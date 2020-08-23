import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unit_converter/model/models.dart';
import 'package:unit_converter/screen/home_screen.dart';

class ConverterScreen extends StatefulWidget {
  final String title;
  final Conversion conversion;

  const ConverterScreen({
    Key key,
    this.title,
    this.conversion,
  }) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  Unit _selectedFrom;
  Unit _selectedTo;
  TextEditingController _editingController;
  Brain _brain;
  String _result = "";
  NumberFormat _format = NumberFormat("###.#####", "en_US");

  Widget _createDropdown(bool from) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: Colors.grey.shade700,
          )),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Unit>(
            value: from ? _selectedFrom : _selectedTo,
            onChanged: (value) {
              setState(() {
                if (from) {
                  _selectedFrom = value;
                } else {
                  _selectedTo = value;
                }

                _convert();
              });
            },
            isExpanded: true,
            items: _brain.units.map((e) {
              return DropdownMenuItem<Unit>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _createTextField() {
    return TextField(
      controller: _editingController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Value",
        border: OutlineInputBorder(),
      ),
      onSubmitted: (value) {
        setState(() {
          _convert();
        });
      },
    );
  }

  _convert() {
    var text = _editingController.text;
    var ans = _brain.calculate(
        _selectedFrom, _selectedTo, text.isEmpty ? 0.0 : double.parse(text));

    _result = _format.format(ans);
  }

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _brain = Brain();
    switch (widget.conversion) {
      case Conversion.LENGTH:
        _brain.initUnits();
        break;
      case Conversion.VOLUME:
        _brain.initUnits();
        break;
      case Conversion.WEIGHT:
        _brain.initUnits();
        break;
      case Conversion.DISTANCE:
        _brain.initUnits();
        break;
    }

    _selectedFrom = _brain.units[0];
    _selectedTo = _brain.units[0];
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 24,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Card(
        elevation: 2,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _createDropdown(true),
              SizedBox(height: 16),
              _createTextField(),
              InkWell(
                onTap: () {
                  setState(() {
                    var tmp = _selectedFrom;
                    _selectedFrom = _selectedTo;
                    _selectedTo = tmp;
                    _convert();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.swap_vert,
                    size: 24,
                  ),
                ),
              ),
              _createDropdown(false),
              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  _result,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 1
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
