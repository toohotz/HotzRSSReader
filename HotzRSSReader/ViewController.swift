//
//  ViewController.swift
//  HotzRSSReader
//
//  Created by Kemar White on 7/17/15.
//  Copyright (c) 2015 toohotz. All rights reserved.
//

import UIKit

class HotzRSSTableViewController: UITableViewController, NSXMLParserDelegate {

    var tableViewDataSource: [String]!
    var XMLParser: HTZXMLParser!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()

        return cell
    }

    //MARK: NSXMLParserDelegate Methods

}

