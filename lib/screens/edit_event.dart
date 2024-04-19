import 'package:flutter/material.dart';

// Примеры импортов для работы с базой данных и моделями
import 'package:sqflite/sqflite.dart';
import '../models/task.dart'; // Модель задачи

class EditTaskScreen extends StatefulWidget {
  final Task? task; // Передаваемая задача (null - новая задача)

  const EditTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
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
      _descriptionController.text = widget.task!.description;
      _dueDateController.text = widget.task!.dueDate.toIso8601String();
    }
  }

  // Сохранение задачи
  void _saveTask() async {
    // ... логика сохранения задачи в базе данных
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать/Редактировать задачу'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Поле ввода для названия задачи
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Название'),
              ),
              // Поле ввода для описания задачи
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 5,
              ),
              // Поле ввода для даты выполнения
              TextField(
                controller: _dueDateController,
                readOnly: true, // Дата не редактируется вручную
                onTap: () async {
                  // Открытие календаря для выбора даты
                  DateTime? pickedDate = await showDatePicker(
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
                decoration: InputDecoration(labelText: 'Дата выполнения'),
              ),
              // Кнопка сохранения задачи
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
