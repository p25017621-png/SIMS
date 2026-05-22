using System;
using System.Data;
using System.Data.SqlClient;

namespace SIMS.Lecturer
{
    public partial class ManageAttendance : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
        @"Data Source=(LocalDB)\MSSQLLocalDB;
        Initial Catalog=SIMS_DB;
        Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAttendance();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            con.Open();

            SqlCommand cmd1 = new SqlCommand(
            "INSERT INTO Attendance VALUES(@id,@name,@course,@status)", con);

            cmd1.Parameters.AddWithValue("@id", "ST001");
            cmd1.Parameters.AddWithValue("@name", "John Tan");
            cmd1.Parameters.AddWithValue("@course", "Computer Science");
            cmd1.Parameters.AddWithValue("@status", ddl1.SelectedValue);

            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand(
            "INSERT INTO Attendance VALUES(@id,@name,@course,@status)", con);

            cmd2.Parameters.AddWithValue("@id", "ST002");
            cmd2.Parameters.AddWithValue("@name", "Sarah Lim");
            cmd2.Parameters.AddWithValue("@course", "Software Engineering");
            cmd2.Parameters.AddWithValue("@status", ddl2.SelectedValue);

            cmd2.ExecuteNonQuery();

            SqlCommand cmd3 = new SqlCommand(
            "INSERT INTO Attendance VALUES(@id,@name,@course,@status)", con);

            cmd3.Parameters.AddWithValue("@id", "ST003");
            cmd3.Parameters.AddWithValue("@name", "Daniel Wong");
            cmd3.Parameters.AddWithValue("@course", "Information Technology");
            cmd3.Parameters.AddWithValue("@status", ddl3.SelectedValue);

            cmd3.ExecuteNonQuery();

            SqlCommand cmd4 = new SqlCommand(
            "INSERT INTO Attendance VALUES(@id,@name,@course,@status)", con);

            cmd4.Parameters.AddWithValue("@id", "ST004");
            cmd4.Parameters.AddWithValue("@name", "Alicia Tan");
            cmd4.Parameters.AddWithValue("@course", "Cyber Security");
            cmd4.Parameters.AddWithValue("@status", ddl4.SelectedValue);

            cmd4.ExecuteNonQuery();

            con.Close();

            LoadAttendance();
        }

        void LoadAttendance()
        {
            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Attendance", con);

            DataTable dt = new DataTable();

            da.Fill(dt);

            GridView1.DataSource = dt;

            GridView1.DataBind();
        }
    }
}