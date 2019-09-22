//
//  FeedCellLayoutCalculator.swift
//  News
//
//  Created by Macbook on 9/9/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHieght: CGFloat
    var moreTextButtonFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constaints.cardInsets.left - Constaints.cardInsets.right
        var showMoreTextButton = false
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constaints.postLabelInsets.left, y: Constaints.postLabelInsets.top), size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constaints.postLabelInsets.left - Constaints.postLabelInsets.right
            var height = text.height(width: width, font: Constaints.postLabelFont)
            
            let limitHeight = Constaints.postLabelFont.lineHeight * Constaints.minifiedPostLitimLines
            if !isFullSized && height > limitHeight {
                height = Constaints.postLabelFont.lineHeight * Constaints.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = Constaints.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constaints.moreTextButtonInserts.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        let attachmentTop = postLabelFrame.size == .zero
                          ? Constaints.postLabelInsets.top
                          : postLabelFrame.maxY + Constaints.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
//        if let attachment = photoAttachment {
//            let photoHeight = Float(attachment.height)
//            let photoWidth = Float(attachment.width)
//            let ratio = CGFloat(photoHeight / photoWidth)
//            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
//        }
        
        if let attachment = photoAttachments.first {
            let photoHeight = Float(attachment.height)
            let photoWidth = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                
                let photos = photoAttachments.map { (photo) -> CGSize in
                    return CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superViewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
        }
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomVeiwFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constaints.bottomViewHeight))
        
        let totalHieght = bottomVeiwFrame.maxY + Constaints.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomVeiwFrame,
                     totalHieght: totalHieght,
                     moreTextButtonFrame: moreTextButtonFrame)
    }
}
