# -*- coding: utf-8 -*-
*** Settings ***
Library  Process
Library  RPA.FileSystem
Library  RPA.Robocloud.Items
Library  robot_config.py
Suite Setup  Load Work Item From Environment


*** Tasks ***
Render
    ${message}=  Get Config  %{DATA}
    Create File  input.dat  ${message}
    Run Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar  render  %{IMAGE}
    Add Work Item File  %{IMAGE}
    Save Work Item

*** Tasks ***
Detect
    Get Work Item File  %{IMAGE}
    Run Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar  detect  %{IMAGE}
    ${message}=  Read File  output.dat
    Set Work Item Variable  %{DATA}  ${message}
    Save Work Item


