require 'spec_helper'

platforms = {
  :ubuntu => {
    :packages  => ['apache2'],
    :versions => ['10.04', '12.04']
  },
  :debian => {
    :packages  => ['apache2'],
    :versions => ['6.0.5']
  },
}

platforms.each do |platform, package_info|
  packages = package_info[:packages]
  versions = package_info[:versions]

  versions.each do |version|
    describe "On #{platform} (#{version})" do
      before do
        Fauxhai.mock('platform' => platform, 'version' => version)
      end

      # TODO: Add tests for dvwa::xampp
      let(:chef_run) { ChefSpec::ChefRunner.new.converge('dvwa::standalone')}

      packages.each do |package|
        it "installs the #{package} package" do
          expect(chef_run).to install_package(package)
        end
      end
    end
  end
end
