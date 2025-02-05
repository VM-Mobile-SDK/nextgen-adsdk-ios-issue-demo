//
//	InlineView
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import SwiftUI
import AdSDKSwiftUI
import AdSDKCore

struct InlineView: View {
    // MARK: - Internal Properties
    @StateObject var viewModel: InlineViewModel

    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Color.gray
                    .overlay { ProgressView() }
                    .foregroundColor(.gray)

            case .loaded(let dataSource):
                ScrollView {
                    LazyVStack {
                        ForEach(dataSource) { viewModel in
                            AdCell(viewModel: viewModel)
                        }
                    }
                }
                .adsContainer()

            case .error(let error):
                Text(error.description)
                    .foregroundColor(.red)
            }
        }
        .task(viewModel.onLoad)
    }
}
