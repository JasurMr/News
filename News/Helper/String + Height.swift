//
//  String + Height.swift
//  News
//
//  Created by Macbook on 9/9/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
