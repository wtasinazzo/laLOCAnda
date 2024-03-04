import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/database/entities/entities.dart';
import 'package:provider/provider.dart';

import '../repository/databaseRepository.dart';


class SeeBookingsPage extends StatelessWidget{
  SeeBookingsPage({Key? key}) : super(key: key);

  static const seeBookingsName = 'Vedi Prenotazioni';

  @override
  Widget build(BuildContext context){
    print('${SeeBookingsPage.seeBookingsName} built');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 233, 211),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        title: Text(
          'La LOCAnda',
          style: GoogleFonts.handlee(
            textStyle: const TextStyle(fontSize: 25, color: Colors.white)
          )),
      ),
      body:Container(
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  DateTime dataScelta = await selectDate(context);
                  List<Prenotazioni?> lista =
                    await Provider.of<DatabaseRepository>(context, listen: false)
                        .findPrenotazioniByData(dataScelta);
                  String testo = daListaATesto(context, lista);
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Prenotazioni in data:'),
                        content: SingleChildScrollView(
                          child: Text(testo)),
                         actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text(
                  "SELEZIONA DATA",
                  style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 20, color: Colors.white)
                  )
                  )),
            ),

            const SizedBox(height: 100),
            
            SizedBox(
              height: 75,
              width: 250,
              child: ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController controller = TextEditingController();
                      return AlertDialog(
                        title: Text('Inserisci il contatto'),
                        content: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'n° telefonico',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              int? number = int.tryParse(controller.text);
                              if (number == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Non hai inserito un numero'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              if (number != null) {
                                List<Prenotazioni?> lista =
                                await Provider.of<DatabaseRepository>(context, listen: false)
                                    .findPrenotazioniByContatto(number) ;
                                String testo = daListaATesto(context, lista);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text('Prenotazioni della persona:'),
                                      content: SingleChildScrollView(
                                        child: Text(testo)),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              }
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text(
                  "SELEZIONA PERSONA",
                  style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 20, color: Colors.white)
                  )
                )
              ),
            )
          ]
        )
      )
    );
  }
  
  String daListaATesto(BuildContext context, List<Prenotazioni?> lista) {
    if (lista.isEmpty){
      return 'Non ci sono prenotazioni con queste caratteristiche.';
    } else {
    String testo = '';
    for (int i = 0; i < lista.length; i++) {
      testo = '${testo} PRENOTAZIONE ${i+1}\n';
      testo = '${testo} Contatto: ${lista[i]!.telefono}\n';
      testo = '${testo} Data: ${lista[i]!.data.day}/${lista[i]!.data.month}/${lista[i]!.data.year}\n';
      testo = '${testo} N° posti: ${lista[i]!.nPersone}\n \n'; 
    }
    return testo;
  }}
}

Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      print('Selected date: $picked');
      return picked;
    } else {
      return DateTime(1999);
    }
}