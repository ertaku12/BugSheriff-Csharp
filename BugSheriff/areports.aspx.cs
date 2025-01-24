using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugSheriff
{
    public partial class areports : System.Web.UI.Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    Response.Redirect("login.aspx", false);
                    return;
                }

                try
                {
                    var reports = await GetReports();
                    reportRepeater.DataSource = reports;
                    reportRepeater.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error fetching reports: {ex.Message}";
                }
            }
        }

        private async Task<List<Report>> GetReports()
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:5000/");
                string jwtToken = Request.Cookies["jwt_token"]?.Value;
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", jwtToken);

                var response = await client.GetAsync("admin/getreports");
                if (response.IsSuccessStatusCode)
                {
                    var jsonString = await response.Content.ReadAsStringAsync();
                    return JsonConvert.DeserializeObject<List<Report>>(jsonString);
                }
                else
                {
                    throw new Exception("Failed to fetch reports.");
                }
            }
        }

        protected async void ViewReport_Command(object sender, CommandEventArgs e)
        {
            string reportPath = e.CommandArgument.ToString();
            string token = Request.Cookies["jwt_token"]?.Value;

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:5000/");

                // Add JWT token to the request headers
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                // Send GET request to the Flask endpoint
                HttpResponseMessage response = await client.GetAsync($"admin/uploads/{reportPath}");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsByteArrayAsync();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", $"inline; filename={reportPath}");
                    Response.BinaryWrite(content);
                    Response.End(); // End the response
                }
                else
                {
                    lblMessage.Text = $"Error: {await response.Content.ReadAsStringAsync()}"; // Display the error message
                }
            }
        }

        public class Report
        {
            public int id { get; set; }
            public string program_name { get; set; }
            public string report_pdf_path { get; set; }
            public string status { get; set; }
            public decimal? reward_amount { get; set; }
            public string iban  { get; set; }
        }
    }
}
