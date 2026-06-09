<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="SIMS.Students" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Profile Settings - SIMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style type="text/css">
        /* 🖥️ MODERN DESIGN SYSTEM TOKENS */
        :root {
            --primary-grad: linear-gradient(135deg, #7c3aed, #4f46e5);
            --primary-glow: rgba(124, 58, 237, 0.15);
            --dark-sidebar: #0f172a; 
            --bg-surface: #ffffff;
            --bg-app: #f8fafc;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --input-focus: #7c3aed;
        }

        *, *::before, *::after {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: var(--bg-app); 
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif !important;
            -webkit-font-smoothing: antialiased; 
            -moz-osx-font-smoothing: grayscale;
            display: flex;
            min-height: 100vh;
            color: var(--text-main);
            overflow-x: hidden;
        }

        .app-container {
            display: flex;
            width: 100%;
        }

        /* 🧭 STABILIZED SIDEBAR CHASSIS (UNCHANGED MATCH) */
        .sidebar-nav {
            width: 260px !important;
            min-width: 260px !important;
            max-width: 260px !important;
            background: var(--dark-sidebar) !important;
            color: #f8fafc !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: space-between !important;
            padding: 24px 16px !important;
            position: fixed !important;
            top: 0 !important;
            bottom: 0 !important;
            left: 0 !important;
            z-index: 100 !important;
            box-shadow: 4px 0 25px rgba(0,0,0,0.05) !important;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .nav-brand {
            display: flex !important;
            align-items: center !important;
            gap: 12px !important;
            padding: 10px 12px !important;
            margin-bottom: 30px !important;
        }

        .brand-logo {
            background: var(--primary-grad) !important;
            width: 38px !important;
            height: 38px !important;
            border-radius: 10px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            font-weight: bold !important;
            font-size: 18px !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3) !important;
        }

        .brand-name {
            font-size: 18px !important;
            font-weight: 700 !important;
            letter-spacing: 0.5px !important;
            background: linear-gradient(to right, #ffffff, #cbd5e1) !important;
            -webkit-background-clip: text !important;
            -webkit-text-fill-color: transparent !important;
            display: inline-block !important;
        }

        .nav-links {
            display: flex !important;
            flex-direction: column !important;
            gap: 8px !important;
            flex-grow: 1 !important;
        }

        .nav-item {
            display: flex !important;
            align-items: center !important;
            gap: 14px !important;
            padding: 14px 18px !important;
            color: #94a3b8 !important;
            text-decoration: none !important;
            border-radius: 12px !important; 
            font-weight: 600 !important;
            font-size: 16px !important;           
            line-height: 24px !important;         
            background: transparent !important;
            border: none !important;
            text-align: left !important;
            width: 100% !important;
            cursor: pointer !important;
            box-sizing: border-box !important;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .nav-item:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.05) !important;
            transform: translateX(4px) !important;
        }

        .nav-item.active {
            color: #ffffff !important;
            background: linear-gradient(135deg, #7c3aed, #6366f1) !important; 
            box-shadow: 0 10px 20px -5px rgba(124, 58, 237, 0.4) !important;
        }

        .nav-item-icon {
            font-size: 18px !important;
            display: inline-block !important;
            width: 24px !important;
            text-align: center !important;
        }

        .nav-footer {
            border-top: 1px solid rgba(255, 255, 255, 0.06) !important;
            padding-top: 20px !important;
        }

        /* 📦 CENTERING CONTENT WRAPPER CHASSIS */
        .main-dashboard-wrapper {
            flex-grow: 1;
            margin-left: 260px;
            padding: 50px 40px;
            box-sizing: border-box;
            min-height: 100vh;
            width: calc(100% - 260px);
            transition: all 0.3s ease;
        }

        /* Centered bounded field container layout */
        .centered-content-container {
            max-width: 1050px;
            margin: 0 auto;
        }

        /* 📱 MOBILE HEADER */
        .mobile-header {
            display: none;
            background: var(--dark-sidebar);
            color: white;
            padding: 14px 20px;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 105;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .mobile-menu-toggle {
            background: transparent;
            border: none;
            color: white;
            font-size: 22px;
            cursor: pointer;
        }

        /* ✨ MODERNIZED COMPACT GLASS MASTER CARD */
        .modern-master-card {
            background: var(--bg-surface);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.06), 0 0 0 1px rgba(15, 23, 42, 0.02);
            border: 1px solid var(--border-color);
        }

        /* 📐 COMPACT RESPONSIVE FORM GRID GRID */
        .modern-form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 32px;
        }

        .form-section-title {
            grid-column: span 2;
            font-size: 14px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 10px 0 0 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .full-width-field {
            grid-column: span 2;
        }

        .field-group-half {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        /* ✍️ SHARPER INPUT ELEMENT FRAMEWORK */
        .premium-input-field {
            width: 100%;
            padding: 13px 16px;
            border-radius: 10px;
            border: 1px solid #cbd5e1;
            font-size: 14px;
            color: var(--text-main);
            outline: none;
            background-color: #f8fafc;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .premium-input-field:hover {
            border-color: #94a3b8;
            background-color: #ffffff;
        }

        .premium-input-field:focus {
            border-color: var(--input-focus);
            background-color: #ffffff;
            box-shadow: 0 0 0 4px var(--primary-glow);
        }

        .premium-input-label {
            display: block; 
            font-weight: 600; 
            margin-bottom: 8px; 
            color: #475569;
            font-size: 13px;
        }

        /* 🚀 INTEGRATED UTILITY ACTION FOOTER */
        .card-action-footer {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: flex-end;
        }

        .btn-submit-save {
            width: auto;
            min-width: 240px;
            background: var(--primary-grad);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 4px 14px rgba(124, 58, 237, 0.25);
            transition: all 0.2s ease;
        }

        .btn-submit-save:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(124, 58, 237, 0.35);
        }

        /* MEDIA QUERIES FOR SCREEN RESIZING RESPONSES */
        @media (max-width: 992px) {
            .modern-form-grid { grid-template-columns: 1fr; gap: 24px; }
            .form-section-title, .full-width-field { grid-column: span 1; }
        }

        @media (max-width: 768px) {
            .sidebar-nav { transform: translateX(-100%) !important; }
            .sidebar-nav.active { transform: translateX(0) !important; }
            .main-dashboard-wrapper { margin-left: 0; padding: 90px 16px 30px 16px; width: 100%; }
            .mobile-header { display: flex; }
            .modern-master-card { padding: 25px 20px; }
            .field-group-half { grid-template-columns: 1fr; }
            .btn-submit-save { width: 100%; }
        }
    </style>
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