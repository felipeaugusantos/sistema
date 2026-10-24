unit untFmxDashboard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Ani, FMX.Effects,
  FMX.Styles, FMX.Filter, FMX.TextLayout, FMX.Types3D, FMX.Platform.Win,
  Winapi.Windows, untInterfacePlugin, untFrameBase, untDiasUteis, untPrzMed, FMX.Platform;

type
  TfmxDashboard = class(TForm)
    Rectangle2: TRectangle;
    Label1: TLabel;
    ShadowEffect1: TShadowEffect;
    lblComparativo: TLabel;
    lblMetasVendedor: TLabel;
    lblMetasEquipe: TLabel;
    fraPrzMed: TfraPrzMed;
    fraDiasUteis: TfraDiasUteis;
    VertScrollBox: TVertScrollBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lblComparativoClick(Sender: TObject);
    procedure lblMetasVendedorClick(Sender: TObject);
    procedure lblMetasEquipeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fraAtual: TfraBaseFrame;
    strNameTableTmp: String;

    procedure pCriaTabelaDias();
    procedure pDeletaTabelaDias();
    procedure pCarregaComparativo();
    procedure pCarregaMetas(blnEquipe: Boolean);

    function fGetNameTableTmp: String;
    function fGetCurrentDate: TDate;
    function fTableTmpExists(): Boolean;
  public
    qryAux: IQuery;
    strCodEmp: String;
    strLogOpe: String;
    procedure SetCursor(crCursor: TCursor);
  end;

var
  fmxDashboard: TfmxDashboard;

implementation

{$R *.fmx}

uses untComparativo, untMetas;

function TfmxDashboard.fGetCurrentDate: TDate;
begin
  qryAux.Close;
  qryAux.SQL.Text := 'SELECT CURRENT_TIMESTAMP AS HOJE';
  qryAux.Open;

  Result := qryAux.FieldValue('HOJE');
end;

function TfmxDashboard.fGetNameTableTmp: String;
begin
  Result := Concat('TMP_DIA', strLogOpe, IntToStr(Random(1000)),
    FormatDateTime('yyyyMMddhhmmss', fGetCurrentDate()))
end;

procedure TfmxDashboard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If fTableTmpExists() Then
    pDeletaTabelaDias();
  fraDiasUteis.qryAux := nil;
  fraAtual.qryAux := nil;
  qryAux := nil;
end;

procedure TfmxDashboard.FormCreate(Sender: TObject);
begin
  Left := 0;
  Top := 0;
  Width := Screen.WorkAreaWidth;
  Height := Screen.WorkAreaHeight;
end;

procedure TfmxDashboard.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key = vkEscape Then
    Close;
end;

procedure TfmxDashboard.FormShow(Sender: TObject);
begin
  pCriaTabelaDias();

  fraDiasUteis.qryAux    := qryAux;
  fraDiasUteis.strCodEmp := strCodEmp;
  fraDiasUteis.strLogOpe := strLogOpe;
  fraDiasUteis.pCarregaDados();

  If fraDiasUteis.blnDireitoGeral Then
  Begin
    lblMetasVendedor.Text := 'METAS GERAL';
    lblMetasEquipe.Visible := False;
  End
  Else
    lblMetasEquipe.Visible := fraDiasUteis.blnDireitoEquipe;

  If Not fraDiasUteis.blnUtilizaPrazoMedio Then
    fraPrzMed.Destroy
  Else
  Begin
    fraPrzMed.qryAux := qryAux;
    fraPrzMed.strLogOpe := strLogOpe;
    fraPrzMed.pCarregaDados();
  End;

  lblMetasVendedorClick(lblMetasVendedor);

  ShowWindow(ApplicationHWND, SW_HIDE);
end;

function TfmxDashboard.fTableTmpExists(): Boolean;
begin
  Try
    If (strNameTableTmp = '') Then
    Begin
      Result := False;
      Exit;
    End;

    qryAux.Close();
    qryAux.SQL.Add('DESC ' + strNameTableTmp);
    qryAux.Open();

    Result := True;
  Except
    On E: Exception do
    Begin
      Result := False;
    End;
  End;
end;

procedure TfmxDashboard.lblComparativoClick(Sender: TObject);
begin

  SetCursor(TCursor(crHourGlass));

  Try
    pCarregaComparativo();
    lblComparativo.FontColor   := $FF46AFA8;
    lblMetasVendedor.FontColor := $FF6B7181;
    lblMetasEquipe.FontColor   := $FF6B7181;
  Finally
    SetCursor(TCursor(crDefault));
  End;

end;

procedure TfmxDashboard.lblMetasVendedorClick(Sender: TObject);
begin

  SetCursor(TCursor(crHourGlass));

  Try
    pCarregaMetas(False);
    lblComparativo.FontColor   := $FF6B7181;
    lblMetasVendedor.FontColor := $FF46AFA8;
    lblMetasEquipe.FontColor   := $FF6B7181;
  Finally
    SetCursor(TCursor(crDefault));
  End;

end;

procedure TfmxDashboard.lblMetasEquipeClick(Sender: TObject);
begin

  SetCursor(TCursor(crHourGlass));

  Try
    pCarregaMetas(True);
    lblComparativo.FontColor   := $FF6B7181;
    lblMetasVendedor.FontColor := $FF6B7181;
    lblMetasEquipe.FontColor   := $FF46AFA8;
  Finally;
    SetCursor(TCursor(crDefault));
  End;

end;

procedure TfmxDashboard.pCarregaComparativo;
begin
  If Assigned(fraAtual) Then
  Begin
    fraAtual.qryAux := nil;
    FreeAndNil(fraAtual);
  End;

  fraAtual := TfraComparativo.Create(Self);
  fraAtual.Parent    := VertScrollBox;
  fraAtual.qryAux    := qryAux;
  fraAtual.strCodEmp := strCodEmp;
  fraAtual.strLogOpe := strLogOpe;
  fraAtual.strTabTmp := strNameTableTmp;

  If (Height > 768) Then
    fraAtual.Align := TAlignLayout.Client
  Else
  Begin
    fraAtual.Align := TAlignLayout.None;
    fraAtual.Width := Width;
  End;

  fraAtual.pCarregaDados();
end;

procedure TfmxDashboard.pCarregaMetas(blnEquipe: Boolean);
begin
  If Assigned(fraAtual) Then
  Begin
    fraAtual.qryAux := nil;
    FreeAndNil(fraAtual);
  End;

  fraAtual := TfraMetas.Create(Self, blnEquipe);
  fraAtual.Parent    := VertScrollBox;
  fraAtual.qryAux    := qryAux;
  fraAtual.strCodEmp := strCodEmp;
  fraAtual.strLogOpe := strLogOpe;
  fraAtual.strTabTmp := strNameTableTmp;
  fraAtual.pCarregaDados();
end;

procedure TfmxDashboard.pCriaTabelaDias;
begin
  repeat
    strNameTableTmp := fGetNameTableTmp();
  until (Not fTableTmpExists());

  Try
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add(' CREATE TABLE ' + strNameTableTmp + ' (           ');
    qryAux.SQL.Add('     DIA INTEGER,                                 ');
    qryAux.SQL.Add('     MES INTEGER,                                  ');
    qryAux.SQL.Add('     KEY IDX_' + strNameTableTmp + '_01 (DIA, MES)');
    qryAux.SQL.Add(' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1         ');

    qryAux.ExecSQL();
  Finally
    qryAux.SQL.Clear();
  End;
end;

procedure TfmxDashboard.pDeletaTabelaDias;
begin
  Try
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add('DROP TABLE ' + strNameTableTmp);

    qryAux.ExecSQL();
  Finally
    qryAux.SQL.Clear();
  End;
end;

procedure TfmxDashboard.SetCursor(crCursor: TCursor);
var
  CS: IFMXCursorService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXCursorService) then
  begin
    CS := TPlatformServices.Current.GetPlatformService(IFMXCursorService) as IFMXCursorService;
  end;
  if Assigned(CS) then
  begin
    CS.SetCursor(crCursor);
  end;
end;

end.
