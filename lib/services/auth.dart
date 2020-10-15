import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';




  // //create custom user object based on firebase user
  // User _userFromFirebaseUser(FirebaseUser user) {
  //   print(user.email);
  //   return user != null
  //       ? User(
  //           uid: user.uid,
  //           displayName: user.displayName,
  //           email: user.email)
  //       : null;
  // }

  //sign in anon - asynchronous task returns Future
  // Future signInAnon() async {
  //   try {
  //     //try sign in anonymously - knows which backend via google service.json
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user; //gains us access to the user object
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in email and password
  signInWitEmailAndPassword(User currentUser, AuthNotifier authNotifier) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: currentUser.email,
            password: currentUser.password).catchError((error) => print(error.code)); //get response from the function
    if(authResult != null){
      FirebaseUser firebaseUser = authResult.user;
      if(firebaseUser != null){
        print("LOGGED IN: $firebaseUser");
        authNotifier.setUser(firebaseUser);
      }
    }
  }

  //register with email and password
  registerWitEmailAndPassword(
      User currentUser, AuthNotifier authNotifier) async {
   
      AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: currentUser.email,
          password: currentUser.password).catchError((error) => print(error.code)); //get response from the function
      if (authResult != null) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = currentUser.displayName;

        FirebaseUser firebaseUser = authResult.user;

        if (firebaseUser != null) {
          await firebaseUser.updateProfile(updateInfo);

          await firebaseUser.reload();

          print("Sign up: $firebaseUser");

          FirebaseUser thisUser = await FirebaseAuth.instance.currentUser();
          authNotifier.setUser(thisUser);
        }
      }

      // _firestore
      //     .collection('users')
      //     .document(currentUserUid)
      //     .setData({'email': currentUser.email, 'displayName': currentUser.displayName});
  }

  //sign out
  signOut(AuthNotifier authNotifier) async {
   
      await FirebaseAuth.instance.signOut()
      .catchError((error) => print(error.code)); //built into FireBaseAuth library
      authNotifier.setUser(null);
   
  }

  initializeCurrentUser(AuthNotifier authNotifier) async {

    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    if (firebaseUser != null) {
      print("INITIALISED CURRENT USER: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }

