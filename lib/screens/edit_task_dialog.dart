// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/tag.dart';
import 'package:planner/models/task.dart';
import 'package:planner/widgets/custom_multi_dropdown_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EditTaskScreen extends StatefulWidget {

  const EditTaskScreen({super.key, this.task}); 
  final Task? task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
  
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  bool _isCreatingNewTask = true;
  double _buttonPaddingSize = 120;
  int _selectedPriorityId = 1;
  int _selectedStatusId = 1;
  // int _selectedUrgentId = 1;
  String _selectedUrgent = 'Низкая';
  String _selectedPriority = 'Низкий';
  String _selectedStatus = 'Низкий';
  var unformattedDateString = '';
  
  final List<String> _priorityOptions = ['Низкий', 'Средний', 'Высокий'];
  List<Tag> _selectedTags = []; // Or List<Tag> if using Tag class
  final List<String> _urgentOptions = ['Низкая', 'Средняя', 'Высокая'];
  final List<String> _statusOptions = ['Низкий', 'Средний', 'Высокий'];
  final _predefinedTags = [
    Tag(id: 1, title: 'Учеба', color: Colors.black.value),
    Tag(id: 2, title: 'Здоровье', color: Colors.green.value),
    Tag(id: 3, title: 'Работа', color: Colors.amber.value),
  ];
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
      if (widget.task != null && widget.task!.dueDate != null) {
        
        unformattedDateString = widget.task!.dueDate!.toIso8601String();
        
        _dueDateController.text = convertIso8601String(unformattedDateString);
      } else {
        // Handle the case where dueDate is null (e.g., set default text)
        _dueDateController.text = ''; // Or set a placeholder text
        unformattedDateString = '';
      }                                                                                 
      _selectedPriorityId = widget.task!.priorityId;
      _selectedStatusId = widget.task!.statusId;
      // _selectedUrgentId = widget.task!.ur
      _buttonPaddingSize = 40;
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
        final userId = result.first['id']! as int;
        final task = widget.task ?? Task(
          title: '',
          priorityId: _selectedPriorityId, 
          statusId: _selectedStatusId, 
          userId: userId, 
        );
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
        final statusId = statusIdMap[_selectedStatus]!;
        final priorityId = priorityIdMap[_selectedPriority]!;

        task.statusId = statusId;
        task.priorityId = priorityId;
        task.title = _titleController.text;
        task.description = _descriptionController.text;
        task.dueDate = _dueDateController.text.isEmpty
        ? null
        : DateTime.parse(unformattedDateString); 
              // Collect selected tags (assuming _selectedTags is a List<String>)
        task.tags = _selectedTags;
        if (task.title.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Введите название задачи'))); // Display SnackBar
          }
         return; // Exit the function if title is empty
        }
        print(task.title);
        if (_isCreatingNewTask) {
          await task.addTaskToDatabase(database);
        }
        else {
          await database.update(
            'task',
            task.toMap(),
            where: 'id = ?',
            whereArgs: [task.id],
          );
        }
        await database.close();

        
        if (mounted) {
          Navigator.pop(context, task);
        }
      } else {
        // TODO(lebowskd):
        //  Handle the case where user ID cannot be found in SQLite
        // (e.g., show an error message or prevent saving)
      }
    } else {
      // Handle the case where username is not found in SharedPreferences
      // (e.g., show an error message or prevent saving)
    }
  }

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
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              const SizedBox(height: 10), 
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              const SizedBox(height: 10), 
              TextField(
                controller: _dueDateController,
                readOnly: true, // Дата не редактируется вручную
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                    //locale: const Locale('ru'),
                  );
                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      // ignore: use_build_context_synchronously
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
                      unformattedDateString = selectedDateTime.toIso8601String();
                      final formattedDateTimeString = DateFormat('dd MMMM yyyy HH:mm', 'ru').format(selectedDateTime);
      
                      setState(() {
                        _dueDateController.text = formattedDateTimeString;
                      });
                    }
                  }
                },
                decoration: const InputDecoration(labelText: 'Дата выполнения'),
              ),
              const SizedBox(height: 10), 
              const Align(
                child: Text('Приоритет задачи'),
              ),
              const SizedBox(height: 10), // Add some spacing between label and radios
              Align(
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
              const Align(
                child: Text('Срочность задачи'),
              ),
              const SizedBox(height: 10), // Add some spacing between label and radios
              Align(
                child: DropdownButton<String>(
                  value: _selectedUrgent,
                  items: _urgentOptions.map((value) {
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
                      _selectedUrgent = newValue!;
                    });
                  },
                ),
              ),
              Visibility(
                // visible: !_isCreatingNewTask,
                visible: !true,
                child: Column(
                  children: [
                    const SizedBox(height: 10), 
                    const Align(
                      child: Text('Статус задачи'),
                    ),
                    const SizedBox(height: 10), // Add some spacing between label and radios
                    // Status Dropdown
                  Align(
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
              // const Align(
              //         alignment: Alignment.center,
              //         child: Text('Теги'),
              //       ),
              const SizedBox(height: 20),
              CustomMultiDropdownList(
                tags: _predefinedTags.toList(), // List of all tags (from map keys)
                selectedTags: _selectedTags, // List of pre-selected tags
                onSelected: (selectedTags) => setState(() {
                  _selectedTags = selectedTags;
                }),
              ),


              // Кнопка сохранения задачи
              SizedBox(height: _buttonPaddingSize), 
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
  String convertIso8601String(String iso8601String) {
  // Parse the ISO 8601 string as a DateTime object
  final dateTime = DateTime.parse(iso8601String);

  // Format the DateTime object into the desired new format
  final formattedDateString = DateFormat('dd MMMM yyyy HH:mm', 'ru').format(dateTime);

  return formattedDateString;
}
}
