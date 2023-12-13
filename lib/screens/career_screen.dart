import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/widgets/career_widget.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  AgendaDB? agendaDB;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carreras'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addCareer');
            },
            icon: const Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagDB,
          builder: (context, value, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
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
                Expanded(
                  child: FutureBuilder(
                      future: agendaDB!.GETFILTEREDCAREERS(searchController.text),
                      builder: (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return careerWidget(
                                snapshot.data![index], context);
                            });
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Algo andaba mal"),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }
                      }),
                ),
              ],
            );
          }),
    );
  }
}
