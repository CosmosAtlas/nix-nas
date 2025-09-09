{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/mnt/drives/disk-16t-5b113a07" = { 
    device = "/dev/disk/by-uuid/5b113a07-9ad1-4660-8ffa-c2f0572546d0";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-4t-88769c7b" = {
    device = "/dev/disk/by-uuid/88769c7b-ffd0-4f74-8a34-cb153ef6c729";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-8t-67752f4f" = {
    device = "/dev/disk/by-uuid/67752f4f-3065-4419-8873-86f3aff7fe02";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-8t-faf54a36" = {
    device = "/dev/disk/by-uuid/faf54a36-03b6-4549-9429-3cd085863357";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-14t-f69b4d14" = {
    device = "/dev/disk/by-uuid/f69b4d14-87ff-45a3-b8ee-d77e39ba7163";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-14t-03105900" = {
    device = "/dev/disk/by-uuid/03105f00-c431-4c41-a92a-2623bf725c4a";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-14t-ddc2e295" = {
    device = "/dev/disk/by-uuid/ddc2e295-3f8f-4940-92ad-089d75c9458c";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-14t-b29daf5a" = {
    device = "/dev/disk/by-uuid/b29daf5a-7302-4528-8b3f-93a2ed9b6650";
    fsType = "ext4";
  };

  fileSystems."/mnt/drives/disk-2t-7C1085E5" = {
    device = "/dev/disk/by-uuid/7C1085E51085A6AC";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=100" ];
  };

  fileSystems."/mnt/drives/disk-1t-604484AA" = {
    device = "/dev/disk/by-uuid/604484AA4484850E";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=100" ];
  };

  fileSystems."/mnt/drives/nvme-disk-1t-704b0b83" = {
    device = "/dev/disk/by-uuid/704b0b83-b70f-43d6-9934-16a1627c67d5";
    fsType = "ext4";
  };

  fileSystems."/mnt/jbod" = {
    device = "/mnt/drives/disk-*/Share:/mnt/drives/disk-4t-88769c7b/";
    fsType = "mergerfs";
    options = [ "defaults" "allow_other" "use_ino" "minfreespace=20G" "category.create=epmfs"];
    neededForBoot = false;
    depends = [
      "/mnt/drives/disk-16t-5b113a07"
      "/mnt/drives/disk-8t-67752f4f"
      "/mnt/drives/disk-8t-faf54a36"
      "/mnt/drives/disk-14t-f69b4d14"
      "/mnt/drives/disk-14t-03105900"
      "/mnt/drives/disk-14t-ddc2e295"
      "/mnt/drives/disk-14t-b29daf5a"
    ];
  };
}
