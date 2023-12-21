abstract class JsonUtils {
  static double validateIntOrDouble(dynamic value) {
    return value is int ? value.toDouble() : value;
  }
}
