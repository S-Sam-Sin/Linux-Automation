#!/usr/bin/python3.5
import ephem
import sys


class Moon:

    def __init__(self, moonphase, date):
        self.info_pass = ""
        if moonphase == "full":
             self.moon = ephem.next_full_moon(date)
        elif moonphase == "new":
            self.moon = ephem.next_new_moon(date)
        elif moonphase == "first_quarter":
            self.moon = ephem.next_first_quarter_moon(date)
        elif moonphase == "last_quarter":
            self.moon = ephem.next_last_quarter_moon(date)

    def GetMoon(self):
        print(self.moon)
info = Moon(sys.argv[1], sys.argv[2])
info.GetMoon()
