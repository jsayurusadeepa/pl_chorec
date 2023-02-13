import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

type Marks record {|
    string pl_stud_id;
    string pl_stud_name;
    float pl_student_marks;
|};

service / on new http:Listener(8081) {
    private final mysql:Client db;

    function init() returns error? {
		mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "1qaz2wsx@");
									
		check mysqlClient.close();
		
		
		self.db = check new ("localhost", "root", "1qaz2wsx@", "MARKS_STORE", 3306);
    }
	
	

    resource function post marks(@http:Payload Marks marks) returns string|error {
        _ = check self.db->execute(`
            INSERT INTO MARKS_STORE.STUD_MARKS_STORE (stud_id, stud_name, stud_marks)
            VALUES (${marks.pl_stud_id}, ${marks.pl_stud_name}, ${marks.pl_student_marks});`);
        return "OK";
    }
}
