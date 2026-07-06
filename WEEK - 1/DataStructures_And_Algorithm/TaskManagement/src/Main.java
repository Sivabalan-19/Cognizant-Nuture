import Model.Task;
import TaskList.TaskLinkedList;

public class Main {
    public static void main(String[] args) {
        TaskLinkedList list = new TaskLinkedList();

        list.addTask(new Task("T001", "Design UI", "In Progress"));
        list.addTask(new Task("T002", "Write API", "Pending"));
        list.addTask(new Task("T003", "Run Tests", "Done"));

        System.out.println("Task List:");
        list.displayTasks();

        Task t = list.searchTask("T002");
        if (t != null) {
            System.out.println("\nFound: " + t);
        }

        list.deleteTask("T001");
        System.out.println("\nAfter delete:");
        list.displayTasks();
    }
}
