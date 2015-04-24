//
//  GameScene.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 17/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import SpriteKit
import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    // MARK: - Properties and Sprite Nodes
    //=======================================================================================

    // Rocket
    var rocket: SKSpriteNode = SKSpriteNode()
    var rocketTexture = SKTexture(imageNamed: "rocket")
    
    // Game Over
    var gameOverScreen: SKSpriteNode = SKSpriteNode()
    var gameOverMessage1: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    var gameOverMessage2: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    
    // Sky
    var sky1: SKSpriteNode = SKSpriteNode()
    var sky2: SKSpriteNode = SKSpriteNode()
    
    // Street
    var street1: SKSpriteNode = SKSpriteNode()
    var street2: SKSpriteNode = SKSpriteNode()
    
    // Obstacles
    var basicObstacle: Obstacle = Obstacle()
    var Obstacles: [Obstacle] = []
    var spaceTopBottom: Float = 250
    
    // Special Obstacles
    var indexSpecialObstacles: Int = 0
    var specialObstacles:
    [(year: String, text: String)] = [("1993","I was born in São Paulo city"),
                                      ("2011","Graduated as Technical Developer"),
                                      ("2012","Started study in Mackenzie University"),
                                      ("2013","Job as System Analyst in Stefanini"),
                                      ("2014","Job as COBOL Developer in Itau Bank"),
                                      ("2015","Started study iOS in MackMobile Project"),
                                      ("Now you can play for fun :)", "Enjoy it!")]
    
    // Messages for the Special Obstacles
    var messageYear: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    var messageText: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    
    // TimeLine
    var endTimeline: Bool = false
    
    // Range of obstacles
    var prevNum: Float = 0
    var maxRange: Float = 175
    var minRange: Float = -100
    
    // Score
    var score: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    var scoreInt: Int = 0
    
    // Speed of the game
    var speedGame: CGFloat = 3.0
    var speedMessage: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    
    // Game in motion
    var inMotion:Bool = false
    
    // Collisions
    var rocketCollision: UInt32 = 1
    var obstacleColission: UInt32 = 2
    
    //=======================================================================================
    
    
    
    // MARK: - Create World
    //=======================================================================================
    
    override func didMoveToView(view: SKView) // Create objects of the world
    {
        // Default Obstacle
        basicObstacle = Obstacle(color: UIColor.blackColor(), size: CGSize(width: (view.bounds.size.width) / 6, height: 480))
        
        // Game Over Screen
        gameOverScreen = SKSpriteNode(color: UIColor.grayColor(), size:CGSize(width:view.bounds.size.width, height:view.bounds.size.height))
        gameOverScreen.alpha = 0.7
        gameOverScreen.zPosition = 11
        gameOverScreen.position.x = view.bounds.size.width / 2
        gameOverScreen.position.y = view.bounds.size.height / 2
        
        // Game Over Message 1
        gameOverMessage1.position.x = 40
        gameOverMessage1.position.y = 430
        gameOverMessage1.text = "Oh no! You lost :("
        gameOverMessage1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        gameOverMessage1.zPosition = 11
        gameOverMessage1.fontSize = 30
        
        // Game Over Message 2
        gameOverMessage2.position.x = 40
        gameOverMessage2.position.y = 400
        gameOverMessage2.text = "Touch the screen and try again"
        gameOverMessage2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        gameOverMessage2.zPosition = 11
        gameOverMessage2.fontSize = 20
        
        // Speed Message
        speedMessage.position.x = 40
        speedMessage.position.y = 400
        speedMessage.text = "FASTER!"
        speedMessage.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        speedMessage.zPosition = 11
        speedMessage.fontSize = 30
        
        // Label Score
        score.position.x = 13
        score.position.y = view.bounds.size.height - 50
        score.text = "Score: 0"
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        score.hidden = true
        
        // Message 1 (Year)
        messageYear.position.x = 40
        messageYear.position.y = 500
        messageYear.text = ""
        messageYear.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        messageYear.hidden = true
        messageYear.fontSize = 25
        
        // Message 2 (Text)
        messageText.position.x = 40
        messageText.position.y = 470
        messageText.text = ""
        messageText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        messageText.hidden = true
        messageText.fontSize = 18
        
        // Street 1
        street1 = SKSpriteNode(imageNamed: "street")
        street1.size.width = view.bounds.width + 2
        street1.position.x = view.bounds.width * 0.5
        street1.position.y = street1.size.height * 0.4
        street1.texture?.filteringMode = SKTextureFilteringMode.Nearest
        street1.physicsBody = SKPhysicsBody(rectangleOfSize: street1.size)
        street1.physicsBody?.dynamic = false
        street1.zPosition = 10
        
        // Street 2
        street2 = SKSpriteNode(imageNamed: "street")
        street2.size.width = view.bounds.width + 2
        street2.position.x = view.bounds.width * 1.5
        street2.position.y = street2.size.height * 0.4
        street2.texture?.filteringMode = SKTextureFilteringMode.Nearest
        street2.physicsBody = SKPhysicsBody(rectangleOfSize: street2.size)
        street2.physicsBody?.dynamic = false
        street2.zPosition = 10
        
        // Sky 1
        sky1 = SKSpriteNode(imageNamed: "sky")
        sky1.xScale = 1.4
        sky1.yScale = 1.4
        sky1.position.x = view.bounds.width * 0.5
        sky1.position.y = 170
        sky1.texture?.filteringMode = SKTextureFilteringMode.Nearest
        
        // Sky 2
        sky2 = SKSpriteNode(imageNamed: "sky")
        sky2.xScale = 1.4
        sky2.yScale = 1.4
        sky2.position.x = view.bounds.width * 1.5
        sky2.position.y = 170
        sky2.texture?.filteringMode = SKTextureFilteringMode.Nearest
        
        // Rocket
        rocketTexture.filteringMode = SKTextureFilteringMode.Nearest
        rocket = SKSpriteNode(texture: rocketTexture)
        rocket.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        rocket.physicsBody?.dynamic = false
        rocket.physicsBody?.contactTestBitMask = rocketCollision
        rocket.physicsBody?.collisionBitMask = obstacleColission
        rocket.zPosition = 9
        rocket.position = CGPoint(x: 150, y: view.bounds.width / 2 - 10)
        
        // Gravity
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -4) // -5.0
        
        // Add objects (except Game Over Screen and Messages)
        self.addChild(sky1)
        self.addChild(sky2)
        self.addChild(street1)
        self.addChild(street2)
        self.addChild(score)
        self.addChild(rocket)
        self.addChild(messageYear)
        self.addChild(messageText)
    }
    //=======================================================================================
    
    
    
    // MARK: - Obstacles
    //=======================================================================================
    func createObstacles(distanceUpDown: Float) // distance that the obstacle will up or down
    {
        // Displacement between obstacles
        let setDistanceUpDown = distanceUpDown - spaceTopBottom / 2
        
        // Obstacles
        let obstacleBottom = basicObstacle.copy() as Obstacle
        let obstacleTop = basicObstacle.copy() as Obstacle
        
        // Position x -> end of the screen
        let xPositionEndScreen = self.view?.bounds.size.width
        
        // Remainder: 0 (obstacle wall or special) | 1 (obstacle building)
        var remainder: Int = (scoreInt % 2)
        
        
        //============================
        // SPECIAL OBSTACLES POSITION
        // - Birthday: 4 
        // - Einstein: 10
        // - Mackenzie: 16
        // - Stefanini: 22
        // - Itau: 28
        // - MackMobile: 34
        //============================
        
        
        // Create Bottom Obstacles (Wall, Building or Special)
        if (remainder == 0)
        {
            // Obstacle Special
            if (scoreInt ==  4 || scoreInt == 10 || scoreInt == 16 ||
                scoreInt == 22 || scoreInt == 28 || scoreInt == 34 ||
                scoreInt == 40)
            {
                obstacleBottom.texture = SKTexture(imageNamed: selectTexture(scoreInt))
                self.setPositionSpecialObstacle(obstacleBottom, obstacleNumber: scoreInt)
                showTexts()
            }
            // Obstacle Wall
            else
            {
                obstacleBottom.texture = SKTexture(imageNamed: "wall")
                self.setPositionBottomObstacle(obstacleBottom, x: Float(xPositionEndScreen!), y: setDistanceUpDown)
            }
        }
        // Obstacle Building
        else
        {
            obstacleBottom.texture = SKTexture(imageNamed: "building")
            self.setPositionBottomObstacle(obstacleBottom, x: Float(xPositionEndScreen!), y: setDistanceUpDown)
        }
        
        obstacleBottom.texture?.filteringMode = SKTextureFilteringMode.Nearest
        obstacleBottom.isBottom = true
        obstacleBottom.physicsBody = SKPhysicsBody(rectangleOfSize: obstacleBottom.size)
        obstacleBottom.physicsBody?.dynamic = false
        obstacleBottom.physicsBody?.contactTestBitMask = rocketCollision
        obstacleBottom.physicsBody?.collisionBitMask = rocketCollision
        
        Obstacles.append(obstacleBottom)
        self.addChild(obstacleBottom)
        
        
        // Create Top Obstacles (Cranes) - only if endTimeline = TRUE
        if (endTimeline == true)
        {
            obstacleTop.texture = SKTexture(imageNamed: "crane")
            obstacleTop.texture?.filteringMode = SKTextureFilteringMode.Nearest
            
            self.setPositionTopObstacle(obstacleTop, x: Float(xPositionEndScreen!), y: Float(Float(setDistanceUpDown) + Float(spaceTopBottom)))
            
            obstacleTop.physicsBody = SKPhysicsBody(rectangleOfSize: obstacleTop.size)
            obstacleTop.physicsBody?.dynamic = false
            obstacleTop.physicsBody?.contactTestBitMask = rocketCollision
            obstacleTop.physicsBody?.collisionBitMask = rocketCollision

            Obstacles.append(obstacleTop)
            self.addChild(obstacleTop)
        }
        
    }
    
    
    // Set Position of Obstacles (walls and buildings)
    func setPositionBottomObstacle(node: SKSpriteNode, x:Float, y:Float)
    {
        let xPosition = (Float(node.size.width) / 2) + x
        let yPosition = Float(self.view!.bounds.size.height) / 2 -  (Float(node.size.height) / 2 ) + y
        
        node.position.x = CGFloat(xPosition)
        node.position.y = CGFloat(yPosition)
    }
    
    
    // Set Position of Special Obstacles
    func setPositionSpecialObstacle(node: SKSpriteNode, obstacleNumber: Int)
    {
        if (obstacleNumber == 4)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115)
        }
        else if (obstacleNumber == 10)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115) // 36.5
        }
        else if (obstacleNumber == 16)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115)
        }
        else if (obstacleNumber == 22)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115)
        }
        else if (obstacleNumber == 28)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115)
        }
        else if (obstacleNumber == 34)
        {
            node.position.x = CGFloat(406.25)
            node.position.y = CGFloat(115)
        }
    }
    
    
    // Select Texture os Special Obstacles
    func selectTexture(obstacleNumber: Int) -> String
    {
        var textureName: String = ""
        
        if (obstacleNumber == 4)
        {
            textureName = "hospital"
        }
        else if (obstacleNumber == 10)
        {
            textureName = "highSchool"
        }
        else if (obstacleNumber == 16)
        {
            textureName = "university"
        }
        else if (obstacleNumber == 22)
        {
            textureName = "firstJob"
        }
        else if (obstacleNumber == 28)
        {
            textureName = "bank"
        }
        else if (obstacleNumber == 34)
        {
            textureName = "iosDevelopment"
        }

        return textureName
    }
    
    
    // Set Position of Top Obstacles (cranes)
    func setPositionTopObstacle (node: SKSpriteNode, x:Float, y:Float)
    {
        let xPosition = (Float(node.size.width) / 2) + x
        let yPosition = Float(self.view!.bounds.size.height) / 2 +  (Float(node.size.height) / 2 ) + y
        
        node.position.x = CGFloat(xPosition)
        node.position.y = CGFloat(yPosition)
    }
    
    
    // Generate Random Distance
    func randomDistanceUpDown() -> Float
    {
        let max = maxRange - prevNum
        let min = minRange - prevNum
        var randomNum1:  Float = Float(arc4random() % 61) + 40
        var randomNum2: Float = Float(arc4random() % 31) + 1
        
        if(randomNum2 % 2 == 0)
        {   var tempNum = prevNum + randomNum1
            if(tempNum > maxRange)
            {  tempNum = maxRange - randomNum1 }
            randomNum1 = tempNum
        }else
        {  var tempNum = prevNum - randomNum1
            if(tempNum < minRange)
            {   tempNum = minRange + randomNum1 }
            randomNum1 = tempNum
        }
        prevNum = randomNum1
        return randomNum1
    }
    //=======================================================================================
    
    
   
    // MARK: - Game
    //=======================================================================================
    
    // Touch the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        // Game start - first touch
        if((rocket.physicsBody?.dynamic) == false)
        {
            self.createObstacles(0)
            rocket.physicsBody?.dynamic = true
            rocket.physicsBody?.velocity = CGVectorMake(0, 500)
            inMotion = true
        }
        
        // Game in motion - second or more touch
        else if(inMotion)
        {
            var rocketSpeed: CGFloat = 300
            
            if(self.view!.bounds.size.height - rocket.position.y < 85)
            {
                rocketSpeed -= 85 - (self.view!.bounds.size.height - position.y )
            }
            
            rocket.physicsBody?.velocity = CGVectorMake(0, rocketSpeed)
        }
        
        // Restart after game over
        else
        {
            gameOverScreen.removeFromParent()
            gameOverMessage1.removeFromParent()
            gameOverMessage2.removeFromParent()
            
            for index in Obstacles
            {
                index.removeFromParent()
            }
            
            Obstacles.removeAll(keepCapacity: false)
            
            scoreInt = 0
            score.hidden = true
            
            rocket.physicsBody?.dynamic = false
            rocket.position = CGPoint(x: 150, y: view!.bounds.width / 2 - 10)
            
            messageYear.hidden = true
            messageText.hidden = true
            
            inMotion = false
        }
    }
    
    
    // Update
    override func update(currentTime: CFTimeInterval)
    {
        if(inMotion)
        {
            // Move sky to left
            sky1.position.x -= CGFloat(speedGame / 2)
            sky2.position.x -= CGFloat(speedGame / 2)
            
            if(sky1.position.x  <= (-view!.bounds.width / 2))
            {
                sky1.position.x = view!.bounds.width * 1.5 - 2
            }
            if(sky2.position.x <= -view!.bounds.width / 2)
            {
                sky2.position.x = view!.bounds.width * 1.5 - 2
            }
            
            // Move street to left
            street1.position.x -= speedGame
            street2.position.x -= speedGame
            
            if(street1.position.x <= -view!.bounds.width / 2)
            {
                street1.position.x = view!.bounds.width * 1.5 - 2
            }
            if(street2.position.x <= -view!.bounds.width / 2)
            {
                street2.position.x = view!.bounds.width * 1.5 - 2
            }
            
            
            for(var index = 0; index < Obstacles.count; index++)
            {
                let obstacle = Obstacles[index]
                
                // Update Score
                if(obstacle.position.x + (obstacle.size.width / 2) < rocket.position.x &&
                    obstacle.isBottom && !obstacle.pointed)
                {
                    scoreInt++
                    obstacle.pointed = true
                    
                    // Hide messages
                    if (scoreInt ==  7 || scoreInt == 13 || scoreInt == 19 ||
                        scoreInt == 25 || scoreInt == 31 || scoreInt == 37 ||
                        scoreInt == 45) // +3
                    {
                        messageYear.hidden = true
                        messageText.hidden = true
                    }
                    
                    // Start game after show the timeline
                    if (scoreInt == 43)
                    {
                        endTimeline = true
                        score.hidden = false
                    }
                    
                    // Change speed of the game
                    if (scoreInt == 63 || scoreInt == 93 || scoreInt == 123)
                    {
                        self.addChild(speedMessage)
                        speedGame = speedGame + 2
                    }
                    
                    // Hide speed message
                    if (scoreInt == 66 || scoreInt == 96 || scoreInt == 236)
                    {
                        speedMessage.removeFromParent()
                    }
                    
                }
                
                // Move obstacle to left
                obstacle.position.x -= speedGame
                
                // Create obstacle
                if(index == Obstacles.count - 1)
                {
                    if(obstacle.position.x < self.view!.bounds.width - obstacle.size.width * 2.0)
                    {
                        self.createObstacles(self.randomDistanceUpDown())
                    }
                }
            }
            
            
            // Update label score
            score.text = "Score: \(scoreInt - 43)"
            
            for(var index = 0; index < Obstacles.count; index++)
            {
                let obstacle = Obstacles[index]
                
                if (obstacle.position.x + (obstacle.size.width / 2) < 0)
                {
                    Obstacles.removeAtIndex(index)
                    obstacle.removeFromParent()
                    continue
                }
            }
            
        }
        
    }

    
    func showTexts()
    {
        messageYear.text = specialObstacles[indexSpecialObstacles].year
        messageText.text = specialObstacles[indexSpecialObstacles].text
        messageYear.hidden = false
        messageText.hidden = false
        indexSpecialObstacles++
    }
    
 
    // Collisions
    func didBeginContact(contact: SKPhysicsContact!)
    {
        // Game Over
        if(inMotion)
        {
            inMotion = false
        
            rocket.physicsBody?.velocity = CGVectorMake(0, 0 )
        
            for index in Obstacles
            {
                index.physicsBody = nil
            }
            
            // Show game over messages
            self.addChild(gameOverScreen)
            self.addChild(gameOverMessage1)
            self.addChild(gameOverMessage2)
            
            // Hide other messages
            speedMessage.removeFromParent()
            messageYear.hidden = true
            messageText.hidden = true
            
            indexSpecialObstacles = 0
            
            speedGame = 3.0
            
            endTimeline = false
        }
        else
        {
            rocket.physicsBody?.velocity = CGVectorMake(0, 0 )
        }
    }

    
}

//================================================================



// MARK: - Class Obstacle
//================================================================
class Obstacle: SKSpriteNode
{
    var isBottom: Bool = false
    var pointed: Bool = false
}
//================================================================
