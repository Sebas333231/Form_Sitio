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
    ItemModel(
        name: "Estacionamiento",
        icono: "../images/servicios/estacionamiento.png",
        isSelected: false
    ),
    ItemModel(
        name: "Buena iluminacion",
        icono: "../images/servicios/iluminacion.png",
        isSelected: false
    ),
    ItemModel(
        name: "Area para trabajar",
        icono: "../images/servicios/trabajo.png",
        isSelected: false
    ),
    ItemModel(
        name: "Articulos de oficina",
        icono: "../images/servicios/articulos.png",
        isSelected: false
    ),
    ItemModel(
        name: "Toalla por huésped",
        icono: "../images/servicios/toalla.png",
        isSelected: false
    ),
    ItemModel(
        name: "Una almohada por huésped",
        icono: "../images/servicios/almohada.png",
        isSelected: false
    ),
    ItemModel(
        name: "Sabanas para cada camas",
        icono: "../images/servicios/sabana.png",
        isSelected: false
    ),
    ItemModel(
        name: "Productos de limpieza",
        icono: "../images/servicios/limpieza.png",
        isSelected: false
    ),
    ItemModel(
        name: "Ropa de cama",
        icono: "../images/servicios/ropa1.png",
        isSelected: false
    ),
    ItemModel(
        name: "Cocina equipada",
        icono: "../images/servicios/cocina1.png",
        isSelected: false
    ),
    ItemModel(
        name: "Secador de pelo",
        icono: "../images/servicios/secador.png",
        isSelected: false
    ),
    ItemModel(
        name: "Plancha con tabla",
        icono: "../images/servicios/plancha.png",
        isSelected: false
    ),
    ItemModel(
        name: "Detector de humo",
        icono: "../images/servicios/humo.png",
        isSelected: false
    ),
    ItemModel(
        name: "Extintor de incendios",
        icono: "../images/servicios/extintor.png",
        isSelected: false
    ),
    ItemModel(
        name: "Botiquin primeros auxilios",
        icono: "../images/servicios/botiquin.png",
        isSelected: false
    ),
    ItemModel(
        name: "Asiento para niños",
        icono: "../images/servicios/asiento.png",
        isSelected: false
    ),
    // ItemModel(
    //     name: "Trona para bebes",
    //     icono: "",
    //     isSelected: false
    // ),
    ItemModel(
        name: "Juegos de mesa",
        icono: "../images/servicios/juegos.png",
        isSelected: false
    ),
    ItemModel(
        name: "Bicicletas gratuitas",
        icono: "../images/servicios/bici.png",
        isSelected: false
    ),
    ItemModel(
        name: "Gimnasio",
        icono: "../images/servicios/gym.png",
        isSelected: false
    ),
    ItemModel(
        name: "Sauna",
        icono: "../images/servicios/sauna.png",
        isSelected: false
    ),
    ItemModel(
        name: "Patio o terraza",
        icono: "../images/servicios/patio.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicio de limpieza diario",
        icono: "../images/servicios/servi.png",
        isSelected: false
    ),
    ItemModel(
        name: "Caja de seguridad",
        icono: "../images/servicios/caja.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicio de consejeria",
        icono: "../images/servicios/consejeria.png",
        isSelected: false
    ),
    ItemModel(
        name: "Mascotas permitidas",
        icono: "../images/servicios/mascotas.png",
        isSelected: false
    ),
    ItemModel(
        name: "Alquiler de coches",
        icono: "../images/servicios/alquiler.png",
        isSelected: false
    ),
    ItemModel(
        name: "Guia turistica/local",
        icono: "../images/servicios/guia.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicio de niñera",
        icono: "../images/servicios/ninheras.png",
        isSelected: false
    ),
    ItemModel(
        name: "Instrumentos musicales",
        icono: "../images/servicios/musica.png",
        isSelected: false
    ),
    ItemModel(
        name: "Tours personalizados",
        icono: "../images/servicios/tours.png",
        isSelected: false
    ),
    ItemModel(
        name: "Jardin privado",
        icono: "../images/servicios/jardin.png",
        isSelected: false
    ),
    ItemModel(
        name: "Cuna",
        icono: "../images/servicios/cuna.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicips de catering",
        icono: "../images/servicios/catering.png",
        isSelected: false
    ),
    ItemModel(
        name: "Sistema de sonido",
        icono: "../images/servicios/sonido.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicio de streaming",
        icono: "../images/servicios/stri.png",
        isSelected: false
    ),
    ItemModel(
        name: "Kit de bienvenida",
        icono: "../images/servicios/kit.png",
        isSelected: false
    ),
    ItemModel(
        name: "Servicio de barco",
        icono: "../images/servicios/bar.png",
        isSelected: false
    ),
    ItemModel(
        name: "Descuetos en restaurantes",
        icono: "../images/servicios/restaurantes.png",
        isSelected: false
    ),
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
