import Employee.EmployeeManager;
import Model.Employee;

public class Main {
    public static void main(String[] args) {
        EmployeeManager manager = new EmployeeManager(5);

        manager.addEmployee(new Employee("E001", "John", "Developer", 75000));
        manager.addEmployee(new Employee("E002", "Jane", "Manager", 95000));
        manager.addEmployee(new Employee("E003", "Bob", "Analyst", 60000));

        System.out.println("Employee List:");
        manager.displayEmployees();

        Employee found = manager.searchEmployee("E002");
        if (found != null) {
            System.out.println("\nSearch result: " + found);
        }

        manager.deleteEmployee("E001");

        System.out.println("\nAfter deletion:");
        manager.displayEmployees();
    }
}
