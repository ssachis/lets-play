import 'dart:async';
import 'barriers.dart';
import 'package:flutter/material.dart';
import 'package:game/bird.dart';
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone=1.8;
  double barrierXtwo=barrierXone+1.5;
  int score = 0;
  int highscore = 0;
  @override
  void initState() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialheight = birdYaxis;
      barrierXone = 1.8;
      barrierXtwo = barrierXone+1.5;

      gameHasStarted = false;
      score = 0;
   super.initState();
  }
void onInit(){
    setState((){
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialheight = birdYaxis;
      barrierXone = 1.8;
      barrierXtwo = barrierXone+1.5;

      gameHasStarted = false;
      score = 0;

    });

}

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }
bool checkBarrierLost(){
  if (barrierXone < 0.2 && barrierXone > -0.2) {
    if (birdYaxis < -0.3 || birdYaxis > 0.7) {
      return true;
    }
  }
  if (barrierXtwo < 0.2 && barrierXtwo > -0.2) {
    if (birdYaxis < -0.8 || birdYaxis > 0.4) {
      return true;
    }
  }
    return false;
}
  void startGame() {
    gameHasStarted = true;
   Timer.periodic(Duration(milliseconds: 60), (timer) {
     time += 0.05;
     height = -4.9 * time * time + 2.8 * time;

     setState(() {
       birdYaxis = initialheight - height;
       if (barrierXone < -2) {
         score++;
         barrierXone += 4.5;
       } else {
         barrierXone -= 0.04;
       }
       if (barrierXtwo < -2) {
         score++;

         barrierXtwo += 4.5;
       } else {
         barrierXtwo -= 0.04;
       }
     });

      if (birdYaxis > 1.3||checkBarrierLost()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();

      }

  });

}
void _showDialog(){
showDialog(context: context,
    builder: (dialogContext) {
  return AlertDialog(
    backgroundColor:Colors.brown,
    title:Text('game over',
    style:TextStyle(color: Colors.white),
  ),
    content:Text(
      'Score ${score.toString()}',
      style:TextStyle(color:Colors.white),
    ),
    actions:[
      TextButton(
      onPressed:(){
        if(score>highscore){
          highscore=score;
        }
        onInit();
        setState((){
          gameHasStarted=false;
        });
        Navigator.of(dialogContext,rootNavigator: true).pop();


  },
      child:Text(
      'Start Again',
      style:TextStyle(color:Colors.white),
      )
  ),

    ],

  );


  },

);

}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        if(gameHasStarted){
          jump();
    }else{
          startGame();
    }
    },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Flappy Bird'),
        ),
        body: Column(

          children: [
            Expanded(
              flex: 2,
              child: Stack(

                children: [
                  AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird()),
                  Container(
                    alignment: Alignment(0, -0.3),

                    child: gameHasStarted ?Text(" ") : Text("T A P  T O  P L A Y",
                        style: TextStyle(
                          fontSize: 20,
                          color:Colors.white,
                        )),
                  ),
                  AnimatedContainer(
                    alignment:Alignment(barrierXone,1.1),
                    duration:Duration(milliseconds:0),
                    child: MyBarrier(

                      size:200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment:Alignment(barrierXone,-1.1),
                    duration:Duration(milliseconds:0),
                    child: MyBarrier(

                      size:150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment:Alignment(barrierXtwo,1.1),
                    duration:Duration(milliseconds:0),
                    child: MyBarrier(

                      size:100.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment:Alignment(barrierXtwo,-1.1),
                    duration:Duration(milliseconds:0),
                    child: MyBarrier(

                      size:170.0,
                    ),
                  ),

                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.green[400],
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SCORE",
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 20),
                        Text(score.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BEST",
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 20),
                        Text(highscore.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
