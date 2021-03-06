USE [master]
GO
/****** Object:  Database [BookShop]    Script Date: 2015-12-12 2:31:29 PM ******/
CREATE DATABASE [BookShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookShop.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BookShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookShop_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BookShop] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookShop] SET RECOVERY FULL 
GO
ALTER DATABASE [BookShop] SET  MULTI_USER 
GO
ALTER DATABASE [BookShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BookShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BookShop]
GO
/****** Object:  UserDefinedFunction [dbo].[AmtDueDate]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AmtDueDate](@aOrderID INT) 
RETURNS smalldatetime
BEGIN
	DECLARE @CON smalldatetime
	SELECT @CON = dbo.Orders.DateShipped - dbo.Orders.DateCreated
	FROM dbo.Orders
WHERE OrderID = @aOrderID;	
RETURN @CON
END;

GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attribute](
	[AttributeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeValue]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValue](
	[AttributeValueID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeID] [int] NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategory](
	[BookCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_BookCategory] PRIMARY KEY CLUSTERED 
(
	[BookCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[BookCategoryID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateShipped] [smalldatetime] NULL,
	[Verified] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[Canceled] [bit] NOT NULL,
	[Comments] [nvarchar](1000) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[ShippingAddress] [nvarchar](500) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [money] NOT NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[PromoFront] [bit] NOT NULL,
	[PromoDept] [bit] NOT NULL,
	[ISBN] [nvarchar](50) NULL,
	[Publisher] [nvarchar](50) NULL,
	[Author] [nvarchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttributeValue]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributeValue](
	[ProductID] [int] NOT NULL,
	[AttributeValueID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[CartID] [char](36) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Attributes] [nvarchar](1000) NULL,
	[DateAdded] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[ProdsInCats]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProdsInCats]
AS
SELECT dbo.Product.ProductID, dbo.Product.Name, dbo.Product.Description, dbo.Product.Price, dbo.Product.Thumbnail, dbo.ProductCategory.CategoryID
FROM   dbo.Product INNER JOIN
            dbo.ProductCategory ON dbo.Product.ProductID = dbo.ProductCategory.ProductID



GO
SET IDENTITY_INSERT [dbo].[BookCategory] ON 

INSERT [dbo].[BookCategory] ([BookCategoryID], [Name], [Description]) VALUES (1, N'Cookbooks', N'Cookbooks')
INSERT [dbo].[BookCategory] ([BookCategoryID], [Name], [Description]) VALUES (2, N'Fiction', N'Fiction')
INSERT [dbo].[BookCategory] ([BookCategoryID], [Name], [Description]) VALUES (6, N'Business', N'Business')
INSERT [dbo].[BookCategory] ([BookCategoryID], [Name], [Description]) VALUES (7, N'Family', N'Family')
SET IDENTITY_INSERT [dbo].[BookCategory] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (11, 1, N'Cookbooks', N'Cookbooks')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (13, 2, N'Fiction', N'Fiction')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (14, 2, N'Mystery', N'Mystery')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (15, 6, N'Business', N'Business')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (16, 7, N'Children', N'Children')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (17, 7, N'Romance', N'Romance')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (20, 7, N'Mystery', N'Mystery')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (21, 7, N'Fiction', N'Fiction')
INSERT [dbo].[Category] ([CategoryID], [BookCategoryID], [Name], [Description]) VALUES (22, 7, N'Art', N'Art')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (1, N'A Desperate Fortune', N'From the bestselling author of The Firebird, comes a new, exquisitely crafted novel of modern-day and historical intrigue. For nearly 300 years, the mysterious journal of Jacobite exile Mary Dundas has lain unread-its secrets safe from prying eyes. Now, amateur codebreaker Sara Thomas has been hired by a once-famous historian to crack the journal’s cipher. But when she arrives in Paris, Sara finds herself besieged by complications from all sides: the journal’s reclusive owner, her charming Parisian neighbor, and Mary, whose journal doesnt hold the secrets Sara expects. It turns out that Mary Dundas wasn’t keeping a record of everyday life, but a first-hand account of her part in a dangerous intrigue. In the first wintry months of 1732, with a scandal gaining steam in London, driving many into bankruptcy and ruin, the man accused of being at its center is concealed among the Jacobites in Paris, with Mary posing as his sister to aid his disguise. When their location is betrayed, they’re forced to put a desperate plan in action, heading south along the road to Rome, protected by the enigmatic Highlander Hugh MacPherson. As Mary’s tale grows more and more dire, Sara, too, must carefully choose which turning to take…to find the road that will lead her safely home.', 14.9900, N'THaDesperateFortune.jpg', N'aDesperateFortune.jpg', 0, 1, N'1451673833', N'Touchstone', N'Susanna Kearsley')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (2, N'All the Light We Cannot See', N'From the highly acclaimed, multiple award-winning Anthony Doerr, the beautiful, stunningly ambitious instant New York Times bestseller about a blind French girl and a German boy whose paths collide in occupied France as both try to survive the devastation of World War II. Marie-Laure lives with her father in Paris near the Museum of Natural History, where he works as the master of its thousands of locks. When she is six, Marie-Laure goes blind and her father builds a perfect miniature of their neighborhood so she can memorize it by touch and navigate her way home. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure’s reclusive great-uncle lives in a tall house by the sea. With them they carry what might be the museum’s most valuable and dangerous jewel. In a mining town in Germany, the orphan Werner grows up with his younger sister, enchanted by a crude radio they find. Werner becomes an expert at building and fixing these crucial new instruments, a talent that wins him a place at a brutal academy for Hitler Youth, then a special assignment to track the resistance. More and more aware of the human cost of his intelligence, Werner travels through the heart of the war and, finally, into Saint-Malo, where his story and Marie-Laure’s converge. Doerr’s “stunning sense of physical detail and gorgeous metaphors” (San Francisco Chronicle) are dazzling. Deftly interweaving the lives of Marie-Laure and Werner, he illuminates the ways, against all odds, people try to be good to one another. Ten years in the writing, a National Book Award finalist, All the Light We Cannot See is a magnificent, deeply moving novel from a writer “whose sentences never fail to thrill” (Los Angeles Times).', 15.0000, N'THAlltheLightWeCannotSee.jpg', N'AlltheLightWeCannotSee.jpg', 0, 0, N'150110456X', N'Scribner', N'Anthony Doerr')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (3, N'Annabel', N'A finalist for the Scotiabank Giller Prize, the Governor Generals Literary Award, the Rogers Writers Trust Fiction Prize, and a #1 national bestseller, Kathleen Winters spectacular debut novel is now available in a new edition.', 11.3400, N'THannabel.jpg', N'annabel.jpg', 0, 0, N'0887842364', N'House of Anansi Press Inc.', N'Kathleen Winter ')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (4, N'Blue Coyote Motel', N'BLUE COYOTE MOTEL (PSYCHOLOGICAL THRILLER) #1 on 17 Goodreads Best Product Lists An Award Winning Best Seller, Blue Coyote Motel was chosen as a quarter finalist in Amazons Breakthrough Novel Award contest in the mystery/thriller category as well as a Goodreads Psychological Thriller Book of the Month and an e-thriller Book of the Month. Scroll up and get your copy today! Ever wondered what would happen if someone discovered the secret of eternal beauty and happiness? Well for one couple the dream becomes reality ... or does it? Blue Coyote Motel is a suspenseful love story which begins in the barrios of Southern California and spans the globe in such diverse locations as Provence, South America, and the Himalayas. The beautiful Latina, Maria, and her husband, Jeffrey, a scientist fired from a prestigious laboratory, struggle to build a new life in a remote Southern California desert area as owners of the motel. Along with the anti-aging hormone, Jeffrey invents a "feel-good" wonder drug to help Maria with her depression. As Jeffrey becomes insane, he begins to experiment with the wonder drug. Six wayward travelers, including an alcoholic priest, a couple who own gold mines in Brazil, a depressed widow, a struggling salesman, and a Native American pediatrician, find themselves spending the night at the small motel. The next morning they wake up feeling better than ever. Has Jeffreys miracle drug delivered? Or is the nightmare of addiction only beginning?', 15.5600, N'THblueCoyoteMotel.jpg', N'blueCoyoteMotel.jpg', 0, 0, N'1624071678', N'Dianne D. Harman', N'Dianne D. Harman')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (5, N'Career of Evil', N'"When a mysterious package is delivered to Robin Ellacott, she is horrified to discover that it contains a womans severed leg. Her boss, private detective Cormoran Strike, is less surprised but no less alarmed. There are four people from his past who he thinks could be responsible--and Strike knows that any one of them is capable of sustained and unspeakable brutality. With the police focusing on the one suspect Strike is increasingly sure is not the perpetrator, he and Robin take matters into their own hands, and delve into the dark and twisted worlds of the other three men. But as more horrendous acts occur, time is running out for the two of them... Career of Evil is the third in the highly acclaimed series featuring private detective Cormoran Strike and his assistant Robin Ellacott. A fiendishly clever mystery with unexpected twists around every corner, it is also a gripping story of a man and a woman at a crossroads in their personal and professional lives.', 34.2200, N'THcareerofEvil.jpg', N'careerofEvil.jpg', 0, 0, N'0316349933', N'Mulholland Product', N'Robert Galbraith')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (6, N'Chasing Demons', N'"After losing her unborn baby at the hands of her abusive husband, Kendra Salvatori flees from him to Black Mountain, North Carolina. She collapses in the barn of Garth Fisher, who rescues Kendra from near-death and nurses her back to health. When Kendra is fully recovered, she insists on leaving, aware that her husband, Tony Salvatori, head of a small but very powerful criminal organization, will eventually locate her. Kendra and Garth are by this time in love with one another and Kendra is very fearful of what Tony will do to Garth if he finds her with him. Garth persuades Kendra to stay with him, convincing her that they are in a safe place that is not easily accessible. Because Kendra is so frightened of what will happen when her husband finds her, Garth and Kendra begin to prepare themselves mentally and physically for the battle they know they will eventually face. Compelling characters and a fine balance of romance and danger are this authors trademark. Chasing Demons is Christy Tillery French at her best. Laurel Johnson, author of The Grass Dance and The Alley of Wishes "Christy Tillery French with tempered elegance creates a stir of emotions while seamlessly switching from one genre to another. Her vivid and silken writing ability is honeycombed with the magic of suspense, romance, mystery and high-grade entertainment." -Sherry Russell, author of Conquering the Mysteries and Lies of Grief', 18.8300, N'THchasingDemons.jpg', N'chasingDemons.jpg', 0, 0, N'0595291236', N'Mystery & Suspense Pr', N'Christy Tillery French')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (7, N'Dancing with Death', N'Violetta is an executioner… of vampires. Famed for her fiery beauty and mesmerising personality, she has never failed an assignment. Monsieur Martinet is no ordinary vampire, though. He is a master at his craft and can control humans with the merest flick of his eyelids. The vampire huntress with the porcelain skin and flaming red hair has killed all of his brethren, without exception. He now seeks the ultimate revenge: her submission in HIS bed. If he’s allowed to stay alive long enough, that is.', 7.5600, N'THdancingwithDeath.jpg', N'dancingwithDeath.jpg', 0, 0, N'1502584131', N'CreateSpace Independent Publishing Platform', N'C. P. Mandara')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (8, N'Edible and Medicinal Plants of Canada', N'Throughout human history plants have provided us with food, clothing, medicine and shelter. Canada is a huge country with diverse habitats that are home to an incredible diversity of plant species that have helped native peoples and early settlers survive through the centuries. This book describes nearly 600 common trees, shrubs, flowers, ferns, mosses and lichens that have been used by people from ancient times to the present. More than 800 colour photographs and illustrations.', 22.4500, N'THediblemedicineplantofcanada.jpg', N'ediblemedicineplantofcanada.jpg', 0, 0, N'1551055724', N'Publishamerica Inc', N'Andy MacKinnon')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (9, N'Emmy & Oliver', N'Emmy and Oliver were going to be best friends forever, or maybe even more, before their futures were ripped apart. In Emmys soul, despite the space and time between them, their connection has never been severed. But is their story still written in the stars? Or are their hearts like the pieces of two different puzzles—impossible to fit together? Emmy just wants to be in charge of her own life. . . . She wants to stay out late, surf her favorite beach—go anywhere without her parents relentless worrying. But Emmys parents cant seem to let her grow up—not since the day Oliver disappeared. Oliver needs a moment to figure out his heart. . . . Hed thought, all these years, that his dad was the good guy. He never knew that it was his father who had kidnapped him and kept him on the run. Discovering it, and finding himself returned to his old hometown, all at once, has his heart racing, and his thoughts swirling. Readers who love Sarah Dessen will devour these pages with hearts in throats as Emmy and Oliver struggle to face the messy, confusing consequences of Olivers fathers crime. Full of romance, coming-of-age emotion, and heartache, these two equally compelling characters create an unforgettable story.', 34.5500, N'THemmyOliver.jpg', N'emmyOliver.jpg', 0, 0, N'0062330594', N'HarperTeen', N'Robin Benway')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (10, N'Even Dogs in the Wild', N'Even Dogs in the Wild brings back Ian Rankins greatest characters in a story exploring the darkest corners of our instincts and desires.', 45.3300, N'THevenDogsinthe Wild.jpg', N'evenDogsinthe Wild.jpg', 0, 0, N'1409159361', N'Orion', N'Ian Rankin')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (11, N'Everything, Everything', N'My disease is as rare as it is famous. Its a form of Severe Combined Immunodeficiency, but basically, Im allergic to the world. I dont leave my house, have not left my house in fifteen years. The only people I ever see are my mom and my nurse, Carla. But then one day, a moving truck arrives. New next door neighbors. I look out the window, and I see him. Hes tall, lean and wearing all black--black t-shirt, black jeans, black sneakers and a black knit cap that covers his hair completely. He catches me looking and stares at me. I stare right back. His name is Olly. I want to learn everything about him, and I do. I learn that he is funny and fierce. I learn that his eyes are Atlantic Ocean-blue and that his vice is stealing silverware. I learn that when I talk to him, my whole world opens up, and I feel myself starting to change--starting to want things. To want out of my bubble. To want everything, everything the world has to offer. Maybe we cant predict the future, but we can predict some things. For example, I am certainly going to fall in love with Olly. Its almost certainly going to be a disaster.', 23.4300, N'THeverything.jpg', N'everything.jpg', 0, 0, N'0385683650', N'Doubleday Canada', N'Nicola Yoon')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (12, N'Goosebumps Most Wanted #2: Son of Slappy', N'The Most Wanted Goosebumps characters are coming after you! Hello dummy! The evil puppet you hate to love is back for a brand new scare. Jack Stander is a good kid. His parents and teachers all trust him and know that he would never do anything wrong. But after visiting his grandfathers house and meeting Slappy, Jack starts to act... differently. What can Jack do when the dummy starts to control him?', 7.5900, N'THGMWSonofSlappy.jpg', N'GMWSonofSlappy.jpg', 0, 0, N'0545417996', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (15, N'Goosebumps: Zombie Halloween', N'Dr. Brewer is doing a little plant-testing in his basement. Nothing to worry about. Harmless, really. But Margaret and Casey Brewer are worried about their father. Especially when they... meet... some of the plants he is growing down there. Then they notice that their father is developing plantlike tendencies. In fact, he is becoming distinctly weedy — and seedy. Is it just part of their fathers ""harmless"" experiment? Or has the basement turned into another little shop of horrors?', 7.9900, N'THGMWZombieHalloween.jpg', N'GMWZombieHalloween.jpg', 0, 0, N'0545298385', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (16, N'Goosebumps-Beware, the Snowman', N'No melting allowed! Jaclyn used to live with her aunt Greta in Chicago. But not anymore. Theyve moved to a place called Sherpia. Its a tiny village on the edge of the Arctic Circle. Jaclyn cant believe shes stuck out in Nowheresville. No movie theaters. No malls. No nothing. Plus, theres something really odd about the village. At night there are strange howling noises. And in front of every house theres a snowman. A creepy snowman with a red scarf. A deep scar on his face. And a really evil smile...', 7.9900, N'THGMWBewaretheSnowman.jpg', N'GMWBewaretheSnowman.jpg', 0, 0, N'9780439863933', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (17, N'Goosebumps-Franken stein''s Dog', N'Find out why Billy Deep and his sister, Sheena, are afraid of dark lagoons, coral reefs, and anything that appears to be half-human, half-fish.', 6.9900, N'THGMWFrankensteinsDog.jpg', N'GMWFrankensteinsDog.jpg', 0, 0, N'545035198', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (18, N'Goosebumps-Night of the Living Dummy', N'Discover the fan-favorite thriller and chiller that first introduced the world to the wooden face of fear. The puppet who pulls all the strings. None other than Slappy the Dummy!', 7.9900, N'THGMWNightoftheLivingDummy.jpg', N'GMWNightoftheLivingDummy.jpg', 0, 0, N'0545035171', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (19, N'Goosebumps-One Day at HorrorLand', N'When the Morris family get lost trying to find the Zoo Gardens Theme Park, they stumble upon Horrorland instead. What a great place! There are no crowds, admission is free and no queues for the rides...But theres still something very weird about the rides at HorrorLand. Something too creepy.', 7.9900, N'THGMWOneDayatHorrorLand.jpg', N'GMWOneDayatHorrorLand.jpg', 0, 0, N'0439568412', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (20, N'Goosebumps-Piano Lessons Can Be Murder', N'Practice till you drop . . . dead. When Jerry finds a dusty old piano in the attic of his new house, his parents offer to pay for lessons. At first, taking piano seems like a cool idea. But theres something creepy about Jerrys piano teacher, Dr. Shreek. Something really creepy. Something Jerry cant quite put his finger on. Then Jerry hears the stories. Terrifying stories. About the students at Dr. Shreeks music school. Students who went in for a lesson... and never came out.', 7.9900, N'THGMWPiano LessonsCanBeMurder.jpg', N'GMWPiano LessonsCanBeMurder.jpg', 0, 0, N'0439671124', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (21, N'Goosebumps-Say Cheese and Die!', N'Strange things happen when Greg starts using the camera he and his friends found.', 7.9900, N'THGMWSayCheeseandDie.jpg', N'GMWSayCheeseandDie.jpg', 0, 0, N'0545035252', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (22, N'Goosebumps-The Blob That Ate Everyone', N'Read it and scream!A famous horror writer. Thats what Zackie Beauchamp wants to be. Hes writing a story about a giant blob monster. A pink slimy creature who eats up an entire town! Then Zackie finds the typewriter. In a burned-down antiques store. He takes it home and starts typing. But theres something really odd about that typewriter. Something really dangerous. Because now every word Zackie writes is starting to come true...', 7.9900, N'THGMWTheBlobThatAteEveryone.jpg', N'GMWTheBlobThatAteEveryone.jpg', 0, 0, N'0439796199', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (23, N'Goosebumps-The Curse of Camp Cold Lake', N'Camp is supposed to be fun, but Sarah hates Camp Cold Lake. The lake is gross and slimy. And shes having a little trouble with her bunkmates. They hate her. So Sarah comes up with a plan. Shell pretend to drown -- then everyone will feel sorry for her. But things dont go exactly the way Sarah planned. Because down by the cold, dark lake someone is watching her. Stalking her. Someone with pale blue eyes. And a see-through body...', 7.9900, N'THGMWTheCurseofCampColdLake.jpg', N'GMWTheCurseofCampColdLake.jpg', 0, 0, N'043972404X', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (24, N'Goosebumps-The Haunted School', N'Hes hearing voices... from another world! Tommy Frazers dad just got married. Now Tommys got a new mom. And hes going to a new school -- Bell Valley Middle School. Tommy doesnt hate school. But its hard making friends. And his new school is so big, its easy to get lost. Which is exactly what happens.Tommy gets lost -- lost in a maze of empty classrooms. And thats when he hears the voices. Kids voices crying for help. Voices coming from behind the classroom walls...', 7.9900, N'THGMWTheHauntedSchool.jpg', N'GMWTheHauntedSchool.jpg', 0, 0, N'0439774756', N'Scholastic Paperbacks', N'R.L. Stine')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (25, N'Harry Potter and the Chamber of Secrets', N'There is a plot, Harry Potter. A plot to make the most terrible things happen at Hogwarts School of Witchcraft and Wizardry this year. Harry Potters summer has included the worst birthday ever, doomy warnings from a house-elf called Dobby, and rescue from the Dursleys by his friend Ron Weasley in a magical flying car! Back at Hogwarts School of Witchcraft and Wizardry for his second year, Harry hears strange whispers echo through empty corridors -- and then the attacks start. Students are found as though turned to stone... Dobbys sinister predictions seem to be coming true. This gift edition hardback, presented in a beautiful foiled slipcase decorated with brand new line art by Jonny Duddle, will delight readers as they follow Harry and his friends through their second year at Hogwarts School of Witchcraft and Wizardry.', 7.9900, N'THharryPotterandtheChamberofSecrets.jpg', N'harryPotterandtheChamberofSecrets.jpg', 0, 0, N'1408855666', N'Bloomsbury Press', N'J.K. Rowling')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (26, N'Harry Potter and the Goblet of Fire ', N'The Triwizard Tournament is to be held at Hogwarts. Only wizards who are over seventeen are allowed to enter - but that doesnt stop Harry dreaming that he will win the competition. Then at Halloween, when the Goblet of Fire makes its selection, Harry is amazed to find his name is one of those that the magical cup picks out. He will face death-defying tasks, dragons and Dark wizards, but with the help of his best friends, Ron and Hermione, he might just make it through - alive! These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. Its time to PASS THE MAGIC ON ...', 34.6700, N'THharryPotterandtheGobletofFire.jpg', N'harryPotterandtheGobletofFire.jpg', 0, 0, N'1408855682', N'Bloomsbury Press', N'J.K. Rowling')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (27, N'Harry Potter and the Philosophers Stone', N'When a letter arrives for unhappy but ordinary Harry Potter, a decade-old secret is revealed to him that apparently hes the last to know. His parents were wizards, killed by a Dark Lords curse when Harry was just a baby, and which he somehow survived. Escaping his hideous Muggle guardians for Hogwarts, a wizarding school brimming with ghosts and enchantments, Harry stumbles upon a sinister adventure when he finds a three-headed dog guarding a room on the third floor. Then he hears of a missing stone with astonishing powers which could be valuable, dangerous, or both.', 34.5500, N'THharryPotterandthePhilosophersStone.jpg', N'harryPotterandthePhilosophersStone.jpg', 0, 0, N'1408834960', N'Bloomsbury Press', N'J.K. Rowling')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (28, N'Harry Potter and the Prisoner of Azkaban', N'When the Knight Bus crashes through the darkness and screeches to a halt in front of him, its the start of another far from ordinary year at Hogwarts for Harry Potter. Sirius Black, escaped mass-murderer and follower of Lord Voldemort, is on the run - and they say he is coming after Harry. In his first ever Divination class, Professor Trelawney sees an omen of death in Harrys tea leaves ...But perhaps most terrifying of all are the Dementors patrolling the school grounds, with their soul-sucking kiss. These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. Its time to PASS THE MAGIC ON ...', 22.3400, N'THharryPotterandthePrisonerofAzkaban.jpg', N'harryPotterandthePrisonerofAzkaban.jpg', 0, 0, N'1408855674', N'Bloomsbury Press', N'J.K. Rowling')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (29, N'Lost Ocean', N'From the creator of the worldwide bestsellers Secret Garden and Enchanted Forest, a beautiful new coloring book that takes you on a magical journey beneath the waves With Lost Ocean, Johanna Basford invites color-inners of all ages to discover an enchanting underwater world hidden in the depths of the sea. Through intricate pen and ink illustrations to complete, color, and embellish, readers will meet shoals of exotic fish, curious octopuses, and delicately penned seahorses. Visit coral reefs and barnacle-studded shipwrecks, discover intricate shells and pirate treasure. Secret Garden and Enchanted Forest fans and newcomers alike will welcome this creative journey into an inky new world. For Lost Ocean, Johanna picked a crisp ivory paper that accentuates and compliments your chosen color palette. The smooth, untextured pages allow for beautiful blending or gradient techniques with colored pencils or are perfect for pens, allowing the nib to glide evenly over the surface without feathering.', 22.3500, N'THlostOcean.jpg', N'lostOcean.jpg', 0, 0, N'0143108999', N'Penguin Product', N'Johanna Basford')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (30, N'Managing the Professional Service Firm', N'The first comprehensive text on the managerial problems of professional firms. Maister, called "the gurus guru" among his consulting peers, offers the fruits of ten years research and consulting to address management issues that affect enterprises offering highly customized services. Maister explores a wide range of topics, offering insightful and practical advice.', 18.9900, N'THmanagingtheProfessionalServiceFirm.jpg', N'managingtheProfessionalServiceFirm.jpg', 0, 0, N'0029197821', N'Free Pr', N'David H. Maister')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (31, N'MYSTIQUE', N'In search of a mysterious green crystal that holds the key to his legacy, Sir Hugh, a fierce medieval warrior, descends on Lingwood Manor and comes face to face with the fiercely independent, strong-willed Lady Alice. 150,000 first printing. $260,000 ad/promo.', 73.6100, N'THMYSTIQUE.jpg', N'MYSTIQUE.jpg', 0, 0, N'0553096982', N'Bantam', N'Amanda Quick')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (32, N'Outwitting the Devil', N'Napoleon Hill wrote this book in 1938, just after publication of his all-time bestseller, Think and Grow Rich. This powerful tale has never been published, considered too controversial by his family and friends. Using his legendary ability to get to the root of human potential, Napoleon Hill digs deep to identify the greatest obstacles we face in reaching personal goals: fear, procrastination, anger, and jealousy, as tools of the Devil. These hidden methods of control can lead us to ruin, and Hill reveals the seven principles of good that will allow us to triumph over them and succeed. Annotated and edited for a contemporary audience by Rich Dad, Poor Dad and Three Feet from Gold co-author Sharon Lechter, this book is profound, powerful, resonant, and rich with insight.', 24.8900, N'THoutwittingtheDevil.jpg', N'outwittingtheDevil.jpg', 0, 0, N'1402784538', N'Sterling', N'Napoleon Hill')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (33, N'Salad Samurai', N'Discover the Way of the Salad Award-winning chef and Veganomicon coauthor Terry Hope Romero knows her veggies. In Salad Samurai, shes back to teach you the way of the veggie warrior, rescuing salads from their bland, boring reputation and side"" status with more than 100 vibrant, filling entrees. This is your guide to real salad bushido: a hearty base, a zesty dressing, and loads of seriously tasty toppings. Based on whole food ingredients and seasonal produce, these versatile meatless, dairy-free dishes are organized by season for a full year of memorable meals (yes, salad can rock even the coldest days of winter). Dig in to: Spring Herb Salad with Maple Orange Tempeh Deviled Kale Caesar Salad Seared Garlic Chickpeas, Spinach, and Farro Seitan Steak Salad with Green Peppercorn Dressing Herbed Pea Ricotta, Tomatoes, and Basil Mushroom, Barley, and Brussels Harvest Bowl Tempeh Rubenesque Salad Pomegranate Quinoa Holiday Tabouli Seitan Bacon Wedge Salad and many more!', 89.1100, N'THsaladSamurai.jpg', N'saladSamurai.jpg', 0, 0, N'0738214876', N'Da Capo Lifelong Product', N'Terry Hope Romero')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (34, N'Secret Garden', N'Experience the phenomenon that has sold 2 million copies worldwide and launched the coloring craze for adults. This beautiful and interactive coloring book features delicate and highly detailed pen-and-ink illustrations-all waiting to be brought to life with color. As added entertainment, tiny garden creatures are hidden on the pages, waiting to be found, and a key and index are included in the back. The books cover and jacket are also colorable. Appealing to all ages, SECRET GARDEN is the original and first book by Johanna Basford.', 29.5600, N'THsecretGarden.jpg', N'secretGarden.jpg', 0, 0, N'1780671067', N'Laurence King Publishing', N'Johanna Basford ')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (35, N'Stars of Fortune', N'BOOK ONE OF THE GUARDIANS TRILOGY. To celebrate the rise of their new queen, three goddesses of the moon created three stars, one of fire, one of ice, one of water. But then they fell from the sky, putting the fate of all worlds in danger. And now three women and three men join forces to pick up the pieces.… Sasha Riggs is a reclusive artist, haunted by dreams and nightmares that she turns into extraordinary paintings. Her visions lead her to the Greek island of Corfu, where five others have been lured to seek the fire star. Sasha recognizes them, because she has drawn them: a magician, an archaeologist, a wanderer, a fighter, a loner. All on a quest. All with secrets. Sasha is the one who holds them together?the seer. And in the magician, Bran Killian, she sees a man of immense power and compassion. As Sasha struggles with her rare ability, Bran is there to support her, challenge her, and believe in her. But Sasha and Bran are just two of the six. And they must all work together as a team to find the fire star in a cradle of land beneath the sea. Over their every attempt at trust, unity, and love, a dark threat looms. And it seeks to corrupt everything that stands in its way of possessing the stars.', 19.9900, N'THstarsofFortune.jpg', N'starsofFortune.jpg', 0, 0, N'1410481336', N'Thorndike Pr', N'Nora Roberts')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (36, N'The 7 Habits of Highly Effective Families', N'In his first major work since The 7 Habits of Highly Effective People, Steven R. Covey presents a practical and philosophical guide to solving the problems--large and small, mundane and extraordinary--that confront all families and strong communities. By offering revealing anecdotes about ordinary people as well as helpful suggestions about changing everyday behavior, The 7 Habits of Highly Effective Families shows how and why to have family meetings, the importance of keeping promises, how to balance individual and family needs, and how to move from dependence to interdependence. The 7 Habits of Highly Effective Families is an invaluable guidebook to the welfare of families everywhere.', 50.9900, N'THthe7HabitsofHighlyEffectiveFamilies.jpg', N'the7HabitsofHighlyEffectiveFamilies.jpg', 0, 0, N'0307440850', N'St. Martins Griffin', N'Stephen R. Covey')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (37, N'The 7 Habits of Highly Effective People', N'One of the most inspiring and impactful books ever written, The 7 Habits of Highly Effective People has captivated readers for 25 years. It has transformed the lives of Presidents and CEOs, educators and parents— in short, millions of people of all ages and occupations.', 17.8900, N'THthe7HabitsofHighlyEffectivePeople.jpg', N'the7HabitsofHighlyEffectivePeople.jpg', 0, 0, N'1451639619', N'Simon & Schuster', N'Stephen R. Covey')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (38, N'The 8th Habit', N'Profound, compelling, and stunningly timely, this groundbreaking book of next-level thinking gives a clear way to finally tap the limitless value-creation promise of the “Knowledge Worker Age.” The world has changed dramatically since the classic, internationally bestselling The 7 Habits of Highly Effective People was published, influencing tens of millions. The challenges and complexity we all face in our relationships, families, professional lives and communities are of an entirely new order of magnitude. In order to thrive, innovate, excel and lead in what Covey calls the new Knowledge Worker Age, we must build on and move beyond effectiveness...to greatness. Accessing the higher levels of human genius and motivation in todays new reality requires a sea change of new thinking -- a new mind-set, a new skill-set, a new tool-set -- in short, a whole new habit.', 12.7900, N'THthe8thHabit.jpg', N'the8thHabit.jpg', 0, 0, N'0743287932', N'Free Press', N'Stephen R. Covey')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (39, N'The Complete Sherlock Holmes', N'The next elegant edition in the Knickerbocker Classic series is The Complete Sherlock Holmes comprised of 4 full-length novels and 56 short stories featuring the world’s most famous pipe-smoking detective. Written by Sir Arthur Conan Doyle between the years 1867 and 1927, the legendary Sherlock Holmes employed his mastery of deductive reasoning and expert sleuthing to solve an arraying of complex and harrowing cases. From his home – 221B Baker Street in London - the legendary Sherlock Holmes (accompanied by his loyal companion and chronicler, Dr. Watson) baffled policemen and became famous worldwide for his remarkable observations and even more eccentric habits. For Sherlock Holmes fans worldwide, this stunning gift edition has a full cloth binding, foil blocking on the spine, ribbon marker, and is packaged neatly in an elegant slipcase. Featuring a foreword from renowned Holmes scholar, Daniel Stashower, (author of A Teller of Tales: The Life of Arthur Conan Doyle and Sherlock Holmes in America), The Complete Sherlock Holmes contains every known Sherlock Holmes tale ever written. From Holmes’ first appearance in “A Study in Scarlet” (1887) and The Hound of the Baskervilles (1901-1902), through the collection of stories in the The Case-Book of Sherlock Holmes, this deluxe edition boasts the entire Holmes catalogue.', 14.5900, N'THtheCompleteSherlockHolmes.jpg', N'theCompleteSherlockHolmes.jpg', 0, 0, N'1937994309', N'Race Point Publishing', N'Arthur Conan Doyle')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (40, N'The Cuckoos Calling', N'A brilliant debut mystery in a classic vein: Detective Cormoran Strike investigates a supermodels suicide. After losing his leg to a land mine in Afghanistan, Cormoran Strike is barely scraping by as a private investigator. Strike is down to one client, and creditors are calling. He has also just broken up with his longtime girlfriend and is living in his office. Then John Bristow walks through his door with an amazing story: His sister, thelegendary supermodel Lula Landry, known to her friends as the Cuckoo, famously fell to her death a few months earlier. The police ruled it a suicide, but John refuses to believe that. The case plunges Strike into the world of multimillionaire beauties, rock-star boyfriends, and desperate designers, and it introduces him to every variety of pleasure, enticement, seduction, and delusion known to man. You may think you know detectives, but youve never met one quite like Strike. You may think you know about the wealthy and famous, but youve never seen them under an investigation like this. Introducing Cormoran Strike, this is the acclaimed first crime novel by J.K. Rowling, writing under the pseudonym Robert Galbraith.', 23.4500, N'THtheCuckoosCalling.jpg', N'theCuckoosCalling.jpg', 0, 0, N'0316206857', N'Mulholland Product', N'Robert Galbraith')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (41, N'The Girl on the Train', N'Three women, three men, connected through marriage or infidelity. Each is to blame for something. But only one is a killer in this nail-biting, stealthy psychological thriller about human frailty and obsession. Just what goes on in the houses you pass by every day? Rachel takes the same commuter train every morning and evening, rattling over the same junctions, flashing past the same townhouses.The train stops at the same signal every day, and she sees the same couple, breakfasting on their roof terrace. Jason and Jess, as she calls them, seem so happy. Then one day Rachel sees someone new in their garden. Soon after, Rachel sees the woman she calls Jess on the news. Jess has disappeared. Through the ensuing police investigation, Rachel is drawn deeper into the lives of the couple she learns are really Megan and Scott Hipwell. As she befriends Scott, Rachel pieces together what really happened the day Megan disappeared. But when Megans body is found, Rachel finds herself the chief suspect in the case. Plunged into a world of betrayals, secrets and deceptions, Rachel must confront the facts about her own past and her own failed marriage. A sinister and twisting story that will keep you guessing at every turn, The Girl on the Train is a high-speed chase for the truth.', 14.9900, N'THtheGirlontheTrain.jpg', N'theGirlontheTrain.jpg', 0, 0, N'03162068545', N'Doubleday Canada', N'Paula Hawkins')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (42, N'The Goldfinch', N'The Goldfinch is a rarity that comes along perhaps half a dozen times per decade, a smartly written literary novel that connects with the heart as well as the mind....Donna Tartt has delivered an extraordinary work of fiction."-Stephen King, The New York Times Book Review Theo Decker, a 13-year-old New Yorker, miraculously survives an accident that kills his mother. Abandoned by his father, Theo is taken in by the family of a wealthy friend. Bewildered by his strange new home on Park Avenue, disturbed by schoolmates who dont know how to talk to him, and tormented above all by his longing for his mother, he clings to the one thing that reminds him of her: a small, mysteriously captivating painting that ultimately draws Theo into the underworld of art. As an adult, Theo moves silkily between the drawing rooms of the rich and the dusty labyrinth of an antiques store where he works. He is alienated and in love--and at the center of a narrowing, ever more dangerous circle. The Goldfinch is a mesmerizing, stay-up-all-night and tell-all-your-friends triumph, an old-fashioned story of loss and obsession, survival and self-invention, and the ruthless machinations of fate.', 22.3400, N'THtheGoldfinch.jpg', N'theGoldfinch.jpg', 0, 0, N'0316055441', N'Back Bay Product', N'Donna Tartt')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (43, N'The Lake House', N'From the New York Times and internationally bestselling author of The Secret Keeper and The Distant Hours, an intricately plotted, spellbinding new novel of heartstopping suspense and uncovered secrets. Living on her familys idyllic lakeside estate in Cornwall, England, Alice Edevane is a bright, inquisitive, innocent, and precociously talented sixteen-year-old who loves to write stories. But the mysteries she pens are no match for the one her family is about to endure… One midsummer’s eve, after a beautiful party drawing hundreds of guests to the estate has ended, the Edevanes discover that their youngest child, eleven-month-old Theo, has vanished without a trace. What follows is a tragedy that tears the family apart in ways they never imagined. Decades later, Alice is living in London, having enjoyed a long successful career as an author. Theo’s case has never been solved, though Alice still harbors a suspicion as to the culprit. Miles away, Sadie Sparrow, a young detective in the London police force, is staying at her grandfather’s house in Cornwall. While out walking one day, she stumbles upon the old estate—now crumbling and covered with vines, clearly abandoned long ago. Her curiosity is sparked, setting off a series of events that will bring her and Alice together and reveal shocking truths about a past long gone...yet more present than ever. A lush, atmospheric tale of intertwined destinies, this latest novel from a masterful storyteller is an enthralling, thoroughly satisfying read.', 12.9900, N'THtheLakeHouse.jpg', N'theLakeHouse.jpg', 0, 0, N'1451649320', N'Atria Product', N'Kate Morton')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (44, N'The Life We Bury', N'College student Joe Talbert has the modest goal of completing a writing assignment for an English class. His task is to interview a stranger and write a brief biography of the person. With deadlines looming, Joe heads to a nearby nursing home to find a willing subject. There he meets Carl Iverson, and soon nothing in Joes life is ever the same. Carl is a dying Vietnam veteran--and a convicted murderer. With only a few months to live, he has been medically paroled to a nursing home, after spending thirty years in prison for the crimes of rape and murder. As Joe writes about Carls life, especially Carls valor in Vietnam, he cannot reconcile the heroism of the soldier with the despicable acts of the convict. Joe, along with his skeptical female neighbor, throws himself into uncovering the truth, but he is hamstrung in his efforts by having to deal with his dangerously dysfunctional mother, the guilt of leaving his autistic brother vulnerable, and a haunting childhood memory. Thread by thread, Joe unravels the tapestry of Carl’s conviction. But as he and Lila dig deeper into the circumstances of the crime, the stakes grow higher. Will Joe discover the truth before it’s too late to escape the fallout?', 25.0000, N'THtheLifeWeBury.jpg', N'theLifeWeBury.jpg', 0, 0, N'1616149981', N'Seventh Street Product', N'Allen Eskens')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (45, N'The Nature of the Beast', N'Hardly a day goes by when nine year old Laurent Lepage doesnt cry wolf. From alien invasions, to walking trees, to winged beasts in the woods, to dinosaurs spotted in the village of Three Pines, his tales are so extraordinary no one can possibly believe him. Including Armand and Reine-Marie Gamache, who now live in the little Quebec village.', 13.5500, N'THtheNatureoftheBeast.jpg', N'theNatureoftheBeast.jpg', 0, 0, N'1250022088', N'Minotaur Product', N'Louise Penny')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (46, N'The Oh She Glows Cookbook', N'A self-trained chef and food photographer, Angela Liddon has spent years perfecting the art of plant-based cooking, creating inventive and delicious recipes that have brought her devoted fans from all over the world. After struggling for a decade with an eating disorder, Angela vowed to change her diet - and her life - once and for all. She traded the low-calorie, processed food shed been living on for whole, nutrient-packed vegetables, fruits, nuts, whole grains, and more. The result? Her energy soared, she healed her relationship with food, and she got her glow back, both inside and out. Eager to share her realization that the food we put into our bodies has a huge impact on how we look and feel each day, Angela started a blog, Oh She Glows, which is now an internet sensation and one of the most popular vegan recipe blogs on the web. This is Angela’s long-awaited debut cookbook, with a treasure trove of more than a hundred mouth-watering, wholesome recipes – from revamped classics that even meat-eaters will love, to fresh and inventive dishes – all packed with flavor. From rich and hearty entrees like the Crowd Pleasing Tex Mex Casserole and 15-Minute Creamy Avocado Pasta to decadent desserts such as Chilled Chocolate Espresso Torte with Hazelnut Crust and Angela’s famous Glo Bakery Glo Bars, there is something for everyone. The Oh She Glows Cookbook also includes recipes free of common food allergens – with more than ninety gluten-free recipes – and many recipes free of soy, nuts, sugar, and grains, too! Whether you are a vegan, “vegan-curious,” or you simply want to eat delicious food that just happens to be healthy, this cookbook is a must-have for anyone who longs to eat well, feel great, and simply glow!', 12.9900, N'THtheOhSheGlowsCookbook.jpg', N'theOhSheGlowsCookbook.jpg', 0, 0, N'0143187228', N'Penguin Canada', N'Angela Liddon')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (47, N'The Silkworm', N'Private investigator Cormoran Strike returns in a new mystery from Robert Galbraith, author of the #1 international bestseller The Cuckoos Calling.', 35.6700, N'THtheSilkworm.jpg', N'theSilkworm.jpg', 0, 0, N'031620689X', N'Mulholland Product', N'Robert Galbraith')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (48, N'Thug Kitchen', N'Thug Kitchen started their wildly popular web site to inspire people to eat some Goddamn vegetables and adopt a healthier lifestyle. Beloved by Gwyneth Paltrow (""This might be my favorite thing ever"") and named Saveurs Best New Food Blog of 2013 ? with half a million Facebook fans and counting ? Thug Kitchen wants to show everyone how to take charge of their plates and cook up some real f*cking food. Yeah, plenty of blogs and cookbooks preach about how to eat more kale, why ginger fights inflammation, and how to cook with microgreens and nettles. But they are dull or pretentious as hell ? and most people can’t afford the hype. Thug Kitchen lives in the real world. In their first cookbook, they’re throwing down more than 100 recipes for their best-loved meals, snacks, and sides for beginning cooks to home chefs. (Roasted Beer and Lime Cauliflower Tacos? Pumpkin Chili? Grilled Peach Salsa? Believe that sh*t.) Plus they’re going to arm you with all the info and techniques you need to shop on a budget and go and kick a bunch of ass on your own. This book is an invitation to everyone who wants to do better to elevate their kitchen game. No more ketchup and pizza counting as vegetables. No more drive-thru lines. No more avoiding the produce corner of the supermarket. Sh*t is about to get real.', 13.4500, N'THthugKitchen.jpg', N'thugKitchen.jpg', 0, 0, N'1770894659', N'Anansi', N'Thug Kitchen')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (49, N'We Are All Made of Molecules', N'Thirteen-year-old Stewart Inkster is academically brilliant but ""ungifted"" socially. Fourteen-year-old Ashley Anderson is the undisputed ""It"" girl of grade nine, but her marks stink. Their worlds are about to collide when Stewart and his dad move in with Ashley and her mom. ""The Brady Bunch"" it isnt. Stewart is trying to be 89.9% happy about it, but Ashley is 110% horrified. She already has to hide the truth behind her parents divorce; ""Spewart"" could further threaten her position at the top of the social ladder. They are complete opposites. And yet, no matter their differences, they share one thing in common: they--like the rest of us--are all made of molecules. Written in alternating voices, Susin Nielsen deftly explores family tragedy and family ties; sibling rivalry and union; and adolescent confusion and revelation.', 85.7700, N'THweAreAllMadeofMolecules.jpg', N'weAreAllMadeofMolecules.jpg', 0, 0, N'177049779X', N'Tundra Product', N'Susin Nielsen')
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [ISBN], [Publisher], [Author]) VALUES (50, N'X', N'Of #1 New York Times–bestselling author Sue Grafton, NPRs Maureen Corrigan said, “Makes me wish there were more than 26 letters.” With only two letters left, Grafton’s many devoted readers will share that sentiment. X:  The number ten. An unknown quantity. A mistake. A cross. A kiss. X:  The shortest entry in Webster’s Unabridged. Derived from Greek and Latin and commonly found in science, medicine, and religion. The most graphically dramatic letter. Notoriously tricky to pronounce: think xylophone. X:  The twenty-fourth letter in the English alphabet. Sue Grafton’s X: Perhaps her darkest and most chilling novel, it features a remorseless serial killer who leaves no trace of his crimes. Once again breaking the rules and establishing new paths, Grafton wastes little time identifying this sociopath. The test is whether Kinsey can prove her case against him before she becomes his next victim.', 14.5200, N'THX.jpg', N'X.jpg', 0, 0, N'0399163840', N'Marian Wood Product', N'Sue Grafton')
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 22)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 22)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (3, 15)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (4, 15)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (5, 15)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (6, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (7, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (8, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (9, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (10, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (11, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (12, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (15, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (16, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (17, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (18, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (19, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (20, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (21, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (22, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (23, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (24, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (25, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (26, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (27, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (31, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (32, 17)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (33, 11)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (34, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (35, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (36, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (37, 15)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (38, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (39, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (40, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (41, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (42, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (43, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (44, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (45, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (46, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (47, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (48, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (49, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (50, 16)
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'326f3b4c-186e-489e-a120-ef7da08360d7', 1, 5, N'attributes', CAST(N'2015-12-07 16:27:00' AS SmallDateTime))
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Verified]  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Completed]  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Canceled]  DEFAULT ((0)) FOR [Canceled]
GO
ALTER TABLE [dbo].[AttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValue_Attribute] FOREIGN KEY([AttributeID])
REFERENCES [dbo].[Attribute] ([AttributeID])
GO
ALTER TABLE [dbo].[AttributeValue] CHECK CONSTRAINT [FK_AttributeValue_Attribute]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_BookCategory] FOREIGN KEY([BookCategoryID])
REFERENCES [dbo].[BookCategory] ([BookCategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_BookCategory]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_AttributeValue] FOREIGN KEY([AttributeValueID])
REFERENCES [dbo].[AttributeValue] ([AttributeValueID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_AttributeValue]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_Product]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
/****** Object:  StoredProcedure [dbo].[CatalogAddBookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAddBookCategory]
(@BookCategoryName nvarchar(50),
@BookCategoryDescription nvarchar(1000))
AS
INSERT INTO BookCategory (Name, Description)
VALUES (@BookCategoryName, @BookCategoryDescription)



GO
/****** Object:  StoredProcedure [dbo].[CatalogAssignProductToCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAssignProductToCategory]
(@ProductID int, @CategoryID int)
AS
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateCategory]
(@BookCategoryID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(50))
AS
INSERT INTO Category (BookCategoryID, Name, Description)
VALUES (@BookCategoryID, @CategoryName, @CategoryDescription)



GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateProduct]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateProduct]
(@CategoryID INT,
 @ProductName NVARCHAR(50),
 @ProductDescription NVARCHAR(MAX),
 @Price MONEY,
 @Thumbnail NVARCHAR(50),
 @Image NVARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
-- Declare a variable to hold the generated product ID
DECLARE @ProductID int
-- Create the new product entry

INSERT INTO Product 
    (Name, 
     Description, 
     Price, 
     Thumbnail, 
     Image,
     PromoFront, 
     PromoDept)
VALUES 
    (@ProductName, 
     @ProductDescription, 
     @Price, 
     @Thumbnail, 
     @Image,
     @PromoFront, 
     @PromoDept)
-- Save the generated product ID to a variable
SELECT @ProductID = @@Identity
-- Associate the product with a category
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteBookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteBookCategory]
(@BookCategoryID int)
AS
DELETE FROM BookCategory
WHERE BookCategoryID = @BookCategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteCategory]
(@CategoryID int)
AS
DELETE FROM Category
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteProduct]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteProduct]
(@ProductID int)
AS
DELETE FROM ShoppingCart WHERE ProductID=@ProductID
DELETE FROM ProductCategory WHERE ProductID=@ProductID
DELETE FROM Product where ProductID=@ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetAllProductsInCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetAllProductsInCategory]
(@CategoryID INT)
AS
SELECT Product.ProductID, Name, Description, Price, Thumbnail, 
       Image, PromoDept, PromoFront
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetBookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetBookCategory] AS
SELECT BookCategoryID, Name, Description
FROM BookCategory



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetBookCategoryDetails]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetBookCategoryDetails]
(@BookCategoryID INT)
AS
SELECT Name, Description
FROM BookCategory
WHERE BookCategoryID = @BookCategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesInBookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--missing procedures from 05-07


CREATE PROCEDURE [dbo].[CatalogGetCategoriesInBookCategory]
(@BookCategoryID INT)
AS
SELECT CategoryID, Name, Description
FROM Category
WHERE BookCategoryID = @BookCategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithoutProduct]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithoutProduct]
(@ProductID int)
AS
SELECT CategoryID, Name
FROM Category
WHERE CategoryID NOT IN
   (SELECT Category.CategoryID
    FROM Category INNER JOIN ProductCategory
    ON Category.CategoryID = ProductCategory.CategoryID
    WHERE ProductCategory.ProductID = @ProductID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithProduct]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithProduct]
(@ProductID int)
AS
SELECT Category.CategoryID, Name
FROM Category INNER JOIN ProductCategory
ON Category.CategoryID = ProductCategory.CategoryID
WHERE ProductCategory.ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoryDetails]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoryDetails]
(@CategoryID INT)
AS
SELECT BookCategoryID, Name, Description
FROM Category
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductAttributeValues]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create CatalogGetProductAttributeValues stored procedure
CREATE PROCEDURE [dbo].[CatalogGetProductAttributeValues]
(@ProductId INT)
AS
SELECT a.Name AS AttributeName,
       av.AttributeValueID, 
       av.Value AS AttributeValue
FROM AttributeValue av
INNER JOIN attribute a ON av.AttributeID = a.AttributeID
WHERE av.AttributeValueID IN
  (SELECT AttributeValueID
   FROM ProductAttributeValue
   WHERE ProductID = @ProductID)
ORDER BY a.Name;



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductDetails]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductDetails]
(@ProductID INT)
AS
SELECT Name, Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductRecommendations]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CatalogGetProductRecommendations]
(@ProductID INT,
@DescriptionLength INT)
AS
SELECT ProductID,
Name,
CASE WHEN LEN(Description) <= @DescriptionLength THEN Description
ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END
AS Description
FROM Product
WHERE ProductID IN
(
SELECT TOP 5 od2.ProductID
FROM OrderDetail od1
JOIN OrderDetail od2 ON od1.OrderID = od2.OrderID
WHERE od1.ProductID = @ProductID AND od2.ProductID != @ProductID
GROUP BY od2.ProductID
ORDER BY COUNT(od2.ProductID) DESC
)



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsInCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsInCategory]
(@CategoryID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnDeptPromo]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnDeptPromo]
(@BookCategoryID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)

-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS Row,
       ProductID, Name, SUBSTRING(Description, 1, @DescriptionLength)
+ '...' AS Description,
       Price, Thumbnail, Image, PromoFront, PromoDept
FROM
(SELECT DISTINCT Product.ProductID, Product.Name,
       CASE WHEN LEN(Product.Description) <= @DescriptionLength 
            THEN Product.Description 
            ELSE SUBSTRING(Product.Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
  FROM Product INNER JOIN ProductCategory
                      ON Product.ProductID = ProductCategory.ProductID
              INNER JOIN Category
                      ON ProductCategory.CategoryID = Category.CategoryID
  WHERE Product.PromoDept = 1
   AND Category.BookCategoryID = @BookCategoryID
) AS ProductOnDepPr

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnFrontPromo]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnFrontPromo]
(@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE PromoFront = 1

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogMoveProductToCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogMoveProductToCategory]
(@ProductID int, @OldCategoryID int, @NewCategoryID int)
AS
UPDATE ProductCategory
SET CategoryID = @NewCategoryID
WHERE CategoryID = @OldCategoryID
  AND ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogRemoveProductFromCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogRemoveProductFromCategory]
(@ProductID int, @CategoryID int)
AS
DELETE FROM ProductCategory
WHERE CategoryID = @CategoryID AND ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateBookCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateBookCategory]
(@BookCategoryID int,
@BookCategoryName nvarchar(50),
@BookCategoryDescription nvarchar(1000))
AS
UPDATE BookCategory
SET Name = @BookCategoryName, Description = @BookCategoryDescription
WHERE BookCategoryID = @BookCategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateCategory]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateCategory]
(@CategoryID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(1000))
AS
UPDATE Category
SET Name = @CategoryName, Description = @CategoryDescription
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateProduct]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateProduct]
(@ProductID INT,
 @ProductName VARCHAR(50),
 @ProductDescription VARCHAR(5000),
 @Price MONEY,
 @Thumbnail VARCHAR(50),
 @Image VARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
UPDATE Product
SET Name = @ProductName,
    Description = @ProductDescription,
    Price = @Price,
    Thumbnail = @Thumbnail,
    Image = @Image,
    PromoFront = @PromoFront,
    PromoDept = @PromoDept
WHERE ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateOrder] 
(@CartID char(36))
AS
/* Insert a new record INTo Orders */
DECLARE @OrderID INT
INSERT INTO Orders DEFAULT VALUES
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)
SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID



GO
/****** Object:  StoredProcedure [dbo].[GetShoppingCartRecommendations]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetShoppingCartRecommendations]
(@CartID CHAR(36),
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that exist in a list of orders
   SELECT TOP 5 od1.ProductID AS Rank
   FROM OrderDetail od1 
     JOIN OrderDetail od2
       ON od1.OrderID=od2.OrderID
     JOIN ShoppingCart sp
       ON od2.ProductID = sp.ProductID
   WHERE sp.CartID = @CartID
        -- Must not include products that already exist in the visitor''s cart
      AND od1.ProductID NOT IN
      (
      -- Returns the products in the specified shopping cart
      SELECT ProductID 
      FROM ShoppingCart
      WHERE CartID = @CartID
      )
   -- Group the ProductID so we can calculate the rank
   GROUP BY od1.ProductID
   -- Order descending by rank
   ORDER BY COUNT(od1.ProductID) DESC
   )



GO
/****** Object:  StoredProcedure [dbo].[OrderGetDetails]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetDetails]
(@OrderID INT)
AS
SELECT Orders.OrderID, 
       ProductID, 
       ProductName, 
       Quantity, 
       UnitCost, 
       Subtotal
FROM OrderDetail JOIN Orders
ON Orders.OrderID = OrderDetail.OrderID
WHERE Orders.OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderGetInfo]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetInfo]
(@OrderID INT)
AS
SELECT OrderID, 
      (SELECT ISNULL(SUM(Subtotal), 0) FROM OrderDetail WHERE OrderID = @OrderID)        
       AS TotalAmount, 
       DateCreated, 
       DateShipped, 
       Verified, 
       Completed, 
       Canceled, 
       Comments, 
       CustomerName, 
       ShippingAddress, 
       CustomerEmail
FROM Orders
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCanceled]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCanceled]
(@OrderID INT)
AS
UPDATE Orders
SET Canceled = 1
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCompleted]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCompleted]
(@OrderID INT)
AS
UPDATE Orders
SET Completed = 1,
    DateShipped = GETDATE()
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkVerified]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkVerified]
(@OrderID INT)
AS
UPDATE Orders
SET Verified = 1
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByDate]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByDate] 
(@StartDate SMALLDATETIME,
 @EndDate SMALLDATETIME)
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE DateCreated BETWEEN @StartDate AND @EndDate
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByRecent]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByRecent] 
(@Count smallINT)
AS
-- Set the number of rows to be returned
SET ROWCOUNT @Count
-- Get list of orders
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
ORDER BY DateCreated DESC
-- Reset rowcount value
SET ROWCOUNT 0



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetUnverifiedUncanceled]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetUnverifiedUncanceled]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=0 AND Canceled=0
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetVerifiedUncompleted]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetVerifiedUncompleted]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=1 AND Completed=0
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderUpdate]
(@OrderID INT,
 @DateCreated SMALLDATETIME,
 @DateShipped SMALLDATETIME = NULL,
 @Verified BIT,
 @Completed BIT,
 @Canceled BIT,
 @Comments VARCHAR(200),
 @CustomerName VARCHAR(50),
 @ShippingAddress VARCHAR(200),
 @CustomerEmail VARCHAR(50))
AS
UPDATE Orders
SET DateCreated=@DateCreated,
    DateShipped=@DateShipped,
    Verified=@Verified,
    Completed=@Completed,
    Canceled=@Canceled,
    Comments=@Comments,
    CustomerName=@CustomerName,
    ShippingAddress=@ShippingAddress,
    CustomerEmail=@CustomerEmail
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[SearchCatalog]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchCatalog] 
(@DescriptionLength INT,
 @PageNumber TINYINT,
 @ProductsPerPage TINYINT,
 @HowManyResults INT OUTPUT,
 @AllWords BIT,
 @Word1 NVARCHAR(15) = NULL,
 @Word2 NVARCHAR(15) = NULL,
 @Word3 NVARCHAR(15) = NULL,
 @Word4 NVARCHAR(15) = NULL,
 @Word5 NVARCHAR(15) = NULL)
AS

/* @NecessaryMatches needs to be 1 for any-word searches and
   the number of words for all-words searches */
DECLARE @NecessaryMatches INT
SET @NecessaryMatches = 1
IF @AllWords = 1 
  SET @NecessaryMatches =
    CASE WHEN @Word1 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word2 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word3 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word4 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word5 IS NULL THEN 0 ELSE 1 END;

/* Create the table variable that will contain the search results */
DECLARE @Matches TABLE
([Key] INT NOT NULL,
 Rank INT NOT NULL)

-- Save matches for the first word
IF @Word1 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word1

-- Save the matches for the second word
IF @Word2 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word2

-- Save the matches for the third word
IF @Word3 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word3

-- Save the matches for the fourth word
IF @Word4 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word4

-- Save the matches for the fifth word
IF @Word5 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word5

-- Calculate the IDs of the matching products
DECLARE @Results TABLE
(RowNumber INT,
 [KEY] INT NOT NULL,
 Rank INT NOT NULL)

-- Obtain the matching products 
INSERT INTO @Results
SELECT ROW_NUMBER() OVER (ORDER BY COUNT(M.Rank) DESC),
       M.[KEY], SUM(M.Rank) AS TotalRank
FROM @Matches M
GROUP BY M.[KEY]
HAVING COUNT(M.Rank) >= @NecessaryMatches

-- return the total number of results using an OUTPUT variable
SELECT @HowManyResults = COUNT(*) FROM @Results

-- populate the table variable with the complete list of products
SELECT Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product 
INNER JOIN @Results R
ON Product.ProductID = R.[KEY]
WHERE R.RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND R.RowNumber <= @PageNumber * @ProductsPerPage
ORDER BY R.Rank DESC



GO
/****** Object:  StoredProcedure [dbo].[SearchWord]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchWord] (@Word NVARCHAR(50))
AS

SET @Word = 'FORMSOF(INFLECTIONAL, "' + @Word + '")'

SELECT COALESCE(NameResults.[KEY], DescriptionResults.[KEY]) AS [KEY],
       ISNULL(NameResults.Rank, 0) * 3 + 
       ISNULL(DescriptionResults.Rank, 0) AS Rank 
FROM 
  CONTAINSTABLE(Product, Name, @Word, 
                LANGUAGE 'English') AS NameResults
  FULL OUTER JOIN
  CONTAINSTABLE(Product, Description, @Word, 
                LANGUAGE 'English') AS DescriptionResults
  ON NameResults.[KEY] = DescriptionResults.[KEY]



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartAddItem]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartAddItem]
(@CartID char(36),
 @ProductID int,
 @Attributes nvarchar(1000))
AS
IF EXISTS
        (SELECT CartID
         FROM ShoppingCart
         WHERE ProductID = @ProductID AND CartID = @CartID)
    UPDATE ShoppingCart
    SET Quantity = Quantity + 1
    WHERE ProductID = @ProductID AND CartID = @CartID
ELSE
    IF EXISTS (SELECT Name FROM Product WHERE ProductID=@ProductID)
        INSERT INTO ShoppingCart (CartID, ProductID, Attributes, Quantity, DateAdded)
        VALUES (@CartID, @ProductID, @Attributes, 1, GETDATE())



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartCountOldCarts]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartCountOldCarts]
(@Days smallint)
AS
SELECT COUNT(CartID)
FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartDeleteOldCarts]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartDeleteOldCarts]
(@Days smallint)
AS
DELETE FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetItems]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetItems]
(@CartID char(36))
AS
SELECT Product.ProductID, Product.Name, ShoppingCart.Attributes, Product.Price, ShoppingCart.Quantity,Product.Price * ShoppingCart.Quantity AS Subtotal
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetTotalAmount]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetTotalAmount]
(@CartID char(36))
AS
SELECT ISNULL(SUM(Product.Price * ShoppingCart.Quantity), 0)
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartRemoveItem]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartRemoveItem]
(@CartID char(36),
 @ProductID int)
AS
DELETE FROM ShoppingCart
WHERE CartID = @CartID and ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartUpdateItem]    Script Date: 2015-12-12 2:31:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartUpdateItem]
(@CartID char(36),
 @ProductID int,
 @Quantity int)
AS
IF @Quantity <= 0
  EXEC ShoppingCartRemoveItem @CartID, @ProductID
ELSE
  UPDATE ShoppingCart
  SET Quantity = @Quantity, DateAdded = GETDATE()
  WHERE ProductID = @ProductID AND CartID = @CartID



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 156
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "ProductCategory"
            Begin Extent = 
               Top = 9
               Left = 307
               Bottom = 114
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
USE [master]
GO
ALTER DATABASE [BookShop] SET  READ_WRITE 
GO
