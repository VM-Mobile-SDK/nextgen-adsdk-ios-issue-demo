//
//	MainView
//  nextgen-adsdk-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import SwiftUI
import AdSDKCore

struct MainView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel = MainViewModel()
    @State private var isTrackingAlertPresented = false

    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Color.gray
                    .overlay { ProgressView() }
                    .foregroundColor(.gray)

            case .loaded(let service):
                content(service)

            case .error(let error):
                Text(error.description)
                    .foregroundColor(.red)
            }
        }
        .task(viewModel.onLoad)
        .onReceive(viewModel.$trackingResult) {
            isTrackingAlertPresented = $0 != nil
        }
        .alert(isPresented: $isTrackingAlertPresented) {
            Alert(
                title: Text(C.trackingAlertTitle),
                message: Text(viewModel.trackingResult!.message),
                dismissButton: .cancel(
                    Text(ButtonTitle.ok.rawValue),
                    action: {
                        viewModel.trackingResult = nil
                    }
                )
            )
        }
    }
}

// MARK: - Private Methods
private extension MainView {
    @ViewBuilder
    func content(_ service: AdService) -> some View {
        let state = viewModel.state

        VStack {
            Spacer()

            route(title: .list, isPresented: state.isInlineButtonShown) {
                InlineView(viewModel: .init(service))
            }

            route(title: .interstitial, isPresented: state.isInterstitialButtonShown) {
                InterstitialView(viewModel: .init(service: service))
            }

            Spacer()

            asyncButton(
                title: .tagRequest,
                isPresented: state.isTagButtonShown,
                action: viewModel.tagRequest
            )

            asyncButton(
                title: .trackingRequest,
                isPresented: state.isTrackingButtonShown,
                action: viewModel.trackingRequest
            )
        }
        .padding()
    }

    @ViewBuilder
    func asyncButton(
        title: ButtonTitle,
        isPresented: Bool,
        action: @Sendable @escaping () async -> Void
    ) -> some View {
        if isPresented {
            Button(title.rawValue) {
                Task { action }
            }
        }
    }

    @ViewBuilder
    func route<Content: View>(
        title: ButtonTitle,
        isPresented: Bool,
        @ViewBuilder _ destination: @escaping () -> Content
    ) -> some View {
        if isPresented {
            NavigationLink(title.rawValue, destination: destination)
        }
    }
}

// MARK: - Models
private enum ButtonTitle: String {
    case list = "Inline ads"
    case interstitial = "Interstitial ad"
    case tagRequest = "Perform tag request"
    case trackingRequest = "Perform tracking request"
    case ok = "OK"
}

// MARK: - MainViewModel.TrackingResult + Extensions
private extension MainViewModel.TrackingResult {
    var message: String {
        switch self {
        case .success(let trackingType):
            "\(trackingType.rawValue) processed successfully."
        case let .failure(trackingType, error):
            "\(trackingType.rawValue) failed with error: \(error.description)"
        }
    }
}

// MARK: - Static Properties
private enum C {
    static let trackingAlertTitle = "Tracking processed"
}
