pipeline {
    agent any
    tools {
        maven 'maven-3.6.3' 
    }
    environment {
	    TAG = "${BUILD_NUMBER}.${BUILD_TIMESTAMP}"
    }
    stages {
        stage ('Build') {
            steps {
                sh 'mvn clean package' 
		archiveArtifacts artifacts:'target/*.war'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("dheerajayati91/samplewebapp:${TAG}")
                }
            }
        }
	    stage('Pushing Docker Image to Dockerhub') {
            steps {
		 
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
                        docker.image("dheerajayati91/samplewebapp:${TAG}").push()
                        docker.image("dheerajayati91/samplewebapp:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
		    script{
			    kubernetesDeploy(configs: "samplewebapp.yaml", kubeconfigId: "kubernetes")
		    }
            }
        }
    }
}
