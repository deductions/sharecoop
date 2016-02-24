organization := "sharecoop"
name := "sharecoop"
version := "1.0-SNAPSHOT"

lazy val semantic_forms_play = (project in file("."))
	.enablePlugins(PlayScala)

scalaVersion := "2.11.7"
javacOptions ++= Seq("-source","1.7", "-target","1.7")

libraryDependencies += "deductions" %% "semantic_forms_play" % "1.0-SNAPSHOT"
libraryDependencies += "org.scalatest" %% "scalatest" % "2.2.6" % Test
// libraryDependencies += specs2 % Test

sources in (Compile, doc) := Seq.empty
publishArtifact in (Compile, packageDoc) := false

// fork a new JVM for 'test:run' and 'run'
fork := true
// add a JVM option to use when forking a JVM for 'run'
javaOptions += "-Xmx50M"

resolvers += "scalaz-bintray" at "https://dl.bintray.com/scalaz/releases"
resolvers += Resolver.file("Local repo", file(System.getProperty("user.home") + "/.ivy2/local"))(Resolver.ivyStylePatterns)

