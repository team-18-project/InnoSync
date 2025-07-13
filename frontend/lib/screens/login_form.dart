import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_form_field.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

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

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _logIn() {
    if (_loginFormKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      if (!_existingEmails.contains(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account not found. Please sign up.')),
        );
        return;
      }
      // TODO: Implement login request with try catch
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  void _signUp() {
    if (_signUpFormKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      if (_existingEmails.contains(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account already exists. Please log in.'),
          ),
        );
        return;
      }
      // TODO: Implement sign up request with try catch
      Navigator.pushNamed(context, '/create_profile');
    }
  }

  Widget _buildTabSelector() {
    return Container(
      height: AppTheme.tabHeight,
      decoration: AppTheme.tabSelectorDecoration,
      child: TabBar(
        controller: _tabController,
        indicator: AppTheme.tabIndicatorDecoration,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'Log In'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  Widget _buildLoginTab() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            icon: Icons.person,
            hint: "Email",
            controller: _emailController,
            validator: _validateEmail,
          ),
          const SizedBox(height: AppTheme.defaultSpacing),
          CustomFormField(
            icon: Icons.lock,
            hint: "Password",
            obscure: _obscurePassword,
            controller: _passwordController,
            validator: _validatePassword,
            toggleObscure: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          const SizedBox(height: AppTheme.smallSpacing),
          Row(
            children: [
              Checkbox(value: false, onChanged: (_) {}),
              const Text("Remember me"),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(color: AppTheme.linkColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.defaultSpacing - 2),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: _logIn,
            child: const Text("Log in", style: AppTheme.buttonTextStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpTab() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            icon: Icons.person,
            hint: "Email",
            controller: _emailController,
            validator: _validateEmail,
          ),
          const SizedBox(height: AppTheme.defaultSpacing),
          CustomFormField(
            icon: Icons.lock,
            hint: "Password",
            obscure: _obscurePassword,
            controller: _passwordController,
            validator: _validatePassword,
            toggleObscure: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          const SizedBox(height: AppTheme.defaultSpacing + 4),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: _signUp,
            child: const Text("Continue", style: AppTheme.buttonTextStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: AppTheme.containerWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.defaultPadding,
              vertical: AppTheme.defaultPadding,
            ),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Inno",
                        style: AppTheme.appTitleStyle.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: "Sync",
                        style: AppTheme.appTitleStyle.copyWith(
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "We work it together !",
                  style: AppTheme.appSubtitleStyle,
                ),
                const SizedBox(height: AppTheme.largeSpacing),
                _buildTabSelector(),
                const SizedBox(height: AppTheme.defaultSpacing + 8),
                SizedBox(
                  height: AppTheme.tabViewHeight,
                  child: TabBarView(
                    controller: _tabController,
                    children: [_buildLoginTab(), _buildSignUpTab()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
