import 'package:fep/config/api_service.dart';
import 'package:fep/screen/home/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IngredientesEditarNombreController extends GetxController {
  final nameController = TextEditingController();
  final id = ''.obs;

  final WeeklyCalendarController controllerCalendario = Get.find();

  void actualizarNombreAlimento() async {
    Get.back(result: nameController.text);
    final apiService = ApiService();

    await apiService.fetchData(
      'alimentos/nombre',
      method: Method.PUT,
      body: {
        'id': id.value,
        'nombre': nameController.text,
      },
    );

    controllerCalendario.cargaAlimentos();
  }
}
