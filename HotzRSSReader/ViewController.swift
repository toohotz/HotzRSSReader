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
    let RSSURL = "https://www.apple.com/main/rss/hotnews/hotnews.rss"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    //MARK: Private Methods

    private func fetchData()
    {
        let myRSSModel = GoogleRSSModel()
        RSSModel = myRSSModel.createRSSModelFromURL(NSURL(string: RSSURL)!)
    }

    //MARK: UITableViewDelegate Methods

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return (section == 0) ? "Apple's Latest Hot News" : nil
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return RSSModel!.titles!.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 200
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(RSSTableViewCell.cellIdentifier, forIndexPath: indexPath) as! RSSTableViewCell
        cell.configureCellAtIndex(indexPath, articleItem: RSSModel!)

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as? RSSReaderDetailViewController
        detailViewController?.configureDetailViewControllerWithItem(RSSModel!, articleIndexPath: indexPath)
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
}

