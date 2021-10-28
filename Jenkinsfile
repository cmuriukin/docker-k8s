
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
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
        }

        stage('Deploy our image') {
      steps {
        script {
          /* groovylint-disable-next-line NestedBlockDepth */
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
        }

        stage('Cleaning up') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
        }
    }
}

