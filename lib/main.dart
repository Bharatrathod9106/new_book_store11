import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Controller/NavigationController.dart';
import 'package:bookstore/Controller/SpalceController.dart';
import 'package:bookstore/Controller/chatController.dart';
import 'package:bookstore/Pages/SplacePage/SplacePage.dart';
import 'package:bookstore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Config/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(SplaceController());
  Get.put(navigationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      title: 'E BOOK',
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // home: const welcomePage(),
      home: SplacePage(),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplacePage(), fenix: true);
    Get.lazyPut(() => BookController(), fenix: true);
    Get.lazyPut(() => navigationController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
  }
}
