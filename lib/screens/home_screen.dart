import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_hive_db/constant/app_theme.dart';
import 'package:flutter_hive_db/model/task_model.dart';
import 'package:flutter_hive_db/screens/taak_editor.dart';
import 'package:flutter_hive_db/widget/my_list_tile.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context);
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
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          'My Habits App',
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("Tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Task",
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  formatDate(DateTime.now(), [d, ", ", M, " ", yyyy]),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const Divider(height: 40, thickness: 2),
                Expanded(
                  child: ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return MyListTile(currentTask, index);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contex) => TaskEditor(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
