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