import 'package:flutter/material.dart';
import 'package:findpetapp/src/Utils/Styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool hasDrawer; // Nueva propiedad para controlar si tiene Drawer

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.hasDrawer = false, // Por defecto, no tiene Drawer
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(7),
        ),
      ),
      title: Text(title, style: smallitle(context)),
      centerTitle: true,
      leading: leading ??
          (hasDrawer
              ? IconButton(
                  icon:
                      const Icon(Icons.menu_open_outlined, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                )),
      actions: actions,
    );
  }
}
