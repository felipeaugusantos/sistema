unit untCadRotasRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, ExtCtrls, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons,
  BitBtnLockedIncrem, EditFocus, Mask, DBCtrls, DBEditFocus, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Provider, DBClient, Uni, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  frxClass, frxExportCSVTestabilidade, MaskEditFocus, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadRotasRegiao = class(TfrmPaiCad)
    pnlGeral: TPanel;
    pnlRotas: TPanel;
    pnlCidades: TPanel;
    lblRegiao: TLabel;
    dbeCodReg: TDBEditFocus;
    edtDesReg: TEditFocus;
    dbeInterv: TDBEditFocus;
    Label1: TLabel;
    DBEHORCAR: TDBEditFocus;
    DBEPEDATE: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    DBEVMINCA: TDBEditFocus;
    lbl4: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    pnlCidade: TPanel;
    edtCidade: TEditFocus;
    Label8: TLabel;
    dbgCidadesDBTableView1: TcxGridDBTableView;
    dbgCidadesLevel1: TcxGridLevel;
    dbgCidades: TcxGrid;
    dtsRotRec: TDataSource;
    cdsRotRec: TUniClientDataSet;
    edtCodCid: TEditFocus;
    cdsRotRecREC_CODREG: TStringField;
    cdsRotRecREC_CODEMP: TStringField;
    cdsRotRecREC_CODCID: TStringField;
    cdsRotRecAUTOINCREM: TStringField;
    cdsRotRecREC_NOMCID: TStringField;
    dbgCidadesDBTableView1REC_CODREG: TcxGridDBColumn;
    dbgCidadesDBTableView1REC_CODEMP: TcxGridDBColumn;
    dbgCidadesDBTableView1REC_CODCID: TcxGridDBColumn;
    dbgCidadesDBTableView1AUTOINCREM: TcxGridDBColumn;
    dbgCidadesDBTableView1REC_NOMCID: TcxGridDBColumn;
    dtsRotReg: TDataSource;
    btnAdicionarCid: TBitBtnLocked;
    btnCancelaItemCid: TBitBtnLocked;
    dbgCidadesDBTableView1REC_ESTADO: TcxGridDBColumn;
    cdsRotRecREC_ESTADO: TStringField;
    pgcDadosRota: TPageControl;
    tbsCidades: TTabSheet;
    tbsVeiculos: TTabSheet;
    pnlVeiculos: TPanel;
    pnlVeiculo: TPanel;
    Label4: TLabel;
    edtDesVei: TEditFocus;
    btnAdicionarVei: TBitBtnLocked;
    btnCancelaItemVei: TBitBtnLocked;
    dbgVeiculos: TcxGrid;
    dbgVeiculosView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    dbgVeiculosLevel1: TcxGridLevel;
    mskPlaVei: TMaskEditFocus;
    dtsRotRev: TDataSource;
    cdsRotRev: TUniClientDataSet;
    cdsRotRevREV_CODREG: TStringField;
    cdsRotRevREV_CODEMP: TStringField;
    cdsRotRevREV_PLAVEI: TStringField;
    cdsRotRevAUTOINCREM: TStringField;
    cdsRotRevREV_DESVEI: TStringField;
    cdsRotRevREV_CONDUT: TStringField;
    cdsRotRevREV_CAPCAR: TIntegerField;
    cdsRotRevREV_PADRAO: TStringField;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cdsRotRevACAO: TStringField;
    Label5: TLabel;
    cdsRotRecREC_CODBAI: TIntegerField;
    cdsRotRecREC_NOMBAI: TStringField;
    dbgCidadesDBTableView1REC_NOMBAI: TcxGridDBColumn;
    edtCodBairro: TEditFocus;
    edtBairro: TEditFocus;
    lblSequencia: TLabel;
    edtSequencia: TEditFocus;
    cdsRotRecREC_SEQUEN: TFloatField;
    dbgCidadesDBTableView1REC_SEQUEN: TcxGridDBColumn;
    cdsRotRecACAO: TStringField;
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarCidClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbgCidadesDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarVeiClick(Sender: TObject);
    procedure btnCancelaItemVeiClick(Sender: TObject);
    procedure btnCancelaItemCidClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgVeiculosView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgVeiculosView1DblClick(Sender: TObject);
    procedure edtCodBairroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    blnTeveExclusao : Boolean;
    procedure pCarregaRegiao;
    procedure pCarregaTransportador;
    procedure pCarregaCidade;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAdicionarCid;
    procedure pAdicionarVei;
    procedure pLimpaCidade;
    procedure pLimpaVeiculo;
    function  fGravaCidadesRegiao(blnInsert: Boolean): Boolean;
    function  fGravaVeiculosRegiao(blnInsert: Boolean): Boolean;
    procedure pAdicionaCidadesRegiao;
    procedure pAdicionaVeiculosRegiao;
    procedure pLimpaClientCidade;
    procedure pLimpaClientVeiculo;
    procedure pPreencheClientCidade;
    procedure pPreencheClientVeiculo;
    procedure pDeletaCidade;
    procedure pDeletaVeiculo;
    procedure pAlteraVeiculoPadrao;

    function fAdicionarCidade: Boolean;
    function fAdicionarVeiculo: Boolean;
    procedure pExcluiCidades;
    procedure pExcluiVeiculos;
    function fPodeAdicionarCid: Boolean;
    function fPodeAdicionarVei: Boolean;
    function fExitemCidadesCadastradas: Boolean;
    function fExitemVeiculosCadastrados: Boolean;
    procedure pCarregaBairro;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    blnRotReg: Boolean;
  end;

var
  frmCadRotasRegiao: TfrmCadRotasRegiao;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadRotasRegiao.btnAdicionarCidClick(Sender: TObject);
begin
  inherited;
  if blnRotReg then
  begin
    if fEmptyStr(edtSequencia.Text) Then
    begin
      fMensagem('ATENÇÃO', 'Informe a sequência!', ['&Ok']);
      Exit;
    end;
  end;

  If fVerificaCampos Then
    If fAdicionarCidade And fPodeAdicionarCid Then
      pAdicionarCid;
end;

procedure TfrmCadRotasRegiao.btnAdicionarVeiClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    If fAdicionarVeiculo And fPodeAdicionarVei Then
      pAdicionarVei;
end;

procedure TfrmCadRotasRegiao.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State = dsEdit) Then
  Begin
    pPreencheClientCidade;
    pPreencheClientVeiculo;

    dbeCodReg.ReadOnly := True;
    dbeCodReg.Enabled  := False;
    mskPlaVei.Enabled  := True;
    blnTeveExclusao    := False;

    pSetFocus(dbeCodTra);
  End;
end;

procedure TfrmCadRotasRegiao.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    pPreencheClientCidade;
    pPreencheClientVeiculo;
    pCarregaRegiao;
    pCarregaTransportador;
    pLimpaCidade;
    pLimpaVeiculo;

    blnTeveExclusao    := False;
    mskPlaVei.Enabled := False;
  End;
end;

procedure TfrmCadRotasRegiao.btnCancelaItemCidClick(Sender: TObject);
begin
  inherited;

  pLimpaCidade;
end;

procedure TfrmCadRotasRegiao.btnCancelaItemVeiClick(Sender: TObject);
begin
  inherited;

  pLimpaVeiculo;
end;

procedure TfrmCadRotasRegiao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRotasRegiao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaClientCidade;
  pLimpaClientVeiculo;
  pCarregaRegiao;
  pCarregaTransportador;
end;

procedure TfrmCadRotasRegiao.btnGravarClick(Sender: TObject);
var
  blnInsert :Boolean;

  function fExisteRegistro:Boolean;
  var strResult: String;
  begin
    if blnInsert then
    begin
      strResult := fCampoTabela('REV_CODIGO','ROTREV',['REV_CODREG','REV_CODIGO'],
                                                      [qryTabela.FieldByName('ROT_CODREG').AsString,
                                                      fAtualizaProCod('ROTREV', 'REV_CODIGO')]);
      result := not fEmptyStr(strResult);
    end
    else
      result := false;
  end;

begin

  blnInsert := qryTabela.State = dsInsert;

  if fExisteRegistro then
  begin
    fMensagem('ATENÇÃO!', 'Já existe um registro com esses dados! Favor verificar.', ['&Ok']);
    Exit;
  end;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (fExitemCidadesCadastradas = False) or (fExitemVeiculosCadastrados = False) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRotasRegiao.btnGravarClick]');
    End;
  End;

  If (blnGravou) And (((fGravaCidadesRegiao(blnInsert)) And (fGravaVeiculosRegiao(blnInsert))) OR (blnTeveExclusao)) Then
    fCommit
  Else
    fRollBack;

  blnTeveExclusao    := False;
  If Not (qryTabela.State In [dsInsert, dsEdit]) Then
    mskPlaVei.Enabled := False;
end;

procedure TfrmCadRotasRegiao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State = dsInsert) Then
  Begin
    blnUsaProCodigo   := False;
    mskPlaVei.Enabled := True;

    pLimpaClientCidade;
    pLimpaClientVeiculo;
    pCarregaRegiao;
    pCarregaTransportador;
    dbeCodReg.ReadOnly := False;

    pSetFocus(dbeCodReg);
  End;
end;

procedure TfrmCadRotasRegiao.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRotas: TConsultasArray;
begin
  chrKey := '/';

  If fPesqRotasRegiao(Self, Nil, Nil, qryTabela, chrKey, arrRotas) Then
  Begin
    pCarregaRegiao;
    pCarregaTransportador;
    pPreencheClientCidade;
    pPreencheClientVeiculo;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadRotasRegiao.dbeCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;

  If fPesqRegiao( Self, dbeCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(dbeCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadRotasRegiao.dbeCodTraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;

  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadRotasRegiao.dbgCidadesDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    Case Key Of
      VK_DELETE : Begin
                    If fMensagem('QUESTÃO','Deseja realmente excluir essa cidade ?',['&Sim','&Não']) = 1 Then
                      pDeletaCidade;
                  End;
    End;
  End;
end;

procedure TfrmCadRotasRegiao.dbgVeiculosView1DblClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In [dsInsert, dsEdit]) Then
    pAlteraVeiculoPadrao;
end;

procedure TfrmCadRotasRegiao.dbgVeiculosView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    Case Key Of
      VK_DELETE : Begin
                    If fMensagem('QUESTÃO','Deseja realmente excluir esse veículo ?',['&Sim','&Não']) = 1 Then
                      pDeletaVeiculo;
                  End;
      VK_RETURN : pAlteraVeiculoPadrao;
    End;
  End;
end;

procedure TfrmCadRotasRegiao.edtCodBairroKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrBairro: TConsultasArray;
begin
  inherited;
  If fEmptyStr(edtCodCid.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe a cidade !', ['&Ok']);
    Exit;
  End;

  If fPesqBairroIBGE(Self, edtCodBairro, edtBairro, Nil, Key, arrBairro, True, edtCodCid) Then
  Begin
    If fValidaCampos(edtCodBairro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadRotasRegiao.edtCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtCidade, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadRotasRegiao.fAdicionarCidade: Boolean;
begin
  Result := (Not fEmptyStr(edtCodCid.Text)) And (Not fEmptyStr(edtCidade.Text));
end;

function TfrmCadRotasRegiao.fAdicionarVeiculo: Boolean;
begin
  Result := (Not fEmptyStr(mskPlaVei.Text)) And (Not fEmptyStr(edtDesVei.Text));
end;

function TfrmCadRotasRegiao.fExitemCidadesCadastradas: Boolean;
begin
  Result := cdsRotRec.RecordCount > 0;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO','É preciso cadastrar uma cidade para essa rota !',['&Ok']);
    pgcDadosRota.ActivePage := tbsCidades;
    pSetFocus(edtCodCid);
  End;
end;

function TfrmCadRotasRegiao.fExitemVeiculosCadastrados: Boolean;
begin
  Result := cdsRotRev.RecordCount > 0;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO','É preciso cadastrar um veículo para essa rota !',['&Ok']);
    pgcDadosRota.ActivePage := tbsVeiculos;
    pSetFocus(mskPlaVei);
  End;
end;

procedure TfrmCadRotasRegiao.pExcluiCidades;
var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery(Nil);

    With qryDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM ROTREC ');
      SQL.Add(' WHERE REC_CODREG = :CODREG ');
      SQL.Add('   AND REC_CODEMP = :CODEMP ');
      SQL.Add('   AND AUTOINCREM = :AUTOINCREM  ');
      ParamByName('CODREG').AsString := qryTabela.FieldByName('ROT_CODREG').AsString;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('ROT_CODEMP').AsString;
      ParamByName('AUTOINCREM').AsString := cdsRotRec.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
      blnTeveExclusao := True;
    End;
  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure TfrmCadRotasRegiao.pExcluiVeiculos;
var
  qryDel : TUniQuery;
begin
  Try
    qryDel := fCriaQuery(Nil);

    Try
      With qryDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM ROTREV              ');
        SQL.Add(' WHERE REV_CODREG = :CODREG      ');
        SQL.Add('   AND AUTOINCREM = :AUTOINCREM  ');
        ParamByName('CODREG').AsString     := qryTabela.FieldByName('ROT_CODREG').AsString;
        ParamByName('AUTOINCREM').AsString := cdsRotRev.FieldByName('AUTOINCREM').AsString;
        ExecSQL;
        blnTeveExclusao := True;
      End;
    Except
      fMensagem('ATENÇÃO','Não foi possível excluir o registro selecionado !'+#13+
                          'Esse veículo esta vinculado ao cadastro de entregas.',['&Ok']);
      Exit;
    End;

  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure TfrmCadRotasRegiao.pInicializaIndices;
begin
  inherited;
  //...
end;

procedure TfrmCadRotasRegiao.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'ROTREG';
  strNomeCampo          := 'ROT_CODREG';
  qryTabela             := fCriarQuery('SELECT * FROM ROTREG', Self);
  qryTabela.AfterOpen   := pAfterOpen;
  dtsRotReg.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodReg;

  cdsRotRec.CreateDataSet;
  cdsRotRev.CreateDataSet;
end;

procedure TfrmCadRotasRegiao.FormShow(Sender: TObject);
begin
  inherited;
  pgcDadosRota.ActivePage                  := tbsCidades;
  blnRotReg                                := fCfgSis('ROTREG', varBoolean);
  lblSequencia.Visible                     := blnRotReg;
  edtSequencia.Visible                     := blnRotReg;
  dbgCidadesDBTableView1REC_SEQUEN.Visible := blnRotReg;
end;

function TfrmCadRotasRegiao.fPodeAdicionarCid: Boolean;
begin
  Result := True;

  With cdsRotRec Do
  Begin
    Try
      DisableControls;
      If Locate('REC_CODCID;REC_CODBAI', VarArrayOf([edtCodCid.Text, IIF(fEmptyStr(edtCodBairro.Text), 0, edtCodBairro.Text)]),[]) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO','Essa cidade/bairro já esta cadastrada para essa rota !',['&Ok']);
        pLimpaCidade;
      End;
    Finally
      EnableControls;
      First;
    End;
  End;
end;

function TfrmCadRotasRegiao.fPodeAdicionarVei: Boolean;
begin
  Result := True;

  With cdsRotRev Do
  Begin
    Try
      DisableControls;

      If Locate('REV_PLAVEI', mskPlaVei.Text,[]) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO','Esse veículo já esta cadastrado para essa rota !',['&Ok']);
        pLimpaVeiculo;
      End;
    Finally
      EnableControls;
      First;
    End;
  End;
end;

function TfrmCadRotasRegiao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodReg) Then
    Begin
      If fEmptyStr(dbeCodReg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Região deve ser preenchida !', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaRegiao;
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Região não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodTra) Then
    Begin
      If fEmptyStr(dbeCodTra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Transportadora deve ser preenchida !', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaTransportador;
        If fEmptyStr(edtNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeHorCar) Then
    Begin
      If fEmptyStr(dbeHorCar.Text) Or (dbeHorCar.Text = '  :  ') Then
      Begin
        fMensagem('ATENÇÃO', 'O Horário da carga deve ser preenchido !', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbePedAte) Then
    Begin
      If fEmptyStr(dbePedAte.Text) Or (dbePedAte.Text = '  :  ') Then
      Begin
        fMensagem('ATENÇÃO', 'O Pedido Até as deve ser preenchido !', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeVmiNca) Then
    Begin
      If fStrToFloat(dbeVmiNca.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO', 'O Valor mínimo da carga deve ser preenchido !', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeInterv) Then
    Begin
      If fEmptyStr(dbeInterv.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Intervalo deve ser preenchido !', ['&Ok']);
        Result := False;
      End
      Else If StrToInt(dbeInterv.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O Intervalo deve ser maior que zero !', ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = edtCodCid) Then
    Begin
      If not fEmptyStr(edtCodCid.Text) Then
      Begin
        pCarregaCidade;
        If fEmptyStr(edtCidade.Text)  Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtCidade.Clear;
    End
    Else If (Sender = edtCodBairro) Then
    Begin
      If not fEmptyStr(edtCodBairro.Text) Then
      Begin
        pCarregaBairro;
        If fEmptyStr(edtBairro.Text)  Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse bairro não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtBairro.Clear;
    End
    Else If (Sender = mskPlaVei) Then
    Begin
      If not fEmptyStr(mskPlaVei.Text) Then
      Begin
        If fVeiculoInativo(mskPlaVei.Text) Then
        Begin
          edtDesVei.Text := '';
          fMensagem('','Este veículo está inativo.',['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesVei.Text := fRetornaDescricaoVeic(mskPlaVei.Text);
          If fEmptyStr(edtDesVei.Text)  Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse veículo não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      else
        edtDesVei.Clear;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadRotasRegiao.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
Var
  arrVei: TConsultasArray;
begin
  inherited;

  If fPesqVeiculos(Self, mskPlaVei, Nil, Nil, Key, arrVei, True, False, ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadRotasRegiao.pAdicionaCidadesRegiao;

  function fSQLIns: String;
  Begin
    Result := '';
    Result := Result + ' INSERT INTO ROTREC ';
    Result := Result + '   (REC_CODREG, REC_CODEMP, REC_CODCID, REC_CODBAI, AUTOINCREM ';

    if blnRotReg then
      Result := Result + ', REC_SEQUEN ';

    Result := Result + ') VALUES ';
    Result := Result + '   (:CODREG   , :CODEMP   , :CODCID,    :CODBAI   , :AUTINC ';

    if blnRotReg then
      Result := Result + ', :SEQUEN ';

    Result := Result + ');';
  End;

var
  qryIns: TUniQuery;
begin
  Try
    qryIns := fCriaQuery(Nil);

    With cdsRotRec Do
    Begin
      First;
      While Not Eof Do
      Begin
        if FieldByName('ACAO').AsString = 'I' then
        begin
          qryIns.Close;
          qryIns.SQL.Clear;
          qryIns.SQL.Add(fSQLIns);
          qryIns.ParamByName('CODREG').AsString := qryTabela.FieldByName('ROT_CODREG').AsString;
          qryIns.ParamByName('CODEMP').AsString := qryTabela.FieldByName('ROT_CODEMP').AsString;
          qryIns.ParamByName('CODCID').AsString := FieldByName('REC_CODCID').AsString;
          qryIns.ParamByName('CODBAI').AsString := FieldByName('REC_CODBAI').AsString;
          qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('ROTREC', VS_strCodEmp);

          if blnRotReg then
            qryIns.ParamByName('SEQUEN').AsString := FieldByName('REC_SEQUEN').AsString;

          qryIns.ExecSQL;
        End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadRotasRegiao.pAdicionarCid;
begin
  With cdsRotRec Do
  Begin
    Append;
    FieldByName('ACAO').AsString       := 'I';
    FieldByName('REC_CODCID').AsString := edtCodCid.Text;
    FieldByName('REC_NOMCID').AsString := edtCidade.Text;
    FieldByName('REC_ESTADO').AsString := fRetNomCidade(edtCodCid.Text,1);
    FieldByName('REC_CODBAI').AsString := edtCodBairro.Text;
    FieldByName('REC_NOMBAI').AsString := edtBairro.Text;

    if blnRotReg then
      FieldByName('REC_SEQUEN').AsString := edtSequencia.Text;

    Post;
    pLimpaCidade;
  End;
end;

procedure TfrmCadRotasRegiao.pAdicionarVei;
var
  recVeiculo : TDadosVeiculo;
  strPlavei  : String;
  strPadrao  : String;
begin
  strPlaVei  := mskPlaVei.Text;
  strPadrao  := IIF(cdsRotRev.IsEmpty,'S','N');
  recVeiculo := fRetornaDadosVeic(strPlaVei);

  cdsRotRev.Append;
  cdsRotRev.FieldByName('ACAO').AsString        := 'I';
  cdsRotRev.FieldByName('REV_PLAVEI').AsString  := strPlaVei;
  cdsRotRev.FieldByName('REV_DESVEI').AsString  := recVeiculo.strMarVei + ' ' +
                                                   recVeiculo.strModVei + ' ' +
                                                   recVeiculo.strAnoVei + ' ' +
                                                   recVeiculo.strCorVei;
  cdsRotRev.FieldByName('REV_CAPCAR').AsInteger := recVeiculo.intCapCar;
  cdsRotRev.FieldByName('REV_CONDUT').AsString  := recVeiculo.strCondut;
  cdsRotRev.FieldByName('REV_PADRAO').AsString  := strPadrao;
  cdsRotRev.Post;

  pLimpaVeiculo;
end;

procedure TfrmCadRotasRegiao.pAdicionaVeiculosRegiao;

  function fSQLIns: String;
  Begin
    Result := '';
    Result := Result + ' INSERT INTO ROTREV ';
    Result := Result + ' (REV_CODIGO, REV_CODREG, REV_CODEMP, REV_PLAVEI, REV_PADRAO, AUTOINCREM) VALUES ';
    Result := Result + ' (:CODIGO   , :CODREG   , :CODEMP   , :PLAVEI   , :PADRAO   , :AUTINC); ';
  End;

var
  qryIns : TUniQuery;
begin
  Try
    qryIns := fCriaQuery(Nil);

    With cdsRotRev Do
    Begin
      First;
      While Not Eof Do
      Begin
          if cdsRotRev.FieldByName('ACAO').AsString = 'I' then
          Begin
            qryIns.Close;
            qryIns.SQL.Clear;
            qryIns.SQL.Add(fSQLIns);
            qryIns.ParamByName('CODIGO').AsString := fAtualizaProCod('ROTREV', 'REV_CODIGO');
            qryIns.ParamByName('CODREG').AsString := qryTabela.FieldByName('ROT_CODREG').AsString;
            qryIns.ParamByName('CODEMP').AsString := qryTabela.FieldByName('ROT_CODEMP').AsString;
            qryIns.ParamByName('PLAVEI').AsString := FieldByName('REV_PLAVEI').AsString;
            qryIns.ParamByName('PADRAO').AsString := FieldByName('REV_PADRAO').AsString;
            qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('ROTREV', VS_strCodEmp);
            qryIns.ExecSQL;
          End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadRotasRegiao.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TFloatField(FieldByName('ROT_VLRMIN')).DisplayFormat := '#,##0.00';

    TDateField(FieldByName('ROT_HORCAR')).EditMask  := '99:99';
    TDateField(FieldByName('ROT_HOREMI')).EditMask  := '99:99';
  End;
end;

procedure TfrmCadRotasRegiao.pAlteraVeiculoPadrao;
var
  qryUpdate : TUniQuery;
  strPlaVei : String;
begin
  Try
    qryUpdate := fCriaQuery(Nil);

    Try
      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE ROTREV SET REV_PADRAO = "S" ');
        SQL.Add(' WHERE REV_CODREG = :CODREG         ');
        SQL.Add('   AND REV_CODEMP = :CODEMP         ');
        SQL.Add('   AND AUTOINCREM = :AUTOINCREM     ');
        ParamByName('CODREG').AsString     := qryTabela.FieldByName('ROT_CODREG').AsString;
        ParamByName('CODEMP').AsString     := qryTabela.FieldByName('ROT_CODEMP').AsString;
        ParamByName('AUTOINCREM').AsString := cdsRotRev.FieldByName('AUTOINCREM').AsString;
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add(' UPDATE ROTREV SET REV_PADRAO = "N" ');
        SQL.Add(' WHERE REV_CODREG  = :CODREG         ');
        SQL.Add('   AND REV_CODEMP  = :CODEMP         ');
        SQL.Add('   AND AUTOINCREM <> :AUTOINCREM     ');
        ParamByName('CODREG').AsString     := qryTabela.FieldByName('ROT_CODREG').AsString;
        ParamByName('CODEMP').AsString     := qryTabela.FieldByName('ROT_CODEMP').AsString;
        ParamByName('AUTOINCREM').AsString := cdsRotRev.FieldByName('AUTOINCREM').AsString;
        ExecSQL;
      End;
    Except
      fMensagem('ATENÇÃO','Não foi possível alterar o registro selecionado !',['&Ok']);
      Exit;
    End;

  Finally
    FreeAndNil(qryUpdate);
  End;

  With cdsRotRev Do
  Begin
    Try
      DisableControls;

      strPlaVei := FieldByName('REV_PLAVEI').AsString;
      First;

      While Not Eof Do
      Begin
        Edit;

        If (strPlaVei = FieldByName('REV_PLAVEI').AsString) Then
          FieldByName('REV_PADRAO').AsString := 'S'
        Else
          FieldByName('REV_PADRAO').AsString := 'N';

        Post;
        Next;
      End;

    Finally
      EnableControls;
    End;
  End;

end;

procedure TfrmCadRotasRegiao.pCarregaCidade;
begin
  If Not fEmptyStr(edtCodCid.Text) Then
    edtCidade.Text := fRetNomCidade(edtCodCid.Text)
  Else
    edtCidade.Clear;
end;

procedure TfrmCadRotasRegiao.pCarregaBairro;
begin
  If Not fEmptyStr(edtCodBairro.Text) Then
    edtBairro.Text := fRetNomBairroIBGE(edtCodBairro.Text,edtCodCid.Text)
  Else
    edtBairro.Clear;
end;

procedure TfrmCadRotasRegiao.pCarregaRegiao;
begin
  If Not fEmptyStr(dbeCodReg.Text) Then
    edtDesReg.Text := fRetNomRegiao(dbeCodReg.Text)
  Else
    edtDesReg.Clear;
end;

procedure TfrmCadRotasRegiao.pCarregaTransportador;
begin
  If Not fEmptyStr(dbeCodTra.Text) Then
    edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text)
  Else
    edtnomTra.Clear;
end;

procedure TfrmCadRotasRegiao.pDeletaCidade;
begin
  pExcluiCidades;
  cdsRotRec.Delete;
  pSetFocus(edtCodCid);
end;

procedure TfrmCadRotasRegiao.pDeletaVeiculo;
begin
  pExcluiVeiculos;
  cdsRotRev.Delete;
  pSetFocus(mskPlaVei);
end;

function TfrmCadRotasRegiao.fGravaCidadesRegiao(blnInsert: Boolean): Boolean;
begin
  Result := True;
  Try
    pAdicionaCidadesRegiao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[pGravaCidadesRegiao]');
    End;
  End;
end;

function TfrmCadRotasRegiao.fGravaVeiculosRegiao(blnInsert: Boolean): Boolean;
begin
  Result := True;

  Try
    pAdicionaVeiculosRegiao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[pGravaVeiculosRegiao]');
    End;
  End;
end;

procedure TfrmCadRotasRegiao.pLimpaCidade;
begin
  edtCodCid.Clear;
  edtCidade.Clear;
  edtCodBairro.Clear;
  edtBairro.Clear;

  if blnRotReg then
    edtSequencia.Clear;

  pSetFocus(edtCodCid);
end;

procedure TfrmCadRotasRegiao.pLimpaClientCidade;
begin
  cdsRotRec.EmptyDataSet;
end;

procedure TfrmCadRotasRegiao.pLimpaClientVeiculo;
begin
  cdsRotRev.EmptyDataSet;
end;

procedure TfrmCadRotasRegiao.pLimpaVeiculo;
begin
  mskPlaVei.Clear;
  edtDesVei.Clear;
  pSetFocus(mskPlaVei);
end;

procedure TfrmCadRotasRegiao.pPreencheClientCidade;

  function fSQLConsulta: String;
  Begin
    Result := '';
    Result := Result + ' SELECT REC_CODREG, ';
    Result := Result + '        REC_CODEMP, ';
    Result := Result + '        REC_CODCID, ';
    Result := Result + '        REC_CODBAI, ';
    Result := Result + '        bairro.nome AS REC_NOMBAI, ';
    Result := Result + '        CID_NOMCID AS REC_NOMCID, ';
    Result := Result + '        CID_ESTADO AS REC_ESTADO, ';
    Result := Result + '        ROTREC.AUTOINCREM,  ';
    Result := Result + '        REC_SEQUEN ';
    Result := Result + '   FROM ROTREC      ';
    Result := Result + '  INNER JOIN CADCID ON CID_CODCID = REC_CODCID ';
    Result := Result + '  LEFT  JOIN bairro ON id_bairro = REC_CODBAI ';
    Result := Result + '  WHERE REC_CODREG = :CODREG ';
    Result := Result + '    AND REC_CODEMP = :CODEMP ';
  End;

var
  qryCons: TUniQuery;
begin
  cdsRotRec.EmptyDataSet;

  If Not fEmptyStr(qryTabela.FieldByName('ROT_CODREG').AsString) Then
  Begin
    Try
      cdsRotRec.DisableControls;
      qryCons := fCriaQuery(Nil);

      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fSQLConsulta);
        ParamByName('CODREG').AsString := qryTabela.FieldByName('ROT_CODREG').AsString;
        ParamByName('CODEMP').AsString := qryTabela.FieldByName('ROT_CODEMP').AsString;
        Open;

        First;
        While Not Eof Do
        Begin
          cdsRotRec.Append;
          cdsRotRec.FieldByName('ACAO').AsString        := 'N';
          cdsRotRec.FieldByName('REC_CODREG').AsString := FieldByName('REC_CODREG').AsString;
          cdsRotRec.FieldByName('REC_CODEMP').AsString := FieldByName('REC_CODEMP').AsString;
          cdsRotRec.FieldByName('REC_CODCID').AsString := FieldByName('REC_CODCID').AsString;
          cdsRotRec.FieldByName('REC_NOMCID').AsString := FieldByName('REC_NOMCID').AsString;
          cdsRotRec.FieldByName('REC_CODBAI').AsString := FieldByName('REC_CODBAI').AsString;
          cdsRotRec.FieldByName('REC_NOMBAI').AsString := FieldByName('REC_NOMBAI').AsString;
          cdsRotRec.FieldByName('REC_ESTADO').AsString := FieldByName('REC_ESTADO').AsString;
          cdsRotRec.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
          cdsRotRec.FieldByName('REC_SEQUEN').AsString := FieldByName('REC_SEQUEN').AsString;
          cdsRotRec.Post;

          Next;
        End;
      End;
    Finally
      cdsRotRec.EnableControls;
      FreeAndNil(qryCons);
    End;
  End;
end;

procedure TfrmCadRotasRegiao.pPreencheClientVeiculo;

  function fSQLConsulta: String;
  Begin
    Result := '';
    Result := Result + ' SELECT        ';
    Result := Result + '   ROTREV.AUTOINCREM,                  ';
    Result := Result + '   CONCAT(IFNULL(MAR_DESMAR, ""), " ", ';
    Result := Result + '          IFNULL(MOD_DESMOD, ""), " ", ';
    Result := Result + '          IFNULL(VEI_ANOVEI, ""), " ", ';
    Result := Result + '          IFNULL(COR_DESCOR, ""), " ") AS REV_DESVEI, ';
    Result := Result + '   REV_CODREG, ';
    Result := Result + '   REV_CODEMP, ';
    Result := Result + '   REV_PLAVEI, ';
    Result := Result + '   VEI_CAPCAR, ';
    Result := Result + '   VEI_CONDUT, ';
    Result := Result + '   REV_PADRAO  ';
    Result := Result + ' FROM ROTREV   ';
    Result := Result + '   INNER JOIN CADVEI ON VEI_PLAVEI = REV_PLAVEI ';
    Result := Result + '   LEFT  JOIN MARVEI ON MAR_CODMAR = VEI_CODMAR ';
    Result := Result + '   LEFT  JOIN MODVEI ON MOD_CODMOD = VEI_CODMOD ';
    Result := Result + '   LEFT  JOIN CORVEI ON COR_CODCOR = VEI_CODCOR ';
    Result := Result + ' WHERE REV_CODREG = :CODREG ';
    Result := Result + '   AND REV_CODEMP = :CODEMP ';
  End;

var
  qryCons: TUniQuery;
begin
  cdsRotRev.EmptyDataSet;

  If Not fEmptyStr(qryTabela.FieldByName('ROT_CODREG').AsString) Then
  Begin
    Try
      cdsRotRev.DisableControls;
      qryCons := fCriaQuery(Nil);

      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fSQLConsulta);
        ParamByName('CODREG').AsString := qryTabela.FieldByName('ROT_CODREG').AsString;
        ParamByName('CODEMP').AsString := qryTabela.FieldByName('ROT_CODEMP').AsString;
        Open;

        First;
        While Not Eof Do
        Begin
          cdsRotRev.Append;
          cdsRotRev.FieldByName('ACAO').AsString        := 'N';
          cdsRotRev.FieldByName('REV_CODREG').AsString  := FieldByName('REV_CODREG').AsString;
          cdsRotRev.FieldByName('REV_CODEMP').AsString  := FieldByName('REV_CODEMP').AsString;
          cdsRotRev.FieldByName('REV_PLAVEI').AsString  := FieldByName('REV_PLAVEI').AsString;
          cdsRotRev.FieldByName('REV_DESVEI').AsString  := FieldByName('REV_DESVEI').AsString;
          cdsRotRev.FieldByName('REV_CAPCAR').AsInteger := FieldByName('VEI_CAPCAR').AsInteger;
          cdsRotRev.FieldByName('REV_CONDUT').AsString  := FieldByName('VEI_CONDUT').AsString;
          cdsRotRev.FieldByName('REV_PADRAO').AsString  := FieldByName('REV_PADRAO').AsString;
          cdsRotRev.FieldByName('AUTOINCREM').AsString  := FieldByName('AUTOINCREM').AsString;
          cdsRotRev.Post;

          Next;
        End;
      End;
    Finally
      cdsRotRev.EnableControls;
      FreeAndNil(qryCons);
    End;
  End;
end;

end.
