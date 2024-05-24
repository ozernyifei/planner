import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {

  const CustomTag({
    super.key,
    required this.text,
    required this.color,
    required this.onDelete,
  });
  final String text;
  final Color color;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CircleAvatar for background color
          CircleAvatar(
            radius: 5,
            backgroundColor: color,
          ),
          const SizedBox(width: 7),
          // Text for tag name
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          //const SizedBox(width: 1),
          // IconButton for deletion
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 12,
            onPressed: onDelete,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}