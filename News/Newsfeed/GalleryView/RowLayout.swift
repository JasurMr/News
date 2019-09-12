//
//  RowLayout.swift
//  News
//
//  Created by Macbook on 9/12/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    fileprivate var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        let superViewWidth = collectionView.frame.width
        guard let rowHeight = rowHeightCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
    }
    
    private func rowHeightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoWidthMinRatio = photosArray.min { $0.height / $0.width < $1.height / $1.width }
        
        guard let myPhotoWidthMinRatio = photoWidthMinRatio else { return nil }
        let difference = superViewWidth / myPhotoWidthMinRatio.width
        
        rowHeight = myPhotoWidthMinRatio.height * difference
        return rowHeight
    }

}
