{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs # Wayland screen capture plugin
          obs-pipewire-audio-capture # Per-application PipeWire audio capture
          obs-vaapi # Hardware acceleration (Intel/AMD GPUs)
          obs-vkcapture # Low-overhead Vulkan/OpenGL game capture
        ];
      };
    }
  ];
}
