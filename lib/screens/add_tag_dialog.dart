// import 'package:flutter/material.dart';
// class AddTagDialog extends StatefulWidget {
//   const AddTagDialog({super.key});

//   @override
//   State<AddTagDialog> createState() => _AddTagDialogState();
// }

// class _AddTagDialogState extends State<AddTagDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _tagNameController = TextEditingController();
//   final _tagColorController = TextEditingController();
//   int _selectedColor = ;

//   @override
//   void dispose() {
//     _tagNameController.dispose();
//     _tagColorController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickColor() async {
//     Color color = await .pickColor(context);
//     setState(() {
//       _selectedColor = color.();
//     });
//     }

//   Future<void> _saveTag() async {
//     if (_formKey.currentState!.validate()) {
//       final tagName = _tagNameController.text;
//       final tagColor = _selectedColor;

      

//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Добавить тег'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _tagNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Название тега',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Введите название тега';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _tagColorController,
//                     decoration: const InputDecoration(
//                       labelText: 'Цвет тега (HEX)',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Введите цвет тега в формате HEX';
//                       }
//                       if (!value.startsWith('#')) {
//                         return 'Цвет должен начинаться с #';
//                       }
//                       if (value.length != 7) {
//                         return 'Неверный формат цвета HEX';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 InkWell(
//                   onTap: _pickColor,
//                   child: Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                       color: Color.('0xFF_selectedColor'),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Отмена'),
//         ),
//         TextButton(
//           onPressed: _saveTag,
//           child: const Text('Сохранить'),
//         ),
//       ],
//     );
//   }
// }
