# Installs ruby 2.0.0-p247 from ruby-build and symlinks it as 2.0.0.
#
# Usage:
#
#     include ruby::2_0_0
class ruby::2_0_0 {
  require ruby
  require ruby::2_0_0_p247

  file { "${ruby::chruby_rubies}/2.0.0":
    ensure  => symlink,
    force   => true,
    target  => "${ruby::chruby_rubies}/2.0.0-p247"
  }
}

