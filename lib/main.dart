import 'package:coronavirus_tracking_app/app/UI/dashboard.dart';
import 'package:coronavirus_tracking_app/app/repositories/data_repository.dart';
import 'package:coronavirus_tracking_app/app/services/api.dart';
import 'package:coronavirus_tracking_app/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API.fromSandBox())),
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
