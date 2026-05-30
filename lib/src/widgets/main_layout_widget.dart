import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final bool showFooter;
  final bool showBackButton;

  const MainLayout({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.showFooter = true,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? CustomAppBarWidget(showBackButton: showBackButton) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            if (showFooter) const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}
