import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_form_field.dart';
import '../mixins/form_mixin.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage>
    with SingleTickerProviderStateMixin, BaseFormMixin {
  late TabController _tabController;
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

  void _logIn() {
    final email = _emailController.text.trim();
    if (!_existingEmails.contains(email)) {
      showError('Account not found. Please sign up.');
      return;
    }
    // TODO: Implement login request with try catch
    Navigator.pushNamed(context, '/dashboard');
  }

  void _signUp() {
    final email = _emailController.text.trim();
    if (_existingEmails.contains(email)) {
      showError('Account already exists. Please log in.');
      return;
    }
    // TODO: Implement sign up request with try catch
    Navigator.pushNamed(context, '/create_profile');
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
          validator: validateEmail,
        ),
        const SizedBox(height: AppTheme.defaultSpacing),
        CustomFormField(
          icon: Icons.lock,
          hint: "Password",
          obscure: _obscurePassword,
          controller: _passwordController,
          validator: validatePassword,
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
        buildSubmitButton(
          text: "Log in",
          onPressed: () => handleSubmit(_logIn),
        ),
      ],
    );
  }

  Widget _buildSignUpTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
          validator: validateEmail,
        ),
        const SizedBox(height: AppTheme.defaultSpacing),
        CustomFormField(
          icon: Icons.lock,
          hint: "Password",
          obscure: _obscurePassword,
          controller: _passwordController,
          validator: validatePassword,
          toggleObscure: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        const SizedBox(height: AppTheme.defaultSpacing + 4),
        buildSubmitButton(
          text: "Continue",
          onPressed: () => handleSubmit(_signUp),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildFormContainer(
      title: "InnoSync",
      subtitle: "We work it together !",
      child: Column(
        children: [
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
    );
  }
}
