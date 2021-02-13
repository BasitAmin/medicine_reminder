import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/controllers/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medicine_reminder/model/Medicine.dart';
import 'package:medicine_reminder/model/Medicine.dart';
class MedicineController extends GetxController{

  var medicines = List<Medicine>().obs;
  TextEditingController name;
  TextEditingController startDate;
  TextEditingController endDate;
  TextEditingController type;
  TextEditingController time;
   Medicine medicine;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name = TextEditingController();
    startDate = TextEditingController();
    endDate = TextEditingController();
    type = TextEditingController();
    time = TextEditingController();
    fetchMedicines();
  }

  void fetchMedicines() async {
    var fetchedNotes = await MedicineDb.db.getMedicineFromDB();
    medicines.value = fetchedNotes;

  }
  medicineType(String medtype)
  {
    type.text = medtype;
  }


  void addMedicine(Medicine medicine)async{
    await MedicineDb.db.addMedicineInDB(medicine);
    fetchMedicines();
   // print(medicines[0].name);
  }









}