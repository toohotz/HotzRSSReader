//
//  ViewController.swift
//  HotzRSSReader
//
//  Created by Kemar White on 7/17/15.
//  Copyright (c) 2015 toohotz. All rights reserved.
//

import UIKit

class HotzRSSTableViewController: UITableViewController, NSXMLParserDelegate {

    var RSSModel: Item? = Item()
    let RSSURL = "http://news.google.com/?output=rss"

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = NSData(contentsOfURL: NSURL(string: RSSURL)!)
        let gDoc = GDataXMLDocument(data: data!, options: UInt32(0), error: nil)
        if gDoc != nil {
             RSSModel = GoogleRSSModel.createRSSModelFromURL(NSURL(string: RSSURL)!)
        } else {
            println("The XML docuement is nil")
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return RSSModel!.titles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()

        return cell
    }
}

