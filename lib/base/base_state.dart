import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

import '../components/text_component.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  var isShowDataFromArguments = true;

  AppBar navigationAppBar({
    String? title,
    bool isCenterTitle = false,
    bool isTranslatable = true,
    List<Widget>? actionWidgets,
    required Function() clickIcon,
  }) {
    return AppBar(
      centerTitle: isCenterTitle,
      title: _getTitle(title, isTranslatable),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      actions: [
        if (actionWidgets != null && actionWidgets.isNotEmpty) ...[
          ...actionWidgets,
        ],
      ],
    );
  }

  Text? _getTitle(String? title, bool isTranslatable) {
    if (title != null && title != "") {
      var textStyle = GoogleFonts.getFont(
        latoFont,
        // lineWight
        fontWeight: boldFontWeight,
        color: kFilterTitleColor,
        fontSize: titleFontSize,
      );

      if (isTranslatable) {
        return Text(
          title,
          style: textStyle,
        );
      } else {
        return Text(
          title,
          style: textStyle,
        );
      }
    }

    return null;
  }

  AppBar myAppBar(
      {String? title,
      bool isNavigate = true,
      bool isCenterTitle = false,
      bool isTranslatable = true,
      List<Widget>? actions}) {
    return AppBar(
      elevation: isNavigate ? 1.4 : 1,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: isCenterTitle,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light // optional
          ),
      title: _getTitle(title, isTranslatable),
      backgroundColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.15),
      leading: isNavigate
          ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, bottom: 12.0, top: 12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    //color: kDisabledTextColor.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: kTextColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  void resetGetXValues(List<Rxn<dynamic>?>? args) {
    if (args != null) {
      for (var arg in args) {
        arg?.value = null;
      }
    }
  }

  bool isBlank(List<dynamic>? args) {
    if (args != null) {
      for (var arg in args) {
        if (arg == null) {
          return true;
        } else if (arg is String && arg.trim().isEmpty) {
          return true;
        }
      }
    }

    return false;
  }

  Widget noDataFoundWidget({
    String? message,
    double divider = 1,
  }) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(context) / divider,
      width: SizeConfig.getScreenWidth(context),
      child: Center(
        child: TextComponent(
          message ?? "no_data_found",
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
