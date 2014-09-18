   <%--
    Copyright (C) 2010  GARC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
  --%>
<%-- 
    Document   : email
    Created on : Aug 21, 2009, 11:06:03 AM
    Author     : Ramkumar
--%>
<%@ page  import="java.util.Properties,javax.mail.Message,javax.mail.MessagingException,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeMessage" %>
<%@ include file="mailConfig.jsp" %>
<%
    String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    String to = "president@reboot09.info"; // out going email id
    String from = user; //Email id of the recipient
    String subject = "Newsletter GARC";
    String messageText = "<b>Ass hole</b>";
    boolean sessionDebug = true;
    boolean WasEmailSent=true;
    Properties props = System.getProperties();
    props.setProperty("mail.transport.protocol", "smtp");
    props.setProperty("mail.host", host);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "465");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class",
    "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.socketFactory.fallback", "false");
    props.setProperty("mail.smtp.quitwait", "false");
    Session mailSession = Session.getDefaultInstance(props, null);
    mailSession.setDebug(sessionDebug);
    Message msg = new MimeMessage(mailSession);
    msg.setFrom(new InternetAddress(from));
    InternetAddress[] address = {new InternetAddress(to)};
    msg.setRecipients(Message.RecipientType.TO, address);
    msg.setSubject(subject);
    msg.setContent(messageText, "text/html"); // use setText if you want to send text
    Transport transport = mailSession.getTransport("smtp");
    transport.connect(host, user, pass);
    try {
    transport.sendMessage(msg, msg.getAllRecipients());
    WasEmailSent = true; // assume it was sent
    }
    catch (Exception err) {
    WasEmailSent = false; // assume it's a fail
    }
    transport.close();
    out.print(WasEmailSent);

%>