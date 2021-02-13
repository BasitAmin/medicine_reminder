import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/controllers/MedicineController.dart';
class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<MedicineController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.medicines.length,
              itemBuilder: (context,int index){
            return ListTile(
              title: Text(controller.medicines[index].name),
            );
          });
        }
      ),
    );
  }
}
