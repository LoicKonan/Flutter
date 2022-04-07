import "dart:io";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:gradely2/components/utils/app.dart";
import "package:gradely2/components/widgets/buttons.dart";

import "package:gradely2/components/variables.dart";

// ignore: must_be_immutable
class UpdateAppScreen extends StatelessWidget {
  String? minAppVersion;
  String? currentVersion;

  UpdateAppScreen(this.minAppVersion, this.currentVersion, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(
              flex: 12,
            ),
            SvgPicture.asset(
              "assets/images/DumpingDoodle.svg",
              color: Theme.of(context).primaryColorDark,
              height: 200,
            ),
            Spacer(
              flex: 4,
            ),
            Text(
              "updated_needed".tr(),
              style: bigTitle,
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "updated_needed_description".tr(),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              "updated_needed_version"
                  .tr(args: [currentVersion!, minAppVersion!]),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 20,
            ),
            SizedBox(
                width: 300,
                child: gradelyButton(
                    onPressed: () => launchURL((() {
                          if (Platform.isIOS || Platform.isMacOS) {
                            return "https://apps.apple.com/app/gradely-2-grade-calculator/id1578749974";
                          } else if (Platform.isAndroid) {
                            return "https://play.google.com/store/apps/details?id=com.eliasschneider.gradely2";
                          } else if (Platform.isWindows) {
                            return "https://www.microsoft.com/store/apps/9MW4FPN80D7D";
                          } else {
                            return "https://gradelyapp.com";
                          }
                        }())),
                    text: "update_now".tr())),
            Spacer(
              flex: 1,
            ),
            Spacer(
              flex: 8,
            ),
          ]),
        ),
      ),
    );
  }
}
