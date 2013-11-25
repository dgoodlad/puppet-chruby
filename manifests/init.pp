# Class: ruby
#
# This module installs a full chruby-driven ruby stack
#
class ruby(
  $default_gems      = $ruby::params::default_gems,
  $chruby_version    = $ruby::params::chruby_version,
  $chruby_root       = $ruby::params::chruby_root,
  $chruby_rubies     = $ruby::params::chruby_rubies,
  $rubybuild_version = $ruby::params::rubybuild_version,
  $user              = $ruby::params::user
) inherits ruby::params {

  if $::osfamily == 'Darwin' {
    include boxen::config

    file { "${boxen::config::envdir}/chruby.sh":
      source => 'puppet:///modules/ruby/chruby.sh' ;
    }
  }

  file { $chruby_root:
    ensure => 'directory',
    owner  => $user,
  }

  exec { 'create rubies directory':
    # puppet does not create directories recursively when ensuring existence
    # with a 'file' resource, so we need to shell out to mkdir -p instead
    command => "mkdir -p ${chruby_rubies}",
    creates => $chruby_rubies,
  }

  file { $chruby_rubies:
    ensure => 'directory',
    owner  => $user,
  }

  Exec['create rubies directory'] -> File[$chruby_rubies]

  $source_url = "https://github.com/postmodern/chruby/archive/v${chruby_version}.tar.gz"

  exec { "install chruby ${chruby_version}":
    command     => "curl -L ${source_url} | tar zx && (cd chruby-${chruby_version} && make install)",
    cwd         => '/tmp',
    environment => [
      "PREFIX=${chruby_root}",
    ],
    logoutput   => 'on_failure',
    creates     => "${chruby_root}/share/doc/chruby-${chruby_version}",
    require     => File[$chruby_root],
  }

  repository { "${chruby_root}/ruby-build":
    ensure  => $rubybuild_version,
    source  => 'sstephenson/ruby-build',
    user    => $user,
    require => File[$chruby_root],
  }

  # TODO inject ruby-build into this chain
  Exec["install chruby ${chruby_version}"] ->
    File[$chruby_rubies] ->
    Ruby::Definition <| |> ->
    Ruby::Version <| |>
}
