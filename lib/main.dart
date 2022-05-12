import 'package:flutter/material.dart';
import 'package:flutter_hive_db/model/task_model.dart';
import 'package:flutter_hive_db/screens/home_screen.dart';

import 'package:hive_flutter/adapters.dart';

import 'constant/app_theme.dart';
import 'package:provider/provider.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("Tasks");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => AppTheme(),
        builder: (context, _) {
          final themeProvider = Provider.of<AppTheme>(context);

          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const HomePage(),
          );
        },
      );
}
