pipeline {
    agent any
    tools {
        maven "MAVEN"
    }
    
    stage('Build') {
            steps {
              dir("${WORKSPACE}") {
                sh 'mvn -B -DskipTests clean package'
                }
            }
        }
    stages {
        stage('Test') {
            steps {
         
		            sh 'docker build -t maven-app:v1 .'
		           
            }
        }
      stage('RUN') {
        steps {
                 sh 'docker run -d -p 8040:80 maven-app:v1'
       	    }
      }
    }
}
