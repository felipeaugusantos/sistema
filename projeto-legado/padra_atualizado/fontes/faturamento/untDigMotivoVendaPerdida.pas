unit untDigMotivoVendaPerdida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus, EditFocus, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmDigMotivoVendaPerdida = class(TfrmPai)
    pnlGeral: TPanel;
    lblMotivo: TLabel;
    edtCodMot: TEditFocus;
    edtDesMot: TEditFocus;
    Label1: TLabel;
    memObservacoes: TMemoFocus;
    btnConfirmaDados: TBitBtnLocked;
    pnlConcorrencia: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodCon: TEditFocus;
    edtDesCon: TEditFocus;
    edtVlrCon: TEditFocus;
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodConKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function fMotivoInformaConcorrencia(strCodMot: string): Boolean;
  public
    strCodCon,
    strCodMot,
    strDesMot,
    strObservacoes: String;
    fltVlrCon: Double;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDigMotivoVendaPerdida: TfrmDigMotivoVendaPerdida;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema, untCadConcorrencia;

{ TfrmDigMotivoVendaPerdida }

procedure TfrmDigMotivoVendaPerdida.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    strCodMot := edtCodMot.Text;
    strDesMot := edtDesMot.Text;
    strObservacoes := memObservacoes.Texto;

    if pnlConcorrencia.Visible then
    begin
      strCodCon := edtCodCon.Text;
      fltVlrCon := StrToFloatDef(AnsiReplaceStr(edtVlrCon.Text,'.',''), 0);
    end
    else
    begin
      strCodCon := EmptyStr;
      fltVlrCon := 0;
    end;

    ModalResult := mrOk;
  End;
end;

procedure TfrmDigMotivoVendaPerdida.edtCodConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrConcorrencia: TConsultasArray;
begin
  inherited;
  if fPesqConcorrencia(Self, edtCodCon, edtDesCon, Nil, Key, arrConcorrencia) then
  begin
    if fValidaCampos(edtCodCon, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmDigMotivoVendaPerdida.edtCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMotivo: TConsultasArray;
begin
  inherited;
  If fPesqMotVendasPerdidas(Self, edtCodMot, edtDesMot, Nil, Key, arrMotivo) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigMotivoVendaPerdida.fMotivoInformaConcorrencia(
  strCodMot: string): Boolean;
var
  qryMotivo: TUniQuery;
begin
  Result := False;
  qryMotivo := fCriaQuery;

  try
    qryMotivo.Close;
    qryMotivo.SQL.Clear;
    qryMotivo.SQL.Add('SELECT MOT_INFCON');
    qryMotivo.SQL.Add('FROM MOTVPD');
    qryMotivo.SQL.Add('WHERE MOT_CODMOT = :CODMOT');

    qryMotivo.ParamByName('CODMOT').AsString := strCodMot;

    qryMotivo.Open;

    if (not qryMotivo.IsEmpty) and (qryMotivo.FieldByName('MOT_INFCON').AsString = 'S') then
    begin
      Result := True;
    end;
  finally
    FreeAndNil(qryMotivo);
  end;
end;

procedure TfrmDigMotivoVendaPerdida.FormActivate(Sender: TObject);
begin
  inherited;
  edtVlrCon.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  pSetFocus(edtCodMot);
end;

procedure TfrmDigMotivoVendaPerdida.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  frmCadConcorrenciaLocal: TfrmCadConcorrencia;
begin
  inherited;
  if (edtCodCon.Focused) then
  begin
    if (Key = VK_INSERT) then
    begin
      pCriarFormularios(TfrmCadConcorrencia, frmCadConcorrenciaLocal);
      try
        frmCadConcorrenciaLocal.ShowModal;
      finally
        pFreeAndNil(frmCadConcorrenciaLocal);
      end;
    end;
  end;
end;

function TfrmDigMotivoVendaPerdida.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtCodMot Then
  Begin
    If fEmptyStr(edtCodMot.Text) Then
    Begin
      fMensagem('', 'O motivo deve ser preenchido!' , ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesMot.Text := fRetMotivoVendasPerdidas(edtCodMot.Text);
      If fEmptyStr(edtDesMot.Text) Then
      Begin
        fMensagem('AVISO', 'Motivo de venda perdida não encontrado!', ['&Ok']);
        Result := False;
      End;
      pnlConcorrencia.Visible := fMotivoInformaConcorrencia(edtCodMot.Text);
    End;
  End
  Else If (pnlConcorrencia.Visible) And (Sender = edtCodCon) Then
  Begin
    If (fEmptyStr(edtCodCon.Text)) Then
    Begin
      fMensagem('', 'A concorrência deve ser preenchida!' , ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesCon.Text := fRetDesConcorrencia(edtCodCon.Text);
      If (fEmptyStr(edtDesCon.Text)) Then
      Begin
        fMensagem('AVISO', 'Concorrência não encontrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  Else If (pnlConcorrencia.Visible) And (Sender = edtVlrCon) Then
  Begin
    If (StrToFloatDef(AnsiReplaceStr(edtVlrCon.Text,'.',''), 0) <= 0) Then
    Begin
      fMensagem('', 'Valor deve ser maior que zero!' , ['&Ok']);
      Result := False;
    End;
  End;

  If (not Result) Then
  Begin
    pSetFocus(Sender);
  End;
end;

end.
