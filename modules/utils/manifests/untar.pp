# Unpacks a compressed TAR archive.
# Parameters:
#   $file:  name of the file to unpack
#   $cwd:   Working directory for the command.
#
# $title is used as the name of the directory that is created by extracting the
# files, relative to $cwd.
#
define utils::untar($file, $cwd) {
  exec { "untar_${title}":
    path => '/bin:/usr/bin',
    cwd => $cwd,
    command => "tar xfz ${file}",
    creates => "${cwd}/${title}",
  }
}

