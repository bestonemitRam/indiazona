import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indiazona/src/core/image/app_images.dart';
import 'package:indiazona/src/logic/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5ED),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
                constraints: BoxConstraints(maxWidth: 600.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.logo, height: 60.h),
                      SizedBox(height: 20.h),
                      Text(
                        "Login User",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D4CA1),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Personal Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.sp),
                      ),
                      SizedBox(height: 12.h),
                      _buildTextField(
                          controller: provider.emailController,
                          "Email ID *",
                          hint: "abc@example.com"),
                      _buildTextField(
                          controller: provider.passwordController,
                          "Password *",
                          obscure: true),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: provider.isLoading
                            ?  SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(child: CircularProgressIndicator())):
                            ElevatedButton(
                                onPressed: () {
                                  provider.loginUser(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                                child: Text("Next",
                                    style:
                                        TextStyle(color: Colors.grey.shade600)),
                              )
                            ,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (MediaQuery.of(context).size.width > 900)
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Image.asset(AppImages.user, fit: BoxFit.contain),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label,
      {String? hint,
      bool obscure = false,
      Widget? suffix,
      TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffix: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }


}
