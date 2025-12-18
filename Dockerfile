FROM jenkins/jenkins:lts

USER root

# Installer les plugins nécessaires
RUN jenkins-plugin-cli --plugins \
    cloudbees-folder \
    configuration-as-code \
    credentials \
    github \
    instance-identity \
    job-dsl \
    script-security \
    structs \
    role-strategy \
    ws-cleanup

USER jenkins

# Copier les fichiers de configuration
COPY my_marvin.yml /var/jenkins_home/casc_jenkins.yml
COPY job_dsl.groovy /var/jenkins_home/job_dsl.groovy

# Définir la variable d'environnement pour JCasC
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_jenkins.yml