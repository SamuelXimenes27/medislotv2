import '../helpers.dart';

class R {
  static Translation string = PtBr();

  static void load(LanguageOption locale) {
    switch (locale) {
      case LanguageOption.enUs:
        string = EnUs();
        break;
      case LanguageOption.ptBr:
        string = PtBr();
        break;
      default:
        string = Fr();
        break;
    }
  }
}
