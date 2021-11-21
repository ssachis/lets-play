import 'package:flutter/material.dart';

import 'home2.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      Builder(
          builder: (context) {
            return Scaffold(
              body: Column(


                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      'choose your game!',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontFamily:'IndieFlower',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Container(
              decoration: BoxDecoration(
              //Here goes the same radius, u can put into a var or function

              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              boxShadow: [
              BoxShadow(
              color: Color(0x54000000),
              spreadRadius:4,
              blurRadius: 20,
              ),
              ],
              ),
              child: ClipRRect(

              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          child: GestureDetector(
                            onTap: () {
                              _navigateToNextScreen2(context);
                            },
                            child: Image(
                              width: 300,

                              image: NetworkImage(
                                  'https://www.thefactsite.com/wp-content/uploads/2014/02/flappy-bird-facts.jpg'),),
                          ),
                      ),


                        ),


                          ]
                          ),
            ),


                  SizedBox(
                    height: 50.0,
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            //Here goes the same radius, u can put into a var or function

                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x54000000),
                                spreadRadius:4,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ClipRRect(

                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            child: GestureDetector(
                              onTap: () {
                                _navigateToNextScreen(context);
                              },
                              child: Image(
                                width: 300,
                                image: NetworkImage(
                                    'https://images.crazygames.com/games/chrome-dino/thumb-1584433985643.png?auto=format,compress&q=75&cs=strip&ch=DPR&w=1200&h=630&fit=crop'),),
                            ),
                          ),


                        ),


                      ]
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Home2()));
  }

  void _navigateToNextScreen2(BuildContext context2) {
    Navigator.of(context2)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

}