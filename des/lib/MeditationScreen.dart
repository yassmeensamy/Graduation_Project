
import 'package:des/NotificationServices.dart';
import 'package:des/Schedule.dart';
import 'package:flutter/material.dart';

class MeditationReminder extends StatefulWidget {
  @override
  _MeditationReminderState createState() => _MeditationReminderState();
}

class _MeditationReminderState extends State<MeditationReminder> {
  List<bool> _selectedDays = List.generate(7, (index) => false);
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // واجهة اختيار الأيام
        ToggleButtons(
          children: [
            Text('Mon'),
            Text('Tue'),
            Text('Wed'),
            Text('Thu'),
            Text('Fri'),
            Text('Sat'),
            Text('Sun'),
          ],
          isSelected: _selectedDays,
          onPressed: (index) {
            setState(() {
              _selectedDays[index] = !_selectedDays[index];
            });
          },
        ),
        // واجهة اختيار الوقت
        ElevatedButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: _selectedTime,
            );
            if (pickedTime != null) {
              setState(() {
                _selectedTime = pickedTime;
              });
            }
          },
          child: Text('Select Time'),
        ),
        ElevatedButton(
          onPressed: () {
            scheduleMeditationReminders();
          
             //NotificationServices.cancelAllNotifications();
          },
          child: Text('Schedule Reminder'),
        ),
      ],
    );
  }

  void scheduleMeditationReminders() {
    DateTime now = DateTime.now();
    for (int i = 0; i < _selectedDays.length; i++) {
      if (_selectedDays[i]) {
        DateTime scheduledTime = DateTime(
          now.year,
          now.month,
          now.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ).add(Duration(days: i - now.weekday + 1));
        if (scheduledTime.isBefore(now)) 
        {
          scheduledTime = scheduledTime.add(Duration(days: 7));
        }
        NotificationServices.scheduleNotification(
          Schedule(
            details: "Meditation Reminder",
            time: scheduledTime,
          ) 
        );
      }
      
    }
  }
}


