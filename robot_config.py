from os import environ
from RPA.Robocloud.Items import Items


def get_config(expr):
    try:
        lib = Items()
        lib.load_work_item_from_environment()
        root = lib.get_work_item_variables()
        root["env"] = dict(environ.items())
        return eval(expr, {"__builtins__": None}, root)
    except:
        return expr
