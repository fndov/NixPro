/* 
  NixPro-ISO Home Manager
  - All modules must fit within available RAM
  - Avoid heavy modules like user\software\apps\collection.nix
  - Keep system packages minimal
  - Consider compression settings carefully 
*/
{ pkgs, settings, ... }: {
  imports = [ /* Home-Manager */
    ../../user/software/commands/sh.nix        
    ../../user/software/commands/cli.nix       
    ../../user/software/commands/lib.nix
    (../.. + "/user/software/apps/terminal"+("/"+settings.user.terminal)+".nix") 
    (../.. + "/user/software/apps/browser"+("/"+settings.user.browser)+".nix") 
    /*
      ../../user/software/apps/collection.nix     
      ../../user/software/apps/spotify.nix        
      ../../user/software/development/android.nix  
      ../../user/software/development/c.nix      
      ../../user/software/development/cc.nix       
      ../../user/software/development/hs.nix       
      ../../user/software/development/rs.nix       
      ../../user/software/development/py-pkgs.nix   
      ../../user/software/development/go.nix        
      ../../user/software/development/zig.nix 
    */
  ];
}
