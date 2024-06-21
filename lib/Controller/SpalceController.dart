import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Auth/LoginScreen.dart';
import '../Pages/welcomePage.dart';

class SplaceController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splaceController();
  }

  void splaceController() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        Get.offAll(() => welcomePage());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }
}
