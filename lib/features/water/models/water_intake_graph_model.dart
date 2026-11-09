class WaterIntakeGraphModel {
  String? status;
  String? message;
  ChartConfig? chartConfig;
  WaterIntakeGraphModel({this.status, this.message, this.chartConfig});
  WaterIntakeGraphModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    chartConfig = json['chartConfig'] != null
        ? ChartConfig.fromJson(json['chartConfig'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (chartConfig != null) {
      data['chartConfig'] = chartConfig!.toJson();
    }
    return data;
  }
}

class ChartConfig {
  int? maxY;
  int? interval;
  List<Data>? data;

  ChartConfig({this.maxY, this.interval, this.data});

  ChartConfig.fromJson(Map<String, dynamic> json) {
    maxY = json['maxY'];
    interval = json['interval'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxY'] = maxY;
    data['interval'] = interval;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? day;
  int? totalMl;

  Data({this.date, this.day, this.totalMl});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    totalMl = json['total_ml'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['total_ml'] = totalMl;
    return data;
  }
}
