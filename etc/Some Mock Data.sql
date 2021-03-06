USE [master]
GO
/****** Object:  Database [FlashCards]    Script Date: 4/18/2019 8:27:12 PM ******/
CREATE DATABASE [FlashCards]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FlashCards', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FlashCards.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FlashCards_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FlashCards_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [FlashCards] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlashCards].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlashCards] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlashCards] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlashCards] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlashCards] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlashCards] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlashCards] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [FlashCards] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlashCards] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlashCards] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlashCards] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlashCards] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlashCards] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlashCards] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlashCards] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlashCards] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FlashCards] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlashCards] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlashCards] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlashCards] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlashCards] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlashCards] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FlashCards] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FlashCards] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FlashCards] SET  MULTI_USER 
GO
ALTER DATABASE [FlashCards] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlashCards] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FlashCards] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FlashCards] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FlashCards] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FlashCards] SET QUERY_STORE = OFF
GO
USE [FlashCards]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [FlashCards]
GO
/****** Object:  Table [dbo].[cards]    Script Date: 4/18/2019 8:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cards](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[front] [nvarchar](max) NULL,
	[back] [nvarchar](max) NOT NULL,
	[img] [nvarchar](max) NULL,
	[card_order] [int] NOT NULL,
	[deck_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[decks]    Script Date: 4/18/2019 8:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[decks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[is_public] [bit] NOT NULL,
	[for_review] [bit] NOT NULL,
	[users_id] [int] NOT NULL,
	[color] [nvarchar](max) NULL,
	[text_color] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tags]    Script Date: 4/18/2019 8:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [varchar](max) NOT NULL,
	[card_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 4/18/2019 8:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[display_name] [varchar](max) NULL,
	[email] [varchar](max) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[salt] [varchar](max) NOT NULL,
	[is_admin] [bit] NOT NULL,
	[role] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cards] ON 

INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (1, N'Encapsulation', N'This is the process of enclosing one or more items within a physical or logical package', N'', 2, 1)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (2, N'Inheritance', N'The act of having one class adopt the properties and methods of another class. This prevents code duplication and allows us to share code across classes while having the source code live in only one class file.', N'', 3, 1)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (3, N'Polymorphism', N'Polymorphism is the idea that something can be assigned a different meaning or usage based on the context it is referred to as. This specifically allows variables and objects to take on more than one form.', N'', 4, 1)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (4, N'Object', N'An object is an in-memory data structure that combines state and behavior into a usable and useful abstraction.', N'', 5, 1)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (16, N'What is Agile development?', N'A software development methodology that delivers functionality in rapid iterations, measured in weeks, requiring frequent communication, development, testing, and delivery.', N'', 1, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (17, N'What is Ruby on Rails?', N'Open source web application framework that uses convention to quickly create MVC. Written on top of the Ruby programming language.', N'', 2, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (18, N'What are some language features of JavaScript?', N'Object Oriented language; Client Side language that can also be used server side; Interpreter based; scripting language of the WWW; Used principally to act on the DOM server-side; inheritance is prototype oriented.', N'', 3, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (19, N'What are the four principles of object oriented programming?', N'Abstraction, Encapsulation, Inheritance, Polymorphism', N'', 4, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (20, N'What is abstraction?', N'Abstraction is a process of hiding the implementation details and showing only functionality to the user. Abstraction lets you focus on what the object does instead of how it does it.', N'', 5, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (21, N'What is encapsulation?', N'Surrounding something, not just to keep the contents together, but also to protect those contents. Restricts access to the inner workings of a class or any objects based on that class; this is referred to as information hiding or data hiding.', N'', 6, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (22, N'What is inheritance?', N'Inheritance is a mechanism in which one object acquires all the properties and behaviour of another object of another class. It is used for Code Resusability and Method Overriding. A child class inherits/reuses methods from its parent class.', N'', 7, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (23, N'What is polymorphism?', N'When two different objects respond to the exact same message in different ways. Two different classes might have the same named method that is implemented in a manner specific to that class.', N'', 8, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (24, N'What is BEM CSS?', N'Methodology for structuring CSS code that uses Block, Element, Modifiers.', N'', 9, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (25, N'What is jQuery?', N'A library of JavaScript functions which make coding interactive web behaviors easier than plain JavaScript', N'', 10, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (26, N'What is an API?', N'An application programming interface (API) allows application developers to bypass traditional web pages and interact directly with the underlying service through function calls. Web APIs respond with raw data not meant for rendering a user experience.', N'', 11, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (27, N'What is Backbone?', N'A JavaScript framework that structures JS code into an MVC pattern; Especially useful for organizing and maintaining large amounts of code tying together a complex user interface.', N'', 12, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (28, N'What is postgresql?', N'Open source object relational database management system that uses and extends the SQL language', N'', 13, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (29, N'What is elasticsearch?', N'open-source, broadly-distributable, readily-scalable, enterprise-grade search engine. Accessible through an extensive and elaborate API, Elasticsearch can power extremely fast searches that support your data discovery applications.', N'', 14, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (30, N'what is redis?', N'Redis is an in-memory data structure store, used as database, cache and message broker. Supports caching, where some data is stored in a cache for faster retrieval.', N'', 15, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (31, N'What is PredictionIO?', N'Machine learning server built on an open source stack; supports scaling and simplifying of the development of machine learning technology.', N'', 16, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (32, N'What is OOP?', N'"Object-oriented programming (OOP) is a programming paradigm using ""objects"" - data structures consisting of data fields and methods together with their interactions - to design applications and computer programs. OOP allows faster development (in the long run) and easier maintenance of code.', N'', 17, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (33, N'What are some disadvantage of OOP?', N'OOP requires larger program sizes (all else being equal) and reduces the speed of the program.', N'', 18, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (34, N'What is prototypal inheritance?', N'JavaScript uses prototypal inheritance. Objects inherit directly from other objects, rather than taxonomies of classes with class inheritance. In JavaScript, all objects have a hidden prototype property that is either another object or null.', N'', 19, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (35, N'How can you validate your html?', N'A computer program can check html or css code for errors; w3 schools has an online html or css validator.', N'', 20, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (36, N'What are some advantages of validating html and css code?', N'Using a validation engine improves cross-browser compatibility, improves search engine rankings by eliminating errors, and is insurance against future web browser editions throwing errors with your code.', N'', 21, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (37, N'What is w3c?', N'World Wide Web Consortium; international organization that maintains standards for the world wide web.', N'', 22, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (38, N'What is the difference between props and state?', N'The state is a data structure that starts with a default value when a Component mounts. It may be mutated across time, mostly as a result of user events.  Props (short for properties) are a Component''s configuration. They are received from above and immutable as far as the Component receiving them is concerned. A Component cannot change its props, but it is responsible for putting together the props of its child Components. Props do not have to just be data - callback functions may be passed in as props.', N'', 23, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (39, N'What is Bootstrap?', N'A Web design framework that provides ready-made css, and javascript components to create responsive web sites.', N'', 24, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (40, N'What are the three main ways to apply CSS to a web page?', N'With an inline style attribute of an element, with a style block in the head section of the html, and with an external link using the link tag.', N'', 25, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (41, N'What is the CSS box model?', N'is essentially boxes within boxes that wraps around HTML elements, and it consists of from outer box to inner box: margins, borders, padding, and the actual content.', N'', 26, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (42, N'What is DOM?', N'Document Object Model;treats an HTML, XHTML, or XML document as a tree structure wherein each node is an object representing a part of the document. When a browser creates a DOM, it must combine the document''s content with its style information', N'', 27, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (43, N'What is Git?', N'A distributed version control system. It can track changes to a file and allows you to revert back to any particular change.', N'', 28, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (44, N'What are html meta tags?', N'Meta tags always go inside head tag of the HTML page. Meta tags is always passed as name/value pairs. Meta tags are not displayed on the page but intended for the browser. Meta tags can contain information about character encoding, description, title of the document etc.', N'', 29, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (45, N'What is the difference between span and div?', N'div is a block element and span is inline element. A div can have a p tag or span tag inside of it but a span tag can not have a p tag or div element.', N'', 30, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (46, N'What is one way to get better rankings from a search engine?', N'Use a meta tag with keywords and description.', N'', 31, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (47, N'What is scope in javascript?', N'In JavaScript, each function gets its own scope. Scope is basically a collection of variables as well as the rules for how those variables are accessed by name. Only code inside that function can access that function''s scoped variables.  A variable name has to be unique within the same scope. A scope can be nested inside another scope. If one scope is nested inside another, code inside the innermost scope can access variables from either scope.', N'', 32, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (48, N'What is event bubbling and how can it be prevented?', N'the concept in which an event triggers at the deepest possible element, and triggers on parent elements in nesting order. As a result, when clicking on a child element one may exhibit the handler of the parent activating.  One way to prevent event bubbling is using event.stopPropagation() or event.cancelBubble on IE < 9.', N'', 33, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (49, N'What does "use strict" do?', N'The ''use strict'' literal is entered at the top of a JavaScript program or at the top of a function and it helps you write safer JavaScript code by throwing an error if a global variable is created by mistake.', N'', 34, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (50, N'Explain Null and Undefined in JavaScript', N'Something hasn''t been initialized : undefined. Something is currently unavailable: null.', N'', 35, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (51, N'What is the difference between "not defined" and "undefined" in JavaScript?', N'A declared variable that has no return value is undefined; a variable that has not been declared throws "not defined" when called.', N'', 36, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (52, N'What is npm?', N'Node Package Manager; npm provides following two main functionalities:  Online repositories for node.js packages/modules which are searchable on search.nodejs.org Command line utility to install packages, do version management and dependency management of Node.js packages.', N'', 37, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (53, N'What is Node.js?', N'Node.js is a web application framework built on Google Chrome''s JavaScript Engine (V8 Engine).  Node.js comes with runtime environment on which a Javascript based script can be interpreted and executed (It is analogus to JVM to JAVA byte code). This runtime allows to execute a JavaScript code on any machine outside a browser. Because of this runtime of Node.js, JavaScript is now can be executed on server as well.', N'', 38, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (54, N'What is Sass?', N'Sass or Syntactically Awesome StyleSheets is a CSS preprocessor that adds power and elegance to the basic language. It allows you to use variables, nested rules, mixins, inline imports, and more, all with a fully CSS-compatible syntax. Sass helps keep large stylesheets well-organized, and get small stylesheets up and running quickly.', N'', 39, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (55, N'What is SQL injection?', N'User enters SQL statement into a form instead of a name or other data.  Accepted code becomes part of database commands issued.  Improper data disclosure, data damage and loss possible.  Well-designed applications make injections ineffective .', N'', 40, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (56, N'How can you prevent SQL injections?', N'Prepared statements with parameterized queries Stored procedures Input validation - blacklist validation and whitelist validation Principle of least privilege - Application accounts shouldn''t assign DBA or admin type access onto the database server. This ensures that if an application is compromised, an attacker won''t have the rights to the database through the compromised application.', N'', 41, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (57, N'What is impersonation?', N'For IT Systems impersonation means that some specific users (usually Admins) could get an access to other user''s data.', N'', 42, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (58, N'What is Cross Site Scripting (XSS)?', N'Cross-site scripting (XSS) - Injects scripts into web application server to direct attacks at unsuspecting clients (Cross-site scripting attacks occur when attacker takes advantage of web applications that accept user input without validation and then present back to user For example: Input that the user enters for Name is not verified Instead is automatically added to a code segment that becomes part of an automated response An attacker can use this vulnerability in XSS attack by tricking valid website into feeding malicious script to another user''s web browser to execute', N'', 43, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (59, N'What is the difference between var and let?', N'var is scoped to the neatest function block and let is scoped to the nearest block. let was added by ES6 standards. Let also does not make the variable accessible before it is declared; it is also not hoisted to outer scope.', N'', 44, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (60, N'What is a callback function?', N'function that is passed to another function as an argument and is executed after some operation has been completed.', N'', 45, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (61, N'What is ES6?', N'Version 6 of the ECMAscript standards. Introduced let, const, arrow functions, default function parameters, and classes.', N'', 46, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (62, N'What is hoisting in JavaScript?', N'The default behavior of moving declarations to the top of the script; without strict, or using var, a variable may be accessed before it is declared.', N'', 47, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (63, N'What is the purpose of the alt attribute on images?', N'To provide alternative information on the image if a user is unable to view it.', N'', 48, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (125, N'What is an iframe and how does it work?', N'an HTML document which can be embedded inside another HTML page.', N'', 49, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (126, N'What were some of the goals of html5?', N'Deliver rich content (graphics, movies, etc.) without the need for additional plugins, such as Flash. Provide better semantic support for web page structure through new structural element tags. Provide a stricter parsing standard to simplify error handling, ensure more consistent cross-browser behaviour, and simplify compatibility with documents written to older standards. Provide better cross-platform support whether running on a PC, Tablet, or Smartphone.', N'', 50, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (127, N'What are two ways to highlight text in a web page?', N'1. use a <mark></mark> tag for html5 pages;  2. set the background-color style attribute.', N'', 51, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (128, N'What is a self-closing tag?', N'Some tags do not need to have an adjoining closing tag. Example:  <meta> <meta />   are both okay in html5.', N'', 52, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (129, N'What is the purpose of a header tag?', N'<header> is used to contain introductory and navigational information about a section of the page. This can include the section heading, the author''s name, time and date of publication, table of contents, or other navigational information.', N'', 53, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (130, N'What is the difference between fork, branch, and clone?', N'A fork is a remote, server-side copy of a repository, distinct from the original. a clone is a local copy of some remote repository. When you clone, you are actually copying the entire source repository, including all the history and branches. A branch is a mechanism to handle the changes within a single repository in order to eventually merge them with the rest of code. A branch is something that is within a repository. Conceptually, it represents a thread of development.', N'', 54, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (131, N'What is the difference between git pull and git fetch?', N'git pull does both a git fetch and git merge', N'', 55, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (132, N'What is the difference between a pull request and a branch?', N'A branch is just a separate version of the code.  A pull request is when someone take the repository, makes their own branch, does some changes, then tries to merge that branch in (put their changes in the other person''s code repository).', N'', 56, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (133, N'How does React work?', N'React creates a virtual DOM. When state changes in a component it firstly runs a "diffing" algorithm, which identifies what has changed in the virtual DOM. The second step is reconciliation, where it updates the DOM with the results of diff.', N'', 57, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (134, N'What is React?', N'React is an open-source JavaScript library created by Facebook for building complex, interactive UIs in web and mobile applications. React''s core purpose is to build UI components; it is often referred to as just the "V" (View) in an "MVC" architecture.', N'', 58, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (135, N'What is ReactJS?', N'ReactJS is an open-source frontend JavaScript library which is used for building user interfaces especifically for single page applications. It is used for handling view layer for web and mobile apps', N'', 59, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (136, N'What is virtual DOM?', N'The virtual DOM (VDOM) is an in-memory representation of Real DOM. The representation of a UI is kept in memory and synced with the "real" DOM. It''s a step that happens between the render function being called and the displaying of elements on the screen. This entire process is called reconciliation.', N'', 60, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (137, N'When should you use a class component over a functional component (React)?', N'If the component needs state or lifecycle methods then use class component otherwise use functional component.', N'', 61, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (138, N'What happens when you call setState?', N'The first thing React will do when setState is called is merge the object you passed into setState into the current state of the component. This will kick off a process called reconciliation. The end goal of reconciliation is to, in the most efficient way possible, update the UI based on this new state.  To do this, React will construct a new tree of React elements (which you can think of as an object representation of your UI). Once it has this tree, in order to figure out how the UI should change in response to the new state, React will diff this new tree against the previous element tree.  By doing this, React will then know the exact changes which occurred, and by knowing exactly what changes occurred, will able to minimize its footprint on the UI by only making updates where absolutely necessary.', N'', 62, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (139, N'What is the difference between an element and component in React?', N'A React element is an object representation of some UI (it describes what you want to see on the screen). A React component is a function or a class which optionally accepts input and returns a React element (typically via JSX which gets transpiled to a createElement invocation).', N'', 63, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (140, N'What is the difference between a presentational component and a container component?', N'Presentational components are concerned with how things look. They generally receive data and callbacks exclusively via props. These components rarely have their own state, but when they do it generally concerns UI state, as opposed to data state.  Container components are more concerned with how things work. These components provide the data and behavior to presentational or other container components. They call Flux actions and provide these as callbacks to the presentational components. They are also often stateful as they serve as data sources.', N'', 64, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (141, N'What is a stateless component?', N'A component that just receives props and renders them to the page; a pure function suffices for a stateless component.', N'', 65, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (142, N'Where in a React component should you make an AJAX request?', N'componentDidMount is where an AJAX request should be made in a React component.  This method will be executed when the component "mounts" (is added to the DOM) for the first time. This method is only executed once during the component''s life. Importantly, you can''t guarantee the AJAX request will have resolved before the component mounts. If it doesn''t, that would mean that you''d be trying to setState on an unmounted component, which would not work. Making your AJAX request in componentDidMount will guarantee that there''s a component to update.', N'', 66, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (143, N'What happens during the lifecycle of a React component?', N'1. Initialization 2. State/property updates 3. Destruction', N'', 67, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (144, N'What does it mean for a component to be mounted in React?', N'It has a corresponding element created in the DOM and is connected to that.', N'', 68, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (145, N'How would you prevent a component from rendering in React?', N'return null from the render method.', N'', 69, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (146, N'What is the point of Redux?', N'Application state management that is easy to reason about, maintain and manage in an asynchronous web application environment.', N'', 70, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (147, N'Where is the state kept in a React + Redux app?', N'In the store.', N'', 71, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (148, N'What is flux?', N'Unidrectional application flow paradigm popular a few years back in React; mostly superceded by Redux these days.', N'', 72, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (149, N'What is the purpose of using super constructor with props argument?', N'A child class constructor cannot make use of this reference until super() method has been called. The same applies for ES6 sub-classes as well. The main reason of passing props parameter to super() call is to access this.props in your child constructors.', N'', 73, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (150, N'What is reconciliation in React?', N'When a component''s props or state change, React decides whether an actual DOM update is necessary by comparing the newly returned element with the previously rendered one. When they are not equal, React will update the DOM. This process is called reconciliation.', N'', 74, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (151, N'What is the difference between component and container in react Redux?', N'Component is part of the React API. A Component is a class or function that describes part of a React UI. Container is an informal term for a React component that is connected to a redux store. Containers receive Redux state updates and dispatch actions, and they usually don''t render DOM elements; they delegate rendering to presentational child components.', N'', 75, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (152, N'What are some advantage of jQuery?', N'Easy to use and learn. Easily expandable. Cross-browser support (IE 6.0+, FF 1.5+, Safari 2.0+, Opera 9.0+) Easy to use for DOM manipulation and traversal. Large pool of built in methods. AJAX Capabilities. Methods for changing or applying CSS, creating animations. Event detection and handling. Tons of plug-ins for all kind of needs.', N'', 76, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (153, N'What is the starting point of code execution in jQuery?', N'The starting point of jQuery code execution is $(document).ready() function which is executed when DOM is loaded.', N'', 77, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (154, N'What does the $ mean in jquery?', N'It is an alias for jQuery. $(document).ready is equivalent to jQuery(document).ready', N'', 78, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (155, N'How do you select element by id using jQuery?', N'$(''#idName'') with # for ids.', N'', 79, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (156, N'What is float in CSS?', N'Float is a CSS positioning property. Floated elements remain a part of the flow of the web page. This is distinctly different than page elements that use absolute positioning. Absolutely positioned page elements are removed from the flow of the webpage.', N'', 80, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (157, N'What is the difference between authentication and authorization?', N'Authentication is the process of ascertaining that somebody really is who he claims to be. Authorization refers to rules that determine who is allowed to do what.', N'', 81, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (158, N'What is a DDoS attack?', N'A denial-of-service attack (DoS attack) is an attempt to make a computer resource unavailable to its intended users.  Denial of service is typically accomplished by flooding the targeted machine or resource with superfluous requests in an attempt to overload systems and prevent some or all legitimate requests from being fulfilled.  In a distributed denial-of-service attack (DDoS attack), the incoming traffic flooding the victim originates from many different sources. This effectively makes it impossible to stop the attack simply by blocking a single source.', N'', 82, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (159, N'What is a botnet?', N'A botnet is a number of Internet-connected devices, each of which is running one or more bots. Botnets can be used to perform distributed denial-of-service attack (DDoS attack), steal data, send spam, and allows the attacker to access the device and its connection.', N'', 83, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (160, N'What is an intrusion detection system?', N'An intrusion detection system (IDS) is a device or software application that monitors a network or systems for malicious activity or policy violations.  Intrusion detection check following:  Possible attacks Any abnormal activity Auditing the system data Analysis of different collected data etc.', N'', 84, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (161, N'What is CORS and how do you enable one?', N'A request for a resource (like an image or a font) outside of the origin is known as a cross-origin request. CORS (cross-origin resource sharing) manages cross-origin requests. CORS allows servers to specify who (i.e., which origins) can access the assets on the server, among many other things.  Access-Control-Allow-Origin is an HTTP header that defines which foreign origins are allowed to access the content of pages on your domain via scripts using methods such as XMLHttpRequest.  For example, if your server provides both a website and an API intended for XMLHttpRequest access on a remote websites, only the API resources should return the Access-Control-Allow-Origin header. Failure to do so will allow foreign origins to read the contents of any page on your origin.', N'', 85, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (162, N'What is session hijacking?', N'Session Hijacking involves the exploitation of the web session control mechanism. The attacker basically exploits vulnerable connections and steals HTTP cookies to gain unauthorized access to sensitive information/data stored in web servers.', N'', 86, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (163, N'What is an SSL certificate?', N'SSL Certificates are small data files that digitally bind a cryptographic key to an organization''s details. When installed on a web server, it activates the padlock and the https protocol (over port 443) and allows secure connections from a web server to a browser.', N'', 87, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (164, N'Why is the root certificate important?', N'A Root SSL certificate is a certificate issued by a trusted certificate authority (CA).  In the SSL ecosystem, anyone can generate a signing key and sign a new certificate with that signature. However, that certificate is not considered valid unless it has been directly or indirectly signed by a trusted CA.  A trusted certificate authority is an entity that has been entitled to verify that someone is effectively who it declares to be. In order for this model to work, all the participants on the game must agree on a set of CA which they trust. All operating systems and most of web browsers ship with a set of trusted CAs.', N'', 88, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (165, N'What is the difference between procedural and object oriented programming?', N'Procedural programming is based upon the modular approach in which the larger programs are broken into procedures. Each procedure is a set of instructions that are executed one after another. On the other hand, OOP is based upon objects. An object consists of various elements, such as methods and variables.  Access modifiers are not used in procedural programming, which implies that the entire data can be accessed freely anywhere in the program. In OOP, you can specify the scope of a particular data by using access modifiers - public, private, internal, protected, and protected internal.', N'', 89, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (166, N'Can you inherit private members of a class?', N'No, you cannot inherit private members of a class because private members are accessible only to that class and not outside that class.', N'', 90, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (167, N'What is an object in OOP?', N'Objects are instance of classes. It is a basic unit of a system. An object is an entity that has attributes, behavior, and identity. Attributes and behavior of an object are defined by the class definition.', N'', 91, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (168, N'How can you sum an array of numbers in Ruby?', N'array.inject(:+)', N'', 92, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (169, N'What is metaprogramming?', N'Ways a program has knowledge of itself or can change itself. Code that operates on code rather than data. The writing of programs that write or manipulate other programs.', N'', 93, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (170, N'What is the new DOCTYPE?', N'Instead of typing out a ridiculously long DOCTYPE statement to tell the browser how to render your webpage, this long line of code has been truncated to <!doctype html>.', N'', 94, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (171, N'What is the Charset in html5?', N'The CharSet is a new meta tag attribute in HTML5 which configures the character encoding. <meta charset="UTF-8″>', N'', 95, 12)
GO
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (172, N'What are some elements html5 introduced for media content?', N'<audio> - It specifies sound content. <video> - It links to a video. <source> - This tag specified the source of video and audio links. <embed> - It acts as a container for external applications. <track> - This element defines tracks for video and audio.', N'', 96, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (173, N'What are some elements that provide better structuring in html5?', N'<article> - This element allows to specify an article. <aside> - It allows to view content other than the page content. <bdi> - It lets a part of text getting formatted in a different direction from other text. <command> - It displays a button element which processes a command upon user action. <details> - It adds additional details that a user can show or hide. <dialog> - It initializes a dialog box or popup window. <figure> - This element can show illustrations, diagrams, photos, and code listings. <figcaption> - It adds a caption for the image specified by a <figure> element. <footer> - This tag appends a footer to a document. <header> - This tag inserts a header into a document. <hgroup> - If a page includes multiple headings, then this tag groups them into a set of <h1> to <h6> elements.', N'', 97, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (174, N'How do you set an image as draggable in html5?', N'<img draggable="true">', N'', 98, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (175, N'What Is HTML5 Web Storage?', N'HTML5 brought this new ability to store web pages within the browser cache. This web storage is not only faster than the cookies but secured too. It is capable of storing a large amount of data without compromising the performance of the website.  Also, note that the cached data is not must for every server request. Instead, it gets utilized only when the page asks for it. And only the web page which gets the data stored can access it.', N'', 99, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (176, N'What Is The Difference Between LocalStorage And SessionStorage Objects?', N'The <localStorage> object doesn''t have an expiry for the stored data whereas the <sessionStorage> object keeps it only for a single session. The <localStorage> object doesn''t have a provision to delete the data upon closing of browser window whereas the <sessionStorage> object clears it simultaneously with the window closing down.', N'', 100, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (177, N'What is a CSS selector?', N'The instruction that indicates the element to which the style applies', N'', 101, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (178, N'What Are Child Selectors In CSS?', N'A child selector looks up for the child of some element. To form a child selector, we need two or more selectors separated by "greater than" symbol.  Let''s take an example. We have a <ul> tag inside a paragraph. Here, <ul> is the child of the paragraph element. So, to apply the CSS styles, we can use the following syntax.', N'', 102, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (179, N'How Do You Make Border Rounded With CSS3?', N'In CSS3, there is a <border-radius> property which allows creating an element with rounded corners. We can apply the same style to all the sides and make the corners round.  The <border-radius> property has four individual properties <border-top-left-radius>, <border-top-right-radius>, <border-bottom-left-radius> and <border-bottom-right-radius>.', N'', 103, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (180, N'How Do You Enable Pagination Using CSS3?', N'Making use of a <ul-li> structure, we can allow Pagination with CSS3.  <div class="main_container"> <div class="pagination"> <ul> <li><a href="#"></a></li> <li><a href="#"></a></li> <li class="active"><a href="#"></a></li> <li><a href="#"></a></li> </ul> </div> </div>', N'', 104, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (181, N'What Are Media Queries In CSS3 And Why Do You Use Them?', N'Media queries are one of the latest features of CSS3 used to define responsive styles for devices of different shapes and sizes.  They are the powerful CSS tool which makes it easy to create responsive design for tablets, desktop, mobiles devices. They can help adjusting the Height, Width, Viewport, Orientation and Resolution.  @media screen and (min-width: 480px) { body { background-color: #ffffff; } }', N'', 105, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (182, N'What Are Pseudo-Classes In CSS?', N'A Pseudo-Class is a CSS technique to set the style when the element changes its state. Examples: -Edit the style upon mouse hover event. -Set the style when an element gets focus. -Apply different styles for visited/unvisited links.', N'', 106, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (183, N'Which Property Do You Use To Modify The Face Of A Font In CSS?', N'-font-family. @font-face { font-family: myCustomFont; src: url(sansation_light.woff); }  body { font-family: ''myCustomFont'', Fallback, Ariel; }', N'', 107, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (184, N'How Do You Add Comments In CSS?', N'Place the comments inside the enclosing / and /.', N'', 108, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (185, N'What Is Z-Index And How Does It Work?', N'The z-index is a CSS property which defines the stack order of web elements. Higher order elements will appear before any lower order element.  Note - The z-index only applies to the positioned elements. For example, position:absolute, position:relative, or position:fixed.', N'', 109, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (186, N'What are the core data types of JavaScript?', N'Number Object String Boolean Function Null Undefined', N'', 110, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (187, N'In JavaScript, what is the difference between undefined value and null value?', N'1. A variable will have <undefined> value if it has declaration but not assigned any value.  2. A variable will yield a <null> value if assigned with null.  3. <undefined> is a type itself whreeas <null> is an object.  4. <undefined> value is set via JavaScript engine whereas null value is set directly in the code.', N'', 111, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (188, N'How Does JavaScript Handle Automatic Type Conversion?', N'As per ECMA Script standard, JavaScript is dynamic as well as weakly typed language with first-class functions which means a function can accept other functions as arguments.  Also, it does support auto-type conversion. Whenever an operator or a statement doesn''t get a value of the expected type, then the conversion takes place automatically.', N'', 112, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (189, N'What Are Different Types Of Popup Boxes Available In JavaScript?', N'Alert - It just has an <Ok> button to proceed. Confirm - It pops up a window showing up <Ok> and <Cancel> buttons. Prompt - It gives a dialog asking for user input followed by showing <Ok>/<Cancel> buttons.', N'', 113, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (190, N'What Is The Mechanism To Detect The Operating System On The Client Machine?', N'navigator.appVersion', N'', 114, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (191, N'What Is The Use Of <This> Keyword In JavaScript?', N'The <this> keyword refers to the current object in the program. It is usually available inside a method for referencing the current variable or current object.', N'', 115, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (192, N'What is the difference between html and xhtml?', N'XHTML stands for EXtensible HyperText Markup Language XHTML is almost identical to HTML XHTML is stricter than HTML XHTML is HTML defined as an XML application XHTML is supported by all major browsers', N'', 116, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (193, N'What is XML?', N'Extensible Markup Language; A software- and hardware-independent tool for storing and transporting data.It does not do anything by itself: someone has to write software to send, store, or display it.', N'', 117, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (194, N'Why is it best to put stylesheets in the head of html?', N'It is w3c standard and it allows the page to load progressively.', N'', 118, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (195, N'Why should JS scripts go right before the closing </body> tag?', N'The browser can render all of the markup first; scripts block parallel downloading.', N'', 119, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (196, N'What is progressive rendering?', N'With HTML progressive rendering is chunking the HTML into separate bits and loading each block as it''s finished. Usually, the backend code loads the HTML at once, but if you flush after finishing one part of the structure, it can be rendered immediately to the page.', N'', 120, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (197, N'How do you set the primary language of a webpage?', N'For example: <html lang="en">', N'', 121, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (198, N'How can you include a different language on a webpage?', N'Use the lang attribute, which can work with most elements:   <blockquote lang="fr">  <p>Le plus grand faible des hommes, c''est l''amour qu''ils ont de la vie.</p>  </blockquote>', N'', 122, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (199, N'What is the difference between CSS reset and CSS normalize?', N'These come into play with cross-browser readibility. CSS reset clears all styles; CSS Normalize keeps some useful defaults.', N'', 123, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (200, N'What is the CSS display property?', N'It specifies the type of rendering box for an element. Some possible values: inline, inline-block, block, none, inherit.', N'', 124, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (201, N'What is the difference between inline and inline-block?', N'Compared to display: inline, the major difference is that display: inline-block allows to set a width and height on the element.  Also, with display: inline-block, the top and bottom margins/paddings are respected, but with display: inline they are not.', N'', 125, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (202, N'What can you do with AJAX?', N'Read data from a web server - after the page has loaded Update a web page without reloading the page Send data to a web server - in the background', N'', 126, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (203, N'What is AJAX?', N'Asynchronous JavaScript and XML; AJAX just uses a combination of:  A browser built-in XMLHttpRequest object (to request data from a web server) JavaScript and HTML DOM (to display or use the data).  Note that you can also transport plain text or JSON.', N'', 127, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (204, N'What is the order of events that occurs with AJAX?', N'1. An event occurs in a web page (the page is loaded, a button is clicked) 2. An XMLHttpRequest object is created by JavaScript 3. The XMLHttpRequest object sends a request to a web server 4. The server processes the request 5. The server sends a response back to the web page 6. The response is read by JavaScript 7. Proper action (like page update) is performed by JavaScript', N'', 128, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (205, N'What is an anonymous function in JavaScript?', N'A function without a name declared; uses functional operator rather than declaration; typical use case is when a variable points to an anonymous function. Unlike function definitions they are invoked at runtime. It is more flexible than a declaration.', N'', 129, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (206, N'What are some cases where an anonymous function is better used than a declared function?', N'Inside loops or if statements.', N'', 130, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (207, N'What is the difference between an attribute and a property (context: html and JS)?', N'html tags have standard attributes that are turned into properties when a JavaScript object. Standard html attributes get turned into properties. HTML attributes are case insensitive and are always strings. DOM properties are not always strings.', N'', 131, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (208, N'What is the same-origin policy? Why is it important?', N'The same origin policy states that a web browser permits script contained in one page (or frame) to access data in another page (or frame) only if both the pages have the same origin. By same origin, it means that both the pages should have been generated from same domain or sub domain. This is to prevent theft of data.', N'', 132, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (209, N'What is one bad scenario that same origin policy prevents?', N'Let us say you are somehow tricked into visiting www.your-bank.bad-site.com. On that bad site, there is an iframe that loads www.your-bank.com, where you proceed to login legitimately. After logging in, a simple JavaScript call on the bad site could be used to access the DOM elements of www.your-bank.com loaded in the iframe, such as your account balance. This is prevented by SOP because because they have different domains and thus can not access each other''s resource attributes.', N'', 133, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (210, N'What are some examples of what is and is not permitted by the same origin policy?', N'a site with origin A:  -Can load a script from origin B, but it works in A''s context --Cannot reach the raw content and source code of the script -Can load CSS from the origin B -Cannot reach the raw text of the CSS files in origin B -Can load a page from origin B by iframe -Cannot reach the DOM of the iframe loaded from origin B -Can load an image from origin B -Cannot reach the bits of the image loaded from origin B -Can play a video from origin B -Cannot capture the images of the video loaded from origin B', N'', 134, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (211, N'What is a JavaScript promise?', N'object represents the eventual completion (or failure) of an asynchronous operation, and its resulting value. Promises have 3 states: pending, rejected, or fulfilled. Promises in JS also supply a .then() method. .catch() can also be used for error handling.', N'', 135, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (212, N'What is a higher order function in JavaScript?', N'A function that takes another function as an argument.', N'', 136, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (213, N'What is asynchronous code?', N'Code that schedules some task to be completed in the future, but lines of code coming on later lines run first.', N'', 137, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (214, N'What is an example of asynchronous JavaScript code?', N'the setTimeOut() function. $.get() will also run asynchronously.', N'', 138, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (215, N'How many resources will a browser download from a given domain at a time?', N'2-8 depending on the browser; chrome downloads 6 at a time.', N'', 139, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (216, N'Describe the difference between progressive enhancement and graceful degradation?', N'Progressive enhancement refers to a feature of your web site that enhances the experience for browsers that support it, but has no impact if your browser does not. Graceful degradation takes that modern feature and acts as if it is the default, but will not completely break the older browser.', N'', 140, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (217, N'What happens when you type an URL in the browser and press enter?', N'1. The browser checks the cache for a DNS record to find the corresponding IP address. First the browser cache, then the OS cache, then the router cache, then the ISP cache.   2. If url is not in the cache, ISP''s DNS server initiates a DNS query to find the IP address of the server that hosts the url.   3. Browser initiates a TCP connection with the server  4. The browser sends an HTTP request to the web server  5. The server handles the request and sends back a response  6. The browser displays the content sent back.', N'', 141, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (218, N'What are HTTP methods? List all HTTP methods that you know, and explain them.', N'The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.  The POST method is used to submit an entity to the specified resource, often causing a change in state or side effects on the server.  The PUT method replaces all current representations of the target resource with the request payload.  The PATCH method is used to apply partial modifications to a resource.  The DELETE method deletes the specified resource.  also: options, connect, head, trace.', N'', 142, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (219, N'What are the variable types in Ruby?', N'class, instance, global, and local. @@ class, @ instance, $ global, local are not prefixed.', N'', 143, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (220, N'How do you remove nil values in an array in Ruby?', N'use .compact', N'', 144, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (221, N'Can you call a private method outside a Ruby class using its object?', N'Yes, with the help of the send method.  Given the class Test:  class Test private def method p "I am a private method" end end We can execute the private method using send:  >> Test.new.send(:method) "I am a private method"', N'', 145, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (222, N'Write a single line of Ruby code that prints the Fibonacci sequence of any length as an array.', N'(1..20).inject( [0, 1] ) { | fib | fib << fib.last(2).inject(:+) }', N'', 146, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (223, N'What is a class?', N'A template from which objects are created; a blueprint from which an objects properties and methods are inherited. In Ruby classes are first class objects.', N'', 147, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (224, N'What is the difference between a class and a module? (Ruby)', N'Modules are collections of methods and constants. They cannot generate instances. Classes may generate instances (objects), and have per-instance state (instance variables).  Modules may be mixed in to classes and other modules. The mixed in module''s constants and methods blend into that class''s own, augmenting the class''s functionality. Classes, however, cannot be mixed in to anything.  A class may inherit from another class, but not from a module.  A module may not inherit from anything.', N'', 148, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (225, N'What are singleton methods in Ruby?', N'Singleton methods are methods that live in the singleton class and are only available for a single object (unlike regular instance methods that are available to all instances of the class).   Methods defined with dot notation are singleton methods for the receiver object.  1. s = ''a string'' 2. def s.meth; end 3. s.singleton_methods # => [:meth]', N'', 149, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (226, N'What is rack? (Ruby)', N'Rack is the underlying technology behind nearly all of the web frameworks in the Ruby world. "Rack" is actually a few different things:  An architecture - Rack defines a very simple interface, and any code that conforms to this interface can be used in a Rack application. This makes it very easy to build small, focused, and reusable bits of code and then use Rack to compose these bits into a larger application. A Ruby gem - Rack is is distributed as a Ruby gem that provides the glue code needed to compose our code.', N'', 150, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (227, N'Why would a developer use Test. startTest( ) and Test.stopTest( )?', N'To create an additional set of governor limits during the execution of a single test class.', N'', 1, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (228, N'What must the Controller for a Visualforce page utilize to override the Standard Opportunity view button?', N'The Opportunity StandardController for pre -built functionality.', N'', 2, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (229, N'What would a developer do to update a picklist field on related Opportunity records when a modification to the associated Account record is detected?', N'Create a process with Process Builder.', N'', 3, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (230, N'Which requirement needs to be implemented by using standard workflow instead of Process Builder? Choose 2 answers', N'Create activities at multiple intervals. Send an outbound message without Apex code.', N'', 4, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (231, N'An org has different Apex Classes that provide Account -related functionality. After a new validation rule is added to the object, many of the test methods fail. What can be done to resolve the failures and reduce the number of code changes needed for future validation rules?', N'Create a method that creates valid Account records, and call this method from within test methods. Create a method that loads valid Account records from a Static Resource, and call this method within test methods.', N'', 5, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (232, N'Which component is available to deploy using Metadata API?', N'Case Layout. Account Layout', N'', 6, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (233, N'In the code below, what type does Boolean inherit from? Boolean b= true;', N'Object', N'', 7, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (234, N'What is the preferred way to reference web content such as images, style sheets, JavaScript, and other libraries that is used in Visualforce pages? ', N'By uploading the content as a Static Resource.', N'', 8, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (235, N'A company has a custom object named Warehouse. Each Warehouse record has a distinct record owner, and is related to a parent Account in Salesforce. Which kind of relationship would a developer use to relate the Account to the Warehouse?', N'Lookup', N'', 9, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (236, N'A developer creates a Workflow Rule declaratively that updates a field on an object. An Apex update trigger exists for that object. What happens when a user updates a record?', N'The Apex Trigger is fired more than once.', N'', 10, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (237, N'In which order does SalesForce execute events upon saving a record?', N'Before Triggers; Validation Rules; After Triggers; Assignment Rules; Workflow Rules; Commit', N'', 11, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (238, N'What is a characteristic of the Lightning Component Framework?', N'It has an event-driven architecture. It includes responsive components.', N'', 12, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (239, N'A developer has a block of code that omits any statements that indicate whether the code block should execute with or without sharing. What will automatically obey the organization-wide defaults and sharing settings for the user who executes the code in the Salesforce organization?', N'Anonymous Blocks', N'', 13, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (240, N'A developer created an Apex trigger using the Developer Console and now wants to debug code How can the developer accomplish this in the Developer Console?', N'Open the logs tab in the Developer Console.', N'', 14, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (241, N'Which data structure is returned to a developer when performing a SOSL search?', N'A list of lists of sObjects.', N'', 15, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (242, N'What is a correct pattern to follow when programming in Apex on a Multi-tenant platform?', N'Queries select the fewest fields and records possible to avoid exceeding governor limits.', N'', 16, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (243, N'A company that uses a Custom object to track candidates would like to send candidate information automatically to a third -party human resource system when a candidate is hired.  What can a developer do to accomplish this task?', N'Create a workflow rule with an outbound message action.', N'', 17, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (244, N'Which standard field needs to be populated when a developer inserts new Contact records programmatically?', N'LastName', N'', 18, 13)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (245, N'What is the size of byte?', N'8 bits', N'', 1, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (246, N'What is the size of char?', N'16 bits', N'', 2, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (247, N'What is the size of short?', N'16 bits', N'', 3, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (248, N'What is the size of int?', N'32 bits', N'', 4, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (249, N'what is the size of long?', N'64 bits', N'', 5, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (250, N'what is the size of float?', N'32 bits', N'', 6, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (251, N'what is the size of double?', N'64 bits', N'', 7, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (252, N'What is the range of byte', N'-128 to 127', N'', 8, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (253, N'What is the range of short?', N'-32,768 to 32,767', N'', 9, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (254, N'What is the range of int?', N'-2,1 billion to 2,1billion', N'', 10, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (255, N'How do you check if a number is even?', N'check if number AND 1 is 0', N'', 11, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (256, N'How do you test if the n-th bit is set?', N'Shift n times to the right and then AND', N'', 12, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (257, N'How can you set the n-th bit', N'Shift n times to the left and OR', N'', 13, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (258, N'How can you unset the nth bit', N'Shift n times to the left and invert, then AND', N'', 14, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (259, N'How can you sort with different rules on the same array?', N'use a comparator', N'', 15, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (260, N'What can you use Arrays.parallelPrefix for?', N'cumulate values in an array', N'', 16, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (261, N'How can you find a value fast in a sorted array?', N'Arrays.binarysearch works on all primitives and on objects using a comparator', N'', 17, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (262, N'How can you compare arrays?', N'Arrays.equals : two arrays are equal if they contain the same elements in the same order', N'', 18, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (263, N'How do you recognize overflow in two complement?', N'Adding 2 positive results in negative and vice versa', N'', 19, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (264, N'How can you assign a specific value to each element of an array or subarray?', N'public static void Arrays.fill', N'', 20, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (265, N'How can you create a duplicate of an array?', N'Arrays.copyOf copies until a given length', N'', 21, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (266, N'How can you create a duplicate of an array range?', N'Arrays.copyOfRange', N'', 22, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (267, N'How can you transform a List into an array?', N'Collections.toArray', N'', 23, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (268, N'How can you transform an array into a List?', N'Arrays.asList', N'', 24, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (269, N'How can Double-checked locking improve performance?', N'By limiting synchronization to the rare case of computing the field''s value or constructing a new instance for the field to reference and by foregoing synchronization during the common case of retrieving an already-created instance or value.', N'', 25, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (270, N'How is the intrinsic lock used?', N'Methods declared as synchronized and blocks that synchronize on the this reference both use the object as monitor (that is, its intrinsic lock)', N'', 26, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (271, N'What is the private lock object idiom?', N'This idiom uses the intrinsic lock associated with the instance of a private final java.lang.Object declared within the class instead of the intrinsic lock of the object itself. This idiom requires the use of synchronized blocks within the class''s methods rather than the use of synchronized methods. Lock contention between the class''s methods is prevented.', N'', 27, 14)
GO
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (272, N'Declaring a volatile Java variable means:', N'1) The value of this variable will never be cached thread-locally: all reads and writes will go straight to "main memory";  2) Access to the variable acts as though it is enclosed in a synchronized block, synchronized on itself.', N'', 28, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (273, N'volatile is used to indicate that', N'a variable''s value will be modified by different threads.', N'', 29, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (274, N'Attempting to synchronize on a null object will', N'throw a NullPointerException.', N'', 30, 14)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (275, N'color', N'Sets the color of text', N'', 1, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (276, N'opacity', N'Sets the opacity level for an element', N'', 2, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (277, N'background', N'A shorthand property for setting all the background properties in one declaration', N'', 3, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (278, N'background-attachment', N'Sets whether a background image is fixed or scrolls with the rest of the page', N'', 4, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (279, N'background-blend-mode', N'Specifies the blending mode of each background layer (color/image)', N'', 5, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (280, N'background-color', N'Specifies the background color of an element', N'', 6, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (281, N'background-image', N'Specifies one or more background images for an element', N'', 7, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (282, N'background-position', N'Specifies the position of a background image', N'', 8, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (283, N'background-repeat', N'Sets how a background image will be repeated', N'', 9, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (284, N'background-clip', N'Specifies the painting area of the background', N'', 10, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (285, N'background-origin', N'Specifies where the background image(s) is/are positioned', N'', 11, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (286, N'background-size', N'Specifies the size of the background image(s)', N'', 12, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (287, N'border', N'Sets all the border properties in one declaration', N'', 13, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (288, N'border-bottom', N'Sets all the bottom border properties in one declaration', N'', 14, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (289, N'border-bottom-color', N'Sets the color of the bottom border', N'', 15, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (290, N'border-bottom-left-radius', N'Defines the shape of the border of the bottom-left corner', N'', 16, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (291, N'border-bottom-right-radius', N'Defines the shape of the border of the bottom-right corner', N'', 17, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (292, N'border-bottom-style', N'Sets the style of the bottom border', N'', 18, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (293, N'border-bottom-width', N'Sets the width of the bottom border', N'', 19, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (294, N'border-color', N'Sets the color of the four borders', N'', 20, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (295, N'border-image', N'A shorthand property for setting all the border-image-* properties', N'', 21, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (296, N'border-image-outset', N'Specifies the amount by which the border image area extends beyond the border box', N'', 22, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (297, N'border-image-repeat', N'Specifies whether the border image should be repeated, rounded or stretched', N'', 23, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (298, N'border-image-slice', N'Specifies how to slice the border image', N'', 24, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (299, N'border-image-source', N'Specifies the path to the image to be used as a border', N'', 25, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (300, N'border-image-width', N'Specifies the widths of the image-border', N'', 26, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (301, N'border-left', N'Sets all the left border properties in one declaration', N'', 27, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (302, N'border-left-color', N'Sets the color of the left border', N'', 28, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (303, N'border-left-style', N'Sets the style of the left border', N'', 29, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (304, N'border-left-width', N'Sets the width of the left border', N'', 30, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (305, N'border-radius', N'A shorthand property for setting all the four border-*-radius properties', N'', 31, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (306, N'border-right', N'Sets all the right border properties in one declaration', N'', 32, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (307, N'border-right-color', N'Sets the color of the right border', N'', 33, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (308, N'border-right-style', N'Sets the style of the right border', N'', 34, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (309, N'border-right-width', N'Sets the width of the right border', N'', 35, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (310, N'border-style', N'Sets the style of the four borders', N'', 36, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (311, N'border-top', N'Sets all the top border properties in one declaration', N'', 37, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (312, N'border-top-color', N'Sets the color of the top border', N'', 38, 15)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (313, N'Vue is', N'progressive framework for building UI, designed to be incrementally adoptable (like React), core library focused on view layer only, capable of powering SPAs when used with modern tooling and supporting libraries, inspired by MVVM', N'', 1, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (314, N'Vue is inspired by which pattern', N'MVVM, use vm to refer to Vue instance, aka ViewModel', N'', 2, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (315, N'', N'component hierarchy diagram', N'https://o.quizlet.com/deIyKCn2eCdRCoW-3BokzA.png', 3, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (316, N'', N'component hierarchy diagram w/routing', N'https://o.quizlet.com/N3d-oVKJVRDDwqJO7AfOPg.png', 4, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (317, N'component basics', N'components are Vue instances, best as single-file (template for HTML, CSS, logic), two types: global and single-file', N'', 5, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (318, N'global limitations v. single-file components', N'global vars (hard to find, naming conflicts), CSS is not encapsulated, no build-time compilation support, ok for small apps, rapid prototyping', N'', 6, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (319, N'v-* (e.g. v-bind)', N'directives prefixed with v-, special reactive attributes, render into DOM', N'', 7, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (320, N'like angular and react, vue apps are a', N'tree of components, loosely modeled after, Web Components Spec', N'', 8, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (321, N'which items in component ''data'' property are tracked and trigger updates', N'those that exist on object creation, not ones added after', N'', 9, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (322, N'what component property triggers updates', N'''data''', N'', 10, 16)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (323, N'Objects', N'Custom datatypes with properties and actions', N'', 1, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (324, N'Operators', N'Used to assign values to variables and perform mathematical operations on them', N'', 2, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (325, N'', N'Math Based Operators', N'https://o.quizlet.com/zDTHPvW9god9t4hLeeWvEQ.png', 3, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (326, N'', N'Comparison Operators', N'https://o.quizlet.com/Q-e9lDfrRqrM.gIlWBSHEA.png', 4, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (327, N'Conditionals', N'Statements that allow for code to be executed against conditionals: IF, ELSE statements', N'', 5, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (328, N'Loops', N'Repetitive Conditional statements. ', N'', 6, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (329, N'Three main types of Loops', N'For, While, Do While', N'', 7, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (330, N'For Loop', N'Repeats until a specific condition becomes false', N'', 8, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (331, N'While Loop', N'Iterate while the condition is true', N'', 9, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (332, N'Do While Loop', N'Perform once then, iterate while the condition is true', N'', 10, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (333, N'console.log()', N'A built-in JavaScript function that will push messages to the browsers error console. It is a very useful tool for debugging code, for seeing how variables are changing in your code. You can output strings, numbers, variables, objects, arrays and combinations of these for inspection.', N'', 11, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (334, N'Math.random()', N'Generates a random floating point number between 0 & 1. To convert this to a number range that we want - for example a random number between 1 & 10. First we multiply the result of Math.random() by 10 (the amount of potential numbers from 1 to 10) - this will give us numbers that range from 0 to 9.99999. Because Math.random() won''t ever return the whole number 1 and to remove the decimal places, we use Math.ceil()to round the result of Math.random()*10 up to the nearest whole number. See more on the Math object.', N'', 12, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (335, N'DOM', N'The Document Object Model is a representation of a webpage that JavaScript can use.', N'', 13, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (336, N'pop()', N'Removes the last element of an array, and returns that element', N'', 14, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (337, N'push()', N'Adds new elements to the end of an array, and returns the new length', N'', 15, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (338, N'shift()', N'Removes the first element of an array, and returns that element', N'', 16, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (339, N'splice()', N'adds/removes items to/from an array, and returns the removed item(s)', N'', 17, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (340, N'unshift()', N'Adds new elements to the beginning of an array, and returns the new length', N'', 18, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (341, N'parseInt()', N'This function parses a string and returns an integer. (Only the first number gets returned.)', N'', 19, 17)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (342, N'Diffusion', N'The passive movement of particles from an area of high concentration to low concentration. This happens along a concentration gradient', N'', 1, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (343, N'Osmosis', N'A passive movement of water molecules through a semi permeable membrane. Water moves from an area of low solute concentration to high solute concentration', N'', 2, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (344, N'Active Transport', N'An active movement where an input of energy is required. Particles move from low concentration to high concentration', N'', 3, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (345, N'Facilitated Diffusion', N'A passive movement of particles from high to low concentration through a protein channel in a cell.', N'', 4, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (346, N'Isotonic Solution', N'The same concentration of dissolved substances. Water in = water out.', N'', 5, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (347, N'Hypertonic Solution', N'Higher concentration of solutes outside cell than inside', N'', 6, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (348, N'Plasmolyse', N'When a cell has shrunk', N'', 7, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (349, N'Hypotonic Solution', N'A cell has more solute inside than outside.', N'', 8, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (350, N'Turgid', N'Cell may explode under pressure due to a hypotonic solution.', N'', 9, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (351, N'Exocytosis', N'Movement out of a cell', N'', 10, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (352, N'Endocytosis', N'Movement into a cell', N'', 11, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (353, N'Lysosome', N'A vesicle that contains destructive/digestive chemicals', N'', 12, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (354, N'Nuclear Pore', N'A large hole in the nucleus to allow messenger RNA through', N'', 13, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (355, N'Pinocytosis', N'A form of endocytosis where a cell engulfs liquid into the cell.', N'', 14, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (356, N'Phagocytosis', N'A form of endocytosis where a cell engulfs solids into a cell', N'', 15, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (357, N'Apoptosis', N'Controlled death of cells', N'', 16, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (358, N'Scientific question', N'Questions that can be answered by using experiments and factual reasoning.', N'', 17, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (359, N'Biology', N'The study of living organisms and how they function.', N'', 18, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (360, N'Scientific Method', N'A method of procedure that has characterized natural science since the 17th century, consisting in systematic observation, measurement, and experiment, and the formulation, testing, and modification of hypotheses.', N'', 19, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (361, N'Hypothesis', N'1st part of the scientific method', N'', 20, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (362, N'experimental design', N'Experimental design refers to how participants are allocated to the different conditions (or IV groups) in an experiment.', N'', 21, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (363, N'compound', N'A pure substance made of two or more elements chemically combined', N'', 1, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (364, N'physical change', N'A change in a substance that does not change it chemically: tearing paper', N'', 2, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (365, N'chemical change', N'A change in a substance that forms a new and different substances: Rust', N'', 3, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (366, N'mixture', N'A combination of two or more substances that are not chemically combined', N'', 4, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (367, N'heterogenus', N'a mixture made of different substances that remain physically separate. Example: salad', N'', 5, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (368, N'homogenous', N'composed of parts all of the same kind Example: milk', N'', 6, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (369, N'element', N'A substance that cannot be broken down into simpler substances by chemical means. An element is composed of atoms that have the same atomic number.', N'', 7, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (370, N'solute', N'A substance that is dissolved in a solution.', N'', 8, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (371, N'Isotope', N'Has different masses with the same number of protons', N'', 9, 19)
GO
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (372, N'covalent bond', N'share electrons', N'', 10, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (373, N'ionic bond', N'transfer electrons', N'', 11, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (374, N'groups', N'share similar chemical properties and are vertical in the periodic table', N'', 12, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (375, N'lewis dot structures', N'only show you the valence electrons of an element', N'', 13, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (376, N'density', N'Mass / Volume', N'', 14, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (377, N'Positive', N'the charge that most metals have when ionized', N'', 15, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (378, N'Negative', N'the charge that most nonmetals have when ionized', N'', 16, 19)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (379, N'this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front this is a really long front ', N'this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back this is a really long back ', N'', 151, 12)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (382, N'Biolomogee', N'IS cool k...', N'', 22, 18)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (387, N'', N'Obtuse Angle', N'https://o.quizlet.com/jMQfobuA-HAnpItdGoPwvA.jpg', 1, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (388, N'', N'acute angle', N'https://o.quizlet.com/NXfhqyqY0p2GrVm7FuIA8g.jpg', 2, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (389, N'', N'right angle', N'https://o.quizlet.com/Ofwva2nqKCnfjl4LIVdqyQ.jpg', 3, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (390, N'', N'acute triangle', N'https://o.quizlet.com/BycmnqDashQ-JyREoVFNvw.jpg', 4, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (391, N'', N'obtuse triangle', N'https://o.quizlet.com/i/pJmg7Fipblg0bht6fJ3dZA.jpg', 5, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (392, N'', N'right triangle', N'https://o.quizlet.com/ZRUKVmbufm8JVNHyj6A33Q.png', 6, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (393, N'obtuse', N'greater than 90 degrees', N'', 7, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (394, N'acute', N'less than 90 degrees', N'', 8, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (395, N'right angle', N'exactly 90 degrees', N'', 9, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (396, N'How many degrees is a straight angle?', N'180 degrees', N'', 10, 23)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (397, N'Hola', N'Hello', N'', 1, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (398, N'Adiós', N'Goodbye', N'', 2, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (399, N'Por favor', N'Please', N'', 3, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (400, N'Gracias', N'Thank you', N'', 4, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (401, N'Lo siento', N'I''m sorry', N'', 5, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (402, N'Quiero', N'I want', N'', 6, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (403, N'Necesito', N'I need', N'', 7, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (404, N'Gato', N'Cat', N'', 8, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (405, N'Perro', N'dog', N'', 9, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (406, N'Pequeño', N'Little', N'', 10, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (407, N'Grande', N'Big', N'', 11, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (408, N'Bien', N'Well', N'', 12, 24)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (409, N'Bonjour', N'Hello', N'', 1, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (410, N'Amour', N'love', N'', 2, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (411, N'Bonheur', N'happiness', N'', 3, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (412, N'Chat', N'Cat', N'', 4, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (413, N'Chien', N'Dog', N'', 5, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (414, N'Sourir', N'Smile', N'', 6, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (415, N'Oui', N'yes', N'', 7, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (416, N'Merci', N'Thank you', N'', 8, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (417, N'Au revoir', N'Good-bye', N'', 9, 25)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (418, N'', N'The Birth of Venus', N'https://wisetoast.com/wp-content/uploads/2015/10/The-Birth-of-Venus-Painting.jpg', 1, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (419, N'', N'Dogs Playing Poker', N'https://wisetoast.com/wp-content/uploads/2015/10/A-Bachelors-Dog-painting.jpg', 2, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (420, N'', N'Portrait of Madame Recamier', N'https://wisetoast.com/wp-content/uploads/2015/10/Portrait-of-Madame-R%C3%A9camier.jpg', 3, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (421, N'', N'The Son of Man', N'https://wisetoast.com/wp-content/uploads/2015/10/the-son-of-a-man-painting.jpg', 4, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (422, N'', N'Massacre of the Innocents', N'https://wisetoast.com/wp-content/uploads/2015/10/Massacre-of-the-Innocents-painting.jpg', 5, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (423, N'', N'A Sunday Afternoon on the Island of La Grande Jatte', N'https://wisetoast.com/wp-content/uploads/2015/10/A-Sunday-Afternoon-on-the-Island-of-La-Grande-Jatte-painting2.jpg', 6, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (424, N'', N'American Gothic', N'https://wisetoast.com/wp-content/uploads/2015/10/American-Gothic-grant-wood-painting-857x1024.jpg', 7, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (425, N'', N'The Persistence of Memory', N'https://wisetoast.com/wp-content/uploads/2015/10/The-Persistence-of-Memory-salvador-deli-painting.jpg', 8, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (426, N'', N'Cafe Terrace at Night', N'https://wisetoast.com/wp-content/uploads/2015/10/Cafe-Terrace-at-Night-van-gogh-painting.jpg', 9, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (427, N'', N'The Scream', N'https://wisetoast.com/wp-content/uploads/2015/10/the-scream-edvard-munch-poster.jpg', 10, 26)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (428, N'', N'Resistor', N'https://www.dummies.com/wp-content/uploads/307542.image0.jpg', 1, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (429, N'', N'capacitor', N'https://www.dummies.com/wp-content/uploads/307543.image1.jpg', 2, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (430, N'', N'Diodes', N'https://www.dummies.com/wp-content/uploads/307544.image2.jpg', 3, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (431, N'', N'(LED) Light-emitting Diode', N'https://www.dummies.com/wp-content/uploads/307545.image3.jpg', 4, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (432, N'', N'Transistors', N'https://www.dummies.com/wp-content/uploads/307546.image4.jpg', 5, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (433, N'', N'Integrated Circuits', N'https://www.dummies.com/wp-content/uploads/307547.image5.jpg', 6, 27)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (434, N'dir', N'Lists all the files in the current directory', N'', 1, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (435, N'Ping', N'Pings an IP address', N'', 2, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (436, N'shutdown /f /r', N'Forcefully restarts the PC', N'', 3, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (437, N'Echo', N'Prints text to the screen', N'', 4, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (438, N'ren', N'renames a file', N'', 5, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (439, N'taskkill', N'Kill or stop a running process or application', N'', 6, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (440, N'systeminfo', N'Displays machine specific properties and configuration', N'', 7, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (441, N'tree', N'Graphically displays the directory structure of a drive or path', N'', 8, 29)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (442, N'Square of a Binomial', N'To square a binomial, you add: the square of the first term, twice the product of the two terms, and the square of the last term.', N'', 3, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (443, N'Difference of Two Squares', N'When two binomials differ only by the sign between their terms (one a plus, the other a minus), we call this a Difference of Two Squares.  The rule is very easy to remember: Subtract the square of the second term from the square of the first term. ', N'', 4, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (444, N'Perfect Square Trinomial', N'A perfect square trinomial results in binomial squares.  If you notice that the first and last terms are perfect squares, then check to see if the trinomial factors as a binomial square.', N'', 5, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (445, N'Difference of Two Squares', N'x^2-y^2=(x+y)(x-y)', N'', 6, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (446, N'Quadratic Formula', N'ax^2 + bx + c = 0', N'', 7, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (447, N'Pythagorean Theorem', N'a^2 + b^2 = c^2', N'', 8, 21)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (448, N'Windows XP', N'Old', N'', 1, 30)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (449, N'Windows 7', N'Not as old', N'', 2, 30)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (450, N'Windows 95', N'Very old', N'', 3, 30)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (451, N'Windows 10', N'Shiny and new', N'', 4, 30)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (452, N'MacOS', N'Better than PC...???', N'', 5, 30)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (453, N'Common Ground Squirrel', N'Annoying', N'', 1, 31)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (454, N'Chipmunk', N'Smol', N'', 2, 31)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (455, N'Other mammal', N'Yes', N'', 3, 31)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (456, N'Elephant', N'Not North American', N'', 4, 31)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (457, N'', N'I''m a widdle potato', N'https://media.giphy.com/media/bPShx901m0HHG/giphy.gif', 1, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (458, N'', N'Yea boi', N'https://media.giphy.com/media/menw2PSZ2vUzu/giphy.gif', 2, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (459, N'', N'Wooo woooo!', N'https://media.giphy.com/media/U1rlk8zdcAwbm/giphy.gif', 3, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (460, N'', N'Woooo!', N'https://media.giphy.com/media/l41m73JY35qIhKK8U/giphy.gif', 4, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (461, N'', N'Happy potato day to ya laddy', N'https://media.giphy.com/media/9EEf6nZwFsYne/giphy.gif', 5, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (462, N'', N'OwwO', N'https://media.giphy.com/media/2hjVP5TiqOV0c/giphy.gif', 6, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (463, N'', N'I''m a fancy potater boy', N'https://media.giphy.com/media/5djePkeW7AD7y/giphy.gif', 7, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (464, N'', N'!', N'https://media.giphy.com/media/mD8wmRZn0LZQc/giphy.gif', 8, 32)
INSERT [dbo].[cards] ([id], [front], [back], [img], [card_order], [deck_id]) VALUES (465, N'', N'I mustache you a question', N'https://media.giphy.com/media/rTf4lLI9Nv0mQ/giphy.gif', 9, 32)
SET IDENTITY_INSERT [dbo].[cards] OFF
SET IDENTITY_INSERT [dbo].[decks] ON 

INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (1, N'Object Oriented Programming (OOP)', N'Basics of OOP', CAST(N'2019-04-16T15:18:41.660' AS DateTime), 1, 0, 1, N'#00ff00', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (12, N'Junior Developer Common Questions', N'Terms that you may be asked in an interview', CAST(N'2019-04-17T10:20:54.440' AS DateTime), 0, 0, 1, N'#0000a0', N'#ffff80')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (13, N'Salesforce Platform Developer', N'Want to master the SalesForce platform? Study this!', CAST(N'2019-04-17T11:48:15.067' AS DateTime), 0, 0, 1, N'#8080ff', N'#ffffff')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (14, N'Java', N'Study up on the basics of programming with Java', CAST(N'2019-04-17T11:53:36.643' AS DateTime), 0, 0, 1, N'#008000', N'#400080')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (15, N'CSS', N'Study your knowledge of CSS Declarations', CAST(N'2019-04-17T12:08:06.260' AS DateTime), 0, 0, 1, N'#ecf0f1', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (16, N'Vue.js', N'Study up on this light weight framework', CAST(N'2019-04-17T12:23:10.097' AS DateTime), 0, 0, 1, N'#ecf0f1', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (17, N'JavaScript', N'The language of the web!', CAST(N'2019-04-17T12:31:39.693' AS DateTime), 0, 0, 1, N'#ecf0f1', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (18, N'Biology', N'Terms for biology', CAST(N'2019-04-17T12:52:06.453' AS DateTime), 1, 0, 2, N'#979ff0', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (19, N'Chemistry', N'Terms for chem class', CAST(N'2019-04-17T13:06:44.577' AS DateTime), 1, 0, 2, N'#ecf0f1', NULL)
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (21, N'Algebra Formulas', N'Collection of algebra formulas', CAST(N'2019-04-18T18:35:48.680' AS DateTime), 1, 0, 3, N'#eb6df1', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (23, N'Math', N'Angles for days', CAST(N'2019-04-18T19:32:46.747' AS DateTime), 1, 0, 2, N'#ffff00', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (24, N'Spanish', N'learn spanish rapidamente', CAST(N'2019-04-18T19:36:53.770' AS DateTime), 1, 0, 2, N'#ff8000', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (25, N'French', N'Learn French ', CAST(N'2019-04-18T19:40:07.810' AS DateTime), 0, 0, 2, N'#80ffff', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (26, N'Famous Art', N'Photo / description', CAST(N'2019-04-18T19:44:01.860' AS DateTime), 1, 0, 2, N'#ccfffa', N'#400080')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (27, N'Electrical Components', N'Match the image to the description', CAST(N'2019-04-18T19:51:10.740' AS DateTime), 1, 0, 2, N'#00ff40', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (29, N'CMD commands', N'Useful command prompt commands', CAST(N'2019-04-18T20:00:55.460' AS DateTime), 1, 0, 3, N'#000000', N'#71f75e')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (30, N'Operating Systems', N'Common OSs', CAST(N'2019-04-18T20:15:11.627' AS DateTime), 1, 0, 3, N'#ddeaff', N'#db337a')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (31, N'Mammals', N'North American Mammals', CAST(N'2019-04-18T20:17:04.027' AS DateTime), 1, 0, 3, N'#866328', N'#000000')
INSERT [dbo].[decks] ([id], [name], [description], [date_created], [is_public], [for_review], [users_id], [color], [text_color]) VALUES (32, N'The Taters Deck', N'Funny dancing taters', CAST(N'2019-04-18T20:18:48.430' AS DateTime), 0, 0, 2, N'#efefef', N'#000000')
SET IDENTITY_INSERT [dbo].[decks] OFF
SET IDENTITY_INSERT [dbo].[tags] ON 

INSERT [dbo].[tags] ([id], [tag], [card_id]) VALUES (1, N'potato', 1)
INSERT [dbo].[tags] ([id], [tag], [card_id]) VALUES (3, N'Exam', 343)
SET IDENTITY_INSERT [dbo].[tags] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [display_name], [email], [password], [salt], [is_admin], [role]) VALUES (1, N'John Fulton', N'email@email.com', N'SfJQM+YazJ1s+zJuHVnf3lVkQNQ=', N'f+jY7cb/4YI=', 0, N'User')
INSERT [dbo].[users] ([id], [display_name], [email], [password], [salt], [is_admin], [role]) VALUES (2, N'Lucy3726', N'lucy@lucy.com', N'ugS/+KNXk/6JGaKujb2ZDuOroz8=', N'9WGt3ibOmyM=', 0, N'User')
INSERT [dbo].[users] ([id], [display_name], [email], [password], [salt], [is_admin], [role]) VALUES (3, N'Admin', N'admin@admin.com', N'PP4Cc0yeYtMkwqCYXIbWamh4frQ=', N'nnXzeYJ1cvw=', 1, N'Admin')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[decks] ADD  DEFAULT (getdate()) FOR [date_created]
GO
ALTER TABLE [dbo].[decks] ADD  DEFAULT ((0)) FOR [is_public]
GO
ALTER TABLE [dbo].[decks] ADD  DEFAULT ((0)) FOR [for_review]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_admin]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('user') FOR [role]
GO
ALTER TABLE [dbo].[cards]  WITH CHECK ADD FOREIGN KEY([deck_id])
REFERENCES [dbo].[decks] ([id])
GO
ALTER TABLE [dbo].[decks]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[tags]  WITH CHECK ADD FOREIGN KEY([card_id])
REFERENCES [dbo].[cards] ([id])
GO
USE [master]
GO
ALTER DATABASE [FlashCards] SET  READ_WRITE 
GO
