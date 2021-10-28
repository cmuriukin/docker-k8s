
pipeline {
    environment {
        registry = 'cmuriukin/docker-k8s'

        registryCredential = 'GIT_HUB_CREDENTIALS'

        dockerImage = ''
    }

    agent any

    stages {
        stage('Cloning our Git') {
      steps {
        git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/cmuriukin/docker-k8s.git', branch: 'main'
      }
        }

        stage('Building our image') {
      steps {
        script {
          /*dockerImage = docker.build registry + ":$BUILD_NUMBER" */
          sh 'docker build -t devops-k8s:latest . '
        }
      }
        }

        stage('Deploy our image') {
      steps {
             script {
                    withDockerRegistry([ credentialsId: "DOCKER_HUB_PASSWORD", url: "https://hub.docker.com" ]) {
                    sh  'docker push devops-k8s:latest'
                    sh  'docker push devops-k8s:latest:$BUILD_NUMBER' 
 /*                   docker.withRegistry('https://hub.docker.com/') {

                        def dockerImage = docker.build("docker-k8s:${env.BUILD_ID}") 

                        dockerImage.push() */
                    }
            }
          
        }
      }
        }
    }

