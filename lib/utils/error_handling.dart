import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_example/utils/constant.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  VoidCallback? fail,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message'] ?? 'Error 400');
      break;
    case 401:
      if (fail != null) {
        fail();
      }
      showSnackBar(context, jsonDecode(response.body)['message'] ?? 'Unauthorized');
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'] ?? 'Internal server error');
      break;
    default:
      showSnackBar(context, 'Unexpected error: ${response.body}');
  }
}
