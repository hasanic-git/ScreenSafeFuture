//
//  Anchorage.swift
//  Anchorage
//
//  Created by Rob Visentin on 2/6/16.
//
//  Copyright 2016 Rightpoint and other contributors
//  http://rightpoint.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

protocol LayoutConstantType {}
extension CGFloat: LayoutConstantType {}
extension CGSize: LayoutConstantType {}
extension XEdgeInsets: LayoutConstantType {}

protocol LayoutAnchorType {}
extension NSLayoutAnchor: LayoutAnchorType {}

// MARK: - Equality Constraints

@discardableResult func == <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalToConstant: CGFloat(rhs)))
}

@discardableResult func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult func == (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func == (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, XEdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult func == <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult func == <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func == (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs)
}

@discardableResult func == (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult func <= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult func <= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult func <= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult func <= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult func <= (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func <= (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, XEdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult func <= <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult func <= <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func <= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToConstant: rhs)
}

@discardableResult func <= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
}

@discardableResult func >= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult func >= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult func >= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult func >= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs))
}

@discardableResult func >= (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func >= (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult func >= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(greaterThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult func >= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func >= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, XEdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult func >= <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs)
}

@discardableResult func >= <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsGreaterThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult func >= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
    return lhs.finalize(constraintsGreaterThanOrEqualToConstant: rhs)
}

@discardableResult func >= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
    return lhs.finalize(constraintsGreaterThanOrEqualToConstant: rhs.constant, priority: rhs.priority)
}

// MARK: - Priority

precedencegroup PriorityPrecedence {
    associativity: none
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~: PriorityPrecedence

@discardableResult func ~ <T: BinaryFloatingPoint>(lhs: T, rhs: Priority) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    return LayoutExpression(constant: CGFloat(lhs), priority: rhs)
}

@discardableResult func ~ (lhs: CGSize, rhs: Priority) -> LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize> {
    return LayoutExpression(constant: lhs, priority: rhs)
}

@discardableResult func ~ <T>(lhs: T, rhs: Priority) -> LayoutExpression<T, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, priority: rhs)
}

@discardableResult func ~ <T, U>(lhs: LayoutExpression<T, U>, rhs: Priority) -> LayoutExpression<T, U> {
    var expr = lhs
    expr.priority = rhs
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: CGFloat(rhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutDimension) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    var expr = lhs
    expr.multiplier *= CGFloat(rhs)
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    var expr = rhs
    expr.multiplier *= CGFloat(lhs)
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: NSLayoutXAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: Optional<NSLayoutXAxisAnchor>.some(lhs), constant: 0.0, multiplier: CGFloat(rhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutXAxisAnchor) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    var expr = lhs
    expr.multiplier *= CGFloat(rhs)
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    var expr = rhs
    expr.multiplier *= CGFloat(lhs)
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: NSLayoutYAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: CGFloat(rhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: NSLayoutYAxisAnchor) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: rhs, constant: 0.0, multiplier: CGFloat(lhs))
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    var expr = lhs
    expr.multiplier *= CGFloat(rhs)
    return expr
}

@discardableResult func * <T: BinaryFloatingPoint>(lhs: T, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    var expr = rhs
    expr.multiplier *= CGFloat(lhs)
    return expr
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutDimension, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutDimension, CGFloat> {
    var expr = lhs
    expr.multiplier /= CGFloat(rhs)
    return expr
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: NSLayoutXAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutXAxisAnchor, CGFloat> {
    var expr = lhs
    expr.multiplier /= CGFloat(rhs)
    return expr
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: NSLayoutYAxisAnchor, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: 0.0, multiplier: 1.0 / CGFloat(rhs))
}

@discardableResult func / <T: BinaryFloatingPoint>(lhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>, rhs: T) -> LayoutExpression<NSLayoutYAxisAnchor, CGFloat> {
    var expr = lhs
    expr.multiplier /= CGFloat(rhs)
    return expr
}

@discardableResult func + <T, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: CGFloat(rhs))
}

@discardableResult func + <T: BinaryFloatingPoint, U>(lhs: T, rhs: U) -> LayoutExpression<U, CGFloat> {
    return LayoutExpression(anchor: rhs, constant: CGFloat(lhs))
}

@discardableResult func + <T, U: BinaryFloatingPoint>(lhs: LayoutExpression<T, CGFloat>, rhs: U) -> LayoutExpression<T, CGFloat> {
    var expr = lhs
    expr.constant += CGFloat(rhs)
    return expr
}

@discardableResult func + <T: BinaryFloatingPoint, U>(lhs: T, rhs: LayoutExpression<U, CGFloat>) -> LayoutExpression<U, CGFloat> {
    var expr = rhs
    expr.constant += CGFloat(lhs)
    return expr
}

@discardableResult func + (lhs: EdgeAnchors, rhs: XEdgeInsets) -> LayoutExpression<EdgeAnchors, XEdgeInsets> {
    return LayoutExpression(anchor: lhs, constant: rhs)
}

@discardableResult func - <T, U: BinaryFloatingPoint>(lhs: T, rhs: U) -> LayoutExpression<T, CGFloat> {
    return LayoutExpression(anchor: lhs, constant: -CGFloat(rhs))
}

@discardableResult func - <T: BinaryFloatingPoint, U>(lhs: T, rhs: U) -> LayoutExpression<U, CGFloat> {
    return LayoutExpression(anchor: rhs, constant: -CGFloat(lhs))
}

@discardableResult func - <T, U: BinaryFloatingPoint>(lhs: LayoutExpression<T, CGFloat>, rhs: U) -> LayoutExpression<T, CGFloat> {
    var expr = lhs
    expr.constant -= CGFloat(rhs)
    return expr
}

@discardableResult func - <T: BinaryFloatingPoint, U>(lhs: T, rhs: LayoutExpression<U, CGFloat>) -> LayoutExpression<U, CGFloat> {
    var expr = rhs
    expr.constant -= CGFloat(lhs)
    return expr
}

@discardableResult func - (lhs: EdgeAnchors, rhs: XEdgeInsets) -> LayoutExpression<EdgeAnchors, XEdgeInsets> {
    return LayoutExpression(anchor: lhs, constant: -rhs)
}

// MARK: - Batching

/// Any Anchorage constraints created inside the passed closure are returned in the array.
///
/// - Parameter closure: A closure that runs some Anchorage expressions.
/// - Returns: An array of new, active `NSLayoutConstraint`s.
@discardableResult func batch(_ closure: () -> Void) -> [NSLayoutConstraint] {
    return batch(active: true, closure: closure)
}

/// Any Anchorage constraints created inside the passed closure are returned in the array.
///
/// - Parameter active: Whether the created constraints should be active when they are returned.
/// - Parameter closure: A closure that runs some Anchorage expressions.
/// - Returns: An array of new `NSLayoutConstraint`s.
func batch(active: Bool, closure: () -> Void) -> [NSLayoutConstraint] {
    let batch = ConstraintBatch()
    batches.append(batch)
    defer {
        batches.removeLast()
    }

    closure()

    if active {
        batch.activate()
    }

    return batch.constraints
}
