import 'package:module_common/i18n/language/en/en_common_translations.dart'
    as common;
import 'package:module_common/i18n/language/en/en_dashboard_translations.dart'
    as dashboard;
import 'package:module_common/i18n/language/en/en_home_translations.dart'
    as home;
import 'package:module_common/i18n/language/en/en_login_translations.dart'
    as login;
import 'package:module_common/i18n/language/en/en_more_translations.dart'
    as more;
import 'package:module_common/i18n/language/en/en_product_translations.dart'
    as product;
import 'package:module_common/i18n/language/en/en_profile_translations.dart'
    as profile;
import 'package:module_common/i18n/language/en/en_stock_translations.dart'
    as stock;
import 'package:module_common/i18n/language/en/en_supplier_translations.dart'
    as supplier;
import 'package:module_common/i18n/language/en/en_transaction_translations.dart'
    as sale;

final Map<String, String> translations = {
  ...common.translations,
  ...dashboard.translations,
  ...home.translations,
  ...login.translations,
  ...more.translations,
  ...product.translations,
  ...profile.translations,
  ...sale.translations,
  ...stock.translations,
  ...supplier.translations,
};
