var nameCounter = 0;
var count = 0;
var userResponsesArray = [];
var userName = "";
var ack;
var fs;
var theReplyMessage = "";

function onSendButton(message_user,count_question,count_name){
/*     var theResult = "there we go " + theyup + " :) " + count + " yoo";
    count++;
    return theResult; */
    var textField = message_user;
        let text1 = textField;
        if (text1 === ""){
            return;
        }
        nameCounter = count_name;
        count = count_question;
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
        //this.messages.push(msg1);
        

        fetch("http://127.0.0.1:5000" + "/predict", {
            method: "POST",
            body: JSON.stringify({message: text1}),
            mode: "cors",
            headers: {
                "Content-Type": "application/json"
            },
        })
        .then(r => r.json())
        .then(r => {
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
                  
                    }
                    
                }else{
                    if (questions[count] == 18){
                        questions[count] = ":)"
            
                    }
                }
                  
            }
           

            if (r.answer == "hondai :) facebook use kalle nati vunata kamak naha "){
                questions[count] = r.answer + " " + questions[count+1];
            }

            if (questions[count] == undefined){
                questions[count] = ":)"
            
            }
            theReplyMessage = questions[count];
            let msg2 = {name: "Sam", message: questions[count]};
            //this.messages.push(msg2);
    
            textField.value = ""

            if (count >= 7 && (text1 === "ow" || text1 === "oww")){
                count++;
            }
   
            if (r.answer == "Matta kiyanna oyya upset ekken inna hetuwa :)" && (count == 6)){
                count--;
            }
     
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