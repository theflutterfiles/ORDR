import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/shared/loading.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool loading = false;
  User _user = User();
  String error = "";

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      setState(() {
        setState(() => loading = false);
      });
      return;
    }

    setState(() => loading = true);

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    AuthResult _authResult;

    if (_authMode == AuthMode.Login) {
      _authResult = signInWitEmailAndPassword(_user, authNotifier);
      if (_authResult == null) {
        setState(() {
          setState(() => loading = false);
          setState(() => error = 'Error signing in.');
        });
      }
    } else {
      _authResult = registerWitEmailAndPassword(_user, authNotifier);
      if (_authResult == null) {
        setState(() {
          setState(() => loading = false);
          setState(() => error = 'Error signing up.');
        });
      }
    }
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Display Name",
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Display Name is required';
        }

        if (value.length < 5 || value.length > 12) {
          return 'Display Name must be betweem 5 and 12 characters';
        }

        return null;
      },
      onFieldSubmitted: (val) {
        _formKey.currentState.validate();
      },
      onChanged: (value) {
        setState(() {
          _user.displayName = value;
        });
      },
      onSaved: (String value) {
        _user.displayName = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      //initialValue: 'julian@food.com',
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null;
      },
      onChanged: (val) {
        //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
        setState(() => _user.email = val);
      },
      onFieldSubmitted: (val) {
        _formKey.currentState.validate();
      },

      onSaved: (String value) {
        _user.email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
      onChanged: (val) {
        //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
        setState(() => _user.password = val);
      },
      onFieldSubmitted: (val) {
        _formKey.currentState.validate();
      },
      onSaved: (String value) {
        _user.password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "Confirm password is required";
        }
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }
        return null;
      },
      onFieldSubmitted: (val) {
        _formKey.currentState.validate();
      },
    );
  }

  Widget _buildSignInLink() {
    return GestureDetector(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: _authMode == AuthMode.Login
                ? 'Don\'t have an account? '
                : 'Already have an account? ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: _authMode == AuthMode.Login ? 'Sign Up' : 'Sign in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 12.0,
            ),
          ),
        ]),
      ),
      onTap: () {
        setState(() {
          _authMode =
              _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff4BB9AA),
                    Color(0xff208294),
                    Color(0xff0E5187),
                    Color(0xff0E2352),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          _authMode == AuthMode.Login ? 'Sign In' : 'Register',
                          textAlign: TextAlign.center,
                          style:
                              AppThemes.display1.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 32),
                        _authMode == AuthMode.Signup
                            ? _buildDisplayNameField()
                            : Container(),
                        _buildEmailField(),
                        _buildPasswordField(),
                        _authMode == AuthMode.Signup
                            ? _buildConfirmPasswordField()
                            : Container(),
                        SizedBox(height: 30),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 100),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 25.0,
                          ),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 5.0,
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () => _submitForm(),
                            child: Text(
                              _authMode == AuthMode.Login ? 'Login' : 'Signup',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                color: Color(0xff0E2352),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        _buildSignInLink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
