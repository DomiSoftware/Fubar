program Fubar;

uses
  System.StartUpCopy,
  FMX.Forms,
  mu in 'mu.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
