import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:fhcs_mobile_application/widgets/Circle/circle_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_medicine_insert_record_local.dart';

class InsertBatchesMedicineBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return WillPopScope(
      onWillPop: () => bmc.backScreen(),
      child: Obx(
        () => BackGroundComponent(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.01,
              horizontal: SizeConfig.screenWidth * 0.04,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DisplayInfo(
                      title: PERIODIC_INVENTORY,
                      info: bmc.currentMonth.toString() +
                          "/" +
                          bmc.currentYear.toString(),
                    ),
                    CircleButton(
                      backgroundColor: KPrimaryColor,
                      icon: Icons.add,
                      iconColor: white,
                      iconSize: getProportionateScreenHeight(30),
                      onPressed: () {
                        bmc.resetText();
                        Get.toNamed("/insertBatchesMedicineRecord");
                        // mc.navigatorInsertMedicine();
                        // GeneralHelper.navigateToScreen(InsertMedicine(), false);
                      },
                    ),
                  ],
                ),
                Text(
                  "Danh s??ch d?????c ph???m nh???p kho",
                  style: AppTheme.titleList,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                ListMedicineInsertRecord(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: KPrimaryColor,
                ),
                // Spacer(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      DisplayDetails(
                        title: QUANTITY_CURRENT,
                        info: "${bmc.numberMedicineInBatch.value} d?????c ph???m",
                      ),
                      DisplayDetails(
                        title: TOTAL_PRICE,
                        info: GeneralHelper.formatCurrencyText(
                            bmc.totalPrice.value.toString()),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RoundedButton(
                    sizeWidth: Get.width,
                    text: bmc.showUpdate
                        ? "C???p nh???t l?? d?????c ph???m"
                        : "Nh???p v??o kho",
                    press: () {
                      bmc.showUpdate
                          ? bmc.updateNewImportBatch()
                          : bmc.insertNewImportBatch();
                      // c.insertNewMedicine();
                      // mc.validateInsertMedicine();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // FloatingActionButton(onPressed: onPressed)
    );
  }
}
