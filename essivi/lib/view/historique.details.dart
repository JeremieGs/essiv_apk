import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'commande.details.view.dart';

class Historiquedetails extends StatefulWidget {
  final String id;
  final String id_com;
  final double lat;
  final double long;
  final String client;
  final String delai;
  final String date_ajout;
  final String distance;
  final String prix;
  final String client_id;
  final String date_livr;
  const Historiquedetails({Key? key,
    required this.id, required this.id_com, required this.lat, required this.long, required this.client, required this.delai, required this.date_ajout, required this.distance, required this.prix, required this.client_id, required this.date_livr,
  })  : super(key: key);

  @override
  _HistoriquedetailsState createState() => _HistoriquedetailsState();
}

class _HistoriquedetailsState extends State<Historiquedetails> {
  affecter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieToken = prefs.getString('jwt');
    Map body ={"id_livr":widget.id};
    var jsonresponce;
    var res = await http.post(Uri.parse('http://10.0.2.2:8000/api/nom_livreur'),
        headers: {
          'Cookie': 'jwt=$cookieToken',
        }, body: body);
    if (res.statusCode==200){
      jsonresponce=json.decode(res.body);
      print("responce statut ${res.statusCode}");
      print("responce statut ${res.body}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Detailscom(
          id: widget.id,
          id_com :widget.id_com,
          lat: widget.lat,
          long: widget.long,
        ),
      ));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withAlpha(20),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black.withAlpha(400)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Livraison № ${widget.id}',
          style: TextStyle(color: Colors.black.withAlpha(400)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informations sur la livraison',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Numéro de livraison:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.id,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Numéro de commande:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.id_com,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Nom du client:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.client,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Distance:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.distance,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Prix:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.prix,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Date d\'ajout:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.date_ajout,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Delai:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.delai,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Date livraison:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(400),
                ),
              ),
              Text(
                widget.date_livr,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withAlpha(400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
