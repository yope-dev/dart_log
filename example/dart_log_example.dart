import 'package:dart_log/dart_log.dart';

void main() {
  var dartLog = DartLog();
  print('awesome: ${dartLog.log(LogType.debug, 'debug text')}');
}
