//
//  GalleryCollectionViewCell.swift
//  News
//
//  Created by Macbook on 9/12/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let myImageView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     addSubview(myImageView)
        myImageView.fillSuperView()
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageUrl: imageUrl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init decoder has not beeb imp")
    }
}
