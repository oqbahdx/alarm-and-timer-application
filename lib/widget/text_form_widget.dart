import 'package:flutter/material.dart';

class TextFormBuild extends StatefulWidget {
  const TextFormBuild({Key? key, required this.eventController,})
      : super(key: key);
  final  TextEditingController? eventController;

  @override
  _TextFormBuildState createState() => _TextFormBuildState();
}

class _TextFormBuildState extends State<TextFormBuild> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: widget.eventController,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'ENTER THE EVENT',
          hintStyle: const TextStyle(
          color: Colors.black87,  fontSize: 24, fontWeight: FontWeight.bold),
          // labelText: 'label text',
          //   label: Center(child: Text('ENTER THE EVENT')),
          // label: const Center(
          //   child: Text(
          //     'ENTER THE EVENT',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),

          labelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
