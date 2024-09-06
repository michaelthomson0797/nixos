{ pkgs, ... }:

{
  #programs.zsh.enable = true;

  nix.settings = {
    trusted-users = ["mthomson"];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };


  users.users.mthomson = {
    #shell = pkgs.zsh;
    isNormalUser = true;
    description = "Michael Thomson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqLd5MRSD5GdVmFOgKGRq8t/I8I9xjH2gRMmNHSqtSPYWFx8xT8uOfwyHx1um73tMg99jb4LCs+OpTaTdEyitFygxF/UdSYvAwzP+Lg4p7n6vLljmt0V1i5Zbct3oPM5CKXsUaRZkNyJxB5gJEXe/wKQ3+xj59HV3+m6uw9MO72sI5PKSFIKQFA2LTCYkA2NfO+/VtrLwopcZ+fvIutdUgmaltA3ESWCglocQ+EDXFsdO/h2KUFN6sereT+EBVPC0ePbxWpT9gHZlpeHyPPDnDuj1lUYQisTVKiaRnyFk6FyLYyxquqk+kHX0vSGD/+tBQ/+NoE/ckp2XvjrM48M3+LqtTcOi5RnTHZFuP9NgKxUQyCGOntocNVJ50puLWgr1joFUdHABo3Xjaik0np0FL5QsfYFbNxY6x94OWUxYFUu+/ZRLMWhA3qab6+FcYo4nYB+VszNYv0kE0Lo0jk9EjACoDc/omS0i5P38wvMekwkE2k54U8CkkE+zB3gXtCATE+kN9/ueOy5W4xHhvnoRmMpFza2xO3LPIVB8mVTUiBRfwgz2+psb/AHQwsmORS9BzfA8QdaM1kbbmZo1F1iw8+m1ZCatos2xkcWgMwKfiT2224hZ7DsM+DAZ4IYQzxT7OBYknh7lX3kQeeficqF3Dlg2QLuAlOdnDqb2xyCSDyQ== mthomson"
    ];
  };
}
