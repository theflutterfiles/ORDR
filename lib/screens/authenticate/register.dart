import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/home/homeScreen.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/shared/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {

  final Function toggleView; //property
  Register({this.toggleView}); //constructor

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>(); //= to global key of form sate
  //used to identify the form with the key

  final TextEditingController _controller = TextEditingController();
  bool loading = false;


  //tracking state
  String error = "";

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  User _user = new User();
  
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

    Widget _buildDisplayTextField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: TextFormField(
              //autofocus: true,
              controller: _controller,
              validator: (val) => val.isEmpty
                  ? "Enter display name"
                  : null, //return null or helper text
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                setState(() => _user.displayName = val
                );
              },
              onFieldSubmitted: (val) {
                _formKey.currentState.validate();
              },
              keyboardType: TextInputType.text,
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
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your display name',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                    fontSize: 13.0,
                  ),
              ),
            ),
          ),
        ],
      );
    }



    Widget _buildEmailTextField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: TextFormField(
              validator: (val) {
                if(val.isEmpty)
                  return "Enter email address";
                if(EmailValidator.validate(val) == true)
                  return null;
                else
                  return "Enter valid email";
              },
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                setState(() => _user.email = val);
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
                    fontSize: 13.0,
                  ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildPasswordTextField() {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: TextFormField(
              controller: _pass,
              validator: (val) => val.length < 6
                  ? "   Password must be at least 6 characters long"
                  : null,
              obscureText: true,
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                setState(() => _user.password = val);
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
                    fontSize: 13.0,
                  ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildConfirmPasswordTextField() {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: TextFormField(
              controller: _confirmPass,
              validator: (val){
                if(val.isEmpty)
                  return 'Enter password';
                if(val != _pass.text)
                  return 'Passwords do not match';
                      return null;
              },
              obscureText: true,
              onChanged: (val) {
                //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
                String confirmPassword;
                                setState(() => confirmPassword = val);
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
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                    fontSize: 13.0,
                  ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildSignupButton(){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0, ),
        width: double.infinity,
        child: RaisedButton(
          color: Colors.white,
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () async{
            if(_formKey.currentState.validate()){
              setState(() => loading = true);
              AuthResult result = await registerWitEmailAndPassword(_user, authNotifier);
              print(_user.email + " - " + _user.password);
              
              if(result == null){
                setState(() => loading = false);
                setState(() => error = 'User already exists! Please sign in.');
                
              }else if(result != null){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage())
                );
              }
            }
            
          },
          child: Text(
            'SIGN UP',
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

    Widget _buildSignInLink(){
      return RichText(
        text: TextSpan(children: [
          TextSpan(text: 'Already have an account? ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
          TextSpan(text: 'Sign In',
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

    return loading ? Loading() : Scaffold(
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
                  Color(0xff4BB9AA),
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
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Register',
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
                          _buildDisplayTextField(),
                          SizedBox(height: 20.0,),
                          _buildEmailTextField(),
                          SizedBox(height: 20.0,),
                          _buildPasswordTextField(),
                          SizedBox(height: 20.0,),
                          _buildConfirmPasswordTextField(),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          _buildSignupButton(),
                          Container(
                            height: 30.0,
                            child: GestureDetector(
                              onTap: () =>  Navigator.pushReplacementNamed(context, "sign in"),
                              child: _buildSignInLink(),
                            ) ,
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
