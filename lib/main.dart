import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodels/employee_viewmodel.dart';
import 'domain/usescases/compute_bonus.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/themes/general_themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EmployeeViewmodel(CalculateBonusUseCase()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonus Employee',
      debugShowCheckedModeBanner: false,
      theme: GeneralTheme.generalThemeLight,


      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
