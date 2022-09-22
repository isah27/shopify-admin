// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users({
    this.uid,
    this.username,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.bankNames,
    this.accountNames,
    this.accountNumbers,
    this.accountTypes,
    this.password,
  });

  String? uid;
  String? username;
  String? email;
  String? phoneNumber;
  String? gender;
  String? address;
  String? bankNames;
  String? accountNames;
  String? accountNumbers;
  String? accountTypes;
  String? password;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        address: json["address"],
        bankNames: json["bank_names"],
        accountNames: json["account_names"],
        accountNumbers: json["account_numbers"],
        accountTypes: json["account_types"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "gender": gender,
        "address": address,
        "bank_names": bankNames,
        "account_names": accountNames,
        "account_numbers": accountNumbers,
        "account_types": accountTypes,
        "password": password,
      };
}

class Sales {
  Sales({
    this.id,
    this.customer,
    this.vendorId,
    this.productId,
    this.name,
    this.price,
    this.category,
    this.rating,
    this.image,
  });
  String? id;
  String? customer;
  String? vendorId;
  String? productId;
  String? name;
  int? price;
  String? category;
  int? rating;
  String? image;

  Sales.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    id = map["id"];
    customer = map["customer"];
    vendorId = map["vendor_id"];
    productId = map["product_id"];
    name = map["name"];
    price = map["price"];
    category = map["category"];
    rating = map["rating"];
    image = map["image"];
  }

  Map<String, dynamic> toMap() {
    var map = {
      "customer": customer,
      "vendor_id": vendorId,
      "product_id": productId,
      "name": name,
      "price": price,
      "category": category,
      "rating": rating,
      "image": image,
      'id': id,
    };

    return map;
  }
}

class Order {
  Order({
    this.id,
    this.customer,
    this.productId,
    this.vendorId,
    this.productName,
    this.quantity,
    this.price,
    this.category,
    this.image,
    this.orderStatus,
    this.productDesc,
  });
  String? id;
  String? customer;
  String? productId;
  String? vendorId;
  String? productDesc;
  String? productName;
  int? quantity;
  int? price;
  String? image;
  String? category;
  String? orderStatus;
  Order.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    id = map["id"];
    customer = map["customer"];
    productId = map["product_id"];
    vendorId = map["vendor_id"];
    productName = map["product_name"];
    quantity = map["quantity"];
    price = map["price"];
    image = map['image'];
    category = map['category'];
    orderStatus = map["order_status"];
    productDesc = map['productDesc'];
  }

  Map<String, dynamic> toMap() {
    var map = {
      "customer": customer,
      "product_id": productId,
      "vendor_id": vendorId,
      "product_name": productName,
      "quantity": quantity,
      "price": price,
      "image": image,
      "category": category,
      "order_status": orderStatus,
      'id': id,
      "productDesc": productDesc,
    };

    return map;
  }
}

class Product {
  Product({
    this.id,
    this.vendor,
    this.name,
    this.description,
    this.price,
    this.category,
    this.image,
    this.imgCount,
  });

  String? id;
  String? vendor;
  String? name;
  String? description;
  int? price;
  String? category;
  String? image;
  int? imgCount;

  factory Product.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      Product(
        id: json["id"],
        vendor: json["vendor"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        image: json["image"],
        imgCount: json["img_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor": vendor,
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "image": image,
        "img_count": imgCount,
      };
}

class ProductCategory {
  String? id;
  String? uid;
  String? name;
  ProductCategory({
    this.id,
    this.uid,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
    };
  }

  factory ProductCategory.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return ProductCategory(
      id: map['id'] as String,
      uid: map['uid'],
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ProductCategory.fromJson(String source) => ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
