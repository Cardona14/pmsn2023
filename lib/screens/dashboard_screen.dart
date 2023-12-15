import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/preferences_helper.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos ;)'),
      ),
      drawer: createDrawer(context),
      body: Center(
        child: Container(
          width: 281,
          height: 498,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/squirtle-sax.gif'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15), // puedes agregar bordes redondeados a la imagen
          ),
        ),
      )
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.grey,
          dividerTheme: const DividerThemeData(thickness: 2),
        ),
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/anonymous.png'), //NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Jose Cardona Negrete'),
              accountEmail: Text('18031246@itcelaya.edu.mx')
            ),
            ListTile(
              leading: Image.asset('assets/hackshop.jpg'),
              trailing: const Icon(Icons.chevron_right),
              title: const Text('Hack Store'),
              subtitle: const Text('Image Carrusel'),
              onTap: () => Navigator.pushNamed(context, '/store'),
            ),
            ExpansionTile(
              title: const Text('Agenda de Tareas'),
              leading: const Icon(Icons.task_outlined),
              trailing: const Icon(Icons.menu_book_outlined),
              children: <Widget>[
                ListTile(
                  trailing: const Icon(Icons.chevron_right),
                  leading: const Icon(Icons.task),
                  title: const Text('Tareas'),
                  onTap: () => Navigator.pushNamed(context, '/tasks')
                ),
                ListTile(
                  trailing: const Icon(Icons.chevron_right),
                  leading: const Icon(Icons.assignment_ind),
                  title: const Text('Maestros'),
                  onTap: () => Navigator.pushNamed(context, '/teachers')
                ),
                ListTile(
                  trailing: const Icon(Icons.chevron_right),
                  leading: const Icon(Icons.people),
                  title: const Text('Carreras'),
                  onTap: () => Navigator.pushNamed(context, '/careers')
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Peliculas'),
              leading: const Icon(Icons.movie_outlined),
              trailing: const Icon(Icons.menu_book_outlined),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  trailing: const Icon(Icons.chevron_right),
                  title: const Text('Populares'),
                  onTap: () {
                    Navigator.pushNamed(context, '/popular');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite_outline),
                  trailing: const Icon(Icons.chevron_right),
                  title: const Text('Favoritas'),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite');
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.map),
              trailing: const Icon(Icons.chevron_right),
              title: const Text('Pronostico del Clima'),
              onTap: () => Navigator.pushNamed(context, '/weather'),
            ),
            ListTile(
              leading: const Icon(Icons.task_alt_outlined),
              trailing: const Icon(Icons.chevron_right),
              title: const Text('Test Provider'),
              onTap: () => Navigator.pushNamed(context, '/provider'),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              trailing: const Icon(Icons.chevron_right),
              title: const Text('Google maps'),
              onTap: () => Navigator.pushNamed(context, '/maps'),
            ),
            DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {
                final isLoggedIn = await PreferencesHelper.getLoggedInStatus();
                if (isLoggedIn) {
                  GlobalValues.flagTheme.value = isDarkModeEnabled;
                  await PreferencesHelper.setTheme(isDarkModeEnabled);
                } else {
                  GlobalValues.flagTheme.value = isDarkModeEnabled;
                }
              }
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                PreferencesHelper.clearPreferences().then((value) {
                  Navigator.pushReplacementNamed(context, '/login');
                });
              }
            ) 
          ],
        ),
      ),
    );
  }
}