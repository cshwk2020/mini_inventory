import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/ColumnSeparator.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:mini_inventory/mini_inventory/widget/RowSeparator.dart';
import 'package:mini_inventory/mini_inventory/widget/WidgetHelper.dart';

import '../model/AppGlobal.dart';
import '../model/CounterModel.dart';

class CounterCatAddNewView extends StatefulWidget {

  CounterCatAddNewView({this.newCounterCatModel });

  CounterCatModel newCounterCatModel;

  TextEditingController titleController = new TextEditingController();

  bool get isFormInValid => titleController.text.isEmpty;

  @override
  State<StatefulWidget> createState() {
    return _CounterCatAddNewState();
  }
}

class _CounterCatAddNewState extends State<CounterCatAddNewView> {


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


            widget.newCounterCatModel.counterCatTitle = widget.titleController.text;
            print("counterCatId==${widget.newCounterCatModel.counterCatId}");

            try {
              counterProvider.addCounterCatModel(widget.newCounterCatModel);

              doPop();
            }
            catch(ex) {

              print("addCatCounterModel...exception...${ex}");

              WidgetHelper.showAlertDialog(context,
                  "Error",
                  ex.toString());
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
