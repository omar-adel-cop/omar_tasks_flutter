import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItem {
  final String task;
  final bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});

  TodoItem copyWith({String? task, bool? isCompleted}) {
    return TodoItem(
      task: task ?? this.task,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoCubit extends Cubit<List<TodoItem>> {
  TodoCubit() : super(const []);

  void addTask(String task) {
    if (task.trim().isEmpty) return;
    emit([...state, TodoItem(task: task.trim())]);
  }

  void removeTask(int index) {
    final updated = List<TodoItem>.from(state)..removeAt(index);
    emit(updated);
  }

  void toggleTask(int index) {
    final updated = List<TodoItem>.from(state);
    updated[index] = updated[index].copyWith(
      isCompleted: !updated[index].isCompleted,
    );
    emit(updated);
  }
}
