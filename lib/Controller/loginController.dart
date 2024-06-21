import 'dart:io';

import 'package:bookstore/Pages/Homepage/HomePage.dart';
import 'package:bookstore/Pages/welcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import '../Auth/LoginScreen.dart';
import '../Auth/utils.dart';
import '../Model/authmodel.dart';

class loginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
RxBool isObscure = true.obs;
  loginFunctio() async {
    try {
      loading(true);
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailController.text.toString())
          .get();

      if (userData.docs.isEmpty) {
        Fluttertoast.showToast(
          msg: 'NO DATA FOUND',
        );
        return;
      } else {
        await auth
            .signInWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString())
            .then((value) async {
          await FetchUserData();
          utils().toastMessage('Welcome To Novel Nest');
          Get.offAll(() => welcomePage());
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
          utils().toastMessage('Enter Correct Credentials');
        });
      }
    } finally {
      loading(false);
    }
  }

  //////////////////////////////
  TextEditingController SignupemailController = TextEditingController();
  TextEditingController Signuppassword = TextEditingController();
  TextEditingController SignupFullName = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Future<String> ProfilePictureUpdate(String documentId) async {
    try {
      if (selectedImage.value != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/$documentId.png');
        await storageReference.putFile(File(selectedImage.value!.path));
        String downloadUrl = await storageReference.getDownloadURL();
        return downloadUrl;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Signup() async {
    try {
      loading(true);

      await auth.createUserWithEmailAndPassword(
          email: SignupemailController.text.toString(),
          password: Signuppassword.text.toString());
      String downloadUrl = await ProfilePictureUpdate(auth.currentUser!.uid);

      Map<String, dynamic> userdata = UserModel(
              id: auth.currentUser!.uid.toString(),
              email: SignupemailController.text.toString(),
              password: Signuppassword.text.toString(),
              fullName: SignupFullName.text.toString(),
              number: numberController.text.toString(),
              profile: downloadUrl)
          .toJson();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(userdata, SetOptions(merge: true));
      Fluttertoast.showToast(msg: 'User Created');
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print(e.toString());
    } finally {
      loading(false);
    }
  }

  ////////////////////
  RxList<UserModel> userList = <UserModel>[].obs;

  FetchUserData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: auth.currentUser!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<UserModel> LOOPDATA = snapshot.docs.map((e) {
          return UserModel.fromJson(e.data() as Map<String, dynamic>);
        }).toList();
        userList.assignAll(LOOPDATA);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Rx<File?> selectedImage = Rx<File?>(null);

  void pickImageFromCamera() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  void pickImageFromGallery() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }
}
