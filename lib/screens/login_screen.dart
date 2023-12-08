import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPass = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Usuario'
      ),
    );

    final txtPass = TextField(
      controller: txtConPass,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Contraseña'
      )
    );

    final imgLogo = Container(
      width: 300,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/90/Cyberpunk_Edgerunners_logo.png')
        )
      )
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: const Icon(Icons.login),
      label: const Text('Entrar'),
      onPressed: () async {
        if (txtConUser.text == '' || txtConPass.text == '') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('El correo y la contraseña son datos necesarios'),
              );
            }
          );
        } else {
          if (isChecked) {
            // Cambiar el estado de logeo a verdadero
            await PreferencesHelper.setLoggedInStatus(true);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/dash');
          } else {
            Navigator.pushReplacementNamed(context, '/dash');
          }
        }
      }
    );

    final savecheckbox = CheckboxListTile(
      title: const Text('Guardar sesión'),
      value: isChecked, 
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
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
          padding: const EdgeInsets.only(bottom: 50),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              imgLogo,
              Container(
                height: 300,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.8)
                ),
                child: Column(
                  children:[
                    txtUser,
                    const SizedBox(height: 10),
                    txtPass,
                    const SizedBox(height: 10),
                    savecheckbox,
                    const SizedBox(height: 10),
                    btnEntrar
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      floatingActionButton: const SizedBox.shrink()
    );
  }
}