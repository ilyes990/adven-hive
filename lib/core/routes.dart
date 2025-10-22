import 'package:get/get.dart';
import '../UI/views/splash_view.dart';
import '../UI/views/onboarding_view.dart';
import '../UI/views/login_view.dart';
import '../UI/views/signup_view.dart';
import '../UI/views/home_view.dart';
import '../UI/views/adventure_details_view.dart';
import '../UI/views/checklist_view.dart';
import '../UI/views/bad_ui.dart';

class AppRoutes {
  // Route names
  static const String badUI = '/bad-ui';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String adventureDetails = '/adventure-details';
  static const String checklist = '/checklist';

  // Route pages
  static List<GetPage> routes = [
    GetPage(
      name: badUI,
      page: () => const BadUIView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: splash,
      page: () => const SplashView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signup,
      page: () => const SignupView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: adventureDetails,
      page: () => const AdventureDetailsView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: checklist,
      page: () => const ChecklistView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
