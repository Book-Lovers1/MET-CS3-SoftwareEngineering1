import 'package:library_app/Features/auth/presentation/views/login_screen.dart';
import 'package:library_app/Features/auth/presentation/views/register_screen.dart';
import 'package:library_app/Features/search/presentation/views/search_view.dart';

import '../../Features/home/domain/entities/book_entity.dart';
import '../../Features/home/presentation/views/book_details_view.dart';
import '../../Features/home/presentation/views/home_view.dart';
//import '../../Features/search/presentaion/views/search_view.dart';
import 'package:go_router/go_router.dart';

import '../../Features/home/presentation/views/pdf_preview.dart';
import '../../Features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/HomeView';
  static const kBookDetailsView = '/BookDetailsView';
  static const kPDFPreview = '/PDFPreview';
  static const kLoginPage = '/LoginPage';
  static const kRegisterPage = '/RegisterPage';
  static const kSearchView = '/searchView';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: kRegisterPage,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: kLoginPage,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kSearchView,
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: kBookDetailsView,
      builder: (context, state) => BookDetailsView(
        book: state.extra as BookEntity,
      ),
    ),
    // GoRoute(
    //   path: kPDFPreview,
    //   builder: (context, state) => const PDFPreview(),
    // ),
  ]);
}
