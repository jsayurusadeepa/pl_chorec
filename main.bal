import ballerina/http;
import ballerinax/mysql;
import ballerina/io;
import ballerinax/mysql.driver as _;

string pl_stud_id = "";
string pl_stud_name = "";
float pl_student_marks = 0.0;

type Mark record {
string pl_stud_id;
string pl_stud_name;
float pl_student_marks;
};

public function main() returns error? {
		
		http:Client clientEndpoint = check new("https://rasubk1xpcqj5ta-p1ky6uccg1hmqavx.adb.ap-mumbai-1.oraclecloudapps.com/ords/pl_stud/pl_stud");
		
		Mark m = check clientEndpoint->get("/get_stud");
		
		pl_stud_id = m["pl_stud_id"];
		pl_stud_name = m["pl_stud_name"];
		pl_student_marks = m["pl_student_marks"];
		
		io:println(pl_stud_id);
		io:println(pl_stud_name);
		io:println(pl_student_marks);
		
		mysql:Client db = check new ("localhost", "root", "1qaz2wsx@", "MARKS_STORE", 3306);
		
        _ = check db->execute(`
            INSERT INTO MARKS_STORE.STUD_MARKS_STORE (stud_id, stud_name, stud_marks)
            VALUES (${pl_stud_id}, ${pl_stud_name}, ${pl_student_marks});`);

}