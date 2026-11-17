import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent{
  final String title;
  const AddTaskEvent(this.title);
  @override
  List<Object> get props => [title];
}

class DeleteTaskEvent extends TaskEvent{
  final int id;
  const DeleteTaskEvent(this.id);
  @override

  List<Object> get props => [id];
}

class ToggleTaskEvent extends TaskEvent{
  final int id;
  const ToggleTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}