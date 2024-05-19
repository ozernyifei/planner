// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart';
import 'package:planner/widgets/custom_tag.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EditTaskScreen extends StatefulWidget {

  const EditTaskScreen({super.key, this.task}); 

  final Task? task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
  
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  bool _isCreatingNewTask = true;

  int _selectedPriorityId = 1;
  int _selectedStatusId = 1;
  String _selectedPriority = 'Низкий';
  String _selectedStatus = 'Низкий';
  
  final List<String> _priorityOptions = ['Низкий', 'Средний', 'Высокий'];
  List<String> _selectedTags = []; // Or List<Tag> if using Tag class
  
  final List<String> _statusOptions = ['Низкий', 'Средний', 'Высокий'];
  final _predefinedTags = {
    'Учеба': Colors.black, // Black for "учеба"
    'Здоровье': Colors.green, // Green for "здоровье"
    'Работа': Colors.amber, // Amber for "работа"
  };
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
      _selectedPriorityId = widget.task!.priorityId;
      _selectedStatusId = widget.task!.statusId;
    }                             
  }                                                   

  // Сохранение задачи
  Future<void> _saveTask() async {
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

        // Proceed with saving the task
        final task = widget.task ?? Task(
          title: '',
          priorityId: _selectedPriorityId, 
          statusId: _selectedStatusId, 
          userId: userId, // Add userId here
        );
            // Map status and priority names to their corresponding IDs
        final statusIdMap = {
          'Низкий': 1,
          'Средний': 2,
          'Высокий': 3,
        };
        final priorityIdMap = {
          'Низкий': 1,
          'Средний': 2,
          'Высокий': 3,
        };

        // Convert status and priority names to IDs using the maps
        final statusId = statusIdMap[_selectedStatus]!;
        final priorityId = priorityIdMap[_selectedPriority]!;

        // Update the task object with IDs
        task.statusId = statusId;
        task.priorityId = priorityId;
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
        //TODO(lebowskd):
        //  Handle the case where user ID cannot be found in SQLite
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
                alignment: Alignment.center,
                child: Text('Приоритет задачи'),
              ),
              const SizedBox(height: 10), // Add some spacing between label and radios
              Align(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: _selectedPriority,
                  items: _priorityOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14) 
                        ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                ),
              ),
              Visibility(
                // visible: !_isCreatingNewTask,
                visible: true,
                child: Column(
                  children: [
                    const SizedBox(height: 10), 
                    const Align(
                      alignment: Alignment.center,
                      child: Text('Статус задачи'),
                    ),
                    const SizedBox(height: 10), // Add some spacing between label and radios
                    // Status Dropdown
                  Align(
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value: _selectedStatus,
                      items: _statusOptions.map((value) {
                        return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14) 
                        ),
                    );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedStatus = newValue!;
                        });
                      },
                    ),
                  ),
                  ],
                ),
              ),
              const Align(
                      alignment: Alignment.center,
                      child: Text('Теги'),
                    ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 500,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10, // Adjust vertical spacing between rows as needed
                  children: [
                    // Predefined tags
                    ..._predefinedTags.entries.map((entry) => CustomTag(
                      text: entry.key,
                      color: entry.value,
                      onDelete: () {
                        setState(() {
                          _selectedTags.remove(entry.key);
                        });
                      },
                    )),
                    // Selected tags
                    ..._selectedTags.map((tag) => CustomTag(
                    text: tag,
                    color: Colors.blue,
                    onDelete: () {
                      setState(() {
                        _selectedTags.remove(tag);
                      });
                    },
                   )),

                    // Add new tag
                    CustomTag(
                      text: 'Добавить',
                      color: Colors.grey[200]!,
                      onDelete: () {
                        // Implement logic to add a new tag
                      },
                    ),
                  ],
                ),
              ),

              
              // Tag Selection


              // Кнопка сохранения задачи
              const SizedBox(height: 40), 
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
