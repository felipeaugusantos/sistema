unit untFatDadosFiscaisImpostos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, strUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untTypesSistema, untConsultas, Datasnap.DBClient, untFuncFat, untLiberacao,
  untDadosFechamentoVendaMSGFatFrame;

type
  TLiberaCST = Record
    strCodIte: string;
    strDesIte: string;
    strCstAtu: string;
    strCstAnt: string;
  End;

  TArrLiberaCST = array of TLiberaCST;

type
  TfrmFatDadosFiscaisImpostos = class(TfrmPaiConfirma)
    dbgItens: TDBGridCitel;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    cdsItensAUTOINCREM: TIntegerField;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_EMPITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensITE_REFERE: TStringField;
    cdsItensITE_SIGUNI: TStringField;
    cdsItensITE_CODSIT: TStringField;
    cdsItensITE_TOTITE: TFloatField;
    cdsItensITE_BASICM: TFloatField;
    cdsItensITE_ALQICM: TFloatField;
    cdsItensITE_VALICM: TFloatField;
    cdsItensITE_BASIPI: TFloatField;
    cdsItensITE_ALQIPI: TFloatField;
    cdsItensITE_VALIPI: TFloatField;
    cdsItensITE_BASRET: TFloatField;
    cdsItensITE_VALRET: TFloatField;
    pnlResImp: TPanel;
    Label12: TLabel;
    Panel1: TPanel;
    DBEditFocus1: TDBEditFocus;
    Label9: TLabel;
    DBEditFocus2: TDBEditFocus;
    Panel2: TPanel;
    Panel3: TPanel;
    Label10: TLabel;
    DBEditFocus3: TDBEditFocus;
    ColorDialog1: TColorDialog;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtBasIcm: TEditFocus;
    edtBasIpi: TEditFocus;
    edtBasRet: TEditFocus;
    edtValIcm: TEditFocus;
    edtValIpi: TEditFocus;
    edtValRet: TEditFocus;
    btnZerarIcms: TBitBtnLocked;
    btnZerarIpi: TBitBtnLocked;
    btnZerarRetido: TBitBtnLocked;
    btnInfRet: TBitBtnLocked;
    btnInfIPI: TBitBtnLocked;
    btnInfIcms: TBitBtnLocked;
    btnSugestao: TBitBtnLocked;
    cdsItensITE_CODABF: TStringField;
    btnDigPisCof: TBitBtnLocked;
    fltfldItensITE_ALQPIS: TFloatField;
    fltfldItensITE_BASPIS: TFloatField;
    fltfldItensITE_VALPIS: TFloatField;
    fltfldItensITE_ALQCOF: TFloatField;
    fltfldItensITE_BASCOF: TFloatField;
    fltfldItensITE_VALCOF: TFloatField;
    cdsItensITE_CSTPIS: TStringField;
    cdsItensITE_CSTCOF: TStringField;
    cdsItensITE_CLAFIS: TStringField;
    cdsItensITE_SITANT: TStringField;
    cdsItensITE_ALTEROU: TBooleanField;
    btnIcmsDesonerado: TBitBtnLocked;
    cdsItensITE_VRDICM: TFloatField;
    cdsItensITE_MTDICM: TStringField;
    Label2: TLabel;
    edtVrdIcm: TEditFocus;
    cdsItensITE_DESONE: TStringField;
    cdsItensITE_BASVRD: TFloatField;
    cdsItensDET_AUTINC: TStringField;
    cdsItensDET_GARANT: TStringField;
    btnTrocaCST: TBitBtnLocked;
    cdsItensITE_BASFCP: TFloatField;
    cdsItensITE_PERFCP: TFloatField;
    cdsItensITE_VALFCP: TFloatField;
    edtValFCPST: TEditFocus;
    Label3: TLabel;
    edtBasFCPST: TEditFocus;
    Label4: TLabel;
    Panel4: TPanel;

    cdsItensITE_BASFCP_: TFloatField;
    cdsItensITE_PERFCP_: TFloatField;
    cdsItensITE_VALFCP_: TFloatField;
    lblValFCP: TLabel;
    lblBasFCP: TLabel;
    edtValFCP: TEditFocus;
    edtBasFCP: TEditFocus;
    cdsItensITE_CLAIPI: TStringField;
    btnAtribuirValoresXML: TBitBtnLocked;
    btnUtiImpOri: TBitBtnLocked;
    btnCstX90: TBitBtnLocked;
    fraDadosFechamentoVendaMSGFatFrame: TfraDadosFechamentoVendaMSGFatFrame;
    pnlMensagem: TPanel;
    cdsItensITE_PERRED: TFloatField;
    cdsItensITE_PEBAST: TFloatField;
    cdsItensITE_ALQRET: TFloatField;
    cdsItensITE_VALIVA: TFloatField;
    cdsItensITE_VALCBS: TFloatField;
    cdsItensITE_VALIBS: TFloatField;
    cdsItensITE_VAL_IS: TFloatField;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    procedure cdsItensBeforeInsert(DataSet: TDataSet);
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnZerarIcmsClick(Sender: TObject);
    procedure btnZerarIpiClick(Sender: TObject);
    procedure btnZerarRetidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnInfIcmsClick(Sender: TObject);
    procedure btnInfIPIClick(Sender: TObject);
    procedure btnInfRetClick(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnSugestaoClick(Sender: TObject);
    procedure btnDigPisCofClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIcmsDesoneradoClick(Sender: TObject);
    procedure btnTrocaCSTClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtribuirValoresXMLClick(Sender: TObject);
    procedure btnUtiImpOriClick(Sender: TObject);
    procedure btnCstX90Click(Sender: TObject);
    procedure pSintetizaClassificacoes;
  private
    FSintetizouClassificacoesFiscais : Boolean;
    blnValidar: Boolean;
    intRecNo: Integer;
    strSitAnt: String;
    blnTroCst: Boolean;

    strAutIncDocEnt: String;
    strDocDev: String;
    strEspDev: String;
    strEmpDev: String;
    BlnTemXML: Boolean;

    objLiberacao : TLiberacao;

    strCSTProdutoTrib: string;

    arrLiberaCST: TArrLiberaCST;

    fltBasIcm,
    fltAlqIcm,
    fltValIcm,

    fltBasIpi,
    fltAlqIpi,
    fltValIpi,

    fltBasRet,
    fltValRet,

    fltBasFCP,
    fltPerFCP,
    fltValFCP: Double;

    strCODCST: String;
    strClaGae: String;

    FBasFCP_: Double;
    FPerFCP_: Double;
    FValFCP_: Double;

    FIcmDes: Double;
    FMotDes: String;

    FValIva: Double;
    FXMLEnt: Boolean;

    blnUsaImpostoOriginal: Boolean;

    function fMesmoGrupoSitTrib(strCodSit: String): Boolean;
    function fRetSitTribEntrada(strAutIncDocEnt, strDocDev, strEspDev, strEmpDev, strCodIte: String; fltQtdIte: Double; strCodSit:
      String; var BlnTemXML: Boolean): Boolean;
    function fPegaIPIEntrada(strCodIte: String): Double;

    function fOrgaoPublicoOuZonaFranca: Boolean;
    function fChamaTelaDeTrava: Boolean;

    function fValidaIVA: boolean;

    function fValidaBaseICMS: Boolean;

    function fTeveFCPSTAlteradoManualemente: Boolean;
    function fTeveMotivoValorDesoneradoAlteradoManualemente: Boolean;

    function fValidaFCP: Boolean;
    function fHabilitaDigitacaoDeNcm: Boolean;
    function fOcorreuProtocoloInterestadual(strAutInc: string): Boolean;
    function fNotaDeDevolucaoExisteNaGERELE(strNumDoc, strEspDoc, strCodEmp, strCodFor: string; var strAutInc: string): boolean;
    function fExisteNotaDeDevolucaoVinculada(strDocDev, strEspDev, strEmpDev: string): Boolean;
    function fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor: Boolean;overload;
    function fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor(strDocDev, strEspDev, strEmpDev, strCodCli: String): Boolean;overload;
    function fAlteraParaImpostosOriginaisDeEntrada: Boolean;
    function fEnvioFornecedor: Boolean;
    function fMotivoIcmsDesoneradoDeveSer9(strMtdIcm: String; fltVrdIcm: Double): Boolean;
    procedure pbtnDigitarIPIClick(Sender: TObject);
    function fEhOutrasSaidasDeFornecedorComCfopX949(strClaFis: String): Boolean;
    procedure pSetaVisibilidadeNovosImpostos;
    { Private declarations }
  public
    { Public declarations }
    blnDifFCPST: Boolean;
    blnTeveFCPSTAlteradoManualemente: Boolean;
    blnTeveMotivoValorDesoneradoAlteradoManualemente: Boolean;
    blnConfirmacaoEspelho : Boolean;
    blnNotaFornecedor: Boolean;
    strSitP_C: String;
    strMenP_C: String;
    strCodigoFornecedor: String;
    strCliOrg: String;
    strZonFra: String;
    blnIcmsDesonerado: Boolean;
    blnTrocaCFOP : Boolean;
    blnNotImp: Boolean;
    blnAlteraValorDoItem : Boolean;
    strOpcDoc : string;
    blnDevolucao: Boolean;
    blnEhOutrasSaidasDeFornecedorDevolucao: Boolean;
    fatVenda: TFatVenda;

    function fTotal(strAgg: String): Double;
    procedure pAdicionaRegistro(intAutInc: Integer;
                                strCodIte,
                                strEmpIte,
                                strDesIte,
                                strRefere,
                                strSigUni,
                                strCodSit,
                                strClaIpi,
                                strSitAnt,
                                strCodAbf: String;
                                fltQtdIte,
                                fltTotIte,
                                fltBasIcm,
                                fltAlqIcm,
                                fltValIcm,
                                fltBasIpi,
                                fltAlqIpi,
                                fltValIpi,
                                fltBasRet,
                                fltValRet,
                                fltAlqPis,
                                fltBasPis,
                                fltValPis,
                                fltAlqCof,
                                fltBasCof,
                                fltValCof,
                                fltBasFCP,
                                fltPerFCP,
                                fltValFCP: Double;

                                fltBasFCP_,
                                fltPerFCP_,
                                fltValFCP_ : Double;

                                strClaFis,
                                strIncPis,
                                strCstPis,
                                strCstCof: String;
                                fltBasVrd,
                                fltVrdIcm: Double;
                                strMtdIcm: String;
                                //strautInc (autoincrem da ESPDET); strGarant Tipo de documento a ser confirmado para validar a CFOP;
                                strAutInc: String = '';
                                strGarant: String = '';
                                strDocDev: String = '';
                                strEspDev: String = '';
                                strEmpDev: String = '';
                                fltValIva: Double = 0;
                                fltAlqRet: Double = 0;
                                fltPerRed: Double = 0;
                                fltPeBaST: Double = 0;
                                fltValCbs: Double = 0;
                                fltValIbs: Double = 0;
                                fltVal_Is: Double = 0);
    property blnSintetizouClassificacoesFiscais : Boolean read FSintetizouClassificacoesFiscais;
    procedure pConfigurarConfirmacaoEspelho;
  end;

const
  COR_CFOP       = $00F4FFFF;
  COR_ICMS       = 10944511;
  COR_IPI        = 13434828;
  COR_RETIDO     = 16768959;
  COR_DESONERADO = $00D2B9EA;
  COR_FCP        = $0071B8FF;
  COR_FCP_ST     = $00FFD2D2;

  COLUNA_CODSIT = 5;

var
  frmFatDadosFiscaisImpostos: TfrmFatDadosFiscaisImpostos;

implementation

uses untFuncoesSimples, untConstantes, untFatDadosFiscaisImpDigValores,
     untFuncoesConsulta, untFatDadosFiscaisImpPisCofins, untFatDadosFiscaisImpIcmsDes,
     untMsgLiberacao,
     untFatDadosFiscaisImpIPI, untReformaTributariaTipos;

{$R *.dfm}

procedure TfrmFatDadosFiscaisImpostos.pAdicionaRegistro(intAutInc: Integer;
                                                        strCodIte,
                                                        strEmpIte,
                                                        strDesIte,
                                                        strRefere,
                                                        strSigUni,
                                                        strCodSit,
                                                        strClaIpi,
                                                        strSitAnt,
                                                        strCodAbf: String;
                                                        fltQtdIte,
                                                        fltTotIte,
                                                        fltBasIcm,
                                                        fltAlqIcm,
                                                        fltValIcm,
                                                        fltBasIpi,
                                                        fltAlqIpi,
                                                        fltValIpi,
                                                        fltBasRet,
                                                        fltValRet,
                                                        fltAlqPis,
                                                        fltBasPis,
                                                        fltValPis,
                                                        fltAlqCof,
                                                        fltBasCof,
                                                        fltValCof,
                                                        fltBasFCP,
                                                        fltPerFCP,
                                                        fltValFCP: Double;
                                                        fltBasFCP_,
                                                        fltPerFCP_,
                                                        fltValFCP_ : Double;
                                                        strClaFis,
                                                        strIncPis,
                                                        strCstPis,
                                                        strCstCof: String;
                                                        fltBasVrd,
                                                        fltVrdIcm: Double;
                                                        strMtdIcm: String;
                                                        strAutInc: String = '';
                                                        strGarant: String = '';
                                                        strDocDev: String = '';
                                                        strEspDev: String = '';
                                                        strEmpDev: String = '';
                                                        fltValIva: Double = 0;
                                                        fltAlqRet: Double = 0;
                                                        fltPerRed: Double = 0;
                                                        fltPeBaST: Double = 0;
                                                        fltValCbs: Double = 0;
                                                        fltValIbs: Double = 0;
                                                        fltVal_Is: Double = 0);
begin

  blnValidar := False;

  With cdsItens Do
  Begin
    Append;

    FieldByName('ITE_AUTINC').AsInteger := intAutInc;
    FieldByName('ITE_CODITE').AsString  := strCodIte;
    FieldByName('ITE_EMPITE').AsString  := strEmpIte;
    FieldByName('ITE_DESITE').AsString  := strDesIte;
    FieldByName('ITE_REFERE').AsString  := strRefere;
    FieldByName('ITE_SIGUNI').AsString  := strSigUni;
    FieldByName('ITE_CODSIT').AsString  := strCodSit;
    FieldByName('ITE_SITANT').AsString  := strSitAnt;        
    FieldByName('ITE_CODABF').AsString  := strCodAbf;

    FieldByName('ITE_QTDITE').AsFloat   := fltQtdIte;
    FieldByName('ITE_TOTITE').AsFloat   := fltTotIte;

    FieldByName('ITE_BASICM').AsFloat   := fltBasIcm;
    FieldByName('ITE_ALQICM').AsFloat   := fltAlqIcm;
    FieldByName('ITE_VALICM').AsFloat   := fltValIcm;

    FieldByName('ITE_BASIPI').AsFloat   := fltBasIpi;
    FieldByName('ITE_ALQIPI').AsFloat   := fltAlqIpi;
    FieldByName('ITE_VALIPI').AsFloat   := fltValIpi;

    FieldByName('ITE_BASRET').AsFloat   := fltBasRet;
    FieldByName('ITE_VALRET').AsFloat   := fltValRet;
    FieldByName('ITE_VALCBS').AsFloat   := fltValCbs;
    FieldByName('ITE_VALIBS').AsFloat   := fltValIbs;
    FieldByName('ITE_VAL_IS').AsFloat   := fltVal_Is;

    {FCP ST}
    FieldByName('ITE_BASFCP').AsFloat   := fltBasFCP;
    FieldByName('ITE_PERFCP').AsFloat   := fltPerFCP;
    FieldByName('ITE_VALFCP').AsFloat   := fltValFCP;

    {FCP}
    FieldByName('ITE_BASFCP_').AsFloat   := fltBasFCP_;
    FieldByName('ITE_PERFCP_').AsFloat   := fltPerFCP_;
    FieldByName('ITE_VALFCP_').AsFloat   := fltValFCP_;

    FieldByName('ITE_BASPIS').AsFloat   := fltBasPis;
    FieldByName('ITE_ALQPIS').AsFloat   := fltAlqPis;
    FieldByName('ITE_VALPIS').AsFloat   := fltValPis;
    FieldByName('ITE_CSTPIS').AsString  := strCstPis;

    FieldByName('ITE_BASCOF').AsFloat   := fltBasCof;
    FieldByName('ITE_ALQCOF').AsFloat   := fltAlqCof;
    FieldByName('ITE_VALCOF').AsFloat   := fltValCof;
    FieldByName('ITE_CSTCOF').AsString  := strCstCof;

    FieldByName('ITE_CLAFIS').AsString  := strClaFis;
    FieldByName('ITE_CLAIPI').AsString  := strClaIpi;

    FieldByName('ITE_BASVRD').AsFloat   := fltBasVrd;
    FieldByName('ITE_VRDICM').AsFloat   := fltVrdIcm;

    If fMotivoIcmsDesoneradoDeveSer9(strMtdIcm, fltVrdIcm) Then
      FieldByName('ITE_MTDICM').AsString := fRetMotivoDesoneracaoICMS('9')
    Else
      FieldByName('ITE_MTDICM').AsString  := IIF(Length(strMtdIcm) < 3, fRetMotivoDesoneracaoICMS(strMtdIcm), strMtdIcm);

    If (fltVrdIcm > 0) And (Not fEmptyStr(strMtdIcm)) Then
      FieldByName('ITE_DESONE').AsString := 'Sim'
    Else
      FieldByName('ITE_DESONE').AsString := 'Não';

    FieldByName('DET_AUTINC').AsString  := strAutInc;
    FieldByName('DET_GARANT').AsString  := strGarant;

    FieldByName('ITE_DOCDEV').AsString  := strDocDev;
    FieldByName('ITE_ESPDEV').AsString  := strEspDev;
    FieldByName('ITE_EMPDEV').AsString  := strEmpDev;

    FieldByName('ITE_VALIVA').AsFloat   := fltValIva;
    FieldByName('ITE_ALQRET').AsFloat   := fltAlqRet;
    FieldByName('ITE_PERRED').AsFloat   := fltPerRed;
    FieldByName('ITE_PEBAST').AsFloat   := fltPeBaST;

    Post;
  End;

  blnValidar := True;

end;

procedure TfrmFatDadosFiscaisImpostos.pbtnDigitarIPIClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmFatDadosFiscaisImpIPI, frmFatDadosFiscaisImpIPI);
    frmFatDadosFiscaisImpIPI.cdsItens.Data     := cdsItens.Data;
    frmFatDadosFiscaisImpIPI.blnNotaFornecedor := blnNotaFornecedor;
    frmFatDadosFiscaisImpIPI.strSitP_C := strSitP_C;
    frmFatDadosFiscaisImpIPI.strMenP_C := strMenP_C;
    frmFatDadosFiscaisImpIPI.blnNotImp := blnNotImp;
    frmFatDadosFiscaisImpIPI.ShowModal;

    If (frmFatDadosFiscaisImpIPI.ModalResult = mrOk) Then
    begin
      cdsItens.Data := frmFatDadosFiscaisImpIPI.cdsItens.Data;
      Self.edtBasIpi.Text := frmFatDadosFiscaisImpIPI.edtBasIpi.Text;
      Self.edtValIpi.Text := frmFatDadosFiscaisImpIPI.edtValIpi.Text;
    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatDadosFiscaisImpostos.btnDigitarIpiClick]');
  End;

  pFreeAndNil(frmFatDadosFiscaisImpIPI);

  pSetFocus(dbgItens);
end;

procedure TfrmFatDadosFiscaisImpostos.pConfigurarConfirmacaoEspelho;
begin
  if blnConfirmacaoEspelho then
  begin
   btnZerarIpi.Caption := '[ F3 ] Digitar IPI';
   btnZerarIpi.OnClick := pbtnDigitarIPIClick;
   btnInfIPI.Visible := False;
  end
  else
  begin
   btnZerarIpi.Caption := '[ F3 ] Zerar IPI';
   btnZerarIpi.OnClick := btnZerarIpiClick;
   btnInfIPI.Visible := True;
  end;
end;

function TfrmFatDadosFiscaisImpostos.fMotivoIcmsDesoneradoDeveSer9(strMtdIcm: String; fltVrdIcm: Double): Boolean;
begin
  Result := False;

  if strOpcDoc <> 'OF' then
    Exit;

  if not fEmptyStr(strMtdIcm) then
    Exit;

  if fltVrdIcm <= 0 then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscaisImpostos.fTeveFCPSTAlteradoManualemente: Boolean;
begin
  Result := False;

  if not Assigned(cdsItens) then
    exit;

  if not cdsItens.Active then
    exit;

  if cdsItens.IsEmpty then
    exit;

  cdsItens.DisableControls;
  try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if (cdsItens.FieldByName('ITE_BASFCP').OldValue <> cdsItens.FieldByName('ITE_BASFCP').NewValue) Or
         (cdsItens.FieldByName('ITE_PERFCP').OldValue <> cdsItens.FieldByName('ITE_PERFCP').NewValue) Or
         (cdsItens.FieldByName('ITE_VALFCP').OldValue <> cdsItens.FieldByName('ITE_VALFCP').NewValue) then
      begin
        Result := True;
        Break;
      end;

      cdsItens.Next;
    end;
  finally
    cdsItens.First;
    cdsItens.EnableControls;
  end;
end;

function TfrmFatDadosFiscaisImpostos.fTeveMotivoValorDesoneradoAlteradoManualemente: Boolean;
begin
  Result := False;

  if not Assigned(cdsItens) then
    exit;

  if not cdsItens.Active then
    exit;

  if cdsItens.IsEmpty then
    exit;

  cdsItens.DisableControls;
  try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if (cdsItens.FieldByName('ITE_MTDICM').OldValue <> cdsItens.FieldByName('ITE_MTDICM').NewValue) Or
         (cdsItens.FieldByName('ITE_VRDICM').OldValue <> cdsItens.FieldByName('ITE_VRDICM').NewValue) then
      begin
        Result := True;
        Break;
      end;

      cdsItens.Next;
    end;
  finally
    cdsItens.First;
    cdsItens.EnableControls;
  end;
end;

function TfrmFatDadosFiscaisImpostos.fTotal(strAgg: String): Double;
begin
  If (Not cdsItens.Active) Or (cdsItens.Aggregates.Find(strAgg).Value = Null) Then
    Result := 0
  Else
    Result := cdsItens.Aggregates.Find(strAgg).Value;
end;

function TfrmFatDadosFiscaisImpostos.fValidaBaseICMS: Boolean;
const
  CST_TRIBUTADO_INTEGRALMENTE = '00';
begin

  Result := True;

  if not Assigned(cdsItens) then
    exit;

  if not cdsItens.Active then
    exit;

  if cdsItens.IsEmpty then
    exit;

  cdsItens.DisableControls;

  try

    cdsItens.First;
    while not cdsItens.Eof do
    begin

      if (RightStr(cdsItensITE_CODSIT.AsString, 2) = CST_TRIBUTADO_INTEGRALMENTE) then
      begin

        if (fFormataFloat(cdsItens.FieldByName('ITE_BASICM').AsFloat, 2) < fFormataFloat(cdsItens.FieldByName('ITE_TOTITE').AsFloat, 2)) then
        begin
          Result := False;
          Break;
        end;

      end;

      cdsItens.Next;

    end;

    if not Result then
      fMensagem('', 'Item: (' + cdsItensITE_CODITE.AsString + ') tributado integralmente, base de cálculo de ICMS não pode ser inferior à (TOTITE - DESESP)!', ['&OK']);

  finally
    cdsItens.EnableControls;
  end;

end;

function TfrmFatDadosFiscaisImpostos.fValidaIVA: boolean;
  const
    LIMITE_TAMANHO_IVA : double = 999.99;
  var
    fltCalcIva : double;
begin
  Result := True;

  if not Assigned(cdsItens) then
    exit;

  if not cdsItens.Active then
    exit;

  if cdsItens.IsEmpty then
    exit;

  if (strOpcDoc = 'OF') then
  begin
    fltCalcIva := 0;

    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if (cdsItens.FieldByName('ITE_VALRET').AsFloat > 0) and (cdsItens.FieldByName('ITE_BASICM').AsFloat > 0) then
      begin
        fltCalcIva := (((cdsItens.FieldByName('ITE_BASRET').AsFloat / cdsItens.FieldByName('ITE_BASICM').AsFloat) * 100) - 100);
        if (fltCalcIva > LIMITE_TAMANHO_IVA) then
        begin
          Result := False;
          Break;
        end;
      end;
      cdsItens.Next;
    end;

    if not Result then
    begin
      fMensagem('', 'IVA resultante do cálculo ((( BASRET / BASICM ) * 100) - 100) é inválido!' + sLineBreak +
        ' [ ' + AnsiReplaceStr(AnsiReplaceStr(FloatToStrF(fltCalcIva, ffNumber, 7, 4), ',', ''), '.', '') + ' ]', ['&OK']);
    end;
  end;
end;

function TfrmFatDadosFiscaisImpostos.fValidaFCP: Boolean;
begin
  Result := True;

  if not Assigned(cdsItens) then
    exit;

  if not cdsItens.Active then
    exit;

  if cdsItens.IsEmpty then
    exit;

  if (pos(strOpcDoc, 'NG_OF') > 0) And blnDevolucao then
  begin
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if not fatVenda.fDentroDoEstado(cdsItens.FieldByName('ITE_EMPITE').AsString) then
        if (cdsItens.FieldByName('ITE_VALFCP_').AsFloat > 0) and (cdsItens.FieldByName('ITE_VALFCP').AsFloat > 0) then
        begin
          Result := False;
          Break;
        end;
      cdsItens.Next;
    end;

    if not Result then
    begin
      Result := (fMensagem('ATENÇÃO','Existem lançamentos de FCP e FCP ST no mesmo item para operação interestadual.'+#13+
                           'Deseja Continuar?', ['&Sim', '&Não']) = 1);
    end;
  end;
end;

procedure TfrmFatDadosFiscaisImpostos.btnAtribuirValoresXMLClick(
  Sender: TObject);
begin
  inherited;
  fRetSitTribEntrada(cdsItens.FieldByName('DET_AUTINC').AsString,
                     cdsItens.FieldByName('ITE_DOCDEV').AsString,
                     cdsItens.FieldByName('ITE_ESPDEV').AsString,
                     cdsItens.FieldByName('ITE_EMPDEV').AsString,
                     cdsItens.FieldByName('ITE_CODITE').AsString,
                     cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                     '',
                     BlnTemXML);

  If Not BlnTemXML Then
  begin
    fMensagem('ATENÇÃO!', 'O documento que esta sendo devolvido não foi referenciado ou não foi efetuado a entrada através' + #13 +
      'de um XML, as Tributações vão ser devolvidas mediante as tributações do cadastro do produto!', ['&O k']);
    Exit;
  end;

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
      fRetSitTribEntrada(cdsItens.FieldByName('DET_AUTINC').AsString,
                         cdsItens.FieldByName('ITE_DOCDEV').AsString,
                         cdsItens.FieldByName('ITE_ESPDEV').AsString,
                         cdsItens.FieldByName('ITE_EMPDEV').AsString,
                         cdsItens.FieldByName('ITE_CODITE').AsString,
                         cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                         '',
                         BlnTemXML);

    cdsItens.Edit;

    cdsItens.FieldByName('ITE_BASICM').AsFloat := fltBasIcm;
    cdsItens.FieldByName('ITE_ALQICM').AsFloat := fltAlqIcm;
    cdsItens.FieldByName('ITE_VALICM').AsFloat := fltValIcm;

    cdsItens.FieldByName('ITE_BASRET').AsFloat := fltBasRet;
    cdsItens.FieldByName('ITE_VALRET').AsFloat := fltValRet;

    cdsItens.FieldByName('ITE_BASIPI').AsFloat := fltBasIpi;
    cdsItens.FieldByName('ITE_ALQIPI').AsFloat := fltAlqIpi;
    cdsItens.FieldByName('ITE_VALIPI').AsFloat := fltValIpi;

    cdsItens.FieldByName('ITE_BASFCP').AsFloat := fltBasFCP;
    cdsItens.FieldByName('ITE_PERFCP').AsFloat := fltPerFCP;
    cdsItens.FieldByName('ITE_VALFCP').AsFloat := fltValFCP;

    cdsItens.FieldByName('ITE_BASFCP_').AsFloat := FBasFCP_;
    cdsItens.FieldByName('ITE_PERFCP_').AsFloat := FPerFCP_;
    cdsItens.FieldByName('ITE_VALFCP_').AsFloat := FValFCP_;

    cdsItens.FieldByName('ITE_VALIVA').AsFloat  := FValIva;
    cdsItens.FieldByName('ITE_VRDICM').AsFloat  := FIcmDes;
    cdsItens.FieldByName('ITE_MTDICM').AsString := fRetMotivoDesoneracaoICMS(FMotDes);

    If (FIcmDes > 0) And (Not fEmptyStr(FMotDes)) Then
      cdsItens.FieldByName('ITE_DESONE').AsString := 'Sim'
    Else
      cdsItens.FieldByName('ITE_DESONE').AsString := 'Não';

    cdsItens.FieldByName('ITE_CODSIT').AsString := strCODCST;

    Try
      FXMLEnt := True;
      cdsItens.Post;
    Finally
      FXMLEnt := False;
    End;

    cdsItens.Next;
  End;
  cdsItens.First;
end;

procedure TfrmFatDadosFiscaisImpostos.btnConfirmaClick(Sender: TObject);
begin

  If (cdsItens.State = dsEdit) Then
    cdsItens.Post;

  if not fValidaIVA then
    exit;

  {Req.: 155450}
  if not fValidaBaseICMS then
    exit;

  if not fValidaFCP then
    exit;

  If blnTrocaCFOP Then
    pSintetizaClassificacoes;

  blnTeveFCPSTAlteradoManualemente := fTeveFCPSTAlteradoManualemente;
  blnTeveMotivoValorDesoneradoAlteradoManualemente := fTeveMotivoValorDesoneradoAlteradoManualemente;

  inherited;
  ModalResult := mrOk;

end;

procedure TfrmFatDadosFiscaisImpostos.btnDigPisCofClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmFatDadosFiscaisImpPisCofins, frmFatDadosFiscaisImpPisCofins);
    frmFatDadosFiscaisImpPisCofins.cdsItens.Data     := cdsItens.Data;
    frmFatDadosFiscaisImpPisCofins.blnNotaFornecedor := blnNotaFornecedor;
    frmFatDadosFiscaisImpPisCofins.strSitP_C := strSitP_C;
    frmFatDadosFiscaisImpPisCofins.strMenP_C := strMenP_C;
    frmFatDadosFiscaisImpPisCofins.blnNotImp := blnNotImp;
    frmFatDadosFiscaisImpPisCofins.ShowModal;

    If (frmFatDadosFiscaisImpPisCofins.ModalResult = mrOk) Then
      cdsItens.Data := frmFatDadosFiscaisImpPisCofins.cdsItens.Data;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatDadosFiscaisImpostos.btnDigPisCofClick]');
  End;

  pFreeAndNil(frmFatDadosFiscaisImpPisCofins);

  pSetFocus(dbgItens);

end;

procedure TfrmFatDadosFiscaisImpostos.btnIcmsDesoneradoClick(Sender: TObject);
begin
  inherited;

  If Not btnIcmsDesonerado.Visible Then
    Exit;

  If Not btnIcmsDesonerado.Enabled Then
    Exit;

  Try
    pCriarFormularios(TfrmFatDadosFiscaisImpIcmsDes, frmFatDadosFiscaisImpIcmsDes);
    frmFatDadosFiscaisImpIcmsDes.cdsItens.Data := cdsItens.Data;
    frmFatDadosFiscaisImpIcmsDes.blnEhOutrasSaidasDeFornecedorDevolucao := blnEhOutrasSaidasDeFornecedorDevolucao;
    frmFatDadosFiscaisImpIcmsDes.fatVenda := fatVenda;
    frmFatDadosFiscaisImpIcmsDes.blnNotImp := blnNotImp;
    frmFatDadosFiscaisImpIcmsDes.BlnTemXML := BlnTemXML;
    frmFatDadosFiscaisImpIcmsDes.ShowModal;
    frmFatDadosFiscaisImpIcmsDes.cdsItens.OnFilterRecord := Nil;

    If (frmFatDadosFiscaisImpIcmsDes.ModalResult = mrOk) Then
      cdsItens.Data := frmFatDadosFiscaisImpIcmsDes.cdsItens.Data;

    edtVrdIcm.Text := FormatFloat('#,##0.00', fTotal('AGG_VRDICM'));
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatDadosFiscaisImpostos.btnIcmsDesoneradoClick]');
  End;

  pFreeAndNil(frmFatDadosFiscaisImpIcmsDes);

  pSetFocus(dbgItens);
end;

procedure TfrmFatDadosFiscaisImpostos.btnInfIcmsClick(Sender: TObject);
  var
    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltTotPro,
    fltPerCor: Double;
begin
  //inherited;

  fltTotPro := fTotal('AGG_TOTITE');

  If (Not btnInfIcms.Visible) Or (fltTotPro <= 0) Then
    Exit;

  blnValidar := False;

  If fPedeDigitacaoValoresImpost(fltBasIcm, fltAlqIcm, fltValIcm, 'Total do ICMS', True) Then
  Begin
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('ITE_ALQICM').AsFloat := fltAlqIcm;
        FieldByName('ITE_BASICM').AsFloat := fFormataFloat(fltBasIcm * fltPerCor, 2);
        FieldByName('ITE_VALICM').AsFloat := fFormataFloat(fltValIcm * fltPerCor, 2);
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + (fFormataFloat(fltBasIcm, 2) - fTotal('AGG_BASICM'));
      FieldByName('ITE_VALICM').AsFloat := FieldByName('ITE_VALICM').AsFloat + (fFormataFloat(fltValIcm, 2) - fTotal('AGG_VALICM'));
      Post;
    End;
  End;

  blnValidar := True;

end;

procedure TfrmFatDadosFiscaisImpostos.btnInfIPIClick(Sender: TObject);
  var
    fltBasIpi,
    fltAlqIpi,
    fltValIpi,
    fltTotPro,
    fltPerCor: Double;
begin
  inherited;

  fltTotPro := fTotal('AGG_TOTITE');

  If (Not btnInfIcms.Visible) Or (fltTotPro <= 0) Then
    Exit;

  blnValidar := False;

  If fPedeDigitacaoValoresImpost(fltBasIpi, fltAlqIpi, fltValIpi, 'Total do IPI', True) Then
  Begin
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('ITE_ALQIPI').AsFloat := fltAlqIpi;
        FieldByName('ITE_BASIPI').AsFloat := fFormataFloat(fltBasIpi * fltPerCor, 2);
        FieldByName('ITE_VALIPI').AsFloat := fFormataFloat(fltValIpi * fltPerCor, 2);
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('ITE_BASIPI').AsFloat := FieldByName('ITE_BASIPI').AsFloat + (fFormataFloat(fltBasIpi, 2) - fTotal('AGG_BASIPI'));
      FieldByName('ITE_VALIPI').AsFloat := FieldByName('ITE_VALIPI').AsFloat + (fFormataFloat(fltValIpi, 2) - fTotal('AGG_VALIPI'));
      Post;
    End;
  End;

  blnValidar := True;

end;


procedure TfrmFatDadosFiscaisImpostos.btnInfRetClick(Sender: TObject);
  var
    fltBasRet,
    fltAlqRet,
    fltValRet,
    fltTotPro,
    fltPerCor: Double;

    function fMontaFiltro: String;
      var
        intPosicao: Integer;
    begin
      Result := '';

      intPosicao := 1;
      While intPosicao < Length(CST_SUBSTITUICAO) Do
      Begin
        Result := Result + ' (ITE_CODSIT = ' + QuotedStr(Copy(CST_SUBSTITUICAO, intPosicao, 3)) +') OR';
        Inc(intPosicao, 4);
      End;

      Result := Copy(Result, 1, Length(Result) - 2);

    end;

begin
  inherited;

  If (Not btnInfRet.Visible) Then
    Exit;

  blnValidar := False;

  Try

    cdsItens.Filtered := False;
    cdsItens.Filter   := fMontaFiltro;
    cdsItens.Filtered := True;

    fltTotPro := fTotal('AGG_TOTITE');

    If (fltTotPro <= 0) Then
    Begin
      fMensagem('', 'Não foram encontrados produtos ST para rateio de valores!', ['&Ok']);
    End

    Else If fPedeDigitacaoValoresImpost(fltBasRet, fltAlqRet, fltValRet, 'Total da ST',False) Then
    Begin
      With cdsItens Do
      Begin
        First;
        While Not Eof Do
        Begin
          fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

          Edit;
          FieldByName('ITE_BASRET').AsFloat := fFormataFloat(fltBasRet * fltPerCor, 2);
          FieldByName('ITE_VALRET').AsFloat := fFormataFloat(fltValRet * fltPerCor, 2);
          Post;

          Next;
        End;
        First;

        Edit;
        FieldByName('ITE_BASRET').AsFloat := FieldByName('ITE_BASRET').AsFloat + (fFormataFloat(fltBasRet, 2) - fTotal('AGG_BASRET'));
        FieldByName('ITE_VALRET').AsFloat := FieldByName('ITE_VALRET').AsFloat + (fFormataFloat(fltValRet, 2) - fTotal('AGG_VALRET'));
        Post;
      End;
    End;
  Except
    On E: exception Do
      pMensagensErro(E.Message, '');
  End;

  cdsItens.Filter   := '';
  cdsItens.Filtered := False;

  cdsItensAfterPost(cdsItens);

  blnValidar := True;  

end;

procedure TfrmFatDadosFiscaisImpostos.btnSugestaoClick(Sender: TObject);
  Var
    fltValIva,
    fltPerBas,
    fltPeBaST,
    fltTotIte,

    fltBasIcm,
    fltAlqIcm,
    fltValIcm,

    fltBasRet,
    fltAlqRet,
    fltValRet,

    fltBasIpi,
    fltAlqIpi,
    fltValIpi: Double;

    strCodSit,
    strCodAbf,
    strEstFor: String;
begin
  inherited;

  If Not blnNotaFornecedor Then
    Exit;

  strEstFor := fEstadoFornecedor(strCodigoFornecedor);

  fltBasRet := 0;

  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      strCodAbf := FieldByName('ITE_CODABF').AsString;
      fltTotIte := FieldByName('ITE_TOTITE').AsFloat;
      fltAlqIpi := fPegaIPIEntrada(FieldByName('ITE_CODITE').AsString);

      pRetDadosAbfFornecedor(strCodAbf, strCodigoFornecedor, strEstFor,
        fltAlqIcm, fltAlqRet, fltValIva, fltPerBas, fltPeBaST, strCodSit);

      fltBasIpi := fltTotIte;
      fltValIpi := fFormataFloat(fltBasIpi * (fltAlqIpi / 100), 2);

      If fltValIpi <= 0 Then
      Begin
        fltBasIpi := 0;
        fltAlqIpi := 0;
        fltValIpi := 0;
      End;

      fltBasIcm := fFormataFloat(fltTotIte * (fltPerBas / 100), 2);
      fltValIcm := fFormataFloat(fltBasIcm * (fltAlqIcm / 100), 2);

      If fltValIcm <= 0 Then
      Begin
        fltBasIcm := 0;
        fltAlqIcm := 0;
        fltValIcm := 0;
      End;

      If Pos(FieldByName('ITE_CODSIT').AsString, CST_SUBSTITUICAO) > 0 Then
      Begin
        fltBasRet := fFormataFloat((fltTotIte + fltValIpi) * (fltPeBaST / 100) * fltValIva, 2);
        fltValRet := fFormataFloat(fltBasRet * (fltAlqRet / 100) - fltValIcm, 2);
      End
      Else
        fltValRet := 0;

      If fltValRet <= 0 Then
      Begin
        fltBasRet := 0;
        fltAlqRet := 0;
        fltValRet := 0;
      End;

      Edit;

      FieldByName('ITE_BASICM').AsFloat := fltBasIcm;
      FieldByName('ITE_ALQICM').AsFloat := fltAlqIcm;
      FieldByName('ITE_VALICM').AsFloat := fltValIcm;

      FieldByName('ITE_BASRET').AsFloat := fltBasRet;
      FieldByName('ITE_VALRET').AsFloat := fltValRet;

      FieldByName('ITE_BASIPI').AsFloat := fltBasIpi;
      FieldByName('ITE_ALQIPI').AsFloat := fltAlqIpi;
      FieldByName('ITE_VALIPI').AsFloat := fltValIpi;

      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;

end;

procedure TfrmFatDadosFiscaisImpostos.btnZerarIcmsClick(Sender: TObject);
  const
    CSTx40 = 1;
    CSTx41 = 2;
begin
  inherited;
  strCSTProdutoTrib := IIF(fMensagem('ATENÇÃO!', 'Repassar a seguinte CST para os produtos tributados:', ['x40', 'x41'],IIF(fOrgaoPublicoOuZonaFranca, CSTx40, CSTx41)) = 1, '40', '41');
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASICM').AsFloat := 0;
      FieldByName('ITE_ALQICM').AsFloat := 0;
      FieldByName('ITE_VALICM').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpostos.btnZerarIpiClick(Sender: TObject);
begin
  inherited;
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASIPI').AsFloat := 0;
      FieldByName('ITE_ALQIPI').AsFloat := 0;
      FieldByName('ITE_VALIPI').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpostos.btnZerarRetidoClick(Sender: TObject);
begin
  inherited;
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASRET').AsFloat := 0;
      FieldByName('ITE_VALRET').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpostos.pSetaVisibilidadeNovosImpostos;
  Var
    blnExibir: Boolean;

  procedure pSetaColuna(const strCampo: String);
    Var
      Column: TColumn;
  begin
    Column := fFindColumnByName(dbgItens, strCampo);
    If Assigned(Column) Then
      Column.Visible := blnExibir;
  end;

begin
  blnExibir := fSomarNovosImpostosDaReformaAoValorContabil;

  lblTotCBS.Visible := blnExibir;
  edtTotCBS.Visible := blnExibir;
  lblTotIBS.Visible := blnExibir;
  edtTotIBS.Visible := blnExibir;
  lblTotIS.Visible  := blnExibir;
  edtTotIS.Visible  := blnExibir;

  pSetaColuna('ITE_VALCBS');
  pSetaColuna('ITE_VALIBS');
  pSetaColuna('ITE_VAL_IS');
end;

procedure TfrmFatDadosFiscaisImpostos.cdsItensAfterPost(DataSet: TDataSet);
begin

  inherited;

  edtBasIcm.Text := FormatFloat('#,##0.00', fTotal('AGG_BASICM'));
  edtValIcm.Text := FormatFloat('#,##0.00', fTotal('AGG_VALICM'));
  edtBasIpi.Text := FormatFloat('#,##0.00', fTotal('AGG_BASIPI'));
  edtValIpi.Text := FormatFloat('#,##0.00', fTotal('AGG_VALIPI'));
  edtBasRet.Text := FormatFloat('#,##0.00', fTotal('AGG_BASRET'));
  edtValRet.Text := FormatFloat('#,##0.00', fTotal('AGG_VALRET'));

  {FCP ST}
  edtBasFCPST.Text := FormatFloat('#,##0.00', fTotal('AGG_BASFCP'));
  edtValFCPST.Text := FormatFloat('#,##0.00', fTotal('AGG_VALFCP'));

  {FCP}
  edtBasFCP.Text   := FormatFloat('#,##0.00', fTotal('AGG_BASFCP_'));
  edtValFCP.Text   := FormatFloat('#,##0.00', fTotal('AGG_VALFCP_'));

  edtVrdIcm.Text := FormatFloat('#,##0.00', fTotal('AGG_VRDICM'));

  edtTotCBS.Text := FormatFloat('#,##0.00', fTotal('AGG_VALCBS'));
  edtTotIBS.Text := FormatFloat('#,##0.00', fTotal('AGG_VALIBS'));
  edtTotIS.Text  := FormatFloat('#,##0.00', fTotal('AGG_VAL_IS'));

end;

procedure TfrmFatDadosFiscaisImpostos.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;
  strSitAnt := cdsItens.FieldByName('ITE_CODSIT').AsString;
  strAutIncDocEnt := cdsItens.FieldByName('DET_AUTINC').AsString;
  strDocDev       := cdsItens.FieldByName('ITE_DOCDEV').AsString;
  strEspDev       := cdsItens.FieldByName('ITE_ESPDEV').AsString;
  strEmpDev       := cdsItens.FieldByName('ITE_EMPDEV').AsString;
end;

procedure TfrmFatDadosFiscaisImpostos.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  If blnValidar Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatDadosFiscaisImpostos.cdsItensBeforePost(DataSet: TDataSet);

  function fValidaValor(strCampo: String): Boolean;
  begin
    Result := DataSet.FieldByName(strCampo).AsFloat >= 0;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo ' + DataSet.FieldByName(strCampo).DisplayLabel +
                ' deve ser maior ou igual à zero!', ['&Ok']);
    End;
  end;

  function fValidaBaseValor(strBase, strValor: String): Boolean;
  begin
    Result := True;

    If (DataSet.FieldByName(strBase).AsFloat = 0) And
       (DataSet.FieldByName(strValor).AsFloat > 0) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Campo ' + DataSet.FieldByName(strBase).DisplayLabel +
                ' deve ser informado!', ['&Ok']);
    End;

  end;

  procedure pCalculaValor(strBase, strAlq, strValor: String);
  begin
    If DataSet.State = dsEdit Then
    Begin
      DataSet.FieldByName(strValor).AsFloat :=
        fFormataFloat(DataSet.FieldByName(strBase).AsFloat * DataSet.FieldByName(strAlq).AsFloat / 100, 2);
    End;
  end;


  function fValidaValorRetido(strCampo: String): Boolean;
  begin
    Result := True;

    If (Pos(DataSet.FieldByName('ITE_CODSIT').AsString, CST_SUBSTITUICAO + '090_190_290_390_490_590_690_790_890_') <= 0) And
       (DataSet.FieldByName(strCampo).Value <> DataSet.FieldByName(strCampo).OldValue) And
       (DataSet.FieldByName(strCampo).Value > 0)Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Campo ' + DataSet.FieldByName(strCampo).DisplayLabel +
                ' não pode ser informado, pois este produto não é ST!', ['&Ok']);
    End;

  End;

  procedure pSetaCodSitItem(strCodSit: String);
    Var
      blnReadOnly: Boolean;
  begin
    blnReadOnly := cdsItensITE_CODSIT.ReadOnly;
    cdsItensITE_CODSIT.ReadOnly := False;
    cdsItensITE_CODSIT.AsString := strCodSit;
    cdsItensITE_CODSIT.ReadOnly := blnReadOnly;
  end;

  procedure pRecalculaIcmsDesonerado;
//    Var
//      fltIcmOpe,
//      fltVrdIcm: Double;
  Begin
    With cdsItens Do
    Begin
      If FieldByName('ITE_DESONE').AsString = 'Sim' Then
      Begin
        //fltIcmOpe := ((FieldByName('ITE_BASICM').AsFloat * 0.70) * (FieldByName('ITE_ALQICM').AsFloat / 100));
        //fltVrdIcm := (FieldByName('ITE_BASICM').AsFloat * (FieldByName('ITE_ALQICM').AsFloat / 100)) - fltIcmOpe;

        FieldByName('ITE_VRDICM').AsFloat := FieldByName('ITE_VALICM').AsFloat;
        FieldByName('ITE_BASVRD').AsFloat := FieldByName('ITE_BASICM').AsFloat;
      End
      Else
      Begin
        FieldByName('ITE_VRDICM').AsFloat := 0;
        FieldByName('ITE_BASVRD').AsFloat := 0;
      End;
    End;
  End;
begin
  inherited;

  If (DataSet.FieldByName('ITE_BASICM').AsFloat <= 0) Then
  Begin
    If (Pos(cdsItensITE_CODSIT.AsString, CST_TRIBUTADO) > 0) Then
      pSetaCodSitItem(LeftStr(cdsItensITE_CODSIT.AsString, 1) + IIF(fEmptyStr(strCSTProdutoTrib),IIF(fOrgaoPublicoOuZonaFranca, '40', '41'),strCSTProdutoTrib));
  End
  Else If (RightStr(cdsItensITE_CODSIT.AsString, 2) = IIF(fOrgaoPublicoOuZonaFranca, '40', '41') ) Then
    pSetaCodSitItem(cdsItensITE_SITANT.AsString);

  {*******************************************}
  {* CASO O CST SEJA X60 E POSSUA IPI OU ST  *}
  {* ALTERA O MESMO PARA X10, EX: 060 -> 010 *}
  {***************************************JC**}
  {* IPI MANTERÁ X60 REQ.:71156***********VA**}
  If (RightStr(cdsItensITE_CODSIT.AsString, 2) = '60') And (cdsItensITE_BASRET.AsFloat > 0) Then
    pSetaCodSitItem(LeftStr(cdsItensITE_CODSIT.AsString, 1) + '10');

  If Not blnValidar Then
    Exit;

  pSetaCodSitItem(fStrZero(DataSet.FieldByName('ITE_CODSIT').AsString, 3));

  If fEmptyStr(fRetSitTributaria(DataSet.FieldByName('ITE_CODSIT').AsString)) Then
  Begin
    pMensagemOk('Situação Tributária não encontrada!');
    DataSet.Cancel;
    Abort;
  End;

  If Not fMesmoGrupoSitTrib(DataSet.FieldByName('ITE_CODSIT').AsString) then
  Begin
    If (Not blnTroCst) Then
      pMensagemOk('Situação tributária não permitida!');

    DataSet.Cancel;
    Abort;
  End;

  If blnTrocaCFOP Then
  Begin
    If DataSet.FieldByName('DET_GARANT').AsString = 'G' Then
    Begin
      {***********************************}
      { GARANTIA - ENVIO P/ FORNECEDOR    }
      {********************************MM*}
      If (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, VS_strClaRGF) <= 0) AND (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, strClaGae) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                              'Garantia - Envio p/ Fornecedor (CLARGF ou CLAGAE)!', ['&O k']);
        DataSet.Cancel;
        Abort;
      End;

    End
    Else If blnNotImp Then
    Begin
      If not (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, VS_strClaImp) > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é permitido classificação de emissão de nota de importação!', ['&O k']);
        DataSet.Cancel;
        Abort;
      End;
    End
    Else
    Begin
      {***********************************}
      { OUTRAS SAIDAS - FORNECEDOR        }
      {********************************JB*}
      If (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, VS_strClaNfo) <= 0) And (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, VS_strClaNOE) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é permitido classificação de Outras Saídas!', ['&O k']);
        DataSet.Cancel;
        Abort;
      End;

      If (Pos(DataSet.FieldByName('ITE_CLAFIS').AsString, '5109_5110_6109_6110_') <= 0) And
         (Copy(DataSet.FieldByName('ITE_MTDICM').AsString, 1, 1) = '7') Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é permitido os CFOP´s 5109, 5110, 6109 e 6110 quando possuir produtos de ICMS Desonerado com motivo 7-SUFRAMA!', ['&O k']);
        DataSet.Cancel;
        Abort;
      End;

    End;

  End;

  If (not blnConfirmacaoEspelho) Or (Self.Showing And blnConfirmacaoEspelho) Then
  Begin
    pCalculaValor('ITE_BASICM', 'ITE_ALQICM', 'ITE_VALICM');
    pCalculaValor('ITE_BASIPI', 'ITE_ALQIPI', 'ITE_VALIPI');
  End;

  If Not (fValidaValor('ITE_BASICM')  And
          fValidaValor('ITE_ALQICM')  And
          fValidaValor('ITE_VALICM')  And
          fValidaValor('ITE_BASIPI')  And
          fValidaValor('ITE_ALQIPI')  And
          fValidaValor('ITE_VALIPI')  And
          fValidaValor('ITE_BASRET')  And
          fValidaValor('ITE_VALRET')) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not (fValidaBaseValor('ITE_BASICM'  , 'ITE_VALICM')  And
          fValidaBaseValor('ITE_BASIPI'  , 'ITE_VALIPI')  And
          fValidaBaseValor('ITE_BASFCP'  , 'ITE_VALFCP')  And
          fValidaBaseValor('ITE_BASFCP_' , 'ITE_VALFCP_') And
          fValidaBaseValor('ITE_BASRET'  , 'ITE_VALRET')) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not (fValidaValorRetido('ITE_BASRET') And
          fValidaValorRetido('ITE_VALRET') And
          fValidaValorRetido('ITE_BASFCP') And
          fValidaValorRetido('ITE_VALFCP')) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If fHabilitaDigitacaoDeNcm And fEmptyStr(DataSet.FieldByName('ITE_CLAIPI').AsString) Then
  Begin
    pMensagemOk('Informe o NCM !');
    DataSet.Cancel;
    Abort;
  End;

  If Assigned(fatVenda) And (not fatVenda.blnClienteZonaFrancaComDescontoEspecial) And (not FXMLEnt) Then
    pRecalculaIcmsDesonerado;

end;

procedure TfrmFatDadosFiscaisImpostos.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsItens.Active Then
    Exit;

  If Pos(Column.FieldName, 'ITE_CLAFIS_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_CFOP;

  If Pos(Column.FieldName, 'ITE_BASICM_ITE_ALQICM_ITE_VALICM_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_ICMS;

  If Pos(Column.FieldName, 'ITE_BASIPI_ITE_ALQIPI_ITE_VALIPI_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_IPI;

  If Pos(Column.FieldName, 'ITE_BASRET_ITE_VALRET_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_RETIDO;

  If Pos(Column.FieldName, 'ITE_VRDICM_ITE_MTDICM_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_DESONERADO;

  If (Column.FieldName = 'ITE_BASFCP_') Or
     (Column.FieldName = 'ITE_PERFCP_') Or
     (Column.FieldName = 'ITE_VALFCP_') Then
    dbgItens.Canvas.Brush.Color := COR_FCP;

  If (Column.FieldName = 'ITE_BASFCP') Or
     (Column.FieldName = 'ITE_PERFCP') Or
     (Column.FieldName = 'ITE_VALFCP') Then
    dbgItens.Canvas.Brush.Color := COR_FCP_ST;

  If (gdFocused in State) Then
  Begin
    dbgItens.Canvas.Brush.Color := clBlue;
    dbgItens.Canvas.Font.Color  := clWhite;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatDadosFiscaisImpostos.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pControlGridFocus(dbgItens, Key, btnConfirma);
end;

procedure TfrmFatDadosFiscaisImpostos.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCadSit: TUniQuery;
    blnReadOnly: Boolean;
    arrSel: TConsultasArray;
    strFiltro : String;
    intContador: Integer;
begin
  inherited;

  With dbgItens Do
  Begin
    If (dbgItens.SelectedField.FieldName = 'ITE_CODSIT') And
       (Not dbgItens.SelectedField.ReadOnly) And
       fEntraCons(Key) Then
    Begin
      qryCadSit := fCriaQuery(Self);

      If fPesqSitTributaria(Self,
                            Nil,
                            Nil,
                            qryCadSit,
                            Key,
                            arrSel) Then
      If (blnTroCst) Or (fMesmoGrupoSitTrib(qryCadSit.FieldByName('TRI_CODTRI').AsString)) then
      Begin
        With cdsItens Do
        Begin
          If State <> dsEdit Then
            Edit;

          blnReadOnly := cdsItensITE_CODSIT.ReadOnly;
          cdsItensITE_CODSIT.ReadOnly := False;
          FieldByName('ITE_CODSIT').AsString := qryCadSit.FieldByName('TRI_CODTRI').AsString;

          if fEnvioFornecedor then
          begin
            For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
            begin
              if fatVenda.arrMatItens[intContador].intAutInc = FieldByName('ITE_AUTINC').AsInteger then
              begin
                fatVenda.arrMatItens[intContador].strCodFis := FieldByName('ITE_CODSIT').AsString;
                fatVenda.arrMatItens[intContador].strCodSit := FieldByName('ITE_CODSIT').AsString;
                fatVenda.pDefineClassificacaoItem(fatVenda.arrMatItens[intContador],
                                                  fatVenda.fAtendeRegrasDifal(False, fatVenda.arrMatItens[intContador].strEmpIte));
                Break;
              end;
            end;
            if Assigned(FindField('ITE_CLAFIS')) then
              FieldByName('ITE_CLAFIS').AsString := fatVenda.arrMatItens[intContador].strClaFis;
          end;
          cdsItensITE_CODSIT.ReadOnly := blnReadOnly;
          Post;
        End;
      End;

      FreeAndNil(qryCadSit);

    End
    Else
    If (dbgItens.SelectedField.FieldName = 'ITE_CLAFIS') And
       (Not dbgItens.SelectedField.ReadOnly) And
       fEntraCons(Key) Then
    Begin
      qryCadSit := fCriaQuery(Self);

      If cdsItens.FieldByName('DET_GARANT').AsString = 'G' Then
        strFiltro := 'LOCATE(CFO_CODCFO, ' + QuotedStr(VS_strClaRGF+'_'+strClaGae)+') > 0 '
      Else
        strFiltro := 'LOCATE(CFO_CODCFO, ' + QuotedStr(VS_strClaNfo + '_' + VS_strClaNOE) + ') > 0 ';

      strFiltro := strFiltro + ' AND LEFT(CFO_CODCFO,1) >= 5 ';

      If fPesqCFOP(Self, Nil, Nil, qryCadSit, Key, arrSel, True, strFiltro) Then
      Begin
        With cdsItens Do
        Begin
          If State <> dsEdit Then
            Edit;

          FieldByName('ITE_CLAFIS').AsString := qryCadSit.FieldByName('CFO_CODCFO').AsString;

          Post;
        End;
      End;

      FreeAndNil(qryCadSit);

    End;


  End;

end;

function TfrmFatDadosFiscaisImpostos.fEhOutrasSaidasDeFornecedorComCfopX949(strClaFis: String): Boolean;
begin
  Result := False;

  if not (strOpcDoc = 'OF') then
    Exit;

  If not (RightStr(strClaFis, 3) = '949') Then
    Exit;

  Result := True;
end;

Function TfrmFatDadosFiscaisImpostos.fMesmoGrupoSitTrib(strCodSit: String): Boolean;
var
  intPosicao: integer;
  strMensagem: string;
  blnPermitirUsaX41: Boolean;
  blnForcarTrocaCST_GF: Boolean;
  blnEhOutrasSaidasDeFornecedorComCfopX949: Boolean;

  function fClassificacaoTributariaValida: Boolean;
  begin
    Result := False;

    If (Pos(strCodSit, CST_NAO_TRIBUTADO) > 0) Then
      Exit(True);

    If not (RightStr(cdsItens.FieldByName('ITE_CLAFIS').AsString, 3) = '914') Then
      Exit;

    If (Pos(strCodSit, CST_X40) > 0) Then
      Exit(True);

  end;

  function fPermitirUsaX41: Boolean;
  begin
    Result := False;

    If not (cdsItens.FieldByName('ITE_VALICM').AsFloat = 0) Then
      Exit;

    If not fClassificacaoTributariaValida Then
      Exit;

    Result := True;
  end;

Begin

  If blnUsaImpostoOriginal Then
  Begin
    Result := True;
    Exit;
  End;

  strMensagem := '';
  blnForcarTrocaCST_GF := False;

  blnEhOutrasSaidasDeFornecedorComCfopX949 := fEhOutrasSaidasDeFornecedorComCfopX949(cdsItens.FieldByName('ITE_CLAFIS').AsString);

  If Pos(strSitAnt, CST_SUBSTITUICAO) > 0 Then
  begin

    blnPermitirUsaX41 := fPermitirUsaX41;

    Result := (Pos(strCodSit, CST_SUBSTITUICAO) > 0) Or (Pos(strCodSit, CST_ANTECIPACAO_ICMS) > 0) or (blnPermitirUsaX41) Or blnEhOutrasSaidasDeFornecedorComCfopX949;

    if (not Result) and (not blnTroCst) then
    begin
      If (fRetSitTribEntrada(cdsItens.FieldByName('DET_AUTINC').AsString,
                                  cdsItens.FieldByName('ITE_DOCDEV').AsString,
                                  cdsItens.FieldByName('ITE_ESPDEV').AsString,
                                  cdsItens.FieldByName('ITE_EMPDEV').AsString,
                                  cdsItens.FieldByName('ITE_CODITE').AsString,
                                  cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                                  strCodSit,
                                  BlnTemXML)) then
        Result := true
      else
      begin
        if Not fEnvioFornecedor then
          strMensagem := 'A CST de origem deste produto é ST. Neste caso, só é permitido informar CST''s de Substituição, CST''s x90 (Outros), ou CST''s x41 sem ICMS.';
      end;
    end;
  end
  else
  begin
    Result := (Pos(strCodSit, CST_SUBSTITUICAO) <= 0) Or blnEhOutrasSaidasDeFornecedorComCfopX949;

    if (not Result) and (not blnTroCst) then
    begin
      If (fRetSitTribEntrada(cdsItens.FieldByName('DET_AUTINC').AsString,
                                  cdsItens.FieldByName('ITE_DOCDEV').AsString,
                                  cdsItens.FieldByName('ITE_ESPDEV').AsString,
                                  cdsItens.FieldByName('ITE_EMPDEV').AsString,
                                  cdsItens.FieldByName('ITE_CODITE').AsString,
                                  cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                                  strCodSit,
                                  BlnTemXML)) then

        Result := true
      else begin
        if Not fEnvioFornecedor then
          strMensagem := 'Não é permitido informar CST de Substituição para produtos que possuem outra origem tributária.';
      end;
    end;
  end;

 if fEnvioFornecedor then
  begin
    blnForcarTrocaCST_GF  := strSitAnt <> strCodSit;
  end;

  if (not fEmptyStr(strMensagem)) then
  begin
    fMensagem('Alteração não permitida!',strMensagem + sLineBreak +
                                        'Verifique seu cadastro de Abreviação de ICMS.', ['&Ok']);

  end
  else if ((not Result) and (blnTroCst)) or blnForcarTrocaCST_GF then
  begin
    intPosicao := Length(arrLiberaCST);
    SetLength(arrLiberaCST, Length(arrLiberaCST) + 1);
    arrLiberaCST[intPosicao].strCodIte := cdsItens.FieldByName('ITE_CODITE').AsString;
    arrLiberaCST[intPosicao].strDesIte := cdsItens.FieldByName('ITE_DESITE').AsString;
    arrLiberaCST[intPosicao].strCstAtu := strCodSit;
    arrLiberaCST[intPosicao].strCstAnt := strSitAnt;
    Result := True;
  end;
End;

function TfrmFatDadosFiscaisImpostos.fNotaDeDevolucaoExisteNaGERELE(strNumDoc,
  strEspDoc, strCodEmp, strCodFor: string; var strAutInc: string): boolean;
begin
  strAutInc := fCampoTabela('AUTOINCREM', 'GERELE', ['GER_DOCENT','GER_ESPENT','GER_EMPENT', 'GER_CODFOR'], [strNumDoc, strEspDoc, strCodEmp, strCodFor], False);
  Result := Not fEmptyStr(strAutInc);
end;

procedure TfrmFatDadosFiscaisImpostos.FormCreate(Sender: TObject);
begin
  inherited;
  blnUsaImpostoOriginal := False;
  blnConfirmacaoEspelho := False;
  pSetaCodIte(cdsItensITE_CODITE);
  strOpcDoc := '';
  blnValidar        := True;
  blnNotaFornecedor := False;
  blnIcmsDesonerado := False;
  blnTrocaCFOP      := False;
  blnDevolucao      := False;
  blnTroCst         := fCfgSis('TROCST', VarBoolean);
  blnNotImp         := False;
  blnAlteraValorDoItem := False;
  FXMLEnt := False;
  cdsItensITE_REFERE.Size := fTamRefere;
  cdsItens.CreateDataSet;
  objLiberacao := TLiberacao.Create;
  blnTeveFCPSTAlteradoManualemente := False;
  blnTeveMotivoValorDesoneradoAlteradoManualemente := False;
  VS_strClaNfo := fTransform(fCfgSis('CLANFO'), 4);
  VS_strClaNOE := fTransform(fCfgSis('CLANOE'), 4);
  SetLength(arrLiberaCST,0);
  fatVenda := Nil;
  strClaGae := fTransform(fCfgSis('CLAGAE'), 4);
  FSintetizouClassificacoesFiscais := False;
end;

procedure TfrmFatDadosFiscaisImpostos.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmFatDadosFiscaisImpostos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If(Shift = [ssAlt]) Then
  Begin
    Case Key Of
      VK_F1 : btnUtiImpOri.Click;
    End;
  End
  Else
  Begin
    Case key Of
      VK_F10:
      begin
        key := 0;
        btnConfirma.Click;
      end;
      VK_F1 : btnSugestao.Click;
      VK_F2 : btnZerarIcms.Click;
      VK_F3 : btnZerarIpi.Click;
      VK_F4 : btnZerarRetido.Click;
      VK_F5 : btnInfIcms.Click;
      VK_F6 : begin
                if btnInfIPI.Visible then
                  btnInfIPI.Click;
              end;
      VK_F7 : btnInfRet.Click;
      VK_F8 : btnDigPisCof.Click;
      VK_F9 : btnIcmsDesonerado.Click;
      VK_F12: btnAtribuirValoresXML.Click;

      VK_RETURN: If ((ActiveControl) = dbgItens) And (cdsItens.State = dsEdit) Then
                 Begin
                   cdsItens.Post;
                 End;
    End;
  End;
end;

procedure TfrmFatDadosFiscaisImpostos.FormShow(Sender: TObject);
begin
  inherited;
  btnInfRet.Visible   := blnNotaFornecedor;
  btnInfIPI.Visible   := blnNotaFornecedor;
  btnInfIcms.Visible  := blnNotaFornecedor;
  btnSugestao.Visible := blnNotaFornecedor Or blnIcmsDesonerado;
  btnAtribuirValoresXML.Visible := blnNotaFornecedor;
  btnIcmsDesonerado.Visible := blnIcmsDesonerado;
  btnTrocaCST.Visible := not cdsItensITE_CODSIT.ReadOnly;
  btnCstX90.Visible := (strOpcDoc = 'CO');

  fFindColumnByName(dbgItens, 'ITE_TOTITE').ReadOnly := Not blnAlteraValorDoItem;

  pSetaVisibilidadeNovosImpostos;

  If btnIcmsDesonerado.Visible Then
    btnIcmsDesonerado.Enabled := fVerificaAcessoSistema('ICMDES');

  If (Not blnNotaFornecedor) And (Not blnIcmsDesonerado) Then
  Begin
  //pnlBotoes.Height := pnlBotoes.Height - btnInfRet.Height;
  //btnSair.Top      := btnConfirma.Top;
  End;

  If not blnTrocaCFOP Then
    fFindColumnByName(dbgItens, 'ITE_CLAFIS').Visible := False;

  cdsItens.First;
  pSetFocus(dbgItens);
  dbgItens.SelectedField := cdsItens.FieldByName('ITE_BASICM');

  cdsItens.Active := False;
  cdsItens.Active := True;
  cdsItensAfterPost(cdsItens);

  dbgItens.Columns[6].Visible := fHabilitaDigitacaoDeNcm;

  btnUtiImpOri.Visible := fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor;

end;

function TfrmFatDadosFiscaisImpostos.fPegaIPIEntrada(strCodIte: String): Double;
begin
  Result := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
end;

function TfrmFatDadosFiscaisImpostos.fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor(
  strDocDev, strEspDev, strEmpDev, strCodCli: String): Boolean;
  Var
    strAutInc: String;
begin
  Result := fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor;

  if not fExisteNotaDeDevolucaoVinculada(strDocDev, strEspDev, strEmpDev) then
    Exit(False);

  if not fNotaDeDevolucaoExisteNaGERELE(strDocDev, strEspDev, strEmpDev, fatVenda.strCodCli, strAutInc) then
    Exit(False);

  if not fOcorreuProtocoloInterestadual(strAutInc) then
    Exit(False);

end;

function TfrmFatDadosFiscaisImpostos.fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor: Boolean;
begin
  Result := True;

  if not Assigned(fatVenda) then
    Exit(False);

  if pos(fatVenda.strOpcDoc, '_OF_GF_') = 0 then
    Exit(False);


end;

function TfrmFatDadosFiscaisImpostos.fRetSitTribEntrada(strAutIncDocEnt,
  strDocDev, strEspDev, strEmpDev, strCodIte: String; fltQtdIte: Double;
  strCodSit: String; var BlnTemXML: Boolean): Boolean;

Var
  qryEspDet : TUniQuery;
  fltFator  : Double;
Begin

  fltBasIcm := 0;
  fltAlqIcm := 0;
  fltValIcm := 0;

  fltBasIpi := 0;
  fltAlqIpi := 0;
  fltValIpi := 0;

  fltBasRet := 0;
  fltValRet := 0;

  fltBasFCP := 0;
  fltPerFCP := 0;
  fltValFCP := 0;

  FBasFCP_ := 0;
  FPerFCP_ := 0;
  FValFCP_ := 0;

  FValIva  := 0;
  FIcmDes  := 0;
  FMotDes  := '';

  strCODCST := '';

  qryEspDet := fCriaQuery;
  qryEspDet.Close;
  qryEspDet.SQL.Clear;
  qryEspDet.SQL.Add(' SELECT DET_CSTXML            ');
  If FEmptyStr(strCodSit) Then
  Begin
    qryEspDet.SQL.Add(' ,I10_QCOM AS DET_QTDITE, ');

    qryEspDet.SQL.Add('  DE.N15_VBC   AS DET_BASICM, ');
    qryEspDet.SQL.Add('  DE.N16_PICMS AS DET_ALQICM, ');
    qryEspDet.SQL.Add('  DE.N17_VICMS AS DET_VALICM, ');

    qryEspDet.SQL.Add('  N17A_VBCFCP AS DET_BFCP, ');
    qryEspDet.SQL.Add('  N17B_PFCP   AS DET_PFCP, ');
    qryEspDet.SQL.Add('  N17C_VFCP   AS DET_VFCP, ');

    qryEspDet.SQL.Add('  N27A_VICMSDESON AS DET_ICMDES, ');
    qryEspDet.SQL.Add('  N27A_MOTDESICMS AS DET_MOTDES, ');
    qryEspDet.SQL.Add('  N19_PMVAST      AS DET_VALIVA, ');

    qryEspDet.SQL.Add('  N21_VBCST   AS DET_BASRET,  ');
    qryEspDet.SQL.Add('  N22_PICMSST AS DET_ALQRET,  ');
    qryEspDet.SQL.Add('  N23_VICMSST AS DET_VALRET,  ');

    qryEspDet.SQL.Add('  O10_VBC  AS DET_BASIPI,     ');
    qryEspDet.SQL.Add('  O13_PIPI AS DET_ALQIPI,     ');
    qryEspDet.SQL.Add('  O14_VIPI AS DET_VALIPI,     ');

    qryEspDet.SQL.Add('  N23A_VBCFCPST AS DET_BFCPST,');
    qryEspDet.SQL.Add('  N23B_PFCPST   AS DET_PFCPST,');
    qryEspDet.SQL.Add('  N23D_FCPST    AS DET_VFCPST ');
  End;

  qryEspDet.SQL.Add('       FROM MOVGER G          ');
  qryEspDet.SQL.Add(' INNER JOIN MOVDET DT ON DT.DET_SEQGER = G.AUTOINCREM                         ');
  qryEspDet.SQL.Add('  LEFT JOIN ESPDET  E ON DT.AUTOINCREM = E.DET_SEQDET                         ');
  qryEspDet.SQL.Add(' INNER JOIN GERELE GE ON GE.GER_DOCENT = DT.DET_NUMDOC                        ');
  qryEspDet.SQL.Add('                     AND GE.GER_ESPENT = DT.DET_ESPDOC                        ');
  qryEspDet.SQL.Add('                     AND GE.GER_EMPENT = DT.DET_CODEMP                        ');
  qryEspDet.SQL.Add('                     AND GE.GER_CODFOR = DT.DET_CODFOR                        ');
  qryEspDet.SQL.Add('                     AND IFNULL(GE.B07_SERIE, "") = IFNULL(DT.DET_SERIE_, "") ');
  qryEspDet.SQL.Add(' INNER JOIN DETELE DE ON GE.AUTOINCREM = DE.DET_SEQGER                        ');
  qryEspDet.SQL.Add('                     AND DE.DET_CODITE = DT.DET_CODITE                        ');

  If Not fEmptyStr(strAutIncDocEnt) Then
    qryEspDet.SQL.Add(' WHERE E.AUTOINCREM = :AUTINC                                               ')
  Else
  Begin
    qryEspDet.SQL.Add(' WHERE  G.GER_NUMDOC = :DOCDEV                                              ');
    qryEspDet.SQL.Add('   AND  G.GER_ESPDOC = :ESPDEV                                              ');
    qryEspDet.SQL.Add('   AND  G.GER_CODEMP = :EMPDEV                                              ');
    qryEspDet.SQL.Add('   AND DT.DET_CODITE = :CODITE                                              ');
  End;

  If Not fEmptyStr(strAutIncDocEnt) Then
    qryEspDet.ParamByName('AUTINC').AsString := strAutIncDocEnt
  Else
  Begin
    qryEspDet.ParamByName('DOCDEV').AsString := strDocDev;
    qryEspDet.ParamByName('ESPDEV').AsString := strEspDev;
    qryEspDet.ParamByName('EMPDEV').AsString := strEmpDev;
    qryEspDet.ParamByName('CODITE').AsString := strCodIte;
  End;

  qryEspDet.Open;

  If qryEspDet.IsEmpty Then
  Begin
    Result    := False;
    BlnTemXML := False;
  End
  Else
  Begin
    Result    := qryEspDet.FieldByName('DET_CSTXML').AsString = strCodSit;
    BlnTemXML := True;

    If FEmptyStr(strCodSit) Then
    Begin
      If fltQtdIte <> qryEspDet.FieldByName('DET_QTDITE').AsFloat Then
        fltFator := fltQtdIte / qryEspDet.FieldByName('DET_QTDITE').AsFloat
      Else
        fltFator := 1;

      fltBasIcm := fFormataFloat((qryEspDet.FieldByName('DET_BASICM').AsFloat * fltFator), 2);
      fltAlqIcm := qryEspDet.FieldByName('DET_ALQICM').AsFloat;
      fltValIcm := qryEspDet.FieldByName('DET_VALICM').AsFloat * fltFator;

      fltBasIpi := qryEspDet.FieldByName('DET_BASIPI').AsFloat * fltFator;
      fltAlqIpi := qryEspDet.FieldByName('DET_ALQIPI').AsFloat;
      fltValIpi := qryEspDet.FieldByName('DET_VALIPI').AsFloat * fltFator;

      fltBasRet := qryEspDet.FieldByName('DET_BASRET').AsFloat * fltFator;
      fltValRet := qryEspDet.FieldByName('DET_VALRET').AsFloat * fltFator;

      fltBasFCP := qryEspDet.FieldByName('DET_BFCPST').AsFloat * fltFator;
      fltPerFCP := qryEspDet.FieldByName('DET_PFCPST').AsFloat;
      fltValFCP := qryEspDet.FieldByName('DET_VFCPST').AsFloat * fltFator;

      FBasFCP_ := qryEspDet.FieldByName('DET_BFCP').AsFloat * fltFator;
      FPerFCP_ := qryEspDet.FieldByName('DET_PFCP').AsFloat;
      FValFCP_ := qryEspDet.FieldByName('DET_VFCP').AsFloat * fltFator;

      FValIva  := qryEspDet.FieldByName('DET_VALIVA').AsFloat;
      FIcmDes  := qryEspDet.FieldByName('DET_ICMDES').AsFloat * fltFator;
      FMotDes  := qryEspDet.FieldByName('DET_MOTDES').AsString;

      strCODCST := qryEspDet.FieldByName('DET_CSTXML').AsString;
    End;

  End;

  FreeAndNil(qryEspDet);

end;

function TfrmFatDadosFiscaisImpostos.fAlteraParaImpostosOriginaisDeEntrada: Boolean;
var
  qryImpostos: TUniQuery;
  fltQtdTotIte: Double;
  fltQtdIte: Double;
begin
  qryImpostos := fCriaQuery;
  try
    Result := False;

    qryImpostos.Close;
    qryImpostos.SQL.Clear;
    qryImpostos.SQL.Add('SELECT D.N12_CST, D.N15_VBC, D.N16_PICMS, D.N17A_VBCFCP, D.N17B_PFCP, D.O10_VBC, ');
    qryImpostos.SQL.Add('       D.O13_PIPI, D.N21_VBCST, D.N22_PICMSST, D.N23A_VBCFCPST, D.N23B_PFCPST, D.I10_QCOM ');
    qryImpostos.SQL.Add('FROM DETELE D');
    qryImpostos.SQL.Add('INNER JOIN GERELE G');
    qryImpostos.SQL.Add('ON(G.AUTOINCREM = D.DET_SEQGER)');
    qryImpostos.SQL.Add('WHERE G.GER_DOCENT = :NUMDOC');
    qryImpostos.SQL.Add('AND G.GER_ESPENT = :ESPDOC');
    qryImpostos.SQL.Add('AND G.GER_EMPENT = :CODEMP');
    qryImpostos.SQL.Add('AND G.GER_CODFOR = :CODFOR');
    qryImpostos.SQL.Add('AND D.DET_CODITE = :CODITE');

    cdsItens.First;

    While Not cdsItens.eof do
    begin
      if Not fPermiteUtilizarCstEImpostosOriginaisDaNotaDoFornecedor(cdsItens.FieldByName('ITE_DOCDEV').AsString,
                                                                     cdsItens.FieldByName('ITE_ESPDEV').AsString,
                                                                     cdsItens.FieldByName('ITE_EMPDEV').AsString,
                                                                     fatVenda.strCodCli) then
      begin
        cdsItens.Next;
        Continue;
      end;

      qryImpostos.Close;
      qryImpostos.ParamByName('NUMDOC').AsString := strDocDev;
      qryImpostos.ParamByName('ESPDOC').AsString := strEspDev;
      qryImpostos.ParamByName('CODEMP').AsString := strEmpDev;
      qryImpostos.ParamByName('CODFOR').AsString := fatVenda.strCodCli;
      qryImpostos.ParamByName('CODITE').AsString := cdsItens.FieldByName('ITE_CODITE').AsString;
      qryImpostos.Open;

      if not qryImpostos.IsEmpty then
      begin
        fltQtdTotIte := qryImpostos.FieldByName('I10_QCOM').AsFloat;
        fltQtdIte :=  cdsItens.FieldByName('ITE_QTDITE').AsFloat;
        cdsItens.Edit;

        if fEnvioFornecedor Then
          cdsItens.FieldByName('ITE_CODSIT').AsString := qryImpostos.FieldByName('N12_CST').AsString
        else
          cdsItens.FieldByName('ITE_CODSIT').AsString := '0' + qryImpostos.FieldByName('N12_CST').AsString;

        cdsItens.FieldByName('ITE_BASICM').AsFloat := fFormataFloat((qryImpostos.FieldByName('N15_VBC').AsFloat / fltQtdTotIte) * fltQtdIte, 2);
        cdsItens.FieldByName('ITE_ALQICM').AsFloat := qryImpostos.FieldByName('N16_PICMS').AsFloat;
        cdsItens.FieldByName('ITE_VALICM').AsFloat := fFormataFloat(cdsItens.FieldByName('ITE_BASICM').AsFloat * (cdsItens.FieldByName('ITE_ALQICM').AsFloat / 100), 2);
        cdsItens.FieldByName('ITE_BASFCP_').AsFloat := fFormataFloat((qryImpostos.FieldByName('N17A_VBCFCP').AsFloat / fltQtdTotIte) * fltQtdIte, 2);
        cdsItens.FieldByName('ITE_PERFCP_').AsFloat := qryImpostos.FieldByName('N17B_PFCP').AsFloat;
        cdsItens.FieldByName('ITE_VALFCP_').AsFloat := fFormataFloat(cdsItens.FieldByName('ITE_BASFCP_').AsFloat * (cdsItens.FieldByName('ITE_PERFCP_').AsFloat / 100), 2);
        cdsItens.FieldByName('ITE_BASIPI').AsFloat := fFormataFloat((qryImpostos.FieldByName('O10_VBC').AsFloat / fltQtdTotIte) * fltQtdIte, 2);
        cdsItens.FieldByName('ITE_ALQIPI').AsFloat := qryImpostos.FieldByName('O13_PIPI').AsFloat;
        cdsItens.FieldByName('ITE_VALIPI').AsFloat := fFormataFloat(cdsItens.FieldByName('ITE_BASIPI').AsFloat * (cdsItens.FieldByName('ITE_ALQIPI').AsFloat / 100), 2);
        cdsItens.FieldByName('ITE_BASRET').AsFloat := fFormataFloat((qryImpostos.FieldByName('N21_VBCST').AsFloat / fltQtdTotIte) * fltQtdIte, 2);
        cdsItens.FieldByName('ITE_VALRET').AsFloat := fFormataFloat(cdsItens.FieldByName('ITE_BASRET').AsFloat * (qryImpostos.FieldByName('N22_PICMSST').AsFloat / 100), 2);
        cdsItens.FieldByName('ITE_BASFCP').AsFloat := fFormataFloat((qryImpostos.FieldByName('N23A_VBCFCPST').AsFloat / fltQtdTotIte) * fltQtdIte, 2);
        cdsItens.FieldByName('ITE_PERFCP').AsFloat := qryImpostos.FieldByName('N23B_PFCPST').AsFloat;
        cdsItens.FieldByName('ITE_VALFCP').AsFloat := fFormataFloat(cdsItens.FieldByName('ITE_BASFCP').AsFloat * (cdsItens.FieldByName('ITE_PERFCP').AsFloat / 100), 2);
        cdsItens.Post;
      end;

      cdsItens.Next;
    end;

    Result := True;
  finally
    FreeAndNil(qryImpostos);
  end;
end;

function TfrmFatDadosFiscaisImpostos.fChamaTelaDeTrava: Boolean;
var
  intAgrupador,
  intPosicao: integer;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
begin

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('As CSTs de origem destes produtos são ST ou tributária.');
  objLiberacao.objMsgLibera.pAddTexto('Neste caso, só é permitido informar CST''s de Substituição ou CST''s x90 (Outros).');
  objLiberacao.objMsgLibera.pAddTexto(' ');

  objTabela := TRegistroMsgLiberaTabela.Create;
  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'CÓD.'        , fTamCodIte   , alEsquerda, teAutcom);
  objLinha.pAddColuna(''  , 'DESCRIÇÃO'   , 50  , alEsquerda, teAutcom);
  objLinha.pAddColuna(''  , 'CST ANTERIOR', 12  , alEsquerda, teAutcom);
  objLinha.pAddColuna(''  , 'CST NOVA'    , 8   , alEsquerda, teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  intAgrupador := -1;
  for intPosicao := Low(arrLiberaCST) to High(arrLiberaCST) do
  begin
    inc(intAgrupador);
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.intAgrupador := intAgrupador;
    objLinha.pAddColuna('CÓD.'          , arrLiberaCST[intPosicao].strCodIte                         , fTamCodIte, alEsquerda , teAutcom);
    objLinha.pAddColuna('DESCRIÇÃO'     , arrLiberaCST[intPosicao].strDesIte                         , 50  , alEsquerda , teAutcom);
    objLinha.pAddColuna('CST ANTERIOR'  , arrLiberaCST[intPosicao].strCstAnt                         , 12  , alEsquerda , teAutcom);
    objLinha.pAddColuna('CST NOVA'      , arrLiberaCST[intPosicao].strCstAtu                         , 8   , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
  end;
  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'STRCST';
  objLiberacao.strSenLib := fCfgSis('STRCST');
  objLiberacao.strMsgSen := 'Liberação de troca de CST de outra origem.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnIgnInc := True;

  Result := objLiberacao.fLibera;
end;

function TfrmFatDadosFiscaisImpostos.fEnvioFornecedor: Boolean;
begin
  if Assigned(fatVenda) then
    Result := fatVenda.strOpcDoc = 'GF'
  else
    Result := False;
end;

function TfrmFatDadosFiscaisImpostos.fExisteNotaDeDevolucaoVinculada(strDocDev, strEspDev, strEmpDev: string): Boolean;
begin
  Result := True;

  if fEmptyStr(strDocDev) then
    Exit(False);

  if fEmptyStr(strEspDev) then
    Exit(False);

  if fEmptyStr(strEmpDev) then
    Exit(False);
end;

function TfrmFatDadosFiscaisImpostos.fOcorreuProtocoloInterestadual(strAutInc: string): Boolean;
var
  intContador: integer;
begin
  Result := False;

  for intContador := 0 to Length(fatVenda.arrMatItens) - 1 do
  begin
    if Not fEnvioFornecedor then
    begin
      if Pos(RightStr(fatVenda.arrMatItens[intContador].strCodFis, 2), '10_30_60_70') <= 0 then
        continue;
    end;

    if fCampoTabela('N12_CST', 'DETELE', ['DET_SEQGER','DET_CODITE'], [strAutInc, fatVenda.arrMatItens[intContador].strCodIte], False) = '00' then
      Exit(True);
  end;
end;

function TfrmFatDadosFiscaisImpostos.fOrgaoPublicoOuZonaFranca: Boolean;
begin
  Result := ((Self.strCliOrg = 'S') Or (Self.strZonFra = 'S'));
end;

procedure TfrmFatDadosFiscaisImpostos.btnTrocaCSTClick(Sender: TObject);
Var
  Key: Char;
  qryCadSit: TUniQuery;
  blnReadOnly: Boolean;
  arrSel: TConsultasArray;
  cdsCSTAnt: TUniClientDataSet;
  intContador: Integer;
begin
  blnReadOnly := cdsItensITE_CODSIT.ReadOnly;
  cdsCSTAnt := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsCSTAnt, cdsItens);

  If fMensagem('ATENÇÃO!!!','Esse procedimento vai trocar a Sit.Tributária de todos os produtos.'+#13+
                            'Deseja Continuar?', ['&Sim', '&Não']) = 1 Then

  Try
    qryCadSit := fCriaQuery(Self);

    Key := Char('/');
    cdsItensITE_CODSIT.ReadOnly := False;

    If fPesqSitTributaria(Self,
                          Nil,
                          Nil,
                          qryCadSit,
                          Key,
                          arrSel) Then
    If (blnTroCst) Or (fMesmoGrupoSitTrib(qryCadSit.FieldByName('TRI_CODTRI').AsString)) then
    Begin
      With cdsItens Do
      Begin
        Try
          DisableControls;
          First;
          While not Eof Do
          Begin
            Try
              Edit;
              FieldByName('ITE_CODSIT').AsString := qryCadSit.FieldByName('TRI_CODTRI').AsString;
              Post;
            Except

            End;

            Next;
          End;

          if Length(arrLiberaCST) > 0 then
          begin
            if not fChamaTelaDeTrava then
            begin
              pCloneDataSet(cdsItens, cdsCSTAnt);
            end
            else
            begin
              if Assigned(fatVenda) then
              begin
                First;
                While not Eof Do
                Begin
                  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
                  Begin
                    if fatVenda.arrMatItens[intContador].intAutInc = FieldByName('ITE_AUTINC').AsInteger then
                    begin
                      if fEnvioFornecedor then
                        fatVenda.arrMatItens[intContador].strCodFis := FieldByName('ITE_CODSIT').AsString;
                      fatVenda.arrMatItens[intContador].strCodSit := FieldByName('ITE_CODSIT').AsString;

                      If (fatVenda.strOpcDoc <> 'NE') Then
                      Begin
                        fatVenda.pDefineClassificacaoItem(fatVenda.arrMatItens[intContador],
                                                          fatVenda.fAtendeRegrasDifal(False, fatVenda.arrMatItens[intContador].strEmpIte));
                        Edit;
                        FieldByName('ITE_CLAFIS').AsString := fatVenda.arrMatItens[intContador].strClaFis;
                        Post;
                      End;

                      Break;
                    end;
                  end;

                  Next;
                End;

                FSintetizouClassificacoesFiscais := True;
                fatVenda.pSintetizaClassificacoes(fatVenda.strOpcDoc <> 'NE');
              end;
            end;
          end;
        Finally
          First;
          EnableControls;
        End;
      End;
    End;
  Finally
    cdsItensITE_CODSIT.ReadOnly := blnReadOnly;
    FreeAndNil(qryCadSit);
    FreeAndNil(cdsCSTAnt);
  End;

end;

procedure TfrmFatDadosFiscaisImpostos.btnUtiImpOriClick(Sender: TObject);
var
  strMsg: string;
begin
  inherited;
  if not btnUtiImpOri.Visible then
    Exit;
  strMsg := 'Este procedimento irá utilizar a CST e impostos da nota fiscal original do fornecedor,' + sLineBreak +
            'com o objetivo de anular por devolução, a entrada ocorrida.' + sLineBreak +
            'Quando o produto e a UF do Fornecedor não constam em Protocolos/Convênios, estas informações' + sLineBreak +
            'estarão diferentes das informações gravadas no processo de entrada de mercadorias.' + sLineBreak +
            'A apuração dos impostos precisará ser ajustada após emissão da nota de devolução.' + sLineBreak +
            'Deseja prosseguir ?';

  if fMensagem('ATENÇÃO', strMsg, ['&Sim', '&Não'], 2, False, 1, 100, False, 0, False, False, False, 210, 600) = 2 then
    Exit;

  Try
    blnUsaImpostoOriginal := True;

    if not fAlteraParaImpostosOriginaisDeEntrada then
      fMensagem('ATENÇÃO', 'Ocorreu um erro ao utilizar os impostos originais de entrada!', ['&Ok']);
  Finally
    blnUsaImpostoOriginal := False;
  End;
end;

function TfrmFatDadosFiscaisImpostos.fHabilitaDigitacaoDeNcm: Boolean;
begin
  Result := False;

  if Assigned(fatVenda) then
    Result := (Not blnConfirmacaoEspelho) And ((fatVenda.strCliEst = 'EX') Or (fatVenda.fTrocaUFEndEntrega = 'EX'))
end;

procedure TfrmFatDadosFiscaisImpostos.btnCstX90Click(Sender: TObject);
var
  blnReadOnly: Boolean;
begin

  blnReadOnly := cdsItensITE_CODSIT.ReadOnly;

  Try
    cdsItensITE_CODSIT.ReadOnly := False;

    cdsItens.Edit;
    cdsItens.FieldByName('ITE_CODSIT').AsString := LeftStr(cdsItens.FieldByName('ITE_CODSIT').AsString,1) + '90';
    cdsItens.Post;
  Finally
    cdsItensITE_CODSIT.ReadOnly := blnReadOnly;
  End;
end;

procedure TfrmFatDadosFiscaisImpostos.pSintetizaClassificacoes;
var
  intContador: integer;
begin
  if Assigned(fatVenda) then
  begin
    cdsItens.First;
    While not cdsItens.Eof Do
    Begin
      For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
      Begin
        if fatVenda.arrMatItens[intContador].intAutInc = cdsItens.FieldByName('ITE_AUTINC').AsInteger then
        begin
          fatVenda.arrMatItens[intContador].strClaFis := cdsItens.FieldByName('ITE_CLAFIS').AsString;
        end;
      end;

      cdsItens.Next;
    End;

    fatVenda.pSintetizaClassificacoes(False);

    FSintetizouClassificacoesFiscais := True;
  end;
end;

end.
