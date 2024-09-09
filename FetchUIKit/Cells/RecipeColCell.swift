//
//  RecipeColCell.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit
import Kingfisher

class RecipeColCell: UICollectionViewCell {
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var topVw: UIView!
    
    override var isSelected: Bool {
        didSet {
            topVw.backgroundColor = isSelected ? UIColor.lightGray.withAlphaComponent(0.25) : UIColor.clear
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with recipe: Recipe) {
            titleLb.text = recipe.name
        if let imageUrl = URL(string: recipe.imageUrl) {
            imageVw.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"), options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
        }
    }
}
