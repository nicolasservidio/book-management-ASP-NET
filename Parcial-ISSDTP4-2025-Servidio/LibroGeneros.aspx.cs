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
    public partial class LibroGeneros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // ALTAS DE GÉNEROS
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TextBox1.Text))
            {
                Label1.Text = " Usted debe completar el campo con el nombre del género.";
            }
            else
            {
                SqlDataSource1.InsertParameters["descripcion"].DefaultValue = TextBox1.Text;

                int result = SqlDataSource1.Insert();

                if (result == 1)
                {
                    Label1.Text = " Género registrado correctamente.";

                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Alta exitosa de Género: {TextBox1.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
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
                    streamWriter.WriteLine($"Alta de Género en más de un registro - Género: {TextBox1.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
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
                    streamWriter.WriteLine($"Alta fallida de Género: {TextBox1.Text}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();
                    // Muestro cuadro emergente con la ruta del archivo
                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log fallido se guardó en: {rutaArchivo}');", true);

                }

                DropDownList1.DataBind();
            }
        }

        // FILTRAR
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
            int idGenero = Convert.ToInt32(e.Command.Parameters["@id"].Value);

            using (SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conexion.Open();

                // Obtener género antes de eliminarlo
                SqlCommand cmdGenero = new SqlCommand("SELECT descripcion FROM LibroGeneros WHERE id = @idGenero", conexion);
                cmdGenero.Parameters.AddWithValue("@idGenero", idGenero);
                SqlDataReader reader = cmdGenero.ExecuteReader();

                string genero = "";
                if (reader.Read())
                {
                    genero = reader["descripcion"].ToString();
                }
                reader.Close();

                // Verificar si el género tiene libros asociados
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Libros WHERE idGenero = @idGenero", conexion);
                cmd.Parameters.AddWithValue("@idGenero", idGenero);

                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    e.Cancel = true; // Cancela la eliminación
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No se puede eliminar este génenro porque tiene libros asociados.');", true);
                }
                else
                {
                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Eliminación exitosa de Género: {genero}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
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
            int idGenero = Convert.ToInt32(e.Command.Parameters["@id"].Value);

            using (SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conexion.Open();

                // Obtener el género actual antes de actualizar
                SqlCommand cmdGenero = new SqlCommand("SELECT descripcion FROM LibroGeneros WHERE id = @idGenero", conexion);
                cmdGenero.Parameters.AddWithValue("@idGenero", idGenero);
                SqlDataReader reader = cmdGenero.ExecuteReader();

                string generoAnterior = "";
                if (reader.Read())
                {
                    generoAnterior = reader["descripcion"].ToString();
                }
                reader.Close();

                // Obtener el nuevo valor ingresado en la actualización
                string nuevoGenero = e.Command.Parameters["@descripcion"].Value.ToString();

                // Registro de log en .txt
                StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                streamWriter.WriteLine($"Modificación de Género: {generoAnterior} → {nuevoGenero}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                streamWriter.Close();
                // Muestro cuadro emergente con la ruta del archivo
                string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('El archivo de log se guardó en: {rutaArchivo}');", true);

            }
        }


    }
}