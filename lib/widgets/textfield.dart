import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  const FormTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      
      this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
      this.validator,
       this.errorMessage='field should not be empty', this.obscureText = false, this.textInputType = TextInputType.text, this.onChanged,})
      : super(key: key);
  final TextEditingController controller;
  final String labelText, hintText;
  final bool Function(String)? validator;
  final  Function(String?)? onChanged;
  final bool obscureText;
  final String errorMessage;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextInputType textInputType;
  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: TextFormField(
        onChanged: (value){
         widget.onChanged != null? widget.onChanged!(value):(){};
        },
        validator: (value) {
          if (widget.validator!(value!)) return widget.errorMessage;

          return null;
        },
        
        controller: widget.controller,
        obscuringCharacter: '*',
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          prefix: widget.prefixIcon,
          suffix: Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: widget.suffixIcon,
          ),
          
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Theme.of(context).cardTheme.color,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
        ),
        style: Theme.of(context).textTheme.bodyText1,
        // maxLines: null,
      ),
    );
  }
}
