import 'package:flutter/material.dart';
import '../theme/dimensions.dart';
import '../widgets/tab_selector.dart';
import '../widgets/spacing.dart';
import '../widgets/login_tab.dart';
import '../widgets/signup_tab.dart';
import '../widgets/form_container.dart';
import '../utils/ui_helpers.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Temporary container for emails
  final List<String> _existingEmails = [
    'existinguser@example.com',
    '3ilim69@gmail.com',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      if (!_existingEmails.contains(email)) {
        UIHelpers.showError(context, 'Account not found. Please sign up.');
        return;
      }
      // TODO: Implement login request with try catch
      Navigator.pushNamed(context, '/main');
    }
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      if (_existingEmails.contains(email)) {
        UIHelpers.showError(context, 'Account already exists. Please log in.');
        return;
      }
      // TODO: Implement sign up request with try catch
      Navigator.pushNamed(context, '/create_profile');
    }
  }

  Widget _buildLoginTab() {
    return LoginTab(
      emailController: _emailController,
      passwordController: _passwordController,
      rememberMe: _rememberMe,
      onRememberMeChanged: (value) =>
          setState(() => _rememberMe = value ?? false),
      onForgotPassword: () {
        // TODO: Implement forgot password
      },
      onLogin: _logIn,
    );
  }

  Widget _buildSignUpTab() {
    return SignupTab(
      emailController: _emailController,
      passwordController: _passwordController,
      onSignup: _signUp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: _formKey,
      title: "InnoSync",
      subtitle: "We work it together !",
      child: Column(
        children: [
          TabSelector(
            controller: _tabController,
            tabLabels: const ['Log In', 'Sign Up'],
          ),
          const VSpace.mediumPlusPlus(),
          FixedHeightSpace(
            height: AppDimensions.tabViewHeight,
            child: TabBarView(
              controller: _tabController,
              children: [_buildLoginTab(), _buildSignUpTab()],
            ),
          ),
        ],
      ),
    );
  }
}
