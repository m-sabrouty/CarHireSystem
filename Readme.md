# README

* python version 3.6

* System dependencies Mysql db ,Flask,flask_mysqldb

*sql files
1-All tables are seperated in files having table name as the file name
2-It is assuemed we have python script to send confirmation letters to customers called by a bash file in a cron task.
3-check_availablity procedure is assumed to be called from a route that searches for specific available car in app.
4-It is assumed according to task that each booking has one vehicle.
5-for creating database and tables once we assume a bash script calling sql files.
6-Availability table represents current availabilty of all cars and it is assumed to be initalized and populated at DB initialization. 

