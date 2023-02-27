import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qazu/admin_account.dart';
import 'package:qazu/db/account_model.dart';
import 'package:qazu/db/models/user_model.dart';
import 'package:qazu/login.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:qazu/prof/add_quiz.dart';

Future<void> main() async {
  // initialize Hive
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // register the adapter
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('mydb');
  await Hive.openBox('accounts');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const AddQuizPage());
  }
}
