var count = 0;
let nameCounter = 0;
var userResponsesArray = [];
let userName = "";
let ack;
var fs;
let theReplyMessage = "";
class Chatbox{
    constructor(theMessage){
        this.args = {
            //openButton: document.querySelector('.chatbox__button'),
            //chatBox: document.querySelector('.chatbox__support'),
            //sendButton: document.querySelector('.send__button')
        }

        this.state = false;
        this.messages = [];
        ack = false;
        this.theMessage = "";
    }
}
/*     display(){
        const {openButton, chatBox , sendButton} = this.args;

        openButton.addEventListener("click" , () => this.toggleState(chatBox))

        sendButton.addEventListener("click" , 

        const node = chatBox.querySelector("input");
        node.addEventListener("keyup", (key) => {
            if (key.code == "Enter"){
                
            }
        })
    }

    toggleState(chatbox){
        this.state = !this.state;
        if(this.state){
            chatbox.classList.add("chatbox--active")
            let msg2 = {name: "Sam", message: "Sanvadaya Aramba keereema sandahaa Obagea namma atulath karanna :) "}
            count = 0;
            this.messages.push(msg2);
            this.updateChatText(chatbox)
            textField.value = ""
            
        }else{
            chatbox.classList.remove("chatbox--active")
        }
    } */
function onSendButton(theMessage){
    return theMessage;
        //var textField = chatbox.querySelector("input");
        var textField = theMessage;
        let text1 = textField;
        if (text1 === ""){
            return;
        }
       /*  let fileContent = text1;
        fs.writeFileSync('UserResponses.txt', fileContent); */
  /*       let msg1 = {name: "User", message: text1}
        this.messages.push(msg1);
        this.updateChatText(chatbox)
        textField.value= ""

        let msg2 = {name: "Sam", message: "Do you have a nickname ?"}
        this.messages.push(msg2);
        this.updateChatText(chatbox)
        textField.value = "" */
        if (nameCounter == 0){
            userName = text1;
            nameCounter++;
        }
        const questions = ["Obage wayasa kopamana weiida ?",
                        userName + " , adha dhavasa obata kohomadha :) ?",
                        "Ada davase oyage wadda plan ekata anuwa wenavadda (wistratmakava pawasanna) ?",
                        "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha", 
                        "mona wagge contents da oyya facebook ekke wadiyenma dakkke ?",
                        userName + " , matta kiyanna Oya adda mona hari upset ekenda inne ?",
                        "adda davase obagae twitter baavitaya pilibandha yamak pawasanna...",
                        userName + " , oya mea welave hodinda inne ? :)",
                        "adda davasse oyage meal plan eka gana oya satis wenavadda ?",
                        "oya dinapatha sports walla yedenavada ?",
                        "adda davasse mea wenakun oyya kochara welavak films baluwada ? mona wage films da baluwe ?",
                        "oya films balanne kammali hinda da nattam karanna wadak nati hinda da ehemath nattam .... ?",
                        "oyya samanayen books kiyawanavada ? books dinapatha kiyaweema gana mokada hitanne ?",
                        userName + " , oyyage adda davasse goal ekuk tiyenavada ? ekka sampoorna kara ganna oyya lassthida ? :)",
                        "oya social media use karanne mona wage popurses walatada ?",
                        "matta kiyanna oyyge adda davasa gatta wenna vidiha ganna oya monna widihatada satis wenne? :)",
                        userName + " , avasanna washyen obata mona hari avul sahagata prashnayak / hageemak tibenum eya maa hata pawasanna, kenekta pawaseemen oabage manasa nidahas wenava :) ",
                        "Sanvadayata sambandha vunata godaaak stuthii.. obata Suba davasak weewwa " + userName + " !! Neerogiyawa sitinna :)"
        ];
       
        let msg1 = {name: "User", message: text1}
        this.messages.push(msg1);
        

        fetch($SCRIPT_ROOT + "/predict", {
            method: "POST",
            body: JSON.stringify({message: text1}),
            mode: "cors",
            headers: {
                "Content-Type": "application/json"
            },
        })
        .then(r => r.json())
        .then(r => {
            //let msg2 = {name: "Sam", message: r.answer};
            return "Yo yo wadda :)";
            if (count >= 7 && (text1 === "ow" || text1 === "oww")){
                //questions[count] = questions[count];
                let correctQuestion = questions[count];
                questions[count] = correctQuestion;
            }
            else {
                if (r.answer !== "Matta Therunne naha..."){
                   
                    if (r.answer == "Matta kiyanna oyya upset ekken inna hetuwa :)" && (count == 6)){
                        questions[count] = r.answer;
                    }else{
                        if(r.answer != "Matta kiyanna oyya upset ekken inna hetuwa :)"){
                            if(questions[count] != undefined){
                                questions[count] = r.answer + " " + questions[count];
                            }else{
                                questions[count] = r.answer;
                            }
                            
                        }else{
                            if(questions[count] != undefined){
                                questions[count] = questions[count];
                            }else{
                                questions[count] = r.answer;
                            }
                        }  
                    }
                    if(questions[count] === "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha"){
                        questions[count] = "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha";
                    }
                    if (questions[count] == 18){
                        questions[count] = ":)"
                        /* fs = require('fs');
                        let fileContent = userResponsesArray;
                        fs.appendFile('UserResponses.txt', fileContent); */
                    }
                    
                }else{
                    if (questions[count] == 18){
                        questions[count] = ":)"
                        /* fs = require('fs');
                        let fileContent = userResponsesArray;
                        fs.appendFile('UserResponses.txt', fileContent); */
                    }
                }
                  
            }
           
          /*   if (r.answer == "harii kamak naha :) matta kiyanna oyyge adda davasa gatta vunu vidiha ganna oya monna widihatada satis wenne?"){
                questions[count] = r.answer;
            } */

            if (r.answer == "hondai :) facebook use kalle nati vunata kamak naha "){
                questions[count] = r.answer + " " + questions[count+1];
            }

            if (questions[count] == undefined){
                questions[count] = ":)"
                /* fs = require('fs');
                let fileContent = userResponsesArray;
                fs.appendFile('UserResponses.txt', fileContent); */
            }
            theReplyMessage = questions.slice(count);
            let msg2 = {name: "Sam", message: questions[count]};
            this.messages.push(msg2);
            //this.updateChatText(chatbox)
            textField.value = ""

            if (count >= 7 && (text1 === "ow" || text1 === "oww")){
                //questions[count] = questions[count];
                count++;
            }
    /*         if(count == 3 && (text1 === "ow" || text1 === "oww")){
                count++;
            } */
            if (r.answer == "Matta kiyanna oyya upset ekken inna hetuwa :)" && (count == 6)){
                count--;
            }
          /*   if (r.answer == "harii kamak naha :) matta kiyanna oyyge adda davasa gatta vunu vidiha ganna oya monna widihatada satis wenne?"){
                count = count + 1;
            } */
            if (r.answer == "hondai :) facebook use kalle nati vunata kamak naha "){
                count++;
            }

            if(questions[count] === "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha"){
                count++;
            }
            count++;

            return theReplyMessage;
            
        }).catch((error) => {
            console.error("Error", error);
            this.updateChatText(chatbox)
            textField.value = ""
        }); 

        
    }

    function updateChatText(chatbox){
        var html = '';
        this.messages.slice().reverse().forEach(function(item, number){
            if (item.name === "Sam"){
                html += '<div class= "messages__item messages__item--visitor">' + item.message + '</div>'
            }
            else
            {
                html += '<div class= "messages__item messages__item--operator">' + item.message + '</div>'
                userResponsesArray.push(item.message);
            }
            
        });
        const chatmessage = chatbox.querySelector('.chatbox__messages');
        chatmessage.innerHTML = html;

        //const fs = require('fs');
     /*    if(this.messages.count >= 8){
            let fileContent = this.messages;
            fs.writeFileSync('UserResponses.txt', fileContent); 
        } */ 
    } 

   /*  writeUserResponses(theMessage){
        const fs = require('fs');
        if(theMessage.contains("obata Suba davasak weewwa !!")){
            let fileContent = userResponsesArray;
            fs.writeFileSync('UserResponses.txt', fileContent); 
        }
    } */


const chatbox = new Chatbox();
//chatbox.display();