import 'dart:math';

import 'package:flutter/material.dart';


abstract class GameObject {
  Offset position;
  Size size;


  GameObject({required this.position, required this.size});

  Widget render(Animation<double> controller, Size unitSize) => AnimatedBuilder(
    animation: controller,
    builder: (context, child) => Positioned(
        top: position.dy * unitSize.height,
        left: position.dx * unitSize.width,
        width: size.width * unitSize.width,
        height: size.height * unitSize.height,
        child: renderGameObject(unitSize)),
  );

  Widget renderGameObject(Size unitSize);

  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
}

class Ball extends GameObject {
  Offset direction;
  double speed;

  Ball({required Offset position, required this.direction, required this.speed})
      : super(position: position, size: Size(.5, .5));

  @override
  Widget renderGameObject(Size unitSize) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(100), offset: Offset(10, 10))
          ]),
    );
  }
}



class Brick extends GameObject {
  Color color;

  Brick({required Offset position, required this.color})
      : super(position: position, size: Size(2, 1));

  @override
  Widget renderGameObject(Size unitSize) {
    return Container(decoration: BoxDecoration(
        color:color,
        border: Border.all(color: Colors.black)

    ),) ;
  }

}


class Paddle extends GameObject {
  double speed = 10.0;

  bool left = false;
  bool right = false;

  double desiredLength = 3.0;

  Paddle({required Offset position}) : super(position: position, size: Size(3.0, .7));

  @override
  Widget renderGameObject(Size unitSize) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.red.shade700,
                  Colors.red.shade300,
                  Colors.red.shade600,
                  Colors.red.shade800,
                ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(100), offset: Offset(10, 10))
            ]),
        child: Center(
          child: Container(
              width: (size.width * unitSize.width) * .7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.shade700,
                      Colors.grey.shade300,
                      Colors.grey.shade600,
                      Colors.grey.shade800,
                      Colors.black,
                    ]),
              )),
        ));
  }
}

class ArkanoidGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArkanoidGameState();
}

class _ArkanoidGameState extends State<ArkanoidGame>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Size worldSize;
  late Paddle paddle;
  late List<Ball> balls;
  late List<Brick> bricks;
  bool gameHasStarted = true;

  int prevTimeMS = 0;

  int score = 0;
  @override
  void initState() {
    gameHasStarted = true;
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(days: 99));
    controller.addListener(update);
    worldSize = Size(18.0, 25.0);
    paddle = Paddle(position: Offset(9.0 - 3.0 / 2, 23.0));
    balls = [
      Ball(
          position: Offset(8.3, 20),
          direction: Offset.fromDirection(-.9),
          speed: 9)
    ];
    bricks = [
   Brick(position:Offset(2,2),color:Colors.green),
      Brick(position:Offset(2,2),color:Colors.green),
      Brick(position:Offset(4,2),color:Colors.green),
      Brick(position:Offset(6,2),color:Colors.green),
      Brick(position:Offset(10,2),color:Colors.green),
      Brick(position:Offset(12,2),color:Colors.green),

      Brick(position:Offset(1.5,3),color:Colors.green),
      Brick(position:Offset(3.5,3),color:Colors.green),
      Brick(position:Offset(5.5,3),color:Colors.green),
      Brick(position:Offset(8.5,3),color:Colors.green),
      Brick(position:Offset(10.5,3),color:Colors.green),
      Brick(position:Offset(12.5,3),color:Colors.green),
      Brick(position:Offset(2,4),color:Colors.green),
      Brick(position:Offset(4,4),color:Colors.green),
      Brick(position:Offset(6,4),color:Colors.green),
      Brick(position:Offset(10,4),color:Colors.green),
      Brick(position:Offset(12,4),color:Colors.green),
      Brick(position:Offset(1.5,5),color:Colors.green),
      Brick(position:Offset(3.5,5),color:Colors.green),
      Brick(position:Offset(5.5,5),color:Colors.green),
      Brick(position:Offset(8.5,5),color:Colors.green),
      Brick(position:Offset(10.5,5),color:Colors.green),


   ];

    prevTimeMS = DateTime.now().millisecondsSinceEpoch;
    controller.forward();
  }


  void update() {
    int currTimeMS = DateTime.now().millisecondsSinceEpoch;
    int deltaMS = currTimeMS - prevTimeMS;
    double deltaS = deltaMS / 1000.0;


    List<Brick> destroyedBricks = [];


    if (paddle.desiredLength > paddle.size.width) {
      double growthAmount = .5 * deltaS;
      paddle.size = Size(paddle.size.width + growthAmount, paddle.size.height);
      paddle.position =
          Offset(paddle.position.dx - growthAmount / 2, paddle.position.dy);
    }
    if (paddle.left && paddle.position.dx > 0) {
      paddle.position = Offset(
          paddle.position.dx - paddle.speed * deltaS, paddle.position.dy);
    }
    if (paddle.right &&
        paddle.position.dx + paddle.size.width < worldSize.width) {
      paddle.position = Offset(
          paddle.position.dx + paddle.speed * deltaS, paddle.position.dy);
    }
    Rect paddleRect = paddle.rect;



    for (Ball ball in balls) {
      ball.position = ball.position + ball.direction * ball.speed * deltaS;
      if (ball.position.dx + ball.size.width > worldSize.width) {
        ball.position =
            Offset(worldSize.width - ball.size.width, ball.position.dy);
        ball.direction = Offset(-ball.direction.dx, ball.direction.dy);
      }
      if (ball.position.dx < 0) {
        ball.position = Offset(0, ball.position.dy);
        ball.direction = Offset(-ball.direction.dx, ball.direction.dy);
      }
      if (ball.position.dy < 0) {
        ball.position = Offset(ball.position.dx, 0);
        ball.direction = Offset(ball.direction.dx, -ball.direction.dy);
      } if (ball.position.dy + ball.size.height > worldSize.height) {
         gameHasStarted = false;

      }
      Rect ballRect = ball.rect;
      if (paddleRect.overlaps(ballRect)) {
        Rect intersection = ballRect.intersect(paddleRect);
        if (intersection.height < intersection.width &&
            ball.position.dy < paddle.position.dy) {
          // ball is hitting the face of the paddle
          ball.position =
              Offset(ball.position.dx, ball.position.dy - intersection.height);
          double paddlePct =
              (ball.position.dx + ball.size.width / 2 - paddle.position.dx) /
                  paddle.size.width;
          double maxAngle = pi * .8;
          ball.direction =
              Offset.fromDirection(-maxAngle + maxAngle * paddlePct);
        } else if (ball.position.dx < paddle.position.dx) {
          ball.position =
              Offset(paddle.position.dx - ball.size.width, ball.position.dy);
          ball.direction =
              Offset(-ball.direction.dx.abs(), ball.direction.dy.abs());
        } else if (ballRect.right > paddleRect.right) {
          ball.position = Offset(paddle.position.dx, ball.position.dy);
          ball.direction =
              Offset(-ball.direction.dx.abs(), ball.direction.dy.abs());
        } else {
          ball.position = Offset(ball.position.dx, paddleRect.bottom);
          ball.direction = Offset(0, ball.direction.dy.abs());
        }
      }
    for ( Brick brick in bricks ){
      Rect brickRect=brick.rect;
      if(brickRect.overlaps(ballRect)){
        score+=100;
        destroyedBricks.add(brick);
        Rect intersection=brickRect.intersect(ballRect);
        if(intersection.height>intersection.width){
          ball.position=Offset(
            ball.position.dx,ball.position.dy-intersection.width*ball.direction.dy.sign);
          ball.direction=Offset(-ball.direction.dx,ball.direction.dy);

        }else{
          ball.position=Offset(
              ball.position.dx,ball.position.dy-intersection.width*ball.direction.dy.sign);
          ball.direction=Offset(ball.direction.dx,-ball.direction.dy);

        }
      }


    }


    }
   if(destroyedBricks.isNotEmpty){
     setState(() {
       for (Brick destroyedBrick in destroyedBricks) {
           bricks.remove(destroyedBrick);
       }
     });
   }

    prevTimeMS = currTimeMS;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Arkenoid'),
        ),
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              children: [
                SizedBox(
                  height:10,
                ),
                Text(
                  "HIGH SCORE",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  "$score",
                  style: TextStyle(color: Colors.white),
                ),
                Container(

                  child: AspectRatio(
                    aspectRatio: worldSize.aspectRatio,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        Size unitSize = Size(
                            constraints.maxWidth / worldSize.width,
                            constraints.maxHeight / worldSize.height);
                        List<Widget> gameObjects = [];
                        gameObjects.add(paddle.render(controller, unitSize));
                        gameObjects.addAll(
                            balls.map((b) => b.render(controller, unitSize)));

                        gameObjects.addAll(
                            bricks.map((b) => b.render(controller, unitSize)));

                        return Stack(
                          children: gameObjects,
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Btn(
                              child: Icon(Icons.arrow_left, size: 60),
                              down: () => paddle.left = true,
                              up: () => paddle.left = false,  ),
                    ),
                    Expanded(
                      child: Btn(
                            child: Icon(Icons.arrow_right, size: 60),
                            down: () => paddle.right = true,
                            up: () => paddle.right = false),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class Btn extends StatelessWidget {
  final void Function() down;
  final void Function() up;
  final Widget child;

  const Btn({ Key ?key, required this.down, required this.up, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Center(child: child),
        ),
        onTapDown: (details) => down(),
        onTapCancel: up,
        onTapUp: (details) => up());
  }
}




