import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'repository/data_repo.dart';

import 'view/home_screen/home_page.dart';

import 'constants/custom_theme.dart';
import 'view_model/data_bloc/data_bloc_bloc.dart';
import 'view_model/suggested_videos_bloc/suggested_videos_bloc.dart';

Future<void> main() async {
  log(
    "App started",
  );
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => DataRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  DataBlocBloc(dataRepo: context.read<DataRepo>())
                    ..add(LoadDataFromFirestoreApiEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  SuggestedVideosBloc(dataRepo: context.read<DataRepo>()),
            ),
          ],
          child: MaterialApp(
            title: "NUHA",
            debugShowCheckedModeBanner: false,
            theme: customTheme,
            home: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const HomePage()),
            ),
          ),
        ));
  }
}
