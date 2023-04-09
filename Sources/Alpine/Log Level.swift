//
//  LogLevel.swift
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

/// Log Level extension for Alpine
public extension Alpine {
    /// Enumerates the different log levels for logging messages.
    enum LogLevel: String {
        /// Log level for detailed and extensive logging.
        case verbose = "VERBOSE"
        
        /// Log level for logging debug information.
        case debug = "DEBUG"
        
        /// Log level for logging informational messages.
        case info = "INFO"
        
        /// Log level for logging warnings.
        case warning = "WARNING"
        
        /// Error log level for logging non-fatal errors.
        case error = "ERROR"
        
        /// Log level for logging non-recoverable fatal errors.
        case hardError = "HARD ERROR"
    }
}
