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
         
		            sh 'sudo docker build -t maven-app:v1 .'
		           
            }
        }
      stage ('RUN') {
        steps {
                 sh 'sudo docker run -d -p 8040:80 maven-app:v1'
       	    }
      }
    }
}
