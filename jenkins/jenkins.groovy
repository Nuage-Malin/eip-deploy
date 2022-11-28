folder("Production") {
    description("Production builds");
}
job("Production/Front") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_FRONT", 'ssh')
                credentials('eip_front')
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
        shell('/app/builders/front.sh production')
    }
}
job("Production/Users Back") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_USERS_BACK", 'ssh')
                credentials('users_back')
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
        shell('/app/builders/users-back.sh production')
    }
}
job("Production/Maestro") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_MAESTRO", 'ssh')
                credentials('maestro')
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
        shell('/app/builders/maestro.sh production')
    }
}

// folder("Development") {
//     description("Development builds");
// }
// job("Development/Front") {
//     scm {
//         git {
//             remote {
//                 github("$GIT_REPOSITORY_URL_FRONT", 'ssh')
//                 credentials('eip_front')
//                 branch("develop")
//             }
//         }
//     }
//     triggers {
//         pollSCM {
//             scmpoll_spec('* * * * *')
//         }
//     }
//     steps {
//         shell('/app/builders/front.sh development')
//     }
// }
// job("Development/Users Back") {
//     scm {
//         git {
//             remote {
//                 github("$GIT_REPOSITORY_URL_USERS_BACK", 'ssh')
//                 credentials('users_back')
//                 branch("develop")
//             }
//         }
//     }
//     triggers {
//         pollSCM {
//             scmpoll_spec('* * * * *')
//         }
//     }
//     steps {
//         shell('/app/builders/users-back.sh development')
//     }
// }
// job("Development/Maestro") {
//     scm {
//         git {
//             remote {
//                 github("$GIT_REPOSITORY_URL_MAESTRO", 'ssh')
//                 credentials('maestro')
//                 branch("develop")
//             }
//         }
//     }
//     triggers {
//         pollSCM {
//             scmpoll_spec('* * * * *')
//         }
//     }
//     steps {
//         shell('/app/builders/maestro.sh development')
//     }
// }