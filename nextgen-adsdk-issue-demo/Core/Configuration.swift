//
//	Configuration
//  nextgen-adsdk-ios-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

/// Configuration to change demo app flow.
enum Configuration {
    static let networkID: UInt = 0000

    /// Size in mb that you can set for max SDK's cache size.
    static let cacheSize: UInt8 = 100

    /// If equal to `true` – SDK will log internal logs, like requests and responses to/from the server,
    /// MRAID logs and other.
    static let isSDKLoggingEnabled = false

    /// Configuration related to the `AdRequest`.
    enum Ad {
        /// If equal to `true` – SDK will preload Ads before presenting. If not – loading will be triggered
        /// during scroll (for inline), or via button (for interstitial).
        static let isPreloadingContent = true

        /// Ad requests parameters for the inline ads.
        static let inlineRequests: [AdRequest]? = nil

        /// Interstitial ad request parameters.
        static let interstitialRequest: AdRequest? = nil

        /// Ad request global parameters.
        @MainActor
        static let globalParameters = AdRequestGlobalParameters(
            gdpr: nil,
            externalUID: nil,
            isOptOutEnabled: nil,
            userIds: nil,
            isSHBEnabled: nil,
            dsa: nil
        )
    }

    /// Configuration related to the `TrackingRequest` and `TagRequest`
    enum Tracking {
        /// Parameters for the `TagRequest`.
        static let tagRequest: TagRequest? = nil

        /// Parameters for the `TrackingRequest`.
        static let trackingRequest: TrackingRequest? = nil

        /// Tag and tracking requests global parameters.
        @MainActor
        static let globalParameters = GlobalParameters(
            gdpr: nil,
            externalUID: nil,
            isOptOutEnabled: nil,
            userIds: nil
        )
    }
}
