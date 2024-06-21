import 'dart:io';
import 'dart:typed_data';
import 'package:bookstore/Model/authmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Auth/utils.dart';
import '../Model/bookModel.dart';

class BookController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController audiolen = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = false.obs;
  var bookData = RxList<BookModel>();
  var currentUserBooks = RxList<BookModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callApi();
  }

  callApi() async {
    await GetAllBooks();
    await GetMyBook();
    await GetUserDetail();
    // await getAllBooks();
  }

  RxList<BookModel> bookList = <BookModel>[].obs;
  RxList<BookModel> fullbookList = <BookModel>[].obs;

  Future GetAllBooks() async {
    print('START');
    try {
      bookList.clear();
      QuerySnapshot snapshot = await db.collection('Books').get();

      if (snapshot.docs.isNotEmpty) {
        List<BookModel> data = snapshot.docs
            .map((e) => BookModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();

        bookList.assignAll(data);
        fullbookList.assignAll(data);
      } else {
        bookList.clear();
      }
    } catch (e) {
      print('ERROR');
      bookList.clear();
      print(e.toString());
    } finally {
      update();
    }
  }

  TextEditingController searchController = TextEditingController();

  void filterProductScreen() {
    bookList.clear();

    if (searchController.text.isEmpty) {
      bookList.addAll(fullbookList);
    } else {
      bookList.addAll(fullbookList.where((entry) => entry.title
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase())));
    }
    update();
  }

  ///////////////////////////////////////////////////////////////
  RxList<BookModel> mybooklist = <BookModel>[].obs;

  Future GetMyBook() async {
    print('START');
    try {
      mybooklist.clear();
      QuerySnapshot snapshot = await db
          .collection('userBook')
          .doc(auth.currentUser!.uid)
          .collection('books')
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<BookModel> data = snapshot.docs
            .map((e) => BookModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();

        mybooklist.assignAll(data);
      } else {
        mybooklist.clear();
      }
    } catch (e) {
      print('ERROR');
      mybooklist.clear();
      print(e.toString());
    } finally {
      update();
    }
  }

//////////////////////////////////////////////////////////////////////////

  RxList<UserModel> userDataList = <UserModel>[].obs;

  Future GetUserDetail() async {
    print('START');
    try {
      userDataList.clear();
      var snapshot =
          await db.collection('users').doc(auth.currentUser!.uid).get();

      if (snapshot.exists) {
        UserModel user =
            UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

        userDataList.add(user);
      } else {
        userDataList.clear();
      }
    } catch (e) {
      print('ERROR');
      userDataList.clear();
      print(e.toString());
    } finally {
      update();
    }
  }

  // Future getAllBooks() async {
  //   // utils().toastMessage("Book Get Fun");
  //   var books = await db.collection("Books").get();
  //   for (var book in books.docs) {
  //     bookData.add(BookModel.fromJson(book.data()));
  //   }
  // }

  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      uploadImageToFirebase(File(image.path));
    }
    // isImageUploading.value = false;
  }

  void uploadImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isImageUploading.value = false;
  }

  createBook() async {
    try {
      String bookId = Uuid().v4();
      isPostUploading.value = true;
      var newBook = BookModel(
        BookID: bookId,
        userID: auth.currentUser!.uid,
        id: "$index",
        title: title.text,
        description: description.text,
        coverUrl: imageUrl.value,
        bookUrl: pdfUrl.value,
        author: author.text,
        aboutAuthor: about.text,
        price: int.parse(price.text),
        pages: int.parse(pages.text),
        language: language.text,
        audioLen: audiolen.text,
        audioUrl: "",
        rating: "",
      );
      await db.collection("Books").doc(bookId).set(newBook.toJson());
      // .add(newBook.toJson());

      addBookInUserDb(newBook, bookId);
      isPostUploading.value = false;
      clearall();
      utils().toastMessage("Book added to the db");
      Get.back();
    } catch (e) {
      utils().toastMessage("Something went wrong");
    } finally {
      await GetAllBooks();
      await GetMyBook();
      Get.back();
    }
  }

  clearall(){
    title.clear();
    description.clear();
    author.clear();
    about.clear();
    price.clear();
    pages.clear();
    language.clear();
    audiolen.clear();
    imageUrl.value = "";
    pdfUrl.value = "";
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;

        print("File Bytes: $fileBytes");

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);
        print(response.storage.bucket);
        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        print(downloadURL);
      } else {
        print("File does not exist");
      }
    } else {
      print("No file selected");
    }
    isPdfUploading.value = false;
  }

  void addBookInUserDb(BookModel book, bookId) async {
    await db
        .collection("userBook")
        .doc(auth.currentUser!.uid)
        .collection("books")
        .doc(bookId)
        .set(book.toJson());
    // .add(book.toJson());
  }

  RxDouble height = 120.00.obs;
  RxDouble width = 120.00.obs;
  RxBool bigSize = false.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

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

  RxBool profileUpdate = false.obs;
  RxString imageee = ''.obs;

  updateprofile() async {
    try {
      profileUpdate(true);
      String downloadUrl = await ProfilePictureUpdate(auth.currentUser!.uid);
      await db.collection('users').doc(auth.currentUser!.uid).set({
        'fullName': fullNameController.text.toString(),
        'number': numberController.text.toString(),
        'profile': downloadUrl
      }, SetOptions(merge: true));
      utils().toastMessage('Profile Updated');
    } catch (e) {
      utils().toastMessage('Failed to update profile');

      print(e.toString());
    } finally {
      profileUpdate(false);
      update();
    }
  }

  deleteBook(docId) async {
    await db.collection('Books').doc(docId).delete();

    await db
        .collection("userBook")
        .doc(auth.currentUser!.uid)
        .collection("books")
        .doc(docId)
        .delete();
    await GetMyBook();
    await GetAllBooks();
  }
}
