// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEventScreen extends StatefulWidget { 
  const EditEventScreen({super.key, this.event});
  final Event? event;

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {

  bool _isCreatingNewEvent = true;
  bool _isAllDay = false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String? startDateTime;
  String? endDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _isCreatingNewEvent = true;
      _titleController.text = widget.event!.title;
      _startDateController.text = widget.event!.startDate.toIso8601String();
      _endDateController.text = widget.event!.endDate.toIso8601String();
    }
  }

  Future<void> _saveEvent() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username != null) {
      final dbHelper = DbHelper();
      final database = await dbHelper.database;
      final result = await database.query('user_data',
          where: 'username = ?',
          whereArgs: [username],
          limit: 1);
      if (result.isNotEmpty) {
        // User ID found in SQLite database
        final userId = result.first['id']! as int;
        if (_startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty) {
          final startDate = DateTime.parse(_startDateController.text);
          final endDate = DateTime.parse(_endDateController.text);
          if (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
            if (_titleController.text.isNotEmpty) {
              await database.insert('event', {
                'userId': userId,
                'title': _titleController.text,
                'description': _descriptionController.text,
                'startDate': startDate.toIso8601String(),
                'endDate': endDate.toIso8601String(),
                'isAllDay': _isAllDay ? 1 : 0, // Convert bool to int for database
              });
            }
            else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Название события не может быть пустым'),
                  backgroundColor: Colors.red,
                  ),
                );
              }
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Начало события не должно быть раньше его конца'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          _isCreatingNewEvent ? 'Создать событие' : 'Изменить событие'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _startDateController,
                readOnly: true, 
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null ) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 12, minute: 0),
                    );

                    if (pickedTime != null) {
                      final selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      startDateTime = selectedDateTime.toIso8601String();
                      final formattedDateTimeString = DateFormat('dd MMMM yyyy HH:mm', 'ru').format(selectedDateTime);
                      setState(() {
                        _startDateController.text = formattedDateTimeString;
                      });
                    }
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата начала события'),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _endDateController,
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null ) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 12, minute: 0),
                    );

                    if (pickedTime != null) {
                      final selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      endDateTime = selectedDateTime.toIso8601String();
                      final formattedDateTimeString = DateFormat('dd MMMM yyyy HH:mm', 'ru').format(selectedDateTime);

      // Отображение выбранной даты и времени
                      setState(() {
                        _endDateController.text = formattedDateTimeString;
                      });
                    }
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата окончания события'),
              ),
              const SizedBox(height: 10,),
                Row(              
                  children: [
                    const Text('Весь день'), // Label text
                    const SizedBox(width: 8), 
                    Checkbox(value: _isAllDay,
                      onChanged: (newValue) {
                       setState(() {
                        _isAllDay = newValue!;
                        }
                       );
                     },
                    ), // Checkbox
                  ],
                ),
                const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveEvent,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
