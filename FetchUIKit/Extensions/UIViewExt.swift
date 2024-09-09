//
//  UIViewExt.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit

extension UIView {
    public func addConstraint(centerYConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .centerY,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .centerY,
                                  multiplier: 1,
                                  constant: centerYConstant)
    }
    
    public func addConstraint(centerXConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .centerX,
                                  multiplier: 1,
                                  constant: centerXConstant)
    }
    
    public func addConstraint(heightConstant: CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .height,
                                  relatedBy: .equal,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1,
                                  constant: heightConstant)
    }
    
    public func addConstraint(widthConstant:CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1,
                                  constant: widthConstant)
    }
    
    public func addConstraint(leftConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .left,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .left,
                                  multiplier: 1,
                                  constant: leftConstant)
    }
    
    public func addConstraint(rightConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .right,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .right,
                                  multiplier: 1,
                                  constant: rightConstant)
    }
    
    public func addConstraint(topConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .top,
                                  multiplier: 1,
                                  constant: topConstant)
    }
    
    public func addConstraint(bottomConstant: CGFloat, toView: UIView? = nil) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: self,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: toView ?? self.superview,
                                  attribute: .bottom,
                                  multiplier: 1,
                                  constant: bottomConstant)
    }
    public func addConstraints(top:CGFloat,bottom:CGFloat,left:CGFloat,right:CGFloat)
    {
        self.addConstraint(topConstant: top).isActive = true
        self.addConstraint(bottomConstant: bottom).isActive = true
        self.addConstraint(leftConstant: left).isActive = true
        self.addConstraint(rightConstant: right).isActive = true
    }
}
