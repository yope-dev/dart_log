import 'package:dart_log/dart_log.dart';

void main() async {
  // Create a dartLog
  final dartLog = DartLog();

  // Log something
  dartLog.log(LogType.info, 'Info text');
}
