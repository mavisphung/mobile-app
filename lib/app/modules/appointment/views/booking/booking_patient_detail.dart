import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/patient_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // final _problemFocusNode = FocusNode();

  final PatientController _controller = Get.put(PatientController());
  final List<int> list = List.generate(4, (index) => index + 1);

  BookingPatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropdownValue = list.first;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: 'Patient Details'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.0.sp),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<PatientController>(
                    init: _controller,
                    builder: (PatientController controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ------------- Choose patient section -------------
                          const MySectionTitle(title: 'Patient\'s information'),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(15.0.sp),
                            ),
                            child: DropdownButton<int>(
                              value: dropdownValue,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 35.0.sp,
                              ),
                              isExpanded: true,
                              underline: const SizedBox.shrink(),
                              hint: const Text('Select patient profile'),
                              borderRadius: BorderRadius.circular(10.0),
                              items: list
                                  .map(
                                    (e) => DropdownMenuItem<int>(
                                      value: e,
                                      child: Text('$e profile'),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                dropdownValue = value ?? 1;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8.0.sp,
                          ),
                          // Dob picker
                          MyDateTimeField(hintText: Strings.dob.tr),
                          //
                          SizedBox(
                            height: 16.0.sp,
                          ),
                          const MySectionTitle(title: 'Write your problem'),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.length >= 1000) {
                                return 'Limit 1000 characters';
                              }
                              return null;
                            },
                            focusNode: FocusNode(),
                            controller: controller.problemController,
                            decoration: InputDecoration(
                              hintText: 'Description your health status, what you are suffering...',
                              contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: -18.sp),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: AppColors.whiteHighlight,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: Get.width.sp / 100 * 80,
        height: 50.sp,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: Text(
            Strings.kContinue.tr,
            style: TextStyle(fontSize: 14.0.sp),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
