#!/bin/sh
#
# Copyright (C) 2009-2013 "isomorph"
# All Rights Reserved.
#
# BSD 3-Clause License
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ----
#
# JWM "VirtualBox" pipe-menu
# Outputs a menu roughly akin to:
#
#    VirtualBox
#    ----------
#    <Virtual Machine>
#    <Virtual Machine>
#    <Virtual Machine>
#    ...
#
# Usage:
#
# 1. Copy this file somewhere on your path and make it executable
# 2. Add the following line somewhere to your /.config/openbox/menu.xml
#
#    <menu id="vms" label="Virtual Machines" execute="cb-virtual-machines-pipemenu" />
#
# 3. Reconfigure openbox


# make sure virtualbox itself exists
which "virtualbox" > /dev/null
if [ "$?" -ne "0" ]; then
    cat <<EOF
<JWM>
    <Program label="Virtualbox cannot be found"></Program>
    <Program label="Click here to install Virtualbox">xdg-open https://www.virtualbox.org/wiki/Linux_Downloads</Program>
</JWM>
EOF
    exit 1
fi

# output the initial menu
cat <<EOF
<JWM>
    <Program label="VirtualBox">virtualbox</Program>
EOF

# Check for the vboxmanage binary
which "vboxmanage" > /dev/null
if [ "$?" -ne "0" ]; then
    echo "</JWM>"
    exit 0
fi

# seperate the main command from the virtuals
echo "    <Separator/>"

# output the list of virtual machines
vboxmanage list vms | cut -f 2 -d "\"" | sort -f | while read vm
do
    cat <<EOF
    <Program label="$vm">vboxmanage startvm "$vm"</Program>
EOF
done;

# and finally...
echo "</JWM>"
