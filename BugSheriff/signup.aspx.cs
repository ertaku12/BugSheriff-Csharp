using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;

namespace BugSheriff
{
    public partial class signup : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected async void btnSignup_Click(object sender, EventArgs e)
        {
            string lusername = username.Text;
            string lpassword = password.Text;
            string lconfirmPassword = confirmPassword.Text;
            string lsecretQuestion = secret_question.Text;
            string lsecretAnswer = secret_answer.Text;

            if (!string.IsNullOrEmpty(lusername) && !string.IsNullOrEmpty(lpassword) &&
                !string.IsNullOrEmpty(lsecretAnswer) && lsecretQuestion != null)
            {
                if (lpassword == lconfirmPassword)
                {
                    var resultMessage = await RegisterUserAsync(lusername, lpassword, lsecretQuestion, lsecretAnswer);
                    lblMessage.Text = resultMessage;
                    
                }
                else
                {
                    lblMessage.Text = "Passwords do not match!";
                    return;
                }
            }
            else
            {
                lblMessage.Text = "Please fill in all fields!";
                return;
            }
        }

        private async Task<string> RegisterUserAsync(string username, string password, string secretQuestion, string secretAnswer)
        {
            string apiUrl = "http://localhost:5000/register";

            using (HttpClient client = new HttpClient())
            {
                var data = new
                {
                    username = username,
                    password = password,
                    secret_question = secretQuestion,
                    secret_answer = secretAnswer
                };

                var content = new StringContent(Newtonsoft.Json.JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    return "User created successfully.";
                }
                else
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    dynamic responseData = Newtonsoft.Json.JsonConvert.DeserializeObject(responseBody);
                    return responseData.message;
                }
            }
        }

        //protected void secretQuestion_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //}
    }
}