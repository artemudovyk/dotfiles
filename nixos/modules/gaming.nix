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
      proton-ge-bin
      mangohud
    ];
    package = pkgs.steam.override {
      extraEnv = {
        SDL_JOYSTICK_HIDAPI_XBOX = "0";
      };
    };
  };

  programs.xwayland.enable = true;

  # Unlock AMD OverDrive features in kernel (0xffffffff enables all controls)
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  programs.corectrl.enable = true;
  hardware.amdgpu.overdrive.enable = true;

  # Controller (Dualsense) udev rules
  services.udev.packages = [
    pkgs.game-devices-udev-rules
  ];
  # hardware.uinput.enable = true;
  boot.kernelModules = [
    "hid-sony"
    "hid-playstation"
    "snd-seq" # Needed for USB audio stream routing
  ];
  users.users.artud.extraGroups = [
    "input"
    "uinput"
  ];
  # PipeWire/Audio setup needed for Haptics audio channel routing
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

      home.packages = with pkgs; [
        pavucontrol
      ];

      home.sessionVariables = {
        STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };

      programs.mangohud = {
        enable = true;
        enableSessionWide = true;

        settings = {
          no_display = true;
          toggle_hud = "Shift_R+F1";

          # Visual layout & metrics
          legacy_layout = false;
          gpu_stats = true;
          gpu_temp = true;
          cpu_stats = true;
          cpu_temp = true;
          ram = true;
          vram = true;
          fps = true;
          frametime = true;
          frame_timing = 1;

          # Styling
          font_size = 18;
          background_alpha = "0.5";
          round_corners = 4;
        };
      };
      # -- HM
    }
  ];

}
