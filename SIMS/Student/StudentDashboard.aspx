<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="SIMS.Student.StudentDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Dashboard - SIMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style type="text/css">
        /* 🖥️ ROOT VARIABLES & CONFIGURATIONS */
:root {
    --primary-grad: linear-gradient(135deg, #7c3aed, #4f46e5);
    --dark-sidebar: #0f172a; /* Richer, deeper slate midnight blue */
    --slate-light: #f8fafc;
    --border-color: rgba(226, 232, 240, 0.7);
    --text-main: #0f172a;
    --text-muted: #475569;
}

body {
    margin: 0;
    padding: 0;
    background-color: #f1f5f9; /* Slightly darker background to make white cards pop */
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    -webkit-font-smoothing: antialiased; /* Smoother, high-end text rendering */
    -moz-osx-font-smoothing: grayscale;
    display: flex;
    min-height: 100vh;
    color: var(--text-main);
}

        .app-container {
            display: flex;
            width: 100%;
        }

        /* 🧭 SIDEBAR SYSTEM */
        .sidebar-nav {
            width: 260px;
            background: var(--dark-sidebar);
            color: #f8fafc;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 24px 16px;
            box-sizing: border-box;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            box-shadow: 4px 0 25px rgba(0,0,0,0.05);
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 12px;
            margin-bottom: 30px;
        }

        .brand-logo {
            background: var(--primary-grad);
            width: 38px;
            height: 38px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
            color: white;
            box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3);
        }

        .brand-name {
            font-size: 18px;
            font-weight: 700;
            letter-spacing: 0.5px;
            background: linear-gradient(to right, #ffffff, #cbd5e1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex-grow: 1;
        }

.nav-item {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 18px;
    color: #94a3b8;
    text-decoration: none;
    border-radius: 12px; /* Matching the updated card curves */
    font-weight: 600;
    font-size: 16px; 
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1); /* Premium ease curve */
    cursor: pointer;
    border: none;
    background: transparent;
    text-align: left;
    width: 100%;
    box-sizing: border-box;
}

.nav-item:hover {
    color: #ffffff;
    background: rgba(255, 255, 255, 0.05);
    transform: translateX(4px);
}

.nav-item.active {
    color: #ffffff;
    background: linear-gradient(135deg, #7c3aed, #6366f1); /* Gradient instead of flat purple */
    box-shadow: 0 10px 20px -5px rgba(124, 58, 237, 0.4);
}

.nav-item-icon {
    font-size: 18px; /* Balanced perfectly with the 16px text font */
}

        .nav-footer {
            border-top: 1px solid rgba(255, 255, 255, 0.06);
            padding-top: 20px;
        }

        /* 📦 MAIN CONTENT WORKSPACE */
        .main-dashboard-wrapper {
            flex-grow: 1;
            margin-left: 260px;
            padding: 40px;
            box-sizing: border-box;
            min-height: 100vh;
            background: #f8fafc;
            transition: all 0.3s ease;
        }

.glass-card {
    background: #ffffff;
    padding: 40px;
    border-radius: 20px; /* Slightly rounder for a modern aesthetic */
    /* Premium layered shadow effect */
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05), 
                0 10px 15px -3px rgba(15, 23, 42, 0.03), 
                0 4px 6px -4px rgba(15, 23, 42, 0.03);
    border: 1px solid var(--border-color);
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

        /* 👤 STUDENT IDENTITY AREA */
        .profile-hero-section {
            background: var(--primary-grad);
            padding: 28px 32px;
            border-radius: 16px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.15);
        }

        /* 📊 VISUAL ANALYTIC METRICS */
.stats-counters-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
    margin-bottom: 35px;
}

.stat-card { 
    padding: 24px; 
    border-radius: 16px; 
    background: #ffffff;
    color: var(--text-main); /* Dark elegant text instead of white */
    border: 1px solid var(--border-color);
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02), 0 2px 4px -2px rgba(0, 0, 0, 0.02);
    transition: all 0.25s ease;
    position: relative;
    overflow: hidden;
}

.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 20px 25px -5px rgba(0,0,0,0.05);
}

/* Premium indicator bars on top of the cards */
.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
}

.bg-blue::before { background: #3b82f6; }
.bg-green::before { background: #10b981; }
.bg-purple::before { background: #7c3aed; }

/* Adjust the text colors inside the card to look balanced */
.stat-card h4 {
    color: var(--text-muted) !important;
}
.stat-card p {
    color: var(--text-main) !important;
}

        /* 🗃️ DATA GRIDS AND INTERFACES */
        .dashboard-grid-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-top: 20px;
        }

        .section-heading {
            margin-top: 0; 
            color: var(--text-main); 
            font-size: 1.2rem; 
            margin-bottom: 18px; 
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .custom-table-container {
            background: white; 
            border-radius: 12px; 
            overflow: hidden; 
            border: 1px solid var(--border-color);
        }

        .progress-track { 
            background: #e2e8f0; 
            border-radius: 10px; 
            height: 8px; 
            width: 100px; 
            display: inline-block; 
            overflow: hidden; 
            vertical-align: middle; 
            margin-right: 8px; 
        }
        .progress-bar { height: 100%; border-radius: 10px; transition: width 0.4s ease; }

        /* 🖨️ PRINT RULES */
        @media print {
            @page { size: A4 portrait; margin: 20mm 15mm; }
            body { background: #ffffff !important; color: #000000 !important; font-family: 'Times New Roman', serif !important; font-size: 11pt !important; }
            .sidebar-nav, .mobile-header, .course-registration-gateway, .screen-only-profile, .stats-counters-container, .announcements-panel-wrapper, .print-hidden-btn, .progress-track, [id*="btnDrop"] {
                display: none !important;
            }
            .main-dashboard-wrapper { margin-left: 0 !important; padding: 0 !important; }
            .glass-card { border: none !important; padding: 0 !important; box-shadow: none !important; }
            .printable-title { display: block !important; text-align: center; margin-bottom: 25px; border-bottom: 2px solid #000000; padding-bottom: 10px; }
            .printable-profile-area { display: block !important; margin-bottom: 30px !important; border: 1px solid #000000 !important; padding: 15px !important; }
            .profile-meta-table { display: table !important; width: 100% !important; border-collapse: collapse !important; }
            .profile-meta-row { display: table-row !important; }
            .profile-meta-cell { display: table-cell !important; padding: 6px !important; border: none !important; font-size: 11pt !important; }
            .dashboard-grid-container { display: block !important; }
            .custom-table-container { border: none !important; margin-bottom: 20px; }
            table { width: 100% !important; border-collapse: collapse !important; }
            th { background: #f2f2f2 !important; border: 1px solid #000000 !important; color: black !important; padding: 8px !important; text-transform: uppercase; font-size: 10pt !important; }
            td { border: 1px solid #000000 !important; padding: 8px !important; background: transparent !important; }
            .print-footer-signature { display: block !important; margin-top: 50px; }
        }

        .printable-title, .print-footer-signature, .profile-meta-table { display: none; }

        /* RESPONSIVE LAYOUT RESPONSES */
        @media (max-width: 1100px) {
            .dashboard-grid-container { grid-template-columns: 1fr; }
        }
        @media (max-width: 768px) {
            .sidebar-nav { transform: translateX(-100%); }
            .sidebar-nav.active { transform: translateX(0); }
            .main-dashboard-wrapper { margin-left: 0; padding: 90px 20px 40px 20px; }
            .mobile-header { display: flex; }
            .stats-counters-container { grid-template-columns: 1fr; }
            .course-registration-gateway { flex-direction: column; align-items: stretch !important; }
        }
        /* Custom GridView Header Line */
.gv-header th {
    border-bottom: 1px solid #e2e8f0 !important;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    font-weight: 700 !important;
    color: #475569 !important;
}

/* Give the rows a clean hover effect */
.custom-table-container tr {
    transition: background-color 0.2s ease;
}

.custom-table-container tr:hover {
    background-color: #f8fafc; /* Rows highlight softly when tracking across data */
}
/* Custom Scrollbar for Chrome, Safari, and Edge */
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-track {
    background: #f1f5f9;
}

::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}
/* Premium DropDown Styling */
select[id*="ddlAvailableCourses"] {
    padding: 12px 16px !important;
    border-radius: 10px !important;
    border: 1px solid var(--border-color) !important;
    font-size: 14px !important;
    color: var(--text-main) !important;
    background-color: #ffffff !important;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05) !important;
    transition: all 0.2s ease !important;
    outline: none !important;
}

select[id*="ddlAvailableCourses"]:focus {
    border-color: #7c3aed !important;
    box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.15) !important;
}

/* Premium Button Transitions */
input[type="submit"].btn, button.btn {
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.05) !important;
}

input[type="submit"].btn:hover {
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25) !important;
    filter: brightness(105%);
}

/* Specialized Drop Button Hover Styles */
[id*="btnDrop"]:hover {
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.25) !important;
    filter: brightness(105%);
}
/* Row Interactivity */
.custom-table-container table tbody tr:not(:first-child) {
    cursor: pointer;
    transition: background-color 0.15s ease, transform 0.1s ease;
}

.custom-table-container table tbody tr:not(:first-child):hover {
    background-color: #f8fafc !important;
}
/* Remarks Status Badges */
.badge-status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 9999px;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    text-align: center;
}

.badge-success { background-color: #dcfce7; color: #166534; }
.badge-warning { background-color: #fef3c7; color: #92400e; }
.badge-danger { background-color: #fee2e2; color: #991b1b; }
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
                    <asp:LinkButton ID="lnkSidebarLogout" runat="server" OnClick="btnLogout_Click" CssClass="nav-item" Style="color: #ef4444;">
                        <span class="nav-item-icon">🚪</span> Sign Out
                    </asp:LinkButton>
                </div>
            </nav>

            <div class="main-dashboard-wrapper">
                <!-- Dashboard Top Meta Navigation Info -->
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;" class="screen-only-profile">
    <div>
        <h1 style="margin: 0; font-size: 24px; font-weight: 700; color: var(--text-main);">Academic Workspace</h1>
        <p style="margin: 4px 0 0 0; font-size: 13px; color: var(--text-muted);">SIMS Institutional Portal &bull; Live Academic Records</p>
    </div>
    <div style="background: white; padding: 8px 16px; border-radius: 10px; border: 1px solid var(--border-color); font-size: 13px; font-weight: 600; color: var(--text-muted); display: flex; align-items: center; gap: 8px;">
        <span style="height: 8px; width: 8px; background-color: #10b981; border-radius: 50%; display: inline-block;"></span>
        System Connected
    </div>
</div>
                <div class="glass-card">
                    
                    <div class="printable-title">
                        <h2>Student Information Management System (SIMS)</h2>
                        <h4>Official Academic Progress Report</h4>
                    </div>

                    <div class="profile-hero-section screen-only-profile">
                        <h2 style="margin: 0 0 8px 0; font-size: 1.75rem; font-weight: 700;">
                            Welcome back, <asp:Label ID="lblStudentName" runat="server" Text="Student" />!
                        </h2>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 12px; font-size: 0.95rem; opacity: 0.9;">
                            <div><strong>Student ID:</strong> <asp:Label ID="lblStudentID" runat="server" /></div>
                            <div><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></div>
                            <div><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" /></div>
                            <div><strong>Mailing Address:</strong> <asp:Label ID="lblAddress" runat="server" /></div>
                        </div>
                    </div>

                    <div class="printable-profile-area">
                        <div class="profile-meta-table">
                            <div class="profile-meta-row">
                                <div class="profile-meta-cell"><strong>Student Name:</strong></div>
                                <div class="profile-meta-cell"><%= lblStudentName.Text %></div>
                                <div class="profile-meta-cell"><strong>Student ID:</strong></div>
                                <div class="profile-meta-cell"><%= lblStudentID.Text %></div>
                            </div>
                            <div class="profile-meta-row">
                                <div class="profile-meta-cell"><strong>Email Address:</strong></div>
                                <div class="profile-meta-cell"><%= lblEmail.Text %></div>
                                <div class="profile-meta-cell"><strong>Phone Number:</strong></div>
                                <div class="profile-meta-cell"><%= lblPhone.Text %></div>
                            </div>
                            <div class="profile-meta-row">
                                <div class="profile-meta-cell"><strong>Mailing Address:</strong></div>
                                <div class="profile-meta-cell" colspan="3"><%= lblAddress.Text %></div>
                            </div>
                        </div>
                    </div>

                    <div class="stats-counters-container">
                        <div class="stat-card bg-blue">
                            <h4 style="margin: 0; opacity: 0.85; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600;">Enrolled Modules</h4>
                            <p style="font-size: 32px; font-weight: 700; margin: 4px 0 0 0;"><asp:Literal ID="litCourseCount" runat="server" Text="0" /></p>
                        </div>
                        <div class="stat-card bg-green">
                            <h4 style="margin: 0; opacity: 0.85; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600;">Attendance Rate</h4>
                            <p style="font-size: 32px; font-weight: 700; margin: 4px 0 0 0;"><asp:Literal ID="litAttendanceRate" runat="server" Text="0%" /></p>
                        </div>
                        <div class="stat-card bg-purple">
                            <h4 style="margin: 0; opacity: 0.85; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600;">Calculated CGPA</h4>
                            <p style="font-size: 32px; font-weight: 700; margin: 4px 0 0 0;"><asp:Literal ID="litCGPA" runat="server" Text="0.00" /></p>
                        </div>
                    </div>

                    <div class="announcements-panel-wrapper" style="margin-bottom: 35px;">
                        <asp:Label ID="lblStatusMessage" runat="server" Visible="false" Style="padding: 12px 18px; display: block; border-radius: 8px; margin-bottom: 15px; font-weight: bold; font-size: 14px; background-color: #fee2e2; color: #ef4444; border: 1px solid #fca5a5;"></asp:Label>
                        
                        <h3 class="section-heading">📢 System Announcements</h3>
                        <asp:Repeater ID="rptAnnouncements" runat="server">
                            <ItemTemplate>
                                <div style="background: #f8fafc; padding: 18px; border-radius: 12px; margin-bottom: 12px; border-left: 4px solid #7c3aed; border-top: 1px solid var(--border-color); border-right: 1px solid var(--border-color); border-bottom: 1px solid var(--border-color);">
                                    <strong style="color: var(--text-main); font-size: 0.95rem;"><%# Eval("title") %></strong> 
                                    <span style="font-size: 0.85em; color: var(--text-muted); margin-left: 6px;"><%# Eval("datePosted", "{0:dd MMM yyyy}") %></span>
                                    <p style="margin: 8px 0 0 0; color: #475569; font-size: 0.9rem; line-height: 1.5;"><%# Eval("message") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="course-management-section enrolled-courses-panel-wrapper" style="margin-bottom: 35px;">
                        <h3 class="section-heading">📚 Course Enrollment Hub</h3>
                        
                        <div class="course-registration-gateway" style="background: #f8fafc; padding: 20px; border-radius: 12px; margin-bottom: 20px; display: flex; gap: 15px; align-items: center; border: 1px solid var(--border-color);">
                            <label style="font-weight: 600; color: #475569; font-size: 13px; white-space: nowrap;">Register a New Course:</label>
                            <asp:DropDownList ID="ddlAvailableCourses" runat="server" Style="padding: 10px 14px; border-radius: 8px; border: 1px solid #cbd5e1; flex-grow: 1; font-size:13px; color:#333; background:#fff; min-width: 200px;"></asp:DropDownList>
                            <asp:Button ID="btnRegisterCourse" runat="server" Text="Enroll Course" OnClick="btnRegisterCourse_Click" CssClass="btn"
                                Style="background-color: #10b981; color: white; border: none; padding: 11px 24px; border-radius: 8px; cursor: pointer; font-weight: 600; font-size: 13px; transition: background 0.2s; white-space: nowrap;" />
                        </div>

                        <h4 style="color: var(--text-muted); margin-bottom: 12px; font-weight: 600; font-size: 14px;">Your Enrolled Courses Matrix</h4>
                        <div class="custom-table-container">
                            <asp:GridView ID="gvEnrolledCourses" runat="server" AutoGenerateColumns="False" OnRowCommand="gvEnrolledCourses_RowCommand"
                                DataKeyNames="courseID" Width="100%" CellPadding="14" GridLines="None">
                               <HeaderStyle BackColor="#f8fafc" Font-Bold="True" ForeColor="#475569" Height="48px" Font-Size="12px" CssClass="gv-header" />
                                <RowStyle Height="50px" ForeColor="#334155" BorderColor="#f1f5f9" BorderWidth="1px" BorderStyle="Solid" Font-Size="13px" />
                                <Columns>
                                    <asp:BoundField DataField="courseName" HeaderText="Course Name" ItemStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="description" HeaderText="Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="credits" HeaderText="Credits" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" />
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Button ID="btnDrop" runat="server" Text="Drop" CommandName="DropCourse" CommandArgument='<%# Eval("courseID") %>' CssClass="btn"
                                                OnClientClick="return confirm('Are you sure you want to drop this course module?');" 
                                                Style="background-color: #ef4444; color: white; border: none; padding: 6px 14px; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 0.8rem;" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                    <div class="dashboard-grid-container">
                        
                        <div>
                            <h3 class="section-heading">📅 Attendance Detailed Breakdown</h3>
                            <div class="custom-table-container" style="padding: 8px;">
                                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="12" GridLines="None">
                                    <HeaderStyle BackColor="#f8fafc" Font-Bold="True" ForeColor="#475569" Height="44px" Font-Size="12px" />
                                    <RowStyle BorderColor="#f1f5f9" BorderWidth="1px" BorderStyle="Solid" ForeColor="#334155" Height="48px" Font-Size="13px" />
                                    <Columns>
                                        <asp:BoundField DataField="courseName" HeaderText="Course" ItemStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="TotalClasses" HeaderText="Classes" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" />
                                        <asp:BoundField DataField="PresentDays" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" />
                                        <asp:TemplateField HeaderText="Rate %" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="180px">
                                            <ItemTemplate>
                                                <div style="display: inline-flex; align-items: center; justify-content: flex-end; width: 100%; gap: 10px;">
                                                    <div class="progress-track screen-only-profile">
                                                        <div class="progress-bar" style='<%# "width: " + Eval("AttendancePercentage") + "%; background-color: " + (Convert.ToDouble(Eval("AttendancePercentage")) >= 85 ? "#10b981" : Convert.ToDouble(Eval("AttendancePercentage")) >= 75 ? "#f59e0b" : "#ef4444") + ";" %>'></div>
                                                    </div>
                                                    <span style='<%# Convert.ToDouble(Eval("AttendancePercentage")) < 75.0 ? "color: #ef4444; font-weight: bold;" : "color: #10b981; font-weight: bold;" %>'>
                                                        <%# Eval("AttendancePercentage", "{0:F1}") %>%
                                                    </span>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        <div>
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                                <h3 class="section-heading" style="margin: 0;">✍️ Academic Score Sheet</h3>
                                <button type="button" onclick="window.print();" class="btn print-hidden-btn" style="background: #64748b; color: white; border: none; padding: 8px 16px; border-radius: 8px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 6px; font-size: 12px; transition: background 0.2s;">
                                    𖤖 Print Report Card
                                </button>
                            </div>
                            <div class="custom-table-container" style="padding: 8px;">
                                <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="12" GridLines="None" OnRowDataBound="gvMarks_RowDataBound">
                                    <HeaderStyle BackColor="#f8fafc" Font-Bold="True" ForeColor="#475569" Height="44px" Font-Size="12px" />
                                    <RowStyle BorderColor="#f1f5f9" BorderWidth="1px" BorderStyle="Solid" ForeColor="#334155" Height="48px" Font-Size="13px" />
                                    <Columns>
                                        <asp:BoundField DataField="courseName" HeaderText="Course" ItemStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="score" HeaderText="Score" DataFormatString="{0:F1}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" />
                                        <asp:TemplateField HeaderText="Remarks" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="120px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRemarksBadge" runat="server" Text='<%# Eval("remarks") %>' Style="font-weight: 600;" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                    </div>

                    <div class="print-footer-signature">
                        <div class="signature-table">
                            <div class="signature-row">
                                <div class="signature-cell">
                                    <div style="width: 200px; border-bottom: 1px solid #000000; margin-bottom: 5px;"></div>
                                    <p style="margin:0; font-size:10pt; font-weight: bold;">Student Signature</p>
                                    <p style="margin:0; font-size:9pt; color:#666;">Date: _______________</p>
                                </div>
                                <div class="signature-cell" style="text-align: right;">
                                    <div style="width: 200px; border-bottom: 1px solid #000000; margin-bottom: 5px; margin-left: auto;"></div>
                                    <p style="margin:0; font-size:10pt; font-weight: bold;">University Registrar Verification</p>
                                    <p style="margin:0; font-size:9pt; color:#666;">Official Institutional Seal</p>
                                </div>
                            </div>
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