import 'package:flutter/material.dart';
import 'package:flutter_hive_db/constant/app_theme.dart';
import 'package:flutter_hive_db/model/task_model.dart';
import 'package:flutter_hive_db/screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TaskEditor extends StatefulWidget {
  Task? task;
  TaskEditor({Key? key, this.task}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context, listen: false);
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Switch.adaptive(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              final provider = Provider.of<AppTheme>(context, listen: false);

              provider.toggleTheme(value);
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? "Add new Task" : "Update your Task",
          // style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Task's Title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100.withAlpha(75),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Your Task"),
            ),
            const SizedBox(height: 40),
            const Text(
              "Your Task's Note",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                  // fillColor: Colors.blue.shade100.withAlpha(75),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Write some Note"),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                child: RawMaterialButton(
                    onPressed: () async {
                      var newTask = Task(
                        title: _taskTitle.text,
                        note: _taskNote.text,
                        creationDate: DateTime.now(),
                        done: false,
                      );
                      Box<Task> taskBox = Hive.box<Task>("Tasks");

                      if (widget.task != null) {
                        widget.task!.title = newTask.title;
                        widget.task!.note = newTask.note;
                        widget.task!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } else {
                        await taskBox.add(newTask);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      }
                    },
                    fillColor: Colors.blueAccent.shade700,
                    child: Text(
                      widget.task == null ? "Add new Task" : "Update Task",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
