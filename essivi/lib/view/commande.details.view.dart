import 'package:essivi/view/commande.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Detailscom extends StatefulWidget {
  final String id;
  final double lat;
  final double long;
  final String id_com;
  const Detailscom({Key? key, required this.id, required this.lat, required this.long, required this.id_com})
      : super(key: key);

  @override
  State<Detailscom> createState() => _DetailscomState();
}

class _DetailscomState extends State<Detailscom> {
  LatLng currentPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

   _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy:LocationAccuracy.high
      );
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de récupérer votre position actuelle.')),
      );
    }
  }

  Future<void> _completeDelivery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieToken = prefs.getString('jwt');

    if (cookieToken != null) {
      var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/livraisonterminer'),body: {
      "id": widget.id,
      "commande":widget.id_com
      },);
      if (response.statusCode == 200) {
        // Rediriger vers la page commande
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => Commande()),
        );
      } else {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur s\'est produite.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withAlpha(20),
    appBar: AppBar(
      iconTheme: IconThemeData( color: Colors.black.withAlpha(400)),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Livraison № '+widget.id,style: TextStyle( color: Colors.black.withAlpha(400)),
      ),
    ),
      body:(
          FlutterMap(
            options: MapOptions(
              center: LatLng(widget.lat, widget.long), // La position de la livraison
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(widget.lat, widget.long), // La position de la livraison
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: currentPosition, // Votre position actuelle
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              PolylineLayerOptions(
                polylines: [
                  Polyline(
                    points: [currentPosition, LatLng(widget.lat, widget.long)], // Tracer l'itinéraire entre votre position actuelle et la position de la livraison
                    color: Colors.blue,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
            ],
          )
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: _completeDelivery,
    child: Icon(Icons.done),
    ),
    );
  }
}
