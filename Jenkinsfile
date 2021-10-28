node {

    stage("Git Clone"){

        git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/cmuriukin/docker-k8s.git', branch: 'main'
    }

     
    stage("Docker build"){
        sh 'docker version'
        sh 'docker build .'
        sh 'docker image list'
        sh 'docker tag docker-kubectl-image:v1'
    }

    withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'PASSWORD')]) {
        sh 'docker login -u cmuriukin -p $PASSWORD'
    }

    stage("Push Image to Docker Hub"){
        sh 'docker push  docker-kubectl-image:v1'
    }

    stage("SSH Into k8s Server") {
        def remote = [:]
        remote.name = 'minikube'
        remote.host = '172.31.81.192'
        remote.user = 'ubuntu'
        remote.password = '#andela123'
        remote.allowAnyHosts = true

        stage('Put k8s-spring-boot-deployment.yml onto k8smaster') {
            sshPut remote: remote, from: 'k8s-spring-boot-deployment.yml', into: '.'
        }

        stage('Deploy spring boot') {
          sshCommand remote: remote, command: "kubectl apply -f k8s-spring-boot-deployment.yml"
        }
    }

}
 
