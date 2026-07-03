<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Lecturers.aspx.cs" Inherits="SIMS.Lecturers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lecturers Directory - SIMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/Assets/CSS/LecturerStudent-style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-container">
            
            <div class="mobile-header">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div class="brand-logo" style="width:30px; height:30px; font-size:14px;">S</div>
                    <span class="brand-name" style="font-size:16px;">SIMS Portal</span>
                </div>
                <button type="button" class="mobile-menu-toggle" onclick="toggleMobileMenu()">☰</button>
            </div>

            <nav class="sidebar-nav" id="sidebarMenu">
                <div>
                    <div class="nav-brand">
                        <div class="brand-logo">S</div>
                        <span class="brand-name">SIMS Portal</span>
                    </div>
                    
                    <div class="nav-links">
                        <a href="StudentDashboard.aspx" class="nav-item <%= Request.Url.AbsolutePath.EndsWith("StudentDashboard.aspx") ? "active" : "" %>">
                            <span class="nav-item-icon">📊</span> Dashboard
                        </a>
                        <a href="Students.aspx" class="nav-item <%= Request.Url.AbsolutePath.EndsWith("Students.aspx") ? "active" : "" %>">
                            <span class="nav-item-icon">👤</span> Student Profile 
                        </a>
                        <a href="Lecturers.aspx" class="nav-item <%= Request.Url.AbsolutePath.EndsWith("Lecturers.aspx") ? "active" : "" %>">
                            <span class="nav-item-icon">👨‍🏫</span> Lecturers 
                        </a>
                    </div>
                </div>
                
                <div class="nav-footer">
                    <asp:LinkButton ID="lnkSidebarLogout" runat="server" OnClick="btnLogout_Click" CssClass="nav-item" Style="color: #f87171 !important;">
                        <span class="nav-item-icon" style="color: #ef4444 !important;">🚪</span> Sign Out
                    </asp:LinkButton>
                </div>
            </nav>

            <div class="main-dashboard-wrapper">
                <div class="centered-content-container">
                    
                    <div style="margin-bottom: 35px; display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 16px;">
                        <div>
                            <h1 style="margin: 0; font-size: 28px; font-weight: 700; color: var(--text-main); letter-spacing: -0.5px;">Lecturers Directory</h1>
                            <p style="margin: 6px 0 0 0; font-size: 14px; color: var(--text-muted);">Search and view global academic faculty allocations and structural tracks</p>
                        </div>
                        <div style="background: white; padding: 10px 18px; border-radius: 12px; border: 1px solid var(--border-color); font-size: 13px; font-weight: 600; color: var(--text-muted); display: flex; align-items: center; gap: 8px; box-shadow: 0 1px 2px rgba(0,0,0,0.02);">
                            <span style="height: 8px; width: 8px; background-color: #10b981; border-radius: 50%; display: inline-block; animation: pulse 2s infinite;"></span>
                            System Connected
                        </div>
                    </div>

                    <div class="modern-master-card">
                        
                        <div class="filter-control-deck">
                            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by lecturer name or department..." 
                                CssClass="premium-input-field" style="width: 360px; max-width: 100%;" />
                            
                            <asp:Button ID="btnSearch" runat="server" Text="Filter Records" OnClick="btnSearch_Click" 
                                CssClass="btn-action-trigger btn-search-accent" />
                            
                            <asp:Button ID="btnClear" runat="server" Text="Reset View" OnClick="btnClear_Click" 
                                CssClass="btn-action-trigger btn-clear-muted" />
                        </div>

                        <div class="custom-table-container">
                            <asp:GridView ID="gvLecturers" runat="server" AutoGenerateColumns="False" Width="100%"
                                GridLines="None" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="name" HeaderText="Lecturer Name" ItemStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="email" HeaderText="Institutional Email" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="department" HeaderText="Academic Department" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="qualification" HeaderText="Qualifications Profile" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="phone" HeaderText="Contact Line" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-grid-notice">
                                        🔍 No matching records found inside current global keyword tracking criteria.
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function toggleMobileMenu() {
            var menu = document.getElementById("sidebarMenu");
            menu.classList.toggle("active");
        }
    </script>
</body>
</html>