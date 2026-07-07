<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAttendance.aspx.cs" Inherits="SIMS.Lecturer.ManageAttendance" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Manage Attendance – SIMS</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<style>
:root{--purple:#6c4ef2;--purple-mid:#7c5cf5;--purple-light:#a78bfa;--purple-pale:#ede9fe;--sidebar-bg:#5b3ee8;--sidebar-dark:#4a30cc;--white:#fff;--bg:#f4f5fb;--text:#1e1b3a;--muted:#7b7898;--border:#e8e5f5;--card-shadow:0 4px 24px rgba(108,78,242,.10);--radius:16px;}
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text);display:flex;min-height:100vh;}
.sidebar{width:230px;min-height:100vh;background:linear-gradient(175deg,var(--sidebar-bg) 0%,var(--sidebar-dark) 100%);display:flex;flex-direction:column;padding:28px 18px;position:fixed;top:0;left:0;bottom:0;z-index:100;}
.sidebar-logo{display:flex;align-items:center;gap:12px;margin-bottom:36px;}
.logo-icon{width:42px;height:42px;background:rgba(255,255,255,.18);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;color:#fff;}
.logo-text h2{color:#fff;font-size:18px;font-weight:700;line-height:1;}
.logo-text p{color:rgba(255,255,255,.6);font-size:11px;margin-top:2px;}
.nav-label{font-size:10px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:rgba(255,255,255,.45);padding:0 10px;margin:18px 0 8px;}
.nav-item{display:flex;align-items:center;gap:12px;padding:11px 14px;border-radius:12px;color:rgba(255,255,255,.75);font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;margin-bottom:3px;transition:background .2s,color .2s;}
.nav-item i{width:18px;text-align:center;font-size:15px;}
.nav-item:hover,.nav-item.active{background:rgba(255,255,255,.18);color:#fff;}
.sidebar-footer{margin-top:auto;background:rgba(255,255,255,.12);border-radius:14px;padding:14px;display:flex;align-items:center;gap:12px;}
.av{width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.25);color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.sidebar-footer .user-info h4{color:#fff;font-size:13px;font-weight:600;}
.sidebar-footer .user-info p{color:rgba(255,255,255,.6);font-size:11px;}
.main{margin-left:230px;flex:1;padding:28px 32px;}
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;}
.topbar h1{font-size:26px;font-weight:700;}
.topbar p{font-size:13px;color:var(--muted);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:10px;}
.icon-btn{width:40px;height:40px;background:var(--white);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;justify-content:center;cursor:pointer;color:var(--muted);font-size:15px;}
.top-avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;}
.hero{background:linear-gradient(130deg,#6c4ef2 0%,#8b6cf9 55%,#a78bfa 100%);border-radius:22px;padding:32px 36px;position:relative;overflow:hidden;color:#fff;margin-bottom:24px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 12px 40px rgba(108,78,242,.30);}
.hero::before{content:'';position:absolute;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,.07);top:-80px;right:-40px;}
.hero-text h2{font-size:26px;font-weight:700;margin-bottom:6px;}
.hero-text p{font-size:13px;color:rgba(255,255,255,.8);}
.hero-graphic{width:80px;height:80px;background:rgba(255,255,255,.12);border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:34px;flex-shrink:0;position:relative;z-index:1;}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px;}
.stat-card{background:var(--white);border-radius:var(--radius);padding:18px 20px;box-shadow:var(--card-shadow);display:flex;align-items:center;gap:14px;border-left:4px solid transparent;transition:transform .2s;}
.stat-card:hover{transform:translateY(-3px);}
.stat-card:nth-child(1){border-color:#6c4ef2;}.stat-card:nth-child(2){border-color:#059669;}.stat-card:nth-child(3){border-color:#d97706;}.stat-card:nth-child(4){border-color:#dc2626;}
.si{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:17px;flex-shrink:0;}
.stat-card:nth-child(1) .si{background:#ede9fe;color:#6c4ef2;}.stat-card:nth-child(2) .si{background:#d1fae5;color:#059669;}.stat-card:nth-child(3) .si{background:#fef3c7;color:#d97706;}.stat-card:nth-child(4) .si{background:#fee2e2;color:#dc2626;}
.si-info h2{font-size:26px;font-weight:700;line-height:1;}
.si-info p{font-size:12px;color:var(--muted);margin-top:2px;}
.si-info .cl{font-size:10px;color:var(--purple);font-weight:600;margin-top:2px;}
.filter-card{background:var(--white);border-radius:var(--radius);padding:20px 24px;box-shadow:var(--card-shadow);border:1px solid var(--border);margin-bottom:24px;}
.filter-row{display:flex;gap:14px;align-items:flex-end;flex-wrap:wrap;}
.fg{display:flex;flex-direction:column;gap:5px;}
.fg label{font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em;}
.fg select,.fg input{padding:10px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);outline:none;min-width:200px;transition:border .2s;}
.fg select:focus,.fg input:focus{border-color:var(--purple);background:#fff;}
.load-btn{padding:10px 22px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.3);transition:transform .2s;}
.load-btn:hover{transform:scale(1.04);}
.msg{border-radius:10px;padding:12px 18px;margin-bottom:20px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:10px;}
.msg-ok{background:#d1fae5;border:1.5px solid #34d399;color:#065f46;}
.msg-err{background:#fee2e2;border:1.5px solid #ef4444;color:#991b1b;}
.att-layout{display:grid;grid-template-columns:1fr 320px;gap:20px;margin-bottom:28px;}
.table-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.table-header{padding:16px 20px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid var(--border);flex-wrap:wrap;gap:10px;}
.table-header h3{font-size:15px;font-weight:700;}
.th-tools{display:flex;align-items:center;gap:10px;flex-wrap:wrap;}
.search-box{display:flex;align-items:center;gap:8px;background:var(--bg);border:1.5px solid var(--border);border-radius:10px;padding:7px 14px;}
.search-box input{border:none;background:transparent;font-family:'DM Sans',sans-serif;font-size:13px;color:var(--text);outline:none;width:150px;}
.search-box i{color:var(--muted);font-size:13px;}
.save-btn{padding:8px 18px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:9px;font-family:'DM Sans',sans-serif;font-size:12px;font-weight:600;cursor:pointer;}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--bg);}
th{padding:11px 14px;text-align:left;font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
td{padding:10px 14px;font-size:13px;border-top:1px solid var(--border);}
tr.hidden-row{display:none;}
.sname{display:flex;align-items:center;gap:8px;}
.mav{width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-size:11px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.att-grp{display:flex;gap:4px;}
.att-btn{width:32px;height:32px;border-radius:8px;border:none;font-size:11px;font-weight:700;cursor:pointer;transition:all .2s;}
.btn-p{background:#d1fae5;color:#059669;}.btn-p.sel{background:#059669;color:#fff;}
.btn-a{background:#fee2e2;color:#dc2626;}.btn-a.sel{background:#dc2626;color:#fff;}
.btn-l{background:#fef3c7;color:#d97706;}.btn-l.sel{background:#d97706;color:#fff;}
.status-badge{display:inline-flex;align-items:center;gap:5px;padding:4px 12px;border-radius:20px;font-size:11px;font-weight:600;transition:all .3s;}
.sb-p{background:#d1fae5;color:#059669;}
.sb-a{background:#fee2e2;color:#dc2626;}
.sb-l{background:#fef3c7;color:#d97706;}
.pb{width:70px;height:6px;background:var(--border);border-radius:3px;overflow:hidden;margin-top:3px;}
.pbf{height:100%;border-radius:3px;transition:width .3s;}
.pg{background:#10b981;}.py{background:#f59e0b;}.pr{background:#ef4444;}
/* SUMMARY PANEL */
.summary-panel{display:flex;flex-direction:column;gap:12px;}
.sum-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.sum-head{padding:12px 16px;display:flex;align-items:center;justify-content:space-between;}
.sum-head-p{background:#d1fae5;border-bottom:2px solid #059669;}
.sum-head-a{background:#fee2e2;border-bottom:2px solid #dc2626;}
.sum-head-l{background:#fef3c7;border-bottom:2px solid #d97706;}
.sum-title{display:flex;align-items:center;gap:8px;font-size:13px;font-weight:700;}
.sum-head-p .sum-title{color:#059669;}
.sum-head-a .sum-title{color:#dc2626;}
.sum-head-l .sum-title{color:#d97706;}
.sum-count{font-size:22px;font-weight:700;min-width:28px;text-align:center;}
.sum-head-p .sum-count{color:#059669;}
.sum-head-a .sum-count{color:#dc2626;}
.sum-head-l .sum-count{color:#d97706;}
.sum-body{padding:6px 0;max-height:120px;overflow-y:auto;}
.sum-row{padding:7px 14px;font-size:12px;border-bottom:1px solid var(--border);display:flex;align-items:center;gap:8px;}
.sum-row:last-child{border-bottom:none;}
.sum-empty{padding:12px 14px;text-align:center;color:var(--muted);font-size:12px;}
/* POOR ATTENDANCE */
.poor-section{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;margin-bottom:24px;}
.poor-header{padding:16px 20px;border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;background:#fff8f0;}
.poor-header h3{font-size:15px;font-weight:700;color:#dc2626;display:flex;align-items:center;gap:8px;}
.risk-tag{background:#fee2e2;color:#dc2626;font-size:11px;font-weight:700;padding:4px 12px;border-radius:20px;}
.poor-table-row{display:grid;grid-template-columns:1fr 1fr 120px 120px 80px 100px;align-items:center;padding:12px 20px;border-bottom:1px solid var(--border);transition:background .2s;}
.poor-table-row:hover{background:#fff8f0;}
.poor-table-row:last-child{border-bottom:none;}
.poor-head-row{display:grid;grid-template-columns:1fr 1fr 120px 120px 80px 100px;padding:10px 20px;background:var(--bg);border-bottom:1px solid var(--border);}
.poor-head-row span{font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
.att-bar{width:100%;height:8px;background:#fee2e2;border-radius:4px;overflow:hidden;margin-top:4px;}
.att-bar-fill{height:100%;background:#ef4444;border-radius:4px;}
.poor-badge{display:inline-flex;align-items:center;gap:5px;background:#fee2e2;color:#dc2626;font-size:11px;font-weight:700;padding:4px 10px;border-radius:20px;}
.flag-btn{padding:5px 12px;background:#fff;border:1.5px solid #dc2626;color:#dc2626;border-radius:8px;font-size:11px;font-weight:600;cursor:pointer;transition:all .2s;font-family:'DM Sans',sans-serif;}
.flag-btn:hover{background:#dc2626;color:#fff;}
.flag-btn.flagged{background:#dc2626;color:#fff;}
.empty-poor{padding:32px;text-align:center;color:var(--muted);}
.empty-poor i{font-size:28px;margin-bottom:8px;display:block;color:#34d399;}
</style>
</head>
<body>
<form id="form1" runat="server">
<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon"><i class="fa-solid fa-graduation-cap"></i></div>
    <div class="logo-text"><h2>SIMS</h2><p>Lecturer Panel</p></div>
  </div>
  <span class="nav-label">Main</span>
  <a href="LecturerDashboard.aspx" class="nav-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
  <a href="ManageAttendance.aspx" class="nav-item active"><i class="fa-solid fa-calendar-check"></i> Attendance</a>
  <a href="ManageMarks.aspx" class="nav-item"><i class="fa-solid fa-chart-column"></i> Marks</a>
  <a href="ViewStudents.aspx" class="nav-item"><i class="fa-solid fa-user-graduate"></i> Students</a>
  <span class="nav-label">Account</span>
  <a href="ManageProfile.aspx" class="nav-item"><i class="fa-solid fa-user-pen"></i> Profile</a>
 <div class="sidebar-footer" onclick="confirmLogout()" style="cursor:pointer;background:rgba(239,68,68,.15);border:1.5px solid rgba(239,68,68,.3);" onmouseover="this.style.background='rgba(239,68,68,.3)'" onmouseout="this.style.background='rgba(239,68,68,.15)'">
    <div class="avatar-circle" style="background:#ef4444;">
        <i class="fa-solid fa-right-from-bracket"></i>
    </div>
    <div class="user-info">
        <h4 style="color:#fca5a5;">Logout</h4>
        <p style="color:rgba(252,165,165,.7);">Click to sign out</p>
    </div>
</div>
</aside>

<main class="main">
  <div class="topbar">
    <div><h1>Manage Attendance</h1><p>Select a course, mark attendance — results update instantly</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-text">
      <h2>Attendance Records 📋</h2>
      <p>Mark Present, Absent or Late — live summary updates on the right instantly.</p>
    </div>
    <div class="hero-graphic"><i class="fa-solid fa-calendar-check"></i></div>
  </div>

  <!-- STATS -->
  <div class="stats">
    <div class="stat-card">
      <div class="si"><i class="fa-solid fa-users"></i></div>
      <div class="si-info">
        <h2><asp:Label ID="lblTotal" runat="server" Text="0"/></h2>
        <p>Total Students</p>
        <div class="cl"><asp:Label ID="lblCourseName" runat="server" Text="Select course"/></div>
      </div>
    </div>
    <div class="stat-card">
      <div class="si"><i class="fa-solid fa-circle-check"></i></div>
      <div class="si-info">
        <h2><span id="livePCount">0</span></h2>
        <p>Present</p>
        <div class="cl">Live count</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="si"><i class="fa-solid fa-clock"></i></div>
      <div class="si-info">
        <h2><span id="liveLCount">0</span></h2>
        <p>Late</p>
        <div class="cl">Live count</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="si"><i class="fa-solid fa-circle-xmark"></i></div>
      <div class="si-info">
        <h2><span id="liveACount">0</span></h2>
        <p>Absent</p>
        <div class="cl">Live count</div>
      </div>
    </div>
  </div>

  <!-- Messages -->
  <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
    <div class="msg msg-ok"><i class="fa-solid fa-circle-check"></i><asp:Label ID="lblSuccessMsg" runat="server"/></div>
  </asp:Panel>
  <asp:Panel ID="pnlError" runat="server" Visible="false">
    <div class="msg msg-err"><i class="fa-solid fa-circle-xmark"></i><asp:Label ID="lblErrorMsg" runat="server"/></div>
  </asp:Panel>

  <!-- FILTER -->
  <div class="filter-card">
    <div class="filter-row">
      <div class="fg">
        <label><i class="fa-solid fa-book"></i> Select Course</label>
        <asp:DropDownList ID="ddlCourse" runat="server" style="padding:10px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;min-width:220px;"/>
      </div>
      <div class="fg">
        <label><i class="fa-solid fa-calendar"></i> Date</label>
        <asp:TextBox ID="txtDate" runat="server" TextMode="Date" style="padding:10px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
      </div>
      <asp:Button ID="btnLoad" runat="server" Text="🔍 Load Students" CssClass="load-btn" OnClick="btnLoad_Click"/>
    </div>
  </div>

  <!-- ATTENDANCE TABLE + LIVE PANEL -->
  <div class="att-layout">
    <!-- LEFT TABLE -->
    <div class="table-card">
      <div class="table-header">
        <h3>📋 <asp:Label ID="lblSelectedCourse" runat="server" Text="Select a course to load students"/></h3>
        <div class="th-tools">
          <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" id="searchInput" placeholder="Search student..." onkeyup="doSearch()"/>
          </div>
          <asp:Button ID="btnSaveAttendance" runat="server" Text="💾 Save" CssClass="save-btn" OnClick="btnSaveAttendance_Click"/>
        </div>
      </div>
      <table id="attTable">
        <thead>
          <tr>
            <th>#</th>
            <th>Student Name</th>
            <th>Overall %</th>
            <th>Mark</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody id="attBody">
          <asp:Repeater ID="rptStudents" runat="server">
            <ItemTemplate>
              <tr data-status="P" data-name="<%# Eval("Name") %>">
                <td style="color:var(--muted);font-size:12px;"><%# Container.ItemIndex + 1 %></td>
                <td>
                  <div class="sname">
                    <div class="mav"><%# Eval("Initial") %></div>
                    <div>
                      <div style="font-weight:600;font-size:13px;"><%# Eval("Name") %></div>
                      <div style="font-size:11px;color:var(--muted);"><%# Eval("Course") %></div>
                    </div>
                  </div>
                </td>
                <td>
                <div style="font-size:12px;font-weight:600;"><%# Eval("AttPct") %>%</div>
<div class="pb">
    <div class="pbf" style='<%# "width:" + Eval("AttPct") + "%;" %>'></div>
</div>
                </td>
                <td>
                  <div class="att-grp">
                    <button type="button" class="att-btn btn-p sel" onclick="setAtt(this,'P')" title="Present">P</button>
                    <button type="button" class="att-btn btn-a" onclick="setAtt(this,'A')" title="Absent">A</button>
                    <button type="button" class="att-btn btn-l" onclick="setAtt(this,'L')" title="Late">L</button>
                  </div>
                </td>
                <td>
                  <span class="status-badge sb-p">
                    <i class="fa-solid fa-circle-check"></i> Present
                  </span>
                </td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </tbody>
      </table>
    </div>

    <!-- RIGHT LIVE SUMMARY -->
    <div class="summary-panel">
      <div class="sum-card">
        <div class="sum-head sum-head-p">
          <div class="sum-title"><i class="fa-solid fa-circle-check"></i> Present</div>
          <div class="sum-count" id="sumCountP">0</div>
        </div>
        <div class="sum-body" id="sumListP">
          <div class="sum-empty">No students marked Present</div>
        </div>
      </div>
      <div class="sum-card">
        <div class="sum-head sum-head-a">
          <div class="sum-title"><i class="fa-solid fa-circle-xmark"></i> Absent</div>
          <div class="sum-count" id="sumCountA">0</div>
        </div>
        <div class="sum-body" id="sumListA">
          <div class="sum-empty">No students marked Absent</div>
        </div>
      </div>
      <div class="sum-card">
        <div class="sum-head sum-head-l">
          <div class="sum-title"><i class="fa-solid fa-clock"></i> Late</div>
          <div class="sum-count" id="sumCountL">0</div>
        </div>
        <div class="sum-body" id="sumListL">
          <div class="sum-empty">No students marked Late</div>
        </div>
      </div>
    </div>
  </div>

  <!-- POOR ATTENDANCE SECTION -->
  <div class="poor-section">
    <div class="poor-header">
      <h3><i class="fa-solid fa-triangle-exclamation"></i> Poor Attendance — Below 75%</h3>
      <span class="risk-tag"><asp:Label ID="lblPoorCount" runat="server" Text="0"/> students at risk</span>
    </div>

    <!-- Poor attendance table header -->
    <div class="poor-head-row">
      <span>Student Name</span>
      <span>Course</span>
      <span>Attendance %</span>
      <span>Classes Missed</span>
      <span>Status</span>
      <span>Action</span>
    </div>

    <!-- Poor attendance rows from DB -->
    <asp:Repeater ID="rptPoorAttendance" runat="server">
      <ItemTemplate>
        <div class="poor-table-row">
          <div class="sname">
            <div class="mav"><%# Eval("Initial") %></div>
            <div>
              <div style="font-weight:600;font-size:13px;"><%# Eval("Name") %></div>
            </div>
          </div>
          <div style="font-size:13px;color:var(--muted);"><%# Eval("Course") %></div>
          <div>
            <div style="font-size:12px;font-weight:700;color:#dc2626;"><%# Eval("AttendancePct") %>%</div>
            <div class="att-bar">
    <div class="att-bar-fill" style='<%# "width:" + Eval("AttendancePct") + "%;" %>'></div>
</div>
          </div>
          <div style="font-size:13px;color:#dc2626;font-weight:600;"><%# Eval("Missed") %> classes</div>
          <div><span class="poor-badge"><i class="fa-solid fa-triangle-exclamation"></i> Poor</span></div>
          <div>
            <button type="button" class="flag-btn" onclick="flagStudent(this, '<%# Eval("Name") %>')">
              <i class="fa-solid fa-flag"></i> Flag
            </button>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>

    <!-- Empty state -->
    <asp:Panel ID="pnlNoPoor" runat="server" Visible="false">
      <div class="empty-poor">
        <i class="fa-solid fa-circle-check"></i>
        <div style="font-size:14px;font-weight:600;color:#059669;">All students have good attendance!</div>
        <div style="font-size:12px;margin-top:4px;">No students below 75% threshold.</div>
      </div>
    </asp:Panel>
  </div>

  <!-- FLAG NOTIFICATION -->
  <div id="flagNotif" style="display:none;position:fixed;bottom:24px;right:24px;background:#1e1b3a;color:#fff;padding:14px 20px;border-radius:12px;font-size:13px;font-weight:600;box-shadow:0 8px 24px rgba(0,0,0,.2);z-index:999;display:flex;align-items:center;gap:10px;">
    <i class="fa-solid fa-flag" style="color:#ef4444;"></i>
    <span id="flagMsg">Student flagged!</span>
  </div>

</main>
</form>

<script>
// Mark attendance
function setAtt(btn, status) {
  var row = btn.closest('tr');
  row.querySelectorAll('.att-btn').forEach(function(b){ b.classList.remove('sel'); });
  btn.classList.add('sel');
  row.setAttribute('data-status', status);

  // Update status badge instantly
  var badge = row.querySelector('.status-badge');
  if (badge) {
    if (status === 'P') {
      badge.className = 'status-badge sb-p';
      badge.innerHTML = '<i class="fa-solid fa-circle-check"></i> Present';
    } else if (status === 'A') {
      badge.className = 'status-badge sb-a';
      badge.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Absent';
    } else {
      badge.className = 'status-badge sb-l';
      badge.innerHTML = '<i class="fa-solid fa-clock"></i> Late';
    }
  }
  updateLivePanel();
}

// Update live summary panel
function updateLivePanel() {
  var rows = document.querySelectorAll('#attBody tr');
  var P = [], A = [], L = [];
  rows.forEach(function(r) {
    if (r.classList.contains('hidden-row')) return;
    var name = r.getAttribute('data-name');
    var status = r.getAttribute('data-status');
    if (!name) return;
    if (status === 'P') P.push(name);
    else if (status === 'A') A.push(name);
    else if (status === 'L') L.push(name);
  });

  document.getElementById('livePCount').textContent = P.length;
  document.getElementById('liveLCount').textContent = L.length;
  document.getElementById('liveACount').textContent = A.length;
  document.getElementById('sumCountP').textContent = P.length;
  document.getElementById('sumCountA').textContent = A.length;
  document.getElementById('sumCountL').textContent = L.length;

  document.getElementById('sumListP').innerHTML = P.length === 0
    ? '<div class="sum-empty">No students marked Present</div>'
    : P.map(function(n){ return '<div class="sum-row"><i class="fa-solid fa-circle-check" style="color:#059669;font-size:10px;"></i>' + n + '</div>'; }).join('');

  document.getElementById('sumListA').innerHTML = A.length === 0
    ? '<div class="sum-empty">No students marked Absent</div>'
    : A.map(function(n){ return '<div class="sum-row"><i class="fa-solid fa-circle-xmark" style="color:#dc2626;font-size:10px;"></i>' + n + '</div>'; }).join('');

  document.getElementById('sumListL').innerHTML = L.length === 0
    ? '<div class="sum-empty">No students marked Late</div>'
    : L.map(function(n){ return '<div class="sum-row"><i class="fa-solid fa-clock" style="color:#d97706;font-size:10px;"></i>' + n + '</div>'; }).join('');
}

// Search students
function doSearch() {
  var val = document.getElementById('searchInput').value.toLowerCase();
  document.querySelectorAll('#attBody tr').forEach(function(r){
    r.classList.toggle('hidden-row', !r.innerText.toLowerCase().includes(val));
  });
  updateLivePanel();
}

// Flag poor attendance student
function flagStudent(btn, name) {
  btn.classList.add('flagged');
  btn.innerHTML = '<i class="fa-solid fa-flag"></i> Flagged';
  btn.disabled = true;

  var notif = document.getElementById('flagNotif');
  document.getElementById('flagMsg').textContent = name + ' has been flagged for poor attendance!';
  notif.style.display = 'flex';
  setTimeout(function(){ notif.style.display = 'none'; }, 3000);
}

// Set today date
window.onload = function() {
  var d = document.getElementById('<%=txtDate.ClientID%>');
        if (d && !d.value) d.value = new Date().toISOString().split('T')[0];
        updateLivePanel();
    }
        </script>
    <script>
        function confirmLogout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = '../Login.aspx';
            }
        }
    </script>
</body>
</html>