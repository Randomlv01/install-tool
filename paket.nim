import os, strutils

proc main() =
  echo "Welche Paketverwaltung nutzt du?"
  echo "1 = apt"
  echo "2 = zypper"
  echo "3 = dnf"
  echo "4 = pacman"
  let manager = readLine(stdin).strip().toLowerAscii()

  if manager notin ["1", "2", "3", "4"]:
    echo "Ungültige Paketverwaltung."
    return

  echo "Welches Paket möchtest du installieren/deinstallieren?"
  let paket = readLine(stdin).strip()

  echo "Was möchtest du"
  echo "1 = das noch nicht vorhandene Paket installieren"
  echo "2 = das vorhandene paket deinstallieren"
  let frage = readLine(stdin).strip()

  if frage notin ["1", "2"]:
    echo "nichts angegeben"
    return

  if paket == "":
    echo "Kein Paketname angegeben."
    return

  var befehl = ""
  if frage == "1":
    case manager
    of "1":
      befehl = "sudo apt install -y " & paket
    of "2":
      befehl = "sudo zypper install -y " & paket
    of "3":
      befehl = "sudo dnf install -y " & paket
    of "4":
      befehl = "sudo pacman -S --noconfirm " & paket
  elif frage == "2":
    case manager
    of "1":
      befehl = "sudo apt remove -y " & paket
    of "2":
      befehl = "sudo zypper remove -y " & paket
    of "3":
      befehl = "sudo dnf remove -y " & paket
    of "4":
      befehl = "sudo pacman -R --noconfirm " & paket

  echo "Führe aus: ", befehl

  let result = execShellCmd(befehl)
  echo result

main()

