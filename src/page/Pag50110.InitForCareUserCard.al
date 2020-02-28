page 50110 "InitForCareUserCard"
{

    PageType = StandardDialog;
    Caption = 'InitForCareUserCard';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SelectedUserName; SelectedUserNameGlob)
                {
                    ApplicationArea = All;
                    trigger OnLookUp(var textPar: Text): Boolean
                    var
                        UserLoc: Record User;
                        InitForCareUserLoc: Codeunit InitForCareUser;
                    begin
                        if Page.RunModal(Page::"Users", UserLoc) = Action::LookupOK then begin
                            InitForCareUserLoc.InitNow(UserLoc);
                        end;
                    end;
                }

            }
        }
    }
    var
        SelectedUserNameGlob: Code[50];

}
