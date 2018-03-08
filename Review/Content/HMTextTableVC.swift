//
//  HMTextTableVC.swift
//  Review
//
//  Created by Jimmy on 08/03/2018.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class HMTextTableVC: UIViewController {
	
	@IBOutlet weak var mTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mTableView.reloadData()
	}
	
	
	lazy var dataSource: [(String, [String])] = {
		var result = [(String, [String])]()

		result.append(("OC基础", ["OC基础", "OC属性", "OC Runtime"]))
		result.append(("Swift基础", ["Swift基础", "Swift与OC区别", "Swift内存管理"]))
		
		return result
	}()
	
	lazy var resourceDic: [String: String] = {
		var result = [String: String]()
		result["OC基础"] = "oc_basic"
		result["OC属性"] = "oc_property"
		result["OC Runtime"] = "oc_runtime"
		
		return result
	}()
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let indexPath = sender as? IndexPath {
			
			let key = dataSource[indexPath.section].1[indexPath.row]
			let vc = segue.destination as! HMContentVC
			
			vc.resourceName = resourceDic[key]
		}
		
		
	}
}

extension HMTextTableVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return (section == 0) ? 40 : 0
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return (section == dataSource.count - 1) ? 40 : 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource[section].1.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return dataSource[section].0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		cell.textLabel?.text = dataSource[indexPath.section].1[indexPath.row]
		
		return cell
	}
	
	
}

extension HMTextTableVC: UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "ShowContent", sender: indexPath)
		
	}
}

