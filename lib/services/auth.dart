import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create new volunteer based on FirebaseUser
  Volunteer _volunteerFromFirebaseUser(FirebaseUser user) {
    return user != null ? Volunteer(uid: user.uid, email: user.email) : null;
  }

  // authantication change user stream
  Stream<Volunteer> get user {
    return _auth.onAuthStateChanged.map(_volunteerFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnonymously() async {

    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the volunteer with uid
      await DatabaseService(uid: user.uid).updateUserData(email);

      return _volunteerFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }
}