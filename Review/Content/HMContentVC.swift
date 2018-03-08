//
//  HMContentVC.swift
//  Review
//
//  Created by Jimmy on 08/03/2018.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class HMContentVC: UIViewController {
	
	var resourceName: String?
	
	var webView: WKWebView = {
		let result = WKWebView()
		
		return result
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(webView)
		webView.snp.makeConstraints { (make) in
			make.edges.equalTo(self.view)
		}
		
		if let resourceName = resourceName {
			let path = Bundle.main.path(forResource: resourceName, ofType: "html")
			
			if let path = path {
				let url = URL(fileURLWithPath: path)
				let urlRequest = URLRequest(url: url)
				webView.load(urlRequest)
			}
		}

	}
	
	
}
