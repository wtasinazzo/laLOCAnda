import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/database/entities/entities.dart';
import 'package:la_locanda/pages/vedi_prenotazioni.dart';
import 'package:provider/provider.dart';

import '../repository/databaseRepository.dart';


class NewBookingPage extends StatefulWidget{
  NewBookingPage({Key? key}) : super(key: key);

  static const newBookingPageName = 'Nuova Prenotazione';

  @override
  State<NewBookingPage> createState() => _NewBookingPageState();
}

class _NewBookingPageState extends State<NewBookingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  DateTime data = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    print('${NewBookingPage.newBookingPageName} built');
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
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Inserimento dei dati:",
                style:GoogleFonts.jost(
                  textStyle: const TextStyle(fontSize: 22),
                  color: Colors.redAccent.shade700
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent.shade700)
                  ),
                  icon: Icon(
                    Icons.phone_android_outlined,
                    color: Colors.red.shade700,
                  ),
                  hintText: 'Contatto',
                ),
                controller: contactController,
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent.shade700)
                  ),
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.red.shade700,
                  ),
                  hintText: 'Nome',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 5),

              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () async {
                      data = await selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    child: const Text("DATA", style: TextStyle(color: Colors.white),))
                ]
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent.shade700)
                  ),
                  icon: Icon(
                    Icons.people_outline,
                    color: Colors.red.shade700,
                  ),
                  hintText: 'Numero di presenti',
                ),
                controller: numberController,
              ),
            ],
          ),
        ),
    ),
    floatingActionButton: 
    FloatingActionButton(
      backgroundColor: Colors.red.shade700,
      onPressed: () async {
        int? controllo = await addPrenotazione(context);
        if (controllo==1){
          Navigator.of(context).pop();
        }
      },
      child: const Icon(Icons.add, color: Colors.white,),
    )
    );

  }

  Future<int?> addPrenotazione(BuildContext context) async {
    
  int? cont = int.tryParse(contactController.text);
  int? num = int.tryParse(numberController.text);

  if (cont==null || num==null){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dati non corretti'),
        duration: Duration(seconds: 2),
      ),
    );
    return null;
  }

  if (nameController.text==""){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Non hai inserito il nome'),
        duration: Duration(seconds: 2),
      ),
    );
    return null;
  }

  // controllo se esiste già cliente
  Clienti? cliente = await Provider.of<DatabaseRepository>(context, listen: false)
    .findClienteByContatto(cont);
  if (cliente==null){
    // Creo nuovo cliente
    await Provider.of<DatabaseRepository>(context, listen: false)
      .insertCliente(Clienti(int.tryParse(contactController.text)!, nameController.text, 0));
          
  } 

  // Gli aggiungo una prenotazione

  // Controllo che ci sia ancora posto
  List<Prenotazioni?> prenotazioniInData = await Provider.of<DatabaseRepository>(context, listen: false)
  .findPrenotazioniByData(data);
  int lunghLista = prenotazioniInData.length;
  int postiPrenotati = 0;
  for (int i = 0; i < lunghLista; i++) {
    postiPrenotati += prenotazioniInData[i]!.nPersone;
  }
  if (postiPrenotati + num > 30){
    String postiDisponibili = (30-postiPrenotati).toString();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Non ci stanno. POSTI LIBERI: $postiDisponibili'),
        duration: const Duration(seconds: 4),
      ),
    );
    return null;
  }

  // aggiungo prenotazione
  try{ 
    await Provider.of<DatabaseRepository>(context, listen: false)
      .insertPrenotazione(Prenotazioni(int.tryParse(contactController.text)!, data, int.tryParse(numberController.text)!));
    
    // aggiorno numero prenotazioni
    cliente = await Provider.of<DatabaseRepository>(context, listen: false)
      .findClienteByContatto(cont);
    cliente!.nPrenotazioni += 1;
  } catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PRENOTAZIONE NON INSERIBILE'),
        duration: Duration(seconds: 4),
      ),
    );
    return null;
  }

  await Provider.of<DatabaseRepository>(context, listen: false)
      .updateCliente(cliente);

   ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PRENOTAZIONE AVVENUTA'),
        duration: Duration(seconds: 4),
      ),
    );
  return 1;
  }
}


