pipeline {
    agent any
    stages {
        stage('Compile') {
            steps {
                echo "Compiling..."
                /*
                withMaven(maven : 'maven3') {
                    sh 'mvn clean compile'
                }
                */
            }
        }
        stage('Test') {
            steps {
                echo "Testing..."
                /*
                withMaven {
                    sh 'mvn test -Dtest=!academy.softserve.eschool.*.*IntegrationTest'
                }
                */
            }
        }
        stage('Sonar analysis') {
            steps {
                echo "Analyzing..."
                /*
                withMaven(maven : 'maven3') {
                    withSonarQubeEnv('sonar6') {
                        sh 'mvn sonar:sonar'
                    }
                }
                */
            }
        }
        stage("Build") {
            steps {
                echo "Building..."
                /*
                withMaven(maven : 'maven3') {
                    sh 'mvn package -Dmaven.test.skip=true'
                }
                */
            }
        }
    }
}