import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/pages/modifica_pren.dart';
import 'package:la_locanda/pages/vedi_clienti.dart';
import 'package:la_locanda/pages/vedi_prenotazioni.dart';

import 'nuova_prenotazione.dart';


class PrenotazioniPage extends StatelessWidget{
  PrenotazioniPage({Key? key}) : super(key: key);

  static const PrenotazioniPageName = 'Prenotazioni';

  @override
  Widget build(BuildContext context){
    print('${PrenotazioniPage.PrenotazioniPageName} built');
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
          alignment: Alignment.center,
          height: 250,
          child: Image.asset('assets/logo.jpg')
        ),
        
        const SizedBox(height: 30),

        SizedBox(
          height: 60,
          width: 255,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewBookingPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Text(
              "PRENOTA ORA",
              style: GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 22, color: Colors.white)
              )
              )),
        ),

        const SizedBox(height: 20),
        
        SizedBox(
          height: 60,
          width: 255,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeeBookingsPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Text(
              "VEDI PRENOTAZIONI",
              style: GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 22, color: Colors.white)
              )
              )),
        ),

        const SizedBox(height: 20),
        
        SizedBox(
          height: 60,
          width: 255,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyBookingsPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Text(
              "MODIFICA/ELIMINA",
              style: GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 22, color: Colors.white, )
              )
              )),
        ),
        const SizedBox(height: 20),
        
        SizedBox(
          height: 60,
          width: 255,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeeClientPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Text(
              "VEDI CLIENTI",
              style: GoogleFonts.jost(
                textStyle: const TextStyle(fontSize: 22, color: Colors.white)
              )
              )),
        ),

      ],);

  }
}