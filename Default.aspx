<%@ Page Language="C#" MasterPageFile="~/BalloonShop.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Welcome to BalloonShop!" %>

<%@ Register Src="UserControls/ProductsList.ascx" TagName="ProductsList" TagPrefix="uc1" %>
<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">
  <span class="CatalogTitle">Welcome to BalloonShop! </span>
  <br />
  <span class="CatalogDescription">Check out these fantastic categories: </span>
    <br />
      <table style="width: 726px;text-align:center;font-family:Verdana, Helvetica, sans-serif; font-size: 12px;">
          <tr>
      <td><img alt="Fiction" src="ProductImages/THaDesperateFortune.jpg" style="width: 100px;" />
        </td>
    <td><img alt="Mistery" src="ProductImages/THX.jpg" style="width: 100px" />
        </td>
              <td><img alt="Art" src="ProductImages/THharryPotterandthePrisonerofAzkaban.jpg" style="width: 100px" />
        </td>
              <td><img alt="Business" src="ProductImages/THthe7HabitsofHighlyEffectivePeople.jpg" style="width: 100px" />
        </td>
              <td><img alt="Cooking" src="ProductImages/THsaladSamurai.jpg" style="width: 100px" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Fiction</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Mistery</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Children</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Business</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Cooking</asp:HyperLink>
        </td>
    </tr>
          
    </table>
    <span class="CatalogDescription">Check out these fantastic authors: </span>
    <br />
     <table style="width: 726px;text-align:center;font-family:Verdana, Helvetica, sans-serif; font-size: 12px;">
          <tr>
      <td><img alt="Fiction" src="ProductImages/THGMWDeepTrouble.jpg" style="width: 100px;" />
        </td>
    <td><img alt="Mistery" src="ProductImages/THharryPotterandtheGobletofFire.jpg" style="width: 100px" />
        </td>
              <td><img alt="Art" src="ProductImages/THweAreAllMadeofMolecules.jpg" style="width: 100px" />
        </td>
              <td><img alt="Business" src="ProductImages/THtheLakeHouse.jpg" style="width: 100px" />
        </td>
              <td><img alt="Cooking" src="ProductImages/THtheSilkworm.jpg" style="width: 100px" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">R.L. Stine</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">J.K. Rowling</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Susin Nielsen</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink9" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Kate Morton</asp:HyperLink>
        </td>
        <td>
            <asp:HyperLink ID="HyperLink10" runat="server" NavigateUrl="" CssClass="BookCategoryUnselected">Robert Galbraith</asp:HyperLink>
        </td>
    </tr>
          
    </table>
</asp:Content>

