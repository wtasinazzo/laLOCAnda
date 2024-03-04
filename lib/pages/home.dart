import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_locanda/pages/prenotazoni.dart';

import 'assistenza.dart';


class Home extends StatefulWidget{
  Home({Key? key}) : super(key: key);
  static const homePageName = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _selIdx = 0;

  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      label: 'Prenotazioni',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_outlined),
      label: 'Assistenza',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return PrenotazioniPage();
      case 1:
        return AssistancePage();
      default:
        return PrenotazioniPage();
    }
  }

  @override
  Widget build(BuildContext context){
    print('${Home.homePageName} built');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 233, 211),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        title: Text(
          'La LOCAnda',
          style: GoogleFonts.handlee(
            textStyle: const TextStyle(fontSize: 25, color: Colors.white)
          )),
      ),
      body: _selectPage(index: _selIdx),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red.shade700,
          selectedItemColor: const Color.fromARGB(255, 237, 233, 211),
          unselectedItemColor: Colors.black,
          items: _navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        )
    );
  }
}