unit untRetornoLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, Uni, untFuncFat, untCadLote,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos, cadastro.Controller.ContratoLocacaoEquipamentos,
  untTypesSistema, MaskEditFocus, untTLock, untFuncoesLocEqu, untTypesLocEqu;

type
  TfrmRetornoLocEqu = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    lblQtde: TLabel;
    edtCodCli: TDBEditFocus;
    edtNomCli: TDBEditFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TDBEditFocus;
    edtQtde: TDBEditFocus;
    edtLocalizacao: TDBEditFocus;
    grpDetalhes: TGroupBox;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    dtsContrato: TDataSource;
    grpAcessorios: TGroupBox;
    cxGridCitelAcessorio: TcxGridCitel;
    cxGridDBTableViewCitelAcessorio: TcxGridDBTableViewCitel;
    cxGridDBColumnEQD_SEQACL: TcxGridDBColumn;
    cxGridDBColumnEQD_DESCR: TcxGridDBColumn;
    cxGridDBColumnEQD_QTDACL: TcxGridDBColumn;
    cxGridDBColumnEQD_STTIPS: TcxGridDBColumn;
    cxGridDBColumnEQD_DOCENV: TcxGridDBColumn;
    cxGridDBColumnEQD_MARDES: TcxGridDBColumn;
    cxGridLevel1Acessorio: TcxGridLevel;
    cdsAcessorios: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField6: TStringField;
    cdsAcessoriosEQD_QTDACL: TFloatField;
    cdsAcessoriosAUTOINCREM: TStringField;
    cdsAcessoriosEQD_SEQACL: TStringField;
    dtsAcessorios: TDataSource;
    pnlEquipamentos: TPanel;
    grdItens: TcxGridCitel;
    grdItensView: TcxGridDBTableViewCitel;
    grdItensEQL_CODIGO: TcxGridDBColumn;
    grdItensEQL_DESCRI: TcxGridDBColumn;
    grdItensEQL_NSERIE: TcxGridDBColumn;
    grdItensEQD_STTIPE: TcxGridDBColumn;
    grdItensEQD_DOCRET: TcxGridDBColumn;
    grdItensEQD_MARDES: TcxGridDBColumn;
    grdItensLvl: TcxGridLevel;
    Panel1: TPanel;
    cdsEqlDet: TUniClientDataSet;
    cdsEqlDetEQD_SEQEQL: TStringField;
    cdsEqlDetEQD_DESCRI: TStringField;
    cdsEqlDetEQD_NSERIE: TStringField;
    cdsEqlDetEQD_MARDES: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    dtsEqlDet: TDataSource;
    cdsEqlDetEQD_STTIPE: TStringField;
    cdsEqlDetEQD_DOCRET: TStringField;
    cdsAcessoriosEQD_DOCRET: TStringField;
    cdsAcessoriosEQD_STTIPE: TStringField;
    grbDuracao: TGroupBox;
    pnlDuracaoDiariaHoras: TPanel;
    lblInicio: TLabel;
    lblTermino: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    edtDtaFin: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    pnlDuracaoMensal: TPanel;
    lblMesIni: TLabel;
    lblMesFin: TLabel;
    edtMesIni: TMaskEditFocus;
    edtMesFin: TMaskEditFocus;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    grdItensEQD_QTDEQU: TcxGridDBColumn;
    cdsAcessoriosEQA_QTDTOT: TFloatField;
    cxGridDBColumnEQA_QTDTOT: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridDBTableViewCitelAcessorioCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    ObjItemAcessorio: TAcessorioContratoLocacaoEquipamentos;
    ObjItemEquipamento: TItemContratoLocacaoEquipamentos;

    ObjRetornoCtr: TRetornoContrato;
    blnCarregandoItens: Boolean;
    FTipoDocEnvio: String;
    FobjLock: TLock;

    function fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    function fPodeMarcarEquipamento(blnMostraMensagem: Boolean): Boolean;
    function fVerificaSelecionado(): Boolean;
    function fConfirmaRetornoNota: Boolean;
    function fAdicionarDadosNota(const blnAdicionarAcessorios: Boolean = True): Boolean;
    function fSelecionaTipoFaturamento: Boolean;

    procedure pCarregarEquipamentos;
    procedure pCarregarAcessorios;
    procedure pMarcarEquipamento(blnMarcar: Boolean);
    procedure pMarcarAcessorio(blnMarcar: Boolean);
    procedure pMarcarAcessoriosEquipamento(const strCodEql: String; blnMarcar: Boolean);
    procedure pMarcarTodosEquipamentos(blnMarcar: Boolean);
    procedure pMarcarTodos(blnMarcar: Boolean);
    procedure pAdicionaEquipamentosNota;
    procedure pAdicionaAcessoriosNota;

    function fSelecionarNotaExistente: Boolean;
    function fEmitirDoc: Boolean;
    function fImportarNFe: Boolean;
    function fInformarXMLImportado: Boolean;
    procedure pConfirmarDocumentoRetorno(const intOpcao: integer);
    procedure pProcessarOrdemServico;
    procedure pImprimirComprovante;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

const
  cstEmitirDoc = 1;
  cstInformNFE = 2;
  cstImportNFe = 3;
  cstInformXML = 4;

implementation

uses untFuncoesSimples, untConsultas, untGravando, untFuncoes,
  untFuncFatTypes, untSelDocEntrada, untEntImportacaoNotaEletronica, untEntImportaNotaElet,
  untEntDigPedido, untFatTipoFaturamento, untObservacao;

{$R *.dfm}

function TfrmRetornoLocEqu.fSelecionarNotaExistente: Boolean;
var
  strNumDoc,
  strEspDoc,
  strCodEmp,
  strSerie: String;
begin
  Result := False;
  If ObjRetornoCtr.ObjNota.fSelecionaNotaEntradaExistente(strNumDoc, strEspDoc, strCodEmp, strSerie) Then
  Begin
    fStartTransaction;
    Try
      If fAdicionarDadosNota Then
      Begin
        Result := ObjRetornoCtr.ObjNota.fGravaDadosDocumentoRetorno(strNumDoc, strEspDoc, strCodEmp, strSerie);
      End;

      If Result Then
      Begin
        fCommit;
        fMensagem('ATENÇÃO', 'Nota de entrada relacionada ao item do contrato com sucesso!', ['&Ok']);
      End
      Else
        fRollBack;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmRetornoLocEqu.fSelecionarNotaExistente]');
      End;
    End;
  End;
end;

function TfrmRetornoLocEqu.fSelecionaTipoFaturamento: Boolean;
Var
  arrOpcoes: TOpcoesFaturamentoArray;
  frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);
  FTipoDocEnvio := 'NF';

  If ((Not fCfgSis('PREMFF', varBoolean)) or ( Not fCfgSis('PERMFF', varBoolean))) Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    arrOpcoes[0].strDesCri := 'Nota Fiscal';
    arrOpcoes[0].strEspDoc := 'NF';
    arrOpcoes[0].strOpcLet := 'N';
    arrOpcoes[0].strMosMen := 'S';

    arrOpcoes[1].strDesCri := 'Faturamento Futuro';
    arrOpcoes[1].strEspDoc := 'FF';
    arrOpcoes[1].strOpcLet := 'F';
    arrOpcoes[1].strMosMen := 'N';

    Try
      pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
      frmFatTipoFaturamento.strOpcDoc := 'LE';
      frmFatTipoFaturamento.fatVenda  := ObjRetornoCtr.ObjNota.ObjFatVenda;
      frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
      frmFatTipoFaturamento.showModal;

      If frmFatTipoFaturamento.blnConfirma Then
      Begin
        FTipoDocEnvio := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmRetornoLocEqu.fSelecionaTipoFaturamento]');
      End;
    End;

  Finally
    pFreeAndNil(frmFatTipoFaturamento);
    SetLength(arrOpcoes, 0);
  end;
End;

function TfrmRetornoLocEqu.fEmitirDoc: Boolean;
Begin
  If Not fAdicionarDadosNota Then
    Exit(False);

  If Not fSelecionaTipoFaturamento Then
    Exit(False);

  fStartTransaction;
  Try
    Result := fConfirmaRetornoNota();
    If Result Then
    Begin
      fCommit;
      fMensagem('ATENÇÃO', 'Documento de retorno emitido com sucesso!', ['&Ok']);
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmRetornoLocEqu.fEmitirDoc]');
    End;
  End;
End;

function TfrmRetornoLocEqu.fImportarNFe: Boolean;
var
  frmEntImportaNotaElet: TfrmEntImportaNotaElet;
Begin
  Result := False;

  If not fVerificaAcessoSistema('frmEntImportaNotaElet') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de importação de nota fiscal eletrônica!', ['&Ok']);
    Exit;
  End;

  strListIdGerEle.Clear;

  pCriarFormularios(TfrmEntImportaNotaElet, frmEntImportaNotaElet);
  Try
    fStartTransaction;
    Try
      frmEntImportaNotaElet.blnAcessadoViaRetornoLocacao := True;
      frmEntImportaNotaElet.strCodCli := ObjRetornoCtr.ObjContrato.CodCliente;
      frmEntImportaNotaElet.rdgTipXML.ItemIndex  := Ord(xmlRetornoLocacao);
      frmEntImportaNotaElet.btnImportarClick(frmEntImportaNotaElet.btnImportar);
      If frmEntImportaNotaElet.blnEntradaEfetivada Then
      Begin
        If fAdicionarDadosNota Then
        Begin
          Result := ObjRetornoCtr.ObjNota.fGravaDadosDocumentoRetorno(frmEntImportaNotaElet.strNumDoc , frmEntImportaNotaElet.strEspDoc, frmEntImportaNotaElet.strCodEmp, frmEntImportaNotaElet.strNumSer);
        End;
      End;

      If Result Then
      Begin
        fCommit;
        fMensagem('ATENÇÃO', 'Nota de entrada relacionada ao item do contrato com sucesso!', ['&Ok']);
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmRetornoLocEqu.fImportarNFe]');
      End;
    End;
  Finally
    pFreeAndNil(frmEntImportaNotaElet);
  End;
End;

function TfrmRetornoLocEqu.fInformarXMLImportado: Boolean;
var
  frmEntDigPedido: TfrmEntDigPedido;
Begin
  Result := False;

  If not fVerificaAcessoSistema('frmEntDigPedido') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de entrada de mercadorias.', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);
  Try
    fStartTransaction;
    Try
      frmEntDigPedido.blnAcessadoViaRetornoLocacao := True;
      frmEntDigPedido.strCodCli := ObjRetornoCtr.ObjContrato.CodCliente;
      frmEntDigPedido.ShowModal;
      If frmEntDigPedido.blnEntradaEfetivada Then
      Begin
        If fAdicionarDadosNota Then
        Begin
          Result := ObjRetornoCtr.ObjNota.fGravaDadosDocumentoRetorno(frmEntDigPedido.strNumDoc , 'NF', frmEntDigPedido.strCodEmp, frmEntDigPedido.strNumSer);
        End;
      End;

      If Result Then
      Begin
        fCommit;
        fMensagem('ATENÇÃO', 'Nota de entrada relacionada ao item do contrato com sucesso!', ['&Ok']);
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmRetornoLocEqu.fInformarXMLImportado]');
      End;
    End;
  Finally
    pFreeAndNil(frmEntDigPedido);
  End;
End;

procedure TfrmRetornoLocEqu.pConfirmarDocumentoRetorno(const intOpcao: integer);
var
  blnConfirma: Boolean;
Begin
  Case intOpcao of
    cstEmitirDoc : blnConfirma := fEmitirDoc;
    cstInformNFE : blnConfirma := fSelecionarNotaExistente;
    cstImportNFe : blnConfirma := fImportarNFe;
    cstInformXML : blnConfirma := fInformarXMLImportado;
    Else
      Exit;
  End;

  If Not blnConfirma Then
    Exit;

  Try
    If fCfgSis('CMPRET', varBoolean) Then
    Begin
      If fMensagem('ATENÇÃO!', 'Deseja imprimir o comprovante de retorno?', ['&Sim', '&Não'], 2) = 1 Then
        pImprimirComprovante;
    End;

    pProcessarOrdemServico;

    ObjRetornoCtr.ObjContrato.pCarregarItensContrato;
    pCarregarEquipamentos;
    pCarregarAcessorios;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRetornoLocEqu.pConfirmarDocumentoRetorno]');
    End;
  End;

End;

procedure TfrmRetornoLocEqu.pImprimirComprovante;
var
  objImp: TImpressaoComprovanteContrato;
begin
  objImp := TImpressaoComprovanteContrato.Create;
  Try
    objImp.fImprimirComprovanteRetorno(ObjRetornoCtr.ObjContrato.NroContrato,
                                       ObjRetornoCtr.ObjNota.EspDoc,
                                       ObjRetornoCtr.ObjNota.EmpDoc,
                                       ObjRetornoCtr.ObjNota.NumDoc
                                       );
  Finally
    FreeAndNil(objImp);
  End;
end;

procedure TfrmRetornoLocEqu.btnConfirmaClick(Sender: TObject);
var
  intOpcao: Integer;
begin
  inherited;

  If Not fVerificaSelecionado() Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum equipamento selecionado!', ['&Ok']);
    Exit;
  End;

  intOpcao := fGetMenu('Escolha o Tipo de NF de Entrada', ['Emitir nota fiscal (Outras Entradas)',
                                                           'Informar nota já existente',
                                                           'Entrada - Importar XML',
                                                           'Entrada - Xml já importado', 'Sair'], 1);
  pConfirmarDocumentoRetorno(intOpcao);
end;

procedure TfrmRetornoLocEqu.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(False);
end;

procedure TfrmRetornoLocEqu.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(True);
end;

procedure TfrmRetornoLocEqu.cxGridDBTableViewCitelAcessorioCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridDBColumnEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmRetornoLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmRetornoLocEqu.edtNumPedKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRetornoLocEqu.pAdicionaAcessoriosNota;
var
  item: TItemNotaContratoLocacao;
  intRecNo: Integer;
begin
  If Not fCfgSis('UTIACE', VarBoolean) Then
    Exit;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        ObjItemAcessorio := ObjRetornoCtr.ObjContrato.fRetornaItemAcessorioContrato(cdsAcessorios.FieldByName('EQD_SEQEQL').AsString, cdsAcessorios.FieldByName('EQD_SEQACL').AsString);

        item := ObjRetornoCtr.ObjNota.fAdicionarAcessorio;
        item.AcessorioContrato := ObjItemAcessorio;
        item.CodigoItem := ObjItemAcessorio.Acessorio.CodigoItem;
        item.DescricaoEquipamento := ObjItemAcessorio.Acessorio.Descricao;
        item.fltQtdIte := ObjItemAcessorio.Quantidade * ObjItemAcessorio.ItemEquipamento.Quantidade;
      End;
      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmRetornoLocEqu.pAdicionaEquipamentosNota;
var
  item: TItemNotaContratoLocacao;
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;

  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        ObjItemEquipamento := ObjRetornoCtr.ObjContrato.fRetornaItemContrato(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

        item := ObjRetornoCtr.ObjNota.fAdicionarProduto;
        item.ItemContrato := ObjItemEquipamento;
        item.CodigoItem := ObjItemEquipamento.Equipamento.CodigoItem;
        item.DescricaoEquipamento := ObjItemEquipamento.Equipamento.Descricao;
        item.fltQtdIte := ObjItemEquipamento.Quantidade;
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

function TfrmRetornoLocEqu.fAdicionarDadosNota(const blnAdicionarAcessorios: Boolean = True): Boolean;
begin
  Try
    ObjRetornoCtr.ObjNota.pLimparItens;
    pAdicionaEquipamentosNota;

    If blnAdicionarAcessorios Then
      pAdicionaAcessoriosNota;

    Result := ObjRetornoCtr.ObjNota.Itens.Count > 0;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmEnvioLocEqu.fAdicionarDadosNota]');
    End;
  End;
end;

function TfrmRetornoLocEqu.fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin
  ObjRetornoCtr.ObjContrato.pLimpar;
  ObjRetornoCtr.ObjContrato.fCarregarContrato('', strNumeroContrato, True, strNumPed);
  ObjRetornoCtr.ObjNota.Contrato := ObjRetornoCtr.ObjContrato;

  If Not ObjRetornoCtr.Valida.fVerificaPodeRealizarRetorno Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', ObjRetornoCtr.Valida.strMensagemRetorno, ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fValidaTravasContrato(ObjRetornoCtr.ObjContrato.AutInc)) Then
  Begin
    Exit(False);
  End;

  edtMesIni.Text := ObjRetornoCtr.objContrato.strMesIni;
  edtMesFin.Text := ObjRetornoCtr.objContrato.strMesFin;
  edtNumCon.Text := ObjRetornoCtr.ObjContrato.NroContrato;
  edtCodCli.Text := ObjRetornoCtr.ObjContrato.CodCliente;
  edtNomCli.Text := ObjRetornoCtr.ObjContrato.NomCliente;
  edtCodVen.Text := ObjRetornoCtr.ObjContrato.Vendedor.Codigo;
  edtNomVen.Text := ObjRetornoCtr.ObjContrato.Vendedor.Nome;
  edtLocalizacao.Text := ObjRetornoCtr.ObjContrato.Localizacao;
  edtNumPed.Text := Copy(ObjRetornoCtr.ObjContrato.NumDocPedAdiantamento, 0, 12);
  edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', ObjRetornoCtr.ObjContrato.DataInicial);
  edtHorIni.Text := FormatDateTime('hh:mm', ObjRetornoCtr.ObjContrato.HoraInicial);
  edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', ObjRetornoCtr.ObjContrato.DataFinal);
  edtHorFIn.Text := FormatDateTime('hh:mm', ObjRetornoCtr.ObjContrato.HoraFinal);
  edtQtde.Text   := FloatToStr(ObjRetornoCtr.ObjContrato.QuantidadeEquipamentos);

  pCarregarEquipamentos;
  pCarregarAcessorios;

  pSetFocus(grdItens);
  grdItensView.DataController.FocusedRowIndex := 0;

  If Not(fEmptyStr(ObjRetornoCtr.ObjContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_RETORN_LOCEQU + ObjRetornoCtr.ObjContrato.AutInc, True, False);

  Result := True;

end;

function TfrmRetornoLocEqu.fConfirmaRetornoNota: Boolean;
var
  frmObservacao: TfrmObservacao;
Begin
  Result := ObjRetornoCtr.ObjNota.fEmiteDocumentoSimplesRemessaRetorno(FTipoDocEnvio);

  If (Not Result) And (Not fEmptyStr(ObjRetornoCtr.ObjNota.MensagemRetorno)) Then
  Begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    Try
      frmObservacao.Caption             := 'Retorno de documentos';
      frmObservacao.lblMensagem.Caption := 'Documento não gerado';
      frmObservacao.memObs.Lines.Add(ObjRetornoCtr.ObjNota.MensagemRetorno);
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  End;

end;

procedure TfrmRetornoLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  cdsEqlDet.CreateDataSet;
  cdsAcessorios.CreateDataSet;

  grpAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);

  ObjRetornoCtr := TRetornoContrato.Create;

  grpAcessorios.Visible := fCfgSis('UTIACE', VarBoolean);
  strListIdGerEle.Clear;

  If Not (fCfgSis('CTRMES', VarBoolean)) Then
  Begin
    pnlDuracaoMensal.Visible := False;
    grbDuracao.Height := grbDuracao.Height - pnlDuracaoMensal.Height + 5;
    pnlDadosContrato.Height := pnlDadosContrato.Height - pnlDuracaoMensal.Height;
  End;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNomCli.Left;
    lblNumCon.Left := lblCodCli.Left;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmRetornoLocEqu.FormDestroy(Sender: TObject);
begin

  FobjLock.fLock_Unlock(cst_TRAVA_RETORN_LOCEQU + ObjRetornoCtr.ObjContrato.AutInc, False, False);
  FreeAndNil(FobjLock);

  If Assigned(ObjItemAcessorio) Then
    FreeAndNil(ObjItemAcessorio);
  If Assigned(ObjItemEquipamento) Then
    FreeAndNil(ObjItemEquipamento);

  inherited;
end;

procedure TfrmRetornoLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) And (Shift = []) And btnConfirma.Enabled Then
    btnConfirma.Click
  Else If (Key = VK_F3) And (Shift = []) And btnMarcarTodos.Enabled Then
    btnMarcarTodos.Click
  Else If (Key = VK_F4) And (Shift = []) And btnDesmarcarTodos.Enabled Then
    btnDesmarcarTodos.Click;
end;

procedure TfrmRetornoLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmRetornoLocEqu.fPodeMarcarEquipamento(blnMostraMensagem: Boolean): Boolean;
begin
  Result := True;

  If cdsEqlDet.FieldByName('EQD_STTIPE').AsString = 'PENDENTE' Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Não foi realizada a inspeção de entrada desse equipamento.', ['&Ok']);

    Result := False;
    Exit;
  End;

  If Not fEmptyStr(cdsEqlDet.FieldByName('EQD_DOCRET').AsString) Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Já foi emitido um documento de retorno desse equipamento.', ['&Ok']);

    Result := False;
    Exit;
  End;
end;

function TfrmRetornoLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtNumCon) Then
    Begin
      If fEmptyStr(edtNumCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Informe o número do contrato.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fCarregarContrato(edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmRetornoLocEqu.fVerificaSelecionado: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      Result := cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M';

      If Result Then
        Exit;

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;

  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      Result := cdsAcessorios.FieldByName('EQD_MARDES').AsString = 'M';

      If Result Then
        Exit;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;

end;

procedure TfrmRetornoLocEqu.grdItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.Values[grdItensEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmRetornoLocEqu.grdItensViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: If (cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M') Or fPodeMarcarEquipamento(True) Then
                   pMarcarEquipamento(cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'D');
  End;
end;

procedure TfrmRetornoLocEqu.pAfterOpen(DataSet: TDataSet);
begin
  TTimeField(DataSet.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
  TTimeField(DataSet.FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';
end;

procedure TfrmRetornoLocEqu.pCarregarAcessorios;
var
  intCnt,
  intCont: Integer;
  aItem: TAcessorioContratoLocacaoEquipamentos;
begin
  If Not fCfgSis('UTIACE', VarBoolean) Then
    Exit;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;

  If Not Assigned(ObjRetornoCtr.objContrato) Then
    Exit;

  If blnCarregandoItens Then
    Exit;

  cdsAcessorios.DisableControls;
  Try
    Try
      For intCont := 0 to ObjRetornoCtr.objContrato.Itens.Count  -1 Do
      Begin
        For intCnt := 0 to ObjRetornoCtr.objContrato.Itens[intCont].Acessorios.Count  -1 Do
        Begin
          aItem := ObjRetornoCtr.objContrato.Itens[intCont].Acessorios[intCnt];

          cdsAcessorios.Insert;
          cdsAcessorios.FieldByName('AUTOINCREM').AsString := aItem.AutInc;
          cdsAcessorios.FieldByName('EQD_SEQEQL').AsString := aItem.CodEquipamento;
          cdsAcessorios.FieldByName('EQD_SEQACL').AsString := aItem.Acessorio.Codigo;
          cdsAcessorios.FieldByName('EQD_DESCRI').AsString := aItem.Acessorio.Descricao;
          cdsAcessorios.FieldByName('EQD_QTDACL').AsFloat  := aItem.Quantidade;
          cdsAcessorios.FieldByName('EQD_STTIPE').AsString := aItem.strInspecaoEntrada;
          cdsAcessorios.FieldByName('EQD_DOCRET').AsString := aItem.strDocRet;
          cdsAcessorios.FieldByName('EQD_MARDES').AsString := 'N';
          cdsAcessorios.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * ObjRetornoCtr.objContrato.Itens[intCont].Quantidade;
          cdsAcessorios.Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRetornoLocEqu.pCarregarAcessorios]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmRetornoLocEqu.pCarregarEquipamentos;
var
  intCnt: Integer;
begin
  blnCarregandoItens := True;

  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If cdsAcessorios.Active Then
    cdsAcessorios.EmptyDataSet;

  cdsEqlDet.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjRetornoCtr.ObjContrato.Itens.Count-1 Do
      Begin
        cdsEqlDet.Insert;
        cdsEqlDet.FieldByName('AUTOINCREM').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].AutInc;
        cdsEqlDet.FieldByName('EQD_SEQEQL').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDet.FieldByName('EQD_DESCRI').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQD_NSERIE').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDet.FieldByName('EQD_DOCRET').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].strDocRet;
        cdsEqlDet.FieldByName('EQD_STTIPE').AsString := ObjRetornoCtr.ObjContrato.Itens[intCnt].strInspecaoEntrada;
        cdsEqlDet.FieldByName('EQD_MARDES').AsString := 'N';
        cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat  := ObjRetornoCtr.ObjContrato.Itens[intCnt].Quantidade;
        cdsEqlDet.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRetornoLocEqu.pCarregarEquipamentos]');
      End;
    End;
  Finally
    cdsEqlDet.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmRetornoLocEqu.pMarcarAcessorio(blnMarcar: Boolean);
begin
  cdsAcessorios.Edit;
  cdsAcessorios.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsAcessorios.Post;
end;

procedure TfrmRetornoLocEqu.pMarcarAcessoriosEquipamento(
  const strCodEql: String; blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsAcessorios.DisableControls;
  intRecNo := cdsAcessorios.RecNo;
  Try
    cdsAcessorios.First;
    While Not cdsAcessorios.Eof Do
    Begin
      If strCodEql = cdsAcessorios.FieldByName('EQD_SEQEQL').AsString Then
      Begin
        pMarcarAcessorio(blnMarcar);
      End;

      cdsAcessorios.Next;
    End;
  Finally
    cdsAcessorios.RecNo := intRecNo;
    cdsAcessorios.EnableControls;
  End;
end;

procedure TfrmRetornoLocEqu.pMarcarEquipamento(blnMarcar: Boolean);
begin
  cdsEqlDet.Edit;
  cdsEqlDet.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsEqlDet.Post;

  pMarcarAcessoriosEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString, blnMarcar);
end;

procedure TfrmRetornoLocEqu.pMarcarTodos(blnMarcar: Boolean);
begin
  pMarcarTodosEquipamentos(blnMarcar);
end;

procedure TfrmRetornoLocEqu.pMarcarTodosEquipamentos(blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If (Not blnMarcar) Or fPodeMarcarEquipamento(False) Then
        pMarcarEquipamento(blnMarcar);

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmRetornoLocEqu.pProcessarOrdemServico;
begin
  If Not fAdicionarDadosNota(False) Then
    Exit;

  ObjRetornoCtr.pProcessarOSContrato;

  If Not fEmptyStr( ObjRetornoCtr.strMensagemRetorno) Then
    fMensagem('ATENÇÃO', ObjRetornoCtr.strMensagemRetorno, ['&Ok']);

  If Not fEmptyStr( ObjRetornoCtr.strMensagemRetornoOk) Then
    fMensagem('ATENÇÃO', ObjRetornoCtr.strMensagemRetornoOk, ['&Ok']);

  ObjRetornoCtr.ObjNota.pLimparItens;
end;

end.
