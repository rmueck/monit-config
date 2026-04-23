# Monit

## NAME
       Monit - utility for monitoring services on a Unix system

## SYNOPSIS
       monit [options] <arguments>

## DESCRIPTION
       Monit is a utility for managing and monitoring processes, programs, files, directories and filesystems on a Unix system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error
       situations. E.g. Monit can start a process if it does not run, restart a process if it does not respond and stop a process if it uses too much resources. You can use Monit to monitor files, directories and filesystems
       for changes, such as timestamps changes, checksum changes or size changes.

       Monit is controlled via an easy to configure control file based on a free-format, token-oriented syntax. Monit logs to syslog or to its own log file and notifies you about error conditions via customisable alert
       messages. Monit can perform various TCP/IP network checks, protocol checks and can utilise SSL for such checks. Monit provides a HTTP(S) interface and you may use a browser to access the Monit program.


## Infrastructure

~~~mermaid
flowchart LR 

    subgraph External_Access [Internet Ingress]
        Caddy[Caddy]:::proxy
        Cert[LetsEncrypt]:::proxy
    end
    
    Cert --> Caddy
    
    subgraph Services_Layer [Applications]
        Seafile_S[Seafile]:::storage
        Joplin_S[Joplin]:::notes
        Hedgedoc_S[Hedgedoc]:::docs
        Azura_S[Azuracast]:::radio
        Vaultwarden_S[Vaultwarden]:::security
        
    end
    
    Caddy --> Seafile_S
    Caddy --> Joplin_S
    Caddy --> Hedgedoc_S
    Caddy --> Azura_S
    Caddy --> Vaultwarden_S


    subgraph Databases_and_Backends [DNS Names]
        Seafile_B[babasea.duckdns.org]:::storage
        Hedgedoc_B[babadocs.duckdns.org]:::docs
        Joplin_B[babanotes.ddns.net]:::notes
        Azura_B[babacast.ddns.net]:::radio
        Vaultwarden_B[babapass.ddns.net ]:::security
    end
    
    Seafile_S --> Seafile_B
    Hedgedoc_S --> Hedgedoc_B
    Joplin_S --> Joplin_B
    Azura_S --> Azura_B
    Vaultwarden_S --> Vaultwarden_B



    subgraph Fuji_HW [RadioDJ]
        RadioDJ[RadioDJ]:::nas
        BUTT[BUTT]:::nas
        NAS[NAS]:::nas
    end
    
    NAS -- Music --> RadioDJ
    RadioDJ --> BUTT
    
    subgraph Monitoring_Section [Health & Alerting]
        Monit[Monitoring]:::radio
        Alert[Alerting]:::proxy
        Mail[Mail]:::storage
    end
    
    Monit --> Alert
    Alert --> Mail
    Seafile_B --> Monit
    Hedgedoc_B --> Monit
    Joplin_B --> Monit
    Azura_B --> Monit
    Vaultwarden_B --> Monit
    
    %% Specific Connections
    Azura_B -- Relay Stream --> Stream1[Stream 1]
    Azura_B -- Relay Stream --> Stream2[Stream 2]
    BUTT --> Azura_S
~~~
