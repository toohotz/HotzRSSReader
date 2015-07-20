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

    var channel: NSArray!
    var items: [Item?] = []

    /**
    Creates a Google RSS reader model from a given URL.

    :param: url The Google RSS reader URL.

    :returns: A Google RSS reader model.
    */
   class func createRSSModelFromURL(url: NSURL) -> GoogleRSSModel?
    {
        var model = GoogleRSSModel()
        var articleTitles = [String]()
        if let document = GDataXMLDocument(data: NSData(contentsOfURL: url), options: UInt32(0), error: nil) {
            let documentRootChannel = document.rootElement().elementsForName("channel") as NSArray

            model.channel = document.rootElement().elementsForName("channel")
//            println("The channel is \(model?.channel)")
            for individualChannel in model.channel {
                let articleItem = individualChannel.elementsForName("item")

                getArticleStringValueFromItem(articleItem, "pubDate")
                for articleNames in articleItem {
                    let articleName = articleNames.elementsForName("title")
                    (articleName as NSArray).enumerateObjectsUsingBlock({ (title, index, stop) -> Void in
                        let articleTitleXMLElement = (articleName as NSArray).objectAtIndex(index) as? GDataXMLElement
                        if let articleStringName = articleTitleXMLElement?.stringValue() {
                        articleTitles.append(articleStringName)
                            var tempItem = Item()
                            tempItem.title = articleStringName
                            model.items.append(tempItem)
                        }

                    })
                }
            }
        }
        return model
    }
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
        var title: String!
        var imageURL: NSURL?
        var image: UIImage? {
            return UIImage(data: NSData(contentsOfURL:imageURL!)!)
        }
        var publishDate: String?
        var description: String?
    }