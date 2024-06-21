import 'package:bookstore/Controller/SpalceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  SplacePage({Key? key}) : super(key: key);
  SplaceController sp = Get.find<SplaceController>();

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Lottie.asset('Assets/Animation/Anim1.json'),
      ),
    );
  }
}
