using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Text.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugSheriffA
{
    public partial class aprofile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchUserDetails();
            }
        }

        private async void FetchUserDetails()
        {
            string jwtToken = Request.Cookies["jwt_token"]?.Value;

            if (string.IsNullOrEmpty(jwtToken))
            {
                // Redirect to login if token is not found
                Response.Redirect("login.aspx", false);
                return;
            }

            const string apiUrl = "http://localhost:5000/user-details";
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", jwtToken);
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response = await client.GetAsync(apiUrl);
                if (response.IsSuccessStatusCode)
                {
                    var data = JsonConvert.DeserializeObject<UserDetails>(await response.Content.ReadAsStringAsync());
                    username.Text = data.Username;
                    secret_question.SelectedValue = data.SecretQuestion;
                    secret_answer.Text = data.SecretAnswer;
                    iban.Text = data.Iban;
                }
                else if (response.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    Response.Redirect("login.aspx", false);
                    return;
                }
                else
                {
                    // show the error message on this: lblMessage
                    var responseBody = await response.Content.ReadAsStringAsync();
                    dynamic responseData = Newtonsoft.Json.JsonConvert.DeserializeObject(responseBody);
                    lblMessage.Text = responseData.message;


                }
            }
        }

        protected async void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            string jwtToken = Request.Cookies["jwt_token"]?.Value;

            if (string.IsNullOrEmpty(jwtToken))
            {
                Response.Redirect("login.aspx", false);
                return;
            }

            // check if password equals confirm password
            if (password.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            if (string.IsNullOrEmpty(secret_answer.Text))
            {
                lblMessage.Text = "Secret answer can't be empty!";
                return;
            }

            //if (iban.Text.Length != 0 && iban.Text.Length != 26)
            //{
            //    lblMessage.Text = "IBAN must be 26 characters long";
            //    return;
            //}


            const string apiUrl = "http://localhost:5000/update-user";
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", jwtToken);
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


                var userDetails = new
                {
                    password = password.Text,
                    secret_question = secret_question.SelectedValue,
                    secret_answer = secret_answer.Text,
                    iban = iban.Text
                };

                var json = JsonConvert.SerializeObject(userDetails);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PutAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.Text = "User details updated successfully!";
                }
                else
                {
                    // Read the error message from the response
                    var errorMessageJson = await response.Content.ReadAsStringAsync();

                    // Extract the message from the JSON
                    var jsonDocument = JsonDocument.Parse(errorMessageJson);
                    var errorMessage = jsonDocument.RootElement.GetProperty("message").GetString();

                    lblMessage.Text = $"Update failed: {errorMessage}";
                }
            }
        }
    }

    public class UserDetails
    {
        public string Username { get; set; }

        [JsonProperty("secret_question")]
        public string SecretQuestion { get; set; }

        [JsonProperty("secret_answer")]
        public string SecretAnswer { get; set; }
        public string Iban { get; set; }
    }
}
