import 'package:bookstore/Components/MultiLineTextFormField.dart';
import 'package:bookstore/Components/MyBackButton.dart';
import 'package:bookstore/Components/MyTextFormField.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewBook extends StatelessWidget {
  const AddNewBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    BookController bookController = Get.put(BookController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyBackButton(),
                            Text(
                              "Add New Book",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            SizedBox(width: 70),
                          ],
                        ),
                        SizedBox(height: 80),
                        InkWell(
                          onTap: () {
                            bookController.pickImage();
                          },
                          child: Obx(
                            () => Container(
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.3),
                              ),
                              child: Center(
                                child: bookController.isImageUploading.value
                                    ? CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      )
                                    : bookController.imageUrl.value == ""
                                        ? Icon(Icons.add, size: 30)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              bookController.imageUrl.value,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bookController.pdfUrl.value == ""
                                  ? Theme.of(context).colorScheme.onBackground
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bookController.isPdfUploading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  )
                                : bookController.pdfUrl.value == ""
                                    ? InkWell(
                                        onTap: () {
                                          bookController.pickPDF();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.insert_chart,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Book PDF",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                            )
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          bookController.pdfUrl.value = "";
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.upload,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "PDF Uploded",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                  ),
                                            )
                                          ],
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.audio_file,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Book Audio",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Book Title",
                    icon: Icons.book,
                    controller: bookController.title,
                  ),
                  SizedBox(height: 10),
                  MultiLineTextFormField(
                    hintText: "Book Description",
                    controller: bookController.description,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Author Name",
                    icon: Icons.person,
                    controller: bookController.author,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "About Author",
                    icon: Icons.person,
                    controller: bookController.about,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          isNumber: true,
                          hintText: "Price",
                          icon: Icons.currency_rupee,
                          controller: bookController.price,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextFormField(
                          isNumber: true,
                          hintText: "Pages",
                          icon: Icons.book,
                          controller: bookController.pages,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Language",
                          icon: Icons.language,
                          controller: bookController.language,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Audio len ",
                          icon: Icons.audiotrack,
                          controller: bookController.audiolen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              // color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cancel,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              SizedBox(width: 10),
                              GestureDetector(onTap: (){
                                bookController.clearall();
                              },
                                child: Text(
                                  "CANCLE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bookController.isPostUploading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      await bookController.createBook();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.post_add,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "POST",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
