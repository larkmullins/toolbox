# installs to /opt/gradle
# existing versions are not overwritten/deleted
# seamless upgrades/downgrades
# $GRADLE_HOME points to latest *installed* (not released)
gradle_version=2.8
sudo mkdir -p /opt/gradle
wget -N https://services.gradle.org/distributions/gradle-${gradle_version}-all.zip
sudo unzip -oq gradle-${gradle_version}-all.zip -d /opt/gradle
sudo ln -sfnv gradle-${gradle_version} /opt/gradle/latest
sudo printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
. /etc/profile.d/gradle.sh
hash -r ; sync
# check installation
gradle -v
