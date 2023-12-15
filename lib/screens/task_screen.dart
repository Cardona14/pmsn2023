import 'dart:math';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/provider/notification_provider.dart';
import 'package:pmsn2023/widgets/task_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;
  TextEditingController searchController = TextEditingController();
  String? dropValueState = "Todas";
  List<String>? dropStateValues = ["Sin Completar", "Completada", "Todas"];

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    NotificationProvider.initialize();
    notifyNearTasks();
  }

  Future deleteAll() async {
    agendaDB!.DELETEALL('tasks');
  }

  Future<void> notifyNearTasks() async {
    var res = await agendaDB!.GETUNFINISHEDTASKS();
    var today = DateTime.now();
    var tomorrowTasks = 0;
    for (var element in res) {
      var task = DateTime.parse(element.dateAlert!);
      if (task.year == today.year &&
          task.month == today.month &&
          task.day == today.day) {
        tomorrowTasks++;
      }
    }
    if (tomorrowTasks != 0) {
      NotificationProvider.showBigTextNotification(
        title: "Tareas pedientes para el dia de mañana!",
        body: tomorrowTasks != 1
            ? "Tienes $tomorrowTasks tareas pendientes para mañana"
            : "Tienes $tomorrowTasks tareas pendientes para mañana",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DropdownButton dropDownButtonStates = DropdownButton(
      value: dropValueState,
      items: dropStateValues?.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(),
      onChanged: (value) {
        dropValueState = value;
        setState(() {});
      }
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagDB,
        builder: (context, value, _) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
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
                    const SizedBox(width: 10),
                    dropDownButtonStates
                  ],
                ),
              ),
              Flexible(
                child: FutureBuilder(
                    future: dropValueState != "Todas"
                      ? agendaDB!.GETFILTEREDTASKS(searchController.text,dropValueState == "Completada" ? 1 : 0)
                      : agendaDB!.GETFILTEREDTASKS(searchController.text, null),
                    builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: taskWidget(snapshot.data![index], context),
                              onTap: () {
                                var random = Random();
                                int number = random.nextInt(4);
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(3, 5),
                                            blurRadius: 10)
                                        ]),
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      children: [
                                                        Container(height: 5),
                                                        Text(
                                                          snapshot.data![index].nameTask!,
                                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                            color: const Color.fromARGB(255,15,171,33),
                                                          ),
                                                        ),
                                                        Container(height: 5),
                                                        Text(
                                                          "Expires: ${snapshot.data![index].dateExp!}",
                                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            color: Colors.grey[500],
                                                          ),
                                                        ),
                                                        Container(height: 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              snapshot.data![index].stateTask! == 0 ? "Sin Completar" : "Completada",
                                                              maxLines: 2,
                                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                                color: Colors.grey[700],
                                                              ),
                                                            ),
                                                            Expanded(child: Container()),
                                                            snapshot.data![index].stateTask! == 1
                                                            ? const Icon(
                                                                Icons.check_circle,
                                                                color: Color.fromARGB(255,24,11,168),
                                                              )
                                                            : const Icon(
                                                                Icons.close_fullscreen,
                                                                color: Color.fromARGB(255, 33, 17, 137),
                                                              )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                snapshot.data![index].descTask!,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          });
                      } else {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Algo andaba mal'),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 60,
                              child: CircularProgressIndicator()),
                          );
                        }
                      }
                    }
                  ),
                ),
              ],
            );
          }
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              var res = await agendaDB!.GETALLTEACHERS();
              if (res.isEmpty) {
                // ignore: use_build_context_synchronously
                ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "¡Error!",
                    text: "Al menos un profesor debe estar registrado para agregar tareas"));
              } else {
                Navigator.pushNamed(context, '/addTask');
              }
            },
            heroTag: 'butonAddTask',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
            heroTag: 'butonCalendar',
            child: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
    );
  }
}