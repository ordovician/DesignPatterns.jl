# Allows the creation of a family of related objects. Useful when you want to make it easy
# to switch which concrete family of objects you want to create. E.g. switch between
# to different UI themes.

# Example based on Design Patterns: Elements of Reusable Object Oriented Software

abstract type MazeFactory end

abstract type Maze end
abstract type Room end
abstract type Door end

@enum Direction NORTH, SOUTH, WEST, EAST

# Implicit interface which must be implemented by concrete factories
make_maze(factory::MazeFactory) = error("implement make_maze(", typeof(factory), ")")
make_wall(factory::MazeFactory) = error("implement make_wall(", typeof(factory), ")")

function make_room(factory::MazeFactory, n::Integer)
    error("implement make_room(", typeof(factory), ", n::Integer)")
end

function make_door(factory::MazeFactory, r1::Room, r2::Room)
    error("implement make_door(", typeof(factory), ", r1::Room, r2::Room)") 
end


struct EnchantedMazeFactory
    
end

function make_room(factory::EnchantedMazeFactory, n::Integer)
    EnchantedRoom(n, cast_spell())
end

function make_door(factory::MazeFactory, r1::Room, r2::Room)
    DoorNeedingSpell(r1, r1)
end


struct MazeGame
    
end

function create_maze(game::MazeGame, factory::MazeFactory)
    maze::Maze = make_maze(factory)
    r1::Room   = make_room(factory, 1)
    r2::Room   = make_room(factory, 1)
    door::Door = make_door(factory, r1, r2)

    add_room(maze, r1)
    add_room(maze, r2)

    set_side(r1, NORTH, make_wall(factory))
    set_side(r1, EAST, door)
    set_side(r1, SOUTH, make_wall(factory))
    set_side(r1, WEST, make_wall(factory))

    set_side(r2, NORTH, make_wall(factory))
    set_side(r2, EAST, make_wall(factory))
    set_side(r2, SOUTH, make_wall(factory))
    set_side(r2, WEST, door)    
end