import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/input_field.dart';

class EditUserInfo extends StatelessWidget {
  const EditUserInfo({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.bioController,
    required this.phoneController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController bioController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            InputField(
              hint: "Name",
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              validating: (val) {
                if (val!.isEmpty) {
                  return "Name can't be blank!";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.person),
              obsecure: false,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.01),
            InputField(
              hint: "Bio",
              controller: bioController,
              textCapitalization: TextCapitalization.none,
              validating: (val) {
                if (val!.isEmpty) {
                  return "Bio can't be blank!";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              prefixIcon: const Icon(Icons.info),
              obsecure: false,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.01),
            InputField(
              hint: "Phone",
              controller: phoneController,
              textCapitalization: TextCapitalization.none,
              validating: (val) {
                if (val!.isEmpty) {
                  return "Phone can't be blank!";
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
              obsecure: false,
            ),
          ],
        ),
      ),
    );
  }
}
