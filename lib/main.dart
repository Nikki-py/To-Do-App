import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_task_screen.dart';

import 'task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 201, 224),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 131, 22, 76),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 254, 48, 113),
          brightness: Brightness.dark,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (states) => const Color.fromARGB(255, 254, 48, 113),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 254, 48, 113),
          foregroundColor: Colors.black87,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 104, 23, 62),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text("No tasks yet", style: TextStyle(fontSize: 20, color: Colors.black87)),
            )
          : ListView.builder(
              itemCount: tasks.length, //how many items to build
              itemBuilder:
                  (context, index) //builds one row at a time
                  {
                    final task = tasks[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CheckboxListTile(
                        tileColor: Colors.transparent,
                        secondary: IconButton(
                          icon: const Icon(Icons.remove, color: Colors.red),
                          onPressed: () {
                            _confirmdelete(index);
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isdone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.black,
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                        value: task.isdone,
                        onChanged: (bool? checked) {
                          setState(() {
                            task.isdone = checked ?? false;
                          });
                        },
                      ),
                    );
                  },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AddTaskScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
            ),
          );
          if (newTask != null && newTask.isNotEmpty) {
            setState(() {
              tasks.add(Task(title: newTask));
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmdelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: Text(
            'Are you sure you want to delete "${tasks[index].title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
