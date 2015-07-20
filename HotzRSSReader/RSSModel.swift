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
   class func createRSSModelFromURL(url: NSURL) -> Item?
    {
        var model = GoogleRSSModel()
        var RSSItem: Item? = Item()
        var articleTitles = [String]()
        if let document = GDataXMLDocument(data: NSData(contentsOfURL: url), options: UInt32(0), error: nil) {
            let documentRootChannel = document.rootElement().elementsForName("channel") as NSArray

            model.channel = document.rootElement().elementsForName("channel")
//            println("The channel is \(model?.channel)")
            for individualChannel in model.channel {
                let articleItem = individualChannel.elementsForName("item")

                // Construct arrays of article feed information
                let articleDictionary = getAllArticleInformationFromItem(articleItem)
                RSSItem?.publishDates = articleDictionary.values.array[Int(ItemIndexName.Title.rawValue)] as? [String]
                RSSItem?.titles = articleDictionary.values.array[Int(ItemIndexName.Description.rawValue)] as? [String]


            }
        }
        return RSSItem
    }
}



private func getAllArticleInformationFromItem(item: [AnyObject]!) -> [String : AnyObject]
{
    var articleInformation = [String : AnyObject]()

    articleInformation["title"] = getArticleStringValueFromItem(item, "description")
    articleInformation["description"] = getArticleStringValueFromItem(item, "pubDate")

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


    struct Item {
        var titles: [String]!
        var imageURL: NSURL?
        var images: UIImage? {
            return UIImage(data: NSData(contentsOfURL:imageURL!)!)
        }
        var publishDates: [String]?
        var descriptions: [String]?
    }