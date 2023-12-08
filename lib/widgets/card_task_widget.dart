import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/screens/add_task.dart';

// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  CardTaskWidget(
    {super.key,required this.taskModel,
    this.agendaDB}
  );

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.green
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(taskModel.nameTask!),
              Text(taskModel.dscTask!)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(taskModel: taskModel)
                  )
                ),
                child: Image.asset('assets/naranja.png',height: 50,)
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Mensaje del sistema'),
                        content: const Text('¿Deseas borrar la tarea?'),
                        actions: [
                          TextButton(onPressed:(){
                            agendaDB!.deleteTask('tblTareas', taskModel.idTask!)
                            .then((value){
                              Navigator.pop(context);
                              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                            });
                          }, child: const Text('Si')),
                          TextButton(
                            onPressed:()=>Navigator.pop(context), 
                            child: const Text('No')
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
  }
}