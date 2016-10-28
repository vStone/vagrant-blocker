# Vagrant::Blocker

Block certain VMs from running together in a multi-VM vagrant setup.

## Installation

    vagrant plugin install vagrant-blocker

## Usage

This plugin can be used to make sure certain machines can not be run together:
When bringing a machine up, an error will be thrown whenever a box that blocks
or is blocked by an already running machine.

```ruby
  config.vm.define 'foo' do |vm|
    vm.blocker.blocks = 'bar'
  end
  config.vm.define 'bar'
```

By default, if a non-existant machine is configured in the blockers, an error
will be thrown. You can disable this behaviour by setting strict_config to `false`:

```ruby
  config.blocker.strict_config = false

  config.vm.define 'strict' do |vm|
    vm.blocker.strict_config = true
    vm.blocker.blocks = %w(foo nonexistant)
  end

  config.vm.define 'foo'
```

## Testing

1. Clone it
2. Ensure you have the correct bundler version (by using RVM).

  ```
  echo 'vagrant-blocker' > .ruby-gemset
  echo '2.3.1' > .ruby-version
  rvm --create use `cat .ruby-version`@`cat .ruby-gemset`
  gem update --system
  gem install bundler --version 1.12.5
  ```

2. Run `bundle install`
3. You can use vagrant like you are used to with `bundle exec vagrant <command>`.
   An example Vagrantfile can be found in the test folder.

## Contributing

1. Fork it ( https://github.com/vStone/vagrant-blocker )
2. Create a new feature branch
3. Commit
4. Push to your remote
5. Create a new Pull Request
