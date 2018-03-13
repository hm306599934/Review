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
	
	var middleData: [(String, [(String, String)])] {
		
		let basic = ("Swift", [("Swift", ""), ("各版本特性", ""), ("混编", "")])
		let pattern = ("设计模式", [("设计思想", ""), ("系统设计模式", ""), ("单例模式", ""), ("响应链", ""), ("代理模式", "")])
		let net = ("网络", [("http", ""), ("https", ""), ("socket", ""), ("抓包", ""), ("AFNetWorking", "")])
		let framework = ("第三方库", [("下拉刷新", ""), ("SDWebImage", ""), ("AFNetWorking", ""), ("RxSwift原理", ""), ("Weex原理", "")])
		
		return [basic, pattern, net, framework]
	}
	
	var highData: [(String, [(String, String)])] {
		
		let basic = ("架构", [("架构设计", ""), ("路由方案", ""), ("MGJ路由", ""), ("MVVM", ""), ("RxSwift", "")])
		let newTech = ("新技术", [("Weex", ""), ("微信小程序", ""), ("自动化测试", ""), ("Python", ""), ("人脸识别", ""), ("AI", "")])
		let efficiency = ("性能优化", [("性能优化方向", ""), ("内存检测", ""), ("UITableView", ""), ("电量", ""), ("检测工具", "")])
		let demo = ("应用", [("Runtime空白页", ""), ("Runtime检测UI卡顿", ""), ("自定义KVO", ""), ("自定义消息中心", ""), ("AOP", ""), ("埋点", "")])
		let other = ("其他", [("自我介绍", ""), ("开发经验", ""), ("发展规划", ""), ("遇到的问题", ""), ("总结", "")])
		
		return [basic, newTech, efficiency, demo, other]
	}
	
	
	lazy var sectionData:[SectionData] = {
		
		var result = [SectionData]()
		
		let lowDataPath = Bundle.main.path(forResource: "LowData", ofType: "plist") ?? ""
		
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

