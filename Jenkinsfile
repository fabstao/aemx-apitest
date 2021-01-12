def newImage
pipeline {
agent {
    kubernetes {
      label 'apitest'
      yaml """
kind: Pod
metadata:
  name: apitest
  namespace: jenkins-mvp
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:latest-jdk11
    workingDir: /home/jenkins
    env:
    - name: GIT_SSL_NO_VERIFY
      value: true
  - name: kubectl
    workingDir: /home/jenkins
    image: docker.io/fabstao/kubectl:latest
    imagePullPolicy: Always
    tty: true
"""
    }
  }


stages {
/*
 stage("Code Checkout from GitLab") {
  steps {
    container(name: 'jnlp') {
	   git branch: 'dev',
		credentialsId: 'gitlab_access_token',
		url: 'https://gitlab.rax.latamps.tech/fsalaman/aemx-poc-cd.git'
    }
  }
 }
 */

/*

   */
   
   stage("Deploy to QA") {
   steps {
    container(name: 'kubectl', shell: '/bin/bash') {
       sh 'kubectl get namespaces'
      }
    }
   }
   
   stage("Test in  QA") {
   steps {
    container(name: 'kubectl', shell: '/bin/bash') {
       script{
           sh '''
           #!/bin/bash
           echo "Probando"
           proyecto=$(kubectl get namespace aemxqa -o "jsonpath={.metadata.name}")
           if [ "$proyecto" == ""]; then
             kubectl create namespace aemxqa
           fi
           kubectl get namespaces
           '''
           }
      }
    }
   }
/*
   stage('Kaniko - container build') {
   environment {
     PATH = "/busybox:/kaniko:$PATH"
   }
   steps {
     container(name: 'kaniko', shell: '/busybox/sh') {
       script {
           sh '''#!/bin/bash
                 echo Iniciando construcción del container
                 cp src/main/docker/Dockerfile.fast-jar ./Dockerfile
                 /kaniko/executor --context=`pwd` --skip-tls-verify --skip-tls-verify-pull --insecure --insecure-pull --insecure-registry --verbosity=debug --destination=harbor.rax.latamps.tech/aemxmvp/quarkusapp:${BUILD_NUMBER}
           '''
           }
      }
     }
   }
*/
 }
}
