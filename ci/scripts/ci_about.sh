#!/usr/bin/env bash
#
#  LICENSE
#
#  This file is part of Flyve MDM Inventory Agent for Android.
#
#  Inventory Agent for Android is a subproject of Flyve MDM. Flyve MDM is a 
#  mobile device management software.
#
#  Flyve MDM Inventory Agent for Android is free software: you can redistribute 
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 3
#  of the License, or (at your option) any later version.
#
#  Flyve MDM Inventory Agent for Android is distributed in the hope that it will be 
#  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  ------------------------------------------------------------------------------
#  @author    Rafael Hernandez - <rhernandez@teclib.com>
#  @copyright Copyright (c) 2017 - 2018 Flyve MDM
#  @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
#  @link      https://github.com/flyve-mdm/android-inventory-agent
#  @link      http://flyve.org/android-inventory-agent
#  @link      https://flyve-mdm.com/
#  ------------------------------------------------------------------------------
#

GIT_TAG=$(jq -r ".version" package.json)

echo "about.version=${GIT_TAG}" > app/src/main/assets/about.properties
echo "about.build=$CIRCLE_BUILD_NUM" >> app/src/main/assets/about.properties
echo "about.date=$(date "+%a %b %d %H:%M:%S %Y")" >> app/src/main/assets/about.properties
echo "about.commit=${CIRCLE_SHA1:0:7}" >> app/src/main/assets/about.properties
echo "about.commitFull=$CIRCLE_SHA1" >> app/src/main/assets/about.properties
echo "about.github=https://github.com/flyve-mdm/android-inventory-agent" >> app/src/main/assets/about.properties

git add app/src/main/assets/about.properties
git commit -m "build(properties): add new properties values"

# push changes only on master branch
if [[ $CIRCLE_BRANCH == *"master"* ]]; then
    git push origin $CIRCLE_BRANCH
fi