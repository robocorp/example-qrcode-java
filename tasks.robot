# -*- coding: utf-8 -*-
*** Settings ***
Library  Process
Library  RPA.FileSystem
Library  RPA.Robocloud.Items
Suite Setup  Load Work Item From Environment


*** Tasks ***
Render
    ${message}=  Get Work Item Variable  %{MESSAGE_KEY}
    Create File  input.dat  ${message}
    Run Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar  render  %{IMAGE_KEY}
    Add Work Item File  %{IMAGE_KEY}
    Save Work Item

*** Tasks ***
Detect
    Get Work Item File  %{IMAGE_KEY}
    Run Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar  detect  %{IMAGE_KEY}
    ${message}=  Read File  output.dat
    Set Work Item Variable  %{MESSAGE_KEY}  ${message}
    Save Work Item


