<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="SIMS.Student.StudentDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Dashboard - SIMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="/Assets/CSS/Studentdashboard-styles.css" rel="stylesheet" type="text/css" />
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
                        <h2 style="margin: 0 0 4px 0; font-size: 1.75rem; font-weight: 700;">
                            Welcome back, <asp:Label ID="lblStudentName" runat="server" Text="Student" />!
                        </h2>
                        <p style="margin: 0 0 20px 0; font-size: 1.05rem; opacity: 0.95; font-weight: 600; color: #fef08a; display: flex; align-items: center; gap: 6px;">
                            <span>🎓</span> <asp:Label ID="lblTrack" runat="server" Text="Loading Track..." /> 
                            &bull; <span>📅</span> <asp:Label ID="lblTerm" runat="server" Text="Loading Term..." />
                        </p>
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
                                <div class="profile-meta-cell"><strong>Academic Program:</strong></div>
                                <div class="profile-meta-cell" style="font-weight: 600; color: #1e3a8a;"><%= lblTrack.Text %></div>
                                <div class="profile-meta-cell"><strong>Current Term:</strong></div>
                                <div class="profile-meta-cell" style="font-weight: 600;"><%= lblTerm.Text %></div>
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
                        
                        <div class="course-registration-gateway" style="background: #f8fafc; padding: 20px; border-radius: 12px; margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 15px; align-items: center; border: 1px solid var(--border-color);">
                            
                            <div style="display: flex; align-items: center; gap: 8px; flex-grow: 2; min-width: 250px;">
                                <label style="font-weight: 600; color: #475569; font-size: 13px; white-space: nowrap;">Course Catalog:</label>
                                <asp:DropDownList ID="ddlAvailableCourses" runat="server" Style="padding: 10px 14px; border-radius: 8px; border: 1px solid #cbd5e1; width: 100%; font-size:13px; color:#333; background:#fff;"></asp:DropDownList>
                            </div>

                            <div style="display: flex; align-items: center; gap: 8px; flex-grow: 1; min-width: 180px;">
                                <label style="font-weight: 600; color: #475569; font-size: 13px; white-space: nowrap;">Semester:</label>
                                <asp:DropDownList ID="ddlSemester" runat="server" Style="padding: 10px 14px; border-radius: 8px; border: 1px solid #cbd5e1; width: 100%; font-size:13px; color:#333; background:#fff;">
                                    <asp:ListItem Text="-- Select Semester --" Value="" />
                                    <asp:ListItem Text="Semester 1" Value="1" />
                                    <asp:ListItem Text="Semester 2" Value="2" />
                                    <asp:ListItem Text="Semester 3" Value="3" />
                                    <asp:ListItem Text="Semester 4" Value="4" />
                                    <asp:ListItem Text="Semester 5" Value="5" />
                                    <asp:ListItem Text="Semester 6" Value="6" />
                                </asp:DropDownList>
                            </div>

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