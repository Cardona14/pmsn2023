import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';

// ignore: must_be_immutable
class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  
  String? dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = [
      'Pendiente',
      'Completado',
      'En proceso'
  ];

  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if( widget.taskModel != null ){
      txtConName.text = widget.taskModel!.nameTask!;
      txtConDsc.text = widget.taskModel!.dscTask!;
      switch(widget.taskModel!.statusTask){
        case 'E': dropDownValue = "En proceso"; break;
        case 'C': dropDownValue = "Completado"; break;
        case 'P': dropDownValue = "Pendiente";
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
        label: Text('Tarea'),
        border: OutlineInputBorder()
      ),
      controller: txtConName,
    );

    final txtDscTask = TextField(
      decoration: const InputDecoration(
        label: Text('Descripcion'),
        border: OutlineInputBorder()
      ),
      maxLines: 6,
      controller: txtConDsc,
    );
  
    const space = SizedBox(height: 10);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(), 
      onChanged: (value){
        dropDownValue = value;
        setState(() { });
      }
    );

    final ElevatedButton btnGuardar = 
      ElevatedButton(
        onPressed: (){
          if( widget.taskModel == null ){
            agendaDB!.insertTask('tblTareas', {
              'nameTask' : txtConName.text,
              'dscTask' : txtConDsc.text,
              'statusTask' : dropDownValue!.substring(0,1)
            }).then((value){
              var msj = ( value > 0 ) 
                ? 'La inserción fue exitosa!'
                : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
          else{
            agendaDB!.updateTask('tblTareas', {
              'idTask' : widget.taskModel!.idTask,
              'nameTask' : txtConName.text,
              'dscTask' : txtConDsc.text,
              'statusTask' : dropDownValue!.substring(0,1)
            }).then((value) {
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
              var msj = ( value > 0 ) 
                ? 'La actualización fue exitosa!'
                : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        }, 
        child: const Text('Save Task')
      );

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null 
          ? const Text('Add Task')
          : const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}