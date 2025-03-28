import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/homepage.dart';
import 'package:todo_app/screens/login_page.dart';
import 'package:todo_app/services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();
  final signUp = GlobalKey<FormState>();

  bool _isloading = false;
  void _register() async {
    setState(() {
      _isloading = true;
    });
    _userModel = UserModel(
      email: emailcontroller.text,
      password: passwordcontroller.text,
      name: namecontroller.text,
      createdAt: DateTime.now(),
      status: 1,
    );

    try {
      await Future.delayed(Duration(seconds: 3));
      final userdata = await _authService.registerUser(_userModel);
      if (userdata != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
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
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0E1D3E),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Form(
                // key: loginkey,
                key: signUp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create an Account',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: themeData.textTheme.displaySmall,

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
                        hintStyle: themeData.textTheme.displaySmall,

                        // hintStyle: themeData.textTheme.displaySmall,

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
                      style: themeData.textTheme.displaySmall,

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
                        hintStyle: themeData.textTheme.displaySmall,

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
                      style: themeData.textTheme.displaySmall,

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is Mandatory';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(
                        // labelText: "Phone Number",
                        hintText: "Enter your Name",
                        hintStyle: themeData.textTheme.displaySmall,

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
                        // Navigator.pop(context);
                        if (signUp.currentState!.validate()) {
                          _register();
                          // UserCredential userData = await FirebaseAuth.instance
                          //     .createUserWithEmailAndPassword(
                          //       email: emailcontroller.text.trim(),
                          //       password: passwordcontroller.text.trim(),
                          //     );
                          // if (userData != null) {
                          //   FirebaseFirestore.instance
                          //       .collection('Users')
                          //       .doc(userData.user!.uid)
                          //       .set({
                          //         'uid': userData.user!.uid,
                          //         'email': userData.user!.email,
                          //         'name': namecontroller.text,
                          //         'CreatedAt': DateTime.now(),
                          //         'Status': 1,
                          //       })
                          //       .then(
                          //         (value) =>
                          // Navigator.pushAndRemoveUntil(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => HomePage(),
                          //           ),
                          //           (Route<dynamic> route) =>
                          //               false, // Remove all previous routes
                          //         ),
                          //       );
                          // }
                        }
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
                          },
                          child: Text(
                            'Login',
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
}
