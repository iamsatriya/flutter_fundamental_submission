enum SwitchState {
  enable,
  disable;

  bool get isEnable => this == SwitchState.enable;
}

extension BoolExtension on bool {
  SwitchState get isEnable =>
      this == true ? SwitchState.enable : SwitchState.disable;
}
