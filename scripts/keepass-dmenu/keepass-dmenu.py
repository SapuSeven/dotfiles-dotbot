#!/usr/bin/python3

from pykeepass_cache import PyKeePass

from pyotp import TOTP
from configparser import ConfigParser
import os
import sys


def load(database, password, keyfile):
    # noinspection PyTypeChecker
    return PyKeePass(database, password=password, keyfile=keyfile, timeout=None)


def keepass_list():
    result = []

    for entry in db.entries:
        #if entry.group == db.recyclebin_group: continue
        result.append("/".join(filter(None, entry.path)))

    return "\n".join(sorted(result))


def keepass_info():
    if len(sys.argv) < 3:
        return "invalid item"

    obj = db.find_entries(path=sys.argv[2].split("/"))

    if len(sys.argv) >= 4:
        return {
            "user": obj.username,
            "pass": obj.password,
            "otp": keepass_get_otp(obj),
            "custom": keepass_get_custom(obj, sys.argv[4]) if len(sys.argv) >= 5 else keepass_get_custom(obj)
        }.get(sys.argv[3], "")
    else:
        return obj


def keepass_get_otp(obj):
    if "OTP" in obj.custom_properties:
        return TOTP(obj.custom_properties["OTP"]).now()
    else:
        return "No OTP secret available"


def keepass_get_custom(obj, key=None):
    if key:
        return obj.custom_properties[key]
    else:
        return "\n".join(filter(lambda s : s != "OTP", obj.custom_properties.keys()))


def keepass_error():
    return "error"


def keepass(func):
    return {
        "list": keepass_list,
        "info": keepass_info
    }.get(func, keepass_error)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Available commands: list, info")
        exit(1)

    config_dir = os.getenv("XDG_CONFIG_HOME", os.getenv("HOME") + "/.config")
    config_path = config_dir + "/keepass-dmenu.conf"

    config = ConfigParser()
    config.read(config_path)

    if not os.path.isfile(config_path):
        print("Configuration not found:", config_path)
        quit(1)

    db = load(
        config["config"]["database"],
        config["config"]["password"],
        config["config"]["keyfile"]
    )
    print(keepass(sys.argv[1])(), end="")
