<%@ Page Language="C#" MasterPageFile="~/BalloonShop.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Welcome to BookShop!" %>


<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">
  
  <span class="CatalogTitle">Welcome to Book Store! </span>
  <br />
  <span class="CatalogDescription">Check out these fantastic categories: 
    <br />
    </span>
    
    <br />
      <table style="width: 726px;text-align:center;font-family:Verdana, Helvetica, sans-serif; font-size: 12px;">
          <tr>
      <td><a href="../Catalog.aspx?BookCategoryID=2&CategoryID=13"><img alt="Fiction" src="ProductImages/THaDesperateFortune.jpg" style="width: 100px;" /></a>
        </td>
    <td><a href="../Catalog.aspx?BookCategoryID=2&CategoryID=14"><img alt="Mistery" src="ProductImages/THX.jpg" style="width: 100px" /></a>
        </td>
              <td><a href="../Catalog.aspx?BookCategoryID=7&CategoryID=16"><img alt="Art" src="ProductImages/THharryPotterandthePrisonerofAzkaban.jpg" style="width: 100px" /></a>
        </td>
              <td><a href="../Catalog.aspx?BookCategoryID=6&CategoryID=15"><img alt="Business" src="ProductImages/THthe7HabitsofHighlyEffectivePeople.jpg" style="width: 100px" /></a>
        </td>
              <td><a href="../Catalog.aspx?BookCategoryID=1&CategoryID=11" ><img alt="Cooking" src="ProductImages/THsaladSamurai.jpg" style="width: 100px" /></a>
        </td>
    </tr>
    <tr>
        <td style="height: 17px">
            <a id="Fiction"  href="../Catalog.aspx?BookCategoryID=2&CategoryID=13" style="font-family:Verdana, Arial; color:#2c607a; font-weight:bold;">Fiction</a>
        </td>
        <td style="height: 17px">
            <a id="Mistery"  href="../Catalog.aspx?BookCategoryID=2&CategoryID=14" style="font-family:Verdana, Arial; color:#2c607a; font-weight:bold;">Mistery</a>
        </td>
        <td style="height: 17px">
            <a id="Children"  href="../Catalog.aspx?BookCategoryID=7&CategoryID=16" style="font-family:Verdana, Arial; color:#2c607a; font-weight:bold;">Children</a>
        </td>
        <td style="height: 17px">
            <a id="Business" href="../Catalog.aspx?BookCategoryID=6&CategoryID=15" style="font-family:Verdana, Arial; color:#2c607a; font-weight:bold;">Business</a>
        </td>
        <td style="height: 17px">
            <a id="Cooking"  href="../Catalog.aspx?BookCategoryID=1&CategoryID=11" style="font-family:Verdana, Arial; color:#2c607a; font-weight:bold;">Cooking</a>
        </td>
    </tr>         
    </table>    
          <h3 class="CatalogDescription">BookShop&copy;</h3>
    <p style="font-family: Verdana, Helvetica, sans-serif; font-size: 12px; color:#2c607a;">Online BookShop provides a new way to have a better experience to purchase books. You could pick books from the categories you interested in. We have a special promotion for volumn sale and author sale. Wish you enjoy your exciting shopping time with us. </p>
          <p style="font-family: Verdana, Helvetica, sans-serif; font-size: 12px; color:#2c607a;">For any question and concern, please feel free to contact Us:</p>
          <p style="font-family: Verdana, Helvetica, sans-serif; font-size: 12px; color:#2c607a;">TEL: (416) 416 4164 <br /> Email: <a href="mailto:BookShop@gmail.com">BookShop@gmail.com</a><br />We are glad to hear from you!</p>
    <p style="font-family: Verdana, Helvetica, sans-serif; font-size: 12px;">&nbsp;</p>
    <p>&nbsp;</p>
    </asp:Content>

