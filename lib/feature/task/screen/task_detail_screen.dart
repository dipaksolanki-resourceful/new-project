import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailsScreen({
    super.key,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),

      body: Center(
        child: Text(
          'Task ID: $taskId',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}