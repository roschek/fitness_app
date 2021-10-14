import 'package:fit_proj/pages/main_page.dart';
import 'package:fit_proj/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:fit_proj/domain/user.dart';

import 'domain/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const ErrorWidget();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<LocalUser?>.value(
            value: AuthService().currentUser,
            initialData: null,
            catchError: (_, __) => null,
            child: MaterialApp(
                title: 'Custom Fitness',
                theme: ThemeData(
                    primaryColor: const Color.fromRGBO(50, 65, 85, 1),
                    textTheme: const TextTheme(subtitle1:TextStyle(color: Colors.white))
                ),
                home: MainPage()
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }


}


class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: const [
              Text('Something wrong')
            ],
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: const [
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}


