// Top-level build.gradle.kts file

buildscript {
    repositories {
        google() // Make sure this is here
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // Add this classpath
        classpath("com.android.tools.build:gradle:7.0.4") // or use a compatible version
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.5.31") // Kotlin plugin version
    }
}

allprojects {
    repositories {
        google() // Ensure this is included for all projects
        mavenCentral()
    }
}

