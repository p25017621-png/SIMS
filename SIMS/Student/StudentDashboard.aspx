<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Shared/Dashboard.Master"
    AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="SIMS.Student.StudentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style type="text/css">
        /* 🖥️ SCREEN ONLY STYLES (Enforces perfect full-screen scrolling and padding) */
        .main-dashboard-wrapper {
            width: 100%; 
            max-height: 88vh; /* Lifted the viewing ceiling for better monitor fitting */
            overflow-y: auto !important; /* Forces native scrollbar when content overflows */
            padding: 10px 10px 60px 10px; /* Deep 60px bottom padding to prevent cutoff text */
            box-sizing: border-box;
            scroll-behavior: smooth;
        }

        .dashboard-grid-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-top: 20px;
        }

        /* Responsive Breakpoint for smaller viewports */
        @media (max-width: 1100px) {
            .dashboard-grid-container {
                grid-template-columns: 1fr; 
            }
        }

        /* 🖨️ PRINT ONLY CONFIGURATIONS */
        @media print {
            @page {
                size: A4 portrait;
                margin: 20mm 15mm 20mm 15mm;
            }
            
            body {
                background: #ffffff !important;
                color: #000000 !important;
                font-family: 'Times New Roman', Times, serif !important;
                font-size: 12pt !important;
                line-height: 1.5 !important;
            }

            /* Completely strip browser height limitations and scroll bars during print execution */
            .main-dashboard-wrapper {
                max-height: none !important;
                overflow-y: visible !important;
                padding: 0 !important;
            }

            /* Hide specific web interfaces */
            .sidebar, 
            .navbar, 
            .nav-menu,
            #btnLogout, 
            .btn, 
            .course-management-section, 
            .screen-only-profile,
            hr,
            .print-hidden-btn {
                display: none !important;
            }

            /* Force content blocks to layout flat on the printed transcript page */
            .printable-profile-area, 
            .dashboard-grid-container,
            .dashboard-grid-container > div {
                display: block !important;
                visibility: visible !important;
                width: 100% !important;
            }

            .glass-card {
                background: none !important;
                box-shadow: none !important;
                padding: 0 !important;
                margin: 0 !important;
                border: none !important;
            }

            /* Display Institutional Header Block */
            .printable-title {
                display: block !important;
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 3px double #000000;
                padding-bottom: 12px;
            }
            .printable-title h2 { 
                margin: 0; 
                font-size: 18pt !important; 
                font-family: 'Georgia', serif;
                font-weight: bold;
                letter-spacing: 0.5px;
                text-transform: uppercase; 
            }
            .printable-title h4 { 
                margin: 5px 0 0 0; 
                font-size: 12pt !important; 
                color: #333333; 
                font-weight: normal;
                font-style: italic;
            }

            /* Profile Table Styling */
            .printable-profile-area {
                margin-bottom: 35px !important;
                border: 1px solid #000000 !important;
                padding: 15px !important;
                background: transparent !important;
            }
            
            .profile-meta-table {
                display: table !important;
                width: 100% !important;
            }
            .profile-meta-row {
                display: table-row !important;
            }
            .profile-meta-cell {
                display: table-cell !important;
                padding: 4px 8px !important;
                font-size: 11pt !important;
            }
            .profile-meta-cell span {
                display: inline !important;
            }

            /* Formatting GridViews into crisp transcript tables */
            .dashboard-grid-container h3 {
                font-size: 12pt !important;
                font-weight: bold;
                text-transform: uppercase;
                margin-bottom: 8px !important;
                border-bottom: 1px solid #000000;
                padding-bottom: 3px;
                color: #000000 !important;
                margin-top: 20px !important;
            }

            table {
                width: 100% !important;
                border-collapse: collapse !important;
                margin-bottom: 15px !important;
            }
            th {
                background-color: #f2f2f2 !important;
                color: #000000 !important;
                border: 1px solid #000000 !important;
                font-weight: bold !important;
                font-size: 11pt !important;
                padding: 6px 8px !important;
                text-transform: uppercase;
            }
            td {
                border: 1px solid #000000 !important;
                font-size: 11pt !important;
                padding: 6px 8px !important;
                background: transparent !important;
                color: #000000 !important;
            }

            /* Signature Footer */
            .print-footer-signature {
                display: block !important;
                margin-top: 60px;
                width: 100%;
            }
            .signature-table {
                display: table;
                width: 100%;
            }
            .signature-row {
                display: table-row;
            }
            .signature-cell {
                display: table-cell;
                width: 50%;
                vertical-align: bottom;
            }
            .signature-line {
                width: 200px;
                border-bottom: 1px solid #000000;
                margin-bottom: 5px;
            }
        }

        /* Default Screen Visibility States (Hidden inside web browsers) */
        .printable-title, .print-footer-signature, .profile-meta-table {
            display: none;
        }
    </style>

    <div class="main-dashboard-wrapper">
        
        <div class="glass-card" style="background: rgba(255, 255, 255, 0.7); backdrop-filter: blur(10px); padding: 30px; margin-bottom: 15px; border-radius: 24px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.05); border: 1px solid rgba(255, 255, 255, 0.18);">
            
            <div class="printable-title">
                <h2>Student Information Management System (SIMS)</h2>
                <h4>Official Academic Progress Report</h4>
            </div>

            <div class="printable-profile-area" style="margin-bottom: 25px;">
                <div class="screen-only-profile" style="display: flex; justify-content: space-between; align-items: flex-start; width: 100%;">
                    <div>
                        <p style="color: #666; margin: 4px 0; font-size: 1.05rem;">
                            <strong>ID:</strong> <asp:Label ID="lblStudentID" runat="server"></asp:Label> | 
                            <strong>Email:</strong> <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </p>
                        <p style="color: #666; margin: 4px 0; font-size: 1.05rem;">
                            <strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server"></asp:Label> | 
                            <strong>Address:</strong> <asp:Label ID="lblAddress" runat="server"></asp:Label>
                        </p>
                    </div>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn"
                        Style="background-color: #dc3545; color: white; border: none; padding: 8px 18px; border-radius: 8px; cursor: pointer; font-weight: 600;" />
                </div>
                
                <div class="profile-meta-table">
                    <div class="profile-meta-row">
                        <div class="profile-meta-cell"><strong>Student Name:</strong></div>
                        <div class="profile-meta-cell"><asp:Label ID="lblPrintName" runat="server"><%= lblStudentName.Text %></asp:Label></div>
                        <div class="profile-meta-cell"><strong>Student ID:</strong></div>
                        <div class="profile-meta-cell"><asp:Label ID="lblPrintID" runat="server"><%= lblStudentID.Text %></asp:Label></div>
                    </div>
                    <div class="profile-meta-row">
                        <div class="profile-meta-cell"><strong>Email Address:</strong></div>
                        <div class="profile-meta-cell"><asp:Label ID="lblPrintEmail" runat="server"><%= lblEmail.Text %></asp:Label></div>
                        <div class="profile-meta-cell"><strong>Phone Number:</strong></div>
                        <div class="profile-meta-cell"><asp:Label ID="lblPrintPhone" runat="server"><%= lblPhone.Text %></asp:Label></div>
                    </div>
                    <div class="profile-meta-row">
                        <div class="profile-meta-cell"><strong>Mailing Address:</strong></div>
                        <div class="profile-meta-cell" colspan="3"><asp:Label ID="lblPrintAddress" runat="server"><%= lblAddress.Text %></asp:Label></div>
                    </div>
                </div>
                <div style="display:none;"><asp:Label ID="lblStudentName" runat="server" Text="Student"></asp:Label></div>
            </div>

            <div class="course-management-section" style="margin-bottom: 30px;">
                <asp:Label ID="lblStatusMessage" runat="server" Visible="false" Style="padding: 12px; display: block; border-radius: 8px; margin-bottom: 15px; font-weight: bold;"></asp:Label>
                
                <h3 style="margin-top: 0; color: #333;">📢 System Announcements</h3>
                <asp:Repeater ID="rptAnnouncements" runat="server">
                    <ItemTemplate>
                        <div style="background: white; padding: 15px; border-radius: 12px; margin-bottom: 10px; border-left: 5px solid #6f42c1; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
                            <strong style="color: #333;"><%# Eval("title") %></strong> <span style="font-size: 0.85em; color: #888;">(<%# Eval("datePosted", "{0:dd MMM yyyy}") %>)</span>
                            <p style="margin: 5px 0 0 0; color: #555; font-size: 0.95rem;"><%# Eval("message") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="course-management-section" style="margin-bottom: 30px;">
                <h3 style="color: #333;">📚 Course Management</h3>
                <div style="background: white; padding: 20px; border-radius: 16px; margin-bottom: 20px; display: flex; gap: 15px; align-items: center; box-shadow: 0 2px 8px rgba(0,0,0,0.02);">
                    <label style="font-weight: 600; color: #444;">Register a New Course:</label>
                    <asp:DropDownList ID="ddlAvailableCourses" runat="server" Style="padding: 8px 12px; border-radius: 8px; border: 1px solid #ddd; min-width: 260px;"></asp:DropDownList>
                    <asp:Button ID="btnRegisterCourse" runat="server" Text="Enroll Course" OnClick="btnRegisterCourse_Click" CssClass="btn"
                        Style="background-color: #28a745; color: white; border: none; padding: 9px 18px; border-radius: 8px; cursor: pointer; font-weight: 600;" />
                </div>

                <h4 style="color: #555; margin-bottom: 10px;">Your Enrolled Courses</h4>
                <asp:GridView ID="gvEnrolledCourses" runat="server" AutoGenerateColumns="False" OnRowCommand="gvEnrolledCourses_RowCommand"
                    DataKeyNames="courseID" Width="100%" CellPadding="12" GridLines="None" Style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.03);">
                    <HeaderStyle BackColor="#f8f9fa" Font-Bold="True" ForeColor="#444" Height="45px" />
                    <RowStyle Height="45px" ForeColor="#555555" BorderColor="#f1f1f1" BorderWidth="1px" BorderStyle="Solid" />
                    <Columns>
                        <asp:BoundField DataField="courseName" HeaderText="Course Name" ItemStyle-Font-Bold="true" />
                        <asp:BoundField DataField="description" HeaderText="Description" />
                        <asp:BoundField DataField="credits" HeaderText="Credits" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Button ID="btnDrop" runat="server" Text="Drop" CommandName="DropCourse" CommandArgument='<%# Eval("courseID") %>' CssClass="btn"
                                    OnClientClick="return confirm('Are you sure you want to drop this course?');"
                                    Style="background-color: #dc3545; color: white; border: none; padding: 6px 14px; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 0.85rem;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="dashboard-grid-container">
                
                <div style="background: white; padding: 20px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.03);">
                    <h3 style="margin-top: 0; color: #333; margin-bottom: 15px;">📅 Attendance Summary</h3>
                    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="12" GridLines="None" 
                        Style="background: white; border-radius: 12px; overflow: hidden;">
                        <HeaderStyle BackColor="#f8f9fa" Font-Bold="True" ForeColor="#444" />
                        <RowStyle BorderColor="#f1f1f1" BorderWidth="1px" BorderStyle="Solid" ForeColor="#555" />
                        <Columns>
                            <asp:BoundField DataField="courseName" HeaderText="Course" ItemStyle-Font-Bold="true" />
                            <asp:BoundField DataField="TotalClasses" HeaderText="Total Classes" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="PresentDays" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Attendance %" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <span style='<%# Convert.ToDouble(Eval("AttendancePercentage")) < 75.0 ? "color: #dc3545; font-weight: bold;" : "color: #28a745; font-weight: bold;" %>'>
                                        <%# Eval("AttendancePercentage", "{0:F1}") %>%
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div style="background: white; padding: 20px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.03);">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                        <h3 style="margin: 0; color: #333;">✍️ Academic Performance</h3>
                        <button type="button" onclick="window.print();" class="btn print-hidden-btn" style="background: #6c757d; color: white; border: none; padding: 7px 14px; border-radius: 8px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 5px;">
                            🖨️ Print Transcript
                        </button>
                    </div>
                    <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="12" GridLines="None"
                        Style="background: white; border-radius: 12px; overflow: hidden;">
                        <HeaderStyle BackColor="#f8f9fa" Font-Bold="True" ForeColor="#444" />
                        <RowStyle BorderColor="#f1f1f1" BorderWidth="1px" BorderStyle="Solid" ForeColor="#555" />
                        <Columns>
                            <asp:BoundField DataField="courseName" HeaderText="Course" ItemStyle-Font-Bold="true" />
                            <asp:BoundField DataField="score" HeaderText="Score" DataFormatString="{0:F2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="remarks" HeaderText="Remarks" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                </div>

            </div>

            <div class="print-footer-signature">
                <div class="signature-table">
                    <div class="signature-row">
                        <div class="signature-cell">
                            <div class="signature-line"></div>
                            <p style="margin:0; font-size:10pt;">Student Signature</p>
                            <p style="margin:0; font-size:9pt; color:#666;">Date: _______________</p>
                        </div>
                        <div class="signature-cell" style="text-align: right;">
                            <div class="signature-line" style="margin-left: auto;"></div>
                            <p style="margin:0; font-size:10pt;">University Registrar Verification</p>
                            <p style="margin:0; font-size:9pt; color:#666;">Official Institutional Seal</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>