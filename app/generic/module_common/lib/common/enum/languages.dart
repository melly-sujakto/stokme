enum Languages {
  en('en', 'English', 'common.lang.en', 'EN'),
  id('id', 'Bahasa', 'common.lang.id', 'ID');

  const Languages(this.code, this.value, this.label, this.labelShort);

  final String code;
  final String value;
  final String label;
  final String labelShort;
}
