import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart' as constants;


class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

String? gender;

class _DataFormState extends State<DataForm> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('When is Your Birthday'),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 60,
          child: TextFormField(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: constants.babyBlue,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                          onBackground: constants.lilac,
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate:
                      DateTime.now().subtract(const Duration(days: 18 * 365)));
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateinput.text = formattedDate;
                });
              }
            },
            controller: dateinput,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.lilac70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'MM-DD-YYYY',
              suffixIcon: Icon(Icons.calendar_month),
              hintStyle: TextStyle(color: constants.txtGrey),
              suffixIconColor: constants.txtGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('What is your gender'),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        GenderSelection()
      ],
    );
  }
}



class GenderSelection extends StatefulWidget {
  GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String value = '';

  Widget radio(String i, String txt, String img) {
    return GestureDetector(
      onTap: () {
        if (value == i) {
          setState(() {
            value = '';
          });
        } else {
          setState(() {
            value = i;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (value == i) ? constants.lightGrey : Colors.transparent,
        ),
        child: Column(
          children: [
            Image.asset(
              img,
              width: 125,
            ),
            Text(txt)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        radio('M', 'Male', 'assets/images/male.png'),
        const SizedBox(
          width: 32,
        ),
        radio('F', 'Female', 'assets/images/female.png')
      ],
    );
  }
}
