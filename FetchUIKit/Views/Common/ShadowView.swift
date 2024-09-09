//
//  RoundedBordersView.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    let shadowOpacity:Float = 0.3
    var container:UIView?
    
    public var roundedBorderIfNeeded = true
    private var blockResize = false
    
    @IBInspectable var radius:CGFloat = 16.0
    var corners: UIRectCorner = [.allCorners]
    {
        didSet
        {
            initialization()
        }
    }
    
    init(frame: CGRect, radius:CGFloat) {
        self.radius = radius
        super.init(frame: frame)
        initialization()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        if roundedBorderIfNeeded && !blockResize
        {
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)) .cgPath
        }
    }
    
    func initialization() {
        if roundedBorderIfNeeded {
            self.layer.cornerRadius = radius
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = .zero
            self.layer.shadowRadius = 3
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    func startAnimation(_ animation:Bool)
    {
        blockResize = animation
        if !animation
        {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)) .cgPath
        }
    }

}
