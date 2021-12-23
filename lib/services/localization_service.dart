import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lang/en_US.dart';
import '../lang/fr_FR.dart';

class LocalizationService extends Translations {
  static final local = Locale('en' , 'US');
  static final fallBackLocale = Locale('en' , 'US');

  static final langs = ['English' , 'French'];
  static final locales = [
    Locale("en" , "US"),
    Locale('fr' , 'FR'),
  ];

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'fr_FR' : frFR,
  };

  void changeLocale(String lang){
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale getLocaleFromLanguage(String lang){
    for(int i = 0; i < langs.length; i++){
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

}
