<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="BugSheriff.signup"  Async="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - BugSheriff</title>
    <link rel="stylesheet" type="text/css" href="styles/signup.css" />
</head>
<body>
    <form id="formSignup" runat="server">
        <div class="top-banner">
            <a href="home.aspx">Home</a>
            <a href="login.aspx">Login</a>
            <a href="signup.aspx">Sign Up</a>
            <%--<a href="profile.aspx">Profile</a>
            <a href="programs.aspx">Programs</a>
            <a href="reports.aspx">Reports</a>--%>

        </div>

        <div class="signup-container">
            <h1>Sign Up</h1>
            <p>Create your account</p>
            <p>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message" ForeColor="Red"></asp:Label>

            </p>

            <div class="input-group">
                <label for="username">Username</label>
                <asp:TextBox ID="username" runat="server" CssClass="input-field" placeholder="Username"></asp:TextBox>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <asp:TextBox ID="password" runat="server" CssClass="input-field" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>

            <div class="input-group">
                <label for="confirmPassword">Confirm Password</label>
                <asp:TextBox ID="confirmPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
            </div>

            <div class="input-group">
                <label for="secret_question">Secret Question</label>
                <asp:DropDownList ID="secret_question" runat="server" CssClass="input-field" >
                    <asp:ListItem Text="What is your pet's name?" Value="What is your pet's name?" />
                    <asp:ListItem Text="What is your mother's maiden name?" Value="What is your mother's maiden name?" />
                    <asp:ListItem Text="What is your favorite book?" Value="What is your favorite book?" />
                </asp:DropDownList>
            </div>

            <div class="input-group">
                <label for="secret_answer">Answer to Secret Question</label>
                <asp:TextBox ID="secret_answer" runat="server" CssClass="input-field" placeholder="Secret Answer"></asp:TextBox>
            </div>

            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="signup-button" OnClick="btnSignup_Click" />

            <p>Already have an account? <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/login.aspx" Text="Login" CssClass="login-link"></asp:HyperLink></p>
        </div>
    </form>
</body>
</html>
