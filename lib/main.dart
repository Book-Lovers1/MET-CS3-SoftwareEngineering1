// ignore_for_file: prefer_const_constructors
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:library_app/firebase_options.dart';
import 'Features/home/presentation/manager/bdf_preview_cubit/pdf_preview_cubit.dart';
import 'Features/home/data/data_sources/home_remote_data_source.dart';
import 'Features/home/data/repos/home_repo_impl.dart';
import 'Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'core/utils/api_services.dart';
import 'core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewestBooksCubit(
            HomeRepoImpl(
              homeRemoteDataSource: HomeRemoteDataSourceImpl(
                ApiServise(
                  Dio(),
                ),
              ),
            ),
          )..fetchNewestBooks(),
        ),
        BlocProvider(
          create: (context) => PdfPreviewCubit(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
