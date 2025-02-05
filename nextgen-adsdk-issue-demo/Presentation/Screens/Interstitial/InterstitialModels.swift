//
//	InterstitialModels
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 04.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

extension InterstitialViewModel {
    enum PresentationState {
        case loading, loaded, error(AdError)
    }
}
