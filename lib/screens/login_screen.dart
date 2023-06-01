import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/styles/app_colors.dart';
import '../home_layout/home_layout.dart';
import '../provider/app_provider.dart';
import 'creat_account_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscureTextCheck = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      InkWell(
                        onTap: () {
                          provider.themeMode == ThemeMode.dark
                              ? provider.changeTheme(ThemeMode.light)
                              : provider.changeTheme(ThemeMode.dark);
                        },
                        child: Text(provider.language == "en" ? 'HI' : 'أهلًا',
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    color: Color.fromARGB(255, 137, 161, 238),
                                    fontSize: 50.sp,
                                    letterSpacing: 11.w,
                                  )
                                : GoogleFonts.cairo(
                                    color: Color.fromARGB(255, 137, 161, 238),
                                    fontSize: 50.sp,
                                  )),
                      ),
                      Text(
                          provider.language == "en"
                              ? "Welcome Back"
                              : 'مرحبًا بعودتك',
                          style: provider.language == "en"
                              ? GoogleFonts.novaSquare(
                                  color: Color.fromARGB(255, 137, 161, 238),
                                  fontSize: 45.sp,
                                )
                              : GoogleFonts.cairo(
                                  color: Color.fromARGB(255, 137, 161, 238),
                                  fontSize: 50.sp,
                                )),
                      SizedBox(
                        height: 40.h,
                      ),
                      TextFormField(
                        validator: (email) {
                          if (email!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter Email"
                                : "أدخل البريد الإلكتروني";
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
                      SizedBox(
                        height: 35.h,
                      ),
                      TextFormField(
                        validator: (password) {
                          if (password!.isEmpty) {
                            return provider.language == "en"
                                ? "Enter Password"
                                : "أدخل كلمة المرور";
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
                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                          FirebaseFunctions.login(
                              emailController.text, passwordController.text,
                              (value) {
                            AwesomeDialog(
                              dismissOnTouchOutside: false,
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.error,
                              title: provider.language == "en"
                                  ? 'Email or Password is incorrect'
                                  : 'البريد الالكتروني او كلمة المرور غير صحيحة',
                              titleTextStyle: provider.language == "en"
                                  ? GoogleFonts.novaSquare(
                                      color: Colors.red, fontSize: 22)
                                  : GoogleFonts.cairo(
                                      color: Colors.red, fontSize: 22),
                              desc: provider.language == "en"
                                  ? 'This email may not have been registered before, do you want to create a new account ?'
                                  : 'ربما لم يتم تسجيل هذا البريد الإلكتروني من قبل، هل تريد انشاء حساب جديد ؟',
                              descTextStyle: provider.language == "en"
                                  ? GoogleFonts.novaSquare(
                                      color: Colors.white, fontSize: 15)
                                  : GoogleFonts.cairo(
                                      color: Colors.white, fontSize: 15),
                              btnOkOnPress: () {
                                Navigator.pushReplacementNamed(
                                    context, CreatAccount.routName);
                              },
                              btnCancelOnPress: () {},
                            )..show();
                          }, () {
                            provider.initUser();
                            Navigator.pushReplacementNamed(
                                context, HomeLayout.routeName);
                          });
                        },
                        child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                provider.language == "en"
                                    ? "LOGIN"
                                    : "تسجيل الدخول",
                                style: provider.language == "en"
                                    ? GoogleFonts.novaSquare(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.w)
                                    : GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                            )),
                      ),
                      MaterialButton(
                        minWidth: 1.w,
                        onPressed: () {
                          Navigator.pushNamed(context, ForgotPassword.routName);
                        },
                        child: Text(
                            provider.language == "en"
                                ? 'Forgot Password ?'
                                : "نسيت كلمة السر ؟",
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    color: Colors.indigo,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w900,
                                  )
                                : GoogleFonts.cairo(
                                    color: Colors.indigo,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w900,
                                  )),
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.language == "en"
                                ? "Don't have an account?"
                                : "ليس لديك حساب؟",
                            style: provider.language == "en"
                                ? GoogleFonts.novaSquare(
                                    fontWeight: FontWeight.w600)
                                : GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600),
                          ),
                          MaterialButton(
                            minWidth: 1.w,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreatAccount.routName);
                            },
                            child: Text(
                                provider.language == "en"
                                    ? 'SIGN UP'
                                    : "تسجيل حساب جديد",
                                style: provider.language == "en"
                                    ? GoogleFonts.novaSquare(
                                        color: Colors.purpleAccent,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : GoogleFonts.cairo(
                                        color: Colors.purpleAccent,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
