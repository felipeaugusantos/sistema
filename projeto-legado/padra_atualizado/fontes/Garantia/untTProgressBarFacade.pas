unit untTProgressBarFacade;

interface
uses
 cxProgressBar,
 Vcl.Forms,
 Vcl.StdCtrls;

Type
  IProgressBarGenerico = Interface
  ['{11932197-0E5B-44CB-8001-E2B1F1502742}']
    function fGetProgressBar: TcxProgressBar;
  end;
  TProgressBarFacade = Class
  public
    class procedure pDefinir(const pIProgressBarGenerico: IProgressBarGenerico; pPosition: Double; pMin: Double = -1;
       pMax: Double = -1);
    class procedure pInfoStatusGravacao(const pIProgressBarGenerico: IProgressBarGenerico; pstrInformacao: String; pStep: Boolean = False);
    class procedure pStepStatusGravacao(const pIProgressBarGenerico: IProgressBarGenerico);

  end;


implementation

{ TProgressBarFacade }

class procedure TProgressBarFacade.pDefinir(const pIProgressBarGenerico: IProgressBarGenerico; pPosition: Double; pMin: Double = -1;
   pMax: Double = -1);
{$IFDEF LINUX}
{$ELSE}
Var
  lpgbProgresso: TcxProgressBar;
{$ENDIF}
begin
{$IFDEF LINUX}
{$ELSE}
  lpgbProgresso := pIProgressBarGenerico.fGetProgressBar;
  If Assigned(lpgbProgresso) Then
  Begin
    if pPosition >= 0 then
      lpgbProgresso.Position := pPosition;
    if pMax >= 0 then
      lpgbProgresso.Properties.Max := pMax;
  End;
{$ENDIF}
end;

class procedure TProgressBarFacade.pInfoStatusGravacao(const pIProgressBarGenerico: IProgressBarGenerico;
  pstrInformacao: String; pStep: Boolean = False);
{$IFDEF LINUX}
{$ELSE}
Var
  lpgbProgresso: TcxProgressBar;
{$ENDIF}
begin
{$IFDEF LINUX}
{$ELSE}
  lpgbProgresso := pIProgressBarGenerico.fGetProgressBar;
  If Assigned(lpgbProgresso) And (GetParentForm(lpgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(lpgbProgresso).FindComponent('lblGravando')).Caption := pstrInformacao;
    Application.ProcessMessages;
  End;

  if pStep then
    TProgressBarFacade.pStepStatusGravacao(pIProgressBarGenerico);
{$ENDIF}
end;

class procedure TProgressBarFacade.pStepStatusGravacao(const pIProgressBarGenerico: IProgressBarGenerico);
{$IFDEF LINUX}
{$ELSE}
Var
  lpgbProgresso: TcxProgressBar;
{$ENDIF}
begin
{$IFDEF LINUX}
{$ELSE}
  lpgbProgresso := pIProgressBarGenerico.fGetProgressBar;
  If Assigned(lpgbProgresso) Then
  Begin
    lpgbProgresso.Position := lpgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
{$ENDIF}
end;

end.



