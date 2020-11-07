package visnov;

import rm.Globals;
import rm.objects.Game_Interpreter as RmGame_Interpreter;

class GameInterpreter extends RmGame_Interpreter {
  // Disable All
  public function command681() {
    Globals.GameSystem.disableEncounter();
    Globals.GameSystem.disableFormation();
    Globals.GameSystem.disableMenu();
    Globals.GameSystem.disableSave();
    return true;
  }

  public function command682() {
    Globals.GameSystem.enableEncounter();
    Globals.GameSystem.enableFormation();
    Globals.GameSystem.enableMenu();
    Globals.GameSystem.enableSave();
    return true;
  }
}
