import 'dart:io';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'package:dart_log/dart_log.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('dart_log_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('DartLog init sets logName and creates directory', () {
    // Arrange
    final log = DartLog.init(dir: tempDir);

    // Assert
    expect(log.logName, isNotEmpty);
    expect(log.directory.existsSync(), isTrue);
  });

  test('DartLog init uses provided logName and creates directory', () {
    // Arrange
    final logName = 'custom_log';
    final log = DartLog.init(logName: logName, dir: tempDir);

    // Assert
    expect(log.logName, logName);
    expect(log.directory.existsSync(), isTrue);
  });

  test('convertTime formats datetime correctly', () {
    // Arrange
    final now = DateTime(2023, 10, 5, 14, 30, 45);
    final log = DartLog('', tempDir);

    // Act
    final formattedTime = log.convertTime(now);

    // Assert
    expect(formattedTime, '2023-10-05 14:30:45');
  });

  test('log writes INFO to file', () {
    // Arrange
    final logName = 'info_log';
    final log = DartLog.init(logName: logName, dir: tempDir);
    final infoMessage = 'This is an info message.';

    // Act
    final result = log.log(LogType.info, infoMessage);
    final file = File(p.join(tempDir.path, '$logName.log'));
    final fileContent = file.readAsStringSync();

    // Assert
    expect(result, isTrue);
    expect(
        fileContent,
        contains(
            '[${log.convertTime(DateTime.now())}] INFO    | ${infoMessage.replaceAll('\n', ' ')}\n'));
  });

  test('log writes ERROR to file', () {
    // Arrange
    final logName = 'error_log';
    final log = DartLog.init(logName: logName, dir: tempDir);
    final errorMessage = 'This is an error message.';

    // Act
    final result = log.log(LogType.error, errorMessage);
    final file = File(p.join(tempDir.path, '$logName.log'));
    final fileContent = file.readAsStringSync();

    // Assert
    expect(result, isTrue);
    expect(
        fileContent,
        contains(
            '[${log.convertTime(DateTime.now())}] ERROR   | ${errorMessage.replaceAll('\n', ' ')}\n'));
  });

  test('log writes WARNING to file', () {
    // Arrange
    final logName = 'warning_log';
    final log = DartLog.init(logName: logName, dir: tempDir);
    final warningMessage = 'This is a warning message.';

    // Act
    final result = log.log(LogType.warning, warningMessage);
    final file = File(p.join(tempDir.path, '$logName.log'));
    final fileContent = file.readAsStringSync();

    // Assert
    expect(result, isTrue);
    expect(
        fileContent,
        contains(
            '[${log.convertTime(DateTime.now())}] WARNING | ${warningMessage.replaceAll('\n', ' ')}\n'));
  });

  test('log prints DEBUG to console', () {
    // Arrange
    final logName = 'debug_log';
    final log = DartLog.init(logName: logName, dir: tempDir);
    final debugMessage = 'This is a debug message.';

    // Act
    final result = log.log(LogType.debug, debugMessage);

    // Assert
    expect(result, isTrue);
    // Note: Testing print output is not straightforward in Dart tests.
    // Consider using a logger that captures output for testing.
  });
}
