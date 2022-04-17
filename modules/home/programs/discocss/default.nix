{ pkgs, lib, theme, config, ... }:
with lib;
let cfg = config.modules.programs.discocss;

in {
  options.modules.programs.discocss = { enable = mkEnableOption "discocss"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ discord discocss ];
    xdg.configFile."discocss/custom.css".text = with theme.colors; ''
            /**
       * @name Discord base 16 Nix theme (based on catppuccin)
       * @author sioodmy 
       * @version 0.0.1
       * @description Automatically generated theme
       * @website https://github.com/sioodmy/nixdots
       * @source https://github.com/sioodmy/nixdots
       **/


      .theme-dark {
      	--header-primary: #${fg} !important;
      	--header-secondary: #${ac} !important;
      	--background-primary: #${bg} !important;
      	--background-primary-alt: #${bg} !important;
      	--background-mobile-primary: #${bg} !important;
      	--background-secondary: #${b1} !important;
      	--background-secondary-alt: #${b1} !important;
      	--background-mobile-secondary: #${b1} !important;
      	--background-tertiary: #${b0} !important;
      	--background-floating: #${bg} !important;
      	--background-mentioned: #${ba} !important;
      	--background-mentioned-hover: #${ba} !important;
      	--background-accent: #${c0} !important;
      	--background-modifier-selected: #${bg} !important;
      	--background-modifier-accent: #${bg} !important;
      	--background-modifier-hover: #${ba} !important;
      	--text-normal: #${fg} !important;
      	--text-muted: #${c0} !important;
      	--text-link: #${c4} !important;
      	--channels-default: #${c0} !important;
      	--channeltextarea-background: #${ba} !important;
      	--activity-card-background: #${bg} !important;
      	--interactive-normal: #${fg} !important;
      	--interactive-muted: #${ba} !important;
      	--interactive-hover: #${c0} !important;
      	--interactive-active: #${ac} !important;
      	--scrollbar-thin-thumb: #${b0} !important;
      	--scrollbar-thin-track: transparent !important;
      	--scrollbar-auto-thumb: #${b0} !important;
      	--scrollbar-auto-track: #${ba}} !important;
      	--scrollbar-auto-scrollbar-color-thumb: #${b1} !important;
      	--scrollbar-auto-scrollbar-color-track: #${ba} !important;
      	--deprecated-store-bg: #${b0} !important;
      	--input-background: #${ba} !important;
      }

      body {
        font-family: monospace, monospace;
      } 
      .message-content {
        font-family: "monospace";
      }

      /* Mentions */
      .mentioned-Tre-dv .mention.interactive {
      	color: var(--white) !important;
      }

      .mentioned-Tre-dv::before {
      	background-color: var(--white) !important;
      }

      /* Home */
      .container-2cd8Mz {
      	background-color: var(--black2) !important;
      }

      /* Autocomplete popup */
      .autocomplete-3NRXG8 {
      	background-color: var(--black2) !important;
      }

      .wrapper-1NNaWG.categoryHeader-OpJ1Ly {
      	background-color: var(--black2) !important;
      }

      .autocomplete-3NRXG8 {
      	background-color: var(--black2) !important;
      }

      /* Autocomplete popup selection */
      .selected-3H3-RC {
      	background-color: var(--black3) !important;
      }

      /* Search: Items */
      .container-2McqkF {
      	background-color: var(--black0) !important;
      }

      .searchOption-351dTI:hover {
      	background-color: var(--black3) !important;
      }

      /* Search: No shadows */
      .option-ayUoaq:after {
      	background: none !important;
      }

      /* Search: in-section */
      .queryContainer-ZunrLZ {
      	background-color: var(--black0) !important;
      }

      /* Search: History */
      .option-ayUoaq:hover {
      	background-color: var(--black3) !important;
      }

      /* Search: Little Icon Thingy */
      .searchFilter-2UfsDk,
      .searchAnswer-23w-CH {
      	background-color: var(--black3) !important;
      }

      /* IN ORDER: New-Unreads-Btn,jumpToPresentBar,CTRL+K */
      .bar-2eAyLE,.jumpToPresentBar-1cEnH0,.input-3r5zZY {
      	background-color: var(--gray0) !important;
      }

      /* New Message Bar */
      .newMessagesBar-1hF-9G:before {
      	content: "";
      	position: absolute;
      	top: 0;
      	right: 0;
      	bottom: 0;
      	left: 0;
      	background: var(--gray0) !important;
      	border-radius:0 0 3px 3px;
      }

      /* New Messages Flag */
      .isUnread-3Lojb- {
      	border-color: var(--gray0) !important;
      }

      .unreadPill-3nEWYM {
      	background-color: var(--gray0) !important;
      }

      .unreadPillCapStroke-1nE1Q8 {
      	fill: var(--gray0) !important;
      	color: var(--gray0) !important;
      }

      .isUnread-3Lojb- .content-3spvdd {
      	color: var(--gray0) !important;
      }

      /* Server Modals */
      .root-g14mjS,
      .separator-2lLxgC {
      	background-color: var(--black2) !important;
      }

      .footer-31IekZ {
      	background-color: var(--black1) !important;
      }

      /* Boost Page */
      .perksModal-CLcR1c {
      	background-color: var(--black1) !important;
      }

      .tierMarkerBackground-G8FoN4 {
      	background-color: var(--black2) !important;
      }

      /* Emoji Popout */
      .popoutContainer-2wbmiM {
      	background-color: var(--black1) !important;
      }

      /* Presence Buttons */
      .lookFilled-yCfaCM.colorGrey-2iAG-B,
      .lookFilled-yCfaCM.colorPrimary-2AuQVo {
      	background-color: var(--black3) !important;
      }

      /* Primary Card */
      .cardPrimary-3qRT__ {
      	background-color: var(--black1) !important;
      }

      /* Payment Page Boxes */
      .paymentPane-ut5qKZ,
      .paginator-1eqD2g,
      .payment-2bOh4k,
      .codeRedemptionRedirect-3SBiCp {
      	background-color: var(--black1) !important;
      }

      .bottomDivider-ZmTm-j {
      	border-bottom-color: var(--black2) !important;
      }

      /* Spotify Invite */
      .invite-3uuHYQ {
      	background-color: var(--black1) !important;
      }

      /* Edit Attachment */
      .footer-VCsJQY {
      	background-color: var(--black1) !important;
      }

      /* Spoilers */
      .spoilerText-27bIiA.hidden-3B-Rum,
      .inlineContent-2YnoDy {
      	background-color: var(--black3) !important;
      }

      /* Stream Preview */
      .streamPreview-I7itZ6 {
      	background-color: var(--black2) !important;
      }

      /* Selection */
      ::-moz-selection {
      	color: var(--white) !important;
      	background: var(--black4) !important;
      }

      ::selection {
      	color: var(--white) !important;
      	background: var(--black4) !important;
      }

      /* Delete Message Confirmation */
      .message-G6O-Wv {
      	background-color: var(--black2) !important;
      	box-shadow: 0 0 0 1px hsla(var(--black3_hsl), 0.6), 0 2px 10px 0 hsla(var(--black3_hsl), 0.1) !important;
      }

      /* Command Option */
      .pill-1HLSrc,
      .optionKey-1tfFt_ {
      	background-color: var(--black2) !important;
      }

      /* Volume Slider */
      .tooltipContent-Nejnvh {
      	background-color: var(--black2) !important;
      }

      .grabber-2GQyvM {
      	background-color: var(--white) !important;
      }

      .bar-1Bhnl9 {
      	background-color: var(--gray0) !important;
      }

      .tooltipPointer-3L49xb {
      	border-top-color: var(--black2) !important;
      }

      /* Call Page */
      .tile-2TcwiO {
      	background-color: var(--black0) !important;
      }

      .button-3Vyz67 {
      	background-color: var(--black2) !important;
      }

      .buttonColor-28DXIe,
      .colorable-3rVGna.primaryDark-2UJt1G {
      	background-color: var(--black2) !important;
      }

      .emptyPreview-1SMLD4 {
      	background: var(--black0) !important;
      }

      /* Reactors List */
      .scroller-2GkvCq {
      	background: var(--black1) !important;
      }

      .reactionDefault-1Sjj1f:hover,
      .reactionSelected-1aMb2K {
      	background-color: var(--black2) !important;
      }

      .reactors-1VXca7 {
      	background-color: var(--black2) !important;
      }
          '';

    #    home.packages = [ discord-css ];
  };
}

