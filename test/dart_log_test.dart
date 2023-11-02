import 'package:dart_log/dart_log.dart';

void main() {
  DartLog dartLog = DartLog.init();
  dartLog.log(LogType.debug, 'info text');
}
