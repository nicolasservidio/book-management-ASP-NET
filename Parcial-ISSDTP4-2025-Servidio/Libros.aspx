<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libros.aspx.cs" Inherits="Parcial_ISSDTP4_2025_Servidio.Libros" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2 style="color: royalblue;">Libros</h2>
            <h4>ALTA</h4>
            Título:  <br />
            <asp:TextBox ID="TextBox1" runat="server" ToolTip="Cargar el libro" onkeyup="filtrarTabla()" ></asp:TextBox>
            <br />
            <br />
            Género: <br />
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource2" DataTextField="descripcion" DataValueField="id"></asp:DropDownList>
            <br /> <br /> 
            Autor: <br />
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource3" DataTextField="apellido" DataValueField="id" AutoPostBack="true" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
            <asp:Label ID="Label2" runat="server" Text=" "></asp:Label>
            <br /> <br /> 
            <asp:Button ID="Button1" runat="server" Text="Alta" Width="123px" BackColor="#82D7FF" OnClick="Button1_Click" />
            <asp:Label ID="Label1" runat="server" Text=" "></asp:Label>


            <br />
            <br />
            <br />

            <h5> Tabla </h5>
            <asp:Table ID="Table1" runat="server" CssClass="estiloTabla"></asp:Table>
            <!-- SQLDataSource para la tabla Libros -->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT Libros.id, Libros.titulo, Libros.idGenero, Libros.idAutor, LibroGeneros.descripcion, LibroAutores.apellido, LibroAutores.nombre FROM Libros INNER JOIN LibroGeneros ON Libros.idGenero = LibroGeneros.id INNER JOIN LibroAutores ON Libros.idAutor = LibroAutores.id" DeleteCommand="DELETE FROM [Libros] WHERE [id] = @id" InsertCommand="INSERT INTO [Libros] ([titulo], [idGenero], [idAutor]) VALUES (@titulo, @idGenero, @idAutor)" UpdateCommand="UPDATE [Libros] SET [titulo] = @titulo, [idGenero] = @idGenero, [idAutor] = @idAutor WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="titulo" Type="String" />
                    <asp:Parameter Name="idGenero" Type="Int32" />
                    <asp:Parameter Name="idAutor" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="titulo" Type="String" />
                    <asp:Parameter Name="idGenero" Type="Int32" />
                    <asp:Parameter Name="idAutor" Type="Int32" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <!-- SQLDataSource para la tabla de genéros -->
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [LibroGeneros]"></asp:SqlDataSource>
            <!-- SQLDataSource para la tabla de autores -->
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [LibroAutores]"></asp:SqlDataSource>

            <br />
            <br />

            <h4>MODIFICACIÓN</h4>
            Seleccione libro a modificar: <br />
            <asp:DropDownList ID="DropDownList3" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource4" DataTextField="titulo" DataValueField="id" AutoPostBack="true" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [Libros]"></asp:SqlDataSource>
            <br />

            <asp:Label ID="Label3" runat="server" Text="Modificar el Título:"></asp:Label> <br />          
            <asp:TextBox ID="TextBox2" runat="server" ToolTip="Modificar el título del libro"></asp:TextBox> 
            <asp:Label ID="Label8" runat="server" Text=" " Font-Bold="True" Font-Italic="True" ForeColor="#CC3300"></asp:Label>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Modificar el Género:"></asp:Label> <br />
            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource2" DataTextField="descripcion" DataValueField="id"></asp:DropDownList>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Modificar el Autor:"></asp:Label> <br />
            <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource3" DataTextField="apellido" DataValueField="id" AutoPostBack="true" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged"></asp:DropDownList>
            <asp:Label ID="Label7" runat="server" Text=" "></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="Modificar" BackColor="#99CC00" OnClick="Button2_Click" />
            <asp:Label ID="Label6" runat="server" Text=" "></asp:Label>

            <br />
            <br />

            <h4>BAJA</h4>
            Seleccione libro a eliminar: <br />
            <asp:DropDownList ID="DropDownList6" runat="server" CssClass="js-example-basic-single" DataSourceID="SqlDataSource5" DataTextField="titulo" DataValueField="id" AutoPostBack="true" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [Libros]"></asp:SqlDataSource>
            <br />
            <asp:Label ID="Label9" runat="server" Text=" "></asp:Label>
            <br />
            <asp:Button ID="Button3" runat="server" Text="Baja" BackColor="#CC3300" Width="77px" OnClientClick="return Confirmar();" OnClick="Button3_Click" /> 
            <asp:Label ID="Label10" runat="server" Text=" " Font-Bold="True" ForeColor="#CC3300"></asp:Label>

            <br />
            <br />
            <br />
            <h3>Otros módulos</h3>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LibroGeneros.aspx">📕 Géneros literarios</asp:HyperLink> <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/LibroAutores.aspx">✍️ Autores literarios</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Menu.aspx">⚜️ Volver al Menú principal</asp:HyperLink>


            <br /><br /> <br />
            <footer>
              <p>&copy; 2025 Nicolás Servidio - Mi Sitio Web. Todos los derechos reservados. </p>
              <p><a href="https://linkedin.com/in/nicolas-servidio-del-monte">Contactame</a> | <a href="#">Política de Privacidad</a></p>
            </footer>

            <style>
                .estiloTabla {
                    width: 50%;
                    border-collapse: collapse;
                    font-family: sans-serif;
	                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);    
	                background-color: white !important;
	                color: black !important;
                }
                .estiloTabla thead {
	                background-color: #0278ae;
	                border: 2px solid #0278ae;
	                color: #f6f5f5;
                }
                .estiloTabla thead tr th {
	                border-right: 1px solid #0a7fc2;
	                padding: 9px 20px 9px 10px;
	                font-weight: 400;
	                font-size: 1.1em;	
	                text-shadow: 0 1px 0 rgba(25.5, 25.5, 25.5, 0.4);
                }
                .estiloTabla th, .estiloTabla td {
                  border: 1px solid #ddd;
                  padding: 8px;
                }
                .estiloTabla th {
                  text-align: left;
                }
                .estiloTabla table > thead > tr > th {
	                border: 1px solid rgba(0, 0, 0, 0.1);
                }
                .estiloTabla td {
                    padding: 2px 15px 1px 10px; 
                    border-color: #b3b3b3;    
                }
                .estiloTabla tbody td:first-of-type {
                    border-left: 2px solid #b3b3b3bb;
                }
                .estiloTabla tbody tr:nth-of-type(even) {
                    background-color: #f3f3f3;
                }
                .estiloTabla tbody tr:last-of-type {
                    border-bottom: 3px solid #51adcf;
                }
                .estiloTabla tbody tr:first-of-type {
                    border-top: 3px solid #51adcf;
                }
                .estiloTabla tbody tr:hover td {
	                background-color: #f8bd7f;
                }
            </style>

        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>

        function filtrarTabla() {

            let filtro = document.getElementById('TextBox1').value.toLowerCase();
            let tabla = document.getElementById('Table1');
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

        function Confirmar() {
            return confirm('¿Estás seguro de que deseas eliminar este registro?');
        }

        document.addEventListener("DOMContentLoaded", function () {
            $(".js-example-basic-single").select2({
                placeholder: 'Select an option'
            });
        });

    </script>
</body>
</html>
