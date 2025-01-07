using System;
using System.Net.Http;
using System.Collections.Generic;
using System.Web.UI;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace BugSheriff
{
    public partial class programs : Page
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

                    // Bind the data to the repeater
                    programRepeater.DataSource = ProgramsList;
                    programRepeater.DataBind();
                }
                else
                {
                    // Read the error response and display the message
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    var errorObj = JsonConvert.DeserializeObject<ErrorResponse>(errorResponse);
                    lblMessage.Text = errorObj?.message ?? "Error fetching programs. Please try again.";
                }
            }
        }
    }

    // Model for the program
    //public class ProgramModel
    //{
    //    public string id { get; set; }
    //    public string name { get; set; }
    //    public string description { get; set; }
    //    public string status { get; set; }
    //    public string application_start_date { get; set; }
    //    public string application_end_date { get; set; }
    //}

    // Model for handling error responses
    //public class ErrorResponse
    //{
    //    public string message { get; set; }
    //}
}
