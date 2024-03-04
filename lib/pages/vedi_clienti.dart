import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/database/entities/entities.dart';
import 'package:provider/provider.dart';

import '../repository/databaseRepository.dart';


class SeeClientPage extends StatefulWidget{
  SeeClientPage({Key? key}) : super(key: key);

  static const seeClientPageName = 'Vedi Clienti';

  @override
  State<SeeClientPage> createState() => _SeeClientPageState();
}

class _SeeClientPageState extends State<SeeClientPage> {
  final TextEditingController idController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    print('${SeeClientPage.seeClientPageName} built');
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
                "Inserisci il n° di telefono del cliente:",
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
                controller: idController,
              ),
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.red.shade700,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    int? num = int.tryParse(idController.text); 
                    if (num==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dati non corretti'),
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    } else {
                      Clienti? cliente = await Provider.of<DatabaseRepository>(context, listen: false)
                        .findClienteByContatto(num);
                      if (cliente==null){
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cliente inesistente'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      } else {
                        String testo = '';
                        testo = '${testo} Contatto: ${cliente.contatto}\n';
                        testo = '${testo} Nome: ${cliente.name}\n';
                        testo = '${testo} N° prenotazioni: ${cliente.nPrenotazioni}\n \n'; 
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Cliente:'),
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
                    }
                  },
                  icon: const Icon(
                    Icons.search
                  )
                ),
              )
              
            ],
          ),
        ),
    ),
    );

  }

}