//
//  Engine.swift
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

// Import Foundation for various comodities.
import Foundation

/** Alpine is a very nimble logging framework for Swift that provides a simple and flexible way to log messages in your application. 

It offers various configuration options, such as:
 - Console-only logging or File-Console-logging,
 - Synchronous and Asynchronous (background) execution,
 - Custom Dispatch Queues,
 - Defining log levels to log for (`writers`),
 - Custom amount of path components to display in log messages,
 - Or simply enabling or disabling logging altogether.
 
Alpine allows you to log messages with different log levels, such as verbose, debug, info, warning, error, and hard error, 
and provides colored output for easier log message identification. 

Additionally, it supports file logging for persistent storage of log messages.
 
It officially supports Windows, macOS and Linux
*/
public class Alpine {    
    /// How many path components of Source file to display when logging.
    /// Defaults to `2` (eg. Bliksem/Blockchain.swift)
    public static var pathDepth: Int = 2
    
    /// Path to the log file.
    /// Set value to `nil` if you want to log only in-memory.
    public static var logFilePath: String? = nil
    
    /// The Default Background Dispatch Queue Alpine will use if in Asynchronous mode
    public static var logQueue: DispatchQueue = DispatchQueue(label: "log", qos: .background)
    
    
    /// Array Log levels this logger is configured to log for.
    public static var writers: [LogLevel] = [.info, .warning, .error, .hardError]
    
    /// The execution method used when logging a message.
    public static var executionMethod: ExecutionMethod = .synchronous(lock: NSRecursiveLock())
    
    /// Controls whether to allow log messages to be logged from writers.
    public static var isEnabled: Bool = true
    
    public static func log(_ level: LogLevel, _ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        // First check if we can should even log. Check if we're enabled and if the Log Levels are Allowed
        guard isEnabled && self.writers.contains(level) else { return }
        
        // If the pathDepth is less than 1, we set it to 1
        // Make sure we don't crash
        if pathDepth < 1 {
            // Set the pathDepth to 1
            pathDepth = 1
        }
        
        // Then we get the File Paths components
        #if os(Windows)
            // Windows uses '\' in paths
            let components: [String] = file.components(separatedBy: "\\")
            let fileName:    String  = components.suffix(pathDepth).joined(separator: "\\")
        #else
            // macOS and Linux use '/' in paths
            let components: [String] = file.components(separatedBy: "/")
            let fileName:    String  = components.suffix(pathDepth).joined(separator: "/")
        #endif
        
        // Now we synthesize the log string
        let logString: String = "\(Date()) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)"
        
        // Now we log the message
        // We use a switch statement to determine which execution method to use
        switch executionMethod {
        // If we're using a synchronous method, we lock the thread and log the message
        case .synchronous(let lock):
            // We use a defer statement to ensure the lock is unlocked after the switch statement
            lock.lock() ; defer { lock.unlock() }

            // We use a switch statement to determine which color to use for the log message
            switch level {
            // If the log level is a warning, we use the Yellow color
            case .warning:
                // print the message in yellow
                print(BKANSIColors.Yellow(logString))
            case .error:
                // If the log level is an error, we use red.
                print(BKANSIColors.Red(logString))
            case .hardError:
                // The same as above, if the log level is a HardError, we use the red.
                print(BKANSIColors.Red(logString))
            default:
                // If the log level is anything else, we just print the message
                print(logString)
            }
            
            // Finally, we append the log message to the log file.
            appendLineToFile(line: logString)
            
        // If we're using an asynchronous method, we use the logQueue to log the message
        case .asynchronous(_):
            // We use a Dispatch Queue to log the message asynchronously
            logQueue.async {
                // We use a switch statement to determine which color to use for the log message
                switch level {
                // If the log level is a warning, we use the Yellow color
                case .warning:
                    // print the message in yellow
                    print(BKANSIColors.Yellow(logString))
                    appendLineToFile(line: logString)
                case .error:
                    // If the log level is an error, we use red.
                    print(BKANSIColors.Red(logString))
                    appendLineToFile(line: logString)
                case .hardError:
                    // The same as above, if the log level is a HardError, we use the red.
                    print(BKANSIColors.Red(logString))
                    appendLineToFile(line: logString)
                default:
                    // If the log level is anything else, we just print the message
                    print(logString)
                    appendLineToFile(line: logString)
                }
            }
        }
    }
    
}
