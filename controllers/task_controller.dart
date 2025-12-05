import '../models/task.dart';

class TaskController {
  final Map<String, List<Task>> tasksByDate = {};

  String _key(DateTime date) => "${date.year}-${date.month}-${date.day}";

  List<Task> getTasks(DateTime date) {
    final key = _key(date);
    final list = tasksByDate[key] ?? [];

    // Pendentes primeiro + ambas ordenadas alfabeticamente
    list.sort((a, b) {
      if (a.done == b.done) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }
      return a.done ? 1 : -1;
    });

    return list;
  }

  void addTask(DateTime date, Task task) {
    final key = _key(date);
    tasksByDate.putIfAbsent(key, () => []);
    tasksByDate[key]!.add(task);
  }

  void removeTask(DateTime date, Task task) {
    tasksByDate[_key(date)]?.remove(task);
  }

  void toggleTask(Task task) {
    task.done = !task.done;
  }
}
