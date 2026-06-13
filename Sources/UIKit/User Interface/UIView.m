/*
 *  UIView.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/3/22.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "UIView.h"

#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@interface UIView()

@property (nonatomic, readwrite) CoreAnimationLayer* layer;

@property (nonatomic, readwrite) UIView* superview;

@property (nonatomic, readwrite) FoundationMutableArray* subviews;

@end

@implementation UIView

- (instancetype)initWithFrame:(CoreFoundationRectangle)frame {
  if (!(self = [super init])) {
    return nil;
  }

  self.layer = [[self.class.layerClass alloc] init];
  self.layer.delegate = self;

  self.frame = frame;
  self.subviews = [FoundationMutableArray makeArray];

  return self;
}

+ (Class)layerClass {
  return CoreAnimationDivisionLayer.class;
}

- (CBoolean)needsDisplay {
  return self.layer.needsDisplay;
}

- (void)setNeedsDisplay:(CBoolean)needsDisplay {
  self.layer.needsDisplay = needsDisplay;
}

- (CBoolean)needsLayout {
  return self.layer.needsLayout;
}

- (void)setNeedsLayout:(CBoolean)needsLayout {
  self.layer.needsLayout = needsLayout;
}

- (CoreFoundationRectangle)frame {
  return self.layer.frame;
}

- (void)setFrame:(CoreFoundationRectangle)frame {
  self.layer.frame = frame;
}

- (CoreFoundationRectangle)bounds {
  return self.layer.bounds;
}

- (void)setBounds:(CoreFoundationRectangle)bounds {
  self.bounds = bounds;
}

- (CBoolean)isHidden {
  return self.layer.isHidden;
}

- (void)setIsHidden:(CBoolean)isHidden {
  self.layer.isHidden = isHidden;
}

- (void)layoutSubviews {
  // TODO: Start the constraint pass here
}

- (void)addSubview:(UIView*)view {
  if (view.superview != self) {
    [view removeFromSuperview];
  }

  [self.subviews appendObject:view];

  [self.layer addSublayer:view.layer];

  view.superview = self;

  // TODO: Auto Layout
//  view.needsUpdateConstraints = true
//  needsUpdateConstraints = true
}

- (void)removeFromSuperview {
// TODO
//  guard
//    let index = superview?.subviews.firstIndex(where: { $0 === self })
//  else {
//    return
//  }
//
//  superview?.subviews.remove(at: index)
//
//  superview = nil
//
//  layer.removeFromSuperlayer()
//
//  // TODO: Auto Layout
}

- (void)displayLayer:(CoreAnimationLayer*)layer {
  if (self.isHidden) {
    [JavaScriptCoreContext updateNode:layer.contents
                        styleProperty:@"visibility"
                           styleValue:@"hidden"];
  } else {
    [JavaScriptCoreContext updateNode:layer.contents
                        styleProperty:@"visibility"
                           styleValue:@"visible"];
  }

  /* Apply the frame. */
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"left"
                         styleValue:$(@"%fpx", self.frame.origin.x)];
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"top"
                         styleValue:$(@"%fpx", self.frame.origin.y)];
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"width"
                         styleValue:$(@"%fpx", self.frame.size.width)];
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"height"
                         styleValue:$(@"%fpx", self.frame.size.height)];
}

- (void)layoutSublayersOfLayer:(CoreAnimationLayer*)layer {
  [self layoutSubviews];
}

@end

C_ASSUME_NONNULL_END

////  // TODO: Use FoundationFramework's Array
////  var constraints: [LayoutConstraint] = []
////
////  public private(set) lazy var leadingAnchor = LayoutXAxisAnchor(
////    item: self,
////    attribute: .leading
////  )
////
////  public private(set) lazy var trailingAnchor = LayoutXAxisAnchor(
////    item: self,
////    attribute: .trailing
////  )
////
////  public private(set) lazy var topAnchor = LayoutYAxisAnchor(
////    item: self,
////    attribute: .top
////  )
////
////  public private(set) lazy var bottomAnchor = LayoutYAxisAnchor(
////    item: self,
////    attribute: .bottom
////  )
////
////  public private(set) lazy var centerXAnchor = LayoutXAxisAnchor(
////    item: self,
////    attribute: .centerX
////  )
////
////  public private(set) lazy var centerYAnchor = LayoutYAxisAnchor(
////    item: self,
////    attribute: .centerY
////  )
////
////  public private(set) lazy var widthAnchor = LayoutDimension(
////    item: self,
////    attribute: .width
////  )
////
////  public private(set) lazy var heightAnchor = LayoutDimension(
////    item: self,
////    attribute: .height
////  )
//
////  func addConstraint(_ constraint: LayoutConstraint) {
////    constraints.append(constraint)
////    needsUpdateConstraints = true
////    superview?.needsUpdateConstraints = true
////  }
////
////  func removeConstraint(_ constraint: LayoutConstraint) {
////    constraints.removeAll(where: { $0 === constraint })
////    needsUpdateConstraints = true
////    superview?.needsUpdateConstraints = true
////  }
//
////  /// Updates the constraints for the receiving view and its subviews.
////  ///
////  /// Whenever a new layout pass is triggered for a view, the system invokes
////  /// this method to ensure that any constraints for the view and its subviews
////  /// are updated with information from the current view hierarchy and its
////  /// constraints. This method is called automatically by the system, but may be
////  /// invoked manually if you need to examine the most up to date constraints.
////  ///
////  /// Subclasses should not override this method.
////  func updateConstraintsIfNeeded() {
////    for subview in subviews {
////      subview.updateConstraintsIfNeeded()
////    }
////
////    if needsUpdateConstraints {
////      updateConstraints()
////      needsUpdateConstraints = false
////    }
////  }
//
//  /// Updates constraints for the view.
//  ///
//  /// Override this method to optimize changes to your constraints.
//  ///
//  /// > Note: It's almost always cleaner and easier to update a constraint
//  ///   immediately after the affecting change has occurred. For example, if you
//  ///   want to change a constraint in response to a button tap, make that
//  ///   change directly in the button's action method.
//  ///
//  ///   You should only override this method when changing constraints in place
//  ///   is too slow, or when a view is producing a number of redundant changes.
//  ///
//  /// To schedule a change, set ``needsUpdateConstraints`` to `true` on the
//  /// view. The system then calls your implementation of ``updateConstraints()``
//  /// before the layout occurs. This lets you verify that all necessary
//  /// constraints for your content are in place at a time when your custom
//  /// view's properties aren't changing.
//  ///
//  /// Your implementation must be as efficient as possible. Don't deactivate all
//  /// your constraints, then reactivate the ones you need. Instead, your app
//  /// must have some way of tracking your constraints, and validating them
//  /// during each update pass. Only change items that need to be changed. During
//  /// each update pass, you must ensure that you have the appropriate
//  /// constraints for the app's current state.
//  ///
//  /// Don't call set ``needsUpdateConstraints`` to `true` inside your
//  /// implementation. Setting ``needsUpdateConstraints`` to `true` schedules
//  /// another update pass, creating a feedback loop.
////  func updateConstraints() {
////    for constraint in constraints where constraint.isActive {
////      guard let firstView = constraint.firstItem as? View else {
////        continue
////      }
////
////      guard !firstView.translatesAutoresizingMaskIntoConstraints else {
////        continue
////      }
////
////      let property = cssProperty(for: constraint.firstAttribute)
////      let value = cssValue(for: constraint)
////
////      if let firstViewID = firstView.id,
////         let property,
////         let value {
////        UIJavaScriptBridge.HTMLElement.setStyleProperty(
////          firstViewID,
////          property.charactersView,
////          property.count,
////          value.charactersView,
////          value.count
////        )
////
////        if constraint.firstAttribute == .centerX {
////          let property = String("--translate-x")
////          let value = String("-50%")
////          UIJavaScriptBridge.HTMLElement.setStyleProperty(
////            firstViewID,
////            property.charactersView,
////            property.count,
////            value.charactersView,
////            value.count
////          )
////        } else if constraint.firstAttribute == .centerY {
////          let property = String("--translate-y")
////          let value = String("-50%")
////          UIJavaScriptBridge.HTMLElement.setStyleProperty(
////            firstViewID,
////            property.charactersView,
////            property.count,
////            value.charactersView,
////            value.count
////          )
////        }
////      }
////    }
////  }
//
//  // TODO: Move to the enum itself.
////  private func cssProperty(
////    for attribute: LayoutConstraint.Attribute
////  ) -> String? {
////    switch attribute {
////    case .leading: return String("left")
////    case .trailing: return String("right")
////    case .top: return String("top")
////    case .bottom: return String("bottom")
////    case .centerX: return String("left")
////    case .centerY: return String("top")
////    case .width: return String("width")
////    case .height: return String("height")
////    case .notAnAttribute: return String("")
////    }
////  }
////
////  // TODO: Move to the enum itself.
////  private func cssValue(for constraint: LayoutConstraint) -> String? {
////    let constant = constraint.constant
////
////    guard let secondView = constraint.secondItem as? View else {
////      return String("\(constant)px")
////    }
////
////    let anchorName = "--view-\(secondView.id ?? 0)"
////
////    switch constraint.firstAttribute {
////    case .width:
////      if constant == 0 {
////        return String("anchor-size(\(anchorName) width)")
////      }
////      return String("calc(anchor-size(\(anchorName) width) + \(constant)px)")
////
////    case .height:
////      if constant == 0 {
////        return String("anchor-size(\(anchorName) height)")
////      }
////      return String("calc(anchor-size(\(anchorName) height) + \(constant)px)")
////
////    case .centerX, .centerY:
////      if constant == 0 {
////        return String("anchor(\(anchorName) center)")
////      }
////      return String("calc(anchor(\(anchorName) center) + \(constant)px)")
////
////    default:
////      let side = switch constraint.secondAttribute {
////      case .leading: "left"
////      case .trailing: "right"
////      case .top: "top"
////      case .bottom: "bottom"
////      case .centerX: "center"
////      case .centerY: "center"
////      default: "left"
////      }
////      if constant == 0 {
////        return String("anchor(\(anchorName) \(side))")
////      }
////      return String("calc(anchor(\(anchorName) \(side)) + \(constant)px)")
////    }
////  }
