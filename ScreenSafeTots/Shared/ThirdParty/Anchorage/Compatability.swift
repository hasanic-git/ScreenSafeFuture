//
//  Compatability.swift
//  Anchorage
//
//  Created by Rob Visentin on 5/1/17.
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

    #if swift(>=4.0)
        typealias XLayoutPriority = NSLayoutConstraint.Priority
        typealias XEdgeInsets = NSEdgeInsets
    #else
        typealias XLayoutPriority = NSLayoutPriority
    #endif
#else
    import UIKit

    typealias XLayoutPriority = UILayoutPriority
    typealias XEdgeInsets = UIEdgeInsets
#endif

#if swift(>=4.2) || (os(macOS) && swift(>=4.0))
    typealias ConstraintAttribute = NSLayoutConstraint.Attribute
#else
    typealias ConstraintAttribute = NSLayoutAttribute
#endif

#if swift(>=4.0)
#else
    extension XLayoutPriority {

        var rawValue: Float {
            return self
        }

        init(rawValue: Float) {
            self.init(rawValue)
        }
    }
#endif

#if swift(>=4.2)
#elseif !os(macOS)
    extension UITableView {
        static let automaticDimension = UITableViewAutomaticDimension
    }

    extension UITableViewCell {
        typealias CellStyle = UITableViewCellStyle
    }

    extension UIApplication {
        typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
    }
#endif

extension CGFloat {

    init<T: BinaryFloatingPoint>(_ value: T) {
        switch value {
        case is Double:
            self.init(value as! Double)
        case is Float:
            self.init(value as! Float)
        case is CGFloat:
            self.init(value as! CGFloat)
        default:
            fatalError("Unable to initialize CGFloat with value \(value) of type \(type(of: value))")
        }
    }

}

extension Float {

    init<T: BinaryFloatingPoint>(_ value: T) {
        switch value {
        case is Double:
            self.init(value as! Double)
        case is Float:
            self.init(value as! Float)
        case is CGFloat:
            self.init(value as! CGFloat)
        default:
            fatalError("Unable to initialize CGFloat with value \(value) of type \(type(of: value))")
        }
    }

}
