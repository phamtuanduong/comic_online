import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/account_info_controllers/account_change_info_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({Key? key, required this.persionModel})
      : super(key: key);
  final PersionModel persionModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.12),
        leading: ButtomBack(
          onClick: () {
            Get.back();
          },
        ),
        title: Text(
          "Thông tin tài khoản",
          style: textSubStyle.copyWith(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<AccChangeInfoController>(
          init: AccChangeInfoController(persionModel),
          builder: (_controller) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding),
                CustomTextField(
                  hintText: "Họ tên người dùng",
                  invalidText: _controller.invalidTextFullName,
                  controller: _controller.textFullNameController,
                ),
                const SizedBox(height: defaultPadding / 2),
                CustomTextField(
                  hintText: "Email",
                  invalidText: _controller.invalidTextEmail,
                  controller: _controller.textEmailController,
                ),
                const SizedBox(height: defaultPadding),
                const Text('Chọn giới tính'),
                ListTile(
                  title: const Text('Nam'),
                  leading: Radio<Gender>(
                    value: Gender.nam,
                    groupValue: _controller.gender,
                    onChanged: (Gender? value) {
                      _controller.gender = value!;
                      _controller.update();
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Nữ'),
                  leading: Radio<Gender>(
                    value: Gender.nu,
                    groupValue: _controller.gender,
                    onChanged: (Gender? value) {
                      _controller.gender = value!;
                      _controller.update();
                    },
                  ),
                ),
                const SizedBox(height: defaultPadding),
                const Text('Thiết lập sinh nhật'),
                const SizedBox(height: defaultPadding / 2),
                TextButton(
                    onPressed: () {
                      buildCupertinoDatePicker(context, _controller);
                    },
                    child: Text(_controller.getDateFormat())),
                const SizedBox(height: defaultPadding),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      bool flag = await _controller.updateInfo();
                      if (!flag) {
                        Get.snackbar("Thay đổi không thành công",
                            "Vui lòng nhập lại thông tin",
                            duration: const Duration(milliseconds: 900),
                            icon: const Icon(Icons.error),
                            backgroundColor: Colors.white54);
                      }
                      if (flag) {
                        Get.snackbar(
                          "Thay đổi thành công",
                          "Thay đổi thông tin tài khoản thành công",
                          duration: const Duration(milliseconds: 900),
                          icon: const Icon(Icons.check),
                          backgroundColor: Colors.white54,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: _controller.isRegisting
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        Text("Cập nhật thông tin", style: textDetailStyle),
                        _controller.isRegisting
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 3))
                            : const SizedBox(),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        fixedSize: const Size(220, 45),
                        primary: Colors.white,
                        backgroundColor: primaryColor.withOpacity(0.8),
                        shape: const StadiumBorder()),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

buildCupertinoDatePicker(
    BuildContext context, AccChangeInfoController controller) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              if (picked != controller.selectedDate) {
                controller.selectedDate = picked;
                controller.update();
              }
            },
            initialDateTime: controller.selectedDate,
            minimumYear: 1900,
            dateOrder: DatePickerDateOrder.dmy,
            use24hFormat: true,
            maximumYear: 2025,
          ),
        );
      });
}
