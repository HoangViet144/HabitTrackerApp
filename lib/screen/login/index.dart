import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:habit_tracker_app/service/storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  List<bool> _isSelected = [true, false];
  String _error = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');

        WidgetsBinding.instance!
            .addPostFrameCallback((_) => loadGoalList(context));
        Navigator.pushNamed(context, '/dashboard');
      }
    });
  }

  void _selectOption(index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = true;
    });
  }

  void _onSubmit(context) {
    if (_isSelected[0]) {
      _loginHandler(context);
    } else {
      _registerHandler(context);
    }
  }

  void _loginHandler(context) async {
    if (_usernameController.text == "" || _passwordController.text == "") {
      setState(() {
        _error = "Empty username or password";
      });
      Timer(
        const Duration(seconds: 5),
        () => setState(() {
          _error = "";
        }),
      );
      return;
    }
    try {
      setState(() {
        _error = "";
        _isLoading = true;
      });

      await login(_usernameController.text, _passwordController.text, context);

      // Navigator.popAndPushNamed(context, '/dashboard');

      setState(() {
        _error = "";
        _isLoading = true;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Wrong username or password";
      });
      print(e.code);
    }
  }

  void _registerHandler(context) async {
    if (_usernameController.text == "" || _passwordController.text == "") {
      setState(() {
        _error = "Empty username or password";
      });
      Timer(
        const Duration(seconds: 5),
        () => setState(() {
          _error = "";
        }),
      );
      return;
    }
    try {
      setState(() {
        _error = "";
        _isLoading = true;
      });

      await register(
          _usernameController.text, _passwordController.text, context);

      // Navigator.popAndPushNamed(context, '/dashboard');

      setState(() {
        _error = "";
        _isLoading = true;
      });
    } on FirebaseAuthException catch (e) {
      String er = "";
      if (e.code == 'weak-password') {
        er = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        er = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        er = 'The email address is badly formatted.';
      } else {
        er = 'Unexpected error';
      }
      print(e);

      setState(() {
        _isLoading = false;
        _error = er;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
        _error = 'Unexpected error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/login.png"),
              fit: BoxFit.cover,
            )),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Center(
                                      child: ToggleButtons(
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 100,
                                            child: Center(child: Text("Login")),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child:
                                                Center(child: Text("Register")),
                                          )
                                        ],
                                        onPressed: (index) =>
                                            _selectOption(index),
                                        isSelected: _isSelected,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 0.5,
                                      color: Color.fromRGBO(136, 152, 170, 1.0),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        const SizedBox(height: 16.0),
                                        Image.asset(
                                          'assets/img/logo.png',
                                          height: 75,
                                        ),
                                      ],
                                    ),
                                    _error == ""
                                        ? const SizedBox(
                                            height: 50,
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                _error,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 0,
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                      ),
                                      child: TextField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          hintText: "Username",
                                          prefixIcon: const Icon(Icons.people),
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                      ),
                                      child: TextField(
                                        obscureText: true,
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon:
                                              const Icon(Icons.password),
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 50,
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 250,
                                          height: 50,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  _isLoading
                                                      ? Colors.grey
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                  Colors.white,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  top: 12,
                                                  bottom: 12,
                                                ),
                                                child: Text(
                                                  _isSelected[0]
                                                      ? "LOGIN"
                                                      : "REGISTER",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              onPressed: _isLoading
                                                  ? () {}
                                                  : () => _onSubmit(context)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
