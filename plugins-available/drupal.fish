# drupal thingy
function drush-compose --description 'Install new module for Drupal8 using composer and enable with drush'
	set --unexport --local __BASE  (git rev-parse --show-toplevel)
	cd $__BASE
	composer require drupal/$argv
	cd -
	drush en $argv -y; drush cr
end

function drush --description 'Per project drush'
	set --unexport --local __BASE  (git rev-parse --show-toplevel)
	set --unexport --local _drush $__BASE/vendor/bin/drush
	set --unexport --local __WEB $__BASE/web
	cd $__WEB;
	eval $_drush $argv;
	cd -;
end