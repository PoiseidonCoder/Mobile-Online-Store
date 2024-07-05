Phone Shop Project
Overview
This project is a simple phone selling shop web application developed using Java. It uses NetBeans 17 as the IDE and JDK 20. The project allows users to browse and purchase phones, while administrators can manage the phone inventory and orders.

Requirements
NetBeans 17: You can download it from NetBeans official website.
JDK 20: Ensure you have JDK 20 installed. You can download it from Oracle's official website.
Apache Tomcat (Optional): If you want to deploy your application on a local server, you can use Apache Tomcat. You can download it from Apache Tomcat official website.
Installation Instructions

1. Set up NetBeans 17
   Download and install NetBeans 17 from the official website.
   Open NetBeans and go to Tools -> Plugins.
   Ensure that the necessary plugins for Java EE development are installed.
2. Install JDK 20
   Download JDK 20 from the official website.
   Install JDK 20 by following the instructions provided.
3. Configure NetBeans to use JDK 20
   Open NetBeans.
   Go to Tools -> Java Platforms.
   Click Add Platform, navigate to the location where JDK 20 is installed, and select it.
4. Clone the Project Repository
   Open NetBeans.
   Go to Team -> Git -> Clone.
   Enter the repository URL and clone the project.
5. Open the Project in NetBeans
   Go to File -> Open Project.
   Navigate to the directory where you cloned the project and open it.
   Running the Project
   Using NetBeans
   Right-click on the project in the Projects tab.
   Select Run to start the application.
   Deploying on Apache Tomcat (Optional)
   Download and install Apache Tomcat from the official website.
   Open NetBeans.
   Go to Services tab, right-click on Servers, and select Add Server.
   Choose Apache Tomcat, specify the installation location, and complete the setup.
   Right-click on your project, select Properties.
   In Run category, select Apache Tomcat as the server.
   Right-click on the project and select Deploy.
   Features
   User Module: Users can browse phones, view details, and make purchases.
   Admin Module: Admins can add, update, delete phone listings, and manage orders.
   Technologies Used
   Java
   Java EE
   Servlets
   JSP
   JDBC
   SQL Server(or any other relational database)
   Troubleshooting
   ClassNotFoundException: Ensure all necessary libraries are included in the project.
   Database Connection Issues: Verify the database connection settings in the db.properties file.
   Server Deployment Issues: Ensure Apache Tomcat is properly configured and running.
   Contributing
   Fork the repository.
   Create a new branch (git checkout -b feature/your-feature).
   Commit your changes (git commit -m 'Add some feature').
   Push to the branch (git push origin feature/your-feature).
   Open a Pull Request.
   License
   This project is licensed under the MIT License.

Feel free to customize this README file according to your project's specific details and requirements.
