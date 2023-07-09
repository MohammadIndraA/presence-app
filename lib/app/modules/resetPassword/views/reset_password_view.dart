import 'package:firebase/widgate/TextFiled.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Icon(Icons.lock_open_outlined, size: 140),
              SizedBox(height: 15),
              TextFiledd(
                controller: controller.emailC,
                hintText: 'Email...',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    controller.sendEmail();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Text(
                              "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : const Text(
                              "SEND PASSWORD NEW",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Kembeali',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
