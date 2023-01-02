import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated, verifying }

class AuthRepository with ChangeNotifier {
  final FirebaseAuth? _auth;
  final FirebaseFirestore firestore;
  User? _user;
  Status _status = Status.uninitialized;

  AuthRepository.instance({required this.firestore}) : _auth = FirebaseAuth.instance {
    _auth!.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User get user => _user!;

  Future<bool> signIn(String email, String password,String name) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth!.signInWithEmailAndPassword(email: email, password: password).then((creds) {
        FirebaseFirestore.instance.collection('users').doc(creds.user?.uid).get().then((doc) {
         if (doc.data()!=null && (doc.data()?['name'] != name)) {
          //FirebaseFirestore.instance.collection('users').doc(creds.user?.uid).update({'name':name});
        
         }else{
          // FirebaseFirestore.instance.collection('users').doc(creds.user?.uid).set({
          //   'email':creds.user?.email,
          //   'name':creds.user?.displayName??name,
          //   'url':creds.user?.photoURL??'',
          //   'userId':creds.user?.uid
          //  });
         }
          } );
      });
     // await checkEmailVerified();
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }
   Future<bool> signUp(String email, String password,String name) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      UserCredential creds  = await _auth!.createUserWithEmailAndPassword(email: email, password: password);
      if (creds.user!=null) {
       // creds.user?.sendEmailVerification().then((value) {
          // Fluttertoast.showToast(msg: 'Check your inbox for verification email');
           FirebaseFirestore.instance.collection('users').doc(creds.user?.uid).set({
            'email':creds.user?.email,
            'name':creds.user?.displayName??name,
            'url':creds.user?.photoURL??'',
            'userId':creds.user?.uid
           });
       // });
      }
      return true;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth!.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    }
    // else if(!firebaseUser.emailVerified){
    //   _status = Status.verifying;
    // }
    else {
      _user = firebaseUser;
      _status = Status.authenticated;
    }
    notifyListeners();
  }
  // Future<void> checkEmailVerified()async{
  //   User? firebaseUser =  FirebaseAuth.instance.currentUser;
  //   await firebaseUser?.reload();
  //    try {
  //     await firebaseUser?.reload();
      
  //     if(firebaseUser!.emailVerified){
  //       _status = Status.authenticated;
  //       Fluttertoast.showToast(msg: 'Email verified');
  //       notifyListeners();
  //     }else{
  //      Fluttertoast.showToast(msg: 'Email not yet verified');
  //     }
  //    } catch (e) {
  //      _status = Status.verifying;
  //      Fluttertoast.showToast(msg: 'Something went wrong');
  //      notifyListeners();
  //    }
  // }

}