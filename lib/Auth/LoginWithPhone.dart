import 'package:bookstore/Auth/utils.dart';
import 'package:bookstore/Auth/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/round_button.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 300),
            TextFormField(
              // keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(hintText: '+1 910 6315 936'),
            ),
            SizedBox(height: 30),
            RoundButtom(title: "Login",loading: loading, onTap: () {

              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false ;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false ;
                    });
                    utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                    setState(() {
                      loading = false ;
                    });
                  },
                  codeAutoRetrievalTimeout: (e){
                    utils().toastMessage(e.toString());
                    setState(() {
                      loading = false ;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}
