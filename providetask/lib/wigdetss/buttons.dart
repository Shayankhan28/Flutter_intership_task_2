import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buttonss extends StatelessWidget {
  const buttonss({
    super.key,
    required this.texttile,
    required this.textcolor,
    required this.fontwight,
    required this.buttoncolor,
    required this.outlinecolor,
    required this.callback,
    this.loading = false,
  });

  final String texttile;
  final FontWeight? fontwight;
  final Color textcolor;
  final bool loading;
  final Color buttoncolor;
  final Color? outlinecolor;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Container(
        height: 55,
        width: 310,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: outlinecolor ?? Colors.transparent,
            width: 1,
          ),
        ),
        child: loading
            ? const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : TextButton(
                onPressed: callback,

                child: Text(
                  texttile,
                  style: GoogleFonts.urbanist(
                    color: textcolor,
                    fontSize: 15,
                    fontWeight: fontwight,
                  ),
                ),
              ),
      ),
    );
  }
}

class textfileddss extends StatefulWidget {
  const textfileddss({
    super.key,
    required this.text_of_textfield,
    required this.type,
    this.width,
    this.iconss,
    required this.vali,
    required this.controller,
  });

  final String text_of_textfield;
  final TextInputType type;
  final double? width;
  final Icon? iconss;
  final String? Function(String?)? vali;
  final TextEditingController? controller;

  @override
  State<textfileddss> createState() => _textfileddssState();
}

class _textfileddssState extends State<textfileddss> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 315,
        child: TextFormField(
          controller: widget.controller!,
          keyboardType: widget.type,
          decoration: InputDecoration(
            suffixIcon: widget.iconss,
            hintText: widget.text_of_textfield,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFDFe1E2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFDFe1E2)),
            ),
            fillColor: Color(0xffF7F8F9),
            filled: true,
          ),
          validator: widget.vali,
        ),
      ),
    );
  }
}

// Passowrd
class Password extends StatefulWidget {
  const Password({super.key, required this.controller, required this.vali});

  final TextEditingController controller;
  final String? Function(String?)? vali;
  @override
  State<Password> createState() => _ppasswordState();
}

class _ppasswordState extends State<Password> {
  bool hidetext = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controller,
          obscureText: hidetext,
          decoration: InputDecoration(
            hintText: "Password",

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(255, 223, 225, 226)),
            ),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color.fromARGB(255, 223, 225, 226)),
            ),
            fillColor: Color(0xffF7F8F9),
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(hidetext ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  hidetext = !hidetext;
                });
              },
            ),
          ),
          validator: widget.vali,
        ),
      ),
    );
  }
}
