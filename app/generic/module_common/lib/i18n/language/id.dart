import 'package:module_common/i18n/language/id/id_common_translations.dart'
    as common;
import 'package:module_common/i18n/language/id/id_dashboard_translations.dart'
    as dashboard;
import 'package:module_common/i18n/language/id/id_home_translations.dart'
    as home;
import 'package:module_common/i18n/language/id/id_login_translations.dart'
    as login;
import 'package:module_common/i18n/language/id/id_more_translations.dart'
    as more;
import 'package:module_common/i18n/language/id/id_product_translations.dart'
    as product;
import 'package:module_common/i18n/language/id/id_profile_translations.dart'
    as profile;
import 'package:module_common/i18n/language/id/id_sale_translations.dart'
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
};
