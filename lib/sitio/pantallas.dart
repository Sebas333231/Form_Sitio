import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:formularios/forms_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import 'habitaciones/form_habitaciones.dart';
import 'servicios/servicios_screen.dart';


//Pagina 1

class PantallaPageOne extends StatefulWidget {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController titulo = TextEditingController();
  TextEditingController numeroHuespedes = TextEditingController();
  TextEditingController numeroCamas = TextEditingController();
  TextEditingController numeroBanhos = TextEditingController();
  TextEditingController descripcionSitio = TextEditingController();
  PantallaPageOne(
      {super.key,
      required this.categoriaController,
      required this.titulo,
      required this.numeroHuespedes,
      required this.numeroCamas,
      required this.numeroBanhos,
      required this.descripcionSitio});

  @override
  State<PantallaPageOne> createState() => _PantallaPageOneState(
      categoriaController: categoriaController,
      titulo: titulo,
      numeroHuespedes: numeroHuespedes,
      numeroCamas: numeroCamas,
      numeroBanhos: numeroBanhos,
      descripcionSitio: descripcionSitio);
}

class _PantallaPageOneState extends State<PantallaPageOne> {
  final List<String> categoria = [
    'Cabañas',
    'Piscinas Increibles',
    'Casas rurales',
    'Casas alpinas'
  ];

  String? seleccionaCategoria;

  TextEditingController categoriaController = TextEditingController();
  TextEditingController titulo = TextEditingController();
  TextEditingController numeroHuespedes = TextEditingController();
  TextEditingController numeroCamas = TextEditingController();
  TextEditingController numeroBanhos = TextEditingController();
  TextEditingController descripcionSitio = TextEditingController();

  _PantallaPageOneState(
      {required this.categoriaController,
      required this.titulo,
      required this.numeroHuespedes,
      required this.numeroCamas,
      required this.numeroBanhos,
      required this.descripcionSitio});

  var numeroH =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, responsive){
          if(responsive.maxWidth <= 699){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agrega tu Sitio',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'CedarvilleCursive',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Categoria',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: categoria
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: seleccionaCategoria,
                      onChanged: (String? value) {
                        setState(() {
                          seleccionaCategoria = value;
                          categoriaController.text = seleccionaCategoria!;
                        });

                        if (seleccionaCategoria == null ||
                            seleccionaCategoria!.isEmpty) {
                          return;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        controller: titulo,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Titulo del sitio',
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
                  const SizedBox(height: 15),
                  const Text(
                    'Numero de Huespedes',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      //fontFamily: 'CedarvilleCursive'
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        inputFormatters: [numeroH],
                        controller: numeroHuespedes,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Numero de Camas',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              //fontFamily: 'CedarvilleCursive'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroCamas,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          const Text(
                            'Numero de Baños',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              //fontFamily: 'Arimo-Medium'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroBanhos,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        maxLines: 8,
                        controller: descripcionSitio,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Descripcion',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Se requiere de este campo';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else if(responsive.maxWidth >= 700 || responsive.maxWidth <= 999){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agrega tu Sitio',
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'CedarvilleCursive',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Categoria',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: categoria
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: seleccionaCategoria,
                      onChanged: (String? value) {
                        setState(() {
                          seleccionaCategoria = value;
                          categoriaController.text = seleccionaCategoria!;
                        });

                        if (seleccionaCategoria == null ||
                            seleccionaCategoria!.isEmpty) {
                          return;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        controller: titulo,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Titulo del sitio',
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
                  const SizedBox(height: 15),
                  const Text(
                    'Numero de Huespedes',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      //fontFamily: 'CedarvilleCursive'
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        inputFormatters: [numeroH],
                        controller: numeroHuespedes,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Numero de Camas',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              //fontFamily: 'CedarvilleCursive'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroCamas,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          const Text(
                            'Numero de Baños',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              //fontFamily: 'Arimo-Medium'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroBanhos,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        maxLines: 8,
                        controller: descripcionSitio,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Descripcion',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Se requiere de este campo';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else if(responsive.maxWidth >= 1000){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agrega tu Sitio',
                    style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'CedarvilleCursive',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Categoria',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: categoria
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: seleccionaCategoria,
                      onChanged: (String? value) {
                        setState(() {
                          seleccionaCategoria = value;
                          categoriaController.text = seleccionaCategoria!;
                        });

                        if (seleccionaCategoria == null ||
                            seleccionaCategoria!.isEmpty) {
                          return;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        controller: titulo,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Titulo del sitio',
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
                  const SizedBox(height: 15),
                  const Text(
                    'Numero de Huespedes',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      //fontFamily: 'CedarvilleCursive'
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        inputFormatters: [numeroH],
                        controller: numeroHuespedes,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Numero de Camas',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              //fontFamily: 'CedarvilleCursive'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroCamas,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          const Text(
                            'Numero de Baños',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              //fontFamily: 'Arimo-Medium'
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                inputFormatters: [numeroH],
                                controller: numeroBanhos,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        maxLines: 8,
                        controller: descripcionSitio,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Descripcion',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Se requiere de este campo';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Container();
          }
        }
    );
  }
}



//Pagina 2

class PantallaPageTwo extends StatefulWidget {
  TextEditingController valorNoche = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController descripcionLugar = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController continenteController = TextEditingController();
  PantallaPageTwo(
      {super.key,
      required this.valorNoche,
      required this.lugar,
      required this.descripcionLugar,
      required this.latitud,
      required this.longitud,
      required this.continenteController});

  @override
  State<PantallaPageTwo> createState() => _PantallaPageTwoState(
      valorNoche: valorNoche,
      lugar: lugar,
      descripcionLugar: descripcionLugar,
      longitud: longitud,
      latitud: latitud,
      continenteController: continenteController);
}

class _PantallaPageTwoState extends State<PantallaPageTwo> {
  TextEditingController valorNoche = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController descripcionLugar = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController continenteController = TextEditingController();

  _PantallaPageTwoState(
      {required this.valorNoche,
      required this.lugar,
      required this.descripcionLugar,
      required this.latitud,
      required this.longitud,
      required this.continenteController});

  var valorN =
      MaskTextInputFormatter(mask: "#######", filter: {"#": RegExp(r'[0-9]')});

  final List<String> continente = [
    'America',
    'Europa',
    'Asia',
    'Africa',
    'Oseania'
  ];

  String? seleccionaContinente;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, responsive) {
          if(responsive.maxWidth >=  1000){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        inputFormatters: [valorN],
                        controller: valorNoche,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Valor noche',
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
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        controller: lugar,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Lugar',
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
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        maxLines: 10,
                        controller: descripcionLugar,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Descripcion del lugar',
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
                  const SizedBox(height: 15),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Continente',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: continente
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: seleccionaContinente,
                      onChanged: (String? value) {
                        setState(() {
                          seleccionaContinente = value;
                          continenteController.text = seleccionaContinente!;
                        });

                        if (seleccionaContinente == null ||
                            seleccionaContinente!.isEmpty) {
                          return;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          /*const Text(
                    'Longitud',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),*/
                          const SizedBox(height: 5),
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                controller: longitud,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    hintText: 'Longitud'),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Se requiere de este campo';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          /*const Text(
                    'Latitud',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),*/
                          const SizedBox(height: 5),
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                controller: latitud,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    hintText: 'Latitud'),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Se requiere de este campo';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }else{
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        inputFormatters: [valorN],
                        controller: valorNoche,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Valor noche',
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
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        controller: lugar,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Lugar',
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
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: TextFormField(
                        maxLines: 10,
                        controller: descripcionLugar,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Descripcion del lugar',
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
                  const SizedBox(height: 15),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Continente',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: continente
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: seleccionaContinente,
                      onChanged: (String? value) {
                        setState(() {
                          seleccionaContinente = value;
                          continenteController.text = seleccionaContinente!;
                        });

                        if (seleccionaContinente == null ||
                            seleccionaContinente!.isEmpty) {
                          return;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                controller: longitud,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    hintText: 'Longitud'),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Se requiere de este campo';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                controller: latitud,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    hintText: 'Latitud'),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Se requiere de este campo';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        }
    );
  }
}



//Pagina 3
class PantallaPageThree extends StatefulWidget {
  TextEditingController valorLimpieza = TextEditingController();
  TextEditingController comision = TextEditingController();
  TextEditingController politica = TextEditingController();
  TextEditingController habitaciones = TextEditingController();
  TextEditingController tituloHabitaciones = TextEditingController();
  TextEditingController descripcionHabitaciones = TextEditingController();
  TextEditingController imagenesEpa = TextEditingController();
  PantallaPageThree(
      {super.key,
      required this.valorLimpieza,
      required this.comision,
      required this.politica,
      required this.habitaciones,
      required this.tituloHabitaciones,
      required this.descripcionHabitaciones,
      required this.imagenesEpa});

  @override
  State<PantallaPageThree> createState() => _PantallaPageThreeState(
      valorLimpieza: valorLimpieza,
      comision: comision,
      politica: politica,
      habitaciones: habitaciones,
      tituloHabitaciones: tituloHabitaciones,
      descripcionHabitaciones: descripcionHabitaciones,
      imagenesEpa: imagenesEpa);
}

class _PantallaPageThreeState extends State<PantallaPageThree> {
  TextEditingController valorLimpieza = TextEditingController();
  TextEditingController comision = TextEditingController();
  TextEditingController politica = TextEditingController();
  TextEditingController habitaciones = TextEditingController();
  TextEditingController tituloHabitaciones = TextEditingController();
  TextEditingController descripcionHabitaciones = TextEditingController();
  TextEditingController imagenesEpa = TextEditingController();

  _PantallaPageThreeState(
      {required this.valorLimpieza,
      required this.comision,
      required this.politica,
      required this.habitaciones,
      required this.tituloHabitaciones,
      required this.descripcionHabitaciones,
      required this.imagenesEpa});

  var valorL =
      MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'[0-9]')});

  var comisionC =
      MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'[0-9]')});

  bool isChecked = false;
  bool isChecked2 = false;

  List<TextEditingController> _controllers = <TextEditingController>[];
  @override
  void initState() {
    // TODO: implement initState
    _controllers = context.read<FormsProvider>().controller;
    super.initState();
  }

  final controller = MultiImagePickerController(
    maxImages: 50,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<TextEditingController> dynamicControllers =
        context.watch<FormsProvider>().controller;
    return LayoutBuilder(
        builder: (context, responsive){
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: TextFormField(
                          inputFormatters: [valorL],
                          controller: valorLimpieza,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Valor limpieza'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Se requiere de este campo';
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 2.0),
                        child: TextFormField(
                          inputFormatters: [comisionC],
                          controller: comision,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Comision'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Se requiere de este campo';
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Habitaciones',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Checkbox(
                          activeColor: Color(0xFFAD974F),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                            habitaciones.text = isChecked.toString();
                          },
                        ),
                        if(isChecked == true)
                          GestureDetector(
                            onTap: () {
                              showDialogFunc(context, dynamicControllers);
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFAD974F),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Center(
                                child: Text(
                                  'Agregar',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    //fontFamily: 'CedarvilleCursive'
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Aceptar términos y condiciones',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Checkbox(
                          activeColor: Color(0xFFAD974F),
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value ?? false;
                            });
                            politica.text = isChecked2.toString();
                          },
                        ),
                      ],
                    ),
                    MultiImagePickerView(
                      onDragBoxDecoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.45),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:
                            const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      onChange: (list) {
                        debugPrint(list.toString());

                        String images = controller.images.toString();
                        imagenesEpa.text = images;
                      },
                      controller: controller,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                    const SizedBox(height: 32),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.white,),
                      onPressed: () {
                        final images = controller.images;
                        // use these images
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(images.map((e) => e.name).toString())));
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ));
        }
    );
  }

  showDialogFunc(context, List dynamicControllers) {

    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 450,
                  width: 400,
                  child: Expanded(
                    child: Example(tituloHabitaciones: tituloHabitaciones),
                  )),
            ),
          ),
        );
      },
    );
  }


  showDialogFunction(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(15),
                height: 450,
                width: 400,
                child: const SingleChildScrollView(
                  child: Expanded(
                    child: Servicios(),
                  ),
                )),
          ),
        );
      },
    );
  }
}



//Pagina 4

class PantallaPageFour extends StatefulWidget {
  TextEditingController reglas = TextEditingController();
  TextEditingController seguridad = TextEditingController();
  PantallaPageFour({super.key, required this.reglas, required this.seguridad});

  @override
  State<PantallaPageFour> createState() => _PantallaPageFourState(reglas: reglas, seguridad: seguridad);
}


class _PantallaPageFourState extends State<PantallaPageFour> {


  TextEditingController reglas = TextEditingController();
  TextEditingController seguridad = TextEditingController();

  _PantallaPageFourState({required this.reglas, required this.seguridad});



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
              'Reglas del sitio',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
                fontFamily: 'JosefinSans-SemiBold'
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: TextFormField(
                controller: reglas,
                maxLines: 10,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Reglas',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Se requiere de este campo';
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Seguridad del sitio',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'JosefinSans-SemiBold'
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: TextFormField(
                controller: seguridad,
                maxLines: 10,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Seguridad',
                  //fillColor: Colors.grey[200],
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Se requiere de este campo';
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
