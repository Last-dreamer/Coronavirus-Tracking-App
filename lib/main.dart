import 'package:coronavirus_tracking_app/app/UI/dashboard.dart';
import 'package:coronavirus_tracking_app/app/repositories/data_repository.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:coronavirus_tracking_app/app/services/data_cache_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = "es_US";
  await initializeDateFormatting("en",null).then((value) => null);

 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   statusBarColor: Color(0xFF222222), // transparent status bar
 ));
  final sharedPreference = await SharedPreferences.getInstance();
  runApp( MyApp(sharedPreferences: sharedPreference,));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
          apiService: APIService(API.fromSandBox()),
          dataCacheService: DataCacheService(sharedPreferences: sharedPreferences)
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,  
        title: 'Covid 19 Tracking App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF101010),
          cardColor: const Color(0xFF222222)
        ),
        home: const DashBoard(),
      ),
    );
  }
}
