folder("Production") {
    description("Production builds");
}
job("Production/Front") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_FRONT", 'ssh')
                credentials('eip_front_production')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/front.sh')
    }
}
job("Production/Back") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_BACK", 'ssh')
                credentials('eip_back_production')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/back.sh')
    }
}