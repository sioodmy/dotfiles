{...}: {
  programs.vdirsyncer.enable = true;
  programs.khal = {
    enable = true;

    locale = {
      timeformat = "%H:%M";
      dateformat = "%d.%m";
      longdateformat = "%d.%m.%Y";
      datetimeformat = "%d.%m %H:%M";
      longdatetimeformat = "%d.%m.%Y %H:%M";
    };
  };

  accounts.calendar.basePath = "Calendars";
  accounts.calendar.accounts.main = {
    primary = true;
    primaryCollection = "Grafik";
    khal = {
      enable = true;
      color = "dark red";
      type = "discover";
      glob = "*";
    };
    local = {
      type = "filesystem";
      fileExt = ".ics";
    };
    remote = {
      type = "caldav";
      url = "http://192.168.21.69:5232/sioodmy/cba1abfe-7388-5310-02a3-9dd7a4e21e39/";
      userName = "sioodmy";
      passwordCommand = ["cat" "/run/agenix/radicale-pass"];
    };
    vdirsyncer = {
      enable = true;
      collections = ["Grafik"];
      conflictResolution = "remote wins";
    };
  };
}
