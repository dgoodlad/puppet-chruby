Puppet::Type.newtype(:chruby_gem) do
  @doc = ""

  ensurable do
    newvalue :present do
      provider.create
    end

    newvalue :absent do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name) do
    isnamevar
  end

  newparam(:gem) do
  end

  newparam(:chruby_version) do
  end

  newparam(:version) do
    defaultto '>= 0'
  end

  newparam(:chruby_root) do
  end

  newparam(:chruby_rubies) do
  end

  autorequire(:exec) do
    "ruby-build-#{self[:rbenv_version]}"
  end
end
