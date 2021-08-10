ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Player p1;
ArrayList<ItemDrop> itemDrops = new ArrayList<ItemDrop>();
//ArrayList<StationaryObject> objects = new ArrayList<StationaryObject>();
//ArrayList<Rock> rocks = new ArrayList<Rock>();
GameWorld gw;
Menu craftMenu;

int timer = 0;

int numEnemies = 1;
int numRocks = 5;

//Map states
int repositionState;
final int LEFT_OF_SCREEN = 1;
final int RIGHT_OF_SCREEN = 2;
final int TOP_OF_SCREEN = 3;
final int BOTTOM_OF_SCREEN = 4;
//Which exits are existing
boolean leftExit = true;
boolean rightExit = true;
boolean topExit = true;
boolean botExit = true;

int[][] state = {
                {1, 2, 3},
                {4, 5, 6},
                {7, 8, 9}
              };

final int LEVEL_ONE_ONE = 1;
final int LEVEL_ONE_TWO = 2;
final int LEVEL_ONE_THREE = 3;
final int LEVEL_TWO_ONE = 4;
final int LEVEL_TWO_TWO = 5;
final int LEVEL_TWO_THREE = 6;
final int LEVEL_THREE_ONE = 7;
final int LEVEL_THREE_TWO = 8;
final int LEVEL_THREE_THREE = 9;

int row = 1;
int column = 0;
boolean switchLevel = false;

//Materials
final int IRON_BAR = 11;
final int GOLD_BAR = 12;

//Item drops
final int STONE = 9;
final int ENEMY_SOUL_DROP = 10;

//Ore types
final int COAL = 1;
final int IRON = 2;
final int GOLD = 3;
