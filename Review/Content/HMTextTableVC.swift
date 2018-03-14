//
//  HMTextTableVC.swift
//  Review
//
//  Created by Jimmy on 08/03/2018.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

struct SectionData {
	var title: String = ""
	var data: [ItemData] = [ItemData]()
}

struct ItemData {
	var title: String = ""
	var content: String = ""
}

class HMTextTableVC: UIViewController {
	
	@IBOutlet weak var mTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mTableView.reloadData()
	}
	
	
	lazy var sectionData:[SectionData] = {
		
		var result = [SectionData]()
		
		var pathName = "LowData"
		
		if self.vcTitle == "中级" {
			pathName = "MiddleData"
		} else if self.vcTitle == "高级" {
			pathName = "HighData"
		}
		
		let lowDataPath = Bundle.main.path(forResource: pathName, ofType: "plist") ?? ""
		
		if let array = NSArray(contentsOfFile: lowDataPath) {
			
			for sectionData in array {
				
				if let sectionData = sectionData as? Dictionary<String, Any> {
					var newSectionData = SectionData()
					newSectionData.title = sectionData["SectionTitle"] as! String
					
					if let data = sectionData["SectionData"] as? Array<Dictionary<String, String>> {
						
						var itemDatas = [ItemData]()
						
						for itemData in data {
							
							var newItemData = ItemData()
							newItemData.title = itemData["title"] ?? ""
							newItemData.content = itemData["content"] ?? ""
							itemDatas.append(newItemData)
						}
						
						newSectionData.data = itemDatas
					}
					
					result.append(newSectionData)
				}
			}
		}
		
		return result
	}()
	
	var vcTitle: String {
		return self.navigationItem.title ?? ""
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let indexPath = sender as? IndexPath {
			
			let itemDate = sectionData[indexPath.section].data[indexPath.row]
			let vc = segue.destination as! HMContentVC
			
			vc.title = itemDate.title
			vc.resourceName = itemDate.content
		}
	}
}

extension HMTextTableVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return (section == 0) ? 40 : 0
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return (section == sectionData.count - 1) ? 40 : 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionData.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sectionData[section].data.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionData[section].title
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		cell.textLabel?.text = sectionData[indexPath.section].data[indexPath.row].title
		
		return cell
	}
	
	
}

extension HMTextTableVC: UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "ShowContent", sender: indexPath)
		
	}
}

