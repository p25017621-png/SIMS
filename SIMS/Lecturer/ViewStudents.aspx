<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudents.aspx.cs" Inherits="SIMS.Lecturer.ViewStudents" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<title>View Students – SIMS</title>
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
.nav-item i{width:18px;text-align:center;}
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
.stat-icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0;}
.stat-card:nth-child(1) .stat-icon{background:#ede9fe;color:#6c4ef2;}.stat-card:nth-child(2) .stat-icon{background:#d1fae5;color:#10b981;}.stat-card:nth-child(3) .stat-icon{background:#fef3c7;color:#d97706;}.stat-card:nth-child(4) .stat-icon{background:#fee2e2;color:#ef4444;}
.stat-info h2{font-size:24px;font-weight:700;line-height:1;}
.stat-info p{font-size:12px;color:var(--muted);margin-top:2px;}
.table-card{background:var(--white);border-radius:var(--radius);box-shadow:var(--card-shadow);border:1px solid var(--border);overflow:hidden;}
.table-header{padding:20px 24px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid var(--border);flex-wrap:wrap;gap:12px;}
.table-header h3{font-size:15px;font-weight:700;}
.search-box{display:flex;align-items:center;gap:8px;background:var(--bg);border:1.5px solid var(--border);border-radius:10px;padding:8px 14px;}
.search-box input{border:none;background:transparent;font-family:'DM Sans',sans-serif;font-size:13px;color:var(--text);outline:none;width:180px;}
.search-box i{color:var(--muted);font-size:13px;}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--bg);}
th{padding:13px 20px;text-align:left;font-size:12px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;}
td{padding:13px 20px;font-size:14px;border-top:1px solid var(--border);}
tr:hover td{background:#faf9ff;}
.progress-bar{width:100%;height:8px;background:var(--border);border-radius:4px;overflow:hidden;}
.progress-fill{height:100%;border-radius:4px;}
.fill-green{background:#10b981;}.fill-yellow{background:#f59e0b;}.fill-red{background:#ef4444;}
.badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-good{background:#d1fae5;color:#059669;}.badge-avg{background:#fef3c7;color:#d97706;}.badge-poor{background:#fee2e2;color:#dc2626;}
.student-name{display:flex;align-items:center;gap:10px;}
.mini-avatar{width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-size:13px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
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
  <a href="ManageAttendance.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Attendance</a>
  <a href="ManageMarks.aspx" class="nav-item"><i class="fa-solid fa-chart-column"></i> Marks</a>
  <a href="ViewStudents.aspx" class="nav-item active"><i class="fa-solid fa-user-graduate"></i> Students</a>
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
    <div><h1>Students</h1><p>Monitor student academic progress</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text"><h2>Student Progress 🎓</h2><p>Monitor academic performance and attendance.</p></div>
    <div class="hero-graphic"><i class="fa-solid fa-user-graduate"></i></div>
  </div>
  <div class="stats">
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
      <div class="stat-info"><h2><asp:Label ID="lblTotal" runat="server" Text="0"/></h2><p>Total Students</p></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-trophy"></i></div>
      <div class="stat-info"><h2><asp:Label ID="lblGood" runat="server" Text="0"/></h2><p>Good Progress</p></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
      <div class="stat-info"><h2><asp:Label ID="lblAvg" runat="server" Text="0"/></h2><p>Average</p></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon"><i class="fa-solid fa-circle-exclamation"></i></div>
      <div class="stat-info"><h2><asp:Label ID="lblPoor" runat="server" Text="0"/></h2><p>Needs Attention</p></div>
    </div>
  </div>
  <div class="table-card">
    <div class="table-header">
      <h3>Student Academic Progress</h3>
      <div class="search-box">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="searchInput" placeholder="Search student..." onkeyup="searchTable()"/>
      </div>
    </div>
    <table id="stuTable">
      <thead>
        <tr><th>Student</th><th>Course</th><th>Attendance %</th><th>Avg Marks</th><th>Progress</th><th>Status</th></tr>
      </thead>
      <tbody>
        <asp:Repeater ID="rptStudents" runat="server">
          <ItemTemplate>
            <tr>
              <td><div class="student-name"><div class="mini-avatar"><%# Eval("Initial") %></div><%# Eval("Name") %></div></td>
              <td><%# Eval("Course") %></td>
              <td><%# Eval("AttendancePct") %>%
               <div class="progress-fill <%# Eval("FillClass") %>" style='<%# "width:" + Eval("AttendancePct") + "%;" %>'></div>
              </td>
              <td><%# Eval("AvgMarks") %></td>
              <td><div class="progress-bar"><div class="progress-fill <%# Eval("FillClass") %>" style="width:<%# Eval("AttendancePct") %>%"></div></div></td>
              <td><span class="badge <%# Eval("BadgeClass") %>"><%# Eval("ProgressStatus") %></span></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </tbody>
    </table>
  </div>
</main>
</form>
<script>
    function searchTable() {
        var val = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#stuTable tbody tr').forEach(function (r) {
            r.style.display = r.innerText.toLowerCase().includes(val) ? '' : 'none';
        });
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