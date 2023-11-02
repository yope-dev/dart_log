import 'dart:io';
import 'package:path/path.dart' as p;

enum LogType { info, warning, error, debug }

class DartLog {
  String logName = '';
  Directory directory = Directory('');
  DartLog(this.logName, this.directory);

  factory DartLog.init({String logName = '', Directory? dir}) {
    if (logName.isEmpty) {
      logName = Platform.resolvedExecutable
          .split(Platform.pathSeparator)
          .last
          .replaceAll('.exe', '');
    }
    if (dir == null) {
      final String rootPath =
          '${Platform.resolvedExecutable.substring(0, Platform.resolvedExecutable.lastIndexOf(Platform.pathSeparator) + 1)}${Platform.pathSeparator}';
      dir = Directory(p.join(rootPath, 'logs'));
      if (!dir.existsSync()) {
        dir.createSync();
      }
    } else {
      if (!dir.existsSync()) {
        dir.createSync();
      }
    }
    return DartLog(logName, dir);
  }

  String convertTime(DateTime now) =>
      '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${now.hour > 9 ? now.hour : '0${now.hour}'}:${now.minute > 9 ? now.minute : '0${now.minute}'}:${now.second > 9 ? now.second : '0${now.second}'}';

  /// Function for logging, if type == LogType.debug
  /// only print, else write to file
  ///
  /// Return true if success write to file.
  /// Return false if can't write to file.
  bool log(LogType type, String info) {
    bool result = false;
    int spaceAmount = 1;
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
    String logText =
        '[${convertTime(DateTime.now())}] ${type.name.toUpperCase()}${' ' * spaceAmount} | ${info.toString().replaceAll('\n', ' ')}\n';
    if (type == LogType.debug) {
      print(logText);
      return true;
    }
    try {
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
