import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import '../models/task_model.dart';
import '../provider/app_provider.dart';
import '../styles/app_colors.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "EditTask";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDateG = DateUtils.dateOnly(DateTime.now());
  var selectedTimeG = TimeOfDay.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "To Do App",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  provider.language == "en"
                      ? Text(AppLocalizations.of(context)!.editTask,
                          style:
                              Brightness.light == Theme.of(context).brightness
                                  ? TextStyle(color: Colors.black)
                                  : TextStyle(color: Colors.white))
                      : Text(AppLocalizations.of(context)!.editTask,
                          style:
                              Brightness.light == Theme.of(context).brightness
                                  ? GoogleFonts.cairo(color: Colors.black)
                                  : GoogleFonts.cairo(color: Colors.white)),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    validator: (taskTitle) {
                      if (taskTitle == null || taskTitle.isEmpty) {
                        return provider.language == "en"
                            ? "Please Enter Task Title"
                            : "يرجى إدخال إسم المهمة";
                      }
                      return null;
                    },
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: provider.language == "en"
                          ? Text("Task Title", style: GoogleFonts.novaSquare())
                          : Text("إسم المهمة", style: GoogleFonts.cairo()),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppCloros.lightColor),
                          borderRadius: BorderRadius.circular(18)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppCloros.lightColor),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    validator: (taskDescription) {
                      if (taskDescription == null || taskDescription.isEmpty) {
                        return provider.language == "en"
                            ? "Please Enter Task Description"
                            : "يرجى إدخال محتوى المهمة";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      label: provider.language == "en"
                          ? Text(
                              "Task Description",
                              style: GoogleFonts.novaSquare(),
                            )
                          : Text(
                              "محتوى المهمة",
                              style: GoogleFonts.cairo(),
                            ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppCloros.lightColor),
                          borderRadius: BorderRadius.circular(18.r)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppCloros.lightColor),
                          borderRadius: BorderRadius.circular(18.r)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.selectDate,
                        style: provider.language == "en"
                            ? TextStyle(
                                color: Brightness.light ==
                                        Theme.of(context).brightness
                                    ? Colors.black
                                    : Colors.white)
                            : GoogleFonts.cairo(
                                color: provider.themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      chooseDate();
                    },
                    child: Text(
                      selectedDateG.toString().substring(0, 10),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.selectTime,
                        style: provider.language == "en"
                            ? TextStyle(
                                color: Brightness.light ==
                                        Theme.of(context).brightness
                                    ? Colors.black
                                    : Colors.white)
                            : GoogleFonts.cairo(
                                color: provider.themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      chooseTime();
                    },
                    child: Text(
                      selectedTimeG.toString().substring(10, 15),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size(150.w, 40.h)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          TaskModel task = TaskModel(
                              userID: FirebaseAuth.instance.currentUser!.uid,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: selectedDateG.millisecondsSinceEpoch,
                              time: selectedTimeG.hour,
                              status: true);
                          FirebaseFunctions.updateTask(task.id, task)
                              .then((value) => Navigator.pop(context));
                        }
                      },
                      child: provider.language == "en"
                          ? Text(
                              "Edit",
                              style: GoogleFonts.novaSquare(),
                            )
                          : Text(
                              "تعديل",
                              style: GoogleFonts.cairo(),
                            ))
                ],
              ),
            ),
          ),
        ));
  }

  void chooseDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 2)));
    if (selectedDate != null) {
      selectedDateG = DateUtils.dateOnly(selectedDate);
    }
    setState(() {});
  }

  void chooseTime() async {
    TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      selectedTimeG = selectedTime;
    }
    setState(() {});
  }
}
