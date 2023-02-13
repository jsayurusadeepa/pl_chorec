import ballerinax/mysql;
import ballerinax/mysql.driver as _;

public function main() returns error?{

	mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "1qaz2wsx@");
										  
	_ = check mysqlClient->execute(`CREATE DATABASE MARKS_STORE;`);
		
	_ = check mysqlClient->execute(`CREATE TABLE MARKS_STORE.STUD_MARKS_STORE (
											stud_id VARCHAR(10),
											stud_name VARCHAR(50),
											stud_marks REAL
                                    );`);
									
	check mysqlClient.close();

}
