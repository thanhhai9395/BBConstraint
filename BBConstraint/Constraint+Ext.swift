//
//  Constraint+Ext.swift
//  BBConstraint
//
//  Created by innmac on 08/05/2023.
//

import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {

    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                   left: NSLayoutXAxisAnchor? = nil,
                   bottom: NSLayoutYAxisAnchor? = nil,
                   right: NSLayoutXAxisAnchor? = nil,
                   paddingTop: CGFloat = 0,
                   paddingLeft: CGFloat = 0,
                   paddingBottom: CGFloat = 0,
                   paddingRight: CGFloat = 0,
                   width: CGFloat? = nil,
                   height: CGFloat? = nil) {

           translatesAutoresizingMaskIntoConstraints = false

           if let top = top {
               topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
           }

           if let left = left {
               leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
           }

           if let bottom = bottom {
               bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
           }

           if let right = right {
               rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
           }

           if let width = width {
               widthAnchor.constraint(equalToConstant: width).isActive = true
           }

           if let height = height {
               heightAnchor.constraint(equalToConstant: height).isActive = true
           }
       }

       func centerX(inView view: UIView) {
           translatesAutoresizingMaskIntoConstraints = false
           centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       }

       func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                    paddingLeft: CGFloat = 0, constant: CGFloat = 0) {

           translatesAutoresizingMaskIntoConstraints = false
           centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

           if let left = leftAnchor {
               anchor(left: left, paddingLeft: paddingLeft)
           }
       }

       func setDimensions(height: CGFloat, width: CGFloat) {
           translatesAutoresizingMaskIntoConstraints = false
           heightAnchor.constraint(equalToConstant: height).isActive = true
           widthAnchor.constraint(equalToConstant: width).isActive = true
       }

    public func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    public func centerInSuperview(size: CGSize = .zero, offset: CGPoint = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: offset.x).isActive = true

        NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: offset.y).isActive = true

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    public func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }

    public func centerXToSuperview(offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: offset)
        constraint.isActive = true
    }

    public func centerYToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }

    public func centerYToSuperview(offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: offset)
        constraint.isActive = true
    }

    public func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }

    convenience public init(backgroundColor: UIColor? = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }

    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }

}

//MARK:- get index of Enum
extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}


// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public var safeAreaInsets: UIEdgeInsets? {
    return UIApplication.shared.windows.first?.safeAreaInsets
}
