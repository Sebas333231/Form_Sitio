import 'package:flutter/material.dart';
import 'package:formularios/categoria/formulario_categoria.dart';
import 'package:formularios/forms_provider.dart';
import 'package:formularios/sitio/formulario_sitio.dart';
import 'package:formularios/sitio/pantallas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FormsProvider>(create: (_) => FormsProvider())
      ],
      builder: (context, _){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) =>  CategoriaForm())
                );
              },
              child: const Text(
                'Categoria'
              )
            ),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SitioForm())
                  );
                },
                child: const Text(
                    'Sitio'
                )
            )
          ],
        ),
      ),
    );
  }
}

