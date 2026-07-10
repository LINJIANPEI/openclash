#!/bin/sh
. /usr/share/openclash/ruby.sh
. /usr/share/openclash/log.sh
. /lib/functions.sh

# This script is called by /etc/init.d/openclash
# Add your custom overwrite scripts here, they will be take effict after the OpenClash own srcipts

LOG_OUT "Tip: Start Running Custom Overwrite Scripts..."
LOGTIME=$(echo $(date "+%Y-%m-%d %H:%M:%S"))
LOG_FILE="/tmp/openclash.log"
#Config Path
CONFIG_FILE="$1"

    #Simple Demo:
    #Key Overwrite Demo
    #1--config path
    #2--key name
    #3--value
    #ruby_edit "$CONFIG_FILE" "['redir-port']" "7892"
    #ruby_edit "$CONFIG_FILE" "['secret']" "123456"
    # ruby_edit "$CONFIG_FILE" "['dns']['enable']" "false"
    #ruby_edit "$CONFIG_FILE" "['dns']['proxy-server-nameserver']" "['https://doh.pub/dns-query','https://223.5.5.5:443/dns-query']"

    #Hash Overwrite Demo
    #1--config path
    #2--key name
    #3--hash type value
    #ruby_edit "$CONFIG_FILE" "['dns']['nameserver-policy']" "{'+.msftconnecttest.com'=>'114.114.114.114', '+.msftncsi.com'=>'114.114.114.114', 'geosite:gfw'=>['https://dns.cloudflare.com/dns-query', 'https://dns.google/dns-query#ecs=1.1.1.1/24&ecs-override=true'], 'geosite:cn'=>['114.114.114.114'], 'geosite:geolocation-!cn'=>['https://dns.cloudflare.com/dns-query', 'https://dns.google/dns-query#ecs=1.1.1.1/24&ecs-override=true']}"
    #ruby_edit "$CONFIG_FILE" "['sniffer']" "{'enable'=>true, 'parse-pure-ip'=>true, 'force-domain'=>['+.netflix.com', '+.nflxvideo.net', '+.amazonaws.com', '+.media.dssott.com'], 'skip-domain'=>['+.apple.com', 'Mijia Cloud', 'dlg.io.mi.com', '+.oray.com', '+.sunlogin.net'], 'sniff'=>{'TLS'=>nil, 'HTTP'=>{'ports'=>[80, '8080-8880'], 'override-destination'=>true}}}"

    #Map Edit Demo
    #1--config path
    #2--map name
    #3--key name
    #4--sub key name
    #5--value
    #ruby_map_edit "$CONFIG_FILE" "['proxy-providers']" "HK" "['url']" "http://test.com"

    #Hash Merge Demo
    #1--config path
    #2--key name
    #3--hash
    #ruby_merge_hash "$CONFIG_FILE" "['proxy-providers']" "'TW'=>{'type'=>'http', 'path'=>'./proxy_provider/TW.yaml', 'url'=>'https://gist.githubusercontent.com/raw/tw_clash', 'interval'=>3600, 'health-check'=>{'enable'=>true, 'url'=>'http://cp.cloudflare.com/generate_204', 'interval'=>300}}"
    #ruby_merge_hash "$CONFIG_FILE" "['rule-providers']" "'Reject'=>{'type'=>'http', 'behavior'=>'classical', 'url'=>'https://testingcf.jsdelivr.net/gh/dler-io/Rules@main/Clash/Provider/Reject.yaml', 'path'=>'./rule_provider/Reject', 'interval'=>86400}"

    #Array Edit Demo
    #1--config path
    #2--key name
    #3--match key name
    #4--match key value
    #5--target key name
    #6--target key value
    #ruby_arr_edit "$CONFIG_FILE" "['proxy-groups']" "['name']" "Proxy" "['type']" "Smart"
    #ruby_arr_edit "$CONFIG_FILE" "['dns']['nameserver']" "" "114.114.114.114" "" "119.29.29.29"

    #Array Insert Value Demo:
    #1--config path
    #2--key name
    #3--position(start from 0, end with -1)
    #4--value
    #ruby_arr_insert "$CONFIG_FILE" "['dns']['nameserver']" "0" "114.114.114.114"

    #Array Insert Hash Demo:
    #1--config path
    #2--key name
    #3--position(start from 0, end with -1)
    #4--hash
    #ruby_arr_insert_hash "$CONFIG_FILE" "['proxy-groups']" "0" "{'name'=>'Disney', 'type'=>'select', 'disable-udp'=>false, 'use'=>['TW', 'SG', 'HK']}"
    #ruby_arr_insert_hash "$CONFIG_FILE" "['proxies']" "0" "{'name'=>'HKG 01', 'type'=>'ss', 'server'=>'cc.hd.abc', 'port'=>'12345', 'cipher'=>'aes-128-gcm', 'password'=>'123456', 'udp'=>true, 'plugin'=>'obfs', 'plugin-opts'=>{'mode'=>'http', 'host'=>'microsoft.com'}}"
    #ruby_arr_insert_hash "$CONFIG_FILE" "['listeners']" "0" "{'name'=>'name', 'type'=>'shadowsocks', 'port'=>'12345', 'listen'=>'0.0.0.0', 'rule'=>'sub-rule-1', 'proxy'=>'proxy'}"

    #Array Insert Other Array Demo:
    #1--config path
    #2--key name
    #3--position(start from 0, end with -1)
    #4--array
    #ruby_arr_insert_arr "$CONFIG_FILE" "['dns']['proxy-server-nameserver']" "0" "['https://doh.pub/dns-query','https://223.5.5.5:443/dns-query']"

    #Array Insert From Yaml File Demo:
    #1--config path
    #2--key name
    #3--position(start from 0, end with -1)
    #4--value file path
    #5--value key name in #4 file
    #ruby_arr_add_file "$CONFIG_FILE" "['dns']['fallback-filter']['ipcidr']" "0" "/etc/openclash/custom/openclash_custom_fallback_filter.yaml" "['fallback-filter']['ipcidr']"

    #Delete Array Value Demo:
    #1--config path
    #2--key name
    #3--value
    #ruby_delete "$CONFIG_FILE" "['dns']['nameserver']" "114.114.114.114"

    #Delete Key Demo:
    #1--config path
    #2--key name
    #3--key name
    #ruby_delete "$CONFIG_FILE" "['dns']" "nameserver"
    #ruby_delete "$CONFIG_FILE" "" "dns"

    #Ruby Script Demo:
    #ruby -ryaml -rYAML -I "/usr/share/openclash" -E UTF-8 -e "
    #   begin
    #      Value = YAML.load_file('$CONFIG_FILE');
    #   rescue Exception => e
    #      puts '${LOGTIME} Error: Load File Failed,【' + e.message + '】';
    #   end;

        #General
    #   begin
    #   Thread.new{
    #      Value['redir-port']=7892;
    #      Value['tproxy-port']=7895;
    #      Value['port']=7890;
    #      Value['socks-port']=7891;
    #      Value['mixed-port']=7893;
    #   }.join;

    #   rescue Exception => e
    #      puts '${LOGTIME} Error: Set General Failed,【' + e.message + '】';
    #   ensure
    #      File.open('$CONFIG_FILE','w') {|f| YAML.dump(Value, f)};
    #   end" 2>/dev/null >> $LOG_FILE
    

    ruby -ryaml -rYAML -I "/usr/share/openclash" -E UTF-8 -e "
    begin
      Value = YAML.load_file('$CONFIG_FILE')

      Value['proxy-groups'] = [
        {
          'name'=>'🚀 国外代理',
          'type'=>'select',
          'disable-udp'=>false,
          'proxies'=>[
            '♻️ 自动选择',
            '➡️ 直连',
            '🇭🇰 香港',
            '🇹🇼 台湾',
            '🇯🇵 日本',
            '🇸🇬 新加坡',
            '🇬🇧 英国',
            '🇺🇸 美国',
            '🌐 全部节点'
          ]
        },
        {
          'name'=>'🎯 国内代理',
          'type'=>'select',
          'disable-udp'=>false,
          'proxies'=>[
            '➡️ 直连',
            '🇨🇳 中国',
            '♻️ 自动选择'
          ]
        },
        {
          'name'=>'🐟 漏网之鱼',
          'type'=>'select',
          'disable-udp'=>false,
          'proxies'=>[
            '♻️ 自动选择',
            '➡️ 直连',
            '🇭🇰 香港',
            '🇹🇼 台湾',
            '🇯🇵 日本',
            '🇸🇬 新加坡',
            '🇬🇧 英国',
            '🇺🇸 美国',
            '🌐 全部节点'
          ]
        },
        {
          'name'=>'🇨🇳 中国',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇨🇳|中国|cn|china|CN)',
          'proxies'=>['中国自动选择']
        },
        {
          'name'=>'🇭🇰 香港',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇭🇰|香港|hk|hongkong|hong kong|HK)',
          'proxies'=>['香港自动选择']
        },
        {
          'name'=>'🇹🇼 台湾',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇹🇼|台湾|tw|taiwan|TW)',
          'proxies'=>['台湾自动选择']
        },
        {
          'name'=>'🇯🇵 日本',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇯🇵|日|jp|japan|JP)',
          'proxies'=>['日本自动选择']
        },
        {
          'name'=>'🇺🇸 美国',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇺🇸|美|us|unitedstates|united states|US)',
          'proxies'=>['美国自动选择']
        },
        {
          'name'=>'🇬🇧 英国',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇬🇧|英国|uk|England|UK)',
          'proxies'=>['英国自动选择']
        },
        {
          'name'=>'🇸🇬 新加坡',
          'type'=>'select',
          'include-all'=>true,
          'filter'=>'(🇸🇬|新加坡|sg|singapore|SG)',
          'proxies'=>['新加坡自动选择']
        },
        {
          'name'=>'🌐 全部节点',
          'type'=>'select',
          'include-all'=>true
        },
          {
          'name'=>'中国自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇨🇳|中国|cn|china|CN)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50,
          'exclude-filter'=>'(🇹🇼|台湾|tw|taiwan|TW)'
        },
        {
          'name'=>'香港自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇭🇰|香港|hk|hongkong|hong kong|HK)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'台湾自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇹🇼|台湾|tw|taiwan|TW)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'日本自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇯🇵|日|jp|japan|JP)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'美国自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇺🇸|美|us|unitedstates|united states|US)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'英国自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇬🇧|英国|uk|England|UK)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'新加坡自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'filter'=>'(🇸🇬|新加坡|sg|singapore|SG)',
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        },
        {
          'name'=>'♻️ 自动选择',
          'type'=>'url-test',
          'include-all'=>true,
          'url'=>'https://cp.cloudflare.com/generate_204',
          'interval'=>300,
          'tolerance'=>50
        }
      ]

      Value['rule-providers'] = {
      
        'private_ip'=>{
          'type'=>'http',
          'behavior'=>'ipcidr',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/private.yaml',
          'path'=>'./rule_provider/private_ip',
          'interval'=>86400
        },
      
        'private_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/private.yaml',
          'path'=>'./rule_provider/private_domain',
          'interval'=>86400
        },
      
        'bilibili_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/bilibili.yaml',
          'path'=>'./rule_provider/bilibili_domain',
          'interval'=>86400
        },
      
        'cn_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/cn.yaml',
          'path'=>'./rule_provider/cn_domain',
          'interval'=>86400
        },
      
        'cn_ip'=>{
          'type'=>'http',
          'behavior'=>'ipcidr',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/cn.yaml',
          'path'=>'./rule_provider/cn_ip',
          'interval'=>86400
        },
      
        'github_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/github.yaml',
          'path'=>'./rule_provider/github_domain',
          'interval'=>86400
        },
      
        'google_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/google.yaml',
          'path'=>'./rule_provider/google_domain',
          'interval'=>86400
        },
      
        'youtube_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/youtube.yaml',
          'path'=>'./rule_provider/youtube_domain',
          'interval'=>86400
        },
      
        'tiktok_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/tiktok.yaml',
          'path'=>'./rule_provider/tiktok_domain',
          'interval'=>86400
        },
      
        'netflix_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/netflix.yaml',
          'path'=>'./rule_provider/netflix_domain',
          'interval'=>86400
        },
      
        'telegram_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/telegram.yaml',
          'path'=>'./rule_provider/telegram_domain',
          'interval'=>86400
        },
      
        'gfw_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/gfw.yaml',
          'path'=>'./rule_provider/gfw_domain',
          'interval'=>86400
        },
      
        'geolocation_nocn_domain'=>{
          'type'=>'http',
          'behavior'=>'domain',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geosite/geolocation-!cn.yaml',
          'path'=>'./rule_provider/geolocation_nocn_domain',
          'interval'=>86400
        },
      
        'google_ip'=>{
          'type'=>'http',
          'behavior'=>'ipcidr',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/google.yaml',
          'path'=>'./rule_provider/google_ip',
          'interval'=>86400
        },
      
        'netflix_ip'=>{
          'type'=>'http',
          'behavior'=>'ipcidr',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/netflix.yaml',
          'path'=>'./rule_provider/netflix_ip',
          'interval'=>86400
        },
      
        'telegram_ip'=>{
          'type'=>'http',
          'behavior'=>'ipcidr',
          'url'=>'https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/telegram.yaml',
          'path'=>'./rule_provider/telegram_ip',
          'interval'=>86400
        }
      
      }

      Value['rules'] = [
        'RULE-SET,private_ip,🎯 国内代理',
        'RULE-SET,private_domain,🎯 国内代理',
        'RULE-SET,bilibili_domain,🎯 国内代理',
        'RULE-SET,cn_domain,🎯 国内代理',
        'RULE-SET,cn_ip,🎯 国内代理',
      
        'RULE-SET,github_domain,🚀 国外代理',
        'RULE-SET,google_domain,🚀 国外代理',
        'RULE-SET,youtube_domain,🚀 国外代理',
        'RULE-SET,tiktok_domain,🚀 国外代理',
        'RULE-SET,netflix_domain,🚀 国外代理',
        'RULE-SET,telegram_domain,🚀 国外代理',
        'RULE-SET,gfw_domain,🚀 国外代理',
        'RULE-SET,geolocation_nocn_domain,🚀 国外代理',
      
        'RULE-SET,google_ip,🚀 国外代理',
        'RULE-SET,netflix_ip,🚀 国外代理',
        'RULE-SET,telegram_ip,🚀 国外代理',
      
        'MATCH,🐟 漏网之鱼'
      ]

      Value['proxies'].unshift(
        {
            'name'=>'➡️ 直连',
            'type'=>'direct',
            'udp'=>'true',
            'ip-version'=>'ipv4-prefer'
        }
      )

      Value['dns']['enable'] = false

      File.open('$CONFIG_FILE','w') { |f| YAML.dump(Value, f) }

    rescue Exception => e
      puts e.message
    end
    "








exit 0