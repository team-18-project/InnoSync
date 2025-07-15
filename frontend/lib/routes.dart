import 'screens/login_form.dart';
import 'screens/profile_creation_page.dart';
import 'screens/dashboard_page.dart';

final appRoutes = {
  '/login': (context) => const LoginFormPage(),
  '/create_profile': (context) => const ProfileCreationPage(),
  // '/dashboard': (context) => const DashboardPage(),
};
