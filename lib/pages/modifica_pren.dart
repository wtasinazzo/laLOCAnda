import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/database/entities/entities.dart';
import 'package:provider/provider.dart';

import '../repository/databaseRepository.dart';


class ModifyBookingsPage extends StatefulWidget{
  ModifyBookingsPage({Key? key}) : super(key: key);

  static const modifyBookingsName = 'Modifica Prenotazioni';

  @override
  State<ModifyBookingsPage> createState() => _ModifyBookingsPageState();
}

class _ModifyBookingsPageState extends State<ModifyBookingsPage> {

  DateTime? dataScelta;
  final TextEditingController controller = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  Prenotazioni? prenotazioneScelta;

  void initState() {
    super.initState();
    dataScelta = DateTime(1999);
  }

  Future<DateTime?> _pickDate() async {
    dataScelta = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dataScelta != null) {
      print('Selected date: $dataScelta');
      setState(() {});
      return dataScelta;
    } else {
      dataScelta = DateTime(1999);
      setState(() {});
      return dataScelta;
    }
    
  }

  @override
  Widget build(BuildContext context){
    print('${ModifyBookingsPage.modifyBookingsName} built');
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
                  await eliminamodificaPrenotazione(context, "aggiorna");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text(
                  "MODIFICA PRENOTAZIONE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 22, color: Colors.white)
                  )
                  )),
            ),

            const SizedBox(height: 100),
            
            SizedBox(
              height: 75,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  await eliminamodificaPrenotazione(context, "elimina");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text(
                  "ELIMINA PRENOTAZIONE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 22, color: Colors.white)
                  )
                )
              ),
            )
          ]
        )
      )
    );
  }

  Future<void> eliminamodificaPrenotazione(BuildContext context, String comando) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: const Color.fromARGB(255, 237, 233, 211),
          title: Text('Inserisci i dati di prenotazione:',
            style: GoogleFonts.jost(
                textStyle: TextStyle(fontSize: 26, color: Colors.redAccent.shade700)
              )),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent.shade700)
                    ),
                    icon: Icon(
                      Icons.phone_android_outlined,
                      color: Colors.red.shade700,
                    ),
                    hintText: 'N° telefonico',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () async {
                        dataScelta = await _pickDate();
                      }, 
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700),
                      child: Text('DATA', style: TextStyle(color:Colors.white ))
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                int? number = int.tryParse(controller.text);
                if (number == null || dataScelta == DateTime(1999)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Non hai inserito dati corretti'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  prenotazioneScelta = await Provider.of<DatabaseRepository>(context, listen: false)
                    .findPrenotazione(number, dataScelta!) ;
                  setState(() {});
                  if (prenotazioneScelta == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Non esiste questa prenotazione'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
                Navigator.of(context).pop();
                if (comando=='elimina'){
                  eliminazione(context);
                } else if (comando=='aggiorna'){
                  aggiornamento(context);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> eliminazione(context) async{
    if (prenotazioneScelta != null) {
      String testo = '';
      testo = '${testo} Contatto: ${prenotazioneScelta!.telefono}\n';
      testo = '${testo} Data: ${prenotazioneScelta!.data.day}/${prenotazioneScelta!.data.month}/${prenotazioneScelta!.data.year}\n';
      testo = '${testo} N° posti: ${prenotazioneScelta!.nPersone}\n \n'; 
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            surfaceTintColor: const Color.fromARGB(255, 237, 233, 211),
            title: Text('Prenotazione:',
            style: GoogleFonts.jost(
                textStyle: TextStyle(fontSize: 26, color: Colors.redAccent.shade700)
              )),
            content: SingleChildScrollView(
              child: Text(testo)),
            actions: [
              TextButton(
                onPressed: () async {
                  await Provider.of<DatabaseRepository>(context, listen: false)
                    .deletePrenotazione(prenotazioneScelta!);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PRENOTAZIONE ELIMINATA'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  
                },
                child: Text('Elimina', style: TextStyle(color: Colors.redAccent.shade700),),
              ),
            ],
          );
        }
      );
    }
  }

  Future<void> aggiornamento(context) async{
    if (prenotazioneScelta != null) {
      String testo = '';
      testo = '${testo} Contatto: ${prenotazioneScelta!.telefono}\n';
      testo = '${testo} Data: ${prenotazioneScelta!.data.day}/${prenotazioneScelta!.data.month}/${prenotazioneScelta!.data.year}\n';
      testo = '${testo} N° posti: ${prenotazioneScelta!.nPersone}\n \n'; 
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            surfaceTintColor: const Color.fromARGB(255, 237, 233, 211),
            title: Text('Prenotazione:',
            style: GoogleFonts.jost(
                textStyle: TextStyle(fontSize: 26, color: Colors.redAccent.shade700)
              )),
            content: SingleChildScrollView(
              child: Text(testo)),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();


                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: const Color.fromARGB(255, 237, 233, 211),
                        title: Text('Inserisci il nuovo numero di presenti:',
                          style: GoogleFonts.jost(
                              textStyle: TextStyle(fontSize: 26, color: Colors.redAccent.shade700)
                            )),
                        content: Container(
                          height: 150,
                          child: TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent.shade700)
                              ),
                              icon: Icon(
                                Icons.people_outlined,
                                color: Colors.red.shade700,
                              ),
                              hintText: 'N° persone',
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              int? nPers = int.tryParse(numberController.text);
                              if (nPers == null ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Non hai inserito dati corretti'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                List<Prenotazioni?> prenotazioniInData = await Provider.of<DatabaseRepository>(context, listen: false)
                                  .findPrenotazioniByData(prenotazioneScelta!.data);
                                int lunghLista = prenotazioniInData.length;
                                int postiPrenotati = 0;
                                for (int i = 0; i < lunghLista; i++) {
                                  postiPrenotati += prenotazioniInData[i]!.nPersone;
                                }
                                if (postiPrenotati + nPers > 30){
                                  String postiDisponibili = (30-postiPrenotati).toString();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Non ci stanno. POSTI LIBERI: $postiDisponibili'),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                Prenotazioni prenotazioneAggiornata = Prenotazioni(prenotazioneScelta!.telefono, prenotazioneScelta!.data, nPers);
                                await Provider.of<DatabaseRepository>(context, listen: false)
                                  .updatePrenotazione(prenotazioneAggiornata);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('PRENOTAZIONE AGGIORNATA'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                }
                              }
                              Navigator.of(context).pop();
                              
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Aggiorna', style: TextStyle(color: Colors.redAccent.shade700),),
              ),
            ],
          );
        }
      );
    }
  }

  String daListaATesto(BuildContext context, List<Prenotazioni?> lista) {
    if (lista.isEmpty){
      return 'Non ci sono prenotazioni con queste caratteristiche.';
    } else {
    String testo = '';
    for (int i = 0; i < lista.length; i++) {
      testo = '${testo} PRENOTAZIONE ${i+1}\n';
      testo = '${testo} Contatto: ${prenotazioneScelta!.telefono}\n';
      testo = '${testo} Data: ${prenotazioneScelta!.data.day}/${prenotazioneScelta!.data.month}/${prenotazioneScelta!.data.year}\n';
      testo = '${testo} N° posti: ${prenotazioneScelta!.nPersone}\n \n'; 
    }
    return testo;
  }}
}

