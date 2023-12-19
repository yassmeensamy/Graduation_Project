import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Models/user.dart';
import '../../../constants.dart' as constants;

typedef BirthdayCallback = void Function(String birthday);
typedef GenderCallback2 = void Function(String gender);

class DataForm extends StatefulWidget {
  final BirthdayCallback onBirthdaySelected;
  final GenderCallback2 onGenderSelected2;

  const DataForm(
      {super.key,
      required this.onBirthdaySelected,
      required this.onGenderSelected2});

  @override
  State<DataForm> createState() => _DataFormState();
}

String? gender;

class _DataFormState extends State<DataForm> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";
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
                widget.onBirthdaySelected(formattedDate);
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
        GenderSelection(onGenderSelected: (selectedGender) {
          widget.onGenderSelected2(selectedGender);
        })
      ],
    );
  }
}

typedef GenderCallback = void Function(String gender);

class GenderSelection extends StatefulWidget {
  final GenderCallback onGenderSelected;
  const GenderSelection({super.key, required this.onGenderSelected});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String value = '';

  Widget radio(String i, String txt, String img) {
    return GestureDetector(
      onTap: () {
        widget.onGenderSelected(i);
        if (value == i) {
          setState(() {
            value = '';
          });
        } else {
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);
          User currentUser = userProvider.user!;
          currentUser.gender = i;
          userProvider.setUser(currentUser);
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
