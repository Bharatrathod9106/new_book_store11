// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:bookstore/Components/MyTextFormField.dart';
import 'package:bookstore/Components/round_button.dart';
import 'package:bookstore/Config/colors.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  BookController bb = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    var mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: Text('Edit Profile'),
      ),
      body: Container(
        height: mySize.height,
        width: mySize.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return Container(
                  height: mySize.height / 4,
                  width: mySize.width / 2.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: bb.selectedImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(19),
                          child: Image.file(
                            File(bb.selectedImage.value!.path),
                            fit: BoxFit.cover,
                          ))
                      : CachedNetworkImage(
                          imageUrl: bb.imageee.value,
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
                          bb.pickImageFromCamera();
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
                          bb.pickImageFromGallery();
                        },
                        icon: Icon(
                          Icons.photo_sharp,
                          color: Colors.blue,
                          size: 30,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyTextFormField(
                  hintText: 'Full Name',
                  icon: Icons.person,
                  controller: bb.fullNameController),
              SizedBox(
                height: 10,
              ),
              MyTextFormField(
                  isNumber: true,
                  hintText: 'Phone Number',
                  icon: Icons.call,
                  controller: bb.numberController),
              SizedBox(
                height: 30,
              ),
              Obx(() {
                return RoundButtom(
                    loading: bb.profileUpdate.value,
                    title: 'Update',
                    onTap: () async {
                      await bb.updateprofile();
                      await bb.GetUserDetail();
                      Get.back();
                      bb.selectedImage.value = null;
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
