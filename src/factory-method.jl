# Intent:
#   Define and interface for creating an object but let subclasses decide which class
#   to instantiate
#
# Related Patterns:
#   - AbstractFactory is often implemented using factory methods.
#   - Template Methods usually call factory methods.

abstract type MazeGame end

abstract type Maze end
abstract type Room end
abstract type Door end

@enum Direction NORTH, SOUTH, WEST, EAST

# Implicit interface which must be implemented by concrete factories
make_maze(game::MazeGame) = error("implement make_maze(", typeof(game), ")")
make_wall(game::MazeGame) = error("implement make_wall(", typeof(game), ")")

function make_room(game::MazeGame, n::Integer)
    error("implement make_room(", typeof(game), ", n::Integer)")
end

function make_door(game::MazeGame, r1::Room, r2::Room)
    error("implement make_door(", typeof(game), ", r1::Room, r2::Room)") 
end


struct EnchantedMazeGame <: MazeGame
    
end

function make_room(game::EnchantedMazeGame, n::Integer)
    EnchantedRoom(n, cast_spell())
end

function make_door(game::EnchantedMazeGame, r1::Room, r2::Room)
    DoorNeedingSpell(r1, r1)
end


    

function create_maze(game::MazeGame)
    maze::Maze = make_maze(game)
    r1::Room   = make_room(game, 1)
    r2::Room   = make_room(game, 1)
    door::Door = make_door(game, r1, r2)

    add_room(maze, r1)
    add_room(maze, r2)

    set_side(r1, NORTH, make_wall(game))
    set_side(r1, EAST, door)
    set_side(r1, SOUTH, make_wall(game))
    set_side(r1, WEST, make_wall(game))

    set_side(r2, NORTH, make_wall(game))
    set_side(r2, EAST, make_wall(game))
    set_side(r2, SOUTH, make_wall(game))
    set_side(r2, WEST, door)    
end