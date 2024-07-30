enum LanguageOption {
  ptBr,
  enUs,
  fr,
}

extension LanguageOptionDescription on LanguageOption {
  String get description {
    switch (this) {
      case LanguageOption.ptBr:
        return 'pt_br';

      case LanguageOption.enUs:
        return 'en_us';
      default:
        return 'fr';
    }
  }
}
