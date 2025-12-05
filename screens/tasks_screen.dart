import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  final DateTime selectedDate;

  const TasksScreen({super.key, required this.selectedDate});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final controller = TaskController();

  @override
  Widget build(BuildContext context) {
    final tasks = controller.getTasks(widget.selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas do Dia"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => _addTaskDialog(),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                "Nenhuma tarefa adicionada.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, i) {
                final task = tasks[i];
                return TaskItem(
                  task: task,
                  onToggle: () {
                    setState(() {
                      controller.toggleTask(task);
                    });
                  },
                  onDelete: () {
                    setState(() {
                      controller.removeTask(widget.selectedDate, task);
                    });
                  },
                );
              },
            ),
    );
  }

  void _addTaskDialog() {
    final textCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Tarefa"),
        content: TextField(
          controller: textCtrl,
          decoration: const InputDecoration(hintText: "Digite a tarefa"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                controller.addTask(widget.selectedDate, Task(title: textCtrl.text));
              });
              Navigator.pop(context);
            },
            child: const Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}
