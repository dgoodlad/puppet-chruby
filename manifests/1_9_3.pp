# Installs ruby 1.9.3-p392 from ruby-build and symlinks it as 1.9.3.
#
# Usage:
#
#     include ruby::1_9_3
class ruby::1_9_3 {
  require ruby
  require ruby::1_9_3_p448

  file { "${ruby::chruby_rubies}/1.9.3":
    ensure  => symlink,
    force   => true,
    target  => "${ruby::chruby_rubies}/1.9.3-p448"
  }
}
