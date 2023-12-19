import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


class FormsProvider with ChangeNotifier{

  FromsProvider(){
    createControllers();
    createControllers2();
    deleteControllers();
    deleteControllers2();
  }

  final List<TextEditingController> _controllers = <TextEditingController>[];

  List<TextEditingController> get controller =>  _controllers;


  Future<void> createControllers() async{
    _controllers.add(TextEditingController());
    notifyListeners();
  }

  Future<void> deleteControllers({index}) async{
    _controllers.remove(index);
    notifyListeners();
  }


  //descripcion

  final List<TextEditingController> _controllers2 = <TextEditingController>[];

  List<TextEditingController> get controller2 =>  _controllers2;


  Future<void> createControllers2() async{
    _controllers2.add(TextEditingController());
    notifyListeners();
  }

  Future<void> deleteControllers2({index}) async{
    _controllers2.remove(index);
    notifyListeners();
  }
}