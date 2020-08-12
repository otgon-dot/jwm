#
# STEAM by Derek Taylor (DistroTube)
# Ported to JWM by Lucas Cruz <lucascruzhl@gmail.com>
# A simple script that creates an JWM Static menu that launches Steam games.
# 
# This program is free software: you can redistribute it and/or modify it under the terms of
# the GNU General Public License version 3 as published by the Free Software Foundation.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without 
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see: http://www.gnu.org/licenses

STEAMAPPS=~/.local/steam/steam/steamapps
echo '<JWM>'
echo '<Menu icon="steam" label="Steam">'
echo '<Program icon="steam" label="Steam">steam</Program>'
echo '<Separator/>'
for file in $(ls $STEAMAPPS/*.acf -1v); do
ID=$(cat "$file" | grep '"appid"' | head -1 | sed -r 's/[^"]*"appid"[^"]*"([^"]*)"/\1/')
NAME=$(cat "$file" | grep '"name"' | head -1 | sed -r 's/[^"]*"name"[^"]*"([^"]*)"/\1/')
echo "<Program label=\"$NAME\">steam steam://rungameid/$ID</Program>"
done
echo '</Menu>'
echo '</JWM>'
