#After deploying the infrastructure log in to one of the EC2 web instances and run the below command ( you need to be in / directory ) in order to load the database file in the RDS instance.

#Keep in mind that the FQDN provided for the RDS instance would be different if deployed in another region. Also, you need to set up a db_password in variables.tf (you will need to specify this password in the db_setup.sql as well)

mysql -v --skip-ssl -u user -p<db_password> -h web-rds.cpywdanzbdov.eu-west-1.rds.amazonaws.com < web-app/db/db_setup.sql
