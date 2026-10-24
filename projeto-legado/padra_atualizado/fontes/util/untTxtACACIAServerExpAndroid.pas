unit untTxtACACIAServerExpAndroid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, ComCtrls, Uni, UniClientDataSet, UniDataSetProvider,
  StrUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  MaskEditFocus, 
  untFrameDirectoryEditFocus;

type
  TfrmTxtACACIAServerExpAndroid = class(TfrmPai)
    lbl1: TLabel;
    pgbProgresso: TProgressBar;
    tmrFechar: TTimer;
    imgAtivid: TImage;
    imgCidade: TImage;
    imgClient: TImage;
    imgMarcas: TImage;
    imgProdut: TImage;
    imgRegiao: TImage;
    imgStsCli: TImage;
    imgStsPro: TImage;
    lblAtivid: TLabel;
    lblCidade: TLabel;
    lblClient: TLabel;
    lblMarcas: TLabel;
    lblProdut: TLabel;
    lblRegiao: TLabel;
    lblStsCli: TLabel;
    lblStsPro: TLabel;
    imgConPag: TImage;
    lblConPag: TLabel;
    imgForPag: TImage;
    lblForPag: TLabel;
    imgGruPro: TImage;
    lblGruPro: TLabel;
    lblUndFat: TLabel;
    imgUndFat: TImage;
    imgTabPre: TImage;
    lblTabPre: TLabel;
    imgTipPed: TImage;
    lblTipPed: TLabel;
    imgTitCtr: TImage;
    lblTitCtr: TLabel;
    imgTipDoc: TImage;
    lblTipDoc: TLabel;
    imgTipNot: TImage;
    lblTipNot: TLabel;
    imgUndVen: TImage;
    lblUndVen: TLabel;
    btnConfirma: TBitBtnLocked;
    dirPathExp: TfraDirectoryEditFocus;
    gpbFiltraPeriodo: TGroupBox;
    chkFiltraPeriodo: TCheckBox;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    dtpDtaIni: TDateTimePicker;
    dtpDtaFin: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure tmrFecharTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dirPathExpExit(Sender: TObject);
    procedure chkFiltraPeriodoClick(Sender: TObject);
    procedure dirPathExpedtDirectoryChange(Sender: TObject);
    procedure dirPathExpedtDirectoryExit(Sender: TObject);
  private
    { Private declarations }
    qryGenerica: TUniQuery;
    dspGenerica: TUniDataSetProvider;
    cdsGenerica: TUniClientDataSet;
    qryClientes: TUniQuery;
    dspClientes: TUniDataSetProvider;
    cdsClientes: TUniClientDataSet;
    qryProdutos: TUniQuery;
    dspProdutos: TUniDataSetProvider;
    cdsProdutos: TUniClientDataSet;
    qryNotas   : TUniQuery;
    dspNotas   : TUniDataSetProvider;
    cdsNotas   : TUniClientDataSet;
    qryPedidos : TUniQuery;
    dspPedidos : TUniDataSetProvider;
    cdsPedidos : TUniClientDataSet;

    qryItensPromocao: TUniQuery;

    lstTextoNF : TStringList;
    lstTextoINF: TStringList;
    lstTextoPD : TStringList;
    lstTextoIPD: TStringList;
    lstTextoTAB: TStringList;
    lstTextoCat: TStringList;
    strLinhaNF : String;
    strLinhaINF: String;
    strLinhaPD : String;
    strLinhaIPD: String;
    strLinhaTAB: String;
    strLinhaCat: String;

    procedure TE_CALLCENTER;
    procedure T_CANALCLIENTE;
    procedure T_CATEGORIA(strCodFor: String);
    procedure TE_CLIENTE;
    procedure T_CONDPAGTO;
    procedure T_FORMAPAGTO;
    procedure TR_CONDFORMAPAGTO;
    procedure T_GRUPOPRODUTO;
    procedure TE_HISTPEDIDO(strCodCli: String);
    procedure TE_KITPRODUTO;
    procedure TE_MARCA;
    procedure T_META;
    procedure TE_METAGERAL;
    procedure T_MUNICIPIO;
    procedure TE_NOTAFISCAL(strCodCli: String);
    procedure TE_PRODUTO;
    procedure TE_PRODUTOUNIDFAT;
    procedure TE_REGIAO;
    procedure T_SALDO;
    procedure T_STATUSCLIENTE;
    procedure T_STATUSPRODUTO;
    procedure TE_TIPODOCUMENTO;
    procedure T_TIPONOTA;
    procedure T_TIPOPEDIDO;
    procedure TE_TITULO;
    procedure T_UNIDFAT;
    procedure TESP_DESCPRODUTO;
    procedure TESP_FILTROPRODUTO;
    procedure TESP_TIPOFORMA;
    procedure TESP_CAMPANHAS;
    procedure TESP_SIMILARIDADES;
    procedure TESP_MARCAVEND;
    procedure TESP_CAMPFLEX;
    procedure TESP_CONFIGMARGEM;
    procedure TR_UNIDFATVEND;

    function fRetNroParcela(strParcel: String): String;
    function fRetTipDocumento(strEspDoc: String): String;

    procedure pCriaQueryPromocoes;    

  public
    { Public declarations }
    blnGeracaoAut        : Boolean;
    blnGerou             : Boolean;
    strPathExp           : String;
    strTE_CALLCENTER     : String;
    strT_CANALCLIENTE    : String;
    strT_CATEGORIA	     : String;
    strTE_CLIENTE	       : String;
    strTR_CLIENTEVENDEDOR: String;
    strT_CONDPAGTO	     : String;
    strT_CONTATO	       : String;
    strTE_ENDENTREGA	   : String;
    strT_FORMAPAGTO	     : String;
    strTR_CONDFORMAPAGTO : String;
    strT_GRUPOPRODUTO	   : String;
    strTE_HISTPEDIDO	   : String;
    strTE_HISTPEDIDOITEM : String;
    strTE_KITPRODUTO	   : String;
    strTE_LIMITECREDCLI	 : String;
    strTE_MARCA	         : String;
    strT_META	           : String;
    strTE_METAGERAL	     : String;
    strT_MUNICIPIO	     : String;
    strTE_NOTAFISCAL	   : String;
    strTE_NOTAFISCALITEM : String;
    strTE_PRODUTO	       : String;
    strTE_PRODUTOUNIDFAT : String;
    strTE_REGIAO	       : String;
    strT_SALDO	         : String;
    strT_STATUSCLIENTE	 : String;
    strT_STATUSPRODUTO 	 : String;
    strTE_TABELAPRECO    : String;
    strTE_TIPODOCUMENTO  : String;
    strT_TIPONOTA	       : String;
    strT_TIPOPEDIDO      : String;
    strTE_TITULO         : String;
    strT_UNIDFAT	       : String;
    strTESP_DESCPRODUTO	 : String;
    strTESP_FILTROPRODUTO: String;
    strTESP_TIPOFORMA	   : String;
    strTESP_CAMPANHAS	   : String;
    strTESP_SIMILARIDADES: String;
    strTESP_MARCAVEND    : String;
    strTESP_CAMPFLEX	   : String;
    strTESP_CONFIGMARGEM : String;
    strTR_UNIDFATVEND    : String;    
  end;

implementation

uses untFuncoesSimples, untModulo, Data.DB, Types;

{$R *.dfm}

procedure TfrmTxtACACIAServerExpAndroid.btnConfirmaClick(Sender: TObject);
  Var
    strHorIni: String;
    strHorFin: String;
begin
  inherited;
  If fEmptyStr(dirPathExp.edtDirectory.text) Then
  Begin
    fMensagem('','Informar o Path para exportação dos arquivos TXTs!', ['&OK']);
    Exit;
  End;
  If (chkFiltraPeriodo.Checked) And
     (dtpDtaIni.DateTime > dtpDtaFin.DateTime) Then
  Begin
    fMensagem('','A data inicial deve ser anterior à data final!', ['&OK']);
    Exit;
  End;
  if fCfgSis('EMPACA') = '' then
  begin
    fMensagem('','O código da(s) empresa(s) deve(m) ser informado(s) nas configurações!', ['&OK']);
    Exit;
  end;
  Try
    btnConfirma.Enabled := False;
    btnSair.Enabled     := False;
    dirPathExp.Enabled  := False;
    pnlInfo.Caption     := 'Aguarde, exportando arquivos...';
    strHorIni           := FormatDateTime('hh:mm:ss', fTime());
    Screen.Cursor       := crHourGlass;
    pCriaQueryPromocoes;    
    TE_CALLCENTER;
    T_CANALCLIENTE;
    T_MUNICIPIO;
    TE_CLIENTE;
    TE_KITPRODUTO;
    TE_MARCA;
    T_META;
    TE_METAGERAL;
    TE_PRODUTOUNIDFAT;
    TE_PRODUTO;
    TE_REGIAO;
    T_SALDO;
    T_STATUSCLIENTE;
    T_STATUSPRODUTO;
    T_CONDPAGTO;
    T_FORMAPAGTO;
    TR_CONDFORMAPAGTO;
    T_GRUPOPRODUTO;
    T_UNIDFAT;
    T_TIPOPEDIDO;
    TE_TIPODOCUMENTO;
    T_TIPONOTA;
    TE_TITULO;
    TESP_DESCPRODUTO;
    TESP_FILTROPRODUTO;
    TESP_TIPOFORMA;
    TESP_CAMPANHAS;
    TESP_SIMILARIDADES;
    TESP_MARCAVEND;
    TESP_CAMPFLEX;
    TESP_CONFIGMARGEM;
    TR_UNIDFATVEND;

    Screen.Cursor       := crDefault;
    strHorFin           := FormatDateTime('hh:mm:ss', fTime());
    pnlInfo.Caption     := 'Exportação gerada com sucesso!';
    If (Not blnGeracaoAut) Then
      fMensagem('','Exportação OK. - Início: ' + strHorIni + ' - Término: ' + strHorFin,['&OK']);
  Finally
    btnConfirma.Enabled := True;
    btnSair.Enabled     := True;
    dirPathExp.Enabled  := True;
    pSetFocus(dirPathExp);
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.chkFiltraPeriodoClick(Sender: TObject);
begin
  gpbFiltraPerIodo.Enabled := chkFiltraPeriodo.Checked;
end;

procedure TfrmTxtACACIAServerExpAndroid.dirPathExpExit(Sender: TObject);
begin
  inherited;
  strPathExp := dirPathExp.edtDirectory.text;
end;

procedure TfrmTxtACACIAServerExpAndroid.FormActivate(Sender: TObject);
begin
  inherited;
  If blnGeracaoAut And (Not blnGerou) Then
  Begin
    btnConfirma.Click;
    blnGerou          := True;
    tmrFechar.Enabled := True;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.FormCreate(Sender: TObject);
begin
  inherited;
  blnGeracaoAut          := False;
  blnGerou               := False;
  qryGenerica            := TUniQuery.Create(Self);
  qryGenerica.Connection := frmModulo.GetCurrentConnection;
  dspGenerica            := TUniDataSetProvider.Create(Self);
  cdsGenerica            := TUniClientDataSet.Create(Self);
  cdsGenerica.DisableControls;
  qryClientes            := TUniQuery.Create(Self);
  qryClientes.Connection := frmModulo.GetCurrentConnection;
  dspClientes            := TUniDataSetProvider.Create(Self);
  cdsClientes            := TUniClientDataSet.Create(Self);
  cdsClientes.DisableControls;
  qryProdutos            := TUniQuery.Create(Self);
  qryProdutos.Connection := frmModulo.GetCurrentConnection;
  dspProdutos            := TUniDataSetProvider.Create(Self);
  cdsProdutos            := TUniClientDataSet.Create(Self);
  cdsProdutos.DisableControls;
  qryNotas               := TUniQuery.Create(Self);
  qryNotas.Connection    := frmModulo.GetCurrentConnection;
  dspNotas               := TUniDataSetProvider.Create(Self);
  cdsNotas               := TUniClientDataSet.Create(Self);
  cdsNotas.DisableControls;
  qryPedidos             := TUniQuery.Create(Self);
  qryPedidos.Connection  := frmModulo.GetCurrentConnection;
  dspPedidos             := TUniDataSetProvider.Create(Self);
  cdsPedidos             := TUniClientDataSet.Create(Self);
  cdsPedidos.DisableControls;
  lstTextoNF             := TStringList.Create;
  lstTextoINF            := TStringList.Create;
  lstTextoPD             := TStringList.Create;
  lstTextoIPD            := TStringList.Create;
  lstTextoTAB            := TStringList.Create;
  lstTextoCat            := TStringList.Create;
end;

procedure TfrmTxtACACIAServerExpAndroid.FormShow(Sender: TObject);
begin
  inherited;
  dirPathExp.edtDirectory.text := fCfgSis('EXPACA');
  If (blnGeracaoAut) Then
  Begin
    If (fEmptyStr(dirPathExp.edtDirectory.text)) Then
      dirPathExp.edtDirectory.text := 'C:\ACACIA\';
  End;
  strPathExp := dirPathExp.edtDirectory.text;
end;

function TfrmTxtACACIAServerExpAndroid.fRetNroParcela(
  strParcel: String): String;
begin
       If strParcel = 'A' Then Result := '01'
  Else If strParcel = 'B' Then Result := '02'
  Else If strParcel = 'C' Then Result := '03'
  Else If strParcel = 'D' Then Result := '04'
  Else If strParcel = 'E' Then Result := '05'
  Else If strParcel = 'F' Then Result := '06'
  Else If strParcel = 'G' Then Result := '07'
  Else If strParcel = 'H' Then Result := '08'
  Else If strParcel = 'I' Then Result := '09'
  Else If strParcel = 'J' Then Result := '10'
  Else If strParcel = 'K' Then Result := '11'
  Else If strParcel = 'L' Then Result := '12';
end;
function TfrmTxtACACIAServerExpAndroid.fRetTipDocumento(
  strEspDoc: String): String;
begin
  If (strEspDoc = 'NF') Then
    Result := '01'
  Else If (strEspDoc = 'IF') Then
    Result := '02'
  Else If (strEspDoc = 'MI') Then
    Result := '03'
  Else If (strEspDoc = 'FF') Then
    Result := '04'
  Else If (strEspDoc = 'TR') Then
    Result := '05'
  Else If (strEspDoc = 'DV') Then
    Result := '06'
  Else If (strEspDoc = 'BR') Then
    Result := '07'
  Else If (strEspDoc = 'PD') Then
    Result := '08'
  Else If (strEspDoc = 'D1') Then
    Result := '09'
  Else
    Result := '00';
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_CAMPANHAS;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_CAMPANHAS	:= 'CAMPANHA' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_CAMPANHAS);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_CAMPFLEX;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_CAMPFLEX := 'CAMPFLEX' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_CAMPFLEX);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_CONFIGMARGEM;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_CONFIGMARGEM := 'CONFIGMARGEM' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;

  strLinha := fPadL(AnsiReplaceStr(FormatFloat('##0.00', fCfgSis('MMDNV1', varDouble)), ',', '.'), 14, '0') + '|' +
              fPadL(AnsiReplaceStr(FormatFloat('##0.00', fCfgSis('MMDN1S', varDouble)), ',', '.'), 14, '0') + '|' +
              fPadL(AnsiReplaceStr(FormatFloat('##0.00', fCfgSis('MMDNV2', varDouble)), ',', '.'), 14, '0') + '|' +
              fPadL(AnsiReplaceStr(FormatFloat('##0.00', fCfgSis('MMDN2S', varDouble)), ',', '.'), 14, '0') + '|';

  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_CONFIGMARGEM);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_DESCPRODUTO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_DESCPRODUTO	:= 'DESCPRODUTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_DESCPRODUTO);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_FILTROPRODUTO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_FILTROPRODUTO := 'FILTROPROD' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_FILTROPRODUTO);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_MARCAVEND;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_MARCAVEND := 'MARCAVEND' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_MARCAVEND);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_SIMILARIDADES;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_SIMILARIDADES := 'SIMILARIDADE' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_SIMILARIDADES);
end;

procedure TfrmTxtACACIAServerExpAndroid.TESP_TIPOFORMA;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTESP_TIPOFORMA	:= 'TIPOFORMA' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTESP_TIPOFORMA);
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_CALLCENTER;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTE_CALLCENTER := 'CALLCENTER' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTE_CALLCENTER);
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_CLIENTE;
Var
  intQtdReg  : Integer;
  strSQL     : String;
  strLimCre  : String;
  strLimDis  : String;
  strCodCond : String;
  strLinhaCli: String;
  lstTextoCli: TStringList;
  strLinhaCV : String;
  lstTextoCV : TStringList;
  strLinhaCon: String;
  lstTextoCon: TStringList;
  strLinhaLim: String;
  lstTextoLim: TStringList;
  strLinhaEnd: String;
  lstTextoEnd: TStringList;

  cdsLimCre: TUniClientDataSet;

  function fRetLimiteCreditoDisp(strCodCli: String; fltLimCre: Double): Double;
  Begin
    With cdsLimCre Do
    Begin
      Filter   := 'CODCLI = ' + QuotedStr(strCodCli);
      Filtered := True;

      Result := (fltLimCre - FieldByName('TOTAL').AsFloat);

      Filter   := '';
      Filtered := False;
    End;
  End;

begin
  Try
    lblClient.Font.Style  := [fsBold];
    strTE_CLIENTE	        := 'CLIENTES'        + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_NOTAFISCAL	    := 'NOTAFISCAL'      + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_NOTAFISCALITEM  := 'ITENSNOTAFISCAL' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_HISTPEDIDO	    := 'HISTPEDIDO'      + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_HISTPEDIDOITEM  := 'HISTPEDITENS'    + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTR_CLIENTEVENDEDOR := 'CLIENTVEND'      + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strT_CONTATO	        := 'CONTATOS'        + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_LIMITECREDCLI	  := 'LIMITECLIENTE'   + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_ENDENTREGA	    := 'ENDCLIENTES'     + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                                       ';
    strSQL := strSQL + '   CLI_CODCLI AS CODCLI,                                                      ';
    strSQL := strSQL + '   CLI_NOMCLI AS NOMCLI,                                                      ';
    strSQL := strSQL + '   CLI_C_G_C_ AS C_G_C_,                                                      ';
    strSQL := strSQL + '   CLI_I_E_S_ AS I_E_S_,                                                      ';
    strSQL := strSQL + '   CONCAT(CLI_ENDERE," ", IFNULL(CLI_ENDNUM,""))                   AS ENDERE, ';
    strSQL := strSQL + '   C1.CID_CODCID AS CODCID,                                         ';
    strSQL := strSQL + '   C1.CID_ESTADO AS ESTADO,                                                   ';
    strSQL := strSQL + '   CLI_BAIRRO AS BAIRRO,                                                      ';
    strSQL := strSQL + '   CLI_FONE01 AS FONE01,                                                      ';
    strSQL := strSQL + '   CLI_F_A_X_ AS F_A_X_,                                                      ';
    strSQL := strSQL + '   CLI_C_E_P_ AS C_E_P_,                                                      ';
    strSQL := strSQL + '   IF(CLI_STATUS = "I", "002", "001")                              AS STATUS, ';
    strSQL := strSQL + '   CLI_FANSOB AS FANSOB,                                                      ';
    strSQL := strSQL + '   CLI_DTACAD AS DTACAD,                                                      ';
    strSQL := strSQL + '   CLI_CODATI AS CODATI,                                                      ';
    strSQL := strSQL + '   CLI_ULTCOM AS ULTCOM,                                                      ';
    strSQL := strSQL + fRetSQLCliCnd('CLI_CODCLI', True) + '                               AS CODCND, ';
    strSQL := strSQL + '   CONCAT(CLI_OBS_01," ",CLI_OBS_02," ",CLI_OBS_03," ",CLI_OBS_04) AS OBSERV, ';
    strSQL := strSQL + '   CLI_EMAIL_ AS EMAIL_,                                                      ';
    strSQL := strSQL + '   CLI_CODVEN AS CODVEN,                                                      ';
    strSQL := strSQL + '   CLI_CONTAT AS CONTAT,                                                      ';
    strSQL := strSQL + '   CLI_LIMCRE AS LIMCRE,                                                      ';
    strSQL := strSQL + '   ETC_ENDENT AS ENDENT,                                                      ';
    strSQL := strSQL + '   ETC_BAIENT AS BAIENT,                                                      ';
    strSQL := strSQL + '   ETC_CEPENT AS CEPENT,                                                      ';
    strSQL := strSQL + '   C2.CID_NOMCID AS CIDENT,                                                   ';
    strSQL := strSQL + '   CLI_ENDCOB AS ENDCOB,                                                      ';
    strSQL := strSQL + '   CLI_BAICOB AS BAICOB,                                                      ';
    strSQL := strSQL + '   CLI_CEPCOB AS CEPCOB,                                                      ';
    strSQL := strSQL + '   C3.CID_NOMCID AS CIDCOB,                                                   ';
    strSQL := strSQL + fRetSQLCliCnd('CLI_CODCLI', False) + '                              AS CNDPAG, ';
    strSQL := strSQL + '   CONCAT("00",CLI_TABPRE)                                         AS TABPRE  ';
    strSQL := strSQL + ' FROM                                                                         ';
    strSQL := strSQL + '   CADCLI                                                                     ';
    strSQL := strSQL + '   LEFT JOIN ENTCLI ON ETC_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '                       ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI) ';
    strSQL := strSQL + '   LEFT JOIN CADCID C1 ON (CLI_CODCID = C1.CID_CODCID)                        ';
    strSQL := strSQL + '   LEFT JOIN CADCID C2 ON (ETC_CIDENT = C2.CID_CODCID)                        ';
    strSQL := strSQL + '   LEFT JOIN CADCID C3 ON (CLI_CIDCOB = C3.CID_CODCID)                        ';
    strSQL := strSQL + ' WHERE                                                                        ';
    strSQL := strSQL + '   CLI_CODCLI IS NOT NULL AND CLI_CODCLI <> ""                                ';

    With qryClientes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspClientes.DataSet := qryClientes;
    cdsClientes.Close;
    cdsClientes.SetProvider(dspClientes);
    cdsClientes.Open;
    With cdsClientes Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTextoCli      := TStringList.Create;
        lstTextoNF       := TStringList.Create;
        lstTextoINF      := TStringList.Create;
        lstTextoCV       := TStringList.Create;
        lstTextoLim      := TStringList.Create;
        lstTextoCon      := TStringList.Create;
        lstTextoEnd      := TStringList.Create;

        lstTextoEnd.Sorted := True;
        lstTextoEnd.Duplicates := dupIgnore;

        lstTextoCon.Sorted := True;
        lstTextoCon.Duplicates := dupIgnore;

        cdsLimCre := fCriaClientDataSetClientesDebitos;

        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          If ((RecordCount mod 100) = 0) Then
            Application.ProcessMessages;

          strCodCond := fPadL(FieldByName('CODCND').AsString, 5, IIF(fEmptyStr(FieldByName('CODCND').AsString), ' ', '0'));            

          strLinhaCli := fPadR(FieldByName('CODCLI').AsString,                020)                         + '|' +  // código do cliente
                         fPadR(FieldByName('NOMCLI').AsString,                100)                         + '|' +  // razão social
                         fPadR(FieldByName('C_G_C_').AsString,                020)                         + '|' +  // cgc
                         fPadR(FieldByName('I_E_S_').AsString,                020)                         + '|' +  // ies
                         fPadR(FieldByName('ENDERE').AsString,                100)                         + '|' +  // endereco
                         fPadR(FieldByName('CODCID').AsString,                100)                         + '|' +  // código da cidade
                         fPadR(FieldByName('ESTADO').AsString,                050)                         + '|' +  // estado
                         fPadR(FieldByName('BAIRRO').AsString,                080)                         + '|' +  // bairro
                         fPadR(FieldByName('FONE01').AsString,                020)                         + '|' +  // telefone
                         fPadR(FieldByName('F_A_X_').AsString,                020)                         + '|' +  // fax
                         fPadR(FieldByName('C_E_P_').AsString,                010)                         + '|' +  // cep
                         fPadR(FieldByName('STATUS').AsString,                010)                         + '|' +  // Status - A-ativo, I-inativo, B-bloqueado
                         fPadR(FieldByName('FANSOB').AsString,                050)                         + '|' +  // nome fantasia
                         '001'                                                                             + '|' +  // % desconto suframa
                         FormatDateTime('ddMMyyyy',FieldByName('DTACAD').AsDateTime)                       + '|' +  // data cadastro
                         fPadR(' ',                                           010)                         + '|' +  // cód. endereco entrega
                         fPadR(' ',                                           010)                         + '|' +  // cód. regional
                         '001       '                                                                      + '|' +  // cód. região
                         fPadR(' ',                                           003)                         + '|' +  // condicao entrega
                         fPadR(FieldByName('CODATI').AsString,                010)                         + '|' +  // cód. atividade
                         fPadR(' ',                                           010)                         + '|' +  // cód. sub-atividade
                         fPadR(' ',                                           010)                         + '|' +  // cód. checkout
                         fPadR(FieldByName('TABPRE').AsString,                010)                         + '|' +  // tabela preco
                         FormatDateTime('ddMMyyyy',FieldByName('ULTCOM').AsDateTime)                       + '|' +  // data ultima visita
                         FormatDateTime('ddMMyyyy',FieldByName('ULTCOM').AsDateTime)                       + '|' +  // data ultima compra
                         fPadR(' ',                                           010)                         + '|' +  // cód. forma pagto
                         fPadR(strCodCond,                                    010)                         + '|' +  // cód. condicao pagto
                         fPadR(FieldByName('CODCLI').AsString,                020)                         + '|' +  // código cliente pai
                         fPadR(' ',                                           200)                         + '|' +  // obs fech. faturamento
                         fPadR(FieldByName('OBSERV').AsString,                200)                         + '|' +  // obs cliente
                         fPadR(' ',                                           001)                         + '|' +  // cód. pedido permitido
                         fPadR(fCfgSis('CODACA'),                             010)                         + '|' +  // codigo empresa na ACACIA
                         fPadR(FieldByName('EMAIL_').AsString,                100)                         + '|' +  // e_mail
                         fPadL(FloatToStr(Round(fCalcMediaPagto(FieldByName('CNDPAG').AsString))), 2, '0') + '|' +  // prazo médio
                         '        '                                                                        + '|' +  // data anivers. cliente
                         '        '                                                                        + '|' +  // data jornal cliente
                         fPadR('S',                                           100)                         + '|';   // flag atualiza
          lstTextoCli.Add(strLinhaCli);

          strLinhaCV := fPadR(FieldByName('CODCLI').AsString, 20) + '|' + // codigo do cliente
                        fPadR(FieldByName('CODVEN').AsString, 10) + '|';  // código do vendedor
          lstTextoCV.Add(strLinhaCV);

          If (Not fEmptyStr(FieldByName('CONTAT').AsString)) Then
          Begin
            strLinhaCon := fPadR(FieldByName('CODCLI').AsString, 020) + '|' + // codigo do cliente
                           fPadR(FieldByName('CONTAT').AsString, 080) + '|' + // contato
                           fPadR(' ',                            050) + '|' + // hobby
                           fPadR(' ',                            050) + '|' + // clube
                           fPadR(' ',                            020) + '|' + // telefone
                           fPadR(' ',                            005) + '|' + // aniversario
                           fPadR(' ',                            050) + '|' + // cargo
                           fPadR(' ',                            250) + '|' + // e-mail
                           fPadR(fCfgSis('CODACA'),              010) + '|' + // codigo empresa na ACACIA
                           fPadR(FieldByName('CODVEN').AsString, 010) + '|';  // código do vendedor
            lstTextoCon.Add(strLinhaCon);
          End;

          strLimCre   := AnsiReplaceStr(FormatFloat('##0.00', FieldByName('LIMCRE').AsFloat),',','.');
          strLimDis   := AnsiReplaceStr(FormatFloat('##0.00', fRetLimiteCreditoDisp(FieldByName('CODCLI').AsString, FieldByName('LIMCRE').AsFloat)),',','.');

          strLinhaLim := fPadR(FieldByName('CODCLI').AsString,  20) + '|' + // codigo do cliente
                         fPadL(strLimCre,                       14) + '|' + // limite de credito
                         fPadL(strLimDis,                       14) + '|' + // limite de credito disponivel
                         fPadR(fCfgSis('CODACA'),               10) + '|';  // codigo empresa na ACACIA
          lstTextoLim.Add(strLinhaLim);

          If Not fEmptyStr(FieldByName('ENDENT').AsString) Then
          Begin
            strLinhaEnd := fPadR(FieldByName('CODCLI').AsString, 010) + '|' + // codigo do cliente
                           fPadR('001',                          010) + '|' + // código do endereço
                           fPadR(FieldByName('ENDENT').AsString, 100) + '|' + // endereço
                           fPadR(' ',                            050) + '|' + // complemento
                           fPadR(FieldByName('CIDENT').AsString, 100) + '|' + // nome da cidade
                           fPadR(FieldByName('CEPENT').AsString, 010) + '|' + // cep
                           fPadR(FieldByName('BAIENT').AsString, 080) + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),              010) + '|' + // codigo empresa na ACACIA
                           fPadR('E',                            010) + '|' + // tipo do endereco E-entrega, C-cobranca
                           fPadR(FieldByName('FONE01').AsString, 020) + '|' + // telefone
                           '0'                                        + '|' + // coordenada x
                           '0'                                        + '|' + // coordenada y
                           '0'                                        + '|' + // flag padrao
                           fPadR(' ',                            020) + '|' + // numero
                           fPadR(FieldByName('ESTADO').AsString, 050) + '|';  // estado
              lstTextoEnd.Add(strLinhaEnd);
          End

          Else If Not fEmptyStr(FieldByName('ENDERE').AsString) Then
          Begin
            strLinhaEnd := fPadR(FieldByName('CODCLI').AsString, 010) + '|' + // codigo do cliente
                           fPadR('001',                          010) + '|' + // código do endereço
                           fPadR(FieldByName('ENDERE').AsString, 100) + '|' + // endereço
                           fPadR(FieldByName('CODCID').AsString, 100) + '|' + // nome da cidade
                           fPadR(FieldByName('C_E_P_').AsString, 010) + '|' + // cep
                           fPadR(FieldByName('BAIRRO').AsString, 080) + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),              010) + '|' + // codigo empresa na ACACIA
                           fPadR('E',                            010) + '|' + // tipo do endereco E-entrega, C-cobranca
                           fPadR(FieldByName('FONE01').AsString, 020) + '|' + // telefone
                           '0'                                        + '|' + // coordenada x
                           '0'                                        + '|' + // coordenada y
                           '0'                                        + '|' + // flag padrao
                           fPadR(' ',                            020) + '|' + // numero
                           fPadR(FieldByName('ESTADO').AsString, 050) + '|';  // estado
            lstTextoEnd.Add(strLinhaEnd);
          End;

//Tectintas solicitou para enviar somente 1 endereco de entrega          
{         If Not fEmptyStr(FieldByName('ENDCOB').AsString) Then
          Begin
            strLinhaEnd := fPadR(FieldByName('CODCLI').AsString, 010) + '|' + // codigo do cliente
                           fPadR('002',                          010) + '|' + // código do endereço
                           fPadR(FieldByName('ENDCOB').AsString, 100) + '|' + // endereço
                           fPadR(FieldByName('CIDCOB').AsString, 100) + '|' + // nome da cidade
                           fPadR(FieldByName('CEPCOB').AsString, 010) + '|' + // cep
                           fPadR(FieldByName('BAICOB').AsString, 080) + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),              010) + '|' + // codigo empresa na ACACIA
                           fPadR('C',                            010) + '|' + // tipo do endereco E-entrega, C-cobranca
                           fPadR(FieldByName('FONE01').AsString, 020) + '|' + // telefone
                           '0'                                        + '|' + // coordenada x
                           '0'                                        + '|' + // coordenada y
                           '0'                                        + '|' + // flag padrao
                           fPadR(' ',                            020) + '|' + // numero
                           fPadR(FieldByName('ESTADO').AsString, 050) + '|';  // estado
            lstTextoEnd.Add(strLinhaEnd);
          End

          Else If Not fEmptyStr(FieldByName('ENDERE').AsString) Then
          Begin
            strLinhaEnd := fPadR(FieldByName('CODCLI').AsString, 010) + '|' + // codigo do cliente
                           fPadR('002',                          010) + '|' + // código do endereço
                           fPadR(FieldByName('ENDERE').AsString, 100) + '|' + // endereço
                           fPadR(FieldByName('CODCID').AsString, 100) + '|' + // nome da cidade
                           fPadR(FieldByName('C_E_P_').AsString, 010) + '|' + // cep
                           fPadR(FieldByName('BAIRRO').AsString, 080) + '|' + // bairro
                           fPadR(fCfgSis('CODACA'),              010) + '|' + // codigo empresa na ACACIA
                           fPadR('C',                            010) + '|' + // tipo do endereco E-entrega, C-cobranca
                           fPadR(FieldByName('FONE01').AsString, 020) + '|' + // telefone
                           '0'                                        + '|' + // coordenada x
                           '0'                                        + '|' + // coordenada y
                           '0'                                        + '|' + // flag padrao
                           fPadR(' ',                            020) + '|' + // numero
                           fPadR(FieldByName('ESTADO').AsString, 050) + '|';  // estado
            lstTextoEnd.Add(strLinhaEnd);
          End;}

          TE_NOTAFISCAL(FieldByName('CODCLI').AsString);

          TE_HISTPEDIDO(FieldByName('CODCLI').AsString);

          Next;
        End;
        lstTextoCli.SaveToFile(strPathExp + '\' + strTE_CLIENTE);
        lstTextoNF.SaveToFile(strPathExp  + '\' + strTE_NOTAFISCAL);
        lstTextoINF.SaveToFile(strPathExp + '\' + strTE_NOTAFISCALITEM);
        lstTextoPD.SaveToFile(strPathExp  + '\' + strTE_HISTPEDIDO);
        lstTextoIPD.SaveToFile(strPathExp + '\' + strTE_HISTPEDIDOITEM);
        lstTextoCV.SaveToFile(strPathExp  + '\' + strTR_CLIENTEVENDEDOR);
        lstTextoCon.SaveToFile(strPathExp + '\' + strT_CONTATO);
        lstTextoLim.SaveToFile(strPathExp + '\' + strTE_LIMITECREDCLI);
        lstTextoEnd.SaveToFile(strPathExp + '\' + strTE_ENDENTREGA);

        lblClient.Font.Style := [];
        imgClient.Visible    := True;
      End;
    End;
  Finally
    cdsClientes.Close;
    FreeAndNil(cdsLimCre);
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_HISTPEDIDO(strCodCli: String);
Var
  strSQL   : String;
  strQtdIte: String;
  strUnitar: String;
  strDesEsp: String;
  strVlrCon: String;
  strTipPed: String;
  strOriPed: String;
  strCodCnd: String;    
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                           ';
  strSQL := strSQL + '   "FATDOR" AS TABELA,                            ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMDOC,                          ';
  strSQL := strSQL + '   FGO_DTAENT AS DTAENT,                          ';
  strSQL := strSQL + '   FGO_CODCLI AS CODCLI,                          ';
  strSQL := strSQL + '   FGO_CODVEN AS CODVEN,                          ';
  strSQL := strSQL + '   FGO_VLRCON AS VLRCON,                          ';
  strSQL := strSQL + '   CND_CODIGO AS CODCND,                          ';
  strSQL := strSQL + '   FGO_CODFPG AS CODFPG,                          ';
  strSQL := strSQL + '   CND_DESCRI AS DESCND,                          ';
  strSQL := strSQL + '   FPG_DESCRI AS DESFPG,                          ';
  strSQL := strSQL + '   FGO_CONPAG AS CONPAG,                          ';
  strSQL := strSQL + '   FGO_TIPPED AS TIPPED,                          ';
  strSQL := strSQL + '   FGO_NUMPOK AS NUMPOK,                          ';
  strSQL := strSQL + '   IF(FGO_JAFATU = 1, "Faturado", "Aberto") AS TIPFAT, ';
  strSQL := strSQL + '   FATGOR.AUTOINCREM AS AUTINC                    ';
  strSQL := strSQL + ' FROM                                             ';
  strSQL := strSQL + '   FATGOR                                         ';
  strSQL := strSQL + '   LEFT JOIN CADCND ON FGO_CODCND = CND_CODIGO    ';
  strSQL := strSQL + '   LEFT JOIN CADFPG ON FGO_CODFPG = FPG_CODIGO    ';
  strSQL := strSQL + ' WHERE                                            ';
  strSQL := strSQL + '   FGO_CODCLI = :CODCLI                           ';

  If chkFiltraPeriodo.Checked Then
    strSQL := strSQL + ' AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN     ';

  strSQL := strSQL + ' UNION ALL                                        ';

  strSQL := strSQL + ' SELECT                                           ';
  strSQL := strSQL + '   "DEL_FATDOR" AS TABELA,                        ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMDOC,                          ';
  strSQL := strSQL + '   FGO_DTAENT AS DTAENT,                          ';
  strSQL := strSQL + '   FGO_CODCLI AS CODCLI,                          ';
  strSQL := strSQL + '   FGO_CODVEN AS CODVEN,                          ';
  strSQL := strSQL + '   FGO_VLRCON AS VLRCON,                          ';
  strSQL := strSQL + '   CND_CODIGO AS CODCND,                          ';
  strSQL := strSQL + '   FGO_CODFPG AS CODFPG,                          ';
  strSQL := strSQL + '   CND_DESCRI AS DESCND,                          ';
  strSQL := strSQL + '   FPG_DESCRI AS DESFPG,                          ';
  strSQL := strSQL + '   FGO_CONPAG AS CONPAG,                          ';
  strSQL := strSQL + '   FGO_TIPPED AS TIPPED,                          ';
  strSQL := strSQL + '   FGO_NUMPOK AS NUMPOK,                          ';
  strSQL := strSQL + '   "Cancelado" AS TIPFAT, ';
  strSQL := strSQL + '   DEL_FATGOR.AUTOINCREM AS AUTINC                ';
  strSQL := strSQL + ' FROM                                             ';
  strSQL := strSQL + '   DEL_FATGOR                                     ';
  strSQL := strSQL + '   LEFT JOIN CADCND ON FGO_CODCND = CND_CODIGO    ';
  strSQL := strSQL + '   LEFT JOIN CADFPG ON FGO_CODFPG = FPG_CODIGO    ';
  strSQL := strSQL + ' WHERE                                            ';
  strSQL := strSQL + '   FGO_CODCLI = :CODCLI                           ';

  If chkFiltraPeriodo.Checked Then
    strSQL := strSQL + ' AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN     ';

  strSQL := strSQL + ' ORDER BY                                         ';
  strSQL := strSQL + '   DTAENT DESC                                ';

  If not chkFiltraPeriodo.Checked Then
    strSQL := strSQL + ' LIMIT 5                                        ';

  With qryPedidos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;

    If chkFiltraPeriodo.Checked Then
    Begin
      ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtpDtaIni.DateTime);
      ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', dtpDtaFin.DateTime);
    End;
  End;
  dspPedidos.DataSet := qryPedidos;
  cdsPedidos.Close;
  cdsPedidos.SetProvider(dspPedidos);
  cdsPedidos.Open;
  With cdsPedidos Do
  Begin
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      strVlrCon := AnsiReplaceStr(FormatFloat('##0.00',FieldByName('VLRCON').AsFloat),',','.');

      If (FieldByName('TIPPED').AsString = 'B') Then
        strTipPed := '01'
      Else
        strTipPed := '00';

      If Not fEmptyStr(FieldByName('NUMPOK').AsString) Then
        strOriPed := 'ACACIA'
       Else
        strOriPed := 'AUTCOM';

      strCodCnd := fPadL(FieldByName('CODCND').AsString, 5, IIF(fEmptyStr(FieldByName('CODCND').AsString), ' ', '0'));        

      strLinhaPD := '';
      strLinhaPD := fPadR(FieldByName('NUMDOC').AsString,                030)      + '|' + // número do pedido
                    fPadR(FieldByName('NUMPOK').AsString,                030)      + '|' + // número do pedido - pocket
                    fPadR(FieldByName('CODCLI').AsString,                020)      + '|' + // codigo do cliente
                    fPadR(FieldByName('TIPFAT').AsString,                030)      + '|' + // status do pedido
                    fPadL(strVlrCon,                                     014, '0') + '|' + // valor do pedido
                    fPadL(strVlrCon,                                     014, '0') + '|' + // valor do pedido faturado
                    FormatDateTime('ddMMyyyy',FieldByName('DTAENT').AsDateTime)    + '|' + // data emissão
                    FormatDateTime('ddMMyyyy',FieldByName('DTAENT').AsDateTime)    + '|' + // data prevista entrega
                    fPadR(strOriPed,                                     030)      + '|' + // origem do pedido
                    fPadR(strTipPed,                                     010)      + '|' + // código do tipo do pedido
                    fPadR(strCodCnd,                                     010)      + '|' + // código da cond. pagto
                    fPadR(' ',                                           100)      + '|' + // descricao frete
                    fPadR(fCfgSis('CODACA'),                             010)      + '|' + // codigo empresa na ACACIA
                    '0'                                                            + '|' + // número do pedido - afv server
                    '0'                                                            + '|' + // desconto forma pagto
                    FieldByName('CODFPG').AsString                                 + '|' + // código forma pagto
                    '  '                                                           + '|' + // flag status
                    fPadR(FieldByName('CODVEN').AsString,                010)      + '|';  // codigo do vendedor
      lstTextoPD.Add(strLinhaPD);

      strSQL := '';
      strSQL := strSQL + ' SELECT                                           ';
      strSQL := strSQL + '   FDO_NUMDOC AS NUMDOC,                          ';
      strSQL := strSQL + '   CONCAT(RIGHT(GRU_CODGRU,3), FDO_CODITE) AS CODITE, ';
      strSQL := strSQL + '   FDO_QTDITE AS QTDITE,                          ';
      strSQL := strSQL + '   FDO_UNITAR AS UNITAR,                          ';
      strSQL := strSQL + '   FDO_DESESP AS DESESP,                          ';            
      strSQL := strSQL + '   FDO_DESCRI AS DESCRI                           ';
      strSQL := strSQL + ' FROM                                             ';
      strSQL := strSQL + ' ' +cdsPedidos.FieldByName('TABELA').AsString +'  ';
      strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = FDO_CODITE            ';
      strSQL := strSQL + 'JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU            ';
      strSQL := strSQL + ' WHERE                                            ';
      strSQL := strSQL + '   FDO_SEQGER = :AUTINC                           ';
      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := cdsPedidos.FieldByName('AUTINC').AsString;
      End;
      dspGenerica.DataSet := qryGenerica;
      cdsGenerica.Close;
      cdsGenerica.SetProvider(dspGenerica);
      cdsGenerica.Open;
      While Not cdsGenerica.Eof Do
      Begin
        strQtdIte   := AnsiReplaceStr(FormatFloat('##0.00', cdsGenerica.FieldByName('QTDITE').AsFloat), ',', '.');
        strUnitar   := AnsiReplaceStr(FormatFloat('##0.00', cdsGenerica.FieldByName('UNITAR').AsFloat), ',', '.');
        strDesEsp   := AnsiReplaceStr(FormatFloat('##0.00', cdsGenerica.FieldByName('DESESP').AsFloat), ',', '.');
        strLinhaIPD := '';
        strLinhaIPD := fPadR(cdsGenerica.FieldByName('NUMDOC').AsString, 030)      + '|' + // número do pedido
                       fPadR(cdsGenerica.FieldByName('CODITE').AsString, 030)      + '|' + // codigo do item
                       fPadR(cdsGenerica.FieldByName('DESCRI').AsString, 100)      + '|' + // descricao do item
                       fPadL(strQtdIte,                                  014, '0') + '|' + // quant.
                       '0'                                                         + '|' + // quant. bonificada
                       '0'                                                         + '|' + // quant. cortada
                       fPadL(strDesEsp,                                  014, '0') + '|' + // desconto
                       fPadL(strUnitar,                                  014, '0') + '|' + // val. unitario
                       fPadR(' ',                                        010)      + '|' + // condição de pagto
                       fPadR(fCfgSis('CODACA'),                          010)      + '|' + // codigo empresa na ACACIA
                       fPadR(' ',                                        200)      + '|' + // motivo do corte
                       '0'                                                         + '|' + // valor do desconto
                       '0'                                                         + '|' + // total do peso
                       '0'                                                         + '|' + // valor total da comissão
                       '0'                                                         + '|' + // saldo quant. da venda
                       ' '                                                         + '|';  // flag gerar verba
        lstTextoIPD.Add(strLinhaIPD);
        cdsGenerica.Next;
      End;
      Next;
    End;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_KITPRODUTO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTE_KITPRODUTO := 'KITPRODUTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTE_KITPRODUTO);
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_MARCA;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblMarcas.Font.Style := [fsBold];
    strTE_MARCA	         := 'MARCA' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   MAR_CODMAR, ';
    strSQL := strSQL + '   MAR_DESMAR  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADMAR      ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(FieldByName('MAR_CODMAR').AsString, 010) + '|' + // codigo da marca
                      fPadR(FieldByName('MAR_DESMAR').AsString, 100) + '|' + // descricao da marca
                      fPadR(fCfgSis('CODACA'),                  010) + '|';  // codigo empresa na ACACIA
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strTE_MARCA);

        lblMarcas.Font.Style := [];
        imgMarcas.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_METAGERAL;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strTE_METAGERAL	:= 'METGERAIS' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTE_METAGERAL);
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_NOTAFISCAL(strCodCli: String);
Var
  strSQL   : String;
  strQtdIte: String;
  strDesEsp: String;
  strUnitar: String;
  strVlrCon: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                               ';
  strSQL := strSQL + '   MOVGER.AUTOINCREM                    AS AUTINC,    ';
  strSQL := strSQL + '   CONCAT(GER_NUMDOC,"/1")              AS NUMDOC,    ';
  strSQL := strSQL + '   GER_DTAENT AS DTAENT,                              ';
  strSQL := strSQL + '   GER_CODCLI AS CODCLI,                              ';
  strSQL := strSQL + '   GER_VLRCON AS VLRCON,                              ';
  strSQL := strSQL + '   GER_CLAFIS AS CLAFIS,                              ';
  strSQL := strSQL + '   GER_CONPAG AS CONPAG,                              ';
  strSQL := strSQL + '   GER_CODVEN AS CODVEN,                              ';
  strSQL := strSQL + '   IF((LOCATE(GER_CLAFIS, "5910_6910") > 0) OR (GER_ESPDOC = "BR"), "B", IF((LEFT(GER_CLAFIS,1) < 5), "D", "V")) AS TIPNOT, ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMPED                               ';
  strSQL := strSQL + ' FROM                                                 ';
  strSQL := strSQL + '   MOVGER                                             ';
  strSQL := strSQL + '   INNER JOIN FATGOR ON (GER_NUMDOC = FGO_NUMFAT AND  ';
  strSQL := strSQL + '                         GER_ESPDOC = FGO_TIPFAT AND  ';
  strSQL := strSQL + '                         GER_CODEMP = FGO_EMPFAT AND  ';
  strSQL := strSQL + '                         GER_CODCLI = FGO_CODCLI AND  ';
  strSQL := strSQL + '                         FGO_ESPDOC = "PD")           ';
  strSQL := strSQL + ' WHERE                                                ';
  strSQL := strSQL + '   GER_CODCLI = :CODCLI AND GER_ESPDOC IN ("NF","IF","IV","EL","D1") ';
  strSQL := strSQL + ' ORDER BY                                             ';
  strSQL := strSQL + '   GER_DTAENT DESC                                    ';
  strSQL := strSQL + ' LIMIT 5                                              ';
  With qryNotas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
  End;
  dspNotas.DataSet := qryNotas;
  cdsNotas.Close;
  cdsNotas.SetProvider(dspNotas);
  cdsNotas.Open;
  With cdsNotas Do
  Begin
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      strVlrCon  := AnsiReplaceStr(FormatFloat('##0.00',FieldByName('VLRCON').AsFloat),',','.');
      strLinhaNF := fPadR(FieldByName('NUMDOC').AsString, 020)                  + '|' + // número da nota fiscal
                    FormatDateTime('ddMMyyyy',FieldByName('DTAENT').AsDateTime) + '|' + // data emissão
                    fPadR(FieldByName('CODCLI').AsString, 020)                  + '|' + // codigo do cliente
                    fPadL(strVlrCon,                      014, '0')             + '|' + // valor da nota
                    fPadR(FieldByName('TIPNOT').AsString, 030)                  + '|' + // tipo da nota
                    fPadR(FieldByName('NUMPED').AsString, 030)                  + '|' + // número do pedido
                    fPadR(' ',                            100)                  + '|' + // motivo da devolução
                    fPadR(fCfgSis('CODACA'),              010)                  + '|' + // codigo empresa na ACACIA
                    FormatDateTime('ddMMyyyy',FieldByName('DTAENT').AsDateTime) + '|' + // data prevista de entrega
                    FormatDateTime('ddMMyyyy',FieldByName('DTAENT').AsDateTime) + '|' + // data entrega cliente
                    fPadR(FieldByName('CLAFIS').AsString, 020)                  + '|' + // codigo da natureza da operação
                    fPadR(FieldByName('CONPAG').AsString, 010)                  + '|' + // codigo da condição de pagamento
                    fPadR(FieldByName('CODVEN').AsString, 010)                  + '|' + // código do vendedor
                    '0'                                                         + '|' + // número pedido afv server
                    '0'                                                         + '|';  // status cnfe
      lstTextoNF.Add(strLinhaNF);

      strSQL := '';
      strSQL := strSQL + ' SELECT                                               ';
      strSQL := strSQL + '   CONCAT(DET_NUMDOC,"/1") AS NUMDOC,                 ';
      strSQL := strSQL + '   CONCAT(RIGHT(ITE_CODGRU,3), DET_CODITE) AS CODITE, ';
      strSQL := strSQL + '   DET_QTDITE AS QTDITE,                              ';
      strSQL := strSQL + '   DET_DESESP AS DESESP,                              ';
      strSQL := strSQL + '   DET_UNITAR AS UNITAR,                              ';
      strSQL := strSQL + '   DET_DESCRI AS DESCRI,                              ';
      strSQL := strSQL + '   DET_NUM_PD AS NUM_PD                               ';
      strSQL := strSQL + ' FROM                                                 ';
      strSQL := strSQL + '   MOVDET                                             ';
      strSQL := strSQL + ' JOIN CADITE ON ITE_CODITE = DET_CODITE               ';
      strSQL := strSQL + ' WHERE                                                ';
      strSQL := strSQL + '   DET_SEQGER = :SEQGER                               ';
      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := cdsNotas.FieldByName('AUTINC').AsString;
      End;
      dspGenerica.DataSet := qryGenerica;
      cdsGenerica.Close;
      cdsGenerica.SetProvider(dspGenerica);
      cdsGenerica.Open;
      While Not cdsGenerica.Eof Do
      Begin
        If Not fEmptyStr(cdsGenerica.FieldByName('NUM_PD').AsString) Then
        Begin
          strQtdIte   := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.FieldByName('QTDITE').AsFloat),',','.');
          strDesEsp   := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.FieldByName('DESESP').AsFloat),',','.');
          strUnitar   := AnsiReplaceStr(FormatFloat('##0.00',cdsGenerica.FieldByName('UNITAR').AsFloat),',','.');
          strLinhaINF := '';
          strLinhaINF := fPadR(cdsGenerica.FieldByName('NUMDOC').AsString, 020)      + '|' + // número da nota fiscal
                         fPadR(cdsGenerica.FieldByName('NUM_PD').AsString, 030)      + '|' + // número do pedido
                         fPadR(cdsGenerica.FieldByName('CODITE').AsString, 030)      + '|' + // codigo do item
                         fPadL(strQtdIte,                                  014, '0') + '|' + // quant.
                         fPadL(strDesEsp,                                  014, '0') + '|' + // desc. especial
                         fPadL(strUnitar,                                  014, '0') + '|' + // val. unitario
                         fPadR(cdsGenerica.FieldByName('DESCRI').AsString, 100)      + '|' + // descricao do item
                         '1'                                                         + '|';  // flag gera verba
          lstTextoINF.Add(strLinhaINF);
        End;
        cdsGenerica.Next;
      End;
      Next;
    End;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_PRODUTO;
Var
  strSQL    : String;
  strLinha  : String;
  strPesoIt : String;
  strPesLiq : String;
  strPreVen : String;
  strPreVe2 : String;
  strPreVe3 : String;
  strPreVe4 : String;
  strPreVe5 : String;
  strPreVe6 : String;
  strPreVe7 : String;
  strSaldos : String;
  strIpiSai : String;
  strPreCus : String;
  strPreMin : String;
  strPreMi2 : String;
  strPreMi3 : String;
  strPreMi4 : String;
  strPreMi5 : String;
  strPreMi6 : String;
  strPreMi7 : String;
  strDesMax : String;
  strMltVen : String;
  strOutVal : String;
  strIcmSai : String;
  strImpFed : String;
  strDesOpe : String;
  strMarMin : String;
  intQtdReg : Integer;
  lstTexto  : TStringList;

  function fPrecoPromocaoItem(strItem: String): Double;
  begin
    Result := 0;

    If (qryItensPromocao.FieldByName('CODITE').AsString = strItem) Or
       (qryItensPromocao.Locate('CODITE', strItem, []))            Then
    Begin
      Result := qryItensPromocao.fieldbyname('PREVEN').AsFloat;
    End;

  end;

begin
  Try
    lblProdut.Font.Style := [fsBold];
    lblTabPre.Font.Style := [fsBold];
    strTE_PRODUTO	       := 'PRODUTOS'  + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strTE_TABELAPRECO    := 'TABPRECO'  + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    strT_CATEGORIA	     := 'CATEGORIA' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                                       ';
    strSQL := strSQL + '   CONCAT(RIGHT(C.ITE_CODGRU,3), C.ITE_CODITE)                     AS CODITE, ';
    strSQL := strSQL + '   C.ITE_CODFOR AS CODFOR,                                                    ';
    strSQL := strSQL + '   C.ITE_CODGRU AS CODGRU,                                                    ';
    strSQL := strSQL + '   RIGHT(C.ITE_CODITE,'+IntToStr(fTamCodIte)+')                    AS CODRED, ';
    strSQL := strSQL + '   C.ITE_DESITE AS DESITE,                                                    ';
    strSQL := strSQL + '   C.ITE_CODMAR AS CODMAR,                                                    ';
    strSQL := strSQL + '   IF(C.ITE_ITEATI = "S", "001", "002")                            AS ITEATI, ';
    strSQL := strSQL + '   IF(C.ITE_ITEATI = "S", "1", "0")                                AS FLAGUSO,';
    strSQL := strSQL + '   C.ITE_CODBAR AS CODBAR,                                                    ';
    strSQL := strSQL + '   C.ITE_PESOIT AS PESOIT,                                                    ';
    strSQL := strSQL + '   C.ITE_PESLIQ AS PESLIQ,                                                    ';
    strSQL := strSQL + '   (SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = C.ITE_CODUNI) AS CODUNI, ';
    strSQL := strSQL + '   I.ITE_PREVE1 AS PREVEN,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE2 AS PREVE2,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE3 AS PREVE3,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE4 AS PREVE4,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE5 AS PREVE5,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE6 AS PREVE6,                                                    ';
    strSQL := strSQL + '   I.ITE_PREVE7 AS PREVE7,                                                    ';
    strSQL := strSQL + '   I.ITE_SALDOS AS SALDOS,                                                    ';
    strSQL := strSQL + '   I.ITE_IPISAI AS IPISAI,                                                    ';
    strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS,                                                    ';
    strSQL := strSQL + '   I.ITE_DESMAX AS DESMAX,                                                    ';
    strSQL := strSQL + '   (I.ITE_PREVE1 - ((I.ITE_PREVE1 * I.ITE_DESMAX) /100))           AS PREMIN, ';
    strSQL := strSQL + '   (I.ITE_PREVE2 - ((I.ITE_PREVE2 * I.ITE_DESMAX) /100))           AS PREMI2, ';
    strSQL := strSQL + '   (I.ITE_PREVE3 - ((I.ITE_PREVE3 * I.ITE_DESMAX) /100))           AS PREMI3, ';
    strSQL := strSQL + '   (I.ITE_PREVE4 - ((I.ITE_PREVE4 * I.ITE_DESMAX) /100))           AS PREMI4, ';
    strSQL := strSQL + '   (I.ITE_PREVE5 - ((I.ITE_PREVE5 * I.ITE_DESMAX) /100))           AS PREMI5, ';
    strSQL := strSQL + '   (I.ITE_PREVE6 - ((I.ITE_PREVE6 * I.ITE_DESMAX) /100))           AS PREMI6, ';
    strSQL := strSQL + '   (I.ITE_PREVE7 - ((I.ITE_PREVE7 * I.ITE_DESMAX) /100))           AS PREMI7, ';
    strSQL := strSQL + '   ITE_MLTVEN                                                      AS MLTVEN, ';
    strSQL := strSQL + '   I.ITE_OUTVAL AS OUTVAL,                                                    ';
    strSQL := strSQL + '   I.ITE_ICMSAI AS ICMSAI,                                                    ';
    strSQL := strSQL + '   I.ITE_IMPFED AS IMPFED,                                                    ';
    strSQL := strSQL + '   I.ITE_DESOPE AS DESOPE,                                                    ';
    strSQL := strSQL + '   I.ITE_MARMIN AS MARMIN                                                     ';
    strSQL := strSQL + ' FROM                                                                         ';
    strSQL := strSQL + '   CADITE C                                                                   ';
    strSQL := strSQL + '   JOIN ITEGER I ON (I.ITE_CODITE = C.ITE_CODITE AND                          ';
    strSQL := strSQL + '                     I.ITE_CODEMP = :CODEMP)                                  ';
    With qryProdutos Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;
    dspProdutos.DataSet := qryProdutos;
    cdsProdutos.Close;
    cdsProdutos.SetProvider(dspProdutos);
    cdsProdutos.Open;
    With cdsProdutos Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          If ((RecordCount mod 100) = 0) Then
            Application.ProcessMessages;

          strPesoIt := AnsiReplaceStr(FormatFloat('##0.000', FieldByName('PESOIT').AsFloat),',','.');
          strPesLiq := AnsiReplaceStr(FormatFloat('##0.000', FieldByName('PESLIQ').AsFloat),',','.');

          strPreVen := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVEN').AsFloat),',','.');
          strPreVe2 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE2').AsFloat),',','.');
          strPreVe3 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE3').AsFloat),',','.');
          strPreVe4 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE4').AsFloat),',','.');
          strPreVe5 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE5').AsFloat),',','.');
          strPreVe6 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE6').AsFloat),',','.');
          strPreVe7 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREVE7').AsFloat),',','.');
          strDesMax := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('DESMAX').AsFloat),',','.');

          strSaldos := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('SALDOS').AsFloat),',','.');
          strIpiSai := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('IPISAI').AsFloat),',','.');
          strPreCus := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PRECUS').AsFloat),',','.');
          strPreMin := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMIN').AsFloat),',','.');
          strPreMi2 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI2').AsFloat),',','.');
          strPreMi3 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI3').AsFloat),',','.');
          strPreMi4 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI4').AsFloat),',','.');
          strPreMi5 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI5').AsFloat),',','.');
          strPreMi6 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI6').AsFloat),',','.');
          strPreMi7 := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('PREMI7').AsFloat),',','.');
          strMltVen := AnsiReplaceStr(FormatFloat('##0.0000',FieldByName('MLTVEN').AsFloat),',','.');

          strOutVal := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('OUTVAL').AsFloat),',','.');
          strIcmSai := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('ICMSAI').AsFloat),',','.');
          strImpFed := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('IMPFED').AsFloat),',','.');
          strDesOpe := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('DESOPE').AsFloat),',','.');
          strMarMin := AnsiReplaceStr(FormatFloat('##0.00',  FieldByName('MARMIN').AsFloat),',','.');

          If fPrecoPromocaoItem(fieldbyname('CODRED').AsString) > 0 Then
          Begin
            strPreMin := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi2 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi3 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi4 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi5 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi6 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreMi7 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');

            strPreVen := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe2 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe3 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe4 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe5 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe6 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');
            strPreVe7 := AnsiReplaceStr(FormatFloat('##0.00', fPrecoPromocaoItem(fieldbyname('CODRED').AsString)),',','.');

            strDesMax := AnsiReplaceStr(FormatFloat('##0.00',  0.00),',','.');
          End;

          strLinha := fPadR(FieldByName('CODITE').AsString,                  030)      + '|' +  // código do produto
                      fPadR(FieldByName('CODFOR').AsString,                  010)      + '|' +  // código da categoria
                      fPadR(FieldByName('CODMAR').AsString,                  010)      + '|' +  // código da marca/fornecedor
                      fPadR(FieldByName('CODGRU').AsString,                  010)      + '|' +  // código do grupo/familia
                      fPadR(FieldByName('DESITE').AsString,                  100)      + '|' +  // descrição
                      fPadR(FieldByName('ITEATI').AsString,                  010)      + '|' +  // status 001-ativo, 002-inativo
                      fPadR(' ',                                             050)      + '|' +  // DUN-14
                      fPadR(FieldByName('CODBAR').AsString,                  050)      + '|' +  // código barra - EAN-13
                      fPadL(strPesoIt,                                       012, '0') + '|' +  // peso bruto
                      fPadL('1',                                             010, '0') + '|' +  // qtde embalagem
                      fPadR(fPadL('1',6,'0'),                                030)      + '|' +  // volume
                      fPadR(' ',                                             200)      + '|' +  // observações
                      fPadR(FieldByName('CODUNI').AsString,                  030)      + '|' +  // unidade produto
                      '0'                                                              + '|' +  // % desconto flex.
                      fPadR(' ',                                             030)      + '|' +  // tempo validade
                      fPadL(strPreVen,                                       014, '0') + '|' +  // preço produto
                      '0'                                                              + '|' +  // % desconto maximo permitido
                      '0'                                                              + '|' +  // % máximo de acrescimo
                      '0'                                                              + '|' +  // % de comissão
                      '0'                                                              + '|' +  // flag de valor fixo
                      fPadL(strSaldos,                                       014, '0') + '|' +  // qtde estoque
                      fPadR(' ',                                             010)      + '|' +  // flag sit. especial P-promocao/L-lancamento
                      fPadL(strIpiSai,                                       014, '0') + '|' +  // % IPI
                      fPadL(strPesLiq,                                       014, '0') + '|' +  // peso liquido
                      fPadR(fCfgSis('CODACA'),                               010)      + '|' +  // código empresa na ACACIA
                      FieldByName('FLAGUSO').AsString                                  + '|' +  // flag uso afv
                      fPadL(strPreCus,                                       014, '0') + '|' +  // preço custo
                      fPadL(strPreMin,                                       014, '0') + '|' +  // preço mínimo
                      fPadR(FieldByName('CODRED').AsString,                  030)      + '|' +  // código do produto reduzido
                      fPadL(strMltVen,                                       014, '0') + '|';   // multiplo

          lstTexto.Add(strLinha);

          If (VS_strTabVen[1] = 'S') And (FieldByName('PREVEN').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '001'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVen,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMin,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[2] = 'S') And (FieldByName('PREVE2').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '002'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe2,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi2,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[3] = 'S') And (FieldByName('PREVE3').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '003'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe3,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi3,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[4] = 'S') And (FieldByName('PREVE4').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '004'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe4,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi4,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[5] = 'S') And (FieldByName('PREVE5').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '005'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe5,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi5,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[6] = 'S') And (FieldByName('PREVE6').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '006'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe6,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi6,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          If (VS_strTabVen[7] = 'S') And (FieldByName('PREVE7').AsFloat > 0) Then
          Begin
            strLinhaTAB := '';
            strLinhaTAB := '007'                                          + '|' + // código da tabela
                           fPadR(fCfgSis('CODACA'),              10)      + '|' + // codigo empresa na ACACIA
                           fPadR(' ',                            10)      + '|' + // código da região
                           fPadR(' ',                            10)      + '|' + // código do canal/ramo de atividade
                           fPadR(' ',                            50)      + '|' + // chave da busca
                           fPadR(FieldByName('CODITE').AsString, 30)      + '|' + // código do produto
                           fPadR(' ',                            10)      + '|' + // código da embalagem
                           fPadL(strPreVe7,                      14, '0') + '|' + // preço
                           fPadL(strDesMax,                      14, '0') + '|' + // % de desconto permitido
                           '00000000000.00'                               + '|' + // % de desconto flex
                           fPadR(' ',                            08)      + '|' + // data inicial da validade
                           fPadR(' ',                            08)      + '|' + // data final da validade
                           fPadL(strPreMi7,                      14, '0') + '|' + // preço mínimo
                           fPadL(strPreCus,                      14, '0') + '|' + // preço custo
                           fPadL(strOutVal,                      14, '0') + '|' + // boca caixa
                           fPadL(strIcmSai,                      14, '0') + '|' + // ICMS de saída
                           fPadL(strImpFed,                      14, '0') + '|' + // impostos federais
                           fPadL(strDesOpe,                      14, '0') + '|' + // despesas operacionais
                           fPadL(strMarMin,                      14, '0') + '|' + // margem mínima
                           fPadR(' ',                            10)      + '|';  // código do vendedor
            lstTextoTAB.Add(strLinhaTAB);
          End;
          T_CATEGORIA(FieldByName('CODFOR').AsString);
          
          Next;
        End;
        lstTexto.SaveToFile(strPathExp    + '\' + strTE_PRODUTO);
        lstTextoTAB.SaveToFile(strPathExp + '\' + strTE_TABELAPRECO);
        lstTextoCat.SaveToFile(strPathExp + '\' + strT_CATEGORIA);

        lblProdut.Font.Style := [];
        lblTabPre.Font.Style := [];
        imgProdut.Visible    := True;
        imgTabPre.Visible    := True;
      End;
    End;
  Finally
    cdsProdutos.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_PRODUTOUNIDFAT;
Var
  strLinha,
  strEmp : String;
  lstTexto : TStringList;
  qryProdutoUnidade: TUniQuery;
  strEmpresas: TStringDynArray;
  i: Integer;
begin
  try
    qryProdutoUnidade := fCriaQuery(Self);

    strTE_PRODUTOUNIDFAT := 'PRODUTOUNIDADE' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';
    lstTexto := TStringList.Create;
    strLinha := '';

    strEmpresas := SplitString(fTransform(fCfgSis('EMPACA'), 3, '/'), '/');
    strEmp := '';

    for i := Low(strEmpresas) to High(strEmpresas) - 1 do
    begin
      if i < High(strEmpresas) - 1 then
        strEmp := strEmp + QuotedStr(strEmpresas[i]) +','
      else
        strEmp := strEmp + QuotedStr(strEmpresas[i]);
    end;

    with qryProdutoUnidade, SQL do
    begin
      Close;
      Clear;
      Append(' SELECT ');
      Append('   CODITE, ');
      Append('   CODUNI, ');
      Append('   CODEMP, ');
      Append('   SALDO_ESTOQUE - ( ');
      Append('     SALDO_RESERVADO + SALDO_GARANTIA + SALDO_SITE ');
      Append('   ) AS SALDO_DISPONIVEL ');
      Append(' FROM ');
      Append('   (SELECT ');
      Append('     G.ITE_CODEMP, ');
      Append('     G.ITE_CODEMP AS CODEMP, ');
      Append('     (SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = I.ITE_CODUNI) AS CODUNI, ');
      Append('     G.ITE_CODITE, ');
      Append('     CONCAT(RIGHT(I.ITE_CODGRU,3), I.ITE_CODITE) AS CODITE, ');
      Append('     G.ITE_SALDOS AS SALDO_ESTOQUE, ');
      Append('     IFNULL( ');
      Append('       (SELECT ');
      Append('         SUM( ');
      Append('           IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0) ');
      Append('         ) ');
      Append('       FROM ');
      Append('         FATDOR ');
      Append('       WHERE FDO_CODITE = G.ITE_CODITE ');
      Append('         AND FDO_CODEMP = G.ITE_CODEMP ');
      Append('         AND FDO_JAFATU = 0 ');
      Append('         AND FDO_ESPDOC = "PD" ');
      Append('       GROUP BY FDO_CODITE), ');
      Append('       0 ');
      Append('     ) AS SALDO_RESERVADO, ');
      Append('     IFNULL( ');
      Append('       (SELECT ');
      Append('         SUM(IFNULL(GAD_QTDREQ, 0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) ) AS SALREG ');
      Append('       FROM ');
      Append('         MOVGAG G ');
      Append('         INNER JOIN MOVGAD D ');
      Append('           ON G.AUTOINCREM = D.GAD_SEQGAG ');
      Append('       WHERE GAD_CODITE = G.ITE_CODITE ');
      Append('         AND GAG_CODEMP = G.ITE_CODEMP ');
      Append('       GROUP BY GAD_CODITE HAVING SALREG > 0), ');
      Append('       0 ');
      Append('     ) AS SALDO_GARANTIA, ');
      Append('     IFNULL( ');
      Append('       (SELECT ');
      Append('         SUM(IFNULL(FSITENS.QTDEVENDA, 0)) ');
      Append('       FROM ');
      Append('         FSPEDIDOCAB FSCAB ');
      Append('         INNER JOIN FSPEDIDOITENS FSITENS ');
      Append('           ON FSCAB.NUMEROPEDIDO = FSITENS.NUMEROPEDIDO ');
      Append('       WHERE FSCAB.IMPORTADO <> "S" ');
      Append('         AND FSITENS.CODIGOPRODUTO = I.ITE_CODITE ');
      Append('       GROUP BY FSITENS.CODIGOPRODUTO), ');
      Append('       0 ');
      Append('     ) AS SALDO_SITE ');
      Append('   FROM ');
      Append('     CADITE I ');
      Append('     INNER JOIN ITEGER G ');
      Append('       ON G.ITE_CODITE = I.ITE_CODITE ');
      Append('       AND G.ITE_CODEMP IN (' +strEmp +') ');
      Append('     GROUP BY ITE_CODITE, ');
      Append('     ITE_CODEMP) TMP; ');

      Open;

      while not Eof do
      begin
        strLinha :=
          fPadR(FieldByName('CODITE').AsString, 30) + '|' +
          fPadR(FieldByName('CODUNI').AsString, 10) + '|' + //?? Checar tamanho (PRODUTOS = 30, Layout = 10)
          fPadR(FieldByName('CODEMP').AsString, 10) + '|' +
          fPadL(AnsiReplaceStr(FormatFloat('##0.00',
            IIF(FieldByName('SALDO_DISPONIVEL').AsFloat > 0, FieldByName('SALDO_DISPONIVEL').AsFloat, 0)
          ),',','.'), 014, '0') + '|';

        lstTexto.Add(strLinha);

        Next;
      end;
    end;

    lstTexto.SaveToFile(strPathExp + '\' + strTE_PRODUTOUNIDFAT);

  finally
    FreeAndNil(qryProdutoUnidade);
  end;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_REGIAO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  lblRegiao.Font.Style := [fsBold];
  strTE_REGIAO         := 'REGIAO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := fPadR('001',             10) + '|' +  // codigo
              fPadR('ATACADO',         50) + '|' +  // descricao
              fPadR(fCfgSis('CODACA'), 10) + '|';   // codigo empresa na ACACIA
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strTE_REGIAO);

  lblRegiao.Font.Style := [];
  imgRegiao.Visible    := True;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_TIPODOCUMENTO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  lblTipDoc.Font.Style := [fsBold];
  strTE_TIPODOCUMENTO  := 'TIPODOCUMENTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := fPadR('01',              10) + '|' +  // codigo
              fPadR('NF',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('02',              10) + '|' +  // codigo
              fPadR('IF',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('03',              10) + '|' +  // codigo
              fPadR('MI',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('04',              10) + '|' +  // codigo
              fPadR('FF',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('05',              10) + '|' +  // codigo
              fPadR('TR',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('06',              10) + '|' +  // codigo
              fPadR('DV',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('07',              10) + '|' +  // codigo
              fPadR('BR',              50) + '|';   // descricao
  lstTexto.Add(strLinha);

  strLinha := fPadR('08',              10) + '|' +  // codigo
              fPadR('PD',              50) + '|';   // descricao

  strLinha := fPadR('09',              10) + '|' +  // codigo
              fPadR('D1',              50) + '|';   // descricao

  lstTexto.Add(strLinha);
  
  lstTexto.SaveToFile(strPathExp + '\' + strTE_TIPODOCUMENTO);

  lblTipDoc.Font.Style := [];
  imgTipDoc.Visible    := True;
end;

procedure TfrmTxtACACIAServerExpAndroid.TE_TITULO;
Var
  strSQL   : String;
  strLinha : String;
  strValOri: String;
  strValDup: String;
  strJurAtr: String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblTitCtr.Font.Style := [fsBold];
    strTE_TITULO         := 'TITULOS' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                          ';
    strSQL := strSQL + '   CTR_CODCLI AS CODCLI,                                         ';
    strSQL := strSQL + '   POR_NOMPOR AS NOMPOR,                                         ';
    strSQL := strSQL + '   CONCAT(CTR_NUMDUP,CTR_PARCEL, CTR_ESPDOC) AS NUMDOC,          ';
    strSQL := strSQL + '   CTR_ESPDOC AS ESPDOC,                                         ';
    strSQL := strSQL + '   CTR_CODVEN AS CODVEN,                                         ';
    strSQL := strSQL + '   CTR_NUMDUP AS NUMDUP,                                         ';
    strSQL := strSQL + '   CTR_PARCEL AS PARCEL,                                         ';
    strSQL := strSQL + '   CTR_DTACAD AS DTACAD,                                         ';
    strSQL := strSQL + '   CTR_DTAVEN AS DTAVEN,                                         ';
    strSQL := strSQL + '   CTR_VALORI AS VALORI,                                         ';
    strSQL := strSQL + '   CTR_VALDUP AS VALDUP                                          ';
    strSQL := strSQL + ' FROM                                                            ';
    strSQL := strSQL + '   CADREC                                                        ';
    strSQL := strSQL + '   JOIN CADCLI ON (CLI_CODCLI = CTR_CODCLI AND CLI_STATUS = "A") ';
    strSQL := strSQL + '   JOIN CADPOR ON (POR_CODPOR = CTR_CODPOR) ';
    strSQL := strSQL + ' WHERE                                                           ';
    strSQL := strSQL + '   CTR_DTAREC IS NULL                                            ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;

          strValOri := AnsiReplaceStr(FormatFloat('##0.00', FieldByName('VALORI').AsFloat), ',', '.');
          strValDup := AnsiReplaceStr(FormatFloat('##0.00', FieldByName('VALDUP').AsFloat), ',', '.');
          strJurAtr := AnsiReplaceStr(FormatFloat('##0.00', fCfgSis('JURATR', varDouble)),  ',', '.');

          strLinha := '';
          strLinha := fPadR(FieldByName('CODCLI').AsString,                   20)      + '|' + // código do cliente
                      fPadR(FieldByName('NUMDOC').AsString,                   20)      + '|' + // número do documento
                      fPadR(fRetNroParcela(FieldByName('PARCEL').AsString),   10)      + '|' + // parcela
                      fPadR(fRetTipDocumento(FieldByName('ESPDOC').AsString), 10)      + '|' + // tipo de documento
                      FormatDateTime('ddMMyyyy',FieldByName('DTACAD').AsDateTime)      + '|' + // data emissão
                      FormatDateTime('ddMMyyyy',FieldByName('DTAVEN').AsDateTime)      + '|' + // data vencimento
                      fPadL(strValOri,                                        14, '0') + '|' + // valor original
                      fPadL(strValDup,                                        14, '0') + '|' + // saldo do titulo
                      fPadR(FieldByName('NUMDUP').AsString,                   20)      + '|' + // número da nota fiscal
                      fPadL(strJurAtr,                                        14, '0') + '|' + // taxa de juros
                      '00000000000.00'                                                 + '|' + // valor pago
                      fPadR(' ',                                              08)      + '|' + // data de pagto
                      fPadR(fCfgSis('CODACA'),                                10)      + '|' + // codigo empresa na ACACIA
                      fPadR(FieldByName('NOMPOR').AsString,                   30)      + '|' + // nome do banco
                      fPadR(FieldByName('CODCLI').AsString,                   20)      + '|';  // código do vendedor
          lstTexto.Add(strLinha);

          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strTE_TITULO);

        lblTitCtr.Font.Style := [];
        imgTitCtr.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.tmrFecharTimer(Sender: TObject);
begin
  inherited;
  If blnGerou Then
     Self.Close;
end;

procedure TfrmTxtACACIAServerExpAndroid.TR_CONDFORMAPAGTO;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblForPag.Font.Style := [fsBold];
    strTR_CONDFORMAPAGTO := 'FORMACONDPGTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                    ';
    strSQL := strSQL + ' 	FPG_CODIGO,              ';
    strSQL := strSQL + ' 	CND_CODIGO               ';
    strSQL := strSQL + ' FROM                      ';
    strSQL := strSQL + ' 	CADCND,                  ';
    strSQL := strSQL + ' 	CADFPG                   ';
    strSQL := strSQL + ' WHERE                     ';
    strSQL := strSQL + ' 	CND_CODFPG = FPG_CODIGO  ';
    strSQL := strSQL + ' ORDER BY                  ';
    strSQL := strSQL + ' 	CND_CODIGO               ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(FieldByName('FPG_CODIGO').AsString,       10)           + '|' + // codigo da forma pagto
                      fPadR(fPadL(FieldByName('CND_CODIGO').AsString, 05, '0'), 10) + '|' ; // codigo da Cond. pagto
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strTR_CONDFORMAPAGTO);

        lblForPag.Font.Style := [];
        imgForPag.Visible := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.TR_UNIDFATVEND;
Var
  strLinha : String;
  lstTexto : TStringList;
  qryVend  : TUniQuery;

  procedure pCarregaVendedor;
  Var
    strSQL: string;
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  OPE_CODOPE AS CODOPE, ';
    strSQL := strSQL + '  OPE_CODEMP AS CODEMP  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  OPE_STATUS = "A"  AND ';
    strSQL := strSQL + '  IFNULL(OPE_CODEMP, "") <> "" ';

    With qryVend Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      First;
    End;

  End;

begin

  Try

    lblUndVen.Font.Style := [fsBold];
    strTR_UNIDFATVEND := 'VENDUNIDFAT' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    qryVend  := fCriaQuery(Self);
    lstTexto := TStringList.Create;
    strLinha := '';

    pCarregaVendedor;

    With qryVend Do
    Begin
      pgbProgresso.Max := RecordCount;

      While Not Eof Do
      Begin
        pgbProgresso.Position := RecNo;
        Application.ProcessMessages;

        strLinha := fPadR(FieldByName('CODEMP').AsString, 10) + '|' +   //CODIGO DA UNIDADE DE FATURAMENTO - 1
                    fPadR(FieldByName('CODOPE').AsString, 10) + '|';    //CODIGO DO VENDEDOR               - 2

        lstTexto.Add(strLinha);
        Next;
      End;
    End;

    lstTexto.SaveToFile(strPathExp + '\' + strTR_UNIDFATVEND);

    lblUndVen.Font.Style := [];
    imgUndVen.Visible    := True;
  Finally
    FreeAndNil(qryVend);
    FreeAndNil(lstTexto);
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_CANALCLIENTE;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblAtivid.Font.Style := [fsBold];
    strT_CANALCLIENTE    := 'CANAL' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   ATI_CODATI, ';
    strSQL := strSQL + '   ATI_DESATI  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADATI      ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := fPadR(FieldByName('ATI_CODATI').AsString, 10) + '|' +  // codigo da atividade
                      fPadR(FieldByName('ATI_DESATI').AsString, 50) + '|' +  // descricao da atividade
                      '0'                                           + '|' +  // 0 - fixo (valor mínimo do pedido)
                      fPadR(fCfgSis('CODACA'),                  10) + '|' +  // codigo empresa na ACACIA
                      '1'                                           + '|';   // flag uso
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_CANALCLIENTE);

        lblAtivid.Font.Style := [];
        imgAtivid.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_CATEGORIA(strCodFor: String);
Var
  strSQL   : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                  ';
    strSQL := strSQL + '   FOR_CODFOR AS CODFOR, ';
    strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR  ';
    strSQL := strSQL + ' FROM                    ';
    strSQL := strSQL + '   CADFOR                ';
    strSQL := strSQL + ' WHERE                   ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR  ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        strLinhaCat := '';
        strLinhaCat := fPadR(FieldByName('CODFOR').AsString, 020) + '|' + // codigo da categoria (fornecedor)
                       fPadR(FieldByName('NOMFOR').AsString, 100) + '|' + // descricao da categoria
                       '0'                                        + '|' + // % aumento máximo de preço
                       fPadR(fCfgSis('CODACA'),              010) + '|';  // codigo empresa na ACACIA

        If (lstTextoCat.IndexOf(strLinhaCat) < 0) Then
          lstTextoCat.Add(strLinhaCat);
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_CONDPAGTO;
Var
  strSQL   : String;
  strLinha : String;
  strFatAca: String;
  strConPag: String;
  strIndice: String;  
  intQtdReg: Integer;
  lstTexto : TStringList;
Begin
  Try
    lblConPag.Font.Style := [fsBold];
    strT_CONDPAGTO	     := 'CONDPGTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                          ';
    strSQL := strSQL + '   CND_CODIGO         AS CODIGO, ';
    strSQL := strSQL + '   CND_CNDPAG         AS CNDPAG, ';
    strSQL := strSQL + '   CND_FATACA         AS FATACA, ';
    strSQL := strSQL + '   CND_DESMAX         AS DESMAX, ';
    strSQL := strSQL + '   LEFT(CND_CNDPAG,2) AS NROPAR  ';
    strSQL := strSQL + ' FROM                            ';
    strSQL := strSQL + '   CADCND                        ';

    If Not fCfgSis('CNDINA', varBoolean) Then
      strSQL := strSQL + ' WHERE LOCATE(' + QuotedStr(VS_strCodEmp) + ', CND_EMPACE) > 0 ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;

          //Exemplo: 3% de desconto esse campo deverá ir com "0,97"
          strIndice := AnsiReplaceStr(FormatFloat('##0.0000', 1 - FieldByName('DESMAX').AsFloat / 100),',','.');

          strFatAca := AnsiReplaceStr(FormatFloat('##0.0000',FieldByName('FATACA').AsFloat),',','.');
          strConPag := fFormataCondPag(FieldByName('CNDPAG').AsString);
          strConPag := fPadR(Copy(strConPag, 1, 4) + ' ' + Copy(strConpag, 5, Length(strConPag)), 80);

          strLinha  := fPadR(fPadL(FieldByName('CODIGO').AsString, 5, '0'),                      10)      + '|' + // codigo da cond. pagto
                       strConPag                                                                          + '|' + // descricao
                       fPadL(FloatToStr(round(fCalcMediaPagto(FieldByName('CNDPAG').AsString))), 02, '0') + '|' + // prazo médio
                       strIndice                                                                          + '|' + // indice da cond. pagto
                       fPadR('001',                                                              20)      + '|' + // cód. da tabela de preco
                       fPadL(strFatAca,                                                          14, '0') + '|' + // % máxima de desconto permitido
                       fPadR(FieldByName('NROPAR').AsString,                                     02)      + '|' + // nro de parcelas
                       fPadR(fCfgSis('CODACA'),                                                  10)      + '|' + // codigo empresa na ACACIA
                       fPadR(' ',                                                                10)      + '|' + // flag especial
                       fPadR('0',                                                                10)      + '|' + // % valor mínimo pedido
                       '1'                                                                                + '|';  // flag uso

          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_CONDPAGTO);

        lblConPag.Font.Style := [];
        imgConPag.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_FORMAPAGTO;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblForPag.Font.Style := [fsBold];
    strT_FORMAPAGTO	:= 'FORMAPGTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   FPG_CODIGO, ';
    strSQL := strSQL + '   FPG_DESCRI  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFPG      ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FPG_STATUS = "A" ';//Oriones enviar todas as ativas
//    strSQL := strSQL + '   FPG_CODIGO = "008" ';//Tectintas enviar somente Faturado

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := '';
          strLinha := fPadR(FieldByName('FPG_CODIGO').AsString, 10) + '|' + // codigo da forma pagto
                      fPadR(FieldByName('FPG_DESCRI').AsString, 50) + '|' + // descricao
                      '0'                                           + '|' + // valor mínimo
                      '0'                                           + '|' + // hierarquia
                      fPadR(fCfgSis('CODACA'),                  10) + '|' + // codigo empresa na ACACIA
                      '1'                                           + '|';  // flag uso
          lstTexto.Add(strLinha);

          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_FORMAPAGTO);

        lblForPag.Font.Style := [];
        imgForPag.Visible := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_GRUPOPRODUTO;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblGruPro.Font.Style := [fsBold];
    strT_GRUPOPRODUTO	    := 'GRUPOPROD' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT                  ';
    strSQL := strSQL + '   GRU_CODGRU AS CODIGO, ';
    strSQL := strSQL + '   GRU_DESGRU AS DESGRU  ';
    strSQL := strSQL + ' FROM                    ';
    strSQL := strSQL + '   CADGRU                ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := fPadR(AnsiRightStr(FieldByName('CODIGO').AsString, 6), 10)  + '|' + // código
                      fPadR(FieldByName('DESGRU').AsString,                  50)  + '|' + // descrição
                      '000.00'                                                    + '|' + // % máximo acréscimo
                      fPadR(fCfgSis('CODACA'),                               10)  + '|';  // código empresa na ACACIA
          lstTexto.Add(strLinha);

          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_GRUPOPRODUTO);

        lblGruPro.Font.Style := [];
        imgGruPro.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_META;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strT_META := 'METAS' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strT_META);
end;

procedure TfrmTxtACACIAServerExpAndroid.T_MUNICIPIO;
  Var
    strSQL   : String;
    strLinha : String;
    intQtdReg: Integer;
    lstTexto : TStringList;
begin
  Try
    lblCidade.Font.Style := [fsBold];
    strT_MUNICIPIO       := 'MUNICIPIOS' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   CID_CODCID, ';
    strSQL := strSQL + '   CID_NOMCID, ';
    strSQL := strSQL + '   CID_ESTADO  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADCID      ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := fPadR(FieldByName('CID_CODCID').AsString, 100) + '|' +  // codigo da cidade
                      fPadR(FieldByName('CID_NOMCID').AsString, 100) + '|' +  // nome da cidade
                      fPadR(FieldByName('CID_ESTADO').AsString, 002) + '|' +  // estado
                      '1'                                            + '|';   // 1 - fixo (indice financeiro)
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_MUNICIPIO);

        lblCidade.Font.Style := [];
        imgCidade.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_SALDO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  strT_SALDO := 'SALDO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := '';
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strT_SALDO);
end;

procedure TfrmTxtACACIAServerExpAndroid.T_STATUSCLIENTE;
Var
  strLinha : String;
  lstTexto : TStringList;
Begin
  lblStsCli.Font.Style := [fsBold];
  strT_STATUSCLIENTE	 := 'STATUSCLIENTE' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;

  strLinha := fPadR('001',   010) + '|' +  // codigo
              fPadR('ATIVO', 100) + '|' +  // descricao
              '0'                 + '|' +  // flag bloqueado
              '0'                 + '|' +  // flag bloquear ped
              '1'                 + '|' +  // flag lim. credito
              fPadR('8',     050) + '|';   // código da cor
  lstTexto.Add(strLinha);

  strLinha := fPadR('002',     010) + '|' +   // codigo
              fPadR('INATIVO', 100) + '|' +   // descricao
              '1'                   + '|' +   // flag bloqueado
              '1'                   + '|' +   // flag bloquear ped
              '1'                   + '|' +   // flag lim. credito
              fPadR('2',       050) + '|';    // código da cor
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strT_STATUSCLIENTE);

  lblStsCli.Font.Style := [];
  imgStsCli.Visible    := True;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_STATUSPRODUTO;
Var
  strLinha : String;
  lstTexto : TStringList;
Begin
  lblStsPro.Font.Style := [fsBold];
  strT_STATUSPRODUTO 	 := 'STATUSPRODUTO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;

  strLinha := fPadR('001',       010) + '|' +  // codigo
              fPadR('ATIVO',     100) + '|' +  // descricao
              ' '                     + '|' +  // flag para controle
              fPadR('8',         050) + '|';   // código da cor
  lstTexto.Add(strLinha);

  strLinha := fPadR('002',       010) + '|' +  // codigo
              fPadR('BLOQUEADO', 100) + '|' +  // descricao
              ' '                     + '|' +  // flag para controle
              fPadR('2',         050) + '|';   // código da cor
  lstTexto.Add(strLinha);

  strLinha := fPadR('003',       010) + '|' +  // codigo
              fPadR('SUSPENSO',  100) + '|' +  // descricao
              ' '                     + '|' +  // flag para controle
              fPadR('6',         050) + '|';   // código da cor
  lstTexto.Add(strLinha);

  lstTexto.SaveToFile(strPathExp + '\' + strT_STATUSPRODUTO);

  lblStsPro.Font.Style := [];
  imgStsPro.Visible    := True;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_TIPONOTA;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblTipNot.Font.Style := [fsBold];
    strT_TIPONOTA	       := 'TIPONOTA' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   CFO_CODCFO, ';
    strSQL := strSQL + '   CFO_DESCR1  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADCFO      ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := fPadR(FieldByName('CFO_CODCFO').AsString, 10)                            + '|' +  // codigo
                      fPadR(FieldByName('CFO_DESCR1').AsString, 50)                            + '|' +  // descricao
                      IIF(Pos(FieldByName('CFO_CODCFO').AsString, VS_strClaVen) > 0, '1', '0') + '|' +  // flag venda
                      IIF(Pos(FieldByName('CFO_CODCFO').AsString, VS_strClaDev) > 0, '1', '0') + '|' +  // flag devolução
                      IIF(Pos(FieldByName('CFO_CODCFO').AsString, '5910_6910_') > 0, '1', '0') + '|' +  // flag bonificação
                      fPadR(fCfgSis('CODACA'),                  10)                            + '|';   // codigo empresa na ACACIA
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_TIPONOTA);

        lblTipNot.Font.Style := [];
        imgTipNot.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_TIPOPEDIDO;
Var
  strLinha : String;
  lstTexto : TStringList;
begin
  lblTipPed.Font.Style := [fsBold];
  strT_TIPOPEDIDO      := 'TIPOSPEDIDO' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

  lstTexto := TStringList.Create;
  strLinha := fPadR('00',     10) + '|' + // codigo
              fPadR('NF',     50) + '|' + // descricao
              fPadR('00001',  10) + '|' + // codigo da condição de pagamento padrao
              '0'                 + '|' + // flag controlar valor mínimo do pedido
              fPadR('0',      03) + '|' + // flag especial
              fPadR('001',    20) + '|' + // codigo da tabela de preço
              '0'                 + '|' + // flag uso
              '0'                 + '|';  // flag bonificação
  lstTexto.Add(strLinha);

//Tectintas solicitou para somente enviar nota fiscal neste arquivo  
{ strLinha := fPadR('01',     10) + '|' + // codigo
              fPadR('MI/FF',  50) + '|' + // descricao
              fPadR('00001',  10) + '|' + // codigo da condição de pagamento padrao
              '0'                 + '|' + // flag controlar valor mínimo do pedido
              fPadR('0',      03) + '|' + // flag especial
              fPadR('001',    20) + '|' + // codigo da tabela de preço
              '0'                 + '|' + // flag uso
              '0'                 + '|';  // flag bonificação
  lstTexto.Add(strLinha);

  strLinha := fPadR('02',     10) + '|' + // codigo
              fPadR('BRINDE', 50) + '|' + // descricao
              fPadR('00001',  10) + '|' + // codigo da condição de pagamento padrao
              '0'                 + '|' + // flag controlar valor mínimo do pedido
              fPadR('0',      03) + '|' + // flag especial
              fPadR('001',    20) + '|' + // codigo da tabela de preço
              '0'                 + '|' + // flag uso
              '0'                 + '|';  // flag bonificação
  lstTexto.Add(strLinha);}

  lstTexto.SaveToFile(strPathExp + '\' + strT_TIPOPEDIDO);

  lblTipPed.Font.Style := [];
  imgTipPed.Visible    := True;
end;

procedure TfrmTxtACACIAServerExpAndroid.T_UNIDFAT;
Var
  strSQL   : String;
  strLinha : String;
  intQtdReg: Integer;
  lstTexto : TStringList;
begin
  Try
    lblUndFat.Font.Style := [fsBold];
    strT_UNIDFAT	       := 'UNIDFAT' + FormatDateTime('yyyyMMdd', VS_Date) + FormatDateTime('hhmmss', fTime()) + '.TXT';

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   EMP_CODEMP, ';
    strSQL := strSQL + '   EMP_NOMEMP  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADEMP      ';
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;
    dspGenerica.DataSet := qryGenerica;
    cdsGenerica.Close;
    cdsGenerica.SetProvider(dspGenerica);
    cdsGenerica.Open;
    With cdsGenerica Do
    Begin
      If Not IsEmpty Then
      Begin
        intQtdReg        := RecordCount;
        lstTexto         := TStringList.Create;
        pgbProgresso.Max := intQtdReg;
        While Not Eof Do
        Begin
          pgbProgresso.Position := RecNo;
          Application.ProcessMessages;
          strLinha := fPadR(FieldByName('EMP_CODEMP').AsString,  10) + '|' +  // codigo da unidade
                      fPadR(FieldByName('EMP_NOMEMP').AsString, 100) + '|' +  // descricao da unidade
                      '1'                                            + '|' +  // 1 - fixo (código da tabela de preço padrão)
                      '1'                                            + '|' +  // 1 - fixo (flag unidade de preço padrão)
                      '0'                                            + '|' +  // 1 - fixo (valor mínimo do pedido)
                      '1'                                            + '|' +  // flag uso
                      fPadR(fCfgSis('CODACA'),                   10) + '|';   // codigo empresa na ACACIA
          lstTexto.Add(strLinha);
          Next;
        End;
        lstTexto.SaveToFile(strPathExp + '\' + strT_UNIDFAT);

        lblUndFat.Font.Style := [];
        imgUndFat.Visible    := True;
      End;
    End;
  Finally
    cdsGenerica.Close;
  End;
end;

procedure TfrmTxtACACIAServerExpAndroid.pCriaQueryPromocoes;
  Var
     strSql: String;
begin
  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE     ';
  strSql := strSql + '  	IPR_CODITE AS CODITE, ';
  strSql := strSql + '    IPR_PREVEN AS PREVEN  ';
  strSql := strSql + '  FROM                    ';
  strSql := strSql + '    CADPRO                ';
  strSql := strSql + '    INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  strSql := strSql + '    INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  strSql := strSql + '  WHERE ';
  strSql := strSql + '    PROEMP.PRO_CODEMP = :CODEMP AND ';
  strSql := strSql + '    PRO_DTAINI <= :DTAPRO AND PRO_DTAFIN >= :DTAPRO ';
  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '    PRO_CODPRO ';

  qryItensPromocao := fCriaQuery(Self);

  With qryItensPromocao, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('DTAPRO').AsDate   := VS_Date;
    Open;
    IndexFieldNames := 'CODITE';
  End;
   
end;

procedure TfrmTxtACACIAServerExpAndroid.dirPathExpedtDirectoryChange(Sender: TObject);
begin
  //#Asimov#
  //Revisar Eventos: dirPathExpExit
end;


procedure TfrmTxtACACIAServerExpAndroid.dirPathExpedtDirectoryExit(
  Sender: TObject);
begin
  inherited;
  dirPathExpExit(sender);
end;

end.
