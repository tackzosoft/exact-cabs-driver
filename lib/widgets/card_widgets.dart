import 'package:flutter/material.dart';
import 'package:exact_cabs_driver/utils/colors.dart';


class SelectableCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final bool isSelected;
  SelectableCard({@required this.title, @required this.isSelected, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
                title,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.black : darkBlueGrey.withOpacity(0.7)
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: isSelected ? selectedCheck() : SizedBox(),
            )
          ],
        ),
      ),
    );
  }


  Widget selectedCheck(){
    return CircleAvatar(
      radius: 15,
      backgroundColor: primaryColor,
      child: Icon(
        Icons.done,
        color: Colors.white,
      ),
    );
  }

}
