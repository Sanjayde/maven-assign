pipeline {
    agent none
    tools {
        maven "maven"
    }
    stages {
	stage ('Build') {
	agent { label 'maven' }
            steps {
              dir("${WORKSPACE}") {
                sh 'mvn -B -DskipTests clean package'
                }
            }
        }
        stage('Docker Build & Test') {
	agent { label 'maven'}
            steps {
                sh '''#!/bin/bash -l
		if sudo docker ps -a | grep maven-app;then sudo docker stop maven-app && sudo docker rm maven-app; else exit 0; fi
	        sudo docker build -t maven-app:test .
		sudo docker run -d -p 80:8080 --name maven-app maven-app:test
		sleep 10
		response=$(curl -s -o /dev/null -w %{http_code} 0.0.0.0)
		if [ "$response == 200" ]; then echo "Response Success"; exit 0; else exit 1; fi
		sudo docker stop maven-app && sudo docker rm maven-app
		'''
            }
        }
        stage ('Docker Push ECR') {
	agent { label 'maven'}
            steps {
		    sh 'sudo docker tag maven-app:test ${ECR_SERVER}:${BUILD_NUMBER}'
		    sh 'sudo docker push ${ECR_SERVER}:${BUILD_NUMBER}'
       	    }
        }
	    
	stage ('Docker Deploy') {
	agent { label 'master'}
            steps {
		 sh 'if sudo docker ps -a | grep maven-app;then sudo docker stop maven-app && sudo docker rm maven-app; else exit 0; fi'
		    sh 'sudo docker run -d -p 80:8080 --name maven-app ${ECR_SERVER}:${BUILD_NUMBER}'
       	    }
        }
    }
}
