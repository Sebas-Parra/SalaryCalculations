import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_clean_arquitecture/domain/usescases/compute_bonus.dart';
import 'package:pry_clean_arquitecture/presentation/viewmodels/employee_viewmodel.dart';
import 'package:pry_clean_arquitecture/presentation/widgets/button.dart';
import 'package:pry_clean_arquitecture/presentation/widgets/field_input.dart';
import 'package:pry_clean_arquitecture/presentation/widgets/field_text.dart';
import '../viewmodels/history_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final salary = TextEditingController();
    final yearsOfExperience = TextEditingController();

    final controller = Provider.of<EmployeeViewmodel>(context, listen: false);

    void _calculateBonus() {
      if (name.text.trim().isEmpty ||
          salary.text.trim().isEmpty ||
          yearsOfExperience.text.trim().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
        return;
      }

      final salaryVal = double.tryParse(salary.text);
      final yearsVal = double.tryParse(yearsOfExperience.text);

      if (salaryVal == null || yearsVal == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter valid numeric values for salary and years'),
          ),
        );
        return;
      }

      final result = controller.calculateBonus(
        name.text.trim(),
        salaryVal,
        yearsVal,
      );

      Navigator.pushNamed(context, '/result', arguments: result);
    }

    void _openHistory() {
      Navigator.pushNamed(context, '/history');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth:
                    400,
              ),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextImput(controller: name, label: 'Name'),
                      const SizedBox(height: 16),
                      TextImput(controller: salary, label: 'Salary'),
                      const SizedBox(height: 16),
                      TextImput(
                        controller: yearsOfExperience,
                        label: 'Years of Experience',
                      ),
                      const SizedBox(height: 24),
                      CalculateButton(onPressed: _calculateBonus),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _openHistory,
                        child: const Text('See History'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
