import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>((event, emit) {
      final updatedTask = [
        ...state.tasks,
        Task(id: DateTime.now().millisecondsSinceEpoch, title: event.title),
      ];
      emit(TaskState(tasks: updatedTask));
    });

    on<DeleteTaskEvent>((event, emit) {
      final updateTask = state.tasks
          .where((task) => task.id != event.id)
          .toList();

      emit(
        TaskState(tasks: updateTask)
      );
    });

    on<ToggleTaskEvent>((event,emit){
      final updateTasks = state.tasks.map((task){
        if(task.id == event.id){
          return task.copyWith(
            isCompleted: !task.isCompleted,
          );
        }
        return task;
      }).toList();
      emit(TaskState(tasks: updateTasks));
    });
  }
}
