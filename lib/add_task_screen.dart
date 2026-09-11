import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTask();
}

class _AddTask extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController(); //how flutter reads/manages what the user types into a textfield

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                labelText: "Task Name",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 136, 134, 134),
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text("Save", style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}
