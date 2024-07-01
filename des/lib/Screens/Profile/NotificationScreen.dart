import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../constants.dart' as constants;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  DateTime _meditationTime = DateTime.now();
  DateTime _trackingTime = DateTime.now();
  String _selectedWeekday = 'None';

  void _selectTime(BuildContext context, bool isMeditation) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onChanged: (time) {
        setState(() {
          if (isMeditation) {
            _meditationTime = time;
          } else {
            _trackingTime = time;
          }
        });
      },
      onConfirm: (time) {
        setState(() {
          if (isMeditation) {
            _meditationTime = time;
          } else {
            _trackingTime = time;
          }
        });
      },
      currentTime: isMeditation ? _meditationTime : _trackingTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: constants.pageColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set your preferred notification times:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meditation Time',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_meditationTime.hour.toString().padLeft(2, '0')}:${_meditationTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, true),
                          child: Text('Select Time'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: constants.babyBlue80),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedWeekday,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedWeekday = newValue!;
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Tracking Time',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_trackingTime.hour.toString().padLeft(2, '0')}:${_trackingTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, false),
                          child: Text('Select Time'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: constants.babyBlue80),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: handleNotification,
                child: Text('Save Times'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: constants.babyBlue80),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleNotification() {
    print('Meditation Time: $_meditationTime on $_selectedWeekday');
    print('Daily Tracking Time: $_trackingTime');
  }
}
