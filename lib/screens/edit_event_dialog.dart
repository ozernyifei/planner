// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
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

  bool _isCreatingNewEvent = false;
  // Контроллеры для полей ввода
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  //TODO(lebowskd):
  // int? id;
  // final String title;
  // final DateTime startDate;
  // final DateTime endDate;
  // final Color color;
  // final bool isAllDay;
  // final int userId;

  // Инициализация состояния
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

  // Сохранение задачи
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

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать/Редактировать событие'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Поле ввода для названия задачи
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              // Поле ввода для описания задачи
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 5,
              ),
              TextField(
                controller: _startDateController,
                readOnly: true, // Дата не редактируется вручную
                onTap: () async {
                  // Открытие календаря для выбора даты
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _endDateController.text = pickedDate.toIso8601String();
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата начала события'),
              ),
              // Поле ввода для даты выполнения
              TextField(
                controller: _endDateController,
                readOnly: true, // Дата не редактируется вручную
                onTap: () async {
                  // Открытие календаря для выбора даты
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _endDateController.text = pickedDate.toIso8601String();
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата окончания события'),
              ),
              // Кнопка сохранения задачи
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
