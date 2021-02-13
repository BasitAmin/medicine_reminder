import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:medicine_reminder/controllers/MedicineController.dart';
import 'package:medicine_reminder/model/Medicine.dart';
import 'package:medicine_reminder/views/ReminderMedicine.dart';
import 'package:sqflite/sqlite_api.dart';
class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  Medicine medicine = Medicine(0,"","","","","");
  MedicineController medicineController = Get.find();

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  String convertTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('HH:mm');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1B3954),
        appBar: AppBar(
          backgroundColor: Color(0xff1B3954),
          bottomOpacity: 0,
          elevation: 0,
          toolbarHeight: 45,
          leading: Icon(Icons.arrow_back),
        ),

        body: Container(
          padding: EdgeInsets.only(left: 12,right: 12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Add Medicine",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                          ),
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('images/medicine.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Container(
                      width: Get.width,
                      height: Get.height-Get.height/3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -2),
                            blurRadius: 30,
                            color: Colors.black.withOpacity(0.16),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: medicineController.name,
                            style: TextStyle(color: Color(0xff1B3954),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "Medicine Name",
                              labelStyle: TextStyle(
                                color: Color(0xff1B3954),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.medical_services,color: Colors.red),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          TextFormField(
                            controller: medicineController.startDate,
                            readOnly: true,
                            onTap: ()
                            {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 3, 5),
                                  maxTime: DateTime(2099, 6, 7), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    medicineController.startDate.text =convertDateTimeDisplay(date.toString());
                                  },
                                  currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            style: TextStyle(color: Color(0xff1B3954),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,),
                            decoration: InputDecoration(
                              labelText: "Start Date",
                              isDense: true,
                              labelStyle: TextStyle(
                                color: Color(0xff1B3954),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.calendar_today_outlined,color: Colors.green),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          TextFormField(
                            controller: medicineController.endDate,
                            readOnly: true,
                            onTap: ()
                            {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 3, 5),
                                  maxTime: DateTime(2099, 6, 7), onChanged: (Date) {
                                    print('change $Date');
                                  }, onConfirm: (Date) {
                                    print('confirm $Date');
                                    medicineController.endDate.text =convertDateTimeDisplay(Date.toString());
                                  },
                                  currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            style: TextStyle(color: Color(0xff1B3954),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,),
                            decoration: InputDecoration(
                              labelText: "End Date",
                              isDense: true,
                              labelStyle: TextStyle(
                                color: Color(0xff1B3954),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.calendar_today_outlined,color: Colors.red,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          TextFormField(
                            controller: medicineController.time,
                            readOnly: true,
                            onTap: ()
                            {
                              DatePicker.showTimePicker(context,
                                  showTitleActions: true,
                                  showSecondsColumn: false,
                                  onChanged: (time) {
                                    print('change $time');
                                  }, onConfirm: (time) {
                                    print('confirm $time');
                                    medicineController.time.text =convertTimeDisplay(time.toString());
                                  },
                                  currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            style: TextStyle(color: Color(0xff1B3954),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,),
                            decoration: InputDecoration(
                              labelText: "Medicine Time",
                              isDense: true,
                              labelStyle: TextStyle(
                                color: Color(0xff1B3954),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: Icon(Icons.timer,color: Colors.green,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          DropdownSearch<String>(
                              mode: Mode.MENU,
                              maxHeight: 180,
                              showSelectedItem: true,
                              items: ["Before Meal", "During Meal", "After Meal"],
                              label: "Medicine type",
                              hint: "Before Meal",
                              popupBackgroundColor: Color(0xff1B3954),
//                      popupItemDisabled: (String s) => s.startsWith('I'),
                             onChanged: medicineController.medicineType,
                              selectedItem: "Before Meal"),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 2.5,
                              height: 55,
                              color: Color(0xff1B3954),
                              onPressed: (){
                                if(formKey.currentState.validate())
                                  {
                                    formKey.currentState.save();
                                    medicine.name = medicineController.name.text;
                                    medicine.type = medicineController.type.text;
                                    medicine.startDate = medicineController.startDate.text;
                                    medicine.endDate = medicineController.endDate.text;
                                    medicine.time = medicineController.time.text;
                                    medicineController.addMedicine(medicine);
                                    Get.to(MedicineReminder());
                                    Get.snackbar("turrrrr", "churrrr",
                                      backgroundColor: Colors.green,
                                      colorText:Colors.white,

                                    );
                                  }


                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              shape: StadiumBorder()
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
