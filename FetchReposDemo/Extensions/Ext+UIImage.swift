//
//  Ext+UIImage.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 11/05/2021.
//

import UIKit


extension UIImage {
    
    convenience init?(systemIcon: SystemIcon) {
        self.init(systemName: systemIcon.name)
    }
    
    convenience init?(customImage: CustomImage) {
        self.init(named: customImage.name)
    }
    
}

