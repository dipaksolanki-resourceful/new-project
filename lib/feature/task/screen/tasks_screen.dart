import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final taskTitleController = TextEditingController();

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void addTask() {
    final title = taskTitleController.text.trim();
    if (title.isEmpty) return;
    context.read<TaskBloc>().add(AddTaskEvent(title));
    taskTitleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskTitleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                IconButton(onPressed: addTask, icon: const Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(

              builder: (context, state) {
                if (state.tasks.isEmpty) {
                  return Center(child: const Text("No Task available"));
                }
                
                return ListView.builder(itemCount: state.tasks.length
                ,itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task.title,style: TextStyle(

                      decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    )),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {

                        context.read<TaskBloc>().add(
                          ToggleTaskEvent(task.id),
                        );
                      },
                    ),
                    onTap: (){
                      context.push('/tasks/${task.id}');
                    },
                    trailing: IconButton(onPressed: (){
                      context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                    }, icon:  const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),),
                  );
                },);
              },
            ),
          ),
        ],
      ),
    );
  }
}
