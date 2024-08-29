import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/alertdialog.dart';
import 'package:sample_project/drawer.dart';
import 'package:sample_project/todo_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> _tasks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> createNewTask() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Dialogbox();
      },
    );

    if (result != null) {
      final taskName = result['taskName'] ?? '';
      final priority = result['priority'] ?? 'High';
      final description = result['description'] ?? '';
      final date = result['date'] != null ? DateTime.tryParse(result['date']) : null;
      final time = result['time'] != null
          ? TimeOfDay.fromDateTime(DateTime.tryParse(result['time']) ?? DateTime.now())
          : null;

      if (taskName.isNotEmpty) {
        setState(() {
          _tasks.add({
            'taskName': taskName,
            'priority': priority,
            'description': description,
            'completed': false,
            'date': date?.toIso8601String(),
            'time': time != null
                ? DateTime(2000, 1, 1, time.hour, time.minute).toIso8601String()
                : null,
          });
        });
        _saveTasks();
      }
    }
  }

  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      _tasks[index]['completed'] = value ?? false;
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final taskList = _tasks.map((task) => jsonEncode(task)).toList();
      await prefs.setStringList('tasks', taskList);
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final taskList = prefs.getStringList('tasks') ?? [];
      setState(() {
        _tasks.clear();
        for (final taskStr in taskList) {
          final task = jsonDecode(taskStr) as Map<String, dynamic>;
          _tasks.add(task);
        }
      });
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  List<Map<String, dynamic>> get _filteredTasks {
    if (_searchQuery.isEmpty) {
      return _tasks;
    } else {
      return _tasks.where((task) {
        final taskName = task['taskName']?.toLowerCase() ?? '';
        return taskName.contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  void _editTask(int index, String taskName, String description, DateTime? date,
      TimeOfDay? time, String priority) {
    setState(() {
      _tasks[index] = {
        'taskName': taskName,
        'priority': priority,
        'description': description,
        'completed': _tasks[index]['completed'],
        'date': date?.toIso8601String(),
        'time': time != null
            ? DateTime(2000, 1, 1, time.hour, time.minute).toIso8601String()
            : null,
      };
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 234, 255), 
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 178, 96, 250), 
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              '/LOGRO.png',
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8),
            Text(
              'LoGrO',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Color.fromARGB(255, 220, 191, 255), 
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: searchbox(),
            ),
            Expanded(
              child: _filteredTasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks available'.tr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 62, 0, 116), 
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = _filteredTasks[index];
                        return TodoTile(
                          taskName: task['taskName'] ?? '',
                          taskCompleted: task['completed'] ?? false,
                          description: task['description'] ?? '',
                          taskDate: task['date'] != null
                              ? DateTime.tryParse(task['date'])
                              : null,
                          taskTime: task['time'] != null
                              ? TimeOfDay.fromDateTime(
                                  DateTime.tryParse(task['time']) ?? DateTime.now())
                              : null,
                          onChanged: (value) {
                            _toggleTaskCompletion(index, value);
                          },
                          onDelete: () {
                            _deleteTask(index);
                          },
                          priority: task['priority'] ?? 'High',
                          onEdit: (taskName, description, date, time, priority) {
                            _editTask(index, taskName, description, date, time, priority);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }

  Widget searchbox() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 229, 212, 255), 
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 25, minWidth: 35),
          border: InputBorder.none,
          hintText: "Search".tr,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
