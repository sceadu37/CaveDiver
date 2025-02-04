
#EXMAPLES OF SAVING AND LOADING
# SaveSystem.save_game()
#SaveSystem.load_game()

extends Node

var save_path = "user://savegame.json"

# Save the game state
func save_game():
	var save_data = {
		"health": GameManager.player_health,
		"oxygen": GameManager.oxygen
	}
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))  # Corrected JSON saving
		print("Game saved!")
	else:
		print("Error saving game!")

# Load the game state
func load_game():
	if not FileAccess.file_exists(save_path):
		print("No save file found.")
		return

	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var save_data = JSON.parse_string(content)  # Corrected JSON loading
		
		if save_data:
			GameManager.player_health = save_data.get("health", 100)
			GameManager.oxygen = save_data.get("oxygen", 100)
			print("Game loaded!")
		else:
			print("Error parsing save file!")
