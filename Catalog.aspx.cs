using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Catalog : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    // don't reload data during postbacks
    if (!IsPostBack)
    {
      PopulateControls();
    }
  }

  // Fill the page with data
  private void PopulateControls()
  {
      // Retrieve BookCategoryID from the query string
      string BookCategoryId = Request.QueryString["BookCategoryID"];
    // Retrieve CategoryID from the query string
    string categoryId = Request.QueryString["CategoryID"];
    // If browsing a category...
    if (categoryId != null)
    {
      // Retrieve category details and display them
      CategoryDetails cd = CatalogAccess.GetCategoryDetails(categoryId);
      catalogTitleLabel.Text = cd.Name;
      catalogDescriptionLabel.Text = cd.Description;
      // Set the title of the page
      this.Title = BalloonShopConfiguration.SiteName +
                   " : Category : " + cd.Name;
    }
    // If browsing a BookCategory...
    else if (BookCategoryId != null)
    {
        // Retrieve BookCategory details and display them
        BookCategoryDetails dd = CatalogAccess.GetBookCategoryDetails(BookCategoryId);
      catalogTitleLabel.Text = dd.Name;
      catalogDescriptionLabel.Text = dd.Description;
      // Set the title of the page
      this.Title = BalloonShopConfiguration.SiteName +
                   " : BookCategory : " + dd.Name;
    }
  }
}
