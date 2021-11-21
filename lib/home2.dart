import 'package:flutter/material.dart';

import 'dart:math';
import 'cactus.dart';
import 'cloud.dart';

import 'dino.dart';
import 'game-object.dart';
import 'ground.dart';


class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2>
with SingleTickerProviderStateMixin {
  Dino dino = Dino();
  double runDistance = 0;
  double runVelocity = 30;
  late AnimationController worldController;
  Duration lastUpdateCall = Duration();

  List<Cactus> cacti = [Cactus(worldLocation: Offset(200, 0))];
  List<Ground> ground = [
    Ground(worldLocation: Offset(0, 0)),
    Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
  ];

  List<Cloud> clouds = [
    Cloud(worldLocation: Offset(100, 20)),
    Cloud(worldLocation: Offset(200, 10)),
    Cloud(worldLocation: Offset(350, -10)),
  ];
  @override
  void initState() {
    super.initState();
    worldController =
        AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();
  }

  void _die() {
    setState(() {
      worldController.stop();
      dino.die();
    });
  }

  _update() {
    dino.update(lastUpdateCall, worldController.lastElapsedDuration!);
    double elapsedTimeSeconds =
        (worldController.lastElapsedDuration! - lastUpdateCall).inMilliseconds /
            1000;
    runDistance += runVelocity * elapsedTimeSeconds;

    Size screenSize = MediaQuery.of(context).size;

    Rect dinoRect = dino.getRect(screenSize, runDistance);
    for (Cactus cactus in cacti) {
      Rect obstacleRect = cactus.getRect(screenSize, runDistance);
      if (dinoRect.overlaps(obstacleRect)) {
        _die();
      }
      if (obstacleRect.right < 0) {
        setState(() {
          cacti.remove(cactus);
          cacti.add(Cactus(
              worldLocation:
              Offset(runDistance + Random().nextInt(100) + 50, 0)));
        });
      }
    }
    for (Ground groundlet in ground) {
      if (groundlet.getRect(screenSize, runDistance).right < 0) {
        setState(() {
          ground.remove(groundlet);
          ground.add(Ground(
              worldLocation: Offset(
                  ground.last.worldLocation.dx + groundSprite.imageWidth / 10,
                  0)));
        });
      }
    }
      lastUpdateCall = worldController.lastElapsedDuration!;
    }
    @override
    Widget build(BuildContext context) {
      Size screenSize = MediaQuery
          .of(context)
          .size;
      List<Widget> children = [];
      for (GameObject object in [...clouds, ...ground,...cacti, dino]) {
        children.add(AnimatedBuilder(
            animation: worldController,
            builder: (context, _) {
              Rect objectRect = object.getRect(screenSize, runDistance);
              return Positioned(
                left: objectRect.left,
                top: objectRect.top,
                width: objectRect.width,
                height: objectRect.height,
                child: object.render(),
              );
            }));
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Dino Runs!'),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dino.jump();
          },
          child: Stack(
            alignment: Alignment.center,
            children: children,
          ),
        ),
      );
    }
  }


