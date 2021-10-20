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
        stage('Docker Build & Test') {
            steps {
                sh '''#!/bin/bash -l
	        sudo docker build -t maven-app:test .
		sudo docker run -d -p 80:8080 --name maven-app maven-app:test
		sleep 4
		curl -s -o /dev/null -w %{http_code} 35.154.189.208
		sudo docker stop maven-app && sudo docker rm maven-app
		'''
            }
        }
        stage ('Docker Push ECR') {
            steps {
                 sh 'sudo docker tag maven-app:test mavenrepo:latest 756033365011.dkr.ecr.ap-south-1.amazonaws.com/mavenrepo:${BUILD_NUMBER}'
		 sh 'sudo docker push 756033365011.dkr.ecr.ap-south-1.amazonaws.com/mavenrepo:${BUILD_NUMBER}'
       	    }
      }
    }
}
