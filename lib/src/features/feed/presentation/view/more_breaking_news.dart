import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreBreakingNews extends StatefulWidget {
  const MoreBreakingNews({Key? key}) : super(key: key);

  @override
  State<MoreBreakingNews> createState() => _MoreBreakingNewsState();
}

class _MoreBreakingNewsState extends State<MoreBreakingNews> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          iconSize: 22,
        ),
        title: const Text("Breaking News"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.redoAlt,
              size: 22,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              ChoiceChip(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(color: Colors.blue.shade800, width: 1.4),
                ),
                label: const Text("Entertainment"),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                selectedColor: Colors.blue.shade800,
                backgroundColor: Colors.white,
              ),
              ChoiceChip(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(color: Colors.blue.shade800, width: 1.4),
                ),
                label: const Text("Entertainment"),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                selectedColor: Colors.blue.shade800,
                backgroundColor: Colors.white,
              ),
              ChoiceChip(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(color: Colors.blue.shade800, width: 1.4),
                ),
                label: const Text("Entertainment"),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                selectedColor: Colors.blue.shade800,
                backgroundColor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
