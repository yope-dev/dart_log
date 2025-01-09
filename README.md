# DartLog 📜

A simple logging utility for Flutter/Dart applications to write logs to a file with different severity levels: INFO, WARNING, ERROR, and DEBUG.

## Features 🚀

- **Log Levels:** Record logs with different severity levels (INFO, WARNING, ERROR, DEBUG).
- **Timestamps:** Each log entry includes a timestamp for easy tracking.
- **Customizable Log Path:** Specify the path where logs should be stored.
- **Easy to Use:** Intuitive API for logging messages.

## Installation 🔧

Add `dart_log` to your `pubspec.yaml`:

```yaml
dependencies:
  dart_log:
    git:
      url: https://github.com/yope-dev/dart_log.git
      ref: "main"
```

Import the package in your Dart code:

```dart
import 'package:dart_log/dart_log.dart';
```

## Usage Example 📋

Initialize the logger:


```dart
DartLog log = DartLog.init(
  logName: 'app_log',
  dir: Directory('path/to/logs'),
);
```
or

```dart
DartLog log = DartLog.init();
```

Log different types of messages:

```dart
log.log(LogType.info, 'This is an informational message.');
log.log(LogType.warning, 'This is a warning message.');
log.log(LogType.error, 'This is an error message.');
log.log(LogType.debug, 'This is a debug message.');
```

## Why Use DartLog? 🤔

- **Simplifies Logging:** Easy to implement and use for any Flutter/Dart project.
- **Debugging Made Easy:** Quickly identify issues with appropriately logged messages.
- **Extendable:** Can be easily extended to include more features as needed.

## Contributing 🤝

Contributions are welcome! Please open an issue or submit a pull request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Happy logging! 🎉