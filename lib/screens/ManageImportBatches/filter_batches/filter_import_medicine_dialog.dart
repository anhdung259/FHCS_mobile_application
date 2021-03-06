import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/data/model/filter/filter_obj.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DatePicker/date_picker.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class FilterImportMedicine extends StatefulWidget {
  @override
  _FilterImportMedicineState createState() => _FilterImportMedicineState();
}

class _FilterImportMedicineState extends State<FilterImportMedicine> {
  DateTime selectedDate;
  final ImportMedicineController imc = Get.find();
  @override
  void initState() {
    super.initState();
    if (imc.monthSelect.isNotEmpty) {
      print(imc.monthSelect.value);
      var parts = imc.monthSelect.value.split('/');
      selectedDate =
          DateTime(int.parse(parts[1].trim()), int.parse(parts[0].trim()));
      print(selectedDate);
    } else {
      selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.01,
        horizontal: SizeConfig.screenWidth * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "B??? l???c t??m ki???m",
                style: AppTheme.titleList,
              ),
              IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: grey,
                  )),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          BoxInput(
            required: false,
            title: "????n gi??:",
            child: Column(
              children: [
                Text(
                  GeneralHelper.formatCurrencyText(
                          imc.minFilterTotalPrice.round().toString()) +
                      " - " +
                      GeneralHelper.formatCurrencyText(
                          imc.maxFilterTotalPrice.round().toString()),
                  style: AppTheme.normalText,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    overlayColor: KPrimaryColor,
                    activeTickMarkColor: KPrimaryColor,
                    activeTrackColor: KPrimaryColor,
                    inactiveTrackColor: KColorBackground,
                    trackHeight: 8,
                    thumbColor: white,
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 30.0,
                    ),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 15,
                      elevation: 2,
                    ),
                  ),
                  child: frs.RangeSlider(
                    min: imc.minTotalPrice,
                    max: imc.maxTotalPrice,
                    lowerValue: imc.minFilterTotalPrice,
                    upperValue: imc.maxFilterTotalPrice,
                    allowThumbOverlap: true,
                    onChanged: (double newLowerValue, double newUpperValue) {
                      setState(() {
                        imc.minFilterTotalPrice = newLowerValue;
                        imc.maxFilterTotalPrice = newUpperValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () => showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: selectedDate ?? null,
                    locale: Locale("vi"),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        imc.selectedDate = date;
                        imc.monthSelect.value =
                            date.month.toString() + "/" + date.year.toString();
                      });
                    }
                  }),
              child: Container(
                  color: white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxInput(
                          required: false,
                          title: "K??? nh???p(th??ng/n??m):",
                          child: BackGroundTextField(
                            sizeWidth: getProportionateScreenWidth(135),
                            sizeheight: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    imc.monthSelect.isNotEmpty
                                        ? Text(
                                            "${selectedDate.month}/${selectedDate.year}",
                                            style: AppTheme.normalText,
                                          )
                                        : Text(
                                            "Th??ng/n??m",
                                            style: AppTheme.blurred,
                                          ),
                                    Icon(
                                      Icons.event,
                                      color: KPrimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        BoxInput(
                          title: "S??? l?????ng:",
                          required: false,
                          child: RoundedInputField(
                            controller: imc.textQuantityFilterController,
                            isNumber: true,
                            sizeWidth: getProportionateScreenWidth(135),
                            hintText: "Nh???p s??? l?????ng",
                            textInputFormat: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]+')),
                            ],
                          ),
                        ),
                      ]))),
          BoxInput(
            required: false,
            title: "Ng??y nh???p:",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: imc.fromCreateDateFilter,
                  onChanged: (value) {
                    imc.fromCreateDateFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: imc.toCreatedDateFilter,
                  onChanged: (value) {
                    imc.toCreatedDateFilter = value + " 23:59:59";
                  },
                ),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: "Ng??y h???t h???n:",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: imc.fromDateExpirationFilter,
                  onChanged: (value) {
                    imc.fromDateExpirationFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: imc.toDateExpirationFilter,
                  onChanged: (value) {
                    imc.toDateExpirationFilter = value + " 23:59:59";
                  },
                ),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: "Tr???ng th??i:",
            child: Column(
              children: [
                Obx(() => Dropdown(
                      title: "Danh s??ch tr???ng th??i",
                      listItem: [
                        FilterObject(display: "Ch??a ???????c s??? d???ng", id: "1"),
                        FilterObject(display: "??ang ???????c s??? d???ng", id: "2"),
                        FilterObject(display: "???? h???t h???n", id: "3"),
                        FilterObject(display: "???? ???????c s??? d???ng h???t", id: "4"),
                        FilterObject(display: "G???n h???t h???n", id: "5"),
                      ],
                      itemSelected: imc.importMedicineStatusFliter.value,
                      obj: FilterObject,
                      idDropDown: imc.importMedicineStatusFliter,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                text: RESETFILTER,
                textColor: KPrimaryColor,
                color: white,
                press: () {
                  // mc.clearId();
                  imc.resetTextFilter();
                  imc.refreshList();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "T??m ki???m",
                press: () {
                  imc.fetchImportMedicine();
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
