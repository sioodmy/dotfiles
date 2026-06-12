{
    config,
    lib,
    ...
}: let
    inherit (lib.attrsets) listToAttrs;
    inherit (lib.lists) map;
    inherit (lib.kernel) no option unset yes;
    inherit (lib.modules) mkForce;

    forceUnsetAll = options:
        listToAttrs (map
            (opt: { name = opt; value = mkForce unset; })
            options);

    forceOptionUnsetAll = options:
        listToAttrs (map
            (opt: { name = opt; value = mkForce (option unset); })
            options);
in {
    boot.kernelPackages = mkForce (config.hardware.asahi.pkgs.linux-asahi.override {
        _kernelPatches = config.boot.kernelPatches;
        enableCommonConfig = false;
    });

    boot.kernelPatches = [
        {
            name = "Remove unused architectures";
            patch = null;
            structuredExtraConfig = {
                ARCH_ACTIONS = no;
                ARCH_AIROHA = no;
                ARCH_SUNXI = no;
                ARCH_ALPINE = no;
                ARCH_APPLE = yes;
                ARCH_ARTPEC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_AXIADO = no;
                ARCH_BCM = no;
                ARCH_BCM_IPROC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_BCMBCA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_BRCMSTB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_BERLIN = no;
                ARCH_BITMAIN = no;
                ARCH_BLAIZE = no;
                ARCH_BST = no;
                ARCH_CIX = no;
                ARCH_EXYNOS = no;
                ARCH_K3 = no;
                ARCH_LG1K = no;
                ARCH_HISI = no;
                ARCH_KEEMBAY = no;
                ARCH_MEDIATEK = no;
                ARCH_MESON = no;
                ARCH_LAN969X = no;
                ARCH_SPARX5 = no;
                ARCH_MMP = no;
                ARCH_MVEBU = no;
                ARCH_NXP = no;
                ARCH_LAYERSCAPE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_MXC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_S32 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARCH_MA35 = no;
                ARCH_NPCM = no;
                ARCH_PENSANDO = no;
                ARCH_QCOM = no;
                ARCH_REALTEK = no;
                ARCH_RENESAS = no;
                ARCH_ROCKCHIP = no;
                ARCH_SEATTLE = no;
                ARCH_INTEL_SOCFPGA = no;
                ARCH_SOPHGO = no;
                ARCH_STM32 = no;
                ARCH_SYNQUACER = no;
                ARCH_TEGRA = no;
                ARCH_SPRD = no;
                ARCH_THUNDER = no;
                ARCH_THUNDER2 = no;
                ARCH_UNIPHIER = no;
                ARCH_VEXPRESS = no;
                ARCH_VISCONTI = no;
                ARCH_XGENE = no;
                ARCH_ZYNQMP = no;
            };
        }
        {
            name = "Remove unused platforms";
            patch = null;
            structuredExtraConfig = {
                MELLANOX_PLATFORM = no;
                LOONGARCH_PLATFORM_DEVICES = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                X86_PLATFORM_DEVICES = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                X86_PLATFORM_DRIVERS_UNIWILL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                X86_PLATFORM_DRIVERS_DELL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                SURFACE_PLATFORMS = no;
                MIPS_PLATFORM_DEVICES = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                CHROME_PLATFORMS = no;
            };
        }
        {
            name = "Remove unused ARM errata workarounds";
            patch = null;
            structuredExtraConfig = {
                AMPERE_ERRATUM_AC03_CPU_38 = no;
                AMPERE_ERRATUM_AC04_CPU_23 = no;
                ARM64_ERRATUM_826319 = no;
                ARM64_ERRATUM_827319 = no;
                ARM64_ERRATUM_824069 = no;
                ARM64_ERRATUM_819472 = no;
                ARM64_ERRATUM_832075 = no;
                ARM64_ERRATUM_834220 = no;
                ARM64_ERRATUM_1742098 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARM64_ERRATUM_845719 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARM64_ERRATUM_843419 = no;
                ARM64_ERRATUM_1024718 = no;
                ARM64_ERRATUM_1418040 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                ARM64_ERRATUM_1165522 = no;
                ARM64_ERRATUM_1319367 = no;
                ARM64_ERRATUM_1530923 = no;
                ARM64_ERRATUM_2441007 = no;
                ARM64_ERRATUM_1286807 = no;
                ARM64_ERRATUM_1463225 = no;
                ARM64_ERRATUM_1542419 = no;
                ARM64_ERRATUM_1508412 = no;
                ARM64_ERRATUM_2051678 = no;
                ARM64_ERRATUM_2077057 = no;
                ARM64_ERRATUM_2658417 = no;
                ARM64_ERRATUM_2054223 = no;
                ARM64_ERRATUM_2067961 = no;
                ARM64_ERRATUM_2441009 = no;
                ARM64_ERRATUM_2457168 = no;
                ARM64_ERRATUM_2645198 = no;
                ARM64_ERRATUM_2966298 = no;
                ARM64_ERRATUM_3117295 = no;
                ARM64_ERRATUM_3194386 = no;
                CAVIUM_ERRATUM_22375 = no;
                CAVIUM_ERRATUM_23144 = no;
                CAVIUM_ERRATUM_23154 = no;
                CAVIUM_ERRATUM_27456 = no;
                CAVIUM_ERRATUM_30115 = no;
                CAVIUM_TX2_ERRATUM_219 = no;
                FUJITSU_ERRATUM_010001 = no;
                HISILICON_ERRATUM_161600802 = no;
                HISILICON_ERRATUM_162100801 = no;
                QCOM_FALKOR_ERRATUM_1003 = no;
                QCOM_FALKOR_ERRATUM_1009 = no;
                QCOM_QDF2400_ERRATUM_0065 = no;
                QCOM_FALKOR_ERRATUM_E1041 = no;
                NVIDIA_CARMEL_CNP_ERRATUM = no;
                ROCKCHIP_ERRATUM_3568002 = no;
                ROCKCHIP_ERRATUM_3588001 = no;
                SOCIONEXT_SYNQUACER_PREITS = no;
            };
        }
        {
            name = "Remove unused DRM stuff";
            patch = null;
            structuredExtraConfig = {
                DRM_HDLCD = no;
                DRM_MALI_DISPLAY = no;
                DRM_KOMEDA = no;
                DRM_RADEON = no;
                DRM_AMDGPU = no;
                DRM_NOUVEAU = no;
                DRM_XE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                DRM_VGEM = no;
                DRM_VKMS = no;
                DRM_VMWGFX = no;
                DRM_UDL = no;
                DRM_AST = no;
                DRM_MGAG200 = no;
                DRM_QXL = no;
                DRM_VIRTIO_GPU = no;
                DRM_ETNAVIV = no;
                DRM_HISI_HIBMC = no;
                DRM_HISI_KIRIN = no;
                DRM_LOGICVC = no;
                DRM_ARCPGU = no;
                DRM_BOCHS = no;
                DRM_CIRRUS_QEMU = no;
                DRM_GM12U320 = no;
                DRM_PL111 = no;
                DRM_XEN_FRONTEND = no;
                DRM_LIMA = no;
                DRM_PANFROST = no;
                DRM_PANTHOR = no;
                DRM_TIDSS = no;
                DRM_ADP = no;
                DRM_GUD = no;
                DRM_POWERVR = no;
                # repeated question
                # DRM_SIMPLEDRM = yes;
            };
        }
        {
            name = "Remove unused HID stuff";
            patch = null;
            structuredExtraConfig = {
                HID_ACCUTOUCH = no;
                HID_ACRUX = no;
                # already set by nixos-apple-silicon
                # HID_APPLE = module;
                HID_APPLEIR = no;
                HID_ASUS = no;
                HID_AUREAL = no;
                HID_BELKIN = no;
                HID_BETOP_FF = no;
                HID_BIGBEN_FF = no;
                HID_CHERRY = no;
                HID_CHICONY = no;
                HID_CORSAIR = no;
                HID_COUGAR = no;
                HID_MACALLY = no;
                HID_PRODIKEYS = no;
                HID_CMEDIA = no;
                HID_CREATIVE_SB0540 = no;
                HID_CYPRESS = no;
                HID_DRAGONRISE = no;
                HID_EMS_FF = no;
                HID_ELAN = no;
                HID_ELECOM = no;
                HID_ELO = no;
                HID_EVISION = no;
                HID_EZKEY = no;
                HID_GEMBIRD = no;
                HID_GFRM = no;
                HID_GLORIOUS = no;
                HID_HOLTEK = no;
                HID_GOODIX_SPI = no;
                HID_GOOGLE_HAMMER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                HID_GOOGLE_STADIA_FF = no;
                HID_VIVALDI = no;
                HID_GT683R = no;
                HID_KEYTOUCH = no;
                HID_KYE = no;
                HID_KYSONA = no;
                HID_UCLOGIC = no;
                HID_WALTOP = no;
                HID_VIEWSONIC = no;
                HID_VRC2 = no;
                HID_XIAOMI = no;
                HID_GYRATION = no;
                HID_ICADE = no;
                HID_ITE = no;
                HID_JABRA = no;
                HID_TWINHAN = no;
                HID_KENSINGTON = no;
                HID_LCPOWER = no;
                HID_LED = no;
                HID_LENOVO = no;
                HID_LETSKETCH = no;
                # repeated question
                # HID_LOGITECH = yes;
                # option not set correctly
                # HID_LOGITECH_HIDPP = no;
                LOGITECH_FF = mkForce no;
                LOGIRUMBLEPAD2_FF = mkForce no;
                LOGIG940_FF = mkForce no;
                LOGIWHEELS_FF = mkForce no;
                HID_MAGICMOUSE = no;
                HID_MALTRON = no;
                HID_MAYFLASH = no;
                HID_MEGAWORLD_FF = no;
                HID_REDRAGON = no;
                HID_MICROSOFT = no;
                HID_MONTEREY = no;
                HID_MULTITOUCH = no;
                HID_NINTENDO = yes;
                HID_NTI = no;
                HID_NTRIG = no;
                HID_NVIDIA_SHIELD = no;
                HID_ORTEK = no;
                HID_PANTHERLORD = no;
                HID_PENMOUNT = no;
                HID_PETALYNX = no;
                HID_PICOLCD = no;
                HID_PLANTRONICS = no;
                HID_PLAYSTATION = no;
                HID_PXRC = no;
                HID_RAZER = no;
                HID_PRIMAX = no;
                HID_RETRODE = no;
                HID_ROCCAT = no;
                HID_SAITEK = no;
                HID_SAMSUNG = no;
                HID_SEMITEK = no;
                HID_SIGMAMICRO = no;
                HID_SONY = no;
                HID_SPEEDLINK = no;
                HID_STEAM = yes;
                HID_STEELSERIES = no;
                HID_SUNPLUS = no;
                HID_RMI = no;
                HID_GREENASIA = no;
                HID_SMARTJOYPLUS = no;
                HID_TIVO = no;
                HID_TOPSEED = no;
                HID_TOPRE = no;
                HID_THINGM = no;
                HID_THRUSTMASTER = no;
                HID_UDRAW_PS3 = no;
                HID_U2FZERO = no;
                HID_WACOM = no;
                HID_WIIMOTE = no;
                HID_WINWING = no;
                HID_XINMO = no;
                HID_ZEROPLUS = no;
                HID_ZYDACRON = no;
                HID_SENSOR_HUB = no;
                HID_ALPS = no;
                HID_MCP2200 = no;
                HID_MCP2221 = no;
            };
        }
        {
            name = "Remove unused I2C stuff";
            patch = null;
            structuredExtraConfig = {
                I2C_ALI1535 = no;
                I2C_ALI1563 = no;
                I2C_ALI15X3 = no;
                I2C_AMD756 = no;
                I2C_AMD8111 = no;
                I2C_AMD_MP2 = no;
                I2C_AMD_ASF = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_HIX5HD2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_I801 = no;
                I2C_I801_MUX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ISCH = no;
                I2C_ISMT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_PIIX4 = no;
                I2C_CHT_WC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_NFORCE2 = no;
                I2C_NVIDIA_GPU = no;
                I2C_SIS5595 = no;
                I2C_SIS630 = no;
                I2C_SIS96X = no;
                I2C_VIA = no;
                I2C_VIAPRO = no;
                I2C_SCMI = no;
                I2C_HYDRA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_POWERMAC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ALTERA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ASPEED = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_AT91 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_AT91_SLAVE_EXPERIMENTAL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_AU1550 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_AXXIA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_BCM2835 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_BCM_IPROC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_BCM_KONA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_BRCMSTB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_CADENCE = no;
                I2C_CBUS_GPIO = no;
                I2C_CGBC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DAVINCI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_CORE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_PLATFORM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_AMDISP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_AMDPSP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_BAYTRAIL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DESIGNWARE_PCI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DIGICOLOR = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_EG20T = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_EMEV2 = no;
                I2C_EXYNOS5 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_GPIO = yes;
                I2C_GPIO_FAULT_INJECTOR = no;
                I2C_GXP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_HIGHLANDER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_HISI = no;
                I2C_IBM_IIC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_IMG = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_IMX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_IMX_LPI2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_IOP3XX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_JZ4780 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_K1 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_KEBA = no;
                I2C_KEMPLD = no;
                I2C_LPC2K = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_LS2X = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MLXBF = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MESON = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MICROCHIP_CORE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MPC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MT65XX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MT7621 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MV64XXX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MXS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_NOMADIK = no;
                I2C_NPCM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_OCORES = no;
                I2C_OMAP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_OWL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_PASEMI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_APPLE = yes;
                I2C_PCA_PLATFORM = no;
                I2C_PNX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_PXA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_PXA_SLAVE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_QCOM_CCI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_QCOM_GENI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_QUP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_RIIC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_RK3X = no;
                I2C_RTL9300 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_RZV2M = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SH7760 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SH_MOBILE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SIMTEC = no;
                I2C_SPRD = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ST = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_STM32F4 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_STM32F7 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SUN6I_P2WI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SYNQUACER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_TEGRA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_TEGRA_BPMP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_UNIPHIER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_UNIPHIER_F = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                # unused option
                # I2C_VERSATILE = yes;
                I2C_WMT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_OCTEON = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_THUNDERX = no;
                # repeated question
                # I2C_XILINX = no;
                I2C_XLP9XX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_RCAR = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_DIOLAN_U2C = no;
                I2C_DLN2 = no;
                I2C_LJCA = no;
                I2C_NCT6694 = no;
                I2C_USBIO = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_CP2615 = no;
                # repeated question
                # I2C_PARPORT = yes;
                I2C_PCI1XXXX = no;
                I2C_ROBOTFUZZ_OSIF = no;
                I2C_TAOS_EVM = no;
                I2C_TINY_USB = yes;
                I2C_VIPERBOARD = no;
                I2C_ACORN = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ELEKTOR = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_ICY = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_MLXCPLD = no;
                I2C_PCA_ISA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_SIBYTE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_CROS_EC_TUNNEL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_XGENE_SLIMPRO = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                SCx200_ACB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_OPAL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                I2C_FSI = no;
                I2C_VIRTIO = no;
            };
        }
        {
            name = "Remove unused frame buffer stuff";
            patch = null;
            structuredExtraConfig = {
                FB_HECUBA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MACMODES = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_GRVGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CIRRUS = no;
                FB_PM2 = no;
                FB_PM2_FIFO_DISCONNECT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ACORN = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CLPS711X = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SA1100 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_IMX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CYBER2000 = no;
                FB_CYBER2000_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_APOLLO = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_Q40 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AMIGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AMIGA_OCS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AMIGA_ECS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AMIGA_AGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_FM2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ARC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ATARI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CONTROL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PLATINUM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VALKYRIE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CT65550 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ASILIANT = no;
                FB_IMSTT = no;
                FB_VGA16 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_STI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MAC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_HP300 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_TGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_UVESA = no;
                FB_VESA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_EFI = yes;
                FB_N411 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_HGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_GBE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SBUS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SBUS_HELPERS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_BW2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CG3 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CG6 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_FFB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_TCX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_CG14 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_P9100 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_LEO = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_XVR500 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_XVR2500 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_XVR1000 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PVR2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OPENCORES = no;
                FB_S1D13XXX = no;
                FB_ATMEL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_NVIDIA = no;
                FB_NVIDIA_DEBUG = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_NVIDIA_BACKLIGHT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_RIVA = no;
                # FB_RIVA_DEBUG = no;
                # FB_RIVA_BACKLIGHT = no;
                FB_I740 = no;
                FB_I810 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_I810_GTF = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_I810_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX_MILLENIUM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX_MYSTIQUE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX_G = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MATROX_MAVEN = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_RADEON = no;
                FB_RADEON_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_RADEON_BACKLIGHT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_RADEON_DEBUG = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ATY128 = no;
                FB_ATY = no;
                FB_ATY_GENERIC_LCD = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_ATY_BACKLIGHT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_S3 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_S3_DDC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SAVAGE = no;
                FB_SIS = no;
                FB_VIA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VIA_DIRECT_PROCFS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VIA_X_COMPATIBILITY = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_NEOMAGIC = no;
                FB_KYRO = no;
                FB_3DFX = no;
                FB_3DFX_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VOODOO1 = no;
                FB_VT8623 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_TRIDENT = no;
                FB_ARK = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PM3 = no;
                FB_CARMINE = no;
                FB_CARMINE_DRAM_EVAL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                CARMINE_DRAM_CUSTOM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AU1100 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_AU1200 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VT8500 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_WM8505 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_WMT_GE_ROPS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_HIT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PMAG_AA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PMAG_BA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MAXINE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_G364 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_68328 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PXA168 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PXA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PXA_OVERLAY = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PXA_SMARTPANEL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PXA_PARAMETERS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                PXA3XX_GCU = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_FSL_DIU = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SH_MOBILE_LCDC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_S3C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_S3C_DEBUG_REGWRITE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SM501 = no;
                FB_SMSCUFX = no;
                FB_UDL = no;
                FB_IBM_GXT4500 = no;
                FB_PS3 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_XILINX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_GOLDFISH = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_COBALT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SH7760 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_VIRTUAL = no;
                XEN_FBDEV_FRONTEND = no;
                FB_METRONOME = no;
                FB_MB862XX = no;
                FB_MB862XX_PCI_GDC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_MB862XX_I2C = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_EP93XX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_PRE_INIT_FB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_BROADSHEET = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SIMPLE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_SSD1307 = no;
                FB_SM712 = no;
                FB_OMAP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP_LCDC_EXTERNAL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP_LCDC_HWA742 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP_MANUAL_UPDATE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP_LCD_MIPID = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP_DMA_TUNE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP2_DEBUG_SUPPORT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                FB_OMAP2_NUM_FBS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                MMP_DISP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                MMP_DISP_CONTROLLER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                MMP_DISP_SPI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                MMP_PANEL_TPOHVGA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                MMP_FB = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
            };
        }
        {
            name = "Remove unused network stuff";
            patch = null;
            structuredExtraConfig = {
                NET_VENDOR_3COM = no;
                NET_VENDOR_8390 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_ACTIONS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_ADAPTEC = no;
                NET_VENDOR_ADI = no;
                GRETH = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_AGERE = no;
                NET_VENDOR_AIROHA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_ALACRITECH = no;
                NET_VENDOR_ALLWINNER = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_ALTEON = no;
                ALTERA_TSE = no;
                NET_VENDOR_AMAZON = no;
                NET_VENDOR_AMD = no;
                NET_XGENE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_XGENE_V2 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_APPLE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_AQUANTIA = no;
                NET_VENDOR_ARC = no;
                NET_VENDOR_ASIX = no;
                NET_VENDOR_ATHEROS = no;
                NET_VENDOR_BROCADE = no;
                BNA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_CADENCE = no;
                NET_CALXEDA_XGMAC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_CAVIUM = no;
                # option not set correctly
                # NET_VENDOR_CHELSIO = no;
                NET_VENDOR_CIRRUS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_CISCO = no;
                NET_VENDOR_CORTINA = no;
                NET_VENDOR_DAVICOM = no;
                NET_VENDOR_DEC = no;
                NET_VENDOR_DLINK = no;
                # option not set correctly
                # NET_VENDOR_EMULEX = no;
                NET_VENDOR_ENGLEDER = no;
                NET_VENDOR_EZCHIP = no;
                NET_VENDOR_FARADAY = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_FREESCALE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_FUJITSU = no;
                NET_VENDOR_FUNGIBLE = no;
                NET_VENDOR_GOOGLE = no;
                NET_VENDOR_HISILICON = no;
                NET_VENDOR_HUAWEI = no;
                NET_VENDOR_I825XX = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_IBM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_INTEL = no;
                NET_VENDOR_LITEX = no;
                NET_VENDOR_MARVELL = no;
                NET_VENDOR_MELLANOX = no;
                NET_VENDOR_META = no;
                NET_VENDOR_MICREL = no;
                NET_VENDOR_MICROCHIP = no;
                NET_VENDOR_MICROSOFT = no;
                NET_VENDOR_MOXART = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_MICROSEMI = no;
                NET_VENDOR_MUCSE = no;
                NET_VENDOR_MYRI = no;
                NET_VENDOR_NATSEMI = no;
                NET_VENDOR_NETRONOME = no;
                NET_VENDOR_NI = no;
                NET_VENDOR_NVIDIA = no;
                NET_VENDOR_OKI = no;
                NET_VENDOR_PACKET_ENGINES = no;
                NET_VENDOR_PASEMI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_PENSANDO = no;
                NET_VENDOR_QLOGIC = no;
                NET_VENDOR_QUALCOMM = no;
                NET_VENDOR_RDC = no;
                NET_VENDOR_REALTEK = no;
                NET_VENDOR_RENESAS = no;
                NET_VENDOR_ROCKER = no;
                NET_VENDOR_SAMSUNG = no;
                NET_VENDOR_SEEQ = no;
                NET_VENDOR_SOLARFLARE = no;
                NET_VENDOR_SGI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_SILAN = no;
                NET_VENDOR_SIS = no;
                NET_VENDOR_SMSC = no;
                NET_VENDOR_SOCIONEXT = no;
                NET_VENDOR_SPACEMIT = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_STMICRO = no;
                NET_VENDOR_SUN = no;
                NET_VENDOR_SUNPLUS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_SYNOPSYS = no;
                NET_VENDOR_TEHUTI = no;
                NET_VENDOR_TI = no;
                NET_VENDOR_TOSHIBA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_TUNDRA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                NET_VENDOR_VERTEXCOM = no;
                NET_VENDOR_VIA = no;
                NET_VENDOR_WANGXUN = no;
                NET_VENDOR_WIZNET = no;
                NET_VENDOR_XILINX = no;
                NET_VENDOR_XIRCOM = no;
                NET_VENDOR_XSCALE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!

                NET_VENDOR_BROADCOM = yes;

                B44 = no;
                BCM4908_ENET = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BCMGENET = no;
                # repeated question
                # BNX2 = no;
                # repeated question
                # CNIC = no;
                SB1250_MAC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                TIGON3 = no;
                BNX2X = no;
                BGMAC = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BGMAC_BCMA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BGMAC_PLATFORM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BNXT = no;
                BNGE = no;
                BCMASP = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!

                # already set by the default asahi config
                # `arch/arm64/configs/asahi.config`
                # BT_HCIBCM4377 = yes;

                # option not set correctly
                # BT_INTEL = no;
                BT_BCM = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BT_RTL = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BT_MTK = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                # repeated question
                # BT_HCIBTUSB = yes;
                BT_HCIBTSDIO = no;
                BT_HCIUART = mkForce no;
                BT_HCIBCM203X = no;
                BT_HCIBPA10X = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                BT_HCIBFUSB = no;
                BT_HCIDTL1 = no;
                BT_HCIBT3C = no;
                BT_HCIBLUECARD = no;
                BT_HCIVHCI = no;
                BT_MRVL = no;
                BT_MTKSDIO = no;
                BT_QCOMSMD = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
                # option not set correctly
                # BT_HCIRSI = no;
                BT_VIRTIO = no;

                # repeated question
                # BRCMFMAC = yes;
                BRCMFMAC_SDIO = yes;
                BRCMFMAC_USB = yes;
                BRCMFMAC_PCIE = yes;

                WLAN_VENDOR_ADMTEK = no;
                WLAN_VENDOR_ATH = no;
                WLAN_VENDOR_INTEL = no;
                WLAN_VENDOR_INTERSIL = no;
                WLAN_VENDOR_MARVELL = no;
                WLAN_VENDOR_MEDIATEK = no;
                WLAN_VENDOR_MICROCHIP = no;
                WLAN_VENDOR_PURELIFI = no;
                WLAN_VENDOR_QUANTENNA = no;
                WLAN_VENDOR_RALINK = no;
                WLAN_VENDOR_REALTEK = no;
                WLAN_VENDOR_RSI = no;
                WLAN_VENDOR_SILABS = no;
                WLAN_VENDOR_ST = no;
                WLAN_VENDOR_TI = no;
                MAC80211_HWSIM = no;
                VIRT_WIFI = no;
                WLAN_VENDOR_ZYDAS = no;
            };
        }
        {
            name = "Unset common-config.nix options";
            patch = null;
            structuredExtraConfig = forceUnsetAll [
                "8139TOO_8129"
                "8139TOO_PIO"
                "BT_HCIUART_QCA"
                "BT_HCIUART_SERDEV"
                "BT_QCA"
                "DRAGONRISE_FF"
                "DRM_AMDGPU_CIK"
                "DRM_AMDGPU_SI"
                "DRM_AMDGPU_USERPTR"
                "DRM_AMD_ACP"
                "DRM_AMD_DC_FP"
                "DRM_AMD_DC_SI"
                "DRM_AMD_ISP"
                "DRM_AMD_SECURE_DISPLAY"
                "DRM_NOUVEAU_SVM"
                "DRM_VC4_HDMI_CEC"
                "FB_3DFX_ACCEL"
                "FB_ATY_CT"
                "FB_ATY_GX"
                "FB_NVIDIA_I2C"
                "FB_RIVA_I2C"
                "FB_SAVAGE_I2C"
                "FB_SAVAGE_ACCEL"
                "FB_SIS_300"
                "FB_SIS_315"
                "FSL_MC_UAPI_SUPPORT"
                "GREENASIA_FF"
                "HID_ACRUX_FF"
                "HOLTEK_FF"
                "HSA_AMD"
                "HSA_AMD_P2P"
                "MT798X_WMAC"
                "NET_VENDOR_MEDIATEK"
                "NVIDIA_SHIELD_FF"
                "PLAYSTATION_FF"
                "ROCKCHIP_DW_HDMI_QP"
                "ROCKCHIP_DW_MIPI_DSI2"
                "SMARTJOYPLUS_FF"
                "SONY_FF"
                "SUN8I_DE2_CCU"
                "THRUSTMASTER_FF"
                "ZEROPLUS_FF"
            ];
        }
        {
            name = "Unset other options";
            patch = null;
            structuredExtraConfig = forceUnsetAll [
                "BT_HCIUART_BCM"
                "BT_HCIUART_BCSP"
                "BT_HCIUART_H4"
                "BT_HCIUART_LL"
                "KEXEC_JUMP"
                "PARAVIRT_SPINLOCKS"
                "PCI_XEN"
                "PERF_EVENTS_AMD_BRS"
                "PREEMPT_VOLUNTARY"
                "XEN_HAVE_PVMMU"
                "XEN_MCE_LOG"
                "XEN_PVH"
                "XEN_PVHVM"
            ];
        }
        {
            name = "Option unset other options";
            patch = null;
            structuredExtraConfig = forceOptionUnsetAll [
                "ARCH_BCM2835"
                "BCM2835_MBOX"
                "BCM2835_WDT"
                "PCI_TEGRA"
                "RASPBERRYPI_FIRMWARE"
                "RASPBERRYPI_POWER"
                "SERIAL_8250_BCM2835AUX"
                "USB_XHCI_TEGRA"
            ];
        }
        # {
        #     name = "Disable random bullshit";
        #     patch = null;
        #     structuredExtraConfig = {
        #         INFINIBAND = no;
        #         GREYBUS = no;
        #         VHOST_MENU = no;
        #         # repeated question
        #         # W1 = no;
        #         W1 = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #         MEMSTICK = no;
        #         COMEDI = no;
        #         CORESIGHT = no;
        #         SOUNDWIRE = no;
        #         # IIO = no; # maybe enable this later on? (Required for speakersafetyd)
        #         # option not set correctly
        #         # SCSI = no;
        #         SCSI = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #         WWAN = no;
        #         FIREWIRE = no;
        #         ATA = no;
        #         CAN_DEV = no;
        #
        #         TEGRA_HOST1X = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #     };
        # }
        # {
        #     name = "Remove unused sounds stuff";
        #     patch = null;
        #     structuredExtraConfig = {
        #         SND_FIREWIRE = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #         SND_ISA = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #         SND_MIPS = mkForce unset; # UNSET!!!!!!!!!!!!!!!!!
        #     };
        # }
    ];
}
