import 'package:flutter/material.dart';

class CustomMultiDropDownList extends StatefulWidget {

  const CustomMultiDropDownList({
    super.key,
    required this.title,
    required this.predefinedTags,
    required this.selectedTags,
    required this.onSelectionChanged,
  });
  final String title;
  final List<String> predefinedTags;
  final List<String> selectedTags;
  final Function(List<String>) onSelectionChanged;

  @override
  // ignore: library_private_types_in_public_api
  _CustomMultiDropDownListState createState() => _CustomMultiDropDownListState();
}

class _CustomMultiDropDownListState extends State<CustomMultiDropDownList> {
  final _selectedTags = <String>[];
   var _filter = '';

  @override
  void initState() {
    super.initState();
    _selectedTags.addAll(widget.selectedTags);
  }

  Future<void> _openDropdown() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Поиск'),
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.predefinedTags.length,
                itemBuilder: (context, index) {
                  final tag = widget.predefinedTags[index];
                  final isSelected = _selectedTags.contains(tag);
                  return ListTile(
                    title: Text(tag),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            _selectedTags.add(tag);
                          } else {
                            _selectedTags.remove(tag);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onSelectionChanged(_selectedTags);
            },
            child: const Text('Применить'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTagsString = _selectedTags.join(', ');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded( // Wrap content with Expanded
            child: Text(
              selectedTagsString.isEmpty ? '${widget.title}:' : '${widget.title}: $selectedTagsString',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: _openDropdown,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
