using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial_ISSDTP4_2025_Servidio
{
    public partial class LibroAutores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // ALTAS DE AUTORES
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(TextBox1.Text) || string.IsNullOrWhiteSpace(TextBox2.Text))
            {
                Label1.Text = " Usted debe completar los dos campos.";
            }
            else
            {
                SqlDataSource1.InsertParameters["nombre"].DefaultValue = TextBox1.Text;
                SqlDataSource1.InsertParameters["apellido"].DefaultValue = TextBox2.Text;

                int result = SqlDataSource1.Insert();

                if (result == 1)
                {
                    Label1.Text = " Autor registrado correctamente.";

                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Alta exitosa de Autor: {TextBox1.Text} {TextBox2.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();
                    // Muestro cuadro emergente con la ruta del archivo
                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log se guardó en: {rutaArchivo}');", true);

                }
                else if (result > 1)
                {
                    Label1.Text = " Se agregó más de un registro en la base de datos. Es necesario revisar la base de datos.";

                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Alta de Autor en más de un registro - Autor: {TextBox1.Text} {TextBox2.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();
                    // Muestro cuadro emergente con la ruta del archivo
                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log se guardó en: {rutaArchivo}');", true);

                }
                else // Para el caso de que no se haya realizado ningun registro, es decir "resultado == 0"
                {
                    Label1.Text = " No se agregó ningún registro en la base de datos.";

                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Alta fallida para el autor Autor: {TextBox1.Text} {TextBox2.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();
                    // Muestro cuadro emergente con la ruta del archivo
                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log fallido se guardó en: {rutaArchivo}');", true);

                }

                DropDownList1.DataBind();
            }
        }

        // FILTRAR POR APELLIDO
        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlDataSource1.FilterExpression = "id = " + DropDownList1.SelectedValue;
        }

        // DESFILTRAR 
        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlDataSource1.FilterExpression = string.Empty;
            SqlDataSource1.FilterParameters.Clear();
        }

        // Evito la eliminación de registros ya utilizados en tabla "Libros"
        protected void SqlDataSource1_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            int idAutor = Convert.ToInt32(e.Command.Parameters["@id"].Value);

            using (SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conexion.Open();

                // Obtener nombre y apellido del autor antes de eliminarlo
                SqlCommand cmdAutor = new SqlCommand("SELECT nombre, apellido FROM LibroAutores WHERE id = @idAutor", conexion);
                cmdAutor.Parameters.AddWithValue("@idAutor", idAutor);
                SqlDataReader reader = cmdAutor.ExecuteReader();

                string nombre = "", apellido = "";
                if (reader.Read())
                {
                    nombre = reader["nombre"].ToString();
                    apellido = reader["apellido"].ToString();
                }
                reader.Close();

                // Verificar si el autor tiene libros asociados
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Libros WHERE idAutor = @idAutor", conexion);
                cmd.Parameters.AddWithValue("@idAutor", idAutor);

                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    e.Cancel = true; // Cancela la eliminación
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No se puede eliminar este autor porque tiene libros asociados.');", true);
                }
                else
                {
                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Eliminación exitosa de Autor: {nombre} {apellido}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();
                    // Muestro cuadro emergente con la ruta del archivo
                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log se guardó en: {rutaArchivo}');", true);
                }

            }
        }

        // Registro de modificaciones en el log
        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            int idAutor = Convert.ToInt32(e.Command.Parameters["@id"].Value);

            using (SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conexion.Open();

                // Obtener el nombre y apellido actuales del autor antes de actualizar
                SqlCommand cmdAutor = new SqlCommand("SELECT nombre, apellido FROM LibroAutores WHERE id = @idAutor", conexion);
                cmdAutor.Parameters.AddWithValue("@idAutor", idAutor);
                SqlDataReader reader = cmdAutor.ExecuteReader();

                string nombreAnterior = "", apellidoAnterior = "";
                if (reader.Read())
                {
                    nombreAnterior = reader["nombre"].ToString();
                    apellidoAnterior = reader["apellido"].ToString();
                }
                reader.Close();

                // Obtener los nuevos valores ingresados en la actualización
                string nuevoApellido = e.Command.Parameters["@apellido"].Value.ToString();
                string nuevoNombre = e.Command.Parameters["@nombre"].Value.ToString();

                // Registro de log en .txt
                StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                streamWriter.WriteLine($"Modificación de Autor: {apellidoAnterior} {nombreAnterior} → {nuevoApellido} {nuevoNombre}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                streamWriter.Close();
                // Muestro cuadro emergente con la ruta del archivo
                string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log se guardó en: {rutaArchivo}');", true);

            }
        }



    }
}