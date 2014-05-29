# audit_grub_security
#
# GRUB is a boot loader for x86/x64 based systems that permits loading an OS
# image from any location. Oracle x86 systems support the use of a GRUB Menu
# password for the console.
# The flexibility that GRUB provides creates a security risk if its
# configuration is modified by an unauthorized user. The failsafe menu entry
# needs to be secured in the same environments that require securing the
# systems firmware to avoid unauthorized removable media boots. Setting the
# GRUB Menu password helps prevent attackers with physical access to the
# system console from booting off some external device (such as a CD-ROM or
# floppy) and subverting the security of the system.
# The actions described in this section will ensure you cannot get to failsafe
# or any of the GRUB command line options without first entering the password.
# Note that you can still boot into the default OS selection without a password.
#
# Refer to Section(s) 1.5.3 Page(s) 47-8 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 3.1 Page(s) 31-2 SLES 11 Benchmark v1.0.0
#.

audit_grub_security () {
  if [ "$os_name" = "SunOS" ] || [ "$os_name" = "Linux" ]; then
    if [ "$os_name" = "Linux" ]; then
      funct_verbose_message "Grub Menu Security"
      check_file="/etc/grub.conf"
      funct_check_perms $check_file 0600 root root
      check_file="/boot/grub/menu.lst"
      funct_check_perms $check_file 0600 root root
    fi
#  if [ "$os_version" = "10" ] || [ "$os_version" = "11" ]; then
#    check_file="/boot/grub/menu.lst"
#    grub_check=`cat $check_file |grep "^password --md5" |awk '{print $1}'`
#    if [ "$grub_check" != "password" ]; then
#      if [ "$audit_mode" = 1 ]; then
#        insecure=`expr $insecure + 1`
#        echo "Warning:   Grub password not set [$insecure Warnings]"
#      fi
#      This code needs work
#      if [ "$audit_mode" = 0 ]; then
#        echo "Setting:   Grub password"
#        if [ ! -f "$log_file" ]; then
#          echo "Saving:    File $check_file to $log_file"
#          find $check_file | cpio -pdm $work_dir 2> /dev/null
#        fi
#   echo -n "Enter password: "
#   read $password_string
#   password_string=`htpasswd -nb test $password_string |cut -f2 -d":"`
#   echo "password --md5 $password_string" >> $check_file
#   chmod 600 $check_file
#   lock_check=`cat $check_file |grep lock`
#   if [ "$lock_check" != "lock" ]; then
#     cat $check_file |sed 's,Solaris failsafe,Solaris failsafe\
#Lock,g' >> $temp_file
#     cp $temp_file $check_file
#     rm $temp_file
#   fi
#     fi
#    else
#      if [ "$audit_mode" = 1 ]; then
#        secure=`expr $secure + 1`
#        echo "Secure:    Set-UID not restricted on user mounted devices [$secure Passes]"
#      fi
#      if [ "$audit_mode" = 2 ]; then
#        restore_file="$restore_dir$check_file"
#        if [ -f "$restore_file" ]; then
#          echo "Restoring:  $restore_file to $check_file"
#          cp -p $restore_file $check_file
#          if [ "$os_version" = "10" ]; then
#            pkgchk -f -n -p $check_file 2> /dev/null
#          else
#            pkg fix `pkg search $check_file |grep pkg |awk '{print $4}'`
#          fi
#        fi
#      fi
#    fi
#  fi
  fi
}
