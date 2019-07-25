//
//  EzConstraint.swift
//  EzConstraint-Example
//
//  Created by An Le  on 7/25/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



enum ROFConstraintType {
    case equal
    case greaterThanOrEqual
    case lessThanOrEqual
}



extension NSLayoutXAxisAnchor {
    
    func constraint(_ type: ROFConstraintType, to anchor: NSLayoutXAxisAnchor, constant: CGFloat) {
        
        switch type {
        case .equal:
            constraint(equalTo: anchor, constant: constant).isActive = true
            
        case .greaterThanOrEqual:
            constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            
        case .lessThanOrEqual:
            constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
    }
}



extension NSLayoutYAxisAnchor {
    
    func constraint(_ type: ROFConstraintType, to anchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        
        switch type {
        case .equal:
            constraint(equalTo: anchor, constant: constant).isActive = true
            
        case .greaterThanOrEqual:
            constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            
        case .lessThanOrEqual:
            constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
    }
}



// MARK: === LAYOUT ATTRIBUTE ===
enum ROFLayoutAttribute {
    
    case top
    case left
    case bottom
    case right
    case leading
    case trailing
    case centerX
    case centerY
    
    fileprivate enum Axis: String {
        case xAxis = "NSLayoutXAxisAnchor"
        case yAxis = "NSLayoutYAxisAnchor"
    }
    
    fileprivate var axis: Axis {
        
        let yAxisAnchors: [ROFLayoutAttribute] = [.top, .bottom, .centerY]
        if yAxisAnchors.contains(self) {
            return .yAxis
        } else {
            return .xAxis
        }
    }
    
    fileprivate func xAxisAnchor(_ view: UIView) -> NSLayoutXAxisAnchor {
        
        switch self {
        case .left:
            return view.leftAnchor
            
        case .right:
            return view.rightAnchor
            
        case .leading:
            return view.leadingAnchor
            
        case .trailing:
            return view.trailingAnchor
            
        case .centerX:
            return view.centerXAnchor
            
        default:
            fatalError()
        }
    }
    
    fileprivate func yAxisAnchor(_ view: UIView) -> NSLayoutYAxisAnchor {
        
        switch self {
        case .top:
            return view.topAnchor
            
        case .bottom:
            return view.bottomAnchor
            
        case .centerY:
            return view.centerYAnchor
            
        default:
            fatalError()
        }
    }
}



extension UIView {
    
    @discardableResult
    func constraint(type: ROFConstraintType = .equal,
                    _ attribute: ROFLayoutAttribute,
                    to view: UIView,
                    constant: CGFloat = 0) -> Self {
        
        switch attribute.axis {
        case .xAxis:
            attribute.xAxisAnchor(self).constraint(type,
                                                   to: attribute.xAxisAnchor(view),
                                                   constant: constant)
            
        case .yAxis:
            attribute.yAxisAnchor(self).constraint(type,
                                                   to: attribute.yAxisAnchor(view),
                                                   constant: constant)
        }
        
        return self
    }
    
    @discardableResult
    func constraint(type: ROFConstraintType = .equal,
                    _ attribute: ROFLayoutAttribute,
                    to view: UIView,
                    _ anotherAttribute: ROFLayoutAttribute,
                    constant: CGFloat = 0) -> Self {
        
        guard attribute != anotherAttribute else {
            return constraint(type: type,
                              attribute,
                              to: view,
                              constant: constant)
        }
        
        // Attributes should be on the same axis
        guard attribute.axis == anotherAttribute.axis else {
            #if DEBUG
            fatalError("Cannot constraint value of \(attribute.axis.rawValue) with \(anotherAttribute.axis.rawValue)")
            #else
            return
            #endif
        }
        
        let axises = [attribute.axis, anotherAttribute.axis]
        
        switch axises {
            
        case [.xAxis, .xAxis]:
            
            let selfAnchor = attribute.xAxisAnchor(self)
            let anotherAnchor = anotherAttribute.xAxisAnchor(view)
            selfAnchor.constraint(type,
                                  to: anotherAnchor,
                                  constant: constant)
            
        case [.yAxis, .yAxis]:
            
            let selfAnchor = attribute.yAxisAnchor(self)
            let anotherAnchor = anotherAttribute.yAxisAnchor(view)
            selfAnchor.constraint(type,
                                  to: anotherAnchor,
                                  constant: constant)
            
        default:
            fatalError()
        }
        
        return self
    }
    
    @discardableResult
    func constraintHeight(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func constraintWidth(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    /// Constraint Width And Height with ratio Width/Height
    @discardableResult
    func constraintWidthHeightRatio(_ multipler: CGFloat) -> Self {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: multipler).isActive = true
        return self
    }
    
    func constraintEqual(to view: UIView) {
        constraint(.top, to: view)
            .constraint(.leading, to: view)
            .constraint(.trailing, to: view)
            .constraint(.bottom, to: view)
    }
}

