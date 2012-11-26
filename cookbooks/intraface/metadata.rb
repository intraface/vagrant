maintainer        "Lars Olesen"
maintainer_email  "lars@intraface.dk"
license           "BSD License"
description       "Install Intraface and required dependencies."
version           "0.1"
recipe            "intraface::default", "Install required PHP dependencies"
recipe            "intraface::intraface", "Install required depedencies for Intraface"

supports 'ubuntu'