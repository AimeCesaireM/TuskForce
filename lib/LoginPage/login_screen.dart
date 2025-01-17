import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tusk_force/Services/global_variables.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imgURL = loginWallpaperFall;

    // Conditional rendering of the loading screen based on the wallpaper

    late Color conditionalProgressBgColor;
    late Color conditionalProgressTextColor;

    if (imgURL == loginWallpaperWinter) {
      conditionalProgressBgColor = Colors.white60;
      conditionalProgressTextColor = Colors.blue;
    }
    else if (imgURL == loginWallpaperSummer){
      conditionalProgressBgColor = Colors.brown.shade300;
      conditionalProgressTextColor = Colors.red;
    }
    else {
      conditionalProgressBgColor = Colors.lightGreen;
      conditionalProgressTextColor = Colors.lightBlueAccent;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: conditionalProgressBgColor,

            child: Center(
              child: CircularProgressIndicator(
                color: conditionalProgressTextColor,
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: imgURL,
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
        ],
      ),
    );
  }
}
