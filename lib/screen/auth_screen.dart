import 'package:flutter/material.dart';
import '../screen/home_screen.dart';

import '../provider/auth.dart';

class Authscreen extends StatefulWidget {
  static const route = "./Authscreen";
  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Auth auth = Auth();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.green,
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 10,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 80.0),
                Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 100.0),
                Card(
                  margin: const EdgeInsets.all(32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const SizedBox(height: 20.0),
                      Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.grey.shade800,
                            ),
                      ),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        child: Text(
                          "Google Sign-in",
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () {
                          {
                            auth.signin().then((value) {
                              if (value == null) {
                                Navigator.of(context)
                                    .pushReplacementNamed(Authscreen.route);
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed(Homescreen.route);
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          shadowColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      FlatButton(
                        child: Text(
                          "Continue as Guest",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Homescreen.route);
                        },
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
