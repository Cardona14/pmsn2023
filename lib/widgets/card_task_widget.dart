import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/screens/add_task_screen.dart';

// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key,required this.taskModel,this.agendaDB});

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            children: [
              Text(taskModel.nameTask!),
              Text(taskModel.descTask!),
              Text('${taskModel.stateTask!}'),
              Text(taskModel.dateExp!),
              Text(taskModel.dateAlert!),
              Text('${taskModel.idTeacher!}')
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => AddTaskScreen(taskModel: taskModel))),
                child: Image.asset( 'assets/images/four_sword.png', height: 50),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Mensaje'),
                            content: const Text('¿Deseas borrar esta tarea?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    agendaDB!.DELETE('tblTasks', 'idTask',taskModel.idTask!, null).then((value) {
                                      Navigator.pop(context);
                                      GlobalValues.flagDB.value = !GlobalValues.flagDB.value;
                                    });
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'))
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete))
            ],
          )
          //Column()
        ],
      ),
    );
  }
}