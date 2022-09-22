import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopify_admin/class/model/models.dart';

class ProductRepository {
  final productCollection = "products";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance.ref();
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChange => _auth.authStateChanges();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// product begin
  Future<List<Product>> fetchProduct() async {
    return await firebaseFirestore
        .collection(productCollection)
        // .where('vendor', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      return value.docs.map((e) => Product.fromJson(e)).toList();
    });
  }

  Future<void> updateProduct({required Product product}) async {
    return await firebaseFirestore
        .collection(productCollection)
        .doc(product.id)
        .update(product.toJson());
  }

  Future<void> deleteProduct({required Product product}) async {
    return await firebaseFirestore
        .collection(productCollection)
        .doc(product.id)
        .delete()
        .then((value) async {
      for (int i = 0; i < product.imgCount!; i++) {
        storage.child("${product.id}/img$i").delete();
      }
    });
  }

  Future<void> uploadProduct(
      {required Product product, required XFile image}) async {
    product.vendor = currentUser!.uid;
    await firebaseFirestore
        .collection(productCollection)
        .add(product.toJson())
        .then((value) async {
      var file = File(image.path);
      var snapshot = await storage.child(value.id.toString()).putFile(file);
      product.image = await snapshot.ref.getDownloadURL();
      product.id = value.id;
      await firebaseFirestore
          .collection(productCollection)
          .doc(value.id)
          .update(product.toJson());
    });
  }

  Future<dynamic> pickImage() async {
    final imagePicker = ImagePicker();
    //ask for permission
    await Permission.photos.request();
    var permissionStatus = await Permission.phone.status;
    // check is permission is granted or if the platform is android
    // by default android permit it
    if (permissionStatus.isGranted || Platform.isAndroid) {
      final XFile? images =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (images != null) {
        return images;
      } else {
        Fluttertoast.showToast(
            msg: "Please select at least one image",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Permission Denied",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20);
    }
    return null;
  }
// product end

// category begin
  Future<void> uploadCategory(ProductCategory category) async {
    // category.uid = currentUser!.uid;
    // category.id = "gsf5566666";
    await firebaseFirestore
        .collection("category")
        .add(category.toMap())
        .then((value) async {
      category.id = value.id;
      await firebaseFirestore
          .collection('category')
          .doc(value.id)
          .update(category.toMap());
    });
  }

  Future<void> deleteCategory(ProductCategory category) async {
    await firebaseFirestore.collection("category").doc(category.id).delete();
  }

  Future<List<ProductCategory>> fetchCategory() async {
    return await firebaseFirestore.collection("category").get().then((value) {
      return value.docs.map((e) => ProductCategory.fromMap(e)).toList();
    });
  }
// category end

// Sales begin

  Future<void> uploadSalesProduct({required Sales sales}) async {
    sales.vendorId = currentUser!.uid;
    await firebaseFirestore
        .collection("sales")
        .add(sales.toMap())
        .then((value) async {
      sales.id = value.id;
      await firebaseFirestore
          .collection('sales')
          .doc(sales.id)
          .update(sales.toMap());
    });
  }

  Future<List<Sales>> fetchSales() async {
    return await firebaseFirestore
        .collection("sales")
        // .where('vendorId', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      return value.docs.map((e) => Sales.fromMap(e)).toList();
    });
  }

  Future<void> deleteSales(String userId) async {
    await firebaseFirestore.collection("sales").doc(userId).delete();
  }

  Future<void> updateSales(Sales sales) async {
    await firebaseFirestore
        .collection("sales")
        .doc(sales.id)
        .update(sales.toMap());
  }

  Future<List<int?>> totalEarning() async {
    return await firebaseFirestore.collection("sales").get().then((value) {
      return value.docs.map((e) => Sales.fromMap(e).price).toList();
    });
  }
// sales end

// order begin
  Future<void> uploadOrder({required Order order}) async {
    order.productName = "new order";
    order.price = 299;
    order.quantity = 3;
    order.orderStatus = 'Pending';

    await firebaseFirestore
        .collection("orders")
        .add(order.toMap())
        .then((value) async {
      order.id = value.id;
      await firebaseFirestore
          .collection('orders')
          .doc(order.id)
          .update(order.toMap());
    });
  }

  Future<List<Order>> fetchOrders() async {
    return await firebaseFirestore.collection("orders").get().then((value) {
      return value.docs.map((e) => Order.fromMap(e)).toList();
    });
  }
// order end
}
