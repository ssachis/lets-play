import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String _email,_password;
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:AppBar(
    title:Text('sign in'),
    ),
    body:
    Form(
    key:_formKey,
    child:Center(

    child: Column(

    children:<Widget>[
    SizedBox(
    height:200,
    ),
    SizedBox(
    width: 350,
    child: TextFormField(

    validator:(input){
    if(input!.isEmpty){
    return 'Please type an email';
    }
    },
    onSaved:(input)=>_email=input!,
    decoration:InputDecoration(

    labelText:'Email',
    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0)
    ), ),
    ),
    ),

    SizedBox(
    height:10,
    ),
    SizedBox(
    width: 350,
    child: TextFormField(
    validator:(input){
    if(input!.length<6){
    return 'your password must be 6 char';
    }
    },
    onSaved:(input)=>_password=input!,
    decoration:InputDecoration(
    labelText:'Password',
    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0)
    ),
    ),
    obscureText:true,
    ),

    ),
      ElevatedButton(

        onPressed:signUp,
        child:Text('Sign Up'),
      ),

    ],
    ),
    ),
    ),
    );

  }

  Future<void>signUp()async{
    Firebase.initializeApp();
    final formState=_formKey.currentState;

    if(formState!.validate()){
      formState.save();
      try {

        FirebaseAuth.instance.createUserWithEmailAndPassword(

            email: _email, password: _password);

        User user = FirebaseAuth.instance.currentUser;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
      }catch(e){
        print(e);
      }
    }
  }
}

