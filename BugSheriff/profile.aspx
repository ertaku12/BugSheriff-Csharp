<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="BugSheriffP.Profile" Async="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Profile</title>
    <link rel="stylesheet" type="text/css" href="styles/profile.css" />
</head>
<body>
    <form id="formProfile" runat="server">
        <div class="top-banner">
            <a href="home.aspx">Home</a>
            <%--<a href="login.aspx">Login</a>
            <a href="signup.aspx">Sign Up</a>--%>
            <a href="profile.aspx">Profile</a>
            <a href="programs.aspx">Programs</a>
            <a href="reports.aspx">Reports</a>
        </div>


        <div class="profile-container">
            <h2>User Profile</h2>
            <p>
                <asp:Label ID="lblMessage" runat="server" CssClass="error-message" ForeColor="Red"></asp:Label>

            </p>
            <div class="input-group">
                <label for="username">Username:</label>
                <asp:TextBox ID="username" runat="server" ReadOnly="true" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="input-group">
                <label for="password">New Password:</label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="input-group">
                <label for="txtConfirmPassword">Confirm New Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="input-group">
                <label for="secret_question">Select a Secret Question:</label>
                <asp:DropDownList ID="secret_question" runat="server" CssClass="dropdown-list">
                    <asp:ListItem Text="What is your pet's name?" Value="What is your pet's name?"></asp:ListItem>
                    <asp:ListItem Text="What is your mother's maiden name?" Value="What is your mother's maiden name?"></asp:ListItem>
                    <asp:ListItem Text="What is your favorite book?" Value="What is your favorite book?"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="input-group">
                <label for="secret_answer">Secret Answer:</label>
                <asp:TextBox ID="secret_answer" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="input-group">
                <label for="iban">IBAN:</label>
                <asp:TextBox ID="iban" runat="server" CssClass="input-field" ></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="update-button" OnClick="btnUpdateProfile_Click" />
            </div>
        </div>

    </form>
</body>
</html>
