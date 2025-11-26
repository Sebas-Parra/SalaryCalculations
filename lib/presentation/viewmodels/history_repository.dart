import 'package:flutter/foundation.dart';
import '../../domain/entities/result_employee.dart';

class HistoryRepository extends ChangeNotifier {
  final List<ResultEmployee> _history = [];

  List<ResultEmployee> get history => List.unmodifiable(_history);

  void add(ResultEmployee item) {
    _history.insert(0, item);
    notifyListeners();
  }

  void clear() {
    _history.clear();
    notifyListeners();
  }
}
