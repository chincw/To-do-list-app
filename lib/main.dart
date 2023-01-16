import 'package:flutter/material.dart';
import 'package:todo_list/storage/store_list.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init shared preferences local storage
  await StoreToDoList.init();
  runApp(const App());
}
