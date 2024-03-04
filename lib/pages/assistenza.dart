import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AssistancePage extends StatelessWidget{
  AssistancePage({Key? key}) : super(key: key);

  static const assistancePageName = 'Assistenza';

  @override
  Widget build(BuildContext context){
    print('${AssistancePage.assistancePageName} built');
    return Container(
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Questa app è stata costruita da Studios WT",
              style:GoogleFonts.jost(
                  textStyle: const TextStyle(fontSize: 20),
                  color: Colors.black
                ),
              ),
            const SizedBox(height: 75),
            Text(
              "CONTATTI",
              style:GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 35),
                color: Colors.red.shade700
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Telefono: +39 3278456789",
              style:GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 20),
                color: Colors.black
              ),
            ),
            Text(
              "E-mail: william@studioswt.com",
              style:GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 20),
                color: Colors.black
              ),
            ),
        ],),
    );

  }
}