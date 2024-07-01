// ignore_for_file: must_be_immutable

import 'package:bookstore/Controller/BookController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/round_button.dart';
import '../Controller/loginController.dart';
import 'LoginWithPhone.dart';
import 'SIgnUpScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  loginController ln = Get.put(loginController());
  BookController bb = Get.find<BookController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(""),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 350,
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              Image.asset(
                                "Assets/Images/book.png",
                                width: 300,
                              ),
                              const SizedBox(height: 20),
                              Text("Novel Nest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      )),
                              const SizedBox(height: 10),
                              Flexible(
                                child: Text(
                                    "Here you can find best book for you and you can also read book and listen book",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        )),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 10),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: ln.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              // helperText: 'enter the email',
                              prefixIcon: Icon(Icons.email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return TextFormField(
                            controller: ln.passwordController,
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
                                prefixIcon: Icon(Icons.lock_clock_outlined)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter password';
                              }
                              return null;
                            },
                          );
                        }),
                      ],
                    )),
                const SizedBox(height: 15),
                Obx(() {
                  return RoundButtom(
                    title: "Login",
                    loading: ln.loading.value,
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        await ln.loginFunctio();
                        await bb.GetUserDetail();
                        await bb.GetMyBook();
                      }
                    },
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account "),
                    TextButton(
                        onPressed: () {
                          Get.to(() => signUpScreen());
                        },
                        child: Text("Sign up",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error)))
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginWithPhone()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    child: const Center(
                      child: Text("Login with phone"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
