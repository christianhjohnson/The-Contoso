Configuration HelloWorld {
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    Node 'localhost'{
        File HelloWorld{
            DestinationPath = "C:\temp\HelloWorld.txt"
            Ensure = "Present"
            Contents = "Hello World from DSC!"
        }
    }
}