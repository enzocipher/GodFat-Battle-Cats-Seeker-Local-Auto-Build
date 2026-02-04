---

# Battle Cats Rolls – Docker Quickstart Guide

This guide will help you run **Battle Cats Rolls** locally using Docker, even if you are new to Linux or command-line tools. You do **not** need AWS or any cloud setup — everything runs locally.

> **Important:** Copy the contents of this repository into your Battle Cats Rolls directory (or just use `git clone`) and **open WSL in that same directory**. All commands below assume you are inside that folder.

---

## 1. Prerequisites

You will need the following installed on your Windows PC:

1. **Windows Subsystem for Linux (WSL2)**

   * If you don’t have it, follow [Microsoft’s guide](https://learn.microsoft.com/en-us/windows/wsl/install).
   * Recommended Linux distribution: **Ubuntu 22.04 or 24.04**.
   * Make sure your WSL2 is running before proceeding.

2. **Docker inside WSL2**

   * Install Docker and Docker Compose in your Linux WSL terminal:

   ```bash
   sudo apt update
   sudo apt install docker.io docker-compose -y
   ```

3. **Git** (to clone the repository)

   * If not installed, run:

   ```bash
   sudo apt update
   sudo apt install git -y
   ```

---

## 2. Clone the Repository

Inside your WSL terminal, run:

```bash
git clone https://gitlab.com/godfat/battle-cats-rolls.git
cd battle-cats-rolls
```

> If you already copied the files manually, just `cd` into the folder in WSL.

---

## 3. Build the Docker Image

The Dockerfile in this repository will:

* Install Ruby and all dependencies
* Install build tools (clang, memcached, etc.)
* Compile the seed seekers automatically
* Convert scripts to Unix format and give execute permissions

To build the Docker image, run:

```bash
docker compose build
```

> This may take a few minutes the first time.

---

## 4. Run the Server

Once the image is built, start the server in **foreground mode**:

```bash
docker compose up
```

* This will start **memcached** and the **Battle Cats Rolls server**.
* Logs will appear in the terminal.
* Press **Ctrl+C** to stop everything cleanly.

> Running in foreground mode ensures everything shuts down when you stop it.

---

## 5. Access the Server

The server listens on **ports 8080 and 9090**.
Open your web browser and visit:

```
http://localhost:8080
http://localhost:9090
```

You should now see the Battle Cats Rolls interface.

---

## 6. Troubleshooting Tips

* **Ports not accessible?** Make sure no other program is using 8080 or 9090.
* **Server not starting?** Make sure Docker is running inside WSL2 and you are inside the repo directory.
* **Missing Linux commands (`ls`, `cd`, etc.)?** All Linux commands work inside the WSL terminal:

```bash
cd battle-cats-rolls
ls -l
```

* **Stop the server** at any time with **Ctrl+C** — this shuts down both the server and memcached.

---

## 7. Advanced Notes

* All data is stored **inside the container**. No AWS keys or cloud access are needed.
* Seed seekers (VampireFlower, 8.6) are compiled automatically during the Docker build.
* To rebuild the server or update dependencies:

```bash
docker compose build --no-cache
docker compose up
```

---

This setup is designed for **local play and testing** only. You do not need any external accounts, keys, or cloud services.

---
