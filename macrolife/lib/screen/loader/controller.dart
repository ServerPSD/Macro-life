import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoaderController extends GetxController {
  RxBool loading = true.obs;
  final argumentos = Get.arguments;

  final box = GetStorage();

  @override
  void onInit() async {
    super.onInit();

    try {
      var args = Get.arguments;

      // Puedes acceder a los valores de esta manera:
      var genero = args["genero"];
      var entrenamiento = args["entrenamiento"];
      var aplicacionSimilar = args["aplicacionSimilar"];
      var altura = args["altura"];
      var peso = args["peso"];
      var fechaNacimiento = args["fechaNacimiento"];
      var objetivo = args["objetivo"];
      var pesoDeseado = args["pesoDeseado"];
      var dieta = args["dieta"];
      var lograr = args["lograr"];
      var metaVelocidad = args["metaVelocidad"];
      var metaImpedimento = args["metaImpedimento"];
      var codigo = args["codigo"];
      var appleID = args["appleID"];
      var googleId = args["googleId"];
      var correo = args["correo"];
      var telefono = args["telefono"];
      var nombre = args["nombre"];

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'registro',
        method: Method.POST,
        body: {
          'genero': genero,
          'entrenamiento': entrenamiento,
          'aplicacionSimilar': aplicacionSimilar,
          'altura': altura,
          'peso': peso,
          'fechaNacimiento': fechaNacimiento,
          'objetivo': objetivo,
          'pesoDeseado': pesoDeseado,
          'dieta': dieta,
          'lograr': lograr,
          'metaVelocidad': metaVelocidad,
          'metaImpedimento': metaImpedimento,
          'referidoCodigo': codigo,
          'appleID': appleID,
          'googleId': googleId,
          'correo': correo,
          'telefono': telefono,
          'nombre': nombre
        },
      );

      UsuarioController usuarioController = Get.put(UsuarioController());

      usuarioController.saveUsuarioFromJson(response['usuario']);

      RegistroPasosController registroPasosController = Get.find();
      loading.value = false;
      registroPasosController.nextStep();
      registroPasosController.currentStep++;
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Registro',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
