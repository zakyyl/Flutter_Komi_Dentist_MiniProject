import 'dart:convert';

import 'package:komi_dentist/env/constants/open_ai.dart';
import 'package:komi_dentist/models/open_ai.dart';
import 'package:komi_dentist/models/usage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RecommendationService {
  static Future<GptData> getRecommendations({
    required String dentalConcern,
  }) async {
    late GptData gptData = GptData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: Usage(completionTokens: 0, promptTokens: 0, totalTokens: 0),
    );

    try {
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');

      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $apiKey',
      };

      final data = jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a dental expert."},
            {"role": "system", "content": "Please give me a dental recommendation for the following concern: $dentalConcern."},
          ],
          "max_tokens": 200,
        },
      );

      var response = await http.post(url, headers: headers, body: data);
      print("Hasil dari service recomendation_service.dart:");
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Error occured when sending request.');
    }

    return gptData;
  }
}
