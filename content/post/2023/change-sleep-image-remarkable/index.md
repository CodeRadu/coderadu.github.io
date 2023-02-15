---
title: Changing the sleep image on the remarkable
categories:
  - linux
  - remarkable
date: 2023-02-15
layout: "post"
slug: "change-sleep-image-remarkable"
menu:
  main:
    weight: -10
---

# Changing the sleep image on the reMarkable

This tutorial works on both the rM1 and the rM2.

## Setup

- Connect your reMarkable with a USB cable to your computer
- Go to `Settings` -> `Help` -> `Copyrights and licenses` -> `General information` and note the SSH password somewhere safe
- Use an SCP client to connect to your reMarkable using `root@10.11.99.1`

## Backing up the old image

- Enter the `/usr/share/remarkable` folder
- Make copy of `suspended.png`

## Changing the image

- Replace `suspended.png` with your new image
- Restart your reMarkable

And that's all!
