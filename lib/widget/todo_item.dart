import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final void Function(ToDo) onToDoChanged;
  final VoidCallback onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => onToDoChanged(todo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: _buildCheckIcon(),
        title: _buildTitleText(),
        trailing: _buildDeleteButton(),
      ),
    );
  }

  /// Builds the checkbox icon
  Widget _buildCheckIcon() {
    return Icon(
      todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
      color: tdBlue,
    );
  }

  /// Builds the task title with styling
  Widget _buildTitleText() {
    return Text(
      todo.todoText ?? "",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: tdBlack,
        decoration: todo.isDone ? TextDecoration.lineThrough : null,
      ),
    );
  }

  /// Builds the delete button
  Widget _buildDeleteButton() {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: tdRed,
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        icon: const Icon(Icons.delete, size: 18, color: Colors.white),
        onPressed: onDeleteItem,
      ),
    );
  }
}
