import 'dart:convert';
import 'dart:io';

void main() {
  // Open the input file
  File inputFile = File('config.txt');

  // Read the contents of the file
  String fileContent = inputFile.readAsStringSync();

  // Extract apiKey and projectId
  String apiKey = extractValue(fileContent, 'apiKey');
  String projectId = extractValue(fileContent, 'projectId');

// Create a map with apiKey and projectId
  Map<String, String> jsonContent = {'apiKey': apiKey, 'projectId': projectId};

  // Convert the map to JSON
  String jsonString = jsonEncode(jsonContent);

  // Write the JSON content to a file
  File outputJsonFile = File('config.json');
  outputJsonFile.writeAsStringSync(jsonString);

  print('JSON file created: config.json');
}

// Function to extract value based on key from file content
String extractValue(String content, String key) {
  RegExp regExp = RegExp('$key: \'(.*?)\'');
  Match match = regExp.firstMatch(content) as Match;
  return match.group(1) ?? '';
}
