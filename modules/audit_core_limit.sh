# audit_core_limit
#
# When an application encounters a runtime error the operating system has the
# opportunity to dump the application’s state, including memory contents, to
# disk. This operation is called a core dump. It is possible for a core dump
# to contain sensitive information, including passwords. Therefore it is
# recommended that core dumps be disabled in high security scenarios.
#
# Refer to Section(s) 2.10 Page(s) 34-35 CIS Apple OS X 10.8 Benchmark v1.0.0
#.

audit_core_limit () {
  if [ "$os_name" = "Darwin" ]; then
    total=`expr $total + 1`
    funct_verbose_message "Core dump limits"
    if [ "$audit_mode" != 2 ]; then
      check_vale=`launchctl limit core |awk '{print $3}'`
      echo "Checking:  Core dump limits"
      if [ "$check_value" != "0" ]; then
        insecure=`expr $insecure + 1`
        echo "Warning:   Core dumps unlimited [$insecure Warnings]"
        funct_verbose_message "" fix
        funct_verbose_message "launchctl limit core 0" fix
        funct_verbose_message "" fix
        if [ "$audit_mode" = 0 ]; then
          echo "Setting:   Core dump limits"
          launchctl limit core 0
        fi
      else
        if [ "$audit_mode" = 1 ]; then
          secure=`expr $secure + 1`
          echo "Secure:    Core dump limits exist [$secure Passes]"
        fi
      fi
    else
      launchctl limit core unlimited
    fi
  fi
}
