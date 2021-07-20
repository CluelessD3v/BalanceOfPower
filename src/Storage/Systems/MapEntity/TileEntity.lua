local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')


local Tile = {} 
Tile.__index = Tile

function Tile.new()
    local self = setmetatable({}, Tile)
    self.GameObject = Instance.new("Part")
    
    
    CollectionService:AddTag(self.GameObject, "Tile")

        
    return self
end
    

-- private functions
local function RemoveMetadata(self)
    local oldTags = CollectionService:GetTags(self.GameObject)
    local oldAttributes = self.GameObject:GetAttributes()

    for attribute, _ in pairs(oldAttributes) do
        self.GameObject:SetAttribute(attribute, nil)
    end

    for _, tag in ipairs (oldTags) do
        CollectionService:RemoveTag(self.GameObject, tag)
    end
end


-- Public Methods
--//TODO Check about Listenning for attribute changes

-- Automatically sets metadata to tile from the terrain types table
function Tile:InitMetadata(theNoiseResult: number, theTerrainTypesTable: table)

    for i = 1, #theTerrainTypesTable -1 do
        local this = theTerrainTypesTable[i] -- current value in the list
        local next = theTerrainTypesTable[i + 1]   -- next value in the list
        
        -- this is an If statement to check if we are in rangeBTW
        if theNoiseResult >= this.Threshold and theNoiseResult <= next.Threshold then
            this.Properties = this.Properties or {}
            this.Tags = this.Tags or {} 
            this.Attributes = this.Attributes or {}
            for property, value in pairs(this.Properties) do
                self.GameObject[property] = value
            end

            for attribute, value in pairs(this.Attributes) do
                self.GameObject:SetAttribute(attribute, value)
            end

            for _, tag in ipairs (this.Tags) do
                CollectionService:AddTag(self.GameObject, tag)
            end 
        end
    end


end

--  OverWrites existing data!
function Tile:SetMetadata(newTerrainDataTable)
    newTerrainDataTable.Attributes = newTerrainDataTable.Attributes or {}
    newTerrainDataTable.Properties = newTerrainDataTable.Properties or {} 
    newTerrainDataTable.Tags = newTerrainDataTable.Tags or {}  
    
    RemoveMetadata(self)
    
    -- reseting tile tag
    CollectionService:AddTag(self.GameObject, "Tile")

    for property, value in pairs(newTerrainDataTable.Properties) do
        self.GameObject[property] = value
    end

    for attribute, value in pairs(newTerrainDataTable.Attributes) do
        self.GameObject:SetAttribute(attribute, value)
    end

    for _, tag in ipairs (newTerrainDataTable.Tags) do
        CollectionService:AddTag(self.GameObject, tag)
    end
end

-- Updates existing data w/o removing existing data
function Tile:UpdateMetaData(newTerrainDataTable)
    newTerrainDataTable.Attributes = newTerrainDataTable.Attributes or {}
    newTerrainDataTable.Properties = newTerrainDataTable.Properties or {} 
    newTerrainDataTable.Tags = newTerrainDataTable.Tags or {}  

    -- Updating Data tile tag
    CollectionService:AddTag(self.GameObject, "Tile")

    for property, value in pairs(newTerrainDataTable.Properties) do
        self.GameObject[property] = value
    end

    for attribute, value in pairs(newTerrainDataTable.Attributes) do
        self.GameObject:SetAttribute(attribute, value)
    end

    for _, tag in ipairs (newTerrainDataTable.Tags) do
        CollectionService:AddTag(self.GameObject, tag)
    end
end


return Tile