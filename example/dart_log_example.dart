import 'dart:io';
import 'package:dart_log/dart_log.dart';

void main() {
  // Initialize default logger
  DartLog defaultLogger = DartLog.init();
  // Log a debug message using the default logger
  defaultLogger.log(LogType.debug, 'Info text');

  // Initialize custom logger with specified log name and directory
  DartLog customLogger = DartLog.init(
    logName: 'test',
    dir: Directory('D:\\dart_log'),
  );
  // Log messages using the custom logger
  customLogger.log(LogType.error, 'Some Error');
  customLogger.log(LogType.info, 'Some INFO');
  customLogger.log(LogType.warning, 'Some warning');
}
