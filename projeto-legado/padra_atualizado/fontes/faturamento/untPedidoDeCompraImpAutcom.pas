{************************************************}
{  IMPORTAÇÂO DE LAYOUT PEDIDO DE COMPRAS ALESSI }
{  E GRAVAÇAO NOS PEDIDOS DE VENDA               }
{                                                }
{ AUTOR : GUILHERME BORGES                       }
{ DATA: 14/11/2012                               }
{************************************************}

unit untPedidoDeCompraImpAutcom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Gauges, Mask, FilenameEditFocus, StrUtils, Uni,
  DB, UniClientDataSet, Grids, DBGridCitel, DBGrids, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Datasnap.DBClient, cxTextEdit, untLiberacao, untMsgLiberacao,
  cxMaskEdit, cxButtonEdit, frxDBSet;

type

  TItensPed = Record
    strCodIte : String;
    fltQtdPed : Double;
    fltVlrUni : Double;
    fltVlrTot : Double;
  End;

  TItensTrava = Record
    strCodIte: String;
    strNomIte: String;
    strMarca : String;
    fltQtdIte: Double;
    fltTbpSug: Double;
    fltTbpArq: Double;
    fltTotSug: Double;
    fltTotArq: Double;
  End;

  TfrmPedidoDeCompraImpAutcom = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    gauProgresso: TGauge;
    Panel2: TPanel;
    DBGrid1: TDBGridCitel;
    cdsOcorrencias: TUniClientDataSet;
    cdsOcorrenciasTIPO: TStringField;
    cdsOcorrenciasLINHA: TIntegerField;
    cdsOcorrenciasCAMPO: TStringField;
    cdsOcorrenciasOCORRENCIA: TStringField;
    dtsOcorrencias: TDataSource;
    Panel3: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnLimpa: TBitBtnLocked;
    flnArqTxt: TFilenameEditFocus;
    grbArquivo: TGroupBox;
    chkImprime: TCheckBox;
    rdgTabPre: TRadioGroup;
    Panel4: TPanel;
    gpbLegendas: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Shape2: TShape;
    pnlDivergSaldo: TPanel;
    dbgDivergSaldo: TDBGridCitel;
    dtsDivergSaldo: TDataSource;
    pnlRodDivergSaldo: TPanel;
    lblRodDivergSaldo: TLabel;
    pnlCabDivergSaldo: TPanel;
    pnlLegMarcado: TPanel;
    shpMarcado: TShape;
    lblLegMarcado: TLabel;
    frxReportJ: TfrxReport;
    frxDBDivergSaldo: TfrxDBDataset;
    frxReportM: TfrxReport;
    procedure flnArqTxtAfterDialog(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLimpaClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure flnArqTxtExit(Sender: TObject);
    procedure dbgDivergSaldoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDivergSaldoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    qryCadIte : TUniQuery;

    arrItens   : Array of TItensPed;
    stlArquivo : TStringList;
    intErro    : Integer;
    intAviso   : Integer;
    qryGenerica: TUniQuery;

    FdtaEmissa,
    FdtaPrevis : TDate;

    intIncPos: Integer;

    arrItensTrava: Array of TItensTrava;

    FstrNroPed,
    FstrConPgt,
    FstrCodCli,    
    FstrNomCli,
    FstrCgcCli,
    FstrIE_Cli,
    FstrEndere,
    FstrBairro,
    FstrCidade,
    FstrEstado,
    FstrCEP    : String;

    strNumDoc : String; // Numero Sequencial Gerado para grava o NumDoc


    FintQtdDet : Integer;

    FfltTbpSug,
    FfltTotSug,
    FfltVlrTot,
    FfltTotCus,
    FfltTotMed : Double;

    FdtaHorArq : TTime;
    FstrTabPre : String;

    objLiberacao : TLiberacao;

    cdsDivergSaldo: TUniClientDataSet;
    cdsItens: TUniClientDataSet;

    Function  pImportarArquivo(strArqName : String): Boolean;
    Procedure pProcessaHeader(intIndex: Integer);
    Procedure pProcessaDetail(intIndex: Integer);
    Procedure pProcessaTrailler(intIndex: Integer);

    Procedure pPegaCampo(strNomeCampo: String; Var fltResult : Double ; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var dtaResult : TDate  ; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var strResult : String ; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var intResult : Integer; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pAddOcorrencia(intIndex: Integer; strNomeCampo, strErro: String; strTipo : Char);

    Procedure pLimpar;

    function fValidaPedido(strNumDoc, strCodCli : String): Boolean;
    function fGravaPedido:Boolean;
    function fGravaItem(recDados : TItensPed; strAutFdo : String):Boolean;
    function fRetornaVendedorRepresentanteCliente(strCodCli, strBusca: string):String;
    function fValidaCndPagTipoCliente(strCndPag, strCodCli: string; var strTipCli: string): Boolean;
    procedure pDefinePrecoItens;
    function fRetornaTabelasPreco(strCndPag: string): string;
    function fUtilizaPrecoArquivo: Boolean;

    procedure pCriaClientDivergSaldo;
    procedure pCriaClientItens;
    procedure pAddDivergSaldo(strCodIte, strDesIte: String; fltQtdPed, fltSalDis: Double);
    procedure pMarcaDesmarcaDivergSaldo;
    function fValidaItensSemSaldo: Boolean;

    procedure pAddItemArray(strCodIte : String; fltQtdPed, fltVlrUni, fltVlrTot : Double);
    procedure pAddCdsItens(strCodIte : String; fltQtdPed, fltVlrUni, fltVlrTot : Double);

    function fPrecoPromocao(strCodIte: String; fltQtde: Double): Double;
    function fVerificaTravaItem(strCodIte: String; fltQtdIte: Double): Boolean;

    procedure pMostraDivergenciasSaldo(strNomArq: String);
  public
    { Public declarations }
  end;

var
  frmPedidoDeCompraImpAutcom: TfrmPedidoDeCompraImpAutcom;

implementation

uses untFuncoesSimples, untFatGor, untFuncoesGenerica, untConstantes, untTypesSistema,
  untCadPro, untFuncFatTypes, untFuncFatImp, untSaldoLojas;

{$R *.dfm}

procedure TfrmPedidoDeCompraImpAutcom.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  Try
    if (not fValidaItensSemSaldo) then
      Exit;

    If fGravaPedido Then
    Begin
      fMensagem('Importação de Pedidos', 'Arquivo Importado com Sucesso!' + #13 + 'Pedido Numero: ' + strNumDoc, ['&OK']);
      pLimpar;
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '[btnConfirmaClick]');
  End;
end;

procedure TfrmPedidoDeCompraImpAutcom.btnLimpaClick(Sender: TObject);
begin
  inherited;
  pLimpar;
end;

procedure TfrmPedidoDeCompraImpAutcom.dbgDivergSaldoDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (cdsDivergSaldo.FieldByName('MARCAD').AsInteger = 1) Then
    TDBGridCitel(Sender).Canvas.Brush.Color := clAqua;

  if (gdSelected in State) and (cdsDivergSaldo.FieldByName('MARCAD').AsInteger = 1) Then
    TDBGridCitel(Sender).Canvas.Font.Color  := clBlack;

  TDBGridCitel(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmPedidoDeCompraImpAutcom.dbgDivergSaldoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    pMarcaDesmarcaDivergSaldo;
end;

procedure TfrmPedidoDeCompraImpAutcom.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if fEmptyStr(String(cdsOcorrenciasTIPO.Value)) Then
    TDBGridCitel(Sender).Canvas.Brush.Color := Self.Color
  Else
  if cdsOcorrenciasTIPO.Value = 'E' Then
    TDBGridCitel(Sender).Canvas.Brush.Color := clRed
  Else
  if cdsOcorrenciasTIPO.Value = 'A' Then
    TDBGridCitel(Sender).Canvas.Brush.Color := clYellow;

  if (gdSelected in State) Then
    TDBGridCitel(Sender).Canvas.Font.Color  := clBlack;

  TDBGridCitel(Sender).DefaultDrawDataCell(Rect, Column.Field, State);

end;

function TfrmPedidoDeCompraImpAutcom.fGravaItem(recDados: TItensPed; strAutFdo : String): Boolean;
  Var
    intSeqInc : Integer;

    strCodVen,
    strCodRep,
    strCodSit,
    strClaFis,
    strSQL,
    strDescri,
    strTipAbf,
    strAutInc : String;
begin
  strCodVen := fRetornaVendedorRepresentanteCliente(FstrCodCli, 'V');
  strCodRep := fRetornaVendedorRepresentanteCliente(FstrCodCli, 'R');

  intSeqInc := 0;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   C.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '   C.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '   C.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '   C.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '   C.ITE_CODUNI AS CODUNI, ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '   C.ITE_CODABF AS CODABF, '
    Else
      strSQL := strSQL + '   I.ITE_CODABF AS CODABF, ';

    strSQL := strSQL + '   C.ITE_PESOIT AS PESOIT, ';
    strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '   I.ITE_PREMED AS PREMED, ';
    strSQL := strSQL + '   I.ITE_COMVAR AS COMVAR ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE C, ';
    strSQL := strSQL + '   ITEGER I ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   I.ITE_CODITE = C.ITE_CODITE AND ';
    strSQL := strSQL + '   I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   I.ITE_CODEMP = :CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := recDados.strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      strTipAbf := fGetTipoAbfFornecedor(FstrCodCli);

      fValidaCodAbf(FieldByName('CODABF').AsString, FstrEstado, strTipAbf, strCodSit);

      strClaFis := IIF(fCadEmp('ESTADO') = FstrEstado, '5', '6');
      strClaFis := strClaFis + IIF( Pos(strCodSit, CST_SUBSTITUICAO) > 0, '405', '102');

    End;

    Inc(intSeqInc);

    strDescri := qryGenerica.fieldbyname('DESITE').AsString;

    If (fCfgSis('IMPREF', varBoolean)) Then
      If (fCfgSis('MONDES', varString) = '1') Then
        strDescri := strDescri +
                     IIF(Not fEmptyStr(qryGenerica.fieldbyname('REFERE').AsString),' ' + qryGenerica.fieldbyname('REFERE').AsString,'')
      Else
        strDescri := IIF(Not fEmptyStr(qryGenerica.fieldbyname('REFERE').AsString),qryGenerica.fieldbyname('REFERE').AsString + ' ','') +
                     strDescri;

    strAutInc := '';
    Result := fGravaFatDor(strAutInc,
                 strAutFdo,                                                                                            // strSeqGer
                 VS_strCodEmp,                                                                                         //  strCodEmp
                 FstrCodCli,                                                                                            //  strCodCli
                 IIF(fEmptyStr(strCodVen), strLoginUsuarioLogado, strCodVen),                                           //  strCodVen
                 recDados.strCodIte,                                                         //  strCodIte
                 qryGenerica.fieldbyname('CODMAR').AsString,                                                           //  strCodMar
                 '',                                                                                                   //  strCodDiv
                 strNumDoc,                                                                                            //  strNumDoc
                 'PD',                                                                                                 //  strEspDoc
                 '',                                                                                                   //  strSerie:
                 FdtaEmissa,
                 FdtaHorArq,                                                            //  dtaHorEnt
                 FstrConPgt,                                                                          //  strConPag
                 '',                                                                                                   //  strEstado
                 strDescri,                                                                                            //  strDescri
                 qryGenerica.fieldbyname('REFERE').AsString,                                                           //  strRefere
                 qryGenerica.fieldbyname('CODUNI').AsString,                                                           //  strUnidad
                 qryGenerica.fieldbyname('CODFOR').AsString,                                                           //  strForIte

                 recDados.fltQtdPed,                                                          //  fltQtdIte
                 recDados.fltVlrUni,                                                          //  fltUnitar
                 recDados.fltVlrUni,                                                          //  fltUniOri
                 recDados.fltVlrUni,                                                          //  fltUniVis
                 recDados.fltVlrTot,                                                          //  fltTotIte
                 recDados.fltVlrTot,                                                          //  fltVlrCon

                 qryGenerica.fieldbyname('PRECUS').AsFloat * recDados.fltQtdPed,              //  fltTotCus
                 qryGenerica.fieldbyname('PREMED').AsFloat * recDados.fltQtdPed,              //  fltTotMed
                 0.00,                                                          //  fltDesCon
                 0.0,                                                                                                  //  fltTotFre
                 0.0,                                                                                                  //  fltDesEsp
                 0.0,                                                                                                  //  fltDesAce
                 strCodRep,                                                                                            //  strCodRep
                 '',                                                                                                   //  strCodVe2
                 qryGenerica.fieldbyname('COMVAR').AsFloat,                                                            //  fltPerCom
                 (recDados.fltVlrTot / 100) * qryGenerica.fieldbyname('COMVAR').AsFloat,      //  fltTotCom
                 0.0,                                                                                                  //  fltTotCo2
                 strClaFis,                                                     //  strClaFis
                 qryGenerica.fieldbyname('CODABF').AsString,                                                           //  strCodFis
                 0.0,                                                                                                  //  fltValIpi
                 0.0,                                                                                                  //  fltAlqIpi
                 0.0,                                                                                                  //  fltBasIpi
                 0.0,                                                                                                  //  fltValIcm
                 0.0,                                                                                                  //  fltAlqIcm
                 0.0,                                                                                                  //  fltBasIcm
                 0.0,                                                                                                  //  fltValRet
                 0.0,                                                                                                  //  fltAlqRet
                 0.0,                                                                                                  //  fltBasRet
                 qryGenerica.fieldbyname('PESOIT').AsFloat * recDados.fltQtdPed,              //  fltTotPes
                 0.0,                                                                                                  //  fltPerBas
                 0.0,                                                                                                  //  fltPerRed
                 False,                                                                                                //  blnJaFatu
                 '',                                                                                                   //  strTipFat
                 '',                                                                                                   //  strNumFat
                 '',                                                                                                   //  strEmpFat
                 0,                                                                                                    //  dtaDtaFat
                 '',                                                                                                   //  strVenFat
                 '',                                                                                                   //  strCndFat
                 0.0,                                                                                                  //  fltValFat
                 'NOR',                                                                                                //  strIdePro
                 'N',                                                                                                  //  strIncPis
                 strLoginUsuarioLogado,                                                                                //  strCodDig
                 fRetCodCnd(FstrConPgt, VS_strCodEmp),                                                                               //  strCodCnd
                 '',                                                                                                   //  strProEmb
                 '',                                                                                                   //  strCodFpg
                 '',                                                                                                   //  strIteCha
                 '',                                                                                                   //  strIteTin
                 '',                                                                                                   //  strDesCor
                 '',                                                                                                   //  strTipEmb
                 0.0,                                                                                                  //  fltQtdEmb
                 0.0,                                                                                                  //  fltPreEmb
                 '',                                                                                                   //  strTipPre
                 0.0,                                                                                                  //  fltPrvTin
                 0.0,                                                                                                  //  fltPrcTin
                 0.0,                                                                                                  //  fltFatTin
                 '',                                                                                                   //  strIteEmb
                 '',                                                                                                   //  strGruEmb
                 0,                                                                                                    //  intLazQua
                 'N',                                                                                                  //  strPromoc
                 '',                                                                                                   //  strSeqTin
                 0.0,                                                                                                  //  fltQtdPul
                 intSeqInc,                                                                                            //  intSeqInd
                 0.0,                                                                                                  //  fltQtdBai
                 recDados.fltVlrUni,                                                          //  fltUniDig
                 '',                                                                                                   //  strComple
                 0.0,                                                                                                  //  fltVolPro
                 '',                                                                                                   //  strCodAca
                 '',                                                                                                   //  strEmpAca
                 False,                                                                                                //  blnProAca
                 FstrTabPre,                                                    //  strTabPre
                 '',                                                                                                   //  strLinha:
                 '',                                                                                                   //  strCatali
                 '',                                                                                                   //  strCodDil
                 0.0,                                                                                                  //  fltPorDil
                 '',                                                                                                   //  strDilCon
                 0.0,                                                                                                  //  fltPorCat
                 '',                                                                                                   //  strEntRet
                 '',                                                                                                   //  strLocRet
                 'N',                                                                                                  //  strEntFut
                 '',                                                                                                   //  strMotFut
                 0,                                                                                                    //  dtaDtaFut
                 qryGenerica.fieldbyname('PRECUS').AsFloat * recDados.fltQtdPed,
                 0,
                 0,
                 '',
                 '',
                 '',
                 False,
                 '',
                 '',
                 '',
                 '',
                 '',
                 '',
                 0,
                 0,
                 '',
                 FstrNroPed,
                 0,
                 '',
                 '',
                 0,
                 0,
                 0);
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaPedido]');
    End;
  End;

end;

function TfrmPedidoDeCompraImpAutcom.fGravaPedido: Boolean;
  Var
    strCodVen,
    strAutInc : String;
    recServicos: TDadosServicos;    
    intCorre : Integer;
    arrDuplic : TarrDuplicata;
    objFatImp : TFatVendaImp;
    documento : TDadosImpressaoVenda;
begin
  Try
    pDefinePrecoItens;

    Screen.Cursor := crHourGlass;
    gauProgresso.Progress := 0;
    gauProgresso.MaxValue := High(arrItens) + 4;

    fStartTransaction;
    gauProgresso.AddProgress(1);

    strCodVen := fRetornaVendedorRepresentanteCliente(FstrCodCli, 'V');
    strNumDoc := fRetSequencialPedido;
    gauProgresso.AddProgress(1);

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    Result := fGravaFatGor(strAutInc,                                                                         // strIncrem
                 VS_strCodEmp,                                                                                //  strCodEmp
                 strNumDoc,                                                    //  strNumDoc
                 'PD',                                                                                        //  strEspDoc
                 FstrCodCli,                                                    //  strCodCli
                 IIF(fEmptyStr(strCodVen), strLoginUsuarioLogado, strCodVen),                                 //  strCodVen
                 '',                                                                                          //  strCodTra
                 '',                                                                                          //  strSerie:
                 FdtaEmissa,  //  dtaDtaEnt
                 FdtaHorArq,                                                    //  dtaHorEnt
                 FstrConPgt,                                  //  strConPag
                 FstrEstado,                                                    //  strEstado
                 FstrNomCli,                                                    //  strNomCom
                 FstrEndere,                                                    //  strEndCon
                 FstrBairro,                                                    //  strBaiCon
                 FstrCEP,                                                       //  strCepCon
                 FstrCidade,                                                    //  strCidCon
                 '',                                                                                          //  strEstCon
                 '',                                                                                          //  strCodAti
                 '',                                                                                          //  strTelCon
                 0,                                                           //  dtaNasCon
                 IIF(Length(FstrCgcCli) = 11,'2','1'),                        //  strCgcCpf
                 FstrCgcCli,                                                    //  strCgcCon
                 FstrIE_Cli,                                                    //  strIesCon
                 '',                                                                                          //  strCli_Rg
                 0.0,                                                                                         //  fltBasSim
                 0.0,                                                                                         //  fltBasIpi
                 0.0,                                                                                         //  fltAlqIpi
                 0.0,                                                                                         //  fltTotIpi
                 0.0,                                                                                         //  fltBasIcm
                 0.0,                                                                                         //  fltAlqIcm
                 0.0,                                                                                         //  fltTotIcm
                 0.0,                                                                                         //  fltTotRet
                 0.0,                                                                                         //  fltAlqRet
                 0.0,                                                                                         //  fltBasRet
                 0.0,                                                                                         //  fltDesEsp
                 FfltVlrTot,                                                    //  fltVlrCon
                 FfltVlrTot,                                                    //  fltTotPro
                 FfltTotCus,                                                    //  fltTotCus
                 FfltTotMed,                                                    //  fltTotMed
                 '',                                                                                          //  strTipFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre
                 0.0,                                                                                         //  fltTotFre

                 0.0,                                                                                         //  fltDesAce
                 0.0,                                                                                         //  fltPesBru
                 0.0,                                                                                         //  fltPesLiq
                 0,                                                                                           //  fltVolume
                 arrDuplic,                                                                                   //  arrDuplic
                 '',                                                                                          //  strEspeci
                 '',                                                                                          //  strMarca,
                 '',                                                            //  strMen001
                 '',                                                            //  strMen002
                 False,                                                                                       //  blnJaFatu
                 '',                                                                                          //  strTipFat
                 '',                                                                                          //  strNumFat
                 '',                                                                                          //  strEmpFat
                 0,                                                                                           //  dtaDtaFat
                 '',                                                                                          //  strVenFat
                 '',                                                                                          //  strCndFat
                 0.0,                                                                                         //  fltValFat
                 0.0,                                                                                         //  fltPorDes
                 strLoginUsuarioLogado,                                                                       //  strCodDig
                 fRetCodCnd(FstrConPgt, VS_strCodEmp),                                                                      //  strCodCnd
                 '',                                                            //  strCodFpg
                 recServicos,
                 '',                                                                                          //  strConEnt
                 VS_Date,                                                                                     //  dtaPreVis
                 0.0,                                                                                         //  fltVPgAnt
                 VS_Date,                                                                                     //  dtaUltAlt
                 '',                                                                                          //  strNTrava
                 'A',                                                                                         //  strTipPed
                 '',                                                                                          //  strCliCtt
                 0,                                                                                           //  intLibera
                 'S',                                                                                         //  strEntFat
                 0.0,                                                                                         //  fltDesCon
                 FstrTabPre,                                                    //  strTabPre
                 '',                                                                                          //  strEntFut
                 0.0,                                                                                         //  fltMargem
                 FstrNroPed,                                                    //  strNumPok
                 '',                                                                                          //  strEmp_CD
                 False,                                                                                       //  blnEnt_CD
                 'N',                                                                                         //  strOprFlj
                 '',                                                                                          //  strMenExp
                 '',                                                                                          //  strMenExp
                 '',                                                                                          //  strMenExp
                 '',                                                                                          //  strMenExp
                 '',                                                                                          //  strNumReg
                 '',                                                                                          //  strPedSit
                 False,                                                                                       //  blnPedLib
                 VS_Date,
                 'N',
                 'V',
                 VS_Date,                                                                                     //  dtaDtEntr
                 'P',       //strTipFin
                 0,        //fltDesFin
                 '',        //strAutEnt
                 '',
                 '',
                 False,
                 '',
                 Nil,
                 '',
                 '',
                 0,
                 0,
                 0,
                 '',
                 Nil,
                 '',
                 0,
                 0,
                 '',
                 '',
                 0,
                 '',
                 0,
                 '',
                 '',
                 '0',
                 'N');

    gauProgresso.AddProgress(1);
    gauProgresso.AddProgress(1);

    If Result Then
    Begin
      For intCorre := 0 To High(arrItens) Do
      Begin
        Result := fGravaItem(arrItens[intCorre], strAutInc);
        If Not Result Then
          Break;
        gauProgresso.AddProgress(1);
      End;
    End;

    If Result Then
      fCommit
    Else
      fRollBack;

    If (Result) And (chkImprime.Checked) Then
    Begin
      objFatImp := TFatVendaImp.Create;
      try
        documento.strNumDoc := strNumDoc;
        documento.strEspDoc := 'PD';
        documento.strEmpDoc := VS_strCodEmp;
        documento.strCodCli := FstrCodCli;
        documento.strCliCgc := FstrCgcCli;
        documento.fltTotGer := FfltVlrTot;
        objFatImp.pImprimeDocumento(documento);
      finally
        FreeAndNil(objFatImp);
      end;
    End;

    gauProgresso.AddProgress(1);
    Screen.Cursor := crDefault;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      Screen.Cursor := crDefault;      
      Result := False;
      pMensagensErro(E.Message, '[fGravaPedido]');
    End;
  End;
end;

procedure TfrmPedidoDeCompraImpAutcom.flnArqTxtAfterDialog(Sender: TObject);
begin
  inherited;
  flnArqTxt.Enabled := False;
  pImportarArquivo(flnArqTxt.Dialog.Dialog.FileName);
end;

procedure TfrmPedidoDeCompraImpAutcom.flnArqTxtExit(Sender: TObject);
begin
  inherited;
  If (FileExists(flnArqTxt.Text)) Then
  Begin
    flnArqTxt.Enabled := False;
    pImportarArquivo(flnArqTxt.Text);
  End;
end;

procedure TfrmPedidoDeCompraImpAutcom.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOcorrencias.CreateDataSet;
  pCriaClientDivergSaldo;
  pCriaClientItens;

  pLimpar;
  qryGenerica := fCriaQuery(Self);

  flnArqTxt.Dialog.Dialog.Filter := 'Aquivos de Texto (*.txt)|*.Txt|Todos Arquivos (*.*)|*.*';
  flnArqTxt.Dialog.OnAccept := flnArqTxtAfterDialog;
  qryCadIte := fCriaQuery();

  intIncPos := 0;

  objLiberacao := TLiberacao.Create;
end;

procedure TfrmPedidoDeCompraImpAutcom.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCadIte);
  inherited;
  FreeAndNil(qryGenerica);

  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);

  FreeAndNil(cdsDivergSaldo);
  FreeAndNil(cdsItens);
end;

function TfrmPedidoDeCompraImpAutcom.fPrecoPromocao(strCodIte: String; fltQtde: Double): Double;
var
  fltPreCus,
  fltPreVen,
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07: Double;
  blnParticiona,
  blnPromo: Boolean;
  strComPro: String;
strCodPro: String;
begin
  Result := 0.00;

  if fRetornaPrecosPromocao(strCodIte,
                           FstrCodCli,
                           VS_Date,
                           fltQtde,
                           0,
                           0,
                           0,
                           fltPreCus,
                           fltPreVen,
                           fltComVar,
                           fltComAta,
                           fltComDis,
                           fltQtdDis,
                           fltDesF07,
                           strComPro,
                           strCodPro,
                           blnParticiona,
                           blnPromo,
                           FstrTabPre,
                           '01000',
                           '',
                           '') then
    Result := fltPreVen;
end;

function TfrmPedidoDeCompraImpAutcom.fRetornaTabelasPreco(
  strCndPag: string): string;
var
  qryCndPag: TUniQuery;
  strTabelas: string;
  strNumTab: string;
  intIndice: integer;
begin
  Result := '1';
  strTabelas := EmptyStr;
  if (fCfgSis('USACND', varBoolean)) and (fCfgSis('TBPCND', varBoolean)) and (fCfgSis('CNDVEN', varString) = 'I') then
  begin
    qryCndPag := fCriaQuery;
    try
      qryCndPag.Close;
      qryCndPag.SQL.Clear;
      qryCndPag.SQL.Add('SELECT CND_PRETAB');
      qryCndPag.SQL.Add('FROM CADCND');
      qryCndPag.SQL.Add('WHERE CND_CNDPAG = :CNDPAG');
      qryCndPag.SQL.Add('AND CND_CODEMP = :CODEMP');
      qryCndPag.ParamByName('CNDPAG').AsString := strCndPag;
      qryCndPag.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCndPag.Open;

      if not qryCndPag.IsEmpty then
        strTabelas := qryCndPag.FieldByName('CND_PRETAB').AsString;
    finally
      FreeAndNil(qryCndPag);
    end;
  end
  else
  begin
    strTabelas := fCfgSis('TABPRC', varString);
  end;

  strTabelas := fDevolveTabelaPreco(strTabelas);

  if fEmptyStr(strTabelas) then
    Exit;

  for intIndice := 1 to Length(strTabelas) do
  begin
    strNumTab := strTabelas[intIndice];

    if (fSistemaUsaEssaTabelaPreco(strNumTab)) and (fFaturamentoUsaEssaTabelaPreco(strNumTab)) then
    begin
      Result := strNumTab;
      Exit;
    end;
  end;
end;

function TfrmPedidoDeCompraImpAutcom.fRetornaVendedorRepresentanteCliente(
  strCodCli, strBusca: string): String;
var
  qryCliente: TUniQuery;
begin
  Result := EmptyStr;
  qryCliente := fCriaQuery;

  try
    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.SQL.Add('SELECT');

    if (UpperCase(strBusca) = 'R') then
    begin
      qryCliente.SQL.Add('CLI_CODREP AS VENREP');
    end
    else
      qryCliente.SQL.Add('CLI_CODVEN AS VENREP');
    begin

    end;

    qryCliente.SQL.Add('FROM CADCLI');
    qryCliente.SQL.Add('WHERE CLI_CODCLI = :CODCLI');

    qryCliente.ParamByName('CODCLI').AsString := strCodCli;
    qryCliente.Open;

    if not qryCliente.IsEmpty then
    begin
      Result := qryCliente.FieldByName('VENREP').AsString;
    end;
  finally
    FreeAndNil(qryCliente);
  end;
end;

function TfrmPedidoDeCompraImpAutcom.fUtilizaPrecoArquivo: Boolean;
var
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  strCodCnd: string;
  strCodFpg: string;
  intIndice: Integer;
  fltTotQtd: Double;
  fltTotSug: Double;
  fltTotArq: Double;
begin
  try
    fltTotQtd := 0;
    fltTotSug := 0;
    fltTotArq := 0;
    strCodCnd := fRetCodCnd(FstrConPgt, VS_strCodEmp);
    strCodFpg := fRetCodFpg(strCodCnd);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(136);
    objLiberacao.objMsgLibera.pAddTexto('Importação de Pedido de Compra - Autcom - Utilizar preços definidos no arquivo para gravação do Pedido de Venda', alCentro, teAmbos, '', 136);
    objLiberacao.objMsgLibera.pAddSeparador(136);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , FstrCodCli + ' - ' + FstrNomCli, 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Condição de Pagamento'  , strCodCnd + ' - ' + fRetDesConPag(strCodCnd), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption(''  , fRetornaCndPagFormatado(FstrConPgt), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento'  , strCodFpg + ' - ' + fRetDescFpg(strCodFpg), 25);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Produto'                        , 65 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Marca'                          , 15 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Quantidade'                     , 10 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Preço Tab. Sug. Fat.'           , 20 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Preço Arquivo'                  , 15 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    for intIndice := 0 to High(arrItensTrava) do
    begin
      if (not fVerificaTravaItem(arrItensTrava[intIndice].strCodIte, arrItensTrava[intIndice].fltQtdIte)) then
        Continue;

      fltTotQtd := fltTotQtd + arrItensTrava[intIndice].fltQtdIte;
      fltTotSug := fltTotSug + arrItensTrava[intIndice].fltTbpSug;
      fltTotArq := fltTotArq + arrItensTrava[intIndice].fltTbpArq;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Produto'                       , arrItensTrava[intIndice].strCodIte + ' - ' + arrItensTrava[intIndice].strNomIte             , 65 , alEsquerda);
      objLinha.pAddColuna('Dt.Marca'                      , arrItensTrava[intIndice].strMarca                                                           , 15 , alEsquerda);
      objLinha.pAddColuna('Quantidade'                    , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), arrItensTrava[intIndice].fltQtdIte) , 10 , alDireita );
      objLinha.pAddColuna('Preço Tab. Sug. Fat.'          , FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), arrItensTrava[intIndice].fltTbpSug) , 20 , alDireita );
      objLinha.pAddColuna('Preço Arquivo'                 , FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), arrItensTrava[intIndice].fltTbpArq) , 15 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    end;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''                              , 'Totais'                                                            , 82 , alEsquerda, teAutcom );
    objLinha.pAddColuna('Quantidade'                    ,  FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fltTotQtd) , 10 , alDireita            );
    objLinha.pAddColuna('Preço Tabela Sug. Faturamento' ,  FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltTotSug) , 20 , alDireita            );
    objLinha.pAddColuna('Preço Arquivo'                 ,  FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltTotArq) , 15 , alDireita            );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'PREDEF';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.strTitulo := 'Importação de Pedido de Compra Preço do Arquivo';

    Result := objLiberacao.fLibera;
  except
    Result := False;
  end;

end;

function TfrmPedidoDeCompraImpAutcom.fValidaCndPagTipoCliente(strCndPag,
  strCodCli: string; var strTipCli: string): Boolean;
var
  qryCndPag: TUniQuery;
  strCodCnd: string;
begin
  Result := False;
  strTipCli := EmptyStr;
  qryCndPag := fCriaQuery;

  try
    qryCndPag.Close;
    qryCndPag.SQL.Clear;
    qryCndPag.SQL.Add('SELECT CLI_TIPCLI');
    qryCndPag.SQL.Add('FROM CADCLI');
    qryCndPag.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryCndPag.ParamByName('CODCLI').AsString := strCodCli;
    qryCndPag.Open;

    if qryCndPag.IsEmpty then
      Exit;

    strTipCli := qryCndPag.FieldByName('CLI_TIPCLI').AsString;

    if fEmptyStr(strTipCli) then
      Exit;

    qryCndPag.Close;
    qryCndPag.SQL.Clear;
    qryCndPag.SQL.Add('SELECT CND_CODIGO');
    qryCndPag.SQL.Add('FROM CADCND');
    qryCndPag.SQL.Add('WHERE CND_CNDPAG = :CNDPAG');
    qryCndPag.SQL.Add('AND LOCATE(:CODEMP, CND_EMPACE) > 0');
    qryCndPag.ParamByName('CNDPAG').AsString := strCndPag;
    qryCndPag.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCndPag.Open;

    if qryCndPag.IsEmpty then
      Exit;

    strCodCnd := qryCndPag.FieldByName('CND_CODIGO').AsString;

    qryCndPag.Close;
    qryCndPag.SQL.Clear;
    qryCndPag.SQL.Add('SELECT * FROM TIPCND');
    qryCndPag.SQL.Add('WHERE TCN_CODTIP = :CODTIP');
    qryCndPag.SQL.Add('AND TCN_CODCND = :CODCND');
    qryCndPag.SQL.Add('AND TCN_CODEMP = :CODEMP');
    qryCndPag.ParamByName('CODTIP').AsString := strTipCli;
    qryCndPag.ParamByName('CODCND').AsString := strCodCnd;
    qryCndPag.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCndPag.Open;

    Result := not qryCndPag.IsEmpty;
  finally
    FreeAndNil(qryCndPag);
  end;
end;

function TfrmPedidoDeCompraImpAutcom.fValidaItensSemSaldo: Boolean;
var
  strSql: String;
  fltTbpSug,
  fltPrePro,
  fltTotSug: Double;
begin
  Result := True;

  if (not fCfgSis('IMPCSD', varBoolean)) then
    Exit;

  if not cdsDivergSaldo.Locate('MARCAD', 1, []) then
    Exit;

  If (fMensagem('AVISO!', 'Há itens sem saldo disponível marcados para não serem importados. Deseja continuar?', ['&Sim', '&Não'], 1) = 2) Then
    Exit(False);

  cdsDivergSaldo.Filtered := False;
  cdsDivergSaldo.Filter   := 'MARCAD=1';
  cdsDivergSaldo.Filtered := True;

  cdsDivergSaldo.First;

  while not cdsDivergSaldo.Eof do
  begin
    cdsItens.Locate('CODITE;QTDPED', VarArrayOf([cdsDivergSaldo.FieldByName('CODITE').AsString,
                                                 cdsDivergSaldo.FieldByName('QTDPED').AsFloat]), []);
    cdsItens.Delete;

    cdsDivergSaldo.Next;
  end;

  cdsItens.First;

  strSql := '';
  strSql := strSql + ' SELECT A.*, B.ITE_ITEATI ';
  strSql := strSql + ' FROM ITEGER A ';
  strSql := strSql + ' INNER JOIN CADITE B ON B.ITE_CODITE = A.ITE_CODITE ';
  strSql := strSql + ' WHERE A.ITE_CODITE = :CODITE ';
  strSql := strSql + ' AND A.ITE_CODEMP = :CODEMP ';

  qryCadIte.SQL.Text := strSql;

  FfltVlrTot := 0;
  FfltTotCus := 0;
  FfltTotMed := 0;
  FfltTbpSug := 0;
  SetLength(arrItens, 0);

  while not cdsItens.Eof do
  begin
    qryCadIte.Close;
    qryCadIte.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
    qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadIte.Open;

    FfltVlrTot := FfltVlrTot + cdsItens.FieldByName('VLRTOT').AsFloat;
    FfltTotCus := FfltTotCus + (cdsItens.FieldByName('QTDPED').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat);
    FfltTotMed := FfltTotMed + (cdsItens.FieldByName('QTDPED').AsFloat * qryCadIte.FieldByName('ITE_PREMED').AsFloat);

    fltTbpSug := qryCadIte.FieldByName('ITE_PREVE' + FstrTabPre).AsFloat;
    fltPrePro := fPrecoPromocao(qryCadIte.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('QTDPED').AsFloat);

    If fltPrePro > 0 Then
      fltTbpSug := fltPrePro;

    fltTotSug := fltTbpSug * cdsItens.FieldByName('QTDPED').AsFloat;
    FfltTbpSug := FfltTbpSug + fltTotSug;

    pAddItemArray(cdsItens.FieldByName('CODITE').AsString,
                  cdsItens.FieldByName('QTDPED').AsFloat,
                  cdsItens.FieldByName('VLRUNI').AsFloat,
                  cdsItens.FieldByName('VLRTOT').AsFloat);

    cdsItens.Next;
  end;
end;

function TfrmPedidoDeCompraImpAutcom.fValidaPedido(strNumDoc,
  strCodCli: String): Boolean;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATGOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FGO_NUMPOK = :NUMPOK AND ';
  strSQL := strSQL + '   FGO_CODCLI = :CODCLI  ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPOK').AsString := strNumDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    Result := (FieldByName('QTD').AsInteger <= 0);
    
  End;

End;

function TfrmPedidoDeCompraImpAutcom.fVerificaTravaItem(strCodIte: String;
  fltQtdIte: Double): Boolean;
var
  Item: TItensPed;
begin
  Result := False;

  for Item in arrItens do
  begin
    if (Item.strCodIte = strCodIte) and (Item.fltQtdPed = fltQtdIte) then
      Exit(True);
  end;
end;

procedure TfrmPedidoDeCompraImpAutcom.pAddCdsItens(strCodIte: String; fltQtdPed,
  fltVlrUni, fltVlrTot: Double);
begin
  cdsItens.Insert;
  cdsItens.FieldByName('CODITE').AsString := strCodIte;
  cdsItens.FieldByName('QTDPED').AsFloat  := fltQtdPed;
  cdsItens.FieldByName('VLRUNI').AsFloat  := fltVlrUni;
  cdsItens.FieldByName('VLRTOT').AsFloat  := fltVlrTot;
  cdsItens.Post;
end;

procedure TfrmPedidoDeCompraImpAutcom.pAddDivergSaldo(strCodIte,
  strDesIte: String; fltQtdPed, fltSalDis: Double);
begin
  cdsDivergSaldo.Append;
  cdsDivergSaldo.FieldByName('CODITE').AsString  := strCodIte;
  cdsDivergSaldo.FieldByName('DESITE').AsString  := strDesIte;
  cdsDivergSaldo.FieldByName('QTDPED').AsFloat   := fltQtdPed;
  cdsDivergSaldo.FieldByName('SALDIS').AsFloat   := fltSalDis;
  cdsDivergSaldo.FieldByName('MARCAD').AsInteger := 0;
  cdsDivergSaldo.Post;
end;

procedure TfrmPedidoDeCompraImpAutcom.pAddItemArray(strCodIte: String;
  fltQtdPed, fltVlrUni, fltVlrTot: Double);
begin
  SetLength(arrItens, Succ(Length(arrItens)));
  arrItens[High(arrItens)].strCodIte := strCodIte;
  arrItens[High(arrItens)].fltQtdPed := fltQtdPed;
  arrItens[High(arrItens)].fltVlrUni := fltVlrUni;
  arrItens[High(arrItens)].fltVlrTot := fltVlrTot;
end;

procedure TfrmPedidoDeCompraImpAutcom.pAddOcorrencia(intIndex: Integer; strNomeCampo, strErro: String; strTipo : Char);
begin
  cdsOcorrencias.Append;
  cdsOcorrenciasTIPO.Value          := AnsiChar(strTipo);
  cdsOcorrenciasLINHA.Value         := intIndex + 1;
  cdsOcorrenciasCAMPO.AsString      := strNomeCampo;
  cdsOcorrenciasOCORRENCIA.AsString := strErro;
  cdsOcorrencias.Post;

  Case strTipo Of
    'E' : Inc(intErro);
    'A' : Inc(intAviso);
  End;

end;

procedure TfrmPedidoDeCompraImpAutcom.pCriaClientDivergSaldo;
begin
  cdsDivergSaldo := TUniClientDataSet.Create(Self);

  cdsDivergSaldo.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsDivergSaldo.FieldDefs.Add('DESITE', ftString, 50);
  cdsDivergSaldo.FieldDefs.Add('SALDIS', ftFloat);
  cdsDivergSaldo.FieldDefs.Add('QTDPED', ftFloat);
  cdsDivergSaldo.FieldDefs.Add('MARCAD', ftInteger);
  cdsDivergSaldo.CreateDataSet;

  (cdsDivergSaldo.FieldByName('SALDIS') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDivergSaldo.FieldByName('SALDIS') As TFloatField).EditFormat    := fMskDigitos(2);

  (cdsDivergSaldo.FieldByName('QTDPED') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDivergSaldo.FieldByName('QTDPED') As TFloatField).EditFormat    := fMskDigitos(2);

  dtsDivergSaldo.DataSet   := cdsDivergSaldo;
  frxDBDivergSaldo.DataSet := cdsDivergSaldo;
end;

procedure TfrmPedidoDeCompraImpAutcom.pCriaClientItens;
begin
  cdsItens := TUniClientDataSet.Create(Self);

  cdsItens.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsItens.FieldDefs.Add('QTDPED', ftFloat);
  cdsItens.FieldDefs.Add('VLRUNI', ftFloat);
  cdsItens.FieldDefs.Add('VLRTOT', ftFloat);
  cdsItens.CreateDataSet;
end;

procedure TfrmPedidoDeCompraImpAutcom.pDefinePrecoItens;
var
  blnLiberouPorTrava: Boolean;
  intIndiceItem: integer;
  intIndiceItemTrava: integer;
begin
  blnLiberouPorTrava := False;

  if rdgTabPre.ItemIndex = 1 then
  begin
    blnLiberouPorTrava := fUtilizaPrecoArquivo;
  end;

  if (not blnLiberouPorTrava) or (rdgTabPre.ItemIndex = 0) then
  begin
    for intIndiceItemTrava := Low(arrItensTrava) to High(arrItensTrava) do
    begin
      for intIndiceItem := Low(arrItens) to High(arrItens) do
      begin
        if (arrItensTrava[intIndiceItemTrava].strCodIte = arrItens[intIndiceItem].strCodIte) and (arrItensTrava[intIndiceItemTrava].fltQtdIte = arrItens[intIndiceItem].fltQtdPed) then
        begin
          arrItens[intIndiceItem].fltVlrUni := arrItensTrava[intIndiceItemTrava].fltTbpSug;
          arrItens[intIndiceItem].fltVlrTot := arrItensTrava[intIndiceItemTrava].fltTotSug;
        end;
      end;
    end;
    FfltVlrTot := FfltTbpSug;
  end;
end;

Function TfrmPedidoDeCompraImpAutcom.pImportarArquivo(strArqName : String):Boolean;
  Var
    intCorre  : Integer;

    dtaGerArq : TDate;
    strNroPed : String;
    strAuxili : String;
    strNomArq : String;
begin
  Result := False;

  cdsDivergSaldo.EmptyDataSet;
  cdsItens.EmptyDataSet;
  pnlDivergSaldo.Visible := False;

  If Not FileExists(strArqName) Then
  Begin
    fMensagem('Erro', 'O Arquivo não Existe!',['%Ok'], 1, True);
    pLimpar;
    Exit;
  End;

  strNomArq := ExtractFileName(strArqName);
  strAuxili := Copy(ExtractFileName(strArqName), 1, 8);
  Insert('/', strAuxili, 3);
  Insert('/', strAuxili, 6);
  dtaGerArq := StrToDateDef(strAuxili, 0);

  strAuxili := Copy(ExtractFileName(strArqName), 10, 6);
  Insert(':', strAuxili, 3);
  Insert(':', strAuxili, 6);
  FdtaHorArq := StrToTimeDef(strAuxili, 0);

  strNroPed := trim(Copy(ExtractFileName(strArqName), 22, 12));

  if (dtaGerArq <= 0) or (FdtaHorArq <= 0) or (Length(strNroPed) <> 12) Then
  Begin
    fMensagem('Erro', 'Nome de Arquivo Inválido!', ['&OK']);
    pLimpar;
    Exit;
  End;


  Try
    Screen.Cursor := crHourGlass;
    cdsOcorrencias.DisableControls;
    stlArquivo := TStringList.Create;
    stlArquivo.LoadFromFile(strArqName);

    gauProgresso.MaxValue := stlArquivo.Count;
    gauProgresso.Progress := 0;
    For intCorre := 0 To stlArquivo.Count -1 Do
    Begin
      if intCorre = 0 Then
        pProcessaHeader(intCorre)
      Else if intCorre = stlArquivo.Count -1 Then
        pProcessaTrailler(intCorre)
      Else
        pProcessaDetail(intCorre);

      gauProgresso.AddProgress(1);

      Application.ProcessMessages;
    End;
    gpbLegendas.Visible := ((intErro > 0) or (intAviso > 0));
    btnConfirma.Enabled := (intErro = 0);
    rdgTabPre.Visible := True;
    pnlDivergSaldo.Visible := (btnConfirma.Enabled and (cdsDivergSaldo.RecordCount > 0));

    if pnlDivergSaldo.Visible then
      pMostraDivergenciasSaldo(strNomArq);

    Result := True;
  Finally
    FreeAndNil(stlArquivo);
    cdsOcorrencias.First;
    cdsOcorrencias.EnableControls;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmPedidoDeCompraImpAutcom.pLimpar;
begin
  If cdsOcorrencias.Active Then
    cdsOcorrencias.EmptyDataSet;
  if not cdsOcorrencias.Active Then
    cdsOcorrencias.Active := True;

  cdsDivergSaldo.EmptyDataSet;
  cdsItens.EmptyDataSet;
  pnlDivergSaldo.Visible := False;

  intErro    := 0;
  intAviso   := 0;
  FintQtdDet := 0;
  FfltVlrTot := 0;
  FfltTotCus := 0;
  FfltTotMed := 0;
  FfltTbpSug := 0;
  FfltTotSug := 0;

  flnArqTxt.Clear;
  gpbLegendas.Visible   := False;
  btnConfirma.Enabled   := False;
  rdgTabPre.Visible     := False;
  flnArqTxt.Enabled     := True;
  gauProgresso.Progress := 0;

  SetLength(arrItens, 0);
  SetLength(arrItensTrava, 0);

end;

procedure TfrmPedidoDeCompraImpAutcom.pMarcaDesmarcaDivergSaldo;
begin
  cdsDivergSaldo.Edit;

  if (cdsDivergSaldo.FieldByName('MARCAD').AsInteger = 0) then
    cdsDivergSaldo.FieldByName('MARCAD').AsInteger := 1
  else
    cdsDivergSaldo.FieldByName('MARCAD').AsInteger := 0;

  cdsDivergSaldo.Post;
end;

procedure TfrmPedidoDeCompraImpAutcom.pMostraDivergenciasSaldo(strNomArq: String);
var
  LNomImp,
  LTipImp: String;
  LReport: TfrxReport;
begin
  if cdsDivergSaldo.IsEmpty then
    Exit;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  LNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  LTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  LReport := frxReportM;

  if LTipImp <> 'M' then
  begin
    LReport := frxReportJ;
    TfrxMemoView(LReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  end;

  LReport.Script.Variables['NOMEMP'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
  LReport.Script.Variables['NOMREL'] := 'APURAÇÃO DE SALDO DE PRODUTOS DO PEDIDO DE COMPRA - ' + strNomArq;
  LReport.Script.Variables['OPERADOR'] := 'Operador: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
  pPreviewReport(Self.Name, 'Apuração de Saldo de Produtos do Pedido de Compra - ' + strNomArq, LReport);
end;

procedure TfrmPedidoDeCompraImpAutcom.pPegaCampo(strNomeCampo: String; var dtaResult: TDate;
  intIndex, intPosIni, intQtde: Integer);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strLinha := Copy(strLinha, intPosIni, intQtde);
    dtaResult := StrToDate(strLinha)
  Except
    On E : Exception Do
    Begin
      pAddOcorrencia(intIndex, strNomeCampo, e.Message, 'E');
      dtaResult := 0;
    End;
  End;

end;

procedure TfrmPedidoDeCompraImpAutcom.pPegaCampo(strNomeCampo: String; var fltResult: Double;
  intIndex, intPosIni, intQtde: Integer);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strLinha := Copy(strLinha, intPosIni, intQtde);
    Insert(',', strLinha, Length(strLinha)-1);
    fltResult := fStrToFloat(strLinha);
  Except
    On E : Exception Do
    Begin
      pAddOcorrencia(intIndex, strNomeCampo, e.Message, 'E');
      fltResult := 0;
    End;
  End;

end;

procedure TfrmPedidoDeCompraImpAutcom.pPegaCampo(strNomeCampo: String; var intResult: Integer;
  intIndex, intPosIni, intQtde: Integer);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strLinha := Copy(strLinha, intPosIni, intQtde);
    intResult := StrToInt(strLinha);
  Except
    On E : Exception Do
    Begin
      pAddOcorrencia(intIndex, strNomeCampo, e.Message, 'E');
      intResult := 0;
    End;
  End;

end;

procedure TfrmPedidoDeCompraImpAutcom.pPegaCampo(strNomeCampo: String; var strResult: String;
  intIndex, intPosIni, intQtde: Integer);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strResult := Trim(Copy(strLinha, intPosIni, intQtde));
  Except
    On E : Exception Do
    Begin
      pAddOcorrencia(intIndex, strNomeCampo, e.Message, 'E');
      strResult := '';
    End;
  End;

end;

procedure TfrmPedidoDeCompraImpAutcom.pProcessaHeader(intIndex: Integer);
  Var
    intIdenti : Integer;
    strSql    : String;
    qryCadCli : TUniQuery;
    strTipCli : String;
    strNomTip : String;
begin
  If Pos('/', stlArquivo[intIndex]) = 17 Then
    intIncPos := 0
  Else
    intIncPos := -6;

  pPegaCampo('Identificação'                    , intIdenti , intIndex, 001, 02);
  pPegaCampo('Numero do Pedido de Compra'       , FstrNroPed, intIndex, 003, 12 + intIncPos);
  pPegaCampo('Data de emissão do Pedido'        , FdtaEmissa, intIndex, 015 + intIncPos, 10);
  pPegaCampo('Data de previsao de entrega'      , FdtaPrevis, intIndex, 025 + intIncPos, 10);
  pPegaCampo('Condição de Pagamento'            , FstrConPgt, intIndex, 035 + intIncPos, 38);
  pPegaCampo('Código interno do transmissor'    , FstrCodCli, intIndex, 073 + intIncPos, 08);
  pPegaCampo('Razão social do transmissor'      , FstrNomCli, intIndex, 081 + intIncPos, 40);
  pPegaCampo('CNPJ do transmissor'              , FstrCgcCli, intIndex, 121 + intIncPos, 14);
  pPegaCampo('Inscrição Estadual do transmissor', FstrIE_Cli, intIndex, 135 + intIncPos, 18);
  pPegaCampo('Endereço do transmissor'          , FstrEndere, intIndex, 153 + intIncPos, 50);
  pPegaCampo('Bairro'                           , FstrBairro, intIndex, 203 + intIncPos, 30);
  pPegaCampo('Cidade'                           , FstrCidade, intIndex, 233 + intIncPos, 40);
  pPegaCampo('Estado'                           , FstrEstado, intIndex, 273 + intIncPos, 02);
  pPegaCampo('CEP'                              , FstrCEP   , intIndex, 275 + intIncPos, 08);

  If intIdenti <> 1 Then
    pAddOcorrencia(intIndex, 'Identificação', 'Identificação de Header Inválido!', 'E');

  If Not fValidaPedido(FstrNroPed, FstrCodCli) Then
    pAddOcorrencia(intIndex, 'Numero do Pedido', 'Pedido já existe!', 'E');

  if (FdtaPrevis <= VS_Date) then
    pAddOcorrencia(intIndex, 'Data de previsao de entrega', 'Data de previsao de entrega do Pedido inferior ou igual que a data atual!', 'A');

  If Not fValidaCndPag(FstrConPgt) Then
    pAddOcorrencia(intIndex, 'Condição de Pagamento', 'Valor Informado é Inválido!', 'E');

  If fCfgSis('USATPC', VarBoolean) Then
    If Not fValidaCndPagTipoCliente(FstrConPgt, FstrCodCli, strTipCli) Then
    Begin
      strNomTip := fRetDescTipoCli(strTipCli);
      pAddOcorrencia(intIndex, 'Condição de Pagamento', 'Prazo da condição do arquivo ('+fRetornaCndPagFormatado(FstrConPgt)+') não foi encontrado dentro das condições definidas para o tipo do cliente (Tipo '+strTipCli+' - '+strNomTip+'). Ajuste o prazo no arquivo ou o tipo do cliente e depois refaça a importação!', 'E');
    End;

  if fEmptyStr(fRetNomCliente(FstrCodCli)) Then
    pAddOcorrencia(intIndex, 'Código interno do transmissor', 'Transmissor informado não encontrado no cadastro de Clientes!', 'E')
  Else
  Begin
    // Caso encontrou o cliente confirma os dados!
    try
      strSql := '';
      strSql := strSql + ' SELECT * FROM CADCLI ';
      strSql := strSql + ' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      strSql := strSql + ' WHERE CLI_CODCLI = :CODCLI';
      qryCadCli := fCriarQuery(strSql, Self);
      With qryCadCli Do
      Begin
        ParamByName('CODCLI').AsString := FstrCodCli;

        Open;

        if (not fEmptyStr(FieldByName('CLI_TABPRE').AsString)) And (fSistemaUsaEssaTabelaPreco(FieldByName('CLI_TABPRE').AsString[1])) And (fFaturamentoUsaEssaTabelaPreco(FieldByName('CLI_TABPRE').AsString[1])) Then
          FstrTabPre := FieldByName('CLI_TABPRE').AsString[1];

        if fEmptyStr(FstrTabPre) then
          FstrTabPre := fRetornaTabelasPreco(FstrConPgt);

        If (FieldByName('CLI_NOMCLI').AsString <> FstrNomCli) then
          pAddOcorrencia(intIndex, 'Razão social do transmissor', 'Cadastro com Valor Divergente do Arquivo! ('+ FstrNomCli +')', 'A');

        If (FieldByName('CLI_C_G_C_').AsString <> FstrCgcCli) then
          pAddOcorrencia(intIndex, 'CNPJ do transmissor', 'Cadastro com Valor Divergente do Arquivo! ('+ fFormataCpfCgc(FstrCgcCli, fSetaPais) +')', 'A');

        If (FieldByName('CLI_I_E_S_').AsString <> FstrIE_Cli) then
          pAddOcorrencia(intIndex, 'Inscrição Estadual do transmissor', 'Cadastro com Valor Divergente do Arquivo! ('+ FstrIE_Cli +')', 'A');

//        If (FieldByName('CLI_ENDERE').AsString <> strEndere) then
//          pAddOcorrencia(intIndex, 'Endereço do transmissor', 'Cadastro com Valor Divergente do Arquivo! ('+ strEndere +')', 'A');

        If (FieldByName('CLI_BAIRRO').AsString <> FstrBairro) then
          pAddOcorrencia(intIndex, 'Bairro', 'Cadastro com Valor Divergente do Arquivo! ('+ FstrBairro +')', 'A');

        If (FieldByName('CID_NOMCID').AsString <> FstrCidade) then
          pAddOcorrencia(intIndex, 'Cidade', 'Cadastro com Valor Divergente do Arquivo! ('+ FstrCidade +')', 'A');

        If (FieldByName('CID_ESTADO').AsString <> FstrEstado) then
          pAddOcorrencia(intIndex, 'Estado', 'Cadastro com Valor Divergente do Arquivo! ('+ FstrEstado +')', 'A');

        If (FieldByName('CLI_C_E_P_').AsString <> FstrCEP) then
          pAddOcorrencia(intIndex, 'CEP', 'Cadastro com Valor Divergente do Arquivo! ('+ fFormataCEP(FstrCEP) +')', 'A');

      End;
    Finally
      FreeAndNil(qryCadCli);
    End;

  End;


end;

procedure TfrmPedidoDeCompraImpAutcom.pProcessaDetail(intIndex: Integer);
  Var
    intIdenti : Integer;

    strSql,
    strNroPed,
    strCodFab,
    strCodBar : String;

    fltTbpSug,
    fltTotSug,
    fltQtde,
    fltVlrUni,
    fltVlrTot,
    fltPrePro : Double;

    intCalSal: Integer;
    blnEntFut,
    blnOrdPro: Boolean;

    FrecSaldos,
    FrecSaldosML: TRecSaldos;
    objSalLoj: TSaldoLojas;

  procedure addItemTrava(strCodIte: string; fltQtdPed, fltTbpSug, fltTbpArq, fltTotSug, fltTotArq: Double);
  Begin
    SetLength(arrItensTrava, Succ(Length(arrItensTrava)));
    arrItensTrava[High(arrItensTrava)].strCodIte := strCodIte;
    arrItensTrava[High(arrItensTrava)].strNomIte := fRetNomProduto(strCodIte);
    arrItensTrava[High(arrItensTrava)].strMarca  := fRetNomMarca(fRetMarcaItem(strCodIte));
    arrItensTrava[High(arrItensTrava)].fltQtdIte := fltQtdPed;
    arrItensTrava[High(arrItensTrava)].fltTbpSug := fltTbpSug;
    arrItensTrava[High(arrItensTrava)].fltTbpArq := fltTbpArq;
    arrItensTrava[High(arrItensTrava)].fltTotSug := fltTotSug;
    arrItensTrava[High(arrItensTrava)].fltTotArq := fltTotArq;
  End;
begin
  objSalLoj := TSaldoLojas.Create(Self);

  try
    intCalSal := fCfgSis('CALSAL', varInteger);
    blnEntFut := fCfgSis('ENTFUT', varBoolean);
    blnOrdPro := fCfgSis('ORDPRO', varBoolean);

    pPegaCampo('Identificação'             , intIdenti, intIndex, 01, 02);
    pPegaCampo('Numero do Pedido de Compra', strNroPed, intIndex, 03, 12 + intIncPos);
    pPegaCampo('Código de Fábrica'         , strCodFab, intIndex, 15 + intIncPos, 25);
    pPegaCampo('Código de Barras'          , strCodBar, intIndex, 40 + intIncPos, 15);
    pPegaCampo('Quantidade'                , fltQtde  , intIndex, 55 + intIncPos, 13);
    pPegaCampo('Valor Unitário'            , fltVlrUni, intIndex, 68 + intIncPos, 13);
    pPegaCampo('Valor Total do Produto'    , fltVlrTot, intIndex, 81 + intIncPos, 13);
    Inc(FintQtdDet);

    If intIdenti <> 2 Then
      pAddOcorrencia(intIndex, 'Identificação', 'Identificação do Detail Inválido!', 'E');

    If strNroPed <> FstrNroPed Then
      pAddOcorrencia(intIndex, 'Numero do Pedido de Compra', 'Numero do Pedido Contido no Detail Difere do Header', 'E');

    strSql := '';
    strSql := strSql + ' SELECT A.*, B.ITE_DESITE, B.ITE_ITEATI ';
    strSql := strSql + '  FROM ITEGER A ';
    strSql := strSql + '  INNER JOIN CADITE B ON B.ITE_CODITE = A.ITE_CODITE ';
    strSql := strSql + ' WHERE ITE_CODBAR = :CODBAR ';
    strSql := strSql + ' AND A.ITE_CODEMP = :CODEMP ';

    qryCadIte.SQL.Text := strSql;
    With qryCadIte Do
    Begin
      ParamByName('CODBAR').AsString := strCodBar;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        fltTbpSug := FieldByName('ITE_PREVE' + FstrTabPre).AsFloat;
        fltTotSug := fltTbpSug * fltQtde;

        FfltTotCus := FfltTotCus + (fltQtde * FieldByName('ITE_PRECUS').AsFloat);
        FfltTotMed := FfltTotMed + (fltQtde * FieldByName('ITE_PREMED').AsFloat);

        fltPrePro := fPrecoPromocao(FieldByName('ITE_CODITE').AsString, fltQtde);
        If fltPrePro > 0 Then
        Begin
          fltTbpSug := fltPrePro;
          fltTotSug := fltPrePro * fltQtde;
        End;

        FfltVlrTot := FfltVlrTot + fltVlrTot;
        FfltTbpSug := FfltTbpSug + fltTotSug;

        if (fltTbpSug > fltVlrUni) Then
          pAddOcorrencia(intIndex, 'Valor Unitário', 'Valor Unitário Informado no arquivo inferior ao Valor de Venda, Diferença: ' + FormatFloat('#,##0.00', fltTbpSug - fltVlrUni), 'A');

        if FieldByName('ITE_ITEATI').AsString = 'N' then
          pAddOcorrencia(intIndex, 'Produto', 'Produto '+FieldByName('ITE_CODITE').AsString+' está inativo sendo assim, não é permitido importar o pedido. Ajuste o status do produto na aba "Complementos" do cadastro do produto e depois realize novamente a importação!', 'E');

        pAddItemArray(FieldByName('ITE_CODITE').AsString, fltQtde, fltVlrUni, fltVlrTot);
        pAddCdsItens(FieldByName('ITE_CODITE').AsString, fltQtde, fltVlrUni, fltVlrTot);

        addItemTrava(FieldByName('ITE_CODITE').AsString, fltQtde, fltTbpSug, fltVlrUni, fltTotSug, fltVlrTot);

        if (fCfgSis('IMPCSD', varBoolean)) then
        begin
          objSalLoj.pCalculaSaldos(qryCadIte,
                                   FrecSaldos, FrecSaldosML,
                                   qryCadIte.FieldByName('ITE_SALDOS').AsFloat, VS_strCodEmp, VS_strCodEmp,
                                   FieldByName('ITE_CODITE').AsString, 0,
                                   blnEntFut, False, blnOrdPro, intCalSal);

          if (fltQtde > FrecSaldos.fltSalDis) then
            pAddDivergSaldo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_DESITE').AsString, fltQtde, FrecSaldos.fltSalDis);
        end;
      End
      Else
        pAddOcorrencia(intIndex, 'Código de Barras', 'Produto com Código de Barras ' + strCodBar + ' Não Encontrado!', 'E');
    End;
  finally
    FreeAndNil(objSalLoj);
  end;
end;

procedure TfrmPedidoDeCompraImpAutcom.pProcessaTrailler(intIndex: Integer);
  Var
    intIdenti : Integer;
    intQtdPed : Integer;
    strNroPed : String;
    fltVlrTot : Double;
    fltDiferenca : Double;
begin
  pPegaCampo('Identificação'                , intIdenti, intIndex, 01, 02);
  pPegaCampo('Numero do Pedido de Compra'   , strNroPed, intIndex, 03, 12 + intIncPos);
  pPegaCampo('Quantidade de Itens no Pedido', intQtdPed, intIndex, 15 + intIncPos, 13);
  pPegaCampo('Valor Total do Pedido'        , fltVlrTot, intIndex, 28 + intIncPos, 13);

  If intIdenti <> 99 Then
    pAddOcorrencia(intIndex, 'Identificação', 'Identificação do Trailler Inválido!', 'E');

  If strNroPed <> FstrNroPed Then
    pAddOcorrencia(intIndex, 'Numero do Pedido de Compra', 'Numero do Pedido Contido no Trailler Difere do Header', 'E');

  if (intQtdPed <> FintQtdDet) Then
    pAddOcorrencia(intIndex, 'Quantidade de Itens no Pedido', 'Valor Divergente', 'E');

  fltDiferenca := fFormataFloat(fltVlrTot, 2) - fFormataFloat(FfltVlrTot, 2);

  If (fFormataFloat(fltDiferenca, 2) <> 0.00) Then
    pAddOcorrencia(intIndex, 'Valor Total do Pedido', 'Valor Divergente, Diferença: ' + FloatToStrF(fltDiferenca, ffFixed, 12, 4), 'E');
end;

end.
