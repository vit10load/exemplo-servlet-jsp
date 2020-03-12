<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <form method="POST">
            <label for=""nome>Nome:</label>
            <%
                String acao = (String) application.getAttribute("acao");

                if (acao == null) {

                    acao = "";
                }

                if (request.getParameter("acaoEditar") != null && request.getParameter("acaoEditar").equals("update")) {

                    acao = "update";
                }

                if (request.getMethod().equals("POST")
                        && acao.equals("update")) {
            %>
            <input type="text" name="nomeEditar" value="<%=request.getParameter("nomeEditar")%>"/>
            <input type="hidden" name="acao" value="<%=request.getParameter("acaoEditar")%>" />
            <input type="hidden" name="index" value="<%=request.getParameter("index")%>" />

            <% } else { %>

            <input type="text" name="nome" value=""/>
            <input type="hidden" name="acao" value="add" />

            <% } %>

            <button type="submit">Add</button>
        </form>

        <table>

            <%

                List<String> nomes = (List) application.getAttribute("nomes");

                if (nomes == null) {

                    nomes = new ArrayList();
                }
                
                if(request.getParameter("acao") != null){
             
                    if (request.getMethod().equals("POST") && request.getParameter("acao").equals("add")) {

                        nomes.add(request.getParameter("nome"));

                        application.setAttribute("nomes", nomes);

                    }

                    if (request.getMethod().equals("POST")&& request.getParameter("acao").equals("remove")) {

                        nomes.remove(Integer.parseInt(request.getParameter("index")));

                    }
                
                       
                }

                if(request.getParameter("acao") != null){
                
                    if (request.getMethod().equals("POST") && request.getParameter("acao").equals("update")) {

                        nomes.add(Integer.parseInt(request.getParameter("index")),
                                request.getParameter("nomeEditar"));
                        nomes.remove(Integer.parseInt(request.getParameter("index")) + 1);

                        application.setAttribute("acao", "add");

                    }
                
                }


            %>

            <thead>
            <th>Nome</th>
            <th>Remove</th>
            <th>Update</th>
        </thead>

        <tbody>

            <%         for (int i = 0; i < nomes.size(); i++) {
            %>
            <tr>
                <td>
                    <%=nomes.get(i)%>
                </td>
                <td>
                    <form method="POST">
                        <input type="hidden" name="index" value="<%=i%>"/>
                        <input type="hidden" name="acao" value="remove"/>
                        <button type="submit">Remove</button>
                    </form>

                </td>
                <td>
                    <form method="POST">
                        <input type="hidden" name="nomeEditar" value="<%=nomes.get(i)%>"/>
                        <input type="hidden" name="index" value="<%=i%>"/>
                        <input type="hidden" name="acaoEditar" value="update"/>
                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </tbody>
    </table>

</body>
</html>
