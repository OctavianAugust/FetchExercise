//
//  UICollectionViewExt.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit

public extension UICollectionView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass, suffixReuseID: String) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseID(identifier: identifier, suffixReuseID: suffixReuseID))
    }
    
    func getCellNibReuseID(_ cellClass: AnyClass, suffixReuseID: String) -> String {
        let identifier = String(describing: cellClass)
        return reuseID(identifier: identifier, suffixReuseID: suffixReuseID)
    }
    
    private func reuseID(identifier: String, suffixReuseID: String) -> String {
        return "\(identifier)_\(suffixReuseID)"
    }
    
}
