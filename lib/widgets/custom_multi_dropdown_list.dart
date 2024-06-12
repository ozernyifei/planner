import 'package:flutter/material.dart';

class CustomMultiDropdownList extends StatefulWidget { // Callback for selected tags

  const CustomMultiDropdownList({
    super.key,
    required this.tags,
    this.selectedTags = const [],
    required this.onSelected,
  });
  final List<String> tags; // List of all available tags
  final List<String> selectedTags; // Pre-selected tags (optional)
  final Function(List<String>) onSelected;

  @override
  State<CustomMultiDropdownList> createState() => _CustomMultiDropdownListState();
}

class _CustomMultiDropdownListState extends State<CustomMultiDropdownList> {
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _selectedTags = widget.selectedTags.toList();
  }

  void _onItemSelected(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
    widget.onSelected(_selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: const Text('Select Tags'),
      isExpanded: true, // Occupy full width
      icon: const Icon(Icons.add),
      items: widget.tags
          .map((tag) => DropdownMenuItem<String>(
                value: tag,
                child: Text(tag),
              ))
          .toList(),
      onChanged: (tag) => _onItemSelected(tag!),
      selectedItemBuilder: (context) => _selectedTags.isEmpty
        ? const [] // Return an empty list if no tags selected
        : [_buildSelectedTags(context)], // Return the list of chips otherwise

    );
  }

  Widget _buildSelectedTags(BuildContext context) {
    final selectedTagsText = _selectedTags.join(', '); // Join tags with comma
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        selectedTagsText,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
