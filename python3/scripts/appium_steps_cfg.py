#!/usr/bin/env python
import datetime
import os
import time
from typing import Union

import tpsup.env
import json
import tpsup.csvtools
import tpsup.htmltools
import tpsup.appiumtools
import tpsup.pstools
from pprint import pformat
# from selenium import webdriver
from appium import webdriver


our_cfg = {
    'resources': {
        'appium' : {
            'method': tpsup.appiumtools.get_driver,
            'cfg': {
                # 'host_port': 'auto'
            },
            'init_resource': 0, # we delay the driver init till we really need it.
        },
    },

    # appiumEnv = AppiumEnv(adb_devicename='emulator-5558', host_port='localhost:4723', is_emulator=True)

    # position_args will be inserted into $opt hash to pass forward
    'position_args' : ['adb_devicename', 'host_port'],

    'extra_args' : [
        # argparse's args
        {
            'dest' : 'headless',
            'default' : False,
            'action' : 'store_true',
            'help' : 'run in headless mode',
        },
        {
            'dest' : 'is_emulator',
            'default' : False,
            'action' : 'store_true',
            'help' : 'this is emulator, therefore, auto start it if it is not running',
        },
        {
            'dest' : 'js',
            'default' : False,
            'action' : 'store_true',
            'help' : 'run js'
        },
        {
            'dest' : 'trap',
            'default' : False,
            'action' : 'store_true',
            'help' : 'used with -js, to add try{...}catch{...}',
        },
        {
            'dest' : 'full',
            'default' : False,
            'action' : 'store_true',
            'help' : 'print full xpath in levels, not shortcut, eg. /html/body/... vs id("myinput")',
        },
        {
            'dest' : 'print_console_log',
            'default' : False,
            'action' : 'store_true',
            'help' : 'print js console log',
        },
        {
            'dest': 'limit_depth',
            'default': 5,
            'action': 'store',
            'type': int,
            'help': 'limit scan depth',
        },
        {
            'dest': 'app',
            'default': None,
            'action': 'store',
            'help': 'app_path, /path/app.apk for android or https://app.com/app.ipa for ios',
        },
    ],

    'usage_example' : f'''

    {{{{prog}}}} emulator-5558 localhost:4723 -is_emulator '''
        'home id=com.android.quicksearchbox:id/search_widget_text click '
        'id=com.android.quicksearchbox:id/search_src_text click string=Amazon action=Search '
        'dump_page=%USERPROFILE%/dumpdir2/page_source.html '
        'xpath="//*[@content-desc]" '
        # 'context=webview dump_element=stdout '
        f'''
    
    - test with app
    {{{{prog}}}} emulator-5558 localhost:4723 -is_emulator -v -np -app "%TPSUP%/python3/scripts/test02.apk"
    - if app stuck, 
    adb uninstall org.nativescript.test02ngchallenge
    
    - test webview context
    {{{{prog}}}} emulator-5558 localhost:4723 -is_emulator context=webview
    this is not working yet. we may need to launch an webview app first
    
    '''
    ,


    'show_progress': 1,

    'opt' : {
        # 'humanlike': 1, # slow down a bit, more human-like
        # "browserArgs": ["--disable-notifications"],
    },
}

def code(all_cfg, known, **opt):

    verbose = opt.get('verbose', 0)
    if verbose:
        print(f'from code(), known ={pformat(known)}')
        print(f'from code(), opt = {pformat(opt)}')

    dryrun = opt.get('dryrun', 0)
    run_js = opt.get('js', 0)
    trap = opt.get('trap', 0)

    yyyy, mm, dd = datetime.datetime.now().strftime("%Y,%m,%d").split(',')

    driver: webdriver = all_cfg["resources"]["appium"].get("driver", None)
    if driver is None:
        method = all_cfg["resources"]["appium"]["driver_call"]['method']
        kwargs = all_cfg["resources"]["appium"]["driver_call"]["kwargs"]
        opt2 = {}

        for k in ["verbose", "app"]:
            if v := opt.get(k, None):
                opt2[k] = v

        driver = method(**{**kwargs, "dryrun":0, **opt}) # overwrite kwargs
        all_cfg["resources"]["appium"]["driver"] = driver

    steps = []
    steps = known['REMAININGARGS']
    print(f'steps = {pformat(steps)}')

    result = tpsup.appiumtools.follow(driver, steps, **opt)

def parse_input_sub(input: Union[str, list], all_cfg: dict, **opt):
    return { 'REMAININGARGS' : input }

def post_batch(all_cfg, known, **opt):
    print(f'running post batch')
    driver: webdriver = all_cfg["resources"]["appium"].get("driver", None)
    if driver:
        print('driver.quit()')
        driver.quit()
    else:
        print("driver didn't start.")

    # if tpsup.pstools.prog_running('chromed', printOutput=1):
    #     print(f"seeing leftover chrome")
