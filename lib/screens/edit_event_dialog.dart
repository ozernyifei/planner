// ignore_for_file: library_private_types_in_public_api

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

  // TODO(lebowskd): add check startDate <= endDate 

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
              // Поле ввода для названия задачи
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              const SizedBox(height: 10,),
              // Поле ввода для описания задачи
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              const SizedBox(height: 10,),
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
                    //locale: const Locale('ru'),
                  );

                  if (pickedDate != null ) {
                    // Выбор времени
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 12, minute: 0),
                      // locale: const Locale('ru', 'RU')
                    );

                    if (pickedTime != null) {
                      // Объединение даты и времени
                      final selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      // Сохранение неформатированной даты в переменной
                      final unformattedDateString = selectedDateTime.toIso8601String();

                      // Форматирование даты и времени для отображения
                      final formattedDateTimeString = DateFormat('dd MMMM yyyy HH:mm', 'ru').format(selectedDateTime);

      // Отображение выбранной даты и времени
                      setState(() {
                        _startDateController.text = formattedDateTimeString;
                      });
                    }
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата начала события'),
              ),
              // Поле ввода для даты выполнения
              const SizedBox(height: 10,),
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
                    //locale: const Locale('ru'),
                  );

                  if (pickedDate != null ) {
                    // Выбор времени
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 12, minute: 0),
                      // locale: const Locale('ru', 'RU')
                    );

                    if (pickedTime != null) {
                      // Объединение даты и времени
                      final selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      // Сохранение неформатированной даты в переменной
                      final unformattedDateString = selectedDateTime.toIso8601String();

                      // Форматирование даты и времени для отображения
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
                    const SizedBox(width: 8), // Add some space between checkbox and label
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
