import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:pmsn2023/screens/add_task_screen.dart';

Widget taskWidget(TaskModel task, BuildContext context) {
  AgendaDB? agendaDB = AgendaDB();
  return FutureBuilder(
      future: agendaDB.GETTEACHER(task.idTeacher!),
      builder: (BuildContext context, AsyncSnapshot<TeacherModel> snapshot) {
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
                      task.nameTask!,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(snapshot.data!.nameTeacher!,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen(taskModel: task,)));
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
                                confirmButtonText: "Si",
                                type: ArtSweetAlertType.warning));
                          if (response.isTapConfirmButton) {
                            agendaDB.DELETE('tblTasks', 'idTask', task.idTask!, null);
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