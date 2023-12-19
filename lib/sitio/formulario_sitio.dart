import 'package:flutter/material.dart';
import 'package:formularios/main.dart';
import 'package:formularios/sitio/pantallas.dart';
import 'package:formularios/sitio/servicios/servicios_screen.dart';

class SitioForm extends StatefulWidget {
  const SitioForm({super.key});

  @override
  State<SitioForm> createState() => _SitioFormState();
}

class _SitioFormState extends State<SitioForm> {
  PageController? controller;
  int currentIndex = 0;

  List<Pantallas> listaPantallas = <Pantallas>[];

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    _pantallasSitio();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  TextEditingController categoria = TextEditingController();
  TextEditingController titulo = TextEditingController();
  TextEditingController numeroHuespedes = TextEditingController();
  TextEditingController numeroCamas = TextEditingController();
  TextEditingController numeroBanhos = TextEditingController();
  TextEditingController descripcionSitio = TextEditingController();
  TextEditingController valorNoche = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController descripcionLugar = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController continente = TextEditingController();
  TextEditingController valorLimpieza = TextEditingController();
  TextEditingController comision = TextEditingController();
  TextEditingController politica = TextEditingController();
  TextEditingController habitaciones = TextEditingController();
  TextEditingController tituloHabitaciones = TextEditingController();
  TextEditingController descripcionHabitaciones = TextEditingController();
  TextEditingController imagenesEpa = TextEditingController();
  TextEditingController reglas = TextEditingController();
  TextEditingController seguridad = TextEditingController();

  GlobalKey<FormState> llave = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        if(responsive.maxWidth >= 1000){
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('../images/img5.webp'), fit: BoxFit.cover)),
                  child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                      (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                Map<String, dynamic> datosSitio = {
                                                  "categoria": categoria.text,
                                                  "nombreSitio": titulo.text,
                                                  "numeroHuespedes":
                                                  numeroHuespedes.text,
                                                  "numeroCamas": numeroCamas.text,
                                                  "numeroBanhos": numeroBanhos.text,
                                                  "descripcionSitio":
                                                  descripcionSitio.text,
                                                  "valorNoche": valorNoche.text,
                                                  "lugar": lugar.text,
                                                  "descripcionLugar":
                                                  descripcionLugar.text,
                                                  "latitud": latitud.text,
                                                  "longitud": longitud.text,
                                                  "continente": continente.text,
                                                  "valorLimpieza":
                                                  valorLimpieza.text,
                                                  "comision": comision.text,
                                                  "politica": politica.text,
                                                  "habitaciones": habitaciones.text,
                                                  "tituloHabitaciones":
                                                  tituloHabitaciones.text,
                                                  "descripcionHabitaciones":
                                                  descripcionHabitaciones.text,
                                                  "imagenes": imagenesEpa.text,
                                                  "reglas": reglas.text,
                                                  "seguridad": seguridad.text
                                                };
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const HomePage()));
                                                print(datosSitio);
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? 'Guardar'
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    //fontFamily: 'CedarvilleCursive'
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))
              ));
        }else if(responsive.maxWidth == 280){
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('../images/img5.webp'), fit: BoxFit.cover)),
                  child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                      (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                Map<String, dynamic> datosSitio = {
                                                  "categoria": categoria.text,
                                                  "nombreSitio": titulo.text,
                                                  "numeroHuespedes":
                                                  numeroHuespedes.text,
                                                  "numeroCamas": numeroCamas.text,
                                                  "numeroBanhos": numeroBanhos.text,
                                                  "descripcionSitio":
                                                  descripcionSitio.text,
                                                  "valorNoche": valorNoche.text,
                                                  "lugar": lugar.text,
                                                  "descripcionLugar":
                                                  descripcionLugar.text,
                                                  "latitud": latitud.text,
                                                  "longitud": longitud.text,
                                                  "continente": continente.text,
                                                  "valorLimpieza":
                                                  valorLimpieza.text,
                                                  "comision": comision.text,
                                                  "politica": politica.text,
                                                  "habitaciones": habitaciones.text,
                                                  "tituloHabitaciones":
                                                  tituloHabitaciones.text,
                                                  "descripcionHabitaciones":
                                                  descripcionHabitaciones.text,
                                                  "imagenes": imagenesEpa.text,
                                                  "reglas": reglas.text,
                                                  "seguridad": seguridad.text
                                                };
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const HomePage()));
                                                print(datosSitio);
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? 'Guardar'
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    //fontFamily: 'CedarvilleCursive'
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))
              ));
        }else if(responsive.maxWidth >= 700 || responsive.maxWidth <= 999){
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('../images/img5.webp'), fit: BoxFit.cover)),
                  child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      child: Center(
                        child: Container(
                          width: 600,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                      (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                Map<String, dynamic> datosSitio = {
                                                  "categoria": categoria.text,
                                                  "nombreSitio": titulo.text,
                                                  "numeroHuespedes":
                                                  numeroHuespedes.text,
                                                  "numeroCamas": numeroCamas.text,
                                                  "numeroBanhos": numeroBanhos.text,
                                                  "descripcionSitio":
                                                  descripcionSitio.text,
                                                  "valorNoche": valorNoche.text,
                                                  "lugar": lugar.text,
                                                  "descripcionLugar":
                                                  descripcionLugar.text,
                                                  "latitud": latitud.text,
                                                  "longitud": longitud.text,
                                                  "continente": continente.text,
                                                  "valorLimpieza":
                                                  valorLimpieza.text,
                                                  "comision": comision.text,
                                                  "politica": politica.text,
                                                  "habitaciones": habitaciones.text,
                                                  "tituloHabitaciones":
                                                  tituloHabitaciones.text,
                                                  "descripcionHabitaciones":
                                                  descripcionHabitaciones.text,
                                                  "imagenes": imagenesEpa.text,
                                                  "reglas": reglas.text,
                                                  "seguridad": seguridad.text
                                                };
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const HomePage()));
                                                print(datosSitio);
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? 'Guardar'
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    //fontFamily: 'CedarvilleCursive'
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))
              ));
        }else{
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('../images/img5.webp'), fit: BoxFit.cover)),
                  child:  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                      (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                Map<String, dynamic> datosSitio = {
                                                  "categoria": categoria.text,
                                                  "nombreSitio": titulo.text,
                                                  "numeroHuespedes":
                                                  numeroHuespedes.text,
                                                  "numeroCamas": numeroCamas.text,
                                                  "numeroBanhos": numeroBanhos.text,
                                                  "descripcionSitio":
                                                  descripcionSitio.text,
                                                  "valorNoche": valorNoche.text,
                                                  "lugar": lugar.text,
                                                  "descripcionLugar":
                                                  descripcionLugar.text,
                                                  "latitud": latitud.text,
                                                  "longitud": longitud.text,
                                                  "continente": continente.text,
                                                  "valorLimpieza":
                                                  valorLimpieza.text,
                                                  "comision": comision.text,
                                                  "politica": politica.text,
                                                  "habitaciones": habitaciones.text,
                                                  "tituloHabitaciones":
                                                  tituloHabitaciones.text,
                                                  "descripcionHabitaciones":
                                                  descripcionHabitaciones.text,
                                                  "imagenes": imagenesEpa.text,
                                                  "reglas": reglas.text,
                                                  "seguridad": seguridad.text
                                                };
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const HomePage()));
                                                print(datosSitio);
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? 'Guardar'
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    //fontFamily: 'CedarvilleCursive'
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))
              ));
        }
      },
    );
  }

  void _pantallasSitio() {
    var lista = <Pantallas>[
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageOne(
            categoriaController: categoria,
            titulo: titulo,
            numeroHuespedes: numeroHuespedes,
            numeroCamas: numeroCamas,
            numeroBanhos: numeroBanhos,
            descripcionSitio: descripcionSitio),
      )),
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageTwo(
            valorNoche: valorNoche,
            lugar: lugar,
            descripcionLugar: descripcionLugar,
            latitud: latitud,
            longitud: longitud,
            continenteController: continente),
      )),
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageThree(
            valorLimpieza: valorLimpieza,
            comision: comision,
            politica: politica,
            habitaciones: habitaciones,
            tituloHabitaciones: tituloHabitaciones,
            descripcionHabitaciones: descripcionHabitaciones,
            imagenesEpa: imagenesEpa),
      )),
      Pantallas(pantalla: const Servicios()),
      Pantallas(
          pantalla: Form(
            key: llave,
            child: PantallaPageFour(reglas: reglas, seguridad: seguridad),
          )
      )
      //Pantallas(pantalla: SelectedItemsView(selectedItems))
    ];

    setState(() {
      listaPantallas = lista;
    });
  }

  AnimatedContainer buildDot(int Index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == Index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == Index ? Colors.grey : Colors.grey),
    );
  }
}

class Pantallas {
  Widget pantalla;

  Pantallas({required this.pantalla});
}
