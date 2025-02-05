//
//	AdCellModels
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import Foundation
import AdSDKCore

extension AdCellViewModel {
    struct InlineAdData {
        let advertisement: Advertisement
        let aspectRatio: Double
    }

    enum PresentationState {
        case loading, error(AdError), loaded(InlineAdData)
    }
}
