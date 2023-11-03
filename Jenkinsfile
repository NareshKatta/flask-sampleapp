pipeline {

  environment {
    dockerimagename = "noone3838/flask-sampleapp"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/NareshKatta/flask-sampleapp.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying python container to Kubernetes') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh 'kubectl apply -f deployment.yaml'
          sh 'kubectl apply -f service.yaml'
        }
        //script {
          //kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        //}
      }
    }

  }

}
