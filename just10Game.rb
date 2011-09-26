#!/usr/bin/ruby
require 'eventmachine'
require "curses"


class Just10Game
  DISP_POS_Y = 12
  DISP_POS_X = 30
  
  def initialize
    @game_is_end = false
    @time_elapsed = ""
    @user_info = ""
  end

  def start_game
    Curses::init_screen
    Curses::cbreak
    time_thread = start_timer
    wait_input
    end_time(time_thread)
    wait_input
  end
  
  def start_timer
    time_thread = Thread.new do
      timer = Time.now
      loop do
        break if @game_is_end
        @time_elapsed = Time.now - timer
        
        Curses::setpos(DISP_POS_Y, DISP_POS_X)
        if @time_elapsed <= 5
          Curses::addstr(@time_elapsed.to_s)
        elsif
          Curses::addstr("    Close     ")
        end
        Curses::setpos(DISP_POS_Y + 1, DISP_POS_X)
        Curses::addstr("Push any key!")
        Curses::refresh
      end
    end
    time_thread
  end

  def end_time(time_thread)
    @game_is_end = true
    time_thread.join
    Curses::init_screen
    sleep(0.5)
    
    result = @time_elapsed - 10
    
    Curses::setpos(DISP_POS_Y, DISP_POS_X)
    Curses::addstr(@time_elapsed.to_s)
    Curses::setpos(DISP_POS_Y + 1, DISP_POS_X)
    Curses::addstr("diffrence:#{result.to_s}")
    Curses::setpos(DISP_POS_Y + 2, DISP_POS_X)
    Curses::addstr("Push any key!")
    Curses::refresh
  end
  
  def wait_input
    Curses::getch
  end

end

begin
  just10Game = Just10Game.new
  just10Game.start_game
ensure
  Curses::close_screen
end
