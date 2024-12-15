#!/bin/sh

[ -z "$1" ] && echo "请输入用户名" && exit 1 
user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'

cd /usr/home/$1/opt/caddy

get_tag() {
	curltest=`which curl`
  repo=$1
  if [ -z "$curltest" ] || [ ! -s "`which curl`" ] ; then
      tag="$( wget --no-check-certificate -T 5 -t 3 --user-agent "$user_agent" --max-redirect=0 --output-document=-  https://api.github.com/repos/${repo}/releases/latest 2>&1 | grep 'tag_name' | cut -d\" -f4 )"
	 	  [ -z "$tag" ] && tag="$( wget --no-check-certificate -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=-  https://api.github.com/repos/${repo}/releases/latest  2>&1 | grep 'tag_name' | cut -d\" -f4 )"
   else
      tag="$( curl -k --connect-timeout 3 --user-agent "$user_agent"  https://api.github.com/repos/${repo}/releases/latest 2>&1 | grep 'tag_name' | cut -d\" -f4 )"
      [ -z "$tag" ] && tag="$( curl -Lk --connect-timeout 3 --user-agent "$user_agent" -s  https://api.github.com/repos/${repo}/releases/latest  2>&1 | grep 'tag_name' | cut -d\" -f4 )"
  fi
  [ ! -z "$tag" ] && echo "$tag"
}

curl_wget() {
  filename=$1
  url=$2
  echo "开始下载 $filename  链接地址 $url"
  curl -Lko "$filename" "$url" || wget --no-check-certificate -O "$filename" "$url" || echo "下载${url}失败！"
}

[ ! -d ./zerotier ] && mkdir -p zerotier
zttag=$(get_tag "lmq8267/ZeroTierOne")
if [ ! -z "$zttag" ] && [ ! -d "./zerotier/${zttag}" ] ; then
    cd ./zerotier
    echo "开始更新ZeroTier $zttag"
    mkdir -p ${zttag}
    curl_wget "./${zttag}/zerotier-arm7l-etc.tar.gz" "https://github.com/lmq8267/ZeroTierOne/releases/download/${zttag}/zerotier-arm7l-etc.tar.gz"
    curl_wget "./${zttag}/zerotier-arm7l-opt.tar.gz" "https://github.com/lmq8267/ZeroTierOne/releases/download/${zttag}/zerotier-arm7l-opt.tar.gz"
    curl_wget "./${zttag}/zerotier-mipsel-opt.tar.gz" "https://github.com/lmq8267/ZeroTierOne/releases/download/${zttag}/zerotier-mipsel-opt.tar.gz"
    curl_wget "./${zttag}/zerotier-one" "https://github.com/lmq8267/ZeroTierOne/releases/download/${zttag}/zerotier-one"
    cd ../
fi

[ ! -d ./vnts ] && mkdir -p vnts
vntstag=$(get_tag "lmq8267/vnts")
if [ ! -z "$vntstag" ] && [ ! -d "./vnts/${vntstag}" ] ; then
    cd ./vnts
    echo "开始更新vnts $vntstag"
    mkdir -p ${vntstag}
    curl_wget "./${vntstag}/vnts_aarch64-unknown-linux-musl" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_aarch64-unknown-linux-musl"
    curl_wget "./${vntstag}/vnts_arm-unknown-linux-musleabi" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_arm-unknown-linux-musleabi"
    curl_wget "./${vntstag}/vnts_arm-unknown-linux-musleabihf" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_arm-unknown-linux-musleabihf"
    curl_wget "./${vntstag}/vnts_armv7-unknown-linux-musleabi" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_armv7-unknown-linux-musleabi"
    curl_wget "./${vntstag}/vnts_armv7-unknown-linux-musleabihf" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_armv7-unknown-linux-musleabihf"
    curl_wget "./${vntstag}/vnts_mips-unknown-linux-musl" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_mips-unknown-linux-musl"
    curl_wget "./${vntstag}/vnts_mipsel-unknown-linux-musl" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_mipsel-unknown-linux-musl"
    curl_wget "./${vntstag}/vnts_x86_64-unknown-linux-musl" "https://github.com/lmq8267/vnts/releases/download/${vntstag}/vnts_x86_64-unknown-linux-musl"
    cd ../
fi

[ ! -d ./vnt-cli ] && mkdir -p vnt-cli
vnttag=$(get_tag "lmq8267/vnt-cli")
if [ ! -z "$vnttag" ] && [ ! -d "./vnt-cli/${vnttag}" ] ; then
    cd ./vnt-cli
    echo "开始更新vnt-cli $vnttag"
    mkdir -p ${vnttag}
    curl_wget "./${vnttag}/vnt-cli-386-docker.tar" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli-386-docker.tar"
    curl_wget "./${vnttag}/vnt-cli-arm64-docker.tar" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli-arm64-docker.tar"
    curl_wget "./${vnttag}/vnt-cli-armv5-docker.tar" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli-armv5-docker.tar"
    curl_wget "./${vnttag}/vnt-cli-armv7-docker.tar" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli-armv7-docker.tar"
    curl_wget "./${vnttag}/vnt-cli-x86_64-docker.tar" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli-x86_64-docker.tar"
    curl_wget "./${vnttag}/vnt-cli_aarch64-unknown-linux-musl" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_aarch64-unknown-linux-musl"
    curl_wget "./${vnttag}/vnt-cli_arm-unknown-linux-musleabi" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_arm-unknown-linux-musleabi"
    curl_wget "./${vnttag}/vnt-cli_arm-unknown-linux-musleabihf" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_arm-unknown-linux-musleabihf"
    curl_wget "./${vnttag}/vnt-cli_armv7-unknown-linux-musleabi" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_armv7-unknown-linux-musleabi"
    curl_wget "./${vnttag}/vnt-cli_armv7-unknown-linux-musleabihf" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_armv7-unknown-linux-musleabihf"
    curl_wget "./${vnttag}/vnt-cli_ddwrt-arm_cortex-a9" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_ddwrt-arm_cortex-a9"
    curl_wget "./${vnttag}/vnt-cli_mips-unknown-linux-musl" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_mips-unknown-linux-musl"
    curl_wget "./${vnttag}/vnt-cli_mipsel-unknown-linux-musl" "https://github.com/lmq8267/vnt-cli/releases/download/${vnttag}/vnt-cli_mipsel-unknown-linux-musl"
    curl_wget "./${vnttag}/vnt-aarch64-apple-darwin.tar.gz" "https://github.com/vnt-dev/vnt/releases/download/${vnttag}/vnt-aarch64-apple-darwin-${vnttag}.tar.gz"
    curl_wget "./${vnttag}/vnt-i686-pc-windows-msvc.tar.gz" "https://github.com/vnt-dev/vnt/releases/download/${vnttag}/vnt-i686-pc-windows-msvc-${vnttag}.tar.gz"
    curl_wget "./${vnttag}/vnt-x86_64-apple-darwin.tar.gz" "https://github.com/vnt-dev/vnt/releases/download/${vnttag}/vnt-x86_64-apple-darwin-${vnttag}.tar.gz"
    curl_wget "./${vnttag}/vnt-x86_64-pc-windows-msvc.tar.gz" "https://github.com/vnt-dev/vnt/releases/download/${vnttag}/vnt-x86_64-pc-windows-msvc-${vnttag}.tar.gz"
    cd ../
fi

[ ! -d ./easytier ] && mkdir -p easytier
easytiertag=$(get_tag "lmq8267/easytier")
if [ ! -z "$easytiertag" ] && [ ! -d "./easytier/${easytiertag}" ] ; then
    cd ./easytier
    echo "开始更新easytier $easytiertag"
    mkdir -p ${easytiertag}
    curl_wget "./${easytiertag}/app-universal-release.apk" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/app-universal-release.apk"
    curl_wget "./${easytiertag}/easytier-freebsd-13.2-x86_64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-freebsd-13.2-x86_64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-windows-x86_64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-windows-x86_64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-macos-x86_64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-macos-x86_64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-macos-aarch64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-macos-aarch64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-x86_64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-x86_64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-mipsel.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-mipsel-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-mips.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-mips-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-armv7hf.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-armv7hf-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-armv7.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-armv7-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-armhf.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-armhf-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-arm.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-arm-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-linux-aarch64.zip" "https://github.com/EasyTier/EasyTier/releases/download/${easytiertag}/easytier-linux-aarch64-${easytiertag}.zip"
    curl_wget "./${easytiertag}/easytier-i686-linux-musl.tar.gz" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-i686-linux-musl.tar.gz"
    curl_wget "./${easytiertag}/easytier-arm64-docker.tar" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-arm64-docker.tar"
    curl_wget "./${easytiertag}/easytier-386-docker.tar" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-386-docker.tar"
    curl_wget "./${easytiertag}/easytier-armv5-docker.tar" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-armv5-docker.tar"
    curl_wget "./${easytiertag}/easytier-armv7-docker.tar" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-armv7-docker.tar"
    curl_wget "./${easytiertag}/easytier-x86_64-docker.tar" "https://github.com/lmq8267/EasyTier/releases/download/${easytiertag}/easytier-x86_64-docker.tar"
    cd ../
fi

[ ! -d ./tailscale ] && mkdir -p tailscale
tailscaletag=$(get_tag "lmq8267/tailscale")
if [ ! -z "$tailscaletag" ] && [ ! -d "./tailscale/${tailscaletag}" ] ; then
    cd ./tailscale
    echo "开始更新tailscale $tailscaletag"
    mkdir -p ${tailscaletag}
    curl_wget "./${tailscaletag}/derper-mipsel" "https://github.com/lmq8267/tailscale/releases/download/${tailscaletag}/derper"
    curl_wget "./${tailscaletag}/tailscaled_full-mipsel" "https://github.com/lmq8267/tailscale/releases/download/${tailscaletag}/tailscaled_full"
    curl_wget "./${tailscaletag}/tailscaled-mipsel" "https://github.com/lmq8267/tailscale/releases/download/${tailscaletag}/tailscaled"
    curl_wget "./${tailscaletag}/tailscale-mipsel" "https://github.com/lmq8267/tailscale/releases/download/${tailscaletag}/tailscale"
    cd ../
fi

[ ! -d ./cloudflared ] && mkdir -p cloudflared
cloudflaredtag=$(get_tag "lmq8267/cloudflared")
if [ ! -z "$cloudflaredtag" ] && [ ! -d "./cloudflared/${cloudflaredtag}" ] ; then
    cd ./cloudflared
    echo "开始更新cloudflared $cloudflaredtag"
    mkdir -p ${cloudflaredtag}
    curl_wget "./${cloudflaredtag}/cloudflared-mipsel" "https://github.com/lmq8267/cloudflared/releases/download/${cloudflaredtag}/cloudflared"
    cd ../
fi

[ ! -d ./alist ] && mkdir -p alist
alisttag=$(get_tag "lmq8267/alist")
if [ ! -z "$alisttag" ] && [ ! -d "./alist/${alisttag}" ] ; then
    cd ./alist
    echo "开始更新alist $alisttag"
    mkdir -p ${alisttag}
    curl_wget "./${alisttag}/alist-mipsel-upx" "https://github.com/lmq8267/alist/releases/download/${alisttag}/alist"
    curl_wget "./${alisttag}/alist-mipsel-upx.tar.gz" "https://github.com/lmq8267/alist/releases/download/${alisttag}/alist.tar.gz"
    curl_wget "./${alisttag}/alist-linux-musl-mipsle.tar.gz" "https://github.com/AlistGo/alist/releases/download/${alisttag}/alist-linux-musl-mipsle.tar.gz"
    cd ../
fi

[ ! -d ./caddy ] && mkdir -p caddy
caddytag=$(get_tag "lmq8267/caddy")
if [ ! -z "$caddytag" ] && [ ! -d "./caddy/${caddytag}" ] ; then
    cd ./caddy
    echo "开始更新caddy $caddytag"
    mkdir -p ${caddytag}
    curl_wget "./${caddytag}/caddy-amd64" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-amd64"
    curl_wget "./${caddytag}/caddy-amd64-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-amd64-upx"
    curl_wget "./${caddytag}/caddy-arm" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-arm"
    curl_wget "./${caddytag}/caddy-arm-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-arm-upx"
    curl_wget "./${caddytag}/caddy-arm64" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-arm64"
    curl_wget "./${caddytag}/caddy-arm64-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-arm64-upx"
    curl_wget "./${caddytag}/caddy-armv5l" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv5l"
    curl_wget "./${caddytag}/caddy-armv5l-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv5l-upx"
    curl_wget "./${caddytag}/caddy-armv6" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv6"
    curl_wget "./${caddytag}/caddy-armv6-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv6-upx"
    curl_wget "./${caddytag}/caddy-armv7l" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv7l"
    curl_wget "./${caddytag}/caddy-armv7l-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-armv7l-upx"
    curl_wget "./${caddytag}/caddy-mips" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-mips"
    curl_wget "./${caddytag}/caddy-mips-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-mips-upx"
    curl_wget "./${caddytag}/caddy-mipsel" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-mipsel"
    curl_wget "./${caddytag}/caddy-mipsel-upx" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-mipsel-upx"
    curl_wget "./${caddytag}/caddy-s390x" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-s390x"
    curl_wget "./${caddytag}/caddy-freebsd-x86-64" "https://github.com/lmq8267/caddy/releases/download/${caddytag}/caddy-freebsd-x86-64"
    cd ../
fi

[ ! -d ./iperf3 ] && mkdir -p iperf3
iperf3tag=$(get_tag "lmq8267/iperf3")
if [ ! -z "$iperf3tag" ] && [ ! -d "./iperf3/${iperf3tag}" ] ; then
    cd ./iperf3
    echo "开始更新iperf3 $iperf3tag"
    mkdir -p ${iperf3tag}
    curl_wget "./${iperf3tag}/iperf3-mipsel" "https://github.com/lmq8267/iperf3/releases/download/${iperf3tag}/iperf3_musl_mipsel"
    curl_wget "./${iperf3tag}/iperf3_musl_aarch64" "https://github.com/lmq8267/iperf3/releases/download/${iperf3tag}/iperf3_musl_aarch64"
    cd ../
fi

[ ! -d ./vnt-cli/luci-app-vnt ] && mkdir -p ./vnt-cli/luci-app-vnt
opvnttag=$(get_tag "lmq8267/luci-app-vnt")
if [ ! -z "$opvnttag" ] && [ ! -d "./vnt-cli/luci-app-vnt/${opvnttag}" ] ; then
    cd ./vnt-cli
    echo "开始更新luci-app-vnt $opvnttag"
    mkdir -p ./luci-app-vnt/${opvnttag}
    curl_wget "./luci-app-vnt/${opvnttag}/luci-app-vnt_all.ipk" "https://github.com/lmq8267/luci-app-vnt/releases/download/${opvnttag}/luci-app-vnt_all.ipk"
    cd ../
fi

[ ! -d ./vnt-cli/梅林离线安装包 ] && mkdir -p ./vnt-cli/梅林离线安装包
merlintag=$(get_tag "lmq8267/luci-app-vnt")
if [ ! -z "$merlintag" ] && [ ! -d "./vnt-cli/梅林离线安装包/${merlintag}" ] ; then
    cd ./vnt-cli
    echo "开始更新vnt梅林离线安装包 $merlintag"
    mkdir -p ./梅林离线安装包/${merlintag}
    curl_wget "./梅林离线安装包/${merlintag}/vnt-koolshare.tar.gz" "https://github.com/lmq8267/vnt-merlin/releases/download/${merlintag}/vnt-koolshare.tar.gz"
    curl_wget "./梅林离线安装包/${merlintag}/vnt-SWRT.tar.gz" "https://github.com/lmq8267/vnt-merlin/releases/download/${merlintag}/vnt-SWRT.tar.gz"
    cd ../
fi

[ ! -d ./netlink ] && mkdir -p ./netlink
netlinktag=$(get_tag "rustp2p/NetLink")
if [ ! -z "$netlinktag" ] && [ ! -d "./netlink/${merlintag}" ] ; then
    cd ./netlink
    echo "开始更新netlink $netlinktag"
    mkdir -p ${netlinktag}
    curl_wget "./netlink/${netlinktag}/netlink-aarch64-apple-darwin.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-aarch64-apple-darwin-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-aarch64-pc-windows-msvc.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-aarch64-pc-windows-msvc-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-aarch64-unknown-linux-musl.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-aarch64-unknown-linux-musl-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-arm-unknown-linux-musleabi.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-arm-unknown-linux-musleabi-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-arm-unknown-linux-musleabihf.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-arm-unknown-linux-musleabihf-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-armv7-unknown-linux-musleabi.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-armv7-unknown-linux-musleabi-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-armv7-unknown-linux-musleabihf.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-armv7-unknown-linux-musleabihf-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-i686-pc-windows-msvc.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-i686-pc-windows-msvc-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-mips-unknown-linux-musl.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-mips-unknown-linux-musl-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-mipsel-unknown-linux-musl.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-mipsel-unknown-linux-musl-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-x86_64-apple-darwin.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-x86_64-apple-darwin-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-x86_64-pc-windows-msvc.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-x86_64-pc-windows-msvc-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-x86_64-unknown-freebsd.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-x86_64-unknown-freebsd-${netlinktag}.tar.gz"
    curl_wget "./netlink/${netlinktag}/netlink-x86_64-unknown-linux-musl.tar.gz" "https://github.com/rustp2p/NetLink/releases/download/${netlinktag}/netlink-x86_64-unknown-linux-musl-${netlinktag}.tar.gz"
    cd ../
fi
