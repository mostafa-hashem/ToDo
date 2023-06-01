import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/widgets/task_item.dart';

import '../models/task_model.dart';
import '../provider/app_provider.dart';
import '../shared/network/firebase/firebase_functions.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

DateTime date = DateTime.now();

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    TaskModel task;
    var provider = Provider.of<MyAppProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365 * 2)),
          onDateSelected: (newDate) {
            setState(() {
              date = newDate;
            });
          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.teal[200],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          dotsColor: Color(0xFF333A47),
          locale: 'en_ISO',
        ),
        SizedBox(
          height: 15.h,
        ),
        StreamBuilder(
            stream: FirebaseFunctions.getTasksFromFirestore(date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      provider.language == "en"
                          ? Text("Something went wrong",
                              style: GoogleFonts.novaSquare())
                          : Text("عذرً, حدث خطأ", style: GoogleFonts.cairo()),
                      ElevatedButton(
                          onPressed: () {},
                          child: provider.language == "en"
                              ? Text(
                                  "Try again",
                                  style: GoogleFonts.novaSquare(),
                                )
                              : Text("حاول مجددًا", style: GoogleFonts.cairo()))
                    ],
                  ),
                );
              }
              List<TaskModel> doneTasks =
                  snapshot.data?.docs.map((doc) => doc.data()).where((task) => task.status).toList() ?? [];
              if (doneTasks.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    provider.language == "en"
                        ? Text(
                            "There's No Finished Tasks Yet",
                            style: GoogleFonts.novaSquare(fontSize: 20.sp),
                          )
                        : Text(
                            "لا يوجد مهام منتهية بعد",
                            style: GoogleFonts.cairo(fontSize: 20.sp),
                          ),
                    Icon(Icons.list, size: 70)
                  ],
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return TaskItem(doneTasks[index]);
                  },
                  itemCount: doneTasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
