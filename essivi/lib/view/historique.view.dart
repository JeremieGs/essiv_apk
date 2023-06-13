import 'package:essivi/view/commande.details.view.dart';
import 'package:essivi/view/livraison.view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'historique.details.dart';

class Historique extends StatefulWidget {
  Historique({super.key});
  @override
  _HistoriqueState createState ()=> _HistoriqueState();
}
class _HistoriqueState extends State<Historique> {

  List<dynamic> Listcommande = [];
  bool isLoading = true;


  @override
  void initState(){
    this.getData();
  }
  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieToken = prefs.getString('jwt');

    if (cookieToken != null) {
      var url = Uri.parse('http://10.0.2.2:8000/api/listhistorique');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'jwt=$cookieToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          Listcommande = json.decode(response.body);
          isLoading = false;
        });
        print(response.statusCode);
        print(Listcommande.length);
      }  else {
        print('Request failed with status: ${response.statusCode}.');
        print(response.body);
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
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blueAccent.withAlpha(20),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: Border(
                bottom: BorderSide(
                  color: Colors.grey.withAlpha(60),
                )
            ),
            title: Center(child: Text('H I S T O R I Q U E S',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            ),
          ),
          body:  Container(
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Listcommande.length,
              itemBuilder: (context, index) {
                DateTime dateAjout = DateTime.parse(Listcommande[index]['date_ajout']);
                DateTime delai = DateTime.parse(Listcommande[index]['delai']);
                DateTime date_livr = DateTime.parse(Listcommande[index]['date_livr']);
                int heure = dateAjout.hour;
                int minute = dateAjout.minute;
                int heuredelai = delai.hour;
                int minutedelai = delai.minute;
                String prix = Listcommande[index]['prix'].toStringAsFixed(2);
                String distance = Listcommande[index]['distance'].toStringAsFixed(2);
                String client_name =  Listcommande[index]['client_name'].substring(0, 7);
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Historiquedetails(
                          id: Listcommande[index]['id'].toString(),
                          id_com :Listcommande[index]['commande'].toString(),
                          lat: double.parse(Listcommande[index]['lat'].toString()),
                          long: double.parse(Listcommande[index]['long'].toString()),
                          client :Listcommande[index]['client_name'].toString(),
                          client_id :Listcommande[index]['client'].toString(),
                          date_ajout : '${dateAjout.day}/${dateAjout.month}/${dateAjout.year}'+'('+heure.toString()+':'+minute.toString()+')',
                          delai :'${delai.day}/${delai.month}/${delai.year}'+'('+heuredelai.toString()+':'+minutedelai.toString()+')',
                          distance :distance,
                          prix :prix,
                          date_livr: date_livr.toString()
                      ),
                    ));
                  },
                  child: Container(
                    width: 500,
                    height: 190,
                    margin: EdgeInsets.only(bottom: 12, right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3) //color of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],

                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today, color: Colors.grey, size: 24,),
                            SizedBox(width: 15,),
                            Text('№' + Listcommande[index]['id'].toString(),
                              style: TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withAlpha(180)),),
                            SizedBox(width: 175,),
                            Text(
                              '${dateAjout.day}/${dateAjout.month}/${dateAjout.year}',
                              style: TextStyle(color: Colors.black.withAlpha(180),
                                  fontSize: 16),textAlign: TextAlign.end,
                              textDirection: TextDirection.rtl,
                            ),
                            Icon(Icons.calendar_month, color: Colors.black
                                .withAlpha(180)),
                          ],
                        ),
                        SizedBox(height: 0,),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 310,),
                            Text('('+
                                heure.toString()+':'+minute.toString()+')',
                              style: TextStyle(fontSize: 13,
                                  color: Colors.black.withAlpha(180)),),
                          ],

                        ),
                        SizedBox(height: 1,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.grey ,size: 17,),
                            Text('Client : ', style: TextStyle(
                                fontSize: 17, color: Colors.black54),),
                            SizedBox(width: 200,),
                            Text(client_name.toString(),
                              style: TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.attach_money, color: Colors.grey ,size: 17,),
                            Text('Prix : ', style: TextStyle(
                                fontSize: 17, color: Colors.black54),),
                            SizedBox(width: 200,),
                            Text(prix + 'CFA',
                              style: TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.grey ,size: 17,),
                            Text('Distance : ', style: TextStyle(
                                fontSize: 17, color: Colors.black54),),
                            SizedBox(width: 170,),
                            Text(distance +
                                'km', style: TextStyle(fontSize: 17,
                                fontWeight: FontWeight.bold, color: Colors.blue),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,),
                            Icon(Icons.location_on, color: Colors.black.withAlpha(
                                180), size: 17,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.history , color: Colors.grey,size: 17,),
                            Text('Statut :', style: TextStyle(
                                fontSize: 17, color: Colors.black54),),
                            SizedBox(width: 195,),
                            Text(Listcommande[index]['statut'].toString(),
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blue),textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,),

                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
    );
  }
}