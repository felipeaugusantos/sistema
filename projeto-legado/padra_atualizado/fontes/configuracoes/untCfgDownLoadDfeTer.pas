unit untCfgDownLoadDfeTer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, untFuncoesSimples,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untPaiConfirma;

type
  TfrmCfgDownLoadDfeTer = class(TfrmPaiConfirma)
    chkSIM: TCheckBox;
    chkEVE: TCheckBox;
    grpCancel: TGroupBox;
    chkCAN: TCheckBox;
    chkENT: TCheckBox;
    pnlTit: TPanel;
    btnClose: TSpeedButton;
    procedure chkSIMClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  protected
    FValCfg: String;
  private
    { Private declarations }
    FIsUpdating: Boolean;
    function fNormalizeValCfg(const AValor: string): string;
    procedure pValCfgToCheckBox(const AValor: string);
    procedure pCheckBoxToValCfg;
    procedure HandleHierarchy(Sender: TObject);
  public
    { Public declarations }
    class function Execute(ACodCfg: String; var AValor: string; aClickPos: TPoint): Boolean;
  end;

implementation

{$R *.dfm}

{ TfrmCfgDownLoadDfeTer }

procedure TfrmCfgDownLoadDfeTer.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCfgDownLoadDfeTer.btnConfirmaClick(Sender: TObject);
begin
  pCheckBoxToValCfg;

  inherited;
end;

procedure TfrmCfgDownLoadDfeTer.chkSIMClick(Sender: TObject);
begin
  inherited;

  HandleHierarchy(Sender);
end;

class function TfrmCfgDownLoadDfeTer.Execute(ACodCfg: String; var AValor: string; aClickPos: TPoint): Boolean;
var
  LfrmCfgDownLoadDfeTer: TfrmCfgDownLoadDfeTer;
begin
  Result := False;
  pCriarFormularios(TfrmCfgDownLoadDfeTer, LfrmCfgDownLoadDfeTer);
  try
    LfrmCfgDownLoadDfeTer.chkSIM.Caption := IIF(Pos(ACodCfg, 'CFG_CTETER') > 0, 'CT-e', 'NF-e') + ' (ativar o download)';
    LfrmCfgDownLoadDfeTer.Position := poDesigned;
    LfrmCfgDownLoadDfeTer.Left := aClickPos.X - (LfrmCfgDownLoadDfeTer.Width div 2);
    LfrmCfgDownLoadDfeTer.Top  := aClickPos.Y - (LfrmCfgDownLoadDfeTer.Height div 2);

    LfrmCfgDownLoadDfeTer.pValCfgToCheckBox(AValor);
    if LfrmCfgDownLoadDfeTer.ShowModal = mrOk then
    begin
      AValor := LfrmCfgDownLoadDfeTer.FValCfg;
      Result := True;
    end;
  finally
    pFreeAndNil(LfrmCfgDownLoadDfeTer);
  end;
end;

function TfrmCfgDownLoadDfeTer.fNormalizeValCfg(const AValor: string): string;
var
  SL: TStringList;
  HasSim, HasAllCan, HasEntCan, HasAllEve: Boolean;
begin
  SL := TStringList.Create;
  try
    SL.Delimiter := '_';
    SL.StrictDelimiter := True;
    SL.DelimitedText := Trim(AnsiUpperCase(AValor));

    HasSim    := (Length(AValor) = 1) and (AValor = 'S');
    HasAllCan := SL.IndexOf('ALLCAN') >= 0;
    HasEntCan := SL.IndexOf('ENTCAN') >= 0;
    HasAllEve := SL.IndexOf('ALLEVE') >= 0;

    if (HasAllCan or HasEntCan or HasAllEve) and (not HasSim) then
      HasSim := True;

    if HasAllEve then
    begin
     if (not HasAllCan) And (not HasEntCan) Then
       HasAllCan := True;
    end;

    SL.Clear;
    if HasSim    then SL.Add('S');
    if HasAllCan then SL.Add('ALLCAN');
    if HasEntCan then SL.Add('ENTCAN');
    if HasAllEve then SL.Add('ALLEVE');

    if SL.Count = 0 then
      Result := 'N'
    else if (SL.Count = 1) and (SL[0] = 'S') then
      Result := 'S'
    else
      Result := StringReplace(SL.CommaText, ',', '_', [rfReplaceAll]);
  finally
    SL.Free;
  end;
end;

procedure TfrmCfgDownLoadDfeTer.FormCreate(Sender: TObject);
begin
  inherited;
  Position := poDesigned;
end;

procedure TfrmCfgDownLoadDfeTer.HandleHierarchy(Sender: TObject);
var
  chkCorrente,
  chkAntagoni: TCheckBox;

  procedure pMarcaCheckBoxAntagonista;
  begin
    if chkEVE.Checked then
      chkAntagoni.Checked := not chkCorrente.Checked
    else if chkCorrente.Checked and chkAntagoni.Checked then
      chkAntagoni.Checked := False;
  end;

begin
  if FIsUpdating then
    Exit;

  chkCorrente := Sender as TCheckBox;

  if (not chkCorrente.Checked) and (chkCorrente = chkSIM) then
  begin
    FIsUpdating := True;
    try
      chkSIM.Checked := False;
      chkCAN.Checked := False;
      chkENT.Checked := False;
      chkEVE.Checked := False;
    finally
      FIsUpdating := False;
    end;
    Exit;
  end;

  FIsUpdating := True;
  try
    if (chkCorrente = chkEVE) then
    begin
      if (not chkCAN.Checked) and (not chkENT.Checked) then
      Begin
        chkCAN.Checked := True;
        chkENT.Checked := False;
      End;
      chkSIM.Checked := True;
    end
    else if (chkCorrente = chkENT) then
    begin
      chkAntagoni := chkCAN;
      pMarcaCheckBoxAntagonista;

      chkSIM.Checked := True;
    end
    else if (chkCorrente = chkCAN) then
    begin
      chkAntagoni := chkENT;
      pMarcaCheckBoxAntagonista;

      chkSIM.Checked := True;
    end;
  finally
    FIsUpdating := False;
  end;
end;

procedure TfrmCfgDownLoadDfeTer.pCheckBoxToValCfg;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    if chkSIM.Checked then SL.Add('S');
    if chkCAN.Checked then SL.Add('ALLCAN');
    if chkENT.Checked then SL.Add('ENTCAN');
    if chkEVE.Checked then SL.Add('ALLEVE');

    if SL.Count = 0 then
      FValCfg := 'N'
    else
      FValCfg := StringReplace(SL.CommaText, ',', '_', [rfReplaceAll]);
  finally
    SL.Free;
    FValCfg := fNormalizeValCfg(FValCfg);
  end;
end;

procedure TfrmCfgDownLoadDfeTer.pValCfgToCheckBox(const AValor: string);
begin
  FValCfg := fNormalizeValCfg(AValor);

  chkSIM.Checked := FValCfg[1] = 'S';
  chkCAN.Checked := Pos('ALLCAN', FValCfg) > 0;
  chkENT.Checked := Pos('ENTCAN', FValCfg) > 0;
  chkEVE.Checked := Pos('ALLEVE', FValCfg) > 0;
end;

end.
