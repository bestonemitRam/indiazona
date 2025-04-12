import 'dart:io';
import 'package:flutter/material.dart';
import 'package:indiazona/src/data/seller_model.dart';
import 'package:indiazona/src/logic/services/seller_service.dart';


class SellerProvider extends ChangeNotifier {
  final SellerService _service = SellerService();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final aadhaarController = TextEditingController();

  bool isLoading = false;

  Future<void> registerSeller(
   
  ) async {




     
    try {
      isLoading = true;
      notifyListeners();

    

      final seller = SellerModel(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        aadhaarNumber: aadhaarController.text,
        aadhaarImageUrl: "aadhaarController",
        profileImageUrl: "profileUrl",
      );

      await _service.saveSellerData(seller);
    } catch (e) {
      throw Exception('Registration failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
