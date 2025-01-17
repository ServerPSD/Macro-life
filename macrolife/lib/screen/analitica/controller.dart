import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/analiticaNutricion.model.dart';
import 'package:macrolife/screen/objetivos/controller.dart';

class AnaliticaController extends GetxController {
  final RxList<ChartData> charSorce = <ChartData>[].obs;
  final Rx<AnaliticaNutricionModel> analiticaNutricion =
      AnaliticaNutricionModel().obs;

  final List<String> listaNutricion = [
    'Esta semana',
    'La semana pasada',
    'Hace 2 semanas',
    'Hace 3 semanas'
  ];

  final tipoBusqueda = 'Esta semana'.obs;

  final color = Colors.transparent.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetch();
    // TODO: implement onInit

    super.onInit();
  }

  Future<void> fetch() async {
    try {
      UsuarioController usuarioController = Get.find();

      isLoading(true);

      charSorce.clear(); // Limpiar datos anteriores

      final apiService = ApiService();
      final response = await apiService.fetchData(
        'analitica/nutricion',
        method: Method.POST,
        body: {
          'idUsuario': usuarioController.usuario.value.sId,
          'tipoBusqueda': tipoBusqueda.value,
        },
      );

      AnaliticaNutricionModel nutricion =
          AnaliticaNutricionModel.fromJson(response);

      print(response);
      for (Dias dia in nutricion.dias ?? []) {
        charSorce.add(ChartData(
            dia.dia ?? '', dia.promedio?.toDouble() ?? 0, Colors.black));
      }

      analiticaNutricion.value = nutricion;

      isLoading(false);
      refresh();
    } catch (e) {
      charSorce.clear(); // Limpiar datos anteriores

      print(e);
    }
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );

    int index = value.toInt();

    String valor = charSorce[index].label;
    Widget text;
    text = Text(valor, style: style);
    return text;
  }
}
