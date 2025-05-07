using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial_ISSDTP4_2025_Servidio
{
    public partial class Libros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                completarTabla();
            }
        }

        // ALTAS DE LIBROS
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(TextBox1.Text))
            {
                Label1.Text = " Usted debe completar el campo con el título del género.";
                completarTabla();
            }
            else
            {
                SqlDataSource1.InsertParameters["titulo"].DefaultValue = TextBox1.Text;
                SqlDataSource1.InsertParameters["idGenero"].DefaultValue = DropDownList1.SelectedValue;
                SqlDataSource1.InsertParameters["idAutor"].DefaultValue = DropDownList2.SelectedValue;

                int result = SqlDataSource1.Insert();

                if (result == 1)
                {
                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Alta exitosa de Libro: {TextBox1.Text}; Genero: {DropDownList1.SelectedItem}; Autor: {DropDownList2.SelectedItem}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();

                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";
                    Label1.Text = " Libro registrado correctamente. Ubicación del archivo de log: " + rutaArchivo;  
                    
                    completarTabla();
                    DropDownList3.DataBind();
                    DropDownList6.DataBind();
                }
                else if (result > 1)
                {
                    Label1.Text = " Se agregó más de un registro en la base de datos. Es necesario revisar la base de datos.";
                    completarTabla();
                }
                else 
                {
                    Label1.Text = " No se agregó ningún registro en la base de datos.";
                    completarTabla();
                }
            }
        }

        // NOTIFICACIÓN DEL NOMBRE DEL AUTOR JUNTO A SU APELLIDO
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label2.Text = " ";

            DataView dv = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count >= 1)
            {
                foreach (DataRowView row in dv)
                {
                    if (row["id"].ToString() == DropDownList2.SelectedValue.ToString())
                    {
                        Label2.Text = " Nombre: " + row["nombre"].ToString();
                    }
                }                
            }
            completarTabla();
        }



        // MODIFICACIONES
        protected void Button2_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(TextBox2.Text))
            {
                Label8.Text = " No está permitido dejar un título vacío.";
                Label6.Text = "";
                completarTabla();
            }
            else
            {
                SqlDataSource1.UpdateParameters["id"].DefaultValue = DropDownList3.SelectedValue;
                SqlDataSource1.UpdateParameters["titulo"].DefaultValue = TextBox2.Text;
                SqlDataSource1.UpdateParameters["idGenero"].DefaultValue = DropDownList4.SelectedValue;
                SqlDataSource1.UpdateParameters["idAutor"].DefaultValue = DropDownList5.SelectedValue;

                int result = SqlDataSource1.Update();

                if (result > 0)
                {

                    // Registro de log en .txt
                    StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                    streamWriter.WriteLine($"Modificación exitosa del Libro de ID {DropDownList3.SelectedValue} - Nuevo título: {TextBox2.Text}; Genero: {DropDownList4.SelectedItem}; Autor: {DropDownList5.SelectedItem}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                    streamWriter.Close();

                    string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";

                    Label6.Text = " Se actualizó el registro. Ubicación del archivo de log: " + rutaArchivo;
                    Label8.Text = "";
                    Label9.Text = "";
                    Label10.Text = "";
                    completarTabla();
                    DropDownList3.DataBind();
                    DropDownList6.DataBind();
                }
            }
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {

            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count >= 1)
            {
                foreach (DataRowView row in dv)
                {
                    if (row["id"].ToString() == DropDownList3.SelectedValue.ToString())
                    {
                        TextBox2.Text = row["titulo"].ToString();
                        DropDownList4.SelectedValue = row["idGenero"].ToString();
                        DropDownList5.SelectedValue = row["idAutor"].ToString();
                    }
                }
            }
            completarTabla();
            Label7.Text = "";
        }

        protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label7.Text = " ";

            DataView dv = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count >= 1)
            {
                foreach (DataRowView row in dv)
                {
                    if (row["id"].ToString() == DropDownList5.SelectedValue.ToString())
                    {
                        Label7.Text = " Nombre: " + row["nombre"].ToString();
                    }
                }
            }
            completarTabla();
        }


        // BAJAS
        protected void Button3_Click(object sender, EventArgs e)
        {

            SqlDataSource1.DeleteParameters["id"].DefaultValue = DropDownList6.SelectedValue;

            int result = SqlDataSource1.Delete();

            if (result >= 1)
            {
                // Registro de log en .txt
                StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/archivo-log.txt", true);
                streamWriter.WriteLine($"Eliminación exitosa del Libro de ID {DropDownList6.SelectedValue}; Fecha: {DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")};\n");
                streamWriter.Close();

                string rutaArchivo = Server.MapPath(".") + "/archivo-log.txt";

                Label10.Text = " Borrado " + result.ToString() + " registro. Ubicación del archivo de log: " + rutaArchivo;
                completarTabla();
                DropDownList3.DataBind();
                DropDownList6.DataBind();
            }
        }

        protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count >= 1)
            {
                foreach (DataRowView row in dv)
                {
                    if (row["id"].ToString() == DropDownList6.SelectedValue.ToString())
                    {
                        Label9.Text = "Título: " + row["titulo"].ToString() + 
                            "<br> Autor: " + row["apellido"].ToString() + " " + row["nombre"].ToString() + 
                            "<br> Género: " + row["descripcion"].ToString();
                    }
                }
            }
            completarTabla();
        }


        protected void completarTabla()
        {

            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            if (dv != null && dv.Count >= 1)
            {

                // Primero rellenamos la CABECERA de "Table1"

                TableRow header = new TableRow(); 

                TableCell hcell1 = new TableCell();
                hcell1.Text = "<b>ID</b>";
                header.Cells.Add(hcell1); 

                TableCell hcell2 = new TableCell();
                hcell2.Text = "<b>Título del Libro</b>";
                header.Cells.Add(hcell2);

                TableCell hcell3 = new TableCell();
                hcell3.Text = "<b>Género</b>";
                header.Cells.Add(hcell3);

                TableCell hcell4 = new TableCell();
                hcell4.Text = "<b>Apellido del Autor</b>";
                header.Cells.Add(hcell4);

                TableCell hcell5 = new TableCell();
                hcell5.Text = "<b>Nombre del Autor</b>";
                header.Cells.Add(hcell5);

                Table1.Rows.Add(header); 

                // Ya tengo el encabezado. Ahora toca RELLENAR REGISTROS de la tabla

                foreach (DataRowView rowView in dv)
                {
                    DataRow row = rowView.Row; 

                    TableRow registro = new TableRow();

                    TableCell cell1 = new TableCell();
                    cell1.Text = row["id"].ToString(); 
                    registro.Cells.Add(cell1);

                    TableCell cell2 = new TableCell();
                    cell2.Text = row["titulo"].ToString();
                    registro.Cells.Add(cell2);

                    TableCell cell3 = new TableCell();
                    cell3.Text = row["descripcion"].ToString(); 
                    registro.Cells.Add(cell3);

                    TableCell cell4 = new TableCell();
                    cell4.Text = row["apellido"].ToString();
                    registro.Cells.Add(cell4);

                    TableCell cell5 = new TableCell();
                    cell5.Text = row["nombre"].ToString();
                    registro.Cells.Add(cell5);

                    Table1.Rows.Add(registro);

                }

            }
            else
            {
                Label1.Text = "No hay registros en la tabla";
            }

        }


    }
}