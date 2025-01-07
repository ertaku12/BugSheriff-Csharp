<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aProgramDetails.aspx.cs" Inherits="BugSheriff.aProgramDetails" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Program</title>
    <link rel="stylesheet" type="text/css" href="styles/adetails.css?v=1.1" />
</head>
<body>
    <div class="top-banner">
        <a href="ahome.aspx">Admin's Home</a>
        <a href="aprofile.aspx">Admin's Profile</a>
        <a href="aprograms.aspx">Admin's Programs</a>
        <a href="areports.aspx">Admin's Reports</a>
    </div>

    <form id="formAProgramDetails" runat="server">
        <div>

            <h2>
                <strong>Program Name: </strong>
                <asp:TextBox ID="name" runat="server" TextMode="SingleLine" Style="height: 40px; font-size: 18px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;" />
            </h2>

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

            <!-- Hidden field to store program_id -->
            <asp:HiddenField ID="program_id" runat="server" />

            <asp:Button ID="btnUpdate" runat="server" Text="Update Program" OnClick="UpdateProgram_Click" CssClass="btn-update" />

            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
