import 'package:flutter/material.dart';

class EventStat extends StatefulWidget { // Number of events to display

  const EventStat({super.key, required this.eventCount});
  final int eventCount;

  @override
  // ignore: library_private_types_in_public_api
  _EventStatState createState() => _EventStatState();
}

class _EventStatState extends State<EventStat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.eventCount == 0 ? Colors.white : Colors.grey[200],
      ),
      child: Column(
        children: [
          if (widget.eventCount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'There are ${widget.eventCount} events today.',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to event list screen (optional)
                    await Navigator.pushNamed(context, '/events'); // Replace '/events' with your actual route name
                  },
                  child: const Text('View Events'),
                ),
              ],
            ),
          if (widget.eventCount == 0)
            // const Text(
            //   "You don't have any upcoming events.",
            //   style: TextStyle(fontSize: 16),
            // ),
            const SizedBox(height: 0,),
        ],
      ),
    );
  }
}
