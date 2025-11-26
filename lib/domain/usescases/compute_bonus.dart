import '../entities/employee.dart';
import '../entities/result_employee.dart';

class CalculateBonusUseCase {
  ResultEmployee execute(Employee employee) {
    double bonus = 0;
    

    if (employee.salary < 500){
      if(employee.yearsOfExperience >= 10){
        bonus = employee.salary * 0.20;
      } else {
        bonus = employee.salary * 0.05;
      }
    }


    final finalSalary = employee.salary + bonus;
    final name = employee.name;
    final salary = employee.salary;

    return ResultEmployee(name: employee.name, salary: employee.salary, bonus: bonus, finalSalary: finalSalary);
  }
}