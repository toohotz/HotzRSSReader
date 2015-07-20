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
    let RSSURL = "http://news.google.com/?output=rss"


    override func viewDidLoad() {
        super.viewDidLoad()
        let data = NSData(contentsOfURL: NSURL(string: RSSURL)!)
        let gDoc = GDataXMLDocument(data: data!, options: UInt32(0), error: nil)
        if gDoc != nil {
            var myRSSModel: GoogleRSSModel? = GoogleRSSModel()
             myRSSModel = GoogleRSSModel.createRSSModelFromURL(NSURL(string: RSSURL)!)
            println("My RSS model holds \(myRSSModel)")

        } else {
            println("The docuement is nil")
        }

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()

        return cell
    }

    //MARK: NSXMLParserDelegate Methods

}

