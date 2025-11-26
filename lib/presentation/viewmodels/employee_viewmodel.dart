import 'package:flutter/material.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/result_employee.dart';
import '../../domain/usescases/compute_bonus.dart';
import 'history_repository.dart';

class EmployeeViewmodel extends ChangeNotifier{
    final CalculateBonusUseCase _calculateBonusUseCase;
    final HistoryRepository _historyRepository;
    
    EmployeeViewmodel(this._calculateBonusUseCase, {HistoryRepository? historyRepository})
      : _historyRepository = historyRepository ?? HistoryRepository();
    
    ResultEmployee? resultEmployee;

    List<ResultEmployee> get history => _historyRepository.history;

    void clearHistory() => _historyRepository.clear();


    ResultEmployee calculateBonus(String name, double salary, double yearsOfExperience){
        final employee = Employee(name: name, salary: salary, yearsOfExperience: yearsOfExperience);
        resultEmployee = _calculateBonusUseCase.execute(employee);
        _historyRepository.add(resultEmployee!);

        notifyListeners();
        return resultEmployee!;
    }
}