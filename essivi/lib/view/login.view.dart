import 'package:essivi/utiles/global.colors.dart';
import 'package:essivi/view/app.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()
                        )
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
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
                      ),
                    )

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
