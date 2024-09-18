//
//  WebView.swift
//  Newsly
//
//  Created by Ganesh Raju Galla on 17/09/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
