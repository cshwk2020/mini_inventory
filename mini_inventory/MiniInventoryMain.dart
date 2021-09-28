
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryReportingProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/repository/ICounterRepository.dart';
import 'package:mini_inventory/mini_inventory/theme/MiniInventoryTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'MiniInventoryHomeBottomBar.dart';
import 'MiniInventoryHomeDrawer.dart';

import 'db/CounterDbHelper.dart';
import 'model/AppGlobal.dart';





class MiniInventoryMain extends StatefulWidget {

  MiniInventoryMain({Key key}): super(key: key);



  @override
  State<StatefulWidget> createState() => MiniInventoryMainState();

}

class MiniInventoryMainState extends State<MiniInventoryMain> {

  @override
  void initState() {

    print("BEFORE INIT DB...");



    print("AFTER INIT DB...");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = "en";


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingProvider>(
            create: (context) => SettingProvider()),
        ChangeNotifierProvider<CounterProvider>(
            create: (context) => CounterProvider()),
        ChangeNotifierProvider<ReportingProvider>(
            create: (context) => ReportingProvider.getInstance()),
        ChangeNotifierProvider<AppNavProvider>(
            create: (context) => AppNavProvider()),


      ],
      child: Consumer2<SettingProvider, CounterProvider>(

          builder: (context, setting_provider, counterProvider, child) {
            return MaterialApp(

              localizationsDelegates: [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,

              ],
              supportedLocales: [
                Locale('en', ''),
                const Locale.fromSubtags(languageCode: 'zh'),
                // generic Chinese 'zh'
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hans'),
                // generic simplified Chinese 'zh_Hans'
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant'),
                // generic traditional Chinese 'zh_Hant'
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
                // 'zh_Hans_CN'
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
                // 'zh_Hant_TW'
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
                // 'zh_Hant_HK'

              ],


              theme: setting_provider.getAppThemeData(),
              title: "Mini Inventory",
              home: MiniInventoryHomeBottomBar()



            );
          }

      ),

    );
  }

}