//
//  Ex+Layout.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import Foundation
import UIKit
// MARK: - LayoutAnchor
public
protocol LayoutAnchor {
    func constraint(equalTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}

// MARK: - LayoutDimension
public
protocol LayoutDimension {
    func constraint(equalToConstant float: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant float: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant float: CGFloat) -> NSLayoutConstraint

    func constraint(equalTo anchor: Self,
                    multiplier mul: CGFloat,
                    constant float: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self,
                    multiplier mul: CGFloat,
                    constant float: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,
                    multiplier mul: CGFloat,
                    constant float: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutDimension: LayoutDimension {}
public
struct LayoutAnchorProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}
public
struct LayoutDimensionProperty<Anchor: LayoutDimension> {
    fileprivate let anchor: Anchor
}

// MARK: - Property
extension LayoutAnchorProperty {
    func equal(to otherAnchor: Anchor, offsetBy
               constant: CGFloat = 0) {
        anchor.constraint(equalTo: otherAnchor,
                          constant: constant).isActive = true
    }

    func greaterThanOrEqual(to otherAnchor: Anchor,
                            offsetBy constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor,
                          constant: constant).isActive = true
    }

    func lessThanOrEqual(to otherAnchor: Anchor,
                         offsetBy constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor,
                          constant: constant).isActive = true
    }
}

extension LayoutDimensionProperty {
    func equal(to constant: CGFloat = 0) {
        anchor.constraint(equalToConstant: constant).isActive = true
    }

    func greaterThanOrEqual(to constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func lessThanOrEqual(to constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }

    func equal(to otherAnchor: Anchor, multiplier mul: CGFloat = 1.0, constant con: CGFloat = 0.0) {
        anchor.constraint(equalTo: otherAnchor, multiplier: mul, constant: con).isActive = true
    }

    func greaterThanOrEqual(to otherAnchor: Anchor, multiplier mul: CGFloat = 1.0, constant con: CGFloat = 0.0) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, multiplier: mul, constant: con).isActive = true
    }

    func lessThanOrEqual(to otherAnchor: Anchor, multiplier mul: CGFloat = 1.0, constant con: CGFloat = 0.0) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, multiplier: mul, constant: con).isActive = true
    }
}

// MARK: - LayoutProxy
public
class LayoutProxy {
    public
    lazy var leading = anchorProperty(with: view.leadingAnchor)
    public
    lazy var trailing = anchorProperty(with: view.trailingAnchor)
    public
    lazy var top = anchorProperty(with: view.topAnchor)
    public
    lazy var bottom = anchorProperty(with: view.bottomAnchor)
    public
    lazy var centerX = anchorProperty(with: view.centerXAnchor)
    public
    lazy var centerY = anchorProperty(with: view.centerYAnchor)
    public
    lazy var width = dimensionProperty(with: view.widthAnchor)
    public
    lazy var height = dimensionProperty(with: view.heightAnchor)

    private let view: UIView
    public
    var superview: UIView {
        assert(view.superview != nil, "need superview!!!")
        return view.superview!
    }

    fileprivate init(view: UIView) {
        self.view = view
    }

    private func anchorProperty<A: LayoutAnchor>(with anchor: A) -> LayoutAnchorProperty<A> {
        return LayoutAnchorProperty(anchor: anchor)
    }
    private func dimensionProperty<B: LayoutDimension>(with anchor: B) -> LayoutDimensionProperty<B> {
        return LayoutDimensionProperty(anchor: anchor)
    }
}

public
extension UIView {
    var leading: NSLayoutXAxisAnchor {
       return self.leadingAnchor
    }
    var trailing: NSLayoutXAxisAnchor {
        return self.trailingAnchor
    }
    var top: NSLayoutYAxisAnchor {
        return self.topAnchor
    }
    var bottom: NSLayoutYAxisAnchor {
        return self.bottomAnchor
    }
    var centerX: NSLayoutXAxisAnchor {
        return self.centerXAnchor
    }
    var centerY: NSLayoutYAxisAnchor {
        return self.centerYAnchor
    }
    var width: NSLayoutDimension {
        return self.widthAnchor
    }
    var height: NSLayoutDimension {
        return self.heightAnchor
    }
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }

    func removeAllConstraintsInSuperView() {
        let constraints = superview?
            .constraints
            .filter { $0.firstItem as? UIView  == self } ?? []
        superview?.removeConstraints(constraints)
    }
}

public
extension UILayoutGuide {
    var leading: NSLayoutXAxisAnchor {
       return self.leadingAnchor
    }
    var trailing: NSLayoutXAxisAnchor {
        return self.trailingAnchor
    }
    var top: NSLayoutYAxisAnchor {
        return self.topAnchor
    }
    var bottom: NSLayoutYAxisAnchor {
        return self.bottomAnchor
    }
    var centerX: NSLayoutXAxisAnchor {
        return self.centerXAnchor
    }
    var centerY: NSLayoutYAxisAnchor {
        return self.centerYAnchor
    }
    var width: NSLayoutDimension {
        return self.widthAnchor
    }
    var height: NSLayoutDimension {
        return self.heightAnchor
    }
}

public
func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}
public
func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

// MARK: -  have offset
public
func ==<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: (A, CGFloat)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}
public
func >=<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: (A, CGFloat)) {
    lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}
public
func <=<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: (A, CGFloat)) {
    lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

//MARK: -  without offset
public
func ==<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) {
    lhs.equal(to: rhs)
}
public
func >=<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) {
    lhs.greaterThanOrEqual(to: rhs)
}
public
func <=<A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) {
    lhs.lessThanOrEqual(to: rhs)
}

public
func *<B: LayoutDimension>(lhs: B, rhs: CGFloat) -> (B, CGFloat) {
    return (lhs, rhs)
}
public
func /<B: LayoutDimension>(lhs: B, rhs: CGFloat) -> (B, CGFloat) {
    return (lhs, 1/rhs)
}
public
func +<B: LayoutDimension>(lhs: B, rhs: CGFloat) -> (B, CGFloat) {
    return (lhs, rhs)
}
public
func -<B: LayoutDimension>(lhs: B, rhs: CGFloat) -> (B, CGFloat) {
    return (lhs, -rhs)
}

public
func +<B: LayoutDimension>(lhs: (B, CGFloat), rhs: CGFloat) -> ((B, CGFloat), CGFloat) {
    return ((lhs.0, lhs.1), rhs)
}
public
func -<B: LayoutDimension>(lhs: (B, CGFloat), rhs: CGFloat) -> ((B, CGFloat), CGFloat) {
    return ((lhs.0, lhs.1), -rhs)
}

// MARK: - only otherAnchor
public
func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: B) {
    lhs.equal(to: rhs)
}
public
func >=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: B) {
    lhs.greaterThanOrEqual(to: rhs)
}
public
func <=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: B) {
    lhs.lessThanOrEqual(to: rhs)
}

// MARK: - otherAnchor * multiplier
public
func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: (B, CGFloat)) {
    lhs.equal(to: rhs.0, multiplier: rhs.1, constant: 0)
}
public
func >=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: (B, CGFloat)) {
    lhs.greaterThanOrEqual(to: rhs.0, multiplier: rhs.1, constant: 0)
}
public
func <=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: (B, CGFloat)) {
    lhs.lessThanOrEqual(to: rhs.0, multiplier: rhs.1, constant: 0)
}

// MARK: - otherAnchor * multiplier + constant
public
func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: ((B, CGFloat), CGFloat)) {
    lhs.equal(to: rhs.0.0, multiplier: rhs.0.1, constant: rhs.1)
}
public
func >=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: ((B, CGFloat), CGFloat)) {
    lhs.greaterThanOrEqual(to: rhs.0.0, multiplier: rhs.0.1, constant: rhs.1)
}
public
func <=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: ((B, CGFloat), CGFloat)) {
    lhs.lessThanOrEqual(to: rhs.0.0, multiplier: rhs.0.1, constant: rhs.1)
}

// MARK: - otherDimension * multiplier + constant
public
func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>,
                            rhs: LayoutDimensionProperty<B>) {
    lhs.equal(to: rhs.anchor)
}
public
func >=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>,
                            rhs: LayoutDimensionProperty<B>) {
    lhs.greaterThanOrEqual(to: rhs.anchor)
}
public
func <=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>,
                            rhs: LayoutDimensionProperty<B>) {
    lhs.lessThanOrEqual(to: rhs.anchor)
}

// MARK: - only constant
public
func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: CGFloat) {
    lhs.equal(to: rhs)
}
public
func >=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: CGFloat) {
    lhs.greaterThanOrEqual(to: rhs)
}
public
func <=<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: CGFloat) {
    lhs.lessThanOrEqual(to: rhs)
}
