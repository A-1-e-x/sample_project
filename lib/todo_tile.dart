import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String description;
  final DateTime? taskDate;
  final TimeOfDay? taskTime;
  final Function(bool?)? onChanged;
  final VoidCallback onDelete;
  final String priority;
  final Function(String, String, DateTime?, TimeOfDay?, String)? onEdit;

  const TodoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.description,
    this.taskDate,
    this.taskTime,
    required this.onChanged,
    required this.onDelete,
    required this.priority,
    required this.onEdit,
  }) : super(key: key);

  String _formatDate(DateTime? date) {
    if (date == null) return 'No date set'.tr;
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'No time set'.tr;
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showEditDialog(BuildContext context) {
    final _nameController = TextEditingController(text: taskName);
    final _descriptionController = TextEditingController(text: description);
    DateTime? _selectedDate = taskDate;
    TimeOfDay? _selectedTime = taskTime;
    String _selectedPriority = priority;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Task Name'.tr),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'.tr),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Date'.tr),
                controller: TextEditingController(text: _formatDate(_selectedDate)),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    _selectedDate = selectedDate;
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'.tr),
                controller: TextEditingController(text: _formatTime(_selectedTime)),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    _selectedTime = selectedTime;
                  }
                },
              ),
              DropdownButton<String>(
                value: _selectedPriority,
                items: <String>['High', 'Medium', 'Low'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  _selectedPriority = newValue!;
                },
                isExpanded: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                if (onEdit != null) {
                  onEdit!(
                    _nameController.text,
                    _descriptionController.text,
                    _selectedDate,
                    _selectedTime,
                    _selectedPriority,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _formatDate(taskDate);
    final timeText = _formatTime(taskTime);
    Color priorityColor;

    switch (priority) {
      case 'High':
        priorityColor = Colors.red; 
        break;
      case 'Medium':
        priorityColor = Colors.orange; 
        break; 
      case 'Low':
        priorityColor = Colors.yellow; 
        break;
      default:
        priorityColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: priorityColor.withOpacity(0.2), 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () => _showEditDialog(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: Text(
                'Date: $dateText',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: Text(
                'Time: $timeText',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
