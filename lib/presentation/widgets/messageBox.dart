import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final bool isMe;
  final String message;
  final DateTime dateTime;
  const MessageBox({
    // Key key,
    required this.isMe,
    required this.message,
    required this.dateTime
  });

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: TextStyle(fontSize: 14),
                      ),  Text(
                       "${dateTime.hour} : ${dateTime.minute}")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                       "${dateTime.hour} : ${dateTime.minute}")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
