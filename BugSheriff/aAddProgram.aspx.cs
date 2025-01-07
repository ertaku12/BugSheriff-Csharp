using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace BugSheriff
{
    public partial class aAddProgram : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    lblMessage.Text = "You must be logged in to add program.";
                    Response.Redirect("login.aspx", false);
                    return;
                }               

            }
        }

        protected async void AddProgram_Click(object sender, EventArgs e)
        {
            string apiUrl = $"http://localhost:5000/admin/newprogram";
            string token = Request.Cookies["jwt_token"]?.Value;

            var addProgram = new
            {
                name = name.Text,
                description = description.Text,
                application_start_date = application_start_date.Text,
                application_end_date = application_end_date.Text,
                status = status.SelectedValue
            };

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
                HttpResponseMessage response = await client.PostAsJsonAsync(apiUrl, addProgram);

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Program added successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to update program.";
                }
            }
        }
    }
}
