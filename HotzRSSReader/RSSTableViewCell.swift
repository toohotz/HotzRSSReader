//
//  RSSTableViewCell.swift
//  HotzRSSReader
//
//  Created by Kemar White on 7/19/15.
//  Copyright (c) 2015 toohotz. All rights reserved.
//

import UIKit

class RSSTableViewCell: UITableViewCell {

    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    static let cellIdentifier = "kRSSTableViewCellIdentifier"

    override func awakeFromNib()
    {
        storyTitleLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 30
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        super.awakeFromNib()
    }

    /**
    Configures the RSS tableview cell with a given RSS article item.

    :param: indexPath   Index path of the article item.
    :param: articleItem The RSS article item.
    */
    func configureCellAtIndex(indexPath: NSIndexPath, articleItem:Item)
    {
        storyTitleLabel.text = (articleItem.titles! as NSArray).objectAtIndex(indexPath.row) as? String
        descriptionLabel.text = (articleItem.descriptions! as NSArray).objectAtIndex(indexPath.row) as? String
        articleDateLabel.text = (articleItem.publishDates! as NSArray).objectAtIndex(indexPath.row) as? String
    }
}
