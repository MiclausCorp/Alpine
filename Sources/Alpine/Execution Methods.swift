//
//  Execution Methods.swift
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

// Import Foundation for DispatchQueue and NSRecursiveLock()
import Foundation

/// Public Execution Method extension for Alpine
public extension Alpine {
    /// Defines the two types of execution methods used when logging a message.
    ///
    /// Logging operations can be expensive operations when there are hundreds of messages being generated or when
    /// it is computationally expensive to compute the message to log. Ideally, one would use the synchronous method
    /// in development, and the asynchronous method in production. This allows for easier debugging in the development
    /// environment, and better performance in production.
    ///
    /// - synchronous:  Logs messages synchronously once the recursive lock is available in serial order.
    /// - asynchronous: Logs messages asynchronously on the dispatch queue in a serial order.
    enum ExecutionMethod {
        /// Log message once the recursive lock is available.
        case synchronous(lock: NSRecursiveLock = NSRecursiveLock())

        /// Log message on the dispatch queue. 
        /// Note - Background QOS is used by default.
        case asynchronous(queue: DispatchQueue = Alpine.logQueue)
    }
}
