{************************************************}
{  IMPORTAÇÂO DE LAYOUT PEDIDO DE COMPRAS ALESSI }
{  E GRAVAÇAO NOS PEDIDOS DE VENDA               }
{                                                }
{ AUTOR : GUILHERME BORGES                       }
{ DATA: 14/11/2012                               }
{************************************************}

unit untPedidoDeCompraImpEdiSawluz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Gauges, Mask, FilenameEditFocus, StrUtils, Uni,
  DB, UniClientDataSet, Grids, DBGridCitel, DBGrids, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Datasnap.DBClient, cxTextEdit, untLiberacao, untMsgLiberacao,
  cxMaskEdit, cxButtonEdit, System.Types, System.Math;

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

  TfrmPedidoDeCompraImpEdiSawluz = class(TfrmPaiSimples)
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
    procedure flnArqTxtAfterDialog(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLimpaClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure flnArqTxtExit(Sender: TObject);
  private
    qryCadIte : TUniQuery;

    arrItens   : Array of TItensPed;
    stlArquivo : TStringList;
    intErro    : Integer;
    intAviso   : Integer;
    qryGenerica: TUniQuery;

    FdtaEmissa: TDate;

    arrItensTrava: Array of TItensTrava;

    FstrNroCon,
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

    FintCasDec,
    FintQtdPed,
    FintQtdDet : Integer;

    FfltTbpSug,
    FfltTotSug,
    FfltVlrTot,
    FfltTotCus,
    FfltTotMed : Double;

    FdtaHorArq : TTime;
    FstrTabPre : String;

    objLiberacao : TLiberacao;

    Function  pImportarArquivo(strArqName : String): Boolean;
    Procedure pProcessaHeader(intIndex: Integer);
    Procedure pProcessaIdentificacaoGeral(intIndex: Integer);
    Procedure pProcessaDetail(intIndex: Integer);
    Procedure pProcessaTrailler(intIndex: Integer);

    Procedure pPegaCampo(strNomeCampo: String; Var fltResult : Double ; intIndex, intPosIni, intQtde : Integer; blnQtd: Boolean = False); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var dtaResult : TDate  ; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var strResult : String ; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pPegaCampo(strNomeCampo: String; Var intResult : Integer; intIndex, intPosIni, intQtde : Integer); overload;
    Procedure pAddOcorrencia(intIndex: Integer; strNomeCampo, strErro: String; strTipo : Char);

    Procedure pLimpar;

    function fValidaPedido(strNumDoc, strCodCli : String): Boolean;
    function fGravaPedido:Boolean;
    function fGravaItem(recDados : TItensPed; strAutFdo : String):Boolean;
    function fRetornaVendedorRepresentanteCliente(strCodCli, strBusca: string):String;
    procedure pDefinePrecoItens;
    function fRetornaTabelasPreco(strCndPag: string): string;
    function fUtilizaPrecoArquivo: Boolean;
    function fCondicaoPagtoClienteSugestao(strCodCli: String): String;
    function fPrecoPromocao(strCodIte: String; fltQtde: Double) : Double;
    procedure AddItem(strCodIte: String; fltQtdPed, fltVlrUni,
      fltVlrTot: Double);
    procedure addItemTrava(strCodIte: string; fltQtdPed, fltTbpSug, fltTbpArq,
      fltTotSug, fltTotArq: Double);

    function fValidarMultiploVenda(): Boolean;
  public
    { Public declarations }
  end;

var
  frmPedidoDeCompraImpEdiSawluz: TfrmPedidoDeCompraImpEdiSawluz;

implementation

uses untFuncoesSimples, untFatGor, untFuncoesGenerica, untConstantes, untTypesSistema,
  untCadPro, untFuncFatTypes, untFuncFatImp, untTravaMultiploVenda, untObservacao, untFuncFat;

{$R *.dfm}

procedure TfrmPedidoDeCompraImpEdiSawluz.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Try
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

procedure TfrmPedidoDeCompraImpEdiSawluz.btnLimpaClick(Sender: TObject);
begin
  inherited;
  pLimpar;
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.DBGrid1DrawColumnCell(Sender: TObject;
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

function TfrmPedidoDeCompraImpEdiSawluz.fGravaItem(recDados: TItensPed; strAutFdo : String): Boolean;
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

    qryGenerica.Close;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Add(strSQL);
    qryGenerica.ParamByName('CODITE').AsString := recDados.strCodIte;
    qryGenerica.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGenerica.Open;

    strTipAbf := fGetTipoAbfFornecedor(FstrCodCli);

    fValidaCodAbf(qryGenerica.FieldByName('CODABF').AsString, FstrEstado, strTipAbf, strCodSit);

    strClaFis := IIF(fCadEmp('ESTADO') = FstrEstado, '5', '6');
    strClaFis := strClaFis + IIF( Pos(strCodSit, CST_SUBSTITUICAO) > 0, '405', '102');

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
                 FstrConPgt,                                                                                            //  strCodCnd
                 '',                                                                                                   //  strProEmb
                 '',                                                                                            //  strCodFpg
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

function TfrmPedidoDeCompraImpEdiSawluz.fGravaPedido: Boolean;
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
                 fRetCodCnd(FstrConPgt),                                                                      //  strCodCnd
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

    For intCorre := 0 To High(arrItens) Do
    Begin
      Result := fGravaItem(arrItens[intCorre], strAutInc);
      If Not Result Then
        Break;
      gauProgresso.AddProgress(1);      
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

procedure TfrmPedidoDeCompraImpEdiSawluz.flnArqTxtAfterDialog(Sender: TObject);
begin
  inherited;
  flnArqTxt.Enabled := False;
  pImportarArquivo(flnArqTxt.Dialog.Dialog.FileName);
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.flnArqTxtExit(Sender: TObject);
begin
  inherited;
  If (FileExists(flnArqTxt.Text)) Then
  Begin
    flnArqTxt.Enabled := False;
    pImportarArquivo(flnArqTxt.Text);
  End;
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOcorrencias.CreateDataSet;

  pLimpar;
  qryGenerica := fCriaQuery(Self);

  flnArqTxt.Dialog.Dialog.Filter := 'Aquivos de Texto (*.txt)|*.Txt|Todos Arquivos (*.*)|*.*';
  flnArqTxt.Dialog.OnAccept := flnArqTxtAfterDialog;
  qryCadIte := fCriaQuery();


  objLiberacao := TLiberacao.Create;
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCadIte);
  inherited;
  FreeAndNil(qryGenerica);

  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
end;

function TfrmPedidoDeCompraImpEdiSawluz.fRetornaTabelasPreco(
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

function TfrmPedidoDeCompraImpEdiSawluz.fRetornaVendedorRepresentanteCliente(
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

function TfrmPedidoDeCompraImpEdiSawluz.fUtilizaPrecoArquivo: Boolean;
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
    strCodCnd := fRetCodCnd(FstrConPgt);
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

function TfrmPedidoDeCompraImpEdiSawluz.fValidaPedido(strNumDoc,
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

  qryGenerica.Close;
  qryGenerica.SQL.Clear;
  qryGenerica.SQL.Add(strSQL);
  qryGenerica.ParamByName('NUMPOK').AsString := strNumDoc;
  qryGenerica.ParamByName('CODCLI').AsString := strCodCli;
  qryGenerica.Open;

  Result := (qryGenerica.FieldByName('QTD').AsInteger <= 0);

End;

procedure TfrmPedidoDeCompraImpEdiSawluz.pAddOcorrencia(intIndex: Integer; strNomeCampo, strErro: String; strTipo : Char);
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

procedure TfrmPedidoDeCompraImpEdiSawluz.pDefinePrecoItens;
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

Function TfrmPedidoDeCompraImpEdiSawluz.pImportarArquivo(strArqName : String):Boolean;
  Var
    intCorre  : Integer;
begin
  Result := False;
  If Not FileExists(strArqName) Then
  Begin
    fMensagem('Erro', 'O Arquivo não Existe!',['%Ok'], 1, True);
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
      Else if intCorre = 1 Then
        pProcessaIdentificacaoGeral(intCorre)
      Else if intCorre = stlArquivo.Count -1 Then
        pProcessaTrailler(intCorre)
      Else
        pProcessaDetail(intCorre);

      gauProgresso.AddProgress(1);

      Application.ProcessMessages;
    End;

    gpbLegendas.Visible := ((intErro > 0) or (intAviso > 0));
    btnConfirma.Enabled := (intErro = 0) And fValidarMultiploVenda();
    rdgTabPre.Visible := False; //True;

    Result := True;
  Finally
    FreeAndNil(stlArquivo);
    cdsOcorrencias.First;
    cdsOcorrencias.EnableControls;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.pLimpar;
begin
  If cdsOcorrencias.Active Then
    cdsOcorrencias.EmptyDataSet;
  if not cdsOcorrencias.Active Then
    cdsOcorrencias.Active := True;

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

procedure TfrmPedidoDeCompraImpEdiSawluz.pPegaCampo(strNomeCampo: String; var dtaResult: TDate;
  intIndex, intPosIni, intQtde: Integer);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strLinha := Copy(strLinha, intPosIni, intQtde);

    dtaResult := StrToDate(Copy(strLinha, 5, 2) + '/' +
                           Copy(strLinha, 3, 2) + '/' +
                           Copy(strLinha, 1, 2));

//    dtaResult := StrToDate(strLinha);
  Except
    On E : Exception Do
    Begin
      pAddOcorrencia(intIndex, strNomeCampo, e.Message, 'E');
      dtaResult := 0;
    End;
  End;

end;

procedure TfrmPedidoDeCompraImpEdiSawluz.pPegaCampo(strNomeCampo: String; var fltResult: Double;
  intIndex, intPosIni, intQtde: Integer; blnQtd: Boolean = False);
  Var
    strLinha : String;
begin
  try
    strLinha := stlArquivo[intIndex];
    strLinha := Copy(strLinha, intPosIni, intQtde);
    if blnQtd then
      Insert(',', strLinha, Length(strLinha) + 1 - FintCasDec)
    else
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

procedure TfrmPedidoDeCompraImpEdiSawluz.pPegaCampo(strNomeCampo: String; var intResult: Integer;
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

procedure TfrmPedidoDeCompraImpEdiSawluz.pPegaCampo(strNomeCampo: String; var strResult: String;
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

procedure TfrmPedidoDeCompraImpEdiSawluz.pProcessaHeader(intIndex: Integer);
  Var
    strIdenti : String;
begin
  pPegaCampo('Identificação'                    , strIdenti , intIndex, 001, 03);
  pPegaCampo('Numero de Controle de Transmissão', FstrNroCon, intIndex, 009, 05);
  pPegaCampo('Razão social do transmissor'      , FstrNomCli, intIndex, 070, 25);
  pPegaCampo('CNPJ do transmissor'              , FstrCgcCli, intIndex, 026, 14);
  pPegaCampo('CNPJ do transmissor'              , FstrCgcCli, intIndex, 026, 14);

  If strIdenti <> 'ITP' Then
    pAddOcorrencia(intIndex, 'Identificação', 'Identificação de header inválido!', 'E');

  FstrCodCli := fRetClientePorCgcCpf(IIF(Length(FstrCgcCli) = 11,'2','1'), FstrCgcCli);
  if fEmptyStr(FstrCodCli) Then
    pAddOcorrencia(intIndex, 'Código Interno do Transmissor', 'Transmissor informado não encontrado no cadastro de clientes!', 'E');
end;

procedure TfrmPedidoDeCompraImpEdiSawluz.pProcessaIdentificacaoGeral(intIndex: Integer);
  Var
    strIdenti : String;
    strSql    : String;
    qryCadCli : TUniQuery;
begin
  pPegaCampo('Identificação'                    , strIdenti , intIndex, 001, 03);
  pPegaCampo('Quantidade de Itens no Pedido'    , FintQtdPed, intIndex, 004, 04);
  pPegaCampo('Quantidade de Casas Decimais'     , FintCasDec, intIndex, 008, 01);
  pPegaCampo('Numero do Pedido de Compra'       , FstrNroPed, intIndex, 009, 12);
  pPegaCampo('Data de emissão do Pedido'        , FdtaEmissa, intIndex, 021, 06);

  If strIdenti <> 'PP1' Then
    pAddOcorrencia(intIndex, 'Identificação', 'Identificação de header inválido!', 'E');

  If Not fValidaPedido(FstrNroPed, FstrCodCli) Then
    pAddOcorrencia(intIndex, 'Número do Pedido', 'Pedido já existe no sistema!', 'E');

  FstrConPgt := fCondicaoPagtoClienteSugestao(FstrCodCli);

  if not fEmptyStr(fRetNomCliente(FstrCodCli)) Then
  Begin
    // Caso encontrou o cliente confirma os dados!
    try
      strSql := '';
      strSql := strSql + ' SELECT * FROM CADCLI ';
      strSql := strSql + ' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      strSql := strSql + ' WHERE CLI_CODCLI = :CODCLI';
      qryCadCli := fCriarQuery(strSql, Self);
      qryCadCli.ParamByName('CODCLI').AsString := FstrCodCli;

      qryCadCli.Open;

      if (not fEmptyStr(qryCadCli.FieldByName('CLI_TABPRE').AsString)) And (fSistemaUsaEssaTabelaPreco(qryCadCli.FieldByName('CLI_TABPRE').AsString[1])) And (fFaturamentoUsaEssaTabelaPreco(qryCadCli.FieldByName('CLI_TABPRE').AsString[1])) Then
        FstrTabPre := qryCadCli.FieldByName('CLI_TABPRE').AsString[1];

      if fEmptyStr(FstrTabPre) then
        FstrTabPre := fRetornaTabelasPreco(FstrConPgt);

      If (qryCadCli.FieldByName('CLI_NOMCLI').AsString <> FstrNomCli) then
        pAddOcorrencia(intIndex, 'Razão Social do Transmissor', 'O nome do cliente no arquivo está diferente no cadastro no sistema! ('+ FstrNomCli +')', 'A');

      If (qryCadCli.FieldByName('CLI_C_G_C_').AsString <> FstrCgcCli) then
        pAddOcorrencia(intIndex, 'CPF/CNPJ do Transmissor', 'O CPF/CNPJ do cliente no arquivo está diferente no cadastro no sistema! ('+ fFormataCpfCgc(FstrCgcCli, fSetaPais) +')', 'A');

      FstrIE_Cli := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
      FstrEndere := qryCadCli.FieldByName('CLI_ENDERE').AsString;
      FstrBairro := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
      FstrCidade := qryCadCli.FieldByName('CID_NOMCID').AsString;
      FstrEstado := qryCadCli.FieldByName('CID_ESTADO').AsString;
      FstrCEP    := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
    Finally
      FreeAndNil(qryCadCli);
    End;

  End;
end;

function TfrmPedidoDeCompraImpEdiSawluz.fPrecoPromocao(strCodIte: String; fltQtde: Double) : Double;
  Var
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
Begin
  Result := 0.00;
  If fRetornaPrecosPromocao(strCodIte,
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
                           '') Then
    Result := fltPreVen;
End;

procedure TfrmPedidoDeCompraImpEdiSawluz.AddItem(strCodIte : String; fltQtdPed, fltVlrUni, fltVlrTot : Double);
Begin
  SetLength(arrItens, Succ(Length(arrItens)));
  arrItens[High(arrItens)].strCodIte := strCodIte;
  arrItens[High(arrItens)].fltQtdPed := fltQtdPed;
  arrItens[High(arrItens)].fltVlrUni := fltVlrUni;
  arrItens[High(arrItens)].fltVlrTot := fltVlrTot;

End;

procedure TfrmPedidoDeCompraImpEdiSawluz.addItemTrava(strCodIte: string; fltQtdPed, fltTbpSug, fltTbpArq, fltTotSug, fltTotArq: Double);
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

procedure TfrmPedidoDeCompraImpEdiSawluz.pProcessaDetail(intIndex: Integer);
  Var
    strIdenti : String;

    strSql,
    strCodFab: String;

    fltTbpSug,
    fltTotSug,
    fltQtde,
    fltVlrUni,
    fltVlrTot,
    fltPrePro : Double;
begin
  pPegaCampo('Identificação'             , strIdenti, intIndex, 01, 03);

  If strIdenti <> 'PP2' Then
    Exit;

  pPegaCampo('Código de Fábrica'         , strCodFab, intIndex, 04, 30);
  pPegaCampo('Quantidade'                , fltQtde  , intIndex, 34, 09, True);
  pPegaCampo('Valor Unitário'            , fltVlrUni, intIndex, 68, 12);
//  pPegaCampo('Valor Total do Produto'    , fltVlrTot, intIndex, 81, 13);
  fltVlrTot := fltVlrUni * fltQtde;
  Inc(FintQtdDet);

  strSql := '';
  strSql := strSql + ' SELECT A.*, B.ITE_ITEATI ';
  strSql := strSql + '  FROM ITEGER A ';
  strSql := strSql + '  INNER JOIN CADITE B ON B.ITE_CODITE = A.ITE_CODITE ';
  strSql := strSql + ' WHERE ITE_CODFAB = :CODFAB ';
  strSql := strSql + ' AND A.ITE_CODEMP = :CODEMP ';

  qryCadIte.SQL.Text := strSql;

  qryCadIte.ParamByName('CODFAB').AsString := strCodFab;
  qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadIte.Open;

  If Not qryCadIte.IsEmpty Then
  Begin
    if not fEmptyStr(FstrTabPre) then
      fltTbpSug := qryCadIte.FieldByName('ITE_PREVE' + FstrTabPre).AsFloat
    else
      fltTbpSug := 0;

    fltTotSug := fltTbpSug * fltQtde;

    FfltTotCus := FfltTotCus + (fltQtde * qryCadIte.FieldByName('ITE_PRECUS').AsFloat);
    FfltTotMed := FfltTotMed + (fltQtde * qryCadIte.FieldByName('ITE_PREMED').AsFloat);

    fltPrePro := fPrecoPromocao(qryCadIte.FieldByName('ITE_CODITE').AsString, fltQtde);
    If fltPrePro > 0 Then
    Begin
      fltTbpSug := fltPrePro;
      fltTotSug := fltPrePro * fltQtde;
    End
    else
    if fRetDescontoCliente(FstrCodCli) > 0 then
    begin
      fltTbpSug := fltTbpSug - ((fltTbpSug * fRetDescontoCliente(FstrCodCli)) / 100);
      fltTotSug := fltTbpSug * fltQtde;
    end;

    FfltVlrTot := FfltVlrTot + fltVlrTot;
    FfltTbpSug := FfltTbpSug + fFormataFloat(fltTotSug, 2);


    if qryCadIte.FieldByName('ITE_ITEATI').AsString = 'N' then
      pAddOcorrencia(intIndex, 'Produto', 'Produto '+qryCadIte.FieldByName('ITE_CODITE').AsString+' está inativo, '
                                        + 'sendo assim, não é permitido importar o pedido. Ajuste o status '
                                        + 'do produto na aba "Complementos" do cadastro do produto e depois '
                                        + 'realize novamente a importação!', 'E');

    AddItem(qryCadIte.FieldByName('ITE_CODITE').AsString, fltQtde, fltVlrUni, fltVlrTot);

    addItemTrava(qryCadIte.FieldByName('ITE_CODITE').AsString, fltQtde, fltTbpSug, fltVlrUni, fltTotSug, fltVlrTot);


  End
  Else
    pAddOcorrencia(intIndex, 'Código de Fábrica', 'Produto com código de fábrica ' + strCodFab + ' não encontrado!', 'E');

end;

procedure TfrmPedidoDeCompraImpEdiSawluz.pProcessaTrailler(intIndex: Integer);
  Var
    strIdenti,
    strNroCon : String;
begin
  pPegaCampo('Identificação'                    , strIdenti, intIndex, 01, 03);
  pPegaCampo('Numero de Controle de Transmissão', strNroCon, intIndex, 04, 05);

  If strIdenti <> 'FTP' Then
    pAddOcorrencia(intIndex, 'Identificação', 'Identificação do trailler inválido!', 'E');

  If strNroCon <> FstrNroCon Then
    pAddOcorrencia(intIndex, 'Numero de Controle de Transmissão', 'Número de controle de transmissão no trailler difere do header!', 'E');

  if (FintQtdPed <> FintQtdDet) Then
    pAddOcorrencia(intIndex, 'Quantidade de Itens no Pedido', Format('Nas informações gerais do arquivos, consta que deve existir %s '
                                                                    +'produtos, porém foram encontrados %s dentro do arquivo. É '
                                                                    +'necessário que no arquivo as duas informações estejam '
                                                                    +'iguais!' ,[FintQtdPed.ToString,FintQtdDet.ToString]), 'E');

end;

function TfrmPedidoDeCompraImpEdiSawluz.fCondicaoPagtoClienteSugestao(strCodCli:String): String;
  Var
    qryCndCli: TUniquery;
Begin
  qryCndCli := fCriaQuery;
  Try
    qryCndCli.SQL.Add('SELECT CND_CNDPAG FROM CLICND');
    qryCndCli.SQL.Add('WHERE CND_CODCLI = ' + QuotedStr(strCodCli) + ' AND CND_SUGEST = "S"');
    qryCndCli.Open;

    If Not qryCndCli.IsEmpty Then
      Result := qryCndCli.Fields[0].AsString;
  Finally
    FreeAndNil(qryCndCli);
  End;
end;

function TfrmPedidoDeCompraImpEdiSawluz.fValidarMultiploVenda(): Boolean;
var
  lstItensTrava: TListaItemTravaMultiploVenda;
  blnEhEmbalagem : Boolean;
  blnCAREST: Boolean;
  intIndex: Integer;
  qryItem: TUniQuery;
  intDecQtd: Integer;

  function fGetSQLItem():String;
  begin
    Result := '';
    Result := Result + '  SELECT                              ';
    Result := Result + '    C.ITE_CODITE,                     ';
    Result := Result + '    C.ITE_BAREMB,                     ';
    Result := Result + '    C.ITE_DESITE,                     ';
    Result := Result + '    C.ITE_MLTVEN,                     ';
    Result := Result + '    C.ITE_CAREST,                     ';
    Result := Result + '    C.ITE_EMPCAR                      ';
    Result := Result + '  FROM                                ';
    Result := Result + '    CADITE C                          ';
    Result := Result + '  WHERE C.ITE_CODITE =:CODITE         ';
  end;


  function fRetornaTipMltVenDoItem():String;
  begin
    Result := '';

    //Embalagem
    If (blnEhEmbalagem) then
      Exit(fCfgSis('QPDMVC'));

    Result := fCfgSis('MLTVEN');
  end;

  function fDesconsideraMultiploVendaItem():Boolean;
  begin
    Result := True;

    If ((blnEhEmbalagem) and (fCfgSis('QPDMVC') = '2')) Then
      Exit;

    If (blnCAREST) And fCfgSis('MLTEST', varBoolean) Then
      Exit;

    Result := False;
  end;

  procedure pInicializaLiberacaoTrava();
  begin
    objLiberacao.Clear;

    objLiberacao.strDirAce := 'SENMTP';
    objLiberacao.strSenLib := fCfgSis('SENMTP');
    objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCliente := FstrCodCli + '-' + fRetNomCliente(FstrCodCli);
    objLiberacao.strCpfCnpj := FstrCgcCli;
    objLiberacao.strSequencialUnicoDtaHra := FormatDateTime('yyyymmddhhmmss', StrToDateTime(DateToStr(VS_Date) + ' ' + TimeToStr(Time)));
    objLiberacao.blnExibirAvisosTravaRemota := True;
  end;

  procedure pCarregaDadosItem(strCodIte:String);
  begin
    qryItem.Close;
    qryItem.ParamByName('CODITE').AsString := strCodIte;
    qryItem.Open;
  end;

  procedure pValidaItem();
  var
    strTipMltVen: String;
    strCodIteT: String;
    strDesIteT: String;
    fltQtdDigT: Double;
    fltMltVenT: Double;
    fltResto: Double;
  begin
    strCodIteT := arrItens[intIndex].strCodIte;
    fltQtdDigT := fFormataFloat(arrItens[intIndex].fltQtdPed, intDecQtd);

    pCarregaDadosItem(strCodIteT);

    blnEhEmbalagem := (Not fEmptyStr(qryItem.FieldByName('ITE_BAREMB').AsString));
    blnCAREST      := (qryItem.FieldByName('ITE_CAREST').AsString = 'S');

    strTipMltVen := fRetornaTipMltVenDoItem();

    If (strTipMltVen = '2') Then
      Exit;

    strDesIteT := qryItem.FieldByName('ITE_DESITE').AsString;

    fltMltVenT := fFormataFloat(qryItem.FieldByName('ITE_MLTVEN').AsFloat, intDecQtd);

    If (fltMltVenT <= 0) Then
      Exit;

    fltResto := Frac(fFormataFloat(fltQtdDigT / fltMltVenT, intDecQtd));

    If (fFormataFloat(fltResto, intDecQtd) = 0) Then
      Exit;

    If CompareValue(fFormataFloat(fltResto, intDecQtd), 0) = EqualsValue Then
      Exit;

    If fDesconsideraMultiploVendaItem() Then
      Exit;


    lstItensTrava.fAdd(strCodIteT,
                       strDesIteT,
                       fltMltVenT,
                       fltQtdDigT,
                       strTipMltVen);
  end;

  procedure pExibeItensComDivergencia(strMensagem: String);
  begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    Try
      frmObservacao.Caption := 'Itens com divergência no múltiplo de vendas ';
      frmObservacao.lblMensagem.Visible := False;
      frmObservacao.memObs.Text := strMensagem;
      frmObservacao.memObs.SelStart := 0;
      frmObservacao.Width := 700;
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  end;

  function fExibeTravas():Boolean;
  Var strNTrava : String;
      stlNumLib : TStringList;
  begin
    strNTrava := '';
    stlNumLib := TStringList.Create;

    Try
      Result := fMensagemLiberacao(objLiberacao, strNTrava, stlNumLib);
    Finally
      FreeAndNil(stlNumLib);
    End;
  end;
begin
  Result := True;

  If (Length(arrItens) = 0) Then
    Exit;

  intDecQtd := fCfgSis('DECQTD', varInteger);

  lstItensTrava := TListaItemTravaMultiploVenda.Create;
  qryItem := fCriaQuery();

  Try
    qryItem.SQL.Add(fGetSQLItem);

    For intIndex := 0 To PRed(Length(arrItens)) Do
      pValidaItem();

    If (lstItensTrava.fExisteItens(ttTrava)) Then
    Begin
      pExibeItensComDivergencia(lstItensTrava.fGetMensagem(ttTrava));
      Exit(False);
    End;

    If (lstItensTrava.fExisteItens(ttAvisa)) Then
    Begin
      pExibeItensComDivergencia(lstItensTrava.fGetMensagem(ttAvisa));
    End;

    If (lstItensTrava.fExisteItens(ttLibera)) Then
    Begin
      pInicializaLiberacaoTrava();
      lstItensTrava.fGetMensagem(ttLibera, objLiberacao);

      Result := fExibeTravas();
    End;

  Finally
    FreeAndNil(lstItensTrava);
    FreeAndNil(qryItem);
  End;
end;


end.
