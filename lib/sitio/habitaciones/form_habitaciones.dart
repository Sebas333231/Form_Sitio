import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forms_provider.dart';




class Example extends StatefulWidget {

  TextEditingController tituloHabitaciones = TextEditingController();
  Example({super.key, required this.tituloHabitaciones});

  @override
  State<Example> createState() => _ExampleState(controllers: [tituloHabitaciones]);
}

class _ExampleState extends State<Example> {
  List<TextEditingController> controllers = <TextEditingController>[];
  List<TextEditingController> controllers2 = <TextEditingController>[];

  @override
  void initState() {
    controllers = context.read<FormsProvider>().controller;
    controllers2 = context.read<FormsProvider>().controller2;
    super.initState();
  }


  _ExampleState({required this.controllers});




  @override
  Widget build(BuildContext context) {
    List<TextEditingController> dynamicControllers = context.watch<FormsProvider>().controller;
    List<TextEditingController> dynamicControllers2 = context.watch<FormsProvider>().controller2;

    return Scaffold(
        body: ListView(
          children: [
            ...dynamicControllers.map((e) => Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                                child: TextFormField(
                                  controller: e,
                                  obscureText: false,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Titulo',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Se requiere de este campo';
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                                child: TextFormField(
                                  maxLines: 5,
                                  obscureText: false,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Descripcion',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Se requiere de este campo';
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30)
                          ],
                        )
                    ),
                    IconButton(
                        onPressed: (){
                          context.read<FormsProvider>().deleteControllers(
                              index: e
                          );
                        },
                        icon: Icon(Icons.delete)
                    ),
                    // IconButton(
                    //     onPressed: (){
                    //       context.read<FormsProvider>().createControllers2();
                    //     },
                    //     icon: const Icon(Icons.add)
                    // )
                  ],

                ),
              ],
            )).toList(),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: (){
                  context.read<FormsProvider>().createControllers();
                },
                child: const Text('Agregar un boton')
            )
          ],
        )
    );
  }
}