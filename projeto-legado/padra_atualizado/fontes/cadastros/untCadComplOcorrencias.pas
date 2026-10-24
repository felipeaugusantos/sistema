unit untCadComplOcorrencias;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus, Uni, EditFocus,
  BitBtnLockedIncrem, DBMemoFocus, frxClass, frxExportCSVTestabilidade,
  QColorLabel;

type
  TfrmCadComplOcorrencias = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDesCoc: TDBEditFocus;
    dtsCadCoc: TDataSource;
    Label3: TLabel;
    dbeTipOco: TDBEditFocus;
    edtDesTipOco: TEditFocus;
    Label4: TLabel;
    dbmMsgPad: TDBMemoFocus;
    lblAlterarCatLead: TLabel;
    dbeCatLea: TDBEditFocus;
    clrLblAltCatLead: TColorLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeTipOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    qryCadToc: TUniQuery;
    procedure pCarregaTipoOcorrencia;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;

{$R *.dfm}

{ TfrmCadComplOcorrencias }

procedure TfrmCadComplOcorrencias.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesCoc, False);
  pCarregaTipoOcorrencia;
end;

procedure TfrmCadComplOcorrencias.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaTipoOcorrencia;
end;

procedure TfrmCadComplOcorrencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComplOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaTipoOcorrencia;
end;

procedure TfrmCadComplOcorrencias.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadComplOcorrencias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadComplOcorrencias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesCoc, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('COC_ALTLEA').AsString := 'N';
end;

procedure TfrmCadComplOcorrencias.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  chrKey := '/';
  If fPesqComplementosOcorrencias(Self, Nil, Nil, qryTabela, chrKey, arrCOcorr, True) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregaTipoOcorrencia;
  End;
end;

procedure TfrmCadComplOcorrencias.dbeTipOcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  If fPesqTiposOcorrencias(Self, dbeTipOco, edtDesTipOco, nil, Key, arrTOcorr, True, '') Then
  Begin
    If fValidaCampos(dbeTipOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComplOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryTabela);
  FreeAndNil(qryCadToc);
end;

procedure TfrmCadComplOcorrencias.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCOC';
  strNomeCampo      := 'COC_CODCOC';
  qryTabela         := fCriarQuery('SELECT * FROM CADCOC', Self);
  dtsCadCoc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadComplOcorrencias.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadComplOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
 
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Complemento da Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesCoc) Then
    Begin
      If fEmptyStr(dbeDesCoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Complemento da Ocorrência deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeTipOco) Then
    Begin
      If fEmptyStr(dbeTipOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaTipoOcorrencia;
        If qryCadToc.FieldByName('TOC_CODTOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadComplOcorrencias.pCarregaTipoOcorrencia;
begin
  pPesquisaCadToc(qryTabela, qryCadToc, dbeTipOco.Text, '');
  With qryCadToc Do
  Begin
    edtDesTipOco.Text := FieldByName('TOC_DESTOC').AsString;
  End;
end;

procedure TfrmCadComplOcorrencias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COC_CODCOC');
  stlCampos.Add('COC_DESCOC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COC_DESCOC');
  stlCamInd.Add('COC_CODCOC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Complemento Ocorrência');

  qryCadToc := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
end;

end.

