//
//	AdCellViewModel
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

@MainActor
final class AdCellViewModel: ObservableObject, Identifiable {
    // MARK: - Internal Properties
    let id: Int

    @Published var state: PresentationState = .loading

    // MARK: - Private Properties
    private let service: AdService
    private let request: AdRequest
    private var advertisement: Advertisement?
    private var adLoadingTask: Task<(), Never>?
    private var isLoaded: Bool { advertisement != nil }

    // MARK: - Init
    init(
        id: Int,
        request: AdRequest,
        service: AdService
    ) async {
        self.id = id
        self.service = service
        self.request = request

        guard Configuration.Ad.isPreloadingContent else { return }

        await loadAdvertisement()
    }
}

// MARK: - Internal Methods
extension AdCellViewModel {
    func onAppear() {
        guard !Configuration.Ad.isPreloadingContent,
              !isLoaded else { return }

        adLoadingTask = Task { await loadAdvertisement() }
    }

    func onDisappear() {
        guard !Configuration.Ad.isPreloadingContent else { return }

        adLoadingTask?.cancel()
        adLoadingTask = nil
        state = .loading
        advertisement = nil
    }
}

// MARK: - Private Methods
private extension AdCellViewModel {
    func loadAdvertisement() async {
        state = .loading

        do {
            let advertisement = try await service.makeAdvertisement(
                request: request,
                placementType: .inline,
                eventDelegate: self
            )

            let aspectRatio = advertisement.metadata?.aspectRatio

            self.advertisement = advertisement

            state = .loaded(
                .init(
                    advertisement: advertisement,
                    aspectRatio: aspectRatio ?? C.defaultAspectRatio
                )
            )

        } catch {
            state = .error(error)
        }
    }
}

// MARK: - AdEventDelegate
extension AdCellViewModel: AdEventDelegate {
    // You can implement any method of AdEventDelegate here.
}

// MARK: - Static Properties
private enum C {
    static let defaultAspectRatio = 2.0
}
