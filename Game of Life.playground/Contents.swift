// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

//  If you size the console just right, you should be able to 
//  get an acceptable animation of the generations going by.

var controller = Controller(boardSize: (30, 80), seeds: [])

for _ in (1...500) {
    print(controller)
    controller.update()
}
