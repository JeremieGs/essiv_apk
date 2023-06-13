import 'package:essivi/view/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ProfilePage extends StatelessWidget {
  final String name;
  final String username;
  final String email;
  final String prenom;

  const ProfilePage({Key? key, required this.name, required this.username, required this.email, required this.prenom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withAlpha(20),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black38),
            onPressed: () {
              // Naviguer vers la page pour modifier le profil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage(name: name.toString(), prenom: prenom.toString(), username: username.toString(), email: email.toString())),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black38),
            onPressed: () async {
              // Effacer les informations d'identification de l'utilisateur
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              // Naviguer vers la page de connexion
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withAlpha(60),
          ),
        ),
        title: Center(
          child: Text(
            'P R O F I L E',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Image de profil
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nom',
            ),
            controller: TextEditingController(text:name ), // Remplacez par la valeur à afficher
            enabled: false, // Désactiver la saisie
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Prenom',
            ),
            controller: TextEditingController(text: prenom), // Remplacez par la valeur à afficher
            enabled: false, // Désactiver la saisie
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            controller: TextEditingController(text: username), // Remplacez par la valeur à afficher
            enabled: false, // Désactiver la saisie
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            controller: TextEditingController(text: email), // Remplacez par la valeur à afficher
            enabled: false, // Désactiver la saisie
          ),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String prenom;
  const EditProfilePage({Key? key, required this.name, required this.username, required this.email, required this.prenom}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _lastController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  singin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieToken = prefs.getString('jwt');
    Map body ={"nom":_nameController.text  ,"prenom":_lastController.text,"email":_emailController.text,"username":_usernameController.text,};
    var jsonresponce;
    var res = await http.post(Uri.parse('http://10.0.2.2:8000/api/modifierlivreur'),
        headers: {
        'Cookie': 'jwt=$cookieToken',
        },body: body);
    if (res.statusCode==200){
      jsonresponce=json.decode(res.body);
      print("responce statut ${res.statusCode}");
      print("responce statut ${res.body}");

    }
  }
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _lastController= TextEditingController(text: widget.prenom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save , color: Colors.black38,),
            onPressed: () {
           singin();
              Navigator.pop(context);
            },
          ),
        ],
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey.withAlpha(60),
            )
        ),
        title: Center(child: Text('E D I T  P R O F I L',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        ),
      ),
      body: Column(
        children: [
          // Image de profil
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
          ),
          // Formulaire pour modifier les informations du client
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nom',
            ),
          ),
          TextField(
            controller: _lastController,
            decoration: InputDecoration(
              labelText: 'Prenom',
            ),
          ),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
        ],
      ),
    );
  }



}
