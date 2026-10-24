unit untCadEquLocacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, untCadLote,
  cxDropDownEdit, cxCalendar, DateEditFocus, cxCurrencyEdit, CurrencyEditFocus,
  DBMemoFocus, EditFocus, MaskEditFocus, Uni, Data.DB, MemoFocus, StrUtils,
  cadastro.Model.EquipamentoLocacao, QColorLabel,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Datasnap.DBClient,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, DBAccess,
  UniClientDataSet, cadastro.Model.AcessorioLocacao, untLiberacao, untTypesLocEqu,
  cxCheckBox, Vcl.Buttons;

type
  TfrmCadEquLocacao = class(TfrmPaiCad)
    dtsCadEqu: TDataSource;
    lblCodigo: TLabel;
    dbeCodigo: TDBEditFocus;
    lblStatus: TLabel;
    ColorLabel26: TColorLabel;
    dbeDescri: TDBEditFocus;
    lblDescri: TLabel;
    lblNSerie: TLabel;
    dbeNSerie: TDBEditFocus;
    lblValAqu: TLabel;
    edtValAqu: TCurrencyEditFocus;
    dbeRpUlMn: TDBEditFocus;
    lblRpUlMn: TLabel;
    lblGarant: TLabel;
    dbeGarant: TDBEditFocus;
    dbeModelo: TDBEditFocus;
    lblModelo: TLabel;
    lblLocFis: TLabel;
    edtCodIte: TEditFocus;
    lblCodIte: TLabel;
    edtDesIte: TEditFocus;
    mmoEspecf: TMemoFocus;
    lblEspecf: TLabel;
    lblDtUlMn: TLabel;
    lblDtaAqu: TLabel;
    mskDtaAqu: TMaskEditFocus;
    edtValLoc: TCurrencyEditFocus;
    lblValLoc: TLabel;
    mskDtUlMn: TMaskEditFocus;
    edtVlLocD: TCurrencyEditFocus;
    Label1: TLabel;
    lblAnoFab: TLabel;
    dbeAnoFab: TDBEditFocus;
    mskDtaVen: TMaskEditFocus;
    lblDtaVen: TLabel;
    Label3: TLabel;
    edtDscGer: TEditFocus;
    Label4: TLabel;
    edtDscSGe: TEditFocus;
    Label2: TLabel;
    edtDscVen: TEditFocus;
    dbeStatus: TDBEditFocus;
    dbeLocFis: TDBEditFocus;
    tsAcessorios: TTabSheet;
    pnlLancamentoAcessorio: TPanel;
    btnCancelaItem: TBitBtnLocked;
    Label5: TLabel;
    edtQtdAcl: TEditFocus;
    Label6: TLabel;
    edtDesAcl: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    Label7: TLabel;
    edtVlrCau: TCurrencyEditFocus;
    edtCodAcl: TEditFocus;
    cdsAcessorios: TUniClientDataSet;
    dtsAcessorios: TUniDataSource;
    cdsAcessoriosDESCRICAO: TStringField;
    cdsAcessoriosCODIGO: TStringField;
    cdsAcessoriosQUANTIDADE: TFloatField;
    tsNegociacao: TTabSheet;
    pnlLancamentoNegociacao: TPanel;
    dtsNegociacaoDiarias: TUniDataSource;
    cdsNegociacaoDiarias: TUniClientDataSet;
    Label8: TLabel;
    edtQtdDias: TEditFocus;
    edtVlrTot: TEditFocus;
    Label9: TLabel;
    btnAdicionarNegociacaoDiaria: TBitBtnLocked;
    btnCancelaItemNegociacao: TBitBtnLocked;
    cdsNegociacaoDiariasQTDDIA: TIntegerField;
    cdsNegociacaoDiariasVLRTOT: TFloatField;
    cdsNegociacaoDiariasVLRDIA: TFloatField;
    cxgAcessorios: TcxGridCitel;
    cxgAcessoriosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgAcessoriosLevel1: TcxGridLevel;
    cxgAcessoriosDBTableViewCitel1DESCRICAO: TcxGridDBColumn;
    cxgAcessoriosDBTableViewCitel1CODIGO: TcxGridDBColumn;
    cxgAcessoriosDBTableViewCitel1QUANTIDADE: TcxGridDBColumn;
    cxGridNegociacaoDiarias: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn;
    pnlRodapeNegociacao: TPanel;
    pnlRodapeEquipamentos: TPanel;
    cdsAcessoriosEQA_SEQACL: TStringField;
    lblLocacaoMensal: TLabel;
    edtVlLocM: TCurrencyEditFocus;
    btnHeranca: TBitBtnLocked;
    lblNroPatrimonio: TLabel;
    dbeNroPat: TDBEditFocus;
    lblEquipOS: TLabel;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    ckSemSerie: TcxCheckBox;
    cdsAcessoriosEQA_VLRADC: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsCadEquStateChange(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure mmoEspecfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCodAclKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAclExit(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarNegociacaoDiariaClick(Sender: TObject);
    procedure btnCancelaItemNegociacaoClick(Sender: TObject);
    procedure cxgAcessoriosDBTableViewCitel1KeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeStatusExit(Sender: TObject);
    procedure cdsAcessoriosBeforePost(DataSet: TDataSet);
    procedure btnHerancaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEquKeyPress(Sender: TObject; var Key: Char);
    procedure ckSemSerieClick(Sender: TObject);
  private
    { Private declarations }
    objCadLot: TCadLot;
    objAcessorio: TEquipamentoLocacaoAcessorio;
    objEquLoc: TEquipamentoLocacaoPrincipal;
    qryCadEql: TUniQuery;
    objLiberacao: TLiberacao;
    strSitAnt: String;
    blnckSemSerieAnt: Boolean;
    FintLocDec: Integer;
    FstrLocDec: String;

    procedure pIniciarInclusao;
    procedure pHabilitarComponentes(blnHabilitar: Boolean);
    procedure pLimparComponentes;
    procedure pAdicionarItemGrid(const aItem: TEquipamentoItemAcessorio);
    procedure pGravarAcessorios;
    procedure pGravarNegociacaoDiarias;
    function  fCarregaAcessorio(const aCodAcl: string): Boolean;
    procedure pLimpaItens;
    procedure pLimpaItensNegociacao;
    procedure pAdicionarNegociacaoDiariaGrid(const aItem: TNegociacaoDiaria);
    procedure pCarregaAcessorios;
    procedure pCarregaNegociacaoDiarias;
    procedure pAbreCadastroProduto;
    procedure pCarregarCodEqu;
    procedure ConfigurarCasasDecimaisValorLocacao;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesConsulta,
  untPanelCxClientes, untPnlDadosEquLocacao, untPanelCxInfoEquLocacao,
  untCadProdutos, untHerancaCadEqu;

procedure TfrmCadEquLocacao.btnAdicionarClick(Sender: TObject);
var
  item: TEquipamentoItemAcessorio;
begin
  inherited;

  If (Not fValidaCampos(edtCodAcl, True))  Then
    Exit;

  If (fStrToFloat(edtQtdAcl.Text) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade de itens.', ['&OK']);
    pSetFocus(edtQtdAcl);
    Exit;
  End
  Else
  Begin

    If Not objAcessorio.fValidaQuantidadeItemFracionado(fStrToFloat(edtQtdAcl.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', objAcessorio.Mensagem, ['&OK']);
      pSetFocus(edtQtdAcl);
      Exit;
    End;
  End;

  item := objEquLoc.AddItem;
  Try
    item.Quantidade := StrToFloatDef( edtQtdAcl.Text, 0 );
    item.Acessorio.Codigo := objAcessorio.Codigo;
    item.Acessorio.AutInc := objAcessorio.AutInc;
    item.Acessorio.Descricao := objAcessorio.Descricao;
    item.Acessorio.ValorAdicional := objAcessorio.ValorAdicional;

    pAdicionarItemGrid(item);
  Finally
    pLimpaItens;
    pSetFocus(edtCodAcl);
  End;

end;

procedure TfrmCadEquLocacao.btnAdicionarNegociacaoDiariaClick(Sender: TObject);
var
  item: TNegociacaoDiaria;
begin
  inherited;

  If (fStrToFloat(edtQtdDias.Text) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade de dias.', ['&OK']);
    pSetFocus(edtQtdDias);
    Exit;
  End
  Else
  If (fStrToFloat(edtQtdDias.Text) = 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor da diária (1 dia) deve ser informado no campo "Valor de Locação (Diária)" da guia Geral', ['&OK']);
    pSetFocus(edtQtdDias);
    Exit;
  End
  Else
  Begin
    If Not objEquLoc.fValidarDiariaNegociacao(StrToIntDef(edtQtdDias.Text, 0)) Then
    Begin
      fMensagem('ATENÇÃO!', objEquLoc.Mensagem, ['&OK']);
      pSetFocus(edtQtdDias);
      Exit;
    End;
  End;

  If (fStrToFloat(edtVlrTot.Text) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o valor total das diárias.', ['&OK']);
    pSetFocus(edtVlrTot);
    Exit;
  End;

  item := objEquLoc.AddNegociacaoDiaria;
  Try
    item.pAdicionaValorDiaria(StrToIntDef(edtQtdDias.Text,0), fStrToFloat(edtVlrTot.Text));

    pAdicionarNegociacaoDiariaGrid(item);
  Finally
    pLimpaItensNegociacao;
    pSetFocus(edtQtdDias);
  End;
end;

procedure TfrmCadEquLocacao.btnAlterarClick(Sender: TObject);
begin

  inherited;

  pHabilitarComponentes(True);

  If (qryTabela.FieldByName('EQL_STATUS').AsString = 'I') Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'O equipamento está INATIVO, para alterá-lo deverá ativá-lo novamente. Deseja prosseguir?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      qryTabela.FieldByName('EQL_STATUS').AsString := 'A';
      mskDtaVen.Text := '__/__/____';
      mskDtaVen.Enabled := False;
    End
    Else
    Begin
      btnCancela.Click();
      Exit;
    End;
  End;

  If (qryTabela.FieldByName('EQL_STATUS').AsString = 'B') Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'O equipamento está BLOQUEADO, para alterá-lo deverá ativá-lo novamente. Deseja prosseguir?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      qryTabela.FieldByName('EQL_STATUS').AsString := 'A';
      mskDtaVen.Text := '__/__/____';
      mskDtaVen.Enabled := False;
    End
    Else
    Begin
      btnCancela.Click();
      Exit;
    End;
  End;

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);

  dbeStatus.Enabled := fVerificaAcessoSistema('EQUSIT');

  pSetFocus(dbeDescri);
end;

procedure TfrmCadEquLocacao.btnCancelaClick(Sender: TObject);
begin
  inherited;

  mskDtaAqu.Text  := qryTabela.FieldByName('EQL_DTAAQU').AsString;
  mskDtUlMn.Text  := qryTabela.FieldByName('EQL_DTULMN').AsString;
  mskDtaVen.Text  := qryTabela.FieldByName('EQL_DTAVEN').AsString;
  edtValAqu.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_VALAQU').AsFloat);
  edtValLoc.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VALLOC').AsFloat);
  edtCodIte.Text  := qryTabela.FieldByName('EQL_CODITE').AsString;
  edtDesIte.Text  := fRetNomProduto(qryTabela.FieldByName('EQL_CODITE').AsString);
  mmoEspecf.Texto := qryTabela.FieldByName('EQL_ESPECF').AsString;
  edtVlLocD.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VLLOCD').AsFloat);
  edtDscVen.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCVEN').AsFloat);
  edtDscSGe.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCSGE').AsFloat);
  edtDscGer.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCGER').AsFloat);
  edtVlrCau.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_VLRCAU').AsFloat);
  edtVlLocM.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VLLOCM').AsFloat);
  edtCodEqu.Text  := qryTabela.FieldByName('EQL_CODEQU').AsString;

  pCarregaAcessorios;
  pCarregaNegociacaoDiarias;

  pHabilitarComponentes(False);
end;

procedure TfrmCadEquLocacao.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pLimpaItens;
  cdsAcessorios.Cancel;
  pSetFocus(edtCodAcl);
end;

procedure TfrmCadEquLocacao.btnCancelaItemNegociacaoClick(Sender: TObject);
begin
  inherited;

  pLimpaItensNegociacao;
  cdsNegociacaoDiarias.Cancel;
  pSetFocus(edtQtdDias);
end;

procedure TfrmCadEquLocacao.btnExcluirClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If (blnExcluiu) Then
    Begin
      fCommit;
      pLimparComponentes();
      pHabilitarComponentes(False);
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupos.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadEquLocacao.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (Not fVerificaCampos()) Then Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaAqu.Text))) Then
      qryTabela.FieldByName('EQL_DTAAQU').AsDateTime := StrToDate(mskDtaAqu.Text)
    Else
      qryTabela.FieldByName('EQL_DTAAQU').Clear();

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtUlMn.Text))) Then
      qryTabela.FieldByName('EQL_DTULMN').AsDateTime := StrToDate(mskDtUlMn.Text)
    Else
      qryTabela.FieldByName('EQL_DTULMN').Clear();

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text))) Then
      qryTabela.FieldByName('EQL_DTAVEN').AsDateTime := StrToDate(mskDtaVen.Text)
    Else
      qryTabela.FieldByName('EQL_DTAVEN').Clear();

    qryTabela.FieldByName('EQL_VALAQU').AsFloat  := StringToFloat(edtValAqu.Text);
    qryTabela.FieldByName('EQL_VALLOC').AsFloat  := StringToFloat(edtValLoc.Text);
    qryTabela.FieldByName('EQL_CODITE').AsString := edtCodIte.Text;
    qryTabela.FieldByName('EQL_ESPECF').AsString := mmoEspecf.Texto;

    qryTabela.FieldByName('EQL_VLLOCD').AsFloat  := StringToFloat(edtVlLocD.Text);
    qryTabela.FieldByName('EQL_DSCVEN').AsFloat  := StringToFloat(edtDscVen.Text);
    qryTabela.FieldByName('EQL_DSCSGE').AsFloat  := StringToFloat(edtDscSGe.Text);
    qryTabela.FieldByName('EQL_DSCGER').AsFloat  := StringToFloat(edtDscGer.Text);
    qryTabela.FieldByName('EQL_VLRCAU').AsFloat  := StringToFloat(edtVlrCau.Text);
    qryTabela.FieldByName('EQL_VLLOCM').AsFloat  := StringToFloat(edtVlLocM.Text);

    If fEmptyStr(edtCodEqu.Text) Then
      qryTabela.FieldByName('EQL_CODEQU').Clear()
    Else
      qryTabela.FieldByName('EQL_CODEQU').AsString := edtCodEqu.Text;

    qryTabela.FieldByName('EQL_SEMSER').AsString := IIF(ckSemSerie.Checked, 'S', 'N');

    inherited;

    If (blnGravou) Then Begin

      objEquLoc.AutInc := qryTabela.FieldByName('AUTOINCREM').AsString;
      objEquLoc.Codigo := qryTabela.FieldByName('EQL_CODIGO').AsString;
      pGravarAcessorios;
      pGravarNegociacaoDiarias;

      fCommit();
      pHabilitarComponentes(False);
      pLimpaItensNegociacao;
    End;

  Except
    On E: Exception Do Begin
      fRollBack();
      pMensagensErro(E.Message, '[TfrmCadEquLocacao.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadEquLocacao.btnHerancaClick(Sender: TObject);
var
  frmHerancaCadEqu: TfrmHerancaCadEqu;
  intCont: Integer;
  item: TEquipamentoItemAcessorio;
  itemNeg: TNegociacaoDiaria;
begin
  inherited;

  pCriarFormularios(TfrmHerancaCadEqu, frmHerancaCadEqu);
  Try
    frmHerancaCadEqu.tipoEquipamento := tpPrincipal;
    frmHerancaCadEqu.ShowModal;

    If frmHerancaCadEqu.blnConfirma Then
    Begin
      qryTabela.FieldByName('EQL_DESCRI').AsString := frmHerancaCadEqu.objHerEqu.objEqu.Descricao;
      qryTabela.FieldByName('EQL_GARANT').AsFloat  := frmHerancaCadEqu.objHerEqu.objEqu.Garantia;
      qryTabela.FieldByName('EQL_RPULMN').AsString := frmHerancaCadEqu.objHerEqu.objEqu.ResponsavelUltimaManutencao;;
      qryTabela.FieldByName('EQL_MODELO').AsString := frmHerancaCadEqu.objHerEqu.objEqu.Modelo;
      qryTabela.FieldByName('EQL_ANOFAB').AsFloat  := frmHerancaCadEqu.objHerEqu.objEqu.AnoFabricacao;
      qryTabela.FieldByName('EQL_LOCFIS').AsString := frmHerancaCadEqu.objHerEqu.objEqu.LocalizacaoFisica;
      qryTabela.FieldByName('EQL_NUMPAT').AsString := frmHerancaCadEqu.objHerEqu.objEqu.NumPatrimonio;

      dbeStatus.Text := frmHerancaCadEqu.objHerEqu.objEqu.Status;
      mskDtaAqu.Text := DateTimeToStr(frmHerancaCadEqu.objHerEqu.objEqu.DataAquisicao);
      mskDtUlMn.Text := DateTimeToStr(frmHerancaCadEqu.objHerEqu.objEqu.DataUltimaManutencao);
      edtValAqu.Value := frmHerancaCadEqu.objHerEqu.objEqu.ValorAquisicao;
      edtValLoc.Value := frmHerancaCadEqu.objHerEqu.objEqu.ValorLocacao;
      edtVlLocD.Value := frmHerancaCadEqu.objHerEqu.objEqu.ValorLocacaoDiaria;
      edtVlLocM.Value := frmHerancaCadEqu.objHerEqu.objEqu.ValorLocacaoMensal;
      edtCodIte.Text := frmHerancaCadEqu.objHerEqu.objEqu.CodigoItem;
      edtDesIte.Text := frmHerancaCadEqu.objHerEqu.objEqu.DescricaoItem;
      mmoEspecf.Lines.Text := frmHerancaCadEqu.objHerEqu.objEqu.Especificacao;
      edtDscGer.Text := FloatToStr(frmHerancaCadEqu.objHerEqu.objEqu.ValorDescontoGerente);
      edtDscSGe.Text := FloatToStr(frmHerancaCadEqu.objHerEqu.objEqu.ValorDescontoSubGerente);
      edtDscVen.Text := FloatToStr(frmHerancaCadEqu.objHerEqu.objEqu.ValorDescontoVendedor);
      edtVlrCau.Text := FloatToStr(frmHerancaCadEqu.objHerEqu.objEqu.ValorCaucao);
      edtCodEqu.Text := frmHerancaCadEqu.objHerEqu.objEqu.CodEquipamentoOS;
      edtDesEqu.Text := frmHerancaCadEqu.objHerEqu.objEqu.DesEquipamentoOS;

      ckSemSerie.Checked := frmHerancaCadEqu.objHerEqu.objEqu.blnNaoPossuiSerie;

      For intCont := 0 To frmHerancaCadEqu.objHerEqu.objEqu.Acessorios.Count-1 Do
      Begin
        item := frmHerancaCadEqu.objHerEqu.objEqu.Acessorios[intCont];
        pAdicionarItemGrid(item);
      End;

      For intCont := 0 To frmHerancaCadEqu.objHerEqu.objEqu.Diarias.Count-1 Do
      Begin
        itemNeg := frmHerancaCadEqu.objHerEqu.objEqu.Diarias[intCont];
        pAdicionarNegociacaoDiariaGrid(itemNeg);
      End;
    End;
  Finally
    pFreeAndNil(frmHerancaCadEqu);
  End;
end;

procedure TfrmCadEquLocacao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pIniciarInclusao();
end;

procedure TfrmCadEquLocacao.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrCadEql: TConsultasArray;
  objfrmPnl : TPanelCxInfoEquLocacao;
begin
  inherited;

  strSitAnt := EmptyStr;
  blnckSemSerieAnt := False;

  chrKey := '/';

  Try
    Try
      objfrmPnl := TPanelCxInfoEquLocacao.Create(TfrmPnlDadosEquLocacao);
      objfrmPnl.strNomForm := self.name;

      If fPesqCadastroEquipLocacao(Self, Nil, Nil, qryTabela, chrKey, arrCadEql, True, '', 0,0, objfrmPnl) Then
      Begin

        If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
        Begin
          objEquLoc.pCarregaEquipamento(qryTabela.FieldByName('AUTOINCREM').AsString);

          mskDtaAqu.Text  := qryTabela.FieldByName('EQL_DTAAQU').AsString;
          mskDtUlMn.Text  := qryTabela.FieldByName('EQL_DTULMN').AsString;
          mskDtaVen.Text  := qryTabela.FieldByName('EQL_DTAVEN').AsString;
          edtValAqu.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_VALAQU').AsFloat);
          edtValLoc.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VALLOC').AsFloat);
          edtCodIte.Text  := qryTabela.FieldByName('EQL_CODITE').AsString;
          edtDesIte.Text  := fRetNomProduto(qryTabela.FieldByName('EQL_CODITE').AsString);
          mmoEspecf.Texto := qryTabela.FieldByName('EQL_ESPECF').AsString;
          edtVlLocD.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VLLOCD').AsFloat);
          edtDscVen.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCVEN').AsFloat);
          edtDscSGe.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCSGE').AsFloat);
          edtDscGer.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_DSCGER').AsFloat);
          edtVlrCau.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('EQL_VLRCAU').AsFloat);
          edtVlLocM.Text  := FormatFloat(FstrLocDec, qryTabela.FieldByName('EQL_VLLOCM').AsFloat);
          edtCodEqu.Text  := qryTabela.FieldByName('EQL_CODEQU').AsString;

          blnckSemSerieAnt := IIF(qryTabela.FieldByName('EQL_SEMSER').AsString = 'S', True, False);
          ckSemSerie.Checked := IIF(qryTabela.FieldByName('EQL_SEMSER').AsString = 'S', True, False);


          pCarregarCodEqu;
          pCarregaAcessorios;
          pCarregaNegociacaoDiarias;

          pHabilitarComponentes(False);
        End;

        pSetFocus(btnAlterar);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    End;
  Finally
    FreeAndNil(objfrmPnl);
  End;

end;

procedure TfrmCadEquLocacao.cdsAcessoriosBeforePost(DataSet: TDataSet);
begin
  inherited;

  objAcessorio.fCarregaAcessorio(DataSet.FieldByName('CODIGO').AsString);

  If DataSet.FieldByName('QUANTIDADE').AsFloat <= 0  Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade de itens.', ['&OK']);
    DataSet.Cancel;
    Abort;
  End;

  If Not objAcessorio.fValidaQuantidadeItemFracionado(DataSet.FieldByName('QUANTIDADE').AsFloat) Then
  Begin
    fMensagem('ATENÇÃO!', objAcessorio.Mensagem, ['&OK']);
    DataSet.Cancel;
    Abort;
  End;

end;

procedure TfrmCadEquLocacao.ckSemSerieClick(Sender: TObject);
begin

  If (qryTabela.State in dsEditModes) Then
  Begin
    If ckSemSerie.Checked Then
    Begin
      dbeNSerie.Enabled := False;

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'EQSSER';
      objLiberacao.strMsgSen    := 'Permitir Alterar a opção "Não possui Série" do Equipamento';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Permitir Alterar a opção "Não possui Série" do Equipamento');
      objLiberacao.objMsgLibera.pAddTexto('Equipamento: '+ dbeCodigo.Text + '-' + dbeDescri.Text);

      If Not objLiberacao.fLibera Then
        ckSemSerie.Checked := False;
      End
    Else
      dbeNSerie.Enabled := True;
  End;

  inherited;

end;

procedure TfrmCadEquLocacao.cxgAcessoriosDBTableViewCitel1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If cdsAcessorios.IsEmpty Then
    Exit;

  If (Key = VK_DELETE) Then
  Begin
    If fMensagem('', 'Deseja excluir esse item?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      objEquLoc.fRemoveAcessorio(cdsAcessorios.FieldByName('CODIGO').AsString);
      cdsAcessorios.Delete;
    End;
  End;

  Case Key Of
    VK_RETURN,
    VK_UP,
    VK_DOWN : Begin
                objAcessorio.fCarregaAcessorio(cdsAcessorios.FieldByName('CODIGO').AsString);

                If cdsAcessorios.FieldByName('QUANTIDADE').AsFloat <= 0  Then
                Begin
                  fMensagem('ATENÇÃO!', 'Informe a quantidade de itens.', ['&OK']);
                End;

                If Not objAcessorio.fValidaQuantidadeItemFracionado(cdsAcessorios.FieldByName('QUANTIDADE').AsFloat) Then
                Begin
                  fMensagem('ATENÇÃO!', objAcessorio.Mensagem, ['&OK']);
                End;
              End;
  End;

end;

procedure TfrmCadEquLocacao.cxGridDBTableViewCitel1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If (Not cdsNegociacaoDiarias.IsEmpty) Then
    Begin
      If fMensagem('', 'Deseja excluir esse item?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        objEquLoc.fRemoveDiaria(cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger);
        cdsNegociacaoDiarias.Delete;
      End;
    End;
  End;
end;

procedure TfrmCadEquLocacao.dbeStatusExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(dbeStatus, False);
end;

procedure TfrmCadEquLocacao.dtsCadEquStateChange(Sender: TObject);
begin
  inherited;

  mskDtaAqu.Enabled := qryTabela.State in dsEditModes;
  mskDtUlMn.Enabled := qryTabela.State in dsEditModes;
  mskDtaVen.Enabled := qryTabela.State in dsEditModes;
  edtValAqu.Enabled := qryTabela.State in dsEditModes;
  edtValLoc.Enabled := qryTabela.State in dsEditModes;
  edtCodIte.Enabled := qryTabela.State in dsEditModes;
  edtVlLocD.Enabled := qryTabela.State in dsEditModes;
  edtDscVen.Enabled := qryTabela.State in dsEditModes;
  edtDscSGe.Enabled := qryTabela.State in dsEditModes;
  edtDscGer.Enabled := qryTabela.State in dsEditModes;
  edtVlrCau.Enabled := qryTabela.State in dsEditModes;
  edtVlLocM.Enabled := qryTabela.State in dsEditModes;
  edtCodEqu.Enabled := qryTabela.State in dsEditModes;
  ckSemSerie.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadEquLocacao.edtCodAclExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodAcl.Text) Then
    fValidaCampos(edtCodAcl, False);
end;

procedure TfrmCadEquLocacao.edtCodAclKeyPress(Sender: TObject; var Key: Char);
Var
  arrAcessorio: TConsultasArray;
begin
  inherited;

  If fPesqAcessorioLocacao(Self, edtCodAcl, edtDesAcl, Nil, Key, arrAcessorio) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEquLocacao.edtCodEquKeyPress(Sender: TObject; var Key: Char);
Var
  arrCodEqu: TConsultasArray;
begin
  inherited;

  If fPesqEquipamento(Self, edtCodEqu, edtDesEqu, nil, Key,  arrCodEqu) Then
  Begin
    fValidaCampos(edtCodEqu, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadEquLocacao.edtCodIteKeyPress(Sender: TObject; var Key: Char);
Var
  arrProduto: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1',
     '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, True, '', False, False, False, False, False, False, False, False, '', -1,
     False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', True) Then
  Begin
    fValidaCampos(edtCodIte, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadEquLocacao.fCarregaAcessorio(const aCodAcl: string): Boolean;
begin

  edtDesAcl.Text := EmptyStr;
  Result := True;

  If Not objAcessorio.fCarregaAcessorio(aCodAcl) Then
  Begin
    Result := False;
    If Not fEmptyStr(objAcessorio.Mensagem) Then
      fMensagem('ATENÇÃO!', objAcessorio.Mensagem, ['&OK'])
    Else
      fMensagem('', 'Acessório não encontrado!', ['&Ok']);
  End
  Else
  Begin
    edtDesAcl.Text := objAcessorio.Descricao;
    If fEmptyStr(edtDesAcl.Text) Then
    Begin
      Result := False;
      fMensagem('', 'Acessório não encontrado!', ['&Ok']);
      edtCodAcl.Clear;
    End
    Else
    If Not objEquLoc.fVerificaAcessorio(edtCodAcl.Text) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', objEquLoc.Mensagem, ['&OK']);
    End;
  End;
end;

procedure TfrmCadEquLocacao.FormCreate(Sender: TObject);
Var
  strSQL: String;
begin
  inherited;
  pSetaCodIte(edtCodIte);
  strNomeTabela := 'CADEQL';
  strNomeCampo  := 'EQL_CODIGO';

  strSQL        := 'SELECT * FROM CADEQL';
  qryCadEql     := fCriarQuery(strSQL, Self);
  qryTabela     := qryCadEql;
  dtsCadEqu.DataSet := qryTabela;

  objCadLot := TCadLot.Create(Self);

  objEquLoc := TEquipamentoLocacaoPrincipal.Create;

  objAcessorio := TEquipamentoLocacaoAcessorio.Create;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;


  If Not fCfgSis('UTIACE', VarBoolean) Then
  Begin
    tsAcessorios.TabVisible := False;
  End
  Else
  Begin
    cdsAcessorios.CreateDataSet;
  End;

  If Not fCfgSis('CTRMES', VarBoolean) Then
  Begin
    lblLocacaoMensal.Visible := False;
    edtVlLocM.Visible := False;
  End;

  cdsNegociacaoDiarias.CreateDataSet;

  objLiberacao := TLiberacao.create;

  If Not fCfgSis('RETGOS', varBoolean) Then
  Begin
    lblEquipOS.Visible := False;
    edtCodEqu.Visible := False;
    edtDesEqu.Visible := False;

    lblEspecf.Top := lblEquipOS.Top;
    mmoEspecf.Height := mmoEspecf.Height + edtCodEqu.Height;
    mmoEspecf.Top := edtCodEqu.Top;
  End;

  ConfigurarCasasDecimaisValorLocacao;

end;

procedure TfrmCadEquLocacao.ConfigurarCasasDecimaisValorLocacao;
Begin
  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);

  edtValLoc.Properties.DecimalPlaces := FintLocDec;
  edtVlLocD.Properties.DecimalPlaces := FintLocDec;
  edtVlLocM.Properties.DecimalPlaces := FintLocDec;

  If FintLocDec = 4 Then
  Begin
    edtValLoc.Properties.DisplayFormat := 'R$ ,0.0000;-R$ ,0.0000';
    edtVlLocD.Properties.DisplayFormat := 'R$ ,0.0000;-R$ ,0.0000';
    edtVlLocM.Properties.DisplayFormat := 'R$ ,0.0000;-R$ ,0.0000';
  End
  Else If FintLocDec = 3 Then
  Begin
    edtValLoc.Properties.DisplayFormat := 'R$ ,0.000;-R$ ,0.000';
    edtVlLocD.Properties.DisplayFormat := 'R$ ,0.000;-R$ ,0.000';
    edtVlLocM.Properties.DisplayFormat := 'R$ ,0.000;-R$ ,0.000';
  End
  Else
  Begin
    edtValLoc.Properties.DisplayFormat := 'R$ ,0.00;-R$ ,0.00';
    edtVlLocD.Properties.DisplayFormat := 'R$ ,0.00;-R$ ,0.00';
    edtVlLocM.Properties.DisplayFormat := 'R$ ,0.00;-R$ ,0.00';
  End;
End;

procedure TfrmCadEquLocacao.FormDestroy(Sender: TObject);
begin

  FreeAndNil(objCadLot);
  FreeAndNil(objAcessorio);
  FreeAndNil(objEquLoc);
  FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmCadEquLocacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) Then
  Begin
    If edtCodIte.Focused Then
      pAbreCadastroProduto;
  End;
end;

procedure TfrmCadEquLocacao.FormShow(Sender: TObject);
begin
  inherited;

  pgcDados.ActivePage := tbsGeral;

  pHabilitarComponentes(False);

  pSetFocus(btnIncluir);
end;

function TfrmCadEquLocacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeDescri) Then
    Begin
      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Descrição deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeNSerie) Then
    Begin
      ckSemSerie.Enabled := fEmptyStr(dbeNSerie.Text);
      If (fEmptyStr(dbeNSerie.Text)) And (Not ckSemSerie.Checked) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Número de Série deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValAqu) Then
    Begin
      If (fEmptyStr(edtValAqu.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Valor de Aquisição deve ser informado!', ['&OK']);
        Result := False;
      End
      Else If (fStrToFloat(edtValAqu.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Valor de Aquisição deve ser maior ou igual a 0 (zero)!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValLoc) Then
    Begin
      If (fEmptyStr(edtValLoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Valor de Locação deve ser informado!', ['&OK']);
        Result := False;
      End
      Else If (fStrToFloat(edtValLoc.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Valor de Locação deve ser maior ou igual a 0 (zero)!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeGarant) Then
    Begin
      If (fEmptyStr(dbeGarant.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Garantia deve ser informado!', ['&OK']);
        Result := False;
      End
      Else If (fStrToFloat(dbeGarant.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Garantia deve ser maior ou igual a 0 (zero)!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin
      If (fEmptyStr(edtCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Produto deve ser informado!', ['&OK']);
        Result := False;
      End
      Else Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Produto informado é inválido!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If Not objEquLoc.fValidaItemLocacao(edtCodIte.Text) Then
          Begin
            fMensagem('ATENÇÃO!', objEquLoc.Mensagem, ['&OK']);
            Result := False;
          End
          Else
          If (objCadLot.tplTipLot = tplArmazem) And (not objCadLot.fExisteLotePrincipalAluguelEquipamento(edtCodIte.Text, VS_strCodEmp)) Then
          Begin
            Result := fMensagem('', 'O produto não possui um armazem principal para locação de equipamentos! Cadastre o armazem antes de efetuar o cadastro do equipamento!', ['&OK']) = -1;
          End;
        End;
      End;
    End

    Else If (Sender = dbeAnoFab) Then
    Begin
      If (Not fEmptyStr(dbeAnoFab.Text)) And (StrToInt(dbeAnoFab.Text) > 0) And (StrToInt(dbeAnoFab.Text) < 1900) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Ano de Fabricação deve ser maior ou igual a 1900!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaVen) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text))) And (dbeStatus.Text = 'A') Then
      Begin
        If (fMensagem('CONFIRMAÇÃO!', 'Uma Data de Venda foi informada, isso irá INATIVAR o equipamento. Deseja prosseguir?', ['&Sim', '&Não'], 2) = 1) Then Begin
          qryTabela.FieldByName('EQL_STATUS').AsString := 'I';
          pHabilitarComponentes(False);
        End
        Else
        Begin
          mskDtaVen.Text := '__/__/____';
        End;
      End;
    End

    Else If (Sender = edtCodAcl) Then
    Begin
      If Not (fEmptyStr(edtCodAcl.Text)) Then
      Begin
        Result := fCarregaAcessorio(edtCodAcl.Text);
      End;
    End

    Else If (Sender = dbeStatus) Then
    Begin
      If (fEmptyStr(dbeStatus.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Status deve ser informado!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeStatus.Text, 'AIB') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Status precisa ser do tipo "A" - Ativo, "I" - Inativo ou "B" - Bloqueado!', ['&OK']);
          Result := False;
        End
        Else
        If (dbeStatus.Text <> 'A') Then
        Begin
          If strSitAnt <> dbeStatus.Text Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'EQUSIT';
            objLiberacao.strMsgSen    := 'Alterar situação de equipamentos e acessórios';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Permitir alterar situação de equipamentos e acessórios.');

            Result := objLiberacao.fLibera;

            If Result Then
              strSitAnt := dbeStatus.Text;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodEqu) Then
    Begin
      If fCfgSis('RETGOS', varBoolean) And (fEmptyStr(edtCodEqu.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Equipamento para OS" deve ser informado!', ['&OK']);
        Result := False;
      End;

      If Not (fEmptyStr(edtCodEqu.Text)) Then
      Begin
        pCarregarCodEqu;

        If (fEmptyStr(edtDesEqu.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Equipamento informado é inválido!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEquLocacao.mmoEspecfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmCadEquLocacao.pAbreCadastroProduto;
var
  frmCadProdutos: TfrmCadProdutos;
begin
  If Not fVerificaAcessoSistema('frmCadProdutos') Then
    Exit;

  pCriarFormularios(TfrmCadProdutos, frmCadProdutos);
  Try
    frmCadProdutos.strCodIteParaCarregar := edtCodIte.Text;
    frmCadProdutos.ShowModal;
  Finally
    pFreeAndNil(frmCadProdutos);
  End;
end;

procedure TfrmCadEquLocacao.pAdicionarItemGrid(const aItem: TEquipamentoItemAcessorio);
begin
  cdsAcessorios.DisableControls;
  Try
    Try
      cdsAcessorios.Insert;
      cdsAcessorios.FieldByName('CODIGO').AsString     := aItem.Acessorio.Codigo;
      cdsAcessorios.FieldByName('EQA_SEQACL').AsString := aItem.Acessorio.AutInc;
      cdsAcessorios.FieldByName('DESCRICAO').AsString  := aItem.Acessorio.Descricao;
      cdsAcessorios.FieldByName('QUANTIDADE').AsFloat  := aItem.Quantidade;
      cdsAcessorios.FieldByName('EQA_VLRADC').AsFloat  := aItem.Acessorio.ValorAdicional;

      cdsAcessorios.Post;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadEquLocacao.pCarregarItemGrid]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmCadEquLocacao.pAdicionarNegociacaoDiariaGrid(
  const aItem: TNegociacaoDiaria);
begin
  cdsNegociacaoDiarias.DisableControls;
  Try
    Try
      cdsNegociacaoDiarias.Insert;
      cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger := aItem.QuantidadeDias;
      cdsNegociacaoDiarias.FieldByName('VLRTOT').AsFloat   := aItem.ValorTotal;
      cdsNegociacaoDiarias.FieldByName('VLRDIA').AsFloat   := aItem.ValorDiaria;
      cdsNegociacaoDiarias.Post;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadEquLocacao.pAdicionarNegociacaoDiariaGrid]');
      End;
    End;
  Finally
    cdsNegociacaoDiarias.EnableControls;
  End;
end;

procedure TfrmCadEquLocacao.pCarregaAcessorios;
var
  intCnt: Integer;
begin
  If Not tsAcessorios.TabVisible Then
    Exit;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;

  pLimpaItens;

  objEquLoc.pCarregaEquipamento(qryTabela.FieldByName('AUTOINCREM').AsString);
  For intCnt := 0 to objEquLoc.Acessorios.Count-1 Do
  Begin
    pAdicionarItemGrid(objEquLoc.Acessorios[intCnt]);
  End;

end;

procedure TfrmCadEquLocacao.pCarregaNegociacaoDiarias;
var
  intCnt: Integer;
begin
  If cdsNegociacaoDiarias.Active Then
    cdsNegociacaoDiarias.EmptyDataSet;

  For intCnt := 0 to objEquLoc.Diarias.Count-1 Do
  Begin
    pAdicionarNegociacaoDiariaGrid(objEquLoc.Diarias[intCnt]);
  End;
end;

procedure TfrmCadEquLocacao.pCarregarCodEqu;
begin
  If Not fEmptyStr(edtCodEqu.Text) Then
  Begin
    edtDesEqu.Text := fRetNomEquipamentoOs(edtCodEqu.Text);
  End;
end;

procedure TfrmCadEquLocacao.pGravarAcessorios;
var
  item: TEquipamentoItemAcessorio;
begin
  If Not tsAcessorios.TabVisible Then
    Exit;

  Try
    objEquLoc.pExcluirItens;

    cdsAcessorios.DisableControls;
    cdsAcessorios.First;
    While not cdsAcessorios.Eof Do
    Begin
      item := objEquLoc.AddItem;
      item.Acessorio.Codigo := cdsAcessorios.FieldByName('CODIGO').AsString;
      item.Acessorio.AutInc := cdsAcessorios.FieldByName('EQA_SEQACL').AsString;
      item.Quantidade       := cdsAcessorios.FieldByName('QUANTIDADE').AsInteger;
      item.ValorAdicional   := cdsAcessorios.FieldByName('EQA_VLRADC').AsFloat;
      item.fInserir;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.First;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmCadEquLocacao.pGravarNegociacaoDiarias;
var
  item: TNegociacaoDiaria;
begin

  Try
    objEquLoc.pExcluirDiarias;

    cdsNegociacaoDiarias.DisableControls;
    cdsNegociacaoDiarias.First;
    While not cdsNegociacaoDiarias.Eof Do
    Begin
      item := objEquLoc.AddNegociacaoDiaria;
      item.QuantidadeDias := cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger;
      item.ValorTotal     := cdsNegociacaoDiarias.FieldByName('VLRTOT').AsFloat;
      item.ValorDiaria    := cdsNegociacaoDiarias.FieldByName('VLRDIA').AsFloat;
      item.fInserir;

      cdsNegociacaoDiarias.Next;
    End;
  Finally
    cdsNegociacaoDiarias.First;
    cdsNegociacaoDiarias.EnableControls;
  End;
end;

procedure TfrmCadEquLocacao.pHabilitarComponentes(blnHabilitar: Boolean);
begin
  dbeCodigo.Enabled := blnHabilitar;
  dbeDescri.Enabled := blnHabilitar;
  dbeNSerie.Enabled := blnHabilitar And (Not ckSemSerie.Checked);
  edtValAqu.Enabled := blnHabilitar;
  edtValLoc.Enabled := blnHabilitar;
  dbeGarant.Enabled := blnHabilitar;
  dbeRpUlMn.Enabled := blnHabilitar;
  dbeModelo.Enabled := blnHabilitar;
  dbeAnoFab.Enabled := blnHabilitar;
  mmoEspecf.Enabled := blnHabilitar;
  dbeLocFis.Enabled := blnHabilitar;
  edtCodIte.Enabled := blnHabilitar;
  dbeStatus.Enabled := blnHabilitar;
  mskDtUlMn.Enabled := blnHabilitar;
  mskDtaAqu.Enabled := blnHabilitar;
  mskDtaVen.Enabled := blnHabilitar;
  edtVlLocD.Enabled := blnHabilitar;
  edtDscVen.Enabled := blnHabilitar;
  edtDscSGe.Enabled := blnHabilitar;
  edtDscGer.Enabled := blnHabilitar;
  edtVlrCau.Enabled := blnHabilitar;
  btnAdicionar.Enabled := blnHabilitar;
  btnCancelaItem.Enabled := blnHabilitar;
  btnAdicionarNegociacaoDiaria.Enabled := blnHabilitar;
  btnCancelaItemNegociacao.Enabled := blnHabilitar;
  cxgAcessorios.Enabled := blnHabilitar;
  cxGridNegociacaoDiarias.Enabled := blnHabilitar;
  edtVlLocM.Enabled := blnHabilitar;
  btnHeranca.Enabled := blnHabilitar;
  edtCodEqu.Enabled := blnHabilitar;
  ckSemSerie.Enabled := blnHabilitar And (fEmptyStr(dbeNSerie.Text))
end;

procedure TfrmCadEquLocacao.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EQL_CODIGO');
  stlCampos.Add('EQL_DESCRI');
  stlCampos.Add('EQL_NSERIE');
  stlCampos.Add('EQL_DTAAQU');
  stlCampos.Add('EQL_VALAQU');
  stlCampos.Add('EQL_VALLOC');
  stlCampos.Add('EQL_GARANT');
  stlCampos.Add('EQL_DTULMN');
  stlCampos.Add('EQL_RPULMN');
  stlCampos.Add('EQL_MODELO');
  stlCampos.Add('EQL_ANOFAB');
  stlCampos.Add('EQL_ESPECF');
  stlCampos.Add('EQL_LOCFIS');
  stlCampos.Add('EQL_CODITE');
  stlCampos.Add('EQL_DTAVEN');
  stlCampos.Add('EQL_STATUS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EQL_DESCRI');
  stlCamInd.Add('EQL_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadEquLocacao.pIniciarInclusao;
begin
  objEquLoc.pLimpar;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;
  If cdsNegociacaoDiarias.Active Then
    cdsNegociacaoDiarias.EmptyDataSet;

  pLimparComponentes();

  pHabilitarComponentes(True);

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);

  qryTabela.FieldByName('EQL_STATUS').AsString := 'A';

  dbeStatus.Enabled := fVerificaAcessoSistema('EQUSIT');
  mskDtaVen.Enabled := False;

  pSetFocus(dbeDescri);
end;

procedure TfrmCadEquLocacao.pLimpaItens;
begin
  edtCodAcl.Clear;
  edtDesAcl.Clear;
  edtQtdAcl.Clear;
end;

procedure TfrmCadEquLocacao.pLimpaItensNegociacao;
begin
  edtQtdDias.Clear;
  edtVlrTot.Clear;
end;

procedure TfrmCadEquLocacao.pLimparComponentes;
begin
  mskDtaAqu.Clear;
  mskDtUlMn.Clear;
  mskDtaVen.Clear;
  edtValAqu.Clear;
  edtValLoc.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  mmoEspecf.Clear;
  edtVlLocD.Clear;
  edtDscVen.Clear;
  edtDscSGe.Clear;
  edtDscGer.Clear;
  edtVlrCau.Clear;
  edtVlLocM.Clear;
  edtCodEqu.Clear;
  edtDesEqu.Clear;
  ckSemSerie.Checked := False;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;
  If cdsNegociacaoDiarias.Active Then
    cdsNegociacaoDiarias.EmptyDataSet;
end;

end.
