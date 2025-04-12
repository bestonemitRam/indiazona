import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indiazona/src/core/image/app_images.dart';
import 'package:indiazona/src/logic/provider/seller_provider.dart';
import 'package:provider/provider.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  State<SellerRegistrationScreen> createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  int _currentStep = 0;

  final steps = [
    "Personal Details",
    "Business Details",
    "GST",
    "Bank Details",
    "Pickup Address",
    "Acceptance & Approval"
  ];

  void _nextStep() {
    if (_currentStep < steps.length - 1) {
      setState(() {
        _currentStep++;
           final sellerProvider =
            Provider.of<SellerProvider>(context, listen: false).registerSeller();
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(AppImages.logo, height: 40),
            const Spacer(),
            const Icon(Icons.notifications_none, color: Colors.black),
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: "Eng",
              underline: const SizedBox(),
              items: ["Eng", "Hin"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(width: 20),
            const CircleAvatar(backgroundImage: AssetImage(AppImages.store)),
            const SizedBox(width: 8),
            const Text("Mr Abc\nSeller",
                style: TextStyle(color: Colors.black, fontSize: 12)),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildStepper(),
                  const SizedBox(height: 20),
                  Expanded(child: _buildStepForm()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    child: Card(
                      color: Colors.white,
                      child: Center(
                        child: Icon(Icons.play_circle_fill,
                            color: Colors.orange, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Image.asset(
                    AppImages.store,
                    fit: BoxFit.fill,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Card(
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            final stepIndex = index ~/ 2;
            final isActive = stepIndex == _currentStep;

            return Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isActive ? Colors.indigo : Colors.grey.shade300,
                    radius: 15,
                    child: Text(
                      "${stepIndex + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[stepIndex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          } else {
            return Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildStepForm() {
    switch (_currentStep) {
      case 0:
        return _personalDetailsForm();
      case 1:
        return _customForm("Business Details");
      case 2:
        return _customForm("GST Details");
      case 3:
        return _customForm("Bank Details");
      case 4:
        return _customForm("Pickup Address");
      case 5:
        return _customForm("Acceptance & Approval");
      default:
        return const SizedBox();
    }
  }

  Widget _personalDetailsForm() {
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    return _formWrapper(
      title: "Personal Details",
      subtitle: "Please fill your information so we can get in touch with you.",
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(label: "Name", hint: "Sahil")),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTextField(
                  controller: sellerProvider.mobileController,
                  label: "Mobile Number",
                  hint: "+91 8548904567"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildFilePicker(label: "Your Image")),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTextField(
                  controller: sellerProvider.emailController,
                  label: "Email",
                  hint: "sahil@gmail.com"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                  controller: sellerProvider.aadhaarController,
                  label: "Aadhaar Card Number",
                  hint: "XXXX XXXX XXXX"),
            ),
            const SizedBox(width: 20),
            Expanded(child: _buildFilePicker(label: "Aadhaar Card Image")),
          ],
        ),
      ],
    );
  }

  Widget _customForm(String title) {
    return _formWrapper(
      title: title,
      subtitle: "This is the form for $title.",
      children: [
        _buildTextField(label: "$title Field 1", hint: ""),
        const SizedBox(height: 20),
        _buildTextField(label: "$title Field 2", hint: "Example 2"),
      ],
    );
  }

  Widget _formWrapper(
      {required String title,
      required String subtitle,
      required List<Widget> children}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(subtitle),
            const SizedBox(height: 20),
            ...children,
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: _previousStep, child: const Text("Back")),
                ElevatedButton(
                    onPressed: _nextStep, child: const Text("Save & Next")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label *"),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePicker({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label *"),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: "JPEG & PNG formats",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: () async {}, child: const Text("Browse File"))
          ],
        ),
        const SizedBox(height: 4),
        Text("Passport size photo under 100 KB.",
            style: TextStyle(fontSize: 10, color: Colors.blue.shade700))
      ],
    );
  }
}
