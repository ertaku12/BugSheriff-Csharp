<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgramDetails.aspx.cs" Inherits="BugSheriff.programDetails" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Program Details</title>
    <link rel="stylesheet" type="text/css" href="styles/details.css" />
</head>
<body>
    <div class="top-banner">
        <a href="home.aspx">Home</a>
        <%--<a href="login.aspx">Login</a>
    <a href="signup.aspx">Sign Up</a>--%>
        <a href="profile.aspx">Profile</a>
        <a href="programs.aspx">Programs</a>
        <a href="reports.aspx">Reports</a>
    </div>
    <form id="formProgramDetails" runat="server">

        <div>
            <h2>
                <asp:Label ID="lblProgramName" runat="server" Text="Program Name"></asp:Label></h2>
            <p>
                <strong>Description: </strong>
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </p>
            <p>
                <strong>Start Date: </strong>
                <asp:Label ID="lblStartDate" runat="server"></asp:Label>
            </p>
            <p>
                <strong>End Date: </strong>
                <asp:Label ID="lblEndDate" runat="server"></asp:Label>
            </p>
            <p>
                <strong>Status: </strong>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </p>

            <!-- Hidden field to store program_id -->
            <asp:HiddenField ID="program_id" runat="server" />

            <asp:FileUpload ID="fileUpload" runat="server" accept=".pdf"/>

            <asp:Button ID="btnUpload" runat="server" Text="Upload Report" OnClick="UploadReport" />

            <br />
            <asp:Label ID="lblUploadMessage" runat="server" ForeColor="Red"></asp:Label>

        </div>
    </form>
</body>
</html>

