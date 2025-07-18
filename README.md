# Covex Studios Death Logs

A standalone FiveM (GTA V) server script that automatically logs player deaths (suicide, NPC, PvP) to a Discord channel via webhook. Now shows **all possible player identifiers** (steam, license, discord, fivem, etc.) in each embed for both victim and killer.

---

## Features

- **Automatic logging of all player deaths**
- **Unique Discord embed for suicide/NPC versus PvP deaths**
- **Displays all player identifiers in code blocks for audit/admin use**
- **Shows street name and vector3 death coordinates**
- **Simple to install, runs with any server framework or standalone**

---

## Installation

1. **Download or clone this repository**
    ```
    git clone https://github.com/YourUsername/your-repo-name.git
    ```

2. **Place the resource folder** (e.g. `covex_deathlogs`) in your server's `resources` directory.

3. **Add to your `server.cfg`:**
    ```
    ensure covex_deathlogs
    ```

4. **Set Your Discord Webhook**
    - Edit `server.lua`
    - Replace:
      ```
      local webhook = "YOUR_DISCORD_WEBHOOK_URL_HERE"
      ```
      with your actual Discord webhook URL from your Discord channel settings.

5. **Restart your server**

---

## Usage

- **Fully automatic.** No commands required.
- Suicides and NPC deaths send a simple embed with only the victim info.
- If killed by another player, both victim and killer info—including **all identifiers**—are shown in the Discord embed.

---

## Example: Suicide/NPC Death

