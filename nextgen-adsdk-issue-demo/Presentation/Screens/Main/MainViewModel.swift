//
//  MainViewModel.swift
//  nextgen-adsdk-ios-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore
import AdSDKSwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Internal Properties
    @Published var state: PresentationState = .loading
    @Published var trackingResult: TrackingResult?

    // MARK: - Private Properties
    private var service: AdService?
}

// MARK: - Internal Properties
extension MainViewModel {
    func onLoad() async {
        guard service == nil else { return }

        do {
            let service = try await AdService(
                networkID: Configuration.networkID,
                cacheSize: Configuration.cacheSize
            )

            await service.setLogginEnabled(Configuration.isSDKLoggingEnabled)
            setAdRequestGlobalParameters(service)
            setTrackingGlobalParameters(service)

            self.service = service
            state = .loaded(service)

        } catch {
            state = .error(error)
        }
    }

    func tagRequest() async {
        guard let request = Configuration.Tracking.tagRequest else {
            return
        }

        do {
            try await service?.tagUser(request: request)
            trackingResult = .success(.tagRequest)
        } catch {
            trackingResult = .failure(.tagRequest, error)
        }
    }

    func trackingRequest() async {
        guard let request = Configuration.Tracking.trackingRequest else {
            return
        }

        do {
            try await service?.trackingRequest(request)
            trackingResult = .success(.trackingRequest)
        } catch {
            trackingResult = .failure(.trackingRequest, error)
        }
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func setAdRequestGlobalParameters(_ service: AdService) {
        let parameters = Configuration.Ad.globalParameters

        service.setAdRequestGlobalParameter(\.gdpr, parameters.gdpr)
        service.setAdRequestGlobalParameter(\.externalUID, parameters.externalUID)
        service.setAdRequestGlobalParameter(\.isOptOutEnabled, parameters.isOptOutEnabled)
        service.setAdRequestGlobalParameter(\.userIds, parameters.userIds)
        service.setAdRequestGlobalParameter(\.isSHBEnabled, parameters.isSHBEnabled)
        service.setAdRequestGlobalParameter(\.dsa, parameters.dsa)
    }

    func setTrackingGlobalParameters(_ service: AdService) {
        let parameters = Configuration.Tracking.globalParameters

        service.setTrackingGlobalParameter(\.gdpr, parameters.gdpr)
        service.setTrackingGlobalParameter(\.externalUID, parameters.externalUID)
        service.setTrackingGlobalParameter(\.isOptOutEnabled, parameters.isOptOutEnabled)
        service.setTrackingGlobalParameter(\.userIds, parameters.userIds)
    }
}
