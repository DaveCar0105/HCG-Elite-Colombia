import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

// ignore: must_be_immutable
class ListaBusqueda extends StatefulWidget {
  final ValueChanged<String> parentAction;
  List<AutoComplete> lista;
  String hintText;
  String hintSearchText;
  Icon icon;
  double width;
  TextStyle style;
  String valorDefecto;
  ListaBusqueda(
      {this.lista,
      this.hintText,
      this.hintSearchText,
      this.icon,
      this.parentAction,
      this.width,
      this.style,
      this.valorDefecto,
      Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaBusquedaState();
  }
}

class ListaBusquedaState extends State<ListaBusqueda> {
  bool mostrar = true;
  List<DropdownMenuItem> items = [];
  String selectedValue;
  List<AutoComplete> lista = [];

  @override
  void initState() {
    setState(() {
      lista = widget.lista;
      selectedValue = widget.valorDefecto;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: widget.icon,
        ),
        Container(
          width: widget.width,
          child: SearchableDropdown(
            items: lista.map((e) {
              return DropdownMenuItem(
                child: new Text(
                  e.nombre,
                  style: widget.style,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  softWrap: true,
                ),
                value: e.nombre,
              );
            }).toList(),
            value: widget.valorDefecto,
            isExpanded: true,
            hint: new Text(
              widget.hintText,
              style: widget.style,
            ),
            searchHint: new Text(
              widget.hintSearchText,
              style: new TextStyle(fontSize: 14),
            ),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                widget.parentAction(value);
              });
            },
          ),
        ),
      ],
    );
  }

  limpiar() {
    setState(() {
      selectedValue = items[0].value;
    });
  }
}
