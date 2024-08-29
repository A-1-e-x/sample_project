import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogbox extends StatefulWidget {
  const Dialogbox({super.key});

  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String _selectedPriority = 'High';

  final List<String> _dropdownItems = ['High', 'Medium', 'Low'];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 229, 212, 255), 
      title: Text(
        'Create New Task'.tr,
        style: TextStyle(color: Colors.black), 
      ),
      content: SizedBox(
        height: 500,
        width: 410,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: taskNameController,
              style: TextStyle(color: Colors.black), 
              decoration: InputDecoration(
                hintText: 'Enter task name'.tr,
                hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 220, 191, 255)), 
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: _selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Priority'.tr,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 220, 191, 255)),
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
              dropdownColor: Color.fromARGB(255, 220, 191, 255), 
              style: TextStyle(color: Colors.black), 
              items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black), 
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Date'.tr,
                  labelStyle: TextStyle(color: Colors.black), 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 220, 191, 255)), 
                  ),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'No date selected'.tr
                      : '${_selectedDate!.toLocal()}'.split(' ')[0],
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Time'.tr,
                  labelStyle: TextStyle(color: Colors.black), 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 220, 191, 255)), 
                  ),
                ),
                child: Text(
                  _selectedTime == null
                      ? 'No time selected'.tr
                      : _selectedTime!.format(context),
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: Colors.black), 
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Enter the description'.tr,
                hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 220, 191, 255)), 
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'taskName': taskNameController.text,
                      'priority': _selectedPriority,
                      'description': descriptionController.text,
                      'date': _selectedDate?.toIso8601String(),
                      'time': _selectedTime != null
                          ? DateTime(2000, 1, 1, _selectedTime!.hour, _selectedTime!.minute).toIso8601String()
                          : null,
                    });
                  },
                  child: Text('Save'.tr),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 241, 234, 255)), 
                    foregroundColor: MaterialStateProperty.all(Colors.black), 
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'.tr),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 241, 234, 255)), 
                    foregroundColor: MaterialStateProperty.all(Colors.black), 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
