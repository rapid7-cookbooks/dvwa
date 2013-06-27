require 'berkshelf'
require 'chefspec'

berksfile = Berkshelf::Berksfile.from_file('Berksfile')
berksfile.install(path: 'vendor/cookbooks')
