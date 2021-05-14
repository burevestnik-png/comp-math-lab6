import 'package:comp_math_lab6/internal/dependencies.dart';
import 'package:comp_math_lab6/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  GlobalBindings().dependencies();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab work',
      theme: ThemeData.light(),
      initialRoute: MainScreen.id,
      getPages: [
        GetPage(
            name: MainScreen.id,
            page: () => MainScreen(),
            transition: Transition.noTransition),
      ],
    );
  }
}
