<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="/email/send.do">
	발신자 : <input name="senderName"><br/>
	발신자 메일: <input name="senderMail"><br/>
	수신자 메일: <input name="receiveMail"><br/>
	제목: <input name="subject"><br/>
	내용: <textarea name="message"></textarea>
	<br/>
	<input type="submit" value="전송">
</form>
</body>
</html>