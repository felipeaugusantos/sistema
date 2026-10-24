unit untRelFatVendasCliente;

interface               

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, Menus, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, ComObj, untTypesSistema,
  UniDataSetProvider, UniClientDataSet, DB, DateUtils,  untITintasDeMaquina,
  BitBtnLockedIncrem, untExcel, ComboBoxFocus, frxExportCSVTestabilidade,
  Vcl.ComCtrls, cxProgressBar, untFrameCentroCustoEditFocus;

type
  TfrmRelFatVendasCliente = class(TfrmPaiRelatorio)
    gpbTipo: TGroupBox;
    edtTipo: TEditFocus;
    ColorLabel2: TColorLabel;
    gpbMargem: TGroupBox;
    edtMargem: TEditFocus;
    ColorLabel3: TColorLabel;
    rdgOrdem: TRadioGroup;
    gpbAjuste: TGroupBox;
    ColorLabel4: TColorLabel;
    edtAjuste: TEditFocus;
    gpbCancelados: TGroupBox;
    ColorLabel5: TColorLabel;
    edtDocCan: TEditFocus;
    svdExcel: TSaveDialog;
    pnlMovRede: TPanel;
    shpMargem: TShape;
    rdgEmpresa: TRadioGroup;
    chkMovRede: TCheckBox;
    gpbExiSom: TGroupBox;
    chkSomDev: TCheckBox;
    chkSomTra: TCheckBox;
    chkSomCon: TCheckBox;
    chkSomFut: TCheckBox;
    chkSomBai: TCheckBox;
    ColorLabel6: TColorLabel;
    ColorLabel7: TColorLabel;
    pnlAutPas: TPanel;
    gpbAutCen: TGroupBox;
    edtDesMod: TEditFocus;
    edtDesCor: TEditFocus;
    edtCodCor: TEditFocus;
    Label24: TLabel;
    edtAno: TEditFocus;
    Label23: TLabel;
    edtCodMod: TEditFocus;
    Label22: TLabel;
    edtDesMar: TEditFocus;
    edtCodMar: TEditFocus;
    Label21: TLabel;
    pgbProgresso: TProgressBar;
    mskPlaVei: TMaskEditFocus;
    Label17: TLabel;
    edtDesVei: TEditFocus;
    chkRefUni: TCheckBox;
    pnlEventos: TPanel;
    lblCodEmb: TLabel;
    edtCodEmb: TEditFocus;
    edtNomEmb: TEditFocus;
    pnlFiltros: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    lblEmpresa: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    shpLiberado: TShape;
    Label2: TLabel;
    Label14: TLabel;
    lbl1: TLabel;
    lblTintasDisp: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    shpRepres: TShape;
    lblComCus: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    lblRegiao: TLabel;
    Label26: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodVendedor: TEditFocus;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtDesVendedor: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtProdutos: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    edtCodCidade: TEditFocus;
    edtDesCidade: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtCodAtividade: TEditFocus;
    edtDesAtividade: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtTintasDisp: TEditFocus;
    edtDesTinta: TEditFocus;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    cbbComCus: TComboBoxFocus;
    edtCodCliExcluir: TEditFocus;
    edtDesCliExcluir: TEditFocus;
    edtCodCliCon: TEditFocus;
    edtNomCliCon: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodFase: TEditFocus;
    edtDesFase: TEditFocus;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    edtConNom: TEditFocus;
    lblCodCla: TLabel;
    edtCodClaFis: TEditFocus;
    edtDesClaFis: TEditFocus;
    Label27: TLabel;
    cbbEndCli: TComboBoxFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    lblNumCmp: TLabel;
    edtNumCmp: TEditFocus;
    lblForPag: TLabel;
    edtDesFpg: TEditFocus;
    edtCodFpg: TEditFocus;
    frxRelatorioJ: TfrxReport;
    chkExbTATL: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);

    function fExisteClientesFilial(strCodigos: String): Integer;
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);

    procedure edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidadeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodCliConKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtividadeExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtTintasDispKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure chkSomDevClick(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodCliConExit(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure mskPlaVeiExit(Sender: TObject);
    procedure edtCodCliExcluirKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExcluirExit(Sender: TObject);
    procedure edtCodModKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodModExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodCorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCorExit(Sender: TObject);
    procedure edtCodFaseExit(Sender: TObject);
    procedure edtCodFaseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmbExit(Sender: TObject);
    procedure edtCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClaFisExit(Sender: TObject);
    procedure edtCodClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure edtCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFpgExit(Sender: TObject);
    function frxRelatorioJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure frxGenGetValue(const VarName: string; var Value: Variant);

  private
    { Private declarations }
    dspRelVenCli: TUniDataSetProvider;
    cdsRelVenCli: TUniClientDataSet;
    QryRelatorio: TUniQuery;

    tintas      : ITintasDeMaquina;

    arrVeic,
    arrRepres,
    arrAtivid,
    arrFornec,
    arrMarca,
    arrCidade,
    arrVendedor,
    arrLinGru,
    arrCadIte,
    arrClientes,
    arrClientesExcluir,    
    arrConsumidor,
    arrEmpresa,
    arrRede,
    arrModelo,
    arrMarcaVei,
    arrCor,
    arrRegiao,
    arrFase,
    arrEmbarc,
    arrEvento,
    arrClasFiscal,
    arrForPag: TConsultasArray;

    strVeic,
    strRepres,
    strAtivid,
    strEmpresa,
    strFornec,
    strCidade,
    strMarca,
    strVendedor,
    strConsumidor,
    strCodRedeLojasCliente,
    strLinGru,
    strCadIte,
    strClientes,
    strClientesExcluir,
    strModelo,
    strMarcaVei,
    strCor,
    strRegiao,
    strFase,
    strEmbarc,
    strEvento,
    strClaFiscal,
    strForPag: String;

    strMsgConf : String;

    blnAcessoTodasAsEmpresas : Boolean;

    blnUsaSer: Boolean;

    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;

    function fFiltroClienteConsumidorFiltrandoPorNome: Boolean;
    function fRetTituloRel(strTipRel: String): String;
    procedure pCabecExcel(objExcel: TExcel);
    procedure pFormataExcel(objExcel: TExcel);

    function fGeraExcelAnalitico(pgbProgresso: TcxProgressBar): Boolean;
    function fGeraExcelSintetico(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSenhaMargem;
    function  fVerificaMetas: Double;
    procedure pMostraMovimentoRedeLojas;
    procedure pMostraDadosAutCen;
    function fGetCgcCli(DataSet: TDataSet): String;
    procedure pGerarExcel;
    procedure pSetaEmpresaSelect(var strSQL: String);
    procedure pSetaConsumidor;
    function fFiltrarVenMtl: Boolean;
    procedure pAjustarPosicaoComponentes(pnlAjuste: TPanel);
    function fMarkup4(strCampoTotIte: String): String;
    function fRetornaEntCli(strCodCli: string; intIndex: Integer): string;
    procedure pCarregaEndCli(strCodCli: string);
    function fVeioTelaVendas: Boolean;
    function fFormataCGCCli(strCGCCli: String): String;
  public
    { Public declarations }
    {************************************}
    {* VARIAVEL QUE SERÁ SETADA TRUE SE *}
    {* VIR DO FATURAMENTO (F9)          *}
    {*********************************AF*}
    blnFaturamento  : Boolean;

    blnPorVendedor  : Boolean;
    blnSomenteVendas: Boolean;
    blnPorLinha     : Boolean;
    oleVendas       : oleVariant;

    {************************************}
    {* VARIAVEL QUE SERÁ SETADA TRUE SE *}
    {* VIR DA CONSULTA DE ITENS (F9)    *}
    {*********************************ER*}
    blnConsultaItem: Boolean;
    blnConsultaDocumento: Boolean;

    blnVeioDoTelemarketing: Boolean;
    blnVeioDoTablet       : Boolean;
    blnVeioTelaVendas     : Boolean;

    blnCliCons   : Boolean;
    blnLiberado  : Boolean;
    blnRepLib    : Boolean;
    blnSenha     : Boolean;
    blnFiltroCFOP: Boolean;
    blnMosCom    : Boolean;
    blnDireitoTodasEmpresas: Boolean;

    strCodVen: String;
    strCodRep: String;
    fIncluirItem: TfIncluiItem;

    pMostraDocumentoReimpressao: TMostraDocumentoReimpressao;

    property strNumDoc:        String  read FNumDoc         write FNumDoc;
    property strEspDoc:        String  read FEspDoc         write FEspDoc;
    property strCodEmp:        String  read FCodEmp         write FCodEmp;

    function fGetArrEmbarc: TConsultasArray;
    function fGetArrEmbarcCodEmb: TConsultasArray;
    function fGetCodEmb: String;
    function fGetStrEmbarc: String;

    Class Procedure pMostraItensVendidos(strCodIte: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);
    Class Procedure pMostraDocumentosVendas(_strNumDoc, _strEspDoc, _strCodEmp: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelFatVendasCliente: TfrmRelFatVendasCliente;

implementation

uses untRelFatVendasClienteF9, untRelFatVendasItensF9,
  untIFuncoes, untRelFatVendasPorLinha, untOpcSoVenda, untConstantes,
  Math, untClassPanelCx, DBEditFocus, untFuncoesGenerica,
  untFuncoesSimples, untFuncTinta, untFuncoesConsulta, untConsultas,
  untGravando;

{$R *.dfm}

procedure TfrmRelFatVendasCliente.FormShow(Sender: TObject);
  Var
    arrCliStr: TStringArray;
    arrCliVar: TVariantArray;

    Function fHeightForm: Integer;
    Begin
      Result := pnlFiltros.Height + 7;

      If pnlEventos.Visible Then
        Result := Result + pnlEventos.Height;

      If pnlAutPas.Visible Then
        Result := Result + pnlAutPas.Height;

      If pnlMovRede.Visible And blnFaturamento Then
        Result := Result + pnlMovRede.Height;

      If (Not blnFaturamento) Then
        Result := Result + gpbTipo.Height + rdgOrdem.Height + 15;

      If pnlBotoes.Visible Then
        Result := Result + pnlBotoes.Height;

      If pnlStatus.Visible Then
        Result := Result + pnlStatus.Height;
    End;

begin
  blnLiberado := fVerificaAcessoSistema('RFVDCLI');
  blnRepLib   := fVerificaAcessoSistema('RMCREP');

  blnAcessoTodasAsEmpresas := ((Not fCfgSis('ACEMPI', varBoolean)) Or blnDireitoTodasEmpresas) And
                              (blnFaturamento);

  strCodRedeLojasCliente := '';

  If blnFaturamento Then
  Begin
    blnConsultaItem := False;

    SetLength(arrCliStr,1);
    arrCliStr[0] := 'CLI_CODCLI';

    SetLength(arrCliVar,1);
    arrCliVar[0] := edtCodCliente.Text;

    strCodRedeLojasCliente := fCampoTabela('CLI_CODRED', 'CADCLI', arrCliStr, arrCliVar);

  End;

  If blnFaturamento Then
    mskDtaIni.Text := DateToStr(VS_Date - fCfgSis('DIAVAN', VarInteger))
  Else
    mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  pMostraDadosAutCen;

  pnlEventos.Visible := (fCfgSis('EVEFAT', varBoolean)) Or (fCfgSis('CADEMB', varBoolean));

  fraCentroCusto.Visible := (fCfgSis('EVEFAT', varBoolean));

  lblCodEmb.Visible := (fCfgSis('CADEMB', varBoolean));
  edtCodEmb.Visible := (fCfgSis('CADEMB', varBoolean));
  edtNomEmb.Visible := (fCfgSis('CADEMB', varBoolean));

  If (pnlEventos.Visible) Then
  Begin
    If (Not fCfgSis('EVEFAT', varBoolean)) And (fCfgSis('CADEMB', varBoolean)) Then
    Begin
      lblCodEmb.Left := lblRegiao.Left;
      edtCodEmb.Left := edtCodReg.Left;
      edtNomEmb.Left := edtNomReg.Left;

      edtCodEmb.Width := edtCodReg.Width;
      edtNomEmb.Width := edtNomReg.Width;
    End;
  End;

  pMostraMovimentoRedeLojas;

  If not (pnlEventos.Visible) Then
    pAjustarPosicaoComponentes(pnlEventos);

  If fCfgSis('FASOBR') <> 'S' Then
  Begin
    Label20.Visible    := False;
    edtCodFase.Visible := False;
    edtDesFase.Visible := False;

    pnlFiltros.Height := pnlFiltros.Height - 35;
    Self.Height := Self.Height - 35;
  End;

  lblNumCmp.Visible := False;
  edtNumCmp.Visible := False;

  If blnFaturamento Then
  Begin
    gpbMargem.Visible     := False;
    gpbTipo.Visible       := False;
    gpbDestino.Visible    := False;
    gpbExiSom.Visible     := False;
    rdgOrdem.Visible      := False;
    gpbAjuste.Visible     := False;
    edtAjuste.Text        := 'N';
    gpbCancelados.Visible := False;
    lblComCus.Visible     := False;
    cbbComCus.Visible     := False;
    rdgEmpresa.Visible    := False;

    lblNumCmp.Visible := True;
    edtNumCmp.Visible := True;

    {*********************************************************************}
    {*  OPCAO FATUTRAMENTO NAO APARECE DO TIPO DE RELATORIO PARA BAIXO   *}
    {******************************************************************LA*}
    Self.ClientHeight := fHeightForm;

    If Not blnPorVendedor Then
    begin
      edtCodCliente.Enabled := False;
    end;
  End
  Else If blnConsultaItem Then
  Begin
    gpbMargem.Visible     := False;
    gpbTipo.Visible       := False;
    gpbDestino.Visible    := False;
    gpbExiSom.Visible     := False;
    rdgOrdem.Visible      := False;
    gpbAjuste.Visible     := True;
    gpbCancelados.Visible := False;
    lblComCus.Visible     := False;
    cbbComCus.Visible     := False;
    rdgEmpresa.Visible    := False;

    {*********************************************************************}
    {*  OPCAO FATUTRAMENTO NAO APARECE DO TIPO DE RELATORIO PARA BAIXO   *}
    {******************************************************************LA*}
    Self.ClientHeight := fHeightForm;
  End;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(nil);

  if ( edtCodCliente.Enabled = False ) or ( edtProdutos.Enabled = False )  then // COERENTE REVISAO 25556
  begin
    blnLiberado := fVerificaAcessoSistema('RFVDCLI');
    blnRepLib   := fVerificaAcessoSistema('RMCREP');

    If (Not edtCodCliente.Enabled) And
       (Not fEmptyStr(edtCodCliente.Text)) And
       (blnFaturamento) Then
    Begin
      blnLiberado := fVerificaAcessoSistema('TRVF9C');
    End;
  end;

  If (Not blnLiberado) Then
  Begin
    edtCodVendedor.Text := '';
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 0;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := EditFocus.ttAlfanumerico;
    shpLiberado.Brush.Color  := clRed;
  End
  Else
  Begin
    edtCodVendedor.TamCampo  := 3;
    edtCodVendedor.MaxLength := 3;
    edtCodVendedor.CompZeros := True;

    If blnSenha And (Not fEmptyStr(edtCodVendedor.Text)) Then
      edtCodVendedor.Text := fRetCodVendedor(edtCodVendedor.Text);

    shpLiberado.Brush.Color  := clGreen;
    edtCodVendedorExit(edtCodVendedor);
  End;

  If (Not blnRepLib) Then
  Begin
    edtCodRep.Text := '';
    edtCodRep.MaxLength := 10;
    edtCodRep.TamCampo  := 0;
    edtCodRep.CompZeros := False;
    edtCodRep.PasswordChar := '*';
    edtCodRep.TipoTexto := EditFocus.ttAlfanumerico;
    shpRepres.Brush.Color  := clRed;
  End
  Else
  Begin
    edtCodRep.TamCampo  := 3;
    edtCodRep.MaxLength := 3;
    edtCodRep.CompZeros := True;

    If blnSenha And (Not fEmptyStr(edtCodRep.Text)) Then
      edtCodRep.Text := fRetCodVendedor(edtCodRep.Text);

    shpRepres.Brush.Color  := clGreen;
    edtCodRepExit(edtCodRep);
  End;

  shpMargem.Brush.Color := clGreen;
  If Not fVerificaAcessoSistema('MARREL') Then
  Begin
    shpMargem.Brush.Color := clRed;
    edtMargem.TabStop := False;
    edtMargem.ReadOnly := True;
    edtMargem.Text := 'N';
  End;

  fValidaCampos(edtCodCliente, True);

  If blnFiltroCFOP Then
  Begin

    Try

      pCriarFormularios(TfrmOpcSoVenda, frmOpcSoVenda);
      frmOpcSoVenda.ShowModal;
      blnSomenteVendas := (frmOpcSoVenda.intRetorno = 1);

    Except
      On E: Exception Do
      Begin
        blnSomenteVendas := False;
        pMensagensErro(E.Message, '[frmOpcSoVenda]');
      End;
    End;

    pFreeAndNil(frmOpcSoVenda);

  End;

  If blnSomenteVendas Then
  Begin
    chkSomTra.Visible  := False;
    chkSomCon.Visible  := False;
    lblCodCla.Visible  := False;
    edtCodClaFis.Visible := False;
    edtDesClaFis.Visible := False;
  End;

  If (blnSomenteVendas) And (Not blnFaturamento) Then
    strMsgConf := ''
  Else
    strMsgConf := fGetMsgRelCnf;

  If (fCfgSis('MARMKP') = '4') Then
  Begin
    cbbComCus.Enabled := False;
    cbbComCus.Visible := False;
    lblComCus.Visible := False;
  End;

  pCarregaEndCli(edtCodCliente.Text);

  inherited;
end;

procedure TfrmRelFatVendasCliente.pCarregaEndCli(strCodCli: string);
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    cbbEndCli.Clear;
    cbbEndCli.Items.Add('Todos');

    if not fClienteConsumidor(edtDesCliente.Text, True, True) then
    begin
      with qryGen do
      begin
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('  CONCAT(TRIM(ETC_ENDENT), "-", TRIM(ETC_BAIENT), "-", TRIM(CID_NOMCID), "-", TRIM(CID_ESTADO)) AS ENDERE ');
        SQL.Add(' FROM ENTCLI JOIN CADCID ON ETC_CIDENT = CID_CODCID ');
        SQL.Add(' WHERE ETC_CODCLI = ' + QuotedStr(strCodCli));
        SQL.Add(' ORDER BY ETC_SEQIND ');
        Open;
        if not IsEmpty then
        begin
          First;
          while not EOF do
          begin
            cbbEndCli.Items.Add(FieldByName('ENDERE').AsString);
            Next;
          end;
        end;
      end;
    end
    else
      cbbEndCli.Enabled := False;

    cbbEndCli.ItemIndex := 0;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmRelFatVendasCliente.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

function TfrmRelFatVendasCliente.fRetornaEntCli(strCodCli: string; intIndex: Integer): string;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    with qryGen do
    begin
      SQL.Clear;
      SQL.Add(' SELECT AUTOINCREM FROM ENTCLI WHERE ETC_CODCLI = ' + QuotedStr(strCodCli));
      SQL.Add(' ORDER BY ETC_SEQIND LIMIT 1 OFFSET ' + IntToStr(intIndex - 1));
      Open;
      Result := FieldByName('AUTOINCREM').AsString;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmRelFatVendasCliente.FormCreate(Sender: TObject);
var
  frxRel: TfrxReport;
begin
  inherited;
  pSetaCodIte(edtProdutos);
  blnUsaSer               := (fCfgSis('AUTCEN', varBoolean)) Or (fCfgSis('USASER', varBoolean)) Or (fCfgSis('CONEQU', varBoolean));
  blnFaturamento          := False;
  blnVeioDoTelemarketing  := False;
  blnVeioDoTablet         := False;
  blnPorVendedor          := False;
  blnSomenteVendas        := False;
  blnFiltroCFOP           := False;
  blnVeioTelaVendas       := False;
  blnMosCom               := False;
  blnDireitoTodasEmpresas := False;
  blnConsultaDocumento    := False;

  pCarregaComposicaoCusto(cbbComCus);

  dspRelVenCli := TUniDataSetProvider.Create(Self);
  cdsRelVenCli := TUniClientDataSet.Create(Self);

  QryRelatorio := fCriaQuery;

  dspRelVenCli.DataSet := QryRelatorio;
  cdsRelVenCli.SetProvider(dspRelVenCli);

  If (VS_strUsaTmq = 'S') Then
  Begin
    tintas := fGetTintasdeMaquina();

    lblTintasDisp.Visible := True;
    edtTintasDisp.Visible := True;
    edtDesTinta.Visible   := True;
  End;

  FNumDoc        := '';
  FEspDoc        := '';
  FCodEmp        := '';

  fIncluirItem := nil;

  frxRel := frxRelatorioJ;

  frxRel.AddFunction('function fFormataCGCCli(strCGCCli: String): String;');
  frxRel.AddFunction('function fFormataFone(strFone: String): String;');
  frxRel.AddFunction('function fVeioTelaVendas(): Boolean;');
  frxRel.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRel.AddFunction('function fCalculaPrecoVenda(intOpcPrecoMargem: Integer; curPrecus: Double; curPreven: Double; curMarBru: Double; curIcmsVenda: Double; curImpFed: Double; curDesOpe: Double; curValCom: Double): Double;');

end;

procedure TfrmRelFatVendasCliente.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)
  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

function TfrmRelFatVendasCliente.frxRelatorioJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACGCCLI' Then
    Result := fFormataCGCCli(Params[0])
  Else If MethodName = 'FFORMATAFONE' Then
    Result := fFormataFone(Params[0])
  Else If MethodName = 'FVEIOTELAVENDAS' Then
    Result := fVeioTelaVendas
  Else If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0])
  Else If MethodName = 'FCALCULAPRECOVENDA' Then
    Result := fCalculaPrecoVenda(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5], Params[6], Params[7]);
end;

function TfrmRelFatVendasCliente.fVeioTelaVendas: Boolean;
begin
  Result := blnVeioTelaVendas;
end;

function TfrmRelFatVendasCliente.fFormataCGCCli(strCGCCli: String): String;
begin
  If Not fEmptyStr(strCGCCli) Then
    Result := IIF(Length(strCGCCli) > 11, '  CNPJ: ', '  CPF: ') + fFormataCpfCgc(strCGCCli, fSetaPais)
  Else
    Result := '';
end;

procedure TfrmRelFatVendasCliente.pAjustarPosicaoComponentes(pnlAjuste: TPanel);
  Var
    intTemp: Integer;
begin
  intTemp := 12;

  gpbTipo.Top       := gpbTipo.Top       - pnlAjuste.Height + intTemp;
  gpbCancelados.Top := gpbCancelados.Top - pnlAjuste.Height + intTemp;
  gpbMargem.Top     := gpbMargem.Top     - pnlAjuste.Height + intTemp;
  gpbAjuste.Top     := gpbAjuste.Top     - pnlAjuste.Height + intTemp;
  rdgOrdem.Top      := rdgOrdem.Top      - pnlAjuste.Height + intTemp;
  gpbDestino.Top    := gpbDestino.Top    - pnlAjuste.Height + intTemp;
  rdgEmpresa.Top    := rdgEmpresa.Top    - pnlAjuste.Height + intTemp;
  gpbExiSom.Top     := gpbExiSom.Top     - pnlAjuste.Height + intTemp;

  if blnConsultaItem then
    if not pnlEventos.Visible then
      gpbAjuste.Top := gpbAjuste.Top - 10;

  Self.Height := Self.Height - pnlAjuste.Height + intTemp + 7;
end;

procedure TfrmRelFatVendasCliente.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

//    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelFatVendasCliente.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If Not (blnLiberado) Then
  Begin
    strCodVen           := fRetCodVendedor(edtCodVendedor.Text);
    edtDesVendedor.Text := fRetNomVendRep(strCodVen);

    If fEmptyStr(edtDesVendedor.Text) Then
    Begin
      fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
      edtCodVendedor.Clear;
      pSetFocus(edtCodVendedor);
    End;
  End
  Else
  Begin
    strCodVen := edtCodVendedor.Text;
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep, nil, 'do vendedor', 3);
  End;

end;

procedure TfrmRelFatVendasCliente.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (blnLiberado) And (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, not blnLiberado)) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

Procedure TfrmRelFatVendasCliente.pSenhaMargem;
Begin
  {**************************************}
  {* SE UTILIZAR MARGEM PEDE SENHA      *}
  {***********************************AF*}
//  If edtMargem.Text = 'S' Then
//  Begin
//
//    If Not fEmptyStr(fCfgSis('SENMLC')) Then
//    Begin
//      ffrmSenha(strSenha,'Margem');
//
//      If strSenha <> fCfgSis('SENMLC') Then
//        edtMargem.Text := 'N';
//    End;
//
//  End;
End;

procedure TfrmRelFatVendasCliente.pSetaEmpresaSelect(var strSQL: String);
begin
  If Not fEmptyStr(edtCodEmpresa.Text) Then
  Begin
    Case rdgEmpresa.ItemIndex Of
      0:strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'DET_CODEMP', 'CODEMP');
      1:strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'T.DET_EMPORI', 'CODEMP');
    End;
  End
  Else
  Begin
    If (Not blnAcessoTodasAsEmpresas) Then
    Begin
      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + '  AND LOCATE(DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
        1:strSQL := strSQL + '  AND LOCATE(T.DET_EMPORI, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;
    End;
  End;
end;

procedure TfrmRelFatVendasCliente.btnImprimirClick(Sender: TObject);
  Const
    INT_QTDSER = 30;
    cnsCodVen = '/*<cnsCodVen>*/';
    cnsNotEsp = '/*<DET_NOTESP>*/';
    
  Var
    frmRelFatVendasPorLinha: TfrmRelFatVendasPorLinha;
    frmRelFatVendasItensF9: TfrmRelFatVendasItensF9;
    frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
    strSQL,
    strSQLDel,
    strSQLNotGer,
    strSQLDelNotGer,
    strSQLPrinc,
    strCusTmp : String;
    strTotTmp : String;
    frxRel: TfrxReport;
    fltLarguraCustoMargem: Double;
    frxPage1, frxPage2, frxPage3: TfrxPage;

    blnIncluirClienteFilial: Boolean;

    Function fGetSQLCampoServico(strCampo: String): String;
      Var
        intSer: Integer;
    begin
      Result := '';
      Result := Result + '  CASE ';

      For intSer := 1 To INT_QTDSER Do
        Result := Result + '    WHEN TS.IDESER = "'  + fStrZero(intToStr(intSer), 2) + '" ' +
                           '    THEN GER_' + strCampo + fStrZero(intToStr(intSer), 2);

      Result := Result + '  END ';
    end;

    Function fGetSQLCodVen: String;
    begin
      If blnUsaSer Then
        Result := ' IF(LOCATE(DET_CODITE, :ITESER) > 0, ' + fGetSQLCampoServico('VENS') + ', DET_CODVEN) '
      Else
        Result := ' DET_CODVEN ';
    end;

    Function fGetTmpServicosID: String;
      Var
        intSer: Integer;
    begin
      Result := '';
      Result := Result + ' ( ';

      For intSer := 1 To INT_QTDSER Do
      Begin
        Result := Result + ' SELECT '  + intToStr(intSer) + ' AS IDESER ';

        If intSer < INT_QTDSER Then
          Result := Result + ' UNION ';
      End;

      Result := Result + ' ) ';
    end;

    Function fRetFatGorAutIncNumCmp(strAlias: String): String;
    Begin
      Result := '';
      Result := Result + '(SELECT FDO_SEQGER FROM FATDOR WHERE TRUE';
      Result := Result + ' AND ' + strAlias + '.DET_NUMDOC = FDO_NUMFAT';
      Result := Result + ' AND ' + strAlias + '.DET_ESPDOC = FDO_TIPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODEMP = FDO_EMPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODCLI = FDO_CODCLI';
      Result := Result + ' AND ' + strAlias + '.DET_CODITE = FDO_CODITE';
      Result := Result + ' LIMIT 1)';
    End;

begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  blnIncluirClienteFilial := fCfgSis('RMCCLF', varBoolean);

  If edtDestino.Text <> 'E' Then
    inherited;

  If (edtDestino.Text = 'E') Or blnImprime Then
  Begin
    btnImprimir.Enabled := FALSE;

    strSQLNotGer     := '';
    strSQLDelNotGer  := '';

    {************************}
    { AGRUPAMENTO POR LINHA }
    {********************RV*}
    If blnPorLinha Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      strSQL := strSQL + '  CONCAT(LEFT(ITE_CODGRU, 3), ".000") AS CODLIN, ';
      strSQL := strSQL + '  GRU_DESGRU AS DESLIN, ';
      strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS, 1) < 5, - (DET_QTDITE), DET_QTDITE)) AS QTDITE, ';

      strTotTmp := ' IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS, 1) < 5, - (DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) ';

      strSQL := strSQL + '  SUM('+strTotTmp+') AS TOTITE, ';
      strSQL := strSQL + '  IFNULL(' + fMarkup4(strTotTmp) + ', 0) AS MAMKP4, ';

      strSQL := strSQL + '  0.00 AS QTDVEN, ';
      strSQL := strSQL + '  0.00 AS TOTVEN, ';

      If blnVeioTelaVendas Then
        strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS, 1) < 5, - (DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTGER, '
      Else
        strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS, 1) < 5, - (DET_TOTITE - DET_DESESP + DET_VALIPI - DET_DESCFF), DET_TOTITE - DET_DESESP + DET_VALIPI - DET_DESCFF))) AS TOTGER, ';

      strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS, 1) < 5, - (DET_TOTITE - DET_DESESP + DET_VALIPI - DET_DESCFF), DET_TOTITE - DET_DESESP + DET_VALIPI - DET_DESCFF))) AS TOTDOC ';

      strSQL := strSQL + '    ,G.GER_TIPFRE AS TIPFRE  ';
      strSQL := strSQL + '    ,DET_TOTFRE AS TOTFRE  ';
      strSQL := strSQL + '    ,DET_DESACE AS DESACE  ';
      strSQL := strSQL + '    ,DET_VALRET AS VALRET  ';
      strSQL := strSQL + '  ,T.DET_VFCPST AS VFCPST  ';
      strSQL := strSQL + '    ,DET_VLRCON AS VLRCON  ';

      if blnFaturamento then
      begin
        strSQL := strSQL + '  , IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), ""))) AS NUMCMP ';
      end;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET ';
      strSQL := strSQL + '  LEFT JOIN CADOPE ON DET_CODVEN = OPE_CODOPE ';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADITE ON DET_CODITE = ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR = CADMAR.MAR_CODMAR ';
      strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';
      strSQL := strSQL + '  LEFT JOIN CADGRU ON CONCAT(LEFT(ITE_CODGRU, 3), "000") = GRU_CODGRU ';

      strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.AUTOINCREM = MOVDET.DET_SEQGER ';
      strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';

      strSQL := strSQL + '  LEFT JOIN ENTCLI ON G.GER_CODCLI = ENTCLI.ETC_CODCLI ';
      strSQL := strSQL + '                  AND ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER ';

      If fFiltroClienteConsumidorFiltrandoPorNome Then
        strSQl := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = GER_CIDCON '
      Else
        strSQl := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

      strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = G.GER_CODTRA  ';
      strSQL := strSQL + '  LEFT JOIN CADFOR ON ITE_CODFOR = FOR_CODFOR ';

      If fCfgSis('USACND', varBoolean) Then
        strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';

      strSQL := strSQL + '  LEFT JOIN CADVEI ON AUX_PLAVEI = VEI_PLAVEI ';

      strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM AND MOVDET.DET_VALRET = 0 ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_TIP_FC = "C" ';
      strSQL := strSQL + '  /*<DET_NOTESP>*/  ';    //Utilizado para replasce no filtro da NOTDET

      strSQL := strSQL + fStrLocate(edtCodCliCon, arrConsumidor, 'G.GER_CGCCON', 'CGCCON');
      If not fEmptyStr(edtConNom.Text) Then
        strSQL := strSQL + ' AND G.GER_NOMCON LIKE :NOMCON ';

      If (fCfgSis('MOSMCL') = '3') Then
        strSQL := strSQL + ' AND (DET_NUMFAT IS NULL OR DET_NUMFAT = "") ';

      strSQL := strSQL + ' AND (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0) ';
      strSQL := strSQL + ' AND DET_PROEMB <> "S"  ';
      strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

      If edtAjuste.Text = 'N' Then
        strSQL := strSQL + ' AND (DET_ESPDOC <> "AJ") ';

      If Length(arrLinGru) > 1 Then
        strSQL := strSQL + fStrLocate(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU', 'CODGRU')
      Else
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin

        If (RightStr(mskLinhaGrupo.Text,3) = '000') Then
          strSQL := strSQL + '  AND LEFT(ITE_CODGRU, 3) = LEFT(:CODGRU, 3) '
        Else
          strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
      End;

      strSQL := strSQL + fStrLocate(edtCodCidade, arrCidade, 'CID_CODCID', 'CODCID');
      strSQL := strSQL + fStrLocate(edtProdutos, arrCadIte, 'DET_CODITE', 'CODITE');
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'DET_CODVEN', 'CODVEN');
      strSQL := strSQL + fStrLocate(edtCodRep, arrRepres, 'DET_CODREP', 'CODREP');
      strSQL := strSQL + fStrLocate(edtCodFase, arrFase, 'AUXMOV.AUX_FASOBR','CODFAS');
      strSQL := strSQL + fStrLocate(edtCodEmb, fGetArrEmbarc, 'AUXMOV.AUX_CODEMB', 'CODEMB');
      strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'G.GER_CODEVE','CODEVE');

      {**********************}
      {* FILTROS DO VEÍCULO *}
      {**********************}
      If fCfgSis('AUTCEN', varBoolean) Then
      Begin
        If (Not fEmptyStr(mskPlaVei.Text)) Then
          strSQL := strSQL + fStrLocate(mskPlaVei, arrVeic,    'AUX_PLAVEI','PLAVEI');

        If (Not fEmptyStr(edtCodMar.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMar, arrMarcaVei,'VEI_CODMAR','MARVEI');

        If (Not fEmptyStr(edtCodMod.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMod, arrModelo,  'VEI_CODMOD','MODELO');

        If (Not fEmptyStr(edtCodCor.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodCor, arrCor,     'VEI_CODCOR','CORVEI');

        If (Not fEmptyStr(edtAno.Text)) Then
          strSQL := strSQL + ' AND VEI_ANOVEI = :ANOVEI ';
      End;


      If Not fEmptyStr(edtCodCliExcluir.Text) Then
         strSQL := strSQL + fStrLocate(edtCodCliExcluir, arrClientesExcluir, 'CLI_CODCLI', 'CLIEXC', False, True);

      If Not fEmptyStr(edtCodCliente.Text) Then
        if chkMovRede.Checked Then
          strSQL := strSQL + ' AND ( (CLI_CODCLI = :CODCLI) OR (CLI_CODRED = ' + strCodRedeLojasCliente + ') ) '
        Else
          strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'CLI_CODCLI', 'CODCLI');

      {****************************}
      {* FILTRO REDE DE LOJAS     *}
      {*************************DP*}
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');


      If blnFaturamento And blnCliCons And (Not blnPorVendedor) Then
        strSQL := strSQL + '  AND CLI_NOMCLI LIKE :NOMCLI ';

      {**********************************************}
      {* EMPRESA DE FATURAMENTO / EMRPESA DE ORIGEM *}
      {*******************************************DP*}
      pSetaEmpresaSelect(strSQL);

      If Not fEmptyStr(edtDescri.Text) Then
        strSQL := strSQL + '  AND DET_DESCRI LIKE :DESCRI ';

      If Not fEmptyStr(edtRefere.Text) Then
        strSQL := strSQL + '  AND DET_REFERE LIKE :REFERE ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'DET_CODMAR', 'CODMAR');

      If (Not fEmptyStr(edtTintasDisp.Text)) Then
        strSQL := strSQL + '  AND DET_IDEPRO = :IDEPRO ';

      strSQL := strSQL + fStrLocate(edtFornecedor, arrFornec, 'ITE_CODFOR', 'CODFOR');
      strSQL := strSQL + fStrLocate(edtCodAtividade, arrAtivid, 'CLI_CODATI', 'CODATI');

      If chkSomDev.Checked Then
        strSQL := strSQL + '  AND ((RIGHT(DET_CLAFIS, 3) IN ("202","411") AND DET_ESPDOC IN ("NF","EL","IF","IV","D1","PD")) OR (DET_ESPDOC = "TR" AND LEFT(DET_CLAFIS,1) < 5) OR (DET_ESPDOC = "DV")) ';

      If chkSomFut.Checked Then
        strSQL := strSQL + '  AND RIGHT(DET_CLAFIS, 3) = "922" ';

      If chkSomBai.Checked Then
        strSQL := strSQL + '  AND (LOCATE(RIGHT(DET_CLAFIS, 3), ' + CLAFIS_ENTFUT_VEN_ABR + ') > 0) ';

      If Not fEmptyStr(edtNomReg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

      If Not fEmptyStr(edtDesFpg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodFpg, arrForPag, 'DET_CODFPG', 'CODFPG');

      if cbbEndCli.ItemIndex > 0 then
        strSQL := strSQL + ' AND ENTCLI.AUTOINCREM = ' + QuotedStr(fRetornaEntCli(edtCodCliente.Text, cbbEndCli.ItemIndex)) + ' ';

      If blnSomenteVendas Then
      Begin

        strSQL := strSQL + ' AND ' + IIF(Not blnIncluirClienteFilial, ' DET_CODCLI NOT IN ('+VS_strCliFil+') AND ', '');
        strSQL := strSQL + ' ( ' + IIF(blnIncluirClienteFilial, ' DET_CODCLI IN ('+VS_strCliFil+') OR ', '');
        strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

        if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
          strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
        else
        begin
          if fCfgSis('ENTBRF', varBoolean) or (not blnSomenteVendas) then
            strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
          else
           strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
        end;

      End;

      If (Not(blnSomenteVendas) And Not(fEmptyStr(edtCodClaFis.Text)) ) Then
        strSQL :=strSQL + 'AND ' + fStrLocate(edtCodClaFis, arrClasFiscal, 'DET_CLAFIS', 'DETFIS', True);

      if blnFaturamento and not fEmptyStr(edtNumCmp.Text) then
      begin
        strSQL := strSQL + ' AND LOCATE(:NUMCMP, IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")))) ';
      end;

      strSQL := strSQL + '  GROUP BY ';
      strSQL := strSQL + '    LEFT(ITE_CODGRU, 3) ';

    End
    {******************************************}
    {* NÃO MEXER NO CALCULO DO CAMPO "TOTITE" *}
    {* TEM QUE SER ASSIM POR MOTIVOS ESPURIOS.*}
    {***************************************MV*}
    Else If (edtTipo.Text = 'A') Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  AUX_PLAVEI AS PLAVEI, ';
      strSQL := strSQL + '  AUX_KM_VEI AS KM_VEI, ';

      strSQL := strSQL + '  CAST(' + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(G.GER_NOMCON, "") = "", " ", G.GER_NOMCON) ', ' CLI_NOMCLI ') + ' AS CHAR(100)) AS NOMCLI, ';
      strSQL := strSQL + '  CAST(' + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(G.GER_TELCON, "") = "", " ", G.GER_TELCON) ', ' IF(IFNULL(CLI_FONE01, "") = "", " ", CLI_FONE01) ') + '  AS CHAR(100)) AS FONE01, ';

      strSQL := strSQL + '  CAST(CONCAT(CID_CODCID ," - ", CID_NOMCID ) AS CHAR(100)) AS NOMCID, ';
      strSQL := strSQL + '  CID_ESTADO AS ESTADO, ';
      strSQL := strSQL + '  OPE_NOMOPE AS VENDED, ';
      strSQL := strSQL + '  IF(IFNULL(G.GER_MEN001, "") = "", CAST(" " AS CHAR(1)), G.GER_MEN001) AS MEN001, ';
      strSQL := strSQL + '  IF(IFNULL(G.GER_MEN002, "") = "", CAST(" " AS CHAR(1)), G.GER_MEN002) AS MEN002, ';
      strSQL := strSQL + '  IF(IFNULL(G.GER_MEN003, "") = "", CAST(" " AS CHAR(1)), G.GER_MEN003) AS MEN003, ';
      strSQL := strSQL + '  IF(IFNULL(G.GER_MEN004, "") = "", CAST(" " AS CHAR(1)), G.GER_MEN004) AS MEN004, ';
      strSQL := strSQL + '  CAST(IFNULL(CONCAT(G.GER_CODTRA,"-",TRA_NOMTRA), " ") AS CHAR(100)) AS TRANSP, ';
      strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", CAST(" " AS CHAR(1)), DET_CONPAG) AS CNDFAT, '; // PARA USO NO RELATÓRIO DE VENDAS F9

      If fCfgSis('USACND', varBoolean) Then
      Begin
        strSQL := strSQL + '  CAST(IFNULL(CONCAT(CND_CNDPAG," - ",CND_DESCRI), " ") AS CHAR(100)) AS CNDPAG, ';
        strSQL := strSQL + '  CND_CODIGO AS CNDCOD, ';
      End
       Else
      Begin
         strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", CAST(" " AS CHAR(1)), DET_CONPAG) AS CNDPAG, ';
        strSQL := strSQL + '  NULL AS CNDCOD, ';
      End;

      strSQL := strSQL + '  DET_DTAENT, ';
      strSQL := strSQL + '  DATE_FORMAT(DET_DTAENT,"%d/%m/%y") AS DTAENT, ';
      strSQL := strSQL + '  CAST(CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS CHAR(30)) AS NUMDOC, ';
      strSQL := strSQL + '  CAST(CONCAT(DET_ESPDOC,"-",DET_NUMDOC) AS CHAR(30)) AS NUMESP, ';
      strSQL := strSQL + '  CAST(IF(LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0, IF(IFNULL(DET_DOCDEV, "") <> "", CONCAT(DET_DOCDEV,"-",DET_ESPDEV), ""), IF(IFNULL(DET_NUM_PD, "") <> "", CONCAT(DET_NUM_PD, "-", DET_ESP_PD), "")) AS CHAR(20)) AS DOCORI, ';
      strSQL := strSQL + '  CAST(IF(IFNULL(DET_NUMFAT, "") <> "", CONCAT(DET_NUMFAT,"-",DET_TIPFAT), "") AS CHAR(30)) AS NUMFAT, ';
      strSQL := strSQL + '  DET_NUMDOC AS DOCUME, ';
      strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  DET_COMPLE AS COMPLE, ';
      strSQL := strSQL + cnsCodVen + ' AS CODVEN, ';
      strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
      strSQL := strSQL + '  DET_CODITE AS CODITE, ';
      strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
      strSQL := strSQL + '  DET_IDEPRO AS IDEPRO, ';
      strSQL := strSQL + '  DET_CODACA AS CODACA, ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR AS DESMAR, ';

      If blnUsaSer Then
        strSQL := strSQL + ' IF(IFNULL(' + fGetSQLCampoServico('CODS') + ', "") <> "",' + fGetSQLCampoServico('DESS') + ' , DET_DESCRI) AS DESCRI, '
      Else
        strSQL := strSQL + ' DET_DESCRI AS DESCRI, ';

      strSQL := strSQL + '  DET_NUMLOT AS NUMLOT, ';

      If (rdgOrdem.ItemIndex = 0) Then
        strSQL := strSQL + '  CAST("D" AS CHAR(1))        AS CONARQ, '
      Else
        strSQL := strSQL + '  CAST(" " AS CHAR(1))        AS CONARQ, ';

      strSQL := strSQL + '  DET_REFERE AS REFERE, ';
      strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
      strSQL := strSQL + '  CADMAR.MAR_CODMAR AS CODMAR, ';
      strSQL := strSQL + '  DET_DESESP AS DESESP, ';

      If (blnConsultaItem) Then
        strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -((DET_TOTITE - DET_DESESP - DET_DESCFF) / DET_QTDITE), (DET_TOTITE - DET_DESESP - DET_DESCFF) / DET_QTDITE)) AS UNITAR, '
      Else
        strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_UNITAR), DET_UNITAR)) AS UNITAR, ';

      strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(IF(DET_UNITAR > DET_UNIORI, DET_UNITAR, DET_UNIORI)), IF(DET_UNITAR > DET_UNIORI, DET_UNITAR, DET_UNIORI))) * DET_QTDITE AS TOTBRU, ';
      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) AS QTDITE, ';

      strTotTmp := '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) ';

      strSQL := strSQL + strTotTmp+' AS TOTITE, ';
      strSQL := strSQL + '  IFNULL(' + fMarkup4(strTotTmp) + ', 0) AS MAMKP4, ';

      If (blnFaturamento) Then
        strSQL := strSQL + TfrmRelFatVendasClienteF9.fColunasRelFatVendasClienteF9 + ', ';

      If (fCfgSis('MARMKP') = '4') Then
        strCusTmp := ' IFNULL(DET_TOTCUS,0) '
      Else
        strCusTmp := ' IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';

      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(' + strCusTmp + '), ' + strCusTmp + ') AS TOTCUS, ';

      If (Not blnFaturamento) Then
        strSQL := strSQL + '  0.000 AS MARGEM, ';

      strSQL := strSQL + '  DET_VALIPI AS TOTIPI, ';

      If blnVeioTelaVendas Then
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0) '+IIF(blnUsaSer, 'OR (('+fGetSQLCampoServico('CODS')+') IS NOT NULL)', '')+', 0.00, '+
                           '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS TOTGER, '
      Else
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0) '+IIF(blnUsaSer, 'OR (('+fGetSQLCampoServico('CODS')+') IS NOT NULL)', '')+', 0.00, '+
                           '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF), DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF)) AS TOTGER, ';

      strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF), DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF)) AS TOTDOC, ';

      strSQL := strSQL + '  DET_ALQIPI AS ALQIPI, ';
      strSQL := strSQL + '  CAST(" " AS CHAR(1)) AS DOCCAN, ';
      strSQL := strSQL + '  CAST(CONCAT(ITE_CODFOR, "-", FOR_NOMFOR) AS CHAR(100)) AS NOMFOR, ';
      strSQL := strSQL + '  (SELECT IF(IFNULL(R.GER_NOMREC, "") = "", " ", R.GER_NOMREC) ';
      strSQL := strSQL + '     FROM ROMGERX R WHERE R.GER_NUMDOC = G.GER_NUMDOC AND      ';
      strSQL := strSQL + '                          R.GER_ESPDOC = G.GER_ESPDOC AND      ';
      strSQL := strSQL + '                          R.GER_CODEMP = G.GER_CODEMP AND      ';
      strSQL := strSQL + '                          R.GER_CODCLI = G.GER_CODCLI LIMIT 1) AS NOMREC, ';
      strSQL := strSQL + '  CAST(CONCAT(DET_CODDIV, "-", ';
      strSQL := strSQL + '         (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = DET_CODDIV)) AS CHAR(100)) AS NOMDIV, ';
      strSQL := strSQL + '  CAST(IF(AUX_PLAVEI IS NULL, "", CONCAT("VEÍCULO: ", CONCAT(LEFT(AUX_PLAVEI,3),"-",RIGHT(AUX_PLAVEI,4))," ", IFNULL(M.MAR_DESMAR, "")," ", IFNULL(O.MOD_DESMOD, "")," ", IFNULL(V.VEI_ANOVEI, "")," ", ';
      strSQL := strSQL + '    IFNULL(C.COR_DESCOR, ""), " - ", "KM: ", IFNULL(AUX_KM_VEI, "000000"))) AS CHAR(255)) AS PLAKMS, ';
      strSQL := strSQL + '  D.DET_CLAFIS AS CLAFIS, ';
      strSQL := strSQL + '  IF(G.GER_CGCCON <> "", G.GER_CGCCON, CLI_C_G_C_) AS CGCCLI, ';
      strSQL := strSQL + '  "' + fCfgSis('MARMKP') + '" AS MARMKP, ';
      strSQL := strSQL + '  "' + fCfgSis('ITESER') + '" AS ITESER, ';
      strSQL := strSQL + '  "' + fCfgSis('SERTER') + '" AS SERTER, ';
      strSQL := strSQL + '  CAST("MOVGER" AS CHAR(6))     AS TABELA, ';
      strSQL := strSQL + '  G.AUTOINCREM AS AUTINC,  ';
      strSQL := strSQL + '  D.AUTOINCREM AS SEQDET,  ';
      strSQL := strSQL + 'CAST( ' + IIF(blnUsaSer, fGetSQLCampoServico('CODS'), ' NULL ') + ' AS CHAR(5))  ' + ' AS CODSER, ';
      strSQL := strSQL + 'CAST( ' + IIF(blnUsaSer, fGetSQLCampoServico('DESS'), ' NULL ') + ' AS CHAR(85)) ' + ' AS DESSER, ';
      strSQL := strSQL + IIF(blnUsaSer, fGetSQLCampoServico('QTDS'), ' 0.00 ') + ' AS QTDSER, ';
      strSQL := strSQL + IIF(blnUsaSer, fGetSQLCampoServico('UNIS'), ' 0.00 ') + ' AS UNISER, ';
      strSQL := strSQL + IIF(blnUsaSer, fGetSQLCampoServico('VALS'), ' 0.00 ') + ' AS VALSER, ';
      strSQL := strSQL + '  D.DET_PERCOM AS PERCOM, ';
      strSQL := strSQL + '  G.GER_TOTSER AS TOTSER  ';

      If fFiltrarVenMtl() Then Begin
        strSQL := strSQL + ', DET_QTDPEC AS QTDPEC ';
        strSQL := strSQL + ', DET_COMPEC AS COMPEC ';
      End;

      strSQL := strSQL + '    ,G.GER_TIPFRE AS TIPFRE  ';
      strSQL := strSQL + '    ,DET_TOTFRE AS TOTFRE  ';
      strSQL := strSQL + '    ,DET_DESACE AS DESACE  ';
      strSQL := strSQL + '    ,DET_VALRET AS VALRET  ';
      strSQL := strSQL + '  ,T.DET_VFCPST AS VFCPST  ';
      strSQL := strSQL + '    ,DET_VLRCON AS VLRCON  ';
      strSQL := strSQL + '    ,DET_TABPRE AS TABPRE  ';
      strSQL := strSQL + '    ,IF(G.GER_ENTFAT = "S", "E", "R") AS ENTRET ';

      if blnFaturamento then
      begin
        strSQL := strSQL + '  , IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), ""))) AS NUMCMP ';
      end;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET D ';
      strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';
      strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';
      strSQL := strSQL + '  LEFT JOIN CADITE ON DET_CODITE = ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR = CADMAR.MAR_CODMAR ';
      strSQL := strSQL + '  LEFT JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';

      strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
      strSQL := strSQL + '  LEFT  JOIN SERMOV S ON S.GER_SEQGER = G.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';

      strSQL := strSQL + '  LEFT JOIN ENTCLI ON G.GER_CODCLI = ENTCLI.ETC_CODCLI ';
      strSQL := strSQL + '                  AND ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER ';

      If fFiltroClienteConsumidorFiltrandoPorNome Then
        strSQl := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = GER_CIDCON '
      Else
        strSQL := strSQL + '  LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ';

      strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = G.GER_CODTRA  ';
      strSQL := strSQL + '  LEFT JOIN CADFOR ON ITE_CODFOR = FOR_CODFOR ';

      If fCfgSis('USACND', varBoolean) Then
        strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';

      strSQL := strSQL + '  LEFT JOIN CADVEI V ON AUXMOV.AUX_PLAVEI = V.VEI_PLAVEI ';
      strSQL := strSQL + '  LEFT JOIN MARVEI M ON V.VEI_CODMAR = M.MAR_CODMAR ';
      strSQL := strSQL + '  LEFT JOIN MODVEI O ON V.VEI_CODMOD = O.MOD_CODMOD ';
      strSQL := strSQL + '  LEFT JOIN CORVEI C ON V.VEI_CODCOR = C.COR_CODCOR ';

      If blnUsaSer Then
        strSQL := strSQL + '  LEFT  JOIN ' + fGetTmpServicosID + ' TS  ON LOCATE(DET_CODITE, :ITESER) > 0 ';

      strSQL := strSQL + '  LEFT JOIN CADOPE ON ' + cnsCodVen + ' = OPE_CODOPE ';

      If fFiltrarVenMtl() Then
        strSQL := strSQL + ' LEFT JOIN MOVMAD MD ON MD.DET_SEQGER = D.AUTOINCREM ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_TIP_FC = "C" ';

      If blnConsultaDocumento Then
      Begin
        strSQL := strSQL + ' AND  DET_NUMDOC = "'+strNumDoc+'" ';
        strSQL := strSQL + ' AND  DET_ESPDOC = "'+strEspDoc+'" ';
        strSQL := strSQL + ' AND  DET_CODEMP = "'+strCodEmp+'" ';
      End;

      If Not chkExbTATL.Checked Then
      Begin
        strSQL := strSQL + ' AND  DET_ESPDOC NOT IN ("TA", "TL") ';
      End;

      strSQL := strSQL + '  /*<DET_NOTESP>*/  ';    //Utilizado para replasce no filtro da NOTDET

      strSQL := strSQL + fStrLocate(edtCodCliCon, arrConsumidor, 'G.GER_CGCCON', 'CGCCON');

      If not fEmptyStr(edtConNom.Text) Then
        strSQL := strSQL + ' AND G.GER_NOMCON LIKE :NOMCON ';

      {**********************}
      {* FILTROS DO VEÍCULO *}
      {**********************}
      If fCfgSis('AUTCEN', varBoolean) Then
      Begin
        If (Not fEmptyStr(mskPlaVei.Text)) Then
          strSQL := strSQL + fStrLocate(mskPlaVei, arrVeic,    'AUX_PLAVEI','PLAVEI');

        If (Not fEmptyStr(edtCodMar.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMar, arrMarcaVei,'VEI_CODMAR','MARVEI');

        If (Not fEmptyStr(edtCodMod.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMod, arrModelo,  'VEI_CODMOD','MODELO');

        If (Not fEmptyStr(edtCodCor.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodCor, arrCor,     'VEI_CODCOR','CORVEI');

        If (Not fEmptyStr(edtAno.Text)) Then
          strSQL := strSQL + ' AND VEI_ANOVEI = :ANOVEI ';
      End;

      If (fCfgSis('MOSMCL') = '3') Then
        strSQL := strSQL + ' AND (DET_NUMFAT IS NULL OR DET_NUMFAT = "") ';

      strSQL := strSQL + ' AND (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0)  ';
      strSQL := strSQL + ' AND DET_PROEMB <> "S"  ';

      If Not(blnConsultaDocumento) Then  //Se não consultar um documento especifico o sistema busca pela data
        strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

      if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
        strSQL := strSQL + ' AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
      else
        If Not fCfgSis('ENTBRF', varBoolean) And (blnSomenteVendas) Then
          strSQL := strSQL + ' AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';

      If (edtAjuste.Text = 'N') Then
        strSQL := strSQL + ' AND (DET_ESPDOC <> "AJ") ';

      If Length(arrLinGru) > 1 Then
        strSQL := strSQL + fStrLocate(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU', 'CODGRU')
      Else
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If (RightStr(mskLinhaGrupo.Text,3) = '000') Then
        Begin
          strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
        End
        Else
        Begin
          strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
        End;
      End;

      strSQL := strSQL + fStrLocate(edtCodCidade, arrCidade, 'CID_CODCID', 'CODCID');

      strSQL := strSQL + fStrLocate(edtProdutos, arrCadIte, 'DET_CODITE', 'CODITE');
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, cnsCodVen, 'CODVEN');
      strSQL := strSQL + fStrLocate(edtCodRep, arrRepres, 'DET_CODREP', 'CODREP');
      strSQL := strSQL + fStrLocate(edtCodFase, arrFase, 'AUXMOV.AUX_FASOBR','CODFAS');
      strSQL := strSQL + fStrLocate(edtCodEmb, fGetArrEmbarc, 'AUXMOV.AUX_CODEMB', 'CODEMB');
      strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'G.GER_CODEVE','CODEVE');

      If Not fEmptyStr(edtCodCliExcluir.Text) Then
         strSQL := strSQL + fStrLocate(edtCodCliExcluir, arrClientesExcluir, 'CLI_CODCLI', 'CLIEXC', False, True);

      If Not fEmptyStr(edtCodCliente.Text) Then
        if chkMovRede.Checked Then
          strSQL := strSQL + ' AND ( (CLI_CODCLI = :CODCLI) OR (CLI_CODRED = ' + strCodRedeLojasCliente + ') ) '
        Else
          strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'CLI_CODCLI', 'CODCLI');

      {****************************}
      {* FILTRO REDE DE LOJAS     *}
      {*************************DP*}
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

      If blnFaturamento And blnCliCons And (Not blnPorVendedor) Then
        strSQL := strSQL + '  AND CLI_NOMCLI LIKE :NOMCLI ';

      {**********************************************}
      {* EMPRESA DE FATURAMENTO / EMPRESA DE ORIGEM *}
      {*******************************************DP*}
      If Not(blnConsultaDocumento) Then //Se não for para trazer o documento especifico da empresa
        pSetaEmpresaSelect(strSQL);     //ja selecionada na baixa de contas a receber a select segue normal

      If Not fEmptyStr(edtDescri.Text) Then
        strSQL := strSQL + '  AND DET_DESCRI LIKE :DESCRI ';

      If Not fEmptyStr(edtRefere.Text) Then
        strSQL := strSQL + '  AND DET_REFERE LIKE :REFERE ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'DET_CODMAR', 'CODMAR');

      If (Not fEmptyStr(edtTintasDisp.Text)) Then
        strSQL := strSQL + '  AND DET_IDEPRO = :IDEPRO ';

      strSQL := strSQL + fStrLocate(edtFornecedor, arrFornec, 'ITE_CODFOR', 'CODFOR');
      strSQL := strSQL + fStrLocate(edtCodAtividade, arrAtivid, 'CLI_CODATI', 'CODATI');

      If chkSomDev.Checked Then
        strSQL := strSQL + '  AND ((RIGHT(DET_CLAFIS, 3) IN ("202","411") AND DET_ESPDOC IN ("NF","EL","IF","IV","D1","PD")) OR (DET_ESPDOC = "TR" AND LEFT(DET_CLAFIS,1) < 5) OR (DET_ESPDOC = "DV")) ';

      If chkSomTra.Checked Then
        strSQL := strSQL + '  AND DET_CODCLI IN (' + fRetClientesFilial + ') AND ((DET_ESPDOC = "TE") OR (DET_ESPDOC IN ("NF", "EL") AND RIGHT(DET_CLAFIS, 3) IN (152,409))) ';

      If chkSomCon.Checked Then
        strSQL := strSQL + '  AND DET_CLAFIS IN ("1917","2917","5917","6917") ';

      If chkSomFut.Checked Then
        strSQL := strSQL + '  AND RIGHT(DET_CLAFIS, 3) = "922" ';

      If chkSomBai.Checked Then
        strSQL := strSQL + '  AND (LOCATE(RIGHT(DET_CLAFIS, 3), ' + CLAFIS_ENTFUT_VEN_ABR + ') > 0) ';

      If Not fEmptyStr(edtNomReg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

      If Not fEmptyStr(edtDesFpg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodFpg, arrForPag, 'DET_CODFPG', 'CODFPG');

      if cbbEndCli.ItemIndex > 0 then
        strSQL := strSQL + ' AND ENTCLI.AUTOINCREM = ' + QuotedStr(fRetornaEntCli(edtCodCliente.Text, cbbEndCli.ItemIndex)) + ' ';

      If blnSomenteVendas Or blnConsultaItem Then
      Begin

        If blnFaturamento Or blnConsultaItem Then
        Begin

          strSQL := strSQL + ' AND ' + IIF(Not blnIncluirClienteFilial, ' DET_CODCLI NOT IN ('+VS_strCliFil+') AND ', '');
          strSQL := strSQL + ' ( ' + IIF(blnIncluirClienteFilial, ' DET_CODCLI IN ('+VS_strCliFil+') OR ', '');
          strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

          if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
            strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
          else
          begin
            if fCfgSis('ENTBRF', varBoolean) or (not blnSomenteVendas) then
              strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
            else
             strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
          end;

        End
        Else
        Begin

          strSQL := strSQL + '  AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
          strSQL := strSQL + '  AND ' + cnsFiltroFFDVTR + ' TRUE ';
          strSQL := strSQL + '  AND ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

          if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
            strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
          else
          begin
            If fCfgSis('ENTBRF', varBoolean) Or (Not blnSomenteVendas) Then
              strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
            Else
              strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
          end;

        End;

      End;

      If (Not(blnSomenteVendas) And Not(fEmptyStr(edtCodClaFis.Text)) ) Then
        strSQL :=strSQL + 'AND ' + fStrLocate(edtCodClaFis, arrClasFiscal, 'DET_CLAFIS', 'DETFIS', True);

      if blnFaturamento and not fEmptyStr(edtNumCmp.Text) then
      begin
        strSQL := strSQL + ' AND LOCATE(:NUMCMP, IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")))) ';
      end;

      strSQL := strSQL + ' GROUP BY D.AUTOINCREM ' + IIF(blnUsaSer, ' ,IDESER ', '');
    End
    Else
    Begin {Sintético}

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  AUX_PLAVEI AS PLAVEI, ';
      strSQL := strSQL + '  AUX_KM_VEI AS KM_VEI, ';

      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(G.GER_NOMCON, "") = "", " ", G.GER_NOMCON) ', ' CLI_NOMCLI ') + ' AS NOMCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(G.GER_TELCON, "") = "", " ", G.GER_TELCON) ', ' IF(IFNULL(CLI_FONE01, "") = "", " ", CLI_FONE01) ') + ' AS FONE01, ';

      strSQL := strSQL + '  CAST(CONCAT(CID_CODCID ," - ", CID_NOMCID ) AS CHAR(100)) AS NOMCID, ';
      strSQL := strSQL + '  CID_ESTADO AS ESTADO, ';
      strSQL := strSQL + '  DET_DTAENT, ';
      strSQL := strSQL + '  DATE_FORMAT(DET_DTAENT,"%d/%m/%y") AS DTAENT, ';
      strSQL := strSQL + '  CAST(CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS CHAR(30)) AS NUMDOC, ';
      strSQL := strSQL + '  CAST(CONCAT(DET_ESPDOC,"-",DET_NUMDOC) AS CHAR(30)) AS NUMESP, ';
      strSQL := strSQL + '  CAST(IF(LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0, IF(IFNULL(DET_DOCDEV, "") <> "", CONCAT(DET_DOCDEV,"-",DET_ESPDEV), ""), IF(IFNULL(DET_NUM_PD, "") <> "", CONCAT(DET_NUM_PD, "-", DET_ESP_PD), "")) AS CHAR(20)) AS DOCORI, ';
      strSQL := strSQL + '  CAST(IF(IFNULL(DET_NUMFAT, "") <> "", CONCAT(DET_NUMFAT,"-",DET_TIPFAT), "") AS CHAR(30)) AS NUMFAT, ';
      strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  DET_COMPLE AS COMPLE, ';
      strSQL := strSQL + '  DET_CODVEN AS CODVEN, ';
      strSQL := strSQL + '  CADOPE.OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '  DET_CONPAG AS CONPAG, ';
      strSQL := strSQL + '  SUM(DET_DESESP) AS DESESP, ';

      strTotTmp := '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) ';

      strSQL := strSQL + '  SUM('+strTotTmp+') AS TOTITE, ';
      strSQL := strSQL + '  SUM(IFNULL(' + fMarkup4(strTotTmp) + ', 0)) AS MAMKP4, ';

      If (fCfgSis('MARMKP') = '4') Then
        strCusTmp := ' IFNULL(DET_TOTCUS,0) '
      Else
        strCusTmp := '  IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';

      strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(' + strCusTmp + '), ' + strCusTmp + ')) AS TOTCUS, ';

      strSQL := strSQL + '  0.000 AS MARGEM, ';

      If blnVeioTelaVendas Then
        strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTGER, '
      Else
        strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF), DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF))) AS TOTGER, ';

      strSQL := strSQL + '  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF), DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF))) AS TOTDOC, ';

      strSQL := strSQL + '  CAST(" " AS CHAR(1)) AS DOCCAN, ';
      strSQL := strSQL + '  CONCAT(ITE_CODFOR, "-", FOR_NOMFOR) AS NOMFOR, ';
      strSQL := strSQL + '  MAX(G.GER_CLAFIS) AS CLAFIS, ';
      strSQL := strSQL + '  D.AUTOINCREM AS SEQDET,  ';
      strSQL := strSQL + '  IF(G.GER_CGCCON <> "", G.GER_CGCCON, CLI_C_G_C_) AS CGCCLI, ';
      strSQL := strSQL + '  "' + fCfgSis('MARMKP') + '" AS MARMKP, ';
      strSQL := strSQL + '  "' + fCfgSis('ITESER') + '" AS ITESER,  ';
      strSQL := strSQL + '  "' + fCfgSis('SERTER') + '" AS SERTER  ';

      if blnFaturamento then
      begin
        strSQL := strSQL + '  , IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), ""))) AS NUMCMP ';
      end;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET D ';
      strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';
      strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';
      strSQL := strSQL + '  LEFT JOIN CADITE ON DET_CODITE = ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADFOR ON ITE_CODFOR = FOR_CODFOR ';

      strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
      strSQL := strSQL + '  LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = D.DET_CODVEN ';

      If Not fEmptyStr(edtCodCliCon.Text) Then
        strSQL := strSQL + '                        AND (G.GER_CGCCON = :CGCCON) ';

      If not fEmptyStr(edtConNom.Text) Then
        strSQL := strSQL + ' AND G.GER_NOMCON LIKE :NOMCON ';

      If fFiltroClienteConsumidorFiltrandoPorNome Then
        strSQl := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = GER_CIDCON '
      Else
        strSQL := strSQL + '  LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ';

      strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';

      strSQL := strSQL + '  LEFT JOIN ENTCLI ON G.GER_CODCLI = ENTCLI.ETC_CODCLI ';
      strSQL := strSQL + '                  AND ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER ';

      strSQL := strSQL + '  LEFT JOIN CADVEI ON AUXMOV.AUX_PLAVEI = VEI_PLAVEI ';

      strSQL := strSQL + 'WHERE TRUE ';

      If (fCfgSis('MOSMCL') = '3') Then
        strSQL := strSQL + ' AND (DET_NUMFAT IS NULL OR DET_NUMFAT = "") ';

      If Not chkExbTATL.Checked Then
      Begin
        strSQL := strSQL + ' AND  DET_ESPDOC NOT IN ("TA", "TL") ';
      End;

      strSQL := strSQL + '  AND (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0) ';
      strSQL := strSQL + '  AND DET_PROEMB <> "S" ';
      strSQL := strSQL + '  AND DET_TIP_FC = "C" ';
      strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

      if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
        strSQL := strSQL + ' AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
      else
        If Not fCfgSis('ENTBRF', varBoolean) And (blnSomenteVendas) Then
          strSQL := strSQL + ' AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';

      If (edtAjuste.Text = 'N') Then
        strSQL := strSQL + ' AND (DET_ESPDOC <> "AJ") ';

      If Length(arrLinGru) > 1 Then
        strSQL := strSQL + fStrLocate(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU', 'CODGRU')
      Else
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If (RightStr(mskLinhaGrupo.Text,3) = '000') Then
        Begin
          strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
        End
        Else
        Begin
          strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
        End;
      End;

      {**********************}
      {* FILTROS DO VEÍCULO *}
      {**********************}
      If fCfgSis('AUTCEN', varBoolean) Then
      Begin
        If (Not fEmptyStr(mskPlaVei.Text)) Then
          strSQL := strSQL + fStrLocate(mskPlaVei, arrVeic,    'AUX_PLAVEI','PLAVEI');

        If (Not fEmptyStr(edtCodMar.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMar, arrMarcaVei,'VEI_CODMAR','MARVEI');

        If (Not fEmptyStr(edtCodMod.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodMod, arrModelo,  'VEI_CODMOD','MODELO');

        If (Not fEmptyStr(edtCodCor.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodCor, arrCor,     'VEI_CODCOR','CORVEI');

        If (Not fEmptyStr(edtAno.Text)) Then
          strSQL := strSQL + ' AND VEI_ANOVEI = :ANOVEI ';
      End;

      strSQL := strSQL + fStrLocate(edtCodCidade, arrCidade, 'CID_CODCID', 'CODCID');
      strSQL := strSQL + fStrLocate(edtProdutos, arrCadIte, 'DET_CODITE', 'CODITE');
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'DET_CODVEN', 'CODVEN');
      strSQL := strSQL + fStrLocate(edtCodRep, arrRepres, 'DET_CODREP', 'CODREP');
      strSQL := strSQL + fStrLocate(edtCodFase, arrFase, 'AUXMOV.AUX_FASOBR','CODFAS');
      strSQL := strSQL + fStrLocate(edtCodEmb, fGetArrEmbarc, 'AUXMOV.AUX_CODEMB', 'CODEMB');
      strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'G.GER_CODEVE','CODEVE');

      If Not fEmptyStr(edtCodCliExcluir.Text) Then
         strSQL := strSQL + fStrLocate(edtCodCliExcluir, arrClientesExcluir, 'CLI_CODCLI', 'CLIEXC', False, True);

      If Not fEmptyStr(edtCodCliente.Text) Then
        if chkMovRede.Checked Then
          strSQL := strSQL + ' AND ( (CLI_CODCLI = :CODCLI) OR (CLI_CODRED = ' + strCodRedeLojasCliente + ') ) '
        Else
          strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'CLI_CODCLI', 'CODCLI');

      {****************************}
      {* FILTRO REDE DE LOJAS     *}
      {*************************DP*}
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

      If blnFaturamento And blnCliCons And (Not blnPorVendedor)  Then
        strSQL := strSQL + '  AND CLI_NOMCLI LIKE :NOMCLI ';

      {**********************************************}
      {* EMPRESA DE FATURAMENTO / EMPRESA DE ORIGEM *}
      {*******************************************DP*}
      pSetaEmpresaSelect(strSQL);

      If Not fEmptyStr(edtDescri.Text) Then
        strSQL := strSQL + '  AND DET_DESCRI LIKE :DESCRI ';

      If Not fEmptyStr(edtRefere.Text) Then
        strSQL := strSQL + '  AND DET_REFERE LIKE :REFERE ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'DET_CODMAR', 'CODMAR');

      If (Not fEmptyStr(edtTintasDisp.Text)) Then
        strSQL := strSQL + '  AND DET_IDEPRO = :IDEPRO ';

      strSQL := strSQL + fStrLocate(edtFornecedor, arrFornec, 'ITE_CODFOR', 'CODFOR');
      strSQL := strSQL + fStrLocate(edtCodAtividade, arrAtivid, 'CLI_CODATI', 'CODATI');

      If chkSomDev.Checked Then
        strSQL := strSQL + '  AND ((RIGHT(DET_CLAFIS, 3) IN ("202","411") AND DET_ESPDOC IN ("NF","EL","IF","IV","D1","PD")) OR (DET_ESPDOC = "TR" AND LEFT(DET_CLAFIS,1) < 5) OR (DET_ESPDOC = "DV")) ';

      If chkSomTra.Checked Then
        strSQL := strSQL + '  AND DET_CODCLI IN (' + fRetClientesFilial + ') AND ((DET_ESPDOC = "TE") OR (DET_ESPDOC IN ("NF", "EL") AND RIGHT(DET_CLAFIS, 3) IN (152,409))) ';

      If chkSomCon.Checked Then
        strSQL := strSQL + '  AND DET_CLAFIS IN ("1917","2917","5917","6917") ';

      If chkSomFut.Checked Then
        strSQL := strSQL + '  AND RIGHT(DET_CLAFIS, 3) = "922" ';

      If chkSomBai.Checked Then
        strSQL := strSQL + '  AND (LOCATE(RIGHT(DET_CLAFIS, 3), ' + CLAFIS_ENTFUT_VEN_ABR + ') > 0) ';

      If Not fEmptyStr(edtNomReg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

      If Not fEmptyStr(edtDesFpg.Text) Then
        strSQL := strSQL + fStrLocate(edtCodFpg, arrForPag, 'DET_CODFPG', 'CODFPG');

      if cbbEndCli.ItemIndex > 0 then
        strSQL := strSQL + ' AND ENTCLI.AUTOINCREM = ' + QuotedStr(fRetornaEntCli(edtCodCliente.Text, cbbEndCli.ItemIndex)) + ' ';

      If blnSomenteVendas Then
      Begin

        If blnFaturamento Then
        Begin

          strSQL := strSQL + ' AND ' + IIF(Not blnIncluirClienteFilial, ' DET_CODCLI NOT IN ('+VS_strCliFil+') AND ', '');
          strSQL := strSQL + ' ( ' + IIF(blnIncluirClienteFilial, ' DET_CODCLI IN ('+VS_strCliFil+') OR ', '');
          strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

          if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
            strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
          else
          begin
            If fCfgSis('ENTBRF', varBoolean) Or (Not blnSomenteVendas) Then
              strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
            Else
              strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
          end;

        End
        Else
        Begin

          strSQL := strSQL + '  AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
          strSQL := strSQL + '  AND ' + cnsFiltroFFDVTR + ' TRUE ';
          strSQL := strSQL + '  AND ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

          if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
            strSQL := strSQL + ' ) AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
          else
          begin
            If fCfgSis('ENTBRF', varBoolean) Or (Not blnSomenteVendas) Then
              strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
            Else
              strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
          end;

        End;

      End;

      If (Not(blnSomenteVendas) And Not(fEmptyStr(edtCodClaFis.Text)) ) Then
        strSQL :=strSQL + 'AND ' + fStrLocate(edtCodClaFis, arrClasFiscal, 'DET_CLAFIS', 'DETFIS', True);

      if blnFaturamento and not fEmptyStr(edtNumCmp.Text) then
      begin
        strSQL := strSQL + ' AND LOCATE(:NUMCMP, IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(T.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
        strSQL := strSQL + '                   FROM NUMCMP ';
        strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ' ';
        strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
        strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
        strSQL := strSQL + '                   FROM EXTDOR ';
        strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
        strSQL := strSQL + '                                         FROM FATDOR ';
        strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('D') + ') ';
        strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")))) ';
      end;

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   NUMDOC ';

    End;

    strSQLNotGer := strSQL;
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVGER', 'NOTGER');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVDET', 'NOTDET');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_COMPLE', '""');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVTRI', 'NOTTRI');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'SERMOV', 'SERNOT');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVICD', 'NOTICD');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_DESCFF', '0.0000');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_ICMPAV', '0.0000');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_NUM_PD', '""');
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_ESP_PD', '""');
    If Pos(cnsCodVen, strSQL) > 0 Then
    Begin
      strSQL := AnsiReplaceStr(strSQL, cnsCodVen, fGetSQLCodVen);
      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, cnsCodVen, ' DET_CODVEN ');
    End;

    If Pos(cnsNotEsp, strSQL) > 0 Then
    Begin
      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, cnsNotEsp, 'AND DET_NOTESP <> "S"');
    End;

    {Configuração criada para ColourDye afim de apresentar o valor digitado na venda}
    If(fCfgSis('EXIOF9',varBoolean)) Then
      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_DESESP', '0');

    If (fCfgSis('MOSMCL') = '3') Then
    Begin
      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, ' AND (DET_NUMFAT IS NULL OR DET_NUMFAT = "") ', '');
      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'IF(IFNULL(DET_NUMFAT, "") <> "", CONCAT(DET_NUMFAT,"-",DET_TIPFAT), "")', '""');
    End;

    If (edtDocCan.Text = 'S') Then
    Begin
      strSQLDel := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER','DEL_MOVGER'), 'AUXMOV','DEL_AUXMOV');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVDET','DEL_MOVDET');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVICD','DEL_MOVICD');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'CAST(" " AS CHAR(1)) AS DOCCAN','CAST("C" AS CHAR(1)) AS DOCCAN');
      strSQL  := strSQL + ' UNION ALL ' + strSQLDel;

      strSQLDelNotGer := AnsiReplaceStr(strSQLNotGer, 'NOTGER','DEL_NOTGER');
      strSQLDelNotGer := AnsiReplaceStr(strSQLDelNotGer, 'NOTDET','DEL_NOTDET');
      strSQLDelNotGer := AnsiReplaceStr(strSQLDelNotGer, 'NOTICD','DEL_NOTICD');
      strSQLDelNotGer := AnsiReplaceStr(strSQLDelNotGer, 'CAST(" " AS CHAR(1)) AS DOCCAN','CAST("C" AS CHAR(1)) AS DOCCAN');
    End;

    If Pos(cnsFiltroFFDVTR, strSQL) > 0 Then
      strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

    If (Pos(fCfgSis('MOSMCL'),'2_3_') > 0) Then
    Begin
      strSQL := strSQL + ' UNION ALL ' + strSQLNotGer;
      If Not fEmptyStr(strSQLDelNotGer) Then
        strSQL := strSQL + ' UNION ALL ' + strSQLDelNotGer;
    End;

    strSQL := strSQL + ' ORDER BY ';

    {************************}
    { AGRUPAMENTO POR LINHA }
    {********************RV*}
    If blnPorLinha Then
    Begin

      strSQL := strSQL + '  1 ';

    End
    Else If blnFaturamento Or blnConsultaItem Then
    Begin

      strSQL := strSQL + '  7, 9 ';

    End
    Else
    Begin

      If (rdgOrdem.ItemIndex = 0) Then
        strSQL := strSQL + '  2 '
      Else
        strSQL := strSQL + '  7, 9 ';

    End;

    strSQLPrinc := strSQL;

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE   ');
      SQL.Add('   CAST("D" AS CHAR(1)) AS MARDES,      ');

      If blnPorLinha Then
      Begin
        SQL.Add('   CODLIN, ');
        SQL.Add('   DESLIN, ');
        SQL.Add('   SUM(QTDITE) AS QTDITE, ');
        SQL.Add('   SUM(TOTITE) AS TOTITE, ');
        SQL.Add('   SUM(MAMKP4) AS MAMKP4, ');
        SQL.Add('   SUM(QTDVEN) AS QTDVEN, ');
        SQL.Add('   SUM(TOTVEN) AS TOTVEN, ');
        SQL.Add('   SUM(TOTGER) AS TOTGER ');
      End
      Else
      Begin
        If (edtTipo.Text = 'A') Then
        Begin
          SQL.Add(' CAST(IF(IFNULL(CODSER, "") = "", "N"   , "S"   ) AS CHAR(1)) AS ITESER, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", QTDITE, QTDSER) AS QTDITE, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTITE, VALSER) AS TOTITE, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", UNITAR, UNISER) AS UNITAR, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTDOC, VALSER) AS TOTDOC, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTGER, VALSER) AS TOTGER, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTCUS, 0.00)   AS TOTCUS, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", DESCRI, DESSER) AS DESCRI, ');
          SQL.Add(' IF(IFNULL(CODSER, "") = "", COMPLE, "") AS COMPLE, ');

          If (blnFaturamento) Then
          Begin
            SQL.Add(' IF(IFNULL(CODSER, "") = "", VLRSUG, UNISER) AS VLRSUG, ');
            SQL.Add(' IF(IFNULL(CODSER, "") = "", VLRPRA, UNISER) AS VLRPRA, ');
            SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTSUG, VALSER) AS TOTSUG, ');
            SQL.Add(' IF(IFNULL(CODSER, "") = "", TOTPRA, VALSER) AS TOTPRA, ');
          End;

        End;

        SQL.Add(' VENCLI.*          ');
      End;

      SQL.Add(' FROM                  ');
      SQL.Add('   (' + strSQLPrinc + ') AS VENCLI ');

      If (Not blnPorLinha) And (edtTipo.Text = 'A') And (blnUsaSer) Then
        SQL.Add(' WHERE (CODSER IS NULL) OR (LENGTH(CODSER) >= 1 AND TRIM(CODSER) <> "") ');

      If blnPorLinha Then
      Begin
        SQL.Add('  GROUP BY ');
        SQL.Add('    CODLIN ');
      End
      Else If (edtTipo.Text = 'A') And (blnUsaSer) Then
        SQL.Add('HAVING ((LOCATE(CODITE, :ITESER) > 0 AND IFNULL(CODSER, "") <> "") OR (LOCATE(CODITE, :ITESER) <= 0)) ');

      SQL.Add(' ORDER BY              ');

      {************************}
      { AGRUPAMENTO POR LINHA }
      {********************RV*}
      If blnPorLinha Then
        SQL.Add('   CODLIN  ')
      Else If blnFaturamento Then
        SQL.Add('   DET_DTAENT DESC, NUMESP  ') // SE VIR DO FATURAMENTO F9 (blnFaturamento) ORDENA POR DATA DECRESCENTE
      Else
      Begin
        If (edtTipo.Text = 'A') Then
        Begin
          If rdgOrdem.ItemIndex = 0 Then
            SQL.Add('   NOMCLI, DET_DTAENT, NUMDOC, DESSER  ')
          Else
            SQL.Add('   DET_DTAENT, NUMESP, DESSER  ');
        End
        Else
        Begin
          If rdgOrdem.ItemIndex = 0 Then
            SQL.Add('   NOMCLI, DET_DTAENT, NUMDOC ')
          Else
            SQL.Add('   DET_DTAENT, NUMESP ');
        End;
      End;

      If FindParam('DTAINI') <> Nil Then
        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      If FindParam('DTAFIN') <> Nil Then
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      If FindParam('CLAVEN') <> Nil Then
        ParamByName('CLAVEN').AsString := VS_strClaVen;
      If FindParam('CLADEV') <> Nil Then
        ParamByName('CLADEV').AsString := VS_strClaDev;

      pSetaParam(edtCodCidade.Text, arrCidade, strCidade, 'CODCID', QryRelatorio);

      If Length(arrLinGru) > 1 Then
        pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', QryRelatorio)
      Else
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', QryRelatorio);
      pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', QryRelatorio);
      pSetaParam(edtCodCliExcluir.Text, arrClientesExcluir, strClientesExcluir, 'CLIEXC', QryRelatorio);

      {*****************}
      {* REDE DE LOJAS *}
      {**************DP*}
      pSetaParamOR(edtCodRede       , arrRede      , 'CODRED', QryRelatorio);
      pSetaParam(edtCodCliCon.Text  , arrConsumidor, strConsumidor, 'CGCCON', QryRelatorio);
      pSetaParam(strCodVen          , arrVendedor  , strVendedor  , 'CODVEN', QryRelatorio);
      pSetaParam(edtCodCidade.Text  , arrCidade    , strCidade    , 'CODCID', QryRelatorio);
      pSetaParam(strCodRep          , arrRepres    , strRepres    , 'CODREP', QryRelatorio);
      pSetaParam(edtCodFase.Text    , arrFase      , strFase      , 'CODFAS', QryRelatorio);
      pSetaParam(fGetCodEmb         , fGetArrEmbarc, strEmbarc    , 'CODEMB', QryRelatorio);
      pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', QryRelatorio);

      If not fEmptyStr(edtConNom.Text) Then
        ParamByName('NOMCON').AsString := edtConNom.Text + '%';

      If blnFaturamento And blnCliCons Then
        ParamByName('NOMCLI').AsString := edtDesCliente.Text + IfThen(fEmptyStr(edtDesCliente.Text),'','%');

      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);

      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESCRI').AsString := edtDescri.Text + '%';

      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';

      If Not fEmptyStr(edtEspDoc.Text) Then
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      pSetaParam(edtMarca.Text, arrMarca, strMarca,'CODMAR', QryRelatorio);

      If (Not fEmptyStr(edtTintasDisp.Text)) Then
      Begin
        ParamByName('IDEPRO').AsString := edtTintasDisp.Text;
      End;

      if blnFaturamento and not fEmptyStr(edtNumCmp.Text) then
        ParamByName('NUMCMP').AsString := edtNumCmp.Text;

      pSetaParam(edtFornecedor.Text, arrFornec, strFornec, 'CODFOR', QryRelatorio);
      pSetaParam(edtCodAtividade.Text, arrAtivid, strAtivid, 'CODATI', QryRelatorio);

      If Not fEmptyStr(edtNomReg.Text) Then
        pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', QryRelatorio);

      If Not fEmptyStr(edtDesFpg.Text) Then
        pSetaParam(edtCodFpg.Text, arrForPag, strForPag, 'CODFPG', QryRelatorio);

      {**********************}
      {* FILTROS DO VEÍCULO *}
      {**********************}
      If fCfgSis('AUTCEN', varBoolean) Then
      Begin
        If (Not fEmptyStr(mskPlaVei.Text)) Then
          pSetaParam(mskPlaVei.Text, arrVeic, strVeic, 'PLAVEI', QryRelatorio);

        If (Not fEmptyStr(edtCodMar.Text)) Then
          pSetaParam(edtCodMar.Text, arrMarcaVei, strMarcaVei, 'MARVEI', QryRelatorio);

        If (Not fEmptyStr(edtCodMod.Text)) Then
          pSetaParam(edtCodMod.Text, arrModelo, strModelo, 'MODELO', QryRelatorio);

        If (Not fEmptyStr(edtCodCor.Text)) Then
          pSetaParam(edtCodCor.Text, arrCor, strCor, 'CORVEI', QryRelatorio);

        If (Not fEmptyStr(edtAno.Text)) Then
          ParamByName('ANOVEI').AsString := edtAno.Text;
      End;

      If (FindParam('ITESER') <> Nil) Then
        ParamByName('ITESER').AsString := QuotedStr(fCfgSis('ITESER', varString) + '_' + fCfgSis('SERTER', varString) + '_');

      If Not(fEmptyStr(edtCodClaFis.Text)) Then
        pSetaParam(edtCodClaFis.Text,arrClasFiscal,strClaFiscal,'DETFIS', QryRelatorio);

      Open;

      pSetaClient(QryRelatorio);

      cdsRelVenCli.Close;
      cdsRelVenCli.PacketRecords := 100;
      cdsRelVenCli.SetProvider(dspRelVenCli);
      cdsRelVenCli.Open;
      cdsRelVenCli.LogChanges := False;

      pSetaClient(cdsRelVenCli);

    End;

    If Not cdsRelVenCli.IsEmpty Then
    Begin

      {***********************}
      { AGRUPAMENTO POR LINHA }
      {********************RV*}
      If blnPorLinha Then
      Begin
        Try
          pCriarFormularios(TfrmRelFatVendasPorLinha, frmRelFatVendasPorLinha);
          cdsRelVenCli.Last;
          cdsRelVenCli.First;
          pCloneDataSet(frmRelFatVendasPorLinha.cdsDados, cdsRelVenCli);
          frmRelFatVendasPorLinha.oleVendas := oleVendas;
          If blnPorVendedor Then
          Begin
            frmRelFatVendasPorLinha.lblVendedor.Caption := fStrTitulo(strCodVen, edtDesVendedor, arrVendedor, strVendedor, 'Vendedor');
          End
          Else
          Begin

            frmRelFatVendasPorLinha.lblVendedor.Caption := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes,  strClientes,  'Cliente');

            frmRelFatVendasPorLinha.pnlDados.Height     := frmRelFatVendasPorLinha.pnlDados.Height -
                                                           frmRelFatVendasPorLinha.lblVendedor.Height;

            frmRelFatVendasPorLinha.lblVendedor.Visible := False;
          End;
          frmRelFatVendasPorLinha.lblMetas.Caption := FormatFloat(',0.00', fVerificaMetas);
          frmRelFatVendasPorLinha.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Visualização)]');
          End;
        End;
        pFreeAndNil(frmRelFatVendasPorLinha);
      End
      Else If blnFaturamento Then
      Begin
        Try
          pCriarFormularios(TfrmRelFatVendasClienteF9,frmRelFatVendasClienteF9);
          frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := cdsRelVenCli;
          frmRelFatVendasClienteF9.blnMosVenMtl := fFiltrarVenMtl();

          If chkMovRede.Checked Then
            frmRelFatVendasClienteF9.strCodRedeLojasCliente := strCodRedeLojasCliente;

          If blnPorVendedor Then
          Begin
            frmRelFatVendasClienteF9.lblCliente.Caption := fStrTitulo(strCodVen, edtDesVendedor, arrVendedor, strVendedor, 'Vendedor');
          End
          Else
          Begin
            frmRelFatVendasClienteF9.lblCliente.Caption := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes,  strClientes,  'Cliente');

            frmRelFatVendasClienteF9.pnlDados.Height := frmRelFatVendasClienteF9.pnlDados.Height -
                                                        frmRelFatVendasClienteF9.edtCliente.Height +
                                                        frmRelFatVendasClienteF9.edtNomRec.Height;

            frmRelFatVendasClienteF9.edtCliente.Visible := Not edtCodCliCon.ReadOnly;
            frmRelFatVendasClienteF9.lblCodCli.Visible  := Not edtCodCliCon.ReadOnly;
          End;

          frmRelFatVendasClienteF9.blnSelDocumentos       := True;
          frmRelFatVendasClienteF9.blnVeioDoTablet        := blnVeioDoTablet;
          frmRelFatVendasClienteF9.blnVeioTelaVendas      := blnVeioTelaVendas;
          frmRelFatVendasClienteF9.blnVeioDoTelemarketing := blnVeioDoTelemarketing;
          frmRelFatVendasClienteF9.blnMosCom              := blnMosCom;
          frmRelFatVendasClienteF9.fIncluirItem           := fIncluirItem;
          frmRelFatVendasClienteF9.blnExibirReferenciaUnidade := chkRefUni.Checked;
          If frmRelFatVendasClienteF9.ShowModal = mrOk Then
            Close;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Visualização)]');
          End;
        End;

        pFreeAndNil(frmRelFatVendasClienteF9);

      End
      Else If blnConsultaDocumento Then
      Begin
        Try
          pCriarFormularios(TfrmRelFatVendasItensF9,frmRelFatVendasItensF9);
          frmRelFatVendasItensF9.dtsRelVenCli.DataSet := cdsRelVenCli;
          frmRelFatVendasItensF9.pMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
          frmRelFatVendasItensF9.blnOpcaoImpressao:= True;
          frmRelFatVendasItensF9.onShow(Nil);
          frmRelFatVendasItensF9.btnDocComClick(Nil);
          pFreeAndNil(frmRelFatVendasItensF9);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmRelFatVendasItensF9]');
          End;
        End;
      End
      Else If blnConsultaItem Then
      Begin
        Try
          pCriarFormularios(TfrmRelFatVendasItensF9,frmRelFatVendasItensF9);
          frmRelFatVendasItensF9.dtsRelVenCli.DataSet := cdsRelVenCli;
          frmRelFatVendasItensF9.pMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
          frmRelFatVendasItensF9.ShowModal;
          pFreeAndNil(frmRelFatVendasItensF9);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmRelFatVendasItensF9]');
          End;
        End;
      End
      Else
      Begin

        If (edtDestino.Text = 'E') Then
        Begin
          pSenhaMargem;
          pGerarExcel;
        End
        Else
        Begin

          frxRel := frxRelatorioJ;

          frxRelatorio.DataSet := cdsRelVenCli;

          // Início - Deixando do jeito original

          TfrxReportPage(frxRel.Pages[0]).Visible := True;
          TfrxReportPage(frxRel.Pages[1]).Visible := True;
          TfrxReportPage(frxRel.Pages[2]).Visible := True;

          frxPage1 := frxRel.FindComponent('Page1') as TfrxPage;
          frxPage2 := frxRel.FindComponent('Page2') as TfrxPage;
          frxPage3 := frxRel.FindComponent('Page3') as TfrxPage;

          frxPage1.Visible := True;
          frxPage2.Visible := True;
          frxPage3.Visible := True;

          TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := False;
          TfrxGroupHeader(frxRel.FindObject('GroupHeader2')).Visible := False;
          TfrxGroupHeader(frxRel.FindObject('GroupHeader3')).Visible := False;

          TfrxGroupFooter(frxRel.FindObject('GroupFooter1')).Visible := False;
          TfrxGroupFooter(frxRel.FindObject('GroupFooter2')).Visible := False;
          TfrxGroupFooter(frxRel.FindObject('GroupFooter3')).Visible := False;

          TfrxMemoView(frxRel.FindObject('rllEvento')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rllEmbarc')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rllRefere')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllUnidade')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbUnidad')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Width := 99.77953;

          TfrxMemoView(frxRel.FindObject('rdbDtaDoc')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbNumDoc')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbQtdIte')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbValUnit')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbTotIte')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllCustoGrupo1')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllMargGrupo1')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbDocOri')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbCodEmp')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbCodVen')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbClaFis')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbCodIte')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbUnidad')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbTotDoc')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbDocCan')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbCodSer')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbDesSer')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbQtdSer')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbUniSer')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbValSer')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rllTotDocGrupo1')).Top := 15.11812; // o restante vai acompanhar no BeforePrint

          TfrxMemoView(frxRel.FindObject('rllMargem')).Visible           := True;
          TfrxMemoView(frxRel.FindObject('rllCusto')).Visible            := True;

          TfrxMemoView(frxRel.FindObject('rllMargGrupo1')).Visible       := True;
          TfrxMemoView(frxRel.FindObject('rllCustoGrupo1')).Visible      := True;
          TfrxMemoView(frxRel.FindObject('rllTotDocMargGrupo1')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusGerGrupo1')).Visible  := True;

          TfrxMemoView(frxRel.FindObject('rllTotCliMargGrupo1')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusCliGrupo1')).Visible  := True;

          TfrxMemoView(frxRel.FindObject('rllTotTotGerMar')).Visible     := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusGeral')).Visible      := True;

          TfrxMemoView(frxRel.FindObject('rllTotDocMargGrupoAnaliticoEmissao')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusGerGrupoAnaliticoEmissao')).Visible  := True;

          TfrxMemoView(frxRel.FindObject('rllValTot')).Left   := 541.91373;
          TfrxMemoView(frxRel.FindObject('rllUnit')).Left     := 495.60668;
          TfrxMemoView(frxRel.FindObject('rllQtde')).Left     := 464.88219;
          TfrxMemoView(frxRel.FindObject('rllUnidade')).Left  := 445.98454;
          TfrxMemoView(frxRel.FindObject('rllRefere')).Left   := 419.52783;

          TfrxMemoView(frxRel.FindObject('rdbDescri')).Width  := 99.77953;
          TfrxMemoView(frxRel.FindObject('rdbRefere')).Left   := 419.52783;
          TfrxMemoView(frxRel.FindObject('rdbUnidad')).Left   := 445.98454;
          TfrxMemoView(frxRel.FindObject('rdbQtdIte')).Left   := 464.88219;
          TfrxMemoView(frxRel.FindObject('rdbValUnit')).Left  := 495.60668;
          TfrxMemoView(frxRel.FindObject('rdbTotIte')).Left   := 541.91373;

          TfrxMemoView(frxRel.FindObject('rdbDesSer')).Width  := 235.84261;
          TfrxMemoView(frxRel.FindObject('rdbQtdSer')).Left   := 464.88219;
          TfrxMemoView(frxRel.FindObject('rdbUniSer')).Left   := 495.49606299;
          TfrxMemoView(frxRel.FindObject('rdbValSer')).Left   := 541.98425197;

          TfrxMemoView(frxRel.FindObject('rllDesEspTot')).Left                        := 541.91373;
          TfrxMemoView(frxRel.FindObject('rllTotDocGerGrupo1')).Left                  := 541.98425197;
          TfrxMemoView(frxRel.FindObject('rllTotQtdD')).Left                          := 464.88219;

          TfrxMemoView(frxRel.FindObject('rllTotQtd')).Left                           := 464.88219;
          TfrxMemoView(frxRel.FindObject('rllTotCliGerGrupo1')).Left                  := 541.91373;

          TfrxMemoView(frxRel.FindObject('rllTotDocGerGrupoAnaliticoSintetico')).Left := 541.91373;
          TfrxMemoView(frxRel.FindObject('rllDesEspTotAnaliticoEmissao')).Left        := 541.98425197;

          TfrxMemoView(frxRel.FindObject('rllMargem2')).Visible            := True;
          TfrxMemoView(frxRel.FindObject('rllCusto2')).Visible             := True;
          TfrxMemoView(frxRel.FindObject('rllMargemSint')).Visible         := True;
          TfrxMemoView(frxRel.FindObject('rllCustoSint')).Visible          := True;
          TfrxMemoView(frxRel.FindObject('rllTotCliMargemGrupo2')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusCliGrupo2')).Visible    := True;
          TfrxMemoView(frxRel.FindObject('rllTotGerMag')).Visible          := True;
          TfrxMemoView(frxRel.FindObject('rllTotGerMag2')).Visible         := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusDocs')).Visible         := True;
          TfrxMemoView(frxRel.FindObject('rllTotCusDocs2')).Visible        := True;

          TfrxMemoView(frxRel.FindObject('rllMargem2SinteticoEmissao')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllCusto2SinteticoEmissao')).Visible  := True;
          TfrxMemoView(frxRel.FindObject('rllMargemSintEmissao')).Visible       := True;
          TfrxMemoView(frxRel.FindObject('rllCustoSintEmissao')).Visible        := True;

          // Fim - Deixando do jeito original

          Try

            frxRel.Script.Variables['rllMensagemRodape'] := strMsgConf;

            frxRel.Script.Variables['ORDEM'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
            If chkSomDev.Checked Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' -> SOMENTE DEVOLUÇÕES ';
            If chkSomTra.Checked Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' -> SOMENTE TRANSFERENCIAS ';
            If chkSomCon.Checked Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' -> SOMENTE CONSIGNAÇÕES ';
            If chkSomFut.Checked Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' -> SOMENTE ENTREGA FUTURA ';
            If chkSomBai.Checked Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' -> SOMENTE BAIXA DE ENTREGA FUTURA ';
            If Not fEmptyStr(edtEspDoc.Text) Then
              frxRel.Script.Variables['ORDEM'] := frxRel.Script.Variables['ORDEM'] +' - ' + edtEspDoc.Text;

            frxRel.Script.Variables['rllCliente'] := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes,  strClientes,  'CLIENTE');

            If Not fEmptyStr(edtCodCliExcluir.Text) Then
              frxRel.Script.Variables['rllCliExcluir'] := fStrTitulo(edtCodCliExcluir.Text, edtDesCliExcluir, arrClientesExcluir,  strClientesExcluir,  'CLIENTE A EXCLUIR')
            Else  
              frxRel.Script.Variables['rllCliExcluir'] := 'CLIENTE A EXCLUIR: NENHUM ';

            frxRel.Script.Variables['rllVendedor'] := fStrTitulo(strCodVen, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR');
            frxRel.Script.Variables['rllRepresentante'] := fStrTitulo(strCodRep, edtNomRep, arrRepres, strRepres, 'REPRESENTANTE');

            If rdgEmpresa.ItemIndex = 0 Then
              frxRel.Script.Variables['rllEmpresa'] := IfThen(fEmptyStr(edtCodEmpresa.Text), 'EMPRESA : TODAS', fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA (FATURAMENTO)') )
            Else
              frxRel.Script.Variables['rllEmpresa'] := IfThen(fEmptyStr(edtCodEmpresa.Text), 'EMPRESA : TODAS', fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA (ORIGEM)'));

            If fCfgSis('FASOBR') = 'S' Then
            Begin
              If Not fEmptyStr(edtCodFase.Text) Then
                frxRel.Script.Variables['rllFaseObra'] := fStrTitulo(edtCodFase.Text, edtDesFase, arrFase, strFase, 'FASE DA OBRA')
              Else
                frxRel.Script.Variables['rllFaseObra'] := 'FASE DA OBRA: TODAS ';
            End;

            If (fCfgSis('EVEFAT', varBoolean)) Then
            Begin
              If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
                frxRel.Script.Variables['rllEvento'] := fStrTitulo(fraCentroCusto.edtCodEve.Text, fraCentroCusto.edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS')
              Else
                frxRel.Script.Variables['rllEvento'] := 'CENTRO DE CUSTOS: TODOS ';
            End
            Else
              TfrxMemoView(frxRel.FindObject('rllEvento')).Visible := False;

            {*****************}
            {* REDE DE LOJAS *}
            {**************DP*}
            frxRel.Script.Variables['rllRedeLoja']   := IfThen(fEmptyStr(edtCodRede.Text), 'REDE DE LOJAS : TODAS', 'REDE DE LOJAS : ' + edtCodRede.Text + ' - ' + edtDesRede.Text);
            frxRel.Script.Variables['rllCidade']     := fStrTitulo(edtCodCidade.Text, edtDesCidade, arrCidade, strCidade, 'CIDADE', True);
            frxRel.Script.Variables['rllFornecedor'] := fStrTitulo(edtFornecedor.Text, edtDesFornecedor, arrFornec, strFornec, 'FORNECEDOR');
            frxRel.Script.Variables['rllAtividade']  := fStrTitulo(edtCodAtividade.Text, edtDesAtividade, arrAtivid, strAtivid, 'ATIVIDADE', True);
            frxRel.Script.Variables['rllComCus']     := 'CUSTO POR: ' + cbbComCus.Text;
            frxRel.Script.Variables['rllLinhaGrupo'] := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinGru,strLinGru,'LINHA/GRUPO');
            frxRel.Script.Variables['rllMarca']      := fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strMarca,'MARCA',True);
            frxRel.Script.Variables['rllTinta']      := 'TINTAS: '+IfThen(not fEmptyStr(edtTintasDisp.Text),(edtTintasDisp.Text+' - '+edtDesTinta.Text),'TODAS');
            frxRel.Script.Variables['rllProduto']    := LeftStr(fStrTitulo(edtProdutos.Text,edtDesProduto,arrCadIte,strCadIte,'PRODUTO'),255);
            frxRel.Script.Variables['rllDesPro']     := 'DESCR. PRODU.: '+IfThen(not fEmptyStr(edtDescri.Text),edtDescri.Text,'TODAS');
            frxRel.Script.Variables['rllRefPro']     := 'REFER. PRODU.: '+IfThen(not fEmptyStr(edtRefere.Text),edtRefere.Text,'TODAS');
            frxRel.Script.Variables['rllEspPro']     := 'ESPEC. DOCUM.: '+IfThen(not fEmptyStr(edtEspDoc.Text),edtEspDoc.Text,'TODAS');
            frxRel.Script.Variables['rllCliCon']     := IfThen(not fEmptyStr(edtCodCliCon.Text),fStrTitulo(edtCodCliCon.Text, edtNomCliCon, arrConsumidor, strConsumidor,'CONSUMIDOR'),'');
            frxRel.Script.Variables['rllNomCon']     := IfThen(not fEmptyStr(edtConNom.Text), 'CONSUMIDOR (NOME): ' + edtConNom.Text, '');
            frxRel.Script.Variables['rllPlaca']      := fStrTitulo(mskPlaVei.Text, edtDesVei, arrVeic, strVeic, 'VEÍCULO');
            frxRel.Script.Variables['rllMarcaVei']   := fStrTitulo(edtCodMar.Text, edtDesMar, arrMarcaVei, strMarcaVei, 'MARCA (VEÍCULO)');
            frxRel.Script.Variables['rllAnoModelo']  := fStrTitulo(edtCodMod.Text, edtDesMod, arrModelo, strModelo, 'MODELO/ANO') + ' / ' + IfThen(fEmptyStr(edtAno.Text), 'TODOS', edtAno.Text);
            frxRel.Script.Variables['rllCor']        := fStrTitulo(edtCodCor.Text, edtDesCor, arrCor, strCor, 'COR');
            frxRel.Script.Variables['rllRegiao']     := fStrTitulo(edtCodReg.Text,edtNomReg,arrRegiao,strRegiao,'REGIÃO',True);
            frxRel.Script.Variables['rllFormPag']    := fStrTitulo(edtCodFpg.Text,edtDesFpg,arrForPag,strForPag,'FORMA DE PAGAMENTO',True);
            frxRel.Script.Variables['rllEmbarc']     := fStrTitulo(edtCodEmb.Text, edtNomEmb, fGetArrEmbarcCodEmb, fGetStrEmbarc, 'EMBARCAÇÃO');
            If Not(blnSomenteVendas) Then
              frxRel.Script.Variables['rllClafis']   := fStrTitulo(edtCodClafis.Text,edtDesClaFis,arrClasFiscal,strClaFiscal,'CLASSIFICAÇÃO. FISCAL',True)
            Else
              frxRel.Script.Variables['rllClafis']   := '';


            If Not edtCodEmb.Visible Then
              TfrxMemoView(frxRel.FindObject('rllEmbarc')).Visible := False;

            pSenhaMargem;

            If not chkRefUni.Checked Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllRefere')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rllUnidade')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbUnidad')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbDescri')).Width := 145.13389;
            End
            Else If (rdgOrdem.ItemIndex = 0) Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllRefere')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbDescri')).Width := 126.23624;
            End;

            If (edtTipo.Text = 'A') Then
            Begin


              frxRel.Script.Variables['NOMREL'] := fRetTituloRel(edtTipo.Text);

              frxPage2.Visible := False;
              frxPage3.Visible := False;

              If rdgOrdem.ItemIndex = 0 Then
              Begin
                TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := True;
                TfrxGroupFooter(frxRel.FindObject('GroupFooter1')).Visible := True;
                TfrxGroupHeader(frxRel.FindObject('GroupHeader2')).Visible := True;
                TfrxGroupFooter(frxRel.FindObject('GroupFooter2')).Visible := True;

              End
              Else
              Begin
                TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := True; // não mostra o GroupFooter1
                TfrxGroupHeader(frxRel.FindObject('GroupHeader3')).Visible := True;
                TfrxGroupFooter(frxRel.FindObject('GroupFooter3')).Visible := True;
              End;

              If edtMargem.Text = 'N' Then
              Begin

                TfrxMemoView(frxRel.FindObject('rllMargem')).Visible           := False;
                TfrxMemoView(frxRel.FindObject('rllCusto')).Visible            := False;

                TfrxMemoView(frxRel.FindObject('rllMargGrupo1')).Visible       := False;
                TfrxMemoView(frxRel.FindObject('rllCustoGrupo1')).Visible      := False;
                TfrxMemoView(frxRel.FindObject('rllTotDocMargGrupo1')).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusGerGrupo1')).Visible  := False;

                TfrxMemoView(frxRel.FindObject('rllTotCliMargGrupo1')).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusCliGrupo1')).Visible  := False;

                TfrxMemoView(frxRel.FindObject('rllTotTotGerMar')).Visible     := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusGeral')).Visible      := False;

                TfrxMemoView(frxRel.FindObject('rllTotDocMargGrupoAnaliticoEmissao')).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusGerGrupoAnaliticoEmissao')).Visible  := False;

                fltLarguraCustoMargem := 77.10235; // largura dos campos de custo e de margem somados

                TfrxMemoView(frxRel.FindObject('rllValTot')).Left   := 541.91373 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllUnit')).Left     := 495.60668 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllQtde')).Left     := 464.88219 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllUnidade')).Left  := 445.98454 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllRefere')).Left   := 419.52783 + fltLarguraCustoMargem;

                TfrxMemoView(frxRel.FindObject('rdbDescri')).Width  := 99.77953 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbRefere')).Left   := 419.52783 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbUnidad')).Left   := 445.98454 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbQtdIte')).Left   := 464.88219 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbValUnit')).Left  := 495.60668 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbTotIte')).Left   := 541.91373 + fltLarguraCustoMargem;

                TfrxMemoView(frxRel.FindObject('rdbDesSer')).Width  := 235.84261 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbQtdSer')).Left   := 464.88219 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbUniSer')).Left   := 495.49606299 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rdbValSer')).Left   := 541.98425197 + fltLarguraCustoMargem;

                TfrxMemoView(frxRel.FindObject('rllDesEspTot')).Left                        := 541.91373 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllTotDocGerGrupo1')).Left                  := 541.98425197 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllTotQtdD')).Left                          := 464.88219 + fltLarguraCustoMargem;

                TfrxMemoView(frxRel.FindObject('rllTotQtd')).Left                           := 464.88219 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllTotCliGerGrupo1')).Left                  := 541.91373 + fltLarguraCustoMargem;

                TfrxMemoView(frxRel.FindObject('rllTotDocGerGrupoAnaliticoSintetico')).Left := 541.91373 + fltLarguraCustoMargem;
                TfrxMemoView(frxRel.FindObject('rllDesEspTotAnaliticoEmissao')).Left        := 541.98425197 + fltLarguraCustoMargem;

              End;

            End
            Else
            Begin

              frxRel.Script.Variables['NOMREL'] := fRetTituloRel(edtTipo.Text);

              If rdgOrdem.ItemIndex = 0 Then
              Begin
                frxPage1.Visible := False;
                frxPage3.Visible := False;
                TfrxHeader(frxRel.FindObject('rlbTituloCndPag')).Visible  := True;
                TfrxMasterData(frxRel.FindObject('rlbDetalheCndPag')).Visible := True;
              End Else
              Begin
                frxPage1.Visible := False;
                frxPage2.Visible := False;
                TfrxHeader(frxRel.FindObject('rlbTituloCliente')).Visible  := True;
                TfrxMasterData(frxRel.FindObject('rlbDetalheCliente')).Visible := True;
              End;

              If edtMargem.Text = 'N' Then
              Begin
                TfrxMemoView(frxRel.FindObject('rllMargem2')).Visible            := False;
                TfrxMemoView(frxRel.FindObject('rllCusto2')).Visible             := False;
                TfrxMemoView(frxRel.FindObject('rllMargemSint')).Visible         := False;
                TfrxMemoView(frxRel.FindObject('rllCustoSint')).Visible          := False;
                TfrxMemoView(frxRel.FindObject('rllTotCliMargemGrupo2')).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusCliGrupo2')).Visible    := False;
                TfrxMemoView(frxRel.FindObject('rllTotGerMag')).Visible          := False;
                TfrxMemoView(frxRel.FindObject('rllTotGerMag2')).Visible         := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusDocs')).Visible         := False;
                TfrxMemoView(frxRel.FindObject('rllTotCusDocs2')).Visible        := False;

                TfrxMemoView(frxRel.FindObject('rllMargem2SinteticoEmissao')).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllCusto2SinteticoEmissao')).Visible  := False;
                TfrxMemoView(frxRel.FindObject('rllMargemSintEmissao')).Visible       := False;
                TfrxMemoView(frxRel.FindObject('rllCustoSintEmissao')).Visible        := False;
              End;

            End;

            If Not blnSomenteVendas Then
              fMensagem('INFORMAÇÃO',
                        'TODO O MOVIMENTO DE ENTRADA E SAÍDA DE ITENS DO CLIENTE ' + #13#10 +
                        'SERÁ MOSTRADO FILTRANDO SOMENTE AS CLASSIFICAÇÕES ' + #13#10 +
                        'INFORMADAS NO CAMPO CLASSIFICAÇÃO FISCAL !'
                        ,['&O K']);

            TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);
            TfrxMemoView(frxRel.FindObject('rllZebra2')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);
            TfrxMemoView(frxRel.FindObject('rllZebra3')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frxRel)
            Else If frxRel.PrepareReport Then
            Begin
              frxRel.PrintOptions.Printer := strNomImp;
              frxRel.PrintOptions.ShowDialog := strNomImp.IsEmpty;
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;

        End;
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  QryRelatorio.Close;
  cdsRelVenCli.Close;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelFatVendasCliente.fRetTituloRel(strTipRel: String): String;
begin
   Result := 'RELATÓRIO DE MOVIMENTO DE CLIENTES' + IfThen(strTipRel = 'A', ' - ANALÍTICO', ' - SINTÉTICO');
end;

function TfrmRelFatVendasCliente.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    IntCorre : Integer;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaDataStr(mskDtaIni.Text) Then
          Begin
            fMensagem('', 'Data Inicial não é válida!', ['&O k']);
            Result := False;
            Sender := mskDtaIni;
          End
          Else If Not fValidaDataStr(mskDtaFin.Text) Then
          Begin
            fMensagem('', 'Data Final não é válida!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End
    Else if (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo, arrLinGru, '', 6);

    End

    Else if (Sender = fraCentroCusto.edtCodEve) And (pnlEventos.Visible) Then
    Begin
      pDesmarcaLista(fraCentroCusto.edtCodEve, arrEvento, '', 5);

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End Else
        fraCentroCusto.edtDesEve.Clear;
    End

    Else if (Sender = edtProdutos) Then
    Begin
      pDesmarcaLista(edtProdutos, arrCadIte);

    End

    {************************************}
    {* VALIDA DESCRIÇÃO DO CLIENTE      *}
    {*********************************AF*}
    Else If (Sender = edtDesCliente) Then
    Begin

      If not edtDesCliente.ReadOnly Then
      Begin

        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('','O nome do cliente deve ser preenchido!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtMarca) Then
    Begin

      pDesmarcaLista(edtMarca, arrMarca);

    End

    Else If (Sender = edtTintasDisp) And (edtTintasDisp.Visible) Then
    Begin

      If fEmptyStr(edtTintasDisp.Text) Then
      Begin
        edtDesTinta.Text := 'TODAS';
      End
      Else
      Begin
        If Not tintas.fEstaDisponivel(edtTintasDisp.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Tinta não está disponível!',['&O K']);
          Result := False;
        End
        Else
        Begin
          edtDesTinta.Text := tintas.fGetNomeTinta(edtTintasDisp.Text);
        End;
      End;

    End

    Else If (Sender = edtCodCliente) Then
    Begin

      pDesmarcaLista(edtCodCliente, arrClientes);

      pSetaConsumidor;

    End

    Else If (Sender = edtCodCliExcluir) Then
    Begin
      pDesmarcaLista(edtCodCliExcluir, arrClientesExcluir);
    End

    {************************************}
    {* VALIDA DESCRIÇÃO DO CLIENTE      *}
    {*********************************AF*}
    Else If (Sender = edtCodCliCon) And (edtCodCliCon.Enabled) Then
    Begin
      If (fEmptyStr(edtCodCliCon.Text) And fCfgSis('CPFCON', varBoolean))  Then
      Begin
        if fClienteConsumidor(edtDesCliente.Text) Then
        begin
          fMensagem('','É obrigatório informar o CPF para cliente consumidor! ',['&OK']);
          Result := False;
        end;
      End;

      edtNomCliCon.Text := fRetNomClienteConsumidor(edtCodCliCon.Text);

      If Not fEmptyStr(edtCodCliCon.Text) Then
      Begin

        If fEmptyStr(edtNomCliCon.Text) Then
        Begin
          fMensagem('','Nenhum consumidor encontrado com este código!',['&OK']);
          Result := False;
        End
        Else If fRetUFCliente(edtCodCliente.Text) <> fRetNomCidade(fRetDadosClienteConsumidor(edtCodCliCon.Text, 'CODCID'), 1) Then
        Begin
          fMensagem('','Estado do cliente consumidor deve ser ' + fRetUFCliente(edtCodCliente.Text),['&OK']);
          Result := False;
        End;

      End
      Else
      begin
        pDesmarcaLista(edtCodCliCon, arrConsumidor);
        edtNomCliCon.Clear;
      end;

    End
    {************************************}
    {* VALIDA MARGEM                    *}
    {*********************************AF*}
    Else If (Sender = edtMargem) Then
    Begin

      If (edtMargem.Text <> 'S') And (edtMargem.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Mostrar Margem deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End
    {************************************}
    {* VALIDA DOCUMENTOS CANCELADOS     *}
    {*********************************LU*}
    Else If (Sender = edtDocCan) Then
    Begin

      If (edtDocCan.Text <> 'S') And (edtDocCan.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Exibir Documentos Cancelados deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End
    {************************************}
    {* VALIDA AJUSTE                    *}
    {*********************************LU*}
    Else If (Sender = edtAjuste) Then
    Begin

      If (edtAjuste.Text <> 'S') And (edtAjuste.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Mostrar Ajuste deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End
    {************************************}
    {* VALIDA VENDEDOR                  *}
    {*********************************AF*}
    Else If (Sender = edtCodVendedor) Then
    Begin

      If (Not blnLiberado) Then
      Begin
        If (fEmptyStr(edtCodVendedor.Text)) Then
        Begin
          fMensagem('', 'O vendedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          strCodVen := fRetCodVendedor(edtCodVendedor.Text);
          If (fEmptyStr(strCodVen)) And (Not fEmptyStr(edtCodVendedor.Text)) Then
          Begin
            fMensagem('AVISO','Vendedor não encontrado.', ['&O K']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        strCodVen := edtCodVendedor.Text;
        pDesmarcaLista(edtCodVendedor,arrVendedor);
      End;

    End

    Else If (Sender = edtCodCidade ) Then
    Begin
      pDesmarcaLista(edtCodCidade, arrCidade);

    End

    {************************************}
    {* VALIDA REPRESENTANTE             *}
    {*********************************PZ*}
    Else If (Sender = edtCodRep) Then
    Begin

      If (Not blnRepLib) Then
      Begin
        If (fEmptyStr(edtCodRep.Text)) Then
        Begin
          fMensagem('', 'O Representante deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          strCodRep := fRetCodVendedor(edtCodRep.Text);
          If (fEmptyStr(strCodRep)) And (Not fEmptyStr(edtCodRep.Text)) Then
          Begin
            fMensagem('AVISO','Representante não encontrado.', ['&O K']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        strCodRep := edtCodRep.Text;
        pDesmarcaLista(edtCodRep, arrRepres);
      End;

    End

    {************************************}
    {* VALIDA TIPO                      *}
    {*********************************AF*}
    Else If (Sender = edtTipo) Then
    Begin

      If (edtTipo.Text <> 'A') And (edtTipo.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo tipo deve ser A ou S!',['&O K']);
        Result := False;
      End;

      chkRefUni.Enabled := (edtTipo.Text = 'A');

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);
      If High(arrEmpresa) >= 0 Then
        For IntCorre := 0 To High(arrEmpresa) Do
        Begin
          If Not fEmptyStr(arrEmpresa[intCorre].strCodigo) Then
          Begin
            If (Not blnAcessoTodasAsEmpresas) And
               (Pos(arrEmpresa[intCorre].strCodigo, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
              Result := False;
              Break;
            End;
          End;
        End
      Else
      Begin
        If Not fEmptyStr(edtCodEmpresa.Text) Then
        Begin
          If (Not blnAcessoTodasAsEmpresas) And
             (Pos(edtCodEmpresa.Text, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtFornecedor) then
    Begin
      pDesmarcaLista(edtFornecedor, arrFornec);

    End
    Else If (Sender = edtCodAtividade) Then
    Begin
      pDesmarcaLista(edtCodAtividade, arrAtivid);
      
    End
    Else if (Sender = edtCodRep) Then
    Begin
      pDesmarcaLista(edtCodRep, arrRepres);

    End
    Else if (Sender = mskPlaVei) Then
    Begin

      If fVeiculoInativo(mskPlaVei.Text) Then
      Begin
        edtDesVei.Text := '';
        fMensagem('','Este veículo está inativo.',['&O k']);
        Result := False;
      End
      Else
      Begin
        pDesmarcaLista(mskPlaVei, arrVeic, '', 7);

        If fEmptyStr(mskPlaVei.Text) Then
        Begin
          edtDesVei.Text := 'TODOS';
        End
        Else
        Begin
          If (Not fEmptyStr(mskPlaVei.Text)) And (mskPlaVei.Text <> '0000000') Then
          Begin
            If fValidaPlaca(mskPlaVei.Text) Then
            Begin
              edtDesVei.Text := fRetornaDescricaoVeic(mskPlaVei.Text);

              If fEmptyStr(edtDesVei.Text) Then
              Begin
                Result := False;
                fMensagem('','Nenhum veículo cadastrado com esta placa!',['&Ok']);
              End
            End
            Else
            Begin
              Result := False;
              fMensagem('','Informe uma placa válida!',['&Ok']);
            End;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarcaVei);
    End

    Else If (Sender = edtCodMod) Then
    Begin
      pDesmarcaLista(edtCodMod, arrModelo);
    End

    Else If (Sender = edtCodCor) Then
    Begin
      pDesmarcaLista(edtCodCor, arrCor);
    End

    Else if (Sender = edtCodEmb) And (edtCodEmb.Visible) Then
    Begin
      pDesmarcaLista(edtCodEmb, arrEmbarc, '', 6);

      If (Length(arrEmbarc) = 0) And
         (Not fEmptyStr(edtCodEmb.Text)) And
         (Not fEmptyStr(edtCodCliente.Text)) And (fStrToFloat(edtCodCliente.Text) > 0) And
         (Not fEmbarcacaoVinculadaCliente(edtCodCliente.Text, edtCodEmb.Text)) Then Begin
        fMensagem('','A Embarcação selecionada não está vinculada ao cliente informado!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodFpg) then
    Begin
      pDesmarcaLista(edtCodFpg, arrForPag);

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelFatVendasCliente.fVerificaMetas: Double;
  Var
    strSQL: String;
    qryCadMet: TUniQuery;
    fltTotMet: Double;
begin
  fltTotMet := 0;
  Result    := fltTotMet;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  MET_TOTMET ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET D, ';
    strSQL := strSQL + '  CADOPE O, ';
    strSQL := strSQL + '  CADMET M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  D.DET_PROEMB <> "S"         AND ';
    strSQL := strSQL + '  D.DET_TIP_FC = "C"          AND ';
    strSQL := strSQL + '  D.DET_CODVEN = M.MET_CODVEN AND ';
    strSQL := strSQL + '  D.DET_CODVEN = O.OPE_CODOPE AND ';
    strSQL := strSQL + '  O.OPE_CODOPE = M.MET_CODVEN AND ';
    //strSQL := strSQL + '  D.DET_CODEMP = M.MET_CODEMP AND ';
    strSQL := strSQL + '  D.DET_CODEMP = O.OPE_CODEMP AND ';
    strSQL := strSQL + '  M.MET_TOTMET > 0            AND ';
    strSQL := strSQL + '  M.MET_MESANO = DATE_FORMAT(D.DET_DTAENT,"%m%Y") AND ';
    strSQL := strSQL + '  D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND';
    strSQL := strSQL + '  D.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    if fCfgSis('BRIMVC', varBoolean) then // BRIMVC = 'Ignorar ENTBRF, não considerando brindes'
      strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 '
    else
    begin
      If fCfgSis('ENTBRF', varBoolean) Or (Not blnSomenteVendas) Then
        strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
      Else
        strSQL := strSQL + ') AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';
    end;

    strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'D.DET_CODVEN', 'CODVEN');
    strSQL := strSQL + fStrLocate(edtCodRep     , arrRepres  , 'D.DET_CODREP', 'CODREP');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      fStrLocate(edtCodEmpresa, arrEmpresa, 'D.DET_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(D.DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + '  AND DET_ESPDOC NOT IN ("FF") ';
    strSQL := strSQL + '  AND DET_ESPDOC NOT IN ("TR", "DV") ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + ' O.OPE_CODOPE, M.MET_MESANO ';

    qryCadMet := fCriaQuery;
    With qryCadMet Do
    Begin
      SQL.Text := strSQL;

      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString   := VS_strClaVen;
      ParamByName('CLADEV').AsString   := VS_strClaDev;

      pSetaParam(strCodVen          , arrVendedor, strVendedor, 'CODVEN', qryCadMet);
      pSetaParam(strCodRep          , arrRepres  , strRepres  , 'CODREP', qryCadMet);
      pSetaParam(edtCodEmpresa.Text , arrEmpresa , strEmpresa , 'CODEMP', qryCadMet);

      Open;
      While Not Eof Do
      Begin
        fltTotMet := fltTotMet + FieldByName('MET_TOTMET').AsFloat;
        Next;
      End;

      Result := fltTotMet;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  {*****************}
  {* REDE DE LOJAS *}
  {**************DP*}
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, nil, fRetNomCliente, 'do cliente', 8);

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    If edtCodCliExcluir.CanFocus Then
      pSetFocus(edtCodCliExcluir)
    Else
      If edtCodVendedor.CanFocus Then
        pSetFocus(edtCodVendedor)
      Else
        pSetFocus(edtCodCidade);
  End Else Begin
    edtCodRede.Enabled := True;
    If edtCodCliExcluir.CanFocus Then
      pSetFocus(edtCodCliExcluir)
    Else
      pSetFocus(edtCodRede);
  End;

  pCarregaEndCli(edtCodCliente.Text);
  pSetaConsumidor;

end;

procedure TfrmRelFatVendasCliente.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, chkMovRede.Checked) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtCodCliExcluirExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliExcluir, edtDesCliExcluir, arrClientesExcluir, nil, fRetNomCliente, 'do cliente', 8);

  If fEmptyStr(edtCodCliExcluir.Text) Then
    edtDesCliExcluir.Text := '';  
end;

procedure TfrmRelFatVendasCliente.edtCodCliExcluirKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliExcluir, edtDesCliExcluir, Nil, Key, arrClientesExcluir, chkMovRede.Checked) Then
  Begin
    If fValidaCampos(edtCodCliExcluir, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodCorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCor, edtDescOR, arrCor, fRetDesCorVeic, Nil, 'da Cor', 4);
end;

procedure TfrmRelFatVendasCliente.edtCodCorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCorVeiculo(Self, edtCodCor, edtDesCor, nil, Key, arrCor) Then
  Begin
    If fValidaCampos(edtCodCor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFatVendasCliente.fFiltroClienteConsumidorFiltrandoPorNome: Boolean;
begin
  Result := (Not fEmptyStr(edtCodCliCon.Text)) Or (Not fEmptyStr(edtConNom.Text));
end;

function TfrmRelFatVendasCliente.fExisteClientesFilial(strCodigos: String): Integer;
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;

Begin
  Try

    qryGenDet := fCriaQuery(Self);

    If fEmptyStr(Trim(strCodigos)) Then
      strCodigos := '0';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  COUNT(*) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  DET_CODCLI IN (' + strCodigos + ')';

    strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'DET_CODVEN', 'CODVEN');
    strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'DET_CODCLI', 'CODCLI');
    strSQL := strSQL + fStrLocate(edtCodCliExcluir, arrClientesExcluir, 'DET_CODCLI', 'CLIEXC', False, True);


    With qryGenDet Do
    Begin
      CLose;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      pSetaParam(strCodVen, arrVendedor, strVendedor, 'CODVEN', qryGenDet);
      pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', qryGenDet);
      pSetaParam(edtCodCliExcluir.Text, arrClientesExcluir, strClientesExcluir, 'CLIEXC', qryGenDet);

      Open;

      Result := FieldByName('VALOR').AsInteger;

      Close;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

End;

function TfrmRelFatVendasCliente.fFiltrarVenMtl: Boolean;
begin
  Result := (fCfgSis('VENMTL', varBoolean)) And (edtTipo.Text = 'A');
end;

procedure TfrmRelFatVendasCliente.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
  edtDesProduto.Text := '';
end;

procedure TfrmRelFatVendasCliente.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);

end;

procedure TfrmRelFatVendasCliente.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

End;

procedure TfrmRelFatVendasCliente.mskPlaVeiExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(mskPlaVei, True);
end;

procedure TfrmRelFatVendasCliente.mskPlaVeiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) then
  Begin
    If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVeic, False, False, ' VEI_STATUS = "A" ') Then
    Begin
      If fValidaCampos(mskPlaVei, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelFatVendasCliente.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos, edtDesProduto, arrCadIte, Nil, fRetNomProduto, 'do Produto', fTamCodIte);

end;

procedure TfrmRelFatVendasCliente.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrCadIte, False, nil, 'Consulta de Itens', '1') Then
    Self.SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelFatVendasCliente.edtTintasDispKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    edtTintasDisp.Text := String(fEscolheTinta());

    If fValidaCampos(edtTintasDisp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, Not blnAcessoTodasAsEmpresas) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmRelFatVendasCliente.edtCodFaseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFase,edtDesFase,arrFase,nil,fRetNomFaseObra,'da fase da obra');
end;

procedure TfrmRelFatVendasCliente.edtCodFaseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFaseObra(Self, edtCodFase, edtDesFase, Nil, Key, arrFase, False) Then
  Begin
    If fValidaCampos(edtCodFase, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodFpgExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFpg, edtDesFpg, arrForPag, Nil, fRetDescFpg, 'da Forma de Pagamento', 3);
end;

procedure TfrmRelFatVendasCliente.edtCodFpgKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************JZ*}
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, arrForPag) Then
  Begin
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarcaVei, fRetDesMarcaVeic, Nil, 'da Marca', 4);
end;

procedure TfrmRelFatVendasCliente.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*************************************}
  {* NOVA CONSULTA DE MODELO (VEÍCULO) *}
  {**********************************MM*}
  If fPesqMarcaVeiculo(Self, edtCodMar, edtDesMar, nil, Key, arrMarcaVei) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodModExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMod, edtDesMod, arrModelo, fRetDesModeloVeic, Nil, 'do Modelo', 4);
end;

procedure TfrmRelFatVendasCliente.edtCodModKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*************************************}
  {* NOVA CONSULTA DE MODELO (VEÍCULO) *}
  {**********************************MM*}
  If fPesqModeloVeiculo(Self, edtCodMod, edtDesMod, nil, Key, arrModelo, True, edtCodMar.Text) Then
  Begin
    If fValidaCampos(edtCodMod, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatVendasCliente.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg,edtNomReg,arrRegiao,fRetDesReg, nil, 'da Região');
end;

procedure TfrmRelFatVendasCliente.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, arrRegiao, False) Then
  Begin
    If fValidaCampos(edtCodReg, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodRepExit(Sender: TObject);
begin
  inherited;
  If Not (blnRepLib) Then
  Begin
    strCodRep      := fRetCodVendedor(edtCodRep.Text);
    edtNomRep.Text := fRetNomVendRep(strCodRep);
    
    If fEmptyStr(edtNomRep.Text)   Then
    Begin
      fMensagem('AVISO','Código do representante não encontrado.', ['&O K']);
      edtCodRep.Clear;
      pSetFocus(edtCodRep);
    End;

  End
  Else
  Begin
    strCodRep := edtCodRep.Text;
    pEdtCodSelectExit(edtCodRep, edtNomRep, arrRepres, fRetNomVendRep, Nil, 'do representante', 3);
  End;
  
end;

procedure TfrmRelFatVendasCliente.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnRepLib) And (fPesqOperador(Self, edtCodRep, edtNomRep, nil, Key, arrRepres, Not blnRepLib)) Then
  Begin
    If fValidaCampos(edtCodRep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, nil, 'da empresa', 3);

end;

procedure TfrmRelFatVendasCliente.edtCodCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCidade, edtDesCidade, Nil, Nil, Key, arrCidade, False) Then
  Begin
    If fValidaCampos(edtCodCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.chkSomDevClick(Sender: TObject);
  Var
    intComp: Integer;
Begin
  inherited;

  For intComp := 0 To gpbExiSom.ControlCount -1 Do
  Begin
    If gpbExiSom.Controls[intComp].Name <> TCheckBox(Sender).Name Then
    Begin
      TCheckBox(gpbExiSom.Controls[intComp]).OnClick := Nil;
      TCheckBox(gpbExiSom.Controls[intComp]).Checked := False;
      TCheckBox(gpbExiSom.Controls[intComp]).OnClick := chkSomDevClick;
    End;
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodAtividadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAtividade,edtDesAtividade, arrAtivid, nil, fRetNomAtividade, 'da atividade', 3);
  
end;

procedure TfrmRelFatVendasCliente.edtCodAtividadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAtividade, edtDesAtividade, Nil, Key, arrAtivid, False) Then
  Begin
    If fValidaCampos(edtCodAtividade, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtCodCidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCidade, edtDesCidade, arrCidade, fRetNomCidadeSemOpc, nil, 'da cidade', 5);

end;

procedure TfrmRelFatVendasCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If ActiveControl Is TRadioButton Then
    Self.SelectNext(ActiveControl, True, True)
  Else
    inherited;
end;

procedure TfrmRelFatVendasCliente.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca, arrMarca, fRetNomMarca, nil, 'da Marca', 6);
end;

procedure TfrmRelFatVendasCliente.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVendasCliente.edtFornecedorExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrFornec, fRetNomFornecedor, nil, 'do fornecedor', 8);
  
end;

procedure TfrmRelFatVendasCliente.edtDestinoExit(Sender: TObject);
begin
//  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If Pos(edtDestino.Text, 'V_I_E_') <= 0 Then
  Begin
    pSetFocus(edtDestino);
  End;

end;

procedure TfrmRelFatVendasCliente.pCabecExcel(objExcel: TExcel);
  Var
    intColuna: Integer;
Begin
  With objExcel Do
  Begin
    LinhaAtual := 01;
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    Escrever(ProximaLinha, 01, fRetTituloRel(edtTipo.Text));

    ProximaLinha;

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text + IfThen(fEmptyStr(edtEspDoc.Text), '', ' - ' + edtEspDoc.Text));

    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCliente.Text  , edtDesCliente   , arrClientes,  strClientes , 'CLIENTE'));

    If fEmptyStr(edtCodCliExcluir.Text) Then
      Escrever(ProximaLinha, 01, 'CLIENTE A EXCLUIR: NENHUM ')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodCliExcluir.Text, edtDesCliExcluir, arrClientesExcluir,  strClientesExcluir , 'CLIENTE A EXCLUIR'));

    Escrever(ProximaLinha, 01, fStrTitulo(strCodVen           , edtDesVendedor  , arrVendedor,  strVendedor , 'VENDEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text  , edtDesEmpresa   , arrEmpresa ,  strEmpresa  , 'EMPRESA', True));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCidade.Text   , edtDesCidade    , arrCidade  ,  strCidade   , 'CIDADE', True));
    Escrever(ProximaLinha, 01, fStrTitulo(edtFornecedor.Text  , edtDesFornecedor, arrFornec  ,  strFornec   , 'FORNECEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodAtividade.Text, edtDesAtividade , arrAtivid  ,  strAtivid   , 'ATIVIDADE', True));
    Escrever(ProximaLinha, 01, fStrTitulo(strCodRep           , edtNomRep       , arrRepres  ,  strRepres   , 'REPRESENTANTE'));

    If fCfgSis('FASOBR') = 'S' Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodFase.Text   , edtDesFase      , arrFase    ,  strFase     , 'FASE DA OBRA', True));

    If (fCfgSis('EVEFAT', varBoolean)) Then
      Escrever(ProximaLinha, 01, fStrTitulo(fraCentroCusto.edtCodEve.Text, fraCentroCusto.edtDesEve, arrEvento,  strEvento, 'EVENTO', True));

    If (edtCodEmb.Visible) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmb.Text    , edtNomEmb, fGetArrEmbarcCodEmb, fGetStrEmbarc, 'EMBARCAÇÃO'));

    Escrever(ProximaLinha, 01, fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinGru,strLinGru,'LINHA/GRUPO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strMarca,'MARCA',True));
    Escrever(ProximaLinha, 01, 'TINTAS: '+IfThen(not fEmptyStr(edtTintasDisp.Text),(edtTintasDisp.Text+' - '+edtDesTinta.Text),'TODAS'));
    Escrever(ProximaLinha, 01, LeftStr(fStrTitulo(edtProdutos.Text,edtDesProduto,arrCadIte,strCadIte,'PRODUTO'),255));
    Escrever(ProximaLinha, 01, 'DESCR. PRODU.: '+IfThen(not fEmptyStr(edtDescri.Text),edtDescri.Text,'TODAS'));
    Escrever(ProximaLinha, 01, 'REFER. PRODU.: '+IfThen(not fEmptyStr(edtRefere.Text),edtRefere.Text,'TODAS'));
    Escrever(ProximaLinha, 01, 'ESPEC. DOCUM.: '+IfThen(not fEmptyStr(edtEspDoc.Text),edtEspDoc.Text,'TODAS'));
    Escrever(ProximaLinha, 01, IfThen(not fEmptyStr(edtCodCliCon.Text),fStrTitulo(edtCodCliCon.Text, edtNomCliCon, arrConsumidor, strConsumidor,'CONSUMIDOR'),''));
    Escrever(ProximaLinha, 01, IfThen(not fEmptyStr(edtConNom.Text), 'CONSUMIDOR (NOME): ' + edtConNom.Text, ''));
    Escrever(ProximaLinha, 01, fStrTitulo(mskPlaVei.Text      , edtDesVei       , arrVeic    ,  strVeic     , 'VEÍCULO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodMar.Text, edtDesMar, arrMarcaVei, strMarcaVei, 'MARCA (VEÍCULO)'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodMod.Text, edtDesMod, arrModelo, strModelo, 'MODELO/ANO') + ' / ' +
                               IfThen(fEmptyStr(edtAno.Text), 'TODOS', edtAno.Text));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCor.Text, edtDesCor, arrCor, strCor, 'COR'));
    If Not(blnSomenteVendas) Then
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodClafis.Text,edtDesClaFis,arrClasFiscal,strClaFiscal,'CLASSIFICAÇÃO FISCAL'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodReg.Text,edtNomReg,arrRegiao,strRegiao,'REGIÃO',True));


    ProximaLinha;

    intColuna := 1;
    If edtTipo.Text = 'A' Then
    Begin
      Escrever(LinhaAtual, intColuna, 'DATA');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'N.DOC.');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'EMP.');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'CFOP');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'CÓDIGO');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'DESCRIÇÃO DO ITEM');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'REFERÊNCIA');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'UNIDADE');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'MARCA');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'QUANTIDADE');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'VR. UNITÁRIO');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'VR. TOTAL');

      If edtMargem.Text = 'S' Then
      Begin
        inc(intColuna);
        Escrever(LinhaAtual, intColuna, 'CUSTO');
        inc(intColuna);
        Escrever(LinhaAtual, intColuna, '% MARGEM');
      End;

      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'TOTAL C/ IPI');

    End
    Else
    Begin

      Escrever(LinhaAtual, intColuna, 'DATA');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'N.DOC.');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'EMP.');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'VEN');

      If rdgOrdem.ItemIndex = 1 Then
      Begin
        inc(intColuna);
        Escrever(LinhaAtual, intColuna, 'CLIENTE');
      End;

      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'COND. PAGAMENTO');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'CFOP');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'DESC.ESP.');
      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'VR.LIQ.');

      If edtMargem.Text = 'S' Then
      Begin
        inc(intColuna);
        Escrever(LinhaAtual, intColuna, 'CUSTO');
        inc(intColuna);
        Escrever(LinhaAtual, intColuna, '% MARGEM');
      End;

      inc(intColuna);
      Escrever(LinhaAtual, intColuna, 'TOTAL C/ IPI');

    End;
  End;
End;

procedure TfrmRelFatVendasCliente.pFormataExcel(objExcel: TExcel);
  Var
    strLetra: Char;
    intIdx,
    intLinFil,
    intLinTit: Integer;
Begin
  If edtTipo.Text = 'A' Then
  Begin
    If edtMargem.Text = 'S' Then
      strLetra := 'O'
    Else
      strLetra := 'M';
  End Else
  Begin
    If edtMargem.Text = 'S' Then
    Begin
      If rdgOrdem.ItemIndex = 0 Then
        strLetra := 'K'
      Else
        strLetra := 'L'
    End Else
    Begin
      If rdgOrdem.ItemIndex = 0 Then
        strLetra := 'I'
      Else
        strLetra := 'J';
    End;
  End;

  intLinTit := objExcel.LinhaAtual;
  intLinFil := intLinTit-1;

  With objExcel Do
  Begin
    {********************************}
    {* MESCLA AS COLUNAS            *}
    {*****************************LA*}
    For intIdx := 1 To intLinFil Do
      Mesclar('A' + IntToStr(intIdx), strLetra + IntToStr(intIdx));

    {**************************************************}
    {* COLOCA EM NEGRITO E ALINHA AO CENTRO DA CELULA *}
    {***********************************************LA*}
    Alinhamento('A1',strLetra + IntToStr(intLinFil), Centro);
    Negrito('A1', strLetra + IntToStr(intLinFil), True);

    {*************************************}
    {* COLORE O FUNDO DA CELULA P/ CINZA *}
    {**********************************LA*}
    CorFundo('A2',strLetra + '3', Amarelo);
    CorFonte('A2',strLetra + '3', Preto);
    CorFundo('A' + IntToStr(intLinTit), strLetra + IntToStr(intLinTit), Preto);
    CorFonte('A' + IntToStr(intLinTit), strLetra + IntToStr(intLinTit), Branco);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************LA*}
    Bordas('A2',strLetra + '3');
    Bordas('A5',strLetra +  IntToStr(intLinFil));

  End;

End;

function TfrmRelFatVendasCliente.fGeraExcelSintetico(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objExcel: TExcel;
    intCol: Integer;

    fltTotLiq,
    fltTotMkp,
    fltTotCus,
    fltTotGer,
    fltTotDes: Double;

    fltTotMkpCli,
    fltTotLiqCli,
    fltTotCusCli,
    fltTotGerCli,
    fltTotDesCli: Double;

    fltTotDesGer,
    fltTotDocGer: Double;

    strCliAnt,
    strLetTmp: String;
    Cor: TCorExcel;

    Procedure pImprimeTotalCliente;
    Begin
      With cdsRelVenCli Do
      If ((strCliAnt <> FieldByName('CODCLI').AsString) Or Eof) And (rdgOrdem.ItemIndex = 0) Then
      Begin

        intCol := 8;

        If rdgOrdem.ItemIndex = 1 Then
         inc(intCol);

        With objExcel Do
        Begin
          Escrever(LinhaAtual, intCol, FloatToStrF(fltTotLiqCli, ffFixed, 12, 2));

          If edtMargem.Text = 'S' Then
          Begin
            inc(intCol);
            Escrever(LinhaAtual, intCol, FloatToStrF(fltTotCusCli, ffFixed, 12, 2));

            inc(intCol);
            If fCfgSis('MARMKP') = '4' Then
              Escrever(LinhaAtual, intCol, FloatToStrF(
                 fCalculaPrecoVenda(2,fltTotCusCli,fltTotMkpCli - IIF(blnVeioTelaVendas, fltTotDesCli, 0),0,0,0,0,0), ffFixed, 12, 2))
            Else
              Escrever(LinhaAtual, intCol, FloatToStrF(
                 fCalculaPrecoVenda(2,fltTotCusCli,fltTotLiqCli - IIF(blnVeioTelaVendas, fltTotDesCli, 0),0,0,0,0,0), ffFixed, 12, 2));

          End;

          inc(intCol);
          Escrever(LinhaAtual, intCol, FloatToStrF(fltTotGerCli, ffFixed, 12, 2));


          Escrever(LinhaAtual, 7, 'TOTAL DO CLIENTE');
          Mesclar('A' + IntToStr(LinhaAtual),  'G' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), Verde_Mar);
          CorFonte('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), Branco);

          ProximaLinha;
        End;

      End;
    End;

Begin
  Result := False;

  objExcel := TExcel.fCriarExcel(Self);
  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  pCabecExcel(objExcel);
  pFormataExcel(objExcel);

  fltTotLiq := 0;
  fltTotMkp := 0;
  fltTotCus := 0;
  fltTotGer := 0;
  fltTotDes := 0;

  fltTotDesGer := 0;
  fltTotDocGer := 0;

  strCliAnt := '';

  With objExcel Do
  Begin
    With cdsRelVenCli Do
    Begin
      pgbProgresso.Visible  := True;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        If (strCliAnt <> FieldByName('CODCLI').AsString) And (rdgOrdem.ItemIndex = 0) Then
        Begin
          fltTotLiqCli := 0;
          fltTotMkpCli := 0;
          fltTotCusCli := 0;
          fltTotGerCli := 0;
          fltTotDesCli := 0;

          If Not fEmptyStr(strCliAnt) Then
            ProximaLinha;

          Mesclar('A' + IntToStr(LinhaAtual), IfThen(edtMargem.Text = 'S', 'J', 'H') + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 1, 'CLIENTE: ' + FieldByName('CODCLI').AsString + '-' +
                                                FieldByName('NOMCLI').AsString +
                                                IIF(Not fEmptyStr(FieldByName('FONE01').AsString), '  TELEFONE: ' + fFormataFone(FieldByName('FONE01').AsString), '') +
                                                IIF(Not fEmptyStr(FieldByName('NOMCID').AsString), '  CIDADE: ' + FieldByName('NOMCID').AsString + '-' + FieldByName('ESTADO').AsString + '  ', '') +
                                                fGetCgcCli(cdsRelVenCli));
          ProximaLinha;

          strCliAnt := FieldByName('CODCLI').AsString;
        End;

        intCol := 1;
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime)));

        inc(intCol);
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('NUMDOC').AsString));
        inc(intCol);
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CODEMP').AsString));
        inc(intCol);
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CODVEN').AsString));

        If rdgOrdem.ItemIndex = 1 Then
        Begin
          inc(intCol);
          Escrever(LinhaAtual, intCol, FieldByName('CODCLI').AsString + '-' +
                                       FieldByName('NOMCLI').AsString + ' - ' +
                                       fGetCgcCli(cdsRelVenCli));
        End;

        inc(intCol);
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CONPAG').AsString));
        inc(intCol);
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CLAFIS').AsString));
        inc(intCol);
        Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('DESESP').AsFloat, ffFixed, 12, 2));
        inc(intCol);
        Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTITE').AsFloat, ffFixed, 12, 2));

        If edtMargem.Text = 'S' Then
        Begin
          inc(intCol);
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTCUS').AsFloat, ffFixed, 12, 2));
          inc(intCol);

          If fCfgSis('MARMKP') = '4' Then
            Escrever(LinhaAtual, intCol, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                     FieldByName('MAMKP4').AsFloat, 0,0,0,0,0), ffFixed, 12, 2))
          Else
            Escrever(LinhaAtual, intCol, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                     FieldByName('TOTITE').AsFloat, 0,0,0,0,0), ffFixed, 12, 2));
        End;

        inc(intCol);
        Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTDOC').AsFloat, ffFixed, 12, 2));

        If (RecNo Mod 2 = 0) Then
          Cor := Cinza
        Else
          Cor := Branco;

        CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intCol) + IntToStr(LinhaAtual), Cor);

        ProximaLinha;

        fltTotLiq := fltTotLiq + FieldByName('TOTITE').AsFloat;
        fltTotMkp := fltTotMkp + FieldByName('MAMKP4').AsFloat;
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
        fltTotGer := fltTotGer + FieldByName('TOTITE').AsFloat;
        fltTotDes := fltTotDes + FieldByName('DESESP').AsFloat;

        fltTotLiqCli := fltTotLiqCli + FieldByName('TOTITE').AsFloat;
        fltTotMkpCli := fltTotMkpCli + FieldByName('MAMKP4').AsFloat;
        fltTotCusCli := fltTotCusCli + FieldByName('TOTCUS').AsFloat;
        fltTotGerCli := fltTotGerCli + FieldByName('TOTITE').AsFloat;
        fltTotDesCli := fltTotDesCli + FieldByName('DESESP').AsFloat;

        fltTotDesGer := fltTotDesGer + FieldByName('DESESP').AsFloat;
        fltTotDocGer := fltTotDocGer + FieldByName('TOTDOC').AsFloat;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        Next;

        pImprimeTotalCliente;
      End;

      Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 8, 9), FloatToStrF(fltTotDesGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 6, 'TOTAL GERAL DESCONTO ESPECIAL');
      Mesclar('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0,  'G', 'H') + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Azul);
      CorFonte('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Branco);

      ProximaLinha;
      Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 8, 9), FloatToStrF(fltTotGer+fltTotDesGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 6, 'TOTAL GERAL DOS PRODUTOS');
      Mesclar('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0,  'G', 'H') + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Branco);

      ProximaLinha;

      Escrever(LinhaAtual, IfThen(edtMargem.Text = 'S', IfThen(rdgOrdem.ItemIndex = 0, 11, 12), IfThen(rdgOrdem.ItemIndex = 0, 8, 9)), FloatToStrF(fltTotDocGer, ffFixed, 12, 2));

      If edtMargem.Text = 'S' Then
      Begin
        Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 9, 10), FloatToStrF(fltTotCus, ffFixed, 12, 2));

        If fCfgSis('MARMKP') = '4' Then
          Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 10, 11), FloatToStrF(
                                       fCalculaPrecoVenda(2,fltTotCus,fltTotMkp - IIF(blnVeioTelaVendas, fltTotDes, 0),0,0,0,0,0), ffFixed, 12, 2))
        Else
          Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 10, 11), FloatToStrF(
                                       fCalculaPrecoVenda(2,fltTotCus,fltTotLiq - IIF(blnVeioTelaVendas, fltTotDes, 0),0,0,0,0,0), ffFixed, 12, 2));
      End;
      Escrever(LinhaAtual, IfThen(rdgOrdem.ItemIndex = 0, 8, 9), FloatToStrF(fltTotGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 7, 'TOTAL GERAL DOS DOCUMENTOS');
      Mesclar('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0,  'G', 'H') + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), IfThen(rdgOrdem.ItemIndex = 0, 'G', 'H') + IntToStr(LinhaAtual), Branco);

    End;

    If Not (fEmptyStr(strMsgConf)) Then
    Begin
      ProximaLinha;
      Escrever(LinhaAtual, 1, strMsgConf);

      If (rdgOrdem.ItemIndex = 0) Then
      Begin
        If SameText(edtMargem.Text, 'S') Then
          strLetTmp := 'K'
        Else
          strLetTmp := 'J';
      End
      Else
      Begin
        If SameText(edtMargem.Text, 'S') Then
          strLetTmp := 'L'
        Else
          strLetTmp := 'M';
      End;

      Mesclar('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual), CinzaEscuro);
      CorFonte('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual), Preto);
    End;

    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    pgbProgresso.Visible  := False;
    pgbProgresso.Position := 0;

    Result := True;
  End;
  FreeAndNil(objExcel);
End;

function TfrmRelFatVendasCliente.fGeraExcelAnalitico(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objExcel: TExcel;
    intCol: Integer;

    fltTotQtd,
    fltTotLiq,
    fltTotMkp,
    fltTotCus,
    fltTotGer,
    fltTotDes: Double;

    fltTotQtdCli,
    fltTotLiqCli,
    fltTotMkpCli,
    fltTotCusCli,
    fltTotGerCli,
    fltTotDesCli: Double;

    fltTotQtdDoc,
    fltTotLiqDoc,
    fltTotMkpDoc,
    fltTotCusDoc,
    fltTotGerDoc,
    fltTotDesDoc: Double;

    fltTotDesGer,
    fltTotDocGer: Double;

    strCliAnt: String;
    strDocAnt: String;
    strLetTmp: String;
    Cor: TCorExcel;

    Procedure pImprimeTotalDocumento;
    Begin
      With objExcel Do
      Begin
        With cdsRelVenCli Do
        If ((strDocAnt <> FieldByName('NUMDOC').AsString) Or Eof) Then
        Begin
          strDocAnt := FieldByName('NUMDOC').AsString;

          If fltTotDesDoc > 0 Then
          Begin
            Escrever(LinhaAtual, 7, 'DESCONTO ESPECIAL');
            Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
            CorFundo('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Azul);
            CorFonte('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Branco);
            Escrever(LinhaAtual, 13, FloatToStrF(fltTotDesDoc, ffFixed, 12, 2));
            ProximaLinha;
          End;

          Escrever(LinhaAtual, 12, FloatToStrF(fltTotLiqDoc, ffFixed, 12, 2));

          If edtMargem.Text = 'S' Then
          Begin
            Escrever(LinhaAtual, 13, FloatToStrF(fltTotCusDoc, ffFixed, 12, 2));

            If fCfgSis('MARMKP') = '4' Then
              Escrever(LinhaAtual, 14, FloatToStrF(
                                           fCalculaPrecoVenda(2,fltTotCusDoc, fltTotMkpDoc - IIF(blnVeioTelaVendas, fltTotDesDoc, 0),0,0,0,0,0), ffFixed, 12, 2))
            Else
              Escrever(LinhaAtual, 14, FloatToStrF(
                                           fCalculaPrecoVenda(2,fltTotCusDoc, fltTotLiqDoc - IIF(blnVeioTelaVendas, fltTotDesDoc, 0),0,0,0,0,0), ffFixed, 12, 2));
          End;

          Escrever(LinhaAtual, IfThen(edtMargem.Text = 'S', 15, 13), FloatToStrF(fltTotGerDoc, ffFixed, 12, 2));

          Escrever(LinhaAtual, 7, 'TOTAL DO DOCUMENTO    '+FieldByName('PLAKMS').AsString);
          Mesclar('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Preto);
          CorFonte('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Branco);

          ProximaLinha;
          ProximaLinha;

          fltTotQtdDoc := 0;
          fltTotLiqDoc := 0;
          fltTotMkpDoc := 0;
          fltTotCusDoc := 0;
          fltTotGerDoc := 0;
          fltTotDesDoc := 0;

        End;
      End;
    End;

    Procedure pImprimeTotalCliente;
    Begin
      With objExcel Do
      Begin
        With cdsRelVenCli Do
        If ((strCliAnt <> FieldByName('CODCLI').AsString) Or Eof) And (rdgOrdem.ItemIndex = 0) Then
        Begin

          Escrever(LinhaAtual, 10, FloatToStrF(fltTotQtdCli, ffFixed, 12, 2));
          Escrever(LinhaAtual, 12, FloatToStrF(fltTotLiqCli, ffFixed, 12, 2));

          If edtMargem.Text = 'S' Then
          Begin
            Escrever(LinhaAtual, 13, FloatToStrF(fltTotCusCli, ffFixed, 12, 2));
            If fCfgSis('MARMKP') = '4' Then
              Escrever(LinhaAtual, 14, FloatToStrF(fCalculaPrecoVenda(2,fltTotCusCli,fltTotMkpCli - IIF(blnVeioTelaVendas, fltTotDesCli, 0),0,0,0,0,0), ffFixed, 12, 2))
            Else
              Escrever(LinhaAtual, 14, FloatToStrF(fCalculaPrecoVenda(2,fltTotCusCli,fltTotLiqCli - IIF(blnVeioTelaVendas, fltTotDesCli, 0),0,0,0,0,0), ffFixed, 12, 2));
          End;

          Escrever(LinhaAtual, IfThen(edtMargem.Text = 'S', 15, 13), FloatToStrF(fltTotGerCli, ffFixed, 12, 2));

          Escrever(LinhaAtual, 7, 'TOTAL DO CLIENTE');
          Mesclar('A' + IntToStr(LinhaAtual),  'I' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Verde_Mar);
          CorFonte('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);

          ProximaLinha;

        End;
      End;
    End;

    function fLinhaComServico(blnGeraColEmBranco: Boolean=True):Boolean;
    begin
      Result := (cdsRelVenCli.FindField('CODSER') <> NIL) And
                (Not fEmptyStr(cdsRelVenCli.FindField('CODSER').AsString)) And
                (cdsRelVenCli.FindField('ESPDOC').AsString = 'NS');
    end;

Begin
  Result := False;

  objExcel := TExcel.fCriarExcel(Self);
  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  pCabecExcel(objExcel);
  pFormataExcel(objExcel);

  fltTotQtd := 0;
  fltTotLiq := 0;
  fltTotMkp := 0;
  fltTotCus := 0;
  fltTotGer := 0;
  fltTotDes := 0;

  fltTotQtdDoc := 0;
  fltTotLiqDoc := 0;
  fltTotMkpDoc := 0;
  fltTotCusDoc := 0;
  fltTotGerDoc := 0;
  fltTotDesDoc := 0;

  fltTotDesGer := 0;
  fltTotDocGer := 0;

  strCliAnt := '';
  strDocAnt := '';

  With objExcel Do
  Begin
    With cdsRelVenCli Do
    Begin
      pgbProgresso.Visible  := True;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        If (strCliAnt <> FieldByName('CODCLI').AsString) Then
        Begin
          fltTotQtdCli := 0;
          fltTotLiqCli := 0;
          fltTotMkpCli := 0;
          fltTotCusCli := 0;
          fltTotGerCli := 0;
          fltTotDesCli := 0;

          If Not fEmptyStr(strCliAnt) Then
            ProximaLinha;

          Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 1, 'CLIENTE: ' + FieldByName('CODCLI').AsString + '-' +
                                                FieldByName('NOMCLI').AsString +
                                                IIF(Not fEmptyStr(FieldByName('FONE01').AsString), '  TELEFONE: ' + fFormataFone(FieldByName('FONE01').AsString), '') +
                                                IIF(Not fEmptyStr(FieldByName('NOMCID').AsString), '  CIDADE: ' + FieldByName('NOMCID').AsString + '-' + FieldByName('ESTADO').AsString + '  ', '') +
                                                fGetCgcCli(cdsRelVenCli));
          ProximaLinha;

          strCliAnt := FieldByName('CODCLI').AsString;
          strDocAnt := FieldByName('NUMDOC').AsString;
        End;

        intCol := 1;
        Escrever(LinhaAtual, intCol, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime)));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('NUMDOC').AsString));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CODEMP').AsString));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CLAFIS').AsString));
        inc(intCol);
        If Not fLinhaComServico Then
          Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CODITE').AsString))
        Else
          Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('CODSER').AsString));
        inc(intCol);

        If Not fLinhaComServico Then
          Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('DESCRI').AsString))
        Else
          Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('DESSER').AsString));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('REFERE').AsString));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('UNIDAD').AsString));
        inc(intCol);

        Escrever(LinhaAtual, intCol, fFrtStrExcel(FieldByName('DESMAR').AsString));
        inc(intCol);

        If Not fLinhaComServico Then
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2))
        Else
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('QTDSER').AsFloat, ffFixed, 12, 2));
        inc(intCol);

        If Not fLinhaComServico Then
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('UNITAR').AsFloat, ffFixed, 12, 2))
        Else
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('UNISER').AsFloat, ffFixed, 12, 2));
        inc(intCol);

        If Not fLinhaComServico Then
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTITE').AsFloat, ffFixed, 12, 2))
        Else
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('VALSER').AsFloat, ffFixed, 12, 2));

        If edtMargem.Text = 'S' Then
        Begin
          inc(intCol);
          Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTCUS').AsFloat, ffFixed, 12, 2));

          inc(intCol);
          If fCfgSis('MARMKP') = '4' Then
            Escrever(LinhaAtual, intCol, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                     FieldByName('MAMKP4').AsFloat, 0,0,0,0,0), ffFixed, 12, 2))
          Else
            Escrever(LinhaAtual, intCol, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                     FieldByName('TOTITE').AsFloat, 0,0,0,0,0), ffFixed, 12, 2));
        End;

        inc(intCol);
        Escrever(LinhaAtual, intCol, FloatToStrF(FieldByName('TOTDOC').AsFloat, ffFixed, 12, 2));

        If (RecNo Mod 2 = 0) Then
          Cor := Cinza
        Else
          Cor := Branco;

        CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intCol) + IntToStr(LinhaAtual), Cor);

        ProximaLinha;

        fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;
        fltTotLiq := fltTotLiq + FieldByName('TOTITE').AsFloat;
        fltTotMkp := fltTotMkp + FieldByName('MAMKP4').AsFloat;
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
        fltTotGer := fltTotGer + FieldByName('TOTITE').AsFloat;
        fltTotDes := fltTotDes + FieldByName('DESESP').AsFloat;

        fltTotQtdCli := fltTotQtdCli + FieldByName('QTDITE').AsFloat;
        fltTotLiqCli := fltTotLiqCli + FieldByName('TOTITE').AsFloat;
        fltTotMkpCli := fltTotMkpCli + FieldByName('MAMKP4').AsFloat;
        fltTotCusCli := fltTotCusCli + FieldByName('TOTCUS').AsFloat;
        fltTotGerCli := fltTotGerCli + FieldByName('TOTITE').AsFloat;
        fltTotDesCli := fltTotDesCli + FieldByName('DESESP').AsFloat;

        fltTotQtdDoc := fltTotQtdDoc + FieldByName('QTDITE').AsFloat;
        fltTotLiqDoc := fltTotLiqDoc + FieldByName('TOTITE').AsFloat;
        fltTotMkpDoc := fltTotMkpDoc + FieldByName('MAMKP4').AsFloat;
        fltTotCusDoc := fltTotCusDoc + FieldByName('TOTCUS').AsFloat;
        fltTotGerDoc := fltTotGerDoc + FieldByName('TOTITE').AsFloat;
        fltTotDesDoc := fltTotDesDoc + FieldByName('DESESP').AsFloat;

        fltTotDesGer := fltTotDesGer + FieldByName('DESESP').AsFloat;
        fltTotDocGer := fltTotDocGer + FieldByName('TOTDOC').AsFloat;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        Next;

        pImprimeTotalDocumento;
        pImprimeTotalCliente;
      End;

      Escrever(LinhaAtual, 12, FloatToStrF(fltTotDesGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 7, 'TOTAL GERAL DESCONTO ESPECIAL');
      Mesclar('A' + IntToStr(LinhaAtual),  'I' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Azul);
      CorFonte('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);

      ProximaLinha;
      Escrever(LinhaAtual, 12, FloatToStrF(fltTotGer+fltTotDesGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 7, 'TOTAL GERAL DOS PRODUTOS');
      Mesclar('A' + IntToStr(LinhaAtual),  'I' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);

      ProximaLinha;
      Escrever(LinhaAtual, 10, FloatToStrF(fltTotQtd, ffFixed, 12, 2));
      Escrever(LinhaAtual, 12, FloatToStrF(fltTotGer, ffFixed, 12, 2));

      If edtMargem.Text = 'S' Then
      Begin
        Escrever(LinhaAtual, 13, FloatToStrF(fltTotCus, ffFixed, 12, 2));
        If fCfgSis('MARMKP') = '4' Then
          Escrever(LinhaAtual, 14, FloatToStrF(
                   fCalculaPrecoVenda(2,fltTotCus,fltTotMkp - IIF(blnVeioTelaVendas, fltTotDes, 0),0,0,0,0,0), ffFixed, 12, 2))
        Else
          Escrever(LinhaAtual, 14, FloatToStrF(
                   fCalculaPrecoVenda(2,fltTotCus,fltTotLiq - IIF(blnVeioTelaVendas, fltTotDes, 0),0,0,0,0,0), ffFixed, 12, 2));
      End;

      Escrever(LinhaAtual, IfThen(edtMargem.Text = 'S', 15, 13), FloatToStrF(fltTotDocGer, ffFixed, 12, 2));
      Escrever(LinhaAtual, 7, 'TOTAL GERAL DOS DOCUMENTOS');
      Mesclar('A' + IntToStr(LinhaAtual),  'I' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);

    End;

    If Not (fEmptyStr(strMsgConf)) Then
    Begin
      ProximaLinha;
      Escrever(LinhaAtual, 1, strMsgConf);

      If SameText(edtMargem.Text, 'S') Then
        strLetTmp := 'M'
      Else
        strLetTmp := 'N';

      Mesclar('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual), CinzaEscuro);
      CorFonte('A' + IntToStr(LinhaAtual), strLetTmp + IntToStr(LinhaAtual), Preto);
    End;

    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    pgbProgresso.Visible  := False;
    pgbProgresso.Position := 0;

    Result := True;
  End;
  FreeAndNil(objExcel);
End;

procedure TfrmRelFatVendasCliente.edtCodClaFisExit(Sender: TObject);
begin
  inherited;
    pEdtCodSelectExit(edtCodClaFis, edtDesClaFis, arrClasFiscal, fRetNatOpe, Nil, 'da Classificação Fiscal');
end;

procedure TfrmRelFatVendasCliente.edtCodClaFisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCFOP(Self, edtCodClaFis, edtDesClaFis, Nil, Key, arrClasFiscal, False) Then
  Begin
    If fValidaCampos(edtCodClaFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatVendasCliente.edtCodCliConExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliCon, edtNomCliCon, arrConsumidor, fRetNomClienteConsumidor, nil, 'do consumidor', 18);

end;

procedure TfrmRelFatVendasCliente.edtCodCliConKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConsum : TUniQuery;
begin
  If edtCodCliCon.ReadOnly Then
    Exit;

  inherited;

  Try

    qryConsum := fCriaQuery(Nil);

    If fPesqConsumidores(Self, nil, nil, nil, nil, qryConsum, Key, arrConsumidor, '', True) Then
    Begin
      edtCodCliCon.Text := qryConsum.FieldByName('CON_C_P_F_').AsString;
      If fValidaCampos(edtCodCliCon, True) Then
        SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(qryConsum);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmRelFatVendasCliente.edtCodCliConKeyPress]');
    End;
  End;

end;

procedure TfrmRelFatVendasCliente.pMostraDadosAutCen;
begin
  If fCfgSis('AUTCEN', varBoolean) Then
  Begin
    pnlAutPas.Visible := True;
  End
  Else
  Begin
    pnlAutPas.Visible := False;
    pAjustarPosicaoComponentes(pnlAutPas);
  End;
end;

procedure TfrmRelFatVendasCliente.pMostraMovimentoRedeLojas;
begin
  If (blnFaturamento) And
     (Not fEmptyStr(strCodRedeLojasCliente)) Then
  Begin
    chkMovRede.Visible := True;
  End
  Else
  Begin
    chkMovRede.Visible := False;
    pAjustarPosicaoComponentes(pnlMovRede);
  End;
end;

procedure TfrmRelFatVendasCliente.pGerarExcel;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Aguarde, Gerando Arquivo...';

      If (edtTipo.Text = 'A') Then
        frmGravando.fExecutarAcao := fGeraExcelAnalitico
      Else
        frmGravando.fExecutarAcao := fGeraExcelSintetico;

      frmGravando.ShowModal;
      If frmGravando.blnConfirma Then
        fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
    Finally
      FreeAndNil(frmGravando);
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmRelFatVendasCliente.pGeraExcel');
    End;
  End;
end;

function TfrmRelFatVendasCliente.fGetCgcCli(DataSet: TDataSet): String;
begin
  If (DataSet.FindField('CGCCLI') <> Nil) Then
    Result := IIF(Length(DataSet.FieldByName('CGCCLI').AsString) > 11, 'CNPJ: ', 'CPF: ') + fFormataCpfCgc(DataSet.FieldByName('CGCCLI').AsString, fSetaPais)
  Else
    Result := '';
end;

procedure TfrmRelFatVendasCliente.pSetaConsumidor;
Begin
  If fClienteConsumidor(edtDesCliente.Text, False, True) Then
  Begin
    edtCodCliCon.ReadOnly := False;
    edtConNom.ReadOnly := edtCodCliCon.ReadOnly;
  End
  Else
  Begin
    edtCodCliCon.ReadOnly := True;
    edtCodCliCon.Clear;

    edtNomCliCon.Clear;

    edtConNom.ReadOnly := edtCodCliCon.ReadOnly;
    edtConNom.Clear;
  End;

  edtCodCliCon.TabStop := Not edtCodCliCon.ReadOnly;
  edtConNom.TabStop := edtCodCliCon.TabStop;

  edtCodCliCon.NormalColor := IIF(edtCodCliCon.ReadOnly, $00FFDFB8, clWindow);
  edtConNom.NormalColor := edtCodCliCon.NormalColor;
End;

procedure TfrmRelFatVendasCliente.edtCodEmbExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmb, edtNomEmb, arrEmbarc, fRetNomEmbarcacao, Nil, 'da embarcação');
end;

procedure TfrmRelFatVendasCliente.edtCodEmbKeyPress(Sender: TObject; var Key: Char);
  Var
    strCodCli: String;
begin
  inherited;

  If (Not fEmptyStr(edtCodCliente.Text)) And (fStrToFloat(edtCodCliente.Text) > 0) Then
    strCodCli := edtCodCliente.Text
  Else
    strCodCli := '';

  If fPesqCadastroEmbarcacoes(Self, edtCodEmb, edtNomEmb, Nil, Key, arrEmbarc, False, strCodCli) Then Begin
    If fValidaCampos(edtCodEmb, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFatVendasCliente.fGetArrEmbarc: TConsultasArray;
  Var
    i: Integer;
begin
  For i := 0 To Length(arrEmbarc) - 1 Do Begin
    If (Length(arrEmbarc[i].strCodigo) < 20) Then
      arrEmbarc[i].strCodigo := fCampoTabela('AUTOINCREM',
                                             'CADEMB',
                                             ['EMB_CODEMB'],
                                             [arrEmbarc[i].strCodigo]);
  End;

  Result := arrEmbarc;
end;

function TfrmRelFatVendasCliente.fGetArrEmbarcCodEmb: TConsultasArray;
  Var
    i: Integer;
begin
  For i := 0 To Length(arrEmbarc) - 1 Do Begin
    If (Length(arrEmbarc[i].strCodigo) = 20) Then
      arrEmbarc[i].strCodigo := fRedCodEmb(arrEmbarc[i].strCodigo);
  End;

  Result := arrEmbarc;
end;

function TfrmRelFatVendasCliente.fGetCodEmb: String;
begin
  If (Length(arrEmbarc) = 0) Then
    Result := fCampoTabela('AUTOINCREM',
                           'CADEMB',
                           ['EMB_CODEMB'],
                           [edtCodEmb.Text])
  Else
    Result := edtCodEmb.Text;
end;

function TfrmRelFatVendasCliente.fGetStrEmbarc: String;
  Var
    i: Integer;
    strTemp: String;
begin
  strTemp := '';

  For i := 0 To Length(arrEmbarc) - 1 Do Begin
    If (Length(arrEmbarc[i].strCodigo) = 20) Then
      arrEmbarc[i].strCodigo := fRedCodEmb(arrEmbarc[i].strCodigo);

    strTemp := strTemp + arrEmbarc[i].strCodigo + '_';
  End;

  If (Not fEmptyStr(strTemp)) Then
    strEmbarc := strTemp;

  Result := strEmbarc;
end;

function TfrmRelFatVendasCliente.fMarkup4(strCampoTotIte: String): String;

  function fEhSubstituido: String;
  begin
    Result := ' (LOCATE(DET_CODFIS, ' + QuotedStr(CST_SUBSTITUICAO) + ') > 0) ';
  end;

  function fDentroEstado: String;
  begin
    Result := ' ((DET_ESTADO = CID_ESTADO) OR (IFNULL(AUX_VENPRE, "N") = "S")) ';
  end;

  function fIcmSai: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ' , 0.00, ROUND((IFNULL(DET_ICMSAI,0) / ' + '(' + strCampoTotIte + ')) * 100, 2))) ';
  end;

  function fImpFed: String;
  begin
    Result := ' (ROUND((IFNULL(DET_IMPFED,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fDesOpe: String;
  begin
    Result := ' (ROUND((IFNULL(DET_DESOPE,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fComTbl: String;
  begin
    Result := ' (0.00) ';
  end;

  function fIcmsST: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ', (IFNULL(DET_ICMPAV, 0)*DET_QTDITE), 0.00)) ';
  end;

begin
  Result := 'ROUND((' + strCampoTotIte + ' * (1 - ((' + fIcmSai + ' + ' + fImpFed + ' + ' + fDesOpe + ' + ' + fComTbl +  ')/100)) - (' + fIcmsST + ')' + '), 2)';
end;

Class Procedure TfrmRelFatVendasCliente.pMostraItensVendidos(strCodIte: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);
Begin
  Try
    pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);

    frmRelFatVendasCliente.blnSenha              := False;
    frmRelFatVendasCliente.blnFaturamento        := False;
    frmRelFatVendasCliente.blnCliCons            := False;
    frmRelFatVendasCliente.blnConsultaItem       := True;
    frmRelFatVendasCliente.blnSomenteVendas      := True;

    frmRelFatVendasCliente.mskLinhaGrupo.Enabled := False;
    frmRelFatVendasCliente.edtProdutos.Enabled   := False;
    frmRelFatVendasCliente.edtProdutos.Text      := strCodIte;
    frmRelFatVendasCliente.edtProdutosExit(frmRelFatVendasCliente.edtProdutos);
    frmRelFatVendasCliente.pMostraDocumentoReimpressao := procMostraDocumentoReimpressao;

    frmRelFatVendasCliente.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnItensVendClick]');
    End;
  End;
  pFreeAndNil(frmRelFatVendasCliente);
End;

Class Procedure TfrmRelFatVendasCliente.pMostraDocumentosVendas(_strNumDoc, _strEspDoc, _strCodEmp: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);
Begin
  Try
    pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);

    frmRelFatVendasCliente.blnSenha              := False;
    frmRelFatVendasCliente.blnFaturamento        := False;
    frmRelFatVendasCliente.blnCliCons            := False;
    frmRelFatVendasCliente.blnConsultaDocumento  := True;
    frmRelFatVendasCliente.blnSomenteVendas      := True;
    frmRelFatVendasCliente.strNumDoc             := _strNumDoc;
    frmRelFatVendasCliente.strEspDoc             := _strEspDoc;
    frmRelFatVendasCliente.strCodEmp             := _strCodEmp;

    frmRelFatVendasCliente.mskLinhaGrupo.Enabled := False;
    frmRelFatVendasCliente.pMostraDocumentoReimpressao := procMostraDocumentoReimpressao;
    frmRelFatVendasCliente.mskDtaIni.Text:= DateToStr(fNow);
    frmRelFatVendasCliente.mskDtaFin.Text:= DateToStr(fNow);
    frmRelFatVendasCliente.edtCodVendedor.Tag:= 0;
    frmRelFatVendasCliente.edtCodRep.Tag:= 0;
    frmRelFatVendasCliente.btnImprimirClick(Nil);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnItensVendClick]');
    End;
  End;
  pFreeAndNil(frmRelFatVendasCliente);
End;

end.
