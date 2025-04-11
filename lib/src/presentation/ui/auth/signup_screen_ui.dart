import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indiazona/src/core/helper/extenstion.dart';
import 'package:indiazona/src/core/image/app_images.dart';
import 'package:indiazona/src/logic/provider/auth_provider.dart';
import 'package:indiazona/src/presentation/ui/store/create_store_ui.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                        "Register Your Online Store",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D4CA1),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildTextField(
                        "Reference Code",
                        hint: "Enter the valid reference code",
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Personal Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.sp),
                      ),
                      SizedBox(height: 12.h),
                      _buildTextField("Name *",
                          hint: "Please write your name here"),
                      _buildTextField("Email ID *", hint: "abc@example.com"),
                      _buildTextField(
                          controller: provider.phoneController,
                          "Mobile Number *",
                          hint: "+91",
                          suffix: TextButton(
                              onPressed: () {}, child: Text("Send OTP"))),
                      _buildTextField("Create Password *", obscure: true),
                      _buildTextField("Confirm Password *", obscure: true),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () 
                          {
                           provider.sendOtp( context);
                           
                            // Navigator.push(
                            //     context,
                            //     CustomPageTransitions.slide(
                            //         const SellerRegistrationScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text("Next",
                              style: TextStyle(color: Colors.grey.shade600)),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already Registered? ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                            children: [
                              TextSpan(
                                text: "Log In",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
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

// class RegisterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfffef6ed),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 800) {
//             // WEB or large screen layout
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(flex: 5, child: _buildForm(context)),
//                 Expanded(flex: 2, child: _buildImage(context)),
//               ],
//             );
//           } else {
//             // MOBILE layout
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildForm(context),
//                   _buildImage(context),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: 500),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(AppImages.logo, height: 60),
//               const SizedBox(height: 20),
//               Text('Register Your Online Store',
//                   style: Theme.of(context).textTheme.bodySmall),
//               const SizedBox(height: 30),
//               _buildTextField('Reference Code', 'Enter reference code'),
//               _buildTextField('Name', 'Please write your name here'),
//               _buildTextField('Email ID', 'abc@example.com'),
//               _buildTextField('Mobile Number', '+91',
//                   suffix:
//                       TextButton(onPressed: () {}, child: Text('Send OTP'))),
//               _buildTextField('Create Password', '********', obscure: true),
//               _buildTextField('Confirm Password', '********', obscure: true),
//               const SizedBox(height: 20),
//               ElevatedButton(onPressed: () {}, child: Text('Next')),
//               const SizedBox(height: 10),
//               Center(
//                   child: TextButton(
//                       onPressed: () {},
//                       child: Text('Already Registered? Log In')))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Image.asset(
//           width: 500.w, height: 600.h, AppImages.user, fit: BoxFit.contain),
//     );
//   }

//   Widget _buildTextField(String label, String hint,
//       {bool obscure = false, Widget? suffix}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$label *'),
//         const SizedBox(height: 4),
//         TextField(
//           obscureText: obscure,
//           decoration: InputDecoration(
//             hintText: hint,
//             suffixIcon: suffix,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }
