import XCTest
@testable import Alpine

final class AlpineTests: XCTestCase {
    
    // Replace with the path to your test log file
    let logFilePath = "test.log"
    
    override func setUp() {
        super.setUp()
        
        // Set up the Alpine with the test log file path
        Alpine.setLogFile(toPath: logFilePath)
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Remove the test log file after each test
        do {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: logFilePath) {
                try fileManager.removeItem(atPath: logFilePath)
            }
        } catch {
            XCTFail("Failed to remove test log file: \(error.localizedDescription)")
        }
    }
    
    func testVeboseLogging() {
        // Verbose
        Alpine.writers = [.verbose]
        Alpine.verbose("Verbose log message")
        XCTAssertTrue(readLogFile().contains("[VERBOSE]"), "Verbose log message not found in log file")
    }
    
    func testDebugLogging() {
        // Debug
        Alpine.writers = [.debug]
        Alpine.debug("Debug log message")
        XCTAssertTrue(readLogFile().contains("[DEBUG]"), "Debug log message not found in log file")
    }
    
    func testInfoLogging() {
        // Info
        Alpine.writers = [.info]
        Alpine.info("Info log message")
        XCTAssertTrue(readLogFile().contains("[INFO]"), "Info log message not found in log file")
    }
    
    func testWarningLogging() {
        // Warning
        Alpine.writers = [.warning]
        Alpine.warning("Warning log message")
        XCTAssertTrue(readLogFile().contains("[WARNING]"), "Warning log message not found in log file")
    }
    
    func testErrorLogging() {
        // Error
        Alpine.writers = [.error]
        Alpine.error("Error log message")
        XCTAssertTrue(readLogFile().contains("[ERROR]"), "Error log message not found in log file")
    }
    
    func testHardErrorLogging() {
            // Hard Error
            Alpine.writers = [.hardError]
            Alpine.hardError("Hard Error log message")
            XCTAssertTrue(readLogFile().contains("[HARD ERROR]"), "Error log message not found in log file")
    }
    
    
    func testAppendingToFile() {
        // Test appending log message to file
        
        // Append log message
        Alpine.appendLineToFile(line: "Test log message")
        XCTAssertTrue(readLogFile().contains("Test log message"), "Appended log message not found in log file")
    }
    
    func testSettingLogFile() {
        // Test setting log file path
        
        // Set log file path
        let newLogFilePath = "test_new.log"
        Alpine.setLogFile(toPath: newLogFilePath)
        XCTAssertEqual(Alpine.logFilePath, newLogFilePath, "Failed to set log file path")
    }
    
    // Helper method to read the contents of the test log file
    func readLogFile() -> String {
        do {
            let logContents = try String(contentsOfFile: logFilePath, encoding: .utf8)
            return logContents
        } catch {
            XCTFail("Failed to read log file: \(error.localizedDescription)")
            return ""
        }
    }
}
