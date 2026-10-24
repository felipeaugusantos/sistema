unit untTxtImpFullSoft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Gauges, StdCtrls, CheckLst, Mask, UniClientDataSet, DB,
  DirectoryEditFocus, AppEvnts, Menus, Buttons, ExtCtrls, untTxtExpFullSoft,
  Uni, ComCtrls, Grids, DBGridCitel, DBGrids,  
  frxClass, frxDBSet,  FilenameEditFocus, BitBtnLockedIncrem,
  JvExMask, JvToolEdit, frxExportCSVTestabilidade;

type
  TfrmTxtImpFullSoft = class(TfrmPai)
    Label17: TLabel;
    pgDados: TPageControl;
    tbImportar: TTabSheet;
    barEspecifico: TGauge;
    chkLstItensExportar: TCheckListBox;
    tbDados: TTabSheet;
    gpItens: TGroupBox;
    dbgPedidosItens: TDBGridCitel;
    gbPedidos: TGroupBox;
    dbgPedidos: TDBGridCitel;
    dirPathExp: TFilenameEditFocus;
    gbClientes: TGroupBox;
    dbgContatos: TDBGridCitel;
    tbLogImp: TTabSheet;
    mmoLogImp: TMemo;
    btnImporta: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosDblClick(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPedidosItensKeyPress(Sender: TObject; var Key: Char);
    procedure dbgContatosKeyPress(Sender: TObject; var Key: Char);
    procedure dirPathExpExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    arquivosExportar: TArquivosExportar;
    intSemaforo: Integer;

    cdsPedidos: TUniClientDataSet;
    cdsPedidosItens: TUniClientDataSet;

    dtsPedidos: TDataSource;
    dtsPedidosItens: TDataSource;

    cdsContatos: TUniClientDataSet;
    dtsContatos: TDataSource;

    qryPedidos: TUniQuery;
    qryCadIte: TUniQuery;

    blnEmpFat: Boolean;
    intRecAtu: Integer;

    strPedidoCab: String;
    strCodRep: String;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pCalculaTotalItens;
    procedure pApagarArquivoDisco(strArquivo: String);
  protected
    procedure pAssociarItens;
    procedure pCriarDataSets;
    procedure pLigaDataSet;
    procedure pRegistrarProgresso(strTexto: String; intInicio, intAtual, intFinal: Integer);
    procedure pRegistraLogImp(strTexto: String);

    function fImportaData(strData: String): TDate;
    function fImportaHora(strHora: String): TTime;
    function fImportaFloat(strValor: String; intDecim: Integer): Double;
    function fContaLinhas(strArq: String): Integer;
    function fCarregaItem(strCodIte: String): Boolean;
    function fRetSaldoItem(strCodIte: String): Double;
    function fValidaCliente(strCodCli: String; var strCodigo: String): Boolean;
    function fRetornaCodCid(strCidade: String; strCepCid: String): String;

    function fGerarPedidosCabecalho: Boolean;
    function fGerarContatos: Boolean;
    function fCarregarPedidos: Boolean;
    function fCarregarPedidosItens: Boolean;
    function fCarregarContatos: Boolean;

    function fValidaClientesPedido: Boolean;
  public
    { Public declarations }
  end;

var
  frmTxtImpFullSoft: TfrmTxtImpFullSoft;

implementation

uses untFuncoes, untFuncoesSimples, StrUtils, untFatGor, untTypesSistema;

{$R *.dfm}

{ TfrmTxtFullSoft }

procedure TfrmTxtImpFullSoft.pAssociarItens;
begin
  arquivosExportar.fAdicionarItem('Registro de Clientes Novos Alterados', fCarregarContatos, True);
  arquivosExportar.fAdicionarItem('Registro de Pedidos', fCarregarPedidos, True);
  arquivosExportar.fAdicionarItem('Registro de Itens de Pedidos', fCarregarPedidosItens, True);
end;

procedure TfrmTxtImpFullSoft.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dirPathExp);
end;

procedure TfrmTxtImpFullSoft.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(arquivosExportar);
end;

procedure TfrmTxtImpFullSoft.FormCreate(Sender: TObject);
begin
  inherited;
  blnEmpFat := fCfgSis('EMPFAT', varBoolean);
  arquivosExportar := TArquivosExportar.Create(chkLstItensExportar);
  intSemaforo := 0;
  pCriarDataSets;
  pLigaDataSet;
end;

function TfrmTxtImpFullSoft.fGerarPedidosCabecalho: Boolean;
  Var
    strAutInc: String;
    strAutFdo: String;
    strIncLFg: String;
    strIncLFd: String;
    strNumDoc: String;
    blnImpRef: Boolean;
    strMARMKP: String;
    strPcmPro: String;
    strCodVen: String;
    strNumPok: String;
    recServicos: TDadosServicos;
begin
  Result := cdsPedidos.RecordCount > 0;

  If Result Then
  Begin
    blnImpRef := fCfgSis('IMPREF', varBoolean);
    strMARMKP := fCfgSis('MARMKP');
    strPcmPro := fCfgSis('PCMPRO');

    Try
      cdsPedidos.First;
      cdsPedidosItens.First;

      While Not cdsPedidos.Eof Do
      Begin
        If cdsPedidos.FieldByName('MARCADO').AsBoolean Then
        Begin
          fStartTransaction;
          strNumDoc := fRetSequencial('PRO_PD');

          strCodVen := strCodRep;

          If fEmptyStr(strCodVen) Then
            strCodVen := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [cdsPedidos.FieldByName('CODIGOCLIENTE').AsString]);

          strNumPok := Trim(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString) +
                       Trim(cdsPedidos.FieldByName('CODIGOCLIENTE').AsString);

          If fGravaFatGor(strAutInc,                                                                                   // strIncrem
                          VS_strCodEmp,                                                                                //  strCodEmp
                          strNumDoc,                                                                                   //  strNumDoc
                          'PD',                                                                                        //  strEspDoc
                          cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                            //  strCodCli
                          strCodVen,                                                                                   //  strCodVen
                          '',                                                                                          //  strCodTra
                          '',                                                                                          //  strSerie:
                          cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,                                             //  dtaDtaEnt
                          0, //cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                       //  dtaHorEnt
                          fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                            //  strConPag
                          '',                                                                                          //  strEstado
                          '',                                                                                          //  strNomCom
                          '',                                                                                          //  strEndCon
                          '',                                                                                          //  strBaiCon
                          '',                                                                                          //  strCepCon
                          '',                                                                                          //  strCidCon
                          '',                                                                                          //  strEstCon
                          '',                                                                                          //  strTelCon
                          '',                                                                                          //  strCgcCpf
                          '',                                                                                          //  strCgcCon
                          '',                                                                                          //  strIesCon
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
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltVlrCon
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltTotPro
                          0, //cdsPedidos.FieldByName('TOTALBRUTO').AsFloat,                                           //  fltTotCus
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltTotMed
                          '',                                                                                          //  strTipFre
                          0.0,                                                                                         //  fltTotFre

                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,

                          0.0,                                                                                         //  fltDesAce
                          0,                                                                                           //  fltPesBru
                          0,                                                                                           //  fltPesLiq
                          0,                                                                                           //  fltVolume
                          '',                                                                                          //  strEspeci
                          '',                                                                                          //  strMarca,
                          '',                                              //  strMen001
                          '',                                              //  strMen002
                          False,                                                                                       //  blnJaFatu
                          '',                                                                                          //  strTipFat
                          '',                                                                                          //  strNumFat
                          0,                                                                                           //  dtaDtaFat
                          '',                                                                                          //  strVenFat
                          '',                                                                                          //  strCndFat
                          0.0,                                                                                         //  fltValFat
                          0.0,                                                                                         //  fltPorDes
                          strLoginUsuarioLogado,                                                                       //  strCodDig
                          cdsPedidos.FieldByName('CODCONDPGTO').AsString,                                              //  strCodCnd
                          cdsPedidos.FieldByName('CODFORMAPGTO').AsString,                                             //  strCodFpg
                          recServicos,
                          '',                                                                                          //  strConEnt
                          VS_Date,                                                                                     //  dtaPreVis
                          0.0,                                                                                         //  fltVPgAnt
                          VS_Date,                                                                                     //  dtaUltAlt
                          '',                                                                                          //  strNTrava
                          'A', //cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString,                                     //  strTipPed
                          False,                                                                                       //  blnLibera
                          'S',                                                                                         //  strEntFat
                          0.0,                                                                                         //  fltDesCon
                          '1', //cdsPedidos.FieldByName('CODTABPRECO').AsString,                                       //  strTabPre
                          '',                                                                                          //  strEntFut
                          0.0,                                                                                         //  fltMargem
                          strNumPok,                                                                                   //  strNumPok
                          '',                                                                                          //  strEmp_CD
                          False,                                                                                       //  blnEnt_CD
                          'N',                                                                                         //  strOprFlj
                          cdsPedidos.FieldByName('OBSERVACAO1').AsString,                                              //  strMenExp
                          cdsPedidos.FieldByName('OBSERVACAO2').AsString,                                              //  strMenExp
                          cdsPedidos.FieldByName('OBSERVACAO3').AsString,                                              //  strMenExp
                          '',                                                                                          //  strMenExp
                          '',
                          '',
                          False,                                                                                        //  blnPedLib
                          0,
                          'N',
                          '',
                          0,
                          'P',                                                                                         // strTipFin
                          0,                                                                                           // fltDesFin
                          '',                                                                                          // strAutEnt
                          '',
                          '',
                          False, //Liberacao Comercial
                          '',
                          Nil,
                          '',
                          '',
                          0, //cdsPedidos.FieldByName('HORAFINAL').AsDateTime,
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
                          'N') Then
          Begin
            //**************************************
            //* GRAVA O LOG DA IMPORTAÇÃO (LOGFGO) *
            //***********************************RV*
            fGravaLogFgo(strIncLFg,
                          strAutInc,                                                                                   // strIncrem
                          VS_strCodEmp,                                                                                //  strCodEmp
                          strNumDoc,                                                                                   //  strNumDoc
                          'PD',                                                                                        //  strEspDoc
                          cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                            //  strCodCli
                          strCodVen,                                                                                   //  strCodVen
                          '',                                                                                          //  strCodTra
                          '',                                                                                          //  strSerie:
                          cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,                                             //  dtaDtaEnt
                          0, //cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                       //  dtaHorEnt
                          fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                            //  strConPag
                          '',                                                                                          //  strEstado
                          '',                                                                                          //  strNomCom
                          '',                                                                                          //  strEndCon
                          '',                                                                                          //  strBaiCon
                          '',                                                                                          //  strCepCon
                          '',                                                                                          //  strCidCon
                          '',                                                                                          //  strEstCon
                          '',                                                                                          //  strTelCon
                          '',                                                                                          //  strCgcCpf
                          '',                                                                                          //  strCgcCon
                          '',                                                                                          //  strIesCon
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
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltVlrCon
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltTotPro
                          0, //cdsPedidos.FieldByName('TOTALBRUTO').AsFloat,                                           //  fltTotCus
                          cdsPedidos.FieldByName('TOTALVENDA').AsFloat,                                                //  fltTotMed
                          '',                                                                                          //  strTipFre
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,                                                                                         //  fltTotFre
                          0.0,                                                                                         //  fltTotFre
                          0,                                                                                           //  fltPesBru
                          0,                                                                                           //  fltPesLiq
                          0,                                                                                           //  fltVolume
                          '',                                                                                          //  strEspeci
                          '',                                                                                          //  strMarca,
                          '',                                              //  strMen001
                          '',                                              //  strMen002
                          False,                                                                                       //  blnJaFatu
                          '',                                                                                          //  strTipFat
                          '',                                                                                          //  strNumFat
                          0,                                                                                           //  dtaDtaFat
                          '',                                                                                          //  strVenFat
                          '',                                                                                          //  strCndFat
                          0.0,                                                                                         //  fltValFat
                          0.0,                                                                                         //  fltPorDes
                          strLoginUsuarioLogado,                                                                       //  strCodDig
                          cdsPedidos.FieldByName('CODCONDPGTO').AsString,                                              //  strCodCnd
                          cdsPedidos.FieldByName('CODFORMAPGTO').AsString,                                             //  strCodFpg
                          recServicos,
                          '',                                                                                          //  strConEnt
                          VS_Date,                                                                                     //  dtaPreVis
                          0.0,                                                                                         //  fltVPgAnt
                          VS_Date,                                                                                     //  dtaUltAlt
                          '',                                                                                          //  strNTrava
                          'A', //cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString,                                     //  strTipPed
                          False,                                                                                       //  blnLibera
                          'S',                                                                                         //  strEntFat
                          0.0,                                                                                         //  fltDesCon
                          '1', //cdsPedidos.FieldByName('CODTABPRECO').AsString,                                       //  strTabPre
                          '',                                                                                          //  strEntFut
                          0.0,                                                                                         //  fltMargem
                          strNumPok,                                                                                   //  strNumPok
                          '',                                                                                          //  strEmp_CD
                          False,                                                                                       //  blnEnt_CD
                          'N',                                                                                         //  strOprFlj
                          cdsPedidos.FieldByName('OBSERVACAO1').AsString,                                              //  strMenExp
                          cdsPedidos.FieldByName('OBSERVACAO2').AsString,                                              //  strMenExp
                          cdsPedidos.FieldByName('OBSERVACAO3').AsString,                                              //  strMenExp
                          '',                                                                                          //  strMenExp
                          '',
                          '',
                          False,                                                                                       //  blnPedLib
                          0,
                          'N',
                          '',
                          0,
                         'P',        //strTipFin
                          0,         //fltDesFin
                          '',        //strAutEnt
                          '',
                          '',
                          False,
                          '',
                          Nil,
                          '',
                          '');

            cdsPedidosItens.First;

            While Not cdsPedidosItens.Eof Do
            Begin
              If fCarregaItem(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString) Then
              Begin
                If Not fGravaFatDor(strAutFdo,
                                    strAutInc,                                                                                            // strSeqGer
                                    VS_strCodEmp,                                                                                         //  strCodEmp
                                    cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                                     //  strCodCli
                                    strCodVen,                                                                                            //  strCodVen
                                    cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString,                                                //  strCodIte
                                    qryCadIte.FieldByName('ITE_CODMAR').AsString,                                                         //  strCodMar
                                    '',                                                                                                   //  strCodDiv
                                    strNumDoc,                                                                                            //  strNumDoc
                                    'PD',                                                                                                 //  strEspDoc
                                    '',                                                                                                   //  strSerie
                                    cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,
                                    0, //cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                                //  dtaHorEnt
                                    fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                                     //  strConPag
                                    '',                                                                                                   //  strEstado
                                    IIF(blnImpRef,
                                          IIF(fCfgSis('MONDES', varString) = '1',
                                                qryCadIte.FieldByName('ITE_DESITE').AsString +
                                                IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),' ' + qryCadIte.FieldByName('ITE_REFERE').AsString,''),
                                                IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),qryCadIte.FieldByName('ITE_REFERE').AsString + ' ','') +
                                                qryCadIte.FieldByName('ITE_DESITE').AsString),
                                          qryCadIte.FieldByName('ITE_DESITE').AsString),                                                  //  strDescri
                                    qryCadIte.FieldByName('ITE_REFERE').AsString,                                                         //  strRefere
                                    qryCadIte.FieldByName('ITE_CODUNI').AsString,                                                         //  strUnidad
                                    qryCadIte.FieldByName('ITE_CODFOR').AsString,                                                         //  strForIte
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat,                                                    //  fltQtdIte
                                    cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                    //  fltUnitar
                                    cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                   //  fltUniOri
                                    cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                   //  fltUniVis
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,//  fltTotIte
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,//  fltVlrCon
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat,      //  fltTotCus
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PREMED').AsFloat,      //  fltTotMed
                                    0.0,                                                                                                  //  fltDesCon
                                    0.0,                                                                                                  //  fltTotFre
                                    0.0,                                                                                                  //  fltDesEsp
                                    0.0,                                                                                                  //  fltDesAce
                                    IIF(fEmptyStr(strCodRep), '', strCodRep),                                                             //  strCodRep
                                    '',                                                                                                   //  strCodVe2
                                    qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                                                          //  fltPerCom
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCom
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCo2
                                    '5405',                                                                                               //  strClaFis
                                    '',                                                                                                   //  strCodFis
                                    0.0,                                                                                                  //  fltValIpi
                                    0.0,                                                                                                  //  fltAlqIpi
                                    0.0,                                                                                                  //  fltBasIpi
                                    0.0,                                                                                                  //  fltValIcm
                                    0.0,                                                                                                  //  fltAlqIcm
                                    0.0,                                                                                                  //  fltBasIcm
                                    0.0,                                                                                                  //  fltValRet
                                    0.0,                                                                                                  //  fltAlqRet
                                    0.0,                                                                                                  //  fltBasRet
                                    fFormataFloat(cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PESOIT').AsFloat, 3),              //  fltTotPes
                                    0.0,                                                                                                  //  fltPerBas
                                    0.0,                                                                                                  //  fltPerRed
                                    False,                                                                                                //  blnJaFatu
                                    '',                                                                                                   //  strTipFat
                                    '',                                                                                                   //  strNumFat
                                    0,                                                                                                    //  dtaDtaFat
                                    '',                                                                                                   //  strVenFat
                                    '',                                                                                                   //  strCndFat
                                    0.0,                                                                                                  //  fltValFat
                                    'NOR',                                                                                                //  strIdePro
                                    'N',                                                                                                  //  strIncPis
                                    strLoginUsuarioLogado,                                                                                //  strCodDig
                                    fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                                     //  strConPag
                                    '',                                                                                                   //  strProEmb
                                    cdsPedidos.FieldByName('CODFORMAPGTO').AsString,                                                      //  strCodFpg
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
                                    cdsPedidosItens.RecNo,                                                                                //  intSeqInd
                                    0.0,                                                                                                  //  fltQtdBai
                                    cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                    //  fltUniDig
                                    '',                                                                                                   //  strComple
                                    0.0,                                                                                                  //  fltVolPro
                                    '',                                                                                                   //  strCodAca
                                    '',                                                                                                   //  strEmpAca
                                    False,                                                                                                //  blnProAca
                                    '1',                                                                                                  //  strTabPre
                                    '',                                                                                                   //  strLinha:
                                    '',                                                                                                   //  strCatali
                                    '',                                                                                                   //  strCodDil
                                    0.0,                                                                                                  //  fltPorDil
                                    '',                                                                                                   //  strDilCon
                                    0.0,
                                    'E',
                                    '',                                    
                                    '',
                                    0,
                                    0,
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    False,
                                    IIF(blnEmpFat, VS_strCodEmp, ''),
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    0,
                                    '',
                                    '',
                                    0,
                                    '',
                                    '',
                                    0,
                                    0) Then
                Begin
                  fRollBack;
                  pMensagensErro('Não foi possivel importar os pedidos', 'TfrmTxtImpFullSoft.fGerarPedidosCabecalho');
                  Exit;
                End;

              End
              Else
              Begin
                fGravaLogFdo(strIncLFd,
                             strAutInc,                                                                                            // strSeqGer
                             strIncLFg,
                             VS_strCodEmp,                                                                                         //  strCodEmp
                             cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                                     //  strCodCli
                             strCodVen,                                                                                            //  strCodVen
                             cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString,                                                //  strCodIte
                             qryCadIte.FieldByName('ITE_CODMAR').AsString,                                                         //  strCodMar
                             '',                                                                                                   //  strCodDiv
                             strNumDoc,                                                                                            //  strNumDoc
                             'PD',                                                                                                 //  strEspDoc
                             '',                                                                                                   //  strSerie
                             cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,
                             0, //cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                                //  dtaHorEnt
                             fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                                     //  strConPag
                             '',                                                                                                   //  strEstado
                             IIF(blnImpRef,
                                    IIF(fCfgSis('MONDES', varString) = '1',
                                         qryCadIte.FieldByName('ITE_DESITE').AsString +
                                         IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),' ' + qryCadIte.FieldByName('ITE_REFERE').AsString,''),
                                         IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),qryCadIte.FieldByName('ITE_REFERE').AsString + ' ','') +
                                         qryCadIte.FieldByName('ITE_DESITE').AsString),
                                   qryCadIte.FieldByName('ITE_DESITE').AsString),                                                  //  strDescri
                             qryCadIte.FieldByName('ITE_REFERE').AsString,                                                         //  strRefere
                             qryCadIte.FieldByName('ITE_CODUNI').AsString,                                                         //  strUnidad
                             qryCadIte.FieldByName('ITE_CODFOR').AsString,                                                         //  strForIte
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat,                                                    //  fltQtdIte
                             cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                    //  fltUnitar
                             cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                   //  fltUniOri
                             cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                   //  fltUniVis
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,//  fltTotIte
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,//  fltVlrCon
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat,      //  fltTotCus
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PREMED').AsFloat,      //  fltTotMed
                             0.0,                                                                                                  //  fltDesCon
                             0.0,                                                                                                  //  fltTotFre
                             0.0,                                                                                                  //  fltDesEsp
                             0.0,                                                                                                  //  fltDesAce
                             IIF(fEmptyStr(strCodRep), '', strCodRep),                                                             //  strCodRep
                             '',                                                                                                   //  strCodVe2
                             qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                                                          //  fltPerCom
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCom
                             cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCo2
                             '5405',                                                                                               //  strClaFis
                             '',                                                                                                   //  strCodFis
                             0.0,                                                                                                  //  fltValIpi
                             0.0,                                                                                                  //  fltAlqIpi
                             0.0,                                                                                                  //  fltBasIpi
                             0.0,                                                                                                  //  fltValIcm
                             0.0,                                                                                                  //  fltAlqIcm
                             0.0,                                                                                                  //  fltBasIcm
                             0.0,                                                                                                  //  fltValRet
                             0.0,                                                                                                  //  fltAlqRet
                             0.0,                                                                                                  //  fltBasRet
                             fFormataFloat(cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PESOIT').AsFloat, 3),              //  fltTotPes
                             0.0,                                                                                                  //  fltPerBas
                             0.0,                                                                                                  //  fltPerRed
                             False,                                                                                                //  blnJaFatu
                             '',                                                                                                   //  strTipFat
                             '',                                                                                                   //  strNumFat
                             0,                                                                                                    //  dtaDtaFat
                             '',                                                                                                   //  strVenFat
                             '',                                                                                                   //  strCndFat
                             0.0,                                                                                                  //  fltValFat
                             'NOR',                                                                                                //  strIdePro
                             'N',                                                                                                  //  strIncPis
                             strLoginUsuarioLogado,                                                                                //  strCodDig
                             fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                                     //  strConPag
                             '',                                                                                                   //  strProEmb
                             cdsPedidos.FieldByName('CODFORMAPGTO').AsString,                                                      //  strCodFpg
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
                             cdsPedidosItens.RecNo,                                                                                //  intSeqInd
                             0.0,                                                                                                  //  fltQtdBai
                             cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                    //  fltUniDig
                             '',                                                                                                   //  strComple
                             0.0,                                                                                                  //  fltVolPro
                             '',                                                                                                   //  strCodAca
                             '',                                                                                                   //  strEmpAca
                             False,                                                                                                //  blnProAca
                             '',                                                                                                   //  strTabPre
                             '',                                                                                                   //  strLinha:
                             '',                                                                                                   //  strCatali
                             '',                                                                                                   //  strCodDil
                             0.0,                                                                                                  //  fltPorDil
                             '',                                                                                                   //  strDilCon
                             0.0,
                             '',
                             '',
                             '',                             
                             0,
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             False,
                             IIF(blnEmpFat, VS_strCodEmp, ''),
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             '');
              End;

              cdsPedidosItens.Next;
            End;

            pRegistrarProgresso('Gravando Pedidos', 0, cdsPedidos.RecNo, cdsPedidos.RecordCount);
            pRegistraLogImp('Importou pedido ' + strNumPok + ' -> ' + strNumDoc + '-PD');
            fCommit;
          End
          Else
          Begin
            fRollBack;
            Exit;
          End;
        End;

        cdsPedidos.Next;
      End;
    Except
      fRollBack;
      pMensagensErro('Não foi possivel importar os pedidos', 'TfrmTxtImpFullSoft.fGerarPedidosCabecalho');
    End;
  End;

end;

procedure TfrmTxtImpFullSoft.pApagarArquivoDisco(strArquivo: String);
  Var
    strDestino: String;
    strNomeArq: String;
begin
  strArquivo := dirPathExp.Text;// + '\' + strArquivo;
  strNomeArq := ExtractFileName(strArquivo);

  strDestino := dirPathExp.Text + {'\' + strNomeArq +} '-' +
                FormatDateTime('yyyymmdd', VS_Date)  + '-' +
                FormatDateTime('hhmmss', Time)       + '.IMP';

  If FileExists(strArquivo) Then
  Begin
    CopyFile(PChar(strArquivo), PChar(strDestino), True);
    DeleteFile(strArquivo);
  End;
end;

procedure TfrmTxtImpFullSoft.btnImportaClick(Sender: TObject);
  Var
    blnImportou: Boolean;
begin
  inherited;
  cdsPedidos.EmptyDataSet;
  cdsPedidosItens.EmptyDataSet;
  cdsContatos.EmptyDataSet;
  mmoLogImp.Clear;

  If InterlockedIncrement(intSemaforo) = 1 Then
  Begin
    blnImportou := False;

    strPedidoCab := ExtractFileName(dirPathExp.Text);
    strCodRep    := Copy(strPedidoCab, 2, 3);

    pgDados.ActivePage := tbLogImp;    

    If arquivosExportar.fGerarArquivos Then
    Begin
      blnImportou := True;

      cdsPedidos.First;
      While Not cdsPedidos.Eof Do
      Begin
        If cdsPedidosItens.RecordCount = 0 Then
             cdsPedidos.Delete
        Else cdsPedidos.Next;
      End;

      If (cdsPedidos.RecordCount  = 0) And
         (cdsContatos.RecordCount = 0) Then
        blnImportou := False;

      pApagarArquivoDisco(strPedidoCab);
    End;

    If blnImportou Then
    Begin
      pRegistraLogImp('Importação concluída com sucesso!');
      fMensagem('', 'Importação concluída com sucesso!', ['OK']);

      pgDados.ActivePage := tbDados;
      btnGravar.Enabled := True;
      pnlInfo.Caption := '';
      btnImporta.Enabled := False;
    End
    Else
    Begin
      pgDados.ActivePage := tbLogImp;
      pRegistraLogImp('Importação não realizada!');
      fMensagem('', 'Importação não realizada!', ['OK']);
    End;

    InterlockedDecrement(intSemaforo);
    
  End
  Else
    InterlockedDecrement(intSemaforo);

end;

procedure TfrmTxtImpFullSoft.pCriarDataSets;
begin
  cdsPedidos := TUniClientDataSet.Create(Self);
  cdsPedidosItens := TUniClientDataSet.Create(Self);

  qryPedidos := fCriaQuery(Self);
  qryPedidos.SQL.Text := 'SELECT DISTINCT FGO_NUMPOK, FGO_CODEMP, FGO_CODCLI, FGO_NUMDOC, FGO_ESPDOC FROM FATGOR WHERE FGO_NUMPOK';
  qryPedidos.Open;

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Add(' SELECT * ');
  qryCadIte.SQL.Add(' FROM CADITE ');
  qryCadIte.SQL.Add('   INNER JOIN ITEGER ');
  qryCadIte.SQL.Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
  qryCadIte.SQL.Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
  qryCadIte.SQL.Add('     AND CADITE.ITE_CODITE = :CODITE ');

  cdsPedidos.FieldDefs.Add('NUMEROPEDIDO',  ftString, 030,  True);
  cdsPedidos.FieldDefs.Add('DATAPEDIDO',    ftDate);
  cdsPedidos.FieldDefs.Add('CODIGOCLIENTE', ftString, 250,  False);
  cdsPedidos.FieldDefs.Add('CPFCNPJ',       ftString, 014,  False);
  cdsPedidos.FieldDefs.Add('CODCONDPGTO',   ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('CODFORMAPGTO',  ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('TIPOFRETE',     ftString, 001,  True);
  cdsPedidos.FieldDefs.Add('TOTALVENDA',    ftFloat);
  cdsPedidos.FieldDefs.Add('ORDEMCOMPRA',   ftString, 050,  False);
  cdsPedidos.FieldDefs.Add('OBSERVACAO1',   ftString, 200,  False);
  cdsPedidos.FieldDefs.Add('OBSERVACAO2',   ftString, 200,  False);
  cdsPedidos.FieldDefs.Add('OBSERVACAO3',   ftString, 200,  False);
  cdsPedidos.FieldDefs.Add('MARCADO',       ftBoolean);
  cdsPedidos.CreateDataSet;
  dtsPedidos := fCriaDataSource(cdsPedidos);

  cdsPedidosItens.FieldDefs.Add('NUMEROPEDIDO',  ftString, 030,  True);
  cdsPedidosItens.FieldDefs.Add('CODIGOPRODUTO', ftString, 030,  True);
  cdsPedidosItens.FieldDefs.Add('QUANTIDADE',    ftFloat);
  cdsPedidosItens.FieldDefs.Add('PRECOVENDA',    ftFloat);
  cdsPedidosItens.FieldDefs.Add('DESCONTO',      ftFloat);
  cdsPedidosItens.FieldDefs.Add('PRECOTABELA',   ftFloat);
  cdsPedidosItens.FieldDefs.Add('SALDO',         ftFloat);
  cdsPedidosItens.CreateDataSet;
  dtsPedidosItens := fCriaDataSource(cdsPedidosItens);

  cdsPedidosItens.MasterFields := 'NUMEROPEDIDO';
  cdsPedidosItens.IndexFieldNames := 'NUMEROPEDIDO';
  cdsPedidosItens.MasterSource := dtsPedidos;

  TFloatField(cdsPedidos.FieldByName('TOTALVENDA')).currency := True;

  TFloatField(cdsPedidosItens.FieldByName('QUANTIDADE')).DisplayFormat := '0.00';
  TFloatField(cdsPedidosItens.FieldByName('PRECOVENDA')).currency := True;
  TFloatField(cdsPedidosItens.FieldByName('DESCONTO')).DisplayFormat := '0.00';
  TFloatField(cdsPedidosItens.FieldByName('PRECOTABELA')).currency := True;
  TFloatField(cdsPedidosItens.FieldByName('SALDO')).DisplayFormat := '0.00';

  cdsContatos := TUniClientDataSet.Create(Self);
  cdsContatos.FieldDefs.Add('TIPMANUT',    ftString, 1,   True);
  cdsContatos.FieldDefs.Add('NOMECLIENTE', ftString, 60,  True);
  cdsContatos.FieldDefs.Add('CODIGO',      ftString, 8,   False);
  cdsContatos.FieldDefs.Add('FANTASIA',    ftString, 50,  False);
  cdsContatos.FieldDefs.Add('ENDERECO',    ftString, 50,  False);
  cdsContatos.FieldDefs.Add('BAIRRO',      ftString, 20,  False);
  cdsContatos.FieldDefs.Add('CEP',         ftString, 8,   False);
  cdsContatos.FieldDefs.Add('CIDADE',      ftString, 20,  False);
  cdsContatos.FieldDefs.Add('TIPOCPF',     ftString, 1,   False);
  cdsContatos.FieldDefs.Add('CNPJ',        ftString, 14,  False);
  cdsContatos.FieldDefs.Add('IES',         ftString, 15,  False);
  cdsContatos.FieldDefs.Add('TELEFONE',    ftString, 11,  False);
  cdsContatos.FieldDefs.Add('CONTATO',     ftString, 20,  False);
  cdsContatos.FieldDefs.Add('REGIAO',      ftString, 2,   False);
  cdsContatos.FieldDefs.Add('CONDPAG',     ftString, 3,   False);
  cdsContatos.FieldDefs.Add('EMAIL',       ftString, 76,  False);
  cdsContatos.CreateDataSet;
  dtsContatos := fCriaDataSource(cdsContatos);

end;

function TfrmTxtImpFullSoft.fCarregarPedidos: Boolean;
  Var
    txtGen   : TextFile;
    strNomArq: String;
    strLinha : String;
    intLinha : Integer;
    intLinhas: Integer;
    strAuxPok: String;
    strCodCli: String;
    strCnpj  : String;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.Text;// + '\' + strPedidoCab;

    If Not FileExists(strNomArq) Then
    Begin
      pRegistraLogImp('Não foi possivel encontrar o arquivo ' + strNomArq);
      fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
      Result := False;
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    pRegistraLogImp('Iniciou leitura dos Pedidos no Arquivo ' + strNomArq);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      strCodCli := '';
      strCnpj   := '';
      If (Copy(strLinha, 1, 1) = '1') Then
      Begin
        If StrToInt64(Copy(strLinha, 212, 14)) > 0 Then
        Begin
          strCnpj := Copy(strLinha, 212, 14);
          If Not fValidaCliente(Copy(strLinha, 212, 14), strCodCli) Then
          Begin
            If Copy(strLinha, 212, 3) = '000' Then
            Begin
              strCnpj := Copy(strLinha, 215, 11);
              fValidaCliente(Copy(strLinha, 215, 11), strCodCli);
            End;
          End;
        End;
      End;

      If (fEmptyStr(strCodCli)) And (fEmptyStr(strCnpj)) Then
      Begin
        strCodCli := fStrZero(Copy(strLinha, 2, 5), 8);
        strCnpj   := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
      End;

      strAuxPok := Copy(strLinha, 7, 6) + fStrZero(strCodCli, 8);

      If (Copy(strLinha, 1, 1) = '1') Then
      Begin
        If (Not qryPedidos.Locate('FGO_CODEMP;FGO_CODCLI;FGO_NUMPOK;FGO_ESPDOC',
            VarArrayOf([VS_strCodEmp, fStrZero(strCodCli, 8), strAuxPok, 'PD']), [])) Then
        Begin
          cdsPedidos.Insert;
          cdsPedidos.FieldByName('CODIGOCLIENTE').AsString := fStrZero(strCodCli, 8);
          cdsPedidos.FieldByName('NUMEROPEDIDO').AsString  := Copy(strLinha, 007, 06);
          cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime  := fImportaData(Copy(strLinha, 013, 8));
          cdsPedidos.FieldByName('CODCONDPGTO').AsString   := Copy(strLinha, 021, 03);
          cdsPedidos.FieldByName('ORDEMCOMPRA').AsString   := Copy(strLinha, 024, 16);
          cdsPedidos.FieldByName('OBSERVACAO1').AsString   := Copy(strLinha, 040, 70);
          cdsPedidos.FieldByName('OBSERVACAO2').AsString   := Copy(strLinha, 110, 70);
          cdsPedidos.FieldByName('OBSERVACAO3').AsString   := Copy(strLinha, 180, 12);
          cdsPedidos.FieldByName('TIPOFRETE').AsString     := Copy(strLinha, 192, 01);
          cdsPedidos.FieldByName('CODFORMAPGTO').AsString  := Copy(strLinha, 209, 03);
          cdsPedidos.FieldByName('CPFCNPJ').AsString       := strCnpj;

          cdsPedidos.FieldByName('MARCADO').AsBoolean := True;

          cdsPedidos.Post;
        End
        Else
          pRegistraLogImp('Não foi possível importar o pedido ' + strAuxPok + ' do cliente ' + strCodCli +
                          ', pois o mesmo já foi importado. (' + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-PD)');
      End;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Pedidos', 0, intLinha, intLinhas);
    End;

    If Result Then Result := fValidaClientesPedido;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pRegistraLogImp('Não foi possivel carregar o arquivo ' + strNomArq + '. Erro: ' + E.Message);
      fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq + '. Erro: ' + E.Message, ['OK']);
    End;
  End;

  CloseFile(txtGen);

end;

function TfrmTxtImpFullSoft.fCarregarPedidosItens: Boolean;
  Var
    txtGen   : TextFile;
    strNomArq: String;
    strLinha : String;
    intLinha : Integer;
    intLinhas: Integer;
    strAuxPok: String;
    strAuxCli: String;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.Text;

    If Not FileExists(strNomArq) Then
    Begin
      pRegistraLogImp('Não foi possivel encontrar o arquivo ' + strNomArq);
      fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
      Result := False;
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    pRegistraLogImp('Iniciou leitura dos itens dos pedidos no Arquivo ' + strNomArq);    

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      If cdsPedidos.Locate('NUMEROPEDIDO', VarArrayOf([Copy(strLinha, 2, 6)]), []) Then
           strAuxCli := cdsPedidos.FieldByName('CODIGOCLIENTE').AsString
      Else strAuxCli := '';

      strAuxPok := Copy(strLinha, 2, 6) + fStrZero(strAuxCli, 8);

      If (Copy(strLinha, 1, 1) = '2') Then
      Begin
        If (Not qryPedidos.Locate('FGO_CODEMP;FGO_NUMPOK;FGO_ESPDOC',
            VarArrayOf([VS_strCodEmp, strAuxPok, 'PD']), [])) Then
        Begin
          cdsPedidosItens.Insert;
          cdsPedidosItens.FieldByName('NUMEROPEDIDO').AsString := Copy(strLinha, 2, 6);

          If Not fCarregaItem(Copy(strLinha, 10, 5)) Then
          Begin
            cdsPedidosItens.Cancel;
            Break;
          End;

          cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString := Copy(strLinha, 10, 5);
          cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat     := fImportaFloat(Copy(strLinha, 15, 12), 3);
          cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat     := fImportaFloat(Copy(strLinha, 27, 12), 4);
          cdsPedidosItens.FieldByName('DESCONTO').AsFloat       := 0.00;
          cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat    := fImportaFloat(Copy(strLinha, 27, 12), 4);
          cdsPedidosItens.FieldByName('SALDO').AsFloat          := fRetSaldoItem(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString);

          cdsPedidosItens.Post;
        End
        Else
          pRegistraLogImp('Não foi possível importar o item ' + Copy(strLinha, 10, 5) + '. Pedido ' + strAuxPok +
                          ' já foi importado. (' + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-PD)');
      End;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Itens', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    pRegistraLogImp('Não foi possivel carregar o arquivo ' + strNomArq);
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  pCalculaTotalItens;

  CloseFile(txtGen);
end;

function TfrmTxtImpFullSoft.fImportaData(strData: String): TDate;
  Var strAux: String;
begin
  strAux := Copy(strData, 7, 2) + '/' +
            Copy(strData, 5, 2) + '/' +
            Copy(strData, 1, 4);

  Result := StrToDate(strAux);
end;

function TfrmTxtImpFullSoft.fImportaHora(strHora: String): TTime;
begin
  Insert(':', strHora, 3);
  Insert(':', strHora, 6);
  Result := StrToTime(strHora);
end;

function TfrmTxtImpFullSoft.fImportaFloat(strValor: String; intDecim: Integer): Double;
begin
//  fltValor := fStrToFloat(strValor, 0.0) / 100.0;
//  strValor := AnsiReplaceStr(strValor, '.', ',');
  If intDecim = 3 Then
       Result := fStrToFloat(strValor) / 1000.000
  Else If intDecim = 4 Then
       Result := fStrToFloat(strValor) / 10000.0000
  Else Result := fStrToFloat(strValor) / 100.00;
end;

function TfrmTxtImpFullSoft.fContaLinhas(strArq: String): Integer;
  Var
    arqGen: TextFile;
begin
  Result := 0;
  
  Try
    AssignFile(arqGen, strArq);
    Reset(arqGen);

    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen);
      Result := Result + 1;
    End;
  Except
    Result := 0;
  End;

  CloseFile(arqGen);
end;

procedure TfrmTxtImpFullSoft.pRegistraLogImp(strTexto: String);
begin
  mmoLogImp.Lines.Add(FormatDateTime('hh:mm:ss', Time) + ' ' + strTexto + #13#10);
end;

procedure TfrmTxtImpFullSoft.pRegistrarProgresso(strTexto: String; intInicio,
  intAtual, intFinal: Integer);
begin
  barEspecifico.MaxValue := intFinal;
  barEspecifico.MinValue := intInicio;
  barEspecifico.Progress := intAtual;
  pnlInfo.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmTxtImpFullSoft.FormShow(Sender: TObject);
begin
  inherited;
  pAssociarItens;
  strCodRep := '';

  dirPathExp.InitialDir   := fCfgSis('IMPFUL');
  cdsPedidos.AfterScroll  := pAtualizaDados;
  pgDados.ActivePageIndex := 0;
end;

procedure TfrmTxtImpFullSoft.pLigaDataSet;
begin
  dbgPedidos.DataSource := dtsPedidos;
  dbgPedidosItens.DataSource := dtsPedidosItens;
  dbgContatos.DataSource := dtsContatos;
end;

procedure TfrmTxtImpFullSoft.dbgContatosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    pSetFocus(btnSair);
end;

procedure TfrmTxtImpFullSoft.dbgPedidosDblClick(Sender: TObject);
begin
  inherited;
  cdsPedidos.Edit;
  cdsPedidos.FieldByName('MARCADO').AsBoolean := Not cdsPedidos.FieldByName('MARCADO').AsBoolean;
  cdsPedidos.Post;
end;

procedure TfrmTxtImpFullSoft.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If cdsPedidos.FieldByName('MARCADO').AsBoolean Then
  Begin

    If (intRecAtu = cdsPedidos.RecNo) Then
         dbgPedidos.Canvas.Font.Color := clAqua
    Else dbgPedidos.Canvas.Font.Color := clBlue;

    dbgPedidos.Canvas.FillRect(Rect);
    dbgPedidos.DefaultDrawColumnCell(Rect,DataCol,Column,State);

  End;
end;

procedure TfrmTxtImpFullSoft.dbgPedidosItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    pSetFocus(btnSair);
end;

function TfrmTxtImpFullSoft.fCarregarContatos: Boolean;
  Var
    txtGen    : TextFile;
    strNomArq : String;
    strLinha  : String;
    intLinha  : Integer;
    intLinhas : Integer;
    strCodCtt : String;
    strTipCpf : String;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.Text;// + '\' + strPedidoCab;

    If Not FileExists(strNomArq) Then
    Begin
      pRegistraLogImp('Não foi possivel encontrar o arquivo ' + strNomArq);     
      fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
      Result := False;
      Exit;
    End;

    pRegistraLogImp('Iniciou leitura dos clientes no Arquivo ' + strNomArq);    

    intLinha  := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      If (Copy(strLinha, 1, 1) = '3') Then
      Begin

        If Not fValidaCliente(Copy(strLinha, 137, 14), strCodCtt) Then
        Begin
          If Copy(strLinha, 137, 3) = '000' Then
          Begin
            strTipCpf := '2';
            fValidaCliente(Copy(strLinha, 140, 11), strCodCtt);
          End
          Else strTipCpf := '1';
        End
        Else strTipCpf := '1';

        cdsContatos.Insert;
        cdsContatos.FieldByName('TIPMANUT').AsString    := Copy(strLinha, 002, 01);
        cdsContatos.FieldByName('CODIGO').AsString      := strCodCtt;
        cdsContatos.FieldByName('NOMECLIENTE').AsString := Copy(strLinha, 003, 32);
        cdsContatos.FieldByName('FANTASIA').AsString    := Copy(strLinha, 035, 25);
        cdsContatos.FieldByName('ENDERECO').AsString    := Copy(strLinha, 060, 34);
        cdsContatos.FieldByName('BAIRRO').AsString      := Copy(strLinha, 094, 15);
        cdsContatos.FieldByName('CEP').AsString         := Copy(strLinha, 109, 08);
        cdsContatos.FieldByName('CIDADE').AsString      := Copy(strLinha, 117, 20);
        cdsContatos.FieldByName('TIPOCPF').AsString     := strTipCpf;
        cdsContatos.FieldByName('CNPJ').AsString        := IIF(strTipCpf = '2', Copy(strLinha, 140, 11), Copy(strLinha, 137, 14));
        cdsContatos.FieldByName('IES').AsString         := Copy(strLinha, 151, 15);
        cdsContatos.FieldByName('TELEFONE').AsString    := Copy(strLinha, 166, 11);
        cdsContatos.FieldByName('CONTATO').AsString     := Copy(strLinha, 177, 25);
        cdsContatos.FieldByName('REGIAO').AsString      := Copy(strLinha, 202, 02);
        cdsContatos.FieldByName('CONDPAG').AsString     := Copy(strLinha, 204, 03);
        cdsContatos.FieldByName('EMAIL').AsString       := Copy(strLinha, 207, 76);
        cdsContatos.Post;
      End;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Clientes', 0, intLinha, intLinhas);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pRegistraLogImp('Não foi possivel encontrar o arquivo ' + strNomArq + ' Erro: ' + E.Message);
      fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
    End;
  End;

  CloseFile(txtGen);
end;

procedure TfrmTxtImpFullSoft.btnGravarClick(Sender: TObject);
begin
  inherited;
  fGerarContatos;
  fGerarPedidosCabecalho;
  btnGravar.Enabled := False;
  btnImporta.Enabled := True;  
  pRegistraLogImp('Pedidos/Clientes gravados com sucesso!');
  fMensagem('', 'Pedidos/Clientes gravados com sucesso!', ['OK']);
end;

function TfrmTxtImpFullSoft.fCarregaItem(strCodIte: String): Boolean;
begin

  Try
    Result := True;

    qryCadIte.Close;
    qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadIte.ParamByName('CODITE').AsString := strCodIte;
    qryCadIte.Open;

    If qryCadIte.IsEmpty Then
      Result := False;

  Except
    Result := False;
  End;

end;

function TfrmTxtImpFullSoft.fRetSaldoItem(strCodIte: String): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	ITE_SALDOS');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	CADITE I');
  qryGen.SQL.Add('	INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	I.ITE_CODITE = :CODITE');
  qryGen.SQL.Add('	AND G.ITE_CODEMP = :CODEMP');

  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGen.Open;

  Result := qryGen.FieldByName('ITE_SALDOS').AsFloat - fRetornaSalRes(VS_strCodEmp,False, '' , strCodIte, VS_strCodEmp);
  FreeAndNil(qryGen);
end;

function TfrmTxtImpFullSoft.fGerarContatos: Boolean;
  Var
    qryGen: TUniQuery;
    strCliNov: String;
    blnAlterar: Boolean;
begin
  Result := True;

  Try
    qryGen := fCriaQuery(Self);

    cdsContatos.First;
    While Not cdsContatos.Eof Do
    Begin
      blnAlterar := False;

      If (Not fValidaCliente(cdsContatos.FieldbyName('CNPJ').AsString, strCliNov)) Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Text := 'SELECT * FROM CADCLI WHERE FALSE';
        qryGen.Open;

        qryGen.Insert;
        strCliNov := fPadL(fAtualizaProCod('CADCLI'), 8, '0');
        qryGen.FieldByName('CLI_CODCLI').AsString := strCliNov;
        qryGen.FieldByName('CLI_NOMCLI').AsString := cdsContatos.FieldByName('NOMECLIENTE').AsString;
        qryGen.FieldByName('CLI_FONE01').AsString := cdsContatos.FieldByName('TELEFONE').AsString;
        qryGen.FieldByName('CLI_EMAIL_').AsString := cdsContatos.FieldByName('EMAIL').AsString;
        qryGen.FieldByName('CLI_CODEMP').AsString := VS_strCodEmp;
        qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADCLI', VS_strCodEmp);
        qryGen.FieldByName('CLI_FANSOB').AsString := cdsContatos.FieldByName('FANTASIA').AsString;
        qryGen.FieldByName('CLI_ENDERE').AsString := cdsContatos.FieldByName('ENDERECO').AsString;
        qryGen.FieldByName('CLI_BAIRRO').AsString := cdsContatos.FieldByName('BAIRRO').AsString;
        qryGen.FieldByName('CLI_C_E_P_').AsString := cdsContatos.FieldByName('CEP').AsString;
        qryGen.FieldByName('CLI_CODCID').AsString := fRetornaCodCid(cdsContatos.FieldByName('CIDADE').AsString,
                                                                    cdsContatos.FieldByName('CEP').AsString);
        qryGen.FieldByName('CLI_C_G_C_').AsString := cdsContatos.FieldByName('CNPJ').AsString;
        qryGen.FieldByName('CLI_CGCCPF').AsString := cdsContatos.FieldByName('TIPOCPF').AsString;
        qryGen.FieldByName('CLI_I_E_S_').AsString := cdsContatos.FieldByName('IES').AsString;
        qryGen.FieldByName('CLI_CONTAT').AsString := cdsContatos.FieldByName('CONTATO').AsString;
        qryGen.FieldByName('CLI_CODREG').AsString := fPadL(cdsContatos.FieldByName('REGIAO').AsString, 5, '0');

        qryGen.FieldByName('CLI_ENVBOL').AsString := 'N';
        qryGen.FieldByName('CLI_PERMMI').AsString := 'S';
        qryGen.FieldByName('CLI_PERMFF').AsString := 'S';
        qryGen.FieldByName('CLI_ZONFRA').AsString := 'N';
        qryGen.FieldByName('CLI_TABPRE').AsString := '1';
        qryGen.FieldByName('CLI_ORGPUB').AsString := 'N';
        qryGen.FieldByName('CLI_DESPIS').AsString := 'N';
        qryGen.FieldByName('CLI_LIMCRE').AsFloat  := 0.0;
        qryGen.FieldByName('CLI_CONSUM').AsString := 'S';
        qryGen.FieldByName('CLI_STATUS').AsString := 'A';
        qryGen.FieldByName('CLI_CODVEN').AsString := IIF(fEmptyStr(strCodRep), fCfgSisL('VENNOV'), strCodRep);
        qryGen.FieldByName('CLI_CODREP').AsString := IIF(fEmptyStr(strCodRep), fCfgSisL('REPNOV'), strCodRep);

        qryGen.FieldByName('CLI_DTACAD').AsDateTime := VS_Date;
        qryGen.Post;

        With cdsPedidos Do
        Begin

          First;
          While Not Eof Do
          Begin
            If SameText(FieldByName('CPFCNPJ').AsString, cdsContatos.FieldByName('CNPJ').AsString) Then
            Begin
              Edit;
              FieldByName('CODIGOCLIENTE').AsString := strCliNov;
              Post;
            End;
            Next;
          End;

        End;

      End
      Else
      Begin
        If SameText(cdsContatos.FieldByName('TIPMANUT').AsString, 'I') Then
        Begin
          pRegistraLogImp('Cliente ' + cdsContatos.FieldbyName('CNPJ').AsString + ' ' +
                          'preparado para novo cadastro.' + #13#10 +
                          'Porém já existe este CPF/CNPJ cadastrado.' + #13#10 +
                          'Cliente: ' + strCliNov + '-' + fRetNomCliente(strCliNov));


          blnAlterar := fMensagem('', 'Cliente ' + cdsContatos.FieldbyName('CNPJ').AsString + ' ' +
                                      'preparado para novo cadastro.' + #13#10 +
                                      'Porém já existe este CPF/CNPJ cadastrado.' + #13#10 +
                                      'Cliente: ' + strCliNov + '-' + fRetNomCliente(strCliNov) + #13#10 +
                                      'Deseja Atualizar os dados do cliente?', ['', '']) = 1;
        End
        Else
          blnAlterar := SameText(cdsContatos.FieldByName('TIPMANUT').AsString, 'A');
      End;

      If blnAlterar Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Text := 'SELECT * FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(strCliNov);
        qryGen.Open;

        If Not qryGen.IsEmpty Then
        Begin
          qryGen.Edit;
          qryGen.FieldByName('CLI_FONE01').AsString := cdsContatos.FieldByName('TELEFONE').AsString;
          qryGen.FieldByName('CLI_EMAIL_').AsString := cdsContatos.FieldByName('EMAIL').AsString;
          qryGen.FieldByName('CLI_FANSOB').AsString := cdsContatos.FieldByName('FANTASIA').AsString;
          qryGen.FieldByName('CLI_ENDERE').AsString := cdsContatos.FieldByName('ENDERECO').AsString;
          qryGen.FieldByName('CLI_BAIRRO').AsString := cdsContatos.FieldByName('BAIRRO').AsString;
          qryGen.FieldByName('CLI_C_E_P_').AsString := cdsContatos.FieldByName('CEP').AsString;
          qryGen.FieldByName('CLI_CODCID').AsString := fRetornaCodCid(cdsContatos.FieldByName('CIDADE').AsString,
                                                                      cdsContatos.FieldByName('CEP').AsString);
          qryGen.FieldByName('CLI_I_E_S_').AsString := cdsContatos.FieldByName('IES').AsString;

          If Not fEmptyStr(strCodRep) Then
          Begin
            qryGen.FieldByName('CLI_CODVEN').AsString := strCodRep;
            qryGen.FieldByName('CLI_CODREP').AsString := strCodRep;
          End;

          qryGen.FieldByName('CLI_CONTAT').AsString := cdsContatos.FieldByName('CONTATO').AsString;
          qryGen.FieldByName('CLI_CODREG').AsString := fPadL(cdsContatos.FieldByName('REGIAO').AsString, 5, '0');
          qryGen.Post;
        End;
        
      End;

      cdsContatos.Edit;
      cdsContatos.FieldByName('CODIGO').AsString := strCliNov;
      cdsContatos.Post;

      pRegistrarProgresso('Cadastrando contatos...', 0, cdsContatos.RecNo, cdsContatos.RecordCount);
      pRegistraLogImp('Cadastrando/Atualizando contato ' + strCliNov);
      cdsContatos.Next;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TfrmTxtImpFullSoft.fValidaCliente(strCodCli: String; var strCodigo: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.Sql.Text := 'SELECT CLI_CODCLI FROM CADCLI WHERE CLI_C_G_C_ = :CPFCGC';
  qryGen.ParamByName('CPFCGC').AsString := strCodCli;
  qryGen.Open;

  strCodigo := qryGen.FieldByName('CLI_CODCLI').AsString;
  Result    := Not fEmptyStr(strCodigo);
  FreeAndNil(qryGen);
end;

function TfrmTxtImpFullSoft.fRetornaCodCid(strCidade: String; strCepCid: String): String;
  Var
    qryGen: TUniQuery;
    qryNew: TUniQuery;
    strCid: String;
begin
  qryGen := fCriaQuery(Self);
  qryGen.Sql.Text := ' SELECT CID_CODCID FROM CADCID WHERE CID_NOMCID = :NOMCID LIMIT 1 ';
  qryGen.ParamByName('NOMCID').AsString := strCidade;
  qryGen.Open;
  strCid := qryGen.FieldByName('CID_CODCID').AsString;

  If fEmptyStr(strCid) Then
  Begin
    qryNew := fCriaQuery(Self);
    qryNew.Sql.Text := ' INSERT INTO CADCID (CID_CODCID, CID_NOMCID, CID_ESTADO, CID_C_E_P_, CID_CODEMP, ' +
                       ' AUTOINCREM, CID_VALENT, CID_CODPAI) VALUES (:CODIGO, :NOMCID, :ESTCID, :CEPCID, ' +
                       ' :CODEMP, :AUTINC, :VALENT, :CODPAI) ';
    strCid := fAtualizaProCod('CADCID');
    qryNew.ParamByName('CODIGO').AsString := strCid;
    qryNew.ParamByName('NOMCID').AsString := strCidade;
    //Rotina usada somente pela Progresso para cadastramento de clientes do PDA...
    //Eles garantem que só existirão cidades do Estado de RS!!! Ainda assim é rotina temporária...
    qryNew.ParamByName('ESTCID').AsString := 'RS';
    qryNew.ParamByName('CEPCID').AsString := fPadR(strCepCid, 05);
    qryNew.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNew.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADCID', VS_strCodEmp);
    qryNew.ParamByName('VALENT').AsFloat  := 0;
    qryNew.ParamByName('CODPAI').AsString := '1058';
    qryNew.ExecSQL;
    qryNew.Close;
    FreeAndNil(qryNew);
  End;

  Result := strCid;
  FreeAndNil(qryGen);
end;

procedure TfrmTxtImpFullSoft.dbgPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (Key = #13) And (Not cdsPedidos.IsEmpty) Then
  Begin
    cdsPedidos.Edit;
    cdsPedidos.FieldByName('MARCADO').AsBoolean := Not cdsPedidos.FieldByName('MARCADO').AsBoolean;
    cdsPedidos.Post;
  End
  Else If Key = #27 Then
  Begin
    pSetFocus(btnSair);
  End;

end;

procedure TfrmTxtImpFullSoft.dirPathExpExit(Sender: TObject);
begin
  inherited;
  dirPathExp.Text := AnsiReplaceStr(dirPathExp.Text, '"', '');
end;

procedure TfrmTxtImpFullSoft.pAtualizaDados(DataSet: TDataSet);
begin
  intRecAtu := cdsPedidos.RecNo;
end;

procedure TfrmTxtImpFullSoft.pCalculaTotalItens;
  Var
    fltTotIte: Double;
begin

  Try

    With cdsPedidosItens Do
    Begin
      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin
        fltTotIte := 0.0;

        Filtered := False;
        Filter   := 'NUMEROPEDIDO = ' + QuotedStr(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);
        Filtered := True;

        First;

        While Not Eof Do
        Begin
          fltTotIte := fltTotIte + (FieldByName('QUANTIDADE').AsFloat * FieldByName('PRECOVENDA').AsFloat);
          Next;
        End;

        cdsPedidos.Edit;
        cdsPedidos.FieldByName('TOTALVENDA').AsFloat := fFormataFloat(fltTotIte, 2);
        cdsPedidos.Post;

        cdsPedidos.Next;
      End;

      Filtered := False;
      Filter   := '';

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

end;

function TfrmTxtImpFullSoft.fValidaClientesPedido: Boolean;
begin
  Result := True;

  With cdsPedidos Do
  Begin
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(fRetNomCliente(FieldByName('CODIGOCLIENTE').AsString)) And
         ( (fEmptyStr(FieldByName('CPFCNPJ').AsString)     ) Or
           (StrToInt64(FieldByName('CPFCNPJ').AsString) = 0) ) Then
      Begin
        pRegistraLogImp('Se o Cpf/Cnpj "' + FieldByName('CPFCNPJ').AsString +
                        '" não for de um Cliente Novo, não ' + #13#10 +
                        'existe cadastro do mesmo. Favor verificar antes de continuar...');

        fMensagem('', 'Se o Cpf/Cnpj "' + FieldByName('CPFCNPJ').AsString +
                      '" não for de um Cliente Novo, não ' + #13#10 +
                      'existe cadastro do mesmo. Favor verificar antes de continuar...', ['OK']);
        Result := False;
      End;

      Next;
    End;
  End;
end;

end.
