import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/error.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 230,
            left: 160,
            child: Text('Oh no!'),
          ),
          const Positioned(
            bottom: 170,
            left: 100,
            child: Text(
              'Something went wrong,\nplease try again.',
              textAlign: TextAlign.center,
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 130,
            right: 130,
            child: Text('Try again'),
          ),
        ],
      ),
    );
  }
}
