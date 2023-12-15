import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';

class AddCareerScreen extends StatefulWidget {
  AddCareerScreen({super.key, this.careerModel});

  CareerModel? careerModel;

  @override
  State<AddCareerScreen> createState() => _AddCareerScreenState();
}

class _AddCareerScreenState extends State<AddCareerScreen> {
  TextEditingController txtContCareerName = TextEditingController();
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    txtContCareerName.text =
        widget.careerModel == null ? "" : widget.careerModel!.nameCareer!;
  }

  @override
  Widget build(BuildContext context) {
    final txtCareerName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre Carrera")),
      controller: txtContCareerName,
    );

    final btnSave = ElevatedButton(
        onPressed: () {
          if (widget.careerModel == null) {
            if (txtContCareerName.text == "") {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.warning,
                  title: "¡Advertencia!",
                  text: "Por favor llena todos los espacios"));
            } else {
              agendaDB!.INSERT('tblCareers', {'nameCareer': txtContCareerName.text}).then((value) {
                var msj = (value > 0)
                    ? 'Carrera agregada con éxito'
                    : 'Algo andaba mal';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblCareers', 'idCareer', {
              "idCareer": widget.careerModel!.idCareer,
              "nameCareer": txtContCareerName.text
            }).then((value) {
              var msj = (value > 0)
                  ? 'Carrera agregada con éxito'
                  : 'Algo andaba mal';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
        },
        child: const Text("Guardado"));

    const space = SizedBox(height: 10);

    return Scaffold(
      appBar: AppBar(
        title: widget.careerModel == null
            ? const Text('Agregar carrera')
            : const Text('Actualizar carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          
          children: [txtCareerName, space, btnSave],
        ),
      ),
    );
  }
}