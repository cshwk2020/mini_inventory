import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/ColumnSeparator.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomSwitch.dart';
import 'package:mini_inventory/mini_inventory/widget/RowSeparator.dart';

import '../model/AppGlobal.dart';
import '../model/CounterCatModel.dart';
import '../model/CounterModel.dart';

class CounterCatEditRow extends StatefulWidget {



  CounterCatEditRow({ CounterCatModel counterCatModel }) {
    print("CounterCatEditRow constructor...${counterCatModel.counterCatTitle}");
    this.counterCatModel = counterCatModel;


    initFormValue();
  }

  //

  CounterCatModel counterCatModel;

  // dirty fields
  TextEditingController titleController = new TextEditingController();
  bool counterCatIsActive = false;

  void saveForm(BuildContext context, CounterProvider counterProvider) {
    counterCatModel.counterCatTitle = titleController.text;
    counterCatModel.counterCatIsActive = counterCatIsActive;

    //CounterProvider counterProvider = Provider.of<CounterProvider>(context);
    counterProvider.setCounterCatModel(counterCatModel: counterCatModel, isForceRefresh: false);
  }

  bool get isFormClean {

    print("isFormClean...1...${titleController.text == counterCatModel.counterCatTitle}");

    print( "isFormClean...3...${counterCatIsActive == counterCatModel.counterCatIsActive}");
    return (titleController.text == counterCatModel.counterCatTitle) &&
        (counterCatIsActive == counterCatModel.counterCatIsActive);
  }

  bool get isFormDirty => !isFormClean;

  bool get isFormInValid {
    return titleController.text.isEmpty;
  }

  initFormValue() {

    print("initFormValue...");

    //
    titleController.text = counterCatModel.counterCatTitle;
    titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleController.text.length));

    //
    counterCatIsActive = counterCatModel.counterCatIsActive;
  }

  @override
  State<StatefulWidget> createState() {
    print("createState...");

    return _CounterCatEditState();
  }
}

class _CounterCatEditState extends State<CounterCatEditRow> {
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
              widget.saveForm(context, counterProvider);
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


                        ]));
              },
            ),
          );
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


  Widget _buildEditIsActiveField(
      SettingProvider settingProvider, CounterProvider counterProvider) {
    return Switch(
      value: widget.counterCatIsActive,
      onChanged: (bool val) {
        print("Switch onChanged");
        setState(() {
          widget.counterCatIsActive = val;

          //
          widget.saveForm(context, counterProvider);
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
              widget.saveForm(context, counterProvider);
              counterProvider.setCounterCatModel(counterCatModel: widget.counterCatModel, isForceRefresh: false);
            });

            AppGlobal.hideKeyboard(context);
          }),
    ]);
  }
}
