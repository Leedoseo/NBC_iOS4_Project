//
//  CustomButton.swift
//  UITest
//
//  Created by 박승환 on 5/27/24.
//

import UIKit

class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.layer.cornerRadius = (imageView?.frame.height ?? 0) / 2
        imageView?.clipsToBounds = true
    }
}
