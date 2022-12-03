import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/model/product_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AppController extends GetxController {
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCompanyFormKey = GlobalKey<FormState>();

  final DatabaseReference firebaseDatabase = FirebaseDatabase.instance.ref();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final TextEditingController productNameTextEditingController =
      TextEditingController();
  final TextEditingController productDescriptionTextEditingController =
      TextEditingController();
  final TextEditingController productQtyTextEditingController =
      TextEditingController();
  final TextEditingController productPriceTextEditingController =
      TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  final TextEditingController newCategoryTextEditingController =
      TextEditingController();
  final TextEditingController newCompanyTextEditingController =
      TextEditingController();

  final RxString productName = ''.obs;
  final RxString productCompany = ''.obs;
  final RxString productCategory = ''.obs;
  final RxString productDescription = ''.obs;
  final RxString productQty = ''.obs;
  final RxString productPrice = ''.obs;
  final RxList imageList = [].obs;
  final RxList firebaseImageUrlList = [].obs;

  final categoriesList = [''].obs;
  final companiesList = [''].obs;

  final RxString newCategory = ''.obs;
  final RxString newCompany = ''.obs;

  final ProductModel detailModel = ProductModel();

  // BUSSINESS LOGIC OF PRODUCT SCREEN
  final generalImage = ''.obs;
  void selectGeneralImage() async {
    generalImage.value = '';
    final XFile? selectedGeneralImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    generalImage.value = selectedGeneralImages?.path.toString() ?? '';
  }

  // Functionality
  Future<String> getFirebaseStorageImageUrl({selectedImage, path}) async {
    String retreivedUrl = '';
    final TaskSnapshot snapshot =
        await firebaseStorage.ref(path).putFile(File(selectedImage));
    if (snapshot.state == TaskState.success) {
      retreivedUrl = await snapshot.ref.getDownloadURL();
    }
    return retreivedUrl;
  }

  String? validator(String? value, error) {
    if (value!.isEmpty) {
      return error;
    }
    return null;
  }

  final productsList = <ProductModel>[].obs;
  final isUploading = false.obs;
  Future<void> addProduct() async {
    if (addProductFormKey.currentState!.validate()) {
      productName.value = productNameTextEditingController.text;
      productDescription.value = productDescriptionTextEditingController.text;
      productQty.value = productQtyTextEditingController.text;
      productPrice.value = productPriceTextEditingController.text;
      await uploadProductData();
    }
  }

  Future<void> uploadProductData() async {
    try {
      isUploading.value = true;
      final selectedImageFirebaseURL = await getFirebaseStorageImageUrl(
        selectedImage: generalImage.value,
        path: '${productName.value}/image',
      );
      final ProductModel productModel = ProductModel(
        productTitle: productName.value,
        productCategory: productCategory.value,
        productCompany: productCompany.value,
        productDescription: productDescription.value,
        productPrice: productPrice.value,
        productQty: productQty.value,
        productImage: selectedImageFirebaseURL,
      );
      productsList.insert(0, productModel);
      await insertDatatoRealDb();
      Get.back();
      Get.snackbar(
        'Product Added',
        'Product Successfully Added',
        duration: const Duration(seconds: 1, milliseconds: 500),
        icon: const Icon(Icons.shopping_cart, color: grey),
        snackPosition: SnackPosition.TOP,
      );
      clearEditingController();
      isUploading.value = false;
    } catch (e) {
      isUploading.value = false;
      throw ('Something went wrong while uploading');
    }
  }

  void editProduct(index) {
    if (addProductFormKey.currentState!.validate()) {
      productName.value = productNameTextEditingController.text;
      productDescription.value = productDescriptionTextEditingController.text;
      productQty.value = productQtyTextEditingController.text;
      productPrice.value = productPriceTextEditingController.text;
      productsList.removeAt(index);
      updateProductData(index);
    }
  }

  Future<void> updateProductData(index) async {
    try {
      isUploading.value = true;
      final selectedImageFirebaseURL = await getFirebaseStorageImageUrl(
        selectedImage: generalImage.value,
        path: '${productName.value}/image',
      );
      final ProductModel productModel = ProductModel(
        productTitle: productName.value,
        productCategory: productCategory.value,
        productCompany: productCompany.value,
        productDescription: productDescription.value,
        productPrice: productPrice.value,
        productQty: productQty.value,
        productImage: selectedImageFirebaseURL,
      );
      productsList.insert(index, productModel);
      await insertDatatoRealDb();
      Get.back();
      Get.snackbar(
        'Product Update',
        'Product Successfully Updated',
        duration: const Duration(seconds: 1, milliseconds: 500),
        icon: const Icon(Icons.shopping_cart, color: grey),
        snackPosition: SnackPosition.TOP,
      );
      clearEditingController();
      isUploading.value = false;
    } catch (e) {
      isUploading.value = false;

      throw ('Something went wrong while uploading');
    }
  }

  Future<void> deleteProduct(int index) async {
    productsList.removeAt(index);
    await insertDatatoRealDb();
    Get.snackbar(
      'Product Deleted',
      'Product Successfully Deleted',
      duration: const Duration(seconds: 1, milliseconds: 500),
      icon: const Icon(Icons.shopping_cart, color: grey),
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> insertDatatoRealDb() async {
    const String productUrl =
        'https://eq-tech-practical-default-rtdb.firebaseio.com/products.json';
    final response = await http.put(
      Uri.parse(productUrl),
      body: productModelListToJson(productsList),
    );
    productsList.value = productModelListFromJson(response.body);
  }

  final isWaitForProducts = false.obs;
  Future<void> getProducts() async {
    const String productsUrl =
        'https://eq-tech-practical-default-rtdb.firebaseio.com/products.json';
    try {
      isWaitForProducts.value = true;
      final http.Response response = await http.get(
        Uri.parse(productsUrl),
      );
      if (response.body != 'null') {
        productsList.value = productModelListFromJson(response.body);
      }
      isWaitForProducts.value = false;
    } catch (e) {
      isWaitForProducts.value = false;

      throw ('API call Failed Please check Connection');
    }
  }

  void clearEditingController() {
    productNameTextEditingController.clear();
    productCategory.value = '';
    productCompany.value = '';
    productDescriptionTextEditingController.clear();
    productPriceTextEditingController.clear();
    productQtyTextEditingController.clear();
    imageList.value = [];
    generalImage.value = '';
    firebaseImageUrlList.value = [];
  }

  // BUSINESS LOGIC OF MANAGE CATEGORY
  final isWaitForCategories = false.obs;
  void addCategory() {
    if (addCategoryFormKey.currentState!.validate()) {
      newCategory.value = newCategoryTextEditingController.text;
      categoriesList.insert(0, newCategory.value);
      uploadCategories();
    }
  }

  void deleteCategory(int index) {
    categoriesList.removeAt(index);
    uploadCategories();
  }

  Future<void> getCategories() async {
    try {
      categoriesList.clear();
      isWaitForCategories.value = true;
      const String categoriesUrl =
          'https://eq-tech-practical-default-rtdb.firebaseio.com/categories.json';
      final http.Response response = await http.get(Uri.parse(categoriesUrl));
      if (response.body.isNotEmpty) {
        final List decodedJson = jsonDecode(response.body);
        for (var element in decodedJson) {
          categoriesList.add(element);
        }
      }
      isWaitForCategories.value = false;
    } catch (e) {
      isWaitForCategories.value = false;
    }
  }

  void uploadCategories() async {
    await firebaseDatabase
        .child('categories')
        .set(categoriesList)
        .then((value) {
      Get.snackbar(
        'Categories',
        'Categories List Changed Successfully',
        duration: const Duration(seconds: 1, milliseconds: 500),
        icon: const Icon(Icons.category, color: grey),
        snackPosition: SnackPosition.TOP,
      );
      newCategoryTextEditingController.clear();
    });
  }

  // BUSINESS LOGIC OF MANAGE COMPANY
  final isWaitForCompanies = false.obs;
  void addCompany() {
    if (addCompanyFormKey.currentState!.validate()) {
      newCompany.value = newCompanyTextEditingController.text;
      companiesList.insert(0, newCompany.value);
      uploadCompanies();
    }
  }

  void deleteCompany(int index) {
    companiesList.removeAt(index);
    uploadCompanies();
  }

  Future<void> getCompanies() async {
    try {
      companiesList.clear();
      isWaitForCompanies.value = true;
      const String companiesUrl =
          'https://eq-tech-practical-default-rtdb.firebaseio.com/companies.json';
      final http.Response response = await http.get(Uri.parse(companiesUrl));
      if (response.body.isNotEmpty) {
        final List decodedJson = jsonDecode(response.body);
        for (var element in decodedJson) {
          companiesList.add(element);
        }
      }
      isWaitForCompanies.value = false;
    } catch (e) {
      isWaitForCompanies.value = false;
    }
  }

  void uploadCompanies() async {
    await firebaseDatabase.child('companies').set(companiesList).then((value) {
      Get.snackbar(
        'Companies',
        'Companies List Changed Successfully',
        duration: const Duration(seconds: 1, milliseconds: 500),
        icon: const Icon(Icons.category, color: grey),
        snackPosition: SnackPosition.TOP,
      );
      newCompanyTextEditingController.clear();
    });
  }
}
