package TaskList;

import Model.Task;

public class TaskLinkedList {
    private Node head;

    public void addTask(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
        } else {
            Node temp = head;
            while (temp.getNext() != null) {
                temp = temp.getNext();
            }
            temp.setNext(newNode);
        }
    }

    public Task searchTask(String id) {
        Node temp = head;
        while (temp != null) {
            if (temp.getTask().getTaskId().equals(id)) {
                return temp.getTask();
            }
            temp = temp.getNext();
        }
        return null;
    }

    public void displayTasks() {
        Node temp = head;
        while (temp != null) {
            System.out.println(temp.getTask());
            temp = temp.getNext();
        }
    }

    public void deleteTask(String id) {
        if (head == null) {
            return;
        }

        if (head.getTask().getTaskId().equals(id)) {
            head = head.getNext();
            return;
        }

        Node temp = head;
        while (temp.getNext() != null) {
            if (temp.getNext().getTask().getTaskId().equals(id)) {
                temp.setNext(temp.getNext().getNext());
                return;
            }
            temp = temp.getNext();
        }
    }
}
