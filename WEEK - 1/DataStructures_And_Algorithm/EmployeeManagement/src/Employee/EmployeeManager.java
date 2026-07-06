package Employee;

import Model.Employee;

public class EmployeeManager {
    Employee[] employees;
    int count;

    public EmployeeManager(int size) {
        employees = new Employee[size];
        count = 0;
    }

    public void addEmployee(Employee emp) {
        if (count < employees.length) {
            employees[count] = emp;
            count++;
        } else {
            System.out.println("Array is full");
        }
    }

    public Employee searchEmployee(String id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].getEmployeeId().equals(id)) {
                return employees[i];
            }
        }
        return null;
    }

    public void displayEmployees() {
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    public void deleteEmployee(String id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].getEmployeeId().equals(id)) {
                for (int j = i; j < count - 1; j++) {
                    employees[j] = employees[j + 1];
                }
                count--;
                System.out.println("Employee deleted");
                return;
            }
        }
        System.out.println("Employee not found");
    }
}
