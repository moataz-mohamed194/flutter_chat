import 'package:flutter/material.dart';

class textFileLogin extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  final TextInputType inputType;
  final Icon textIcon;
  final String errorText;
  final Color cursorColor;
  final Color textStyleColor;
  final Color borderSideColor;
  final bool obscure;
  final String oldData;
  const textFileLogin(
      {this.textStream,
      this.textChange,
      this.textStyleColor,
      this.hintText,
      this.borderSideColor,
      this.errorText,
      this.inputType,
      this.cursorColor,
      this.textIcon,
      this.obscure = false,
      this.oldData});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width / 1.25,
      child: StreamBuilder(
          stream: textStream,
          builder: (context, snapshot) {
            return TextFormField(
                style: TextStyle(color: textStyleColor),
                cursorColor: cursorColor,
                autofocus: false,
                keyboardType: inputType,
                obscureText: obscure,
                onChanged: textChange,
                decoration: InputDecoration(
                  prefixIcon: textIcon,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(40.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: borderSideColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: borderSideColor, width: 2),
                  ),
                  hintText: "   $hintText",
                  helperStyle: TextStyle(
                      color: textStyleColor, fontWeight: FontWeight.bold),
                  errorText: errorText,
                ),
                initialValue: oldData);
          }),
    );
  }
}
