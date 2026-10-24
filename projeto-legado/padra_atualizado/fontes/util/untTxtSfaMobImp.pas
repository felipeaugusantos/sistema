unit untTxtSfaMobImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Gauges, StdCtrls, CheckLst, Mask, UniClientDataSet, DB,
  DirectoryEditFocus, AppEvnts, Menus, Buttons, ExtCtrls, Uni,
  ComCtrls, Grids, DBGridCitel, DBGrids,   frxClass, frxDBSet, untPaiRelatorio,
  untAtualizaOcorrenciasCRM, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, untConstantes;

Type
  TRecSfaMobImpFiles = record
    strContatos,
    strComunica,
    strEstoque,
    strNaoVenda,
    strNaoVisita,
    strPedidoCab,
    strPedidoItens,
    strPlanoVisita,
    strVersaoPocket: String;
    dtaDataTransmissao,
    tmrHoraTransmissao: TDateTime;
  end;

Type
  TArrRecSfaMobImpFiles = Array Of TRecSfaMobImpFiles;

Type
  TArquivosExportar = class
  private
    FchkLstItensExportar: TCheckListBox;
    FItens: Array of TBooleanFunction;
    procedure SetchkLstItensExportar(const Value: TCheckListBox);
    function GetItens(index: Integer): TBooleanFunction;
    procedure SetItens(index: Integer;
      const Value: TBooleanFunction);
    function GetCount: Integer;
  public
    constructor Create(chkLstItensExportar: TCheckListBox);

    function fAdicionarItem(strTexto: String; funcao: TBooleanFunction; blnMarcado: Boolean): Boolean;
    function fGerarArquivos: Boolean;

    property chkLstItensExportar: TCheckListBox read FchkLstItensExportar write SetchkLstItensExportar;
    property Itens[index: Integer]: TBooleanFunction read GetItens write SetItens;
    property Count: Integer read GetCount;
  End;

type
  TfrmTxtSfaMobImp = class(TfrmPai)
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
    tbImprimir: TTabSheet;
    rgRelatorios: TRadioGroup;
    frxRelVisitasNaoRealizadas: TfrxReport;
    frxDBVisitas: TfrxDBDataset;
    frxDBVendas: TfrxDBDataset;
    frxRelPlanejamento: TfrxReport;
    frxDBPlanejamento: TfrxDBDataset;
    frxRelVendasNaoRealizadas: TfrxReport;
    tmrFecha: TTimer;
    btnImporta: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    dirPathExp: TfraDirectoryEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosDblClick(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    arquivosExportar: TArquivosExportar;
    intSemaforo: Integer;

    cdsPedidos: TUniClientDataSet;
    cdsPedidosItens: TUniClientDataSet;

    dtsPedidos: TDataSource;
    dtsPedidosItens: TDataSource;

    cdsVisitas: TUniClientDataSet;
    dtsVisitas: TDataSource;

    cdsVendasNao: TUniClientDataSet;
    dtsVendasNao: TDataSource;

    cdsContatos: TUniClientDataSet;
    dtsContatos: TDataSource;

    cdsPlanejamento: TUniClientDataSet;
    dtsPlanejamento: TDataSource;

    qryPedidos: TUniQuery;
    qryCadIte: TUniQuery;

    fltPesLiq: Double;
    fltPesBru: Double;

    blnGerou: Boolean;
    blnEmpFat: Boolean;

    strPathImportados: String;

    sfaFiles: TRecSfaMobImpFiles;

    objOcoCrm: TAtuOcoCrm;

    procedure pCalculaPesBruLiq;
    procedure pApagarArquivoDisco(strArquivo: String);
    function fArquivosParaImportacao: TArrRecSfaMobImpFiles;

  protected

    procedure pAssociarItens;
    procedure pCriarDataSets;
    procedure pLigaDataSet;
    procedure pRegistrarProgresso(strTexto: String; intInicio, intAtual, intFinal: Integer);

    function fImportaData(strData: String): TDate;
    function fImportaHora(strHora: String): TTime;
    function fImportaFloat(strValor: String): Double;
    function fContaLinhas(strArq: String): Integer;
    function fCarregaItem(strCodIte: String): Boolean;
    function fRetSaldoItem(strCodIte: String): Double;
    function fValidaCliente(strCodCli: String): Boolean;

    function fGerarPedidosCabecalho: Boolean;
    function fGerarContatos: Boolean;
    function fCarregarPedidos: Boolean;
    function fCarregarPedidosItens: Boolean;
    function fCarregarVisitasNaoRealizadas: Boolean;
    function fCarregarVendasNaoRealizadas: Boolean;
    function fCarregarContatos: Boolean;
    function fCarregarPlanejamentos: Boolean;
  public
    { Public declarations }
    blnGeracaoAut: Boolean;
  end;

Const
  LAYOUT_ACUMULATIVO = '1';
  LAYOUT_BLOCO_TRANSMISSAO = '2';

implementation

uses untFuncoes,untFuncoesCRM, untFuncoesSimples, StrUtils, untFatGor,
  untTypesSistema, untTypesCRM, untTFatReservaSaldo;

{$R *.dfm}

{ TfrmTxtSfaMobImp }

procedure TfrmTxtSfaMobImp.pAssociarItens;
begin
  arquivosExportar.fAdicionarItem('Pedidos', fCarregarPedidos, True);
  arquivosExportar.fAdicionarItem('Ocorrências - Visitas não realizadas', fCarregarVisitasNaoRealizadas, True);
  arquivosExportar.fAdicionarItem('Ocorrências - Vendas não realizadas', fCarregarVendasNaoRealizadas, True);
  arquivosExportar.fAdicionarItem('Contatos', fCarregarContatos, True);
  arquivosExportar.fAdicionarItem('Planejamento de visitas', fCarregarPlanejamentos, False);
end;

procedure TfrmTxtSfaMobImp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(arquivosExportar);
end;

procedure TfrmTxtSfaMobImp.FormCreate(Sender: TObject);
begin
  inherited;
  blnEmpFat := fCfgSis('EMPFAT', varBoolean);
  arquivosExportar := TArquivosExportar.Create(chkLstItensExportar);
  intSemaforo := 0;
  pCriarDataSets;
  pLigaDataSet;
  blnGeracaoAut := False;
  blnGerou  := False;
  strPathImportados := fCfgSis('PEDSFM');  
end;

function TfrmTxtSfaMobImp.fGerarPedidosCabecalho: Boolean;
  Var
    strAutInc: String;
    strAutFdo: String;
    strNumDoc: String;
    blnImpRef: Boolean;
    strEspDoc: String;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  Result := cdsPedidos.RecordCount > 0;

  If Result Then
  Begin
    blnImpRef := fCfgSis('IMPREF', varBoolean);
    strEspDoc := fCfgSisL('TPDSFM');

    If fEmptyStr(strEspDoc) Then
      strEspDoc := 'PD';

    Try
      cdsPedidos.First;
      cdsPedidosItens.First;

      While Not cdsPedidos.Eof Do
      Begin
        If cdsPedidos.FieldByName('MARCADO').AsBoolean Then
        Begin
          fStartTransaction;
          If (strEspDoc = 'PD') Then
            strNumDoc := fRetSequencialPedido(VS_strCodEmp)
          Else
            strNumDoc := fRetSequencial('PRO_' + strEspDoc, VS_strCodEmp, fTamDocCadRec);

          pCalculaPesBruLiq;

          If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
            objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,'PD',VS_strCodEmp,cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,'','',cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString,afcPedido);

          FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

          objOcoCrm.strNomFrm := Self.Name;
          If fGravaFatGor(strAutInc,                                                                                   // strIncrem
                          VS_strCodEmp,                                                                                //  strCodEmp
                          strNumDoc,                                                                    //  strNumDoc
                          strEspDoc,                                                                                   //  strEspDoc
                          cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                           //  strCodCli
                          cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString,                                           //  strCodVen
                          '',                                                                                          //  strCodTra
                          '',                                                                                          //  strSerie:
                          cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,                                         //  dtaDtaEnt
                          cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                            //  dtaHorEnt
                          fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                            //  strConPag
                          '',                                                                                          //  strEstado
                          '',                                                                                          //  strNomCom
                          '',                                                                                          //  strEndCon
                          '',                                                                                          //  strBaiCon
                          '',                                                                                          //  strCepCon
                          '',                                                                                          //  strCidCon
                          '',                                                                                          //  strEstCon
                          '',                                                                                          //  strCodAti
                          '',                                                                                          //  strTelCon
                          0,                                                                                           //  dtaNasCon
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
                          cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat,                                              //  fltVlrCon
                          cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat,                                              //  fltTotPro
                          cdsPedidos.FieldByName('TOTALBRUTO').AsFloat,                                                //  fltTotCus
                          cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat,                                              //  fltTotMed
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
                          fltPesBru,                                                                                   //fltPesBru
                          fltPesLiq,                                                                                   //  fltPesLiq
                          0,                                                                                           //  fltVolume
                          arrDuplic,                                                                                   //  arrDuplic
                          '',                                                                                          //  strEspeci
                          '',                                                                                          //  strMarca,
                          cdsPedidos.FieldByName('OBSERVACAO1').AsString,                                                              //  strMen001
                          cdsPedidos.FieldByName('OBSERVACAO2').AsString,                                                              //  strMen002
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
                          cdsPedidos.FieldByName('CODCONDPGTO').AsString,                                              //  strCodCnd
                          cdsPedidos.FieldByName('CODFORMAPGTO').AsString,                                             //  strCodFpg
                          recServicos,
                          '',                                                                                          //  strConEnt
                          VS_Date,                                                                                     //  dtaPreVis
                          0.0,                                                                                         //  fltVPgAnt
                          VS_Date,                                                                                     //  dtaUltAlt
                          '',                                                                                          //  strNTrava
                          cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString,                                            //  strTipPed
                          '',                                                                                          //  strCliCtt
                          0,                                                                                       //  blnLibera
                          'S',                                                                                         //  strEntFat
                          0.0,                                                                                         //  fltDesCon
                          cdsPedidos.FieldByName('CODTABPRECO').AsString,                                              //  strTabPre
                          '',                                                                                          //  strEntFut
                          0.0,                                                                                         //  fltMargem
                          cdsPedidos.FieldByName('NUMEROPEDIDO').AsString,                                             //  strNumPok
                          '',                                                                                          //  strEmp_CD
                          False,                                                                                       //  blnEnt_CD
                          'N',                                                                                         //  strOprFlj
                          '',                                                                                          //  strMenExp
                          '',                                                                                          //  strMenExp
                          '',                                                                                          //  strMenExp
                          '',                                                                                          //  strMenExp
                          '',
                          '',
                          True,                                                                                       //  blnPedLib
                          0.0,
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
                          '',
                          cdsPedidos.FieldByName('HORAFINAL').AsDateTime,
                          cdsPedidos.FieldByName('DATATRANSMISSAO').AsDateTime,
                          cdsPedidos.FieldByName('HORATRANSMISSAO').AsDateTime,
                          '',
                          objOcoCrm,
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
            cdsPedidosItens.First;

            While Not cdsPedidosItens.Eof Do
            Begin
              If fCarregaItem(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString) Then
              Begin
                strAutFdo := '';
                If Not fGravaFatDor(strAutFdo,
                                    strAutInc,                                                                                            // strSeqGer
                                    VS_strCodEmp,                                                                                         //  strCodEmp
                                    cdsPedidos.FieldByName('CODIGOCLIENTE').AsString,                                                                                            //  strCodCli
                                    cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString,                                                                                            //  strCodVen
                                    cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString,                                                         //  strCodIte
                                    qryCadIte.FieldByName('ITE_CODMAR').AsString,                                                           //  strCodMar
                                    '',                                                                                                   //  strCodDiv
                                    strNumDoc,                                                                                            //  strNumDoc
                                    strEspDoc,                                                                                            //  strEspDoc
                                    '',                                                                                                   //  strSerie:
                                    cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime,
                                    cdsPedidos.FieldByName('HORAINICIAL').AsDateTime,                                                            //  dtaHorEnt
                                    fRetConPagCodCnd(cdsPedidos.FieldByName('CODCONDPGTO').AsString),                                                                          //  strConPag
                                    '',                                                                                                   //  strEstado
                                    IIF(blnImpRef,
                                        IIF(fCfgSis('MONDES', varString) = '1',
                                              qryCadIte.FieldByName('ITE_DESITE').AsString +
                                              IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),' ' + qryCadIte.FieldByName('ITE_REFERE').AsString,''),
                                              IIF(Not fEmptyStr(qryCadIte.FieldByName('ITE_REFERE').AsString),qryCadIte.FieldByName('ITE_REFERE').AsString + ' ','') +
                                              qryCadIte.FieldByName('ITE_DESITE').AsString),
                                        qryCadIte.FieldByName('ITE_DESITE').AsString),                                                      //  strDescri
                                    qryCadIte.FieldByName('ITE_REFERE').AsString,                                                           //  strRefere
                                    qryCadIte.FieldByName('ITE_CODUNI').AsString,                                                           //  strUnidad
                                    qryCadIte.FieldByName('ITE_CODFOR').AsString,                                                           //  strForIte
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat,                                                          //  fltQtdIte
                                    cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                          //  fltUnitar
                                    cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                          //  fltUniOri
                                    cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat,                                                          //  fltUniVis
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                          //  fltTotIte
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                          //  fltVlrCon
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat,              //  fltTotCus
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PREMED').AsFloat,              //  fltTotMed
                                    0.0,                                                                                                  //  fltDesCon
                                    0.0,                                                                                                  //  fltTotFre
                                    0.0,                                                                                                  //  fltDesEsp
                                    0.0,                                                                                                  //  fltDesAce
                                    '',                                                                                                   //  strCodRep
                                    '',                                                                                                   //  strCodVe2
                                    qryCadIte.FieldByName('ITE_PRECOM').AsFloat,                                                          //  fltPerCom
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCom
                                    cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat * qryCadIte.FieldByName('ITE_PRECOM').AsFloat,      //  fltTotCo2
                                    '',                                                                                                   //  strClaFis
                                    '',                                                           //  strCodFis
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
                                    '',                                                                                                   //  strEmpFat
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
                                    cdsPedidosItens.RecNo,                                                                                            //  intSeqInd
                                    0.0,                                                                                                  //  fltQtdBai
                                    cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat,                                                          //  fltUniDig
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
                                    'E',
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
                                    '',
                                    '',
                                    0,
                                    '',
                                    '',
                                    0,
                                    0,
                                    0) Then

                Begin
                  fRollBack;
                  pMensagensErro('Não foi possivel importar os pedidos', 'TfrmTxtSfaMobImp.fGerarPedidosCabecalho');
                  Exit;
                End;
              End;

              cdsPedidosItens.Next;
            End;

            pRegistrarProgresso('Gravando Pedidos', 0, cdsPedidos.RecNo, cdsPedidos.RecordCount);
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
      pMensagensErro('Não foi possivel importar os pedidos', 'TfrmTxtSfaMobImp.fGerarPedidosCabecalho');
    End;
  End;

end;

procedure TfrmTxtSfaMobImp.pApagarArquivoDisco(strArquivo: String);
  Var
    strDestino: String;
    strNomeArq: String;    
begin
  strArquivo := dirPathExp.edtDirectory.text + '\' + strArquivo;
  strNomeArq := ExtractFileName(strArquivo);

  strDestino := strPathImportados + '\' + strNomeArq + '-' +
                FormatDateTime('yyyymmdd', VS_Date)  + '-' +
                FormatDateTime('hhmmss', fTime())       + '.IMP';

  If FileExists(strArquivo) Then
  Begin
    CopyFile(PChar(strArquivo), PChar(strDestino), True);
    DeleteFile(strArquivo);
  End;
end;

procedure TfrmTxtSfaMobImp.btnImportaClick(Sender: TObject);
  Var
    arrFilesImp: TArrRecSfaMobImpFiles;
    intContador: Integer;
    blnImportou: Boolean;
begin
  inherited;
  If InterlockedIncrement(intSemaforo) = 1 Then
  Begin
    blnImportou := False;
    arrFilesImp := fArquivosParaImportacao;

    For intContador := 0 To Length(arrFilesImp) -1 Do
    Begin
      sfaFiles := arrFilesImp[intContador];

      If arquivosExportar.fGerarArquivos Then
      Begin
        blnImportou := True;
        pApagarArquivoDisco(sfaFiles.strContatos);
        pApagarArquivoDisco(sfaFiles.strComunica);
        pApagarArquivoDisco(sfaFiles.strEstoque);
        pApagarArquivoDisco(sfaFiles.strNaoVenda);
        pApagarArquivoDisco(sfaFiles.strNaoVisita);
        pApagarArquivoDisco(sfaFiles.strPedidoCab);
        pApagarArquivoDisco(sfaFiles.strPedidoItens);
        pApagarArquivoDisco(sfaFiles.strPlanoVisita);
        pApagarArquivoDisco(sfaFiles.strVersaoPocket);
      End;

    End;

    If blnImportou Then
    Begin
      If Not blnGeracaoAut Then
        fMensagem('', 'Importação concluída com sucesso!', ['OK']);

      pgDados.ActivePage := tbDados;
      btnGravar.Enabled := True;
      btnImprimir.Enabled := True;
      pnlInfo.Caption := '';
      btnImporta.Enabled := False;
    End;

    SetLength(arrFilesImp, 0);          

    InterlockedDecrement(intSemaforo);
    
  End
  Else
    InterlockedDecrement(intSemaforo);

end;

procedure TfrmTxtSfaMobImp.pCriarDataSets;
begin
  cdsPedidos := TUniClientDataSet.Create(Self);
  cdsPedidosItens := TUniClientDataSet.Create(Self);

  qryPedidos := fCriaQuery(Self);
  qryPedidos.SQL.Text := 'SELECT DISTINCT FGO_NUMPOK FROM FATGOR WHERE FGO_NUMPOK';
  qryPedidos.Open;

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Add(' SELECT * ');
  qryCadIte.SQL.Add(' FROM CADITE ');
  qryCadIte.SQL.Add('   INNER JOIN ITEGER ');
  qryCadIte.SQL.Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
  qryCadIte.SQL.Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
  qryCadIte.SQL.Add('     AND CADITE.ITE_CODITE = :CODITE ');


  cdsPedidos.FieldDefs.Add('NUMEROPEDIDO',      ftString, 030,  True);
  cdsPedidos.FieldDefs.Add('DATAPEDIDO',        ftDate);
  cdsPedidos.FieldDefs.Add('CODIGOCLIENTE',     ftString, 250,  True);
  cdsPedidos.FieldDefs.Add('HORAINICIAL',       ftTime);
  cdsPedidos.FieldDefs.Add('HORAFINAL',         ftTime);
  cdsPedidos.FieldDefs.Add('DATAFATURAMENTO',   ftDate);
  cdsPedidos.FieldDefs.Add('CODTIPOPEDIDO',     ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('CODCONDPGTO',       ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('CODFORMAPGTO',      ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('CODTABPRECO',       ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('TIPOFRETE',         ftString, 001,  True);
  cdsPedidos.FieldDefs.Add('ORDEMCOMPRA',       ftString, 050,  False);
  cdsPedidos.FieldDefs.Add('OBSERVACAO1',       ftString, 200,  False);
  cdsPedidos.FieldDefs.Add('OBSERVACAO2',       ftString, 200,  False);
  cdsPedidos.FieldDefs.Add('TOTALBRUTO',        ftFloat);
  cdsPedidos.FieldDefs.Add('TOTALLIQUIDO',      ftFloat);
  cdsPedidos.FieldDefs.Add('EMAILCOPIAPEDIDO',  ftString, 100,  False);
  cdsPedidos.FieldDefs.Add('CODIGOVENDEDOR',    ftString, 010,  True);
  cdsPedidos.FieldDefs.Add('MARCADO',           ftBoolean);
  cdsPedidos.FieldDefs.Add('DATATRANSMISSAO',   ftDate);
  cdsPedidos.FieldDefs.Add('HORATRANSMISSAO',   ftTime);
  cdsPedidos.CreateDataSet;
  dtsPedidos := fCriaDataSource(cdsPedidos);

  cdsPedidosItens.FieldDefs.Add('NUMEROPEDIDO',   ftString, 030,  True);
  cdsPedidosItens.FieldDefs.Add('CODIGOPRODUTO',  ftString, 030,  True);
  cdsPedidosItens.FieldDefs.Add('QUANTIDADE',     ftFloat);
  cdsPedidosItens.FieldDefs.Add('PRECOVENDA',     ftFloat);
  cdsPedidosItens.FieldDefs.Add('DESCONTO',       ftFloat);
  cdsPedidosItens.FieldDefs.Add('PRECOTABELA',    ftFloat);
  cdsPedidosItens.FieldDefs.Add('OBSERVACAO',     ftString, 030,  False);
  cdsPedidosItens.FieldDefs.Add('SALDO',          ftFloat);
  cdsPedidosItens.CreateDataSet;
  dtsPedidosItens := fCriaDataSource(cdsPedidosItens);

  cdsPedidosItens.MasterFields := 'NUMEROPEDIDO';
  cdsPedidosItens.IndexFieldNames := 'NUMEROPEDIDO';
  cdsPedidosItens.MasterSource := dtsPedidos;

  TTimeField(cdsPedidos.FieldByName('HORAINICIAL')).DisplayFormat := 'HH:MM';
  TTimeField(cdsPedidos.FieldByName('HORAFINAL')).DisplayFormat := 'HH:MM';
  TFloatField(cdsPedidos.FieldByName('TOTALBRUTO')).currency := True;
  TFloatField(cdsPedidos.FieldByName('TOTALLIQUIDO')).currency := True;

  TFloatField(cdsPedidosItens.FieldByName('QUANTIDADE')).DisplayFormat := '0.00';
  TFloatField(cdsPedidosItens.FieldByName('PRECOVENDA')).currency := True;
  TFloatField(cdsPedidosItens.FieldByName('DESCONTO')).DisplayFormat := '0.00';
  TFloatField(cdsPedidosItens.FieldByName('PRECOTABELA')).currency := True;
  TFloatField(cdsPedidosItens.FieldByName('SALDO')).DisplayFormat := '0.00';

  cdsVisitas := TUniClientDataSet.Create(Self);
  cdsVisitas.FieldDefs.Add('CODIGOCLIENTE', ftString, 250, True);
  cdsVisitas.FieldDefs.Add('DATAPEDIDO',    ftDate);
  cdsVisitas.FieldDefs.Add('HORARIO',       ftTime);
  cdsVisitas.FieldDefs.Add('CODIGOMOTIVO',  ftString, 10);
  cdsVisitas.FieldDefs.Add('OBSERVACAO',    ftString, 200, False);
  cdsVisitas.CreateDataSet;
  dtsVisitas := fCriaDataSource(cdsVisitas);

  cdsVendasNao := TUniClientDataSet.Create(Self);
  cdsVendasNao.FieldDefs.Add('CODIGOCLIENTE', ftString, 250, True);
  cdsVendasNao.FieldDefs.Add('DATAPEDIDO',    ftDate);
  cdsVendasNao.FieldDefs.Add('HORARIO',       ftTime);
  cdsVendasNao.FieldDefs.Add('CODIGOMOTIVO',  ftString, 10, False);
  cdsVendasNao.FieldDefs.Add('OBSERVACAO',    ftString, 200, False);
  cdsVendasNao.CreateDataSet;
  dtsVendasNao := fCriaDataSource(cdsVendasNao);

  cdsContatos := TUniClientDataSet.Create(Self);
  cdsContatos.FieldDefs.Add('CODIGO',       ftString, 20,   True);
  cdsContatos.FieldDefs.Add('NOMECONTATO',  ftString, 80,   True);
  cdsContatos.FieldDefs.Add('HOBBY',        ftString, 50,   False);
  cdsContatos.FieldDefs.Add('TIME',         ftString, 50,   False);
  cdsContatos.FieldDefs.Add('TELEFONE',     ftString, 20,   False);
  cdsContatos.FieldDefs.Add('ANIVERSARIO',  ftString, 5,    False);
  cdsContatos.FieldDefs.Add('CARGO',        ftString, 50,   False);
  cdsContatos.FieldDefs.Add('EMAIL',        ftString, 250,  False);
  cdsContatos.FieldDefs.Add('CODIGORCA',    ftString, 10,   False);
  cdsContatos.CreateDataSet;
  dtsContatos := fCriaDataSource(cdsContatos);

  cdsPlanejamento := TUniClientDataSet.Create(Self);
  cdsPlanejamento.FieldDefs.Add('PERIOCIDADE',    ftString, 20, True);
  cdsPlanejamento.FieldDefs.Add('DATABASE',       ftDate);
  cdsPlanejamento.FieldDefs.Add('SEQVISITA',      ftString, 10, False);
  cdsPlanejamento.FieldDefs.Add('HORARIO',        ftString, 20, False);
  cdsPlanejamento.FieldDefs.Add('CODIGOCLIENTE',  ftString, 20, True);
  cdsPlanejamento.FieldDefs.Add('OBSERVACAO',     ftString, 200, False);
  cdsPlanejamento.CreateDataSet;
  dtsPlanejamento := fCriaDataSource(cdsPlanejamento);

end;

function TfrmTxtSfaMobImp.fCarregarPedidos: Boolean;
  Var
    txtGen   : TextFile;
    strNomArq: String;
    strLinha : String;
    intLinha : Integer;
    intLinhas: Integer;
begin
  Result := True;
  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strPedidoCab;
    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      Exit;
    End;

    intLinha  := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      If Not qryPedidos.Locate('FGO_NUMPOK', Copy(strLinha, 1, Pos('|', strLinha) - 1), []) Then
      Begin
        cdsPedidos.Insert;
        cdsPedidos.FieldByName('NUMEROPEDIDO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime := fImportaData(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODIGOCLIENTE').AsString := LeftStr(Copy(strLinha, 1, Pos('|', strLinha) - 1), 8);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('HORAINICIAL').AsDateTime := fImportaHora(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('HORAFINAL').AsDateTime := fImportaHora(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('DATAFATURAMENTO').AsDateTime := fImportaData(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        //cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODCONDPGTO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODFORMAPGTO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODTABPRECO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('TIPOFRETE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('ORDEMCOMPRA').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('OBSERVACAO1').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('OBSERVACAO2').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('TOTALBRUTO').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('EMAILCOPIAPEDIDO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidos.FieldByName('MARCADO').AsBoolean := True;

        If StrToIntDef(cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString, 0) = 0 Then
          cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString := 'A'
        Else
          cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString := 'B';

        If sfaFiles.dtaDataTransmissao > 0 Then
          cdsPedidos.FieldByName('DATATRANSMISSAO').AsDateTime := sfaFiles.dtaDataTransmissao;

        If sfaFiles.tmrHoraTransmissao > 0 Then
          cdsPedidos.FieldByName('HORATRANSMISSAO').AsDateTime := sfaFiles.tmrHoraTransmissao;

        cdsPedidos.Post;
      End;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Pedidos', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);

  Result := Result And fCarregarPedidosItens;

  cdsPedidos.First;
  While Not cdsPedidos.Eof Do
  Begin
    If cdsPedidosItens.RecordCount = 0 Then
      cdsPedidos.Delete
    Else
      cdsPedidos.Next;
  End;
end;

function TfrmTxtSfaMobImp.fCarregarPedidosItens: Boolean;
  Var
    txtGen: TextFile;
    strNomArq: String;
    strLinha: String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strPedidoItens;

    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      If Not qryPedidos.Locate('FGO_NUMPOK', Copy(strLinha, 1, Pos('|', strLinha) - 1), []) Then
      Begin
        cdsPedidosItens.Insert;
        cdsPedidosItens.FieldByName('NUMEROPEDIDO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        If Not fCarregaItem(Copy(strLinha, 1, Pos('|', strLinha) - 1)) Then
        Begin
          cdsPedidosItens.Cancel;
          Break;
        End;

        cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('QUANTIDADE').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('PRECOVENDA').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('DESCONTO').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat := fImportaFloat(Copy(strLinha, 1, Pos('|', strLinha) - 1));
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('OBSERVACAO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

        cdsPedidosItens.FieldByName('SALDO').AsFloat := fRetSaldoItem(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString);

        cdsPedidosItens.Post;
      End;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Itens', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);
end;

function TfrmTxtSfaMobImp.fImportaData(strData: String): TDate;
begin
  Insert('/', strData, 3);
  Insert('/', strData, 6);
  Result := StrToDate(strData);
end;

function TfrmTxtSfaMobImp.fImportaHora(strHora: String): TTime;
begin
  Insert(':', strHora, 3);
  Insert(':', strHora, 6);
  Result := StrToTime(strHora);
end;

function TfrmTxtSfaMobImp.fImportaFloat(strValor: String): Double;
begin
  strValor := AnsiReplaceStr(strValor, '.', ',');
  Result := fStrToFloat(strValor);
end;

function TfrmTxtSfaMobImp.fContaLinhas(strArq: String): Integer;
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

procedure TfrmTxtSfaMobImp.pRegistrarProgresso(strTexto: String; intInicio,
  intAtual, intFinal: Integer);
begin
  barEspecifico.MaxValue := intFinal;
  barEspecifico.MinValue := intInicio;
  barEspecifico.Progress := intAtual;
  pnlInfo.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmTxtSfaMobImp.FormShow(Sender: TObject);
begin
  inherited;
  pAssociarItens;
  dirPathExp.edtDirectory.text := fCfgSis('IMPSFM');
end;

procedure TfrmTxtSfaMobImp.pLigaDataSet;
begin
  dbgPedidos.DataSource := dtsPedidos;
  dbgPedidosItens.DataSource := dtsPedidosItens;
end;

procedure TfrmTxtSfaMobImp.dbgPedidosDblClick(Sender: TObject);
begin
  inherited;
  cdsPedidos.Edit;
  cdsPedidos.FieldByName('MARCADO').AsBoolean := Not cdsPedidos.FieldByName('MARCADO').AsBoolean;
  cdsPedidos.Post;
end;

procedure TfrmTxtSfaMobImp.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If cdsPedidos.FieldByName('MARCADO').AsBoolean Then
  Begin

    dbgPedidos.Canvas.Font.Color := clGreen;
//    dbgPedidos.Canvas.Brush.Color := clBlue;
    dbgPedidos.Canvas.FillRect(Rect);
    dbgPedidos.DefaultDrawColumnCell(Rect,DataCol,Column,State);

  End;
end;

function TfrmTxtSfaMobImp.fCarregarVisitasNaoRealizadas: Boolean;
  Var
    txtGen: TextFile;
    strNomArq: String;
    strLinha: String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strNaoVisita;

    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      cdsVisitas.Insert;
      cdsVisitas.FieldByName('CODIGOCLIENTE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVisitas.FieldByName('DATAPEDIDO').AsDateTime := fImportaData(Copy(strLinha, 1, Pos('|', strLinha) - 1));
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVisitas.FieldByName('HORARIO').AsDateTime := fImportaHora(LeftStr(Copy(strLinha, 1, Pos('|', strLinha) - 1), 8));
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVisitas.FieldByName('CODIGOMOTIVO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVisitas.FieldByName('OBSERVACAO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVisitas.Post;
      
      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Visitas Não Realizadas', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);
end;

function TfrmTxtSfaMobImp.fCarregarVendasNaoRealizadas: Boolean;
  Var
    txtGen: TextFile;
    strNomArq: String;
    strLinha: String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strNaoVenda;

    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      cdsVendasNao.Insert;
      cdsVendasNao.FieldByName('CODIGOCLIENTE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVendasNao.FieldByName('DATAPEDIDO').AsDateTime := fImportaData(Copy(strLinha, 1, Pos('|', strLinha) - 1));
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVendasNao.FieldByName('HORARIO').AsDateTime := fImportaHora(LeftStr(Copy(strLinha, 1, Pos('|', strLinha) - 1), 8));
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVendasNao.FieldByName('OBSERVACAO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsVendasNao.Post;
      
      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Vendas Não Realizadas', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);
end;

function TfrmTxtSfaMobImp.fCarregarContatos: Boolean;
  Var
    txtGen: TextFile;
    strNomArq: String;
    strLinha: String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strContatos;

    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      cdsContatos.Insert;
      cdsContatos.FieldByName('CODIGO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('NOMECONTATO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('HOBBY').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('TIME').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('TELEFONE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('ANIVERSARIO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('CARGO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('EMAIL').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.FieldByName('CODIGORCA').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsContatos.Post;

      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Contatos', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);
end;

function TfrmTxtSfaMobImp.fCarregarPlanejamentos: Boolean;
  Var
    txtGen: TextFile;
    strNomArq: String;
    strLinha: String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Result := True;

  Try
    strNomArq := dirPathExp.edtDirectory.text + '\' + sfaFiles.strPlanoVisita;

    If Not FileExists(strNomArq) Then
    Begin
      If Not blnGeracaoAut Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo ' + strNomArq, ['OK']);
        Result := False;
      End;
      
      Exit;
    End;

    intLinha := 0;
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(txtGen, strNomArq);
    Reset(txtGen);

    While Not Eof(txtGen) Do
    Begin
      Readln(txtGen, strLinha);

      cdsPlanejamento.Insert;
      cdsPlanejamento.FieldByName('PERIOCIDADE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsPlanejamento.FieldByName('DATABASE').AsDateTime := fImportaData(Copy(strLinha, 1, Pos('|', strLinha) - 1));
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsPlanejamento.FieldByName('SEQVISITA').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsPlanejamento.FieldByName('HORARIO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsPlanejamento.FieldByName('CODIGOCLIENTE').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));

      cdsPlanejamento.FieldByName('OBSERVACAO').AsString := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
      
      cdsPlanejamento.Post;
      
      intLinha := intLinha + 1;
      pRegistrarProgresso('Carregando Contatos', 0, intLinha, intLinhas);
    End;

  Except
    Result := False;
    fMensagem('Atenção', 'Não foi possivel carregar o arquivo ' + strNomArq, ['OK']);
  End;

  CloseFile(txtGen);
end;


procedure TfrmTxtSfaMobImp.btnImprimirClick(Sender: TObject);
  Var
    frxRel: TfrxReport;
    frxDataSet: TfrxDBDataSet;
begin
  inherited;

  frxDBVisitas.DataSet := cdsVisitas;
  frxDBVendas.DataSet := cdsVendasNao;
  frxDBPlanejamento.DataSet := cdsPlanejamento;

  frxRel := Nil;
  frxDataSet := Nil;
  case rgRelatorios.ItemIndex of
    0: Begin
      frxDataSet := frxDBVisitas;
      frxRel := frxRelVisitasNaoRealizadas;
      frxRel.Script.Variables['NOMREL'] := 'RELATÓRIO DE VISITAS NÃO REALIZADAS';
    End;
    1: Begin
      frxDataSet := frxDBVendas;
      frxRel := frxRelVendasNaoRealizadas;
      frxRel.Script.Variables['NOMREL'] := 'RELATÓRIO DE VENDAS NÃO REALIZADAS';
    End;
    2: Begin
      frxDataSet := frxDBPlanejamento;
      frxRel := frxRelPlanejamento;
      frxRel.Script.Variables['NOMREL'] := 'PLANEJAMENTO DE VISITAS';
    End;
  end;

  frxRel.Script.Variables['PERIODO'] := '';
  frxRel.Script.Variables['PARAM1'] := '';
  frxRel.Script.Variables['PARAM2'] := '';
  frxRel.Script.Variables['NOMEMP'] := fCadEmp('NOMEMP');
  frxRel.Script.Variables['FNOMREL'] := Self.Name;

  If frxDataSet.DataSet.RecordCount > 0 Then
    pPreviewReport(Self.Name, Self.Caption, frxRel)
  Else
    fMensagem('ATENÇÃO', 'Nenhuma informação para este relatório foi gerada', ['OK']);

end;

procedure TfrmTxtSfaMobImp.btnGravarClick(Sender: TObject);
  Var
    blnGravado: Boolean;
begin
  inherited;
  blnGravado := fGerarPedidosCabecalho;
  blnGravado := blnGravado And fGerarContatos;

  If (blnGravado) And (Not blnGeracaoAut) Then
  Begin
    btnGravar.Enabled := False;
    fMensagem('', 'Pedidos gravados com sucesso!', ['OK']);
    pgDados.ActivePage := tbImprimir;
  End;



end;

function TfrmTxtSfaMobImp.fCarregaItem(strCodIte: String): Boolean;
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

function TfrmTxtSfaMobImp.fRetSaldoItem(strCodIte: String): Double;
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

  Result := qryGen.FieldByName('ITE_SALDOS').AsFloat - TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(VS_strCodEmp)
                                                           .CodigoItem(strCodIte)
                                                           .CodEmpresa(VS_strCodEmp)
                                                         ).fGetQuantidade();
  FreeAndNil(qryGen);
end;

function TfrmTxtSfaMobImp.fGerarContatos: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := True;

  Try
    qryGen := fCriaQuery(Self);
    qryGen.SQL.Text := 'SELECT * FROM CLICTT';
    qryGen.Open;

    cdsContatos.First;
    While Not cdsContatos.Eof Do
    Begin
      If (fValidaCliente(cdsContatos.FieldbyName('CODIGO').AsString))
        And (Not qryGen.Locate('CLI_CODCLI;CLI_NOMCTT;CLI_DEPCTT', VarArrayOf([cdsContatos.FieldbyName('CODIGO').AsString,
        cdsContatos.FieldbyName('NOMECONTATO').AsString, cdsContatos.FieldbyName('CARGO').AsString]), [])) Then
      Begin
        qryGen.Insert;
        qryGen.FieldByName('CLI_CODCLI').AsString := cdsContatos.FieldByName('CODIGO').AsString;
        qryGen.FieldByName('CLI_NOMCTT').AsString := cdsContatos.FieldByName('NOMECONTATO').AsString;
        qryGen.FieldByName('CLI_TELCTT').AsString := cdsContatos.FieldByName('TELEFONE').AsString;
        qryGen.FieldByName('CLI_EMACTT').AsString := cdsContatos.FieldByName('EMAIL').AsString;
        qryGen.FieldByName('CLI_CODEMP').AsString := VS_strCodEmp;
        qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLICTT', VS_strCodEmp);
        qryGen.FieldByName('CLI_DEPCTT').AsString := cdsContatos.FieldByName('CARGO').AsString;
        qryGen.Post;
      End;

      pRegistrarProgresso('Cadastrando contatos...', 0, qryGen.RecNo, qryGen.RecordCount);
      cdsContatos.Next;
    End;

  Except
    Result := False;
  End;

  FreeAndNil(qryGen);
end;

function TfrmTxtSfaMobImp.fValidaCliente(strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.Sql.Text := 'SELECT COUNT(*) QTD FROM CADCLI WHERE CLI_CODCLI = :CODCLI';
  qryGen.ParamByName('CODCLI').AsString := strCodCli;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmTxtSfaMobImp.dbgPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    cdsPedidos.Edit;
    cdsPedidos.FieldByName('MARCADO').AsBoolean := Not cdsPedidos.FieldByName('MARCADO').AsBoolean;
    cdsPedidos.Post;
  End;

end;

procedure TfrmTxtSfaMobImp.FormActivate(Sender: TObject);
begin
  inherited;

  If blnGeracaoAut And (Not blnGerou) Then
  Begin
    btnImporta.Click;
    btnGravar.Click;
    blnGerou := True;
    tmrFecha.Enabled := True;
  End;

end;

procedure TfrmTxtSfaMobImp.pCalculaPesBruLiq;
  Var
    qryIte: TUniQuery;

    function fRetPeso(strCodIte: String): Double;
    Begin
      qryIte.Close;
      qryIte.SQL.Clear;
      qryIte.SQL.Add('SELECT ITE_PESOIT FROM CADITE WHERE ITE_CODITE = :CODITE');
      qryIte.ParamByName('CODITE').AsString := strCodIte;
      qryIte.Open;
      Result := qryIte.FieldByName('ITE_PESOIT').AsFloat;
    End;

begin

  Try
    qryIte := fCriaQuery(Self); 
    fltPesLiq := 0.0;
    fltPesBru := 0.0;

    With cdsPedidosItens Do
    Begin
      First;

      While Not Eof Do
      Begin
        fltPesBru := fltPesBru + fFormataFloat(FieldByName('QUANTIDADE').AsFloat * fRetPeso(FieldByName('CODIGOPRODUTO').AsString), 3);

        Next;
      End;

      fltPesLiq := fFormataFloat(fltPesBru * fStrToFloat(fCfgSis('FATPLI', varDouble)), 3);

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryIte);
end;

procedure TfrmTxtSfaMobImp.tmrFechaTimer(Sender: TObject);
begin
  inherited;

  If blnGerou Then
    Self.Close;

end;

function TfrmTxtSfaMobImp.fArquivosParaImportacao: TArrRecSfaMobImpFiles;
  Var
    strTransmissao : String;
    srcPedCab      : TSearchRec;
    sfaFilesTmp    : TRecSfaMobImpFiles;

  procedure pAdicionarArquivos;
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := sfaFilesTmp;
  end;

  function fDataTransmissao: TDateTime;
    Var
      strData: String;
  begin
    strData := Copy(strTransmissao, 7, 2) + '/' +
               Copy(strTransmissao, 5, 2) + '/' +
               Copy(strTransmissao, 1, 4);

    Result := StrToDateDef(strData, 0);
  end;

  function fHoraTransmissao: TDateTime;
    Var
      strHora: String;
  begin
    strHora := Copy(strTransmissao, 09, 2) + ':' +
               Copy(strTransmissao, 11, 2) + ':' +
               Copy(strTransmissao, 13, 2);

    Result := StrToTimeDef(strHora, 0);
  end;

begin
  SetLength(Result, 0);

  If fCfgSis('LAYSFM') = LAYOUT_ACUMULATIVO Then
  Begin
    sfaFilesTmp.strContatos     := 'CONTATOS.TXT';
    sfaFilesTmp.strComunica     := 'CTRLCOMUNICA.TXT';
    sfaFilesTmp.strEstoque      := 'ESTOQUE.TXT';
    sfaFilesTmp.strNaoVenda     := 'NAOVENDA.TXT';
    sfaFilesTmp.strNaoVisita    := 'NAOVISITA.TXT';
    sfaFilesTmp.strPedidoCab    := 'PEDIDOCAB.TXT';
    sfaFilesTmp.strPedidoItens  := 'PEDIDOITENS.TXT';
    sfaFilesTmp.strPlanoVisita  := 'AGENDAVISITAS.TXT';
    sfaFilesTmp.strVersaoPocket := 'VERSAOPOCKET.TXT';

    sfaFilesTmp.dtaDataTransmissao := 0;
    sfaFilesTmp.tmrHoraTransmissao := 0;

    pAdicionarArquivos;
  End
  Else If fCfgSis('LAYSFM') = LAYOUT_BLOCO_TRANSMISSAO Then
  Begin

    If (FindFirst(dirPathExp.edtDirectory.text + '\PEDCAB*.*', faAnyFile, srcPedCab) = 0) Then
    Begin
      Repeat
        {***************************************}
        {* exemplo: "PEDCAB20110201061122.062" *}
        {*          "PEDCAByyyyMMddhhmmss.XXX" *}
        {************************************JC*}
        strTransmissao := AnsiReplaceStr(ExtractFileName(srcPedCab.Name), 'PEDCAB', '');

        sfaFilesTmp.strContatos     := 'CONTATOS'     + strTransmissao;
        sfaFilesTmp.strComunica     := 'CTRLCOMUNICA' + strTransmissao;
        sfaFilesTmp.strEstoque      := 'ESTOQUE'      + strTransmissao;
        sfaFilesTmp.strNaoVenda     := 'NAOVENDA'     + strTransmissao;
        sfaFilesTmp.strNaoVisita    := 'NAOVISITA'    + strTransmissao;
        sfaFilesTmp.strPedidoCab    := 'PEDCAB'       + strTransmissao;
        sfaFilesTmp.strPedidoItens  := 'PEDITEM'      + strTransmissao;
        sfaFilesTmp.strPlanoVisita  := 'PLANOVISITA'  + strTransmissao;
        sfaFilesTmp.strVersaoPocket := 'VERSAOPOCKET' + strTransmissao;

        sfaFilesTmp.dtaDataTransmissao := fDataTransmissao;
        sfaFilesTmp.tmrHoraTransmissao := fHoraTransmissao;

        pAdicionarArquivos;

      Until (FindNext(srcPedCab) <> 0);

      FindClose(srcPedCab);
    End;

  End;

end;

{ TArquivosExportar }

constructor TArquivosExportar.Create(chkLstItensExportar: TCheckListBox);
begin
  FchkLstItensExportar := chkLstItensExportar;
  FchkLstItensExportar.Clear;
  SetLength(FItens, 0);
end;

function TArquivosExportar.fAdicionarItem(strTexto: String;
  funcao: TBooleanFunction; blnMarcado: Boolean): Boolean;
begin
  Result := True;
  Try
    SetLength(FItens, Length(FItens) + 1);
    FItens[Length(FItens) - 1] := funcao;
    FchkLstItensExportar.Items.Add(strTexto);
    FchkLstItensExportar.Checked[Length(FItens) - 1] := blnMarcado;
  Except
    Result := False;
  End;
end;

function TArquivosExportar.fGerarArquivos: Boolean;
  Var
    intCont: Integer;
begin
  Result := True;

  FchkLstItensExportar.Enabled := False;

  For intCont := Low(FItens) To High(FItens) Do
  Begin
    FchkLstItensExportar.ItemIndex := intCont;
    If Result And FchkLstItensExportar.Checked[intCont] And Assigned(FItens[intCont]) Then
      Result := FItens[intCont]();
  End;

  FchkLstItensExportar.Enabled := True;
end;

function TArquivosExportar.GetCount: Integer;
begin
  Result := Length(FItens);
end;

function TArquivosExportar.GetItens(
  index: Integer): TBooleanFunction;
begin
  Result := FItens[index];
end;

procedure TArquivosExportar.SetchkLstItensExportar(
  const Value: TCheckListBox);
begin
  FchkLstItensExportar := Value;
end;

procedure TArquivosExportar.SetItens(index: Integer;
  const Value: TBooleanFunction);
begin
  FItens[index] := Value;
end;


end.
