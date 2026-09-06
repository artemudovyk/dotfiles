{ pkgs, ... }:

{
  # Enable OpenGL / Hardware Acceleration (Mesa + Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for 32-bit Steam games and Wine dependencies
  };

  # Enable Steam & GameMode
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin # Custom Proton build with extra game fixes & codecs
    ];
  };

  # Unlock AMD OverDrive features in kernel (0xffffffff enables all controls)
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # Enable CoreCtrl service and polkit rules
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };

  home-manager.sharedModules = [
    {
      systemd.user.services.corectrl = {
        Unit = {
          Description = "CoreCtrl System Tray Application";
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.corectrl}/bin/corectrl --minimize-systray";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      home.sessionVariables = {
        STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
      };

    }
  ];

}
