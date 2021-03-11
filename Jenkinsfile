podTemplate(cloud: "kubernetes-qa", yaml: """\
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
  namespace: jenkins
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
    image: fabstao/kubectl:latest
    imagePullPolicy: Always
    command:
    - /bin/cat
    tty: true
    securityContext:
      runAsUser: 1000
  - name: apitest
    workingDir: /home/jenkins
    image: fabstao/apitest:latest
    imagePullPolicy: Always
    command:
    - /bin/cat
    tty: true
    securityContext:
      runAsUser: 1000 
""") {
	node(POD_LABEL) {
		git 'https://github.com/fabstao/aemx-apitest'
		stage("Deploy to QA/Preprod") {
			container(name: 'kubectl') {
				script {
				   sh '''#!/bin/bash
					NSPACE=aemxqa
					echo "Desplegando..."
					proyecto=$(kubectl get namespace $NSPACE -o "jsonpath={.metadata.name}")
					if [ "$proyecto" == "" ]; then
					  kubectl create namespace $NSPACE
					fi
					kubectl apply -f $WORKSPACE/quarkus-dep.yaml
                   '''
                }
			}
		}
		stage("Test with Robot API - QA/Prod") {
			container(name: 'apitest') {
				script {
					sh '''#!/bin/bash
						echo "Esperando a que levante el ambiente de prueba"
						sleep 25
						echo "Probando API REST"
						/apitest/runtest.sh quarkus.robot
				}
			}
		}
		stage("Free Resources from QA") {
			container(name: 'kubectl') {
				script {
				   sh '''#!/bin/bash
					NSPACE=aemxqa
					echo "Desplegando..."
					proyecto=$(kubectl get namespace $NSPACE -o "jsonpath={.metadata.name}")
					if [ "$proyecto" == "" ]; then
					  kubectl create namespace $NSPACE
					fi
					kubectl delete -f $WORKSPACE/quarkus-dep.yaml
                   '''
                }
			}
		}
	}
} // END
