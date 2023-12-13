import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:pmsn2023/screens/add_techaer_screen.dart';

Widget teacherWidget(TeacherModel teacher, BuildContext context) {
  AgendaDB? agendaDB = AgendaDB();
  return FutureBuilder(
      future: agendaDB.GETCAREER(teacher.idCareer!),
      builder: (BuildContext context, AsyncSnapshot<CareerModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.nameTeacher!,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.nameCareer!,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 12))
                  ],
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AddTeacherScreen(teacherModel: teacher,)));
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:MaterialStateProperty.all(Colors.green)),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            ArtDialogResponse response =
                              await ArtSweetAlert.show(
                                barrierDismissible: false,
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                  denyButtonText: "Cancelar",
                                  title: "Estas seguro?",
                                  confirmButtonText: "si",
                                  type: ArtSweetAlertType.warning));
                            if (response.isTapConfirmButton) {
                              var res = await agendaDB.DELETE('tblTeachers','idTeacher', teacher.idTeacher!, 'tblTasks');
                              if (res == 0) {
                                // ignore: use_build_context_synchronously
                                ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.danger,
                                    title: "¡Error!",
                                    text:"Hay tareas que están registradas con este profesor."));
                              }
                              GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Colors.red),
                            padding:MaterialStateProperty.all(EdgeInsets.zero)),
                          child: const Icon(
                            Icons.delete,
                            size: 14,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Algo salio mal"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
}