//
//	AdCell
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import SwiftUI
import AdSDKSwiftUI
import AdSDKCore

struct AdCell: View {
    // MARK: - Internal Properties
    @StateObject var viewModel: AdCellViewModel

    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Color.gray
                    .overlay { ProgressView() }
                    .foregroundColor(.gray)
                    .frame(height: C.defaultHeight)

            case .loaded(let data):
                AdView(advertisement: data.advertisement)
                    .aspectRatio(data.aspectRatio, contentMode: .fit)

            case .error(let error):
                Text(error.description)
                    .foregroundColor(.red)
                    .frame(height: C.defaultHeight)
            }
        }
        .onDisappear(perform: viewModel.onDisappear)
        .onAppear(perform: viewModel.onAppear)
    }
}

// MARK: - Static Properties
private enum C {
    static let defaultHeight = 200.0
}
