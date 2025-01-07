<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="programs.aspx.cs" Inherits="BugSheriff.programs" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Programs</title>
    <link rel="stylesheet" type="text/css" href="styles/programs.css?v=1.3" />

    <script type="text/javascript">
        function redirectToDetails(program) {
            var url = "ProgramDetails.aspx?id=" + program.id +
                "&name=" + encodeURIComponent(program.name) +
                "&description=" + encodeURIComponent(program.description) +
                "&status=" + encodeURIComponent(program.status) +
                "&start_date=" + program.application_start_date +
                "&end_date=" + program.application_end_date;

            window.location.href = url; // Redirect
        }

        function filterPrograms() {
            const searchText = document.getElementById("<%= txtSearch.ClientID %>").value.toLowerCase();
            const programCards = document.querySelectorAll('.program');

            programCards.forEach(card => {
                const name = card.querySelector('h3').innerText.toLowerCase();
                const description = card.querySelector('p:nth-of-type(1)').innerText.toLowerCase(); // Description
                const status = card.querySelector('p:nth-of-type(2)').innerText.toLowerCase(); // Status
                const endDate = card.querySelector('p:nth-of-type(3)').innerText.toLowerCase(); // End Date
                const startDate = card.querySelector('input[type="hidden"]').value.toLowerCase(); // Start Date

                // Check if any of the fields include the search text
                card.style.display = name.includes(searchText) ||
                    description.includes(searchText) ||
                    status.includes(searchText) ||
                    endDate.includes(searchText) ||
                    startDate.includes(searchText)
                    ? 'block' : 'none';
            });
        }
    </script>
</head>
<body>
    <div class="top-banner">
        <a href="home.aspx">Home</a>
        <a href="profile.aspx">Profile</a>
        <a href="programs.aspx">Programs</a>
        <a href="reports.aspx">Reports</a>
    </div>



    <form id="formAPrograms" runat="server">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div>
            <h2>Programs</h2>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search..." onkeyup="filterPrograms()"></asp:TextBox>

            <div id="programList">
                <asp:Repeater ID="programRepeater" runat="server">
                    <ItemTemplate>
                        <div class="program">
                            <h3><strong>Program name: </strong><%# Eval("name") %></h3>
                            <p><strong>Description: </strong><%# Eval("description") %></p>
                            <p><strong>Status: </strong><%# Eval("status") %></p>
                            <p><strong>Ends: </strong><%# Eval("application_end_date") %></p>

                            <!-- Hidden input for application start date -->
                            <input type="hidden" id="hiddenStartDate<%# Eval("id") %>" value="<%# Eval("application_start_date") %>" />

                            <a href="javascript:void(0);"
                                            onclick='redirectToDetails({
                                   id: "<%# Eval("id") %>",
                                   name: "<%# Eval("name") %>",
                                   description: "<%# Eval("description") %>",
                                   status: "<%# Eval("status") %>",
                                   application_end_date: "<%# Eval("application_end_date") %>",
                                   application_start_date: document.getElementById("hiddenStartDate<%# Eval("id") %>").value // Hidden field value
                             })'
                                class="program-link">View Details</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>


</body>
</html>
