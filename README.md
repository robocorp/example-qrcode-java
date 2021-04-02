# Robocorp QR Code Example Robot
Example Robot to Detect and Render QR Codes with java boofcv library

## Tasks

#### Render QR code

Configure two Robocloud environment variables:

<pre>
DATA
      Name of the Work Item key or literal message to be rendered into QR code
IMAGE
      Name of the Work Item file to hold the image of rendered QR Code
</pre>

#### Detect QR code

Configure two Robocloud environment variables:

<pre>
DATA
      Name of the Work Item key to hold the data read from the QR code
IMAGE
      Name of the Work Item file that holds the image where QR code is searched from
</pre>

## Usage of Java

This example also shows simple way to extends Robot's functionality with java. JDK is added as a conda dependency:

<pre>
channels:
  - conda-forge

dependencies:
  - python=3.7.5
  - rpaframework=9.3.2
  - openjdk=11.0.8
</pre>

In more complex library it would make sense to implement the RF-java communication by using [jrobotremoteserver](https://github.com/robotframework/RemoteInterface), but this example we just start the java as shell command e.g.

<pre>Run Process  java  -jar  QrCode-1.0-SNAPSHOT-jar-with-dependencies.jar  render  %{IMAGE_KEY}</pre>

Also full java code, dependencies and build scripts are included in the example. If you hava JDK and Maven installed, you can build the java by running:

<pre>mvn package</pre>

It will generate fat jar in target directory. 
