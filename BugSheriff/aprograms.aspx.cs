using System;
using System.Net.Http;
using System.Collections.Generic;
using System.Web.UI;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.UI.WebControls;
using System.Linq;

namespace BugSheriff
{
    public partial class aprograms : Page
    {
        protected List<ProgramModel> ProgramsList = new List<ProgramModel>();

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

                await FetchPrograms();
            }
        }

        // Fetch programs from API
        protected async Task FetchPrograms()
        {
            string apiUrl = "http://localhost:5000/programs";
            string token = Request.Cookies["jwt_token"]?.Value;

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
                HttpResponseMessage response = await client.GetAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    ProgramsList = JsonConvert.DeserializeObject<List<ProgramModel>>(jsonResponse);

                    // Sort the list by Id in ascending order
                    ProgramsList = ProgramsList.OrderBy(p => p.id).ToList();

                    // Bind the data to the repeater
                    RepeaterPrograms.DataSource = ProgramsList;
                    RepeaterPrograms.DataBind();
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    var errorObj = JsonConvert.DeserializeObject<ErrorResponse>(errorResponse);
                    lblMessage.Text = errorObj?.message ?? "Error fetching programs.";
                }
            }
        }


        // Delete program
        protected async void DeleteProgram(object sender, CommandEventArgs e)
        {
            string programId = e.CommandArgument.ToString();
            string apiUrl = $"http://localhost:5000/admin/program/{programId}";
            string token = Request.Cookies["jwt_token"]?.Value;

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
                HttpResponseMessage response = await client.DeleteAsync(apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Program deleted successfully!";
                    await FetchPrograms(); // Refresh programs after deletion
                }
                else
                {
                    lblMessage.Text = "Error deleting program.";
                }
            }
        }


    }

    public class ProgramModel
    {
        public string id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string status { get; set; }
        public string application_start_date { get; set; }
        public string application_end_date { get; set; }
    }

    public class ErrorResponse
    {
        public string message { get; set; }
    }
}
