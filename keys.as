package {
	
    import flash.events.KeyboardEvent;
    import flash.display.Sprite;
	
    public class keys {
		
        private var press_left:Boolean = false;
        private var press_right:Boolean = false;
        private var press_up:Boolean = false;
        private var press_down:Boolean = false;
        private var press_space:Boolean = false;
        private var press_ctrl:Boolean = false;
		
        public function keys(movieclip:Sprite) {
            movieclip.stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
            movieclip.stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
        }
		
		//getters
        public function get is_left():Boolean {
            return press_left;
        }
        public function get is_right():Boolean {
            return press_right;
        }
        public function get is_up():Boolean {
            return press_up;
        }
        public function get is_down():Boolean {
            return press_down;
        }
        public function get is_space():Boolean {
            return press_space;
        }
        public function get is_ctrl():Boolean {
            return press_ctrl;
        }
		
		//setters
        public function set is_left(f:Boolean) {
            press_left = f;
        }
        public function set is_right(f:Boolean) {
            press_right = f;
        }
        public function set is_up(f:Boolean) {
            press_up = f;
        }
        public function set is_down(f:Boolean) {
            press_down = f;
        }
        public function set is_space(f:Boolean) {
            press_space = f;
        }
        public function set is_ctrl(f:Boolean) {
            press_ctrl = f;
        }
		
		
        private function key_down(event:KeyboardEvent) {
            if (event.keyCode == 32) {
                press_space = true;
            }
            if (event.keyCode == 37) {
                press_left = true;
            }
            if (event.keyCode == 38) {
                press_up = true;
            }
            if (event.keyCode == 39) {
                press_right = true;
            }
            if (event.keyCode == 40) {
                press_down = true;
            }
            if (event.keyCode == 17) {
                press_ctrl = true;
            }
        }
        private function key_up(event:KeyboardEvent) {
            if (event.keyCode == 32) {
                press_space = false;
            }
            if (event.keyCode == 37) {
                press_left = false;
            }
            if (event.keyCode == 38) {
                press_up = false;
            }
            if (event.keyCode == 39) {
                press_right = false;
            }
            if (event.keyCode == 40) {
                press_down = false;
            }
            if (event.keyCode == 17) {
                press_ctrl = false;
            }
        }
    }
}