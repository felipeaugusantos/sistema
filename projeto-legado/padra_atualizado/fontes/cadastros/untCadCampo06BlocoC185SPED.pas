unit untCadCampo06BlocoC185SPED;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Uni, MaskEditFocus, StrUtils;

type
  TfrmCadCampo06BlocoC185SPED = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    dbeCodCST: TDBEditFocus;
    dbeCODCFO: TDBEditFocus;
    Label10: TLabel;
    edtCST: TEditFocus;
    btnIncluiCST: TBitBtnLocked;
    btnRemoveCST: TBitBtnLocked;
    Label3: TLabel;
    edtCFOP: TEditFocus;
    btnIncluiCFOP: TBitBtnLocked;
    btnRemoveCFOP: TBitBtnLocked;
    edtDtaIni: TMaskEditFocus;
    edtDtaFin: TMaskEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluiCSTClick(Sender: TObject);
    procedure btnRemoveCSTClick(Sender: TObject);
    procedure btnIncluiCFOPClick(Sender: TObject);
    procedure btnRemoveCFOPClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadCampo06BlocoC185SPED.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  edtCST.Clear;
  edtCFOP.Clear;
  edtDtaIni.Enabled := True;
  edtDtaFin.Enabled := True;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtCST.Clear;
  edtCFOP.Clear;

  If (Not qryTabela.IsEmpty) And (Not fEmptyStr(qryTabela.FieldByName('B06_DTAINI').AsString)) Then
    edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('B06_DTAINI').AsDateTime)
  Else
    edtDtaIni.Clear;

  If (Not qryTabela.IsEmpty) And (Not fEmptyStr(qryTabela.FieldByName('B06_DTAFIN').AsString)) Then
    edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('B06_DTAFIN').AsDateTime)
  Else
    edtDtaFin.Clear;

  edtDtaIni.Enabled := False;
  edtDtaFin.Enabled := False;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtCST.Clear;
  edtCFOP.Clear;
  edtDtaIni.Clear;
  edtDtaFin.Clear;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnGravarClick(Sender: TObject);
begin
  if not fVerificaCampos then
  begin
    Exit;
  end;

  If Not fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)) Then
    qryTabela.FieldByName('B06_DTAINI').AsDateTime := StrToDateTime(edtDtaIni.Text)
  Else
    qryTabela.FieldByName('B06_DTAINI').Clear;

  If Not fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text)) Then
    qryTabela.FieldByName('B06_DTAFIN').AsDateTime := StrToDateTime(edtDtaFin.Text)
  Else
    qryTabela.FieldByName('B06_DTAFIN').Clear;

  edtCST.Clear;
  edtCFOP.Clear;
  edtDtaIni.Enabled := False;
  edtDtaFin.Enabled := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnIncluiCFOPClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCFOP.Text) then
  begin
    if Length(edtCFOP.Text) = 4 then
    begin
      if Pos(edtCFOP.Text, dbeCodCFO.Text) <= 0 then
        dbeCodCFO.Text := dbeCodCFO.Text + IIF(fEmptyStr(dbeCodCFO.Text), '', '_') + edtCFOP.Text;
    end;
  end;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnRemoveCFOPClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCFOP.Text) then
  begin
    if Length(edtCFOP.Text) = 4 then
    begin
      if Pos(edtCFOP.Text, dbeCodCFO.Text) > 0 then
        dbeCodCFO.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(dbeCodCFO.Text, '_' + edtCFOP.Text, ''), edtCFOP.Text + '_', ''), edtCFOP.Text, '');
    end;
  end;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnIncluiCSTClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCST.Text) then
  begin
    if Length(edtCST.Text) = 2 then
    begin
      if Pos(edtCST.Text, dbeCodCST.Text) <= 0 then
        dbeCodCST.Text := dbeCodCST.Text + IIF(fEmptyStr(dbeCodCST.Text), '', '_') + edtCST.Text;
    end;
  end;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnRemoveCSTClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCST.Text) then
  begin
    if Length(edtCST.Text) = 2 then
    begin
      if Pos(edtCST.Text, dbeCodCST.Text) > 0 then
        dbeCodCST.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(dbeCodCST.Text, '_' + edtCST.Text, ''), edtCST.Text + '_', ''), edtCST.Text, '');
    end;
  end;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  edtCST.Clear;
  edtCFOP.Clear;
  edtDtaIni.Clear;
  edtDtaFin.Clear;
  edtDtaIni.Enabled := True;
  edtDtaFin.Enabled := True;
end;

procedure TfrmCadCampo06BlocoC185SPED.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  Key   : Char;
begin
  Key := '/';
  If fPesqCampo06BlocoC185SPED(Self, dbeCodigo, nil, qryTabela, Key, arrSel) then
  Begin
    If fEmptyStr(qryTabela.FieldByName('B06_DTAINI').AsString) Then
      edtDtaIni.Clear
    Else
      edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('B06_DTAINI').AsDateTime);

    If fEmptyStr(qryTabela.FieldByName('B06_DTAFIN').AsString) Then
      edtDtaFin.Clear
    Else
      edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('B06_DTAFIN').AsDateTime);

    edtCST.Clear;
    edtCFOP.Clear;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCampo06BlocoC185SPED.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADB06';
  strNomeCampo      := 'B06_CODIGO';

  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadCampo06BlocoC185SPED.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  inherited;
end;

procedure TfrmCadCampo06BlocoC185SPED.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('B06_CODIGO');
  stlCampos.Add('B06_DESCRI');
  stlCampos.Add('B06_CODCST');
  stlCampos.Add('B06_CODCFO');
  stlCampos.Add('B06_DTAINI');
  stlCampos.Add('B06_DTAFIN');

  stlCamInd.Add('B06_CODIGO');
  stlCamInd.Add('B06_DESCRI');
  stlCamInd.Add('B06_CODCST');
  stlCamInd.Add('B06_CODCFO');
  stlCamInd.Add('B06_DTAINI');
  stlCamInd.Add('B06_DTAFIN');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Valores CST');
  stlDesInd.Add('Valores CFOP');
  stlDesInd.Add('Data Inicial');
  stlDesInd.Add('Data Final');
end;

function TfrmCadCampo06BlocoC185SPED.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      if fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'O campo "Descrição" deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDtaIni) Then
    Begin
      if Not fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)) Then
      Begin
        Try
          StrToDate(edtDtaIni.Text);
        Except
          fMensagem('', 'Campo "Dt. Inicial" inválido!', ['&OK']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtDtaFin) Then
    Begin
      if Not fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text)) Then
      Begin
        Try
          StrToDate(edtDtaFin.Text);
        Except
          fMensagem('', 'Campo "Dt. Final" inválido!', ['&OK']);
          Result := False;
        End
      End;
    End;
  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.
