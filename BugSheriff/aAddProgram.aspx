<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aAddProgram.aspx.cs" Inherits="BugSheriff.aAddProgram" Async="true" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Program</title>
    <link rel="stylesheet" type="text/css" href="styles/details.css" />
</head>
<body>
    <div class="top-banner">
        <a href="ahome.aspx">Admin's Home</a>
        <a href="aprofile.aspx">Admin's Profile</a>
        <a href="aprograms.aspx">Admin's Programs</a>
        <a href="areports.aspx">Admin's Reports</a>
    </div>

    <form id="formAddProgram" runat="server">
        <div>
            <p>
                <strong>Program Name: </strong>
                <asp:TextBox ID="name" runat="server" TextMode="SingleLine"></asp:TextBox>
            </p>
            <p>
                <strong>Description: </strong>
                <asp:TextBox ID="description" runat="server" TextMode="MultiLine"></asp:TextBox>
            </p>
            <p>
                <strong>Start Date: </strong>
                <asp:TextBox ID="application_start_date" runat="server" TextMode="Date"></asp:TextBox>
            </p>
            <p>
                <strong>End Date: </strong>
                <asp:TextBox ID="application_end_date" runat="server" TextMode="Date"></asp:TextBox>
            </p>
            <p>
                <strong>Status: </strong>
                <asp:DropDownList ID="status" runat="server">
                    <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                    <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                </asp:DropDownList>
            </p>



            <asp:Button ID="btnUpdate" runat="server" Text="Add Program" OnClick="AddProgram_Click" CssClass="btn-update" />

            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
