import 'package:hive_flutter/hive_flutter.dart';

class ProgressStore {
  static const _boxName = 'progress';
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  String _linesKey(String songId, int level) => '$songId:level$level:lines';
  String _doneKey(String songId, int level) => '$songId:level$level:done';

  Set<int> completedLines(String songId, int level) {
    final stored = _box.get(_linesKey(songId, level), defaultValue: <int>[]);
    return Set<int>.from((stored as List).cast<int>());
  }

  Future<void> markLineComplete(String songId, int level, int lineId) async {
    final lines = completedLines(songId, level)..add(lineId);
    await _box.put(_linesKey(songId, level), lines.toList());
  }

  bool isLevelComplete(String songId, int level) {
    return _box.get(_doneKey(songId, level), defaultValue: false) as bool;
  }

  Future<void> setLevelComplete(String songId, int level) async {
    await _box.put(_doneKey(songId, level), true);
  }

  int completedLineCount(String songId, int level) {
    return completedLines(songId, level).length;
  }
}
