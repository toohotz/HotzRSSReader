//
//  RSSReaderDetailViewController.swift
//  HotzRSSReader
//
//  Created by Kemar White on 7/21/15.
//  Copyright (c) 2015 toohotz. All rights reserved.
//

import Foundation
import UIKit

class RSSReaderDetailViewController: UIViewController, UITextViewDelegate ,UIScrollViewDelegate {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleStoryTextView: UITextView!
    var titles: [String] = []
    var articleStories: [String] = []
    var currentIndexPath: NSIndexPath!
    var yOffset = CGFloat()
    var timer: NSTimer?

    override func viewDidLoad() {
        setupUI()
        articleStoryTextView.delegate = self
        super.viewDidLoad()
    }

    func configureDetailViewControllerWithItem(articleItem:Item, articleIndexPath:NSIndexPath)
    {
        currentIndexPath = articleIndexPath
        if let titlesExist = articleItem.titles {
            titles = titlesExist
        }
        if let articleDescriptions = articleItem.descriptions {
            articleStories = articleDescriptions
        }
    }

    private func setupUI()
    {
        articleTitleLabel.text = (titles as NSArray).objectAtIndex(currentIndexPath.row) as? String
        articleStoryTextView.text = (articleStories as NSArray).objectAtIndex(currentIndexPath.row) as? String

        UIView.animateWithDuration(0.85, animations: { () -> Void in
            self.articleTitleLabel.alpha = 1.0
            self.articleStoryTextView.alpha = 1.0
            self.articleStoryTextView.contentOffset = CGPointMake(50, 0)
        }) { (finished) -> Void in

            if self.yOffset <= CGRectGetHeight(self.articleStoryTextView.frame) {
           self.timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "autoScrollArticle", userInfo: nil, repeats: true)
            self.articleStoryTextView.setContentOffset(CGPointMake(self.articleStoryTextView.contentOffset.x, (self.articleStoryTextView.contentOffset.y - 20) ), animated: true)
            }
        }
    }

     func autoScrollArticle()
    {
        yOffset = yOffset + 2.5
        articleStoryTextView.setContentOffset(CGPointMake(articleStoryTextView.contentOffset.x, yOffset), animated: true)
    }

    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        yOffset = scrollView.contentOffset.y

        if self.yOffset >= CGRectGetHeight(self.articleStoryTextView.frame) {
            timer?.invalidate()
            timer = nil
        }
    }
}
