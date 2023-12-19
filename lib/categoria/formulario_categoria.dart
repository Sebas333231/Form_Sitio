import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:formularios/forms_provider.dart';
import 'package:formularios/main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CategoriaForm extends StatefulWidget {
  const CategoriaForm({super.key});

  @override
  State<CategoriaForm> createState() => _CategoriaFormState();
}

class _CategoriaFormState extends State<CategoriaForm> {
  //Validacion de formularios
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController categiria = TextEditingController();
  TextEditingController imagenController = TextEditingController();

  String selectFile = '';
  Uint8List? selectedImagenInBytes;
  int imagenCounts = 0;
  List<Uint8List> pickedImagesBytes = [];
  String foto = '';


  _selectFile(bool imagenFrom) async{
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if(fileResult != null){
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImagenInBytes = fileResult.files.first.bytes;

        imagenController.text = selectFile;
      });
    }
    print(selectFile);
  }

  Uint8List? iconBytes;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget titleBox(String title) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(title,
              style: TextStyle(color: colorScheme.onInverseSurface)),
        ),
      );
    }




    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              '../images/fondo1.webp'
            ),
            fit: BoxFit.cover
          )
        ),
        child: LayoutBuilder(
          builder: (context, responsive) {
            if (responsive.maxWidth <= 730) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0x54C4C2C2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Categoria',
                                  style: TextStyle(
                                      fontFamily: 'CedarvilleCursive',
                                      fontSize: 40,
                                      color: Colors.black
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Form(
                                  key: formKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, right: 2.0),
                                              child: TextFormField(
                                                controller: categiria,
                                                obscureText: false,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                  const TextStyle(fontSize: 13),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  hintText: 'Categoria',
                                                  fillColor: Colors.grey[200],
                                                  filled: true,
                                                ),
                                                validator: (String? value){
                                                  if(value == null || value.isEmpty){
                                                    return "Se requiere de este campo";
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: ()async{
                                            _selectFile(true);
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 50,
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFFFFF),
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Seleccionar imagen',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: 150,
                                          height: 150,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                                          ),
                                          child: selectFile.isEmpty
                                              ? Image.asset(
                                            '../images/img2.jpg',
                                            fit: BoxFit.cover,
                                          ) : Image.memory(
                                            selectedImagenInBytes!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: ()async{
                                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                                            if(result != null){
                                              setState(() {
                                                iconBytes = result.files.single.bytes;
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 50,
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Seleccionar icono',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        if(iconBytes != null)
                                          Image.memory(
                                            iconBytes!,
                                            width: 50,
                                            height: 50,
                                          )else
                                          const Text(
                                            'No se ha seleccionado ningun icono',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'CedarvilleCursive',
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                      ],
                                    )
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            } else if (responsive.maxWidth <= 950 ||
                responsive.maxWidth == 1024) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Container(
                    height: responsive.maxWidth > 1024 ? 600 : 500,
                    decoration: BoxDecoration(
                        color: Color(0x54C4C2C2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                            ),
                            child: selectFile.isEmpty
                                ? Image.asset(
                                '../images/img2.jpg',
                              fit: BoxFit.cover,
                            ) : Image.memory(
                                selectedImagenInBytes!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    'Categoria',
                                  style: TextStyle(
                                    fontFamily: 'CedarvilleCursive',
                                    fontSize: 40,
                                    color: Colors.black
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 2.0),
                                            child: TextFormField(
                                              controller: categiria,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    const TextStyle(fontSize: 13),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                hintText: 'Categoria',
                                                fillColor: Colors.grey[200],
                                                filled: true,
                                              ),
                                              validator: (String? value){
                                                if(value == null || value.isEmpty){
                                                  return "Se requiere de este campo";
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: ()async{
                                          _selectFile(true);
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFA810),
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Seleccionar imagen',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: ()async{
                                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                                          if(result != null){
                                            setState(() {
                                              iconBytes = result.files.single.bytes;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 180,
                                          height: 50,
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Seleccionar icono',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      if(iconBytes != null)
                                        Image.memory(
                                          iconBytes!,
                                          width: 100,
                                          height: 100,
                                        )else
                                          const Text(
                                              'No se ha seleccionado ningun icono',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'CedarvilleCursive',
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                    ],
                                  )
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: Container(
                width: 950,
                height: 550,
                decoration: BoxDecoration(
                    color: Color(0x54C4C2C2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                        ),
                        child: selectFile.isEmpty
                            ? Image.asset(
                          '../images/img2.jpg',
                          fit: BoxFit.cover,
                        ) : Image.memory(
                          selectedImagenInBytes!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Categoria',
                              style: TextStyle(
                                  fontFamily: 'CedarvilleCursive',
                                  fontSize: 40,
                                  color: Colors.black
                              ),
                            ),
                            const SizedBox(height: 30),
                            Form(
                              key: formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0, right: 2.0),
                                          child: TextFormField(
                                            controller: categiria,
                                            obscureText: false,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              labelStyle:
                                              const TextStyle(fontSize: 13),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                              hintText: 'Categoria',
                                              fillColor: Colors.grey[200],
                                              filled: true,
                                            ),
                                            validator: (String? value){
                                              if(value == null || value.isEmpty){
                                                return "Se requiere de este campo";
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: ()async{
                                        _selectFile(true);
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFA810),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Seleccionar imagen',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: ()async{
                                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                                        if(result != null){
                                          setState(() {
                                            iconBytes = result.files.single.bytes;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 180,
                                        height: 50,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Seleccionar icono',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    if(iconBytes != null)
                                      Image.memory(
                                        iconBytes!,
                                        width: 100,
                                        height: 100,
                                      )else
                                      const Text(
                                        'No se ha seleccionado ningun icono',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'CedarvilleCursive',
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ],
                                )
                            )
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(formKey.currentState!.validate()){
            Map<String, dynamic> datosCategoria = {
              "categoria": categiria.text,
              "imagen": imagenController.text
            };

            Navigator.of(context).push(
              MaterialPageRoute(builder: (_)  => const HomePage())
            );

            print(datosCategoria);
          }
        },
        label: const Text(
            'Guardar',
          style: TextStyle(
            color: Colors.black, fontSize: 17, fontFamily: 'CedarvilleCursive'
          ),
        ),
        icon: const Icon(
            Icons.save, color: Colors.black,
        ),
      ),
    );
  }
}

