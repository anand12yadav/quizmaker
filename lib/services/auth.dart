import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizmaker/models/user.dart';

class AuthService{
   
FirebaseAuth _auth=FirebaseAuth.instance;

User userFromFirebaseUser(FirebaseUser user){
  return user != null? User(uid: user.uid) :null;
}

Future signInWithEmailAndPass(String email,String password) async{
     try{
     AuthResult authResult= await _auth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=authResult.user;
    return userFromFirebaseUser(firebaseUser);
     }catch(e){
       print(e.toString());
     }
   }

Future signUpWithEmailAndPassword(String email,String password) async{
     try{
       AuthResult authResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser firebaseUser=  authResult.user;
       return userFromFirebaseUser(firebaseUser);
       
     }
     catch(e){
       print(e.toString());
     }
   }
Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
    
  }
}