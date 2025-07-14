import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/validated_text_field.dart';
import '../widgets/tab_selector.dart';
import '../widgets/remember_me_checkbox.dart';
import '../widgets/spacing.dart';
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
  bool _rememberMe = false;

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

  Widget _buildLoginTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidatedTextField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
          validator: validateEmail,
        ),
        const VSpace.medium(),
        ValidatedTextField(
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
        const VSpace.small(),
        RememberMeCheckbox(
          value: _rememberMe,
          onChanged: (value) => setState(() => _rememberMe = value ?? false),
          onForgotPassword: () {
            // TODO: Implement forgot password
          },
        ),
        const VSpace.mediumMinus(),
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
        ValidatedTextField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
          validator: validateEmail,
        ),
        const VSpace.medium(),
        ValidatedTextField(
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
        const VSpace.mediumPlus(),
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
          TabSelector(
            controller: _tabController,
            tabLabels: const ['Log In', 'Sign Up'],
          ),
          const VSpace.mediumPlusPlus(),
          FixedHeightSpace(
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
