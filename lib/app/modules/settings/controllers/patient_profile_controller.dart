import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings_impl.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfileController extends GetxController {
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final dob = DateTime.now().obs;
  final gender = userGender.first['value']!.obs;
  final avatar = ''.obs;

  final RxList<Patient> patientList = <Patient>[].obs;

  final status = Status.init.obs;

  final _provider = Get.put(ApiSettingsImpl());

  late XFile? file;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    addressFocusNode.dispose();
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    dob.close();
    gender.close();
    avatar.close();
    super.dispose();
  }

  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  void setStatusLoading() {
    status.value = Status.loading;
  }

  void setStatusSuccess() {
    status.value = Status.success;
  }

  void setStatusFail() {
    status.value = Status.fail;
  }

  Future<bool> getPatientList({int page = 1, int limit = 10}) async {
    final response = await _provider.getPatientList(page: page, limit: limit);

    Map<String, dynamic> result = ApiResponse.getResponse(response);
    ResponseModel2 model = ResponseModel2.fromMap(result);
    var data = model.data as dynamic;

    if (data.isNotEmpty) {
      patientList.addAll(data.map<Patient>(
        (e) => Patient(
          id: e['id'],
          firstName: e['firstName'],
          lastName: e['lastName'],
          dob: e['dob'],
          address: e['address'],
          gender: e['gender'],
          avatar: e['avatar'],
          supervisorId: e['supervisor_id'],
          oldHealthRecords: e['old_health_records'],
        ),
      ));
      return true;
    }
    return false;
  }

  Future<bool> getPatientWithId(int id) async {
    final response = await _provider.getPatientProfile(id).futureValue();

    if (response != null && response.isSuccess == true) {
      final patient = Patient.fromMap(response.data);
      firstName.text = patient.firstName ?? '';
      lastName.text = patient.lastName ?? '';
      dob.value = Utils.parseStrToDate(patient.dob ?? '') ?? DateTime.now();
      if (patient.gender != null) {
        gender.value = patient.gender!;
      }
      address.text = patient.address ?? '';
      avatar.value = patient.avatar ?? Constants.defaultAvatar;
      return true;
    }
    return false;
  }

  void getImage(bool isFromCamera) async {
    file = isFromCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    List<XFile> files = <XFile>[];
    files.add(file!);
    var response = await _provider.postPresignedUrls(files);
    if (response.isOk) {
      ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
      String fileExt = file!.name.split('.')[1];
      String fullUrl = resModel.data['urls'][0];
      String url = fullUrl.split('?')[0];

      await Utils.upload(fullUrl, File(file!.path), fileExt);
      try {
        avatar.value = url;
      } catch (e) {
        print('error $e');
        rethrow;
      }
    }
  }

  void addPatientProfile() async {
    if (avatar.value.isEmpty) {
      Utils.showAlertDialog('Avatar of patient is missing');
      return;
    }
    setStatusLoading();

    Patient info = Patient(
      firstName: firstName.value.text,
      lastName: lastName.value.text,
      dob: '2002-05-08',
      address: address.value.text,
      gender: gender.value,
      avatar: avatar.value,
    );
    var response = await _provider.postPatientProfile(info).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      setStatusSuccess();
      Get.back();
      Utils.showTopSnackbar('Add patient profile sucessfully', title: 'Notice');
    } else {
      Get.snackbar('Error ${response?.statusCode}', 'Error while updating profile', backgroundColor: Colors.red);
      setStatusFail();
    }
  }
}
