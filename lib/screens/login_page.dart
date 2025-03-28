import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/homepage.dart';
import 'package:todo_app/screens/sign_up_page.dart';
import 'package:todo_app/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  // final loginkey = GlobalKey<FormState>();
  final loginkey = GlobalKey<FormState>();
  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();
  bool _isloading = false;
  void _login() async {
    setState(() {
      _isloading = true;
    });
    try {
      _userModel = UserModel(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );

      final data = await _authService.loginUser(_userModel);
      if (data != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isloading = false;
      });
      List err = e.toString().split("]");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Form(
                // key: loginkey,
                key: loginkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login to your Account',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an Email Id';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        // labelText: "Phone Number",
                        hintText: "Enter your Email",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: const BorderSide(color: Colors.red),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 186, 10, 213),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      // maxLength: 10,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Mandatory';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        // labelText: "Phone Number",
                        hintText: "Enter your Password",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: const BorderSide(color: Colors.red),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 186, 10, 213),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      // maxLength: 10,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 40),

                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 50),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 8, 79, 136),
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        if (loginkey.currentState!.validate()) {
                          _login();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isloading,
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _login() async {
  //   UserCredential userData = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //         email: emailcontroller.text.trim(),
  //         password: passwordcontroller.text.trim(),
  //       );
  //   if (userData != null) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //       (Route<dynamic> route) => false, // Remove all previous routes
  //     );
  //   }
  // }
}
