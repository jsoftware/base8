#!/bin/sh

echo "this script will install j system on /usr"

[ "Linux" = "$(uname)" ] || { echo "$(uname) not supported" ; exit 1; }

if [ "$(uname -m)" = "x86_64" ] ; then
 cpu="intel64"
else
 if [ "$(uname -m)" = "i386" ] || [ "$(uname -m)" = "i686" ] ; then
  cpu="intel32"
 else
  if [ "$(uname -m)" = "aarch64" ] ; then
   cpu="arm64"
  else
   if [ "$(uname -m)" = "armv6l" ] ; then
    cpu="arm32"
   else
    echo "platform $(uname -m) not supported"
    exit 1
   fi
  fi
 fi
fi

if [ "$cpu" = "intel64" -o  "$cpu" = "arm64" ] ; then
 [ "j64-807" = ${PWD##*/} ] || { echo "directory not j64-807" ; exit 1; }
else
 [ "j807" = ${PWD##*/} ] || { echo "directory not j807" ; exit 1; }
fi

[ "$(id -u)" = "0" ] || { echo "need sudo" ; exit 1; }

mkdir -p /usr/share/j/8.07 || { echo "can not create directory" ; exit 1; }
mkdir -p /etc/j/8.07 || { echo "can not create directory" ; exit 1; }
rm -rf /usr/share/j/8.07/system
cp -r system /usr/share/j/8.07/.
rm -rf /usr/share/j/8.07/tools
cp -r tools /usr/share/j/8.07/.
rm -rf /usr/share/j/8.07/icons
cp -r bin/icons /usr/share/j/8.07/.
rm -rf /usr/share/j/8.07/addons/ide/jhs 
cp -r addons/ide/jhs /usr/share/j/8.07/addons/ide/.
find /usr/share/j/8.07 -type d -exec chmod a+rx {} \+
find /usr/share/j/8.07 -type f -exec chmod a+r {} \+
cp bin/profile.ijs /etc/j/8.07/.
cp bin/profilex_template.ijs /etc/j/8.07/.
find /etc/j/8.07 -type d -exec chmod a+rx {} \+
find /etc/j/8.07 -type f -exec chmod a+r {} \+
cp bin/jconsole /usr/bin/ijconsole-8.07
chmod a+rx /usr/bin/ijconsole-8.07
(cd /usr/bin && ln -sf ijconsole-8.07 ijconsole)

if [ "$cpu" = "intel64" ] ; then
 if [ -d "/usr/lib/x86_64-linux-gnu" ] ; then
  cp bin/libj.so /usr/lib/x86_64-linux-gnu/libj.so.8.07
  chmod a+r /usr/lib/x86_64-linux-gnu/libj.so.8.07
 else
  if [ -d "/usr/lib64" ] ; then
   cp bin/libj.so /usr/lib64/libj.so.8.07
   chmod a+r /usr/lib64/libj.so.8.07
  else
   echo "can not find lib directory"
   exit 1
  fi
 fi
fi
if [ "$cpu" = "arm64" ] ; then
 if [ -d "/usr/lib/aarch64-linux-gnu" ] ; then
  cp bin/libj.so /usr/lib/aarch64-linux-gnu/libj.so.8.07
  chmod a+r /usr/lib/aarch64-linux-gnu/libj.so.8.07
 else
  if [ -d "/usr/lib64" ] ; then
   cp bin/libj.so /usr/lib64/libj.so.8.07
   chmod a+r /usr/lib64/libj.so.8.07
  else
   echo "can not find lib directory"
   exit 1
  fi
 fi
fi
if [ "$cpu" = "intel32" ] ; then
 if [ -d "/usr/lib/i386-linux-gnu" ] ; then
  cp bin/libj.so /usr/lib/i386-linux-gnu/libj.so.8.07
  chmod a+r /usr/lib/i386-linux-gnu/libj.so.8.07
 else
  if [ -d "/usr/lib" ] ; then
   cp bin/libj.so /usr/lib/libj.so.8.07
   chmod a+r /usr/lib/libj.so.8.07
  else
   echo "can not find lib directory"
   exit 1
  fi
 fi
fi
if [ "$cpu" = "arm32" ] ; then
 if [ -d "/usr/lib/arm-linux-gnueabihf" ] ; then
  cp bin/libj.so /usr/lib/arm-linux-gnueabihf/libj.so.8.07
  chmod a+r /usr/lib/arm-linux-gnueabihf/libj.so.8.07
 else
  if [ -d "/usr/lib" ] ; then
   cp bin/libj.so /usr/lib/libj.so.8.07
   chmod a+r /usr/lib/libj.so.8.07
  else
   echo "can not find lib directory"
   exit 1
  fi
 fi
fi
ldconfig
echo "done"