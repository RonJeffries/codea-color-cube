displayMode(FULLSCREEN)

function setup()
    noSmooth()
    rectMode(CORNER)

    img=image(600,100)    
    setContext(img)
    fill(247, 22, 22, 30)

    rect(0,0,600,100)
    fontSize(40)
    fill(255,0,0)
    --rect(0,0,100,100)
    text("+X", 50, 50)
    fill(33, 255, 0, 255)
    --rect(100,0,100,100)
    text("+Z", 150,50)
    fill(22, 0, 255, 255)
    --rect(200,0,100,100)
    text("-X", 250,50)
    fill(255, 230, 0, 255)
    --rect(300,0,100,100)
    text("-Z", 350,50)
    fill(255, 0, 167, 255)
    --rect(400,0,100,100)
    text("+Y", 450, 50)
    fill(0, 255, 221, 255)
    --rect(500,0,100,100)
    text("-Y", 550,50)
    setContext()

    assert(OrbitViewer, "Please include Cameras (not Camera) as a dependency")

    scene = craft.scene()
    m = scene:entity()
    m.model = craft.model.cube(vec3(1,1,1))
    m.material = craft.material("Materials:Basic")
    m.material.blendMode = NORMAL
    m.material.map = img  
    local r = color(137, 255, 0, 200)
    --m.model.colors = {r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r}

    uvs1={}
    c=0
    for x=1,6 do
        table.insert(uvs1,vec2(c/6,1))
        table.insert(uvs1,vec2((c+1)/6,1))
        table.insert(uvs1,vec2((c+1)/6,0))
        table.insert(uvs1,vec2(c/6,0))
        c=c+1
    end
    m.model.uvs=uvs1
    for i,p in ipairs(m.model.positions) do
        --print(i,p)
    end
    
    print(#m.model.colors)
    print(m.model.colors[1])
    s = scene:entity()
    s.model = craft.model.cube(vec3(1,1,1)/10)
    s.material = craft.material("Materials:Basic")
    s.position = vec3(0.5, 0.5, 0.5)

    viewer = scene.camera:add(OrbitViewer, vec3(0), 10, 0, 2000)
    viewer.camera.farPlane=3000
    secs = ElapsedTime
end

function update(dt)
    time = ((math.floor(ElapsedTime - secs))%#s.model.positions) + 1
    pos = m.model.positions[time]
    --print(time,pos)
    s.position = pos
    scene:update(dt)
end

function draw()
    update(DeltaTime)
    scene:draw() 
    sprite(img,WIDTH/2,HEIGHT-100)   
end