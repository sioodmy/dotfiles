{
  config,
  pkgs,
  ...
}: let
  # credits: kurnevsky
  json = pkgs.formats.json {};
  rnnoise = {
    type = "ladspa";
    name = "rnnoise";
    plugin = "librnnoise_ladspa";
    label = "noise_suppressor_stereo";
    control = {"VAD Threshold (%)" = 50.0;};
  };
  pw_rnnoise_config = {
    "context.properties" = {"log.level" = 0;};
    "context.spa-libs" = {
      "audio.convert.*" = "audioconvert/libspa-audioconvert";
      "support.*" = "support/libspa-support";
    };
    "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -11;
          "rt.prio" = 88;
          "rt.time.soft" = 2000000;
          "rt.time.hard" = 2000000;
        };
        flags = ["ifexists" "nofail"];
      }
      {name = "libpipewire-module-protocol-native";}
      {name = "libpipewire-module-client-node";}
      {name = "libpipewire-module-adapter";}

      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.name" = "effect_input.rnnoise";
          "node.description" = "Noise Cancellation Source";
          "media.name" = "Noise Cancellation Source";
          "filter.graph" = {nodes = [rnnoise];};
          "capture.props" = {"node.passive" = true;};
          "playback.props" = {"media.class" = "Audio/Source";};
        };
      }

      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.name" = "effect_output.rnnoise";
          "node.description" = "Noise Cancellation Sink";
          "media.name" = "Noise Cancellation Sink";
          "filter.graph" = {nodes = [rnnoise];};
          "capture.props" = {"media.class" = "Audio/Sink";};
          "playback.props" = {"node.passive" = true;};
        };
      }
    ];
  };
in {
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  environment.etc."wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
    bluez_monitor.properties = {
      ["bluez5.enable-sbc-xq"] = true,
      ["bluez5.enable-msbc"] = true,
      ["bluez5.enable-hw-volume"] = true,
      ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
    }
  '';
  environment.etc."pipewire/source-rnnoise.conf" = {
    source = json.generate "source-rnnoise.conf" pw_rnnoise_config;
  };
  systemd.services."pipewire-source-rnnoise" = {
    environment.LADSPA_PATH = "${pkgs.rnnoise-plugin}/lib/ladspa";
    description = "Noise canceling source for pipewire";
    requires = ["pipewire.service"];
    after = ["pipewire.service"];
    script = "${pkgs.pipewire}/bin/pipewire -c source-rnnoise.conf";
    serviceConfig = {
      DynamicUser = true;
      PrivateTmp = true;
      SupplementaryGroups = "pipewire";
    };
  };
}
