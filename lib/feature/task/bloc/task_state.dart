import 'package:equatable/equatable.dart';

class Task{
  final int id;
  final String title;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TaskState extends Equatable {
  final List<Task> tasks;
  const TaskState({this.tasks = const []});

  @override
  List<Object> get props => [tasks];
}