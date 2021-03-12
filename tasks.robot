# -*- coding: utf-8 -*-
*** Settings ***
Library  Remote    http://127.0.0.1:8270/
Library  Process
Library  OperatingSystem
Library  RPA.FileSystem
Library  RPA.Robocloud.Items
Suite Setup  Start Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar
Suite Teardown  Stop Remote Server


*** Keywords ***
Prepare
    Start Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar
    Set Environment Variable  IMAGE_KEY  qrcode.png
    Set Environment Variable  MESSAGE_KEY  message
    Set Environment Variable  RPA_WORKITEMS_ADAPTER  RPA.Robocloud.Items.FileAdapter
    Set Environment Variable  RPA_WORKITEMS_PATH  devdata/workitem/items.json
    Set Environment Variable  RC_WORKSPACE_ID  1
    Set Environment Variable  RC_WORKITEM_ID  1
    Load Work Item From Environment

*** Tasks ***
Render
    ${message}=  Get Work Item Variable  %{MESSAGE_KEY}
    Render  ${message}  %{IMAGE_KEY}
    Add Work Item File  %{IMAGE_KEY}
    Save Work Item

*** Tasks ***
Detect
    ${path}=  Get Work Item File  %{IMAGE_KEY}
    ${message}=  Detect  ${path}
    Set Work Item Variable  %{MESSAGE_KEY}  ${message}
    Save Work Item


