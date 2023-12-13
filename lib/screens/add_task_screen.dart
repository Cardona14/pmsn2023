import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController txtContTaskName = TextEditingController();
  TextEditingController txtContTaskDesc = TextEditingController();
  TextEditingController txtContTaskExp = TextEditingController();
  String? reminder;
  TeacherModel? dropDownValue;
  List<TeacherModel>? dropDownValues;
  DateTime? pickedDate;
  AgendaDB? agendaDB;

  String? dropValueState = "Sin Completar";
  List<String>? dropStateValues = ["Sin Completar", "Completada"];

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();

    if (widget.taskModel != null) {
      txtContTaskName.text = widget.taskModel!.nameTask!;
      txtContTaskDesc.text = widget.taskModel!.descTask!;
      txtContTaskExp.text = widget.taskModel!.dateExp!;
      reminder = widget.taskModel!.dateAlert!;
      dropValueState = widget.taskModel!.stateTask! == 0 ? "Sin Completar" : "Completada";
      getTeacher();
    } else {
      getTeachers();
    }
  }

  Future getTeacher() async {
    final teacher = await agendaDB!.GETTEACHER(widget.taskModel!.idTeacher!);
    final teachers = await agendaDB!.GETALLTEACHERS();
    setState(() {
      dropDownValues = teachers;
      for (int i = 0; i < teachers.length; i++) {
        if (teachers[i].idTeacher == teacher.idTeacher) {
          dropDownValue = teachers[i];
          break;
        }
      }
    });
  }

  Future getTeachers() async {
    final teachers = await agendaDB!.GETALLTEACHERS();
    setState(() {
      dropDownValues = teachers;
      dropDownValue = teachers[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateInput = TextField(
      controller: txtContTaskExp,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today),
        labelText: "Fecha de expiracion"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            txtContTaskExp.text = formattedDate;
            reminder = DateFormat('yyyy-MM-dd').format(pickedDate.subtract(const Duration(days: 1)));
          });
        } else {
          print("Fecha no seleccionada");
        }
      });

    final txtTaskName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre")),
      controller: txtContTaskName,
    );

    final txtTaskDesc = TextField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Descripcion")),
      maxLines: 6,
      controller: txtContTaskDesc,
    );

    const space = SizedBox(
      height: 10,
    );

    final DropdownButton dropDownButtonTeachers = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            ?.map((teacher) => DropdownMenuItem(
                value: teacher, child: Text(teacher.nameTeacher!)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final DropdownButton dropDownButtonStates = DropdownButton(
        value: dropValueState,
        items: dropStateValues
            ?.map((state) => DropdownMenuItem(value: state, child: Text(state)))
            .toList(),
        onChanged: (value) {
          dropValueState = value;
          setState(() {});
        });

    final ElevatedButton btnSave = ElevatedButton(
        onPressed: () {
          if (widget.taskModel == null) {
            if (txtContTaskName.text == "" || txtContTaskDesc.text == "" || txtContTaskExp.text == "") {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.warning,
                  title: "Advertencia!",
                  text: "Por favor llena todos los espacios"));
            } else {
              agendaDB!.INSERT('tblTasks', {
                "nameTask": txtContTaskName.text,
                "descTask": txtContTaskDesc.text,
                "stateTask": dropValueState == "Sin Completar" ? 0 : 1,
                "dateExp": txtContTaskExp.text,
                "dateAlert": reminder,
                "idTeacher": dropDownValue!.idTeacher
              }).then((value) {
                var msj = (value > 0)
                    ? 'Tarea actualizada con éxito'
                    : 'Algo andaba mal';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblTasks', 'idTask', {
              "idTask": widget.taskModel!.idTask,
              "nameTask": txtContTaskName.text,
              "descTask": txtContTaskDesc.text,
              "stateTask": dropValueState == "Sin Completar" ? 0 : 1,
              "dateExp": txtContTaskExp.text,
              "dateAlert": reminder,
              "idTeacher": dropDownValue!.idTeacher
            }).then((value) {
              var msj = (value > 0)
                  ? 'Tarea actualizada con éxito'
                  : 'Algo andaba mal';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              txtContTaskName.text = "";
              txtContTaskDesc.text = "";
              Navigator.pop(context);
            });
          }
          GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
        },
        child: widget.taskModel == null
            ? const Text("Tarea guardada")
            : const Text("Tarea Actualizada"));

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null
            ? const Text("Tarea agregada")
            : const Text("Tarea actualizada"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              txtTaskName,
              space,
              txtTaskDesc,
              space,
              dropDownButtonTeachers,
              space,
              dateInput,
              space,
              dropDownButtonStates,
              space,
              btnSave
            ],
          ),
        ),
      ),
    );
  }
}