import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

type Marks record {|
    int pl_stud_id;
    string pl_stud_name;
    float pl_student_marks;
|};

type Res record {|
    string res;
|};

public function main() returns error? {
	
	mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "1qaz2wsx@");
									
		check mysqlClient.close();
		
		mysql:Client db = check new ("localhost", "root", "1qaz2wsx@", "MARKS_STORE", 3306);
		
		http:Client pl = check new ("http://localhost:8000");
		
		Marks[] prs = check pl->/;

		foreach var {pl_stud_id, pl_stud_name, pl_student_marks} in prs {
			_ = check db->execute(`
				INSERT INTO MARKS_STORE.STUD_MARKS_STORE (stud_id, stud_name, stud_marks)
				VALUES (${pl_stud_id}, ${pl_stud_name}, ${pl_student_marks});`);
		}
}
