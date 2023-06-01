import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/app_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  provider.language == "en"
                      ? Text(
                          AppLocalizations.of(context)!.darkMood,
                          style: GoogleFonts.novaSquare(),
                        )
                      : Text(AppLocalizations.of(context)!.darkMood,
                          style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    provider.themeMode == ThemeMode.dark
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  provider.language == "en"
                      ? Text(
                          AppLocalizations.of(context)!.lightMood,
                          style: GoogleFonts.novaSquare(),
                        )
                      : Text(AppLocalizations.of(context)!.lightMood,
                          style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    provider.themeMode == ThemeMode.light
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.system);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  provider.language == "en"
                      ? Text(
                          AppLocalizations.of(context)!.systemMood,
                          style: GoogleFonts.novaSquare(),
                        )
                      : Text(AppLocalizations.of(context)!.systemMood,
                          style: GoogleFonts.cairo()),
                  const Spacer(),
                  Icon(
                    provider.themeMode == ThemeMode.system
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 35,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Brightness.light == Theme.of(context).brightness
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark),
        ),
        Icon(Icons.check,
            color: Brightness.light == Theme.of(context).brightness
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text, context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
