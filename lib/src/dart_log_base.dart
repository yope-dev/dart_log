import 'dart:io';
import 'package:path/path.dart' as p;

/// Enum representing different types of log levels.
enum LogType { info, warning, error, debug }

/// A logging utility for Flutter/Dart applications to write logs to a file with different severity levels.
class DartLog {
  String logName = '';
  Directory directory = Directory('');

  /// Constructor for DartLog, initializes logName and directory.
  DartLog(this.logName, this.directory);

  /// Factory constructor to initialize logName and directory with default values if necessary.
  factory DartLog.init({String logName = '', Directory? dir}) {
    // If logName is empty, use the executable name without .exe extension
    if (logName.isEmpty) {
      logName = Platform.resolvedExecutable
          .split(Platform.pathSeparator)
          .last
          .replaceAll('.exe', '');
    }
    // If dir is null, create a 'logs' directory in the executable's directory
    if (dir == null) {
      final String rootPath =
          '${Platform.resolvedExecutable.substring(0, Platform.resolvedExecutable.lastIndexOf(Platform.pathSeparator) + 1)}${Platform.pathSeparator}';
      dir = Directory(p.join(rootPath, 'logs'));
      if (!dir.existsSync()) {
        dir.createSync();
      }
    } else {
      // If the provided directory does not exist, create it
      if (!dir.existsSync()) {
        dir.createSync();
      }
    }
    return DartLog(logName, dir);
  }

  /// Converts a DateTime object to a string in the format: yyyy-MM-dd HH:mm:ss.
  String convertTime(DateTime now) =>
      '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} '
      '${now.hour > 9 ? now.hour : '0${now.hour}'}:${now.minute > 9 ? now.minute : '0${now.minute}'}:'
      '${now.second > 9 ? now.second : '0${now.second}'}';

  /// Logs a message to a file or prints it to the console based on the log type.
  ///
  /// - For [LogType.debug], prints the message to the console.
  /// - For other types, appends the message to the log file.
  ///
  /// Returns true if the log is successfully written to the file or printed, false otherwise.
  bool log(LogType type, String info) {
    bool result = false;
    int spaceAmount = 1;
    // Determines the space amount for alignment based on log type
    switch (type) {
      case LogType.info:
        spaceAmount = 3;
        break;
      case LogType.error:
        spaceAmount = 2;
        break;
      default:
        spaceAmount = 0;
        break;
    }
    // Constructs the log message with timestamp, type, and info
    String logText =
        '[${convertTime(DateTime.now())}] ${type.name.toUpperCase()}${' ' * spaceAmount} | ${info.toString().replaceAll('\n', ' ')}\n';
    // If debug, print to console
    if (type == LogType.debug) {
      print(logText);
      return true;
    }
    try {
      // Constructs the file path and writes the log message
      final file = File(p.join(directory.path, '$logName.log'));
      if (file.existsSync()) {
        file.writeAsStringSync(logText, mode: FileMode.append);
      } else {
        file.createSync();
        file.writeAsStringSync(logText);
      }
      result = true;
    } catch (e) {
      result = false;
    }
    return result;
  }
}
