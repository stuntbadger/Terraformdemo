resource "aws_instance" "phpapp" {
 ami = "${lookup(var.AmiLinux, var.region)}"
 instance_type = "t2.micro"
 associate_public_ip_address = "true"
 subnet_id = "${aws_subnet.PublicAZA.id}"
 vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"] key_name = "${var.key_name}"
 tags {
 Name = "phpapp"
 }
 user_data = <<HEREDOC
#!/bin/bash
yum update -y
yum install -y httpd24 php56 php56-mysqlnd
service httpd start
chkconfig httpd on
echo "<?php" >> /var/www/html/index.php
echo "\$conn = new mysqli('mydatabase.jpenney.internal', 'root', 'secret', 'test');" >> /var/www/html/index.php
echo "\$sql = 'SELECT * FROM mytable'; " >> /var/www/html/index.php
echo "\$result = \$conn->query(\$sql); " >> /var/www/html/index.php
echo "while(\$row = \$result->fetch_assoc()) { echo 'Comment : ' . \$row['mycol'] .\"<BR>\" ;} " >> /var/www/html/index.php
echo "\$conn->close(); " >> /var/www/html/index.php
echo "?>" >> /var/www/html/index.php
echo "<a href=\"add.php\">Add a comment</a>">> /var/www/html/index.php
echo "<html>" >>/var/www/html/insert.php
echo "<body>" >>/var/www/html/insert.php
echo "<?php" >>/var/www/html/insert.php
echo "\$con = mysql_connect(\"mydatabase.jpenney.internal\",\"root\",\"secret\");" >>/var/www/html/insert.php
echo "if (!\$con)" >>/var/www/html/insert.php
echo "  {" >>/var/www/html/insert.php
echo "  die('Could not connect: ' . mysql_error());" >>/var/www/html/insert.php
echo "  }" >>/var/www/html/insert.php
echo "mysql_select_db(\"test\", \$con);" >>/var/www/html/insert.php
echo "\$sql=\"INSERT INTO mytable (mycol) " >>/var/www/html/insert.php
echo "VALUES" >>/var/www/html/insert.php
echo "('\$_POST[comment1]')\";" >>/var/www/html/insert.php
echo "if (!mysql_query(\$sql,\$con))" >>/var/www/html/insert.php
echo "  {" >>/var/www/html/insert.php
echo "  die('Error: ' . mysql_error());" >>/var/www/html/insert.php
echo "  }" >>/var/www/html/insert.php
echo " echo \"" >>/var/www/html/insert.php
echo "<!DOCTYPE html>" >>/var/www/html/insert.php
echo "<script>" >>/var/www/html/insert.php
echo "function redir()" >>/var/www/html/insert.php
echo "{" >>/var/www/html/insert.php
echo "alert('record added..');" >>/var/www/html/insert.php
echo "window.location.assign('index.php');" >>/var/www/html/insert.php
echo "}" >>/var/www/html/insert.php
echo "</script>" >>/var/www/html/insert.php
echo "<body onload='redir();'></body>\";" >>/var/www/html/insert.php
echo "<a href=\"index.php\">Back to Home page </a>">> /var/www/html/index.php
echo "mysql_close($con)" >>/var/www/html/insert.php
echo "?>" >>/var/www/html/insert.php
echo "</body>" >>/var/www/html/insert.php
echo "</html>" >>/var/www/html/insert.php
echo "<html>" >>/var/www/html/add.php
echo "<body>" >>/var/www/html/add.php
echo "<p>enter a comment :</p>" >>/var/www/html/add.php
echo "<form action=\"insert.php\" method=\"post\">" >>/var/www/html/add.php
echo "Comment: <input type=\"text\" name=\"comment1\" /><br><br>" >>/var/www/html/add.php
echo "<input type=\"submit\" />" >>/var/www/html/add.php
echo "</form>" >>/var/www/html/add.php
echo "</body>" >>/var/www/html/add.php
echo "</html>" >>/var/www/html/add.php
HEREDOC
}

resource "aws_instance" "database" {
 ami = "${lookup(var.AmiLinux, var.region)}"
 instance_type = "t2.micro"
 associate_public_ip_address = "false"
 subnet_id = "${aws_subnet.PrivateAZA.id}"
 vpc_security_group_ids = ["${aws_security_group.Database.id}"] key_name = "${var.key_name}"
 tags {
 Name = "database"
 }
 user_data = <<HEREDOC
#!/bin/bash
yum update -y
yum install -y mysql55-server
service mysqld start
/usr/bin/mysqladmin -u root password 'secret'
mysql -u root -psecret -e "create user 'root'@'%' identified by 'secret';" mysql
mysql -u root -psecret -e 'CREATE TABLE mytable (mycol varchar(255));' test
mysql -u root -psecret -e "INSERT INTO mytable (mycol) values ('The first comment !') ;" test
HEREDOC
}
