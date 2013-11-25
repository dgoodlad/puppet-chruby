# Public: Configuration values for ruby
class ruby::params {
  case $::osfamily {
    'Darwin': {
      include boxen::config

      $chruby_root   = "${boxen::config::home}/chruby"
      # If you change this you're going to have a bad time, because chruby sets
      # $RUBIES by default to include all the directories in $PREFIX/opt/rubies
      $chruby_rubies = "${chruby_root}/opt/rubies"
      $user          = $::boxen_user
    }

    default: {
      $chruby_root   = '/usr/local/share/chruby'
      $chruby_rubies = '/opt/rubies'
      $user          = 'root'
    }
  }

  $chruby_version = '0.3.7'

  $default_gems = ['bundler ~>1.3']

  $rubybuild_version = 'v20131122.1'
}
