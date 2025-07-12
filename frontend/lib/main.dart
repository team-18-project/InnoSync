import 'package:flutter/material.dart';

void main() {
  runApp(const InnoSyncApp());
}

class InnoSyncApp extends StatelessWidget {
  const InnoSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isPasswordVisible = false;
  bool rememberMe = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    VoidCallback? togglePassword,
  }) {
    return TextField(
      obscureText: obscure && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green),
        suffixIcon: hint == "Password"
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.green,
          ),
          onPressed: togglePassword,
        )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.green,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicator: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(6),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: "Log In"),
          Tab(text: "Sign Up"),
        ],
      ),
    );
  }

  Widget _buildForm(bool isLogin) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _buildTextField(hint: "Email", icon: Icons.person),
          const SizedBox(height: 16),
          _buildTextField(
            hint: "Password",
            icon: Icons.lock,
            obscure: true,
            togglePassword: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          const SizedBox(height: 8),
          if (isLogin)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) {
                        setState(() => rememberMe = val ?? false);
                      },
                    ),
                    const Text("Remember me"),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(isLogin ? "Log in" : "Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopDecoration() {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(160),
                ),
              ),
              child: const Center(
                child: Text(""), // Placeholder for top-left curve
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(160),
                ),
              ),
              child: const Center(
                child: Text(""), // Placeholder for top-right curve
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: const [
        Text.rich(
          TextSpan(
            text: "Inno",
            style: TextStyle(
              fontSize: 32,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "Sync",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          "We work it together !",
          style: TextStyle(
            fontSize: 14,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopDecoration(),
          _buildLogo(),
          const SizedBox(height: 20),
          _buildTabSelector(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildForm(true),
                _buildForm(false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
