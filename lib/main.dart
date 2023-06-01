import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/provider/app_provider.dart';
import 'package:todo/screens/creat_account_screen.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/screens/forget_password_screen.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/settings_tab.dart';
import 'package:todo/screens/tasks.dart';
import 'package:todo/styles/my_theme.dart';
import 'firebase_options.dart';
import 'home_layout/home_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyAppProvider(), child: ToDoApp()));
}

class ToDoApp extends StatelessWidget {
  late MyAppProvider provider;

  @override
  Widget build(BuildContext context) {
    getPreferences();
    provider = Provider.of<MyAppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: provider.firebaseUser != null
              ? HomeLayout.routeName
              : LoginScreen.routName,
          routes: {
            LoginScreen.routName: (c) => LoginScreen(),
            CreatAccount.routName: (c) => CreatAccount(),
            HomeLayout.routeName: (c) => HomeLayout(),
            TaskTab.routeName: (c) => TaskTab(),
            SettingsTab.routeName: (c) => SettingsTab(),
            EditTask.routeName: (c) => EditTask(),
            ForgotPassword.routName: (c) => ForgotPassword(),
          },
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          themeMode: provider.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.language),
        );
      },
    );
  }

  void getPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    provider.changeLanguage(language!);
    if (prefs.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    } else if (prefs.getString('theme') == 'system') {
      provider.changeTheme(ThemeMode.system);
    } else {
      provider.changeTheme(ThemeMode.light);
    }
  }
}
