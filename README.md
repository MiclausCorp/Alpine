# Alpine 🗻

[![Swift](https://github.com/MiclausCorp/Alpine/actions/workflows/swift.yml/badge.svg)](https://github.com/MiclausCorp/Alpine/actions/workflows/swift.yml)
[![Get on SPM](https://img.shields.io/badge/Available%20on-Swift%20Package%20Manager-orange?logo=swift)](#installation)

Alpine is a lightweight and flexible logging library for Swift that provides an easy way to log messages in your application. It comes with a range of configuration options that allow you to customize the logging process according to your needs.

## Features
Alpine offers various configuration options:

*   **Console-only logging or File-Console-logging:** Choose between logging to console only, or logging to both console and file.
*   **Synchronous and Asynchronous (background) execution:** You can choose to execute the logging process synchronously or asynchronously.
*   **Custom Dispatch Queues:** You can specify custom dispatch queues for executing the logging process.
*   **Defining log levels to log for (`writers`):** Choose which log levels you want to log for.
*   **Custom amount of path components to display in log messages:** You can specify how many path components to display in log messages.
*   **Enabling or disabling logging altogether:** You can easily enable or disable logging altogether.

In addition to these features, Alpine also allows you to log messages with different log levels, including verbose, debug, info, warning, error, and hard error. Colored output is provided for easier log message identification, and file logging is supported for persistent storage of log messages.

## Installation
#### Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in `Package.swift` by adding this:
```swift
.package(url: "https://github.com/MiclausCorp/Alpine.git", branch: "master")
```

## Getting Started
To get started with Alpine, simply add it to your project using a package manager like Swift Package Manager. Once you have added Alpine to your project, you can start using it right away.

Here's a simple example of how to log to a message with Alpine (Console-Only):
```swift
import Alpine
Alpine.info("My first log.")
```

## File-Console Logging
To use File-Console logging, you need to set up a log file
```swift
Alpine.setLogFile(toPath: "/Users/user/Documents/MyApp.log")
Alpine.hardError("We Crashed Because of this.")
```

## Writers (Log Levels)
By default, Alpine only captures **Informational Messages**, **Warnings**, **Errors** and **Hard Errors**. Everything else (**verbose** and **debug**) is ignored.

Alpine allows you to define the log levels to log for using the `writers` property. 
This property is an array of `LogLevel` values that specifies which log levels to log for.

```swift
// Capture debug logs only
Alpine.writers = [.debug]
Alpine.debug("Debug")

// That means that this will be ignored.
// Alpine.warning("Warning")
```

## Synchronous vs Asynchronous Execution Modes
Alpine offers both synchronous and asynchronous (background) Execution Modes to provide flexibility in how you want to execute your logging process. By default, Alpine uses Synchronous mode.

**Synchronous Logging**: In synchronous logging mode, the logging process is executed on the same thread that initiated the log message. This mode is useful when debugging your app, where you want to ensure that the log message is logged before proceeding with the next task.

```swift
// Alpine is coincident by default. This is how you'd set it
Alpine.executionMethod = .synchronous()
Alpine.error("This is an error log message.")
```

You can also provide your own recursive lock

```swift
Alpine.executionMethod = .synchronous(lock: NSRecursiveLock())
Alpine.error("This is an error log message.")
```

**Asynchronous Logging**: In asynchronous logging mode, the logging process is executed on a background thread, allowing the main thread to continue with other tasks without waiting for the log message to be logged. This mode is useful for production, where you want to log messages without affecting the performance of your application.
```swift
Alpine.executionMethod = .asynchronous()
Alpine.info("Here's an informational message")
```

You can also provide your own Dispatch Queue (It doesn't even have to have a Background QOS)

```swift
Alpine.executionMethod = .asynchronous(queue: DispatchQueue(label: "net.bliksem.log"))
Alpine.verbose("We are checking...")
```

## Path Components
Alpine allows you to customize the number of path components to display in log messages using the `pathDepth` property. This property specifies the number of path components to display in log messages.
```swift
// Path Depth = 2, get the last two path components
Alpine.pathDepth = 2
Alpine.error("An error has occured") // Will log something like (Bliksem/Blockchain.swift)
```

## Killswitch
Ever had to search and comment all of your `print(_)` statements before lanuching your app? Well, no more.
Alpine allows you to enable or disable logging using the `isEnabled` property. This property allows you to easily disable logging in Production mode to get back those precious milliseconds without removing your old code.
```swift
Alpine.isEnabled = false
Alpine.info("You won't see me :(") // This will not be logged
```

You can easily re-enable it later if you need to debug some issues in your app
```swift
Alpine.isEnabled = true
Alpine.info("Now you see me :)") // This time it'll log
```

## ANSI Control Modifiers
Alpine uses ANSI colors to highlight **warning**, **error**, and **hard error** log messages. This makes it easy to identify these messages in the console.

Warning messages are highlighted in **yellow**.
Error and Hard error messages are highlighted in **bright red**.

## Contributing
Contributions to Alpine are welcome! If you would like to contribute, feel free to submit a pull request.

## Compatibility
Alpine officially supports Windows, macOS, and Linux.

## Documentation
While Alpine is very easy to use thanks to its Static syntax, you can always use the Xcode Documentation Compiler. Go to Product > Build Documentation

## License
Alpine is released under the MIT license. See [LICENSE](LICENSE) for more information.
