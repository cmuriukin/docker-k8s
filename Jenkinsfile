node {

    stage("Git Clone"){

        git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/cmuriukin/docker-k8s.git', branch: 'main'
    }

     
    stage("Docker build"){
        sh 'docker version'
        sh 'docker build -t docker-kubectl-image:v1 .'
        sh 'docker image list'
        sh 'docker tag docker-kubectl-image:v1 docker-kubectl-image:v1'
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

        stage('Put pod-from-inside.yaml onto k8smaster') {
            sshPut remote: remote, from: 'pod-from-inside.yaml', into: '.'
        }

        stage('Deploy') {
          sshCommand remote: remote, command: "kubectl apply -f pod-from-inside.yaml"
        }
    }

}
 
