import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import '../home_layout/home_layout.dart';
import '../provider/app_provider.dart';
import '../styles/app_colors.dart';

class CreatAccount extends StatefulWidget {
  static const String routName = "CreatAccount";

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  final _formKey = GlobalKey<FormState>();

  bool obscureTextCheck = true;

  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  var selectedDate = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          provider.themeMode == ThemeMode.light
              ? Image.asset(
                  "assets/images/login_screen.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/splash_dark_bg.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          provider.themeMode == ThemeMode.dark
                              ? provider.changeTheme(ThemeMode.light)
                              : provider.changeTheme(ThemeMode.dark);
                        },
                        child: Text(
                          provider.language == "en"
                              ? "Create New Account"
                              : "إنشاء حساب جديد",
                          style: provider.language == "en"
                              ? GoogleFonts.novaSquare(
                                  fontSize: 30.sp,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w600)
                              : GoogleFonts.cairo(
                                  fontSize: 30.sp,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                  Column(
                    children: [
                      TextFormField(
                        validator: (email) {
                          if (email!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter User Name"
                                : "أدخل إسم المستخدم";
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z\d]([._](?![._])|[a-zA-Z\d]){1,18}[a-zA-Z\d]$")
                              .hasMatch(email);
                          if (!emailValid) {
                            return provider.language == "en"
                                ? "Enter Valid User Name"
                                : "أدخل إسم مستخدم صالح";
                          }
                          return null;
                        },
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppCloros.lightColor),
                          ),
                          label: Text(
                            provider.language == "en"
                                ? "User Name"
                                : "إسم المستخدم",
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    color: AppCloros.lightColor,
                                  )
                                : GoogleFonts.cairo(
                                    color: AppCloros.lightColor,
                                  ),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      TextFormField(
                        validator: (email) {
                          if (email!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter Email"
                                : "أدخل البريد الإلكتروني";
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          if (!emailValid) {
                            return provider.language == "en"
                                ? "Enter Valid Email"
                                : "أدخل بريد إلكتروني صالح";
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppCloros.lightColor),
                          ),
                          label: Text(
                            provider.language == "en"
                                ? "Email"
                                : "البريد الإلكتروني",
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    color: AppCloros.lightColor,
                                  )
                                : GoogleFonts.cairo(
                                    color: AppCloros.lightColor,
                                  ),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          suffix: Icon(
                            Icons.alternate_email,
                            color: AppCloros.lightColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      TextFormField(
                        validator: (password) {
                          if (password!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter Password"
                                : "أدخل كلمة المرور";
                          } else if (password.length < 6) {
                            return provider.language == "en"
                                ? "Password length shouldn't be less than 6 characters"
                                : "يجب ألا يقل طول كلمة المرور عن 6 أحرف";
                          }
                          bool passwordValid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#$&*~]).{8,}$')
                              .hasMatch(password);
                          if (!passwordValid) {
                            return provider.language == "en"
                                ? "Enter Valid Password"
                                : "أدخل كلمة مرور صالحة";
                          }
                          return null;
                        },
                        obscureText: obscureTextCheck,
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: Text(
                              provider.language == "en"
                                  ? "Password"
                                  : "كلمة المرور",
                              style: provider.language == "en"
                                  ? GoogleFonts.novaSquare(
                                      color: AppCloros.lightColor,
                                    )
                                  : GoogleFonts.cairo(
                                      color: AppCloros.lightColor,
                                    ),
                            ),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppCloros.lightColor),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    obscureTextCheck = !obscureTextCheck;
                                  });
                                },
                                child: obscureTextCheck
                                    ? const Icon(
                                        Icons.visibility,
                                        color: AppCloros.lightColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: AppCloros.lightColor,
                                      ))),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: (age) {
                          if (age!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter Your Age"
                                : "أدخل عمرك";
                          }
                          return null;
                        },
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppCloros.lightColor),
                          ),
                          label: Text(
                            provider.language == "en" ? "Age" : "العمر",
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    color: AppCloros.lightColor,
                                  )
                                : GoogleFonts.cairo(
                                    color: AppCloros.lightColor,
                                  ),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                          ),
                          suffix: Icon(
                            Icons.date_range,
                            color: AppCloros.lightColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        width: 230.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: MaterialButton(
                          minWidth: 1.w,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseFunctions.creatAccount(
                                  emailController.text,
                                  userNameController.text,
                                  int.parse(ageController.text),
                                  passwordController.text, (value) {
                                provider.initUser();
                                Navigator.pushReplacementNamed(
                                    context, HomeLayout.routeName);

                              });
                            }
                          },
                          child: Text(
                              provider.language == "en"
                                  ? 'Create Account'
                                  : "إنشاء حساب",
                              style: provider.language == "en"
                                  ? GoogleFonts.novaSquare(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w300,
                                    )
                                  : GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w300,
                                    )),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  void chooseDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 2)));
    if (selectedDate != null) {
      selectedDate = DateUtils.dateOnly(selectedDate);
    }
    setState(() {});
  }
}
