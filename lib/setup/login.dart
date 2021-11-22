import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../gamepage.dart';
import 'register.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email,_password;
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: false,

      body:

        Column(

          children: <Widget>[
          Center(

     child: Column(

            children: <Widget>[
              SizedBox(
                height:175,
              ),
              Container(
          decoration: BoxDecoration(
            //Here goes the same radius, u can put into a var or function



          ),
          child: ClipRRect(


            child: GestureDetector(

              child: Image(
                width: 100,


                image: NetworkImage(
                    'https://i.pinimg.com/originals/a4/04/fa/a404fa3232d26e91f8ea3a0937c3cb77.png'),),
            ),
          ),


        ),

      Form(
          key:_formKey,
          child:Center(

            child: Column(

              children:<Widget>[
                SizedBox(
                  height:35,
                ),
                SizedBox(
                  width: 300,
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
                  width: 300,
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
                SizedBox(
                  height:25,
                ),

                SizedBox(
                  width: 90,
                  child: ElevatedButton(

                    onPressed:signIn,
                      child:Text('Sign In'),
                  ),
                ),
                SizedBox(
                  height:10,
                ),
                SizedBox(
                  width:90,
                  child: ElevatedButton(

                    onPressed:navigateToRegister,
                    child:Text('Sign Up'),
                  ),
                ),

              ],
            ),
          ),
        ),]
          ),

        )
          ]
          )
    );
  }

 Future<void>signIn()async{
    Firebase.initializeApp();
    final formState=_formKey.currentState;

    if(formState!.validate()){
      formState.save();
      try {

          FirebaseAuth.instance.signInWithEmailAndPassword(

            email: _email, password: _password);
        User user = FirebaseAuth.instance.currentUser;
        Navigator.push(context,MaterialPageRoute(builder: (context)=>GamePage(user: user)));
      }catch(e){
        print(e);
      }
    }
  }
  void navigateToRegister(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
  }
}
