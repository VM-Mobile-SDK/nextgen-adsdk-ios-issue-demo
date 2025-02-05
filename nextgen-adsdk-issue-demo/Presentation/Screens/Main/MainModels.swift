//
//	MainModels
//  nextgen-adsdk-ios-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

extension MainViewModel {
    enum TrackingResult {
        case success(TrackingType), failure(TrackingType, AdError)
    }

    enum TrackingType: String {
        case tagRequest = "Tag Request"
        case trackingRequest = "Tracking Request"
    }

    enum PresentationState {
        case loading, error(AdError), loaded(AdService)

        var isInterstitialButtonShown: Bool {
            Configuration.Ad.interstitialRequest != nil
        }

        var isInlineButtonShown: Bool {
            Configuration.Ad.inlineRequests != nil
        }

        var isTrackingButtonShown: Bool {
            Configuration.Tracking.trackingRequest != nil
        }

        var isTagButtonShown: Bool {
            Configuration.Tracking.tagRequest != nil
        }
    }
}
