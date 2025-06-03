#!/bin/bash

# 🧠 Jake's Secure SSH Setup Wizard v1.0

set -e

echo "🔐 Welcome to Jake's Secure SSH Setup Wizard"

# ──────────────────────────────────────────────
# ✅ 1. Ask for SSH Port
# ──────────────────────────────────────────────
read -p "➡️  Enter SSH port you want to use (default: 3971): " SSH_PORT
SSH_PORT=${SSH_PORT:-3971}

# ──────────────────────────────────────────────
# ✅ 2. Ask for Public Key (or generate)
# ──────────────────────────────────────────────
echo ""
read -p "➡️  Do you have an existing SSH public key to use? (y/n): " has_key

if [[ "$has_key" == "y" || "$has_key" == "Y" ]]; then
  echo ""
  read -p "Paste your SSH public key: " USER_SSH_KEY
else
  echo "🛠️  No key provided. Generating a 4096-bit RSA keypair..."
  ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa <<< y >/dev/null
  USER_SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
  echo "📎 Key generated:"
  echo "$USER_SSH_KEY"
fi

# ──────────────────────────────────────────────
# ✅ 3. Create authorized_keys
# ──────────────────────────────────────────────
echo "📥 Writing key to /root/.ssh/authorized_keys..."
mkdir -p /root/.ssh
echo "$USER_SSH_KEY" > /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# ──────────────────────────────────────────────
# ✅ 4. Update sshd_config
# ──────────────────────────────────────────────
echo "🧩 Updating /etc/ssh/sshd_config..."

cat > /etc/ssh/sshd_config <<EOF
# Jake Secure SSH Config
Port $SSH_PORT
PermitRootLogin prohibit-password
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
EOF

# ──────────────────────────────────────────────
# ✅ 5. Disable ssh.socket & mask it
# ──────────────────────────────────────────────
echo "🛑 Disabling ssh.socket..."
systemctl disable --now ssh.socket || true
systemctl mask ssh.socket || true

# ──────────────────────────────────────────────
# ✅ 6. Enable & restart ssh.service
# ──────────────────────────────────────────────
systemctl enable ssh
systemctl restart ssh
echo "🔁 SSH service restarted on port $SSH_PORT"

# ──────────────────────────────────────────────
# ✅ 7. Setup UFW rules
# ──────────────────────────────────────────────
echo "🛡️  Configuring UFW firewall rules..."
ufw allow $SSH_PORT/tcp
ufw deny 22/tcp
ufw default deny incoming
ufw default allow outgoing
ufw --force enable

# ──────────────────────────────────────────────
# ✅ 8. Install Fail2Ban
# ──────────────────────────────────────────────
echo "🚓 Installing Fail2Ban..."
apt update && apt install -y fail2ban
systemctl enable --now fail2ban

# ──────────────────────────────────────────────
# ✅ Done!
# ──────────────────────────────────────────────
echo ""
echo "✅ All done!"
echo "🚀 SSH is now locked down on port $SSH_PORT"
echo "🔐 Login using your private key only."

echo "🧠 Pro Tip: Test the new port before closing current session!"


#chmod +x setup-secure-ssh.sh
#./setup-secure-ssh.sh