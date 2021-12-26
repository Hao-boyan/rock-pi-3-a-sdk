
Files in debian/

All the packaging work should be made by modifying files in debian/

 Main files:

 control - meta-data about the package (dependencies, etc.)

 rules - specifies how to build the package

 copyright - copyright information for the package

 changelog - history of the Debian package
 
 When you need make a Carmachine .deb format package for your debian system:
 
 Get carmachine source package:
 
 git clone https://github.com/rockchip-linux/carmachine.git
 
 Create debian/ directory in carmachine project:
 
 mkdir -p debian/
 
 cp files from carmachine/debian/ to debian/ in project directory

 cp cross compilation tools to project directory
 
 Make .deb package
 
 dpkg-buildpackage -rfakeroot -b -aarmhf
