import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';

class AddTeacherScreen extends StatefulWidget {
  AddTeacherScreen({super.key, this.teacherModel});

  TeacherModel? teacherModel;

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  TextEditingController txtContTeacherName = TextEditingController();
  TextEditingController txtContTeacherEmail = TextEditingController();
  CareerModel? dropDownValue;
  List<CareerModel>? dropDownValues;
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.teacherModel != null) {
      txtContTeacherName.text = widget.teacherModel!.nameTeacher!;
      txtContTeacherEmail.text = widget.teacherModel!.emailTeacher!;
      getCareer();
    } else {
      getCareers();
    }
  }

  Future getCareer() async {
    final career = await agendaDB!.GETCAREER(widget.teacherModel!.idCareer!);
    final careers = await agendaDB!.GETALLCAREERS();
    setState(() {
      dropDownValues = careers;
      for (int i = 0; i < careers.length; i++) {
        if (careers[i].idCareer == career.idCareer) {
          dropDownValue = careers[i];
          break;
        }
      }
    });
  }

  Future getCareers() async {
    final careers = await agendaDB!.GETALLCAREERS();
    setState(() {
      dropDownValues = careers;
      dropDownValue = careers[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtTeacherName = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nombre")),
      controller: txtContTeacherName,
    );

    final txtTeacherEmail = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Email")),
      controller: txtContTeacherEmail,
    );

    const space = SizedBox(height: 10);

    final btnSave = ElevatedButton(
        onPressed: () {
          if (widget.teacherModel == null) {
            if (txtContTeacherName.text == "" || txtContTeacherEmail.text == "") {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.warning,
                  title: "¡Advertencia!",
                  text: "Por favor llena todos los espacios"));
            } else {
              agendaDB!.INSERT('tblTeachers', {
                "nameTeacher": txtContTeacherName.text,
                "emailTeacher": txtContTeacherEmail.text,
                "idCareer": dropDownValue!.idCareer
              }).then((value) {
                var msj = (value > 0)
                    ? 'Profesor añadido con éxito'
                    : 'Algo andaba mal';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblTeachers', 'idTeacher', {
              "idTeacher": widget.teacherModel!.idTeacher,
              "nameTeacher": txtContTeacherName.text,
              "emailTeacher": txtContTeacherEmail.text,
              "idCareer": dropDownValue!.idCareer
            }).then((value) {
              var msj = (value > 0)
                  ? 'Profesor añadido con éxito'
                  : 'Algo andaba mal';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
        },
        child: const Text("Guardado"));

    final DropdownButton dropDownButtonCareer = DropdownButton(
      value: dropDownValue,
      items: dropDownValues?.map((career) => DropdownMenuItem(value: career, child: Text(career.nameCareer!))).toList(),
      onChanged: (value) {
        dropDownValue = value;
        setState(() {});
      }
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.teacherModel == null
            ? const Text('Agregar maestro')
            : const Text('Actualizar maestro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            txtTeacherName,
            space,
            txtTeacherEmail,
            space,
            dropDownButtonCareer,
            space,
            btnSave
          ],
        ),
      ),
    );
  }
}