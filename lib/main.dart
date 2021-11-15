import 'dart:io';

import 'bloc/dictionary_cubit.dart';
import 'repo/word_repo.dart';
import 'screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        child: HomeScreen(),
        create: (context) => DictionaryCubit(WordRepository()),
      ),
    );
  }
}
