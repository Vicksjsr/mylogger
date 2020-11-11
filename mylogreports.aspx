<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mylogreports.aspx.cs" Inherits="vikapplogger.mylogreports" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Debug Access From SAP SM20 Logs</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}
label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}
body 
 {
  background-color: lightgoldenrodyellow;
 } 

</style>
</head>
   

<body>
    <form id="form1" runat="server">
         <div class="row">
      <div class="col-25">
        <label for="fname"><b>MyloggerReport</b></label>
      </div>
      <div class="col-75">
         <label for="fname"><b>Integrated with SAP Security logs For Debug Access</b></label>
      </div>
    </div>

        <div>
     <asp:DropDownList ID="ddlusers" runat="server" AutoPostBack="true" DataSourceID="DropDownDataSource"
    DataTextField="UserName" DataValueField="UserName" AppendDataBoundItems="true" Height="22px" OnSelectedIndexChanged="ddlusers_SelectedIndexChanged" Width="262px">
    <asp:ListItem Text="All Users" Value="" />
</asp:DropDownList>
<asp:SqlDataSource ID="DropDownDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConStr %>"
    SelectCommand="select DISTINCT UserName from SM20_Logs_new where [Audit Log Message Te] LIKE '%Field content%'" OnSelecting="DropDownDataSource_Selecting"></asp:SqlDataSource>

<asp:DropDownList ID="ddltcodes" runat="server" DataTextField="Transaction Code" DataValueField="Transaction Code" AppendDataBoundItems="true" Height="19px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack = "true" Width="252px" DataSourceID="SqlDataSource2">
    <asp:ListItem Text="All Tcodes" Value="" />
 </asp:DropDownList>

  <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConStr %>"
    SelectCommand="select DISTINCT [Transaction Code] from SM20_Logs_new where [Audit Log Message Te] LIKE '%Field content%'" OnSelecting="SqlDataSource2_Selecting"></asp:SqlDataSource>

    </div>
        <div>
            <br />
        </div>


        <%--Chart Tables--%>
        <asp:Chart ID="Chart1" runat="server" Height="453px" Width="1038px" BackColor="YellowGreen">
        <Titles>
        <asp:Title ShadowOffset="3" Name="Items" />
       </Titles>
       <Legends>
        <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Default" LegendStyle="Row" />
        </Legends>
            <Series>
                <asp:Series Name="Series1"></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
         <%--Ends--%>
         <br />
         <br />
        <div>
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" CssClass="mydatagrid" PagerStyle-CssClass="pager"
 HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowPaging="True" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White">
   <Columns>
        <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Width="150" />
        <asp:BoundField DataField="Time" HeaderText="Time" ItemStyle-Width="150" />
        <asp:BoundField DataField="Cl." HeaderText="Client" ItemStyle-Width="150" />
        <asp:BoundField DataField="UserName" HeaderText="User" ItemStyle-Width="150" />
        <asp:BoundField DataField="Terminal Name" HeaderText="TerminalName" ItemStyle-Width="150" />
        <asp:BoundField DataField="Transaction Code" HeaderText="TCode" ItemStyle-Width="150" />
        <asp:BoundField DataField="Program" HeaderText="Program" ItemStyle-Width="150" />
        <asp:BoundField DataField="Audit Log Message Te" HeaderText="AuditMessage" ItemStyle-Width="150" />            
    </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:constr %>"            
            SelectCommand="select Date,Time,[Cl.],UserName,[Terminal name],[Transaction Code],Program,[Audit Log Message Te] from SM20_Logs_new where [Audit Log Message Te] LIKE '%Field content%'" FilterExpression="UserName = '{0}'">
 
          <FilterParameters>
        <asp:ControlParameter Name="UserName" ControlID="ddlusers" PropertyName="SelectedValue" />
         </FilterParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
