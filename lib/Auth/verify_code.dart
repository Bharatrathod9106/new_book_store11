import 'package:bookstore/Auth/utils.dart';
import 'package:bookstore/Pages/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verifyCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 300),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifyCodeController,
              decoration: InputDecoration(hintText: '6 digit code'),
            ),
            SizedBox(height: 30),
            RoundButtom(
                title: "Verify",
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyCodeController.text.toString());
                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => welcomePage()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
