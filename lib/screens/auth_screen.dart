import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {

  const AuthScreen({super.key});

  @override

  State<AuthScreen> createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLogin = true;

  bool loading = false;

  bool hidePassword = true;

  final Color background = const Color(0xFF080808);

final Color cardColor = const Color(0xFF151515);

final Color accent = const Color(0xFFFF5A36);

final Color darkText = const Color(0xFFFFFFFF);

  @override

  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();

  }

  Future<void> submit() async {

    final email = emailController.text.trim();

    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {

      showMessage('Please enter your email and password.');

      return;

    }

    if (password.length < 6) {

      showMessage('Password must be at least 6 characters.');

      return;

    }

    setState(() {

      loading = true;

    });

    try {

      final auth = FirebaseAuth.instance;

      if (isLogin) {

        await auth.signInWithEmailAndPassword(

          email: email,

          password: password,

        );

      } else {

        await auth.createUserWithEmailAndPassword(

          email: email,

          password: password,

        );

      }

    } on FirebaseAuthException catch (e) {

      String message;

      switch (e.code) {

        case 'invalid-email':

          message = 'The email address is not valid.';

          break;

        case 'user-not-found':

          message = 'No account exists with this email.';

          break;

        case 'wrong-password':

        case 'invalid-credential':

          message = 'The email or password is incorrect.';

          break;

        case 'email-already-in-use':

          message = 'An account already exists with this email.';

          break;

        case 'weak-password':

          message = 'The password is too weak.';

          break;

        case 'user-disabled':

          message = 'This account has been disabled.';

          break;

        case 'network-request-failed':

          message = 'Network error. Check your internet connection.';

          break;

        case 'too-many-requests':

          message = 'Too many attempts. Try again later.';

          break;

        case 'operation-not-allowed':

          message =

              'Email/password authentication is not enabled in Firebase.';

          break;

        default:

          message =

              'Firebase error: ${e.code}\n${e.message ?? 'No additional message'}';

      }

      showMessage(message);

    } catch (e) {

      showMessage('Error: $e');

    } finally {

      if (mounted) {

        setState(() {

          loading = false;

        });

      }

    }

  }

  Future<void> forgotPassword() async {

    final email = emailController.text.trim();

    if (email.isEmpty) {

      showMessage('Enter your email first.');

      return;

    }

    try {

      await FirebaseAuth.instance.sendPasswordResetEmail(

        email: email,

      );

      showMessage('Password reset email sent.');

    } on FirebaseAuthException catch (e) {

      showMessage(

        e.message ?? 'Unable to send password reset email.',

      );

    }

  }

  void showMessage(String message) {

    if (!mounted) return;

    ScaffoldMessenger.of(context)

      ..hideCurrentSnackBar()

      ..showSnackBar(

        SnackBar(

          content: Text(message),

          duration: const Duration(seconds: 4),

        ),

      );

  }

  BoxDecoration softShadow({

    Color color = const Color(0xFFFFF4EA),

    double radius = 22,

  }) {

    return BoxDecoration(

      color: color,

      borderRadius: BorderRadius.circular(radius),

      boxShadow: const [

        BoxShadow(

          color: Color(0x40B86F50),

          offset: Offset(8, 8),

          blurRadius: 18,

        ),

        BoxShadow(

          color: Color(0xFFFFFFFF),

          offset: Offset(-7, -7),

          blurRadius: 16,

        ),

      ],

    );

  }

  InputDecoration fieldDecoration({

    required String hint,

    required IconData icon,

    Widget? suffix,

  }) {

    return InputDecoration(

      hintText: hint,

      hintStyle: TextStyle(

        color: darkText.withOpacity(0.42),

        fontSize: 16,

      ),

      prefixIcon: Icon(

        icon,

        color: accent,

      ),

      suffixIcon: suffix,

      filled: true,

      fillColor: background,

      contentPadding: const EdgeInsets.symmetric(

        horizontal: 20,

        vertical: 19,

      ),

      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,

      ),

      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,

      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(

          color: accent.withOpacity(0.65),

          width: 1.5,

        ),

      ),

    );

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: background,

      body: SafeArea(

        child: Stack(

          children: [

            SingleChildScrollView(

              padding: const EdgeInsets.fromLTRB(

                28,

                35,

                28,

                70,

              ),

              child: Column(

                children: [

                  const SizedBox(height: 10),

                  // PULSE icon

                  Container(

                    width: 86,

                    height: 86,

                    decoration: BoxDecoration(

                      color: background,

                      shape: BoxShape.circle,

                      boxShadow: const [

                        BoxShadow(

                          color: Color(0x40B86F50),

                          offset: Offset(7, 7),

                          blurRadius: 15,

                        ),

                        BoxShadow(

                          color: Color(0xFFFFFFFF),

                          offset: Offset(-6, -6),

                          blurRadius: 14,

                        ),

                      ],

                    ),

                    child: Icon(

                      Icons.favorite_rounded,

                      size: 43,

                      color: accent,

                    ),

                  ),

                  const SizedBox(height: 20),

                  Text(

                    'PULSE',

                    style: TextStyle(

                      color: darkText,

                      fontSize: 34,

                      fontWeight: FontWeight.w900,

                      letterSpacing: 3,

                    ),

                  ),

                  const SizedBox(height: 7),

                  Text(

                    isLogin

                        ? 'Welcome back'

                        : 'Create your account',

                    style: TextStyle(

                      color: darkText.withOpacity(0.65),

                      fontSize: 17,

                    ),

                  ),

                  const SizedBox(height: 32),

                  Container(

                    width: double.infinity,

                    padding: const EdgeInsets.fromLTRB(

                      24,

                      28,

                      24,

                      26,

                    ),

                    decoration: softShadow(

                      color: cardColor,

                      radius: 30,

                    ),

                    child: Column(

                      crossAxisAlignment:

                          CrossAxisAlignment.stretch,

                      children: [

                        Text(

                          isLogin ? 'Log in' : 'Sign up',

                          style: TextStyle(

                            color: darkText,

                            fontSize: 28,

                            fontWeight: FontWeight.w800,

                          ),

                        ),

                        const SizedBox(height: 7),

                        Text(

                          isLogin

                              ? 'Enter your details to continue'

                              : 'Join PULSE and discover your world',

                          style: TextStyle(

                            color: darkText.withOpacity(0.55),

                            fontSize: 14,

                          ),

                        ),

                        const SizedBox(height: 25),

                        TextField(

                          controller: emailController,

                          keyboardType:

                              TextInputType.emailAddress,

                          style: TextStyle(

                            color: darkText,

                            fontSize: 16,

                          ),

                          decoration: fieldDecoration(

                            hint: 'Email address',

                            icon: Icons.email_outlined,

                          ),

                        ),

                        const SizedBox(height: 16),

                        TextField(

                          controller: passwordController,

                          obscureText: hidePassword,

                          style: TextStyle(

                            color: darkText,

                            fontSize: 16,

                          ),

                          decoration: fieldDecoration(

                            hint: 'Password',

                            icon: Icons.lock_outline_rounded,

                            suffix: IconButton(

                              onPressed: () {

                                setState(() {

                                  hidePassword = !hidePassword;

                                });

                              },

                              icon: Icon(

                                hidePassword

                                    ? Icons.visibility_outlined

                                    : Icons.visibility_off_outlined,

                                color: accent,

                              ),

                            ),

                          ),

                        ),

                        if (isLogin) ...[

                          const SizedBox(height: 8),

                          Align(

                            alignment: Alignment.centerRight,

                            child: TextButton(

                              onPressed:

                                  loading ? null : forgotPassword,

                              child: Text(

                                'Forgot Password?',

                                style: TextStyle(

                                  color: accent,

                                  fontWeight: FontWeight.w700,

                                ),

                              ),

                            ),

                          ),

                        ],

                        const SizedBox(height: 14),

                        SizedBox(

                          height: 56,

                          child: ElevatedButton(

                            onPressed: loading ? null : submit,

                            style: ElevatedButton.styleFrom(

                              backgroundColor: accent,

                              foregroundColor: Colors.white,

                              elevation: 5,

                              shadowColor:

                                  accent.withOpacity(0.45),

                              shape: RoundedRectangleBorder(

                                borderRadius:

                                    BorderRadius.circular(18),

                              ),

                            ),

                            child: loading

                                ? const SizedBox(

                                    width: 25,

                                    height: 25,

                                    child:

                                        CircularProgressIndicator(

                                      strokeWidth: 3,

                                      color: Colors.white,

                                    ),

                                  )

                                : Text(

                                    isLogin

                                        ? 'LOGIN'

                                        : 'CREATE ACCOUNT',

                                    style: const TextStyle(

                                      fontSize: 16,

                                      fontWeight: FontWeight.w800,

                                      letterSpacing: 1,

                                    ),

                                  ),

                          ),

                        ),

                        const SizedBox(height: 20),

                        GestureDetector(

                          onTap: loading

                              ? null

                              : () {

                                  setState(() {

                                    isLogin = !isLogin;

                                  });

                                },

                          child: RichText(

                            textAlign: TextAlign.center,

                            text: TextSpan(

                              style: TextStyle(

                                color: darkText.withOpacity(0.55),

                                fontSize: 14,

                              ),

                              children: [

                                TextSpan(

                                  text: isLogin

                                      ? "Don't have an account? "

                                      : 'Already have an account? ',

                                ),

                                TextSpan(

                                  text: isLogin

                                      ? 'Sign up'

                                      : 'Log in',

                                  style: TextStyle(

                                    color: accent,

                                    fontWeight: FontWeight.w800,

                                  ),

                                ),

                              ],

                            ),

                          ),

                        ),

                      ],

                    ),

                  ),

                ],

              ),

            ),

            // DMJEH corner branding

            Positioned(

              right: 18,

              bottom: 14,

              child: Text(

                'DMJEH',

                style: TextStyle(

                  color: darkText.withOpacity(0.42),

                  fontSize: 11,

                  fontWeight: FontWeight.w800,

                  letterSpacing: 2,

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}