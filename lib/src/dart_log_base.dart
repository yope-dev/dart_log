import 'dart:io';
import 'package:path/path.dart' as p;

enum LogType { info, warning, error, debug }

class DartLog {
  String convertTime(DateTime now) =>
      '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${now.hour > 9 ? now.hour : '0${now.hour}'}:${now.minute > 9 ? now.minute : '0${now.minute}'}:${now.second > 9 ? now.second : '0${now.second}'}';
  final String rootPath =
      '${Platform.resolvedExecutable.substring(0, Platform.resolvedExecutable.lastIndexOf(Platform.pathSeparator) + 1)}${Platform.pathSeparator}';

  /// Function for logging,
  bool log(LogType type, String info) {
    bool result = false;
    try {
      String appName = Platform.resolvedExecutable
          .split(Platform.pathSeparator)
          .last
          .replaceAll('.exe', '');
      // print('path: $_rootPath\nappName: $appName');
      String logText =
          '[${convertTime(DateTime.now())}] ${type.name.toUpperCase()} - ${info.toString().replaceAll('\n', ' ')}\n';
      final directory = Directory(p.join(rootPath, 'logs'));
      if (!directory.existsSync()) {
        directory.createSync();
      }
      final file = File(p.join(directory.path, '$appName.log'));
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
