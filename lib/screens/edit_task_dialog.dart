// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
class EditTaskScreen extends StatefulWidget {

  const EditTaskScreen({super.key, this.task}); 

  final Task? task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
  
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  bool _isCreatingNewTask = true;

  int _selectedPriority = 1;
  int _selectedStatus = 1;
  // Контроллеры для полей ввода
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();




  // Инициализация состояния
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _isCreatingNewTask = false;
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description!;
      _dueDateController.text = widget.task!.dueDate!.toIso8601String();
      _selectedPriority = widget.task!.priorityId;
    }
  }

  // Сохранение задачи
  Future<void> _saveTask() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');


    if (username != null) {
    // Look up user ID in SQLite database based on username
      final dbHelper = DbHelper();
      final database = await dbHelper.database;

      final result = await database.query('user_data',
          where: 'username = ?',
          whereArgs: [username],
          limit: 1);
      if (result.isNotEmpty) {
        // User ID found in SQLite database
        final userId = result.first['id']! as int;

        // Proceed with saving the task
        final task = widget.task ?? Task(
          title: '',
          priorityId: _selectedPriority, // Example default priority
          statusId: _selectedStatus, // Example default status
          userId: userId, // Add userId here
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
      } else {
        // Handle the case where user ID cannot be found in SQLite
        // (e.g., show an error message or prevent saving)
      }
    } else {
      // Handle the case where username is not found in SharedPreferences
      // (e.g., show an error message or prevent saving)
    }
  }

  //TODO(lebowskd): 
  // 'id': id,
  //     'title': title, check
  //     'description': description, check
  //     'dueDate': dueDate?.toIso8601String(), check
  //     'user_id': userId, 
  //     'priorityId': priorityId,  check
  //     'statusId': statusId,
  //     'tagId': tagId,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isCreatingNewTask ? 'Создать задачу' : 'Изменить задачу'),
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
              const SizedBox(height: 10), 
              // Поле ввода для описания задачи
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 2,
              ),
              const SizedBox(height: 10), 
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
              const SizedBox(height: 10), 
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Приоритет задачи'),
              ),
              const SizedBox(height: 10), // Add some spacing between label and radios
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
            Visibility(
              visible: !_isCreatingNewTask,
              child: Column(
                children: [
                  const SizedBox(height: 10), 
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Срочность задачи'),
                  ),
                  const SizedBox(height: 10), // Add some spacing between label and radios
                  Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                    const Text('Низкий'),
                    Radio(
                      value: 2,
                      groupValue: _selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                    const Text('Средний'),
                    Radio(
                      value: 3,
                      groupValue: _selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                    const Text('Высокий'),
                  ],
                              ),
                ],
              ),
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
