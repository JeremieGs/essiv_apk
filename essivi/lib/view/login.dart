import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app.view.dart';
class Login extends StatefulWidget {

  @override
  _LoginState createState ()=> _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool is_loading = false;

 singin(String username , String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body ={"username":username  ,"password":password};
    var jsonresponce;
    var res = await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),body: body);
    if (res.statusCode==200){
      jsonresponce=json.decode(res.body);
      print("responce statut ${res.statusCode}");
      print("responce statut ${res.body}");

      if (jsonresponce != null) {
        setState(() {
          is_loading=false;
        });
        sharedPreferences.setString("jwt", jsonresponce["jwt"]);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );

      }
    }
    else {
      setState(() {
        is_loading =false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${res.body}')),
      );
    }


  }

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.1);

    return Scaffold(
      /*body: Column(children: [
        SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Essivi',
                    style: TextStyle(
                      fontSize: 35,
                      color: Globalcolor().mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(children: [
                  Text(
                    'Connecter vous a votre compte',
                    style: TextStyle(
                      fontSize: 16,
                      color: Globalcolor().textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(height: 15),

                  ///email or username
                  TextFormGlobal(
                    controller: emailController,
                    text: "email ou nom d'utilisateur ",
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),

                  /// password
                  TextFormGlobal(
                    controller: passwordController,
                    text: "mot de passe ",
                    obscure: true,
                    textInputType: TextInputType.text,
                  ),

                  /// button
                  const SizedBox(height: 10),
                  const ButtonGlobal(),
                ])
              ],
            )),
          ),
        )
      ]
       */
      body: Stack (
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: defaultLoginSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bienvenue ',
                      style: TextStyle(fontWeight : FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(height: 4,),
                    Image.asset('assets/image/loginn.png' ,),
                    SizedBox(height:0.5,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blueAccent.withAlpha(50),
                      ),
                      child: TextField(
                        controller: emailController,
                        cursorColor: Colors.blueAccent,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email,color: Colors.blueAccent,),
                          hintText: "Nom d'utilisateur ",
                          border: InputBorder.none,
                        ),
                        obscureText: false,
                      ),
                    ),
                    SizedBox(height:0.2),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blueAccent.withAlpha(50)

                      ),
                      child: TextField(
                        controller: passwordController,
                        cursorColor: Colors.blueAccent,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock,color: Colors.blueAccent,),
                          hintText: "Mot de passe ",
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height:9),
                    TextButton (
                      onPressed: emailController.text==""||passwordController.text==""?null
                        :(){
                        setState(() {
                          is_loading=true;
                        });
                        singin(emailController.text, passwordController.text);
                      },
                      child: Container(
                      width: size.width *0.8,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),)

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
