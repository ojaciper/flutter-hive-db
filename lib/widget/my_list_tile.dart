import 'package:flutter/material.dart';
import 'package:flutter_hive_db/constant/app_theme.dart';
import 'package:flutter_hive_db/model/task_model.dart';
import 'package:flutter_hive_db/screens/taak_editor.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatefulWidget {
  Task task;
  int index;
  MyListTile(this.task, this.index, {Key? key}) : super(key: key);
  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? null : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskEditor(
                          task: widget.task,
                        ),
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 2,
            // color: Colors.black87,
          ),
          Text(widget.task.note!),
        ],
      ),
    );
  }
}
