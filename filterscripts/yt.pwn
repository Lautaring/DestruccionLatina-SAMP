/* ___________________________________________________________________
|                                                                  |
|                         SA- TUBE V1.0 BY                         |
|               ____            ____         ___                   |
|				|___ U N K Y	  |  HE 	|  __ R E A T          |
|               |                 |         |___|                  |
|__________________________________________________________________|*/
#include <a_samp>
#include <zcmd>
#include <a_http>

#define DIALOG_TUBE 69
#define MAX_TDS 77
#define mred "{ff0000}"
#define mcol "{c0ff5c}"

new Text:TUBE_TD[77];
new PlayerText:TUBE_PTD[MAX_PLAYERS][2];
enum YTINFO
{
	MUSICNAME[30],
	LINK[100]
};
// Total musics are 27, You can add your desire musics as well !
new MUSICLIST[][YTINFO] =
{
	{"Despacito","www.youtube.com/watch?v=kJQP7kiw5Fk"},
	{"See You Again","www.youtube.com/watch?v=nUHoGNK98s8"},
	{"Gangnam Style","www.youtube.com/watch?v=NeLnqJGhq_Q"},
	{"Sorry","www.youtube.com/watch?v=rBistsB7pNU"},
	{"Shake It Off","www.youtube.com/watch?v=nfWlot6h_JM"},
	{"Bailando","www.youtube.com/watch?v=DkBMWBI6KQs"},
	{"Sugar","www.youtube.com/watch?v=48VSP-atSeI"},
	{"Roar","www.youtube.com/watch?v=CevxZvSJLk8"},
	{"Shape Of You","www.youtube.com/watch?v=JGwWNGJdvx8"},
	{"Lean On","www.youtube.com/watch?v=YqeW9_5kURI"},
	{"Blank Space","www.youtube.com/watch?v=e-ORhEE9VVg"},
	{"About that Base","www.youtube.com/watch?v=7PCkvCPvDXk"},
	{"Dark Horse","www.youtube.com/watch?v=0KSOMA3QBU0"},
	{"Hello","www.youtube.com/watch?v=9h0Arg_-380"},
	{"Counting Stars","www.youtube.com/watch?v=hT_nvWreIhg"},
	{"Thinking Out Loud","www.youtube.com/watch?v=JbEkxVVxk4c"},
	{"What do you mean","www.youtube.com/watch?v=NywWB67Z7zQ"},
	{"This is what you came for","www.youtube.com/watch?v=kOkQ4T5WO9E"},
	{"Chantaje","www.youtube.com/watch?v=6Mgqbai3fKo"},
	{"Chandelier","www.youtube.com/watch?v=2vjPBrBU-TM"},
	{"Love me like you do","www.youtube.com/watch?v=AJtDXIazrMo"},
	{"Rockabye","www.youtube.com/watch?v=papuvlVeZg8"},
	{"Last Friday Night","www.youtube.com/watch?v=KlyXNRrsk4A"},
	{"Thrift Shop","www.youtube.com/watch?v=QK8mJJJvaes"},
	{"Look What you made me to","www.youtube.com/watch?v=3tmd-ClpJxA"},
	{"Bon Appetit","www.youtube.com/watch?v=EVhhiqp3S2Q"},
	{"Swish Swish","www.youtube.com/watch?v=EW6rhjSqZ14"}
//	{"VIDEO NAME","YOUTUBE VIDEO LINK"} // add Comma " , " in the upper one , don't add comma in the last line
};
public OnFilterScriptInit()
{
	CREATETUBE();
	print("\n--------------------------------------");
 	print(" SA-TUBE FILTERSCRIPT BY FUNKYTHEGREAT");
 	print(" -------- LOADED SUCCESFULLY --------");
  	print("--------------------------------------\n");
   	return 1;
}
public OnFilterScriptExit()
{
	print("\n--------------------------------------");
 	print(" SA-TUBE FILTERSCRIPT BY FUNKYTHEGREAT");
 	print(" ------ UN-LOADED SUCCESFULLY --------");
  	print("--------------------------------------\n");
   	return 1;
}
CREATETUBE()
{
	TUBE_TD[0] = TextDrawCreate(-9.375000, -12.999997, "box");
	TextDrawLetterSize(TUBE_TD[0], 0.000000, 48.562500);
	TextDrawTextSize(TUBE_TD[0], 649.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[0], 1);
	TextDrawColor( TUBE_TD[0], -1);
	TextDrawUseBox(TUBE_TD[0], 1);
	TextDrawBoxColor(TUBE_TD[0], -1);
	TextDrawSetShadow(TUBE_TD[0], 0);
	TextDrawSetOutline(TUBE_TD[0], 0);
	TextDrawBackgroundColor(TUBE_TD[0], 255);
	TextDrawFont(TUBE_TD[0], 1);
	TextDrawSetProportional( TUBE_TD[0], 1);
	TextDrawSetShadow(TUBE_TD[0], 0);

	TUBE_TD[1] = TextDrawCreate(1.875000, 2.750000, "O");
	TextDrawLetterSize(TUBE_TD[1], 0.623124, 1.214998);
	TextDrawTextSize(TUBE_TD[1], 643.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[1], 1);
	TextDrawColor( TUBE_TD[1], 255);
	TextDrawUseBox(TUBE_TD[1], 1);
	TextDrawBoxColor(TUBE_TD[1], -1);
	TextDrawSetShadow(TUBE_TD[1], 0);
	TextDrawSetOutline(TUBE_TD[1], 1);
	TextDrawBackgroundColor(TUBE_TD[1], -1061109505);
	TextDrawFont(TUBE_TD[1], 0);
	TextDrawSetProportional( TUBE_TD[1], 1);
	TextDrawSetShadow(TUBE_TD[1], 0);

	TUBE_TD[2] = TextDrawCreate(-6.250000, 18.333341, "box");
	TextDrawLetterSize(TUBE_TD[2], 0.000000, 3.125000);
	TextDrawTextSize(TUBE_TD[2], 631.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[2], 1);
	TextDrawColor( TUBE_TD[2], -1);
	TextDrawUseBox(TUBE_TD[2], 1);
	TextDrawBoxColor(TUBE_TD[2], -1);
	TextDrawSetShadow(TUBE_TD[2], 0);
	TextDrawSetOutline(TUBE_TD[2], 0);
	TextDrawBackgroundColor(TUBE_TD[2], 255);
	TextDrawFont(TUBE_TD[2], 1);
	TextDrawSetProportional( TUBE_TD[2], 1);
	TextDrawSetShadow(TUBE_TD[2], 0);

	TUBE_TD[72] = TextDrawCreate(622.500000, 1.116677, "");
	TextDrawLetterSize(TUBE_TD[72], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[72], 16.000000, 14.000000);
	TextDrawAlignment(TUBE_TD[72], 1);
	TextDrawColor( TUBE_TD[72], -16776961);
	TextDrawSetShadow(TUBE_TD[72], 0);
	TextDrawSetOutline(TUBE_TD[72], 0);
	TextDrawBackgroundColor(TUBE_TD[72], -1);
	TextDrawFont(TUBE_TD[72], 5);
	TextDrawSetProportional( TUBE_TD[72], 0);
	TextDrawSetShadow(TUBE_TD[72], 0);
	TextDrawSetSelectable( TUBE_TD[72], true);
	TextDrawSetPreviewModel(TUBE_TD[72], 19379);
	TextDrawSetPreviewRot(TUBE_TD[72], 0.000000, 0.000000, 90.000000, 1.000000);

	TUBE_TD[3] = TextDrawCreate(625.875244, 2.266666, "X");
	TextDrawLetterSize(TUBE_TD[3], 0.373124, 1.098333);
	TextDrawAlignment(TUBE_TD[3], 1);
	TextDrawColor( TUBE_TD[3], -1);
	TextDrawSetShadow(TUBE_TD[3], 0);
	TextDrawSetOutline(TUBE_TD[3], 0);
	TextDrawBackgroundColor(TUBE_TD[3], 255);
	TextDrawFont(TUBE_TD[3], 2);
	TextDrawSetProportional( TUBE_TD[3], 1);
	TextDrawSetShadow(TUBE_TD[3], 0);

	TUBE_TD[4] = TextDrawCreate(-1.250000, 22.350008, "box");
	TextDrawLetterSize(TUBE_TD[4], 0.000000, -0.437500);
	TextDrawTextSize(TUBE_TD[4], 660.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[4], 1);
	TextDrawColor( TUBE_TD[4], -1);
	TextDrawUseBox(TUBE_TD[4], 1);
	TextDrawBoxColor(TUBE_TD[4], 255);
	TextDrawSetShadow(TUBE_TD[4], 0);
	TextDrawSetOutline(TUBE_TD[4], 0);
	TextDrawBackgroundColor(TUBE_TD[4], 255);
	TextDrawFont(TUBE_TD[4], 2);
	TextDrawSetProportional( TUBE_TD[4], 1);
	TextDrawSetShadow(TUBE_TD[4], 0);

	TUBE_TD[5] = TextDrawCreate(116.875000, 2.166666, "FuNkY's Browser");
	TextDrawLetterSize(TUBE_TD[5], 0.336248, 1.413333);
	TextDrawAlignment(TUBE_TD[5], 3);
	TextDrawColor( TUBE_TD[5], 255);
	TextDrawSetShadow(TUBE_TD[5], 0);
	TextDrawSetOutline(TUBE_TD[5], 1);
	TextDrawBackgroundColor(TUBE_TD[5], -1061109505);
	TextDrawFont(TUBE_TD[5], 1);
	TextDrawSetProportional( TUBE_TD[5], 1);
	TextDrawSetShadow(TUBE_TD[5], 0);

	TUBE_TD[6] = TextDrawCreate(201.875000, 22.000000, "SEARCH -    SA-MPTUBE.COM/AUDIO=FBROWSER");
	TextDrawLetterSize(TUBE_TD[6], 0.204998, 1.004999);
	TextDrawAlignment(TUBE_TD[6], 3);
	TextDrawColor( TUBE_TD[6], 255);
	TextDrawSetShadow(TUBE_TD[6], 0);
	TextDrawSetOutline(TUBE_TD[6], 0);
	TextDrawBackgroundColor(TUBE_TD[6], 255);
	TextDrawFont(TUBE_TD[6], 2);
	TextDrawSetProportional( TUBE_TD[6], 1);
	TextDrawSetShadow(TUBE_TD[6], 0);

	TUBE_TD[7] = TextDrawCreate(-5.000000, 40.449985, "box");
	TextDrawLetterSize(TUBE_TD[7], 0.000000, -1.000000);
	TextDrawTextSize(TUBE_TD[7], 653.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[7], 1);
	TextDrawColor( TUBE_TD[7], -1);
	TextDrawUseBox(TUBE_TD[7], 1);
	TextDrawBoxColor(TUBE_TD[7], 255);
	TextDrawSetShadow(TUBE_TD[7], 0);
	TextDrawSetOutline(TUBE_TD[7], 0);
	TextDrawBackgroundColor(TUBE_TD[7], 255);
	TextDrawFont(TUBE_TD[7], 1);
	TextDrawSetProportional( TUBE_TD[7], 1);
	TextDrawSetShadow(TUBE_TD[7], 0);

	TUBE_TD[8] = TextDrawCreate(2.500000, 39.316650, "] SA-MP TUBE - NOW PLAYING AUDIO");
	TextDrawLetterSize(TUBE_TD[8], 0.240621, 0.759998);
	TextDrawTextSize(TUBE_TD[8], 643.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[8], 1);
	TextDrawColor( TUBE_TD[8], 255);
	TextDrawUseBox(TUBE_TD[8], 1);
	TextDrawBoxColor(TUBE_TD[8], -1);
	TextDrawSetShadow(TUBE_TD[8], 0);
	TextDrawSetOutline(TUBE_TD[8], 0);
	TextDrawBackgroundColor(TUBE_TD[8], -1061109505);
	TextDrawFont(TUBE_TD[8], 2);
	TextDrawSetProportional( TUBE_TD[8], 1);
	TextDrawSetShadow(TUBE_TD[8], 0);

	TUBE_TD[9] = TextDrawCreate(-13.125000, 53.650005, "box");
	TextDrawLetterSize(TUBE_TD[9], 0.000000, 44.625000);
	TextDrawTextSize(TUBE_TD[9], 650.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[9], 1);
	TextDrawColor( TUBE_TD[9], -1);
	TextDrawUseBox(TUBE_TD[9], 1);
	TextDrawBoxColor(TUBE_TD[9], -1);
	TextDrawSetShadow(TUBE_TD[9], 0);
	TextDrawSetOutline(TUBE_TD[9], 0);
	TextDrawBackgroundColor(TUBE_TD[9], 255);
	TextDrawFont(TUBE_TD[9], 2);
	TextDrawSetProportional( TUBE_TD[9], 1);
	TextDrawSetShadow(TUBE_TD[9], 0);

	TUBE_TD[10] = TextDrawCreate(8.125000, 65.750022, "-");
	TextDrawLetterSize(TUBE_TD[10], 0.790247, -0.435833);
	TextDrawAlignment(TUBE_TD[10], 1);
	TextDrawColor( TUBE_TD[10], 255);
	TextDrawSetShadow(TUBE_TD[10], 0);
	TextDrawSetOutline(TUBE_TD[10], 5);
	TextDrawBackgroundColor(TUBE_TD[10], 255);
	TextDrawFont(TUBE_TD[10], 1);
	TextDrawSetProportional( TUBE_TD[10], 1);
	TextDrawSetShadow(TUBE_TD[10], 0);

	TUBE_TD[11] = TextDrawCreate(105.625000, 49.416690, "SA Tube");
	TextDrawLetterSize(TUBE_TD[11], 0.435247, 2.906682);
	TextDrawAlignment(TUBE_TD[11], 3);
	TextDrawColor( TUBE_TD[11], 255);
	TextDrawSetShadow(TUBE_TD[11], 0);
	TextDrawSetOutline(TUBE_TD[11], 0);
	TextDrawBackgroundColor(TUBE_TD[11], 255);
	TextDrawFont(TUBE_TD[11], 2);
	TextDrawSetProportional( TUBE_TD[11], 1);
	TextDrawSetShadow(TUBE_TD[11], 0);

	TUBE_TD[12] = TextDrawCreate(60.625000, 58.166652, "box");
	TextDrawLetterSize(TUBE_TD[12], 0.014374, 1.334997);
	TextDrawTextSize(TUBE_TD[12], 107.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[12], 1);
	TextDrawColor( TUBE_TD[12], -1);
	TextDrawUseBox(TUBE_TD[12], 1);
	TextDrawBoxColor(TUBE_TD[12], -16776961);
	TextDrawSetShadow(TUBE_TD[12], 0);
	TextDrawSetOutline(TUBE_TD[12], 0);
	TextDrawBackgroundColor(TUBE_TD[12], 255);
	TextDrawFont(TUBE_TD[12], 1);
	TextDrawSetProportional( TUBE_TD[12], 1);
	TextDrawSetShadow(TUBE_TD[12], 0);

	TUBE_TD[13] = TextDrawCreate(182.500000, 57.583358, "BOX");
	TextDrawLetterSize(TUBE_TD[13], 0.330624, 1.415832);
	TextDrawTextSize(TUBE_TD[13], 436.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[13], 1);
	TextDrawColor( TUBE_TD[13], 255);
	TextDrawUseBox(TUBE_TD[13], 1);
	TextDrawBoxColor(TUBE_TD[13], -2139062017);
	TextDrawSetShadow(TUBE_TD[13], 0);
	TextDrawSetOutline(TUBE_TD[13], 0);
	TextDrawBackgroundColor(TUBE_TD[13], 255);
	TextDrawFont(TUBE_TD[13], 2);
	TextDrawSetProportional( TUBE_TD[13], 1);
	TextDrawSetShadow(TUBE_TD[13], 0);

	TUBE_TD[14] = TextDrawCreate(10.000000, 93.749984, "box");
	TextDrawLetterSize(TUBE_TD[14], 0.000000, 19.375000);
	TextDrawTextSize(TUBE_TD[14], 333.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[14], 1);
	TextDrawColor( TUBE_TD[14], 255);
	TextDrawUseBox(TUBE_TD[14], 1);
	TextDrawBoxColor(TUBE_TD[14], 255);
	TextDrawSetShadow(TUBE_TD[14], 0);
	TextDrawSetOutline(TUBE_TD[14], 0);
	TextDrawBackgroundColor(TUBE_TD[14], 255);
	TextDrawFont(TUBE_TD[14], 1);
	TextDrawSetProportional( TUBE_TD[14], 1);
	TextDrawSetShadow(TUBE_TD[14], 0);

	TUBE_TD[15] = TextDrawCreate(572.974731, 55.299980, "LD_BEAT:up");
	TextDrawLetterSize(TUBE_TD[15], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[15], 12.000000, 11.000000);
	TextDrawAlignment(TUBE_TD[15], 1);
	TextDrawColor( TUBE_TD[15], 255);
	TextDrawSetShadow(TUBE_TD[15], 0);
	TextDrawSetOutline(TUBE_TD[15], 0);
	TextDrawBackgroundColor(TUBE_TD[15], 255);
	TextDrawFont(TUBE_TD[15], 4);
	TextDrawSetProportional( TUBE_TD[15], 0);
	TextDrawSetShadow(TUBE_TD[15], 0);

	TUBE_TD[16] = TextDrawCreate(366.125000, 162.033264, "loadsc1:loadsc1");
	TextDrawLetterSize(TUBE_TD[16], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[16], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[16], 1);
	TextDrawColor( TUBE_TD[16], -1);
	TextDrawSetShadow(TUBE_TD[16], 0);
	TextDrawSetOutline(TUBE_TD[16], 0);
	TextDrawBackgroundColor(TUBE_TD[16], 255);
	TextDrawFont(TUBE_TD[16], 4);
	TextDrawSetProportional( TUBE_TD[16], 0);
	TextDrawSetShadow(TUBE_TD[16], 0);

	TUBE_TD[17] = TextDrawCreate(367.174987, 244.316757, "loadsc3:loadsc3");
	TextDrawLetterSize(TUBE_TD[17], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[17], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[17], 1);
	TextDrawColor( TUBE_TD[17], -1);
	TextDrawSetShadow(TUBE_TD[17], 0);
	TextDrawSetOutline(TUBE_TD[17], 0);
	TextDrawBackgroundColor(TUBE_TD[17], 255);
	TextDrawFont(TUBE_TD[17], 4);
	TextDrawSetProportional( TUBE_TD[17], 0);
	TextDrawSetShadow(TUBE_TD[17], 0);

	TUBE_TD[18] = TextDrawCreate(368.549957, 319.550384, "loadsc4:loadsc4");
	TextDrawLetterSize(TUBE_TD[18], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[18], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[18], 1);
	TextDrawColor( TUBE_TD[18], -1);
	TextDrawSetShadow(TUBE_TD[18], 0);
	TextDrawSetOutline(TUBE_TD[18], 0);
	TextDrawBackgroundColor(TUBE_TD[18], 255);
	TextDrawFont(TUBE_TD[18], 4);
	TextDrawSetProportional( TUBE_TD[18], 0);
	TextDrawSetShadow(TUBE_TD[18], 0);

	TUBE_TD[19] = TextDrawCreate(613.750000, 59.333343, "SIGN IN");
	TextDrawLetterSize(TUBE_TD[19], 0.166875, 0.860831);
	TextDrawTextSize(TUBE_TD[19], 0.000000, 31.000000);
	TextDrawAlignment(TUBE_TD[19], 2);
	TextDrawColor( TUBE_TD[19], -1);
	TextDrawUseBox(TUBE_TD[19], 1);
	TextDrawBoxColor(TUBE_TD[19], 65535);
	TextDrawSetShadow(TUBE_TD[19], 0);
	TextDrawSetOutline(TUBE_TD[19], 0);
	TextDrawBackgroundColor(TUBE_TD[19], 255);
	TextDrawFont(TUBE_TD[19], 2);
	TextDrawSetProportional( TUBE_TD[19], 1);
	TextDrawSetShadow(TUBE_TD[19], 0);

	TUBE_TD[20] = TextDrawCreate(366.125000, 169.333709, "loadsc1:loadsc1");
	TextDrawLetterSize(TUBE_TD[20], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[20], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[20], 1);
	TextDrawColor( TUBE_TD[20], -1);
	TextDrawSetShadow(TUBE_TD[20], 0);
	TextDrawSetOutline(TUBE_TD[20], 0);
	TextDrawBackgroundColor(TUBE_TD[20], 255);
	TextDrawFont(TUBE_TD[20], 4);
	TextDrawSetProportional( TUBE_TD[20], 0);
	TextDrawSetShadow(TUBE_TD[20], 0);

	TUBE_TD[21] = TextDrawCreate(572.500122, 58.200012, "-");
	TextDrawLetterSize(TUBE_TD[21], 1.009374, 1.588333);
	TextDrawAlignment(TUBE_TD[21], 1);
	TextDrawColor( TUBE_TD[21], -2139062017);
	TextDrawSetShadow(TUBE_TD[21], 0);
	TextDrawSetOutline(TUBE_TD[21], 0);
	TextDrawBackgroundColor(TUBE_TD[21], 255);
	TextDrawFont(TUBE_TD[21], 1);
	TextDrawSetProportional( TUBE_TD[21], 1);
	TextDrawSetShadow(TUBE_TD[21], 0);

	TUBE_TD[22] = TextDrawCreate(7.000000, 91.000000, "loadsc2:loadsc2");
	TextDrawLetterSize(TUBE_TD[22], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[22], 328.120117, 167.000000);
	TextDrawAlignment(TUBE_TD[22], 1);
	TextDrawColor( TUBE_TD[22], -1);
	TextDrawSetShadow(TUBE_TD[22], 0);
	TextDrawSetOutline(TUBE_TD[22], 0);
	TextDrawBackgroundColor(TUBE_TD[22], 255);
	TextDrawFont(TUBE_TD[22], 4);
	TextDrawSetProportional( TUBE_TD[22], 0);
	TextDrawSetShadow(TUBE_TD[22], 0);

	TUBE_TD[24] = TextDrawCreate(337.199951, 286.000000, "10,000,000 VIEWS");
	TextDrawLetterSize(TUBE_TD[24], 0.268747, 1.349166);
	TextDrawAlignment(TUBE_TD[24], 3);
	TextDrawColor( TUBE_TD[24], 255);
	TextDrawSetShadow(TUBE_TD[24], 0);
	TextDrawSetOutline(TUBE_TD[24], 0);
	TextDrawBackgroundColor(TUBE_TD[24], 255);
	TextDrawFont(TUBE_TD[24], 2);
	TextDrawSetProportional( TUBE_TD[24], 1);
	TextDrawSetShadow(TUBE_TD[24], 0);

	TUBE_TD[25] = TextDrawCreate(235.000000, 303.000000, "box");
	TextDrawLetterSize(TUBE_TD[25], 0.000000, -0.187500);
	TextDrawTextSize(TUBE_TD[25], 318.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[25], 1);
	TextDrawColor( TUBE_TD[25], -1);
	TextDrawUseBox(TUBE_TD[25], 1);
	TextDrawBoxColor(TUBE_TD[25], 5821439);
	TextDrawSetShadow(TUBE_TD[25], 0);
	TextDrawSetOutline(TUBE_TD[25], 0);
	TextDrawBackgroundColor(TUBE_TD[25], 255);
	TextDrawFont(TUBE_TD[25], 1);
	TextDrawSetProportional( TUBE_TD[25], 1);
	TextDrawSetShadow(TUBE_TD[25], 0);

	TUBE_TD[26] = TextDrawCreate(290.900054, 303.000000, "box");
	TextDrawLetterSize(TUBE_TD[26], 0.000000, -0.194499);
	TextDrawTextSize(TUBE_TD[26], 317.900054, 0.000000);
	TextDrawAlignment(TUBE_TD[26], 1);
	TextDrawColor( TUBE_TD[26], -1);
	TextDrawUseBox(TUBE_TD[26], 1);
	TextDrawBoxColor(TUBE_TD[26], -1061109505);
	TextDrawSetShadow(TUBE_TD[26], 0);
	TextDrawSetOutline(TUBE_TD[26], 0);
	TextDrawBackgroundColor(TUBE_TD[26], 255);
	TextDrawFont(TUBE_TD[26], 1);
	TextDrawSetProportional( TUBE_TD[26], 1);
	TextDrawSetShadow(TUBE_TD[26], 0);

	TUBE_TD[27] = TextDrawCreate(369.450012, 402.666778, "loadsc7:loadsc7");
	TextDrawLetterSize(TUBE_TD[27], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[27], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[27], 1);
	TextDrawColor( TUBE_TD[27], -1);
	TextDrawSetShadow(TUBE_TD[27], 0);
	TextDrawSetOutline(TUBE_TD[27], 0);
	TextDrawBackgroundColor(TUBE_TD[27], 255);
	TextDrawFont(TUBE_TD[27], 4);
	TextDrawSetProportional( TUBE_TD[27], 0);
	TextDrawSetShadow(TUBE_TD[27], 0);

	TUBE_TD[28] = TextDrawCreate(365.400146, 91.333320, "loadsc13:loadsc13");
	TextDrawLetterSize(TUBE_TD[28], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[28], 117.000000, 67.000000);
	TextDrawAlignment(TUBE_TD[28], 1);
	TextDrawColor( TUBE_TD[28], -1);
	TextDrawSetShadow(TUBE_TD[28], 0);
	TextDrawSetOutline(TUBE_TD[28], 0);
	TextDrawBackgroundColor(TUBE_TD[28], 255);
	TextDrawFont(TUBE_TD[28], 4);
	TextDrawSetProportional( TUBE_TD[28], 0);
	TextDrawSetShadow(TUBE_TD[28], 0);

	TUBE_TD[29] = TextDrawCreate(555.000000, 121.750022, "IN SAN ANDREAS");
	TextDrawLetterSize(TUBE_TD[29], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[29], 3);
	TextDrawColor( TUBE_TD[29], 255);
	TextDrawSetShadow(TUBE_TD[29], 0);
	TextDrawSetOutline(TUBE_TD[29], 0);
	TextDrawBackgroundColor(TUBE_TD[29], 255);
	TextDrawFont(TUBE_TD[29], 2);
	TextDrawSetProportional( TUBE_TD[29], 1);
	TextDrawSetShadow(TUBE_TD[29], 0);

	TUBE_TD[30] = TextDrawCreate(568.750000, 111.833351, "TOP 10 RICHEST MAN");
	TextDrawLetterSize(TUBE_TD[30], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[30], 3);
	TextDrawColor( TUBE_TD[30], 255);
	TextDrawSetShadow(TUBE_TD[30], 0);
	TextDrawSetOutline(TUBE_TD[30], 0);
	TextDrawBackgroundColor(TUBE_TD[30], 255);
	TextDrawFont(TUBE_TD[30], 2);
	TextDrawSetProportional( TUBE_TD[30], 1);
	TextDrawSetShadow(TUBE_TD[30], 0);

	TUBE_TD[31] = TextDrawCreate(8.625000, 295.616638, "LD_TATT:10weed");
	TextDrawLetterSize(TUBE_TD[31], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[31], 39.000000, 37.000000);
	TextDrawAlignment(TUBE_TD[31], 1);
	TextDrawColor( TUBE_TD[31], 16711828);
	TextDrawSetShadow(TUBE_TD[31], 0);
	TextDrawSetOutline(TUBE_TD[31], 0);
	TextDrawBackgroundColor(TUBE_TD[31], 255);
	TextDrawFont(TUBE_TD[31], 4);
	TextDrawSetProportional( TUBE_TD[31], 0);
	TextDrawSetShadow(TUBE_TD[31], 0);

	TUBE_TD[32] = TextDrawCreate(52.500000, 296.083343, "FuNkYTheGreat");
	TextDrawLetterSize(TUBE_TD[32], 0.245624, 1.279165);
	TextDrawAlignment(TUBE_TD[32], 1);
	TextDrawColor( TUBE_TD[32], 255);
	TextDrawSetShadow(TUBE_TD[32], 0);
	TextDrawSetOutline(TUBE_TD[32], 0);
	TextDrawBackgroundColor(TUBE_TD[32], 255);
	TextDrawFont(TUBE_TD[32], 2);
	TextDrawSetProportional( TUBE_TD[32], 1);
	TextDrawSetShadow(TUBE_TD[32], 0);

	TUBE_TD[33] = TextDrawCreate(55.000000, 313.666687, "SUBSCRIBE");
	TextDrawLetterSize(TUBE_TD[33], 0.219374, 1.094998);
	TextDrawTextSize(TUBE_TD[33], 102.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[33], 1);
	TextDrawColor( TUBE_TD[33], -1);
	TextDrawUseBox(TUBE_TD[33], 1);
	TextDrawBoxColor(TUBE_TD[33], -16776961);
	TextDrawSetShadow(TUBE_TD[33], 0);
	TextDrawSetOutline(TUBE_TD[33], 0);
	TextDrawBackgroundColor(TUBE_TD[33], 255);
	TextDrawFont(TUBE_TD[33], 2);
	TextDrawSetProportional( TUBE_TD[33], 1);
	TextDrawSetShadow(TUBE_TD[33], 0);

	TUBE_TD[34] = TextDrawCreate(107.050025, 313.666625, "100k");
	TextDrawLetterSize(TUBE_TD[34], 0.219374, 1.094998);
	TextDrawTextSize(TUBE_TD[34], 127.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[34], 1);
	TextDrawColor( TUBE_TD[34], 255);
	TextDrawUseBox(TUBE_TD[34], 1);
	TextDrawBoxColor(TUBE_TD[34], -1061109505);
	TextDrawSetShadow(TUBE_TD[34], 0);
	TextDrawSetOutline(TUBE_TD[34], 0);
	TextDrawBackgroundColor(TUBE_TD[34], 255);
	TextDrawFont(TUBE_TD[34], 2);
	TextDrawSetProportional( TUBE_TD[34], 1);
	TextDrawSetShadow(TUBE_TD[34], 0);

	TUBE_TD[35] = TextDrawCreate(322.024932, 304.649993, "Like 201k  Dislike 20k");
	TextDrawLetterSize(TUBE_TD[35], 0.189373, 1.057499);
	TextDrawAlignment(TUBE_TD[35], 3);
	TextDrawColor( TUBE_TD[35], 255);
	TextDrawSetShadow(TUBE_TD[35], 0);
	TextDrawSetOutline(TUBE_TD[35], 0);
	TextDrawBackgroundColor(TUBE_TD[35], 255);
	TextDrawFont(TUBE_TD[35], 2);
	TextDrawSetProportional( TUBE_TD[35], 1);
	TextDrawSetShadow(TUBE_TD[35], 0);

	TUBE_TD[36] = TextDrawCreate(526.174560, 131.749969, "By SA-NEWS");
	TextDrawLetterSize(TUBE_TD[36], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[36], 3);
	TextDrawColor( TUBE_TD[36], 255);
	TextDrawSetShadow(TUBE_TD[36], 0);
	TextDrawSetOutline(TUBE_TD[36], 0);
	TextDrawBackgroundColor(TUBE_TD[36], 255);
	TextDrawFont(TUBE_TD[36], 2);
	TextDrawSetProportional( TUBE_TD[36], 1);
	TextDrawSetShadow(TUBE_TD[36], 0);

	TUBE_TD[37] = TextDrawCreate(542.524536, 137.983322, "1,310,031 Views");
	TextDrawLetterSize(TUBE_TD[37], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[37], 3);
	TextDrawColor( TUBE_TD[37], 255);
	TextDrawSetShadow(TUBE_TD[37], 0);
	TextDrawSetOutline(TUBE_TD[37], 0);
	TextDrawBackgroundColor(TUBE_TD[37], 255);
	TextDrawFont(TUBE_TD[37], 2);
	TextDrawSetProportional( TUBE_TD[37], 1);
	TextDrawSetShadow(TUBE_TD[37], 0);

	TUBE_TD[38] = TextDrawCreate(558.024414, 184.750030, "GANGSTER'S IN LS");
	TextDrawLetterSize(TUBE_TD[38], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[38], 3);
	TextDrawColor( TUBE_TD[38], 255);
	TextDrawSetShadow(TUBE_TD[38], 0);
	TextDrawSetOutline(TUBE_TD[38], 0);
	TextDrawBackgroundColor(TUBE_TD[38], 255);
	TextDrawFont(TUBE_TD[38], 2);
	TextDrawSetProportional( TUBE_TD[38], 1);
	TextDrawSetShadow(TUBE_TD[38], 0);

	TUBE_TD[39] = TextDrawCreate(554.899414, 194.083374, "(FULL MOVIE HD)");
	TextDrawLetterSize(TUBE_TD[39], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[39], 3);
	TextDrawColor( TUBE_TD[39], 255);
	TextDrawSetShadow(TUBE_TD[39], 0);
	TextDrawSetOutline(TUBE_TD[39], 0);
	TextDrawBackgroundColor(TUBE_TD[39], 255);
	TextDrawFont(TUBE_TD[39], 2);
	TextDrawSetProportional( TUBE_TD[39], 1);
	TextDrawSetShadow(TUBE_TD[39], 0);

	TUBE_TD[40] = TextDrawCreate(531.799560, 203.699981, "BY MOVIE_GUY");
	TextDrawLetterSize(TUBE_TD[40], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[40], 3);
	TextDrawColor( TUBE_TD[40], 255);
	TextDrawSetShadow(TUBE_TD[40], 0);
	TextDrawSetOutline(TUBE_TD[40], 0);
	TextDrawBackgroundColor(TUBE_TD[40], 255);
	TextDrawFont(TUBE_TD[40], 2);
	TextDrawSetProportional( TUBE_TD[40], 1);
	TextDrawSetShadow(TUBE_TD[40], 0);

	TUBE_TD[41] = TextDrawCreate(552.974731, 210.899963, "25,300,404 VIEWS");
	TextDrawLetterSize(TUBE_TD[41], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[41], 3);
	TextDrawColor( TUBE_TD[41], 255);
	TextDrawSetShadow(TUBE_TD[41], 0);
	TextDrawSetOutline(TUBE_TD[41], 0);
	TextDrawBackgroundColor(TUBE_TD[41], 255);
	TextDrawFont(TUBE_TD[41], 2);
	TextDrawSetProportional( TUBE_TD[41], 1);
	TextDrawSetShadow(TUBE_TD[41], 0);

	TUBE_TD[42] = TextDrawCreate(558.024414, 263.500152, "SHOOT OUT IN LV");
	TextDrawLetterSize(TUBE_TD[42], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[42], 3);
	TextDrawColor( TUBE_TD[42], 255);
	TextDrawSetShadow(TUBE_TD[42], 0);
	TextDrawSetOutline(TUBE_TD[42], 0);
	TextDrawBackgroundColor(TUBE_TD[42], 255);
	TextDrawFont(TUBE_TD[42], 2);
	TextDrawSetProportional( TUBE_TD[42], 1);
	TextDrawSetShadow(TUBE_TD[42], 0);

	TUBE_TD[43] = TextDrawCreate(558.649414, 272.833465, "3 SUSPECT DIED");
	TextDrawLetterSize(TUBE_TD[43], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[43], 3);
	TextDrawColor( TUBE_TD[43], 255);
	TextDrawSetShadow(TUBE_TD[43], 0);
	TextDrawSetOutline(TUBE_TD[43], 0);
	TextDrawBackgroundColor(TUBE_TD[43], 255);
	TextDrawFont(TUBE_TD[43], 2);
	TextDrawSetProportional( TUBE_TD[43], 1);
	TextDrawSetShadow(TUBE_TD[43], 0);

	TUBE_TD[44] = TextDrawCreate(527.849609, 281.083343, "By SA-NEWS");
	TextDrawLetterSize(TUBE_TD[44], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[44], 3);
	TextDrawColor( TUBE_TD[44], 255);
	TextDrawSetShadow(TUBE_TD[44], 0);
	TextDrawSetOutline(TUBE_TD[44], 0);
	TextDrawBackgroundColor(TUBE_TD[44], 255);
	TextDrawFont(TUBE_TD[44], 2);
	TextDrawSetProportional( TUBE_TD[44], 1);
	TextDrawSetShadow(TUBE_TD[44], 0);

	TUBE_TD[45] = TextDrawCreate(539.073852, 288.099975, "132,310 VIEWS");
	TextDrawLetterSize(TUBE_TD[45], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[45], 3);
	TextDrawColor( TUBE_TD[45], 255);
	TextDrawSetShadow(TUBE_TD[45], 0);
	TextDrawSetOutline(TUBE_TD[45], 0);
	TextDrawBackgroundColor(TUBE_TD[45], 255);
	TextDrawFont(TUBE_TD[45], 2);
	TextDrawSetProportional( TUBE_TD[45], 1);
	TextDrawSetShadow(TUBE_TD[45], 0);

	TUBE_TD[46] = TextDrawCreate(595.299316, 336.349975, "THE TRUTH DIED IN GREEN");
	TextDrawLetterSize(TUBE_TD[46], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[46], 3);
	TextDrawColor( TUBE_TD[46], 255);
	TextDrawSetShadow(TUBE_TD[46], 0);
	TextDrawSetOutline(TUBE_TD[46], 0);
	TextDrawBackgroundColor(TUBE_TD[46], 255);
	TextDrawFont(TUBE_TD[46], 2);
	TextDrawSetProportional( TUBE_TD[46], 1);
	TextDrawSetShadow(TUBE_TD[46], 0);

	TUBE_TD[47] = TextDrawCreate(560.524414, 346.816558, "GOO EXPERIMENT");
	TextDrawLetterSize(TUBE_TD[47], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[47], 3);
	TextDrawColor( TUBE_TD[47], 255);
	TextDrawSetShadow(TUBE_TD[47], 0);
	TextDrawSetOutline(TUBE_TD[47], 0);
	TextDrawBackgroundColor(TUBE_TD[47], 255);
	TextDrawFont(TUBE_TD[47], 2);
	TextDrawSetProportional( TUBE_TD[47], 1);
	TextDrawSetShadow(TUBE_TD[47], 0);

	TUBE_TD[48] = TextDrawCreate(526.899536, 355.666748, "BY JOF575");
	TextDrawLetterSize(TUBE_TD[48], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[48], 3);
	TextDrawColor( TUBE_TD[48], 255);
	TextDrawSetShadow(TUBE_TD[48], 0);
	TextDrawSetOutline(TUBE_TD[48], 0);
	TextDrawBackgroundColor(TUBE_TD[48], 255);
	TextDrawFont(TUBE_TD[48], 2);
	TextDrawSetProportional( TUBE_TD[48], 1);
	TextDrawSetShadow(TUBE_TD[48], 0);

	TUBE_TD[49] = TextDrawCreate(554.923950, 363.633300, "52,313,310 VIEWS");
	TextDrawLetterSize(TUBE_TD[49], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[49], 3);
	TextDrawColor( TUBE_TD[49], 255);
	TextDrawSetShadow(TUBE_TD[49], 0);
	TextDrawSetOutline(TUBE_TD[49], 0);
	TextDrawBackgroundColor(TUBE_TD[49], 255);
	TextDrawFont(TUBE_TD[49], 2);
	TextDrawSetProportional( TUBE_TD[49], 1);
	TextDrawSetShadow(TUBE_TD[49], 0);

	TUBE_TD[50] = TextDrawCreate(563.424316, 419.183563, "THREE GANSTER'S");
	TextDrawLetterSize(TUBE_TD[50], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[50], 3);
	TextDrawColor( TUBE_TD[50], 255);
	TextDrawSetShadow(TUBE_TD[50], 0);
	TextDrawSetOutline(TUBE_TD[50], 0);
	TextDrawBackgroundColor(TUBE_TD[50], 255);
	TextDrawFont(TUBE_TD[50], 2);
	TextDrawSetProportional( TUBE_TD[50], 1);
	TextDrawSetShadow(TUBE_TD[50], 0);

	TUBE_TD[51] = TextDrawCreate(570.999145, 428.516906, "arrested DURING....");
	TextDrawLetterSize(TUBE_TD[51], 0.206248, 1.010833);
	TextDrawAlignment(TUBE_TD[51], 3);
	TextDrawColor( TUBE_TD[51], 255);
	TextDrawSetShadow(TUBE_TD[51], 0);
	TextDrawSetOutline(TUBE_TD[51], 0);
	TextDrawBackgroundColor(TUBE_TD[51], 255);
	TextDrawFont(TUBE_TD[51], 2);
	TextDrawSetProportional( TUBE_TD[51], 1);
	TextDrawSetShadow(TUBE_TD[51], 0);

	TUBE_TD[52] = TextDrawCreate(525.649536, 438.500122, "BY POLICIA");
	TextDrawLetterSize(TUBE_TD[52], 0.164998, 0.748332);
	TextDrawAlignment(TUBE_TD[52], 3);
	TextDrawColor( TUBE_TD[52], 255);
	TextDrawSetShadow(TUBE_TD[52], 0);
	TextDrawSetOutline(TUBE_TD[52], 0);
	TextDrawBackgroundColor(TUBE_TD[52], 255);
	TextDrawFont(TUBE_TD[52], 2);
	TextDrawSetProportional( TUBE_TD[52], 1);
	TextDrawSetShadow(TUBE_TD[52], 0);

	TUBE_TD[53] = TextDrawCreate(602.500000, 79.749977, "box");
	TextDrawLetterSize(TUBE_TD[53], 0.000000, 0.562500);
	TextDrawTextSize(TUBE_TD[53], 628.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[53], 1);
	TextDrawColor( TUBE_TD[53], -1);
	TextDrawUseBox(TUBE_TD[53], 1);
	TextDrawBoxColor(TUBE_TD[53], 65535);
	TextDrawSetShadow(TUBE_TD[53], 0);
	TextDrawSetOutline(TUBE_TD[53], 0);
	TextDrawBackgroundColor(TUBE_TD[53], 255);
	TextDrawFont(TUBE_TD[53], 1);
	TextDrawSetProportional( TUBE_TD[53], 1);
	TextDrawSetShadow(TUBE_TD[53], 0);

	TUBE_TD[54] = TextDrawCreate(597.474853, 73.449966, "(");
	TextDrawLetterSize(TUBE_TD[54], 0.400000, 1.600000);
	TextDrawAlignment(TUBE_TD[54], 1);
	TextDrawColor( TUBE_TD[54], 65452);
	TextDrawSetShadow(TUBE_TD[54], 0);
	TextDrawSetOutline(TUBE_TD[54], 0);
	TextDrawBackgroundColor(TUBE_TD[54], 255);
	TextDrawFont(TUBE_TD[54], 1);
	TextDrawSetProportional( TUBE_TD[54], 0);
	TextDrawSetShadow(TUBE_TD[54], 0);

	TUBE_TD[55] = TextDrawCreate(627.474853, 73.133323, ")");
	TextDrawLetterSize(TUBE_TD[55], 0.400000, 1.600000);
	TextDrawAlignment(TUBE_TD[55], 1);
	TextDrawColor( TUBE_TD[55], 65452);
	TextDrawSetShadow(TUBE_TD[55], 0);
	TextDrawSetOutline(TUBE_TD[55], 0);
	TextDrawBackgroundColor(TUBE_TD[55], 255);
	TextDrawFont(TUBE_TD[55], 1);
	TextDrawSetProportional( TUBE_TD[55], 0);
	TextDrawSetShadow(TUBE_TD[55], 0);

	TUBE_TD[56] = TextDrawCreate(599.224731, 74.883369, "O");
	TextDrawLetterSize(TUBE_TD[56], 0.400000, 1.600000);
	TextDrawAlignment(TUBE_TD[56], 1);
	TextDrawColor( TUBE_TD[56], -1);
	TextDrawSetShadow(TUBE_TD[56], 0);
	TextDrawSetOutline(TUBE_TD[56], 0);
	TextDrawBackgroundColor(TUBE_TD[56], 255);
	TextDrawFont(TUBE_TD[56], 1);
	TextDrawSetProportional( TUBE_TD[56], 1);
	TextDrawSetShadow(TUBE_TD[56], 0);

	TUBE_TD[57] = TextDrawCreate(535.000000, 76.833335, "AUTOPLAY");
	TextDrawLetterSize(TUBE_TD[57], 0.243123, 1.063333);
	TextDrawAlignment(TUBE_TD[57], 1);
	TextDrawColor( TUBE_TD[57], -1061109505);
	TextDrawSetShadow(TUBE_TD[57], 0);
	TextDrawSetOutline(TUBE_TD[57], 0);
	TextDrawBackgroundColor(TUBE_TD[57], 255);
	TextDrawFont(TUBE_TD[57], 2);
	TextDrawSetProportional( TUBE_TD[57], 1);
	TextDrawSetShadow(TUBE_TD[57], 0);

	TUBE_TD[58] = TextDrawCreate(2.500000, 357.999877, "box");
	TextDrawLetterSize(TUBE_TD[58], 0.000000, -0.687500);
	TextDrawTextSize(TUBE_TD[58], 334.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[58], 1);
	TextDrawColor( TUBE_TD[58], -1);
	TextDrawUseBox(TUBE_TD[58], 1);
	TextDrawBoxColor(TUBE_TD[58], -2139062017);
	TextDrawSetShadow(TUBE_TD[58], 0);
	TextDrawSetOutline(TUBE_TD[58], 0);
	TextDrawBackgroundColor(TUBE_TD[58], 255);
	TextDrawFont(TUBE_TD[58], 1);
	TextDrawSetProportional( TUBE_TD[58], 1);
	TextDrawSetShadow(TUBE_TD[58], 0);

	TUBE_TD[59] = TextDrawCreate(64.375000, 341.083404, "+ Add to");
	TextDrawLetterSize(TUBE_TD[59], 0.212498, 1.168333);
	TextDrawAlignment(TUBE_TD[59], 3);
	TextDrawColor( TUBE_TD[59], 255);
	TextDrawSetShadow(TUBE_TD[59], 0);
	TextDrawSetOutline(TUBE_TD[59], 0);
	TextDrawBackgroundColor(TUBE_TD[59], 255);
	TextDrawFont(TUBE_TD[59], 2);
	TextDrawSetProportional( TUBE_TD[59], 1);
	TextDrawSetShadow(TUBE_TD[59], 0);

	TUBE_TD[60] = TextDrawCreate(120.625000, 341.666748, "SHARE");
	TextDrawLetterSize(TUBE_TD[60], 0.212498, 1.168333);
	TextDrawAlignment(TUBE_TD[60], 3);
	TextDrawColor( TUBE_TD[60], 255);
	TextDrawSetShadow(TUBE_TD[60], 0);
	TextDrawSetOutline(TUBE_TD[60], 0);
	TextDrawBackgroundColor(TUBE_TD[60], 255);
	TextDrawFont(TUBE_TD[60], 2);
	TextDrawSetProportional( TUBE_TD[60], 1);
	TextDrawSetShadow(TUBE_TD[60], 0);

	TUBE_TD[61] = TextDrawCreate(80.399993, 343.099975, "LD_BEAT:right");
	TextDrawLetterSize(TUBE_TD[61], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[61], 9.000000, 9.000000);
	TextDrawAlignment(TUBE_TD[61], 1);
	TextDrawColor( TUBE_TD[61], 255);
	TextDrawSetShadow(TUBE_TD[61], 0);
	TextDrawSetOutline(TUBE_TD[61], 0);
	TextDrawBackgroundColor(TUBE_TD[61], 255);
	TextDrawFont(TUBE_TD[61], 4);
	TextDrawSetProportional( TUBE_TD[61], 0);
	TextDrawSetShadow(TUBE_TD[61], 0);

	TUBE_TD[62] = TextDrawCreate(174.499969, 341.883483, "more");
	TextDrawLetterSize(TUBE_TD[62], 0.212498, 1.168333);
	TextDrawAlignment(TUBE_TD[62], 3);
	TextDrawColor( TUBE_TD[62], 255);
	TextDrawSetShadow(TUBE_TD[62], 0);
	TextDrawSetOutline(TUBE_TD[62], 0);
	TextDrawBackgroundColor(TUBE_TD[62], 255);
	TextDrawFont(TUBE_TD[62], 2);
	TextDrawSetProportional( TUBE_TD[62], 1);
	TextDrawSetShadow(TUBE_TD[62], 0);

	TUBE_TD[63] = TextDrawCreate(135.625000, 337.183288, "...");
	TextDrawLetterSize(TUBE_TD[63], 0.365624, 1.535833);
	TextDrawAlignment(TUBE_TD[63], 1);
	TextDrawColor( TUBE_TD[63], 255);
	TextDrawSetShadow(TUBE_TD[63], 0);
	TextDrawSetOutline(TUBE_TD[63], 0);
	TextDrawBackgroundColor(TUBE_TD[63], 255);
	TextDrawFont(TUBE_TD[63], 1);
	TextDrawSetProportional( TUBE_TD[63], 1);
	TextDrawSetShadow(TUBE_TD[63], 0);

	TUBE_TD[64] = TextDrawCreate(2.500000, 342.833221, "box");
	TextDrawLetterSize(TUBE_TD[64], 0.000000, -0.687500);
	TextDrawTextSize(TUBE_TD[64], 334.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[64], 1);
	TextDrawColor( TUBE_TD[64], -1);
	TextDrawUseBox(TUBE_TD[64], 1);
	TextDrawBoxColor(TUBE_TD[64], -2139062017);
	TextDrawSetShadow(TUBE_TD[64], 0);
	TextDrawSetOutline(TUBE_TD[64], 0);
	TextDrawBackgroundColor(TUBE_TD[64], 255);
	TextDrawFont(TUBE_TD[64], 1);
	TextDrawSetProportional( TUBE_TD[64], 1);
	TextDrawSetShadow(TUBE_TD[64], 0);

	TUBE_TD[65] = TextDrawCreate(101.875000, 363.250122, "Published on 28 SEP 2017");
	TextDrawLetterSize(TUBE_TD[65], 0.174998, 0.946666);
	TextDrawAlignment(TUBE_TD[65], 3);
	TextDrawColor( TUBE_TD[65], 255);
	TextDrawSetShadow(TUBE_TD[65], 0);
	TextDrawSetOutline(TUBE_TD[65], 0);
	TextDrawBackgroundColor(TUBE_TD[65], 255);
	TextDrawFont(TUBE_TD[65], 2);
	TextDrawSetProportional( TUBE_TD[65], 1);
	TextDrawSetShadow(TUBE_TD[65], 0);

	TUBE_TD[66] = TextDrawCreate(43.750000, 373.750213, "CATEGORY:");
	TextDrawLetterSize(TUBE_TD[66], 0.174998, 0.946666);
	TextDrawAlignment(TUBE_TD[66], 3);
	TextDrawColor( TUBE_TD[66], 255);
	TextDrawSetShadow(TUBE_TD[66], 0);
	TextDrawSetOutline(TUBE_TD[66], 0);
	TextDrawBackgroundColor(TUBE_TD[66], 255);
	TextDrawFont(TUBE_TD[66], 2);
	TextDrawSetProportional( TUBE_TD[66], 1);
	TextDrawSetShadow(TUBE_TD[66], 0);

	TUBE_TD[67] = TextDrawCreate(51.875000, 374.333374, "loadsc0:loadsc0");
	TextDrawLetterSize(TUBE_TD[67], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[67], 37.000000, 34.000000);
	TextDrawAlignment(TUBE_TD[67], 1);
	TextDrawColor( TUBE_TD[67], -1);
	TextDrawSetShadow(TUBE_TD[67], 0);
	TextDrawSetOutline(TUBE_TD[67], 0);
	TextDrawBackgroundColor(TUBE_TD[67], 255);
	TextDrawFont(TUBE_TD[67], 4);
	TextDrawSetProportional( TUBE_TD[67], 0);
	TextDrawSetShadow(TUBE_TD[67], 0);

	TUBE_TD[68] = TextDrawCreate(184.074981, 58.566684, "-");
	TextDrawLetterSize(TUBE_TD[68], 0.313122, 1.135830);
	TextDrawTextSize(TUBE_TD[68], 432.699981, 0.000000);
	TextDrawAlignment(TUBE_TD[68], 1);
	TextDrawColor( TUBE_TD[68], -1);
	TextDrawUseBox(TUBE_TD[68], 1);
	TextDrawBoxColor(TUBE_TD[68], -1);
	TextDrawSetShadow(TUBE_TD[68], 0);
	TextDrawSetOutline(TUBE_TD[68], 0);
	TextDrawBackgroundColor(TUBE_TD[68], 255);
	TextDrawFont(TUBE_TD[68], 2);
	TextDrawSetProportional( TUBE_TD[68], 1);
	TextDrawSetShadow(TUBE_TD[68], 0);

	TUBE_TD[69] = TextDrawCreate(248.974975, 56.316638, "SEARCH !");
	TextDrawLetterSize(TUBE_TD[69], 0.318749, 1.296666);
	TextDrawAlignment(TUBE_TD[69], 3);
	TextDrawColor( TUBE_TD[69], -1061109505);
	TextDrawSetShadow(TUBE_TD[69], 0);
	TextDrawSetOutline(TUBE_TD[69], 0);
	TextDrawBackgroundColor(TUBE_TD[69], 255);
	TextDrawFont(TUBE_TD[69], 2);
	TextDrawSetProportional( TUBE_TD[69], 1);
	TextDrawSetShadow(TUBE_TD[69], 0);
	TextDrawSetSelectable( TUBE_TD[69], true);

	TUBE_TD[70] = TextDrawCreate(-1.250000, 22.350008, "box");
	TextDrawLetterSize(TUBE_TD[70], 0.000000, -0.812500);
	TextDrawTextSize(TUBE_TD[70], 668.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[70], 1);
	TextDrawColor( TUBE_TD[70], -1);
	TextDrawUseBox(TUBE_TD[70], 1);
	TextDrawBoxColor(TUBE_TD[70], 255);
	TextDrawSetShadow(TUBE_TD[70], 0);
	TextDrawSetOutline(TUBE_TD[70], 0);
	TextDrawBackgroundColor(TUBE_TD[70], 255);
	TextDrawFont(TUBE_TD[70], 2);
	TextDrawSetProportional( TUBE_TD[70], 1);
	TextDrawSetShadow(TUBE_TD[70], 0);

	TUBE_TD[71] = TextDrawCreate(-5.000000, 52.683334, "box");
	TextDrawLetterSize(TUBE_TD[71], 0.000000, -0.375000);
	TextDrawTextSize(TUBE_TD[71], 653.000000, 0.000000);
	TextDrawAlignment(TUBE_TD[71], 1);
	TextDrawColor( TUBE_TD[71], -1);
	TextDrawUseBox(TUBE_TD[71], 1);
	TextDrawBoxColor(TUBE_TD[71], 255);
	TextDrawSetShadow(TUBE_TD[71], 0);
	TextDrawSetOutline(TUBE_TD[71], 0);
	TextDrawBackgroundColor(TUBE_TD[71], 255);
	TextDrawFont(TUBE_TD[71], 2);
	TextDrawSetProportional( TUBE_TD[71], 1);
	TextDrawSetShadow(TUBE_TD[71], 0);

	TUBE_TD[73] = TextDrawCreate(605.000000, 1.116677, "");
	TextDrawLetterSize(TUBE_TD[73], 0.000000, 0.000000);
	TextDrawTextSize(TUBE_TD[73], 16.000000, 14.000000);
	TextDrawAlignment(TUBE_TD[73], 1);
	TextDrawColor( TUBE_TD[73], -16776961);
	TextDrawSetShadow(TUBE_TD[73], 0);
	TextDrawSetOutline(TUBE_TD[73], 0);
	TextDrawBackgroundColor(TUBE_TD[73], -1);
	TextDrawFont(TUBE_TD[73], 5);
	TextDrawSetProportional( TUBE_TD[73], 0);
	TextDrawSetShadow(TUBE_TD[73], 0);
	TextDrawSetSelectable( TUBE_TD[73], true);
	TextDrawSetPreviewModel(TUBE_TD[73], 19379);
	TextDrawSetPreviewRot(TUBE_TD[73], 0.000000, 0.000000, 90.000000, 1.000000);

	TUBE_TD[74] = TextDrawCreate(609.000854, 3.683336, "-");
	TextDrawLetterSize(TUBE_TD[74], 0.669375, 1.063333);
	TextDrawAlignment(TUBE_TD[74], 1);
	TextDrawColor( TUBE_TD[74], -1);
	TextDrawSetShadow(TUBE_TD[74], 0);
	TextDrawSetOutline(TUBE_TD[74], 0);
	TextDrawBackgroundColor(TUBE_TD[74], 255);
	TextDrawFont(TUBE_TD[74], 2);
	TextDrawSetProportional( TUBE_TD[74], 1);
	TextDrawSetShadow(TUBE_TD[74], 0);

	TUBE_TD[75] = TextDrawCreate(242.499847, 341.033447, "]");
	TextDrawLetterSize(TUBE_TD[75], 0.344374, 1.290831);
	TextDrawAlignment(TUBE_TD[75], 1);
	TextDrawColor( TUBE_TD[75], -65281);
	TextDrawSetShadow(TUBE_TD[75], 0);
	TextDrawSetOutline(TUBE_TD[75], 1);
	TextDrawBackgroundColor(TUBE_TD[75], 255);
	TextDrawFont(TUBE_TD[75], 2);
	TextDrawSetProportional( TUBE_TD[75], 1);
	TextDrawSetShadow(TUBE_TD[75], 0);
	TextDrawSetSelectable( TUBE_TD[75], true);

	TUBE_TD[76] = TextDrawCreate(336.874847, 341.600006, "YOUTUBE TOP LIST");
	TextDrawLetterSize(TUBE_TD[76], 0.207499, 1.156665);
	TextDrawAlignment(TUBE_TD[76], 3);
	TextDrawColor( TUBE_TD[76], 255);
	TextDrawSetShadow(TUBE_TD[76], 0);
	TextDrawSetOutline(TUBE_TD[76], 0);
	TextDrawBackgroundColor(TUBE_TD[76], 255);
	TextDrawFont(TUBE_TD[76], 2);
	TextDrawSetProportional( TUBE_TD[76], 1);
	return 1;
}
SHOWTEXTDRAW(playerid)
{
	for(new i = 0; i < MAX_TDS; i++)
	{
	if(i != 23 )
 	{
	TextDrawShowForPlayer(playerid, TUBE_TD[i]);
	}
	}
	SelectTextDraw(playerid, 0xA3B4C5FF);
	PlayerTextDrawShow(playerid, TUBE_PTD[playerid][1]);
    return 1;
}
HIDETEXTDRAW(playerid)
{
	for(new i = 0; i < MAX_TDS; i++)
	{
	if(i != 23 )
 	{
	TextDrawHideForPlayer(playerid, TUBE_TD[i]);
	}
	}
	CancelSelectTextDraw(playerid);
	PlayerTextDrawHide(playerid, TUBE_PTD[playerid][1]);
    return 1;
}
public OnPlayerConnect(playerid)
{
	TUBE_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 236.000000, 274.000000, "SA-TUBE CURRENTLY LISTENING - NO SONG");
	PlayerTextDrawLetterSize(playerid, TUBE_PTD[playerid][1], 0.268747, 1.349166);
	PlayerTextDrawAlignment(playerid, TUBE_PTD[playerid][1], 3);
	PlayerTextDrawColor(playerid, TUBE_PTD[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, TUBE_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TUBE_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TUBE_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TUBE_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TUBE_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TUBE_PTD[playerid][1], 0);
    return 1;
}
CMD:satube(playerid)
{
	SendClientMessage(playerid, -1 , ""mred"[SA-TUBE] "mcol"SA-MP YOUTUBE SYSTEM OPENED, CLICK ON SEARCH Button to search a music.!");
	SHOWTEXTDRAW(playerid);
	return 1;
}
CMD:create(playerid)
{
	TUBE_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 236.000000, 274.000000, "SA-TUBE CURRENTLY LISTENING - NO SONG");
	PlayerTextDrawLetterSize(playerid, TUBE_PTD[playerid][1], 0.268747, 1.349166);
	PlayerTextDrawAlignment(playerid, TUBE_PTD[playerid][1], 3);
	PlayerTextDrawColor(playerid, TUBE_PTD[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, TUBE_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TUBE_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TUBE_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TUBE_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TUBE_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TUBE_PTD[playerid][1], 0);
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
 	new string[256];
	if(dialogid == DIALOG_TUBE)
	{
	    if(!response) return SelectTextDraw(playerid, 0xA3B4C5FF); SHOWTEXTDRAW(playerid);
		{
			if(!strlen(inputtext))
			{
      		ShowPlayerDialog(playerid,DIALOG_TUBE,DIALOG_STYLE_INPUT,""mred"Enter a youtube link !",""mcol"Please enter a youtube link ! "mred"(e.g www.youtube.com/watch?v=kJQP7kiw5Fk )\n"mcol"If you don't know a name then click on the {ffff00}STAR\n"mcol"The link should be exact or it wont work","Play","Close");
			}
			PlayerTextDrawSetString(playerid,TUBE_PTD[playerid][1],"SA-TUBE CURRENTLY LISTENING -LINK AUDIO");
			format(string, sizeof(string) , "http://www.youtubeinmp3.com/fetch/?video=%s", inputtext);
			SelectTextDraw(playerid, 0xA3B4C5FF);
			SHOWTEXTDRAW(playerid);
			SendClientMessage(playerid, -1 , ""mred"[SA-TUBE] "mcol"You are now listening to an AUDIO, Some videos take few seconds to start,");
			SendClientMessage(playerid, -1 ,""mred"[SA-TUBE] "mcol"Depending on your internet , and some videos have intro, etc. So please wait few secs.");
			PlayYoutubeAudio(playerid, string);
		}
	}
	if(dialogid == DIALOG_TUBE+1)
	{
 		if(!response) return SelectTextDraw(playerid, 0xA3B4C5FF); SHOWTEXTDRAW(playerid);
		{
		format(string, sizeof(string) , "LISTENING- %s", MUSICLIST[listitem][MUSICNAME]);
		PlayerTextDrawSetString(playerid,TUBE_PTD[playerid][1],string);
		format(string, sizeof(string) , "http://www.youtubeinmp3.com/fetch/?video=%s", MUSICLIST[listitem][LINK]);
		SelectTextDraw(playerid, 0xA3B4C5FF);
		SHOWTEXTDRAW(playerid);
		SendClientMessage(playerid, -1 ,""mred"[SA-TUBE] "mcol"You are now listening to an CUSTOM AUDIO, Some videos take few seconds to start,");
		SendClientMessage(playerid, -1 ,""mred"[SA-TUBE] "mcol"Depending on your internet,and some videos have intro, etc.So please wait few secs.");
		PlayYoutubeAudio(playerid, string);
		}
	}
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	new string[356];
    if(clickedid == TUBE_TD[69])
    {
         ShowPlayerDialog(playerid,DIALOG_TUBE,DIALOG_STYLE_INPUT,""mred"Enter a youtube link !",""mcol"Please enter a youtube link ! "mred"(e.g www.youtube.com/watch?v=kJQP7kiw5Fk )\n"mcol"If you don't have a link then type /mucics and put a name in this dialog\nThe link/name should be exact or it wont work","Play","Close");
         CancelSelectTextDraw(playerid);
    }
    if(clickedid == TUBE_TD[72])
    {
    	 CancelSelectTextDraw(playerid);
    	 HIDETEXTDRAW(playerid);
		 StopAudioStreamForPlayer(playerid);
 		 SendClientMessage(playerid, -1 , ""mred"[SA-TUBE] "mcol"You've closed the SA-TUBE.!");
    }
    if(clickedid == TUBE_TD[73])
    {
    	 CancelSelectTextDraw(playerid);
    	 HIDETEXTDRAW(playerid);
    	 SendClientMessage(playerid, -1 , ""mred"[SA-TUBE] "mcol"You've minimized the SA-TUBE, The music wont be stopped now.");
    }
    if(clickedid == TUBE_TD[75])
    {
 	for(new a=0; a<sizeof(MUSICLIST); a++)
 	{
 	format(string, sizeof(string), "%s%s\n",string,MUSICLIST[a][MUSICNAME]);
 	}
	ShowPlayerDialog(playerid, DIALOG_TUBE+1 , DIALOG_STYLE_LIST, ""mred"TOP MUSICS", string, "Play","Exit");
	CancelSelectTextDraw(playerid);
    }
    return 1;
}
// 			Thanks to Sreyas aka SyS for both of these			//

forward RequestYoutube2Mp3( playerid, response_code, data[ ] );
public RequestYoutube2Mp3( playerid, response_code, data[ ] )
{

    //if( response_code == 200 )
    //{
        new
            start_pos = strfind( data, "\"url\":" ) + 9,
            end_pos = strfind( data, "\"", .pos = start_pos ),
            mp3_coverted_link[ 500 ];

        strmid( mp3_coverted_link, data,start_pos,end_pos );
        format( mp3_coverted_link, sizeof( mp3_coverted_link ), "http://%s", mp3_coverted_link );
        //PlayAudioStreamForPlayer( playerid, mp3_coverted_link );
        PlayAudioStreamForPlayer( playerid, "http://www.youtube.com/watch?v=fJ9rUzIMcZQ");
    //}

    //else
        //SendClientMessage( playerid, -1, "Couldn't play the song!!!" );

    return 1;

}

PlayYoutubeAudio( playerid, video_link[ ] )
{

    new
        param_v_idx = strfind( video_link, "?v=" ) + 3,
        video_id[ 15 ],
        payload[ 55 ];

    strmid( video_id, video_link, param_v_idx, strlen( video_link ) );
    format( payload, sizeof( payload ), "www.yt-mp3.com/fetch?v=%s&apikey=1234567", video_id );
    HTTP( playerid, HTTP_GET, payload, "", "RequestYoutube2Mp3" );

    return 1;

}
