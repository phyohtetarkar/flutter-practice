import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_flutter/repo/developer_repo.dart';

import 'main.dart';
import 'model/developer.dart';

class DeveloperEditPage extends StatefulWidget {
  final Developer dev;
  final DeveloperRepo repo;

  const DeveloperEditPage({
    Key key,
    this.dev,
    this.repo,
  }) : super(key: key);

  @override
  _DeveloperEditPageState createState() => _DeveloperEditPageState();
}

class _DeveloperEditPageState extends State<DeveloperEditPage> {
  TextEditingController _nameController;
  TextEditingController _ageController;
  String _heading;

  Widget _buildDropdown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          items: languages.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          value: _heading,
          isExpanded: true,
          onChanged: (e) {
            setState(() {
              _heading = e;
              print(e);
            });
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return InkWell(
      onTap: () {
        final controller = FixedExtentScrollController(
          initialItem: languages.indexOf(_heading),
        );
        final picker = Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
          ),
          child: CupertinoPicker.builder(
            scrollController: controller,
            itemExtent: 46,
            childCount: languages.length,
            onSelectedItemChanged: (index) {
              setState(() {
                _heading = languages[index];
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  languages[index],
                ),
              );
            },
          ),
        );

        showModalBottomSheet(
          context: context,
          builder: (context) => picker,
          backgroundColor: Colors.transparent,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          _heading,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget _buildChoiceChip() {
    final pos = languages.indexOf(_heading);
    final controller = ScrollController(initialScrollOffset: pos * 46.0);
    return Container(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final selected = languages[index] == _heading;
          return ChoiceChip(
            label: Text(
              languages[index],
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            selected: selected,
            onSelected: (selected) {
              setState(() {
                _heading = languages[index];
              });
            },
            avatar: selected ? Icon(Icons.check_circle, color: Colors.white) : null,
            selectedColor: Theme.of(context).primaryColor,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.dev.name);
    _ageController = TextEditingController(text: "${widget.dev.age ?? ""}");
    _heading = widget.dev.heading ?? languages[0];
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final appBar = AppBar(
      title: Text(widget.dev.id == null ? "Create" : "Update"),
      actions: [
        FlatButton(
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          shape: CircleBorder(),
          onPressed: () {
            if (widget.dev.id == null) {
              final d = Developer(
                name: _nameController.text,
                heading: _heading,
                age: int.parse(_ageController.text),
              );
              widget.repo.insert(d).whenComplete(() {
                Navigator.of(context).pop(true);
              });
            } else {
              widget.repo
                  .update(
                Developer(
                  id: widget.dev.id,
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
                  heading: _heading,
                ),
              )
                  .whenComplete(() {
                Navigator.of(context).pop(true);
              });
            }
          },
        ),
      ],
    );

    final widgets = [
      TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: "Name",
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 16),
      TextField(
        controller: _ageController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Age",
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 16),
      _buildChoiceChip(),
    ];

    if (widget.dev.id != null) {
      widgets.add(SizedBox(height: 16));
      widgets.add(RaisedButton(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        onPressed: () {
          widget.repo.delete(widget.dev.id).whenComplete(() {
            Navigator.of(context).pop(true);
          });
        },
        color: Color(0xffd50002),
        child: Text(
          "DELETE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
          ),
        ),
      ),
    );
  }
}
