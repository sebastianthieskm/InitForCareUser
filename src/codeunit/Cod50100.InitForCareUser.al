codeunit 50100 "InitForCareUser"
{
    procedure InitNow(var UserPar: Record User);
    var
        CompanyLoc: Record Company;
        UserSetupLoc: Record "User Setup";
        KMAssistanceGroupLoc: Record "KM Assistance Group";
        KMUserOrgStrucAssignmentLoc: Record "KM User Org.-Struc. Assignment";
    begin
        If CompanyLoc.FindSet() then
            repeat
                UserSetupLoc.Init();
                UserSetupLoc."User ID" := UserPar."User Name";
                EVALUATE(UserSetupLoc."Qualifying Period", '<2Y>');
                EVALUATE(UserSetupLoc."Retroactive Absence", '<2Y>');
                EVALUATE(UserSetupLoc."Dateformula Rep. Events", '<-CM>');
                EVALUATE(UserSetupLoc."Dateformula old Daily Register", '<-2Y>');
                if UserSetupLoc.Insert() then;
            until CompanyLoc.Next() = 0;

        if KMAssistanceGroupLoc.FindSet() then
            repeat
                KMUserOrgStrucAssignmentLoc.Init();
                KMUserOrgStrucAssignmentLoc."User ID" := UserPar."User Name";
                KMUserOrgStrucAssignmentLoc."Assistance Group Code" := KMAssistanceGroupLoc.Code;
                KMUserOrgStrucAssignmentLoc."Org.-Unit 1 Code" := KMAssistanceGroupLoc."Org.-Unit 1 Code";
                KMUserOrgStrucAssignmentLoc."Org.-Unit 2 Code" := KMAssistanceGroupLoc."Org.-Unit 2 Code";
                KMUserOrgStrucAssignmentLoc."Org.-Unit 3 Code" := KMAssistanceGroupLoc."Org.-Unit 3 Code";
                KMUserOrgStrucAssignmentLoc.Company := KMAssistanceGroupLoc.Company;
                KMUserOrgStrucAssignmentLoc."Source From Date" := 20000101D;
                KMUserOrgStrucAssignmentLoc."Source To Date" := 99991231D;
                if KMUserOrgStrucAssignmentLoc.Insert(true) then;
            until KMAssistanceGroupLoc.Next() = 0;
        Message('Fertig');
    end;


}