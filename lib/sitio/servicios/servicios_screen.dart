import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Servicios extends StatefulWidget {
  const Servicios({super.key});

  @override
  State<Servicios> createState() => _ServiciosState();
}

class _ServiciosState extends State<Servicios> {

  //lista de los servicios
  List<ItemModel> items = [
    ItemModel(
        name: 'Wifi',
        icono: '../images/servicios/wifi.png',
        isSelected: false),
    ItemModel(
        name: 'Piscina',
        icono: '../images/servicios/piscina.webp',
        isSelected: false),
    ItemModel(
        name: 'Cocina',
        icono: '../images/servicios/cocina.png',
        isSelected: false),
    ItemModel(
        name: 'Un Jacuzzi',
        icono: '../images/servicios/jacuzzi.png',
        isSelected: false),
    ItemModel(
        name: 'Aire Acondicionado',
        icono: '../images/servicios/aireA.png',
        isSelected: false),
    ItemModel(
        name: 'Lavadora secadora',
        icono: '../images/servicios/lavadora.png',
        isSelected: false),
    ItemModel(
        name: 'Televicion o cable',
        icono: '../images/servicios/tv.png',
        isSelected: false),
    ItemModel(
        name: 'Chimenea',
        icono: '../images/servicios/chimenea.png',
        isSelected: false),
  ];

  //Funcion para subir estos servicios a firebase
  Future<void> uploadDataToServer(List<ItemModel> selectedItems) async {
    // URL de tu servidor o Firebase
    var url = Uri.parse('');

    // Convertir la lista de modelos a formato JSON
    var jsonData = selectedItems
        .map((item) => {'nombre': item.name, 'Icono': item.icono})
        .toList();

    try {
      // Realizar una solicitud POST al servidor
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      // Comprobar si la solicitud fue exitosa (código de respuesta 200)
      if (response.statusCode == 200) {
        print('Datos enviados exitosamente');
      } else {
        print('Error al enviar datos: ${response.statusCode}');
      }
    } catch (error) {
      print('Error de red: $error');
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, responsive){
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selecciona tus servicios',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans-SemiBold'
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Container(
                            height: 260,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFAD974F),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset:
                                    Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Positioned(
                                    top: 5,
                                    left: 10,
                                    right: 10,
                                    child: Image(
                                      image: AssetImage(
                                          items[index].icono
                                      ),
                                      width: 170,
                                      height: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 5,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: CheckboxListTile(
                                        title: Text(
                                          items[index].name,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'JosefinSans-SemiBold'
                                          ),
                                        ),
                                        value: items[index].isSelected,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            items[index].isSelected = value!;
                                          });
                                        },
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                ),
                Expanded(
                  flex: -1,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Filtrar los elementos seleccionados
                      List<ItemModel> selectedItems =
                      items.where((item) => item.isSelected).toList();

                      // Subir la información a Firebase o a cualquier servidor
                      await uploadDataToServer(selectedItems);

                      // Mostrar un mensaje después de subir la información
                      // Filtrar los elementos seleccionados
                      List<ItemModel> selected =
                      items.where((item) => item.isSelected).toList();

                      // Navegar a la otra vista y pasar la lista de elementos seleccionados
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectedItemsView(selectedItems: selected),
                        ),
                      );
                    },
                    child: Text('Ver elementos'),
                  ),
                )
              ],
            ),
          );
      },
    );
  }
}

class SelectedItemsView extends StatelessWidget {
  final List<ItemModel> selectedItems;
  const SelectedItemsView({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elementos Seleccionados'),
      ),
      body: ListView.builder(
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedItems[index].name),
          );
        },
      ),
    );
  }
}

class ItemModel {
  String name;
  String icono;
  bool isSelected;

  ItemModel(
      {required this.name, required this.icono, required this.isSelected});
}
