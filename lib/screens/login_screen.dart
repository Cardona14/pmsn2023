import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();


    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final txtPass = TextField(
      controller: txtConPass,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      )
    );

    final imgLogo = Container(
      width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/90/Cyberpunk_Edgerunners_logo.png')
        )
      )
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: () => Navigator.pushNamed(context, '/dash')
      /*(){
        Navigator.pushNamed(context, '/dash')
      }*/
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .5,
            fit: BoxFit.fill,
            image: NetworkImage('https://i.pinimg.com/originals/73/4c/52/734c524293d18ce697a78a25842ed328.png')
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  height: 200,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Column(
                    children:[
                      txtUser,
                      const SizedBox(height: 10),
                      txtPass
                    ],
                  ),
                ),
                imgLogo
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      floatingActionButton: btnEntrar,
    );
  }
}