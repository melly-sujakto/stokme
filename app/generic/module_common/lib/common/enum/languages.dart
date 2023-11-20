enum Languages {
  en('en', 'ENGLISH', 'common.lang.en', 'EN'),
  id('id', 'BAHASA', 'common.lang.id', 'ID');

  const Languages(this.code, this.value, this.label, this.labelShort);

  final String code;
  final String value;
  final String label;
  final String labelShort;
}
