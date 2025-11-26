import 'package:flutter/material.dart';
import 'package:pry_clean_arquitecture/domain/entities/result_employee.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! ResultEmployee) {
      return Scaffold(
        appBar: AppBar(title: const Text('Result')),
        body: const Center(child: Text('Invalid result data')),
      );
    }

    final ResultEmployee result = args;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee: ${result.name}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    Text('Salary: \$${result.salary.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),

                    Text('Bonus: \$${result.bonus.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),

                    Text('Final Salary: \$${result.finalSalary.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 24),

                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
