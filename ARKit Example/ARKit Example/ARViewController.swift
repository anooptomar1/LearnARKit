//
//  ARViewController.swift
//  ARKit Example
//
//  Created by 李礼光 on 2017/7/6.
//  Copyright © 2017年 LG. All rights reserved.
//

import UIKit


class ARViewController: UIViewController {
    
    //属性
    private var tableView : UITableView!
    private let Demos : [UIViewController] = [
        BasicARViewController(),
        TouchARViewController()
    ]
    private let DemosName : [String] = [
        "基础体验",
        "点击屏幕摆放虚拟物品"
    ]
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        
    }
    
    
    
    
}

extension ARViewController : UITableViewDelegate,UITableViewDataSource {
    func setupTable() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.backgroundColor = UIColor.gray
        view.addSubview(tableView)
    }
    
    //代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Demos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
        cell.textLabel?.text = "\(DemosName[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        self.present(Demos[indexPath.row], animated: false, completion: nil)
    }
}






    
    
    

