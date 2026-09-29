# {
#   home-manager.sharedModules = [
#     {
#       # 1. Disable node suspension on idle
#       xdg.configFile."wireplumber/wireplumber.conf.d/51-disable-suspension.conf".text = ''
#         monitor.alsa.rules = [
#           {
#             matches = [ { node.name = "~alsa_output.*" } ]
#             actions = {
#               update-props = {
#                 session.suspend-timeout-seconds = 0
#               }
#             }
#           }
#         ]
#
#         monitor.bluez.rules = [
#           {
#             matches = [ { node.name = "~bluez_output.*" } ]
#             actions = {
#               update-props = {
#                 session.suspend-timeout-seconds = 0
#               }
#             }
#           }
#         ]
#       '';
#
#       # 2. Bluetooth monitor rules & codec lock (WirePlumber 0.5 syntax)
#       xdg.configFile."wireplumber/wireplumber.conf.d/51-bose-fix.conf".text = ''
#         monitor.bluez.properties = {
#           bluez5.codecs = [ "sbc_xq" "sbc" "ldac" "aptx" ]
#           bluez5.enable-sbc-xq = true
#           bluez5.enable-msbc = false
#           bluez5.roles = [ "a2dp_sink" "a2dp_source" ]
#         }
#       '';
#
#       # 3. Disable auto-switching to HFP/HSP microphone profile
#       xdg.configFile."wireplumber/wireplumber.conf.d/50-disable-autoswitch.conf".text = ''
#         wireplumber.settings = {
#           bluetooth.autoswitch-to-headset-profile = false
#         }
#       '';
#
#       # 4. Increase quantum / latency specifically for Bluetooth outputs
#       xdg.configFile."wireplumber/wireplumber.conf.d/52-increase-quantum.conf".text = ''
#         monitor.bluez.rules = [
#           {
#             matches = [
#               {
#                 node.name = "~bluez_output.*"
#               }
#             ]
#             actions = {
#               update-props = {
#                 # Fixes "out of buffers" XRuns on Bluetooth sinks specifically
#                 node.latency = "1024/48000"
#                 api.bluez5.a2dp.rate = 48000
#               }
#             }
#           }
#         ]
#       '';
#     }
#   ];
# }

{
  home-manager.sharedModules = [
    {
      xdg.configFile."wireplumber/wireplumber.conf.d/51-disable-suspension.conf".text = ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_output.*"
              }
            ]
            actions = {
              update-props = {
                session.suspend-timeout-seconds = 0
              }
            }
          }
        ]

        monitor.bluez.rules = [
          {
            matches = [
              {
                node.name = "~bluez_output.*"
              }
            ]
            actions = {
              update-props = {
                session.suspend-timeout-seconds = 0
              }
            }
          }
        ]
      '';

      # 2. Disable AAC globally for Bluetooth via Home Manager file
      xdg.configFile."wireplumber/wireplumber.conf.d/51-bose-fix.conf".text = ''
        monitor.bluez.properties = {
          bluez5.codecs = [ "sbc" "sbc_xq" "ldac" "aptx" ]
          bluez5.enable-sbc-xq = true
        }
      '';

      # xdg.configFile."wireplumber/wireplumber.conf.d/51-bose-fix.conf".text = ''
      #   monitor.bluez.properties = {
      #     # Lock priority order strictly to prevent renegotiation loops
      #     bluez5.codecs = [ "sbc_xq" "ldac" "sbc" ]
      #     bluez5.enable-sbc-xq = true
      #     bluez5.enable-msbc = false
      #     bluez5.enable-hw-volume = true
      #   }
      # '';

      xdg.configFile."wireplumber/wireplumber.conf.d/50-disable-autoswitch.conf".text = ''
        wireplumber.settings = {
          bluetooth.autoswitch-to-headset-profile = false
        }
      '';

      xdg.configFile."wireplumber/wireplumber.conf.d/52-increase-quantum.conf".text = ''
        monitor.bluez.properties = {
          bluez5.default.rate = 48000
          # Increase latency/buffer allocation to prevent buffer underruns
          api.bluez5.a2dp.quantum = 1024
        }

        context.properties = {
          default.clock.min-quantum = 1024
        }
      '';
      # -- HM
    }
  ];
}
