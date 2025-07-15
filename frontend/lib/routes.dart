import 'screens/login_form.dart';
import 'screens/profile_creation_page.dart';
import 'screens/discover_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/settings_page.dart';

final appRoutes = {
  '/login': (context) => const LoginFormPage(),
  '/create_profile': (context) => const ProfileCreationPage(),
  '/discover': (context) => const DiscoverPage(),
  '/dashboard': (context) => const DashboardPage(),
  '/settings': (context) => const SettingsPage(),
};
