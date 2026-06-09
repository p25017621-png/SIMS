<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Lecturers.aspx.cs" Inherits="SIMS.Lecturers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lecturers Directory - SIMS</title>
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

        /* 🧭 SIDEBAR NAV CHASSIS (ALIGNED ARCHITECTURE) */
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
    display: flex !important;          /* Fixed */
    align-items: center !important;     /* Fixed */
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

        /* 📦 CENTERING CONTENT WORKSPACE WRAPPER */
        .main-dashboard-wrapper {
            flex-grow: 1;
            margin-left: 260px;
            padding: 50px 40px;
            box-sizing: border-box;
            min-height: 100vh;
            width: calc(100% - 260px);
            transition: all 0.3s ease;
        }

        .centered-content-container {
            max-width: 1100px;
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

        /* ✨ MODERNIZED GLASS CONTAINER CARD */
        .modern-master-card {
            background: var(--bg-surface);
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.04), 0 0 0 1px rgba(15, 23, 42, 0.01);
            border: 1px solid var(--border-color);
            margin-bottom: 30px;
        }

        /* 🔍 SEARCH AND FILTER CONTROL PANEL DECK */
        .filter-control-deck {
            display: flex;
            gap: 12px;
            margin-bottom: 30px;
            align-items: center;
            flex-wrap: wrap;
        }

        /* ✍️ PREMIUM FORM CHASSIS MATCHING */
        .premium-input-field {
            padding: 13px 18px !important;
            border-radius: 10px !important;
            border: 1px solid #cbd5e1 !important;
            font-size: 14px !important;
            color: var(--text-main) !important;
            outline: none !important;
            background-color: #f8fafc !important;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .premium-input-field:hover {
            border-color: #94a3b8 !important;
            background-color: #ffffff !important;
        }

        .premium-input-field:focus {
            border-color: var(--input-focus) !important;
            background-color: #ffffff !important;
            box-shadow: 0 0 0 4px var(--primary-glow) !important;
        }

        /* 🚀 UNIFIED BUTTON ACTION MOTIFS */
        .btn-action-trigger {
            padding: 13px 26px !important;
            border-radius: 10px !important;
            font-weight: 700 !important;
            font-size: 13px !important;
            cursor: pointer !important;
            border: none !important;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .btn-search-accent {
            background: #10b981 !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.15) !important;
        }

        .btn-search-accent:hover {
            transform: translateY(-1px) !important;
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.25) !important;
            filter: brightness(103%);
        }

        .btn-clear-muted {
            background: #64748b !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(100, 116, 139, 0.1) !important;
        }

        .btn-clear-muted:hover {
            transform: translateY(-1px) !important;
            box-shadow: 0 6px 16px rgba(100, 116, 139, 0.2) !important;
            filter: brightness(103%);
        }

        /* 📊 HIGHLY DESIGNED CUSTOM TABLE SYSTEM */
        .custom-table-container {
            background: white !important;
            border-radius: 12px !important;
            overflow: hidden !important;
            border: 1px solid var(--border-color) !important;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02) !important;
        }

        /* Deep GridView override targeting standard native generation elements */
        .custom-table-container table {
            border-collapse: collapse !important;
            width: 100% !important;
            margin: 0 !important;
        }

        .custom-table-container th {
            background-color: #f8fafc !important;
            color: #475569 !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.7px !important;
            font-size: 11px !important;
            padding: 16px 20px !important;
            border-bottom: 2px solid #e2e8f0 !important;
            border-top: none !important;
        }

        .custom-table-container td {
            padding: 16px 20px !important;
            color: #334155 !important;
            font-size: 13.5px !important;
            border-bottom: 1px solid #f1f5f9 !important;
        }

        /* Target data records exclusively avoiding header parameters */
        .custom-table-container tr:not(:first-child) {
            transition: background-color 0.2s ease !important;
            cursor: pointer !important;
        }

        .custom-table-container tr:not(:first-child):hover {
            background-color: #f8fafc !important;
        }

        /* Clean styling wrapper for Empty State Exceptions */
        .empty-grid-notice {
            padding: 40px 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
        }

        /* Custom Scrollbar system mechanics */
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* RESPONSIVE LAYOUT MATRIX CONTROLS */
        @media (max-width: 768px) {
            .sidebar-nav { transform: translateX(-100%) !important; }
            .sidebar-nav.active { transform: translateX(0) !important; }
            .main-dashboard-wrapper { margin-left: 0; padding: 90px 16px 30px 16px; width: 100%; }
            .mobile-header { display: flex; }
            .modern-master-card { padding: 25px 20px; }
            .premium-input-field { width: 100% !important; }
            .filter-control-deck { flex-direction: column; align-items: stretch; gap: 10px; }
            .btn-action-trigger { width: 100% !important; text-align: center; }
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