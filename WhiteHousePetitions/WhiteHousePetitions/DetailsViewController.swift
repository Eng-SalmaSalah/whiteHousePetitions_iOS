//
//  DetailsViewController.swift
//  WhiteHousePetitions
//
//  Created by Salma Salah on 2/19/20.
//  Copyright © 2020 Salma Salah. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {
    var detailItem : Petition?
    var webView : WKWebView?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPetitionOnTheWebView()

    }
    func loadPetitionOnTheWebView() {
        guard let detailItem = detailItem else {return}
        //It’s very common to unwrap variables using the same name, rather than create slight variations. In this case we could have used guard let unwrappedItem = detailItem, but that isn’t any better.
        
        let htmlString = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        //to write multiline string: """   content    """
        webView?.loadHTMLString(htmlString, baseURL: nil)
    }


}
