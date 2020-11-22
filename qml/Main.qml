/*
 * Copyright (C) 2020  Michele Castellazzi
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * photosphere is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 import QtQuick 2.9
 import QtQuick.Window 2.2
 import PhotoSphere 1.0

 Window {
     visible: true
     width: 640
     height: 480
     title: qsTr("Hello World")

     // Insert your update() hack of choice here, something that pushes redraws

     Rectangle {
         id: container
         anchors.fill: parent
         visible: true
         color: "transparent"

         PhotoSphere {
             id: sphere
             visible: true
             anchors.fill: parent
             imageUrl: "<your photosphere url>" // this initial version supports correctly only full 360 panospheres

             MouseArea {
                 id: ma
                 anchors.fill: parent
                 property var clickedPos;
                 property var clickedAzimuth;
                 property var clickedElevation;
                 property var clickedFoV;
                 onPressed: {
                     clickedPos = Qt.point(mouseX, mouseY)
                     clickedAzimuth = sphere.azimuth
                     clickedElevation = sphere.elevation
                 }
                 onPositionChanged: {
                     var curpos = Qt.point(mouseX, mouseY)
                     var posDiff = Qt.point(curpos.x - ma.clickedPos.x, curpos.y - ma.clickedPos.y)

                     sphere.azimuth = clickedAzimuth + posDiff.x / 6.0
                     sphere.elevation = clickedElevation + posDiff.y / 6.0
                     console.log(sphere.azimuth, sphere.elevation)
                 }
                 onWheel: {
                     if (wheel.modifiers & Qt.ControlModifier) {
                         sphere.fieldOfView +=  wheel.angleDelta.y / 120;
                         console.log(sphere.fieldOfView)
                     }
                 }
             }
         }
     }
 }
