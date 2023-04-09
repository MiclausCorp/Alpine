//
//  Drivers.swift
//  Alpine
//
//  Created by Darius Miclaus on 09/04/2023.
//  Copyright (c) 2023 Miclaus Industries Corporation B.V.
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
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

/// Alpine Extension for Logging drivers
public extension Alpine {
    /// Log Verbose messages. (Use for detailed and extensive logging).
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func verbose(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .verbose log level
        log(.verbose, message, file: file, line: line, function: function)
    }
    
    /// Log Debug messages
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func debug(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .debug log level
        log(.debug, message, file: file, line: line, function: function)
    }
    
    /// Log informational messages.
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func info(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .info log level
        log(.info, message, file: file, line: line, function: function)
    }
    
    /// Log Warning messages
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func warning(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .warning log level
        log(.warning, message, file: file, line: line, function: function)
    }
    
    /// Log recoverable errors
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func error(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .error log level
        log(.error, message, file: file, line: line, function: function)
    }
    
    /// Log non-recoverable fatal errors.
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - file: The name of the file where the log statement is called. Default is #file.
    ///   - line: The line number where the log statement is called. Default is #line.
    ///   - function: The name of the function where the log statement is called. Default is #function.
    static func hardError(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // Call log function with .hardError log level
        log(.hardError, message, file: file, line: line, function: function)
    }
}
