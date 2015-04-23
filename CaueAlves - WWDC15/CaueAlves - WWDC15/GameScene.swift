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

//================================================================

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    // MARK: - Properties and Sprite Nodes
    //================================================================
    
    // Hero (character)
    var hero: SKSpriteNode = SKSpriteNode() // bird
    var HeroTexture = SKTexture(imageNamed: "hero") // TexturaPassaro
    
    // Scenery
    var gameOverScreen: SKSpriteNode = SKSpriteNode() // cobrir
    
    var background1: SKSpriteNode = SKSpriteNode() // Fundo1
    var background2: SKSpriteNode = SKSpriteNode() // Fundo2
    
    var floor1: SKSpriteNode = SKSpriteNode() // Chao1
    var floor2: SKSpriteNode = SKSpriteNode() // Chao2
    
    // Obstacles
    var basicObstacle: Obstacle = Obstacle() // TuboBase
    var spaceTopBottom: Float = 250 // Espaco - entre tubo de cima e de baixo
    var Obstacles: [Obstacle] = [] // Tubos array
    
    // Range os Obstacles
    var prevNum: Float = 0 // igual
    var maxRange: Float = 175 // igual
    var minRange: Float = -100 // igual
    
    // Score
    var score: SKLabelNode = SKLabelNode(fontNamed: "System-bold") // pontuacaoL
    var scoreInt: Int = 0 // pontuacao - em inteiro int
    
    // MENSAGEM
    var message: SKLabelNode = SKLabelNode(fontNamed: "System-bold")
    
    // Speed of the game
    var speedGame: CGFloat = 2.0 //2.0 velocidade
    
    // Game has started or not
    var inMotion:Bool = false // emMovimento
    
    // Collision
    var heroCollision: UInt32 = 1 // birdCategory
    var obstacleColission: UInt32 = 2 // pipeCategory
    
    // TimeLine
    var endTimeline: Bool = false
    
    
    // MARK: - didMoveToView
    //================================================================
    override func didMoveToView(view: SKView)
    {
        /******** Definir o tubo padrão com cor preta, largura igual a largura da
        //tela a dividir por 6, e altura de 480 ********/
        // Default size of the obstacle
        basicObstacle = Obstacle(color: UIColor.blackColor(), size: CGSize(width: (view.bounds.size.width) / 6, height: 480))
        
        /******* O Cobrir fica do tamanho da nossa tela, cor cinzenta meio transparente "alpha = 0.7" *******/
        // Size of the gameOverScreen - end of the game
        gameOverScreen = SKSpriteNode(color: UIColor.grayColor(), size:CGSize(width:view.bounds.size.width, height:view.bounds.size.height))
        gameOverScreen.alpha = 0.7
        /******* a posição Z é de 11 para que quando ela aparecer se sobreponha a tudo ********/
        gameOverScreen.zPosition = 11
        gameOverScreen.position.x = view.bounds.size.width / 2
        gameOverScreen.position.y = view.bounds.size.height / 2
        
        /****** A Label pontuação é colocada no canto superior esquerdo, mas para já fica escondida *******/
        // Size and position of label Score
        score.position.x = 13
        score.position.y = view.bounds.size.height - 50
        score.text = "0 %"
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        score.hidden = true
        
        
        ///\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
        message.position.x = 40
        message.position.y = 500
        message.text = ""
        message.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        message.hidden = true
        ///\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
        
        
        /***** No objecto Chão vamos colocar a imagem "Ground.png" ****/
        // Size and position of Floor1
        floor1 = SKSpriteNode(imageNamed: "floor")
        floor1.size.width = view.bounds.width + 2
        floor1.position.x = view.bounds.width * 0.5
        floor1.position.y = floor1.size.height * 0.4
        floor1.texture?.filteringMode = SKTextureFilteringMode.Nearest
        //O seu corpo fisico será do mesmo tamanho da imagem que iremos visualizar
        floor1.physicsBody = SKPhysicsBody(rectangleOfSize: floor1.size)
        //dynamic = false para que não reaja a colisões ou forças de gravidade
        floor1.physicsBody?.dynamic = false
        floor1.zPosition = 10
        
        /***** As duas variáveis Chao são quase iguais só diferencia a sua posição, enquanto
        // a primeira fica no centro do ecrã esta fica á direita do ecrã, com isto iremos
        // criar uma noção de movimento em que o cenário parece não acabar :)   ******/
        // Size and position of Floor2
        floor2 = SKSpriteNode(imageNamed: "floor")
        floor2.size.width = view.bounds.width + 2
        floor2.position.x = view.bounds.width * 1.5
        floor2.position.y = floor2.size.height * 0.4
        floor2.texture?.filteringMode = SKTextureFilteringMode.Nearest
        floor2.physicsBody = SKPhysicsBody(rectangleOfSize: floor2.size)
        floor2.physicsBody?.dynamic = false
        floor2.zPosition = 10
        
        /******* Os fundos seguem a mesma lógica do chão, para estes
        // vamos colocar a imagem "Background.png" ********/
        // Size and position of background1
        background1 = SKSpriteNode(imageNamed: "sky")
        background1.xScale = 1.4
        background1.yScale = 1.4
        background1.position.x = view.bounds.width * 0.5
        background1.position.y = 170
        background1.texture?.filteringMode = SKTextureFilteringMode.Nearest
        
        /******* Mesma logica do Chao2 ******/
        // Size and position of background1
        background2 = SKSpriteNode(imageNamed: "sky")
        background2.xScale = 1.4
        background2.yScale = 1.4
        background2.position.x = view.bounds.width * 1.5
        background2.position.y = 170
        background2.texture?.filteringMode = SKTextureFilteringMode.Nearest
        
        /********* Este filteringMode serve para ajustarmos o tamanho da imagem do passaro
        // ao seu objecto *******/
        // Texture of Hero
        HeroTexture.filteringMode = SKTextureFilteringMode.Nearest
        hero = SKSpriteNode(texture: HeroTexture)
        hero.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        //Para já e como o jogo ainda não começou vamos colocar o pássaro estatico
        hero.physicsBody?.dynamic = false
        hero.physicsBody?.contactTestBitMask = heroCollision
        hero.physicsBody?.collisionBitMask = obstacleColission
        hero.zPosition = 9
        hero.position = CGPoint(x: 150, y: view.bounds.width / 2 - 10)
        
        /***** Aqui colocamos a física do nosso mundo onde a gravidade vai ser y = -0.5 ****/
        // Gravity
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -4) // -5.0
        
        /****** Adicionar ao ecrã os objectos criados anteriormente menos o Cobrir
        // que apenas será colocado no fim do jogo ******/
        // Add objects (except gameOverScreen)
        self.addChild(background1)
        self.addChild(background2)
        self.addChild(floor1)
        self.addChild(floor2)
        self.addChild(score)
        self.addChild(hero)
        
        
        self.addChild(message)
    }
    //================================================================
    
    
    
    // MARK: - Create Obstacles
    //================================================================
    /******* Na spawnPipeRow temos um parâmetro de entrada offs que representa
    //quanto os tubos vão subir ou descer. (******/
    func createObstacles(distanceUpDown: Float) // distance that the obstacle will up or down
    {
        /**** Com base no offs e no Espaco podemos determinar o deslocamento exato do tubo. ****/
        // Displacement between obstacles
        let setDistanceUpDown = distanceUpDown - spaceTopBottom / 2
        //Declaração dos dois tubos
        let obstacleBottom = basicObstacle.copy() as Obstacle
        let obstacleTop = basicObstacle.copy() as Obstacle
        //A posição x onde termina a tela
        let xPositionEndScreen = self.view?.bounds.size.width
        
        /****** Aqui definimos para o tubo de baixo a imagem, se é um tubo de cima ou de baixo
        // e sua posição baseada no offset e no xx *******/
        
        // ObstacleBottom
        // image
        /****** A função SetRelativePositionBot será explicada mais a frente para já basta sabermos que tem o objectivo de colocar o nosso tubo no sitio certo *****/
        // position
        
        // /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
        var remainder: Int
        remainder = (scoreInt % 2)
        
        if (remainder == 0)
        {
            if (scoreInt == 4 || scoreInt == 10 || scoreInt == 16) // positions
            {
                obstacleBottom.texture = SKTexture(imageNamed: "obstacleMack") // special
                self.setSpecialPositionObstacle(obstacleBottom)
                message.text = "Special"
                message.hidden = false
            }
            else
            {
                obstacleBottom.texture = SKTexture(imageNamed: "obstacle") // predio
                self.setPositionObstacle(obstacleBottom, x: Float(xPositionEndScreen!), y: setDistanceUpDown)
            }
        }
        else
        {
            obstacleBottom.texture = SKTexture(imageNamed: "obstacleX1") // muro
            self.setPositionObstacle(obstacleBottom, x: Float(xPositionEndScreen!), y: setDistanceUpDown)
        }
        // \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
        
        obstacleBottom.texture?.filteringMode = SKTextureFilteringMode.Nearest
        obstacleBottom.isBottom = true
        
        /****** Definição das dimensões do seu corpo físico ******/
        // physicsBody
        obstacleBottom.physicsBody = SKPhysicsBody(rectangleOfSize: obstacleBottom.size)
        obstacleBottom.physicsBody?.dynamic = false
        obstacleBottom.physicsBody?.contactTestBitMask = heroCollision
        obstacleBottom.physicsBody?.collisionBitMask = heroCollision
        /****** Adicionamos o tubo ao nosso array *******/
        // add
        Obstacles.append(obstacleBottom)
        //E por fim adicionamos ao cenário
        self.addChild(obstacleBottom)
        
        
        
        // OBSTACLE TOP
        if (endTimeline == true){
            /******** Neste pedaço de código vamos repetir o mesmo a cima mas
            // para o tubo de cima. *******/
            // Obstacle Top
            // image
            obstacleTop.texture = SKTexture(imageNamed: "obstacleX2")
            obstacleTop.texture?.filteringMode = SKTextureFilteringMode.Nearest
            /****** Temos aqui uma variante no Y pois vamos adicionar ao offset o Espaco
            // assim ao seu deslocamento adicionamos mais o valor do espaço que
            // provocará o intervalo entre os 2 tubos *****/
            // position
            self.setPositionTopObstacle(obstacleTop, x: Float(xPositionEndScreen!), y: Float(Float(setDistanceUpDown) + Float(spaceTopBottom)))
            // physicsBody
            obstacleTop.physicsBody = SKPhysicsBody(rectangleOfSize: obstacleTop.size)
            obstacleTop.physicsBody?.dynamic = false
            obstacleTop.physicsBody?.contactTestBitMask = heroCollision
            obstacleTop.physicsBody?.collisionBitMask = heroCollision
            // add
            Obstacles.append(obstacleTop)
            self.addChild(obstacleTop)
        }
        
        
    }
    //================================================================
    
    
    
    // MARK: - Set Position of Obstacle
    //================================================================
    /****** Temos como parâmetros de entrada o tubo alvo, a posição x e y *****/
    func setPositionObstacle(node: SKSpriteNode, x:Float, y:Float) // obstacle, position x and y
    {
        /****** O x é fácil é o nosso parâmetro X mais metade da largura do nosso tubo,
        // temos de acrescentar metade da largura porque o tubo será criado a partir
        // do seu centro, logo teremos de dar um desconto. ******/
        let xPosition = (Float(node.size.width) / 2) + x
        //No y temos o centro da altura da tela mais o parâmetro Y mais metade
        // da altura como explicado anteriormente
        let yPosition = Float(self.view!.bounds.size.height) / 2 -  (Float(node.size.height) / 2 ) + y
        
        node.position.x = CGFloat(xPosition)
        node.position.y = CGFloat(yPosition)
    }
    
    func setSpecialPositionObstacle(node: SKSpriteNode) // obstacle
    {
        
        node.position.x = CGFloat(406.25)
        node.position.y = CGFloat(36.5)
    }
    
    // MARK: - Set Position of Top Obstacle
    //================================================================
    /****** Função SetRelativePositionTop igual a anterior mas para o tubo de cima *****/
    func setPositionTopObstacle (node: SKSpriteNode, x:Float, y:Float) // obstacle, position x and y
    {
        let xPosition = (Float(node.size.width) / 2) + x
        let yPosition = Float(self.view!.bounds.size.height) / 2 +  (Float(node.size.height) / 2 ) + y
        node.position.x = CGFloat(xPosition)
        node.position.y = CGFloat(yPosition)
    }
    //================================================================
    //================================================================

    

    // MARK: - touchesBegan
    //================================================================
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        /****** Se o Passaro tem physicsBody.dynamic = false então é o primeiro toque, e o vai iniciar-se ******/
        // Game start - first touch
        if((hero.physicsBody?.dynamic) == false) // First touch
        {
            /****** Chamar spawnPipeRow para crias os primeiros dois tubos *****/
            self.createObstacles(0)
            /****** Tornar o pássaro influenciável pelo ambiente ******/
            hero.physicsBody?.dynamic = true
            /**** Colocamos uma velocidade de 175 na vertical que fará o pássaro dar o primeiro salto *****/
            hero.physicsBody?.velocity = CGVectorMake(0, 500) // (0, 175)
            /****** Deixamos de esconder a label da pontuação *******/
//            score.hidden = false
            /***** Identificamos que o movimento do pássaro de iniciou *****/
            inMotion = true
        }
        
        // Game in motion - second or more touch
        else if(inMotion)
        {
            /****** Velocidade de salto por defeito de 200 *****/
            var heroSpeed: CGFloat = 300 // 200
            /******* Se o pássaro se encontrar perto do cimo reduzir a velocidade do salto ******/
            if(self.view!.bounds.size.height - hero.position.y < 85)
            {
                heroSpeed -= 85 - (self.view!.bounds.size.height - position.y )
            }
            hero.physicsBody?.velocity = CGVectorMake(0, heroSpeed)
        }
        
        /******* Se o jogo se encontrar parado por Game Over recomeçar de novo ****/
        // Restart after game over
        else
        {
            /***** Remover aTela que cobre o ecrã ****/
            gameOverScreen.removeFromParent()
            /**** Apagar todos os tubos no array da tela *****/
            for index in Obstacles
            {
                index.removeFromParent()
            }
            /**** E remover também do array ******/
            Obstacles.removeAll(keepCapacity: false)
            /***** Colocar pontuação a Zero ******/
            scoreInt = 0
            /***** E colocar Passaro com posição e definições de inicio de jogo ****/
            hero.physicsBody?.dynamic = false
            hero.position = CGPoint(x: 150, y: view!.bounds.width / 2 - 10)
            score.hidden = true
            message.hidden = true
            inMotion = false
        }
    }
    //================================================================
   
    
    
    // MARK: - update
    //================================================================
    override func update(currentTime: CFTimeInterval)
    {
        // Game in motion
        if(inMotion)
        {
            /****** Mover o fundo ligeiramente para a esquerda: o valor da velocidade/2 ******/
            /****** A velocidade é dividida por 2 para nos dar um efeito paralaxe no movimento *****/
            // Move background images to left
            background1.position.x -= CGFloat(speedGame / 2)
            background2.position.x -= CGFloat(speedGame / 2)
            
            /******* Aqui vamos controlar cada vez que um dos fundos sai da tela pela sua esquerda, *******/
            /******* vamos move-la instantaneamente para a direita da tela, para que esta comece ******/
            /******* a entrar pela direita. Parece confuso mas não é. ******/
            // Background images transition
            if(background1.position.x  <= (-view!.bounds.width / 2))
            {
                background1.position.x = view!.bounds.width * 1.5 - 2
            }
            if(background2.position.x <= -view!.bounds.width / 2)
            {
                background2.position.x = view!.bounds.width * 1.5 - 2
            }
            
            /****** O código seguinte segue a mesma lógica do fundo mas para o chão ******/
            // Move floor images to left
            floor1.position.x -= speedGame
            floor2.position.x -= speedGame
            
            // Background images transition
            if(floor1.position.x <= -view!.bounds.width / 2)
            {
                floor1.position.x = view!.bounds.width * 1.5 - 2
            }
            if(floor2.position.x <= -view!.bounds.width / 2)
            {
                floor2.position.x = view!.bounds.width * 1.5 - 2
            }
            
            /****** A cada um dos tubos criados ******/
            //
            for(var index = 0; index < Obstacles.count; index++)
            {
                let obstacle = Obstacles[index]
                
                /****** Se um tubo de baixo já passou pelo pássaro então somamos um ponto e marcamos o tubo para que não pontue mais */
                // Score points by passing obstacles
                if(obstacle.position.x + (obstacle.size.width / 2) < hero.position.x &&
                    obstacle.isBottom && !obstacle.pointed)
                {
//                    scoreInt = scoreInt + 3
                    scoreInt++
                    obstacle.pointed = true
                    
                    // 3 pts a mais que o scoreInt que faz o specialobstacle
                    // 4 10 16
                    if (scoreInt == 7 || scoreInt == 13 || scoreInt == 19)
                    {
                        message.hidden = true
                    }
                    
                    // comecar jogo
                    if (scoreInt == 20){
                        endTimeline = true
                        score.hidden = false
                    }
                }
                
                /******* Mover o tubo para a esquerda com a velocidade definida ****/
                // Move obstacle to left
                obstacle.position.x -= speedGame
                /******** Se temos tubos a menos e já está na altura de criar novos tubos então ******/
                // Create obstacle with random DistanceUpDown
                if(index == Obstacles.count - 1)
                {
                    if(obstacle.position.x < self.view!.bounds.width - obstacle.size.width * 2.0)
                    {
                        //Criamos novos tubos com um Offset aleatório
                        self.createObstacles(self.randomDistanceUpDown())
                    }
                }
            }
            
            /******* Atualizamos a label pontuação *****/
            // Update label score
            score.text = "Score: \(scoreInt - 20)"
            
            for(var index = 0; index < Obstacles.count; index++)
            {
                let obstacle = Obstacles[index]
                
                /****** Se tubo ja saiu da tela será apagado *****/
                // Remove obstacle from array when it disappeared
                if (obstacle.position.x + (obstacle.size.width / 2) < 0)
                {
                    Obstacles.removeAtIndex(index)
                    obstacle.removeFromParent()
                    continue
                }
            }
            
        }
        
    }
    //================================================================
    
    
    
    // MARK: - Collision - didBeginContact
    //================================================================
    func didBeginContact(contact: SKPhysicsContact!)
    {
        if(inMotion)
        {
            /***** Paramos o movimento ****/
            inMotion = false
            /*** Paramos o pássaro ****/
            hero.physicsBody?.velocity = CGVectorMake(0, 0 )
            /***** Eliminamos os tubos ****/
            for index in Obstacles
            {
                index.physicsBody = nil
            }
            /***** E por fim cobrir o ecrã com a tela cinzenta *****/
            self.addChild(gameOverScreen)
        }
        else
        {
            hero.physicsBody?.velocity = CGVectorMake(0, 0 )
        }
    }
    //================================================================
    
    
    
    // MARK: - get Random distance Up and Down of the obstacles
    //================================================================
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
