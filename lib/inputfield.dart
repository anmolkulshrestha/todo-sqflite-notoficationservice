import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField({Key? key,required this.widget,required this.title,required this.hint,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text(title,style:  GoogleFonts.lato(
    textStyle: TextStyle(
          fontSize: 17,
        fontWeight: FontWeight.w400

    )
),),

            Container(
              height: 52,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border:Border.all(color: Colors.grey,
                width: 1.0),
                borderRadius: BorderRadius.circular(12.0)
              ),

              child: Row(
                children: [
                  Expanded(child: TextFormField(
                readOnly: widget==null?false:true
                    ,autofocus: false,
                  cursorColor: Colors.grey[700],
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0
                      )
                    )
                  ),)),
                  widget==null?Container():Container(child: widget,)
                ],
              ),

            )

          ],
        ),
      ),
    );
  }

}
