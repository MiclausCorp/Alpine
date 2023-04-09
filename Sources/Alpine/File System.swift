//
//  File System.swift
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

// Import Foundation for `FileManager`
import Foundation

/// File System Management Extension for Alpine
public extension Alpine {
    /// Append a line to the log file.
    /// - Parameter line: The Log message to append to the log file.
    internal static func appendLineToFile(line: String) {
        // Check if log file path is set
        guard let logFilePath: String = logFilePath else {
            // If not, We skip appending the line to the file. The user likely wants Console logging only.
            return
        }
        
        // Check if the log file exists
        let fileManager: FileManager = FileManager.default                 // Get the file manager
        let fileExists: Bool = fileManager.fileExists(atPath: logFilePath) // Check if the file exists
        
        // If file doesn't exist, create it
        if !fileExists {
            // Create the file
            fileManager.createFile(atPath: logFilePath, contents: nil, attributes: nil)
        }
        
        // Now Append the line to the file
        if let fileHandle: FileHandle = FileHandle(forWritingAtPath: logFilePath) {
            // Read to the end of the file
            fileHandle.seekToEndOfFile()

            // Append the line to the file
            #if os(Windows)
            // Windows uses a Carriage Return (CR) followed by a Line Feed (LF) for new lines
            let lineData: Data? = (line + "\r\n").data(using: .utf8)
            #else
            // macOS and Linux use a Line Feed (LF) for new lines
            let lineData: Data? = (line + "\n").data(using: .utf8)
            #endif

            // Write the line to the file
            // Note, we use `?? Data()` to ensure that we don't crash if the line is nil

            // Make sure the line data is not nil so we don't crash.
            // That's the last thing you would want from your logging library.
            guard let lineData: Data = lineData else {
                // If the line data is nil, we print an error message and return
                print("Failed to write line to file: \(logFilePath)")
                return
            }

            // Write the validated line to the file
            fileHandle.write(lineData)

            // Close the file
            fileHandle.closeFile()
        } else {
            // If we failed to open the file for writing, we print an error message
            print("Failed to open file for writing: \(logFilePath)")
        }
    }
    
    /// Set the log file path.
    /// - Parameter logFilePath: The path to the log file. Defaults to logs in the current directory.
    static func setLogFile(toPath logFilePath: String = "log") {
        // Set the log file
        self.logFilePath = logFilePath
    }
}
