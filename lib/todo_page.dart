import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_cubit.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List😘'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<TodoCubit>().addTask(controller.text);
                    controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoCubit, List<TodoItem>>(
              builder: (context, tasks) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('wake up and add task to do'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final todo = tasks[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) {
                          context.read<TodoCubit>().toggleTask(index);
                        },
                      ),
                      title: Text(
                        todo.task,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todo.isCompleted
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoCubit>().removeTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}