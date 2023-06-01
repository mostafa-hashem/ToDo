import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';
import '../styles/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  static const String routName = "ForgotPassword";
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.language == "en"
                          ? "Enter E-Mail to send verification code"
                          : "أدخل البريد الإلكتروني لإرسال رمز التحقق",
                      style: provider.language == "en"
                          ? GoogleFonts.novaSquare(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: provider.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white)
                          : GoogleFonts.cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: provider.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            emailController.clear();
                            Navigator.pushNamed(
                                context, ForgotPassword.routName);
                          }
                        },
                        child:
                            Text(provider.language == "en" ? 'Send' : "إرسال",
                                style: provider.language == "en"
                                    ? GoogleFonts.novaSquare(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
