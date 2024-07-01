import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class MeditationForm extends StatefulWidget {
  final Function(String, DateTime) onMeditationTimeSelected;
  String question;
  bool day;
  MeditationForm({required this.onMeditationTimeSelected, Key? key, required this.question, required this.day}) : super(key: key);

  @override
  _MeditationFormState createState() => _MeditationFormState();
}

class _MeditationFormState extends State<MeditationForm> {
  DateTime _selectedTime = DateTime.now();
  String _selectedWeekday = 'None';
  
  void _showTimePicker() {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onChanged: (time) {
        setState(() {
          _selectedTime = time;
        });
      },
      onConfirm: (time) {
        setState(() {
          _selectedTime = time;
          widget.onMeditationTimeSelected(_selectedWeekday, _selectedTime);
        });
      },
      currentTime: _selectedTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.question),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        widget.day ? DropdownButton<String>(
          value: _selectedWeekday,
          onChanged: (String? newValue) {
            setState(() {
              _selectedWeekday = newValue!;
              widget.onMeditationTimeSelected(_selectedWeekday, _selectedTime);
            });
          },
          items: <String>[
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
            'None'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ):const SizedBox(height: 0) ,
        const SizedBox(height: 20),
        Text(
          '${_selectedTime.hour}:${_selectedTime.minute}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _showTimePicker,
          child: Text('Select Time'),
        ),
      ],
    );
  }
}
