<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="SIMS.Students" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Profile Settings - SIMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/Assets/CSS/StudentProfile-style.css" rel="stylesheet" type="text/css" />
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
                    <asp:LinkButton ID="lnkSidebarLogout" runat="server" OnClick="lnkSidebarLogout_Click" CssClass="nav-item" Style="color: #f87171 !important;">
                        <span class="nav-item-icon" style="color: #ef4444 !important;">🚪</span> Sign Out
                    </asp:LinkButton>
                </div>
            </nav>

            <div class="main-dashboard-wrapper">
                <div class="centered-content-container">
                    
                    <div style="margin-bottom: 35px; display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 16px;">
                        <div>
                            <h1 style="margin: 0; font-size: 28px; font-weight: 700; color: var(--text-main); letter-spacing: -0.5px;">Profile Settings</h1>
                            <p style="margin: 6px 0 0 0; font-size: 14px; color: var(--text-muted);">Manage your personal information mappings and system parameters</p>
                        </div>
                    </div>

                    <asp:Label ID="lblStatusMessage" runat="server" Visible="false" 
    Style="padding: 16px 24px; border-radius: 12px; margin-bottom: 30px; font-weight: 600; font-size: 14px; display: flex; align-items: center; gap: 10px; transition: opacity 0.5s ease;">
</asp:Label>

                    <div class="modern-master-card">
                        <div class="modern-form-grid">
                            
                            <div class="form-section-title">
                                <span>👤</span> Biographical Parameters
                            </div>

                            <div>
                                <span class="premium-input-label">Student Legal Full Name</span>
                                <asp:TextBox ID="txtName" runat="server" CssClass="premium-input-field" placeholder="e.g. John Doe" />
                            </div>

                            <div class="field-group-half">
                                <div>
                                    <span class="premium-input-label">Gender Identity</span>
                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="premium-input-field">
                                        <asp:ListItem Text="Select Option" Value="" />
                                        <asp:ListItem Text="Male" Value="Male" />
                                        <asp:ListItem Text="Female" Value="Female" />
                                    </asp:DropDownList>
                                </div>
                                <div>
                                    <span class="premium-input-label">Date of Birth</span>
                                    <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="premium-input-field" />
                                </div>
                            </div>

                            <div class="form-section-title" style="margin-top: 15px;">
                                <span>✉️</span> Contact & Communications
                            </div>

                            <div>
                                <span class="premium-input-label">Primary Email Address</span>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="premium-input-field" placeholder="username@domain.com" />
                            </div>

                            <div>
                                <span class="premium-input-label">Mobile Communication Line</span>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="premium-input-field" placeholder="+1 (555) 000-0000" />
                            </div>

                            <div class="full-width-field">
                                <span class="premium-input-label">Current Residential Address</span>
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="premium-input-field" style="resize: none; font-family: inherit;" placeholder="Street name, City, Zip Code" />
                            </div>

                        </div>

                        <div class="card-action-footer">
                            <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Configuration" OnClick="btnUpdateProfile_Click" CssClass="btn-submit-save" />
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

    // 🕒 Auto-hide the notification banner smoothly after 4 seconds
    window.onload = function () {
        var statusLabel = document.getElementById('<%= lblStatusMessage.ClientID %>');
        if (statusLabel) {
            setTimeout(function () {
                statusLabel.style.opacity = '0';
                setTimeout(function () {
                    statusLabel.style.display = 'none';
                }, 500); // Gives the CSS opacity transition 500ms to finish fading out
            }, 4000); // Visible for 4 seconds
        }
    };
</script>
</body>
</html>