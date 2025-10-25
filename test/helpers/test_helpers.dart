import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Wrap widget with GetMaterialApp for testing
Widget wrapWithGetMaterialApp(Widget child) {
  return GetMaterialApp(
    home: Scaffold(body: child),
  );
}

/// Setup GetX for testing
void setupGetX() {
  Get.testMode = true;
}

/// Cleanup GetX after testing
void cleanupGetX() {
  Get.reset();
}
