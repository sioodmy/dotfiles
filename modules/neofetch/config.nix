''
  print_info()
  {
      info title
      info underline
      info " " distro
      info " " kernel
      info " " packages
      info " " de
      info " " memory
      info " " uptime
      info cols
  }
  title_fqdn="off"
  kernel_shorthand="on"
  distro_shorthand="on"
  os_arch="off"
  uptime_shorthand="tiny"
  memory_percent="on"
  memory_unit="mib"
  package_managers="off"
  shell_path="off"
  shell_version="on"
  speed_type="bios_limit"
  speed_shorthand="on"
  cpu_brand="on"
  cpu_speed="on"
  cpu_cores="logical"
  cpu_temp="C"
  gpu_brand="on"
  gpu_type="all"
  refresh_rate="on"
  gtk_shorthand="on"
  gtk2="on"
  gtk3="on"
  public_ip_host="http://ident.me"
  public_ip_timeout=2
  de_version="on"
  disk_show=('/')
  disk_subtitle="mount"
  disk_percent="on"
  music_player="auto"
  song_format="%artist% - %album% - %title%"
  song_shorthand="on"
  mpc_args=(-p 7777)
  colors=(5 5 5 5 5 7)
  bold="on"
  underline_enabled="on"
  underline_char="━"
  separator="⋮"
  block_range=(0 7)
  color_blocks="off"
  block_width=3
  block_height=1
  col_offset="auto"
  bar_char_elapsed="-"
  bar_char_total="="
  bar_border="on"
  bar_length=15
  bar_color_elapsed="distro"
  bar_color_total="distro"
  cpu_display="off"
  memory_display="off"
  battery_display="off"
  disk_display="off"
  image_backend="kitty"
  image_source="${./sakurafetch.png}"
  ascii_distro="auto"
  ascii_colors=(distro)
  ascii_bold="on"
  image_loop="off"
  crop_mode="normal"
  crop_offset="center"
  image_size="208px"
  gap=2
  yoffset=0
  xoffset=0
  background_color=
  stdout="off"
''
