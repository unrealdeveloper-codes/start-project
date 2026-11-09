import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/features/water/models/water_intake_graph_model.dart';
import 'package:desa/features/water/repositories/water_progress_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/datePicker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterIntakeGraphController extends GetxController {
  static WaterIntakeGraphController get intance => Get.find();

  // BuildContext context;
  // WaterIntakeGraphController(this.context);

  @override
  void onInit() {
    setInitialWeek(DateTime.now());
  //  fetchWaterIntake();
    super.onInit();
  }

  // -- Variables
  final _repo = WaterProgressRepository();
  final user = AuthController.instance.user;
  final apiCallHandler = ApiCallHandler();
  final Rx<WaterIntakeGraphModel> _waterIntake = WaterIntakeGraphModel().obs;
  final _isLoading = false.obs;
  final _erroMessage = "".obs;
  final _weekStartDate = "".obs;
  final _weekEndDate = "".obs;

  // -- Getter
  WaterIntakeGraphModel get waterIntake => _waterIntake.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _erroMessage.value;
  String get weekStartDate => _weekStartDate.value;
  String get weekEndDate => _weekEndDate.value;

  // -- Helper Functions
  void setWaterIntake(Map<String, dynamic> response) {
    final data = WaterIntakeGraphModel.fromJson(response);
    _waterIntake.value = data;
    _waterIntake.refresh();
  }

  void resetWaterGoal() {
    _waterIntake.value = WaterIntakeGraphModel();
    _erroMessage.value = "";
  }

  void setInitialWeek(DateTime date) {
    final DateTime startOfWeek = date;
    final DateTime endOfWeek = date.add(const Duration(days: 6));
    _weekStartDate.value = startOfWeek.toLocal().toString().split(" ")[0];
    _weekEndDate.value = endOfWeek.toLocal().toString().split(" ")[0];
  }

  void selectWeek(BuildContext context) async {
    try {
      final DateTime firstBlockDate = parseDateTime(user.createdAt!);
      final DateTime? pickedDate = await showAppDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstBlockDate,
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        // Calculate the week range starting from the picked date
        final DateTime startOfWeek = pickedDate;

        // Block selection of weeks that start before the allowed date
        if (startOfWeek.isBefore(firstBlockDate)) {
          AppSnackBar.showToast(
              message:
                  "Selected week starts before allowed date. Please pick another week.");
          return;
        }
        setInitialWeek(pickedDate);
        fetchWaterIntake(context);
      }
    } catch (e, s) {
      print("Error $e -- StackTrace $s");
    }
  }

  DateTime parseDateTime(String createTime) {
    // Parse the provided string into a DateTime object
    DateTime parsedDate = DateTime.parse(createTime);

    // Return a DateTime with the desired format
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
  }

  // -- API Functions
  Future<void> fetchWaterIntake(BuildContext context) async {
    if (_weekStartDate.value == "") {
      AppSnackBar.showToast(message: "Please Select Week First");
      return;
    }
    final body = {
      "first_date": _weekStartDate.value,
      "last_date": _weekEndDate.value,
    };
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.waterIntakeGraphical(body),
      onSuccess: (result) => setWaterIntake(result),
      errorMessage: _erroMessage,
      isLoading: _isLoading,
    );
  }
}


// -- Set First and Last date of week
// -- Use them in body and UI
// -- Ristrect Calendar before creation date