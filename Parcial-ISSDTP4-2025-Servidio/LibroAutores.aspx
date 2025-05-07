<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibroAutores.aspx.cs" Inherits="Parcial_ISSDTP4_2025_Servidio.LibroAutores" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2 style="color: royalblue;">Autores</h2>
            <h4>ALTA</h4>
            Nombre <asp:TextBox ID="TextBox1" runat="server" ToolTip="Cargar nombre de autor" onkeyup="filtrarTablaPorNombre()"></asp:TextBox> <br />
            Apellido <asp:TextBox ID="TextBox2" runat="server" ToolTip="Cargar apellido de autor" onkeyup="filtrarTablaPorApellido()"></asp:TextBox>
            <br /> <br />
            <asp:Button ID="Button1" runat="server" Text="Alta" Width="111px" OnClick="Button1_Click" BackColor="#B32D00" ForeColor="White" />
            <asp:Label ID="Label1" runat="server" Text=" "></asp:Label>

            <br />
            <br />
            <br />

            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="id" HeaderText="ID del Autor" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="apellido" HeaderText="Apellido" SortExpression="apellido" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre" />
                    <asp:BoundField DataField="cantidad_libros" HeaderText="Cantidad de libros" SortExpression="cantidad_libros" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" DeleteCommand="DELETE FROM [LibroAutores] WHERE [id] = @id" InsertCommand="INSERT INTO [LibroAutores] ([apellido], [nombre]) VALUES (@apellido, @nombre)" SelectCommand="SELECT LA.id, LA.apellido, LA.nombre, COUNT(L.id) AS cantidad_libros FROM LibroAutores LA LEFT JOIN Libros L ON LA.id = L.idAutor GROUP BY LA.id, LA.apellido, LA.nombre; " UpdateCommand="UPDATE [LibroAutores] SET [apellido] = @apellido, [nombre] = @nombre WHERE [id] = @id" OnDeleting="SqlDataSource1_Deleting" OnUpdating="SqlDataSource1_Updating">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="apellido" Type="String" />
                    <asp:Parameter Name="nombre" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="apellido" Type="String" />
                    <asp:Parameter Name="nombre" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <!-- FILTROS ! -->
            <br />
            <h4>Filtro por apellido</h4>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource2" DataTextField="apellido" DataValueField="id"></asp:DropDownList>
            <br />
            <asp:Button ID="Button2" runat="server" BackColor="Yellow" Text="Filtrar" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" BackColor="#FF6600" Text="Desfiltrar" OnClick="Button3_Click" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [LibroAutores]"></asp:SqlDataSource>


            <br />
            <br />
            <br />
            <h3>Otros módulos</h3>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Libros.aspx">🗃️ Libros </asp:HyperLink> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/LibroGeneros.aspx">📕 Géneros literarios</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Menu.aspx">⚜️ Volver al Menú principal</asp:HyperLink>

            <br /><br /><br />
            <footer>
              <p>&copy; 2025 Nicolás Servidio - Mi Sitio Web. Todos los derechos reservados. </p>
              <p><a href="https://linkedin.com/in/nicolas-servidio-del-monte">Contactame</a> | <a href="#">Política de Privacidad</a></p>
            </footer>

        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>

        function filtrarTablaPorNombre() {

            let filtro = document.getElementById('TextBox1').value.toLowerCase();
            let tabla = document.getElementById('GridView1');
            let filas = tabla.getElementsByTagName('tr');
            for (var i = 1; i < filas.length; i++) {
                var fila = filas[i];
                var celdas = fila.getElementsByTagName('td');
                var mostrarFila = false;
                for (var j = 0; j < celdas.length; j++) {
                    var celda = celdas[j];
                    if (celda) {
                        var contenido = celda.textContent || celda.innerText;
                        if (contenido.toLowerCase().indexOf(filtro) > -1) {
                            mostrarFila = true;
                            break;
                        }
                    }
                }
                fila.style.display = mostrarFila ? '' : 'none';
            }
        }

        function filtrarTablaPorApellido() {

            let filtro = document.getElementById('TextBox2').value.toLowerCase();
            let tabla = document.getElementById('GridView1');
            let filas = tabla.getElementsByTagName('tr');
            for (var i = 1; i < filas.length; i++) {
                var fila = filas[i];
                var celdas = fila.getElementsByTagName('td');
                var mostrarFila = false;
                for (var j = 0; j < celdas.length; j++) {
                    var celda = celdas[j];
                    if (celda) {
                        var contenido = celda.textContent || celda.innerText;
                        if (contenido.toLowerCase().indexOf(filtro) > -1) {
                            mostrarFila = true;
                            break;
                        }
                    }
                }
                fila.style.display = mostrarFila ? '' : 'none';
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            $(".js-example-basic-single").select2({
                placeholder: 'Select an option'
            });
        });

    </script>
</body>
</html>
