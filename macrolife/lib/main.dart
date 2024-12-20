// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/configuraciones.dart';
import 'package:macrolife/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  final configuracionesController = Get.put(ConfiguracionesController());
  // await configuracionesController.buscaConfiguraciones();
  Stripe.merchantIdentifier = 'merchant.mx.posibilidades.macrolife';

  Stripe.publishableKey =
      configuracionesController.configuraciones.value.stripe?.publicKey ?? '';
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Solo permite orientación vertical normal
    DeviceOrientation
        .portraitDown, // Permite orientación vertical invertida (opcional)
  ]).then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial,
        theme: themeData,
        getPages: AppPages.pages,
        locale: const Locale('es', 'MX'),
        supportedLocales: const [Locale('es', 'MX')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
      ),
    );
  });
}
