// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import '../classes/db_helper.dart';
import '../models/task.dart'; 

class EditTaskScreen extends StatefulWidget { 
  const EditTaskScreen({super.key, this.task});

  factory EditTaskScreen.create() {
    return const EditTaskScreen();
  }

  final Task? task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
  
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  int _selectedPriority = 1;
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
      _selectedPriority = widget.task!.priorityId;
    }
  }

  // Сохранение задачи
  Future<void> _saveTask() async {
    final dbHelper = DbHelper();
    final database =  await dbHelper.database;
    
    
    final task = widget.task ?? Task(
      title: '',
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
    await database.close();
    if (mounted) {
      Navigator.pop(context);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задача'),
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
                maxLines: 2,
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
                decoration: const InputDecoration(labelText: 'Дата выполнения'),
              ),
              Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const Text('Низкий'),
                Radio(
                  value: 2,
                  groupValue: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const Text('Средний'),
                Radio(
                  value: 3,
                  groupValue: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const Text('Высокий'),
              ],
            ),
              const TextField(),
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
