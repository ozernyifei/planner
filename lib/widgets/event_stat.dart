import 'package:flutter/material.dart';

class EventStat extends StatelessWidget {

  const EventStat({super.key, required this.eventCount});
  final int eventCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1/3, // Take 1/3 of screen height
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: Colors.black26,
          width: 1.5
        )
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Сегодняшнее количество событий:',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            eventCount.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: eventCount == 0 ? Colors.green : Colors.blue,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            eventCount == 0 ? 'Нет запланированных событий' : 'У вас есть события',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to events screen here (replace with your logic)
            },
            child: const Text('Перейти к событиям'),
          ),
        ],
      ),
    );
  }
}
