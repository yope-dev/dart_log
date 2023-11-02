import 'dart:io';

import 'package:dart_log/dart_log.dart';

void main() async {
  // Create a dartLog
  DartLog dartLog = DartLog.init();
  // Log something
  dartLog.log(LogType.debug, 'Info text');
  dartLog = DartLog.init(logName: 'test', dir: Directory('D:\\GIT\\dart_log'));
  dartLog.log(LogType.error, 'Some Error');
  dartLog.log(LogType.info, 'Some INFO');
  dartLog.log(LogType.warning, 'Some warning');
}
