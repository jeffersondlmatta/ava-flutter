import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tasks_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendário"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CalendarDatePicker(
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            initialDate: selected,
            onDateChanged: (date) {
              setState(() => selected = date);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TasksScreen(selectedDate: selected)),
              );
            },
            child: Text("Ver tarefas de ${DateFormat('dd/MM/yyyy').format(selected)}"),
          ),
        ],
      ),
    );
  }
}
