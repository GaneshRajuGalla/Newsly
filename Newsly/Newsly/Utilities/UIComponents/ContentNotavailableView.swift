//
//  EmptyView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 18/09/24.
//

import SwiftUI

enum ContentUnavailableType {
    case connectionIssue
    case noDataAvailable
    case errorOccurred(String, retryCallback: () -> Void)
    
    var title: String {
        switch self {
        case .connectionIssue:
            return "Connection issue"
        case .noDataAvailable:
            return "No data available"
        case .errorOccurred:
            return "An error occurred"
        }
    }
    
    var systemImage: String {
        switch self {
        case .connectionIssue:
            return "wifi.slash"
        case .noDataAvailable:
            return "exclamationmark.triangle"
        case .errorOccurred:
            return "xmark.octagon"
        }
    }
    
    var description: String {
        switch self {
        case .connectionIssue:
            return "Check your internet connection"
        case .noDataAvailable:
            return "Please try refreshing the content"
        case .errorOccurred(let description, _):
            return description
        }
    }
    
    var retryCallback: (() -> Void)? {
        if case let .errorOccurred(_,retryCallback) = self {
            return retryCallback
        }
        return nil
    }
}

import SwiftUI

struct ContentNotavailableView: View {
    
    // MARK: - Properties
    let contentType: ContentUnavailableType
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: contentType.systemImage)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(contentType.title)
                .textStyle(color: .white, font: .headline, weight: .semibold)
            Text(contentType.description)
                .textStyle(color: .secondary, font: .subheadline, weight: .semibold)
            if let retryCallback = contentType.retryCallback {
                Button("Retry", action: retryCallback)
                    .buttonStyle(.bordered)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
