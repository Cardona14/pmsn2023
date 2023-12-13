import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/screens/add_career_screen.dart';

Widget careerWidget(CareerModel career, BuildContext context) {
  AgendaDB? agendaDB = AgendaDB();;

  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(5),
    child: Row(
      children: [
        Column(
          children: [
            Text(
              career.nameCareer!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCareerScreen(careerModel: career)));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
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
                  ArtDialogResponse response = await ArtSweetAlert.show(
                    barrierDismissible: false,
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                      denyButtonText: "Cancelar",
                      title: "Estas seguro",
                      confirmButtonText: "Si",
                      type: ArtSweetAlertType.warning));
                  if (response.isTapConfirmButton) {
                    var res = await agendaDB.DELETE('tblCareers', 'idCareer', career.idCareer!, 'tblTeachers');
                    if (res == 0) {
                      // ignore: use_build_context_synchronously
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.danger,
                          title: "¡Error!",
                          text:"Hay tareas que están registradas con esta carrera"));
                    }
                    GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
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
}