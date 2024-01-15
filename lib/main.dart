import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/data_repo.dart';

import 'view/home_screen/home_page.dart';

import 'constants/custom_theme.dart';
import 'view_model/bloc/data_bloc_bloc.dart';

Future<void> main() async {
  log(
    "App started",
  );
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: RepositoryProvider(
        create: (context) => DataRepo(),
        child: BlocProvider(
          create: (context) => DataBlocBloc(dataRepo: context.read<DataRepo>())
            ..add(LoadDataFromFirestoreApiEvent()),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
