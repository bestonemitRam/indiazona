import 'package:flutter/material.dart';
import 'package:indiazona/src/core/image/app_images.dart';

// class EmailVerificationScreen extends StatelessWidget {
//   const EmailVerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfffef6ed),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 800) {
//             return Row(
//               children: [
//                 Expanded(child: _buildImageSide(context)),
//                 Expanded(child: Center(child: _buildTextContent(context))),
//               ],
//             );
//           } else {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildImageSide(context),
//                   _buildTextContent(context),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildImageSide(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xfffde6c9),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: Image.asset(
//             AppImages.rightUser, // <- Your local asset path
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextContent(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 500),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(AppImages.logo, height: 60),
//               const SizedBox(height: 20),
//               Text(
//                 'Verify Your Email Address',
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: Colors.blue.shade900,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Please check your email (s********@gmail.com) for a verification link.\n'
//                 "If it’s not in your inbox, check your spam folder or request again.",
//                 style: TextStyle(fontSize: 16, height: 1.5),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // TODO: Trigger resend logic
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange.shade600,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Resend Verification Email',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   const Text("Want to change email ID? "),
//                   GestureDetector(
//                     onTap: () {
//                       // TODO: Go back
//                     },
//                     child: Text(
//                       'Back To Previous Page',
//                       style: TextStyle(
//                         color: Colors.blue.shade800,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indiazona/src/core/image/app_images.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5ED),
      body: Row(
        children: [
      
          if (MediaQuery.of(context).size.width > 900)
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfffde6c9),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(
                      AppImages.rightUser,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
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
                        "Verify Your Email Address",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D4CA1),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Please check your email (s********@gmail.com) for a verification link.\n'
                        "If it’s not in your inbox, check your spam folder or request again.",
                        style: TextStyle(fontSize: 16.sp, height: 1.5),
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Trigger resend email logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade600,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Resend Verification Email',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            "Want to change email ID? ",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back To Previous Page',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
