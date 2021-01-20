Welcome to the Made To Measure wordpress website.
The website runs on wordpress 5.2.4 on php version 7.3.9 and an apache web server.
The environment is containerised in a docker image and deployed on azure managed kubernetes.
•	Developing
•	Dependencies and Source Code
•	Live deployments
•	Maintaining
•	PHP version
•	PHP dependencies
•	Wordpress version
•	Wordpress plugins
•	Commercial wordpress plugins
•	CI and Deployment
•	Contact

Dependencies and Source Code
Here are the folders a developer is interested in:
1.	__tests__ - php unit tests.
2.	commercial-plugins - wordpress plugins that cannot be managed though composer.
3.	docker/wordpress.dockerfile - the base docker image with all the environment dependencies for the website.
4.	html/wp-content - all the custom code for the wordpress website.
5.	ci - concourse pipeline files, helm and k8s config.
6.	.htaccess - .htaccess used in the docker image.
7.	composer{.json,.lock} - composer files for managing dependencies
8.	docker-compose.yml - docker-compose manifest for local development
9.	Dockerfile - the project's docker image file
10.	robots.txt - the website's robots text file
11.	wp-config.php - the wordpress configuration file

Live deployments
This application run on kubernetes on AKS. There are three kubernetes clusters for our environments of dev, test and prod.
Deployments are handled though ci/cd pipelines on concourse with configured triggers to define which environment to deploy to.
Please read CI and Deployment for more info on deployments and ci.

Maintaining
We aim to make sure that the website is always ket secure and upto date.
It goes without saying that all updates and additions should be thoroughly checked before releasing. There are particular things that you may need to update at some point:
•	PHP version
•	PHP dependencies
•	Wordpress version
•	Wordpress plugins
•	Commercial wordpress plugins

PHP version
The php version is defined in the base docker image here. It currently uses the php image with apache.
To update the version you can update the base php image at the top of the file in ./docker/wordpress.dockerfile:
FROM php:7.3-apache
to your new image version. When your changes get merged to master a new base image will be build and deployed to the dev azure container registry.

PHP dependencies
The website requires a number of base php and server dependencies to ensure stable operation.
If you need to update any of these you can do this in the base docker image here.

Wordpress version
If you need to update the wordpress version you can do this in the base docker image here.

Wordpress plugins
We use composer to manage community plugin version by pointing it to the wpackagist registry.
Here are some useful commands when working with updating package versions (from the project root):
# list any outdates direct and transitive dependencies 
composer outdated

# Dry running an update
composer update --dry-run

# Run an update
composer update

# install a new plugin
composer install <plugin-name-from-registry>
The major versions of plugins are locked, but the composer update command can automatically increment the path and minor versions of a package. Major updates to packages will have to be explicitly defined in the composer.json file.

Commercial wordpress plugins
The commercial plugins are plugins that are not available on the wpackgist registry. They are source controlled in this repo here.
To update on of these plugins, you can download the update from the package source, delete the old version and drop it in the commercial-plugins directory.
To add a new commercial plugin drop the plugin folder in the commercial-plugins directory. After you will either need to rebuild the docker image or run this composer command from the root of the project composer run copy-commercial-plugins in the terminal.

CI and Deployment
This project uses concourse for CI/CD.
•	made-to-measure-pull-request: This pipeline is triggered when a pull-request is opened on a feature branch into the master branch. It will report back to git whether the pull-request is safe to merge.
•	configuration
•	update script
•	concourse
•	made-to-measure: This pipeline is triggered from changes on the master branch. It is the release pipeline. Read here to read about the development process of adding and releasing new features.
•	configuration
•	update script
•	concourse

Resource Links

Dev live environment
•	database
•	kubernetes cluster
•	website

Quick Links
•	Wordpress docker image
•	The base docker image used by the dockerfile in this project
•	wordpress
•	Wordpress developer documentation
•	composer
•	PHP Package Management
•	wpackagist
•	Repository for wordpress plugins for composer
•	Docker
•	Virtualisation and containerisation of applications
•	Kubernetes
•	Container orchestration
•	Concourse
•	Automation system for CI/CD
•	Fesk documentation
•	M&S technical documentation including concourse and kubernetes

Contact
Team mtm-curtains
•	Email: mtm-curtains@marks-and-spencer.com
•	Slack: #mtm-curtains

