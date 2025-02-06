{ inputs, settings, ... }: {
  imports = [ /* Configuration */ ];

  system.stateVersion = settings.system.version;
}
