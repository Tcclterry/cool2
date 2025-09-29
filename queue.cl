
class NewNode inherits Object {
    data : Object;
    next : NewNode;
    myInit(i : Object, n : NewNode) : NewNode {
        {
            data <- i;
            next <- n;
            self;
        }    
    };
    
    myGData() : Object { data };
    myGNext() : NewNode { next };
    mySetNext(n : NewNode) : SELF_TYPE {
        {
            next <- n;
            self;
        }
    };
};
class Queue inherits Object {
    front : NewNode;
    rear  : NewNode;
    myInitQueue() : SELF_TYPE {
        {
            let v1 : NewNode in front <- v1;
            let v2 : NewNode in rear  <- v2;
            self;
        }
    };
    myIsEmpty() : Bool { isvoid front };
    myEnqueue(data : Object) : SELF_TYPE {
        {
            let v : NewNode in
            let nNode : NewNode <- (new NewNode).myInit(data, v) in {
                if myIsEmpty() then {
                    front <- nNode;
                    rear  <- nNode;
                } else {
                    rear.mySetNext(nNode);
                    rear <- nNode;
                } fi;
            };
            self;
        }
    };
    myDequeue() : Object {
        if myIsEmpty() then {
            (new IO).out_string("Nothing in Queue\n");
        } else {
            let d : Object <- front.myGData() in {
                front <- front.myGNext();
                if myIsEmpty() then {
                    let v : NewNode in rear <- v;
                } else {
                    new Object;
                } fi;
                d;
            };    
        } fi
    };
    myFrontData() : Object {
        if myIsEmpty() then new Object
        else front.myGData() fi
    };
    myPrint() : Object {
        if myIsEmpty() then {
            (new IO).out_string("Nothing in Queue\n");
        } else {
            let tPoint : NewNode <- front in
            while not isvoid tPoint loop {
                case tPoint.myGData() of
                    s : String => (new IO).out_string(s);
                    i : Int    => (new IO).out_int(i);
                    o : Object => (new IO).out_string(o.type_name());
                esac;
                (new IO).out_string(" ");
                tPoint <- tPoint.myGNext();
            } pool;
        } fi
    };
    mySize() : Int {
        let count : Int <- 0, tPoint : NewNode <- front in {
            while not isvoid tPoint loop {
                count <- count + 1;
                tPoint <- tPoint.myGNext();
            } pool;
            count;
        }    
    };
};
class Main inherits IO {
    main() : Object {
        let demoQueue : Queue <- (new Queue).myInitQueue() in {
            demoQueue.myPrint(); 

            demoQueue.myEnqueue("firstone");
            demoQueue.myEnqueue(2);
            demoQueue.myEnqueue("3rd");
            demoQueue.myPrint(); 
            
            if demoQueue.myIsEmpty() then {
                out_string("Queue is empty, no front data\n");
            } else {
                out_string("Front: ");
                case demoQueue.myFrontData() of
                    s : String => out_string(s);
                    i : Int    => out_int(i);
                    o : Object => out_string(o.type_name());
                esac;
                out_string("\n");
            } fi;

            demoQueue.myDequeue();
            demoQueue.myPrint();

            demoQueue.myDequeue();
            demoQueue.myDequeue();
            demoQueue.myPrint(); 
        }
    };
};
