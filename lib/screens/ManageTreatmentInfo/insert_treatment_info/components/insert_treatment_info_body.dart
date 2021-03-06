import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/patient_info.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:line_icons/line_icons.dart';

import 'confirm_treatment.dart';
import 'make_prescription.dart';

class InsertTreatmentInfoBody extends StatefulWidget {
  @override
  _InsertTreatmentInfoBody createState() => _InsertTreatmentInfoBody();
}

class _InsertTreatmentInfoBody extends State<InsertTreatmentInfoBody> {
  final TreatmentInfoController tic = Get.find();
  var activeStep = 0;
  int upperBound = 2;
  @override
  Widget build(BuildContext context) {
    Widget screen() {
      switch (activeStep) {
        case 0:
          return PatientInfo();
        case 1:
          return MakePrescription();
        case 2:
          return ConfirmTreatment();
        default:
          return PatientInfo();
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            IconStepper(
              steppingEnabled: false,
              activeStepColor: KPrimaryColor,
              icons: [
                Icon(
                  LineIcons.userEdit,
                  color: white,
                ),
                Icon(
                  LineIcons.alternatePrescriptionBottle,
                  color: white,
                ),
                Icon(
                  LineIcons.signature,
                  color: white,
                ),
              ],
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            header(),
            Expanded(
              child: screen(),
            ),
            Obx(() => Padding(
                  // this is new
                  padding: EdgeInsets.only(
                      bottom: tic.pushBottom.isFalse
                          ? Get.context.mediaQueryViewInsets.bottom
                          : Get.context.mediaQueryViewInsets.bottom +
                              getProportionateScreenHeight(150)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activeStep == 0 ? Container() : previousButton(),
                activeStep == 2 ? createTreatmentInfo() : nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Th??ng tin b???nh nh??n';
      case 1:
        return 'T???o ????n thu???c';
      case 2:
        return 'X??c nh???n ????n c???p ph??t';
      default:
        return 'Th??ng tin b???nh nh??n';
    }
  }

  Widget nextButton() {
    return RoundedButton(
      sizeHeight: getProportionateScreenHeight(40),
      text: "Ti???p t???c",
      press: () {
        FocusScope.of(context).unfocus();
        if (activeStep < upperBound) {
          if (activeStep == 0 && tic.validatePatientInfo()) {
            setState(() {
              activeStep++;
            });
          } else if (activeStep == 1 && tic.validatePerscription()) {
            setState(() {
              activeStep++;
            });
          }
        }
      },
    );
  }

  Widget previousButton() {
    return RoundedButton(
      sizeHeight: getProportionateScreenHeight(38),
      text: "Tr??? l???i",
      press: () {
        FocusScope.of(context).unfocus();
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }

  Widget createTreatmentInfo() {
    return tic.showEdit == false
        ? RoundedButton(
            sizeHeight: getProportionateScreenHeight(38),
            text: "T???o ????n",
            press: () {
              FocusScope.of(context).unfocus();
              tic.validateInsert();
            },
          )
        : RoundedButton(
            sizeHeight: getProportionateScreenHeight(38),
            text: "C???p nh???t",
            press: () {
              FocusScope.of(context).unfocus();
              tic.validateUpdate();
            });
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: KPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
