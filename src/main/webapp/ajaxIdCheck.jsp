<%@ page import="java.sql.Connection" %>
<%@ page import="dao.ConnectionUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String emailId = request.getParameter("emailId");

    Connection connection = ConnectionUtil.INSTANCE.getConnection();
    String sql = "select * from member where emailId = ?";
     PreparedStatement preparedStatement = connection.prepareStatement(sql);
     ResultSet resultSet = null;
    preparedStatement.setString(1, emailId);
    resultSet = preparedStatement.executeQuery();
    if(resultSet.next()) {
        out.print("{\"result\":\"true\"}");
    }else {
        out.print("{\"result\":\"false\"}");
    }
    if (connection != null)connection.close();
    if (preparedStatement!= null)preparedStatement.close();
    if(resultSet != null) resultSet.close();
%>
