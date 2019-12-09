# Class: dynatraceoneagent::params
#
#
# Dynatrace OneAgent default download and install settings according to operating system
#
class dynatraceoneagent::params {

    # OneAgent Download Parameters
    $tenant_url         = undef
    $paas_token         = undef
    $version            = 'latest'
    $arch               = 'all'
    $installer_type     = 'default'

    #OneAgent Install Parameters
    $oneagent_params_hash = {
        'INFRA_ONLY'             => '0',
        'APP_LOG_CONTENT_ACCESS' => '1',
    }

    $reboot_system      = false

    if $::osfamily == 'Windows' {
        #Parameters for Windows OneAgent Download
        $os_type        = 'windows'
        $download_dir   = 'C:\\Windows\\Temp\\'
        #Parameters for Windows OneAgent Installer
        $service_name   = 'Dynatrace OneAgent'
        $provider       = 'windows'
    } elsif $::osfamily == 'AIX' {
        #Parameters for AIX OneAgent Download
        $os_type        = 'aix'
        $download_dir   = '/tmp/'
        #Parameters for AIX OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
        $default_install_dir = '/opt/dynatrace/oneagent'
    } elsif $::kernel == 'Linux' {
        #Parameters for Linux OneAgent Download
        $os_type        = 'unix'
        $download_dir   = '/tmp/'
        #Parameters for Linux OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
        $default_install_dir = '/opt/dynatrace/oneagent'
    }

    #Set default install dir based on Windows architecture
    if ($::osfamily == 'Windows') and ($::architecture == 'x64') {
        $default_install_dir = 'C:\\Program Files (x86)\\dynatrace\\oneagent'
    } elsif ($::osfamily == 'Windows') and ($::architecture == 'x32') {
        $default_install_dir = 'C:\\Program Files\\dynatrace\\oneagent'
    }

}
