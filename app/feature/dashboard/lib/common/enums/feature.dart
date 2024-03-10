enum Feature {
  sale('sale'),
  stockIn('stockIn'),
  product('product'),
  stock('stock'),
  transaction('transaction'),
  supplier('supplier'),
  ;

  const Feature(this.value);
  final String value;

  static Feature fromString(String value) {
    final foundEnum =
        Feature.values.where((val) => val.value == value).firstOrNull;

    if (foundEnum == null) {
      throw UnsupportedError('Feature: $value is not supported');
    }
    return foundEnum;
  }
}
