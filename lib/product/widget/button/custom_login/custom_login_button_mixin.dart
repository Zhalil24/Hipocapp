part of 'custom_login_button.dart';

mixin _CustomLoginButtonMixin on MountedMixin<CustomLoginButton>, State<CustomLoginButton> {
  final ValueNotifier<bool> _isLoadingNotifer = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    _isLoadingNotifer.value = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onPressed(BuildContext context) async {
    _isLoadingNotifer.value = true;
    final resp = await widget.onOperation.call();
    await safeOperation(
      () async {
        if (resp) Navigator.pop(context);
        _isLoadingNotifer.value = false;
      },
    );
  }
}
