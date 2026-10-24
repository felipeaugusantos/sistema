unit untCadEventos;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, StdCtrls, Mask, DBCtrls,
  DBEditFocus, Menus, ComCtrls, Buttons, ExtCtrls, AppEvnts, DB,
  BitBtnLockedIncrem, QColorLabel, frxClass, frxExportCSVTestabilidade,
  SysUtils;

type
  TfrmCadEventos = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDesEve: TDBEditFocus;
    dtsCadEve: TDataSource;
    dbeConCon: TDBEditFocus;
    Label3: TLabel;
    lblExiFat: TLabel;
    dbeExiFat: TDBEditFocus;
    cllExiFat: TColorLabel;
    rdgTipoEvento: TDBRadioGroup;
    dbeCodigoCompleto: TDBEditFocus;
    lblCodCompleto: TLabel;
    lblDtaEve: TLabel;
    lblQtdPes: TLabel;
    dbeDtaEve: TDBEditFocus;
    dbeQtdPes: TDBEditFocus;
    lblEndereco: TLabel;
    dbeEndEve: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsCadEveDataChange(Sender: TObject; Field: TField);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterOpen(DataSet: TDataSet);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEventos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADEVE';
  strNomeCampo      := 'EVE_CODEVE';
  qryTabela         := fCriarQuery('SELECT * FROM CADEVE', Self);
  qryTabela.AfterOpen   := pAfterOpen;
  dtsCadEve.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  lblDtaEve.Visible := fCfgSis('EVEDTQ', varBoolean);
  dbeDtaEve.Visible := lblDtaEve.Visible;
  lblQtdPes.Visible := lblDtaEve.Visible;
  dbeQtdPes.Visible := lblDtaEve.Visible;
end;

function TfrmCadEventos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Centro de Custos deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeCodigoCompleto) Then
    Begin
      If (fEmptyStr(dbeCodigoCompleto.Text)) And (dbeCodigoCompleto.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código Completo do Centro de Custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeDesEve) Then
    Begin
      If fEmptyStr(dbeDesEve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Centro de Custos deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (dbeExiFat.Visible) And (Sender = dbeExiFat) Then Begin
      If (Pos(dbeExiFat.Text, 'SN') <= 0) Then Begin
        fMensagem('ATENÇÃO!', 'A campo Exibir no Faturamento deve ser igual a ' +
          QuotedStr('S') + ' ou ' + QuotedStr('N') + '!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmCadEventos.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('EVE_CODCOM') <> nil Then
      TStringField(FieldByName('EVE_CODCOM')).EditMask := fMskCodCom;

    If FindField('EVE_DTAEVE') <> nil Then
      TDateField(FieldByName('EVE_DTAEVE')).EditMask := '99/99/9999';
  end;
end;

procedure TfrmCadEventos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EVE_CODEVE');
  stlCampos.Add('EVE_DESEVE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EVE_DESEVE');
  stlCamInd.Add('EVE_CODEVE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadEventos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEventos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEventos.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEventos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEventos.btnIncluirClick(Sender: TObject);
begin
  inherited;
   If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeCodigoCompleto, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  If (qryTabela.Active) And (qryTabela.State = dsInsert) Then
  Begin
    qryTabela.FieldByName('EVE_EXIFAT').AsString := 'S';
    qryTabela.FieldByName('EVE_TIPEVE').AsString := 'G';
  End;

end;

procedure TfrmCadEventos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEvento: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  chrKey := '/';
  If fPesqEventos(Self, Nil, Nil, qryTabela, chrKey, arrEvento) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadEventos.dtsCadEveDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  rdgTipoEvento.Enabled := (dtsCadEve.State in [dsEdit, dsInsert]);
end;

procedure TfrmCadEventos.btnAlterarClick(Sender: TObject);
begin
  inherited;
   pHabilitaCodigo(dbeCodigo, dbeCodigoCompleto, False);
end;

procedure TfrmCadEventos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  lblExiFat.Visible := fCfgSis('EVEFAT', varBoolean);
  dbeExiFat.Visible := fCfgSis('EVEFAT', varBoolean);
  cllExiFat.Visible := fCfgSis('EVEFAT', varBoolean);

end;

end.

