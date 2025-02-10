import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_color.dart';
import '../../../../constants/typograph.dart';
import '../../../../utils/helpers/date_helper.dart';
import '../../../auth/presentation/logout/cubit/logout_cubit.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).viewPadding.top + 40,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning',
            style: Typograph.body12r.copyWith(
              color: AppColor.greyTextColor,
            ),
          ),
          Text(
            DateHelper.dateTimeToStrDate(DateTime.now()),
            style: Typograph.subtitle16m,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<LogoutCubit>().logout();
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
