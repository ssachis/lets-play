import 'package:flutter/material.dart';

import "home2.dart";

import "Home.dart";



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Builder(
          builder: (context) {
            return Scaffold(
              body: Column(


                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      'choose an option',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        //fontFamily:'IndieFlower',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(

                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      child: GestureDetector(
                        onTap: () {
                          _navigateToNextScreen2(context);
                        },
                        child: Image(
                          width: 300,
                          image: NetworkImage(
                              'https://psmag.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTI3NTgyMjIwOTYwNjM1MzU4/flappy-bird.jpg'),),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      child: GestureDetector(
                        onTap: () {
                          _navigateToNextScreen(context);
                        },
                        child: Image(
                          width: 300,
                          image: NetworkImage(

                              "https://images.crazygames.com/games/chrome-dino/thumb-1584433985643.png?auto=format,compress&q=75&cs=strip&ch=DPR&w=1200&h=630&fit=crop"),),
                      ),
                    ),
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
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _navigateToNextScreen2(BuildContext context2) {
    Navigator.of(context2)
        .push(MaterialPageRoute(builder: (context) => Home2()));
  }
}