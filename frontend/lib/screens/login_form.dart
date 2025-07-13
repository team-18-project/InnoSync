import 'package:flutter/material.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
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
    super.dispose();
  }

  void _logIn(String email) {
    if (email.isEmpty) {
      throw Exception('Email is required.');
    }
    if (!_existingEmails.contains(email)) {
      throw Exception('Account not found. Please sign up.');
    }
    // TODO: Implement login request
  }

  void _signUp(String email) {
    if (email.isEmpty) {
      throw Exception('Email is required.');
    }
    if (_existingEmails.contains(email)) {
      throw Exception('Account already exists. Please log in.');
    }
    // TODO: Implement sign up request
  }

  Widget _buildTabSelector() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.green,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'Log In'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hint,
    bool obscure = false,
    VoidCallback? toggleObscure,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.green,
                ),
                onPressed: toggleObscure,
              )
            : null,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _buildLoginTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
        ),
        const SizedBox(height: 12),
        _buildInputField(
          icon: Icons.lock,
          hint: "Password",
          obscure: _obscurePassword,
          toggleObscure: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Checkbox(value: false, onChanged: (_) {}),
            const Text("Remember me"),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password ?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              try {
                _logIn(_emailController.text.trim());
                Navigator.pushNamed(context, '/dashboard');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString().replaceFirst('Exception: ', '')),
                  ),
                );
              }
            },
            child: const Text("Log in", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          icon: Icons.person,
          hint: "Email",
          controller: _emailController,
        ),
        const SizedBox(height: 12),
        _buildInputField(
          icon: Icons.lock,
          hint: "Password",
          obscure: _obscurePassword,
          toggleObscure: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              try {
                _signUp(_emailController.text.trim());
                Navigator.pushNamed(context, '/create_profile');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString().replaceFirst('Exception: ', '')),
                  ),
                );
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7FD),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Inno",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Sync",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "We work it together !",
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
                const SizedBox(height: 25),
                _buildTabSelector(),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
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
