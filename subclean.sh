for d in `svn st | grep ^! | awk '{print $2}'`; do svn rm $d; done;
