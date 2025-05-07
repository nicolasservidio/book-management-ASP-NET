<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibroGeneros.aspx.cs" Inherits="Parcial_ISSDTP4_2025_Servidio.LibroGeneros" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2 style="color: royalblue;">Géneros</h2>
            <h4>ALTA</h4>
            Género (descripción):  <br />
            <asp:TextBox ID="TextBox1" runat="server" ToolTip="Cargar género nuevo" onkeyup="filtrarTabla()"></asp:TextBox>
            <br /> <br />
            <asp:Button ID="Button1" runat="server" Text="Alta" Width="125px" OnClick="Button1_Click" BackColor="#297A6F" ForeColor="White" />
            <asp:Label ID="Label1" runat="server" Text=" "></asp:Label>

            <br />
            <br />
            <br />

            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="id" HeaderText="ID del Género" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" SortExpression="descripcion" />
                    <asp:BoundField DataField="cantidad_libros" HeaderText="Cantidad de libros" SortExpression="cantidad_libros" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" DeleteCommand="DELETE FROM [LibroGeneros] WHERE [id] = @id" InsertCommand="INSERT INTO [LibroGeneros] ([descripcion]) VALUES (@descripcion)" SelectCommand="SELECT LG.id, LG.descripcion, COUNT(L.id) AS cantidad_libros FROM LibroGeneros LG LEFT JOIN Libros L ON LG.id = L.idGenero GROUP BY LG.id, LG.descripcion; " UpdateCommand="UPDATE [LibroGeneros] SET [descripcion] = @descripcion WHERE [id] = @id" OnDeleting="SqlDataSource1_Deleting" OnUpdating="SqlDataSource1_Updating">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="descripcion" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="descripcion" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <!-- FILTROS ! -->

            <br />
            <h4>FILTROS</h4>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource2" DataTextField="descripcion" DataValueField="id"></asp:DropDownList>
            <br />
            <asp:Button ID="Button2" runat="server" Text="Filtrar" BackColor="Yellow" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" Text="Desfiltrar" BackColor="#FF6600" OnClick="Button3_Click" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [LibroGeneros]"></asp:SqlDataSource>

            <br />
            <br />
            <br />
            <h3>Otros módulos</h3>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Libros.aspx">🗃️ Libros </asp:HyperLink> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/LibroAutores.aspx">✍️ Autores literarios</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Menu.aspx">⚜️ Volver al Menú principal</asp:HyperLink>

            <br /><br /> <br />
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

        function filtrarTabla() {

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

        document.addEventListener("DOMContentLoaded", function () {
            $(".js-example-basic-single").select2({
                placeholder: 'Select an option'
            });
        });

    </script>
</body>
</html>
