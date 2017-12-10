<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: chenny
  Date: 2017/10/3
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%=application.getResource("/").getPath() %><br/>
<%=application.getResource(".").getPath() %><br/>
<%=application.getResource(".").getPath() %><br/>
<%=new File(".").getAbsolutePath() %><br/>
<%=new File("/").getAbsolutePath() %><br/>