cat > /mnt/user-data/outputs/ManageAttendance.aspx << 'ENDOFFILE'
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
:root{--purple:#6c4ef2;--purple-mid:#7c5cf5;--purple-light:#a78bfa;--purple-pale:#ede9fe;--sidebar-bg:#5b3ee8;--sidebar-dark:#4a30cc;--white:#ffffff;--bg:#f4f5fb;--text:#1e1b3a;--muted:#7b7898;--border:#e8e5f5;--card-shadow:0 4px 24px rgba(108,78,242,.10);--radius:16px;}
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
.avatar-circle{width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.25);color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.sidebar-footer .user-info h4{color:#fff;font-size:13px;font-weight:600;}
.sidebar-footer .user-info p{color:rgba(255,255,255,.6);font-size:11px;}
.main{margin-left:230px;flex:1;padding:32px 36px;}
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:28px;}
.topbar h1{font-size:26px;font-weight:700;}
.topbar p{font-size:13px;color:var(--muted);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:14px;}
.icon-btn{width:40px;height:40px;background:var(--white);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;justify-content:center;cursor:pointer;color:var(--muted);font-size:15px;}
.top-avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;}
.hero{background:linear-gradient(130deg,#6c4ef2 0%,#8b6cf9 55%,#a78bfa 100%);border-radius:22px;padding:36px 40px;position:relative;overflow:hidden;color:#fff;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 12px 40px rgba(108,78,242,.30);}
.hero::before{content:'';position:absolute;width:320px;height:320px;border-radius:50%;background:rgba(255,255,255,.07);top:-100px;right:-60px;}
.hero-text h2{font-size:28px;font-weight:700;margin-bottom:8px;}
.hero-text p{font-size:14px;color:rgba(255,255,255,.8);}
.hero-graphic{width:90px;height:90px;background:rgba(255,255,255,.12);border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:38px;position:relative;z-index:1;flex-shrink:0;}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:28px;}
.stat-card{background:var(--white);border-radius:var(--radius);padding:18px 20px;box-shadow:var(--card-shadow);display:flex;align-items:center;gap:14px;border-left:4px solid transparent;}
.stat-card:nth-child(1){border-color:#6c4ef2;}.stat-card:nth-child(2){border-color:#34d399;}.stat-card:nth-child(3){border-color:#f59e0b;}.stat-card:nth-child(4){border-color:#ef4444;}
.stat-icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:17px;flex-shrink:0;}
.stat-card:nth-child(1) .stat-icon{background:#ede9fe;color:#6c4ef2;}.stat-card:nth-child(2) .stat-icon{background:#d1fae5;color:#10b981;}.stat-card:nth-child(3) .stat-icon{background:#fef3c7;color:#d97706;}.stat-card:nth-child(4) .stat-icon{background:#fee2e2;color:#ef4444;}
.stat-info h2{font-size:24px;font-weight:700;line-height:1;}
.stat-info p{font-size:12px;color:var(--muted);margin-top:2px;}
.filter-card{background:var(--white);border-radius:var(--radius);padding:20px 24px;box-shadow:var(--card-shadow);border:1px solid var(--border);margin-bottom:24px;display:flex;gap:16px;align-items:flex-end;flex-wrap:wrap;}
.filter-group{display:flex;flex-direction:column;gap:6px;}
.filter-group label{font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
.filter-group select,.filter-group input{padding:10px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);outline:none;min-width:200px;}
.dash-btn{padding:10px 22px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.35);transition:transform .2s;}
.dash-btn:hover{transform:scale(1.04);}
.section-title{font-size:17px;font-weight:700;margin-bottom:16px;display:flex;align-items:center;gap:10px;}
.table-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;margin-bottom:28px;}
.table-header{padding:18px 24px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid var(--border);}
.table-header h3{font-size:15px;font-weight:700;}
.btn-save{padding:9px 20px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--bg);}
th{padding:12px 20px;text-align:left;font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
td{padding:12px 20px;font-size:14px;border-top:1px solid var(--border);}
tr:hover td{background:#faf9ff;}
.att-btn{width:34px;height:34px;border-radius:8px;border:none;font-size:12px;cursor:pointer;font-weight:700;transition:all .2s;margin-right:4px;}
.btn-present{background:#d1fae5;color:#059669;}.btn-present.selected,.btn-present:hover{background:#059669;color:#fff;}
.btn-absent{background:#fee2e2;color:#dc2626;}.btn-absent.selected,.btn-absent:hover{background:#dc2626;color:#fff;}
.btn-late{background:#fef3c7;color:#d97706;}.btn-late.selected,.btn-late:hover{background:#d97706;color:#fff;}
.badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-poor{background:#fee2e2;color:#dc2626;}
.student-name{display:flex;align-items:center;gap:10px;}
.mini-avatar{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-size:12px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.progress-bar{width:100%;height:7px;background:var(--border);border-radius:4px;overflow:hidden;margin-top:4px;}
.progress-fill{height:100%;border-radius:4px;}
.fill-green{background:linear-gradient(90deg,#34d399,#10b981);}.fill-yellow{background:linear-gradient(90deg,#fbbf24,#f59e0b);}.fill-red{background:linear-gradient(90deg,#f87171,#ef4444);}
.alert-box{background:#fff8f0;border:1.5px solid #fed7aa;border-radius:var(--radius);padding:16px 20px;margin-bottom:24px;display:flex;align-items:center;gap:14px;}
.alert-box i{color:#f97316;font-size:20px;}
.alert-box p{font-size:13px;color:#92400e;font-weight:500;}
.alert-box strong{color:#c2410c;}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.hero{animation:fadeUp .5s ease both;}.stats{animation:fadeUp .5s .1s ease both;}.table-card{animation:fadeUp .5s .2s ease both;}
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
  <div class="sidebar-footer">
    <div class="avatar-circle">L</div>
    <div class="user-info"><h4>Lecturer</h4><p>Welcome Back!</p></div>
    <i class="fa-solid fa-chevron-right" style="margin-left:auto;color:rgba(255,255,255,.5);font-size:12px;"></i>
  </div>
</aside>
<main class="main">
  <div class="topbar">
    <div><h1>Manage Attendance</h1><p>Record, update and monitor student attendance</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text">
      <h2>Attendance Records 📋</h2>
      <p>Mark attendance and identify students with poor attendance.</p>
    </div>
    <div class="hero-graphic"><i class="fa-solid fa-calendar-check"></i></div>
  </div>

  <!-- STATS with asp:Label so backend can update them -->
  <div class="stats">
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
      <div class="stat-info">
        <h2><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h2>
        <p>Total Students</p>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
      <div class="stat-info">
        <h2><asp:Label ID="lblPresent" runat="server" Text="0"></asp:Label></h2>
        <p>Present Today</p>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-clock"></i></div>
      <div class="stat-info">
        <h2><asp:Label ID="lblLate" runat="server" Text="0"></asp:Label></h2>
        <p>Late Today</p>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-circle-xmark"></i></div>
      <div class="stat-info">
        <h2><asp:Label ID="lblAbsent" runat="server" Text="0"></asp:Label></h2>
        <p>Absent Today</p>
      </div>
    </div>
  </div>

  <div class="alert-box">
    <i class="fa-solid fa-triangle-exclamation"></i>
    <p><strong>Check below</strong> for students with attendance below 75%.</p>
  </div>

  <!-- Filter -->
  <div class="filter-card">
    <div class="filter-group">
      <label>Course</label>
      <asp:DropDownList ID="ddlCourse" runat="server" style="padding:10px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;min-width:200px;">
        <asp:ListItem Text="Web Programming (WEB3013)" Value="WEB3013"/>
        <asp:ListItem Text="Database Systems (DBS2023)" Value="DBS2023"/>
        <asp:ListItem Text="Software Engineering (SWE3033)" Value="SWE3033"/>
      </asp:DropDownList>
    </div>
    <div class="filter-group">
      <label>Date</label>
      <asp:TextBox ID="txtDate" runat="server" TextMode="Date" style="padding:10px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
    </div>
    <asp:Button ID="btnLoad" runat="server" Text="Load Students" CssClass="dash-btn" OnClick="btnLoad_Click"/>
  </div>

  <!-- Today's Attendance Table -->
  <div class="section-title"><i class="fa-solid fa-calendar-check" style="color:var(--purple)"></i> Today's Attendance</div>
  <div class="table-card">
    <div class="table-header">
      <h3>Mark Attendance</h3>
      <asp:Button ID="btnSaveAttendance" runat="server" Text="💾 Save Attendance" CssClass="btn-save" OnClick="btnSaveAttendance_Click"/>
    </div>
    <table>
      <thead>
        <tr><th>No.</th><th>Student ID</th><th>Student Name</th><th>Program</th><th>Overall %</th><th>Today</th></tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td><td>S001</td>
          <td><div class="student-name"><div class="mini-avatar">A</div>Ahmad Bin Ali</div></td>
          <td>CS</td>
          <td>92%<div class="progress-bar"><div class="progress-fill fill-green" style="width:92%"></div></div></td>
          <td>
            <button type="button" class="att-btn btn-present selected" onclick="setAtt(this)">P</button>
            <button type="button" class="att-btn btn-absent" onclick="setAtt(this)">A</button>
            <button type="button" class="att-btn btn-late" onclick="setAtt(this)">L</button>
          </td>
        </tr>
        <tr>
          <td>2</td><td>S002</td>
          <td><div class="student-name"><div class="mini-avatar">S</div>Siti Binti Hassan</div></td>
          <td>IT</td>
          <td>60%<div class="progress-bar"><div class="progress-fill fill-red" style="width:60%"></div></div></td>
          <td>
            <button type="button" class="att-btn btn-present" onclick="setAtt(this)">P</button>
            <button type="button" class="att-btn btn-absent selected" onclick="setAtt(this)">A</button>
            <button type="button" class="att-btn btn-late" onclick="setAtt(this)">L</button>
          </td>
        </tr>
        <tr>
          <td>3</td><td>S003</td>
          <td><div class="student-name"><div class="mini-avatar">R</div>Raj Kumar</div></td>
          <td>CS</td>
          <td>95%<div class="progress-bar"><div class="progress-fill fill-green" style="width:95%"></div></div></td>
          <td>
            <button type="button" class="att-btn btn-present selected" onclick="setAtt(this)">P</button>
            <button type="button" class="att-btn btn-absent" onclick="setAtt(this)">A</button>
            <button type="button" class="att-btn btn-late" onclick="setAtt(this)">L</button>
          </td>
        </tr>
        <tr>
          <td>4</td><td>S004</td>
          <td><div class="student-name"><div class="mini-avatar">L</div>Lim Wei Ming</div></td>
          <td>CS</td>
          <td>55%<div class="progress-bar"><div class="progress-fill fill-red" style="width:55%"></div></div></td>
          <td>
            <button type="button" class="att-btn btn-present" onclick="setAtt(this)">P</button>
            <button type="button" class="att-btn btn-absent" onclick="setAtt(this)">A</button>
            <button type="button" class="att-btn btn-late selected" onclick="setAtt(this)">L</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- Poor Attendance Section -->
  <div class="section-title"><i class="fa-solid fa-triangle-exclamation" style="color:#ef4444"></i> Poor Attendance — Below 75%</div>
  <div class="table-card">
    <div class="table-header">
      <h3>⚠️ Poor Attendance Alert</h3>
      <span style="font-size:12px;color:var(--muted);">Threshold: below 75%</span>
    </div>
    <table>
      <thead>
        <tr><th>Student ID</th><th>Student Name</th><th>Course</th><th>Attendance %</th><th>Classes Missed</th><th>Status</th></tr>
      </thead>
      <tbody>
        <asp:Repeater ID="rptPoorAttendance" runat="server">
          <ItemTemplate>
            <tr>
              <td><%# Eval("StudentID") %></td>
              <td><div class="student-name"><div class="mini-avatar"><%# Eval("Initial") %></div><%# Eval("Name") %></div></td>
              <td><%# Eval("Course") %></td>
              <td><%# Eval("AttendancePct") %>%
                <div class="progress-bar"><div class="progress-fill fill-red" style="width:<%# Eval("AttendancePct") %>%"></div></div>
              </td>
              <td><%# Eval("Missed") %> classes</td>
              <td><span class="badge badge-poor">Poor</span></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
        <tr>
          <td>S002</td>
          <td><div class="student-name"><div class="mini-avatar">S</div>Siti Binti Hassan</div></td>
          <td>Database Systems</td>
          <td>60%<div class="progress-bar"><div class="progress-fill fill-red" style="width:60%"></div></div></td>
          <td>8 classes</td>
          <td><span class="badge badge-poor">Poor</span></td>
        </tr>
        <tr>
          <td>S004</td>
          <td><div class="student-name"><div class="mini-avatar">L</div>Lim Wei Ming</div></td>
          <td>Web Programming</td>
          <td>55%<div class="progress-bar"><div class="progress-fill fill-red" style="width:55%"></div></div></td>
          <td>11 classes</td>
          <td><span class="badge badge-poor">Poor</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</form>
<script>
function setAtt(btn){
  var row=btn.closest('tr');
  row.querySelectorAll('.att-btn').forEach(function(b){b.classList.remove('selected');});
  btn.classList.add('selected');
}
window.onload=function(){
  var d=document.getElementById('<%=txtDate.ClientID%>');
        if (d && !d.value) { d.value = new Date().toISOString().split('T')[0]; }
    }
</script>
</body>
</html>
ENDOFFILE