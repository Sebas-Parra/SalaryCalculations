import 'package:flutter/material.dart';
import '../views/result_page.dart';
import '../views/home_page.dart';
import '../views/history_page.dart';

class AppRoutes {
  static const home = '/';
  static const result = '/result';
  static const history = '/history';
  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
    // Dejar que ResultPage lea los argumentos desde ModalRoute,
    // así no se fuerza un tipo específico aquí.
    result: (_) => const ResultPage(),
    history: (_) => const HistoryPage(),
  };
}
