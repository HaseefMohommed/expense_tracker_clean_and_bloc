import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/extentions/failure_extention.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.appState == AppStatus.success) {
          Navigator.pushNamed(context, SignInPage.routeName);
        }
        state.faliure.showError(context, state.appState);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(
            AppTheme.primaryPadding,
          ),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                name: state.appState == AppStatus.loading
                    ? 'Please wait..'
                    : 'sign out',
                onPressed: () {
                  context.read<AuthCubit>().signOutUser();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
