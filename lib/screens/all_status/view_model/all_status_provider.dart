import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:status_viewer_app/screens/all_status/api/get_all_status_api.dart';
import 'package:status_viewer_app/screens/all_status/model/all_status_model.dart';

class AllStatusProvider extends ChangeNotifier {
  AllStatusProvider() {
    getAllStatus();
  }
  List<AllStatusModel> allStatusList = [];
  List<String> jonSnow = [];
  List<String> aryaStark = [];
  List<String> tyirionLannister = [];
  List<AllStatusModel?> uniquest = [];

  bool isLoading = false;

  void getAllStatus() async {
    isLoading = true;
    notifyListeners();
    final response = await GetAllStatusApi.getAllStatus();
    allStatusList = (json.decode(response.body) as List)
        .map((data) => AllStatusModel.fromJson(data))
        .toList();

    var seen = <String>{};
    uniquest = allStatusList
        .where((student) => seen.add(student.profile!.name!))
        .toList();
    allStatusList.where((element) {
      if (element.profile!.name == "Jon Snow") {
        jonSnow.add(element.image ?? "");
      } else if (element.profile!.name == "Arya Stark") {
        aryaStark.add(element.image ?? "");
      } else if (element.profile!.name == "Tyirion Lannister") {
        tyirionLannister.add(element.image?.trim() ?? "");
      }
      return element.profile!.name == "Jon Snow";
    }).toList();

    aryaStark.removeWhere((value) => value == "");
    tyirionLannister.removeWhere((value) => value == "");
    jonSnow.removeWhere((value) => value == "");
    isLoading = false;
    notifyListeners();
  }
}
