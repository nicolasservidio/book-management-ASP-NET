<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="Parcial_ISSDTP4_2025_Servidio.Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Módulos</h3>
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Libros.aspx">🗃️ Libros</asp:HyperLink> <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LibroGeneros.aspx">📕 Géneros literarios</asp:HyperLink> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/LibroAutores.aspx">✍️ Autores literarios</asp:HyperLink>

            <br /><br /> <br /> <br /> 
            <footer>
              <p>&copy; 2025 Nicolás Servidio - Mi Sitio Web. Todos los derechos reservados.</p>
              <p><a href="https://linkedin.com/in/nicolas-servidio-del-monte">Contactame</a> | <a href="#">Política de Privacidad</a></p>
            </footer>
        </div>
    </form>
</body>
</html>
