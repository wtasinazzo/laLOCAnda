import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/pages/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  void _enterApp(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => Home())));
    });
  }
      
   
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () => _enterApp(context));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 211),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 237, 233, 211),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 300,
              child: Image.asset('assets/logo.jpg')
            ),
            const SizedBox(height: 20),
            Text(
              'La LOCAnda',
              style: GoogleFonts.handlee(
                textStyle: TextStyle(fontSize: 50, color:Colors.red.shade700)
              )),
            const SizedBox(height: 40),
            CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade700),
              ),
          ],
        ),
    ),
    );
  }
}
