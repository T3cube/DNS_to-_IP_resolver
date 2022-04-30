# DNS_to-_IP_resolver
resolves a hostname to an ip address, and then uses that ip address to get a hostname and compares the 2

# Usage
./lookup.ps1 <list of names>
(reads line by line)
  
This project was designed to assist with a dumb problem with large scale networks. With quickly changing system availability, sometimes the ARP cache would be out of date. Most people prefer to use an easy to remember hostname instead of an IP address, but this has issues with stale ARP entries. The goal of this script is to request the host IP address from the ARP cache with the DNS recorded hostname, then use that IP address and perform a DNS query with it to find out who currently is actually using that address. From there it compares the 2 values (stripping away the domain at the end and keeping only the hostname).  If they match, the target hostname likely can be reached and the system should be online and accessible through use of the hostname.

There are several cenarios this script takes into account:
  Not getting a response.
  Getting a hostname resolved to an IP address, but being told the IP address doesnt resolve to a hostname.
  Getting a hostname resolved to an IP address and the IP address being resolved to a hostname where either they match or they dont match.
