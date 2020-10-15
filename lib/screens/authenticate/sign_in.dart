import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/home/homeScreen.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/shared/loading.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {

  final Function toggleView; //property
  SignIn({this.toggleView}); //constructor

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>(); //= to global key of form sate
  

  
  String error = "";
  bool loading = false;

  User user = new User();
  

  @override
  void initState() {
    final AuthNotifier _authNotifier = Provider.of<AuthNotifier>(context, listen: true);
    initializeCurrentUser(_authNotifier);
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {

     

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    Widget _buildEmailTextField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) return "Enter email address";
                if (EmailValidator.validate(val) == true)
                  return null;
                else
                  return "Enter valid email";
              },
              //validator: (val) => "Enter Email";
              //? "Enter email"
              //: null, //return null or helper text
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                setState(() => user.email = val);
              },
              onFieldSubmitted: (val) {
                _formKey.currentState.validate();
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Color(0xff0E2352),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'example@example.com',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                  )),
            ),
          ),
        ],
      );
    }

    Widget _buildPasswordTextField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              validator: (val) => val.length < 6
                  ? "Password must be at least 6 characters long"
                  : null,
              obscureText: true,
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                setState(() => user.password = val);
              },
              onFieldSubmitted: (val) {
                _formKey.currentState.validate();
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Color(0xff0E2352),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                  )),
            ),
          ),
        ],
      );
    }

    Widget _buildLoginButton() {
      return Container(
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              setState(() => loading = true);
              dynamic result =
                  await signInWitEmailAndPassword(user, authNotifier);
              if (result == null) {
                setState(() => loading = false);
                setState(() => error = 'Incorrect email/password');
              } else if (result != null) {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => HomePage()));
              }
            }
          },
          child: Text(
            'SIGN IN',
            style: TextStyle(
              letterSpacing: 1.5,
              color: Color(0xff0E2352),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildForgotPasswordBtn() {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          padding: EdgeInsets.only(right: 0.0),
          onPressed: () {
            print("forgot password");
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildSignUpLink() {
      return RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 12.0,
            ),
          ),
        ]),
      );
    }

    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xfffbe30b),
                        Color(0xff208294),
                        Color(0xff0E5187),
                        Color(0xff0E2352),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildEmailTextField(),
                                SizedBox(
                                  height: 40.0,
                                ),
                                _buildPasswordTextField(),
                                _buildForgotPasswordBtn(),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                ),
                                _buildLoginButton(),
                                Container(
                                  height: 30.0,
                                  child: GestureDetector(
                                    onTap: () =>  Navigator.pushReplacementNamed(context, "register"),
                                    child: _buildSignUpLink(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
