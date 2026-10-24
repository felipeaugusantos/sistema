unit untRelRetBco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils, RlReport, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Uni, AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untZClient, cxProgressBar, Math, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckListBox, Data.DB,
  Datasnap.DBClient, cxCustomListBox,untCfgRel, MemDS, DBAccess,
  Datasnap.Provider, UniDataSetProvider, UniClientDataSet, RLFilters,
  RLDraftFilter;

type
  TfrmRelRetBco = class(TfrmPaiRelatorio)
    pnlTopo: TPanel;
    gpbOrdem: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOrdem: TEditFocus;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtDados: TEditFocus;
    lstCodOco: TcxCheckListBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    ColorLabel4: TColorLabel;
    edtExibirCodCliente: TEditFocus;
    Label2: TLabel;
    frxRetBco: TfrxReport;
    frxDBDatasetBco: TfrxDBDataset;
    qryRetBco: TUniQuery;
    qryRetBcoCODOCO: TStringField;
    qryRetBcoNOSNUM: TStringField;
    qryRetBcoNUMDUP: TStringField;
    qryRetBcoCODEMP: TStringField;
    qryRetBcoDTAVEN: TDateField;
    qryRetBcoDTAPAG: TDateField;
    qryRetBcoVALPAG: TFloatField;
    qryRetBcoJURMOR: TFloatField;
    qryRetBcoDESCON: TFloatField;
    qryRetBcoRET_CODREJ: TStringField;
    qryRetBcoRET_CODBCO: TStringField;
    qryRetBcoOUTVAL: TFloatField;
    qryRetBcoVALDUP: TFloatField;
    qryRetBcoCARTEI: TIntegerField;
    qryRetBcoTARIFA: TFloatField;
    qryRetBcoCODCLI: TStringField;
    qryRetBcoDTARET: TDateField;
    qryRetBcoNOMARQ: TStringField;
    qryRetBcoCEPCLI: TStringField;
    qryRetBcoCTR_DTAVEN: TDateField;
    qryRetBcoCTR_VALORI: TFloatField;
    qryRetBcoCTR_VALDUP: TFloatField;
    qryRetBcoVALCOR: TFloatField;
    qryRetBcoCTR_DESSUJ: TFloatField;
    qryRetBcoVALDIF: TFloatField;
    qryRetBcoCODMOT: TStringField;
    qryRetBcoDESMOT: TStringField;
    qryRetBcoCUSCAR: TFloatField;
    qryRetBcoCARBCO: TStringField;
    qryRetBcoIOFDES: TFloatField;
    qryRetBcoTXADES: TFloatField;
    qryRetBcoJUROPE: TFloatField;
    cdsRetBco: TUniClientDataSet;
    dspRetBco: TUniDataSetProvider;
    cdsRetBcoCODOCO: TStringField;
    cdsRetBcoNOSNUM: TStringField;
    cdsRetBcoNUMDUP: TStringField;
    cdsRetBcoCODEMP: TStringField;
    cdsRetBcoDTAVEN: TDateField;
    cdsRetBcoDTAPAG: TDateField;
    cdsRetBcoVALPAG: TFloatField;
    cdsRetBcoJURMOR: TFloatField;
    cdsRetBcoDESCON: TFloatField;
    cdsRetBcoRET_CODREJ: TStringField;
    cdsRetBcoRET_CODBCO: TStringField;
    cdsRetBcoOUTVAL: TFloatField;
    cdsRetBcoVALDUP: TFloatField;
    cdsRetBcoCARTEI: TIntegerField;
    cdsRetBcoTARIFA: TFloatField;
    cdsRetBcoCODCLI: TStringField;
    cdsRetBcoDTARET: TDateField;
    cdsRetBcoNOMARQ: TStringField;
    cdsRetBcoCEPCLI: TStringField;
    cdsRetBcoCTR_DTAVEN: TDateField;
    cdsRetBcoCTR_VALORI: TFloatField;
    cdsRetBcoCTR_VALDUP: TFloatField;
    cdsRetBcoVALCOR: TFloatField;
    cdsRetBcoCTR_DESSUJ: TFloatField;
    cdsRetBcoVALDIF: TFloatField;
    cdsRetBcoCODMOT: TStringField;
    cdsRetBcoDESMOT: TStringField;
    cdsRetBcoCUSCAR: TFloatField;
    cdsRetBcoCARBCO: TStringField;
    cdsRetBcoIOFDES: TFloatField;
    cdsRetBcoTXADES: TFloatField;
    cdsRetBcoJUROPE: TFloatField;
    frxDBDatasetOcor: TfrxDBDataset;
    qryOcorr: TUniQuery;
    frxDBDatasetTotOcor: TfrxDBDataset;
    qryTotOcor: TUniQuery;
    qryOcorrCODOCO: TStringField;
    qryOcorrQTDDUP: TLargeintField;
    qryOcorrMOTOCO: TStringField;
    qryOcorrVALDUP: TFloatField;
    qryOcorrVALPAG: TFloatField;
    qryOcorrTARIFA: TFloatField;
    qryOcorrVALJUR: TFloatField;
    qryOcorrVALDES: TFloatField;
    qryOcorrCUSCAR: TFloatField;
    qryTotOcorCODOCO: TStringField;
    qryTotOcorQTDDUP: TLargeintField;
    qryTotOcorVALDUP: TFloatField;
    qryTotOcorVALPAG: TFloatField;
    qryTotOcorTARIFA: TFloatField;
    qryTotOcorVALJUR: TFloatField;
    qryTotOcorVALDES: TFloatField;
    qryTotOcorCUSCAR: TFloatField;
    frxDBDatasetNaoBaix: TfrxDBDataset;
    qryNaoBaix: TUniQuery;
    qryNaoBaixCODOCO: TStringField;
    qryNaoBaixNOSNUM: TStringField;
    qryNaoBaixNUMDUP: TStringField;
    qryNaoBaixCODEMP: TStringField;
    qryNaoBaixDTAVEN: TDateField;
    qryNaoBaixDTAPAG: TDateField;
    qryNaoBaixVALPAG: TFloatField;
    qryNaoBaixJURMOR: TFloatField;
    qryNaoBaixDESCON: TFloatField;
    qryNaoBaixRET_CODREJ: TStringField;
    qryNaoBaixRET_CODBCO: TStringField;
    qryNaoBaixVALDUP: TFloatField;
    qryNaoBaixCARTEI: TIntegerField;
    qryNaoBaixDUPDIV: TStringField;
    qryNaoBaixTARIFA: TFloatField;
    qryNaoBaixCODCLI: TStringField;
    qryNaoBaixDTARET: TDateField;
    qryNaoBaixNOMARQ: TStringField;
    qryNaoBaixCEPCLI: TStringField;
    qryNaoBaixMOTDIV: TStringField;
    qryNaoBaixCUSCAR: TFloatField;
    qryNaoBaixCARBCO: TStringField;
    qryNaoBaixIOFDES: TFloatField;
    qryNaoBaixTXADES: TFloatField;
    qryNaoBaixJUROPE: TFloatField;
    qryDupJaBaixadas: TUniQuery;
    frxDBDatasetJaBaixadas: TfrxDBDataset;
    qryDupJaBaixadasCODOCO: TStringField;
    qryDupJaBaixadasNOSNUM: TStringField;
    qryDupJaBaixadasNUMDUP: TStringField;
    qryDupJaBaixadasCODEMP: TStringField;
    qryDupJaBaixadasDTAVEN: TDateField;
    qryDupJaBaixadasDTAPAG: TDateField;
    qryDupJaBaixadasVALPAG: TFloatField;
    qryDupJaBaixadasJURMOR: TFloatField;
    qryDupJaBaixadasDESCON: TFloatField;
    qryDupJaBaixadasOUTVAL: TFloatField;
    qryDupJaBaixadasVALDUP: TFloatField;
    qryDupJaBaixadasRET_CODREJ: TStringField;
    qryDupJaBaixadasRET_CODBCO: TStringField;
    qryDupJaBaixadasCARTEI: TIntegerField;
    qryDupJaBaixadasCODCLI: TStringField;
    qryDupJaBaixadasTARIFA: TFloatField;
    qryDupJaBaixadasNOMARQ: TStringField;
    qryDupJaBaixadasCEPCLI: TStringField;
    qryDupJaBaixadasCTR_DESSUJ: TFloatField;
    qryDupJaBaixadasCTR_DTAVEN: TDateField;
    qryDupJaBaixadasCTR_VALORI: TFloatField;
    qryDupJaBaixadasCTR_VALDUP: TFloatField;
    qryDupJaBaixadasVALCOR: TFloatField;
    qryDupJaBaixadasVALDIF: TFloatField;
    qryDupJaBaixadasDTARET: TDateField;
    qryDupJaBaixadasCUSCAR: TFloatField;
    qryDupJaBaixadasCARBCO: TStringField;
    qryDupJaBaixadasIOFDES: TFloatField;
    qryDupJaBaixadasTXADES: TFloatField;
    qryDupJaBaixadasJUROPE: TFloatField;
    frxRetBcoTarifa: TfrxReport;
    qryOcorrVALPAG_COMTAR: TFloatField;
    qryTotOcorVALPAG_COMTAR: TFloatField;
    qryBaixadasLancaTarifa: TUniQuery;
    frxDBDatasetBaixadasLancaTarifa: TfrxDBDataset;
    qryBaixadasLancaTarifaCODOCO: TStringField;
    qryBaixadasLancaTarifaNOSNUM: TStringField;
    qryBaixadasLancaTarifaNUMDUP: TStringField;
    qryBaixadasLancaTarifaCODEMP: TStringField;
    qryBaixadasLancaTarifaDTAVEN: TDateField;
    qryBaixadasLancaTarifaDTAPAG: TDateField;
    qryBaixadasLancaTarifaVALPAG: TFloatField;
    qryBaixadasLancaTarifaJURMOR: TFloatField;
    qryBaixadasLancaTarifaDESCON: TFloatField;
    qryBaixadasLancaTarifaOUTVAL: TFloatField;
    qryBaixadasLancaTarifaVALDUP: TFloatField;
    qryBaixadasLancaTarifaRET_CODREJ: TStringField;
    qryBaixadasLancaTarifaRET_CODBCO: TStringField;
    qryBaixadasLancaTarifaCARTEI: TIntegerField;
    qryBaixadasLancaTarifaCODCLI: TStringField;
    qryBaixadasLancaTarifaTARIFA: TFloatField;
    qryBaixadasLancaTarifaNOMARQ: TStringField;
    qryBaixadasLancaTarifaCEPCLI: TStringField;
    qryBaixadasLancaTarifaCTR_DESSUJ: TFloatField;
    qryBaixadasLancaTarifaCTR_DTAVEN: TDateField;
    qryBaixadasLancaTarifaCTR_VALORI: TFloatField;
    qryBaixadasLancaTarifaCTR_VALDUP: TFloatField;
    qryBaixadasLancaTarifaVALCOR: TFloatField;
    qryBaixadasLancaTarifaVALDIF: TFloatField;
    qryBaixadasLancaTarifaDTARET: TDateField;
    qryBaixadasLancaTarifaCUSCAR: TFloatField;
    qryBaixadasLancaTarifaCARBCO: TStringField;
    qryBaixadasLancaTarifaIOFDES: TFloatField;
    qryBaixadasLancaTarifaTXADES: TFloatField;
    qryBaixadasLancaTarifaJUROPE: TFloatField;
    qryRetBcoVL_TARIFA: TFloatField;
    qryRetBcoVALPAG_COMTAR: TFloatField;
    cdsRetBcoVL_TARIFA: TFloatField;
    cdsRetBcoVALPAG_COMTAR: TFloatField;
    qryRetBcoVAL_CRED: TFloatField;
    cdsRetBcoVAL_CRED: TFloatField;
    qryCodigoErroPix: TUniQuery;
    frxDBDataSetCodigoErroPIX: TfrxDBDataset;
    qryRetBcoCTR_VALREC: TFloatField;
    cdsRetBcoCTR_VALREC: TFloatField;
    lblQuebraNomeCliente: TLabel;
    edtQuebraNomeCliente: TEditFocus;
    ColorLabel5: TColorLabel;
    procedure btnImprimirClick(Sender: TObject);
    procedure pRetDadosConta(intCartei: Integer);
    procedure pGeraRelatorio(strCodBco: String);

    function fRetDescOco(strCodoco: String): String;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstCodOcoKeyPress(Sender: TObject; var Key: Char);
    function frxRetBcoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }

    qryOcorrencia : TUniQuery;
    qryNaoBaixados: TUniQuery;
    qryTotalGeral: TUniQuery;

    qryRelatorio : TZClient;

    strCodBco: String;
    strCodAge: String;
    strNumCta: String;
    ACedente: String;

    blnImprimir: Boolean;
    strSQL: String;
    ASQLJaBaixadaLancaTarifa: String;
    BlnEncBan : Boolean;

    procedure pCalculaValorCorrigido;
    function fCalculaValorCorrigidoInterna(cxProgresso : TcxProgressBar):Boolean;
    function fRetCodOcoSelec: String;
    function RetornaMotivoOcorrenciaSelecionada: String;
    function RetornaSQLCampoJurOpe:String;
    procedure pGetRelPrincipal_F;

    // Functions para uso no relatório;
    function fRetDescOco_Rel(strCodOco: String): String;
    function pRetornaDescricaoBeforePrint(strTexto, ABanco: String; iTam: Integer): String;
    function pRetornaDescricaoBeforePrint_Rel(strTexto, ABanco: String; iTam: Integer): String;
    function RetornaOcorrencia_Rel(ABanco, AOcorrencia, ACnab : String; AMotivo: String  = ''; ADescricaoComMotivo: Boolean = True): String;

    procedure pGetRelOcorrencias_F;
    procedure pGetRelNaoBaixadas_F;
    procedure pGetRelBaixadas_F;
    procedure pGetCodigoErroPix;
    procedure AddFunctionFRX;
    procedure AddVariablesFRX;
    function SomenteHaRegistrosDeDuplicatasNaoBaixadas: Boolean;
    function fPreencheComZerosEsquerda(str: String): String;
    function fPreencheComZerosEsquerda_Rel(str: String): String;
    procedure GeraRelatorioBaixadasLancaTarifa_F;
    procedure pConfigurarQuebraNomeCliente(AReport: TfrxReport; const AQuebrar: Boolean);
  public
    { Public declarations }
    strNomBanco: String;
    ATipoCnab: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmRelRetBco: TfrmRelRetBco;

Const
  BANCOS_API: Array Of String = ['001', '097', '748', '341', '756', '033', '422', '237'];

implementation

uses  untfuncoesSimples, untPai, untGravando,
      untFuncAutban;

{$R *.dfm}

procedure TfrmRelRetBco.btnImprimirClick(Sender: TObject);
  Var
    intIndex : Integer;
    blnSelec : Boolean;
begin
  blnSelec := False;
  For intIndex := 0 to lstCodOco.Items.Count -1 Do
  Begin
    If lstCodOco.Items[intIndex].Checked Then
    Begin
      blnSelec := True;
      Break;
    End;
  End;

  If not blnSelec then
  Begin
    fMensagem('', 'Selecione pelo menos uma Ocorrência!', ['&OK']);
    pSetFocus(lstCodOco);
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If edtDestino.Text = 'V' Then
    strTipImp := 'J';

  If LeftStr(strNomBanco,3) = '001' Then
  Begin
    If Pos('7d', strNomBanco) > 0 Then
      strCodBco := LeftStr(strNomBanco,3) + 'D7'
    Else If (ATipoCnab <> 'API') Then
      strCodBco := LeftStr(strNomBanco,3)
    Else
      strCodBco := LeftStr(strNomBanco,3) + 'API';
  End
  Else If MatchStr(LeftStr(strNomBanco,3), ['341', '237']) Then
  Begin
    strCodBco := LeftStr(strNomBanco,3);
    If (ATipoCnab.Equals('API')) Then
      strCodBco := LeftStr(strNomBanco,3) + 'API';
  End
  Else If LeftStr(strNomBanco,3) = '104' Then
  Begin
    If Pos('400', strNomBanco) > 0 Then
      strCodBco := LeftStr(strNomBanco,3) + 'p400'
    Else
      strCodBco := LeftStr(strNomBanco,3);
  End
  Else If LeftStr(strNomBanco,3) = '033' Then
  Begin
    strCodBco := LeftStr(strNomBanco,3) + 'API';
    If Not ATipoCnab.Equals('API') Then
    Begin
      If Pos('Santander', strNomBanco) > 0 Then
        strCodBco := LeftStr(strNomBanco,3) + 'B'
      Else
        strCodBco := LeftStr(strNomBanco,3);
    End;
  End
  Else If LeftStr(strNomBanco,3) = '756' Then
  Begin
    strCodBco := LeftStr(strNomBanco,3);
    If (ATipoCnab.Equals('API')) Then
      strCodBco := LeftStr(strNomBanco,3) + 'API';
  End
  Else
  If LeftStr(strNomBanco,3) = '274' Then
  Begin
    If Pos('LP [400p]', strNomBanco) > 0 Then
      strCodBco := LeftStr(strNomBanco,3) + 'LP400p'
    Else
      strCodBco := LeftStr(strNomBanco,3);
  End
  Else
    strCodBco := LeftStr(strNomBanco,3);

  pGeraRelatorio(strCodBco);

end;

function TfrmRelRetBco.fRetDescOco(strCodoco: String): String;
begin

  strCodBco := LeftStr(strCodBco,3);
  {***********************************}
  {* BANCO DO BANESPA                *}
  {********************************LB*}
  If (strCodBco = '033') And (Pos('Santander', strNomBanco) <= 0) Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '04' Then
      Result := 'TRANSFERÊNCIA DE CARTEIRA - ENTRADA '

    Else If strCodoco = '05' Then
      Result := 'TRANSFERÊNCIA DE CARTEIRA - BAIXA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '07' Then
      Result := 'LIQUIDAÇÃO POR CONTA '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO POR SALDO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO CONFORME COMANDO VIA ARQUIVO - REMESSA '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME COMANDO AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER: UTILIZADO ARQ. EXISTÊNCIA MENSAL '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '14' Then
      Result := 'VENCIMENTO ALTERADO '

    Else If strCodoco = '15' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '19' Then
      Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '20' Then
      Result := 'CANCELAMENTO DE INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '23' Then
      Result := 'REMESSA A CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'RETIRADA DE CARTÓRIO '

    Else If strCodoco = '25' Then
      Result := 'BAIXADO POR TER SIDO PROTESTADO '

    Else If strCodoco = '26' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS / CUSTAS '

    Else If strCodoco = '29' Then
      Result := 'OCORRÊNCIA DO SACADO '

    Else If strCodoco = '30' Then
      Result := 'DESCONTO CONCEDIDO '

    Else
      Result := 'OUTRAS ';

  End
  {***********************************}
  {* BANCO SANTANDER                 *}
  {********************************AC*}
  Else If strCodBco = '353' Then
  Begin

    If strCodoco = '01' Then
      Result := 'TÍTULO NÃO EXISTE '
    Else If strCodoco = '02' Then
      Result := 'ENTRADA TÍT. CONFIRMADA '
    Else If strCodoco = '03' Then
      Result := 'ENTRADA TÍT. REJEITADA '
    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO '
    Else If strCodoco = '07' Then
      Result := 'LIQUIDAÇÃO POR CONTA '
    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO POR SALDO '
    Else If strCodoco = '09' Then
      Result := 'BAIXA AUTOMÁTICA '
    Else If strCodoco = '10' Then
      Result := 'TÍT. BAIX. CONF. INSTRUÇÃO '
    Else If strCodoco = '11' Then
      Result := 'EM SER '
    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then
      Result := 'PRORROGAÇÃO DE VENCIMENTO '
    Else If strCodoco = '15' Then
      Result := 'CONFIRMAÇÃO DE PROTESTO '
    Else If strCodoco = '16' Then
      Result := 'TÍT. JÁ BAIXADO/LIQUIDADO '
    Else If strCodoco = '17' Then
      Result := 'LIQUIDADO EM CARTÓRIO '
    Else If strCodoco = '21' Then
      Result := 'TÍT. ENVIADO A CARTÓRIO '
    Else If strCodoco = '22' Then
      Result := 'TÍT. RETIRADO DE CARTÓRIO '
    Else If strCodoco = '24' Then
      Result := 'CUSTAS DE CARTÓRIO '
    Else If strCodoco = '25' Then
      Result := 'PROTESTAR TÍTULO '
    Else If strCodoco = '26' Then
      Result := 'SUSTAR PROTESTO '
    Else
      Result := 'OUTRAS ';

  End

 {***********************************}
  {* BANCO SANTANDER 033             *}
  {********************************AF*}
  Else If (strCodBco = '033') And (Pos('Santander', strNomBanco) > 0) Then
  Begin

    If strCodoco = '01' Then Result := 'TÍTULO NÃO EXISTE '
    Else If strCodoco = '02' Then Result := 'ENTRADA TÍT. CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA TÍT. REJEITADA '
    Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA PARA CARTEIRA DESCONTO '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO '
    Else If strCodoco = '07' Then Result := 'LIQUIDAÇÃO POR CONTA '
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO POR SALDO '
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA '
    Else If strCodoco = '10' Then Result := 'TÍT. BAIX. CONF. INSTRUÇÃO '
    Else If strCodoco = '11' Then Result := 'EM SER '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'PRORROGAÇÃO DE VENCIMENTO '
    Else If strCodoco = '15' Then Result := 'CONFIRMAÇÃO DE PROTESTO '
    Else If strCodoco = '16' Then Result := 'TÍT. JÁ BAIXADO/LIQUIDADO '
    Else If strCodoco = '17' Then Result := 'LIQUIDADO EM CARTÓRIO '
    Else If strCodoco = '21' Then Result := 'TÍT. ENVIADO A CARTÓRIO '
    Else If strCodoco = '22' Then Result := 'TÍT. RETIRADO DE CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'CUSTAS DE CARTÓRIO '
    Else If strCodoco = '25' Then Result := 'PROTESTAR TÍTULO '
    Else If strCodoco = '26' Then Result := 'SUSTAR PROTESTO '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANESTES 021                    *}
  {********************************AF*}
  Else If (strCodBco = '021') Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CARTEIRA - ENTRADA '
    Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA DE CARTEIRA - BAIXA '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO '
    Else If strCodoco = '07' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DA INSTRUÇÃO DE DESCONTO '
    Else If strCodoco = '08' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DO CANCELAMENTO DO DESCONTO '
    Else If strCodoco = '09' Then Result := 'BAIXA '
    Else If strCodoco = '11' Then Result := 'TÍTULO EM CARTEIRA (EM SER) '
    Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DE INSTRUÇÃO DE ABATIMENTO '
    Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DE INSTRUÇÃO DE CANCELAMENTO DE ABATIMENTO  '
    Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DE INSTRUÇÃO DE ALTERAÇÃO DE VENCIMENTO '
    Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU LIQUIDAÇÃO DE TÍTULO NÃO REGISTRADO '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE SUSTAÇÃO / CANCELAMENTO DE PROTESTO '
    Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'RETIRADA DE CARTÓRIO '
    Else If strCodoco = '25' Then Result := 'PROTESTADO E BAIXADO '
    Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFA / CUSTAS '
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADA '
    Else If strCodoco = '99' Then Result := 'REMESSA REJEITADA '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO SAFRA 422                 *}
  {********************************AF*}
  Else If (strCodBco = '422') Then
  Begin
    If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CARTEIRA (ENTRADA) '
    Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA DE CARTEIRA (BAIXA) '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '09' Then Result := 'BAIXADO AUTOMATICAMENTE '
    Else If strCodoco = '10' Then Result := 'BAIXADO CONFORME INSTRUÇÕES '
    Else If strCodoco = '11' Then Result := 'TÍTULOS EM SER (PARA ARQUIVO MENSAL) '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO DE SUSTAR PROTESTO '
    Else If strCodoco = '21' Then Result := 'TRANSFERÊNCIA DE BENEFICIÁRIO '
    Else If strCodoco = '23' Then Result := 'TÍTULO ENVIADO A CARTÓRIO '
    Else If strCodoco = '40' Then Result := 'BAIXA DE TÍTULO PROTESTADO '
    Else If strCodoco = '41' Then Result := 'LIQUIDAÇÃO DE TÍTULO BAIXADO '
    Else If strCodoco = '42' Then Result := 'TÍTULO RETIRADO DE CARTÓRIO '
    Else If strCodoco = '43' Then Result := 'CUSTAS DE CARTÓRIO '
    Else If strCodoco = '44' Then Result := 'ACEITE DO TÍTULO PELO PAGADOR '
    Else If strCodoco = '45' Then Result := 'NÃO ACEITE DO TÍTULO PELO PAGADOR '
    Else If strCodoco = '51' Then Result := 'VALOR DO TÍTULO ALTERADO '
    Else If strCodoco = '52' Then Result := 'ACERTO DE DATA DE EMISSÃO '
    Else If strCodoco = '53' Then Result := 'ACERTO DE CÓDIGO ESPÉCIE DE DOCUMENTO '
    Else If strCodoco = '54' Then Result := 'ALTERAÇÃO DE SEU NÚMERO '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO BRB 070                   *}
  {********************************KP*}
  Else If (strCodBco = '070') Then
  Begin
    If strCodoco = '00' Then Result := 'BAIXA POR DEVOLUÇÃO '
    Else If strCodoco = '02' Then Result := 'ENTRADA DE TÍTULO '
    Else If strCodoco = '05' Then Result := 'LIQUIDAÇÃO S/REGISTRO OU MODALIDADE 1 '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL C/REGISTRO OU MODALIDADE 2 OU 3 '
    Else If strCodoco = '09' Then Result := 'LIQUIDAÇÃO/INSTRUÇÃO REJEITADA '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO REGULARIZADA S/REGISTRO OU MODALIDADE 1 '
    Else If strCodoco = '16' Then Result := 'LIQUIDAÇÃO REGULARIZADA C/REGISTRO OU MODALIDADE 2 E 3 '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO SOFISA 637                *}
  {********************************IV*}
  Else If (strCodBco = '637') Then
  Begin

    If strCodoco = '01' Then Result := 'TÍTULO NÃO EXISTE '
    Else If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '05' Then Result := 'CAMPO LIVRE ALTERADO '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA '
    Else If strCodoco = '10' Then Result := 'BAIXA POR TER SIDO LIQUIDADO '
    Else If strCodoco = '12' Then Result := 'CONFIRMA ABATIMENTO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'BAIXA REJEITADA '
    Else If strCodoco = '16' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '19' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE SUSTAÇÃO '
    Else If strCodoco = '22' Then Result := 'SEU NÚMERO ALTERADO '
    Else If strCodoco = '23' Then Result := 'TÍTULO ENVIADO PARA CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE NÃO PROTESTAR '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS - CORRESPONDENTES '
    Else If strCodoco = '40' Then Result := 'TARIFA DE ENTRADA (DEBITADA NA LIQUIDAÇÃO) '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO DO BRADESCO               *}
  {********************************LB*}
  Else If Pos(strCodBco, '237_995_993_992_996_997_991_989_982_983_990_970_981_906_978_977_976_975_974_973_962_') > 0 Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO AUTOMATICAMENTE VIA ARQUIVO (COND.CAD.) '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME INSTRUCOES DA AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER - ARQUIVO DE TÍTULOS PENDENTES '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '14' Then
      Result := 'VENCIMENTO ALTERADO '

    Else If strCodoco = '15' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO (PROTESTO CONFIRMADO) '

    Else If strCodoco = '17' Then
      Result := 'LIQUIDAÇÃO APOS BAIXA OU TÍTULO NÃO REGISTRADO '

    Else If strCodoco = '18' Then
      Result := 'ACERTO DE DEPOSITARIA '

    Else If strCodoco = '19' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '20' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTR. SUSTACAO PROTESTO '

    Else If strCodoco = '21' Then
      Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '

    Else If strCodoco = '23' Then
      Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '

    Else If strCodoco = '27' Then
      Result := 'BAIXA REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS/CUSTAS CARTORARIAS '

    Else If strCodoco = '30' Then
      Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADOS '

    Else If strCodoco = '32' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '33' Then
      Result := 'CONFIRMAÇÃO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS '

    Else If strCodoco = '34' Then
      Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA '

    Else If strCodoco = '35' Then
      Result := 'DESAGENDAMENTO DO DÉBITO AUTOMÁTICO '

    Else If strCodoco = '68' Then
      Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO '

    Else If strCodoco = '69' Then
      Result := 'CANCELAMENTO DOS DADOS DO RATEIO '

    Else If strCodoco = '73' Then
      Result := 'CONFIRMAÇÃO RECEB. PEDIDO DE NEGATIVAÇÃO'

    Else If strCodoco = '74' Then
      Result := 'CONFIR PEDIDO DE EXCL DE NEGAT'

    Else If strCodoco = '93' Then
      Result := 'BAIXA OPERACIONAL / BAIXA PELA CIP'

    Else If strCodoco = '94' Then
      Result := 'INSTRUÇÃO DE NEGATIVAÇÃO EXPRESSA REJEITADA'

    Else If strCodoco = '95' Then
      Result := 'CONFIRMAÇÃO DE ENTRADA NEGATIVAÇÃO EXPRESSA'

    Else If strCodoco = '96' Then
      Result := 'DESISTÊNCIA NEGATIVAÇÃO EXPRESSA CONFIRMADA'

    Else If strCodoco = '97' Then
      Result := 'DESISTÊNCIA NEGATIVAÇÃO EXPRESSA REJEITADA'

    Else If strCodoco = '98' Then
      Result := 'CONFIRMAÇÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA CARTÓRIO'

    Else If strCodoco = '99' Then
      Result := 'CANCELAMENTO NEGATIVAÇÃO EXPRESSA POR LIQUIDAÇÃO'

    Else

      Result := 'OUTRAS';

  End

  {***********************************}
  {*           BANCO LECCA           *}
  {***********************************}
  Else If strCodBco = '984' Then
  Begin
         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '09' Then Result := 'BAIXADO AUTOMAT. VIA ARQUIVO '
    Else If strCodoco = '10' Then Result := 'BAIXADO CONFORME INSTRUÇÕES DA AGÊNCIA '
    Else If strCodoco = '11' Then Result := 'EM SER - ARQUIVO DE TÍTULOS PENDENTES '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '16' Then Result := 'TÍTULO PAGO EM CHEQUE – VINCULADO '
    Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU TÍTULO NÃO REGISTRADO '
    Else If strCodoco = '18' Then Result := 'ACERTO DE DEPOSITÁRIA '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEB. INST. DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO SUSTAÇÃO DE PROTESTO '
    Else If strCodoco = '21' Then Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '
    Else If strCodoco = '22' Then Result := 'TÍTULO COM PAGAMENTO CANCELADO '
    Else If strCodoco = '23' Then Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '
    Else If strCodoco = '25' Then Result := 'CONFIRMAÇÃO RECEB.INST.DE PROTESTO FALIMENTAR '
    Else If strCodoco = '27' Then Result := 'BAIXA REJEITADA '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS '
    Else If strCodoco = '29' Then Result := 'OCORRÊNCIAS DO PAGADOR '
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADOS '
    Else If strCodoco = '32' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '33' Then Result := 'CONFIRMAÇÃO PEDIDO ALTERAÇÃO OUTROS DADOS '
    Else If strCodoco = '34' Then Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA '
    Else If strCodoco = '35' Then Result := 'DESAGENDAMENTO DO DÉBITO AUTOMÁTICO '
    Else If strCodoco = '40' Then Result := 'ESTORNO DE PAGAMENTO '
    Else If strCodoco = '55' Then Result := 'SUSTADO JUDICIAL '
    Else If strCodoco = '58' Then Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO '
    Else If strCodoco = '69' Then Result := 'CANCELAMENTO DE RATEIO '
    Else If strCodoco = '73' Then Result := 'CONFIRMAÇÃO RECEB. PEDIDO DE NEGATIVAÇÃO '
    Else If strCodoco = '74' Then Result := 'CONFIR PEDIDO DE EXCL DE NEGAT ';

  End

  {***********************************}
  {* BANCO UNIPRIME                  *}
  {***********************************}
  Else If Pos(strCodBco, '099_084_') > 0 Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO AUTOMATICAMENTE VIA ARQUIVO (COND.CAD.) '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME INSTRUCOES DA AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER - ARQUIVO DE TÍTULOS PENDENTES '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '14' Then
      Result := 'VENCIMENTO ALTERADO '

    Else If strCodoco = '15' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO (PROTESTO CONFIRMADO) '

    Else If strCodoco = '17' Then
      Result := 'LIQUIDAÇÃO APOS BAIXA OU TÍTULO NÃO REGISTRADO '

    Else If strCodoco = '18' Then
      Result := 'ACERTO DE DEPOSITARIA '

    Else If strCodoco = '19' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '20' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTR. SUSTACAO PROTESTO '

    Else If strCodoco = '21' Then
      Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '

    Else If strCodoco = '23' Then
      Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '

    Else If strCodoco = '27' Then
      Result := 'BAIXA REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS/CUSTAS CARTORARIAS '

    Else If strCodoco = '30' Then
      Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADOS '

    Else If strCodoco = '32' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '33' Then
      Result := 'CONFIRMAÇÃO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS '

    Else If strCodoco = '34' Then
      Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA '

    Else If strCodoco = '35' Then
      Result := 'DESAGENDAMENTO DO DÉBITO AUTOMÁTICO '

    Else If strCodoco = '40' Then
      Result := 'ESTORNO DE PAGAMENTO '

    Else If strCodoco = '55' Then
      Result := 'SUSTADO JUDICIAL '

    Else If strCodoco = '68' Then
      Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO '

    Else If strCodoco = '69' Then
      Result := 'CANCELAMENTO DOS DADOS DO RATEIO '

    Else If strCodoco = '73' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO. PEDIDO DE NEGATIVAÇÃO '

    Else If strCodoco = '74' Then
      Result := 'CONFIRMAÇÃO PEDIDO DE EXCL DE NEGAT (COM OU SEM BAIXA) '

    Else
      Result := 'OUTRAS';

  End

  {******************************}
  {* BANCO NA FOMENTO MERCANTIL *}
  {******************************}
  Else If (strCodBco = '994') Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '05' Then
      Result := 'BAIXA CONFIRMADA '

    Else If strCodoco = '06' Then
      Result := 'BAIXA REJEITADA '

    Else If strCodoco = '08' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '09' Then
      Result := 'ABATIMENTO REJEITADO '

    Else If strCodoco = '11' Then
      Result := 'CANCELAMENTO DE ABATIMENTO CONFIRMADO '

    Else If strCodoco = '12' Then
      Result := 'CANCELAMENTO DE ABATIMENTO REJEITADO '

    Else If strCodoco = '14' Then
      Result := 'PRORROGAÇÃO CONFIRMADA '

    Else If strCodoco = '15' Then
      Result := 'PRORROGAÇÃO REJEITADA '

    Else If strCodoco = '17' Then
      Result := 'ALTERAÇÃO DE USO DA EMPRESA CONFIRMADA '

    Else If strCodoco = '18' Then
      Result := 'ALTERAÇÃO DE USO DA EMPRESA REJEITADA '

    Else If strCodoco = '20' Then
      Result := 'ALTERAÇÃO DE NÚMERO CONFIRMADA '

    Else If strCodoco = '21' Then
      Result := 'ALTERAÇÃO DE NÚMERO REJEITADA '

    Else If strCodoco = '23' Then
      Result := 'PROTESTO CONFIRMADO '

    Else If strCodoco = '24' Then
      Result := 'PROTESTO REJEITADO '

    Else If strCodoco = '26' Then
      Result := 'SUSTAÇÃO DE PROTESTO CONFIRMADA '

    Else If strCodoco = '27' Then
      Result := 'SUSTAÇÃO DE PROTESTO REJEITADA '

    Else If strCodoco = '29' Then
      Result := 'ALTERAÇÃO DE OUTROS DADOS CONFIRMADA '

    Else If strCodoco = '30' Then
      Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADA '

    Else If strCodoco = '32' Then
      Result := 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTR. DE PROTESTO FAMILIAR '

    Else If strCodoco = '36' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '37' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '38' Then
      Result := 'MANUTENÇÃO DE TÍTULOS VENCIDOS '

    Else If strCodoco = '39' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '40' Then
      Result := 'NÃO PROTESTO CONFIRMADO '

    Else If strCodoco = '41' Then
      Result := 'TÍTULO ENVIADO AO CARTÓRIO '

    Else If strCodoco = '42' Then
      Result := 'ALEGAÇÕES DO SACADO '

    Else If strCodoco = '43' Then
      Result := 'BAIXA POR TER SIDO PROTESTADO '

    Else If strCodoco = '44' Then
      Result := 'CUSTAS DE PROTESTO '

    Else If strCodoco = '45' Then
      Result := 'CUSTAS DE SUSTAÇÃO '

    Else If strCodoco = '46' Then
      Result := 'CUSTAS DE CARTÓRIO DISTRIBUIDOR '

    Else If strCodoco = '47' Then
      Result := 'CUSTAS DE EDITAL '

    Else If strCodoco = '48' Then
      Result := 'TARIFA DE INSTRUÇÃO '

    Else If strCodoco = '49' Then
      Result := 'TARIFA DE OCORRÊNCIAS '

    Else If strCodoco = '51' Then
      Result := 'CUSTAS DE SUSTAÇÃO JUDICIAL '

    Else If strCodoco = '52' Then
      Result := 'SUSTADO JUDICIAL '

    Else If strCodoco = '53' Then
      Result := 'PAGAMENTO COM CHEQUE '

    Else If strCodoco = '55' Then
      Result := 'DÉBITO DE TARIFAS/CUSTAS '

    Else If strCodoco = '56' Then
      Result := 'PAGAMENTO CANCELADO '

    Else If strCodoco = '58' Then
      Result := 'CUSTAS DE IRREGULARIDADE '

    Else If strCodoco = '61' Then
      Result := 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '62' Then
      Result := 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE SUSTAÇÃO '

    Else If strCodoco = '63' Then
      Result := 'INSTRUÇÃO CANCELADA '

    Else If strCodoco = '72' Then
      Result := 'BAIXA POR DECURSO DE PRAZO '

    Else If strCodoco = '73' Then
      Result := 'TPITULO RETIRADO DO CARTÓRIO '

    Else If strCodoco = '74' Then
      Result := 'NÃO PROTESTO REJEITADO '

    Else If strCodoco = '75' Then
      Result := 'TRANSFERÊNCIA ENTRE CONTAS ';

  End

{******************************************}
{*        BANCO DAYCOVAL [400P]           *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:147378****************************MT*}
  Else If (strCodBco = '707') Then
  Begin

    If strCodoco = '01' Then Result := 'ENTRADA CONFIRMADA NA CIP '
    Else If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '05' Then Result := 'CAMPO LIVRE ALTERADO '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA '
    Else If strCodoco = '10' Then Result := 'BAIXA PÔR TER SIDO LIQUIDADO '
    Else If strCodoco = '12' Then Result := 'CONFIRMA ABATIMENTO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'BAIXA REJEITADA '
    Else If strCodoco = '16' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '19' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE SUSTAÇÃO '
    Else If strCodoco = '22' Then Result := 'SEU NÚMERO ALTERADO '
    Else If strCodoco = '23' Then Result := 'TÍTULO ENVIADO PARA CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE NÃO PROTESTAR '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS – CORRESPONDENTES '
    Else If strCodoco = '40' Then Result := 'TARIFA DE ENTRADA (DEBITADA NA LIQUIDAÇÃO) '
    Else If strCodoco = '43' Then Result := 'BAIXADO POR TER SIDO PROTESTADO '
    Else If strCodoco = '96' Then Result := 'TARIFA SOBRE INSTRUÇÕES – MÊS ANTERIOR '
    Else If strCodoco = '97' Then Result := 'TARIFA SOBRE BAIXAS – MÊS ANTERIOR '
    Else If strCodoco = '98' Then Result := 'TARIFA SOBRE ENTRADAS – MÊS ANTERIOR '
    Else If strCodoco = '99' Then Result := 'TARIFA SOBRE INSTRUÇÃO DE PROTESTO/SUSTAÇÃO – MÊS ANTERIOR '
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO SB Credito                *}
  {********************************LB*}
  Else If strCodBco = '988' Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '04' Then Result := 'ALTERAÇÃO DE DADOS - NOVA ENTRADA '
    Else If strCodoco = '05' Then Result := 'ALTERAÇÃO DE DADOS - BAIXA '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '07' Then Result := 'LIQUIDAÇÃO PARCIAL – COBRANÇA INTELIGENTE (B2B)'
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '09' Then Result := 'BAIXA SIMPLES '
    Else If strCodoco = '10' Then Result := 'BAIXA POR TER SIDO LIQUIDADO '
    Else If strCodoco = '11' Then Result := 'EM SER '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'BAIXAS REJEITADAS '
    Else If strCodoco = '16' Then Result := 'INSTRUCOES REJEITADAS '
    Else If strCodoco = '17' Then Result := 'ALTERAÇÃO DE DADOS REJEITADOS '
    Else If strCodoco = '18' Then Result := 'COBRANÇA CONTRATUAL - ABATIMENTO E BAIXA BLOQUEADOS '
    Else If strCodoco = '19' Then Result := 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE SUSTACAO DE PROTESTO/TARIFA '
    Else If strCodoco = '21' Then Result := 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE NÃO PROTESTAR '
    Else If strCodoco = '23' Then Result := 'PROTESTO ENVIADO A CARTÓRIO/TARIFA '
    Else If strCodoco = '24' Then Result := 'INSTRUÇÃO DE PROTESTO REJEITADA/SUSTADA/PENDENTE '
    Else If strCodoco = '25' Then Result := 'ALEGACOES DO SACADO '
    Else If strCodoco = '26' Then Result := 'TARIFA DE AVISO DE COBRANÇA '
    Else If strCodoco = '27' Then Result := 'TARIFA DE EXTRATO POSICAO '
    Else If strCodoco = '28' Then Result := 'TARIFA DE RELACAO DAS LIQUIDACOES '
    Else If strCodoco = '29' Then Result := 'TARIFA DE MANUTENÇÃO DE TÍTULOS VENCIDOS '
    Else If strCodoco = '30' Then Result := 'DÉBITO MENSAL DE TARIFAS '
    Else If strCodoco = '32' Then Result := 'TÍTULO PROTESTADO '
    Else If strCodoco = '33' Then Result := 'CUSTAS DE PROTESTO '
    Else If strCodoco = '34' Then Result := 'VALORES DAS CUSTAS DE DESISTENCIA/SUSTACAO E CANCELAMENTO DO PROTESTO '
    Else If strCodoco = '35' Then Result := 'CUSTAS DE CARTÓRIO DISTRIBUIDOR '
    Else If strCodoco = '36' Then Result := 'CUSTAS DE EDITAL '
    Else If strCodoco = '37' Then Result := 'TARIFA DE EMISSAO DE BLOQUETO/TARIFA DE ENVIO DE DUPLICATA '
    Else If strCodoco = '38' Then Result := 'TARIFA DE INSTRUÇÃO '
    Else If strCodoco = '39' Then Result := 'TARIFA DE OCORRÊNCIAS '
    Else If strCodoco = '40' Then Result := 'TARIFA MENSAL DE EMISSAO DE BLOQUETO/TARIFA MENSAL DE ENVIO DE DUPLICATA '
    Else If strCodoco = '41' Then Result := 'DÉBITO MENSAL DE TARIFAS - EXTRATO DE POSICAO '
    Else If strCodoco = '42' Then Result := 'DÉBITO MENSAL DE TARIFAS - OUTRAS INSTRUCOES '
    Else If strCodoco = '43' Then Result := 'DÉBITO MENSAL DE TARIFAS - MANUTENÇÃO DE TÍTULOS VENCIDOS '
    Else If strCodoco = '44' Then Result := 'DÉBITO MENSAL DE TARIFAS - OUTRAS OCORRÊNCIAS '
    Else If strCodoco = '45' Then Result := 'DÉBITO MENSAL DE TARIFAS - PROTESTO '
    Else If strCodoco = '46' Then Result := 'DÉBITO MENSAL DE TARIFAS - SUSTACAO DE PROTESTO '
    Else If strCodoco = '47' Then Result := 'BAIXA COM TRANSFERÊNCIA PARA DESCONTO '
    Else If strCodoco = '48' Then Result := 'VALORES DAS CUSTAS DE SUSTACAO JUDICIAL DEFINITIVA '
    Else If strCodoco = '51' Then Result := 'TARIFA MENSAL REF A ENTRADAS BANCOS CORRESPONDENTES NA CARTEIRA '
    Else If strCodoco = '52' Then Result := 'TARIFA MENSAL BAIXAS NA CARTEIRA '
    Else If strCodoco = '53' Then Result := 'TARIFA MENSAL BAIXAS EM BANCOS CORRESPONDENTES NA CARTEIRA '
    Else If strCodoco = '54' Then Result := 'TARIFA MENSAL DE LIQUIDACOES NA CARTEIRA '
    Else If strCodoco = '55' Then Result := 'TARIFA MENSAL DE LIQUIDACOES EM BANCOS CORRESPONDENTES NA CARTEIRA '
    Else If strCodoco = '56' Then Result := 'CUSTAS DE IRREGULARIDADE '
    Else If strCodoco = '57' Then Result := 'INSTRUÇÃO CANCELADA '
    Else If strCodoco = '59' Then Result := 'BAIXA POR CRÉDITO EM C/C'
    Else If strCodoco = '60' Then Result := 'ENTRADA REJEITADA CARNÊ (NOTA 20 – TABELA 1) '
    Else If strCodoco = '61' Then Result := 'TARIFA EMISSÃO AVISO DE MOVIMENTAÇÃO DE TÍTULOS (2154)'
    Else If strCodoco = '62' Then Result := 'DÉBITO MENSAL DE TARIFA - AVISO DE MOVIMENTAÇÃO DE TÍTULOS (2154) '
    Else If strCodoco = '63' Then Result := 'TÍTULO SUSTADO JUDICIALMENTE '
    Else If strCodoco = '64' Then Result := 'ENTRADA CONFIRMADA COM RATEIO DE CRÉDITO '
    Else If strCodoco = '65' Then Result := 'PAGAMENTO COM CHEQUE – AGUARDANDO COMPENSAÇÃO '
    Else If strCodoco = '69' Then Result := 'CHEQUE DEVOLVIDO '
    Else If strCodoco = '72' Then Result := 'BAIXA POR CRÉDITO EM C/C SEM TÍTULO CORRESPONDENTE '
    Else If strCodoco = '73' Then Result := 'CONFIRMAÇÃO DE ENTRADA NA COBRANÇA SIMPLES '
    Else If strCodoco = '74' Then Result := 'INSTRUÇÃO DE NEGATIVAÇÃO EXPRESSA REJEITADA '
    Else If strCodoco = '75' Then Result := 'CONFIRMA O RECEB. DE INSTRUÇÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '77' Then Result := 'CONFIRMA O RECEB. DE INSTRUÇÃO DE EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '78' Then Result := 'CONFIRMA O RECEB. DE INSTRUÇÃO DE CANCELAMENTO DE NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '79' Then Result := 'NEGATIVAÇÃO EXPRESSA INFORMACIONAL '
    Else If strCodoco = '80' Then Result := 'CONFIRMA DE ENTRADA EM NEGATIVAÇÃO EXPRESSA / TARIFA '
    Else If strCodoco = '81' Then Result := 'CONFIRMA EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA / TARIFA '
    Else If strCodoco = '82' Then Result := 'CONFIRMA O CANCELAMENTO EM NEGATIVAÇÃO EXPRESSA / TARIFA '
    Else If strCodoco = '83' Then Result := 'CONFIRMA EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA POR LIQUIDAÇÃO / TARIFA '
    Else If strCodoco = '84' Then Result := 'TARIFA MENSAL DE ENTRADA EM NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '85' Then Result := 'TARIFA PACOTE COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '86' Then Result := 'TARIFA E-MAIL COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '87' Then Result := 'TARIFA SMS COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '88' Then Result := 'TARIFA MENSAL PACOTE COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '89' Then Result := 'TARIFA MENSAL E-MAIL COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '90' Then Result := 'TARIFA MENSAL SMS COBRANÇA ATIVA ELETRÔNICA '
    Else If strCodoco = '91' Then Result := 'TARIFA MENSAL DE EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '92' Then Result := 'TARIFA MENSAL DE CANCELAMENTO DE NEGATIVAÇÃO EXPRESSA '
    Else If strCodoco = '93' Then Result := 'TARIFA MENSAL DE EXCLUSÃO DE NEGATIVAÇÃO EXPRESSA POR LIQUIDAÇÃO '
    Else If strCodoco = '94' Then Result := 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE NÃO NEGATIVAR '
    Else If strCodoco = '95' Then Result := 'BAIXA OPERACIONAL '
    Else If strCodoco = '99' Then Result := 'DESCONTADA E TRANSFERIDA PARA COBRANÇA SIMPLES '
    Else Result :=  'OUTRAS ';

  End

  {***********************************}
  {* SB CREDITO -  BRADESCO          *}
  {***********************************}
  Else If strCodBco = '987' Then
  Begin
         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '09' Then Result := 'BAIXADO AUTOMAT. VIA ARQUIVO '
    Else If strCodoco = '10' Then Result := 'BAIXADO CONFORME INSTRUÇÕES DA AGÊNCIA '
    Else If strCodoco = '11' Then Result := 'EM SER - ARQUIVO DE TÍTULOS PENDENTES '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '16' Then Result := 'TÍTULO PAGO EM CHEQUE – VINCULADO '
    Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU TÍTULO NÃO REGISTRADO '
    Else If strCodoco = '18' Then Result := 'ACERTO DE DEPOSITÁRIA '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEB. INST. DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO SUSTAÇÃO DE PROTESTO '
    Else If strCodoco = '21' Then Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '
    Else If strCodoco = '22' Then Result := 'TÍTULO COM PAGAMENTO CANCELADO '
    Else If strCodoco = '23' Then Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '
    Else If strCodoco = '25' Then Result := 'CONFIRMAÇÃO RECEB.INST.DE PROTESTO FALIMENTAR '
    Else If strCodoco = '27' Then Result := 'BAIXA REJEITADA '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS '
    Else If strCodoco = '29' Then Result := 'OCORRÊNCIAS DO PAGADOR '
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADOS '
    Else If strCodoco = '32' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '33' Then Result := 'CONFIRMAÇÃO PEDIDO ALTERAÇÃO OUTROS DADOS '
    Else If strCodoco = '34' Then Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA '
    Else If strCodoco = '35' Then Result := 'DESAGENDAMENTO DO DÉBITO AUTOMÁTICO '
    Else If strCodoco = '40' Then Result := 'ESTORNO DE PAGAMENTO '
    Else If strCodoco = '55' Then Result := 'SUSTADO JUDICIAL '
    Else If strCodoco = '58' Then Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO '
    Else If strCodoco = '69' Then Result := 'CANCELAMENTO DE RATEIO '
    Else If strCodoco = '73' Then Result := 'CONFIRMAÇÃO RECEB. PEDIDO DE NEGATIVAÇÃO '
    Else If strCodoco = '74' Then Result := 'CONFIR PEDIDO DE EXCL DE NEGAT ';

  End

  Else If strCodBco = '356' Then
  Begin
         If strCodoco = '02' Then Result := 'CONFIRMAÇÃO DE ENTREGA '
    Else If strCodoco = '03' Then Result := 'REGISTRO RECUSADO '
    Else If strCodoco = '04' Then Result := 'BAIXADO E CREDITADO EM C. CORRENTE - ADIANT. FORNECEDORES '
    Else If strCodoco = '05' Then Result := 'LIQUIDAÇÃO DE TIT. NÃO REG. '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '07' Then Result := 'LIQUIDAÇÃO POR CONTA '
    Else If strCodoco = '08' Then Result := 'BAIXADO PROTESTO '
    Else If strCodoco = '09' Then Result := 'BAIXADO '
    Else If strCodoco = '10' Then Result := 'BAIXADO CONF. INSTRUCOES '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '17' Then Result := 'PAGO EM CARTÓRIO '
    Else If strCodoco = '18' Then Result := 'CONFIRMAÇÃO RECEBIMENTO - INSTR. SUSTAR PROTESTO E BAIXAR O TÍTULO '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO DE RECEBIMENTO, INSTR. PROTESTAR '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTR. SUSTAR PROTESTO E CONSERVAR EM CARTEIRA '
    Else If strCodoco = '21' Then Result := 'SUSTACAO NÃO ACATADA, TÍTULO LIQUIDADO NA DATA '
    Else If strCodoco = '22' Then Result := 'NUMERO DO CEDENTE ALTERADO '
    Else If strCodoco = '23' Then Result := 'CAMPO ESPECIAL ALTERADO '
    Else If strCodoco = '24' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTR. NÃO PROTESTAR '
    Else If strCodoco = '25' Then Result := 'ENVIADO A CARTÓRIO TROCA DE ARQUIVOS COBRANÇA COM E SEM REGISTRO '
    Else If strCodoco = '26' Then Result := 'PROTESTO SUSTADO '
    Else If strCodoco = '27' Then Result := 'PROTESTO NÃO SUSTADO '
    Else If strCodoco = '28' Then Result := 'PROTESTO DEVOLVIDO PELO CARTÓRIO '
    Else If strCodoco = '29' Then Result := 'DÉBITO CUSTAS CARTORIAIS '
    Else If strCodoco = '30' Then Result := 'MULTA ALTERADA '
    Else If strCodoco = '31' Then Result := 'MULTA CANCELADA '
    Else If strCodoco = '32' Then Result := 'DESCONTO CONCEDIDO '
    Else If strCodoco = '34' Then Result := 'PROTESTO AUTOM. CANCELADO '
    Else If strCodoco = '75' Then Result := 'JUROS E DATA DE VENCIMENTO ALTERADOS '
    Else If strCodoco = '98' Then Result := 'AMORTIZAÇÃO '
    Else Result := 'OUTROS ';
  End

  {***********************************}
  {* SIFRA                           *}
  {********************************MT*}
  Else If strCodBco = '998' Then
  Begin
    If strCodoco = '01' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '02' Then Result := 'PAGO NORMAL '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '05' Then Result := 'PRORROGAÇÃO '
    Else If strCodoco = '06' Then Result := 'PAGO EM CARTÓRIO '
    Else If strCodoco = '08' Then Result := 'BAIXADO '
    Else If strCodoco = '09' Then Result := 'BAIXADO '
    Else If strCodoco = '10' Then Result := 'ENTRADA NO CARTÓRIO '
    Else If strCodoco = '11' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '14' Then Result := 'BAIXA POR PROTESTO '
    Else If strCodoco = '15' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '17' Then Result := 'CANC. DE ABATIMENTO '
    Else If strCodoco = '18' Then Result := 'PROTESTO SUSTADO '
    Else If strCodoco = '22' Then Result := 'BAIXADO SEM SOLUÇÃO'
    Else If strCodoco = '24' Then Result := 'RECOMPRA '
    Else If strCodoco = '28' Then Result := 'SOLIC. BAIXA VIA CNAB '
    Else If strCodoco = '37' Then Result := 'DEPOSITO EM CONTA '
    Else If strCodoco = '38' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '45' Then Result := 'PAGO POR DEPOSITO SACADO '
    Else If strCodoco = '48' Then Result := 'PAGO POR DEPOSITO '
    Else If strCodoco = '50' Then Result := 'PAGAMENTO CH COLADO'
    Else If strCodoco = '52' Then Result := 'BAIXA POR NEGATIVAÇÃO '
    Else If strCodoco = '54' Then Result := 'ENTRADA NO PEFIN '
    Else If strCodoco = '75' Then Result := 'EXCLUSÃO PEFIN SOLICITADO '
    Else If strCodoco = '90' Then Result := 'LIQUIDADO POR CREDCONTA '
    Else If strCodoco = '91' Then Result := 'LIQUIDADO BAIXA CONTABIL '
    Else Result := 'OUTROS ';
  End

  {***********************************}
  {* GRUPO SIFRA                     *}
  {***********************************}
  Else If strCodBco = '979' Then
  Begin
         If strCodoco = '01' Then Result := 'ENTRADA CONFIRMADA'
    Else If strCodoco = '02' Then Result := 'PAGO NORMAL '
    Else If strCodoco = '05' Then Result := 'PRORROGADO '
    Else If strCodoco = '06' Then Result := 'PAGO EM CARTÓRIO'
    Else If strCodoco = '08' Then Result := 'BAIXADO '
    Else If strCodoco = '10' Then Result := 'ENTRADA NO CARTÓRIO '
    Else If strCodoco = '14' Then Result := 'BAIXA POR PROTESTO '
    Else If strCodoco = '17' Then Result := 'CONC. DE ABATIMENTO '
    Else If strCodoco = '18' Then Result := 'PROTESTO SUSTADO '
    Else If strCodoco = '22' Then Result := 'BAIXADO SEM SOLUÇÃO '
    Else If strCodoco = '24' Then Result := 'RECOMPRA '
    Else If strCodoco = '45' Then Result := 'LIQUIDADO MANUALMENTE POR DEPOSITO (SACA '
    Else If strCodoco = '48' Then Result := 'LIQUIDADO MANUALMENTE POR DEPOSITO (CEDE  '
    Else If strCodoco = '52' Then Result := 'BAIXA POR NEGATIVAÇÃO '
    Else If strCodoco = '54' Then Result := 'REGISTRO PEFIN CONFIRMADO '
    Else If strCodoco = '60' Then Result := 'ENVIAR AO PEFIN '
    Else If strCodoco = '61' Then Result := 'EXCLUSÃO PEFIN CONFIRMADA '
    Else If strCodoco = '62' Then Result := 'REGISTRO PEFIN REJEITADO '
    Else If strCodoco = '63' Then Result := 'ALTERAÇÃO OUTROS DADOS CONFIRMADA '
    Else If strCodoco = '64' Then Result := 'SUSTADO JUDICIALMENTE '
    Else If strCodoco = '71' Then Result := 'PROTESTO/ENVIO CARTÓRIO SOLICITADO '
    Else If strCodoco = '72' Then Result := 'PROTESTO/ENVIO CARTÓRIO ACEITO '
    Else If strCodoco = '73' Then Result := 'PROTESTO/ENVIO CARTÓRIO REJEITADO '
    Else If strCodoco = '74' Then Result := 'SUSTAR PROTESTO/ENVIO CARTÓRIO SOLICITADO '
    Else If strCodoco = '75' Then Result := 'EXCLUSÃO PEFIN SOLICITADA '
    Else If strCodoco = '76' Then Result := 'SUSTAR PROTESTO/ENVIO CARTÓRIO ACEITO '
    Else If strCodoco = '77' Then Result := 'SUSTAR PROTESTO/ENVIO CARTÓRIO REJEITADO '
    Else Result := 'OUTROS ';
  End

  {***********************************}
  {* BANCO MERCANTIL                 *}
  {********************************LB*}
  Else If strCodBco = '389' Then
  Begin

    If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA'
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA'
    Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CONTRATO'
    Else If strCodoco = '06' Then Result := 'LIQUIDADO'
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA'
    Else If strCodoco = '10' Then Result := 'BAIXA PEDIDO DO CEDENTE'
    Else If strCodoco = '12' Then Result := 'ABATIMENTO/DESCONTO CONCEDIDO'
    Else If strCodoco = '13' Then Result := 'ABATIMENTO/DESCONTO CANCELADO'
    Else If strCodoco = '14' Then Result := 'ALTERAÇÃO DE VENCIMENTO'
    Else If strCodoco = '15' Then Result := 'LIQUIDADO EM CARTÓRIO'
    Else If strCodoco = '16' Then Result := 'LIQUIDADO COM CHEQUE A COMPENSAR'
    Else If strCodoco = '19' Then Result := 'ALTERAÇÃO DE INSTRUÇÃO PROTESTO'
    Else If strCodoco = '22' Then Result := 'ALTERAÇÃO DE SEU NÚMERO'
    Else If strCodoco = '23' Then Result := 'LIQUIDADO POR DÉBITO EM CONTA'
    Else If strCodoco = '24' Then Result := 'LIQUIDADO PELO BANCO CORRESPONDENTE'
    Else If strCodoco = '31' Then Result := 'BAIXA FRANCO DE PAGAMENTO'
    Else If strCodoco = '55' Then Result := 'INSTRUÇÃO CODIFICADA'
    Else If strCodoco = '56' Then Result := 'SUSTAR PROTESTO E MANTER EM CARTEIRA'
    Else If strCodoco = '65' Then Result := 'EMISSÃO DE SEGUNDA VIA DE AVISO'
    Else If strCodoco = '67' Then Result := 'NÃO CONCEDER JUROS FORA DO PRAZO'
    Else If strCodoco = '83' Then Result := 'COBRANÇA AUTOMÁTICA DE TARIFAS'
    Else If strCodoco = '84' Then Result := 'PROTESTAR SEM MAIS CONSULTAS'
    Else If strCodoco = '85' Then Result := 'BAIXA DE TÍTULO PROTESTADO'
    Else Result := 'OUTRAS';

  End

  {***********************************}
  {* BANCO HSBC                      *}
  {********************************LB*}
  Else If strCodBco = '399' Then
  Begin

    If strCodoco =  '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO AUTOMATICAMENTE VIA ARQUIVO (COND.CAD.) '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME INSTRUCOES DA AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER - ARQUIVO DE TÍTULOS PENDENTES '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '14' Then
      Result := 'VENCIMENTO ALTERADO '

    Else If strCodoco = '15' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO (PROTESTO CONFIRMADO) '

    Else If strCodoco = '17' Then
      Result := 'LIQUIDAÇÃO APOS BAIXA OU TÍTULO NÃO REGISTRADO '

    Else If strCodoco = '18' Then
      Result := 'ACERTO DE DEPOSITARIA '

    Else If strCodoco = '19' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '20' Then
      Result := 'CONFIRMAÇÃO RECEBIMENTO INSTR. SUSTACAO PROTESTO '

    Else If strCodoco = '21' Then
      Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '

    Else If strCodoco = '23' Then
      Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '

    Else If strCodoco = '27' Then
      Result := 'BAIXA REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS/CUSTAS CARTORARIAS '

    Else If strCodoco = '29' Then
      Result := 'ALTERAÇÃO DE OUTROS DADOS REJEITADOS '

    Else If strCodoco = '32' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '33' Then
      Result := 'CONFIRMAÇÃO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS '

    Else If strCodoco = '34' Then
      Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA '

    Else If strCodoco = '35' Then
      Result := 'DESAGENDAMENTO DO DÉBITO AUTOMÁTICO '

    Else If strCodoco = '68' Then
      Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO '

    Else If strCodoco = '69' Then
      Result := 'CANCELAMENTO DOS DADOS DO RATEIO '

    Else
      Result := 'OUTRAS';

  End

  {***********************************}
  {* BANCO NOSSA CAIXA NOSSO BANCO   *}
  {********************************LB*}
  Else If strCodBco = '151' Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '04' Then
      Result := 'TRANSFERÊNCIA DE CARTEIRA - ENTRADA '

    Else If strCodoco = '05' Then
      Result := 'TRANSFERÊNCIA DE CARTEIRA - BAIXA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '07' Then
      Result := 'LIQUIDAÇÃO POR CONTA '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO POR SALDO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO CONFORME COMANDO VIA ARQUIVO - REMESSA '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME COMANDO AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER: UTILIZADO ARQ. EXISTÊNCIA MENSAL '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '14' Then
      Result := 'VENCIMENTO ALTERADO '

    Else If strCodoco = '15' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '19' Then
      Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '20' Then
      Result := 'CANCELAMENTO DE INSTRUÇÃO DE PROTESTO '

    Else If strCodoco = '23' Then
      Result := 'REMESSA A CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'RETIRADA DE CARTÓRIO '

    Else If strCodoco = '25' Then
      Result := 'BAIXADO POR TER SIDO PROTESTADO '

    Else If strCodoco = '26' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS / CUSTAS '

    Else If strCodoco = '29' Then
      Result := 'OCORRÊNCIA DO SACADO '

    Else If strCodoco = '30' Then
      Result := 'DESCONTO CONCEDIDO '

    Else If strCodoco = '32' Then
      Result := 'CHEQUE '

    Else
      Result := 'OUTRAS '

  End

  {***********************************}
  {* BANCO CAIXA ECONOMICA FEDRAL    *}
  {********************************LB*}
  Else If strCodBco = '104' Then
  Begin

    If Not (RightStr(strNomBanco,4) = '400p') Then
    Begin
           If strCodoco = '01' Then Result := 'SOLICITAÇÃO DE IMPRESSAO DE TÍTULOS CONFIRMADA '
      Else If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
      Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
      Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/ENTRADA '
      Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/BAIXA '
      Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO '
      Else If strCodoco = '07' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DA INSTRUÇÃO DE DESCONTO '
      Else If strCodoco = '08' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DO CANCELAMENTO DO DESCONTO '
      Else If strCodoco = '09' Then Result := 'BAIXA '
      Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE ABATIMENO '
      Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE CANCELAMENTO ABATIMENO '
      Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO ALTERAÇÃO DE VENCIMENTO '
      Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APOS BAIXA OU LIQUIDAÇÃO TIULO NÃO REGISTRADO '
      Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO '
      Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE SUSTACAO/CANCELAMENTO DE PROTESTO '
      Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO (APONTE EM CARTÓRIO) '
      Else If strCodoco = '24' Then Result := 'RETIRADA DE CARTÓRIO E MANUTENÇÃO EM CARTEIRA '
      Else If strCodoco = '25' Then Result := 'PROTESTADO E BAIXADO (BAIXA POR TER SIDO PROTESTADO) '
      Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA '
      Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS '
      Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS '
      Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADA '
      Else If strCodoco = '35' Then Result := 'CONFIRMAÇÃO DE INCLUSAO BANCO DE SACADO '
      Else If strCodoco = '36' Then Result := 'COFIRMACAO DE ENVIO DE E-MAIL/SMS' //SIGCB'CONFIRMAÇÃO DE ALTERAÇÃO BANCO DE SACADO '
      Else If strCodoco = '37' Then Result := 'ENVIO DE E-MAIL/SMS REJEITADO ' //SIGCB'COFIRMACAO DE EXCLUSAO BANCO DE SACADO '
      Else If strCodoco = '38' Then Result := 'EMISSAO DE BOLETOS DE BANCO DE SACADO '
      Else If strCodoco = '39' Then Result := 'MANUTENÇÃO DE SACADO REJEITADA '
      Else If strCodoco = '40' Then Result := 'ENTRADA DE TÍTULO VIA BANCO DE SACADO REJEITADA '
      Else If strCodoco = '41' Then Result := 'MANUTENÇÃO DE BANCO DE SACADO REJEITADA '
      Else If strCodoco = '43' Then Result := 'ESTORNO DE PROTESTO SUSTACAO '
      Else If strCodoco = '44' Then Result := 'ESTORNO DE BAIXA/LIQUIDAÇÃO '
      Else If strCodoco = '45' Then Result := 'ALTERAÇÃO DE DADOS '
      Else Result :=  'OUTRAS ';

    End
    Else
    Begin
           If strCodoco = '01' Then Result := 'ENTRADA CONFIRMADA '
      Else If strCodoco = '02' Then Result := 'BAIXA CONFIRMADA '
      Else If strCodoco = '03' Then Result := 'ABATIMENTO CONCEDIDO '
      Else If strCodoco = '04' Then Result := 'ABATIMENTO CANCELADO '
      Else If strCodoco = '05' Then Result := 'VENCIMENTO ALTERADO '
      Else If strCodoco = '06' Then Result := 'USO DA EMPRESA ALTERADO '
      Else If strCodoco = '07' Then Result := 'PRAZO DE PROTESTO ALTERADO '
      Else If strCodoco = '08' Then Result := 'PRAZO DE DEVOLUÇÃO ALTERADO '
      Else If strCodoco = '09' Then Result := 'ALTERAÇÃO CONFIRMADA '
      Else If strCodoco = '10' Then Result := 'ALTERAÇÃO COM REEMISSAO DE BLOQUETE CONFIRMADA '
      Else If strCodoco = '11' Then Result := 'ALTERAÇÃO COM OPCAO DE PROTESTO PARA DEVOLUÇÃO CONFIRMADA '
      Else If strCodoco = '12' Then Result := 'ALTERAÇÃO COM OPCAO DE DEVOLUÇÃO PARA PROTESTO CONFIRMADA '
      Else If strCodoco = '20' Then Result := 'EM SER '
      Else If strCodoco = '21' Then Result := 'LIQUIDAÇÃO '
      Else If strCodoco = '22' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
      Else If strCodoco = '23' Then Result := 'BAIXA POR DEVOLUÇÃO '
      Else If strCodoco = '24' Then Result := 'BAIXA FRANCO PAGAMENTO '
      Else If strCodoco = '25' Then Result := 'BAIXA POR PROTESTO '
      Else If strCodoco = '26' Then Result := 'TÍTULO ENVIADO PARA CARTÓRIO '
      Else If strCodoco = '27' Then Result := 'SUSTACAO DE PROTESTO '
      Else If strCodoco = '28' Then Result := 'ESTORNO DE PROTESTO '
      Else If strCodoco = '29' Then Result := 'ESTORNO DE SUSTACAO DE PROTESTO '
      Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE TÍTULO '
      Else If strCodoco = '31' Then Result := 'TARIFA SOBRE TÍTULO VENCIDO '
      Else If strCodoco = '32' Then Result := 'OUTRAS TARIFAS DE ALTERAÇÃO '
      Else If strCodoco = '33' Then Result := 'ESTORNO DE BAIXA /LIQUIDAÇÃO '
      Else If strCodoco = '99' Then Result := 'REJICAO DO TÍTULO - COD. REJEICAO INFORMADO NAS POS 80 A 82  '
      Else Result :=  'OUTRAS ';
    End;
    
  End


  //*************************************************//
  // CODIGOS DE OCORRÊNCIA PARA O BANRISUL           //
  //**********************************************ED*//
  Else If strCodBco = '041' Then
  Begin
    strCodoco := strCodoco.Replace('.','');

    If RightStr(strNomBanco,6) <> '[240p]' Then
    begin
           If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA. '
      Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA. '
      Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL. '
      Else If strCodoco = '07' Then Result := 'LIQUIDAÇÃO POR PARCIAL. '
      Else If strCodoco = '08' Then Result := 'BAIXA POR PAGAMENTO. '
      Else If strCodoco = '09' Then Result := 'DEVOLUÇÃO AUTOMATICA. '
      Else If strCodoco = '10' Then Result := 'BAIXADO CONFORME INSTRUCOES. '
      Else If strCodoco = '11' Then Result := 'ARQUIVO LEVANTAMENTO. '
      Else If strCodoco = '12' Then Result := 'CONCESSÃO DE ABATIMENTO. '
      Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO. '
      Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO. '
      Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO. '
      Else If strCodoco = '16' Then Result := 'ALTERAÇÃO DE DADOS. '
      Else If strCodoco = '17' Then Result := 'ALTERAÇÃO DE INSTRUÇÕES. '
      Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE PROTESTO. '
      Else If strCodoco = '20' Then Result := 'CANCELAMENTO DE INSTRUÇÃO DE PROTESTO. '
      Else If strCodoco = '21' Then Result := 'AGUARDANDO AUTORIZAÇÃO PARA PROTESTO POR EDITAL. '
      Else If strCodoco = '22' Then Result := 'PROTESTO SUSTADO POR ALTERAÇÃO DE VENCIMENTO E PRAZO DE CARTÓRIO. '
      Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO. '
      Else If strCodoco = '25' Then Result := 'DEVOLUÇÃO, LIQUIDADO ANTERIORMENTE. '
      Else If strCodoco = '26' Then Result := 'DEVOLVIDO PELO CARTÓRIO - ERRO DE INFORMAÇÃO. '
      Else If strCodoco = '30' Then Result := 'COBRANÇA A CREDITAR (LIQUIDAÇÃO EM TRÂNSITO). '
      Else If strCodoco = '31' Then Result := 'TÍTULO EM TRÂNSITO PAGO EM CARTÓRIO. '
      Else If strCodoco = '32' Then Result := 'REEMBOLSO E TRANSFERÊNCIA ( PARA DESCONTO OU CARTEIRA COM GARANTIA DE TÍTULOS). '
      Else If strCodoco = '33' Then Result := 'REEMBOLSO E DEVOLUÇÃO. '
      Else If strCodoco = '40' Then Result := 'BAIXA DE TÍTULOS PROTESTADOS. '
      Else If strCodoco = '41' Then Result := 'DESPESA DE APONTE. '
      Else If strCodoco = '42' Then Result := 'ALTERAÇÃO DE TÍTULO. '
      Else If strCodoco = '43' Then Result := 'RELAÇÃO DE TÍTULOS. '
      Else If strCodoco = '44' Then Result := 'MANUTENÇÃO MENSAL. '
      Else If strCodoco = '45' Then Result := 'SUSTAÇÃO DE CARTÓRIO E ENVIO DE TÍTULO À CARTÓRIO. '
      Else If strCodoco = '46' Then Result := 'FORNECIMENTO DE FORMULÁRIO PRÉ-IMPRESSO. '
      Else If strCodoco = '68' Then Result := 'ACERTO DOS DADOS DO RATEIO DE CRÉDITO. '
      Else If strCodoco = '69' Then Result := 'CANCELAMENTO DOS DADOS DO RATEIO. '
      Else                          Result := 'OUTRAS ';
    end
    else
    begin
           If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA'
      Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA'
      Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/ENTRADA'
      Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/BAIXA'
      Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO'
      Else If strCodoco = '07' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DA INSTRUÇÃO DE DESCONTO'
      Else If strCodoco = '08' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DO CANCELAMENTO DO DESCONTO'
      Else If strCodoco = '09' Then Result := 'BAIXA'
      Else If strCodoco = '11' Then Result := 'TÍTULOS EM CARTEIRA (EM SER)'
      Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE ABATIMENTO'
      Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE CANCELAMENTO ABATIMENTO'
      Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO ALTERAÇÃO DE VENCIMENTO'
      Else If strCodoco = '15' Then Result := 'FRANCO DE PAGAMENTO'
      Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU LIQUIDAÇÃO TÍTULO NÃO REGISTRADO'
      Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO'
      Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE SUSTAÇÃO/CANCELAMENTO DE PROTESTO'
      Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO (APONTE EM CARTÓRIO)'
      Else If strCodoco = '24' Then Result := 'RETIRADA DE CARTÓRIO E MANUTENÇÃO EM CARTEIRA'
      Else If strCodoco = '25' Then Result := 'PROTESTADO E BAIXADO (BAIXA POR TER SIDO PROTESTADO)'
      Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA'
      Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS'
      Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS'
      Else If strCodoco = '29' Then Result := 'OCORRÊNCIAS DO PAGADOR'
      Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADA'
      Else If strCodoco = '33' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO RATEIO DE CRÉDITO'
      Else If strCodoco = '34' Then Result := 'CONFIRMAÇÃO DO CANCELAMENTO DOS DADOS DO RATEIO DE CRÉDITO'
      Else If strCodoco = '35' Then Result := 'CONFIRMAÇÃO DO DESAGENDAMENTO DO DÉBITO AUTOMÁTICO'
      Else If strCodoco = '36' Then Result := 'CONFIRMAÇÃO DE ENVIO DE E-MAIL/SMS'
      Else If strCodoco = '37' Then Result := 'ENVIO DE E-MAIL/SMS REJEITADO'
      Else If strCodoco = '38' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO PRAZO LIMITE DE RECEBIMENTO (A DATA DEVE SER INFORMADA NO CAMPO 28.3.P)'
      Else If strCodoco = '39' Then Result := 'CONFIRMAÇÃO DE DISPENSA DE PRAZO LIMITE DE RECEBIMENTO'
      Else If strCodoco = '40' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DO NÚMERO DO TÍTULO DADO PELO BENEFICIÁRIO'
      Else If strCodoco = '41' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DO NÚMERO CONTROLE DO PARTICIPANTE'
      Else If strCodoco = '42' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO PAGADOR'
      Else If strCodoco = '43' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO SACADOR/AVALISTA'
      Else If strCodoco = '44' Then Result := 'TÍTULO PAGO COM CHEQUE DEVOLVIDO'
      Else If strCodoco = '45' Then Result := 'TÍTULO PAGO COM CHEQUE COMPENSADO'
      Else If strCodoco = '46' Then Result := 'INSTRUÇÃO PARA CANCELAR PROTESTO CONFIRMADA'
      Else If strCodoco = '47' Then Result := 'INSTRUÇÃO PARA PROTESTO PARA FINS FALIMENTARES CONFIRMADA'
      Else If strCodoco = '48' Then Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE TRANSFERÊNCIA DE CARTEIRA/MODALIDADE DE COBRANÇA'
      Else If strCodoco = '49' Then Result := 'ALTERAÇÃO DE CONTRATO DE COBRANÇA'
      Else If strCodoco = '50' Then Result := 'TÍTULO PAGO COM CHEQUE PENDENTE DE LIQUIDAÇÃO'
      Else If strCodoco = '51' Then Result := 'TÍTULO DDA RECONHECIDO PELO PAGADOR'
      Else If strCodoco = '52' Then Result := 'TÍTULO DDA NÃO RECONHECIDO PELO PAGADOR'
      Else If strCodoco = '53' Then Result := 'TÍTULO DDA RECUSADO PELA CIP'
      Else If strCodoco = '54' Then Result := 'CONFIRMAÇÃO DA INSTRUÇÃO DE BAIXA DE TÍTULO NEGATIVADO SEM PROTESTO'
      Else If strCodoco = '55' Then Result := 'CONFIRMAÇÃO DE PEDIDO DE DISPENSA DE MULTA'
      Else If strCodoco = '56' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE COBRANÇA DE MULTA'
      Else If strCodoco = '57' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE COBRANÇA DE JUROS'
      Else If strCodoco = '58' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DO VALOR/DATA DE DESCONTO'
      Else If strCodoco = '59' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DO BENEFICIÁRIO DO TÍTULO'
      Else If strCodoco = '60' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE DISPENSA DE JUROS DE MORA'
      Else If strCodoco = '61' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR NOMINAL DO TÍTULO'
      Else If strCodoco = '63' Then Result := 'TÍTULO SUSTADO JUDICIALMENTE'
      Else If strCodoco = '64' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR MÍNIMO/PERCENTUAL'
      Else If strCodoco = '65' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR MÁXIMO/PERCENTUAL'
      Else If strCodoco = 'AB' Then Result := 'COBRANÇA A CREDITAR (EM TRÂNSITO)'
      Else If strCodoco = 'AC' Then Result := 'SITUAÇÃO DO TÍTULO - CARTÓRIO'
      Else                          Result := 'OUTRAS ';
    end;

  End

  Else If strCodBco = '133' Then
  Begin
           If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA'
      Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA'
      Else If strCodoco = '04' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/ENTRADA'
      Else If strCodoco = '05' Then Result := 'TRANSFERÊNCIA DE CARTEIRA/BAIXA'
      Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO'
      Else If strCodoco = '07' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DA INSTRUÇÃO DE DESCONTO'
      Else If strCodoco = '08' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DO CANCELAMENTO DO DESCONTO'
      Else If strCodoco = '09' Then Result := 'BAIXA'
      Else If strCodoco = '11' Then Result := 'TÍTULOS EM CARTEIRA (EM SER)'
      Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE ABATIMENTO'
      Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE CANCELAMENTO ABATIMENTO'
      Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO ALTERAÇÃO DE VENCIMENTO'
      Else If strCodoco = '15' Then Result := 'FRANCO DE PAGAMENTO'
      Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU LIQUIDAÇÃO TÍTULO NÃO REGISTRADO'
      Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO'
      Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE SUSTAÇÃO/CANCELAMENTO DE PROTESTO'
      Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO (APONTE EM CARTÓRIO)'
      Else If strCodoco = '24' Then Result := 'RETIRADA DE CARTÓRIO E MANUTENÇÃO EM CARTEIRA'
      Else If strCodoco = '25' Then Result := 'PROTESTADO E BAIXADO (BAIXA POR TER SIDO PROTESTADO)'
      Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA'
      Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS'
      Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS'
      Else If strCodoco = '29' Then Result := 'OCORRÊNCIAS DO PAGADOR'
      Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADA'
      Else If strCodoco = '33' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO RATEIO DE CRÉDITO'
      Else If strCodoco = '34' Then Result := 'CONFIRMAÇÃO DO CANCELAMENTO DOS DADOS DO RATEIO DE CRÉDITO'
      Else If strCodoco = '35' Then Result := 'CONFIRMAÇÃO DO DESAGENDAMENTO DO DÉBITO AUTOMÁTICO'
      Else If strCodoco = '36' Then Result := 'CONFIRMAÇÃO DE ENVIO DE E-MAIL/SMS'
      Else If strCodoco = '37' Then Result := 'ENVIO DE E-MAIL/SMS REJEITADO'
      Else If strCodoco = '38' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO PRAZO LIMITE DE RECEBIMENTO (A DATA DEVE SER INFORMADA NO CAMPO 28.3.P)'
      Else If strCodoco = '39' Then Result := 'CONFIRMAÇÃO DE DISPENSA DE PRAZO LIMITE DE RECEBIMENTO'
      Else If strCodoco = '40' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DO NÚMERO DO TÍTULO DADO PELO BENEFICIÁRIO'
      Else If strCodoco = '41' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DO NÚMERO CONTROLE DO PARTICIPANTE'
      Else If strCodoco = '42' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO PAGADOR'
      Else If strCodoco = '43' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO SACADOR/AVALISTA'
      Else If strCodoco = '44' Then Result := 'TÍTULO PAGO COM CHEQUE DEVOLVIDO'
      Else If strCodoco = '45' Then Result := 'TÍTULO PAGO COM CHEQUE COMPENSADO'
      Else If strCodoco = '46' Then Result := 'INSTRUÇÃO PARA CANCELAR PROTESTO CONFIRMADA'
      Else If strCodoco = '47' Then Result := 'INSTRUÇÃO PARA PROTESTO PARA FINS FALIMENTARES CONFIRMADA'
      Else If strCodoco = '48' Then Result := 'CONFIRMAÇÃO DE INSTRUÇÃO DE TRANSFERÊNCIA DE CARTEIRA/MODALIDADE DE COBRANÇA'
      Else If strCodoco = '49' Then Result := 'ALTERAÇÃO DE CONTRATO DE COBRANÇA'
      Else If strCodoco = '50' Then Result := 'TÍTULO PAGO COM CHEQUE PENDENTE DE LIQUIDAÇÃO'
      Else If strCodoco = '51' Then Result := 'TÍTULO DDA RECONHECIDO PELO PAGADOR'
      Else If strCodoco = '52' Then Result := 'TÍTULO DDA NÃO RECONHECIDO PELO PAGADOR'
      Else If strCodoco = '53' Then Result := 'TÍTULO DDA RECUSADO PELA CIP'
      Else If strCodoco = '54' Then Result := 'CONFIRMAÇÃO DA INSTRUÇÃO DE BAIXA DE TÍTULO NEGATIVADO SEM PROTESTO'
      Else If strCodoco = '55' Then Result := 'CONFIRMAÇÃO DE PEDIDO DE DISPENSA DE MULTA'
      Else If strCodoco = '56' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE COBRANÇA DE MULTA'
      Else If strCodoco = '57' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE COBRANÇA DE JUROS'
      Else If strCodoco = '58' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DO VALOR/DATA DE DESCONTO'
      Else If strCodoco = '59' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DO BENEFICIÁRIO DO TÍTULO'
      Else If strCodoco = '60' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE DISPENSA DE JUROS DE MORA'
      Else If strCodoco = '61' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR NOMINAL DO TÍTULO'
      Else If strCodoco = '63' Then Result := 'TÍTULO SUSTADO JUDICIALMENTE'
      Else If strCodoco = '64' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR MÍNIMO/PERCENTUAL'
      Else If strCodoco = '65' Then Result := 'CONFIRMAÇÃO DE ALTERAÇÃO DO VALOR MÁXIMO/PERCENTUAL'
      Else If strCodoco = 'AB' Then Result := 'COBRANÇA A CREDITAR (EM TRÂNSITO)'
      Else If strCodoco = 'AC' Then Result := 'SITUAÇÃO DO TÍTULO - CARTÓRIO'
      Else                          Result := 'OUTRAS ';

  End

  //*************************************************//
  // CODIGOS DE OCORRÊNCIA PARA O BANCO DA AMAZÔNIA  //
  //**********************************************JU*//
  Else If strCodBco = '003' Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA. '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA. '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL. '
    Else If strCodoco = '09' Then Result := 'BAIXADO AUTOMATICAMENTE VIA ARQUIVO. '
    Else If strCodoco = '10' Then Result := 'BAIXADO CONFORME INSTRUÇÕES DA AGÊNCIA. '
    Else If strCodoco = '11' Then Result := 'EM SER ARQUIVO DE TÍTULOS PENDENTES. '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO. '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO. '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO. '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO. '
    Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU TÍTULO NÃO REGISTRADO. '
    Else If strCodoco = '18' Then Result := 'ACERTO DE DEPOSITÁRIA. '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO. '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE SUSTAÇÃO DE PROTESTO. '
    Else If strCodoco = '21' Then Result := 'ACERTO DO CONTROLE DO PARTICIPANTE. '
    Else If strCodoco = '23' Then Result := 'ENTRADA DO TÍTULO EM CARTÓRIO. '
    Else If strCodoco = '24' Then Result := 'ENTRADA REJEITADA POR CEP IRREGULAR. '
    Else If strCodoco = '27' Then Result := 'BAIXA REJEITADA. '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS. '
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADOS. '
    Else If strCodoco = '32' Then Result := 'INSTRUÇÃO REJEITADA. '
    Else If strCodoco = '33' Then Result := 'CONFIRMAÇÃO ALTERAÇÃO PEDIDO OUTROS DADOS. '
    Else If strCodoco = '34' Then Result := 'RETIRADO DE CARTÓRIO E MANUTENÇÃO CARTEIRA. '
    Else                          Result := 'OUTRAS ';

  End
  //*************************************************//
  // CODIGOS DE OCORRÊNCIA PARA O BANCO RENDIMENTO   //
  //**********************************************JU*//
  Else If strCodBco = '633' Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA. '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA. '
    Else If strCodoco = '05' Then Result := 'CAMPO LIVRE ALTERADO. '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL. '
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO. '
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA. '
    Else If strCodoco = '10' Then Result := 'BAIXA POR TER SIDO LIQUIDADO. '
    Else If strCodoco = '12' Then Result := 'CONFIRMA ABATIMENTO. '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO. '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO. '
    Else If strCodoco = '15' Then Result := 'BAIXA REJEITADA. '
    Else If strCodoco = '16' Then Result := 'INSTRUÇÃO REJEITADA. '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO ORDEM DE PROTESTO. '
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO SUSTAÇÃO DE PROTESTO. '
    Else If strCodoco = '22' Then Result := 'SEU NUMERO ALTERADO. '
    Else If strCodoco = '23' Then Result := 'TÍTULO ENVIADO PARA CARTÓRIO. '
    Else If strCodoco = '24' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE NÃO PROTESTAR. '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS - CORRESPONDENTES. '
    Else If strCodoco = '40' Then Result := 'TARIFA DE ENTRADA (DEBITADA NA LIQUIDAÇÃO). '
    Else If strCodoco = '43' Then Result := 'BAIXADO POR TER SIDO PROTESTADO. '
    Else If strCodoco = '96' Then Result := 'TARIFA SOBRE INSTRUÇÕES - MÊS ANTERIOR. '
    Else If strCodoco = '97' Then Result := 'TARIFA SOBRE BAIXAS - MÊS ANTERIOR. '
    Else If strCodoco = '98' Then Result := 'TARIFA SOBRE ENTRADAS - MÊS ANTERIOR. '
    Else If strCodoco = '99' Then Result := 'TARIFA SOBRE INSTRUÇÕES DE PROTESTO/SUSTAÇÃO - MÊS ANTERIOR. '
    Else                          Result := 'OUTRAS ';

  End

  //*************************************************//
  // CODIGOS DE OCORRÊNCIA PARA O CECRED             //
  //**********************************************JU*//
  Else If strCodBco = '085' Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA.'
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA.'
    Else If strCodoco = '04' Then Result := 'TRANFERÊNCIA DE CARTEIRA/ENTRADA.'
    Else If strCodoco = '05' Then Result := 'TRANFERÊNCIA DE CARTEIRA/BAIXA.'
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO.'
    Else If strCodoco = '07' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DA INSTRUÇÃO DE DESCONTO.'
    Else If strCodoco = '08' Then Result := 'CONFIRMAÇÃO DO RECEBIMENTO DO CANCELAMENTO DO DESCONTO.'
    Else If strCodoco = '09' Then Result := 'BAIXA.'
    Else If strCodoco = '11' Then Result := 'TÍTULOS EM CARTEIRA.'
    Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INTRUÇÃO ABATIMENTO.'
    Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE CANCELAMENTO ABATIMENTO.'
    Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INTRUÇÃO ALETRAÇÃO DE VENCIMENTO.'
    Else If strCodoco = '17' Then Result := 'LIQUIDAÇÃO APÓS BAIXA OU LIQUIDAÇÃO TÍTULO NÃO REGISTRADO.'
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE PROTESTO.'
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO INSTRUÇÃO DE SUSTAÇÃO/CANCELAMENTO DE PROTESTO.'
    Else If strCodoco = '23' Then Result := 'REMESSA A CARTÓRIO (APONTE EM CARTÓRIO).'
    Else If strCodoco = '24' Then Result := 'RETIRADA DE CARTÓRIO E MANUTENÇÃO EM CARTEIRA.'
    Else If strCodoco = '25' Then Result := 'PROTESTADO E BAIXADO (BAIXA POR TER SIDO PROTESTADO).'
    Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA.'
    Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS.'
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFA/CUSTAS.'
    Else If strCodoco = '29' Then Result := 'OCORRÊNCIAS DO SACADO.'
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADA.'
    Else If strCodoco = '42' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO SACADO.'
    Else If strCodoco = '46' Then Result := 'INSTRUÇÃO PARA CANCELAR PROTESTO CONFIRMADA.'
    Else                          Result := 'OUTRAS';

  End

  //*************************************************//
  // CODIGOS DE OCORRENCIA PARA O BANCO DO NORDESTE  //
  //**********************************************KP*//
  Else If strCodBco = '004' Then
  Begin
    If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA.'
    Else If strCodoco = '04' Then Result := 'ALTERAÇÃO.'
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL.'
    Else If strCodoco = '07' Then Result := 'PAGAMENTO POR CONTA.'
    Else If strCodoco = '08' Then Result := 'PAGAMENTO POR CARTÓRIO.'
    Else If strCodoco = '09' Then Result := 'BAIXA SIMPES.'
    Else If strCodoco = '10' Then Result := 'DEVOLVIDO PROTESTADO.'
    Else If strCodoco = '11' Then Result := 'EM SER.'
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO.'
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO.'
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO.'
    Else If strCodoco = '15' Then Result := 'BAIXA AUTOMÁTICA.'
    Else If strCodoco = '18' Then Result := 'ALTERAÇÃO DEPOSITÁRIA.'
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO DE PROTESTO.'
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO DE SUSTAR PROTESTO.'
    Else If strCodoco = '21' Then Result := 'ALTERAÇÃO DE INFORMAÇÕES DE CONTROLE DA EMPRESA.'
    Else If strCodoco = '22' Then Result := 'ALTERAÇÃO "SEU NÚMERO".'
    Else If strCodoco = '51' Then Result := 'ENTRADA REJEITADA.'
    Else                          Result := 'OUTRAS';
  End

  //*************************************************//
  // CODIGOS DE OCORRÊNCIA PARA O UNICRED            //
  //**********************************************JU*//
  Else If Pos(strCodBco, '090_') > 0  Then
  Begin

         If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA.'
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA.'
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO.'
    Else If strCodoco = '09' Then Result := 'BAIXA.'
    Else If strCodoco = '12' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE INTRUÇÃO ABATIMENTO.'
    Else If strCodoco = '13' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE INTRUÇÃO DE CANCELAMENTO ABATIMENTO.'
    Else If strCodoco = '14' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE INTRUÇÃO DE ALETRAÇÃO DE VENCIMENTO.'
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE INTRUÇÃO DE PROTESTO.'
    Else If strCodoco = '20' Then Result := 'CONFIRMAÇÃO RECEBIMENTO DE INTRUÇÃO DE SUSTAÇÃO/CANCELAMENTO DE PROTESTO.'
    Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA.'
    Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO DO PEDIDO DE ALTERAÇÃO DE OUTROS DADOS.'
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DE DADOS REJEITADA.'
    Else If strCodoco = '41' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DO NÚMERO DO CONTROLE DO PARTICIPANTE.'
    Else If strCodoco = '42' Then Result := 'CONFIRMAÇÃO DA ALTERAÇÃO DOS DADOS DO SACADO.'
    Else                          Result := 'OUTRAS';

  End

 {**********************************************
  * CODIGOS DE OCORRÊNCIA PARA O UNICRED 136   *
  ******************************************MT**}
  Else If Pos(strCodBco, '136_') > 0  Then
  Begin
         If strCodoco = '01' Then Result := 'PAGO'
    Else If strCodoco = '02' Then Result := 'INSTRUÇÃO CONFIRMADA'
    Else If strCodoco = '03' Then Result := 'INSTRUÇÃO REJEITADA'
    Else If strCodoco = '04' Then Result := 'SUSTADO JUDICIAL'
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL'
    Else If strCodoco = '07' Then Result := 'LIQUIDAÇÃO EM CONDICIONAL'
    Else If strCodoco = '08' Then Result := 'SUSTADO DEFINITIVO'
    Else If strCodoco = '09' Then Result := 'LIQUIDAÇÃO DE TÍTULO DESCONTADO'
    Else If strCodoco = '10' Then Result := 'PROTESTO SOLICITADO'
    Else If strCodoco = '11' Then Result := 'PROTESTO EM CARTÓRIO'
    Else If strCodoco = '12' Then Result := 'SUSTAÇÃO SOLICITADA'
    Else If strCodoco = '13' Then Result := 'TÍTULOS DESCONTADO'
    Else If strCodoco = '14' Then Result := 'TÍTULOS DESCONTÁVEL'
    Else                          Result := 'OUTRAS';
  End

  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If (strCodBco = '246') Then
  Begin

    If strCodoco = '02' Then Result := 'ENTRADA CONFIRMADA '
    Else If strCodoco = '03' Then Result := 'ENTRADA REJEITADA '
    Else If strCodoco = '05' Then Result := 'CAMPO LIVRE ALTERADO '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '08' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '09' Then Result := 'BAIXA AUTOMÁTICA '
    Else If strCodoco = '10' Then Result := 'BAIXA POR TER SIDO LIQUIDADO '
    Else If strCodoco = '12' Then Result := 'CONFIRMA ABATIMENTO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'VENCIMENTO ALTERADO '
    Else If strCodoco = '15' Then Result := 'BAIXA REJEITADA '
    Else If strCodoco = '16' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '19' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE PROTESTO '
    Else If strCodoco = '20' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE SUSTAÇÃO '
    Else If strCodoco = '22' Then Result := 'SEU NÚMERO ALTERADO '
    Else If strCodoco = '23' Then Result := 'TÍTULO ENVIADO PARA CARTÓRIO '
    Else If strCodoco = '24' Then Result := 'CONFIRMA RECEBIMENTO DE ORDEM DE NÃO PROTESTAR '
    Else If strCodoco = '28' Then Result := 'DÉBITO DE TARIFAS/CUSTAS - CORRESPONDENTES '
    Else If strCodoco = '40' Then Result := 'TARIFA DE ENTRADA (DEBITADA NA LIQUIDAÇÃO) '
    Else If strCodoco = '43' Then Result := 'BAIXADO POR TER SIDO PROTESTADO '
    Else If strCodoco = '96' Then Result := 'TARIFA SOBRE INSTRUÇÕES - MÊS ANTERIOR '
    Else If strCodoco = '97' Then Result := 'TARIFA SOBRE BAIXAS - MÊS ANTERIOR '
    Else If strCodoco = '98' Then Result := 'TARIFA SOBRE ENTRADAS - MÊS ANTERIOR '
    Else If strCodoco = '99' Then Result := 'TARIFA SOBRE INSTRUÇÕES DE PROTESTO/SUSTAÇÃO - MÊS ANTERIOR '
    Else Result := 'OUTRAS ';

  End

  Else If (strCodBco = '089') Then
  Begin

    If strCodoco = '02' Then Result := 'CONFIRMAÇÃO ENTRADA TÍTULO '
    Else If strCodoco = '03' Then Result := 'COMANDO RECUSADO '
    Else If strCodoco = '04' Then Result := 'TRANSFERENCIA DE CARTEIRA - ENTRADA '
    Else If strCodoco = '05' Then Result := 'LIQUIDAÇÃO SEM REGISTRO '
    Else If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL '
    Else If strCodoco = '09' Then Result := 'BAIXA DE TÍTULO '
    Else If strCodoco = '10' Then Result := 'BAIXA SOLICITADA '
    Else If strCodoco = '11' Then Result := 'TÍTULOS EM SER '
    Else If strCodoco = '12' Then Result := 'ABATIMENTO CONCEDIDO '
    Else If strCodoco = '13' Then Result := 'ABATIMENTO CANCELADO '
    Else If strCodoco = '14' Then Result := 'ALTERAÇÃO DE VENCIMENTO '
    Else If strCodoco = '15' Then Result := 'LIQUIDAÇÃO EM CARTÓRIO '
    Else If strCodoco = '19' Then Result := 'CONFIRMAÇÃO INSTRUÇÃO PROTESTO '
    Else If strCodoco = '20' Then Result := 'DÉBITO EM CONTA '
    Else If strCodoco = '21' Then Result := 'ALTERAÇÃO DE NOME DO SACADO '
    Else If strCodoco = '22' Then Result := 'ALTERAÇÃO DE ENDEREÇO SACADO '
    Else If strCodoco = '23' Then Result := 'ENCAMINHADO A PROTESTO '
    Else If strCodoco = '24' Then Result := 'SUSTAR PROTESTO '
    Else If strCodoco = '25' Then Result := 'DISPENSAR JUROS '
    Else If strCodoco = '26' Then Result := 'INSTRUÇÃO REJEITADA '
    Else If strCodoco = '27' Then Result := 'CONFIRMAÇÃO ALTERAÇÃO DADOS '
    Else If strCodoco = '28' Then Result := 'MANUTENÇÃO TÍTULO VENCIDO '
    Else If strCodoco = '30' Then Result := 'ALTERAÇÃO DADOS REJEITADA '
    Else If strCodoco = '96' Then Result := 'DESPESAS DE PROTESTO '
    Else If strCodoco = '97' Then Result := 'DESPESAS DE SUSTAÇÃO DE PROTESTO '
    Else If strCodoco = '98' Then Result := 'DESPESAS DE CUSTAS ANTECIPADAS '
    Else Result := 'OUTRAS ';

  End
  Else If (strCodBco = '097') Then
  Begin
     If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL'
     Else Result := 'OUTRAS ';
  End
  Else If (strCodBco = '208') Then
  Begin

         If strCodoco = '02' Then Result := 'Entrada Confirmada'
    Else If strCodoco = '03' Then Result := 'Entrada Rejeitada'
    Else If strCodoco = '04' Then Result := 'Transferência de Carteira/Entrada'
    Else If strCodoco = '05' Then Result := 'Transferência de Carteira/Baixa'
    Else If strCodoco = '06' Then Result := 'Liquidação'
    Else If strCodoco = '07' Then Result := 'Confirmação do Recebimento da Instrução de Desconto'
    Else If strCodoco = '08' Then Result := 'Confirmação do Recebimento do Cancelamento do Desconto'
    Else If strCodoco = '09' Then Result := 'Baixa'
    Else If strCodoco = '11' Then Result := 'Títulos em Carteira (Em Ser)'
    Else If strCodoco = '12' Then Result := 'Confirmação Recebimento Instrução de Abatimento'
    Else If strCodoco = '13' Then Result := 'Confirmação Recebimento Instrução de Cancelamento Abatimento'
    Else If strCodoco = '14' Then Result := 'Confirmação Recebimento Instrução Alteração de Vencimento'
    Else If strCodoco = '15' Then Result := 'Franco de Pagamento'
    Else If strCodoco = '17' Then Result := 'Liquidação Após Baixa ou Liquidação Título Não Registrado'
    Else If strCodoco = '19' Then Result := 'Confirmação Recebimento Instrução de Protesto'
    Else If strCodoco = '20' Then Result := 'Confirmação Recebimento Instrução de Sustação/Cancelamento de Protesto'
    Else If strCodoco = '23' Then Result := 'Remessa a Cartório (Aponte em Cartório)'
    Else If strCodoco = '24' Then Result := 'Retirada de Cartório e Manutenção em Carteira'
    Else If strCodoco = '25' Then Result := 'Protestado e Baixado (Baixa por Ter Sido Protestado)'
    Else If strCodoco = '26' Then Result := 'Instrução Rejeitada'
    Else If strCodoco = '27' Then Result := 'Confirmação do Pedido de Alteração de Outros Dados'
    Else If strCodoco = '28' Then Result := 'Débito de Tarifas/Custas'
    Else If strCodoco = '29' Then Result := 'Ocorrências do Pagador'
    Else If strCodoco = '30' Then Result := 'Alteração de Dados Rejeitada'
    Else If strCodoco = '33' Then Result := 'Confirmação da Alteração dos Dados do Rateio de Crédito'
    Else If strCodoco = '34' Then Result := 'Confirmação do Cancelamento dos Dados do Rateio de Crédito'
    Else If strCodoco = '35' Then Result := 'Confirmação do Desagendamento do Débito Automático'
    Else If strCodoco = '36' Then Result := 'Confirmação de envio de e-mail/SMS'
    Else If strCodoco = '37' Then Result := 'Envio de e-mail/SMS rejeitado'
    Else If strCodoco = '38' Then Result := 'Confirmação de alteração do Prazo Limite de Recebimento (a data deve ser informada no campo 28.3.p)'
    Else If strCodoco = '39' Then Result := 'Confirmação de Dispensa de Prazo Limite de Recebimento'
    Else If strCodoco = '40' Then Result := 'Confirmação da alteração do número do título dado pelo Beneficiário'
    Else If strCodoco = '41' Then Result := 'Confirmação da alteração do número controle do Participante'
    Else If strCodoco = '42' Then Result := 'Confirmação da alteração dos dados do Pagador'
    Else If strCodoco = '43' Then Result := 'Confirmação da alteração dos dados do Sacador/Avalista'
    Else If strCodoco = '44' Then Result := 'Título pago com cheque devolvido'
    Else If strCodoco = '45' Then Result := 'Título pago com cheque compensado'
    Else If strCodoco = '46' Then Result := 'Instrução para cancelar protesto confirmada'
    Else If strCodoco = '47' Then Result := 'Instrução para protesto para fins falimentares confirmada'
    Else If strCodoco = '48' Then Result := 'Confirmação de instrução de transferência de carteira/modalidade de cobrança'
    Else If strCodoco = '49' Then Result := 'Alteração de contrato de cobrança'
    Else If strCodoco = '50' Then Result := 'Título pago com cheque pendente de liquidação'
    Else If strCodoco = '51' Then Result := 'Título DDA reconhecido pelo Pagador'
    Else If strCodoco = '52' Then Result := 'Título DDA não reconhecido pelo Pagador'
    Else If strCodoco = '53' Then Result := 'Título DDA recusado pela CIP'
    Else If strCodoco = '54' Then Result := 'Confirmação da Instrução de Baixa de Título Negativado sem Protesto'
    Else If strCodoco = '55' Then Result := 'Confirmação de Pedido de Dispensa de Multa'
    Else If strCodoco = '56' Then Result := 'Confirmação do Pedido de Cobrança de Multa'
    Else If strCodoco = '57' Then Result := 'Confirmação do Pedido de Alteração de Cobrança de Juros'
    Else If strCodoco = '58' Then Result := 'Confirmação do Pedido de Alteração do Valor/Data de Desconto'
    Else If strCodoco = '59' Then Result := 'Confirmação do Pedido de Alteração do Beneficiário do Título'
    Else If strCodoco = '60' Then Result := 'Confirmação do Pedido de Dispensa de Juros de Mora'
    Else If strCodoco = '61' Then Result := 'Confirmação de Alteração do Valor Nominal do Título'
    Else If strCodoco = '63' Then Result := 'Título Sustado Judicialmente'
    Else If strCodoco = '64' Then Result := 'Confirmação de alteração do valor mínimo/percentual'
    Else If strCodoco = '65' Then Result := 'Confirmação de alteração do valor máximo/percentual'
    Else Result := 'OUTRAS ';

  End

  {***********************************}
  {* BANCO DO BMP MONEY PLUS LP      *}
  {********************************LB*}
  Else If (strCodBco  = '274') Then
  Begin

    If strCodoco = '02' Then
      Result := 'ENTRADA CONFIRMADA '

    Else If strCodoco = '03' Then
      Result := 'ENTRADA REJEITADA '

    Else If strCodoco = '06' Then
      Result := 'LIQUIDAÇÃO NORMAL '

    Else If strCodoco = '08' Then
      Result := 'LIQUIDAÇÃO EM CARTÓRIO '

    Else If strCodoco = '09' Then
      Result := 'BAIXADO AUTOMATICAMENTE VIA ARQUIVO (COND.CAD.) '

    Else If strCodoco = '10' Then
      Result := 'BAIXADO CONFORME INSTRUCOES DA AGÊNCIA '

    Else If strCodoco = '11' Then
      Result := 'TÍTULOS EM SER - ARQUIVO DE TÍTULOS PENDENTES '

    Else If strCodoco = '12' Then
      Result := 'ABATIMENTO CONCEDIDO '

    Else If strCodoco = '13' Then
      Result := 'ABATIMENTO CANCELADO '

    Else If strCodoco = '17' Then
      Result := 'LIQUIDAÇÃO APOS BAIXA OU TÍTULO NÃO REGISTRADO '

    Else If strCodoco = '18' Then
      Result := 'ACERTO DE DEPOSITARIA '

    Else If strCodoco = '21' Then
      Result := 'ACERTO DO CONTROLE DO PARTICIPANTE '

    Else If strCodoco = '22' Then
      Result := 'TITULO COM PAGAMENTO CANCELADO '

    Else If strCodoco = '23' Then
      Result := 'ENTRADA DO TÍTULO EM CARTÓRIO '

    Else If strCodoco = '24' Then
      Result := 'ENTRADA REJEITADA POR CEP IRREGULAR '

    Else If strCodoco = '27' Then
      Result := 'BAIXA REJEITADA '

    Else If strCodoco = '28' Then
      Result := 'DÉBITO DE TARIFAS/CUSTAS CARTORARIAS '

    Else If strCodoco = '29' Then
      Result := 'OCORRENCIAS DO PAGADOR '

    Else If strCodoco = '32' Then
      Result := 'INSTRUÇÃO REJEITADA '

    Else If strCodoco = '40' Then
      Result := 'ESTORNO DE PAGAMENTO '

    Else
      Result := 'OUTRAS';

  End

  {***********************************}
  {* 964 - FINANCEIRA FORMULA - 400P *}
  {***********************************}
  Else If (strCodBco = '964') Then
  Begin

         If strCodoco = '02' Then Result := 'Entrada confirmada'
    Else If strCodoco = '03' Then Result := 'Entrada rejeitada'
    Else If strCodoco = '04' Then Result := 'Alteração de dados – nova entrada ou alteração/exclusão de dados acatada'
    Else If strCodoco = '05' Then Result := 'Alteração de dados – baixa'
    Else If strCodoco = '06' Then Result := 'Liquidação normal'
    Else If strCodoco = '07' Then Result := 'Liquidação parcial – cobrança inteligente (b2b)'
    Else If strCodoco = '08' Then Result := 'Liquidação em cartório'
    Else If strCodoco = '09' Then Result := 'Baixa simples'
    Else If strCodoco = '11' Then Result := 'Baixa por ter sido liquidado em ser (só no retorno mensal)'
    Else If strCodoco = '12' Then Result := 'Abatimento concedido'
    Else If strCodoco = '13' Then Result := 'Abatimento cancelado'
    Else If strCodoco = '14' Then Result := 'Vencimento alterado'
    Else If strCodoco = '15' Then Result := 'Baixas rejeitadas'
    Else If strCodoco = '16' Then Result := 'Instruções rejeitadas'
    Else If strCodoco = '17' Then Result := 'Alteração/exclusão de dados rejeitados'
    Else If strCodoco = '18' Then Result := 'Cobrança contratual – instruções/alterações rejeitadas/pendentes'
    Else If strCodoco = '19' Then Result := 'Confirma recebimento de instrução de protesto'
    Else If strCodoco = '20' Then Result := 'Confirma recebimento de instrução de sustação de protesto /tarifa'
    Else If strCodoco = '21' Then Result := 'Confirma recebimento de instrução de não protestar'
    Else If strCodoco = '23' Then Result := 'Título enviado a cartório/tarifa'
    Else If strCodoco = '24' Then Result := 'Instrução de protesto rejeitada / sustada / pendente'
    Else If strCodoco = '25' Then Result := 'Alegações do pagador'
    Else If strCodoco = '26' Then Result := 'Tarifa de aviso de cobrança'
    Else If strCodoco = '27' Then Result := 'Tarifa de extrato posição'
    Else If strCodoco = '28' Then Result := 'Tarifa de relação das liquidações'
    Else If strCodoco = '29' Then Result := 'Tarifa de manutenção de títulos vencidos'
    Else If strCodoco = '30' Then Result := 'Débito mensal de tarifas (para entradas e baixas)'
    Else If strCodoco = '32' Then Result := 'Baixa por ter sido protestado'
    Else If strCodoco = '33' Then Result := 'Custas de protesto'
    Else If strCodoco = '34' Then Result := 'Custas de sustação'
    Else If strCodoco = '35' Then Result := 'Custas de cartório distribuidor'
    Else If strCodoco = '36' Then Result := 'Custas de edital'
    Else If strCodoco = '37' Then Result := 'Tarifa de emissão de boleto/tarifa de envio de duplicata'
    Else If strCodoco = '38' Then Result := 'Tarifa de instrução'
    Else If strCodoco = '39' Then Result := 'Tarifa de ocorrências'
    Else If strCodoco = '40' Then Result := 'Tarifa mensal de emissão de boleto/tarifa mensal de envio de duplicata'
    Else If strCodoco = '41' Then Result := 'Débito mensal de tarifas – extrato de posição (b4ep/b4ox)'
    Else If strCodoco = '42' Then Result := 'Débito mensal de tarifas – outras instruções'
    Else If strCodoco = '43' Then Result := 'Débito mensal de tarifas – manutenção de títulos vencidos'
    Else If strCodoco = '44' Then Result := 'Débito mensal de tarifas – outras ocorrências'
    Else If strCodoco = '45' Then Result := 'Débito mensal de tarifas – protesto'
    Else If strCodoco = '46' Then Result := 'Débito mensal de tarifas – sustação de protesto'
    Else If strCodoco = '47' Then Result := 'Baixa com transferência para desconto'
    Else If strCodoco = '48' Then Result := 'Custas de sustação judicial'
    Else If strCodoco = '51' Then Result := 'Tarifa mensal ref a entradas bancos correspondentes na carteira'
    Else If strCodoco = '52' Then Result := 'Tarifa mensal baixas na carteira'
    Else If strCodoco = '53' Then Result := 'Tarifa mensal baixas em bancos correspondentes na carteira'
    Else If strCodoco = '54' Then Result := 'Tarifa mensal de liquidações na carteira'
    Else If strCodoco = '55' Then Result := 'Tarifa mensal de liquidações em bancos correspondentes na carteira'
    Else If strCodoco = '56' Then Result := 'Custas de irregularidade'
    Else If strCodoco = '57' Then Result := 'Instrução cancelada'
    Else If strCodoco = '59' Then Result := 'Baixa por crédito em c/c através do sispag'
    Else If strCodoco = '60' Then Result := 'Entrada rejeitada carnê'
    Else If strCodoco = '61' Then Result := 'Tarifa emissão aviso de movimentação de títulos'
    Else If strCodoco = '62' Then Result := 'Débito mensal de tarifa – aviso de movimentação de títulos'
    Else If strCodoco = '63' Then Result := 'Título sustado judicialmente'
    Else If strCodoco = '64' Then Result := 'Entrada confirmada com rateio de crédito'
    Else If strCodoco = '65' Then Result := 'Pagamento com cheque – aguardando compensação'
    Else If strCodoco = '69' Then Result := 'Cheque devolvido'
    Else If strCodoco = '71' Then Result := 'Entrada registrada, aguardando avaliação'
    Else If strCodoco = '72' Then Result := 'Baixa por crédito em c/c através do sispag sem título correspondente'
    Else If strCodoco = '73' Then Result := 'Confirmação de entrada na cobrança simples – entrada não aceita na cobrança contratual'
    Else If strCodoco = '74' Then Result := 'Instrução de negativação expressa rejeitada'
    Else If strCodoco = '75' Then Result := 'Confirmação de recebimento de instrução de entrada em negativação expressa'
    Else If strCodoco = '76' Then Result := 'Cheque compensado'
    Else If strCodoco = '77' Then Result := 'Confirmação de recebimento de instrução de exclusão de entrada em negativação expressa'
    Else If strCodoco = '78' Then Result := 'Confirmação de recebimento de instrução de cancelamento de negativação expressa'
    Else If strCodoco = '79' Then Result := 'Negativação expressa informacional'
    Else If strCodoco = '80' Then Result := 'Confirmação de entrada em negativação expressa – tarifa'
    Else If strCodoco = '82' Then Result := 'Confirmação do cancelamento de negativação expressa – tarifa'
    Else If strCodoco = '83' Then Result := 'Confirmação de exclusão de entrada em negativação expressa por liquidação – tarifa'
    Else If strCodoco = '85' Then Result := 'Tarifa por boleto (até 03 envios) cobrança ativa eletrônica'
    Else If strCodoco = '86' Then Result := 'Tarifa email cobrança ativa eletrônica'
    Else If strCodoco = '87' Then Result := 'Tarifa sms cobrança ativa eletrônica'
    Else If strCodoco = '88' Then Result := 'Tarifa mensal por boleto (até 03 envios) cobrança ativa eletrônica'
    Else If strCodoco = '89' Then Result := 'Tarifa mensal email cobrança ativa eletrônica'
    Else If strCodoco = '90' Then Result := 'Tarifa mensal sms cobrança ativa eletrônica'
    Else If strCodoco = '91' Then Result := 'Tarifa mensal de exclusão de entrada de negativação expressa'
    Else If strCodoco = '92' Then Result := 'Tarifa mensal de cancelamento de negativação expressa'
    Else If strCodoco = '93' Then Result := 'Tarifa mensal de exclusão de negativação expressa por liquidação'
    Else Result := 'Outras';

  End

  Else If (strCodBco = '077') Then
  Begin
     If strCodoco = '06' Then Result := 'LIQUIDAÇÃO NORMAL'
     Else Result := 'OUTRAS ';
  End

end;

function TfrmRelRetBco.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender = edtOrdem Then
  Begin
    If (edtOrdem.Text <> 'V') And (edtOrdem.Text <> 'D') Then
    Begin
      fMensagem('ATENÇÃO','O campo Ordenar Por deve ser V ou D!' ,['&O K']);
      Result := False;
    End;
  end
  else
  If Sender = edtDados Then
  Begin
    If (edtDados.Text <> 'C') And (edtDados.Text <> 'A') Then
    Begin
      fMensagem('ATENÇÃO','O campo Mostrar dados deve ser C ou A!' ,['&O K']);
      Result := False;
    End;
  end
  else
  If Sender = edtExibirCodCliente Then
  Begin
    If (edtExibirCodCliente.Text <> 'S') And (edtExibirCodCliente.Text <> 'N') Then
    Begin
      fMensagem('ATENÇÃO','O campo Exibir deve ser S ou N!' ,['&O K']);
      Result := False;
    End;
  end
  else
  If Sender = edtQuebraNomeCliente Then
  Begin
    If (edtQuebraNomeCliente.Text <> 'S') And (edtQuebraNomeCliente.Text <> 'N') Then
    Begin
      fMensagem('ATENÇÃO','O campo Quebrar Nome deve ser S ou N!' ,['&O K']);
      Result := False;
    End;
  end
  else
  If Sender = edtDestino Then
  Begin
    If (edtDestino.Text <> 'V') And (edtDestino.Text <> 'I') Then
    Begin
      fMensagem('ATENÇÃO','O campo Destino deve ser V ou I!' ,['&O K']);
      Result := False;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelRetBco.lstCodOcoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelRetBco.pCalculaValorCorrigido;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCalculaValorCorrigidoInterna;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

function TfrmRelRetBco.fCalculaValorCorrigidoInterna(cxProgresso : TcxProgressBar):Boolean;
  Var
    LConsiderarDescontoSugerido : Boolean;
    strTipBco: String;
begin
  strTipBco := strCodBco;
  If (strCodBco = '001') Then
  Begin
    strTipBco := RightStr(strNomBanco, 2);
    If (strTipBco = '7d') Then
      strTipBco := strCodBco + 'D7'
    Else
      strTipBco := strCodBco;;
  End
  Else If (strCodBco = '104') Then
  Begin
    strTipBco := RightStr(strNomBanco, 4);
    If (strTipBco = '400p') Then
      strTipBco := strCodBco + 'p400'
    Else
      strTipBco := strCodBco;
  End
  Else If (strCodBco = '756') Then
  Begin
    strTipBco := RightStr(strNomBanco, 4);
    If (strTipBco = '240p') Then
      strTipBco := strCodBco + '_240p'
    Else
      strTipBco := strCodBco;
  End;

  Try
    cdsRetBco.DisableControls;
    cdsRetBco.First;

    cxProgresso.Properties.Max := cdsRetBco.RecordCount;
    cxProgresso.Position := 0;

    While Not cdsRetBco.Eof Do
    Begin
      cxProgresso.Position := cdsRetBco.RecNo;

      cdsRetBco.Edit;

      If strNomBanco <> '041 - Banrisul [240p]' Then
        cdsRetBco.FieldByName('VALCOR').AsFloat := cdsRetBco.FieldByName('CTR_VALDUP').AsFloat + fCalculaJurosCadCtr(fAcertaDataParaDiaUtil(cdsRetBco.FieldByName('CTR_DTAVEN').AsDateTime),  cdsRetBco.FieldByName('DTAPAG').AsString, cdsRetBco.FieldByName('CTR_VALDUP').AsFloat)
      Else
        cdsRetBco.FieldByName('VALCOR').AsFloat := cdsRetBco.FieldByName('CTR_VALDUP').AsFloat + fCalculaJurosCadCtr(fAcertaDataParaDiaUtil(cdsRetBco.FieldByName('CTR_DTAVEN').AsDateTime),  cdsRetBco.FieldByName('DTAPAG').AsString, cdsRetBco.FieldByName('CTR_VALDUP').AsFloat, 9999, 9999, 9999, '341');

      if cdsRetBco.FieldByName('VALPAG').AsFloat <> 0 then
      Begin
        if cdsRetBco.FieldByName('CTR_VALREC').AsFloat > 0 then
           cdsRetBco.FieldByName('VALDIF').AsFloat := 0
        Else
           cdsRetBco.FieldByName('VALDIF').AsFloat := RoundTo(cdsRetBco.FieldByName('VALCOR').AsFloat  - (cdsRetBco.FieldByName('VALPAG').AsFloat+ cdsRetBco.FieldByName('TARIFA').AsFloat),-2);
      End
      Else
        cdsRetBco.FieldByName('VALDIF').Clear;

      If (cdsRetBco.FieldByName('VALDIF').AsFloat > 0.00) And (cdsRetBco.FieldByName('CTR_DESSUJ').AsFloat > 0.00) Then
      Begin
        If Not MatchStr(strCodBco, ['341API', '033API', '756API', '077', '237API']) Then
        Begin
          LConsiderarDescontoSugerido := (fGetBancoConfig(0,'CONFIG' + strTipBco + '-' + cdsRetBco.FieldByName('CARTEI').AsString, 'CONSIDESSUJ', '') <> 'N');
          If LConsiderarDescontoSugerido Then
          Begin
            If (cdsRetBco.FieldByName('VALDIF').AsFloat = cdsRetBco.FieldByName('CTR_DESSUJ').AsFloat) Then
            Begin
              cdsRetBco.FieldByName('VALDIF').AsFloat := 0.00;
              cdsRetBco.FieldByName('DESCON').AsFloat := fFormataFloat(cdsRetBco.FieldByName('DESCON').AsFloat +  cdsRetBco.FieldByName('CTR_DESSUJ').AsFloat, 2);
              If (fFormataFloat(cdsRetBco.FieldByName('CTR_VALDUP').AsFloat - cdsRetBco.FieldByName('VALDUP').AsFloat,2) = cdsRetBco.FieldByName('VALDIF').AsFloat) Then
              Begin
                cdsRetBco.FieldByName('VALDUP').AsFloat := fFormataFloat(cdsRetBco.FieldByName('VALDUP').AsFloat +  cdsRetBco.FieldByName('VALDIF').AsFloat ,2);
              End;
            End;
          End;
        End;
      End;

      cdsRetBco.Post;

      cdsRetBco.Next;
    End;

    Result := True;

  Finally
    cdsRetBco.EnableControls;
  End;

End;

procedure TfrmRelRetBco.pGeraRelatorio(strCodBco: String);
  Var
    LImpPadrao: String;
begin
  blnImprimir := False;

  If Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LImpPadrao := TCfgRel.fGetImpPadraoWindows;
    If (edtDestino.Text = 'V') And (VerImpressoraONLINE(LImpPadrao) <> 0) Then
    Begin
      TCfgRel.fMensagem('ATENÇÃO!',
        'Impressora padrão não encontrada ou não disponível. Impressora: "' +

        LImpPadrao + '".', ['&OK']);

    End;
  End;

  BlnEncBan := fCfgSis('ENCBAN', varBoolean);
  if blnEncBan Then
    blnEncBan := Not MatchStr(strCodBco, ['033API', '756API']);

  pGetRelPrincipal_F;
  pGetRelBaixadas_F;
  pGetCodigoErroPix;

  If BlnEncBan Then
     GeraRelatorioBaixadasLancaTarifa_F; // apenas quando eh rel tarifa;

  pGetRelOcorrencias_F;
  pGetRelNaoBaixadas_F;

  if blnImprimir Then
  begin

    AddFunctionFRX();
    AddVariablesFRX();
    pConfigurarQuebraNomeCliente(frxRetBco, edtQuebraNomeCliente.Text = 'S');
    pConfigurarQuebraNomeCliente(frxRetBcoTarifa, edtQuebraNomeCliente.Text = 'S');

    If edtDestino.Text = 'V' Then
    begin

      If BlnEncBan Then
         pPreviewReport(Self.Name, 'Relatório de Arquivo retorno', frxRetBcoTarifa)
      Else
         pPreviewReport(Self.Name, 'Relatório de Arquivo retorno', frxRetBco);

    end
    Else
    begin

      if BlnEncBan then
         pPrintReport(Self.Name, 'Relatório de Arquivo retorno', strNomImp, frxRetBcoTarifa)
      else
         pPrintReport(Self.Name, 'Relatório de Arquivo retorno', strNomImp, frxRetBco);

    end;

  end
  else
  begin
    pTabelaVazia;
    pSetFocus(edtDestino);
  end;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelRetBco.pRetDadosConta(intCartei: Integer);
var
  strTipBco: String;
begin
  strTipBco := strCodBco;
  If (strCodBco = '001') Then
  Begin
    strTipBco := RightStr(strNomBanco, 2);
    If (strTipBco = '7d') Then
      strTipBco := strCodBco + 'D7'
    Else
      strTipBco := strCodBco;;
  End
  Else If (strCodBco = '104') Then
  Begin
    strTipBco := RightStr(strNomBanco, 4);
    If (strTipBco = '400p') Then
      strTipBco := strCodBco + 'p400'
    Else
      strTipBco := strCodBco;
  End;
  strCodAge := fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'CODAGEN', '');
  strNumCta := fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'NUMCTAC', '');

  If (strCodBco = '422') Then
  Begin
     If Pos('Safra [Online]', strNomBanco) > 0 Then
     Begin
       strCodAge := fGetBancoConfig(0, 'CONFIG422API' + '-' + IntToStr(intCartei), 'CODAGEN', '') + fGetBancoConfig(0, 'CONFIG422API' + '-' + IntToStr(intCartei), 'DIGAGEN', '');
       strNumCta := fGetBancoConfig(0, 'CONFIG422API' + '-' + IntToStr(intCartei), 'NUMCTAC', '');
     End;
     strCodBco := LeftStr(strNomBanco,3) + 'p400'
  End;

  If LeftStr(strCodBco, 3) = '748' then
    ACedente := fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'POSTOCO', '') + '.' +
                fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'IDENTBC', '');

   If strCodBco.Equals('756API') then
   Begin
     strCodAge := fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'CODCOPE', '');
     strNumCta := fGetBancoConfig(0, 'CONFIG' + strTipBco + '-' + IntToStr(intCartei), 'CODCCOR', '');
   End;
end;

procedure TfrmRelRetBco.pConfigurarQuebraNomeCliente(AReport: TfrxReport; const AQuebrar: Boolean);
  Var
    LCliente: TfrxComponent;
    LZebra  : TfrxComponent;
    LBanda  : TfrxComponent;
begin
  LCliente := AReport.FindObject('mmcliente');
  LZebra   := AReport.FindObject('mmoZebra');
  LBanda   := AReport.FindObject('masterDataDuplicatas');

  If Not (LCliente is TfrxMemoView) Then
    Exit;

  If Not (LZebra is TfrxMemoView) Then
    Exit;

  If Not (LBanda is TfrxBand) Then
    Exit;

  TfrxMemoView(LCliente).WordWrap := AQuebrar;
  TfrxBand(LBanda).Stretched      := AQuebrar;

  TfrxMemoView(LCliente).StretchMode := smDontStretch;
  TfrxMemoView(LZebra).StretchMode   := smDontStretch;

  If AQuebrar Then
  Begin
    TfrxMemoView(LCliente).StretchMode := smActualHeight;
    TfrxMemoView(LZebra).StretchMode   := smMaxHeight;
  End;
end;

function TfrmRelRetBco.RetornaMotivoOcorrenciaSelecionada: String;
Var
  intIndex : Integer;
Begin
  Result := '';

  if (LeftStr(strCodBco, 3) = '237') then
  Begin

    For intIndex := 0 To lstCodOco.Items.Count - 1 Do
    Begin

      if (lstCodOco.Items[intIndex].Checked) then
      begin

        If Pos( ' /. ', lstCodOco.Items[intIndex].Text ) > 0 Then
           Result := Result + Copy(lstCodOco.Items[intIndex].Text, (pos( ' /. ', lstCodOco.Items[intIndex].Text )+ 4), 2) + '_'
        else
           Result := Result + '00' + '_';

      end;

    End;

  End
  Else
  Begin

    For intIndex := 0 To lstCodOco.Items.Count - 1 Do
    Begin
      if (lstCodOco.Items[intIndex].Checked) then
      begin
        if Copy(lstCodOco.Items[intIndex].Text, 3, 1) = '.' then
          Result := Result + Copy(lstCodOco.Items[intIndex].Text, 4, 2) + '_'
        else
          Result := Result + '00' + '_';
      end;
    End;

  End;

end;

procedure TfrmRelRetBco.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtOrdem);
end;

procedure TfrmRelRetBco.FormCreate(Sender: TObject);
begin
  inherited;
  qryRelatorio := TZClient.Create(Self);

end;

procedure TfrmRelRetBco.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelRetBco.FormShow(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;
  qryOcorrencia := fCriaQuery(qryOcorrencia);
  qryTotalGeral := fCriaQuery(qryTotalGeral);

  cdsretbco.Open;

  strCodBco := LeftStr(strNomBanco, 3);

  {**********************************}
  {* RETORNA O CODIGO DA OCORRÊNCIA *}
  {*******************************LB*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  RET_CODOCO AS CODOCO, ';
  strSQL := strSQL + '  RET_MOTOCO AS MOTOCO, ';
  strSQL := strSQL + '  COUNT(RET_CODOCO) AS QTDDUP, ';
  strSQL := strSQL + '  SUM(RET_VALDUP) AS VALDUP,   ';
  strSQL := strSQL + '  SUM(RET_VALPAG) AS VALPAG    ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RETBCO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  RET_CODBCO = :CODBCO ';

  If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
  Begin
    If ATipoCnab.Equals('API') Then
      strSQL := strSQL + ' AND IFNULL(RET_CNAB__,"") = "API" '
    Else
      strSQL := strSQL + ' AND IFNULL(RET_CNAB__,"") <> "API"  ';
  End;

  If fCfgSis('EMPIMP', varBoolean) Then
    strSQL := strSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString + ' ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  RET_CODOCO ';
  strSQL := strSQL + ', RET_MOTOCO ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  RET_CODOCO, RET_MOTOCO ';

  If MatchStr(strCodBco, ['341', '033','756']) Then
  Begin
    If ATipoCnab.IsEMpty Then
      ATipoCnab := '400';
  End;

  qryOcorrencia.Close;
  qryOcorrencia.SQL.Text := strSQL;
  qryOcorrencia.ParamByName('CODBCO').AsString := strCodBco;
  qryOcorrencia.Open;

  While Not qryOcorrencia.Eof do
  Begin

    if MatchStr(LeftStr(strCodBco, 3), ['001', '748', '237', '097', '274', '341', '033', '756']) then
    begin

      If (LeftStr(strCodBco, 3) = '237') then
      Begin

          lstCodOco.Items.Add;
          if (not fEmptyStr(qryOcorrencia.FieldByName('MOTOCO').AsString)) and (qryOcorrencia.FieldByName('MOTOCO').AsString <> '00') then
             lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryOcorrencia. FieldByName('CODOCO').AsString + ' - ' +
                                                              RetornaOcorrencia(LeftStr(strCodBco, 3), qryOcorrencia.FieldByName('CODOCO').AsString, ATipoCnab) + ' /. ' +
                                                              RetornaOcorrencia(LeftStr(strCodBco, 3), qryOcorrencia.FieldByName('CODOCO').AsString, ATipoCnab, qryOcorrencia.FieldByName('MOTOCO').AsString)
          else
             lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryOcorrencia.FieldByName('CODOCO').AsString + ' - ' +
                                                              RetornaOcorrencia(LeftStr(strCodBco, 3), qryOcorrencia.FieldByName('CODOCO').AsString, ATipoCnab);

          lstCodOco.Items[lstCodOco.Items.Count-1].Checked := True;
      End
      Else
      Begin

        lstCodOco.Items.Add;

        if (not fEmptyStr(qryOcorrencia.FieldByName('MOTOCO').AsString)) and
           (qryOcorrencia.FieldByName('MOTOCO').AsString <> '00') then
          lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryOcorrencia.FieldByName('CODOCO').AsString + '.' +
                                                           RetornaOcorrencia(LeftStr(strCodBco, 3), qryOcorrencia.FieldByName('CODOCO').AsString, ATipoCnab, qryOcorrencia.FieldByName('MOTOCO').AsString)
        else
          lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryOcorrencia.FieldByName('CODOCO').AsString + ' - ' +
                                                           RetornaOcorrencia(LeftStr(strCodBco, 3), qryOcorrencia.FieldByName('CODOCO').AsString, ATipoCnab);

        lstCodOco.Items[lstCodOco.Items.Count-1].Checked := True;
      End;

    end
    else
    Begin
      lstCodOco.Items.Add;
      lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryOcorrencia.FieldByName('CODOCO').AsString + ' - ' + fRetDescOco(qryOcorrencia.FieldByName('CODOCO').AsString);
      lstCodOco.Items[lstCodOco.Items.Count-1].Checked := True;
    End;

    qryOcorrencia.Next;
  End;

 qryOcorrencia. First;
end;

function TfrmRelRetBco.fRetCodOcoSelec : String;
  Var
    intIndex : Integer;
Begin
  Result := '';
  For intIndex := 0 To lstCodOco.Items.Count - 1 Do
  Begin
    if lstCodOco.Items[intIndex].Checked then
      Result := Result + Copy(lstCodOco.Items[intIndex].Text, 1, 2) + '_';
  End;

End;

// Fast
procedure TfrmRelRetBco.pGetRelPrincipal_F;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT IF(RET_MOTOCO <> "00" AND RET_CODBCO IN (SELECT DISTINCT(OCO_CODBCO) FROM OCOBAN), ';
  strSQL := strSQL + '       CONCAT(RET_CODOCO, ".", RET_MOTOCO), RET_CODOCO) AS CODOCO, ';
  strSQL := strSQL + '       RET_NOSNUM AS NOSNUM,                                     ';
  strSQL := strSQL + '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP,                  ';
  strSQL := strSQL + '       RET_CODEMP AS CODEMP,                                     ';
  strSQL := strSQL + '       RET_DTAVEN AS DTAVEN,                                     ';
  strSQL := strSQL + '       IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, RET_DTAOCO),NULL) AS DTAPAG, ';
  strSQL := strSQL + '       RET_VALPAG AS VALPAG,                                     ';
  strSQL := strSQL + '       RET_JURMOR AS JURMOR,                                     ';
  strSQL := strSQL + '       RET_DESCON AS DESCON,                                     ';
  strSQL := strSQL + '       RET_CODREJ,                                               ';
  strSQL := strSQL + '       RET_CODBCO,                                               ';
  strSQL := strSQL + '       RET_OUTVAL AS OUTVAL,                                     ';
  strSQL := strSQL + '       RET_VALDUP AS VALDUP,                                     ';
  strSQL := strSQL + '       RET_CARTEI AS CARTEI,                                     ';
  strSQL := strSQL + '       IFNULL(RET_TARIFA, 0.00) AS TARIFA,                       ';

  strSQL := strSQL + IIf( edtExibirCodCliente.Text = 'S', ' CONCAT(RET_CODCLI, "-", CLI_NOMCLI) AS CODCLI, ',  ' CLI_NOMCLI AS CODCLI, ' );

  strSQL := strSQL + '       MAX(DET.DET_DTARET) AS DTARET,                                 ';
  strSQL := strSQL + '       CONCAT(RET_NOMARQ, " - ", RET_DTAARQ, " - ", RET_HORARQ) AS NOMARQ, ';
  strSQL := strSQL + '       CLI_C_E_P_ AS CEPCLI,                                     ';
  strSQL := strSQL + '       R.CTR_DTAVEN,                                             ';
  strSQL := strSQL + '       R.CTR_VALORI,                                             ';
  strSQL := strSQL + '       R.CTR_VALDUP, 0.00 AS VALCOR, IFNULL(R.CTR_DESSUJ,0.00) AS CTR_DESSUJ,  ';
  strSQL := strSQL + '       0.00 AS VALDIF,                                           ';
  strSQL := strSQL + '       IFNULL(R.CTR_VALREC, 0.00) AS CTR_VALREC,                 ';
  strSQL := strSQL + '       MOT_CODMOT CODMOT,                                        ';
  strSQL := strSQL + '       MOT_DESMOT DESMOT,                                        ';
  strSQL := strSQL + '       RET_CUSCAR AS CUSCAR,                                     ';
  strSQL := strSQL + '       RET_CARBCO AS CARBCO,                                     ';
  strSQL := strSQL + '       IFNULL(RET_IOFDES, 0.00) AS IOFDES,                       ';
  strSQL := strSQL + '       IFNULL(RET_TXADES, 0.00) AS TXADES,                       ';
  strSQL := strSQL + RetornaSQLCampoJurOpe;

  //CALCULOS
  strSQL := strSQL + ' IF(RET_CUSCAR > 0, RET_CUSCAR, IFNULL(RET_TARIFA, 0.00)) VL_TARIFA, ';

  strSQL := strSQL + ' IF(RET_VALPAG <> 0, (RET_VALPAG + RET_TARIFA), 0) VALPAG_COMTAR, ';

  strSQL := strSQL + ' IF(RET_TXADES > 0,(((RET_VALDUP - RET_TARIFA) - RET_IOFDES) - RET_TXADES),0) VAL_CRED ';

  strSQL := strSQL + 'FROM RETBCO                                                      ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI                      ';
  strSQL := strSQL + 'LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP                  ';
  strSQL := strSQL + '                  AND R.CTR_CODCLI = RET_CODCLI                  ';
  strSQL := strSQL + '                  AND R.CTR_NUMDUP = RET_NUMDUP                  ';
  strSQL := strSQL + '                  AND R.CTR_PARCEL = RET_PARCEL                  ';
  strSQL := strSQL + '                  AND R.CTR_ESPDOC = RET_ESPDOC                  ';
  strSQL := strSQL + '                  AND R.CTR_SEQBAI = 0                           ';
  strSQL := strSQL + 'LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM            ';
  strSQL := strSQL + '                    AND DET.DET_CODOCO = RET_CODOCO              ';
  strSQL := strSQL + 'LEFT JOIN RETMOT                                                 ';
  strSQL := strSQL + '                 ON MOT_CODEMP = RET_CODEMP                      ';
  strSQL := strSQL + '                AND MOT_CODCLI = RET_CODCLI                      ';
  strSQL := strSQL + '                AND MOT_NUMDUP = RET_NUMDUP                      ';
  strSQL := strSQL + '                AND MOT_PARCEL = RET_PARCEL                      ';
  strSQL := strSQL + '                AND MOT_ESPDOC = RET_ESPDOC                      ';
  strSQL := strSQL + '                AND MOT_CODOCO = RET_CODOCO                      ';
  strSQL := strSQL + 'WHERE RET_CODBCO = :CODBCO AND                                   ';
  strSQL := strSQL + '      IFNULL(RET_DUPDIV, "N") <> "S" AND                         ';

  If fCfgSis('EMPIMP', varBoolean) Then
    strSQL := strSQL + ' RET_EMPIMP = ' + VS_strCodEmp.QuotedString + 'AND ';

  If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
     strSQL := strSQL + IIf( ATipoCnab.Equals('API'), ' IFNULL(RET_CNAB__,"") = "API" AND ',  ' IFNULL(RET_CNAB__,"") <> "API" AND ' );

  strSQL := strSQL + '       LOCATE(RET_CODOCO, "' + fRetCodOcoSelec + '") > 0         ';

  If MatchStr(LeftStr(strCodBco, 3), ['001', '748', '237', '097', '274', '341']) Then
  Begin
    If (not fEmptyStr(RetornaMotivoOcorrenciaSelecionada)) then
      strSQL := strSQL + '   AND LOCATE(IFNULL(RET_MOTOCO, "00"), "' + RetornaMotivoOcorrenciaSelecionada + '") > 0 ';
  End;

  strSQL := strSQL + 'GROUP BY R.AUTOINCREM, RET_CODOCO, RET_MOTOCO                                ';
  strSQL := strSQL + 'ORDER BY RET_CODOCO, RET_MOTOCO, MOT_CODMOT,                     ';

  strSQL := strSQL + IIf( (edtOrdem.Text = 'V'), ' RET_DTAVEN ', ' RET_NUMDUP ' );

  cdsRetBco.Close;
  With qryRetBco Do //, qryQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    qryretbco.open;

    cdsRetBco.Open;
    pRetDadosConta(qryRetBco.FieldByName('CARTEI').AsInteger);
    //fAbreClient(True, 'TfrmRelRetBco.pGeraRelatorio(strCodBco: String)');

    TDateField(cdsRetBco.FieldByName('DTAVEN')).DisplayFormat := 'dd/mm/yy';
    TDateField(cdsRetBco.FieldByName('DTAPAG')).DisplayFormat := 'dd/mm/yy';
    TDateField(cdsRetBco.FieldByName('DTARET')).DisplayFormat := 'dd/mm/yyyy';

    frxDBDatasetBco.DataSet := cdsRetBco;
  End;

  If Not cdsretbco.IsEmpty Then
  Begin
     blnImprimir := True;
     pCalculaValorCorrigido;
  End;

end;

procedure TfrmRelRetBco.pGetRelOcorrencias_F;
begin

  {**********************************}
  {* RETORNA O CODIGO DA OCORRÊNCIA *}
  {*******************************LB*}
  strSQL := '';
  strSQL := strSQL + 'SELECT RET_CODOCO AS CODOCO, ';
  strSQL := strSQL + '       COUNT(RET_CODOCO) AS QTDDUP, RET_MOTOCO AS MOTOCO, ';
  strSQL := strSQL + '       SUM(RET_VALDUP) AS VALDUP, SUM(RET_VALPAG) AS VALPAG, ';
  strSQL := strSQL + '       SUM(RET_TARIFA) AS TARIFA, SUM(RET_JURMOR) AS VALJUR, ';
  strSQL := strSQL + '       SUM(RET_DESCON) AS VALDES, SUM(IFNULL(RET_CUSCAR,0)) AS CUSCAR  ';

  strSQL := strSQL + ' ,IF( SUM(RET_VALPAG) <> 0, (SUM(RET_VALPAG) + SUM(RET_TARIFA)), 0) VALPAG_COMTAR ';

  strSQL := strSQL + 'FROM RETBCO ';
  strSQL := strSQL + 'WHERE RET_CODBCO = :CODBCO ';

  If fCfgSis('EMPIMP', varBoolean) Then
    strSQL := strSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString + ' ';

  If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
     strSQL := strSQL + IIF( ATipoCnab.Equals('API'), ' AND IFNULL(RET_CNAB__,"") = "API" ',  ' AND IFNULL(RET_CNAB__,"") <> "API" ' );

  strSQL := strSQL + ' AND LOCATE(RET_CODOCO, "' + fRetCodOcoSelec + '") > 0 ';

  If MatchStr(LeftStr(strCodBco, 3), ['001', '748', '237', '097', '274', '341', '033','756']) Then
  Begin
    If (not fEmptyStr(RetornaMotivoOcorrenciaSelecionada)) then
      strSQL := strSQL + '   AND LOCATE(IFNULL(RET_MOTOCO, "00"), "' + RetornaMotivoOcorrenciaSelecionada + '") > 0 ';
  End;

  strSQL := strSQL + 'GROUP BY RET_CODOCO, IF(RET_CODBCO IN (SELECT DISTINCT(OCO_CODBCO) FROM OCOBAN),RET_MOTOCO,"") ';

  strSQL := strSQL + 'ORDER BY RET_CODOCO, RET_MOTOCO ';

  With qryOcorr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    Open;
  End;

  frxDBDatasetOcor.DataSet := qryOcorr;

  strSQL := '';
  strSQL := strSQL + 'SELECT RET_CODOCO AS CODOCO, ';
  strSQL := strSQL + '       COUNT(RET_CODOCO) AS QTDDUP, ';
  strSQL := strSQL + '       SUM(RET_VALDUP) AS VALDUP, SUM(RET_VALPAG) AS VALPAG, ';
  strSQL := strSQL + '       SUM(RET_TARIFA) AS TARIFA, SUM(RET_JURMOR) AS VALJUR, ';
  strSQL := strSQL + '       SUM(RET_DESCON) AS VALDES, SUM(RET_CUSCAR) AS CUSCAR ';
  strSQL := strSQL + '       ,SUM(VALPAG_COMTAR) AS VALPAG_COMTAR ';
  strSQL := strSQL + 'FROM (SELECT RET_CODOCO, RET_VALDUP, RET_VALPAG, RET_TARIFA,  ';
  strSQL := strSQL + '             RET_JURMOR, RET_DESCON, RET_CUSCAR, ';

  strSQL := strSQL + ' IF( SUM(RET_VALPAG) <> 0, (SUM(RET_VALPAG) + SUM(RET_TARIFA)), 0) VALPAG_COMTAR ';

  strSQL := strSQL + '      FROM RETBCO ';
  strSQL := strSQL + '      WHERE RET_CODBCO = :CODBCO ';

  If fCfgSis('EMPIMP', varBoolean) Then
    strSQL := strSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString + ' ';

  If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
     strSQL := strSQL + IIF( ATipoCnab.Equals('API'), ' AND IFNULL(RET_CNAB__,"") = "API" ', ' AND IFNULL(RET_CNAB__,"") <> "API" ' );

  strSQL := strSQL + '      AND LOCATE(RET_CODOCO, "' + fRetCodOcoSelec + '") > 0 ';

  If MatchStr(LeftStr(strCodBco, 3), ['001', '748', '237', '097', '274', '341', '033','756']) Then
  Begin
    If (not fEmptyStr(RetornaMotivoOcorrenciaSelecionada)) then
      strSQL := strSQL + '   AND LOCATE(IFNULL(RET_MOTOCO, "00"), "' + RetornaMotivoOcorrenciaSelecionada + '") > 0 ';
  End;

  strSQL := strSQL + '      GROUP BY RET_NUMDUP, RET_PARCEL, RET_ESPDOC, RET_CODEMP) AS TEMP ';

  With qryTotOcor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    Open;
  End;

  frxDBDatasetTotOcor.DataSet := qryTotOcor;

end;


procedure TfrmRelRetBco.pGetRelNaoBaixadas_F;
begin
  //If (fGetBancoConfig(0,'CONFIG' + strCodBco, 'BAIDIVAUT', '') = 'S') Then
  //Begin
    qryNaoBaixados := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT IF(RET_MOTOCO <> "00" AND RET_CODBCO IN (SELECT DISTINCT(OCO_CODBCO) FROM OCOBAN), ';
    strSQL := strSQL + '       CONCAT(RET_CODOCO, ".", RET_MOTOCO), RET_CODOCO) AS CODOCO, RET_NOSNUM AS NOSNUM, ';
    strSQL := strSQL + '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, ';
    strSQL := strSQL + '       RET_CODEMP AS CODEMP, RET_DTAVEN AS DTAVEN,  IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, RET_DTAOCO),NULL) AS DTAPAG, ';
    strSQL := strSQL + '       RET_VALPAG AS VALPAG, RET_JURMOR AS JURMOR, RET_DESCON AS DESCON, RET_CODREJ, RET_CODBCO, ';
    strSQL := strSQL + '       RET_VALDUP AS VALDUP, RET_CARTEI AS CARTEI, RET_DUPDIV AS DUPDIV,  IFNULL(RET_TARIFA, 0.00) AS TARIFA, ';

    strSQL := strSQL + IIF( edtExibirCodCliente.Text = 'S', ' CONCAT(RET_CODCLI, "-", CLI_NOMCLI) AS CODCLI, ', ' CLI_NOMCLI AS CODCLI, ');

    strSQL := strSQL + '       MAX(DET.DET_DTARET) AS DTARET, CONCAT(RET_NOMARQ, " - ", RET_DTAARQ, " - ", RET_HORARQ) AS NOMARQ, ';
    strSQL := strSQL + '       CLI_C_E_P_ AS CEPCLI, RET_MOTDIV AS MOTDIV, RET_CUSCAR AS CUSCAR, RET_CARBCO AS CARBCO,  ';
    strSQL := strSQL + '       RET_IOFDES AS IOFDES,';
    strSQL := strSQL + RetornaSQLCampoJurOpe;
    strSQL := strSQL + '        RET_TXADES AS TXADES ';
    strSQL := strSQL + 'FROM RETBCO ';
    strSQL := strSQL + 'LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI ';
    strSQL := strSQL + 'LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP ';
    strSQL := strSQL + '                  AND R.CTR_CODCLI = RET_CODCLI ';
    strSQL := strSQL + '                  AND R.CTR_NUMDUP = RET_NUMDUP ';
    strSQL := strSQL + '                  AND R.CTR_PARCEL = RET_PARCEL ';
    strSQL := strSQL + '                  AND R.CTR_ESPDOC = RET_ESPDOC ';
    strSQL := strSQL + 'LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM ';
    strSQL := strSQL + 'WHERE RET_CODBCO = :CODBCO AND ';

    If fCfgSis('EMPIMP', varBoolean) Then
      strSQL := strSQL + ' RET_EMPIMP = ' + VS_strCodEmp.QuotedString + ' AND ';

    If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
       strSQL := strSQL + IIF( ATipoCnab.Equals('API'), ' IFNULL(RET_CNAB__,"") = "API" AND', ' IFNULL(RET_CNAB__,"") <> "API" AND ' );

    strSQL := strSQL + '      RET_DUPDIV = "S" ';
    strSQL := strSQL + 'GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO, RET_MOTOCO  ';
    strSQL := strSQL + 'ORDER BY RET_CODOCO, RET_MOTOCO, ';

    strSQL := strSQL + IIF( (edtOrdem.Text = 'V'), ' RET_DTAVEN  ', ' RET_NUMDUP ' );

    With qryNaoBaixados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
      Open;
    End;

    If Not qryNaoBaixados.IsEmpty Then
    Begin
       blnImprimir := True;
       TDateField(qryNaoBaixados.FieldByName('DTAVEN')).DisplayFormat := 'dd/mm/yy';
       TDateField(qryNaoBaixados.FieldByName('DTAPAG')).DisplayFormat := 'dd/mm/yy';
       frxDBDatasetNaoBaix.DataSet := qryNaoBaixados;
    End;

end;

procedure TfrmRelRetBco.pGetCodigoErroPix;
begin
  Try
    qryCodigoErroPix.Close;
    qryCodigoErroPix.SQL.Clear;
    qryCodigoErroPix.SQL.Text := 'SELECT                                                                                                           ' +
                                 '  B.RET_ERRPIX AS ERRPIX,                                                                                        ' +
                                 '  CASE                                                                                                           ' +
                                 '    B.RET_ERRPIX                                                                                                 ' +
                                 '    WHEN "004"                                                                                                   ' +
                                 '    THEN "CHAVE SEM CADASTRO NA DICT."                                                                           ' +
                                 '    WHEN "005"                                                                                                   ' +
                                 '    THEN "CHAVE NÃO CADASTRADA NO MESMO CNPJ DA AG/CONTA DA REMESSA."                                            ' +
                                 '    WHEN "009"                                                                                                   ' +
                                 '    THEN "LOCATION INVÁLIDA OU INEXISTETE OU LOCATION CRIADA COM TIPO DE COBRANÇA DIVERGENTE DA REMESSA."        ' +
                                 '    WHEN "010"                                                                                                   ' +
                                 '    THEN "BOLETO COM PIX NÃO É PERMITIDO PARA BOLETO COM PAGAMENTO PARCIAL."                                     ' +
                                 '    WHEN "999"                                                                                                   ' +
                                 '    THEN "PIX NÃO EMITIDO POR PROLEMAS NA PLATAFORMA. ENTRE EM CONTATO COM AS ÁREAS DE SUPORTE DO ITAÚ UNIBANCO."' +
                                 '    ELSE "OUTROS"                                                                                                ' +
                                 '  END AS DESCRICAO_ERRPIX,                                                                                       ' +
                                 '  CONCAT(B.RET_CODCLI, " - ", C.CLI_NOMCLI) AS CLIENTE,                                                          ' +
                                 '  R.CTR_DTACAD AS DTACAD,                                                                                        ' +
                                 '  B.RET_NOSNUM AS NOSNUM,                                                                                        ' +
                                 '  B.RET_NUMDUP AS NUMDUP,                                                                                        ' +
                                 '  B.RET_PARCEL AS PARCEL,                                                                                        ' +
                                 '  B.RET_ESPDOC AS ESPDOC,                                                                                        ' +
                                 '  B.RET_CODEMP AS CODEMP,                                                                                        ' +
                                 '  B.RET_DTAVEN AS DTAVEN,                                                                                        ' +
                                 '  B.RET_VALDUP AS VALDUP                                                                                         ' +
                                 'FROM                                                                                                             ' +
                                 '  RETBCO B                                                                                                       ' +
                                 '  LEFT JOIN CADCLI C                                                                                             ' +
                                 '    ON B.RET_CODCLI = C.CLI_CODCLI                                                                               ' +
                                 '  LEFT JOIN CADREC R                                                                                             ' +
                                 '    ON B.RET_NUMDUP = R.CTR_NUMDUP                                                                               ' +
                                 '    AND B.RET_PARCEL = R.CTR_PARCEL                                                                              ' +
                                 '    AND B.RET_ESPDOC = R.CTR_ESPDOC                                                                              ' +
                                 '    AND B.RET_CODEMP = R.CTR_CODEMP                                                                              ' +
                                 '    AND B.RET_CODCLI = R.CTR_CODCLI                                                                              ' +
                                 'WHERE RET_CODBCO = :CODBCO                                                                                       ' +
                                 '  AND RET_ERRPIX IS NOT NULL                                                                                     ' +
                                 'ORDER BY B.RET_ERRPIX                                                                                            ' ;
    qryCodigoErroPix.ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    qryCodigoErroPix.Open;
    If Not qryCodigoErroPix.IsEmpty Then
       frxDBDataSetCodigoErroPIX.DataSet := qryCodigoErroPix;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelRetBco.pGetCodigoErroPix]');
    End;
  End;
end;

procedure TfrmRelRetBco.pGetRelBaixadas_F;
begin
  ASQLJaBaixadaLancaTarifa := '';
  strSQL := '';
  strSQL := strSQL + 'SELECT IF(RET_MOTOCO <> "00" AND RET_CODBCO IN (SELECT DISTINCT(OCO_CODBCO) FROM OCOBAN), ';
  strSQL := strSQL + '       CONCAT(RET_CODOCO, ".", RET_MOTOCO), RET_CODOCO) AS CODOCO, RET_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '       RET_CODEMP AS CODEMP, RET_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '       IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, RET_DTAOCO), NULL) AS DTAPAG, ';
  strSQL := strSQL + '       R.CTR_VALREC AS VALPAG, RET_JURMOR AS JURMOR, ';
  strSQL := strSQL + '       RET_DESCON AS DESCON, RET_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '       RET_VALDUP AS VALDUP, RET_CODREJ, RET_CODBCO, ';
  strSQL := strSQL + '       RET_CARTEI AS CARTEI, ';

  strSQL := strSQL + IIF( edtExibirCodCliente.Text = 'S', ' CONCAT(RET_CODCLI, "-", CLI_NOMCLI) AS CODCLI, ', ' CLI_NOMCLI AS CODCLI, ' );

  strSQL := strSQL + '       IFNULL(RET_TARIFA, 0.00) AS TARIFA,  ';
  strSQL := strSQL + '       CONCAT(RET_NOMARQ, " - ", RET_DTAARQ, " - ", RET_HORARQ) AS NOMARQ, CLI_C_E_P_ AS CEPCLI, ';
  strSQL := strSQL + '       IFNULL(R.CTR_DESSUJ,0.00) AS CTR_DESSUJ, R.CTR_DTAVEN, R.CTR_VALORI, R.CTR_VALDUP, 0.00 AS VALCOR, 0.00 AS VALDIF, MAX(DET.DET_DTARET) AS DTARET, RET_CUSCAR AS CUSCAR, RET_CARBCO AS CARBCO, ';
  strSQL := strSQL + '       RET_IOFDES AS IOFDES,';
  strSQL := strSQL + RetornaSQLCampoJurOpe;
  strSQL := strSQL + '       RET_TXADES AS TXADES ';
  strSQL := strSQL + 'FROM RETBCO ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI ';
  strSQL := strSQL + 'LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP ';
  strSQL := strSQL + '                  AND R.CTR_CODCLI = RET_CODCLI ';
  strSQL := strSQL + '                  AND R.CTR_NUMDUP = RET_NUMDUP ';
  strSQL := strSQL + '                  AND R.CTR_PARCEL = RET_PARCEL ';
  strSQL := strSQL + '                  AND R.CTR_ESPDOC = RET_ESPDOC ';
  strSQL := strSQL + '                  AND R.CTR_SEQBAI = 0          ';
  strSQL := strSQL + 'LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM ';
  strSQL := strSQL + 'WHERE RET_CODBCO = :CODBCO AND ';

  If fCfgSis('EMPIMP', varBoolean) Then
    strSQL := strSQL + ' RET_EMPIMP = ' + VS_strCodEmp.QuotedString + ' AND ';

  If MatchStr(LeftStr(strCodBco, 3), BANCOS_API) Then
     strSQL := strSQL + IIF( ATipoCnab.Equals('API'), ' IFNULL(RET_CNAB__,"") = "API" AND ', ' IFNULL(RET_CNAB__,"") <> "API" AND ' );

  strSQL := strSQL + ' IFNULL(RET_DUPDIV, "N") <> "S" AND ';

  If LeftStr(strCodBco, 3) = '341' then
  begin
    ASQLJaBaixadaLancaTarifa := strSQL + '       LOCATE(RET_CODOCO, "09_35") > 0 AND ';
    ASQLJaBaixadaLancaTarifa := ASQLJaBaixadaLancaTarifa + '      CTR_DTAREC IS NOT NULL ';
    ASQLJaBaixadaLancaTarifa := ASQLJaBaixadaLancaTarifa + 'GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO, RET_MOTOCO  ';
    ASQLJaBaixadaLancaTarifa := ASQLJaBaixadaLancaTarifa + 'ORDER BY RET_CODOCO, RET_MOTOCO, ';

    ASQLJaBaixadaLancaTarifa := ASQLJaBaixadaLancaTarifa + IIF( (edtOrdem.Text = 'V'), ' RET_DTAVEN ', ' RET_NUMDUP ' );
  end;

  strSQL := strSQL + '      LOCATE(RET_CODOCO, "' + fRetCodOcoSelec + '") > 0 AND ';

  If MatchStr(LeftStr(strCodBco, 3), ['001', '748', '237', '097', '274', '341', '033', '756']) Then
  Begin
    If (not fEmptyStr(RetornaMotivoOcorrenciaSelecionada)) then
      strSQL := strSQL + '   LOCATE(IFNULL(RET_MOTOCO, "00"), "' + RetornaMotivoOcorrenciaSelecionada + '") > 0 AND ';
  End;

  strSQL := strSQL + '      CTR_DTAREC IS NOT NULL ';
  strSQL := strSQL + 'GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO, RET_MOTOCO  ';
  strSQL := strSQL + 'ORDER BY RET_CODOCO, RET_MOTOCO, ';

  strSQL := strSQL + IIF( (edtOrdem.Text = 'V'), ' RET_DTAVEN ', ' RET_NUMDUP ' );

  qryDupJaBaixadas.Close;
  qryDupJaBaixadas.SQL.Clear;
  qryDupJaBaixadas.SQL.Add(strSQL);
  qryDupJaBaixadas.ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
  qryDupJaBaixadas.Open;

  If Not qryDupJaBaixadas.IsEmpty Then
  Begin

     TDateField(qryDupJaBaixadas.FieldByName('DTAVEN')).DisplayFormat := 'dd/mm/yy';
     TDateField(qryDupJaBaixadas.FieldByName('DTAPAG')).DisplayFormat := 'dd/mm/yy';

     If BlnEncBan Then
        TfrxReportPage(FrxRetBcoTarifa.FindObject('Page4')).Visible := True
     Else
        TfrxReportPage(FrxRetBco.FindObject('Page4')).Visible := True;

     frxDBDatasetJaBaixadas.DataSet := qryDupJaBaixadas;

  End
  Else
  Begin

     If BlnEncBan Then
        TfrxReportPage(FrxRetBcoTarifa.FindObject('Page4')).Visible := False
     Else
        TfrxReportPage(FrxRetBco.FindObject('Page4')).Visible := False;

  End;

end;

procedure TfrmRelRetBco.GeraRelatorioBaixadasLancaTarifa_F;
begin

  If (LeftStr(strCodBco, 3) = '341') then
  begin

    qryBaixadasLancaTarifa.Close;
    qryBaixadasLancaTarifa.SQL.Clear;
    qryBaixadasLancaTarifa.SQL.Add(ASQLJaBaixadaLancaTarifa);
    qryBaixadasLancaTarifa.ParamByName('CODBCO').AsString := '341';
    qryBaixadasLancaTarifa.Open;

    If Not qryBaixadasLancaTarifa.IsEmpty Then
    Begin

       TDateField(qryBaixadasLancaTarifa.FieldByName('DTAVEN')).DisplayFormat := 'dd/mm/yy';
       TDateField(qryBaixadasLancaTarifa.FieldByName('DTAPAG')).DisplayFormat := 'dd/mm/yy';

       TfrxReportPage(FrxRetBcoTarifa.FindObject('Page5')).Visible := True;

       frxDBDatasetBaixadasLancaTarifa.DataSet := qryBaixadasLancaTarifa;

    End
    Else
    Begin

       TfrxReportPage(FrxRetBcoTarifa.FindObject('Page5')).Visible := False

    End;

  End
  Else
    TfrxReportPage(FrxRetBcoTarifa.FindObject('Page5')).Visible := False;

end;


function TfrmRelRetBco.fRetDescOco_Rel( strCodOco: String ): String;
begin
  Result := fRetDescOco(strCodOco);
end;

function TfrmRelRetBco.frxRetBcoUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'fRetDescOco_Rel') Then
     Result := fRetDescOco_Rel(Params[0]);

  If SameText(MethodName, 'pRetornaDescricaoBeforePrint_Rel') Then
     Result := pRetornaDescricaoBeforePrint_Rel(Params[0],Params[1],Params[2]);

  If SameText(MethodName, 'RetornaOcorrencia_Rel') Then
     Result := RetornaOcorrencia_Rel(Params[0],Params[1],Params[2],Params[3],Params[4]);

  If SameText(MethodName, 'fPreencheComZerosEsquerda_Rel') Then
     Result := fPreencheComZerosEsquerda_Rel(Params[0]);

end;

Function TfrmRelRetBco.pRetornaDescricaoBeforePrint( strTexto : String; ABanco : String; iTam : Integer ) : String;
Begin

   Result := strTexto + ' - ' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ATipoCnab);

   If iTam > 2 Then
   Begin

      If (ABanco = '237') Then
      Begin
         Result := Copy(strTexto, 1, 2) + '-'    + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ATipoCnab)
                                        + ' /. ' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ATipoCnab, Copy(strTexto, 4, 2));
      End
      Else
      Begin
         Result := Copy(strTexto, 1, 2) + '.' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ATipoCnab, Copy(strTexto, 4, 2));
      End;

   End;

End;

function TfrmRelRetBco.pRetornaDescricaoBeforePrint_Rel( strTexto : String; ABanco : String; iTam : Integer ) : String;
begin
  Result := pRetornaDescricaoBeforePrint(strTexto, ABanco, iTam);
end;

function TfrmRelRetBco.RetornaOcorrencia_Rel(ABanco, AOcorrencia, ACnab: String; AMotivo: String = ''; ADescricaoComMotivo: Boolean = True): String;
Begin
  Result := RetornaOcorrencia(ABanco, AOcorrencia, ACnab, AMotivo, ADescricaoComMotivo);
End;

function TfrmRelRetBco.RetornaSQLCampoJurOpe: String;
begin
  Result := ' IF(                                                 '+
            '   RET_CODBCO IN ("748")AND RET_CNAB__ IN ("API"),   '+
            '   IFNULL(RET_OUTVAL, 0.00),                         '+
            '   IFNULL(RET_JUROPE, 0.00)                          '+
            ' ) AS JUROPE,                                        ';
end;

function TfrmRelRetBco.SomenteHaRegistrosDeDuplicatasNaoBaixadas: Boolean;
begin
  Result := False;

  If Not qryRetBco.IsEmpty Then
    Exit;

  If Not qryRetBco.FieldByName('DTARET').IsNull Then
    Exit;

  If qryNaoBaixados.IsEmpty Then
    Exit;

  If qryNaoBaixados.FieldByName('DTARET').IsNull Then
    Exit;

  Result := True;
end;

function TfrmRelRetBco.fPreencheComZerosEsquerda(str : String) : String;
Begin
  if fPadL(str, 6, '0') = '000000' then
     Result := ''
  else
     Result := fPadL(str, 6, '0');
End;

function TfrmRelRetBco.fPreencheComZerosEsquerda_Rel(str : String) : String;
Begin
  Result := fPreencheComZerosEsquerda(str);
End;

Procedure TfrmRelRetBco.AddFunctionFRX();
Begin

  If BlnEncBan Then
  Begin
    frxRetBcoTarifa.AddFunction('function fRetDescOco_Rel( strCodOco: String ): String');
    frxRetBcoTarifa.AddFunction('function pRetornaDescricaoBeforePrint_Rel( strTexto : String; ABanco : String; iTam : Integer ) : String');
    frxRetBcoTarifa.AddFunction('function RetornaOcorrencia_Rel(ABanco, AOcorrencia, ACnab: String; AMotivo: String = ''; ADescricaoComMotivo: Boolean = True): String');
    frxRetBcoTarifa.AddFunction('function fPreencheComZerosEsquerda_Rel( str: String ): String');
  End
  Else
  Begin
    frxRetBco.AddFunction('function fRetDescOco_Rel( strCodOco: String ): String');
    frxRetBco.AddFunction('function pRetornaDescricaoBeforePrint_Rel( strTexto : String; ABanco : String; iTam : Integer ) : String');
    frxRetBco.AddFunction('function RetornaOcorrencia_Rel(ABanco, AOcorrencia, ACnab: String; AMotivo: String = ''; ADescricaoComMotivo: Boolean = True): String');
    frxRetBco.AddFunction('function fPreencheComZerosEsquerda_Rel( str: String ): String');
  End;
End;

Procedure TfrmRelRetBco.AddVariablesFRX();
Begin

  If BlnEncBan Then
  Begin

    frxRetBcoTarifa.PreviewOptions.Zoom := 1.25;

    TfrxMemoView(frxRetBcoTarifa.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
    TfrxMemoView(frxRetBcoTarifa.FindObject('mmoZebraRet')).Highlight.Color := fCfgSis('CORZEB');

    If (LeftStr(strCodBco, 3) = '748') And (ATipoCnab = 'API') Then
      TfrxMemoView(frxRetBcoTarifa.FindObject('Memo3')).Text := 'O. COB.';

    frxRetBcoTarifa.Script.Variables['NOMREL']   := 'RELATÓRIO DE ARQUIVO DE RETORNO ';
    frxRetBcoTarifa.Script.Variables['NOMEMP']   := fRetNomeEmpresa;
    frxRetBcoTarifa.Script.Variables['CODBCO']   := Leftstr( strNomBanco, 3 );
    frxRetBcoTarifa.Script.Variables['BANCO']    := AnsiUpperCase(strNomBanco);
    frxRetBcoTarifa.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
    frxRetBcoTarifa.Script.Variables['NOMEFORM'] := '[FrmRelRetBco]';
    frxRetBcoTarifa.Script.Variables['ORDEM']    := IIf( edtordem.Text = 'V','Vencimento', 'Documento' );
    frxRetBcoTarifa.Script.Variables['TPCNAB']   := ATipoCnab;
    frxRetBcoTarifa.Script.Variables['DTARET']   := 'DATA DO ARQUIVO RETORNO - ' + FormatDateTime('dd/mm/yyyy', qryRetBco.FieldByName('DTARET').AsDateTime);

    // PRINCIPAL
    If LeftStr(strCodBco, 3) = '748' then
       frxRetBcoTarifa.Script.Variables['NOMBCO'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'Cedente: ' + ACedente
    Else
       frxRetBcoTarifa.Script.Variables['NOMBCO'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'C/C: ' + strNumCta;

    If edtDados.Text = 'A' Then
    Begin
       TfrxMemoView(frxRetBcoTarifa.FindObject('mmCliente')   ).DataField := 'NOMARQ';
       TfrxMemoView(frxRetBcoTarifa.FindObject('mmlblCliente')).Text      := 'ARQUIVO - DATA - HORA';
    End;

    // JA BAIXADAS
    If LeftStr(strCodBco, 3) = '748' then
       frxRetBcoTarifa.Script.Variables['NOMBCOBAIX'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'Cedente: ' + ACedente
    Else
       frxRetBcoTarifa.Script.Variables['NOMBCOBAIX'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'C/C: ' + strNumCta;

  End
  Else
  Begin

    frxRetBco.PreviewOptions.Zoom := 1.25;
    TfrxMemoView(frxRetBco.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
    TfrxMemoView(frxRetBco.FindObject('mmoZebraRet')).Highlight.Color := fCfgSis('CORZEB');

    frxRetBco.Script.Variables['NOMREL']   := 'RELATÓRIO DE ARQUIVO DE RETORNO ';
    frxRetBco.Script.Variables['NOMEMP']   := fRetNomeEmpresa;
    frxRetBco.Script.Variables['CODBCO']   := Leftstr( strNomBanco, 3 );
    frxRetBco.Script.Variables['BANCO']    := AnsiUpperCase(strNomBanco);
    frxRetBco.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
    frxRetBco.Script.Variables['NOMEFORM'] := '[FrmRelRetBco]';
    frxRetBco.Script.Variables['ORDEM']    := IIf( edtordem.Text = 'V','Vencimento', 'Documento' );
    frxRetBco.Script.Variables['TPCNAB']   := ATipoCnab;

    If SomenteHaRegistrosDeDuplicatasNaoBaixadas Then
      frxRetBco.Script.Variables['DTARET']   := 'DATA DO ARQUIVO RETORNO - ' + FormatDateTime('dd/mm/yyyy', qryNaoBaixados.FieldByName('DTARET').AsDateTime)
    Else
      frxRetBco.Script.Variables['DTARET']   := 'DATA DO ARQUIVO RETORNO - ' + FormatDateTime('dd/mm/yyyy', qryRetBco.FieldByName('DTARET').AsDateTime);

    // PRINCIPAL
    If LeftStr(strCodBco, 3) = '748' then
       frxRetBco.Script.Variables['NOMBCO'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'Cedente: ' + ACedente
    Else
       frxRetBco.Script.Variables['NOMBCO'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'C/C: ' + strNumCta;

    If edtDados.Text = 'A' Then
    Begin
       TfrxMemoView(frxRetBco.FindObject('mmCliente')   ).DataField := 'NOMARQ'; //'DINHEIRO: [SUM(<frxDataset."CTR_DINHEI">,rlbMaster)]';
       TfrxMemoView(frxRetBco.FindObject('mmlblCliente')).Text      := 'ARQUIVO - DATA - HORA';
    End;

    // JA BAIXADAS
    If LeftStr(strCodBco, 3) = '748' then
       frxRetBco.Script.Variables['NOMBCOBAIX'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'Cedente: ' + ACedente
    Else
       frxRetBco.Script.Variables['NOMBCOBAIX'] := AnsiUpperCase(strNomBanco) + '          ' + 'AG.: ' + strCodAge + '     ' + 'C/C: ' + strNumCta;
  End;

End;

end.

