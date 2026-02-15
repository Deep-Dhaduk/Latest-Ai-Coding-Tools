import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyIntake = 'daily_ml';
const _keyLastDate = 'last_reset_date';
const _keyGoal = 'goal_ml';
const _keyHistory = 'history'; // comma-separated ml entries for today

const int defaultGoalMl = 2000;
const int glassMl = 250;

class StorageService extends ChangeNotifier {
  int _currentMl = 0;
  int _goalMl = defaultGoalMl;
  String _lastDate = '';
  final List<int> _todayHistory = [];
  bool _loaded = false;

  int get currentMl => _currentMl;
  int get goalMl => _goalMl;
  List<int> get todayHistory => List.unmodifiable(_todayHistory);
  bool get loaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _goalMl = prefs.getInt(_keyGoal) ?? defaultGoalMl;
    _lastDate = prefs.getString(_keyLastDate) ?? '';
    final today = _today();
    if (_lastDate != today) {
      _currentMl = 0;
      _todayHistory.clear();
      _lastDate = today;
      await _save();
    } else {
      _currentMl = prefs.getInt(_keyIntake) ?? 0;
      final hist = prefs.getString(_keyHistory);
      if (hist != null && hist.isNotEmpty) {
        _todayHistory.clear();
        for (final s in hist.split(',')) {
          final v = int.tryParse(s);
          if (v != null) _todayHistory.add(v);
        }
      }
    }
    _loaded = true;
    notifyListeners();
  }

  String _today() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyIntake, _currentMl);
    await prefs.setString(_keyLastDate, _lastDate);
    await prefs.setInt(_keyGoal, _goalMl);
    await prefs.setString(_keyHistory, _todayHistory.join(','));
  }

  Future<void> checkDailyReset() async {
    final today = _today();
    if (_lastDate != today) {
      _lastDate = today;
      _currentMl = 0;
      _todayHistory.clear();
      await _save();
      notifyListeners();
    }
  }

  Future<void> addWater([int ml = glassMl]) async {
    await checkDailyReset();
    _currentMl += ml;
    _todayHistory.add(ml);
    await _save();
    notifyListeners();
  }

  Future<void> setGoal(int ml) async {
    if (ml < 100) return;
    _goalMl = ml;
    await _save();
    notifyListeners();
  }
}
