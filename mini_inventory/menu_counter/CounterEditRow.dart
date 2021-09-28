import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:mini_inventory/mini_inventory/widget/RectButton.dart';
import 'package:provider/provider.dart';

import '../model/AppGlobal.dart';
import '../model/CounterCatModel.dart';
import '../model/CounterModel.dart';

class CounterEditRow extends StatefulWidget {



  CounterEditRow({
    this.counterModel,
    this.counterCatList,
    this.onInputDigitModeEvent,}) {
    print("CounterEditRow constructor...onInputDigitModeClicked==${this.onInputDigitModeEvent}");

    initFormValue();
  }

  void Function(CounterModel) onInputDigitModeEvent;

  //
  List<CounterCatModel> counterCatList;
  CounterModel counterModel;
  CounterCatModel getSelectedCounterCat() {
    return counterCatList.where((cat) => cat.counterCatId==counterModel.counterCatId).first;
  }

  // dirty fields
  TextEditingController titleController = new TextEditingController();
  TextEditingController valueController = new TextEditingController();
  bool counterIsActive = false;


  void saveForm_counterTitle(BuildContext context, CounterProvider counterProvider) {
    counterModel.counterTitle = titleController.text;
    counterProvider.saveCounterInfoWithoutValueChanged(counterModel);
  }

  void saveForm_counterValue(BuildContext context, CounterProvider counterProvider) {
    counterModel.counterValue = int.tryParse(valueController.text);
    counterProvider.adjustCounterValue(counterModel: counterModel, isForceRefresh: false);
  }

  void saveForm_isActive(BuildContext context, CounterProvider counterProvider) {
    counterModel.counterIsActive = counterIsActive;
    counterProvider.saveCounterInfoWithoutValueChanged(counterModel);
  }

  void saveForm_counterCat(BuildContext context, CounterProvider counterProvider) {
    counterModel.counterCatId = counterModel.counterCatId;
    counterProvider.saveCounterInfoWithoutValueChanged(counterModel);
  }


  bool get isFormClean {
    print(
        "isFormClean...1...${titleController.text == counterModel.counterTitle}");
    print(
        "isFormClean...2...${int.tryParse(valueController.text) == counterModel.counterValue}");
    print(
        "isFormClean...3...${counterIsActive == counterModel.counterIsActive}");
    return (titleController.text == counterModel.counterTitle) &&
        (int.tryParse(valueController.text) == counterModel.counterValue) &&
        (counterIsActive == counterModel.counterIsActive);
  }

  bool get isFormDirty => !isFormClean;

  bool get isFormInValid {
    return titleController.text.isEmpty || valueController.text.isEmpty;
  }

  initFormValue() {
    print("initFormValue...");
    titleController.text = counterModel.counterTitle;
    titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleController.text.length));

    valueController.text = '${counterModel.counterValue}';
    valueController.selection = TextSelection.fromPosition(
        TextPosition(offset: valueController.text.length));

    counterIsActive = counterModel.counterIsActive;
  }

  @override
  State<StatefulWidget> createState() {
    print("createState...");

    return _CounterEditRowState();
  }
}

class _CounterEditRowState extends State<CounterEditRow> {
  @override
  void initState() {
    print("initState...");

    super.initState();
  }

  doPop() {
    AppGlobal.hideKeyboard(context);
    Navigator.pop(context);
  }

  //  return buildTitleRow(settingProvider);
  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {
      //
      widget.titleController.addListener(() {
        print("TextEditingController...Listener...");
        setState(() {
          widget.saveForm_counterTitle(context, counterProvider);
        });
      });

      widget.valueController.addListener(() {
        print("TextEditingController...Listener...");
        setState(() {
          widget.saveForm_counterValue(context, counterProvider);


        });
      });

      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.isFormClean
                    ? Colors.transparent
                    : Colors.redAccent)),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
                padding: EdgeInsets.all(6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Text("dirty==${widget.isFormDirty}"),
                      //Text("isFormInValid==${widget.isFormInValid}"),
                      //Text("isActive==${widget.isActive} vs ${widget.counterModel.isActive}"),
                      //Text("counterCatId==${widget.counterModel.counterCatId}"),
                      //Text("counterId==${widget.counterModel.counterId}"),

                      _buildEditFirstRowView(
                          context, settingProvider, counterProvider),

                      _buildEditSecondRowView(context, settingProvider, counterProvider),
                    ]));
          },
        ),
      );
    });
  }

  Widget _buildEditCatDropDownView(BuildContext context,
      SettingProvider settingProvider, CounterProvider counterProvider) {

    return CounterCatDropdownWidget(
        selectedCounterCat: widget.getSelectedCounterCat(),
        counterCatList: widget.counterCatList,
        onSelectCounterCatModel: (cat) {
          setState( () {
            widget.counterModel.counterCatId = cat.counterCatId;
            widget.saveForm_counterCat(context, counterProvider);
          });

        });

  }

  Widget _buildEditFirstRowView(BuildContext context,
      SettingProvider settingProvider, CounterProvider counterProvider) {

    double width = MediaQuery.of(context).size.width;

    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            width: width-100-50,
            child: _buildEditTitleField(settingProvider, counterProvider),
          ),
              Container(
                  width: 100,
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("ON",
                            style: settingProvider.getAppThemeData().textTheme.headline6),
                        _buildEditIsActiveField(settingProvider, counterProvider),
                      ])),
        ]));
  }


  Widget _buildEditSecondRowView(BuildContext context, settingProvider, counterProvider) {

    double width = MediaQuery.of(context).size.width;

    return Container(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



          Container(
            width: width-100-50,
            child: _buildEditCatDropDownView(context, settingProvider, counterProvider),
          ),

          Container(
              width: 100,
              child: _buildEditValueField(settingProvider, counterProvider)),


          ]));
  }

  Widget _buildEditTitleField(
      SettingProvider settingProvider, CounterProvider counterProvider) {
    return TextField(
      controller: widget.titleController,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textAlign: TextAlign.start,
      style: settingProvider.getAppThemeData().textTheme.headline6,
    );
  }

  Widget _buildEditValueField(
      SettingProvider settingProvider, CounterProvider counterProvider) {

    return Container(

      child: RectButton(
          buttonText: '${widget.counterModel.counterValue}',
          buttonWidth: 30,
          textStyle: settingProvider.getAppThemeData().textTheme.button,
          backgroundColor: settingProvider.getAppThemeData().backgroundColor,
          onClicked: () {

            print("clicked...${widget.onInputDigitModeEvent}...${widget.counterModel}");
            widget.onInputDigitModeEvent(widget.counterModel);

          }),

    );


  }

  Widget _buildEditIsActiveField(
      SettingProvider settingProvider, CounterProvider counterProvider) {
    return Switch(
      value: widget.counterIsActive,
      onChanged: (bool val) {
        print("Switch onChanged");
        setState(() {
          widget.counterIsActive = val;

          //
          widget.saveForm_isActive(context, counterProvider);
        });
      },
    );
  }


  Widget buildSaveRow(BuildContext context, SettingProvider settingProvider,
      CounterProvider counterProvider) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      RaisedButton.icon(
          label: Text("Save", style: Theme.of(context).textTheme.button),
          icon: Icon(Icons.save),
          elevation: 2,
          onPressed: widget.isFormInValid || widget.isFormClean
              ? null
              : () {
                  setState(() {
                    //widget.saveForm(context, counterProvider);
                    //counterProvider.setCounterModel(counterModel: widget.counterModel, isForceRefresh: false);
                  });

                  AppGlobal.hideKeyboard(context);
                }),
    ]);
  }


}
