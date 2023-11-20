import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onGenderChanged;

  const GenderSelector({Key? key, required this.onGenderChanged})
      : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String _selectedGender = 'M';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1, // 공간 분배 비율
            child: ListTile(
              title: const Text(
                '남성',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              leading: Radio<String>(
                  value: 'M',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _selectedGender = value;
                        widget.onGenderChanged(value);
                      });
                    }
                  },
                  fillColor: MaterialStateProperty.all(Colors.white)),
            ),
          ),
          Flexible(
            flex: 1, // 공간 분배 비율
            child: ListTile(
              title: const Text(
                '여성',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              leading: Radio<String>(
                  value: 'W',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _selectedGender = value;
                        widget.onGenderChanged(value);
                      });
                    }
                  },
                  fillColor: MaterialStateProperty.all(Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
