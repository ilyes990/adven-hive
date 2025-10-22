import 'package:flutter_gemini/flutter_gemini.dart';
import 'adventure_model.dart';

// Abstract repository interface
abstract class AdventureRepository {
  Future<String> generateItems(AdventureModel adventureModel);
}

// Implementation of the repository
class AdventureRepositoryImpl implements AdventureRepository {
  @override
  Future<String> generateItems(AdventureModel adventureModel) async {
    try {
      // Add a small delay to ensure Gemini is initialized
      await Future.delayed(const Duration(milliseconds: 100));

      // Build the prompt
      final prompt = '''
Generate a list of essential items for an adventure.
Type: ${adventureModel.type}
Members: ${adventureModel.members}
Difficulty: ${adventureModel.difficulty}
Distance: ${adventureModel.distance}km
Challenge: ${adventureModel.challenge}
Weather: ${adventureModel.weather}

Output only items separated with - Example: Backpacks - Hiking boots - Tent
''';

      print('Sending prompt to Gemini: $prompt');

      // Use the correct Gemini API method
      final response = await Gemini.instance.text(prompt);

      if (response == null) {
        throw Exception('No response from AI');
      }

      print('Raw Gemini response type: ${response.runtimeType}');
      print('Raw Gemini response: $response');

      // Extract the text content from the response
      String responseText = '';

      try {
        // Handle the response as dynamic to access its properties
        final dynamicResponse = response as dynamic;

        // Try to extract text from the response
        if (dynamicResponse.content != null &&
            dynamicResponse.content.parts != null &&
            dynamicResponse.content.parts.isNotEmpty) {
          responseText = dynamicResponse.content.parts.first.text ?? '';
        } else {
          responseText = response.toString();
        }

        // Remove the "Instance of Candidates" part if present
        if (responseText.contains('Instance of Candidates')) {
          // Try to extract actual content
          final contentMatch = responseText.contains('content:');
          if (contentMatch) {
            final startIndex = responseText.indexOf('content:') + 8;
            final endIndex = responseText.lastIndexOf('}');
            if (startIndex > 8 && endIndex > startIndex) {
              responseText =
                  responseText.substring(startIndex, endIndex).trim();
            }
          }
        }
      } catch (e) {
        print('Error extracting text from response: $e');
        responseText = response.toString();
      }

      print('Extracted response text: $responseText');

      if (responseText.isEmpty) {
        throw Exception('Empty response from AI');
      }

      return responseText;
    } catch (e) {
      print('AI Generation Error: $e');
      throw Exception('Failed to generate items: $e');
    }
  }
}
