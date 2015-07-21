//
//  RSSModel.swift
//  HotzRSSReader
//
//  Created by Kemar White on 7/20/15.
//  Copyright (c) 2015 toohotz. All rights reserved.
//

import Foundation
import UIKit

class GoogleRSSModel: NSObject {

    enum ItemIndexName: UInt {
        case Title
        case Description
        case PublishDate
    }
    var channel: NSArray!

    /**
    Creates a Google RSS reader model from a given URL.

    :param: url The Google RSS reader URL.

    :returns: A Google RSS reader model.
    */
     func createRSSModelFromURL(url: NSURL) -> Item?
    {
        var model = GoogleRSSModel()
        var RSSItem: Item? = Item()
        var articleTitles = [String]()
        if let document = GDataXMLDocument(data: NSData(contentsOfURL: url), options: UInt32(0), error: nil) {

            let documentRootChannel = document.rootElement().elementsForName("channel") as NSArray
            model.channel = document.rootElement().elementsForName("channel")

            for individualChannel in model.channel {

                let articleItem = individualChannel.elementsForName("item")
                let articleDictionary = getAllArticleInformationFromItem(articleItem)
                RSSItem?.publishDates = articleDictionary["pubDate"] as? [String]
                RSSItem?.titles = articleDictionary["title"] as? [String]
                RSSItem?.descriptions = articleDictionary["description"] as? [String]
            }
        }
        return RSSItem
    }

    private func getAllArticleInformationFromItem(item: [AnyObject]!) -> [String : AnyObject]
    {
        var articleInformation = [String : AnyObject]()

        articleInformation["title"] = getArticleStringValueFromItem(item, articleTag: "title")
        articleInformation["description"] = getArticleStringValueFromItem(item, articleTag: "description")

        let dates = getArticleStringValueFromItem(item, articleTag: "pubDate")
        var formattedDates: [String] = []

        for dateString in dates {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, dd MM YYYY HH:mm:ss zzz"
            var articleDate: NSDate? = NSDate()
            articleDate = dateFormatter.dateFromString(dateString)
            dateFormatter.dateStyle = .MediumStyle
            formattedDates.append(dateFormatter.stringFromDate(articleDate!))

        }
        articleInformation["pubDate"] = formattedDates

        return articleInformation
    }

    private func getArticleStringValueFromItem(item: [AnyObject]!, articleTag: String) -> [String]
    {
        var itemValues = [String]()
        for articleDetails in item {
            let articleDetailValue = articleDetails.elementsForName(articleTag)
            (articleDetailValue as NSArray).enumerateObjectsUsingBlock({ (title, index, stop) -> Void in
                let articleDetailValueXMLElement = (articleDetailValue as NSArray).objectAtIndex(index) as? GDataXMLElement
                if let articleDetailValueName = articleDetailValueXMLElement?.stringValue() {
                    itemValues.append(articleDetailValueName)
                }
            })
        }
        return itemValues
    }
}

    struct Item {
        var titles: [String]?
        var imageURL: NSURL?
        var images: UIImage? {
            return UIImage(data: NSData(contentsOfURL:imageURL!)!)
        }
        var publishDates: [String]?
        var descriptions: [String]?
    }
