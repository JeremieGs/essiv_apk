import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:essivi/view/commande.view.dart';
import 'package:essivi/view/livraison.view.dart';
import 'package:essivi/view/historique.view.dart';
import 'package:essivi/view/profil.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Homepage extends StatefulWidget {
@override
_HomepageState createState ()=> _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int index =0;
  String nom ='';
  String prenom ='';
  String email ='';
  String username ='';
  bool isLoading = true;

   getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieToken = prefs.getString('jwt');

    if (cookieToken != null) {
      var url = Uri.parse('http://10.0.2.2:8000/api/userview');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'jwt=$cookieToken',
        },
      );

      if (response.statusCode == 200) {
        final info = jsonDecode(response.body);
        setState(() {
          nom =info['last_name'];
          prenom =info['first_name'];
          email =info['email'];
          username =info['username'];
          isLoading = false;
        });
        print(response.statusCode);
      }  else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      print('Cookie token not found.');
    }
    return "Success!";
  }
  void main() {
    const duration = const Duration(seconds: 1);
    Timer.periodic(duration, (Timer t) => getData());
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
@override
Widget build(BuildContext context) {

  final screens = [    Commande(),    Historique(),  ProfilePage(name :nom,prenom:prenom ,
    username:username ,
    email:email,
  )

  ];
    return Scaffold(
      body: screens[index],
      bottomNavigationBar : NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.shade100,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )
        )
      ),
      child : NavigationBar(
        height: 65,
        selectedIndex: index,
        animationDuration: Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (index) =>
        setState(() => this.index = index),
        destinations: [
          NavigationDestination(icon: Icon(Icons.delivery_dining_outlined ,size: 30), label: 'livraison',
            selectedIcon: Icon(Icons.delivery_dining ,size: 30),),
          NavigationDestination(icon: Icon(Icons.history_outlined ,size: 30), label: 'historique',
            selectedIcon: Icon(Icons.history ,size: 30),),
          NavigationDestination(icon: Icon(Icons.person_outlined ,size: 30), label: 'profil',
            selectedIcon: Icon(Icons.person ,size: 30),),
        ],
      ),
    ),
    );
  }
}