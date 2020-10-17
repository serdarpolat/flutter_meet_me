import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final ScrollController scrollController;
  final double topBarOffset;
  final Function onNotification;

  const Messages({
    Key key,
    this.scrollController,
    this.topBarOffset,
    this.onNotification,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: s.width,
      height: s.height,
      child: Stack(
        children: [
          Container(
            width: s.width,
            height: s.height,
            child: Opacity(
              opacity: 0.0,
              child: Image.asset(
                "assets/images/05-Messages.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: s.width,
            height: s.height,
            padding: EdgeInsets.only(bottom: 80, top: 160 - topBarOffset),
            child: NotificationListener<ScrollNotification>(
              onNotification: onNotification,
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                controller: scrollController,
                itemCount: 20,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: s.width,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://randomuser.me/api/portraits/women/89.jpg"),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Denise Burton",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "That's awesome man. How about a date ton...",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "13:25",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
