// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:bookstore/Auth/LoginScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/round_button.dart';
import '../Controller/loginController.dart';

class signUpScreen extends StatelessWidget {
  signUpScreen({Key? key}) : super(key: key);

  loginController ln = Get.find<loginController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("Sign-Up"),
      ),
      body: SizedBox(
        width: MediaQuery
            .sizeOf(context)
            .width,
        height: MediaQuery
            .sizeOf(context)
            .height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                // Container(
                //   height: 300,
                //   padding: EdgeInsets.all(20),
                //   color: Theme.of(context).colorScheme.primary,
                //   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //     Expanded(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const SizedBox(height: 30),
                //           Image.asset(
                //             "Assets/Images/book.png",
                //             width: 200
                //           ),
                //           const SizedBox(height: 20),
                //           Text("E - Book Store",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .headlineLarge
                //                   ?.copyWith(
                //                 color: Theme.of(context).colorScheme.onBackground,
                //               )),
                //           const SizedBox(height: 10),
                //           Flexible(
                //             child: Text(
                //                 "Here you can find best book for you and you can also read book and listen book",
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .labelSmall
                //                     ?.copyWith(
                //                   color: Theme.of(context).colorScheme.onBackground,
                //                 )),
                //           ),
                //         ],
                //       ),
                //     )
                //   ]),
                // ),,
                Obx(() {
                  return Container(
                    height: mySize.height / 4,
                    width: mySize.width / 2.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: ln.selectedImage.value != null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Image.file(
                          File(ln.selectedImage.value!.path),
                          fit: BoxFit.cover,
                        ))
                        : CachedNetworkImage(
                      imageUrl: '',
                      errorWidget: (b, o, s) {
                        return Icon(Icons.person);
                      },
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.grey.shade100,
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            ln.pickImageFromCamera();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.brown,
                            size: 30,
                          )),
                      SizedBox(
                        width: 25,
                      ),
                      IconButton(
                          onPressed: () async {
                            ln.pickImageFromGallery();
                          },
                          icon: Icon(
                            Icons.photo_sharp,
                            color: Colors.blue,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: ln.SignupFullName,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: 'FullName',
                              // helperText: 'enter the password',
                              prefixIcon: Icon(Icons.details_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter FullName';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: ln.SignupemailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'E-mail',
                              // helperText: 'enter the email',
                              prefixIcon: Icon(Icons.email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter the email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Obx(() {
                          return TextFormField(
                            controller: ln.Signuppassword,
                            keyboardType: TextInputType.text,
                            obscureText: ln.isObscure.value,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      ln.isObscure.toggle();
                                    },
                                    icon: Icon(ln.isObscure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                hintText: 'Password',
                                // helperText: 'enter the password',
                                prefixIcon: Icon(Icons.lock_clock_outlined)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter password';
                              }
                              return null;
                            },
                          );
                        }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: ln.numberController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: 'Phone-No',
                              // helperText: 'enter the password',
                              prefixIcon: Icon(Icons.phone)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter Number';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 15),
                Obx(() {
                  return RoundButtom(
                    title: "Sign-Up",
                    loading: ln.loading.value,
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        await ln.Signup();
                      }
                    },
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account "),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .error)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
