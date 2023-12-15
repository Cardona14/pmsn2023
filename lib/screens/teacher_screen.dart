import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:pmsn2023/widgets/teacher_widget.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  AgendaDB? agendaDB;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maestros'),
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagDB,
          builder: (context, value, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Buscar",
                    ),
                    controller: searchController,
                    onChanged: (text) {
                      GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future:
                          agendaDB!.GETFILTEREDTEACHERS(searchController.text),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<TeacherModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return teacherWidget(
                                    snapshot.data![index], context);
                              });
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Algo andaba mal"),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }
                      }),
                ),
              ],
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await agendaDB!.GETALLCAREERS();
          if (res.isEmpty) {
            // ignore: use_build_context_synchronously
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "¡Error!",
                text: "Se debe registrar al menos una carrera para agregar docentes"));
          } else {
            Navigator.pushNamed(context, '/addTeacher');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}