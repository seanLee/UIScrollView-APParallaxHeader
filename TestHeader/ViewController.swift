//
//  ViewController.swift
//  TestHeader
//
//  Created by Sean on 16/8/2.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private let cellIdentifier = "cellIdentifier"
    
    private var parallaxWithView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let barButton = UIBarButtonItem(title: "with view", style: .Plain, target: self, action: #selector(toggle(_:)))
        navigationItem.rightBarButtonItem = barButton
        
        //    添加myTableView
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor(red: (238.0/255.0), green: (238.0/255.0), blue: (238.0/255.0), alpha: 1.0);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = .SingleLine;
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        (
            tableView.snp_makeConstraints { (make) in
                make.edges.equalTo(view)
            }
        )
        
         toggle(nil)
    }
    
    @objc private func toggle(sender: AnyObject?) {
        if parallaxWithView {
            tableView.addParallaxWithImage(UIImage(named: "ParallaxImage.jpg")!, height: 160.0, shadow: true)
            
            parallaxWithView = false
            
            let barButton = UIBarButtonItem(title: "with view", style: .Plain, target: self, action: #selector(toggle(_:)))
            navigationItem.rightBarButtonItem = barButton
        } else {
            let imageView = UIImageView(image: UIImage(named: "Rover.jpg"))
            imageView.frame = CGRect(x: 0, y: 0, width: 320.0, height: 160.0)
            imageView.contentMode = .ScaleAspectFill
            tableView.addParallaxWithView(imageView, height: 160.0, shadow: true)
            
            parallaxWithView = true
            
            let barButton = UIBarButtonItem(title: "with image", style: .Plain, target: self, action: #selector(toggle(_:)))
            navigationItem.rightBarButtonItem = barButton
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(14.0)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

