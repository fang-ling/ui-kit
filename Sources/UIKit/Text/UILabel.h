/*
 *  UILabel.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/5/24.
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

#import "../User Interface/UIView.h"

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A view that displays one or more lines of informational text.
 *
 * You can configure the overall appearance of a label's text, and use
 * attributed strings to customize the appearance of substrings within the text.
 *
 * Follow these steps to add a label to your interface:
 *   - Supply either a string or an attributed string that represents the
 *     content
 *   - If you're using a non-attributed string, configure the appearance of the
 *     label
 *   - Set up Auto Layout rules to govern the size and position of the label in
 *     your interface
 *   - Provide accessibility information and localized strings
 *
 * #### Customize the label's appearance
 *
 * You provide the content for a label by assigning either a ``String`` object
 * to the ``text`` property, or an ``AttributedString`` object to the
 * ``attributedText`` property. The label displays the property set most
 * recently.
 *
 * The ``attributedText`` property allows you to control the appearance of
 * individual characters and groups of characters, using the
 * ``AttributedString`` API.
 *
 * If you want to format the label's text in a uniform fashion, set the
 * ``text`` property to an ``String`` object containing the content, and
 * configure the ``font``, ``textColor``, ``textAlignment``, and
 * ``lineBreakMode`` properties.
 *
 * If you set these appearance properties on a label that displays the content
 * of the ``attributedText`` property, the label overrides the appropriate
 * attributes and displays the attributed string with a uniform appearance.
 *
 * Specify the maximum number of lines for the label to use when laying out the
 * text with the ``numberOfLines`` property. Setting a value of `0` allows the
 * label to use as many lines as necessary to lay out the text within the
 * label's width. Use the ``lineBreakMode`` property to control how the label
 * splits the text into multiple lines, and the truncation behavior associated
 * with the final line.
 *
 * Use Auto Layout to position and optionally size the label. The intrinsic
 * content size for a label defaults to the size that displays the entirety of
 * the content on a single line. If you provide Auto Layout constraints that
 * define the width of the label but not the height, the label's intrinsic
 * content size adjusts the height to display the text completely.
 *
 * When the label has its size completely defined externally, you can specify
 * how it handles the situation when its content doesn't fit within the bounds.
 * To reduce the font size, set the ``adjustsFontSizeToFitWidth`` property to
 * `true` and set the ``minimumScaleFactor`` property to a value between `0`
 * and `1`. The latter of these properties represents how much smaller than the
 * requested font size the label scales the text. Setting the
 * ``allowsDefaultTighteningForTruncation`` property to true instructs the
 * label to reduce the spacing between characters before truncating the string.
 *
 * #### Design labels for a wide audience
 *
 * Labels provide valuable information to your users. To make sure that
 * information reaches a wide audience, internationalize text and support
 * accessibility in your labels.
 */
@interface UILabel: UIView

/**
 * The text that the label displays.
 *
 * This property is `nil` by default. Assigning a new value to this property
 * also replaces the value of the ``attributedText`` property with the same
 * text, although without any inherent style attributes. Instead the label
 * styles the new string using ``shadowColor``, ``textAlignment``, and other
 * style-related properties of the class.
 */
@property (nonatomic, copy) FoundationString* text;

@end

C_ASSUME_NONNULL_END
