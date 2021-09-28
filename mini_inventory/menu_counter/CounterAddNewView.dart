import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:mini_inventory/mini_inventory/widget/RowSeparator.dart';
import 'package:mini_inventory/mini_inventory/widget/WidgetHelper.dart';
import 'package:provider/provider.dart';

import '../model/AppGlobal.dart';
import '../model/CounterModel.dart';

class CounterAddNewView extends StatefulWidget {

  CounterAddNewView({this.counterCatList, this.newCounterModel });

  List<CounterCatModel> counterCatList;
  CounterModel newCounterModel;

  TextEditingController titleController = new TextEditingController();
  CounterCatModel selectedCounterCat = null;

  bool get isFormInValid => titleController.text.isEmpty || selectedCounterCat == null;

  @override
  State<StatefulWidget> createState() {
    return _CounterAddNewState();
  }
}

class _CounterAddNewState extends State<CounterAddNewView> {


  @override
  void initState() {
    print("initState...");

    widget.titleController.addListener(() {
      print("TextEditingController...Listener...");
      setState(() {});
    });

    super.initState();
  }

  doPop() {
    AppGlobal.hideKeyboard(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {
      return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Counter',
                        style: Theme.of(context).textTheme.headline6),
                  ])),
          body: SafeArea(
              child: Container(
                  child: Column(children: [

                    Card( child:  CounterCatDropdownWidget(
                        selectedCounterCat: widget.selectedCounterCat,
                        counterCatList: widget.counterCatList,
                        onSelectCounterCatModel: (cat) {
                          widget.selectedCounterCat = cat;
                    }) ),

                    RowSeparator(),

                    Card( child: _buildTitleField(settingProvider)),

                    RowSeparator(),

                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [

                      _buildBackButton(settingProvider),

                      RowSeparator(),

                      _buildSaveButton(settingProvider, counterProvider),

                    ])

                  ]))));
    });
  }



  Widget _buildTitleField(SettingProvider settingProvider) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Text("Title",
              style: settingProvider.getAppThemeData().textTheme.headline6),
          TextField(
            controller: widget.titleController,
            textAlign: TextAlign.left,
            style: settingProvider.getAppThemeData().textTheme.headline6,
          )
        ]);
  }

  Widget _buildSaveButton(
      SettingProvider settingProvider, CounterProvider counterProvider) {
    return RaisedButton.icon(
        label: Text("Save", style: Theme.of(context).textTheme.button),
        icon: Icon(Icons.save),
        elevation: 2,
        onPressed: widget.isFormInValid
            ? null
            : () {

                  if (widget.selectedCounterCat == null) {
                    throw Exception("NO_CATEGORY_SELECTED");
                  }
                  else {
                     // counterProvider.getNewCounterModel(widget.selectedCounterCat.counterCatId);
                    widget.newCounterModel.counterCatId = widget.selectedCounterCat.counterCatId;
                    widget.newCounterModel.counterTitle = widget.titleController.text;
                    print("counterId==${widget.newCounterModel.counterId}");

                    try {
                      counterProvider.addCounterModel(widget.newCounterModel);

                      doPop();
                    }
                    catch(ex) {

                      print("addCounterModel...exception...${ex}");

                      WidgetHelper.showAlertDialog(context,
                            "Error",
                            ex.toString());
                    }

                  }

              });
  }

  Widget _buildBackButton(SettingProvider settingProvider) {
    return RaisedButton.icon(
        label: Text("Back", style: Theme.of(context).textTheme.button),
        icon: Icon(Icons.cancel),
        elevation: 2,
        onPressed: () {
          doPop();
        });
  }
}
