unit untNotaFiscalImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, Uni, DB, untFuncFat, StrUtils, AppEvnts, untEntNfeXml, untTValidaNFeCapa,
  UniClientDataSet, UniDataSetProvider, Mask, MaskEditFocus, Types,
  BitBtnLockedIncrem, ComCtrls, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus, untZClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, Datasnap.DBClient, Math, untTypesSistema,
  QColorLabel, untTPerfilDespachanteAduaneiro;

type
  TfrmNotaFiscalImport = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    pnlItens: TPanel;
    Label1: TLabel;
    edtNumPed: TEditFocus;
    edtNumCtn: TEditFocus;
    edtForPed: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtDtaEnt: TEditFocus;
    Label4: TLabel;
    edtCompra: TEditFocus;
    Label5: TLabel;
    edtCndPag: TEditFocus;
    Label6: TLabel;
    edtDolFec: TEditFocus;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label8: TLabel;
    edtQtdIte: TEditFocus;
    Label32: TLabel;
    edtTotGer: TEditFocus;
    GroupBox1: TGroupBox;
    edtSitTri: TEditFocus;
    chkTodosTrib: TCheckBox;
    Label19: TLabel;
    Label20: TLabel;
    edtUnitar: TEditFocus;
    edtTotIte: TEditFocus;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    edtNumDi: TEditFocus;
    mskDtaDi: TMaskEditFocus;
    edtLcDese: TEditFocus;
    mskDtDese: TMaskEditFocus;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtBaseCalculo: TEditFocus;
    edtDespAduaneiras: TEditFocus;
    edtImpostoImportacao: TEditFocus;
    edtValorIOF: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnConfirmaItem: TBitBtnLocked;
    btnConfPed: TBitBtnLocked;
    btnCancPed: TBitBtnLocked;
    pbProgresso: TProgressBar;
    btnDadosDI: TBitBtnLocked;
    btnRatDesAdu: TBitBtnLocked;
    Label22: TLabel;
    edtUfDese: TEditFocus;
    lblEntRet: TLabel;
    cmbVTrInt: TComboBoxFocus;
    Label24: TLabel;
    edtVAFrMM: TEditFocus;
    Label29: TLabel;
    cmbForImp: TComboBoxFocus;
    Label30: TLabel;
    edtUF_Adq: TEditFocus;
    mskCgcAdq: TMaskEditFocus;
    Label31: TLabel;
    lblAdicao: TLabel;
    edtAdicao: TEditFocus;
    pnlTipoImportacao: TPanel;
    rdgTipoImportacao: TRadioGroup;
    edtArqXML: TFilenameEditFocus;
    lblArqXML: TLabel;
    Label9: TLabel;
    lblCodFor: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    cdsXML: TUniClientDataSet;
    cdsXMLPCD_CODITE: TStringField;
    cdsXMLITE_CODUNI: TStringField;
    cdsXMLPCD_QTDITE: TFloatField;
    cdsXMLPCD_UNITAR: TFloatField;
    cdsXMLPCD_TOTITE: TFloatField;
    cdsXMLPCD_SITTRI: TStringField;
    cdsXMLPCD_ALQICM: TFloatField;
    cdsXMLPCD_PERIPI: TFloatField;
    cdsXMLXML_VAFRMM: TFloatField;
    cdsXMLXML_LOCDES: TStringField;
    cdsXMLXML_UFTERC: TStringField;
    cdsXMLXML_CNPJTE: TStringField;
    cdsXMLXML_NUMEDI: TStringField;
    cdsXMLXML_DATADI: TDateField;
    cdsXMLXML_DTDESE: TDateField;
    cdsXMLXML_ADICAO: TFloatField;
    cdsXMLXML_II_VBC: TFloatField;
    cdsXMLXML_II_DPA: TFloatField;
    cdsXMLXML_II_VII: TFloatField;
    cdsXMLXML_II_IOF: TFloatField;
    cdsXMLPCD_DESITE: TStringField;
    cdsXMLXML_UFDESE: TStringField;
    cdsXMLXML_VIATRA: TStringField;
    cdsXMLXML_TPINTE: TStringField;
    edtSiscomex: TEditFocus;
    lblSiscomex: TLabel;
    cdsXMLXML_SISCOM: TFloatField;
    cdsXMLPCD_BASICM: TFloatField;
    cdsXMLPCD_VALICM: TFloatField;
    cdsXMLPCD_BASIPI: TFloatField;
    cdsXMLPCD_TOTIPI: TFloatField;
    cdsXMLPCD_BASPIS: TFloatField;
    cdsXMLPCD_ALQPIS: TFloatField;
    cdsXMLPCD_VALPIS: TFloatField;
    cdsXMLPCD_BASCOF: TFloatField;
    cdsXMLPCD_ALQCOF: TFloatField;
    cdsXMLPCD_VALCOF: TFloatField;
    cdsXMLPCD_BASRET: TFloatField;
    cdsXMLPCD_VALRET: TFloatField;
    mskCndPag: TMaskEditFocus;
    cdsXMLITE_CODFAB: TStringField;
    edtCodFab: TEditFocus;
    cdsXMLXML_CFORDI: TStringField;
    cdsXMLITE_VALFRE: TFloatField;
    cdsXMLITE_DESACE: TFloatField;
    cdsXMLITE_OUTROS: TFloatField;
    cdsXMLXML_INDEX_: TIntegerField;
    cdsXMLXML_NUMCMP: TStringField;
    cdsXMLXML_NITCMP: TIntegerField;
    cdsXMLPCD_TOTITE_ORI: TFloatField;
    cdsXMLXML_II_VII_ORI: TFloatField;
    cdsXMLPCD_TOTIPI_ORI: TFloatField;
    cdsXMLPCD_VALPIS_ORI: TFloatField;
    cdsXMLPCD_VALCOF_ORI: TFloatField;
    cdsXMLXML_VAFRMM_ORI: TFloatField;
    cdsXMLPCD_VALICM_ORI: TFloatField;
    lblImpFre: TLabel;
    clbImpFre: TColorLabel;
    edtImpFre: TEditFocus;
    cdsXMLITE_VALSEG: TFloatField;
    lblPerfilAduaneiro: TLabel;
    edtCodPerfil: TEditFocus;
    edtDescPerfil: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfPedClick(Sender: TObject);
    procedure btnConfirmaItemClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnCancPedClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSitTriKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtUnitarExit(Sender: TObject);
    procedure btnDadosDIClick(Sender: TObject);
    procedure btnRatDesAduClick(Sender: TObject);
    procedure cmbVTrIntChange(Sender: TObject);
    procedure cmbForImpChange(Sender: TObject);
    procedure rdgTipoImportacaoClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure cdsXMLAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodPerfilKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
    qryPcmGer: TUniQuery;
    qryPcmDet: TUniQuery;
    qryCadTri: TUniQuery;
    dtsPcmDet: TDataSource;
    cdsPcmDet: TUniClientDataSet;
    dspPcmDet: TUniDataSetProvider;

    cdsDiverg: TZClient;
    cdsDadosFornec: TZClient;

    fatVenda: TFatVenda;
    intConfirmando: Integer;
    fltTotalItensXML: Double;
    fltInfCpl: Double;
    intVolumeDI: Integer;
    fltPesBruDI: Double;
    fltPesLiqDI: Double;
    strEspeciDI: String;
    strMarca_DI: String;
    fltTotNF_DI: Double;
    fltTotFrete: Double;
    fltTotSeguro: Double;
    strInfCplDI: String;

    recDespesasAduaneiras: TDespesasAduaneiras;
    recTotais: TRecTotais;

    objEntNfeXml: TNFeXml;
    cdsVinculaItensImportacao: TUniClientDataSet;
    fltValFreNota: Double;
    fltDesAceNota: Double;

    strNomArq: String;

    function fCarregaPedido: Boolean;
    function fBaixaPedido(fltValEmi: Double; strDocEmi, strEspEmi, strSerEmi: String): Boolean;

    function fRetNotaFiscalMae: String;
    function fPedidoMaeBaixado: Boolean;

    procedure pEditaItem;
    procedure pCarregaItensPedido;
    procedure pCalculaTotal;
    procedure pCalculaTotalXML;
    procedure pAtualizaDados(Dataset: TDataSet);
    procedure pAtualizaDadosXML(Dataset: TDataSet);
    procedure pCarregaCadTri;

    procedure pConfirma;
    procedure pRateiaDespesaAcessoriaNotaImportacao;

    procedure GravaXMLDI(AAutInc: string);
    function GetPerfilAduaneiro: string;
    procedure pConfirmaImpXML;

    function fValidaDadosDI: Boolean;
    procedure pCopiarDadosDi;
    procedure pCopiarDadosDiXML;
    procedure pRecalculaICMS;


    { SALVA OS DADOS DIGITADOS DOS PRODUTOS E CARREGA NOVAMENTE NA IMPORTACAO }
    procedure pSalvaDigitacaoItensNotaImportacao;
    procedure pCarregaDigitacaoItensNotaImportacao;
    function fJaPossuiDigitacaoItensNotaImportacao: Boolean;
    function fBuscaValorSiscomex(strInfCpl: WideString): Double;
    function fBuscaUnidade(strCodIte: string): string;
    procedure pBuscaInformacaoImportacaoXML;
    procedure pConfirmaItemXML;
    procedure pRatDesAduXML;
    function fValidaValoresDivergentes: Boolean;
    function fTemValoresDivergentes: Boolean;
    procedure pPreparandoItensImportacaoParaVinculacao;
    procedure pCarregaItensImportacaoParaVinculacao;
    procedure pCarregaItensImportacaoVinculados;
    procedure pPreparandoDadosFiscais;
    procedure pGravandoDocumento;
    procedure pCalculaValorNF;
    procedure pDeleteBakImp;
    function pValidarCampo(strCampo: String; varValor: Variant): Boolean;
    function fValidarDataXML: Boolean;
  protected
    procedure pEscapePressed; override;
    procedure OnImportErro(strNumDoc, strSerie, strNomArq, strMensagem: String);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intEscolheFormaImport: integer;
  end;

implementation

uses untFuncoes, untfuncoesSimples, untFatDadosFiscais, untReimpressao,
  untPesqAux, untConsultas, untConstantes, untPanelCxPedidoCompra,
  untFuncFatTypes, untPnlDadosPedidoCompra, untDuplicatas,
  untVinculaItensImportacao, untNotaFiscalImportMostraDiverg, untGravando,
  untFuncoesAuxiliares;

{$R *.dfm}

{ TfrmNotaFiscalImport }

function TfrmNotaFiscalImport.fCarregaPedido: Boolean;
  Var
    strSQL: String;
    strNumPed: String;
    strNumCtn: String;
    strDolFec: String;
    strUfDese: String;
begin

  strNumPed := edtNumPed.Text;
  strNumCtn := edtNumCtn.Text;
  strDolFec := edtDolFec.Text;
  strUfDese := edtUfDese.Text;

  btnCancPed.Click;


  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCMGER.*, ';
  strSQL := strSQL + '  CONCAT(PCG_CODFOR, "-", FOR_NOMFOR) AS PCG_FORPED, ';
  strSQL := strSQL + '  CADFOR.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER, ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  PCG_PEDIMP = "S" AND ';
  strSQL := strSQL + '  PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  strSQL := strSQL + '  PCG_CODFOR = FOR_CODFOR AND ';
  strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '  PCG_NUMCTN = :NUMCTN ';

  With qryPcmGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('NUMCTN').AsString := strNumCtn;
    Open;

    Result := (Not IsEmpty);

    edtDtaEnt.Text := FieldByName('PCG_DTAENT').AsString;
    edtForPed.Text := FieldByName('PCG_FORPED').AsString;

    If fEmptyStr(FieldByName('PCG_CODCMP').AsString) Then
      edtCompra.Text := FieldByName('PCG_COMPRA').AsString
    Else
      edtCompra.Text := FieldByName('PCG_CODCMP').AsString + ' - ' + fRetNomVendRep(FieldByName('PCG_CODCMP').AsString);

    edtCndPag.Text := FieldByName('PCG_CONPAG').AsString;

    edtUfDese.Clear;
  End;

  If (Result) Then
  Begin
    edtNumPed.Text := strNumPed;
    edtNumCtn.Text := strNumCtn;
    edtDolFec.Text := strDolFec;
    edtUfDese.Text := strUfDese;
    pSetFocus(edtNumCtn);
  End;

end;

function TfrmNotaFiscalImport.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumPed) Then
  Begin
    If (fEmptyStr(edtNumPed.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Número do Pedido deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtNumCtn) Then
  Begin
    If (fEmptyStr(edtNumCtn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do container deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (StrToInt(edtNumCtn.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do container deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If (Not fCarregaPedido) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse pedido não está cadastrado!', ['&Ok']);
      Result := False;
    End
    Else If (fCfgSis('LIBPCM', varBoolean)) And (qryPcmGer.FieldByName('PCG_PEDLIB').IsNull) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido ainda não foi liberado (Liberação de Pedidos de Compra)!', ['&Ok']);
      Result := False;
    End
    Else If (qryPcmGer.FieldByName('PCG_JAEMIT').AsInteger = 1) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nota fiscal referente a esse pedido já foi emitida!', ['&Ok']);
      Result := False;
    End
    Else If (StrToInt(edtNumCtn.Text) > 0) And (Not fPedidoMaeBaixado) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nota fiscal principal deste pedido ainda não foi emitida!', ['&Ok']);
      Result := False;
    End;

    If (Result) And (blnBuscaPorChave) Then
      edtDolFec.Text := FormatFloat(fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo), 0);
  End
  Else If (Sender = edtDolFec) Then
  Begin

    If (fEmptyStr(edtDolFec.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O dolar fechado deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDolFec.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O dolar fechado deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtCodPerfil) then
  begin
    PerfilDespachanteAduaneiro.pSetaPerfilDefault;
    If not fEmptyStr(edtCodPerfil.Text) then
    begin
      edtDescPerfil.Text := fRetDescPerfilAduanero(edtCodPerfil.Text);
      If fEmptyStr(edtDescPerfil.Text) then
      Begin
        fMensagem('ATENÇÃO!', 'Perfil aduaneiro não encontrado!', ['&Ok']);
        Result := False;
      end
      Else
        PerfilDespachanteAduaneiro.CodigoPerfil := edtCodPerfil.Text;
    end;
  end

  Else If (Sender = edtQtdIte) Then
  Begin

    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade do item deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade do item deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If (rdgTipoImportacao.ItemIndex = 0) And (fStrToFloat(edtQtdIte.Text) > cdsPcmDet.FieldByName('PCD_QTDORI').AsFloat) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade do item deve ser menor que ' + FloatToStrF(cdsPcmDet.FieldByName('PCD_QTDORI').AsFloat,
                                                                                     ffFixed, 12, 2) + '!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtSitTri) Then
  Begin

    If (fEmptyStr(edtSitTri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A situação tributária deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCadTri;
      If (fEmptyStr(qryCadTri.FieldByName('TRI_CODTRI').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa situação tributária não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtNumDi) Then
  Begin
    If fEmptyStr(edtNumDi.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do DI/DSI/DA deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskDtaDi) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaDi.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data do DI/DSI/DA deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtLcDese) Then
  Begin
    If fEmptyStr(edtLcDese.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O local do desembaraço deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtUfDese) Then
  Begin
    If Not fValidaEstado(edtUfDese.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'UF inválida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskDtDese) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtDese.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data do desembaraço deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = cmbVTrInt) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(cmbVTrInt.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Via de Transporte Internacional deve ser selecionada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtVAFrMM) And edtVAFrMM.Enabled Then
  Begin
    If fStrToFloat(edtVAFrMM.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da AFRMM (Adicional ao Frete para Renovação da Marinha Mercante) não pode ser negativo!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = cmbForImp) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(cmbForImp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A forma de importação deve ser selecionada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtUF_Adq) And edtUF_Adq.Enabled Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(edtUF_Adq.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A UF do adquirente ou do encomendante deve ser informada!', ['&Ok']);
      Result := False;
    End
    Else If Not fValidaEstado(edtUF_Adq.Text) Or (edtUF_Adq.Text = 'EX') Then
    Begin
      fMensagem('ATENÇÃO!', 'UF inválida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskCgcAdq) And mskCgcAdq.Enabled Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskCgcAdq.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O CNPJ do adquirente ou do encomendante deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If Not fTestaCgc(fTiraCaracEspeciais(mskCgcAdq.Text)) Then
    Begin
      fMensagem('ATENÇÃO', mskCgcAdq.Text + ' não é um Número de CNPJ válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtBaseCalculo) Or
          (Sender = edtDespAduaneiras) Or
          (Sender = edtImpostoImportacao) Or
          (Sender = edtValorIOF) Then
  Begin
    If fEmptyStr(TEdit(Sender).Text) Then
    Begin
      TEdit(Sender).Text := '0,00';
    End
    Else If fStrToFloat(TEdit(Sender).Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Os valores do imposto de importação devem ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmNotaFiscalImport.FormCreate(Sender: TObject);
begin
  inherited;

  pSetaNumPedCom(edtNumPed);

  qryPcmGer := fCriaQuery;
  qryPcmDet := fCriaQuery;
  dtsPcmDet := TDataSource.Create(Self);
  cdsPcmDet := TUniClientDataSet.Create(Self);
  cdsPcmDet.AggregatesActive := True;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_TOTITE';
    FieldName     := 'TOT_TOTITE';
    DataSet       := cdsPcmDet;
    Expression    := 'SUM(PCD_TOTITE)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  dspPcmDet := TUniDataSetProvider.Create(Self);
  PerfilDespachanteAduaneiro := TPerfilDespachanteAduaneiro.Create(Self);
  PerfilDespachanteAduaneiro.pSetaPerfilDefault;


  dspPcmDet.DataSet := qryPcmDet;
  cdsPcmDet.SetProvider(dspPcmDet);

  dtsPcmDet.DataSet := cdsPcmDet;
  cdsPcmDet.AfterScroll := pAtualizaDados;

  dbgItens.DataSource := dtsPcmDet;

  intConfirmando := -1;
  cdsDiverg := Nil;

  cdsDadosFornec := TZClient.Create(Self, TNFeXml.fSQLDadosFornec);
  cdsDadosFornec.fLeDados('TfrmNotaFiscalImport.FormCreate');
  cdsDadosFornec.IndexFieldNames := 'CODFOR';
  intVolumeDI := 0;
  fltPesBruDI := 0;
  fltPesLiqDI := 0;
  strEspeciDI := EmptyStr;
  strMarca_DI := EmptyStr;
  fltTotNF_DI := 0;
  fltTotFrete := 0;
  fltTotSeguro:= 0;

end;

procedure TfrmNotaFiscalImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End

  ELse If (Key = VK_F9) Then
  Begin
    If (Not cdsPcmDet.Active) Or (cdsPcmDet.IsEmpty) Then
      Exit;
    btnDadosDI.Click;
  End

  ELse If (Key = VK_F8) Then
  Begin
    btnRatDesAdu.Click;
  End

  Else If (Key = VK_ESCAPE) Then
  Begin
    btnCancPed.Click;
  End;

end;

procedure TfrmNotaFiscalImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsPcmDet.AfterScroll := Nil;

  qryPcmGer.Close;
  FreeAndNil(qryPcmGer);

  qryPcmDet.Close;
  FreeAndNil(qryPcmDet);

  If Assigned(cdsDiverg) Then
    FreeAndNil(cdsDiverg);
end;

procedure TfrmNotaFiscalImport.pCarregaItensPedido;
  Const
    STR_UNITAR = '(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) ' +
                 '            * (1 - IFNULL(PCD_DESUN2, 0) / 100) ' +
                 '            * (1 - IFNULL(PCD_DESUN3, 0) / 100) ' +
                 '            * (1 - IFNULL(PCD_DESUN4, 0) / 100) ' +
                 '            * (1 - IFNULL(PCD_DESUN5, 0) / 100) ' +
                 '            * (1 - IFNULL(PCD_DESUN6, 0) / 100) ' +
                 ' * :DOLFEC)';
  Var
    strSQL: String;
begin


  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCMDET.AUTOINCREM, ';
  strSQL := strSQL + '  PCD_CODITE, ';
  strSQL := strSQL + '  ITE_CODFAB, ';
  strSQL := strSQL + '  LEFT(PCD_DESITE,81) AS PCD_DESITE, ';
  strSQL := strSQL + '  ITE_CODUNI, ';
  strSQL := strSQL + '  PCD_QTDITE AS PCD_QTDORI, ';
  strSQL := strSQL + '  PCD_QTDITE, ';
  strSQL := strSQL + '  ' + STR_UNITAR + ' AS PCD_UNITAR, ';
  strSQL := strSQL + '  PCD_UNITAR AS PCD_UNIORI, ';
  strSQL := strSQL + '  (PCD_QTDITE * (PCD_UNITAR ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
  strSQL := strSQL + '      * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
  strSQL := strSQL + '   )) AS PCD_TOTITE, ';

  strSQL := strSQL + '  ABF_CODSIT_ENT_PEJ AS PCD_SITTRI, ';
  strSQL := strSQL + '  PCD_VALMAR, ';
  strSQL := strSQL + '  PCD_VALIMP, ';

  strSQL := strSQL + '  PCD_PERBAS, ';
  strSQL := strSQL + '  PCD_ALQICM, ';
  strSQL := strSQL + '  PCD_BASICM, ';
  strSQL := strSQL + '  PCD_VALICM, ';

  strSQL := strSQL + '  PCD_BASIPI, ';
  strSQL := strSQL + '  PCD_PERIPI, ';
  strSQL := strSQL + '  PCD_TOTIPI, ';

  strSQL := strSQL + '  PCD_ALQPIS, ';
  strSQL := strSQL + '  PCD_ALQCOF, ';
  strSQL := strSQL + '  PCD_BASPIS, ';
  strSQL := strSQL + '  PCD_BASCOF, ';
  strSQL := strSQL + '  PCD_VALPIS, ';
  strSQL := strSQL + '  PCD_VALSIS, ';
  strSQL := strSQL + '  PCD_VALCOF, ';

  strSQL := strSQL + '  000000000.0000 AS PCD_BASRET, ';
  strSQL := strSQL + '  000000000.0000 AS PCD_VALRET, ';

  strSQL := strSQL + '  REPEAT(" ", 30) AS PCD_NUM_DI, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS PCD_DTA_DI, ';
  strSQL := strSQL + '  REPEAT(" ", 60) AS PCD_LCDESE, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS PCD_DTDESE, ';

  strSQL := strSQL + '  "  " AS PCD_VTRINT, ';
  strSQL := strSQL + '  00000000.00 AS PCD_VAFRMM, ';
  strSQL := strSQL + '  " "  AS PCD_FORIMP, ';
  strSQL := strSQL + '  "  " AS PCD_UF_ADQ, ';
  strSQL := strSQL + '  REPEAT(" ", 18) AS PCD_CGCADQ, ';

  strSQL := strSQL + '  00000000.00 AS PCD_BASEII, ';
  strSQL := strSQL + '  00000000.00 AS PCD_DESADU, ';
  strSQL := strSQL + '  00000000.00 AS PCD_VAL_II, ';
  strSQL := strSQL + '  00000000.00 AS PCD_VALIOF,';
  strSQL := strSQL + '  PCD_ADICAO ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET ';
  strSQL := strSQL + 'INNER JOIN CADITE I ON PCD_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + 'INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = PCD_CODEMP ';
  strSQL := strSQL + 'INNER JOIN CADFOR ON FOR_CODFOR = PCD_CODFOR ';
  strSQL := strSQL + 'LEFT JOIN ABFICM ON ';
  strSQL := strSQL + '  ABF_ESTADO = ' + QuotedStr(fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 1)) + ' AND ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF = ABF_CODABF '
  Else
    strSQL := strSQL + '  G.ITE_CODABF = ABF_CODABF ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCD_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  PCD_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '  PCD_NUMCTN = :NUMCTN ';

  With qryPcmDet Do
  Begin
    Close;
    cdsPcmDet.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := edtNumPed.Text;
    ParamByName('NUMCTN').AsString := edtNumCtn.Text;
    ParamByName('DOLFEC').AsFloat  := fStrToFloat(edtDolFec.Text);

    Open;
    pSetaClient(qryPcmDet);

    cdsPcmDet.SetProvider(dspPcmDet);
    cdsPcmDet.Open;
    pSetaClient(cdsPcmDet);
  End;

  With cdsPcmDet Do
  Begin

    While (Not Eof) Do
    Begin
      Edit;
      FieldByName('PCD_VAFRMM').AsFloat := FieldByName('PCD_VALMAR').AsFloat;
      FieldByName('PCD_BASEII').AsFloat := FieldByName('PCD_TOTITE').AsFloat;
      FieldByName('PCD_VAL_II').AsFloat := FieldByName('PCD_VALIMP').AsFloat;
      Post;
      Next;
    End;

    First;

    TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
    TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
    TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_ALQICM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,##0.00';
  End;

  If fJaPossuiDigitacaoItensNotaImportacao Then
  Begin
    If fPergunta('Já existe uma digitação salva para os produtos desta importação! ' + #13#10 +
                 'Deseja carregar esta digitação?') Then
    Begin
      pCarregaDigitacaoItensNotaImportacao;
    End;
  End;

  pCalculaTotal;

  pSetFocus(dbgItens);
end;

procedure TfrmNotaFiscalImport.btnConfPedClick(Sender: TObject);
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    if (fEmptyStr(edtDesFor.Text)) or (fEmptyStr(edtArqXML.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Código do fornecedor e caminho do XML devem ser preenchidos!', ['&O k']);
      Exit;
    end;

    if fEmptyStr(mskCndPag.Text) then
    begin
      fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
      Exit;
    end;

    If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
    begin
      fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
      Exit;
    end;

    If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
    begin
      fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
      Exit;
    end;

    If Not fValidaCndPag(mskCndPag.Text) Then
    begin
      fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
      Exit;
    end;

    If (Pos(edtImpFre.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Importar valor de frete e seus dados cadastrais" corretamente!', ['&O k']);
      Exit;
    End;

    pBuscaInformacaoImportacaoXML;
  end
  else
  begin
    If (fValidaPanel(pnlCabecalho, False)) Then
    Begin
      pCarregaItensPedido;
      edtDolFec.Enabled := False;
      edtNumPed.Enabled := False;
      edtNumCtn.Enabled := False;
    End;
  end;
end;

procedure TfrmNotaFiscalImport.btnDadosDIClick(Sender: TObject);
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    if (not cdsXML.Active) or (cdsXML.IsEmpty) then
      Exit;

    pCopiarDadosDiXML;
  end
  else
  begin
    If (Not cdsPcmDet.Active) Or (cdsPcmDet.IsEmpty) Then
      Exit;

    pCopiarDadosDi;
  end;

end;

procedure TfrmNotaFiscalImport.pEditaItem;
begin

  pnlItens.Enabled := True;
  pSetFocus(edtQtdIte);

end;

procedure TfrmNotaFiscalImport.pAtualizaDados(Dataset: TDataset);
begin

  With cdsPcmDet Do
  Begin
    If (Not Active) Or (IsEmpty) Then
    Begin
      Exit;
    End;

    edtCodIte.Text := FieldByName('PCD_CODITE').AsString;
    edtCodFab.Text := FieldByName('ITE_CODFAB').AsString;
    edtDesIte.Text := FieldByName('PCD_DESITE').AsString;
    edtQtdIte.Text := FloatToStrF(FieldByName('PCD_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DEQTPC', varInteger));
    edtUnitar.Text := FloatToStrF(FieldByName('PCD_UNITAR').AsFloat, ffFixed, 12, PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
    edtTotIte.Text := FloatToStrF(FieldByName('PCD_TOTITE').AsFloat, ffFixed, 12, 2);
    edtSitTri.Text := FieldByName('PCD_SITTRI').AsString;

    edtNumDi.Text  := FieldByName('PCD_NUM_DI').AsString;
    mskDtaDi.Text  := FieldByName('PCD_DTA_DI').AsString;
    edtLcDese.Text := FieldByName('PCD_LCDESE').AsString;
    mskDtDese.Text := FieldByName('PCD_DTDESE').AsString;

    If (FieldByName('PCD_VAFRMM').AsFloat > 0) And fEmptyStr(FieldByName('PCD_VTRINT').AsString) Then
      cmbVTrInt.ItemIndex := 0
    Else
      cmbVTrInt.ItemIndex := StrToIntDef(FieldByName('PCD_VTRINT').AsString, 0) -1;
    cmbForImp.ItemIndex := strToIntDef(FieldByName('PCD_FORIMP').AsString, 0) -1;
    edtVAFrMM.Text      := FormatFloat('#,##0.00', FieldByName('PCD_VAFRMM').AsFloat);
    edtUF_Adq.Text      := Trim(FieldByName('PCD_UF_ADQ').AsString);
    mskCgcAdq.Text      := Trim(FieldByName('PCD_CGCADQ').AsString);

    cmbVTrIntChange(cmbVTrInt);
    cmbForImpChange(cmbForImp);

    edtBaseCalculo.Text       := FloatToStrF(FieldByName('PCD_BASEII').AsFloat, ffNumber, 12, 2);
    edtDespAduaneiras.Text    := FloatToStrF(FieldByName('PCD_DESADU').AsFloat, ffNumber, 12, 2);
    edtImpostoImportacao.Text := FloatToStrF(FieldByName('PCD_VAL_II').AsFloat, ffNumber, 12, 2);
    edtValorIOF.Text          := FloatToStrF(FieldByName('PCD_VALIOF').AsFloat, ffNumber, 12, 2);
    edtAdicao.Text            := FieldByName('PCD_ADICAO').AsString;

  End;
end;

procedure TfrmNotaFiscalImport.pAtualizaDadosXML(Dataset: TDataSet);
begin
  With cdsXML Do
  Begin
    If (Not Active) Or (IsEmpty) Then
    Begin
      Exit;
    End;

    edtCodIte.Text := FieldByName('PCD_CODITE').AsString;
    edtCodFab.Text := FieldByName('ITE_CODFAB').AsString;
    edtDesIte.Text := FieldByName('PCD_DESITE').AsString;
    edtQtdIte.Text := FloatToStrF(FieldByName('PCD_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DEQTPC', varInteger));
    edtUnitar.Text := FloatToStrF(FieldByName('PCD_UNITAR').AsFloat, ffFixed, 12, PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
    edtTotIte.Text := FloatToStrF(FieldByName('PCD_TOTITE').AsFloat, ffFixed, 12, 2);
    edtSitTri.Text := FieldByName('PCD_SITTRI').AsString;

    edtNumDi.Text  := FieldByName('XML_NUMEDI').AsString;
    mskDtaDi.Text  := FieldByName('XML_DATADI').AsString;
    edtLcDese.Text := FieldByName('XML_LOCDES').AsString;
    mskDtDese.Text := FieldByName('XML_DTDESE').AsString;

    If (FieldByName('XML_VAFRMM').AsFloat > 0) And fEmptyStr(FieldByName('XML_VIATRA').AsString) Then
      cmbVTrInt.ItemIndex := 0
    Else
      cmbVTrInt.ItemIndex := StrToIntDef(FieldByName('XML_VIATRA').AsString, 0) -1;
    cmbForImp.ItemIndex := strToIntDef(FieldByName('XML_TPINTE').AsString, 0) -1;
    edtVAFrMM.Text      := FormatFloat('#,##0.00', FieldByName('XML_VAFRMM').AsFloat);
    edtUF_Adq.Text      := Trim(FieldByName('XML_UFTERC').AsString);
    mskCgcAdq.Text      := Trim(FieldByName('XML_CNPJTE').AsString);

    cmbVTrIntChange(cmbVTrInt);
    cmbForImpChange(cmbForImp);

    edtBaseCalculo.Text       := FloatToStrF(FieldByName('XML_II_VBC').AsFloat, ffNumber, 12, 2);
    edtDespAduaneiras.Text    := FloatToStrF(FieldByName('XML_II_DPA').AsFloat, ffNumber, 12, 2);
    edtImpostoImportacao.Text := FloatToStrF(FieldByName('XML_II_VII').AsFloat, ffNumber, 12, 2);
    edtValorIOF.Text          := FloatToStrF(FieldByName('XML_II_IOF').AsFloat, ffNumber, 12, 2);
    edtAdicao.Text            := FieldByName('XML_ADICAO').AsString;

  End;
end;

procedure TfrmNotaFiscalImport.pCarregaItensImportacaoParaVinculacao;
var
  strArquivo: string;
begin
  strArquivo := edtArqXML.Text;
  objEntNfeXml := TNFeXml.Create(Self, True, xmlEntradaMercadoria);

  objEntNfeXml.onLogErro := OnImportErro;
  objEntNfeXml.cdsDadosFornec := cdsDadosFornec;

  objEntNfeXml.blnImportaFrete := edtImpFre.Text = 'S';
  objEntNfeXml.PerfilDespachanteAduaneiro := PerfilDespachanteAduaneiro;


  objEntNfeXml.fCarregarDoArquivo(strArquivo, cdsDiverg, False, True, Trim(edtCodFor.Text), (rdgTipoImportacao.ItemIndex =1));
  strNomArq := ChangeFileExt(ExtractFileName(strArquivo), EmptyStr);
end;

procedure TfrmNotaFiscalImport.pPreparandoItensImportacaoParaVinculacao;
var
  RecDetEle: TRecDetEle;
  intIndice: integer;
  blnTemVinculo: Boolean;
  strSQL: String;
  qryBakImp: TUniQuery;
begin
  blnTemVinculo := False;
  qryBakImp := fCriaQuery(Self);

  try
    strSQL := '';
    strSQL := strSQL + 'SELECT IMP_INDICE, IMP_CODITE, IMP_DESITE, IMP_CODFAB, IMP_PEDCMP ';
    strSQL := strSQL + 'FROM BAKIMP ';
    strSQL := strSQL + 'WHERE IMP_ARQUIV = :NOMARQ ';
    strSQL := strSQL + '    AND IMP_CODFOR = :CODFOR ';
    strSQL := strSQL + '    AND IMP_CODEMP = :CODEMP ';

    qryBakImp.SQL.Text := strSQL;
    qryBakImp.ParamByName('NOMARQ').AsString  := strNomArq;
    qryBakImp.ParamByName('CODFOR').AsString  := Trim(edtCodFor.Text);
    qryBakImp.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryBakImp.Open;

    if (not qryBakImp.IsEmpty) then
      blnTemVinculo := fMensagem('', 'Gostaria de recuperar os vínculos já relacionados para este XML?', ['&Sim', '&Não']) = 1;

    for intIndice := 0 to objEntNfeXml.getQuantidadeItens - 1 do
    begin
      RecDetEle := objEntNfeXml.getItemNota[intIndice];
      cdsVinculaItensImportacao.Append;
      cdsVinculaItensImportacao.FieldByName('CodItemFor').AsString := String(RecDetEle.I02_CPROD);
      cdsVinculaItensImportacao.FieldByName('NITEM').AsString := String(RecDetEle.I02_NITEM);
      cdsVinculaItensImportacao.FieldByName('DescItemFor').AsString := String(RecDetEle.I04_XPROD);
      cdsVinculaItensImportacao.FieldByName('Indice').AsInteger     := intIndice + 1;

      if blnTemVinculo and (not qryBakImp.IsEmpty) and qryBakImp.Locate('IMP_INDICE', intIndice + 1, []) then
      begin
        cdsVinculaItensImportacao.FieldByName('CodItemLoja').AsString   := qryBakImp.FieldByName('IMP_CODITE').AsString;
        cdsVinculaItensImportacao.FieldByName('DescItemLoja').AsString  := qryBakImp.FieldByName('IMP_DESITE').AsString;
        cdsVinculaItensImportacao.FieldByName('CodFabItemVin').AsString := qryBakImp.FieldByName('IMP_CODFAB').AsString;
        cdsVinculaItensImportacao.FieldByName('NumPedComp').AsString    := qryBakImp.FieldByName('IMP_PEDCMP').AsString;
      end;

      cdsVinculaItensImportacao.Post;
    end;
  finally
    FreeAndNil(qryBakImp);
  end;
end;

procedure TfrmNotaFiscalImport.pCarregaItensImportacaoVinculados;
var
  intIndice: integer;
  RecDetEle: TRecDetEle;
  strDataDI: string;
  strDataDesemb: string;
  fltSiscomex: Double;
  fltValorItemSemImposto: Double;

begin
  fltInfCpl := fBuscaValorSiscomex(objEntNfeXml.recDadosNota.Z03_infCpl);
  intVolumeDI := Trunc(objEntNfeXml.recDadosNota.X27_QVOL);
  fltPesBruDI := objEntNfeXml.recDadosNota.X32_PESOB;
  fltPesLiqDI := objEntNfeXml.recDadosNota.X31_PESOL;
  strEspeciDI := String(objEntNfeXml.recDadosNota.X28_ESP);
  strMarca_DI := String(objEntNfeXml.recDadosNota.X35_MARCA);
  fltTotNF_DI := objEntNfeXml.recDadosNota.W16_VNF;
  strInfCplDI := objEntNfeXml.recDadosNota.Z03_infCpl;
  fltTotFrete := objEntNfeXml.recDadosNota.W08_VFRETE;
  fltTotSeguro := objEntNfeXml.recDadosNota.W09_VSEG;

  fltTotalItensXML := 0;
  recTotais.fltTotIte_DI := 0;
  recTotais.fltII_DI     := 0;
  recTotais.fltIPI_DI    := 0;
  recTotais.fltPIS_DI    := 0;
  recTotais.fltCOFINS_DI := 0;
  recTotais.fltSiscom_DI := 0;
  recTotais.fltAFRMM_DI  := 0;
  recTotais.fltICMS_DI   := 0;


  If cdsXML.Active Then
    cdsXML.Close;

  cdsXML.CreateDataSet;
  cdsXML.EmptyDataSet;

  TFloatField(cdsXML.FieldByName('PCD_UNITAR')).DisplayFormat := fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo);

  cdsVinculaItensImportacao.First;

  Try
    dbgItens.DataSource := nil;

    for intIndice := 0 to objEntNfeXml.getQuantidadeItens - 1 do
    begin
      RecDetEle := objEntNfeXml.getItemNota[intIndice];

      if (RecDetEle.P02_VBC > 0) and (RecDetEle.I10_QCOM > 0) then
      begin
        fltValorItemSemImposto := fFormataFloat(RecDetEle.P02_VBC / RecDetEle.I10_QCOM, PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
      end
      else
      begin
        fltValorItemSemImposto := RecDetEle.I10A_VUNCOM;
      end;

      cdsXML.Append;
      cdsXMLXML_INDEX_.AsInteger  := intIndice + 1;
      cdsXMLPCD_QTDITE.AsFloat    := RecDetEle.I10_QCOM;

      case PerfilDespachanteAduaneiro.IdentificacaoUnitario of
        iduBaseCalculo: begin
                            cdsXMLPCD_UNITAR.AsFloat    := fltValorItemSemImposto; //RecDetEle.I10A_VUNCOM;
                            cdsXMLPCD_TOTITE.AsFloat    := RecDetEle.P02_VBC; //RecDetEle.I11_VPROD;
                        end;

        iduUnitarioComercial: begin
                                cdsXMLPCD_UNITAR.AsFloat    := RecDetEle.I10A_VUNCOM;
                                cdsXMLPCD_TOTITE.AsFloat    := RecDetEle.I11_VPROD;
                              end;
      end;

      cdsXMLPCD_ALQICM.AsFloat    := RecDetEle.N16_PICMS;
      cdsXMLPCD_PERIPI.AsFloat    := RecDetEle.O13_PIPI;

      If Pos(String(objEntNfeXml.recDadosNota.C21_CRT), '1_2_') > 0 Then
        cdsXMLPCD_SITTRI.AsString   := '190'
      Else
        cdsXMLPCD_SITTRI.AsString   := '1' + String(RecDetEle.N12_CST);

      cdsXMLXML_VAFRMM.AsFloat    := RecDetEle.I23B_VAFRMM;
      cdsXMLXML_NUMEDI.AsString   := String(RecDetEle.I19_NDI);
      cdsXMLXML_LOCDES.AsString   := String(RecDetEle.I21_XLOCDESEMB);
      cdsXMLXML_UFTERC.AsString   := IIF(fCfgSis('INFTER', varBoolean), fRetUFEmpresa,String(RecDetEle.I23E_UFTERCEIRO));
      cdsXMLXML_CNPJTE.AsString   := IIF(fCfgSis('INFTER', varBoolean), fRetCGCEmpresa(VS_strCodEmp),String(RecDetEle.I23D_CNPJ));
      cdsXMLXML_CFORDI.AsString   := String(RecDetEle.I02_CPROD);
      cdsXMLITE_VALFRE.AsFloat    := IIF(fltTotFrete > 0, RecDetEle.I15_VFRETE, 0);
      cdsXMLITE_OUTROS.AsFloat    := RecDetEle.I17A_VOUTRO;
      cdsXMLITE_VALSEG.AsFloat    := IIF(fltTotSeguro > 0, RecDetEle.I16_VSEG, 0);


      strDataDI := Copy(String(RecDetEle.I20_DDI),9,2) + '/' + Copy(String(RecDetEle.I20_DDI),6,2) + '/' + Copy(String(RecDetEle.I20_DDI),1,4);
      strDataDesemb := Copy(String(RecDetEle.I23_DDESEMB),9,2) + '/' + Copy(String(RecDetEle.I23_DDESEMB),6,2) + '/' + Copy(String(RecDetEle.I23_DDESEMB),1,4);
      fltTotalItensXML := fltTotalItensXML + cdsXMLPCD_TOTITE.AsFloat;

      If Not strDataDI.Equals('//')  Then
        cdsXMLXML_DATADI.AsDateTime := StrToDate(strDataDI);
      If Not strDataDesemb.Equals('//') Then
        cdsXMLXML_DTDESE.AsDateTime := StrToDate(strDataDesemb);
      cdsXMLXML_ADICAO.AsFloat    := RecDetEle.I26_NADICAO;
      cdsXMLXML_II_VBC.AsFloat    := RecDetEle.P02_VBC;
      cdsXMLXML_II_DPA.AsFloat    := RecDetEle.P03_VDESPADU;
      cdsXMLXML_II_VII.AsFloat    := RecDetEle.P04_VII;
      cdsXMLXML_II_IOF.AsFloat    := RecDetEle.P05_VIOF;
      cdsXMLXML_UFDESE.AsString   := String(RecDetEle.I22_UFDESEMB);
      cdsXMLXML_VIATRA.AsString   := String(RecDetEle.I23A_TPVIATRANSP);
      cdsXMLXML_TPINTE.AsString   := String(RecDetEle.I23C_TPINTERMEDIO);

          cdsXMLPCD_BASICM.AsFloat    := RecDetEle.N15_VBC;
          cdsXMLPCD_VALICM.AsFloat    := RecDetEle.N17_VICMS;
          cdsXMLPCD_BASIPI.AsFloat    := RecDetEle.O10_VBC;
          cdsXMLPCD_TOTIPI.AsFloat    := RecDetEle.O14_VIPI;
          cdsXMLPCD_BASPIS.AsFloat    := RecDetEle.Q07_VBC;
          cdsXMLPCD_ALQPIS.AsFloat    := RecDetEle.Q08_PPIS;
      cdsXMLPCD_VALPIS.AsFloat    := RecDetEle.Q09_VPIS;
      cdsXMLPCD_BASCOF.AsFloat    := RecDetEle.S07_VBC;
      cdsXMLPCD_ALQCOF.AsFloat    := RecDetEle.S08_PCOFINS;
      cdsXMLPCD_VALCOF.AsFloat    := RecDetEle.S11_VCOFINS;
      cdsXMLPCD_BASRET.AsFloat    := RecDetEle.N26_VBCSTRET;
      cdsXMLPCD_VALRET.AsFloat    := RecDetEle.N27_VICMSSTRET;

      cdsXMLPCD_CODITE.AsString   := cdsVinculaItensImportacao.FieldByName('CodItemLoja').AsString;
      cdsXMLPCD_DESITE.AsString   := cdsVinculaItensImportacao.FieldByName('DescItemLoja').AsString;
      cdsXMLITE_CODUNI.AsString   := fBuscaUnidade(cdsXMLPCD_CODITE.AsString);
      cdsXMLITE_CODFAB.AsString   := cdsVinculaItensImportacao.FieldByName('codFabItemVin').AsString;
      cdsXMLXML_NUMCMP.AsString   := cdsVinculaItensImportacao.FieldByName('NumPedComp').AsString;
      cdsXMLXML_NITCMP.AsInteger  := intIndice + 1;

      cdsXMLPCD_TOTITE_ORI.AsFloat := cdsXMLPCD_TOTITE.AsFloat;
      cdsXMLXML_II_VII_ORI.AsFloat := cdsXMLXML_II_VII.AsFloat;
      cdsXMLPCD_TOTIPI_ORI.AsFloat := cdsXMLPCD_TOTIPI.AsFloat;
      cdsXMLPCD_VALPIS_ORI.AsFloat := cdsXMLPCD_VALPIS.AsFloat;
      cdsXMLPCD_VALCOF_ORI.AsFloat := cdsXMLPCD_VALCOF.AsFloat;
      cdsXMLXML_VAFRMM_ORI.AsFloat := cdsXMLXML_VAFRMM.AsFloat;
      cdsXMLPCD_VALICM_ORI.AsFloat := cdsXMLPCD_VALICM.AsFloat;

      cdsXML.Post;

      recTotais.fltTotIte_DI := recTotais.fltTotIte_DI + cdsXMLPCD_TOTITE.AsFloat;
      recTotais.fltII_DI     := recTotais.fltII_DI + cdsXMLXML_II_VII.AsFloat;
      recTotais.fltIPI_DI    := recTotais.fltIPI_DI + cdsXMLPCD_TOTIPI.AsFloat;
      recTotais.fltPIS_DI    := recTotais.fltPIS_DI + cdsXMLPCD_VALPIS.AsFloat;
      recTotais.fltCOFINS_DI := recTotais.fltCOFINS_DI + cdsXMLPCD_VALCOF.AsFloat;
      recTotais.fltAFRMM_DI  := recTotais.fltAFRMM_DI + cdsXMLXML_VAFRMM.AsFloat;
      recTotais.fltICMS_DI   := recTotais.fltICMS_DI + cdsXMLPCD_VALICM.AsFloat;

      cdsVinculaItensImportacao.Next;
    end;
  Finally
    dbgItens.DataSource := dtsPcmDet;
  End;

  edtTotGer.Text := FormatFloat('#,##0.00', fltTotalItensXML);

  fltSiscomex := fltInfCpl;
  Try
    cdsXML.DisableControls;
    cdsXML.First;
    while not cdsXML.Eof do
    begin
      cdsXML.Edit;
      if cdsXML.RecNo = cdsXML.RecordCount then
      begin
        cdsXMLXML_SISCOM.AsFloat := fltSiscomex;
      end
      else
      begin
        cdsXMLXML_SISCOM.AsFloat := RoundTo((cdsXMLPCD_TOTITE.AsFloat/fltTotalItensXML) * fltInfCpl, -2);
      end;
      fltSiscomex := fltSiscomex - cdsXMLXML_SISCOM.AsFloat;
          recTotais.fltSiscom_DI := recTotais.fltSiscom_DI + cdsXMLXML_SISCOM.AsFloat;
      cdsXML.Post;
      cdsXML.Next;
    end;
  Finally
    cdsXML.First;
    cdsXML.EnableControls;
    edtCodFor.Enabled := False;
    edtArqXML.Enabled := False;
    mskCndPag.Enabled := False;
    edtImpFre.Enabled := False;
  End;

end;

procedure TfrmNotaFiscalImport.pBuscaInformacaoImportacaoXML;
var
  frmVinculaItensImportacao: TfrmVinculaItensImportacao;
begin
  Try
    TfrmGravando.fExecutarModalA(pCarregaItensImportacaoParaVinculacao, 'Carregando Itens para vinculação . . .', '') ;

    If objEntNfeXml.getQuantidadeItens <= 0 Then
      Exit;

    try
      Application.CreateForm(TfrmVinculaItensImportacao, frmVinculaItensImportacao);
      frmVinculaItensImportacao.setNFeXML(objEntNfeXml);
      frmVinculaItensImportacao.strCodFor := Trim(edtCodFor.Text);
      cdsVinculaItensImportacao := frmVinculaItensImportacao.cdsImpotXML;

      TfrmGravando.fExecutarModalA(pPreparandoItensImportacaoParaVinculacao, 'Preparando Itens para vinculação . . .', '') ;

      frmVinculaItensImportacao.cdsImpotXML := cdsVinculaItensImportacao;

      frmVinculaItensImportacao.strNomArq := strNomArq;
      frmVinculaItensImportacao.ShowModal;

      if frmVinculaItensImportacao.blnVinculouItens then
      begin
        cdsVinculaItensImportacao := frmVinculaItensImportacao.cdsImpotXML;

        TfrmGravando.fExecutarModalA(pCarregaItensImportacaoVinculados, 'Carregando Itens vinculados . . .', '') ;

      end;
    finally
      pFreeAndNil(frmVinculaItensImportacao);
    end;
  Finally
    FreeAndNil(objEntNfeXml);
  End;
end;

procedure TfrmNotaFiscalImport.btnConfirmaItemClick(Sender: TObject);
  Var
    tbmSavePlace: TBookmark;
    strSitTri   : String;
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    pConfirmaItemXML;
  end
  else
  begin

    If Not fValidaPanel(pnlItens, False) Then
      Exit;

    With cdsPcmDet Do
    Begin
      Edit;
      FieldByName('PCD_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
      FieldByName('PCD_UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
      FieldByName('PCD_TOTITE').AsFloat  := fStrToFloat(edtTotIte.Text);
      FieldByName('PCD_SITTRI').AsString := edtSitTri.Text;

      FieldByName('PCD_NUM_DI').AsString   := edtNumDi.Text ;
      FieldByName('PCD_DTA_DI').AsDateTime := StrToDateDef(mskDtaDi.Text,0);

      If FieldByName('PCD_DTA_DI').AsDateTime <= 0 Then
        FieldByName('PCD_DTA_DI').Clear;

      FieldByName('PCD_LCDESE').AsString   := edtLcDese.Text;
      FieldByName('PCD_DTDESE').AsDateTime := StrToDateDef(mskDtDese.Text,0);

      If FieldByName('PCD_DTDESE').AsDateTime <= 0 Then
        FieldByName('PCD_DTDESE').Clear;

      FieldByName('PCD_VTRINT').AsString := Trim(LeftStr(cmbVTrInt.Text, 2));
      FieldByName('PCD_FORIMP').AsString := Trim(LeftStr(cmbForImp.Text, 2));
      FieldByName('PCD_VAFRMM').AsFloat  := fStrToFloat(edtVAFrMM.Text);
      FieldByName('PCD_UF_ADQ').AsString := Trim(edtUF_Adq.Text);
      FieldByName('PCD_CGCADQ').AsString := Trim(mskCgcAdq.Text);

      FieldByName('PCD_BASEII').AsFloat  := fStrToFloat(edtBaseCalculo.Text);
      FieldByName('PCD_DESADU').AsFloat  := fStrToFloat(edtDespAduaneiras.Text);
      FieldByName('PCD_VAL_II').AsFloat  := fStrToFloat(edtImpostoImportacao.Text);
      FieldByName('PCD_VALIOF').AsFloat  := fStrToFloat(edtValorIOF.Text);

      If Length(Trim(edtAdicao.Text)) > 0 Then
        FieldByName('PCD_ADICAO').AsInteger := StrToInt(edtAdicao.Text);

      pRecalculaICMS;

      Post;

      pSalvaDigitacaoItensNotaImportacao;
    End;

    If chkTodosTrib.Checked Then
    Begin
      If fMensagem('', 'Confirma alteração da Situação Tributária para todos os itens?', ['&Sim', '&Não']) = 1 Then
      Begin
        With cdsPcmDet Do
        Begin
          strSitTri := edtSitTri.Text;
          tbmSavePlace := GetBookmark;
          DisableControls;
          First;

          pbProgresso.Visible := True;
          pbProgresso.Max     := RecordCount;

          While Not Eof Do
          Begin
            pbProgresso.Position := RecNo;
            Application.ProcessMessages;

            Edit;
            FieldByName('PCD_SITTRI').AsString := strSitTri;
            Post;

            pSalvaDigitacaoItensNotaImportacao;

            Next;
          End;

          pbProgresso.Visible := False;

          GotoBookmark(tbmSavePlace);
          EnableControls;
        End;

        chkTodosTrib.Checked := False;
      End;
    End;

    pCalculaTotal;
    pSetFocus(dbgItens);
    pnlItens.Enabled := False;
  end;
end;

procedure TfrmNotaFiscalImport.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    pAtualizaDadosXML(Nil);
  end
  else
  begin
    pAtualizaDados(Nil);
  end;
  pSetFocus(dbgItens);
  pnlItens.Enabled := False;
end;

procedure TfrmNotaFiscalImport.btnCancPedClick(Sender: TObject);
begin
  inherited;

  pnlItens.Enabled := False;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    cdsXML.Close;
    edtCodFor.Clear;
    edtDesFor.Clear;
    edtArqXML.Clear;
    mskCndPag.Clear;
    edtImpFre.Text := 'S';
    edtCodFor.Enabled := True;
    edtArqXML.Enabled := True;
    mskCndPag.Enabled := True;
    edtImpFre.Enabled := True;
  end
  else
  begin
    cdsPcmDet.Close;
  end;

  btnCancelaItem.Click;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Clear;
  edtUnitar.Clear;
  edtTotIte.Clear;
  edtSitTri.Clear;
  edtTotGer.Clear;

  edtDtaEnt.Clear;
  edtForPed.Clear;
  edtCompra.Clear;
  edtCndPag.Clear;
  edtNumCtn.Clear;
  edtNumPed.Clear;

  edtDolFec.Clear;
  edtUfDese.Clear;

  edtDolFec.Enabled := True;
  edtNumPed.Enabled := True;
  edtNumCtn.Enabled := True;

  cmbVTrInt.ItemIndex := -1;
  cmbForImp.ItemIndex := -1;
  edtVAFrMM.Clear;
  edtUF_Adq.Clear;
  mskCgcAdq.Clear;

  mskDtaDi.Clear;
  mskDtDese.Clear;
  edtNumDi.Clear;
  edtLcDese.Clear;

  edtBaseCalculo.Clear;
  edtImpostoImportacao.Clear;
  edtDespAduaneiras.Clear;
  edtValorIOF.Clear;
  edtAdicao.Clear;

  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    pSetFocus(edtCodFor);
  end
  else
  begin
    pSetFocus(edtNumPed);
  end;

end;

procedure TfrmNotaFiscalImport.btnConfirmaClick(Sender: TObject);
Begin
  inherited;

  If Not fValidaCampos(edtUfDese, True) Then
    Exit;

  If rdgTipoImportacao.ItemIndex = 1 then
   If Not fValidarDataXML Then
      Exit;

  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin
    Try
      Try
        if rdgTipoImportacao.ItemIndex = 1 then
        begin
          pConfirmaImpXML;
        end
        else
        begin
          pConfirma;
        end;

        InterlockedDecrement(intConfirmando);

      Except
        On E: Exception Do
        Begin
          InterlockedDecrement(intConfirmando);
          pMensagensErro(E.Message, '[pConfirma]');
        End;
      End;
    Finally
      If Assigned(fatVenda) Then
        FreeAndNil(fatVenda);
    End;

  End
  Else
    InterlockedDecrement(intConfirmando)

End;

procedure TfrmNotaFiscalImport.pConfirma;
  Var
    strErro, strSQL: String;
    qryGenAbf: TUniQuery;
    blnResult: Boolean;
    prcScroll: TprcScroll;
    ArrLivFis : TArrLivFis;
    intPosicao: Integer;
    ComposicaoValorContabil: TComposicaoValorContabil;
begin
  If (Not cdsPcmDet.Active) Or
     (cdsPcmDet.IsEmpty)    Then
  Begin
    fMensagem('', 'É necessário escolher um pedido!', ['&Ok']);
    btnCancPed.Click;
    Exit;
  End;

  If Not fValidaDadosDI Then
    Exit;

  cdsPcmDet.First;

  fatVenda := TFatVenda.CreateInstance('VN');
  fatVenda.procGravaDI := GravaXMLDI;
  fatVenda.procGetPerfilAduaneiro := GetPerfilAduaneiro;
  fatVenda.intDecImp := PerfilDespachanteAduaneiro.CasasDecimaisArquivo;
  pCriarCdsVenda(fatVenda);
  Try
    fatVenda.strOpcDocTrue := 'IN';
    fatVenda.strEspDoc := 'NF';
    fatVenda.strNotImp := 'S';

    cdsVenda.EmptyDataSet;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ABFICM.*, ';
    strSQL := strSQL + '  "NOR" AS IDEPRO, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  G.ITE_PREMED AS TOTMED, ';
    strSQL := strSQL + '  I.ITE_INCPIS AS INCPIS, ';
    strSQL := strSQL + '  I.ITE_PESOIT AS PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ AS PESLIQ, ';
    strSQL := strSQL + '  G.ITE_DESMAX AS DESMAX, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS PREVE7, ';
    strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '  I.ITE_EMBALA AS EMBALA, ';
    strSQL := strSQL + '  I.ITE_COMLUB AS COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + '  G.ITE_COMVAR AS COMVAR  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';

    strSQL := strSQL + 'INNER JOIN ITEGER G ON ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE ';

    strSQL := strSQL + 'INNER JOIN ABFICM  ON ';
    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = ABF_CODABF  '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = ABF_CODABF  ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  ABF_ESTADO   = ' + QuotedStr(fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 1)) + ' AND ';
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

    qryGenAbf := fCriaQuery;

    With qryGenAbf Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    With cdsPcmDet Do
    Begin
      pDisableControls(cdsPcmDet, prcScroll);
      Filter := '(PCD_SITTRI = '''') OR (PCD_SITTRI = NULL)';
      Filtered := True;
      blnResult := IsEmpty;
      Filter := '';
      Filtered := False;
      pEnableControls(cdsPcmDet, prcScroll);

      If Not blnResult Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher todas as situações tributárias!', ['&Ok']);
        First;
        Exit;
      End;
    End;

    fatVenda.strCodCli := '';
    fatVenda.strCodFor := qryPcmGer.FieldByName('PCG_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strConPag := qryPcmGer.FieldByName('PCG_CONPAG').AsString;
    fatVenda.strCliEst := fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryPcmGer.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryPcmGer.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryPcmGer.FieldByName('FOR_ENDERE').AsString;
    fatVenda.strCliNum := qryPcmGer.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryPcmGer.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryPcmGer.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryPcmGer.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryPcmGer.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryPcmGer.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryPcmGer.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryPcmGer.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryPcmGer.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryPcmGer.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';

    fatVenda.fltAduDem := recDespesasAduaneiras.fltDemurr;
    fatVenda.fltAduTxa := recDespesasAduaneiras.fltTaxArm;
    fatVenda.fltAduDpc := recDespesasAduaneiras.fltDespac;
    fatVenda.fltAduFre := recDespesasAduaneiras.fltFrete_;
    fatVenda.fltAduOdp := recDespesasAduaneiras.fltOutDes;
    fatVenda.fltAduMul := recDespesasAduaneiras.fltMulAdu;
    fatVenda.fltAduFti := recDespesasAduaneiras.fltFreInt;
    fatVenda.fltAdu500 := recDespesasAduaneiras.fltF_500_;

    fatVenda.fltTotCus := 0.0;
    fatVenda.fltTotMed := 0.0;
    fatVenda.fltPesBru := 0.0;
    fatVenda.fltPesLiq := 0.0;
    fatVenda.fltTotPis := 0.0;
    fatVenda.fltTotCof := 0.0;
    fatVenda.fltTotRmm := 0.0;

    Try
      pDisableControls(cdsPcmDet, prcScroll);

      cdsPcmDet.Filter   := 'PCD_QTDITE > 0';
      cdsPcmDet.Filtered := True;

      While (Not cdsPcmDet.Eof) Do
      Begin

        With qryGenAbf Do
        Begin
          Close;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODITE').AsString := cdsPcmDet.FieldByName('PCD_CODITE').AsString;
          Open;
          If qryGenAbf.IsEmpty Then
          Begin
            strErro := 'Não foi possível carregar a abreviação do produto [' + cdsPcmDet.FieldByName('PCD_CODITE').AsString + '] na empresa [' + VS_strCodEmp +
            '], verifique o campo ITE_CODABF da tabela ';
            If fCfgSis('TIPABF', varInteger) = 2 Then
              strErro := strErro + 'ITEGER.'
            Else
              strErro := strErro + 'CADITE.';
            FreeAndNil(fatVenda);

            fMensagem('Atenção', strErro, ['&Ok']);
            Exit;
          End;
        End;

        With cdsVenda Do
        Begin

          Insert;

          FieldByName('AUTOINCREM').AsInteger := cdsVenda.RecordCount + 1;
          FieldByName('ITE_IDEPRO').AsString  := qryGenAbf.FieldByName('IDEPRO').AsString;
          FieldByName('ITE_CODGRU').AsString  := qryGenAbf.FieldByName('CODGRU').AsString;
          FieldByName('ITE_CODITE').AsString  := qryGenAbf.FieldByName('CODITE').AsString;
          FieldByName('ITE_DESITE').AsString  := qryGenAbf.FieldByName('DESITE').AsString;
          FieldByName('ITE_DESORI').AsString  := qryGenAbf.FieldByName('DESITE').AsString;
          FieldByName('ITE_REFERE').AsString  := qryGenAbf.FieldByName('REFERE').AsString;
          FieldByName('ITE_CODUNI').AsString  := qryGenAbf.FieldByName('UNIDAD').AsString;
          FieldByName('ITE_UNIDAD').AsString  := qryGenAbf.FieldByName('UNIDAD').AsString;
          FieldByName('ITE_CODMAR').AsString  := qryGenAbf.FieldByName('CODMAR').AsString;
          FieldByName('ITE_CODFOR').AsString  := qryGenAbf.FieldByName('CODFOR').AsString;
          FieldByName('ITE_UNIORI').AsFloat   := cdsPcmDet.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_UNIVIS').AsFloat   := cdsPcmDet.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_UNITAR').AsFloat   := cdsPcmDet.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_TAXJUR').AsFloat   := 0;
          FieldByName('ITE_UNITMP').AsFloat   := 0;
          FieldByName('ITE_DESCON').AsFloat   := 0;
          FieldByName('ITE_QTDITE').AsFloat   := cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat;
          FieldByName('ITE_TOTITE').AsFloat   := cdsPcmDet.FieldByName('PCD_TOTITE').AsFloat;
          FieldByName('ITE_MARLUC').AsFloat   := 0;
          FieldByName('ITE_DESESP').AsFloat   := 0;
          FieldByName('ITE_COMPOS').AsString  := fCampoTabela('ITE_COMPOS', 'CADITE', ['ITE_CODITE'], [qryGenAbf.FieldByName('CODITE').AsString], False);

          FieldByName('ITE_ENTSAI').AsString  := 'S';

          FieldByName('ITE_PRECUS').AsFloat   := qryGenAbf.FieldByName('PRECUS').AsFloat;
          FieldByName('ITE_TOTCUS').AsFloat   := qryGenAbf.FieldByName('PRECUS').AsFloat * cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat;
          FieldByName('ITE_PREMED').AsFloat   := 0;
          FieldByName('ITE_TOTMED').AsFloat   := qryGenAbf.FieldByName('TOTMED').AsFloat;
          FieldByName('ITE_CLAFIS').AsString  := '';
          FieldByName('ITE_PERRED').AsFloat   := 0;
          FieldByName('ITE_PERBAS').AsFloat   := 0;
          FieldByName('ITE_UNIEMB').AsFloat   := 0;
          FieldByName('ITE_COMLUB').AsString  := qryGenAbf.FieldByName('COMLUB').AsString;
          FieldByName('ITE_IPISAI').AsFloat   := cdsPcmDet.FieldByName('PCD_PERIPI').AsFloat;
          FieldByName('ITE_PESOIT').AsFloat   := qryGenAbf.FieldByName('PESOIT').AsFloat;
          FieldByName('ITE_PESLIQ').AsFloat   := qryGenAbf.FieldByName('PESLIQ').AsFloat;
          FieldByName('ITE_DESMAX').AsFloat   := qryGenAbf.FieldByName('DESMAX').AsFloat;
          FieldByName('ITE_PREVE1').AsFloat   := qryGenAbf.FieldByName('PREVE1').AsFloat;
          FieldByName('ITE_PREVE2').AsFloat   := qryGenAbf.FieldByName('PREVE2').AsFloat;
          FieldByName('ITE_PREVE3').AsFloat   := qryGenAbf.FieldByName('PREVE3').AsFloat;
          FieldByName('ITE_PREVE4').AsFloat   := qryGenAbf.FieldByName('PREVE4').AsFloat;
          FieldByName('ITE_PREVE5').AsFloat   := qryGenAbf.FieldByName('PREVE5').AsFloat;
          FieldByName('ITE_PREVE6').AsFloat   := qryGenAbf.FieldByName('PREVE6').AsFloat;
          FieldByName('ITE_PREVE7').AsFloat   := qryGenAbf.FieldByName('PREVE7').AsFloat;
          FieldByName('ITE_SALDOS').AsFloat   := qryGenAbf.FieldByName('SALDOS').AsFloat;
          FieldByName('ITE_COMVAR').AsFloat   := qryGenAbf.FieldByName('COMVAR').AsFloat;
          FieldByName('ITE_INCPIS').AsString  := qryGenAbf.FieldByName('INCPIS').AsString;
          FieldByName('ITE_CLAIPI').AsString  := qryGenAbf.FieldByName('CLAIPI').AsString;
          FieldByName('ABF_CODABF').AsString  := qryGenAbf.FieldByName('ABF_CODABF').AsString;
          FieldByName('ABF_CODFIS').AsString  := cdsPcmDet.FieldByName('PCD_SITTRI').AsString;
          FieldByName('ABF_CODMEN').AsString  := '';

          FieldByName('ABF_CODSIT').AsString  := cdsPcmDet.FieldByName('PCD_SITTRI').AsString;

          FieldByName('ITE_ALQICM').AsFloat   := cdsPcmDet.FieldByName('PCD_ALQICM').AsFloat;
          FieldByName('ITE_BASICM').AsFloat   := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat;
          FieldByName('ITE_VALICM').AsFloat   := cdsPcmDet.FieldByName('PCD_VALICM').AsFloat;

          FieldByName('ITE_ALQIPI').AsFloat   := cdsPcmDet.FieldByName('PCD_PERIPI').AsFloat;
          FieldByName('ITE_BASIPI').AsFloat   := cdsPcmDet.FieldByName('PCD_BASIPI').AsFloat;
          FieldByName('ITE_VALIPI').AsFloat   := cdsPcmDet.FieldByName('PCD_TOTIPI').AsFloat;

          FieldByName('ITE_BASRET').AsFloat   := cdsPcmDet.FieldByName('PCD_BASRET').AsFloat;
          FieldByName('ITE_VALRET').AsFloat   := cdsPcmDet.FieldByName('PCD_VALRET').AsFloat;

          FieldByName('ITE_NUM_DI').AsString   := cdsPcmDet.FieldByName('PCD_NUM_DI').AsString;
          FieldByName('ITE_DTA_DI').AsDateTime := cdsPcmDet.FieldByName('PCD_DTA_DI').AsDateTime;
          FieldByName('ITE_LCDESE').AsString   := cdsPcmDet.FieldByName('PCD_LCDESE').AsString;
          FieldByName('ITE_UFDESE').AsString   := edtUfDese.Text;
          FieldByName('ITE_DTDESE').AsDateTime := cdsPcmDet.FieldByName('PCD_DTDESE').AsDateTime;

          FieldByName('ITE_VTRINT').AsString  := cdsPcmDet.FieldByName('PCD_VTRINT').AsString;
          FieldByName('ITE_FORIMP').AsString  := cdsPcmDet.FieldByName('PCD_FORIMP').AsString;
          FieldByName('ITE_VAFRMM').AsFloat   := cdsPcmDet.FieldByName('PCD_VAFRMM').AsFloat;
          FieldByName('ITE_UF_ADQ').AsString  := cdsPcmDet.FieldByName('PCD_UF_ADQ').AsString;
          FieldByName('ITE_CGCADQ').AsString  := cdsPcmDet.FieldByName('PCD_CGCADQ').AsString;
          FieldByName('ITE_CFORDI').AsString  := qryGenAbf.FieldByName('CODITE').AsString;

          FieldByName('ITE_BASEII').AsFloat   := cdsPcmDet.FieldByName('PCD_BASEII').AsFloat;
          FieldByName('ITE_DESADU').AsFloat   := cdsPcmDet.FieldByName('PCD_DESADU').AsFloat;
          FieldByName('ITE_VAL_II').AsFloat   := cdsPcmDet.FieldByName('PCD_VAL_II').AsFloat;
          FieldByName('ITE_VALIOF').AsFloat   := cdsPcmDet.FieldByName('PCD_VALIOF').AsFloat;

          FieldByName('ITE_BASPIS').AsFloat   := cdsPcmDet.FieldByName('PCD_BASPIS').AsFloat;
          FieldByName('ITE_ALQPIS').AsFloat   := cdsPcmDet.FieldByName('PCD_ALQPIS').AsFloat;
          FieldByName('ITE_VALPIS').AsFloat   := cdsPcmDet.FieldByName('PCD_VALPIS').AsFloat;

          FieldByName('ITE_BASCOF').AsFloat   := cdsPcmDet.FieldByName('PCD_BASCOF').AsFloat;
          FieldByName('ITE_ALQCOF').AsFloat   := cdsPcmDet.FieldByName('PCD_ALQCOF').AsFloat;
          FieldByName('ITE_VALCOF').AsFloat   := cdsPcmDet.FieldByName('PCD_VALCOF').AsFloat;

          FieldByName('ITE_ADICAO').AsInteger := cdsPcmDet.FieldByName('PCD_ADICAO').AsInteger;

          fatVenda.fltTotCus := fatVenda.fltTotCus + qryGenAbf.FieldByName('PRECUS').AsFloat * cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat;
          fatVenda.fltTotMed := fatVenda.fltTotMed + qryGenAbf.FieldByName('TOTMED').AsFloat;
          fatVenda.fltTotPis := fatVenda.fltTotPis + FieldByName('ITE_VALPIS').AsFloat;
          fatVenda.fltTotCof := fatVenda.fltTotCof + FieldByName('ITE_VALCOF').AsFloat;
          fatVenda.fltTotRmm := fatVenda.fltTotRmm + FieldByName('ITE_VAFRMM').AsFloat;

          Post;
        End;

        cdsPcmDet.Next;

      End;

      cdsPcmDet.Filter   := '';
      cdsPcmDet.Filtered := False;
      pEnableControls(cdsPcmDet, prcScroll);

    Except

      On E: Exception Do
      Begin
        cdsPcmDet.Filter   := '';
        cdsPcmDet.Filtered := False;
        pEnableControls(cdsPcmDet, prcScroll);
        pMensagensErro(E.Message, 'frmNotaFiscalImport.btnConfirmaClick');
        FreeAndNil(qryGenAbf);
        Exit;
      End;

    End;

    Try
      fatVenda.strCliEst := fRetNomCidade(qryPcmGer.FieldByName('FOR_CODCID').AsString, 1);
      fatVenda.strCliIes := qryPcmGer.FieldByName('FOR_I_E_S_').AsString;
      fatVenda.strCliAti := qryPcmGer.FieldByName('FOR_CODATI').AsString;

      fatVenda.pPreencheMatrizFechamento;
    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'frmNotaFiscalImport.btnConfirmaClick');
        FreeAndNil(qryGenAbf);
        Exit;
      End;

      On E: ExceptionAutCom Do
      Begin
        fMensagem('', E.Message, ['&O K']);
        FreeAndNil(qryGenAbf);
        Exit;
      End;

    End;

    fatVenda.pCalculaPesBruLiq;

    fatVenda.pCalculaTotGer;

    If (StrToInt(edtNumCtn.Text) > 0) Then
    Begin
      fatVenda.strMen001 := 'REF. A NOTA FISCAL ' + fRetNotaFiscalMae + ' / ' + edtNumCtn.Text;
    End;
    If fatVenda.fltImpTax = 0 Then
      fatVenda.fltImpTax := qryPcmGer.FieldByName('PCG_VALSIS').AsFloat;

    fatVenda.fltTotPis := 0;
    fatVenda.fltTotCof := 0;

    For intPosicao := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
    Begin
      If cdsVenda.Locate('AUTOINCREM', fatVenda.arrMatItens[intPosicao].intAutInc, []) Then
      Begin
        fatVenda.arrMatItens[intPosicao].fltBasPis := cdsVenda.FieldByName('ITE_BASPIS').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltAlqPis := cdsVenda.FieldByName('ITE_ALQPIS').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltValPis := cdsVenda.FieldByName('ITE_VALPIS').AsFloat;

        fatVenda.arrMatItens[intPosicao].fltBasCof := cdsVenda.FieldByName('ITE_BASCOF').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltAlqCof := cdsVenda.FieldByName('ITE_ALQCOF').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltValCof := cdsVenda.FieldByName('ITE_VALCOF').AsFloat;

        fatVenda.arrMatItens[intPosicao].intAdicao := cdsVenda.FieldByName('ITE_ADICAO').AsInteger;

        fatVenda.fltTotPis := fatVenda.fltTotPis + fatVenda.arrMatItens[intPosicao].fltValPis;
        fatVenda.fltTotCof := fatVenda.fltTotCof + fatVenda.arrMatItens[intPosicao].fltValCof;
      End;
    End;

    Try
      pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
      frmFatDadosFiscais.PerfilDespachanteAduaneiro := PerfilDespachanteAduaneiro;
      frmFatDadosFiscais.fatVenda       := fatVenda;
      frmFatDadosFiscais.blnForcaEdiBas := True;
      frmFatDadosFiscais.blnNotImp      := TRUE;
      frmFatDadosFiscais.ShowModal;

      blnResult := frmFatDadosFiscais.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnResult := False;
        pMensagensErro(E.Message, '[frmNotaFiscalImport.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmFatDadosFiscais);

    If (Not blnResult) Then
      Exit;

    fatVenda.fltTotGer := fatVenda.fltImpTot;
    fatVenda.fltDesAce := fatVenda.fltDesAce + fatVenda.fltOutros;
    pRateiaDespesaAcessoriaNotaImportacao;

    fDigDuplic(fatVenda.arrDuplicata,
               qryPcmGer.FieldByName('PCG_CONPAG').AsString,
               0,
               fatVenda.fltTotGer,
               False,
               False,
               False,
               qryPcmGer.FieldByName('PCG_DTAPED').AsDateTime,
               False);

    fatVenda.pAjustaCSTSimples;

    cdsVenda.First;
    For intPosicao := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
    Begin
      If cdsVenda.Locate('AUTOINCREM', fatVenda.arrMatItens[intPosicao].intAutInc, []) Then
      Begin
        fatVenda.arrMatItens[intPosicao].fltVlrCon := 0;
        for ComposicaoValorContabil in PerfilDespachanteAduaneiro.ComposicaoValorContabil  do
        begin
          case ComposicaoValorContabil of
            tcvcVR_PRODUTOS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltTotIte;
            tcvcFRETE:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValFre;
            tcvcSEGURO:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValSeg;
            tcvcVR_ICMS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIcm;
            tcvcPIS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValPis;
            tcvcCOFINS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValCof;
            tcvcIPI:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIpi;
            tcvcII:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltVal_II;
            tcvcSISCOMEX:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltImpTax;
            tcvcAFRMM:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltVafRmm;
            tcvcDESPESAS_ADUANEIRAS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltDesAdu;
            tcvcIOF:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIof;
          end;
        end;
        fatVenda.arrMatItens[intPosicao].fltVlrCon := fatVenda.arrMatItens[intPosicao].fltVlrCon - fatVenda.arrMatItens[intPosicao].fltDesEsp;
        fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltDesAce;

        {fatVenda.arrMatItens[intPosicao].fltVlrCon := fatVenda.arrMatItens[intPosicao].fltTotIte +
                                                      fatVenda.arrMatItens[intPosicao].fltValIpi +
                                                      fatVenda.arrMatItens[intPosicao].fltValRet +
                                                      fatVenda.arrMatItens[intPosicao].fltDesAce +
                                                      fatVenda.arrMatItens[intPosicao].fltValFre -
                                                      fatVenda.arrMatItens[intPosicao].fltDesEsp +
                                                      fatVenda.arrMatItens[intPosicao].fltValIcm +
                                                      fatVenda.arrMatItens[intPosicao].fltVal_II +
                                                      fatVenda.arrMatItens[intPosicao].fltDesAdu +
                                                      fatVenda.arrMatItens[intPosicao].fltValIof +
                                                      fatVenda.arrMatItens[intPosicao].fltImpTax +
                                                      fatVenda.arrMatItens[intPosicao].fltValPis +
                                                      fatVenda.arrMatItens[intPosicao].fltValCof +
                                                      fatVenda.arrMatItens[intPosicao].fltVafRmm;
       }
      End;
    End;

    Try
      fStartTransaction;

      fatVenda.strNumDoc := fatVenda.fRetornaSeqNota;

      blnResult := fatVenda.fGNotGer;
      If (Not blnResult) Then
      Begin
        fRollBack;
        Exit;
      End;

      blnResult := fatVenda.fGNotDet;
      If (Not blnResult) Then
      Begin
        fRollBack;
        Exit;
      End;

      fatVenda.pCalculaCadFis(ArrLivFis);

      blnResult := fatVenda.fGCadFisRe(ArrLivFis);
      If (Not blnResult) Then
      Begin
        fRollBack;
        Exit;
      End;

      blnResult := fBaixaPedido(fatVenda.fltTotGer, fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strSerFsc);
      If (Not blnResult) Then
      Begin
        fRollBack;
        Exit;
      End;

      fCommit;

      If (fCfgSis('NFEUSA', varBoolean)) And (fCfgSis('PNLNFE', varBoolean)) And fatVenda.blnGerNFE Then
      Begin
        fExecutarModal(fatVenda.fNotaEletronicaPainel, 'Aguarde ...', '');
      End;

      fMensagem('', 'Documento: ' + fatVenda.strNumDoc + ' - ' + fatVenda.strEspDoc + ' gravado com sucesso!', ['&O k']);

      btnCancPed.Click;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[Gravação da Nota de Importação]');
        fRollBack;
        Exit;
      End;
    End;

    {*******************************************}
    {* IMPRIME A NOTA                          *}
    {****************************************MV*}
    If (Not fatVenda.blnGerNFE) Then
      TReimpressao.Create(fatVenda.strNumDoc, 'NF',
                          0, 0, '', VS_strCodEmp, '', True, 'F', True, False, False, '', '', False, 0, False, 'V').pReimprimeDocumento(True);

    FreeAndNil(qryGenAbf);
  Finally
    FreeAndNil(fatVenda);
  End;
end;

procedure TfrmNotaFiscalImport.pRateiaDespesaAcessoriaNotaImportacao;
var
  intCont: Integer;
  fltTotalProdutos : Double;
  fltPercRepresent : Double;
  fltTotRatDespesaAcessoria: Double;
begin
  If Length(fatVenda.arrMatItens) = 0 Then
    Exit;

  fltTotalProdutos  := 0;
  fltTotRatDespesaAcessoria := 0;

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
    fltTotalProdutos := fltTotalProdutos + fatVenda.arrMatItens[intCont].fltTotIte;

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    fltPercRepresent := fatVenda.arrMatItens[intCont].fltTotIte / fltTotalProdutos;

    fatVenda.arrMatItens[intCont].fltDesAce := fFormataFloat(fatVenda.fltDesAce * fltPercRepresent, 2);

    fltTotRatDespesaAcessoria := fltTotRatDespesaAcessoria + fatVenda.arrMatItens[intCont].fltDesAce;
  End;

  fatVenda.arrMatItens[0].fltDesAce := fatVenda.arrMatItens[0].fltDesAce + (fatVenda.fltDesAce - fltTotRatDespesaAcessoria);
end;


procedure TfrmNotaFiscalImport.pPreparandoDadosFiscais;
Var
  blnResult: Boolean;
  strSQL, strErro: String;
  qryGenAbf, qryFornecedor: TUniQuery;
  prcScroll: TprcScroll;
  fltTxSiscomex: Double;
  intPosicao: Integer;
begin
  blnResult := True;

  Try
    qryFornecedor := fCriaQuery;
    qryFornecedor.SQL.Add('SELECT * FROM CADFOR WHERE FOR_CODFOR = :CODFOR');
    qryFornecedor.ParamByName('CODFOR').AsString := Trim(edtCodFor.Text);
    qryFornecedor.Open;

    fatVenda.strOpcDocTrue := 'IN';

    fatVenda.strEspDoc := 'NF';
    fatVenda.strNotImp := 'S';

    cdsVenda.EmptyDataSet;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ABFICM.*, ';
    strSQL := strSQL + '  "NOR" AS IDEPRO, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  G.ITE_PREMED AS TOTMED, ';
    strSQL := strSQL + '  I.ITE_INCPIS AS INCPIS, ';
    strSQL := strSQL + '  I.ITE_PESOIT AS PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ AS PESLIQ, ';
    strSQL := strSQL + '  G.ITE_DESMAX AS DESMAX, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS PREVE7, ';
    strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '  I.ITE_EMBALA AS EMBALA, ';
    strSQL := strSQL + '  I.ITE_COMLUB AS COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + '  G.ITE_COMVAR AS COMVAR  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';

    strSQL := strSQL + 'INNER JOIN ITEGER G ON ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE ';

    strSQL := strSQL + 'INNER JOIN ABFICM  ON ';
    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = ABF_CODABF  '

    Else
      strSQL := strSQL + '  G.ITE_CODABF = ABF_CODABF  ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  ABF_ESTADO   = ' + QuotedStr(fRetNomCidade(qryFornecedor.FieldByName('FOR_CODCID').AsString, 1)) + ' AND ';
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

    qryGenAbf := fCriaQuery;

    With qryGenAbf Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    fatVenda.strCodCli := '';
    fatVenda.strCodFor := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strConPag := mskCndPag.Text;
    fatVenda.strCliEst := fRetNomCidade(qryFornecedor.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryFornecedor.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryFornecedor.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryFornecedor.FieldByName('FOR_ENDERE').AsString;

    fatVenda.strCliNum := qryFornecedor.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryFornecedor.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryFornecedor.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryFornecedor.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryFornecedor.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryFornecedor.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryFornecedor.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryFornecedor.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryFornecedor.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryFornecedor.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryFornecedor.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryFornecedor.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';

    fatVenda.fltAduDem := recDespesasAduaneiras.fltDemurr;
    fatVenda.fltAduTxa := recDespesasAduaneiras.fltTaxArm;
    fatVenda.fltAduDpc := recDespesasAduaneiras.fltDespac;
    fatVenda.fltAduFre := recDespesasAduaneiras.fltFrete_;
    fatVenda.fltAduOdp := recDespesasAduaneiras.fltOutDes;
    fatVenda.fltAduMul := recDespesasAduaneiras.fltMulAdu;
    fatVenda.fltAduFti := recDespesasAduaneiras.fltFreInt;
    fatVenda.fltAdu500 := recDespesasAduaneiras.fltF_500_;
    fatVenda.fltTot_DI := fltTotNF_DI;

    fatVenda.fltTotCus := 0.0;
    fatVenda.fltTotMed := 0.0;
    fatVenda.fltPesBru := 0.0;
    fatVenda.fltTotCof := 0.0;
    fatVenda.fltTotRmm := 0.0;
    fatVenda.fltValFre := 0.0;
    fatVenda.fltValSeg := 0.0;
    fatVenda.fltDesAce := 0.0;
    fatVenda.fltOutros := 0.0;
    fatVenda.intQtdTra := intVolumeDI;
    fatVenda.fltPesBru := fltPesBruDI;
    fatVenda.fltPesLiq := fltPesLiqDI;
    fatVenda.strEspTra := strEspeciDI;
    fatVenda.strMarTra := strMarca_DI;

    Try
      pDisableControls(cdsXML, prcScroll);
      cdsXML.First;
      fltTxSiscomex := 0;
      While (Not cdsXML.Eof) Do
      Begin

        With qryGenAbf Do
        Begin
          Close;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODITE').AsString := cdsXML.FieldByName('PCD_CODITE').AsString;
          Open;
          If qryGenAbf.IsEmpty Then
          Begin
            strErro := 'Não foi possível carregar a abreviação do produto [' + cdsXML.FieldByName('PCD_CODITE').AsString + '] na empresa [' + VS_strCodEmp +
            '], verifique o campo ITE_CODABF da tabela ';
            If fCfgSis('TIPABF', varInteger) = 2 Then
              strErro := strErro + 'ITEGER.'
            Else
              strErro := strErro + 'CADITE.';
            FreeAndNil(fatVenda);

            fMensagem('Atenção', strErro, ['&Ok']);
            blnResult := False;
            Exit;
          End;
        End;

        With cdsVenda Do
        Begin

          Insert;

          FieldByName('AUTOINCREM').AsInteger := cdsXML.FieldByName('XML_INDEX_').AsInteger; // cdsVenda.RecordCount + 1;
          FieldByName('ITE_IDEPRO').AsString  := qryGenAbf.FieldByName('IDEPRO').AsString;
          FieldByName('ITE_CODGRU').AsString  := qryGenAbf.FieldByName('CODGRU').AsString;
          FieldByName('ITE_CODITE').AsString  := qryGenAbf.FieldByName('CODITE').AsString;
          FieldByName('ITE_DESITE').AsString  := qryGenAbf.FieldByName('DESITE').AsString;
          FieldByName('ITE_DESORI').AsString  := qryGenAbf.FieldByName('DESITE').AsString;
          FieldByName('ITE_REFERE').AsString  := qryGenAbf.FieldByName('REFERE').AsString;
          FieldByName('ITE_CODUNI').AsString  := qryGenAbf.FieldByName('UNIDAD').AsString;
          FieldByName('ITE_UNIDAD').AsString  := qryGenAbf.FieldByName('UNIDAD').AsString;
          FieldByName('ITE_CODMAR').AsString  := qryGenAbf.FieldByName('CODMAR').AsString;
          FieldByName('ITE_CODFOR').AsString  := qryGenAbf.FieldByName('CODFOR').AsString;
          FieldByName('ITE_UNIORI').AsFloat   := cdsXML.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_UNIVIS').AsFloat   := cdsXML.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_UNITAR').AsFloat   := cdsXML.FieldByName('PCD_UNITAR').AsFloat;
          FieldByName('ITE_TAXJUR').AsFloat   := 0;
          FieldByName('ITE_UNITMP').AsFloat   := 0;
          FieldByName('ITE_DESCON').AsFloat   := 0;
          FieldByName('ITE_QTDITE').AsFloat   := cdsXML.FieldByName('PCD_QTDITE').AsFloat;
          FieldByName('ITE_TOTITE').AsFloat   := cdsXML.FieldByName('PCD_TOTITE').AsFloat;
          FieldByName('ITE_MARLUC').AsFloat   := 0;
          FieldByName('ITE_DESESP').AsFloat   := 0;
          FieldByName('ITE_COMPOS').AsString  := fCampoTabela('ITE_COMPOS', 'CADITE', ['ITE_CODITE'], [qryGenAbf.FieldByName('CODITE').AsString], False);

          FieldByName('ITE_ENTSAI').AsString  := 'S';

          FieldByName('ITE_PRECUS').AsFloat   := qryGenAbf.FieldByName('PRECUS').AsFloat;
          FieldByName('ITE_TOTCUS').AsFloat   := qryGenAbf.FieldByName('PRECUS').AsFloat * cdsXML.FieldByName('PCD_QTDITE').AsFloat;
          FieldByName('ITE_PREMED').AsFloat   := 0;
          FieldByName('ITE_TOTMED').AsFloat   := qryGenAbf.FieldByName('TOTMED').AsFloat;
          FieldByName('ITE_CLAFIS').AsString  := '';
          FieldByName('ITE_PERRED').AsFloat   := 0;
          FieldByName('ITE_PERBAS').AsFloat   := 0;
          FieldByName('ITE_UNIEMB').AsFloat   := 0;
          FieldByName('ITE_COMLUB').AsString  := qryGenAbf.FieldByName('COMLUB').AsString;
          FieldByName('ITE_IPISAI').AsFloat   := cdsXML.FieldByName('PCD_PERIPI').AsFloat;
          FieldByName('ITE_PESOIT').AsFloat   := qryGenAbf.FieldByName('PESOIT').AsFloat;
          FieldByName('ITE_PESLIQ').AsFloat   := qryGenAbf.FieldByName('PESLIQ').AsFloat;
          FieldByName('ITE_DESMAX').AsFloat   := qryGenAbf.FieldByName('DESMAX').AsFloat;
          FieldByName('ITE_PREVE1').AsFloat   := qryGenAbf.FieldByName('PREVE1').AsFloat;
          FieldByName('ITE_PREVE2').AsFloat   := qryGenAbf.FieldByName('PREVE2').AsFloat;
          FieldByName('ITE_PREVE3').AsFloat   := qryGenAbf.FieldByName('PREVE3').AsFloat;
          FieldByName('ITE_PREVE4').AsFloat   := qryGenAbf.FieldByName('PREVE4').AsFloat;
          FieldByName('ITE_PREVE5').AsFloat   := qryGenAbf.FieldByName('PREVE5').AsFloat;
          FieldByName('ITE_PREVE6').AsFloat   := qryGenAbf.FieldByName('PREVE6').AsFloat;
          FieldByName('ITE_PREVE7').AsFloat   := qryGenAbf.FieldByName('PREVE7').AsFloat;
          FieldByName('ITE_SALDOS').AsFloat   := qryGenAbf.FieldByName('SALDOS').AsFloat;
          FieldByName('ITE_COMVAR').AsFloat   := qryGenAbf.FieldByName('COMVAR').AsFloat;
          FieldByName('ITE_INCPIS').AsString  := qryGenAbf.FieldByName('INCPIS').AsString;
          FieldByName('ITE_CLAIPI').AsString  := qryGenAbf.FieldByName('CLAIPI').AsString;
          FieldByName('ABF_CODABF').AsString  := qryGenAbf.FieldByName('ABF_CODABF').AsString;
          FieldByName('ABF_CODFIS').AsString  := cdsXML.FieldByName('PCD_SITTRI').AsString;
          FieldByName('ABF_CODMEN').AsString  := '';

          FieldByName('ABF_CODSIT').AsString  := cdsXML.FieldByName('PCD_SITTRI').AsString;

          FieldByName('ITE_ALQICM').AsFloat   := cdsXML.FieldByName('PCD_ALQICM').AsFloat;
          FieldByName('ITE_BASICM').AsFloat   := cdsXML.FieldByName('PCD_BASICM').AsFloat;
          FieldByName('ITE_VALICM').AsFloat   := cdsXML.FieldByName('PCD_VALICM').AsFloat;

          FieldByName('ITE_ALQIPI').AsFloat   := cdsXML.FieldByName('PCD_PERIPI').AsFloat;
          FieldByName('ITE_BASIPI').AsFloat   := cdsXML.FieldByName('PCD_BASIPI').AsFloat;
          FieldByName('ITE_VALIPI').AsFloat   := cdsXML.FieldByName('PCD_TOTIPI').AsFloat;

          FieldByName('ITE_BASRET').AsFloat   := cdsXML.FieldByName('PCD_BASRET').AsFloat;
          FieldByName('ITE_VALRET').AsFloat   := cdsXML.FieldByName('PCD_VALRET').AsFloat;

          FieldByName('ITE_NUM_DI').AsString   := cdsXML.FieldByName('XML_NUMEDI').AsString;
          FieldByName('ITE_DTA_DI').AsDateTime := cdsXML.FieldByName('XML_DATADI').AsDateTime;
          FieldByName('ITE_LCDESE').AsString   := cdsXML.FieldByName('XML_LOCDES').AsString;
          FieldByName('ITE_UFDESE').AsString   := edtUfDese.Text;
          FieldByName('ITE_DTDESE').AsDateTime := cdsXML.FieldByName('XML_DTDESE').AsDateTime;

          FieldByName('ITE_VTRINT').AsString  := cdsXML.FieldByName('XML_VIATRA').AsString;
          FieldByName('ITE_FORIMP').AsString  := cdsXML.FieldByName('XML_TPINTE').AsString;
          FieldByName('ITE_VAFRMM').AsFloat   := cdsXML.FieldByName('XML_VAFRMM').AsFloat;
          FieldByName('ITE_UF_ADQ').AsString  := cdsXML.FieldByName('XML_UFTERC').AsString;
          FieldByName('ITE_CGCADQ').AsString  := cdsXML.FieldByName('XML_CNPJTE').AsString;
          FieldByName('ITE_CFORDI').AsString  := cdsXML.FieldByName('XML_CFORDI').AsString;

          FieldByName('ITE_BASEII').AsFloat   := cdsXML.FieldByName('XML_II_VBC').AsFloat;
          FieldByName('ITE_DESADU').AsFloat   := cdsXML.FieldByName('XML_II_DPA').AsFloat;
          FieldByName('ITE_VAL_II').AsFloat   := cdsXML.FieldByName('XML_II_VII').AsFloat;
          FieldByName('ITE_VALIOF').AsFloat   := cdsXML.FieldByName('XML_II_IOF').AsFloat;

          FieldByName('ITE_BASPIS').AsFloat   := cdsXML.FieldByName('PCD_BASPIS').AsFloat;
          FieldByName('ITE_ALQPIS').AsFloat   := cdsXML.FieldByName('PCD_ALQPIS').AsFloat;
          FieldByName('ITE_VALPIS').AsFloat   := cdsXML.FieldByName('PCD_VALPIS').AsFloat;

          FieldByName('ITE_BASCOF').AsFloat   := cdsXML.FieldByName('PCD_BASCOF').AsFloat;
          FieldByName('ITE_ALQCOF').AsFloat   := cdsXML.FieldByName('PCD_ALQCOF').AsFloat;
          FieldByName('ITE_VALCOF').AsFloat   := cdsXML.FieldByName('PCD_VALCOF').AsFloat;
          FieldByName('ITE_VALFRE').AsFloat   := cdsXML.FieldByName('ITE_VALFRE').AsFloat;
          FieldByName('ITE_VALSEG').AsFloat   := cdsXML.FieldByName('ITE_VALSEG').AsFloat;
          FieldByName('ITE_DESACE').AsFloat   := cdsXML.FieldByName('ITE_DESACE').AsFloat;
          FieldByName('ITE_OUTROS').AsFloat   := cdsXML.FieldByName('ITE_OUTROS').AsFloat;

          FieldByName('ITE_ADICAO').AsInteger := cdsXML.FieldByName('XML_ADICAO').AsInteger;

          FieldByName('ITE_NUMCMP').AsString  := cdsXML.FieldByName('XML_NUMCMP').AsString;

          if (not fEmptyStr(cdsXML.FieldByName('XML_NUMCMP').AsString)) then
            FieldByName('ITE_NITCMP').AsInteger := cdsXML.FieldByName('XML_NITCMP').AsInteger;

          fatVenda.fltTotCus := fatVenda.fltTotCus + qryGenAbf.FieldByName('PRECUS').AsFloat * cdsXML.FieldByName('PCD_QTDITE').AsFloat;
          fatVenda.fltTotMed := fatVenda.fltTotMed + qryGenAbf.FieldByName('TOTMED').AsFloat;
          fatVenda.fltTotPis := fatVenda.fltTotPis + FieldByName('ITE_VALPIS').AsFloat;
          fatVenda.fltTotCof := fatVenda.fltTotCof + FieldByName('ITE_VALCOF').AsFloat;
          fatVenda.fltTotRmm := fatVenda.fltTotRmm + FieldByName('ITE_VAFRMM').AsFloat;
          fatVenda.fltValFre := fatVenda.fltValFre + cdsXML.FieldByName('ITE_VALFRE').AsFloat;
          fatVenda.fltValSeg := fatVenda.fltValSeg + cdsXML.FieldByName('ITE_VALSEG').AsFloat;
          fatVenda.fltDesAce := fatVenda.fltDesAce + cdsXML.FieldByName('ITE_DESACE').AsFloat;
          fatVenda.fltOutros := fatVenda.fltOutros + cdsXML.FieldByName('ITE_OUTROS').AsFloat;

          fltTxSiscomex := fltTxSiscomex + cdsXMLXML_SISCOM.AsFloat;

          Post;
        End;

        cdsXML.Next;

      End;

      pEnableControls(cdsXML, prcScroll);

    Except

      On E: Exception Do
      Begin
        blnResult := False;
        pEnableControls(cdsXML, prcScroll);
        pMensagensErro(E.Message, 'frmNotaFiscalImport.btnConfirmaClick');
        FreeAndNil(qryGenAbf);
        FreeAndNil(fatVenda);
        Exit;
      End;

    End;

    Try
      fatVenda.strCliEst := fRetNomCidade(qryFornecedor.FieldByName('FOR_CODCID').AsString, 1);
      fatVenda.strCliIes := qryFornecedor.FieldByName('FOR_I_E_S_').AsString;
      fatVenda.strCliAti := qryFornecedor.FieldByName('FOR_CODATI').AsString;
      fatVenda.fltFreDig := fatVenda.fltValFre;
      fatVenda.strMen001 := strInfCplDI;
      fltValFreNota := fatVenda.fltValFre;
      fltDesAceNota := fatVenda.fltDesAce;
      fatVenda.pPreencheMatrizFechamento;
    Except

      On E: Exception Do
      Begin
        blnResult := False;
        pMensagensErro(E.Message, 'frmNotaFiscalImport.btnConfirmaClick');
        FreeAndNil(qryGenAbf);
        Exit;
      End;

      On E: ExceptionAutCom Do
      Begin
        fMensagem('', E.Message, ['&O K']);
        FreeAndNil(qryGenAbf);
        Exit;
      End;

    End;

    fatVenda.pCalculaTotGer;

    If fatVenda.fltImpTax = 0 Then
      fatVenda.fltImpTax := fltTxSiscomex;

    fatVenda.fltTotPis := 0;
    fatVenda.fltTotCof := 0;

    For intPosicao := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
    Begin
      If cdsVenda.Locate('AUTOINCREM', fatVenda.arrMatItens[intPosicao].intAutInc, []) Then
      Begin
        fatVenda.arrMatItens[intPosicao].fltBasPis := cdsVenda.FieldByName('ITE_BASPIS').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltAlqPis := cdsVenda.FieldByName('ITE_ALQPIS').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltValPis := cdsVenda.FieldByName('ITE_VALPIS').AsFloat;

        fatVenda.arrMatItens[intPosicao].fltBasCof := cdsVenda.FieldByName('ITE_BASCOF').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltAlqCof := cdsVenda.FieldByName('ITE_ALQCOF').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltValCof := cdsVenda.FieldByName('ITE_VALCOF').AsFloat;

        fatVenda.arrMatItens[intPosicao].intAdicao := cdsVenda.FieldByName('ITE_ADICAO').AsInteger;

        fatVenda.fltTotPis := fatVenda.fltTotPis + fatVenda.arrMatItens[intPosicao].fltValPis;
        fatVenda.fltTotCof := fatVenda.fltTotCof + fatVenda.arrMatItens[intPosicao].fltValCof;
      End;
    End;
  Finally
    FreeAndNil(qryGenAbf);
    FreeAndNil(qryFornecedor);

    If not blnResult Then
      cdsVenda.EmptyDataSet;
  End;
end;

procedure TfrmNotaFiscalImport.pGravandoDocumento;
var
  ArrLivFis : TArrLivFis;
  blnResult: Boolean;

begin

  fDigDuplic(fatVenda.arrDuplicata,
             mskCndPag.Text,
             0,
             fatVenda.fltTotGer,
             False,
             False,
             False,
             fNow,
             False);

  fatVenda.pAjustaCSTSimples;

  fatVenda.intQtdTra := intVolumeDI;
  fatVenda.fltPesBru := fltPesBruDI;
  fatVenda.fltPesLiq := fltPesLiqDI;
  fatVenda.strEspTra := strEspeciDI;
  fatVenda.strMarTra := strMarca_DI;

  Try
    fStartTransaction;

    fatVenda.strNumDoc := fatVenda.fRetornaSeqNota;

    blnResult := fatVenda.fGNotGer;
    If (Not blnResult) Then
    Begin
      fRollBack;
      Exit;
    End;

    blnResult := fatVenda.fGNotDet;
    If (Not blnResult) Then
    Begin
      fRollBack;
      Exit;
    End;

    fatVenda.pCalculaCadFis(ArrLivFis);

    blnResult := fatVenda.fGCadFisRe(ArrLivFis);
    If (Not blnResult) Then
    Begin
      fRollBack;
      Exit;
    End;

    blnResult := fBaixaPedido(fatVenda.fltTotGer, fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strSerFsc);
    If (Not blnResult) Then
    Begin
      fRollBack;
      Exit;
    End;

    pDeleteBakImp;

    fCommit;

    If (fCfgSis('NFEUSA', varBoolean)) And (fCfgSis('PNLNFE', varBoolean)) And fatVenda.blnGerNFE Then
    Begin
      fExecutarModal(fatVenda.fNotaEletronicaPainel, 'Aguarde ...', '');
    End;

    fMensagem('', 'Documento: ' + fatVenda.strNumDoc + ' - ' + fatVenda.strEspDoc + ' gravado com sucesso!', ['&O k']);

    btnCancPed.Click;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Gravação da Nota de Importação]');
      fRollBack;
      Exit;
    End;
  End;
end;

procedure TfrmNotaFiscalImport.pConfirmaImpXML;
Var
  blnResult: Boolean;
  intPosicao: Integer;
  blnAlterouFrete: Boolean;
  blnAlterouDesAce: Boolean;
  ComposicaoValorContabil: TComposicaoValorContabil;
begin
  If (Not cdsXML.Active) Or
     (cdsXML.IsEmpty)    Then
  Begin
    fMensagem('', 'Não existe itens carregado do XML!', ['&Ok']);
    btnCancPed.Click;
    Exit;
  End;

  fatVenda := TFatVenda.CreateInstance('VN');
  fatVenda.procGravaDI := GravaXMLDI;
  fatVenda.procGetPerfilAduaneiro := GetPerfilAduaneiro;
  fatVenda.intDecImp := PerfilDespachanteAduaneiro.CasasDecimaisArquivo;
  pCriarCdsVenda(fatVenda);

  try

    TfrmGravando.fExecutarModalA(pPreparandoDadosFiscais, 'Preparando dados fiscais . . .', '') ;

    If cdsVenda.isEmpty Then
      Exit;

    Try
      pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
      frmFatDadosFiscais.PerfilDespachanteAduaneiro := Self.PerfilDespachanteAduaneiro;
      frmFatDadosFiscais.fatVenda       := fatVenda;
      frmFatDadosFiscais.blnForcaEdiBas := True;
      frmFatDadosFiscais.blnNotImp      := TRUE;
      frmFatDadosFiscais.blnNotImpXML   := True;
      frmFatDadosFiscais.fValidaValoresDivergentes := fValidaValoresDivergentes;

      frmFatDadosFiscais.ShowModal;

      blnResult := frmFatDadosFiscais.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnResult := False;
        pMensagensErro(E.Message, '[frmNotaFiscalImport.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmFatDadosFiscais);

    If (Not blnResult) Then
      Exit;

    fatVenda.fltTotGer := fatVenda.fltImpTot;
    fatVenda.fltDesAce := fatVenda.fltDesAce + fatVenda.fltOutros;
    pRateiaDespesaAcessoriaNotaImportacao;

    blnAlterouFrete := Not (CompareValue(fatVenda.fltValFre, fltValFreNota, 0.05) = EqualsValue);
    blnAlterouDesAce := Not (CompareValue(fatVenda.fltDesAce, fltDesAceNota, 0.05) = EqualsValue);

    cdsVenda.First;
    For intPosicao := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
    Begin
      If cdsVenda.Locate('AUTOINCREM', fatVenda.arrMatItens[intPosicao].intAutInc, []) Then
      Begin
        If Not blnAlterouFrete Then
          fatVenda.arrMatItens[intPosicao].fltValFre := cdsVenda.FieldByName('ITE_VALFRE').AsFloat;

        If (Not blnAlterouDesAce) And (fatVenda.fltDesAce > 0) Then
          fatVenda.arrMatItens[intPosicao].fltDesAce := cdsVenda.FieldByName('ITE_DESACE').AsFloat;
        fatVenda.arrMatItens[intPosicao].fltVlrCon := 0;
        for ComposicaoValorContabil in PerfilDespachanteAduaneiro.ComposicaoValorContabil  do
        begin
          case ComposicaoValorContabil of
            tcvcVR_PRODUTOS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltTotIte;
            tcvcFRETE:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValFre;
            tcvcSEGURO:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValSeg;
            tcvcVR_ICMS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIcm;
            tcvcPIS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValPis;
            tcvcCOFINS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValCof;
            tcvcIPI:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIpi;
            tcvcII:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltVal_II;
            tcvcSISCOMEX:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltImpTax;
            tcvcAFRMM:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltVafRmm;
            tcvcDESPESAS_ADUANEIRAS:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltDesAdu;
//          tcvcOUTROS:
//            fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltOutVal;
            tcvcIOF:
              fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltValIof;
          end;
        end;
        fatVenda.arrMatItens[intPosicao].fltVlrCon := fatVenda.arrMatItens[intPosicao].fltVlrCon - fatVenda.arrMatItens[intPosicao].fltDesEsp;
        fatVenda.arrMatItens[intPosicao].fltVlrCon :=  fatVenda.arrMatItens[intPosicao].fltVlrCon + fatVenda.arrMatItens[intPosicao].fltDesAce;

        {fatVenda.arrMatItens[intPosicao].fltVlrCon := fatVenda.arrMatItens[intPosicao].fltTotIte +
                                                      fatVenda.arrMatItens[intPosicao].fltValIpi +
                                                      fatVenda.arrMatItens[intPosicao].fltValRet +
                                                      fatVenda.arrMatItens[intPosicao].fltDesAce +
                                                      fatVenda.arrMatItens[intPosicao].fltValFre -
                                                      fatVenda.arrMatItens[intPosicao].fltDesEsp +
                                                      fatVenda.arrMatItens[intPosicao].fltValIcm +
                                                      fatVenda.arrMatItens[intPosicao].fltVal_II +
                                                      fatVenda.arrMatItens[intPosicao].fltDesAdu +
                                                      fatVenda.arrMatItens[intPosicao].fltValIof +
                                                      fatVenda.arrMatItens[intPosicao].fltImpTax +
                                                      fatVenda.arrMatItens[intPosicao].fltValPis +
                                                      fatVenda.arrMatItens[intPosicao].fltValCof +
                                                      fatVenda.arrMatItens[intPosicao].fltVafRmm;}
      End;
    End;

    TfrmGravando.fExecutarModalA(pGravandoDocumento, 'Gravando Nota de Importação . . .', '') ;

    {*******************************************}
    {* IMPRIME A NOTA                          *}
    {****************************************MV*}
    If (Not fatVenda.blnGerNFE) Then
      TReimpressao.Create(fatVenda.strNumDoc, 'NF',
                          0, 0, '', VS_strCodEmp, '', True, 'F', True, False, False, '', '', False, 0, False, 'V').pReimprimeDocumento(True);

  Finally
    FreeAndNil(fatVenda);
  End;
end;

procedure TfrmNotaFiscalImport.pConfirmaItemXML;
Var
  tbmSavePlace: TBookmark;
  strSitTri   : String;
begin
  If Not fValidaPanel(pnlItens, False) Then
    Exit;

  With cdsXML Do
  Begin
    Edit;
    FieldByName('PCD_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
    FieldByName('PCD_UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
    FieldByName('PCD_TOTITE').AsFloat  := fStrToFloat(edtTotIte.Text);
    FieldByName('PCD_SITTRI').AsString := edtSitTri.Text;

    FieldByName('XML_NUMEDI').AsString   := edtNumDi.Text ;
    FieldByName('XML_DATADI').AsDateTime := StrToDateDef(mskDtaDi.Text,0);

    If FieldByName('XML_DATADI').AsDateTime <= 0 Then
      FieldByName('XML_DATADI').Clear;

    FieldByName('XML_LOCDES').AsString   := edtLcDese.Text;
    FieldByName('XML_DTDESE').AsDateTime := StrToDateDef(mskDtDese.Text,0);

    If FieldByName('XML_DTDESE').AsDateTime <= 0 Then
      FieldByName('XML_DTDESE').Clear;

    FieldByName('XML_VIATRA').AsString := Trim(LeftStr(cmbVTrInt.Text, 2));
    FieldByName('XML_TPINTE').AsString := Trim(LeftStr(cmbForImp.Text, 2));
    FieldByName('XML_VAFRMM').AsFloat  := fStrToFloat(edtVAFrMM.Text);
    FieldByName('XML_UFTERC').AsString := Trim(edtUF_Adq.Text);
    FieldByName('XML_CNPJTE').AsString := Trim(mskCgcAdq.Text);

    FieldByName('XML_II_VBC').AsFloat  := fStrToFloat(edtBaseCalculo.Text);
    FieldByName('XML_II_DPA').AsFloat  := fStrToFloat(edtDespAduaneiras.Text);
    FieldByName('XML_II_VII').AsFloat  := fStrToFloat(edtImpostoImportacao.Text);
    FieldByName('XML_II_IOF').AsFloat  := fStrToFloat(edtValorIOF.Text);

    If Length(Trim(edtAdicao.Text)) > 0 Then
      FieldByName('XML_ADICAO').AsInteger := StrToInt(edtAdicao.Text);

    Post;

  End;

  If chkTodosTrib.Checked Then
  Begin
    If fMensagem('', 'Confirma alteração da Situação Tributária para todos os itens?', ['&Sim', '&Não']) = 1 Then
    Begin
      With cdsXML Do
      Begin
        strSitTri := edtSitTri.Text;
        tbmSavePlace := GetBookmark;
        DisableControls;
        First;

        pbProgresso.Visible := True;
        pbProgresso.Max     := RecordCount;

        While Not Eof Do
        Begin
          pbProgresso.Position := RecNo;
          Application.ProcessMessages;

          Edit;
          FieldByName('PCD_SITTRI').AsString := strSitTri;
          Post;


          Next;
        End;

        pbProgresso.Visible := False;

        GotoBookmark(tbmSavePlace);
        EnableControls;
      End;

      chkTodosTrib.Checked := False;
    End;
  End;

  pCalculaTotalXML;
  pSetFocus(dbgItens);
  pnlItens.Enabled := False;
end;

procedure TfrmNotaFiscalImport.btnRatDesAduClick(Sender: TObject);
  Var
    fltDesAdu,
    fltTotPro,
    fltPerCor,
    fltDesAduTot: Double;
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    pRatDesAduXML;
  end
  else
  begin
    fltTotPro := fStrToFloat(edtTotGer.Text);

    If (Not cdsPcmDet.Active) Or (cdsPcmDet.IsEmpty) Or (fltTotPro = 0.00) Then
      Exit;

    If pnlItens.Enabled Then
    Begin
      fMensagem('', 'Antes de Informar o valor das Despesas Aduaneiras, é necessário confirmar o item.', ['&Ok']);
      Exit;
    End;

    fltDesAduTot := 0.00;
    FillChar(recDespesasAduaneiras, SizeOf(recDespesasAduaneiras), #0);

    If TfrmFatDadosFiscais.fInformouDespesasAduaneiras(recDespesasAduaneiras) Then
    Begin
      fltDesAdu := recDespesasAduaneiras.fltTotalD;
      With cdsPcmDet Do
      Begin
        First;
        While Not Eof Do
        Begin
          fltPerCor := FieldByName('PCD_TOTITE').AsFloat / fltTotPro;

          Edit;
          FieldByName('PCD_DESADU').AsFloat := fFormataFloat(fltDesAdu * fltPerCor, 2);
          fltDesAduTot := fltDesAduTot + FieldByName('PCD_DESADU').AsFloat;


          pRecalculaICMS;


          cdsPcmDet.Post;

          cdsPcmDet.Next;
        End;
        First;

        Edit;
        FieldByName('PCD_DESADU').AsFloat := FieldByName('PCD_DESADU').AsFloat + (fFormataFloat(fltDesAdu, 2) - fltDesAduTot);
        pRecalculaICMS;
        Post;
      End;
    End;
  end;
end;

procedure TfrmNotaFiscalImport.cdsXMLAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtNumDi.Text             := cdsXMLXML_NUMEDI.AsString;
  edtLcDese.Text            := cdsXMLXML_LOCDES.AsString;
  edtUF_Adq.Text            := cdsXMLXML_UFTERC.AsString;
  mskCgcAdq.Text            := cdsXMLXML_CNPJTE.AsString;
  edtVAFrMM.Text            := FormatFloat('#,##0.00',cdsXMLXML_VAFRMM.AsFloat);
  edtQtdIte.Text            := FormatFloat('#,##0.00',cdsXMLPCD_QTDITE.AsFloat);
  edtUnitar.Text            := FormatFloat(fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo),cdsXMLPCD_UNITAR.AsFloat);
  edtTotIte.Text            := FormatFloat('#,##0.00',cdsXMLPCD_TOTITE.AsFloat);
  mskDtaDi.Text             := DateToStr(cdsXMLXML_DATADI.AsDateTime);
  mskDtDese.Clear;
  If Not cdsXMLXML_DTDESE.IsNull Then
    mskDtDese.Text            := DateToStr(cdsXMLXML_DTDESE.AsDateTime);
  edtAdicao.Text            := FloatToStr(cdsXMLXML_ADICAO.AsFloat);
  edtBaseCalculo.Text       := FormatFloat('#,##0.00',cdsXMLXML_II_VBC.AsFloat);
  edtDespAduaneiras.Text    := FormatFloat('#,##0.00',cdsXMLXML_II_DPA.AsFloat);
  edtImpostoImportacao.Text := FormatFloat('#,##0.00',cdsXMLXML_II_VII.AsFloat);
  edtValorIOF.Text          := FormatFloat('#,##0.00',cdsXMLXML_II_IOF.AsFloat);
  edtSiscomex.Text          := FormatFloat('#,##0.00',cdsXMLXML_SISCOM.AsFloat);
  edtCodIte.Text            := cdsXMLPCD_CODITE.AsString;
  edtCodFab.Text            := cdsXMLITE_CODFAB.AsString;
  edtDesIte.Text            := cdsXMLPCD_DESITE.AsString;
  edtSitTri.Text            := cdsXMLPCD_SITTRI.AsString;
  edtUfDese.Text            := cdsXMLXML_UFDESE.AsString;
  cmbVTrInt.ItemIndex       := StrToIntDef(cdsXMLXML_VIATRA.AsString,0) - 1;
  cmbForImp.ItemIndex       := StrToIntDef(cdsXMLXML_TPINTE.AsString,0) - 1;
end;

procedure TfrmNotaFiscalImport.cmbForImpChange(Sender: TObject);
begin
  inherited;
  edtUF_Adq.Enabled := False;
  mskCgcAdq.Enabled := False;

  If (LeftStr(cmbForImp.Text, 1) = '2') Or   //2 – IMPORTAÇÃO POR CONTA E ORDEM
     (LeftStr(cmbForImp.Text, 1) = '3') Then //3 – IMPORTAÇÃO POR ENCOMENDA
  Begin
    edtUF_Adq.Enabled := True;
    mskCgcAdq.Enabled := True;
  End;

  If Not edtUF_Adq.Enabled Then
    edtUF_Adq.Clear;

  If Not mskCgcAdq.Enabled Then
    mskCgcAdq.Clear;
end;

procedure TfrmNotaFiscalImport.cmbVTrIntChange(Sender: TObject);
begin
  inherited;
  edtVAFrMM.Enabled := Trim(LeftStr(cmbVTrInt.Text, 2)) = '1';//1 – MARÍTIMA
  If Not edtVAFrMM.Enabled Then
    edtVAFrMM.Text := '0,00';
end;

procedure TfrmNotaFiscalImport.edtCodForExit(Sender: TObject);
begin
  inherited;
  edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);
end;

procedure TfrmNotaFiscalImport.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec) Then
  begin
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmNotaFiscalImport.edtCodPerfilKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqPerfilAduaneiro(Self, edtCodPerfil, edtDescPerfil, nil, Key, arrFornec, True) then
  Begin
    SelectNext(ActiveControl, True, True);
    PerfilDespachanteAduaneiro.CodigoPerfil := edtCodPerfil.Text;
  End;

end;

procedure TfrmNotaFiscalImport.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    objfrmPnl: TPanelCxPedidoCompra;
    chrKey: Char;
    arrPedido: TConsultasArray;

begin
  inherited;

  {**********************************}
  {* NOVA CONSULTA DE PEDIDO COMPRA *}
  {*******************************AC*}

  Try
    objfrmPnl := TPanelCxPedidoCompra.Create(TfrmPnlDadosPedidoCompra);

    chrKey := Key;
    if fPesqPedidoCompraNFImport(Self, edtNumPed, edtNumCtn, qryPcmGer, chrKey, arrPedido, objfrmPnl) then
    begin
        edtNumPed.Text := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
        edtNumCtn.Text := qryPcmGer.FieldByName('PCG_NUMCTN').AsString;

        If (fValidaCampos(edtNumCtn, True)) Then
          pSetFocus(edtDolFec);
    end;

  Finally
    FreeAndNil(objfrmPnl);
  End;

end;

procedure TfrmNotaFiscalImport.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pEditaItem;
  End;
end;

function TfrmNotaFiscalImport.fBaixaPedido(fltValEmi: Double; strDocEmi,
  strEspEmi, strSerEmi: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PCMGER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PCG_JAEMIT = 1, ';
      strSQL := strSQL + '  PCG_DTAEMI = ' + fCurrentDate + ', ';
      strSQL := strSQL + '  PCG_VALEMI = :VALEMI, ';
      strSQL := strSQL + '  PCG_DOCEMI = :DOCEMI, ';
      strSQL := strSQL + '  PCG_ESPEMI = :ESPEMI, ';
      strSQL := strSQL + '  PCG_SEREMI = :SEREMI  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
      strSQL := strSQL + '  PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
      strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCG_NUMCTN = :NUMCTN ';

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALEMI').AsFloat  := fltValEmi;
        ParamByName('DOCEMI').AsString := strDocEmi;
        ParamByName('ESPEMI').AsString := strEspEmi;
        ParamByName('SEREMI').AsString := strSerEmi;
        ParamByName('NUMPED').AsString := edtNumPed.Text;
        ParamByName('NUMCTN').AsString := edtNumCtn.Text;
        ExecSQL;
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PCMDET ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PCD_JAEMIT = 1, ';
      strSQL := strSQL + '  PCD_DTAEMI = ' + fCurrentDate + ', ';
      strSQL := strSQL + '  PCD_VALEMI = :VALEMI, ';
      strSQL := strSQL + '  PCD_DOCEMI = :DOCEMI, ';
      strSQL := strSQL + '  PCD_ESPEMI = :ESPEMI, ';
      strSQL := strSQL + '  PCD_SEREMI = :SEREMI  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCD_ESPDOC = "PD" AND ';
      strSQL := strSQL + '  PCD_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
      strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCD_NUMCTN = :NUMCTN ';

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALEMI').AsFloat  := fltValEmi;
        ParamByName('DOCEMI').AsString := strDocEmi;
        ParamByName('ESPEMI').AsString := strEspEmi;
        ParamByName('SEREMI').AsString := strSerEmi;
        ParamByName('NUMPED').AsString := edtNumPed.Text;
        ParamByName('NUMCTN').AsString := edtNumCtn.Text;
        ExecSQL;
        Close;
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fBaixaPedido]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function TfrmNotaFiscalImport.fBuscaUnidade(strCodIte: string): string;
var
  qryUnidade: TUniQuery;
begin
  try
    Result := '';
    qryUnidade := fCriaQuery();
    qryUnidade.SQL.Add('SELECT ITE_CODUNI FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryUnidade.ParamByName('CODITE').AsString := strCodIte;
    qryUnidade.Open;
    if not qryUnidade.IsEmpty then
    begin
      Result := qryUnidade.FieldByName('ITE_CODUNI').AsString;
    end;
  finally
    FreeAndNil(qryUnidade);
  end;
end;

function TfrmNotaFiscalImport.fBuscaValorSiscomex(strInfCpl: WideString): Double;
var
  strTexto,
  strValor: String;
  I: Integer;
  blnParar: Boolean;
begin
  If fEmptyStr(strInfCpl) Then
    Exit(0);
  strTexto := Trim(strInfCpl);
  I := Pos('SISCOMEX', UpperCase(strTexto)) + Length('SISCOMEX');

  If I <= Length('SISCOMEX') Then
    Exit(0);

  Repeat
    If fEmptyStr(strValor) Then
    Begin
      If (CharInSet(strTexto[I], ['0'..'9'])) Then
        strValor := strValor + strTexto[I]
    End
    Else
    If CharInSet(strTexto[I], ['0'..'9',',','.']) Then
      strValor := strValor + strTexto[I];

    Inc(I);

    blnParar := Not(fEmptyStr(strValor)) And (Not CharInSet(strTexto[I], ['0'..'9',',','.']));
  Until blnParar;

  strValor := StringReplace(strValor, '.', '', [rfReplaceAll]);
  Result := StrToFloat(strValor);
end;

procedure TfrmNotaFiscalImport.pCalculaTotal;
begin
  Try

    If TAggregateField(cdsPcmDet.FieldByName('TOT_TOTITE')).Value = Null Then
      edtTotGer.Text := '0,00'
    Else
      edtTotGer.Text := FloatToStrF(TAggregateField(cdsPcmDet.FieldByName('TOT_TOTITE')).Value,ffFixed,12,2);

  Finally

  End;

end;

procedure TfrmNotaFiscalImport.pCalculaTotalXML;
var
  fltTotIte: Double;
begin
  fltTotIte := 0;
  if (cdsXML.Active) and (not cdsXML.IsEmpty) then
  begin
    cdsXML.DisableControls;
    Try
      cdsXML.First;
      while not cdsXML.Eof do
      begin
        fltTotIte := fltTotIte + cdsXMLPCD_TOTITE.AsFloat;
        cdsXML.Next;
      end;
    Finally
      cdsXML.First;
      cdsXML.EnableControls;
    End;
  end;
  edtTotGer.Text := FormatFloat('#,##0.00', fltTotIte);
end;

procedure TfrmNotaFiscalImport.pCalculaValorNF;
var
  intPosicao: Integer;
begin
  recTotais.fltTotIte_NF := 0;
  recTotais.fltII_NF     := 0;
  recTotais.fltIPI_NF    := 0;
  recTotais.fltPIS_NF    := 0;
  recTotais.fltCOFINS_NF := 0;
  recTotais.fltSiscom_NF := 0;
  recTotais.fltAFRMM_NF  := 0;
  recTotais.fltICMS_NF   := 0;

  cdsVenda.First;
  For intPosicao := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
  Begin
    If cdsVenda.Locate('AUTOINCREM', fatVenda.arrMatItens[intPosicao].intAutInc, []) Then
    Begin
      recTotais.fltTotIte_NF := recTotais.fltTotIte_NF + fatVenda.arrMatItens[intPosicao].fltTotIte;
      recTotais.fltII_NF     := recTotais.fltII_NF + fatVenda.arrMatItens[intPosicao].fltVal_II;
      recTotais.fltIPI_NF    := recTotais.fltIPI_NF + fatVenda.arrMatItens[intPosicao].fltValIpi;
      recTotais.fltPIS_NF    := recTotais.fltPIS_NF + fatVenda.arrMatItens[intPosicao].fltValPis;
      recTotais.fltCOFINS_NF := recTotais.fltCOFINS_NF + fatVenda.arrMatItens[intPosicao].fltValCof;
      recTotais.fltSiscom_NF := recTotais.fltSiscom_NF + fatVenda.arrMatItens[intPosicao].fltImpTax;
      recTotais.fltAFRMM_NF  := recTotais.fltAFRMM_NF + fatVenda.arrMatItens[intPosicao].fltVafRmm;
      recTotais.fltICMS_NF   := recTotais.fltICMS_NF + fatVenda.arrMatItens[intPosicao].fltValIcm;
    End;
  End;
end;

procedure TfrmNotaFiscalImport.pEscapePressed;
begin

  If (ActiveControl) = dbgItens Then
    btnCancPed.Click
  Else
    inherited;

end;

procedure TfrmNotaFiscalImport.pRatDesAduXML;
  Var
    fltDesAdu,
    fltTotPro,
    fltPerCor,
    fltDesAduTot: Double;
begin
  inherited;

  fltTotPro := fStrToFloat(edtTotGer.Text);

  If (Not cdsXML.Active) Or (cdsXML.IsEmpty) Or (fltTotPro = 0.00) Then
    Exit;

  If pnlItens.Enabled Then
  Begin
    fMensagem('', 'Antes de Informar o valor das Despesas Aduaneiras, é necessário confirmar o item.', ['&Ok']);
    Exit;
  End;

  fltDesAduTot := 0.00;
  FillChar(recDespesasAduaneiras, SizeOf(recDespesasAduaneiras), #0);

  If TfrmFatDadosFiscais.fInformouDespesasAduaneiras(recDespesasAduaneiras) Then
  Begin
    fltDesAdu := recDespesasAduaneiras.fltTotalD;
    With cdsXML Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('PCD_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('XML_II_DPA').AsFloat := fFormataFloat(fltDesAdu * fltPerCor, 2);
        fltDesAduTot := fltDesAduTot + FieldByName('XML_II_DPA').AsFloat;
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('XML_II_DPA').AsFloat := FieldByName('XML_II_DPA').AsFloat + (fFormataFloat(fltDesAdu, 2) - fltDesAduTot);
      Post;
    End;
  End;

end;

procedure TfrmNotaFiscalImport.edtSitTriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSitTrib: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE SIT. TRIBUTÁRIA *}
  {*********************************RV*}
  If fPesqSitTributaria(Self, edtSitTri, Nil, Nil, Key, arrSitTrib) Then
  Begin
    if fValidaCampos(edtSitTri) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmNotaFiscalImport.edtUnitarExit(Sender: TObject);
begin
  inherited;
  edtTotIte.Text := FloatToStr(fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text));
end;

procedure TfrmNotaFiscalImport.FormShow(Sender: TObject);
begin
  inherited;
  qryCadTri := fCriarQuery('SELECT * FROM CADTRI WHERE FALSE');
  edtUnitar.EditFormat := fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
  edtDolFec.EditFormat := fMskDigitos(PerfilDespachanteAduaneiro.CasasDecimaisArquivo);
  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));

  pSetaCodIte( edtCodIte );
  pSetaCodIte( cdsXMLPCD_CODITE );
end;

procedure TfrmNotaFiscalImport.pCarregaCadTri;
begin
  pPesquisaCadTri(qryCadTri, qryCadTri, edtSitTri.Text);
end;

function TfrmNotaFiscalImport.fRetNotaFiscalMae: String;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_DOCEMI, ';
    strSQL := strSQL + '  PCG_ESPEMI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := edtNumPed.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := Fields[0].AsString + '-' + Fields[1].AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function TfrmNotaFiscalImport.fTemValoresDivergentes: Boolean;
begin
  Result := True;

  If fFormataFloat(abs(fFormataFloat(recTotais.fltTotIte_DI, 2) - fFormataFloat(recTotais.fltTotIte_NF, 2)), 2) > 0.05 Then
    Exit;

  if fFormataFloat(recTotais.fltII_DI, 2) <> fFormataFloat(recTotais.fltII_NF, 2) then
    Exit;

  if fFormataFloat(recTotais.fltIPI_DI, 2) <> fFormataFloat(recTotais.fltIPI_NF, 2) then
    Exit;

  if fFormataFloat(recTotais.fltPIS_DI, 2) <> fFormataFloat(recTotais.fltPIS_NF, 2) then
    Exit;

  if fFormataFloat(recTotais.fltCOFINS_DI, 2) <> fFormataFloat(recTotais.fltCOFINS_NF, 2) then
    Exit;

  if fFormataFloat(recTotais.fltAFRMM_DI, 2) <> fFormataFloat(recTotais.fltAFRMM_NF, 2) then
    Exit;

  if fFormataFloat(recTotais.fltICMS_DI, 2) <> fFormataFloat(recTotais.fltICMS_NF, 2) then
    Exit;

  Result := False;
end;

function TfrmNotaFiscalImport.fPedidoMaeBaixado: Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_JAEMIT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_NUMCTN = 0 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := edtNumPed.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := (Fields[0].AsInteger = 1);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function TfrmNotaFiscalImport.fValidaDadosDI: Boolean;
  var
    stlNum_Di: TStringList;
begin

  cdsPcmDet.First;
  Result := True;

  stlNum_Di := TStringList.Create;

  While (Not cdsPcmDet.Eof) Do
  Begin
    If fEmptyStr(cdsPcmDet.FieldByName('PCD_NUM_DI').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário preencher os dados de importação de todos os itens.', ['&Ok']);
      Result := False;
      Break;
    End;

    stlNum_Di.Add(cdsPcmDet.FieldByName('PCD_NUM_DI').AsString);

    cdsPcmDet.Next;
  End;

  FreeAndNil(stlNum_Di);

end;

function TfrmNotaFiscalImport.fValidaValoresDivergentes: Boolean;
var
  frmNotaFiscalImportMostraDiverg: TfrmNotaFiscalImportMostraDiverg;
begin
  Result := True;

  pCalculaValorNF;

  if not fTemValoresDivergentes then
    Exit;

  pCriarFormularios(TfrmNotaFiscalImportMostraDiverg, frmNotaFiscalImportMostraDiverg);
  try
    frmNotaFiscalImportMostraDiverg.PerfilDespachanteAduaneiro := PerfilDespachanteAduaneiro;
    frmNotaFiscalImportMostraDiverg.recTotais := recTotais;
    frmNotaFiscalImportMostraDiverg.cdsItens_DI := cdsXML;

    Result := frmNotaFiscalImportMostraDiverg.ShowModal = mrOK;
  finally
    pFreeAndNil(frmNotaFiscalImportMostraDiverg);
  end;
end;

function TfrmNotaFiscalImport.GetPerfilAduaneiro: string;
begin
  Result := PerfilDespachanteAduaneiro.CodigoPerfil;
end;

procedure TfrmNotaFiscalImport.GravaXMLDI(AAutInc: string);
var qryComand: TUniQuery;
begin
  If fEmptyStr(edtArqXML.Text) then
    Exit;
  If rdgTipoImportacao.ItemIndex = 0 then
    Exit;

  qryComand := fCriaQuery();
  try
    qryComand.SQL.Text := 'SELECT * FROM XML_DI WHERE FALSE';
    qryComand.Open;
    qryComand.Append;

    qryComand.FieldByName('XML_SEQGER').AsString   := AAutInc;
    TBlobField(qryComand.FieldByName('XML_ARQUIV')).LoadFromFile(edtArqXML.Text);
    qryComand.FieldByName('XML_CFGPER').AsString := PerfilDespachanteAduaneiro.GetConfiguracoesText;

    qryComand.Post;
    qryComand.Close;
  finally
    FreeAndNil(qryComand);
  End;
end;

procedure TfrmNotaFiscalImport.OnImportErro(strNumDoc, strSerie, strNomArq,
  strMensagem: String);
begin
  pMensagemOk(strMensagem);
end;

procedure TfrmNotaFiscalImport.pCopiarDadosDi;
  Var
    strLcDese,
    strUf_Adq,   //SIGLA UF DO ADQUIRENTE OU DO ENCOMENDANTE
    strCgcAdq,   //CNPJ DO ADQUIRENTE OU DO ENCOMENDANTE
    strForImp,   //FORMA DE IMPORTAÇÃO QUANTO A INTERMEDIAÇÃO
    strVTrInt,   //VIA DE TRANSPORTE INTERNACIONAL
    strNumDi: String;
    dtaDtaDi,
    dtaDtDese: TDateTime;
    intAdicao: Integer;
begin
  If pnlItens.Enabled Then
  Begin
    fMensagem('', 'Antes de realizar a cópia, é necessário confirmar o item.', ['&Ok']);
  End
  Else
  Begin
    If fMensagem('', 'Confirma realizar a cópia do DI deste produto para todos os outros?', ['&Sim', '&Não']) = 1 Then
    Begin

      strNumDi := cdsPcmDet.FieldByName('PCD_NUM_DI').AsString;
      dtaDtaDi := cdsPcmDet.FieldByName('PCD_DTA_DI').AsDateTime;
      strLcDese := cdsPcmDet.FieldByName('PCD_LCDESE').AsString;
      dtaDtDese := cdsPcmDet.FieldByName('PCD_DTDESE').AsDateTime;
      strVTrInt := cdsPcmDet.FieldByName('PCD_VTRINT').AsString;
      strForImp := cdsPcmDet.FieldByName('PCD_FORIMP').AsString;
      strCgcAdq := cdsPcmDet.FieldByName('PCD_CGCADQ').AsString;
      strUf_Adq := cdsPcmDet.FieldByName('PCD_UF_ADQ').AsString;
      intAdicao := cdsPcmDet.FieldByName('PCD_ADICAO').AsInteger;

      cdsPcmDet.DisableControls;

      pbProgresso.Visible := True;
      pbProgresso.Max     := cdsPcmDet.RecordCount;

      cdsPcmDet.First;
      While (Not cdsPcmDet.Eof) Do
      Begin
        pbProgresso.Position := cdsPcmDet.RecNo;
        Application.ProcessMessages;

        cdsPcmDet.Edit;

        cdsPcmDet.FieldByName('PCD_NUM_DI').AsString := strNumDi;
        cdsPcmDet.FieldByName('PCD_DTA_DI').AsDateTime := dtaDtaDi;
        cdsPcmDet.FieldByName('PCD_LCDESE').AsString := strLcDese;
        cdsPcmDet.FieldByName('PCD_DTDESE').AsDateTime := dtaDtDese;
        cdsPcmDet.FieldByName('PCD_VTRINT').AsString := strVTrInt;
        cdsPcmDet.FieldByName('PCD_FORIMP').AsString := strForImp;
        cdsPcmDet.FieldByName('PCD_CGCADQ').AsString := strCgcAdq;
        cdsPcmDet.FieldByName('PCD_UF_ADQ').AsString := strUf_Adq;
        cdsPcmDet.FieldByName('PCD_ADICAO').AsInteger := intAdicao;

        cdsPcmDet.Post;

        pSalvaDigitacaoItensNotaImportacao;

        cdsPcmDet.Next;
      End;

      pbProgresso.Visible := False;

      cdsPcmDet.EnableControls;
    End;
  End;
end;

procedure TfrmNotaFiscalImport.pCopiarDadosDiXML;
  Var
    strLcDese,
    strUf_Adq,   //SIGLA UF DO ADQUIRENTE OU DO ENCOMENDANTE
    strCgcAdq,   //CNPJ DO ADQUIRENTE OU DO ENCOMENDANTE
    strForImp,   //FORMA DE IMPORTAÇÃO QUANTO A INTERMEDIAÇÃO
    strVTrInt,   //VIA DE TRANSPORTE INTERNACIONAL
    strNumDi: String;
    dtaDtaDi,
    dtaDtDese: TDateTime;
    intAdicao: Integer;
begin
  If pnlItens.Enabled Then
  Begin
    fMensagem('', 'Antes de realizar a cópia, é necessário confirmar o item.', ['&Ok']);
  End
  Else
  Begin
    If fMensagem('', 'Confirma realizar a cópia do DI deste produto para todos os outros?', ['&Sim', '&Não']) = 1 Then
    Begin

      strNumDi  := cdsXML.FieldByName('XML_NUMEDI').AsString;
      dtaDtaDi  := cdsXML.FieldByName('XML_DATADI').AsDateTime;
      strLcDese := cdsXML.FieldByName('XML_LOCDES').AsString;
      dtaDtDese := cdsXML.FieldByName('XML_DTDESE').AsDateTime;
      strVTrInt := cdsXML.FieldByName('XML_VIATRA').AsString;
      strForImp := cdsXML.FieldByName('XML_TPINTE').AsString;
      strCgcAdq := cdsXML.FieldByName('XML_CNPJTE').AsString;
      strUf_Adq := cdsXML.FieldByName('XML_UFTERC').AsString;
      intAdicao := cdsXML.FieldByName('XML_ADICAO').AsInteger;

      cdsXML.DisableControls;

      pbProgresso.Visible := True;
      pbProgresso.Max     := cdsXML.RecordCount;

      cdsXML.First;
      While (Not cdsXML.Eof) Do
      Begin
        pbProgresso.Position := cdsXML.RecNo;
        Application.ProcessMessages;

        cdsXML.Edit;

        cdsXML.FieldByName('XML_NUMEDI').AsString := strNumDi;
        cdsXML.FieldByName('XML_DATADI').AsDateTime := dtaDtaDi;
        cdsXML.FieldByName('XML_LOCDES').AsString := strLcDese;
        cdsXML.FieldByName('XML_DTDESE').AsDateTime := dtaDtDese;
        cdsXML.FieldByName('XML_VIATRA').AsString := strVTrInt;
        cdsXML.FieldByName('XML_TPINTE').AsString := strForImp;
        cdsXML.FieldByName('XML_CNPJTE').AsString := strCgcAdq;
        cdsXML.FieldByName('XML_UFTERC').AsString := strUf_Adq;
        cdsXML.FieldByName('XML_ADICAO').AsInteger := intAdicao;

        cdsXML.Post;

        cdsXML.Next;
      End;

      pbProgresso.Visible := False;

      cdsXML.EnableControls;
    End;
  End;
end;

procedure TfrmNotaFiscalImport.pDeleteBakImp;
var
  qryBakImp: TUniQuery;
begin
  qryBakImp := fCriaQuery(Self);

  try
    qryBakImp.SQL.Text := 'DELETE FROM BAKIMP WHERE IMP_ARQUIV = :NOMARQ AND IMP_CODFOR = :CODFOR AND IMP_CODEMP = :CODEMP ';
    qryBakImp.ParamByName('NOMARQ').AsString := strNomArq;
    qryBakImp.ParamByName('CODFOR').AsString := Trim(edtCodFor.Text);
    qryBakImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBakImp.ExecSQL;
  finally
    FreeAndNil(qryBakImp);
  end;
end;

procedure TfrmNotaFiscalImport.pSalvaDigitacaoItensNotaImportacao;
  Var
    qryExec: TUniQuery;
begin
  qryExec := fCriaQuery;

  With qryExec, SQL Do
  Begin
    Add('  REPLACE INTO PCMIMP (');
    Add('    PCI_SEQPCD,        ');
    Add('    PCI_QTDITE,        ');
    Add('    PCI_UNITAR,        ');
    Add('    PCI_TOTITE,        ');
    Add('    PCI_SITTRI,        ');
    Add('    PCI_NUM_DI,        ');
    Add('    PCI_DTA_DI,        ');
    Add('    PCI_LCDESE,        ');
    Add('    PCI_UFDESE,        ');
    Add('    PCI_DTDESE,        ');
    Add('    PCI_BASEII,        ');
    Add('    PCI_DESADU,        ');
    Add('    PCI_VAL_II,        ');
    Add('    PCI_CGCADQ,        ');
    Add('    PCI_FORIMP,        ');
    Add('    PCI_UF_ADQ,        ');
    Add('    PCI_VAFRMM,        ');
    Add('    PCI_VTRINT,        ');
    Add('    PCI_VALIOF,        ');
    Add('    PCI_ADICAO)        ');
    Add('  VALUES (             ');
    Add('    :SEQPCD,           ');
    Add('    :QTDITE,           ');
    Add('    :UNITAR,           ');
    Add('    :TOTITE,           ');
    Add('    :SITTRI,           ');
    Add('    :NUM_DI,           ');
    Add('    :DTA_DI,           ');
    Add('    :LCDESE,           ');
    Add('    :UFDESE,           ');
    Add('    :DTDESE,           ');
    Add('    :BASEII,           ');
    Add('    :DESADU,           ');
    Add('    :VAL_II,           ');
    Add('    :CGCADQ,           ');
    Add('    :FORIMP,           ');
    Add('    :UF_ADQ,           ');
    Add('    :VAFRMM,           ');
    Add('    :VTRINT,           ');
    Add('    :VALIOF,           ');
    Add('    :ADICAO)           ');

    ParamByName('SEQPCD').Value := cdsPcmDet.FieldByName('AUTOINCREM').Value;
    ParamByName('QTDITE').Value := cdsPcmDet.FieldByName('PCD_QTDITE').Value;
    ParamByName('UNITAR').Value := cdsPcmDet.FieldByName('PCD_UNITAR').Value;
    ParamByName('TOTITE').Value := cdsPcmDet.FieldByName('PCD_TOTITE').Value;
    ParamByName('SITTRI').Value := cdsPcmDet.FieldByName('PCD_SITTRI').Value;
    ParamByName('NUM_DI').Value := cdsPcmDet.FieldByName('PCD_NUM_DI').Value;
    ParamByName('DTA_DI').Value := cdsPcmDet.FieldByName('PCD_DTA_DI').Value;
    ParamByName('LCDESE').Value := cdsPcmDet.FieldByName('PCD_LCDESE').Value;
    ParamByName('UFDESE').Value := edtUfDese.Text;
    ParamByName('DTDESE').Value := cdsPcmDet.FieldByName('PCD_DTDESE').Value;
    ParamByName('VAFRMM').Value := cdsPcmDet.FieldByName('PCD_VAFRMM').Value;
    ParamByName('UF_ADQ').Value := cdsPcmDet.FieldByName('PCD_UF_ADQ').Value;
    ParamByName('BASEII').Value := cdsPcmDet.FieldByName('PCD_BASEII').Value;
    ParamByName('DESADU').Value := cdsPcmDet.FieldByName('PCD_DESADU').Value;
    ParamByName('VAL_II').Value := cdsPcmDet.FieldByName('PCD_VAL_II').Value;
    ParamByName('VALIOF').Value := cdsPcmDet.FieldByName('PCD_VALIOF').Value;
    ParamByName('CGCADQ').Value := cdsPcmDet.FieldByName('PCD_CGCADQ').Value;
    ParamByName('FORIMP').Value := cdsPcmDet.FieldByName('PCD_FORIMP').Value;
    ParamByName('VAFRMM').Value := cdsPcmDet.FieldByName('PCD_VAFRMM').Value;
    ParamByName('VTRINT').Value := cdsPcmDet.FieldByName('PCD_VTRINT').Value;
    ParamByName('ADICAO').Value := cdsPcmDet.FieldByName('PCD_ADICAO').Value;

    ExecSQL;
  End;

  FreeAndNil(qryExec);
end;

procedure TfrmNotaFiscalImport.rdgTipoImportacaoClick(Sender: TObject);
begin
  inherited;
  if rdgTipoImportacao.ItemIndex = 1 then
  begin
    lblCodFor.Visible     := True;
    edtCodFor.Visible     := True;
    edtDesFor.Visible     := True;
    lblArqXML.Visible     := True;
    edtArqXML.Visible     := True;
    lblSiscomex.Visible   := True;
    edtSiscomex.Visible   := True;
    lblImpFre.Visible     := True;
    edtImpFre.Visible     := True;
    clbImpFre.Visible     := True;
    edtNumPed.Visible     := False;
    edtNumCtn.Visible     := False;
    Label1.Visible        := False;
    Label2.Visible        := False;
    edtForPed.Visible     := False;
    Label3.Visible        := False;
    edtDtaEnt.Visible     := False;
    Label4.Visible        := False;
    edtCompra.Visible     := False;
    edtCndPag.Visible     := False;
    mskCndPag.Visible     := True;

    dtsPcmDet.DataSet     := cdsXML;
    pSetFocus(edtCodFor);
    lblPerfilAduaneiro.Visible := True;
    edtCodPerfil.Visible := True;
    edtDescPerfil.Visible := True;
  end
  else
  begin
    lblCodFor.Visible     := False;
    edtCodFor.Visible     := False;
    edtDesFor.Visible     := False;
    lblArqXML.Visible     := False;
    edtArqXML.Visible     := False;
    lblSiscomex.Visible   := False;
    edtSiscomex.Visible   := False;
    lblImpFre.Visible     := False;
    edtImpFre.Visible     := False;
    clbImpFre.Visible     := False;
    edtNumPed.Visible     := True;
    edtNumCtn.Visible     := True;
    Label1.Visible        := True;
    Label2.Visible        := True;
    edtForPed.Visible     := True;
    Label3.Visible        := True;
    edtDtaEnt.Visible     := True;
    Label4.Visible        := True;
    edtCompra.Visible     := True;
    edtCndPag.Visible     := True;
    mskCndPag.Visible     := False;
    dtsPcmDet.DataSet     := cdsPcmDet;
    pSetFocus(edtNumPed);
    lblPerfilAduaneiro.Visible := False;
    edtCodPerfil.Visible := False;
    edtDescPerfil.Visible := False;
  end;
end;

procedure TfrmNotaFiscalImport.pCarregaDigitacaoItensNotaImportacao;
  Var
    qryItemDig: TUniQuery;
begin
  qryItemDig := fCriaQuery;

  With qryItemDig, SQL Do
  Begin
    Add('SELECT SQL_NO_CACHE * FROM PCMIMP WHERE PCI_SEQPCD = :SEQPCD');
  End;

  With cdsPcmDet Do
  Begin
    First;

    pbProgresso.Visible := True;
    pbProgresso.Max     := RecordCount;

    While (Not Eof) Do
    Begin
      qryItemDig.Close;
      qryItemDig.ParamByName('SEQPCD').AsString := FieldByName('AUTOINCREM').AsString;
      qryItemDig.Open;

      pbProgresso.Position := RecNo;
      Application.ProcessMessages;

      If Not qryItemDig.IsEmpty Then
      Begin
        Edit;

        FieldByName('PCD_QTDITE').Value := qryItemDig.FieldByName('PCI_QTDITE').Value;
        FieldByName('PCD_UNITAR').Value := qryItemDig.FieldByName('PCI_UNITAR').Value;
        FieldByName('PCD_TOTITE').Value := qryItemDig.FieldByName('PCI_TOTITE').Value;
        FieldByName('PCD_SITTRI').Value := qryItemDig.FieldByName('PCI_SITTRI').Value;
        FieldByName('PCD_NUM_DI').Value := qryItemDig.FieldByName('PCI_NUM_DI').Value;
        FieldByName('PCD_DTA_DI').Value := qryItemDig.FieldByName('PCI_DTA_DI').Value;
        FieldByName('PCD_LCDESE').Value := qryItemDig.FieldByName('PCI_LCDESE').Value;

        If Not fEmptyStr(qryItemDig.FieldByName('PCI_UFDESE').AsString) Then
          edtUfDese.Text := qryItemDig.FieldByName('PCI_UFDESE').AsString;

        FieldByName('PCD_DTDESE').Value := qryItemDig.FieldByName('PCI_DTDESE').Value;
        FieldByName('PCD_BASEII').Value := qryItemDig.FieldByName('PCI_BASEII').Value;
        FieldByName('PCD_DESADU').Value := qryItemDig.FieldByName('PCI_DESADU').Value;
        FieldByName('PCD_VAL_II').Value := qryItemDig.FieldByName('PCI_VAL_II').Value;
        FieldByName('PCD_VALIOF').Value := qryItemDig.FieldByName('PCI_VALIOF').Value;
        FieldByName('PCD_VTRINT').Value := qryItemDig.FieldByName('PCI_VTRINT').Value;
        FieldByName('PCD_FORIMP').Value := qryItemDig.FieldByName('PCI_FORIMP').Value;
        FieldByName('PCD_VAFRMM').Value := qryItemDig.FieldByName('PCI_VAFRMM').Value;
        FieldByName('PCD_UF_ADQ').Value := qryItemDig.FieldByName('PCI_UF_ADQ').Value;
        FieldByName('PCD_CGCADQ').Value := qryItemDig.FieldByName('PCI_CGCADQ').Value;
        FieldByName('PCD_FORIMP').Value := qryItemDig.FieldByName('PCI_FORIMP').Value;
        FieldByName('PCD_UF_ADQ').Value := qryItemDig.FieldByName('PCI_UF_ADQ').Value;
        FieldByName('PCD_VAFRMM').Value := qryItemDig.FieldByName('PCI_VAFRMM').Value;
        FieldByName('PCD_VTRINT').Value := qryItemDig.FieldByName('PCI_VTRINT').Value;
        FieldByName('PCD_ADICAO').Value := qryItemDig.FieldByName('PCI_ADICAO').Value;
        Post;
      End;

      Next;
    End;

    pbProgresso.Visible := False;

    First;
  End;

  FreeAndNil(qryItemDig);
end;

function TfrmNotaFiscalImport.fJaPossuiDigitacaoItensNotaImportacao: Boolean;
  Var
    qryItemDig: TUniQuery;
begin
  qryItemDig := fCriaQuery;

  With qryItemDig, SQL Do
  Begin
    Add('SELECT SQL_NO_CACHE * FROM PCMIMP WHERE PCI_SEQPCD = :SEQPCD');
  End;

  Result := False;

  With cdsPcmDet Do
  Begin
    First;

    While (Not Eof) Do
    Begin
      qryItemDig.Close;
      qryItemDig.ParamByName('SEQPCD').AsString := FieldByName('AUTOINCREM').AsString;
      qryItemDig.Open;

      If Not qryItemDig.IsEmpty Then
      Begin
        Result := True;
        Break;
      End;

      Next;
    End;

    First;
  End;

  FreeAndNil(qryItemDig);
end;

function TfrmNotaFiscalImport.pValidarCampo(strCampo: String; varValor: Variant): Boolean;
Begin
  Result := VarCompareValue(cdsXML.FieldByName(strCampo).Value, varValor) = vrEqual;
End;

function TfrmNotaFiscalImport.fValidarDataXML: Boolean;
Var
  strDatDes: String;
Begin
  If (Not cdsXML.Active) Or
     (cdsXML.IsEmpty)    Then
  Begin
    fMensagem('', 'Não existe itens carregado do XML!', ['&Ok']);
    Exit(False);
  End;

  cdsXML.First;
  strDatDes := '';
  While Not cdsXML.Eof Do
  Begin
    If pValidarCampo('XML_DTDESE',null) Then
      strDatDes :=  strDatDes +
        cdsXML.FieldByName('PCD_CODITE').AsString +
        ' - ' +
        cdsXML.FieldByName('PCD_DESITE').AsString + #13;
    cdsXML.Next;
  End;
  If Not fEmptyStr(strDatDes) Then
  Begin
    strDatDes := 'A Data Desembaraço para o(s) produto(s) abaixo não foi informada:' + #13+
      strDatDes;
    fMensagem('ATENÇÃO!', strDatDes, ['&Ok']);
  End;
  Result := fEmptyStr(strDatDes);
End;

procedure TfrmNotaFiscalImport.pRecalculaICMS;
var
  fltFrac, fltAlqReduzida: Double;
  CalculoBaseICMSNotaImp: TConjCalculoBaseICMSNotaImp;
begin
  CalculoBaseICMSNotaImp := fGetCfgCalculoBaseICMSNotaImportacao;

  cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_TOTITE').AsFloat;
  If cbiniII in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_VAL_II').AsFloat;
  If cbiniIPI in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_TOTIPI').AsFloat;
  If cbiniPIS_COFINS in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_VALPIS').AsFloat +
                                                                                                 cdsPcmDet.FieldByName('PCD_VALCOF').AsFloat;
  If cbiniSiscomex in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_VALSIS').AsFloat;
  If cbiniAFRMM in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_VALMAR').AsFloat;
  If cbiniDespeasAduaneira in CalculoBaseICMSNotaImp Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := cdsPcmDet.FieldByName('PCD_BASICM').AsFloat + cdsPcmDet.FieldByName('PCD_DESADU').AsFloat;

  fltAlqReduzida := (cdsPcmDet.FieldByName('PCD_ALQICM').AsFloat * cdsPcmDet.FieldByName('PCD_PERBAS').AsFloat) / 100;

  fltFrac := ( 1 -  (fltAlqReduzida / 100));
  If fltFrac <=0 Then
    fltFrac := 0.0001;

  fltAlqReduzida := (cdsPcmDet.FieldByName('PCD_ALQICM').AsFloat * cdsPcmDet.FieldByName('PCD_PERBAS').AsFloat) / 100;
  cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := RoundTo( cdsPcmDet.FieldByName('PCD_BASICM').AsFloat / (fltFrac), -2);

  cdsPcmDet.FieldByName('PCD_VALICM').AsFloat := RoundTo( cdsPcmDet.FieldByName('PCD_BASICM').AsFloat * (fltAlqReduzida / 100), -2);
  If cdsPcmDet.FieldByName('PCD_ALQICM').AsFloat > 0 Then
    cdsPcmDet.FieldByName('PCD_BASICM').AsFloat := RoundTo( cdsPcmDet.FieldByName('PCD_VALICM').AsFloat * 100 / cdsPcmDet.FieldByName('PCD_ALQICM').AsFloat, -2);
End;

end.

