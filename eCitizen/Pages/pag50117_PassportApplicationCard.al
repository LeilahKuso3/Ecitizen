page 50117 "Passport Application Card"
{
    PageType = Card;
    SourceTable = "Passport Application Header";
    ApplicationArea = All;
    Caption = 'Passport Application Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field("Applicant ID No."; Rec."Applicant ID No.") { }
                field("First Name"; Rec."First Name") { }
                field("Last Name"; Rec."Last Name") { }
                field("Date of Birth"; Rec."Date of Birth") { }
            }

            group(Contact)
            {
                field("Phone No."; Rec."Phone No.") { }
                field("Email"; Rec."Email") { }
            }
            part(Attachments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                SubPageLink =
                    "Table ID" = const(Database::"Passport Application Header"),
                    "No." = field("No.");
            }

            // =========================
            // 👤 Additional Personal Info
            // =========================
            group("Additional Personal Information")
            {
                field("Place of Birth"; Rec."Place of Birth") { }
                field(Occupation; Rec.Occupation) { }
                field("Employment Status"; Rec."Employment Status") { }
                field(Religion; Rec.Religion) { }
            }

            // =========================
            // 🚨 Emergency Contact
            // =========================
            group("Emergency Contact")
            {
                field("Emergency Contact Name"; Rec."Emergency Contact Name") { }
                field("Emergency Contact Phone"; Rec."Emergency Contact Phone") { }
                field("Emergency Contact Relationship"; Rec."Emergency Contact Relationship") { }
                field("Emergency Contact Address"; Rec."Emergency Contact Address") { }
            }

            part(Documents; "Passport Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = field("No.");
            }

            group(Application)
            {
                field("Application Date"; Rec."Application Date") { }
                field("Passport Type"; Rec."Passport Type") { }
                field(Amount; Rec.Amount) { }
                field(Status; Rec.Status) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenAttachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;

                trigger OnAction()
                var
                    DocAttachment: Record "Document Attachment";
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                begin
                    DocAttachment.SetRange("Table ID", Database::"Passport Application Header");
                    DocAttachment.SetRange("No.", Rec."No.");

                    DocumentAttachmentDetails.SetTableView(DocAttachment);
                    DocumentAttachmentDetails.RunModal();
                end;
            }

            action(SubmitApplication)
            {
                ApplicationArea = All;
                Caption = 'Submit Application';
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    PassportDocument: Record "Passport Document Line";
                begin
                    PassportDocument.SetRange("Application No.", Rec."No.");

                    if PassportDocument.IsEmpty() then
                        Error('Please add the required documents before submitting the application.');

                    Rec.UpdateCompletionPercentage();

                    if Rec."Completion %" < 100 then
                        Error(
                            'Application is only %1%% complete. All required documents must be submitted.',
                            Rec."Completion %");

                    if Rec.Status <> Rec.Status::Open then
                        Error('Only Open applications can be submitted.');

                    Rec.Status := Rec.Status::Submitted;
                    Rec.Modify(true);

                    Message('Application submitted successfully.');
                end;
            }

            action(ReviewApplication)
            {
                Caption = 'Send to Review';
                ApplicationArea = All;
                Image = ViewDetails;

                trigger OnAction()
                var
                    PassportDocument: Record "Passport Document Line";
                begin
                    PassportDocument.SetRange("Application No.", Rec."No.");
                    PassportDocument.SetRange(Submitted, false);

                    if not PassportDocument.IsEmpty() then
                        Error('All required documents must be submitted for the application to be submitted.');

                    Rec.Status := Rec.Status::Submitted;
                    Rec.Modify(true);

                    Message('Application submitted successfully.');
                end;
            }

            action(ApproveApplication)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::UnderReview then
                        Error('Only applications under review can be approved.');

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);

                    Message('Application approved.');
                end;
            }
        }
    }
}