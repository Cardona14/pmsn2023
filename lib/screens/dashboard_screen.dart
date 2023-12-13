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
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
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
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Tareas'),
            onTap: () => Navigator.pushNamed(context, '/tasks')
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Maestros'),
            onTap: () => Navigator.pushNamed(context, '/teachers')
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Carreras'),
            onTap: () => Navigator.pushNamed(context, '/careers')
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Movies'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Test Provider'),
            onTap: () => Navigator.pushNamed(context, '/provider'),
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
    );
  }
}