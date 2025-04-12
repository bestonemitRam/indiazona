import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:indiazona/src/data/seller_model.dart';


class SellerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, String path) async {
    final ref = _storage.ref().child('sellers/$path');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> saveSellerData(SellerModel seller) async {
    await _firestore.collection('sellers').add(seller.toJson());
  }
}
