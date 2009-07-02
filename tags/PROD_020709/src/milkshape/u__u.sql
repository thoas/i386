drop database if exists gobelins_project;
create database gobelins_project character set utf8 collate utf8_general_ci;
GRANT ALL ON gobelins_project.* TO gobelins_project@localhost IDENTIFIED BY 'gobelinsrocks';
FLUSH PRIVILEGES;