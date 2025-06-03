#!/bin/bash

### 🧠 مشخصات قابل تنظیم
SSH_PORT=3971
PUB_KEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZT3TGVhSc4g9h+SLGEAwL31S8WMUwMee3n3ML3tzEv5zQQzZtcXmnVqTajJEAxkuUoKcys3swHdMH8LGgCrUvDenL82IDFmkfsZm6rHYOU0DAnvbFGAoBLCSpZBUfJwQHTZz9n0HYg+3XADEQNtcb2JRGF+jwG0LUFpMMTacHRRs1ajIZZQk5MaFQD/J501wjNHHvbImWU4jxXVJcOPtF+6vL0pdQa4WCjI/DN7A3ukF+/xZxlM+HusNFU/V8TWOdAVSzKJJfoW/LMxzIvfty5uK6N6KNLcYQoHr5MuiWtGfyqRwZtocCP5gxOQnn/gFIx9U4hkrO2/YuvQ6x9yXA1Sv0aMd92QgM+2VhVblkTQSR+ygll5g5dbZJdQz8NQUkEd/7NWK5RWrXyLI1/QgciT+whdCP9/FPJ4DL9pcSSySd+AflHvPxt7YRbyxv9ATiMWsQZknsdZHyb/GRFycPQGOwC2jhMc1IWea6YbDWJBZK6FKAMeFjMXOZpmAj0Sh+f2+p0W//DFv1jgaLFmpYMW1p0GFeyzQHgNHzSKXqxsE9qL8xmTZVaekqkRtl0u8Sr43JWw24gqGOMj4BB1JKDDW7MAZxx/jJF89dUyzltFplRVJ8hZYUXdwQfqXsBcb/3xHaCWdKZ1WfoD4Yk4MFjvAKNYLBgr/vrmuSGAmnzw== vpn-bot'

echo "🧱 تغییر پورت SSH به $SSH_PORT ..."
sed -i "s/^#Port .*/Port $SSH_PORT/" /etc/ssh/sshd_config
sed -i "/^Port /!b;n;c\PermitRootLogin yes" /etc/ssh/sshd_config

echo "🪓 خاموش کردن ssh.socket ..."
systemctl disable --now ssh.socket
systemctl mask ssh.socket

echo "🔐 تنظیم کلید SSH..."
mkdir -p ~/.ssh
echo "$PUB_KEY" > ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo "🧯 تنظیمات فایروال (UFW)..."
ufw allow $SSH_PORT/tcp
ufw deny 22/tcp
ufw default deny incoming
ufw default allow outgoing
yes | ufw enable

echo "👮 نصب Fail2Ban ..."
apt update && apt install -y fail2ban
systemctl enable --now fail2ban

echo "🔁 ریستارت SSH و تست نهایی..."
sshd -t && systemctl restart ssh

echo "✅ پایان عملیات | پورت فعال شده: $SSH_PORT"
ss -tulnp | grep sshd
