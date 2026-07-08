<%@ Page Title="Admin Dashboard"
    MasterPageFile="~/Shared/Dashboard.Master"
    CodeBehind="AdminDashboard.aspx.cs"
    Inherits="SIMS.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Status Stats Row -->
    <div class="dashboard-cards">
        <div class="glass-card stat-card">
            <h3>👨‍🎓 Total Students</h3>
            <p><asp:Label ID="lblStudents" runat="server" Text="0"></asp:Label></p>
        </div>

        <div class="glass-card stat-card">
            <h3>👨‍🏫 Total Lecturers</h3>
            <p><asp:Label ID="lblLecturers" runat="server" Text="0"></asp:Label></p>
        </div>

        <div class="glass-card stat-card">
            <h3>📚 Total Courses</h3>
            <p><asp:Label ID="lblCourses" runat="server" Text="0"></asp:Label></p>
        </div>

        <div class="glass-card stat-card">
            <h3>🎓 Total Programmes</h3>
            <p><asp:Label ID="lblProgrammes" runat="server" Text="0"></asp:Label></p>
        </div>
    </div>

    <br />

    <!-- Quick Actions Panel -->
    <div class="glass-card" style="padding:30px; border-radius:24px;">
        <h2>Quick Actions</h2>
        <br />
        <div style="display:flex; gap:20px; flex-wrap:wrap;">
            <a href="/Management/Student/StudentManagement.aspx" class="primary-btn" style="text-decoration:none;">👨‍🎓 Add Student</a>
            <a href="/Admin/LecturerManagement.aspx" class="primary-btn" style="text-decoration:none;">👨‍🏫 Add Lecturer</a>
            <a href="/Admin/CourseManagement.aspx" class="primary-btn" style="text-decoration:none;">📚 Add Course</a>
        </div>
    </div>

    <br />

    <!-- Live Grid Split: Announcements & Academic Calendar Side-by-Side -->
    <div class="dashboard-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; align-items: start;">
        
        <!-- COLUMN 1: LIVE ANNOUNCEMENTS SYSTEM -->
        <div class="glass-card" style="padding: 30px; border-radius: 24px; background: #ffffff; border: 1px solid #e8e5f5; box-shadow: 0 4px 24px rgba(108,78,242,.10);">
            <h3 style="font-size: 18px; font-weight: 700; margin-bottom: 20px; padding-bottom: 12px; border-bottom: 1px solid #e8e5f5; display: flex; justify-content: space-between; align-items: center;">
                <span>📢 Manage Announcements</span>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Green" Font-Size="12px" />
            </h3>

            <!-- Create New Announcement Form -->
            <div style="background: #f8fafc; padding: 15px; border-radius: 12px; margin-bottom: 20px; border: 1px dashed #cbd5e1;">
                <h4 style="margin: 0 0 10px 0; font-size: 14px; color: #1e1b3a;">Create New Announcement</h4>
                <div style="display: flex; flex-direction: column; gap: 10px;">
                    <asp:TextBox ID="txtNewTitle" runat="server" Placeholder="Announcement Title..." style="width: 95%; padding: 8px 12px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13px;" />
                    <asp:TextBox ID="txtNewMessage" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Write announcement message here..." style="width: 95%; padding: 8px 12px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-family: inherit; font-size: 13px; resize: vertical;" />
                    <div>
                        <asp:Button ID="btnPostAnnouncement" runat="server" Text="🚀 Post Announcement" OnClick="btnPostAnnouncement_Click" CssClass="primary-btn" style="padding: 8px 16px; font-size: 12px; border: none; cursor: pointer; border-radius: 8px;" />
                    </div>
                </div>
            </div>

            <!-- Announcements GridView -->
            <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="announcementID" GridLines="None" Width="100%"
                OnRowEditing="gvAnnouncements_RowEditing" 
                OnRowCancelingEdit="gvAnnouncements_RowCancelingEdit" 
                OnRowUpdating="gvAnnouncements_RowUpdating" 
                OnRowDeleting="gvAnnouncements_RowDeleting"
                style="border-collapse: collapse; margin-top: 10px;">
                
                <HeaderStyle BackColor="#6c4ef2" ForeColor="White" Font-Bold="true" Height="40px" HorizontalAlign="Left" />
                
                <Columns>
                    <asp:TemplateField HeaderText="Title">
                        <HeaderStyle Width="25%" HorizontalAlign="Left" />
                        <ItemStyle VerticalAlign="Top" />
                        <ItemTemplate>
                            <div style="padding: 10px 5px;">
                                <strong style="color: #1e1b3a; font-size: 14px;"><%# Eval("title") %></strong>
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div style="padding: 10px 5px;">
                                <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("title") %>' Width="90%" style="padding: 6px 10px; border: 1.5px solid #6c4ef2; border-radius: 6px; font-weight: bold;" />
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Message">
                        <HeaderStyle Width="50%" HorizontalAlign="Left" />
                        <ItemStyle VerticalAlign="Top" />
                        <ItemTemplate>
                            <div style="padding: 10px 5px;">
                                <p style="color: #555; margin: 0; font-size: 13px; line-height: 1.4;"><%# Eval("message") %></p>
                                <small style="color: #a78bfa; font-size: 11px; display: block; margin-top: 5px;"><%# Eval("datePosted", "{0:dd MMM yyyy}") %></small>
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div style="padding: 10px 5px;">
                                <asp:TextBox ID="txtMessage" runat="server" Text='<%# Bind("message") %>' TextMode="MultiLine" Rows="3" Width="90%" style="padding: 6px 10px; border: 1.5px solid #6c4ef2; border-radius: 6px; font-family: inherit; resize: vertical;" />
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <HeaderStyle Width="25%" HorizontalAlign="Center" />
                        <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <div style="padding: 10px 0; text-align: center;">
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit" ForeColor="#6c4ef2" Font-Bold="true" style="text-decoration: underline; margin-right: 12px; font-size: 13px;" />
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Delete" ForeColor="#ef4444" Font-Bold="true" style="text-decoration: underline; font-size: 13px;" OnClientClick="return confirm('Are you sure you want to delete this announcement? It will be removed for lecturers too.');" />
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div style="padding: 10px 0; text-align: center;">
                                <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" Text="Save" ForeColor="#10b981" Font-Bold="true" style="text-decoration: none; margin-right: 10px; font-size: 13px;" />
                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" Text="Cancel" ForeColor="#7b7898" Font-Bold="true" style="text-decoration: none; font-size: 13px;" />
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- COLUMN 2: ACADEMIC CALENDAR UI -->
        <div class="glass-card" style="padding:30px; border-radius:24px; background: #ffffff; border: 1px solid #e8e5f5; box-shadow: 0 4px 24px rgba(108,78,242,.10);">
            <h2 style="margin-bottom:10px; font-size:18px; font-weight:700;">Academic Calendar</h2>
            <p style="color:#64748b; margin-bottom:15px; font-size:13px;">View important academic dates and examination schedules.</p>

            <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender" Width="100%" Style="border: none; font-family: inherit;">
                <TodayDayStyle BackColor="#10b981" ForeColor="White" />
            </asp:Calendar>

            <!-- Calendar Filter/Legend System -->
            <div style="margin-top:20px; display:flex; gap:12px; flex-wrap:wrap; font-size:12px; color: #555;">
                <span><span style="display:inline-block; width:12px; height:12px; background:#10b981; border-radius:50%; margin-right:4px; vertical-align:middle;"></span>Today</span>
                <span><span style="display:inline-block; width:12px; height:12px; background:#6366f1; border-radius:50%; margin-right:4px; vertical-align:middle;"></span>Registration</span>
                <span><span style="display:inline-block; width:12px; height:12px; background:orange; border-radius:50%; margin-right:4px; vertical-align:middle;"></span>Midterm Exam</span>
                <span><span style="display:inline-block; width:12px; height:12px; background:mediumpurple; border-radius:50%; margin-right:4px; vertical-align:middle;"></span>Project Submission</span>
                <span><span style="display:inline-block; width:12px; height:12px; background:red; border-radius:50%; margin-right:4px; vertical-align:middle;"></span>Final Exam</span>
            </div>
        </div>

    </div>

</asp:Content>