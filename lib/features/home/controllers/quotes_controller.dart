import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/home/repository/quotes_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuotesController extends GetxController {
  static QuotesController get instance => Get.find();

  BuildContext context;
  QuotesController(this.context);

  @override
  void onInit() {
    fetchQuotes();
    super.onInit();
  }

  // -- Variables
  final _repo = QuotesRepository();
  final apiCallHandler = ApiCallHandler();

  final _isLoading = false.obs;
  final _erroMessage = "".obs;
  final _quote = "".obs;

  // -- Getter
  bool get isLoading => _isLoading.value;
  String get errorMessage => _erroMessage.value;
  String get quote => _quote.value;

  // -- Helper Functions
  void setIntital() {
    _erroMessage.value = "";
    _quote.value = "";
  }

  void setQuots(Map<String, dynamic> data) {
    _quote.value = data['data'];
  }

  // -- API Functions
  Future<void> fetchQuotes() async {
    setIntital();

    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.fetchQuotes(),
      onSuccess: (result) => setQuots(result),
      errorMessage: _erroMessage,
      isLoading: _isLoading,
    );
  }
}
