{ pkgs, config, ...}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # i dont care about cookies
      { id = "eneajgkmdhmjmloiabgkpkiooaejmlpk"; } # copy as plain text
      { id = "aleakchihdccplidncghkekgioiakgal"; } # h264ify
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "dpgfbfopkfdfmlfdpmoanamopdnibhkl"; } # anti-testportal 
    ];
  };
}
