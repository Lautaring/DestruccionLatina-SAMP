//FS Derby Beta Creada Hace Mucho Por si algo esta mal o desatualizado
#define FILTERSCRIPT
#include <a_samp>
#include <zcmd>
#include <foreach>
#include <sscanf2>
#include <streamer>

//#define CMD:%1(%2) forward _%1(%2);public _%1(%2)
#undef MAX_PLAYERS
#define MAX_PLAYERS 				10
#define MAX_DERBY_PLAYERS 			10

#define REMOVETYPE_QUIT_SERVER 		0
#define REMOVETYPE_EXIT_VEHICLE 	1
#define REMOVETYPE_IDLE 			2
#define REMOVETYPE_FELL 			3
#define REMOVETYPE_EXPLOTA          4

#define BLANCO       -1
#define ROJO         0xFF0000FF //LOS COLOREAS YA LOS TIENES
#define COLOR_KICK   0x92998C75
#define AZUL_CLARO   0x45D0FFFF
#define AZUL         0x0000FFB4
#define MAGENTA      0xFF00FFFF
#define CYAN         0x00FFFFFF
#define FLUORECENTE  0x00FF009D
#define VERDE        0x00FF00FF
#define AMARILLO     0xFFFF00FF
#define GRIS         0x00000044
#define NARANJO      0xFF7C00FF
#define PURPURA      0xB700FFFF

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#if !defined isnull
    #define isnull(%1) \
                ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define PlayerName(%0) PlayerNames[%0]
#endif


enum derbyInfo
{
	Vehicle[ 10 ],

	MatchStart, MatchTimer,

    TotalPlayers,ActivePlayers,

	MinPos,

	bool:DerbyStarted, bool:DerbyEnded,
	bool:VehicleOccupied[ 10 ]
};

enum playerInfo
{
	bool:InDerby,
	bool:IsConnected,
	bool:IsLoggedIn,

	databaseID,
    score,
	AFKTime, StartTime,
	VehicleID,
    SpectateID,
	Name[ 24 ], Password[ 24 ],
	IP[ 16 ]
};

new
	dInfo[ derbyInfo ],
	pInfo[ MAX_PLAYERS ][ playerInfo ]
;
new
	Timer[2]
;

new
	Text:gSpecInfo[3] = Text:INVALID_TEXT_DRAW,
	Text:gCounterInfo = Text:INVALID_TEXT_DRAW,
	PlayerText:pSpecInfo0[ MAX_PLAYERS ]
;


new JugadorDerby[MAX_PLAYERS];

public OnFilterScriptInit()
{
print("\n--------------------------------------");
print(" Sistema Derby Cargado");
print("--------------------------------------\n");



CreateDynamicObject(3458, 863.68414, 3402.15063, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 871.68927, 3379.43384, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 675.54932, 3319.77832, 2.03390,   0.00000, 0.00000, 316.25446);
CreateDynamicObject(3458, 863.85010, 3356.70117, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 840.22028, 3319.51270, 2.03390,   0.00000, 0.00000, 48.88334);
CreateDynamicObject(3458, 871.68927, 3333.90601, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 836.84857, 3413.18506, 2.03390,   0.00000, 0.00000, 38.88020);
CreateDynamicObject(3458, 810.14008, 3368.75781, 2.03390,   0.00000, 0.00000, 320.11630);
CreateDynamicObject(3458, 795.85852, 3379.43384, 11.86780,   0.00000, 12.00000, 359.57440);
CreateDynamicObject(1655, 664.32068, 3393.06470, 5.61440,   12.00000, 0.00000, 316.00000);
CreateDynamicObject(3458, 912.04626, 3379.44727, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 837.52045, 3346.09766, 2.03390,   0.00000, 0.00000, 320.58105);
CreateDynamicObject(3458, 810.21283, 3391.36597, 2.03390,   0.00000, 0.00000, 39.70876);
CreateDynamicObject(3458, 869.62671, 3372.67163, 2.03390,   0.00000, 0.00000, 311.67642);
CreateDynamicObject(1655, 847.49316, 3379.35767, 5.61443,   12.00000, 0.00000, 89.48991);
CreateDynamicObject(3458, 896.51373, 3342.55078, 2.03390,   0.00000, 0.00000, 311.67642);
CreateDynamicObject(3458, 647.25952, 3375.11523, 2.03390,   0.00000, 0.00000, 45.89386);
CreateDynamicObject(1655, 663.19781, 3368.04370, 5.61443,   12.00000, 0.00000, 220.51418);
CreateDynamicObject(3458, 899.03613, 3414.46655, 2.03390,   0.00000, 0.00000, 45.89386);
CreateDynamicObject(3877, 931.62506, 3377.70313, 5.33070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 931.63580, 3381.18408, 5.33070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 908.06085, 3326.97925, 5.23220,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 910.67139, 3329.31177, 5.23220,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 913.32489, 3427.32910, 5.38852,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 911.11230, 3429.53589, 5.38852,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 890.88562, 3332.02417, 5.12254,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 890.88147, 3335.84985, 5.21942,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 890.52832, 3423.01636, 4.88129,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 890.72723, 3426.50464, 4.88129,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 825.27783, 3336.82471, 11.86780,   0.00000, 12.00000, 45.89390);
CreateDynamicObject(3458, 826.08191, 3420.73242, 11.86780,   0.00000, 12.00000, 311.67639);
CreateDynamicObject(3458, 775.79352, 3380.40308, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1655, 669.14752, 3380.43872, 5.61440,   12.00000, 0.00000, 270.27347);
CreateDynamicObject(3458, 644.43683, 3380.54492, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 604.02344, 3380.53198, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 646.71448, 3386.59766, 2.03390,   0.00000, 0.00000, 310.84784);
CreateDynamicObject(3458, 870.93549, 3385.43872, 2.03390,   0.00000, 0.00000, 45.89386);
CreateDynamicObject(1655, 853.78687, 3367.46899, 5.61443,   12.00000, 0.00000, 136.44141);
CreateDynamicObject(1655, 853.41040, 3391.39624, 5.61443,   12.00000, 0.00000, 40.99238);
CreateDynamicObject(3458, 619.14081, 3346.10132, 2.03390,   0.00000, 0.00000, 45.89390);
CreateDynamicObject(3458, 620.29315, 3417.15039, 2.03390,   0.00000, 0.00000, 310.84784);
CreateDynamicObject(3458, 716.79187, 3379.98950, 11.86780,   0.00000, -12.00000, 360.00000);
CreateDynamicObject(3458, 693.18414, 3422.75562, 11.86780,   0.00000, -12.00000, 45.89390);
CreateDynamicObject(3458, 750.78888, 3346.49512, 5.16389,   -32.00000, 14.00000, 66.81091);
CreateDynamicObject(3458, 781.43829, 3365.28516, 2.03386,   0.00000, 0.00000, 299.39780);
CreateDynamicObject(3458, 651.66913, 3404.06348, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 642.82318, 3333.21753, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 642.82324, 3426.86963, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 805.55109, 3455.03687, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 761.22321, 3367.69995, 2.03390,   0.00000, 0.00000, 54.09073);
CreateDynamicObject(3458, 808.12994, 3305.29736, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 729.71527, 3455.83496, 2.03390,   0.00000, 0.00000, 358.71829);
CreateDynamicObject(3458, 837.70575, 3440.49902, 2.03390,   0.00000, 0.00000, 311.67642);
CreateDynamicObject(3458, 702.08618, 3305.14746, 2.03390,   0.00000, 0.00000, 0.05356);
CreateDynamicObject(3458, 708.78729, 3389.12866, 2.03390,   0.00000, 0.00000, 326.90436);
CreateDynamicObject(3458, 709.22986, 3370.87427, 2.03390,   0.00000, 0.00000, 41.24811);
CreateDynamicObject(3458, 678.95380, 3345.94946, 2.03390,   0.00000, 0.00000, 38.71188);
CreateDynamicObject(3458, 676.88788, 3413.10620, 2.03390,   0.00000, 0.00000, 319.10895);
CreateDynamicObject(3458, 651.32666, 3355.98804, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 758.96704, 3398.41211, 2.03390,   0.00000, 0.00000, 308.72595);
CreateDynamicObject(3458, 747.18671, 3432.79663, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 790.84937, 3328.03564, 2.03386,   0.00000, 0.00000, 269.77530);
CreateDynamicObject(3458, 677.80188, 3438.33105, 2.03390,   0.00000, 0.00000, 35.66080);
CreateDynamicObject(3458, 693.37720, 3332.95020, 11.86780,   0.00000, -12.00000, 310.84781);
CreateDynamicObject(3458, 722.61700, 3322.94946, 12.87952,   -32.00000, 14.00000, 30.45117);
CreateDynamicObject(3458, 735.62347, 3380.47290, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3458, 721.60254, 3429.04663, 12.36415,   23.00000, 14.00000, 321.39029);
CreateDynamicObject(3458, 801.56458, 3336.08301, 11.39163,   23.00000, 14.00000, 127.79407);
CreateDynamicObject(3458, 796.92401, 3432.17065, 14.45710,   -41.00000, 14.00000, 209.00000);
CreateDynamicObject(3458, 773.68359, 3412.97266, 8.73647,   -41.00000, 14.00000, 258.64581);
CreateDynamicObject(3458, 871.68927, 3424.81250, 2.03390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19692, 779.76831, 3305.46802, 2.31669,   0.00000, 0.00000, 90.13759);
CreateDynamicObject(19692, 777.23590, 3454.94067, 2.31669,   0.00000, 0.00000, 90.66592);
CreateDynamicObject(19692, 763.30286, 3305.36670, 2.31669,   0.00000, 0.00000, 90.13759);
CreateDynamicObject(19692, 746.83844, 3305.30005, 2.31669,   0.00000, 0.00000, 90.13759);
CreateDynamicObject(19692, 730.46155, 3305.32080, 2.31669,   0.00000, 0.00000, 90.13759);
CreateDynamicObject(3877, 623.71210, 3335.16089, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 623.80756, 3331.33594, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 604.81415, 3333.88208, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 607.18744, 3331.34888, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 585.07941, 3378.54419, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 585.15289, 3382.54834, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 609.37872, 3432.50562, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 606.70227, 3430.21240, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 623.87616, 3428.69580, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 623.86847, 3425.13501, 4.98632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19692, 758.08783, 3455.24048, 2.31669,   0.00000, 0.00000, 88.98090);
CreateDynamicObject(19692, 701.76099, 3453.50244, 2.31669,   0.00000, 0.00000, 111.65802);
CreateDynamicObject(1225, 664.82422, 3376.06274, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 664.35181, 3387.02246, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 664.93408, 3384.61938, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 663.51178, 3374.05078, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 656.89331, 3368.48291, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 658.02301, 3392.72632, 4.02278,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 677.53375, 3410.53418, 9.61774,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 665.11200, 3426.47998, 4.06406,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 681.46698, 3406.68579, 9.61774,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 706.17145, 3440.59595, 19.85645,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 723.82062, 3384.07129, 3.87313,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 721.75519, 3384.83984, 3.87313,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 722.83118, 3385.33496, 3.87313,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 724.83020, 3382.88403, 3.87313,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 723.99988, 3377.01123, 3.87313,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 742.01556, 3329.65161, 12.09030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 705.65295, 3314.67212, 19.79399,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 666.10339, 3332.48584, 3.86031,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 682.63226, 3307.14233, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 682.69141, 3305.34375, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 682.66174, 3303.59497, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 684.83051, 3305.20776, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 683.98993, 3306.20117, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 683.96289, 3304.23364, 3.96622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 697.06854, 3382.70117, 9.55836,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 697.14008, 3377.34082, 9.55836,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 678.22809, 3346.30444, 9.69312,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 682.24194, 3349.70459, 9.69312,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 722.20374, 3307.71045, 3.95945,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 722.27362, 3302.53979, 3.95945,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 788.17560, 3302.65796, 3.96636,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 788.17627, 3308.08789, 3.96636,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 828.39496, 3303.04492, 3.95616,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 849.07074, 3333.51367, 3.96530,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 860.00061, 3367.61450, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 853.49719, 3373.69092, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 852.01874, 3375.09497, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 851.99982, 3383.70361, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 853.11493, 3385.21533, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 859.62604, 3390.93262, 4.02457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 840.99286, 3349.11157, 9.62653,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 837.06500, 3353.03174, 9.62653,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 815.74957, 3376.52051, 9.48838,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 815.66327, 3382.10571, 9.48838,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 837.19586, 3404.09155, 9.60490,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 841.23077, 3407.63623, 9.60490,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 847.80377, 3425.17993, 3.95877,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 795.98810, 3383.27637, 4.16728,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 773.59540, 3383.75684, 3.96646,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 793.16882, 3348.48828, 3.95964,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 735.97467, 3377.59277, 17.90516,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 735.91803, 3382.68750, 17.90516,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 776.62048, 3382.29541, 17.94675,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 776.70044, 3376.93579, 17.94675,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 813.39026, 3321.36011, 18.57936,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 814.59546, 3439.16650, 20.80032,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 779.28058, 3428.35718, 14.67012,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 781.12543, 3428.43726, 14.16002,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 749.89868, 3452.65894, 4.27226,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 749.95172, 3458.10498, 4.27226,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 785.33075, 3452.15088, 3.99971,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 785.20673, 3457.90088, 3.99971,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 867.48663, 3422.01270, 4.24620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 866.70715, 3336.65210, 4.06148,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9833, 864.50995, 3378.96338, 0.13197,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9833, 651.25183, 3380.51538, 0.32981,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(7392, 801.29541, 3378.46118, 19.74419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(7392, 709.26373, 3379.36963, 19.74419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1243, 830.64398, 3380.60376, -1.73648,   0.00000, 0.00000, 0.00000);



gSpecInfo[0] = TextDrawCreate(641.666687, 364.462951, "usebox");
TextDrawLetterSize(gSpecInfo[0], 0.000000, 9.085805);
TextDrawTextSize(gSpecInfo[0], -2.000000, 0.000000);
TextDrawAlignment(gSpecInfo[0], 1);
TextDrawColor(gSpecInfo[0], 0);
TextDrawUseBox(gSpecInfo[0], true);
TextDrawBoxColor(gSpecInfo[0], 102);
TextDrawSetShadow(gSpecInfo[0], 0);
TextDrawSetOutline(gSpecInfo[0], 0);
TextDrawFont(gSpecInfo[0], 0);

gSpecInfo[1] = TextDrawCreate(145.333328, 379.396301, "usebox");
TextDrawLetterSize(gSpecInfo[1], 0.000000, -1.837655);
TextDrawTextSize(gSpecInfo[1], 514.000000, 0.000000);
TextDrawAlignment(gSpecInfo[1], 1);
TextDrawColor(gSpecInfo[1], 0);
TextDrawUseBox(gSpecInfo[1], true);
TextDrawBoxColor(gSpecInfo[1], 102);
TextDrawSetShadow(gSpecInfo[1], 0);
TextDrawSetOutline(gSpecInfo[1], 0);
TextDrawFont(gSpecInfo[1], 0);

gCounterInfo = TextDrawCreate(498.000000, 350.000000, "Jugadores en Derby: ~r~1/10");
TextDrawLetterSize(gCounterInfo, 0.205000, 1.749332);
TextDrawAlignment(gCounterInfo, 1);
TextDrawColor(gCounterInfo, -1);
TextDrawSetShadow(gCounterInfo, 0);
TextDrawSetOutline(gCounterInfo, 1);
TextDrawBackgroundColor(gCounterInfo, 51);
TextDrawFont(gCounterInfo, 3);
TextDrawSetProportional(gCounterInfo, 1);

//Autos..

dInfo[ Vehicle ][ 0 ] = CreateVehicle(504, 887.0186, 3424.9155, 4.7949, 91.1585, -1, -1, 100);
dInfo[ Vehicle ][ 1 ] = CreateVehicle(504, 926.4531, 3379.5173, 4.7949, 90.4666, -1, -1, 100);
dInfo[ Vehicle ][ 2 ] = CreateVehicle(504, 909.3864, 3425.3032, 4.7949, 136.7253, -1, -1, 100);
dInfo[ Vehicle ][ 3 ] = CreateVehicle(504, 886.1459, 3333.8582, 4.7949, 91.1585, -1, -1, 100);
dInfo[ Vehicle ][ 4 ] = CreateVehicle(504, 905.7486, 3332.2349, 4.7949, 41.7766, -1, -1, 100);
dInfo[ Vehicle ][ 5 ] = CreateVehicle(504, 627.1328, 3426.9482, 4.7543, 270.7619, -1, -1, 100);
dInfo[ Vehicle ][ 6 ] = CreateVehicle(504, 610.9069, 3428.1479, 4.7543, 220.8554, -1, -1, 100);
dInfo[ Vehicle ][ 7 ] = CreateVehicle(504, 588.9676, 3380.3799, 4.7543, 270.7619, -1, -1, 100);
dInfo[ Vehicle ][ 8 ] = CreateVehicle(504, 627.9383, 3333.1218, 4.7543, 270.7619, -1, -1, 100);
dInfo[ Vehicle ][ 9 ] = CreateVehicle(504, 608.9066, 3335.5344, 4.7543, 315.6830, -1, -1, 100);

UsePlayerPedAnims();
AddClasses();
dInfo[ MatchStart ] = 5, dInfo[ MatchTimer ] = 360;
dInfo[ MinPos ] = 1;


Timer[ 0 ] = SetTimer("MainTimer", 1000, true);

return 1;
}




public OnGameModeExit()
{
	KillTimer(Timer[ 0 ]), KillTimer(Timer[ 1 ]);
	TextDrawDestroy(gCounterInfo), TextDrawDestroy(gSpecInfo[0]), TextDrawDestroy(gSpecInfo[1]), TextDrawDestroy(gSpecInfo[2]);
	return 1;
}

public OnPlayerConnect(playerid)
{
JugadorDerby[playerid] = 0;
return 1;
 
}


public OnPlayerDisconnect(playerid)
{
	new string [76];
	JugadorDerby[playerid] = 0;
    format(string, sizeof(string), "** %s(: %d) ha salido del servidor durante el Derby", GetPlayerNameEx(playerid), playerid);
	SendClientMessageToAll(ROJO, string);

	if(pInfo[ playerid ][ InDerby ] == true) dInfo[ ActivePlayers ]--;
	for(new i; i < _: playerInfo; ++i) pInfo[ playerid ][ playerInfo: i ] = 0;
	dInfo[ TotalPlayers ]--;
	format(string, sizeof( string ), "Jugadores en Derby: ~r~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
	TextDrawSetString(gCounterInfo, string);
	TextDrawHideForPlayer(playerid, gCounterInfo);
	return 1;

}

public OnPlayerSpawn(playerid)
{
 JugadorDerby[playerid] = 0;
 return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(pInfo[ playerid ][ InDerby ] == true)
	{
		RemoveFromDerby(playerid, REMOVETYPE_EXPLOTA);
	}
	JugadorDerby[playerid] = false;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
		if(pInfo[ playerid ][ InDerby ] == true)
		{
			RemoveFromDerby(playerid, REMOVETYPE_EXIT_VEHICLE);
		}
		pInfo[ playerid ][ VehicleID ] = INVALID_VEHICLE_ID;
	}
	else if(newstate == PLAYER_STATE_DRIVER) pInfo[ playerid ][ VehicleID ] = GetPlayerVehicleID(playerid);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	pInfo[ playerid ][ AFKTime ] = 0;
	return 1;
}


public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}


public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
CMD:derby(playerid, params[])
{
        
        new Float:phealth, string[122];
        GetPlayerHealth(playerid,phealth);
   	    if(phealth < 75.0)
            return SendClientMessage(playerid,ROJO,"** Debes llenar tu vida antes de ir al Derby");
        if(JugadorDerby[playerid])
   	        return SendClientMessage(playerid, ROJO, "** Ya estas en derby, usa /sderby");
		//if(DerbyAbierto == 0)
	      //  return SendClientMessage(playerid,ROJO,"** El derby está cerrado, espera a que un admin lo abra");
	        
        JugadorDerby[playerid] = true;
        SendClientMessage(playerid,AZUL_CLARO,"**  ¡Bienvenido a Derby!, Para salir del minijuego usa {FFFFFF}/sderby");
        format(string, sizeof(string), "**{FF0000} %s(%d) {FFFFFF}se ha teletransportado a /Derby", GetPlayerNameEx(playerid), playerid);
		SendClientMessageToAll(BLANCO, string);
		SetPlayerInterior(playerid, 0);
		if(dInfo[ MatchStart ] > 0)
    {
        for(new x; x < 10; x++)
        {
            if(dInfo[ VehicleOccupied ][ x ]) continue;
            else
            {
            dInfo[ VehicleOccupied ][ x ] = true;
            PutPlayerInVehicle(playerid, dInfo[ Vehicle ][ x ], 0);
            break;
            }
        }

        pInfo[ playerid ][ SpectateID ] = INVALID_PLAYER_ID;
        pInfo[ playerid ][ InDerby ] = true;
        dInfo[ ActivePlayers ]++;
        dInfo[ TotalPlayers ]++;
        
        format(string, sizeof( string ), "Jugadores en Derby: ~r~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
	    TextDrawSetString(gCounterInfo, string);
        TextDrawShowForPlayer(playerid, gCounterInfo);
        
        TogglePlayerControllable(playerid, false);
    }
    
        else if(dInfo[ MatchStart ] <= 0)

    
        {
        if(dInfo[ DerbyEnded ] == false)
        {
        pInfo[ playerid ][ InDerby ] = false;
        foreach(Player, i)

        {
        if(pInfo[ i ][ InDerby ] == false) continue;
	    else

        {

	    TogglePlayerSpectating(playerid, true), PlayerSpectateVehicle(playerid, GetPlayerVehicleID( i ));
        pInfo[ playerid ][ SpectateID ] = i;
        break;
               }
            }
        }
        else SetPlayerPos(playerid, 0, 0, 0);
        }
        return 1;
        }
CMD:sderby(playerid, params[])
{
        new string[76];
		if(JugadorDerby[playerid])
		{
        JugadorDerby[playerid] = false;
        format(string, sizeof(string), "**{FF0000} %s(%d) {FFFFFF}ha salido del Derby", GetPlayerNameEx(playerid), playerid);
        SendClientMessageToAll(BLANCO, string);
        dInfo[ ActivePlayers ]--;
        dInfo[ TotalPlayers ]--;
	    TextDrawHideForPlayer(playerid, gCounterInfo);
        SetPlayerVirtualWorld(playerid, 0);
     	SpawnPlayer(playerid);
     	//if(dInfo[ ActivePlayers ] == 1 || dInfo[ TotalPlayers ] == 1)RestartDerby();
        }
        else
            return SendClientMessage(playerid,ROJO,"** Tu no estas en Derby");
        return 1;
    }
stock UpdateSpecInfo(playerid)
{
	new
	    string[ 36 ],
	    targetid = pInfo[ playerid ][ SpectateID ]
	;
	if(IsPlayerConnected(targetid)) format(string, sizeof( string ), "%s(~y~%d~w~)", pInfo[ targetid ][ Name ], targetid);
	else string = "unconnected";

	PlayerTextDrawSetString(playerid, pSpecInfo0[ playerid ], string);
	PlayerTextDrawShow(playerid, pSpecInfo0[ playerid ]);
}


stock RemoveFromDerby(playerid, removetype = REMOVETYPE_QUIT_SERVER)
{
	new string[ 150 ],
	    timeplayed
	;
	
	SetVehicleVirtualWorld(pInfo[ playerid ][ VehicleID ], 1);
	JugadorDerby[playerid] = false;
	dInfo[ VehicleOccupied ][ pInfo[ playerid ][ VehicleID ] ] = false;
	dInfo[ ActivePlayers ]--;
	dInfo[ TotalPlayers ]--;
	pInfo[ playerid ][ InDerby ] = false;
	//if(dInfo[ ActivePlayers ] == 1 || dInfo[ TotalPlayers ] == 1)RestartDerby();
    SetPlayerPos(playerid, 0, 0, 0);

	switch(removetype)
	{
	    case REMOVETYPE_QUIT_SERVER:
	    {
            format(string, sizeof(string), "** {FFFFFF}%s (%d){FF0000} salió del Derby", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ]);
			SendClientMessageToAll(ROJO, string);

			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~Ganaste", 2500, 3);
			        format(string, sizeof(string), "** {FFFFFF}%s (%d){FF0000} Ha ganado el Derby", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
				    SetPlayerScore(i, 5);  //todos estos en la gm de AF los reemplazas por SetPlayerScore(playerid,PlayerInfo[playerid][Score]); PERO PRIMERO PRUÉBALOS ASI
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(ROJO, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_EXIT_VEHICLE:
		{
		    timeplayed = gettime() - pInfo[ playerid ][ StartTime ];

			GameTextForPlayer(playerid, "~r~Descalificado", 2500, 3);
		    format(string, sizeof(string), "** {FFFFFF}%s (%d) {FF0000} ha perdido, salió del vehiculo - {FF0000}Duró : [%d:00] {FF0000} segundos", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(ROJO, string);

			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~Ganaste", 2500, 3);
			        format(string, sizeof(string), "** {FFFFFF}%s (%d){FF0000} Ha ganado el Derby - Duró : {FFFFFF}[%d:00] {FF0000} segundos", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ], timeplayed);
					SetPlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(ROJO, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_IDLE:
		{
      		timeplayed = gettime() - pInfo[ playerid ][ StartTime ];

		    GameTextForPlayer(playerid, "~r~Descalificado", 2500, 3);
		    format(string, sizeof(string), "** {FFFFFF}%s(%d){FF0000} Ha perdido por quedarse afk - Duró : {FFFFFF}[%d:00] {FF0000} segundos", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(ROJO, string);

			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~Ganaste", 2500, 3);
			        format(string, sizeof(string), "** {FFFFFF}%s(%d){FF0000} Ha ganado el Derby",GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
					SetPlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(ROJO, string);
				//SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_FELL:
		{
      		timeplayed = gettime() - pInfo[ playerid ][ StartTime ];

		    GameTextForPlayer(playerid, "~r~Descalificado", 2500, 3);
		    format(string, sizeof(string), "** {FFFFFF}%s(%d){FF0000} ha perdido en Derby por caerse al agua - Duró : {FFFFFF}[%d:00]{FF0000}  segundos",GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
			SendClientMessageToAll(ROJO, string);

			if(dInfo[ ActivePlayers ] == 1)
			{
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~Ganaste", 2500, 3);
			        format(string, sizeof(string), "** {FFFFFF}%s(%d){FF0000} Ha ganado el Derby", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
					SetPlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(ROJO, string);
			    //SetTimer("ResetDerby", 3000, false);
			}
		}
		case REMOVETYPE_EXPLOTA:
		{
         timeplayed = gettime() - pInfo[ playerid ][ StartTime ];
         
		 GameTextForPlayer(playerid, "~r~Descalificado", 2500, 3);
	     format(string, sizeof(string), "** {FFFFFF}%s (%d) {FF0000} ha perdido, explotó el vehiculo - {FF0000}Duró : {FFFFFF}[%d:00]{FF0000}  segundos", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ]+1, dInfo[ TotalPlayers ], timeplayed);
		 SendClientMessageToAll(ROJO, string);

		 if(dInfo[ ActivePlayers ] == 1)
		 {
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        GameTextForPlayer(i, "~g~Ganaste", 2500, 3);
			        format(string, sizeof(string), "** {FFFFFF}%s (%d){FF0000} Ha ganado el Derby - {FF0000} Duró : {FFFFFF}[%d:00]{FF0000}  segundos", GetPlayerNameEx(playerid), playerid, dInfo[ ActivePlayers ], dInfo[ TotalPlayers ], timeplayed);
					SetPlayerScore(i, 5);
			        break;
				}
				dInfo[ DerbyEnded ] = true;
				SendClientMessageToAll(ROJO, string);
				//SetTimer("ResetDerby", 3000, true);
		 }
		}
	}
	if(dInfo[ ActivePlayers ] <= 1 || dInfo[ TotalPlayers ] <= 1)
	{
	    dInfo[ DerbyEnded ] = true;
	    foreach(Player, i)
	    {
			if(GetPlayerState( i ) == PLAYER_STATE_SPECTATING) TogglePlayerSpectating(i, false);
			else SetPlayerPos(i, 0, 0, 0);
		}
		SetTimer("ResetDerby", 5000, false);
	}
    else if(dInfo[ ActivePlayers ] > 1)
	{
	    pInfo[ playerid ][ SpectateID ] = INVALID_PLAYER_ID;
		foreach(Player, i)
	 	{
			if(pInfo[ i ][ InDerby ] == false) continue;
	  		else pInfo[ playerid ][ SpectateID ] = i;
		}
		if(pInfo[ playerid ][ SpectateID ] != INVALID_PLAYER_ID)
		{
            TogglePlayerSpectating(playerid, true), PlayerSpectateVehicle(playerid, GetPlayerVehicleID( pInfo[ playerid ][ SpectateID ] ));
			TextDrawShowForPlayer(playerid, gSpecInfo[0]), TextDrawShowForPlayer(playerid, gSpecInfo[1]), TextDrawShowForPlayer(playerid, gSpecInfo[2]);
			UpdateSpecInfo(playerid);
		}
	}
	format(string, sizeof( string ), "Jugadores en Derby: ~r~%d/%d", dInfo[ ActivePlayers ], dInfo[ TotalPlayers ]);
	TextDrawSetString(gCounterInfo, string);
	TextDrawHideForPlayer(playerid, gCounterInfo);
}


forward MainTimer(playerid);
public MainTimer(playerid)
{
	if(dInfo[ TotalPlayers ] != 0 && dInfo[ ActivePlayers ] != 0)
	{
	    dInfo[ MatchStart ]--;
	    if(dInfo[ MatchStart ] == 3)
		{
			foreach(Player, i)
			{
				GameTextForPlayer(i, "~r~3", 1000, 3);
				PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 2)
		{
		    foreach(Player, i)
			{
				GameTextForPlayer(i, "~b~2", 1000, 3);
				PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 1)
		{
		    foreach(Player, i)
			{
				GameTextForPlayer(i, "~p~1", 1000, 3);
	            PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	    else if(dInfo[ MatchStart ] == 0)
		{
		    new
		        string[ 32 ]
    		;
		    format(string, sizeof( string ), "Jugadores en Derby: ~r~%d/%d", dInfo[ ActivePlayers ], dInfo [ TotalPlayers]);
			TextDrawSetString(gCounterInfo, string);
			TextDrawShowForPlayer(playerid, gCounterInfo);

			GameTextForPlayer(playerid, "~p~GO ~b~GO ~p~GO", 2000, 3);

			dInfo[ DerbyEnded ] = false;
			foreach(Player, i)
			{
				TogglePlayerControllable(i, true);
				SetCameraBehindPlayer(i);
				PlayerPlaySound(i, 1057, 0, 0, 0);
				pInfo[ i ][ StartTime ] = gettime();
			}
			for(new x; x < 15; x++)
			{
				if(dInfo[ VehicleOccupied ][ x ]) continue;
	            else SetVehicleVirtualWorld(dInfo[ Vehicle ][ x ], 1);
	        }
		}
	    if(dInfo[ MatchStart ] <= 0)
	    {
			dInfo[ MatchTimer ]--;
			if(dInfo[ MatchTimer ] > 0)
			{
			    new
					Float:X,
					Float:Y,
					Float:Z
				;
			    foreach(Player, i)
			    {
			        if(pInfo[ i ][ InDerby ] == false) continue;
			        else if(GetPlayerState( i ) == PLAYER_STATE_SPECTATING) continue;
			        else
			        {
				        pInfo[ i ][ AFKTime ]++;

						if(pInfo[ i ][ AFKTime ] > 3)
						{
							RemoveFromDerby(i, REMOVETYPE_IDLE);
							continue;
						}
						else
						{
							GetPlayerPos(i, X, Y, Z);
							RepairVehicle(GetPlayerVehicleID(i));

							if(Z <= dInfo[ MinPos ])
							{
								RemoveFromDerby(i, REMOVETYPE_FELL);
								continue;
							}
						}
					}
				}
			}
			else if(dInfo[ MatchTimer ] == 0)
			{
				RestartDerby();
				GameTextForPlayer(playerid, "~r~Se acabó el tiempo", 2500, 3);
			}
		}
	}
	return 1;
}



stock AddClasses()
{
	for(new i = 1; i < 299; i++) AddPlayerClass(i,0.0,0.0,0.0,0.0,0,0,0,0,0,0);
}


stock GetPlayerNameEx(playerid)
{
        new pName[25];
        GetPlayerName(playerid, pName, 25);
        return pName;
}


forward ResetDerby();
public ResetDerby()
{
	RestartDerby();
}



stock RestartDerby()
{
	dInfo[ MatchStart ] = 5;
	dInfo[ MatchTimer ] = 360;
	dInfo[ ActivePlayers ] = 0;
	dInfo[ DerbyEnded ] = false;

    for(new x; x < 10; x++)
	{
	    dInfo[ VehicleOccupied ][ x ] = false;
	    SetVehicleToRespawn(dInfo[ Vehicle ][ x ]);
		SetVehicleVirtualWorld(dInfo[ Vehicle ][ x ], 0);//0
	}
	foreach(Player, i)
	{
	    if(pInfo[ i ][ IsLoggedIn ] == false) continue;
	    if(pInfo[ i ][ SpectateID ] != INVALID_PLAYER_ID || GetPlayerState(i) == PLAYER_STATE_SPECTATING)
	    {
	        pInfo[ i ][ SpectateID ] = INVALID_PLAYER_ID;
	        TogglePlayerSpectating(i, false);
	        TextDrawHideForPlayer(i, gSpecInfo[0]), TextDrawHideForPlayer(i, gSpecInfo[1]), TextDrawHideForPlayer(i, gSpecInfo[2]);
			PlayerTextDrawHide(i, pSpecInfo0[ i ]);
		}
		else
		{
            dInfo[ ActivePlayers ]++;
			pInfo[ i ][ InDerby ] = true;
			TogglePlayerControllable(i, false);

			for(new x; x < 10; x++)
			{
				if(dInfo[ VehicleOccupied ][ x ]) continue;
				else
				{
					dInfo[ VehicleOccupied ][ x ] = true;
		            PutPlayerInVehicle(i, dInfo[ Vehicle ][ x ], 0);
		            break;
				}
	        }
		}
	}
}

