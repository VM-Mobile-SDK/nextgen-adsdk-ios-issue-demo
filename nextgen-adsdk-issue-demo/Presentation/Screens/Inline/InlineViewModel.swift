//
//	InlineViewModel
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

@MainActor
final class InlineViewModel: ObservableObject {
    // MARK: - Internal Properties
    @Published var state: PresentationState = .loading

    // MARK: - Private Properties
    private let service: AdService

    // MARK: - Init
    init(_ service: AdService) {
        self.service = service
    }
}

// MARK: - Internal Methods
extension InlineViewModel {
    func onLoad() async {
        guard let requests = Configuration.Ad.inlineRequests else {
            return
        }

        let dataSource = await getDataSource(requests, service: service)
        state = .loaded(dataSource)
    }
}

// MARK: - Private Methods
private extension InlineViewModel {
    nonisolated func getDataSource(
        _ requests: [AdRequest],
        service: AdService
    ) async -> [AdCellViewModel] {
        await withTaskGroup(
            of: AdCellViewModel.self,
            returning: [AdCellViewModel].self
        ) { group in
            for i in Int.zero..<requests.count {
                let request = requests[i]
                group.addTask {
                    await .init(
                        id: i,
                        request: request,
                        service: service
                    )
                }
            }

            let result = await group.reduce(
                into: [AdCellViewModel]()
            ) { result, cell in
                result.append(cell)
            }

            return result.sorted { $0.id < $1.id }
        }
    }
}
