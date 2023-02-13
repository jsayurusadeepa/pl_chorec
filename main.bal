import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

type Marks record {|
    string pl_stud_id;
    string pl_stud_name;
    float pl_student_marks;
|};

    string res = "";
	
public function main() returns error? {
	
	mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root",
                                          password = "1qaz2wsx@");
									
		check mysqlClient.close();
		
		
		mysql:Client db = check new ("localhost", "root", "1qaz2wsx@", "MARKS_STORE", 3306);
	
		http:Client pl_call = check new ("https://dc0c7b7d-7fbd-4b52-9d73-ad40481e374f-dev.e1-us-east-azure.choreoapis.dev/qvaq/ordsgeneratedapiforpl/1.0.0");
	
		map<string> headers = {"Authorization": "Bearer eyJ4NXQiOiJZV1kxTm1Sa1pHSTVNekU0T0RCbFpEUmlNV0k0WldKbE5qRXhaV1ZpWmpFek1tTm1ORFUzWVEiLCJraWQiOiJNV1E1TldVd1lXWmlNbU16WlRJek16ZG1NekJoTVdNNFlqUXlNalZoTldNNE5qaGtNR1JtTnpGbE1HSTNaRGxtWW1Rek5tRXlNemhoWWpCaU5tWmhZd19SUzI1NiIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI0ZDUyNWZkZC04N2MzLTRiOTMtODMwMy0xYjk3YTZkZWViOWYiLCJhdXQiOiJBUFBMSUNBVElPTiIsImF1ZCI6Ik5EeFNDdDBmOGdyX3ZrdzZseWQ2X3JubjM4UWEiLCJuYmYiOjE2NzYyODgxMjcsImF6cCI6Ik5EeFNDdDBmOGdyX3ZrdzZseWQ2X3JubjM4UWEiLCJzY29wZSI6ImRlZmF1bHQiLCJvcmdhbml6YXRpb24iOnsidXVpZCI6ImRjMGM3YjdkLTdmYmQtNGI1Mi05ZDczLWFkNDA0ODFlMzc0ZiJ9LCJpc3MiOiJodHRwczpcL1wvc3RzLmNob3Jlby5kZXY6NDQzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNjc2MjkxNzI3LCJpYXQiOjE2NzYyODgxMjcsImp0aSI6ImZmYjcxMTQ1LWMyNDgtNGY0Mi1hNTEyLTI5MTg2YWNlOWVhNCJ9.ooDfb6A__2QBgE7ieR4rhuD3iu8FRRG79dyBJ1HH9NjgalYdUmLsrFOfRC09M1GvDcVoBzbc5V2E10RXXNRQY4F8uI1xfhlTf_uNABMEKdiPiAgAgmJr2nhD-nST_4JpKZS7svN-6CNN5ioc2lwpwNS0edIfkLOxKT-5BWtVs5opBz6lkE9uWLP6_6LWBKHmWQ3pzw118PUp9YEoSuUoYdmZgg2XugZewlm5MQtZGwg9OGVsS-GuZkZ3hP1Cg2qJFZLcdJDijmK83bPm06uZpuxbv6tY2GGIbo6psljvAE27sASCXSxa0ScEfIDObvq3K5bxy2pgZ_moq_9TKB9cIRbn-3WvCW5nY42aFQk5TIrj79UY4ozrJqheiPnHzi_rfBzFNOXq8o4teRm0Pg3DmTvq4zW8EGlDf5B-MyeZ136fS1GhgHmiBu_va9OZ2n3M0X50VgrQOCjViIIl4GGEZFyXNdehbmhjDUA6SVgFzs0lZLyfsAab2jQ0e5p9jCvYe0kfKSJY3L3JPMoP8m2Fk1nvYIZnvivyYmloxgCDOkMfJxACk2plZ6EdsFwPTjUyYln7zPyT8lyOSzKbaOOYNa3R4L8Y-ioR6ZVJ4at0UfpfEJ6ns9bA3iAuv665_x_fqudx5V29fJOHuxYO1DojCDGpVXLylckrI29bhqXqFec"};
	
		res = check pl_call->/stud(headers);
		
		http:Client pl = check new ("http://localhost:8000");
		
		Marks[] prs = check pl->/;

		foreach var {pl_stud_id, pl_stud_name, pl_student_marks} in prs {
			_ = check db->execute(`
				INSERT INTO MARKS_STORE.STUD_MARKS_STORE (stud_id, stud_name, stud_marks)
				VALUES (${pl_stud_id}, ${pl_stud_name}, ${pl_student_marks});`);
		}
}