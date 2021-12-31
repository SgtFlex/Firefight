$scale 2
$origin 0 0 0 -90
$modelname	"hr/unsc/bubble_shield/bubble_shield"
$body bubble_shield "Base.smd"
$cdmaterials "models/hr/unsc/bubble_shield"
$surfaceprop	glass
$sequence idle "Base.smd"  activity ACT_IDLE -1 loop fps 30
$collisionmodel "Phys.smd" {
	$automass
	$concave
	$maxconvexpieces 80
}
$texturegroup "Color"
{
	{"bubble_shield"}
	{"bubble_shield_b"}
	{"bubble_shield_y"}
}