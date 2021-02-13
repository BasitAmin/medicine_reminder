import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/controllers/MedicineController.dart';
import 'package:medicine_reminder/views/add_medicine.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // saving a controller in main memory. initialization
  final medicineController = Get.put(MedicineController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Medicine Reminder",
    home: AddMedicine(),
  ));
}

