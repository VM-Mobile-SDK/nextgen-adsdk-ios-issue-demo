//
//	InterstitialView
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 04.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import SwiftUI
import AdSDKSwiftUI

struct InterstitialView: View {
    // MARK: - Internal Properties
    @StateObject var viewModel: InterstitialViewModel

    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Color.gray
                    .overlay { ProgressView() }
                    .foregroundColor(.gray)

            case .loaded:
                VStack {
                    Spacer()

                    if viewModel.isLoaded {
                        Button(
                            ButtonTitle.presetAdvertisement,
                            action: viewModel.onPresent
                        )
                        .buttonStyle(.bordered)

                    } else {
                        Button(
                            ButtonTitle.loadAdvertisement,
                            action: {
                                Task {
                                    await viewModel.onLoadAdvertisement()
                                }
                            }
                        )
                    }

                    Spacer()
                }
                .interstitial($viewModel.interstitialState)

            case .error(let error):
                Text(error.description)
                    .foregroundColor(.red)
            }
        }
        .task(viewModel.onLoad)
    }
}

// MARK: - Static Properties
private enum ButtonTitle {
    static let loadAdvertisement = "Load Advertisement"
    static let presetAdvertisement = "Present Advertisement"
}
