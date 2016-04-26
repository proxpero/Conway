// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

//  If you size the console just right, you should be able to 
//  get an acceptable animation of the generations going by.

import Logic

var controller = Controller()

for _ in (1...1000) {
    print(controller)
    controller.update()
}

