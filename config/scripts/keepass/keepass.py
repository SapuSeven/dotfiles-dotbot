try:
    from pykeepass_cache.pykeepass_cache import PyKeePass
except ImportError:
    from pykeepass_cache_git.pykeepass_cache import PyKeePass

from pyotp import TOTP
from configparser import ConfigParser
import sys


def load(database, password, keyfile):
    # noinspection PyTypeChecker
    return PyKeePass(database, password=password, keyfile=keyfile, timeout=None)


def keepass_list():
    return "\n".join(sorted(list(map(lambda x: x.path, db.entries))))


def keepass_info():
    if len(sys.argv) < 3:
        return "invalid item"

    obj = db.find_entries_by_path(sys.argv[2])
    # print("Username:", obj.username)
    # print("Password:", obj.password)
    # print("AutoType:", obj.autotype_sequence)

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
        print("No OTP secret available")
        return ""


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

    config = ConfigParser()
    config.read("config.ini")

    db = load(
        config["config"]["database"],
        config["config"]["password"],
        config["config"]["keyfile"]
    )
    print(keepass(sys.argv[1])(), end="")
