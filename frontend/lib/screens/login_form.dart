import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/validated_text_field.dart';
import '../widgets/tab_selector.dart';
import '../widgets/remember_me_checkbox.dart';
import '../widgets/spacing.dart';
import '../mixins/validation_mixin.dart';
import '../mixins/ui_mixin.dart';
import '../mixins/form_widgets_mixin.dart';
import '../mixins/form_logic_mixin.dart';
import '../services/api_service.dart';
import '../utils/token_storage.dart'; // где реализованы saveToken/getToken
import 'dashboard_page.dart'; // импортируй DashboardPage

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage>
    with
        SingleTickerProviderStateMixin,
        ValidationMixin,
        UIMixin,
        FormWidgetsMixin,
        FormLogicMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final _fullNameController = TextEditingController();

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

  void _logIn() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;
  try {
    final String? token = await ApiService.login(email, password);
    if (token != null) {
      await saveToken(token); // сохраняем токен для будущих запросов
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage(token: token)),
      );
    } else {
      showError('Login failed. Check your email and password.');
    }
  } catch (e) {
    showError('Connection error.');
  }
}

void _signUp() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;
  final fullName = _fullNameController.text.trim();
  try {
    final success = await ApiService.signup(email, password, fullName);
    if (success) {
      // Immediately log in after signup
      final String? token = await ApiService.login(email, password);
      if (token != null) {
        await saveToken(token);
        Navigator.pushNamed(
          context,
          '/create_profile',
          arguments: {'email': email, 'name': fullName},
        );
      } else {
        showError('Could not log in after signup.');
      }
    } else {
      showError('Registration error. Email may already exist.');
    }
  } catch (e) {
    showError('Server connection error.');
  }
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
          hint: "Name",
          controller: _fullNameController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Enter Name';
            }
            return null;
          },
        ),
        const VSpace.medium(),
        ValidatedTextField(
          icon: Icons.email,
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
