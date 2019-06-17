import 'package:flutter_web/material.dart';

class IterationField extends StatefulWidget {
  final VoidCallback onDelete;
  final TextEditingController drumTypeController;
  final TextEditingController startDurationController;
  IterationField({Key key, this.onDelete, this.drumTypeController, this.startDurationController}) : super(key: key);
  @override
  _IterationFieldState createState() => _IterationFieldState();
}

class _IterationFieldState extends State<IterationField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:16.0),
      child: Row(
        children: [
          Expanded(child: Padding(
            padding:  EdgeInsets.only(right: 16.0),
            child: TextField(
              controller: widget.drumTypeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                labelText: 'Enter drum type',
              ),
            ),
          ),),
          Expanded(child: Padding(
            padding:  EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: widget.startDurationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                labelText: 'Enter start duration',
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
