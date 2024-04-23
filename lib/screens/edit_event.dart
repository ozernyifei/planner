// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import '../classes/db_helper.dart';
import '../models/task.dart'; 

class EditEventScreen extends StatefulWidget { 
  const EditEventScreen({super.key, this.task});
  final Task? task;

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  // Контроллеры для полей ввода
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();

  // Инициализация состояния
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description!;
      _dueDateController.text = widget.task!.dueDate!.toIso8601String();
    }
  }

  // Сохранение задачи
  Future<void> _saveTask() async {
    
    final task = widget.task ?? Task(
      id: 0, // New task has ID 0 initially
      title: '',
      description: '',
      dueDate: null,
      priorityId: 1, // Example default priority
      statusId: 1, // Example default status
    );

    // Update task properties from screen inputs
    task.title = _titleController.text;
    task.description = _descriptionController.text;
    task.dueDate = _dueDateController.text == null
        ? null
        : DateTime.parse(_dueDateController.text);

         await task.addTaskToDatabase(database);

    Navigator.pop(context);
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
              // Поле ввода для даты выполнения
              TextField(
                controller: _dueDateController,
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
                      _dueDateController.text = pickedDate.toIso8601String();
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата события'),
              ),
              // Кнопка сохранения задачи
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
