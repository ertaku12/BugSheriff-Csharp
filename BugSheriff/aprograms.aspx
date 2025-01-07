<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aprograms.aspx.cs" Inherits="BugSheriff.aprograms" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel - Programs</title>
    <link rel="stylesheet" type="text/css" href="styles/aprograms.css" />

    <script type="text/javascript">
        function redirectToEdit(program) {
            var url = "aProgramDetails.aspx?id=" + program.id +
                "&name=" + encodeURIComponent(program.name) +
                "&description=" + encodeURIComponent(program.description) +
                "&status=" + encodeURIComponent(program.status) +
                "&start_date=" + program.application_start_date +
                "&end_date=" + program.application_end_date;

            window.location.href = url; // Redirect
        }

        function filterPrograms() {
            const searchText = document.getElementById("<%= txtSearch.ClientID %>").value.toLowerCase();
            const programCards = document.querySelectorAll('.program-card'); // Corrected the class to match the actual class used in the card div

            programCards.forEach(card => {
                const name = card.querySelector('h3')?.innerText.toLowerCase() || "";
                const description = card.querySelector('p:nth-of-type(1)')?.innerText.toLowerCase() || ""; // Description
                const status = card.querySelector('p:nth-of-type(2)')?.innerText.toLowerCase() || ""; // Status
                const endDate = card.querySelector('p:nth-of-type(3)')?.innerText.toLowerCase() || ""; // End Date
                const startDate = card.querySelector('input[type="hidden"]')?.value.toLowerCase() || ""; // Start Date

                // Check if any of the fields include the search text
                const match = name.includes(searchText) || description.includes(searchText) || status.includes(searchText) || endDate.includes(searchText) || startDate.includes(searchText);

                card.style.display = match ? 'block' : 'none';
            });
        }


        function confirmDelete(programName) {
            return confirm("Are you sure you want to delete the program '" + programName + "'? \nThis will also delete all reports tied with this program.");
        }
    </script>


</head>
<body>
    <div class="top-banner">
        <a href="ahome.aspx">Admin's Home</a>
        <%--<a href="login.aspx">Login</a>
    <a href="signup.aspx">Sign Up</a>--%>
        <a href="aprofile.aspx">Admin's Profile</a>
        <a href="aprograms.aspx">Admin's Programs</a>
        <a href="areports.aspx">Admin's Reports</a>

    </div>

    <form id="formAPrograms" runat="server">
        <h2>All Programs</h2>

        <a href="/aAddProgram" class="program-link">Add Program</a>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="container">
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search..." onkeyup="filterPrograms()"></asp:TextBox>

            <asp:Repeater ID="RepeaterPrograms" runat="server">
                <ItemTemplate>
                    <div class="program-card">
                        <h3><strong>Program Name: </strong><%# Eval("name") %></h3>
                        <p><strong>Description: </strong><%# Eval("description") %></p>
                        <p><strong>Status: </strong><%# Eval("status") %></p>
                        <p><strong>Ends: </strong><%# Eval("application_end_date") %></p>

                        <!-- Hidden input for application start date -->
                        <input type="hidden" id="hiddenStartDate<%# Eval("id") %>" value="<%# Eval("application_start_date") %>" />

                        <a href="javascript:void(0);"
                            onclick='redirectToEdit({
                        id: "<%# Eval("id") %>",
                        name: "<%# Eval("name") %>",
                        description: "<%# Eval("description") %>",
                        status: "<%# Eval("status") %>",
                        application_end_date: "<%# Eval("application_end_date") %>",
                        application_start_date: document.getElementById("hiddenStartDate<%# Eval("id") %>").value // Hidden field value
  })'
                            class="program-link">Edit Program</a>
                        
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete"
                            CommandArgument='<%# Eval("id") %>'
                            OnClientClick='<%# "return confirmDelete(\"" + Eval("name") + "\");" %>'
                            OnCommand="DeleteProgram" />

                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </form>
</body>
</html>
