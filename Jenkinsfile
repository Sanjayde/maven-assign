pipeline {
    agent any
    tools {
        maven "maven"
    }
    stages {
	stage ('Build') {
            steps {
              dir("${WORKSPACE}") {
                sh 'mvn -B -DskipTests clean package'
                }
            }
        }
        stage('Test') {
            steps {
         
		            sh 'docker build -t maven-app:v1 .'
		           
            }
        }
      stage ('RUN') {
        steps {
                 sh 'docker run -d -p 8040:80 maven-app:v1'
       	    }
      }
    }
}
