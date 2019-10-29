vi /etc/bind/named.conf.options

cat <<EOT
EXAMPLE:
options {
        directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0's placeholder.

        // forwarders {
        //      0.0.0.0;
        // };
        # query range you allow
        allow-query { localhost; 10.0.0.0/24; };
        # the range to transfer zone files
        allow-transfer { localhost; 10.0.0.0/24; };
        # recursion range you allow
        allow-recursion { localhost; 10.0.0.0/24; };
        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        dnssec-validation auto;

        auth-nxdomain no;    # conform to RFC1035
        # change if not use IPV6
        listen-on-v6 { none; };
};
EOT