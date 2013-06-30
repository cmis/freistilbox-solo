desc "Start a new provisioning run"
task :prov do
  sh "vagrant provision"
end

desc "Fire up VM"
task :up do
	sh "vagrant up"
end

desc "Shut down VM"
task :down do
  sh "vagrant halt"
end

desc "Log in to VM"
task :login do
  sh "vagrant ssh"
end

desc "Install cookbooks"
task :cb do
  sh "librarian-chef install"
end

desc "Clean up everything"
task :clobber do
	sh "vagrant destroy"
	sh "rm -r cookbooks"
end
