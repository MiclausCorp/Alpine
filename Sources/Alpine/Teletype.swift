//
//  ANSI.swift
//  ANSI Teletype Terminal Control Escape Sequences
//  BliksemCore23 - Part of the #Lightning23 Upgrade Package
//
//  Created by Darius Miclaus on 07/04/2022.
//  Copyright (c) 2023 The Bliksem Project
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

/// ANSI Teletype Terminal Control Modifiers
internal struct BKANSIModifiers {
    /// Bold Control Modifier
    static var bold:          [Int] = [1, 22]

    /// Blink Control Modifier
    static var blink:         [Int] = [5, 25]

    /// Dim Control Modifier
    static var dim:           [Int] = [2, 22]

    /// Italic Control Modifier
    static var italic:        [Int] = [2, 23]

    /// Underline Control Modifier
    static var underline:     [Int] = [4, 24]

    /// Inverse Control Modifier
    static var inverse:       [Int] = [7, 27]

    /// Hidden Control Modifier
    static var hidden:        [Int] = [8, 28]

    /// Strikethrough Control Modifier
    static var strikethrough: [Int] = [9, 29]
}

/// ANSI Teletype Terminal Control Text Escape Sequences
internal struct BKANSIColorCode {
    /// 8-bit Black color code
    static let black:   [Int] = [0, 9]

    /// 8-bit Red color code
    static let red:     [Int] = [1, 9]

    /// 8-bit Green color code
    static let green:   [Int] = [2, 9]

    /// 8-bit Yellow color code
    static let yellow:  [Int] = [3, 9]

    /// 8-bit Blue color code
    static let blue:    [Int] = [4, 9]

    /// 8-bit Magenta color code
    static let magenta: [Int] = [5, 9]

    /// 8-bit Cyan color code
    static let cyan:    [Int] = [6, 9]

    /// 8-bit White color code
    static let white:   [Int] = [7, 9]
}

/// Apply ANSI Teletype Terminal Control Background Escape Sequences
/// - Parameter style: Style to apply
/// - Returns: Tele-escaped String
func apply<T>(style: [T]) -> ((String) -> String) {
    return { str in return "\u{001B}[\(style[0])m\(str)\u{001B}[\(style[1])m" }
}

func getColor(color: [Int], mod: Int) -> [Int] {
    let terminator: Int = mod == 30 || mod == 90 ? 30 : 40
    return [ color[0] + mod, color[1] + terminator ]
}

internal class BKANSIColors {
    /// Normal Text Color. 30 is the default text color
    static let normalText: Int = 30

    /// Background Color. 40 is the default background color
    static let bg:         Int = 40

    /// Bright Text Color. 90 is the default text color
    static let brightText: Int = 90

    /// Bright Background Color. 100 is the default background color
    static let brightBg:   Int = 100

    /// Get text colorer
    /// 
    /// - Parameter color: Color value
    /// - Returns: Text Colorer
    internal static func getTextColorer(color: Int) -> ((String) -> String) {
        return apply(style: ["38;5;\(color)", String(normalText + 9)])
    }

    /// Color text
    /// - Parameters:
    ///   - text: Text String
    ///   - color: Color
    /// - Returns: Tele-escaped String
    internal static func colorText(text: String, color: Int) -> String {
        return BKANSIColors.getTextColorer(color: color)(text)
    }

    /// Get background colorer
    /// 
    /// - Parameter color: Color Code
    /// - Returns: Text String
    internal static func getBgColorer(color: Int) -> ((String) -> String) {
        return apply(style: ["48;5;\(color)", String(bg + 9)])
    }

    /// Color background
    /// 
    /// - Parameters:
    ///   - text: Text String
    ///   - color: Color code
    /// - Returns: Tele-escaped String
    internal static func colorBg(text: String, color: Int) -> String {
        return BKANSIColors.getBgColorer(color: color)(text)
    }

    // MARK: - Normal text colors

    /// Black Text Color
    internal static var black = apply(style: getColor(color: BKANSIColorCode.black, mod: normalText))

    /// Red Text Color
    internal static var red = apply(style: getColor(color: BKANSIColorCode.red, mod: normalText))

    /// Green Text Color
    internal static var green = apply(style: getColor(color: BKANSIColorCode.green, mod: normalText))

    /// Yellow Text Color
    internal static var yellow = apply(style: getColor(color: BKANSIColorCode.yellow, mod: normalText))

    /// Blue Text Color
    internal static var blue = apply(style: getColor(color: BKANSIColorCode.blue, mod: normalText))

    /// Magenta Text Color
    internal static var magenta = apply(style: getColor(color: BKANSIColorCode.magenta, mod: normalText))

    /// Cyan Text Color
    internal static var cyan = apply(style: getColor(color: BKANSIColorCode.cyan, mod: normalText))

    /// White Text Color
    internal static var white = apply(style: getColor(color: BKANSIColorCode.white, mod: normalText))

    // MARK: - Bright text colors

    /// Black Bright Text Color
    internal static var Black = apply(style: getColor(color: BKANSIColorCode.black, mod: brightText))

    /// Red Bright Text Color
    internal static var Red = apply(style: getColor(color: BKANSIColorCode.red, mod: brightText))

    /// Green Bright Text Color
    internal static var Green = apply(style: getColor(color: BKANSIColorCode.green, mod: brightText))

    /// Yellow Bright Text Color
    internal static var Yellow = apply(style: getColor(color: BKANSIColorCode.yellow, mod: brightText))

    /// Blue Bright Text Color
    internal static var Blue = apply(style: getColor(color: BKANSIColorCode.blue, mod: brightText))

    /// Magenta Bright Text Color
    internal static var Magenta = apply(style: getColor(color: BKANSIColorCode.magenta, mod: brightText))

    /// Cyan Bright Text Color
    internal static var Cyan = apply(style: getColor(color: BKANSIColorCode.cyan, mod: brightText))

    /// White Bright Text Color
    internal static var White = apply(style: getColor(color: BKANSIColorCode.white, mod: brightText))

    // MARK: - Normal background colors

    /// Black Background Color
    internal static var bgBlack = apply(style: getColor(color: BKANSIColorCode.black, mod: bg))

    /// Red Background Color
    internal static var bgRed = apply(style: getColor(color: BKANSIColorCode.red, mod: bg))

    /// Green Background Color
    internal static var bgGreen = apply(style: getColor(color: BKANSIColorCode.green, mod: bg))

    /// Yellow Background Color
    internal static var bgYellow = apply(style: getColor(color: BKANSIColorCode.yellow, mod: bg))

    /// Blue Background Color
    internal static var bgBlue = apply(style: getColor(color: BKANSIColorCode.blue, mod: bg))

    /// Magenta Background Color
    internal static var bgMagenta = apply(style: getColor(color: BKANSIColorCode.magenta, mod: bg))

    /// Cyan Background Color
    internal static var bgCyan = apply(style: getColor(color: BKANSIColorCode.cyan, mod: bg))

    /// White Background Color
    internal static var bgWhite = apply(style: getColor(color: BKANSIColorCode.white, mod: bg))

    // MARK: - Bright background colors

    /// Black Bright Background Color
    internal static var BgBlack = apply(style: getColor(color: BKANSIColorCode.black, mod: brightBg))

    /// Red Bright Background Color
    internal static var BgRed = apply(style: getColor(color: BKANSIColorCode.red, mod: brightBg))

    /// Green Bright Background Color
    internal static var BgGreen = apply(style: getColor(color: BKANSIColorCode.green, mod: brightBg))

    /// Yellow Bright Background Color
    internal static var BgYellow = apply(style: getColor(color: BKANSIColorCode.yellow, mod: brightBg))

    /// Blue Bright Background Color
    internal static var BgBlue = apply(style: getColor(color: BKANSIColorCode.blue, mod: brightBg))

    /// Magenta Bright Background Color
    internal static var BgMagenta = apply(style: getColor(color: BKANSIColorCode.magenta, mod: brightBg))

    /// Cyan Bright Background Color
    internal static var BgCyan = apply(style: getColor(color: BKANSIColorCode.cyan, mod: brightBg))

    /// White Bright Background Color
    internal static var BgWhite = apply(style: getColor(color: BKANSIColorCode.white, mod: brightBg))

    // MARK: - Text modifiers

    /// Bold Text
    internal static var bold = apply(style: BKANSIModifiers.bold)

    /// Blink character
    internal static var blink = apply(style: BKANSIModifiers.blink)

    /// Dim character
    internal static var dim = apply(style: BKANSIModifiers.dim)

    /// Italic text
    internal static var italic = apply(style: BKANSIModifiers.italic)

    /// Underline text
    internal static var underline = apply(style: BKANSIModifiers.underline)

    /// Inverse text
    internal static var inverse = apply(style: BKANSIModifiers.inverse)

    /// Hidden text
    internal static var hidden = apply(style: BKANSIModifiers.hidden)

    /// Strikethrough text
    internal static var strikethrough = apply(style: BKANSIModifiers.strikethrough)
}
