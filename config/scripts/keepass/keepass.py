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
            "otp": TOTP(obj.custom_properties["OTP"]).now() if "OTP" in obj.custom_properties else ""
        }.get(sys.argv[3], "")
    else:
        return obj


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
