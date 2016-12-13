#!/bin/sh
cd
wget -c https://github.com/LightTable/LightTable/releases/download/0.8.1/lighttable-0.8.1-linux.tar.gz
tar -xzvf lighttable-0.8.1-linux.tar.gz 
sudo mv lighttable-0.8.1-linux/ /opt/lighttable 
sudo ln -sf /opt/lighttable/LightTable /usr/bin/lighttable
cat << EOF | sudo tee /usr/share/applications/light-table.desktop &> /dev/null
[Desktop Entry]
Version=1.0
Name=Light Table
GenericName=Text Editor
Exec=/opt/lighttable/LightTable
Terminal=false
Icon=/opt/lighttable/resources/app/core/img/lticon.png
Type=Application
Categories=GTK;Utility;TextEditor;Application;IDE;Development;
EOF

sudo chmod a+x /usr/share/applications/light-table.desktop