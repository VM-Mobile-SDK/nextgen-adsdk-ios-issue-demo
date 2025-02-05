//
//	InterstitialViewModel
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 04.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

@MainActor
final class InterstitialViewModel: ObservableObject {
    // MARK: - Internal Properties
    @Published var state: PresentationState = .loading
    @Published var interstitialState = AdInterstitialState.hidden

    var isLoaded: Bool { advertisement != nil }

    // MARK: - Private Properties
    private let service: AdService
    private var advertisement: Advertisement?

    // MARK: - Init
    init(service: AdService) {
        self.service = service
    }
}

// MARK: - Internal Methods
extension InterstitialViewModel {
    func onLoad() async {
        guard !isLoaded,
              Configuration.Ad.isPreloadingContent else {
            return state = .loaded
        }

        await onLoadAdvertisement()
    }

    func onLoadAdvertisement() async {
        guard let request = Configuration.Ad.interstitialRequest else {
            return
        }

        state = .loading

        do {
            let advertisement = try await service.makeAdvertisement(
                request: request,
                placementType: .interstitial,
                eventDelegate: self
            )

            self.advertisement = advertisement
            state = .loaded

        } catch {
            state = .error(error)
        }
    }

    func onPresent() {
        guard let advertisement else { return }

        interstitialState = .presentedIfLoaded(advertisement)
    }
}

// MARK: - AdEventDelegate
extension InterstitialViewModel: AdEventDelegate {
    func unloadRequest() {
        interstitialState = .hidden
    }

    // You can implement any method of AdEventDelegate here.
}
