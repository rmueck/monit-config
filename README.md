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
graph LR
    %% Global Styles - Added color:#000 to force black text on light backgrounds
    classDef proxy fill:#f8cecc,stroke:#b85450,color:#000
    classDef storage fill:#fff2cc,stroke:#d6b656,color:#000
    classDef docs fill:#d5e8d4,stroke:#82b366,color:#000
    classDef radio fill:#dae8fc,stroke:#6c8ebf,color:#000
    classDef joplin fill:#1ba1e2,stroke:#006EAF,color:#fff
    classDef hardware fill:#b0e3e6,stroke:#0e8088,color:#000
    classDef nas fill:#b1ddf0,stroke:#10739e,color:#000

    subgraph External_Access [Internet Ingress]
        direction TB
        Cert[Certificates LetsEncrypt]:::proxy --> Caddy[Caddy Proxy / Cert Manager]:::proxy
    end

    subgraph Services_Layer [Applications]
        direction TB
        Seafile_S[Seafile]:::storage
        Hedgedoc_S[Hedgedoc]:::docs
        Joplin_S[Joplin]:::joplin
        Vaultwarden_S[Vaultwarden]:::proxy
        Azura_S[Azuracast]:::radio
    end

    Caddy --> Seafile_S
    Caddy --> Joplin_S
    Caddy --> Hedgedoc_S
    Caddy --> Azura_S
    Caddy --> Vaultwarden_S

    subgraph Databases_and_Backends [DNS]
        direction TB
        Seafile_B[babasea.duckdns.org]:::storage
        Hedgedoc_B[babadocs.duckdns.org]:::docs
        Joplin_B[babanotes.ddns.net]:::joplin
        Vaultwarden_B[babapass.ddns.net]:::proxy
        Azura_B[babacast.ddns.net]:::radio
    end

    Seafile_S --> Seafile_B
    Hedgedoc_S --> Hedgedoc_B
    Joplin_S --> Joplin_B
    Vaultwarden_S --> Vaultwarden_B
    Azura_S --> Azura_B

    subgraph Fuji_HW [Fuji Hardware]
        direction LR
        NAS[(NAS)]:::nas -- Music --> RadioDJ:::nas --> BUTT:::nas
    end

    BUTT --> Azura_S

    subgraph Monitoring_Section [Health & Alerting]
        direction LR
        Monit[Monitoring]:::radio --> Alert[Alerting]:::proxy --> Mail[Mail]:::storage
    end

    %% Routing to Monitoring
    Seafile_B & Hedgedoc_B & Joplin_B & Azura_B & Vaultwarden_B --- Monit

    subgraph Streams [Outbound]
        Stream1[Stream 1]
        Stream2[Stream 2]
    end

    Azura_B -- Relay --> Stream1
    Azura_B -- Relay --> Stream2
~~~
