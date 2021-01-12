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
    command:
    - /bin/cat
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
   
   stage("Deploy to QA") {
   steps {
    container(name: 'kubectl', shell: '/bin/bash') {
       script {
           sh '''#!/bin/bash
                 uname -a
                 ls -la /home/jenkins
           '''
       }
      }
    }
   }
   
   stage("Test in  QA") {
   steps {
    container(name: 'kubectl', shell: '/bin/bash') {
       script{
           sh '''#!/bin/bash
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
 }
}
