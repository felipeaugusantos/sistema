{*******************************************}
{* CLASSE PARA CAMPANHA DE VENDAS          *}
{* DATA: 24/10/2007                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untCamGer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  UniClientDataSet, UniDataSetProvider, untFuncoesSimples, Forms,
  untCfgRel,
{$ENDIF}
  Uni, Db, Classes, untICamGer,
  System.DateUtils,
  Faturamento.Connections.Functions,
  Shared.Functions.DataSet,
  System.Generics.Collections,
  untTypesSistema;

Type TCampanhaDet = Record
       strCodCmg: String;
       strCodIte: String;
     End;

Type TCamGen = Class(TComponent)
  Private

    FSeqCmg: String;
    FAutInc: String;
    FOpcao_: String;
    FCodMar: String;
    FDesMar: String;
    FCodGru: String;
    FDesGru: String;
    FCodFor: String;
    FDesFor: String;
    FVlrFat: Double;
    FCodEmp: String;
    FDesEmp: String;
    {*******************************************}
    {* FUNCTIONS                               *}
    {****************************************RL*}
    function getDesEmp: String;
    function getDesFor: String;
    function getDesGru: String;
    function getDesMar: String;
    function getVlrFat: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    procedure setVlrFat(const Value: String);

  Public

    qryCamGen: TUniQuery;

   {$IFNDEF LINUX}
    dtsCamGen: TDataSource;
   {$ENDIF}

    function fGravaCamGen(strAutInc: String;
                          strSeqCmg,
                          strOpcao_: String;
                          strCodGru,
                          strCodFor,
                          strCodMar: String;
                          fltVlrFat: Double;
                          strCodEmp: String): Boolean;

    function fDeletaCamGen(strSeqCmg,
                          strOpcao_,
                          strCodOpc: String
                          {strCodEmp: String}): Boolean;

    function fUsaCampanhaGenerica: Boolean;
    function fVerificaProdutoCampGenerica(strCodCli, strCodGru,
     strCodMar, strCodFor: String): Boolean;

    procedure pLimpaDadosGen;
    procedure pAtuDadosGen;
    procedure pCarregaCamGen(strSeqCmg: String);

    property strSeqCmg: String Read FSeqCmg   Write FSeqCmg;
    property strAutInc: String Read FAutInc   Write FAutInc;
    property strOpcao_: String Read FOpcao_   Write FOpcao_;
    property strCodMar: String Read FCodMar   Write FCodMar;
    property strDesMar: String Read getDesMar Write FDesMar;
    property strCodGru: String Read FCodGru   Write FCodGru;
    property strDesGru: String Read getDesGru Write FDesGru;
    property strCodFor: String Read FCodFor   Write FCodFor;
    property strDesFor: String Read getDesFor Write FCodFor;
    property strVlrFat: String Read getVlrFat Write setVlrFat;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

Type TCamDet = Class(TComponent)

  Private

    FSeqCmg: String;
    FAutInc: String;
    FCodIte: String;
    FDesIte: String;
    FQtdIte: Double;
    FVlrUni: Double;
    FVlrIte: Double;
    FPreClq: Double;
    FPreCus: Double;
    FGirP03: Double;
    FGirP06: Double;
    FGirP12: Double;
    FIdePro: String;
    FIteTin: String;
    FTinDes: String;
    FCodPcl: String;
    FCodEmp: String;
    FDesEmp: String;

    {*******************************************}
    {* FUNCTIONS                               *}
    {****************************************RL*}
    function getDesEmp: String;
    function getDesIte: String;
    function getQtdIte: String;
    function getVlrIte: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    procedure setQtdIte(const Value: String);
    procedure setVlrIte(const Value: String);
    function getVlrUni: String;
    procedure setVlrUni(const Value: String);

  Public

    qryCamDet: TUniQuery;

   {$IFNDEF LINUX}
    dtsCamDet: TDataSource;
   {$ENDIF}

    arrCampanhaDet: Array Of TCampanhaDet;
    stlItensNaoTemCampanha: TStringList;
    function fRetornaSomenteItensEmCampanhaDaLista(strLisCodIteOrc: String): TStringList;

    function fGravaCamDet(strAutInc: String;
                          strSeqCmg,
                          strCodIte: String;
                          fltQtdIte,
                          fltVlrUni,
                          fltVlrIte,
                          fltPreCus,
                          fltGirP03,
                          fltGirP06,
                          fltGirP12: Double;
                          strCodEmp,
                          strIdePro,
                          strIteTin,
                          strTinDes : String;
                          fltTinVol: Double;
                          strCodPcl : String;
                          fltPreClq: Double): Boolean;

    function fDeletaCamDet(ACodigoCampanha : String; AProdutosExcluidos : TUniClientDataSet): Boolean;

    function fRetornaSimilaridade(strCodIte: String): String;
    function fVerificaProdutoCampanha(strCodCmg, strCodIte: String): String; Overload;
    function fVerificaProdutoCampanha(strCodCli, strCodIte, strIdePro, strIteTin: String; fltTinVol: Double;
                                      var fltVlrUni : Double; var strCodCam: String;
                                      var fltPreClq: Double): Boolean; Overload;

    procedure pLimpaDadosDet;
    procedure pAtuDadosDet;
    procedure pCarregaCamDet(strSeqCmg: String; intFiltro: Integer = 1;blnFiltraDataAtual: Boolean = False);
    //procedure pCarregaArrayCampanhaDet(strSeqCmg, strCodIte: String);
    procedure pCarregaArrayCampanhaDet;

    property strSeqCmg: String Read FSeqCmg   Write FSeqCmg;
    property strAutInc: String Read FAutInc   Write FAutInc;
    property strCodIte: String Read FCodIte   Write FCodIte;
    property strDesIte: String Read getDesIte Write FDesIte;
    property strQtdIte: String Read getQtdIte Write setQtdIte;
    property strVlrUni: String Read getVlrUni Write setVlrUni;
    property strVlrIte: String Read getVlrIte Write setVlrIte;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

Type TCamGer = Class(TComponent, ICamGer)
  Private

//    strSQL : String;
    FCodCmg: String;
    FDesCmg: String;
    FCodRed: String;
    FDesRed: String;
    FCodCli: String;
    FDesCli: String;
    FObs_01: String;
    FObs_02: String;
    FObs_03: String;
    FBrinde: String;
    FDtaEnt: TDateTime;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FCodEmp: String;
    FDesEmp: String;
    FAutInc: String;
    FAtiva_: String;
    FCdsCamGer: TUniClientDataSet;
    FdicFiltro: TDicionario;

    {*******************************************}
    {* FUNCOES                                 *}
    {****************************************RL*}
    function getDesCli: String;
    function getDesEmp: String;
    function getDesRed: String;
    function getDtaEnt: String;
    function getDtaFin: String;
    function getDtaIni: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    procedure setDtaEnt(const Value: String);
    procedure setDtaFin(const Value: String);
    procedure setDtaIni(const Value: String);

  Public

    blnEmCampanha: Boolean;

    qryCamGer: TUniQuery;
    dspCamGer: TUniDataSetProvider;

  {$IFNDEF LINUX}
    dtsCamGer: TDataSource;
  {$ENDIF}

    objCamDet: TCamDet;
    objCamGen: TCamGen;

    function fGravaCamGer(Var strAutInc: String;
                          strCodCmg,
                          strDesCmg,
                          strCodRed,
                          strCodCli,
                          strObs_01,
                          strObs_02,
                          strObs_03,
                          strCodEmp,
                          strBrinde: String;
                          dtaDtaEnt,
                          dtaDtaIni,
                          dtaDtaFin: TDateTime;
                          strAtiva : String): Boolean;

    function fGravaCamCli(strAutInc, strCodCli: String):Boolean;
    function fLimpaCamCli(strAutInc: String):Boolean;
    function fCarregaCamCli(strAutInc: String):TList<String>;

    function fRetornaNomeCampanha(strCodCmg: String): String;
    function fRetornaClientesRede(strCodRed: String): String;
    function fRetornaRedeCliente(strCodCli: String): String;
    function fVerificaCustoItemCampanha(strCodEmp, strCodCli, strCodIte,
      strIdePro, strIteTin: String; var fltPreCus: Double): Boolean;
    function fVerificaClienteCampanha(strCodCli: String): Boolean;
    function fConfirmaCondPagCampanha(strCodCmg, strCodCnd, strCodFpg: String): Boolean;
    function fExisteCampanha(dtaDtaAtu: TDatetime): Boolean;
    function fBuscaPrecoVenda(strCodIte: String): Double;
    function fTemItensParaImportar(strNumDoc, strEspDoc, strCodEmp: String;
                  var strTabela, strPrefixo: String) : Boolean;

    function fGravaCamCnd(strAutoinCnd, strCodCmg, strCodCnd, strCodFpg: String): Boolean;
    function fDeletaCamCnd(strAutoinCnd: String): Boolean;

    procedure pLimpaDadosGer;
    procedure pAtuDadosGer;
    procedure pCarregaCamGer(strCodCmg: String);

    function getCdsCamGer: TUniClientDataSet;
    procedure setCdsCamGer(DataSet: TUniClientDataSet);

    function getDesCmg: String;
    procedure setDesCmg(Value: String);
    procedure pCarregaProdutos(qryProdutos : TUniQuery);
    function fGetSQLGiro(strTipo, strCampo : string; dtaInicio: TDate; blnMedia : Boolean; intMeses: Integer = 0) : string;
    function fVerificaCodigoProdutoCliente(strCodCli, strCodProdIte, strCodCmg : String): String;
    procedure pAcrescentaExcecaoCampanha(const strCodIte: String);  overload;
    procedure pAcrescentaExcecaoCampanha(const arrItens: TArrString); overload;
    property strCodCmg: String Read FCodCmg   Write FCodCmg;
    property strDesCmg: String Read getDesCmg   Write setDesCmg;
    property strCodRed: String Read FCodRed   Write FCodRed;
    property strDesRed: String Read getDesRed Write FDesRed;
    property strCodCli: String Read FCodCli   Write FCodCli;
    property strDesCli: String Read getDesCli Write FDesCli;
    property strObs_01: String Read FObs_01   Write FObs_01;
    property strObs_02: String Read FObs_02   Write FObs_02;
    property strObs_03: String Read FObs_03   Write FObs_03;
    property strBrinde: String Read FBrinde   Write FBrinde;
    property strDtaEnt: String Read getDtaEnt Write setDtaEnt;
    property strDtaIni: String Read getDtaIni Write setDtaIni;
    property strDtaFin: String Read getDtaFin Write setDtaFin;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;
    property strAutInc: String Read FAutInc   Write FAutInc;
    property strAtiva_: String Read FAtiva_   Write FAtiva_;
    property cdsCamGer: TUniClientDataSet Read getCdsCamGer Write setCdsCamGer;
    property dicFiltro: TDicionario Read FdicFiltro Write FdicFiltro;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

implementation

uses StrUtils, SysUtils, Variants, untConstantes;

{ TCamDet }

{*******************************************}
{* CREATE                                  *}
{****************************************RL*}
constructor TCamDet.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  Try
    stlItensNaoTemCampanha := TStringList.Create;
    qryCamDet := fCriaQuery;

  {$IFNDEF LINUX}
    dtsCamDet := fCriaDataSource(qryCamDet);
  {$ENDIF}

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*******************************************}
{* DESTROY                                 *}
{****************************************RL*}
destructor TCamDet.Destroy;
begin

  FreeAndNil(stlItensNaoTemCampanha);

  FreeAndNil(qryCamDet);

  arrCampanhaDet := Nil;

  inherited;

end;

{*******************************************}
{* PEGA DESCRIÇÃO DA EMPRESA               *}
{****************************************RL*}
function TCamDet.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

{*******************************************}
{* PEGA DESCRIÇÃO DO PRODUTO               *}
{****************************************RL*}
function TCamDet.getDesIte: String;
begin
  Result := fRetNomProduto(FCodIte);
end;

{*******************************************}
{* FORMATA QTD DO PRODUTO                  *}
{****************************************RL*}
function TCamDet.getQtdIte: String;
begin
  Result := FloatToStrF(FQtdIte, ffFixed, 14, 3);
end;

{*******************************************}
{* FORMATA VALOR DO PRODUTO                *}
{****************************************RL*}
function TCamDet.getVlrIte: String;
begin
  Result := FloatToStrF(FVlrIte, ffFixed, 12, 4);
end;

{*******************************************}
{* ATUALIZA DADOS DAS VARIÁVEIS            *}
{****************************************RL*}
procedure TCamDet.pAtuDadosDet;
begin

  Try

    If (Not qryCamDet.Active) Or (qryCamDet.IsEmpty) Then
    Begin
      pLimpaDadosDet;
    End;

    With qryCamDet Do
    Begin

      FSeqCmg := FieldByName('CMD_SEQCMG').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FCodIte := FieldByName('CMD_CODITE').AsString;
      FVlrUni := FieldByName('CMD_VLRUNI').AsFloat;
      FQtdIte := FieldByName('CMD_QTDITE').AsFloat;
      FVlrIte := FieldByName('CMD_VLRITE').AsFloat;
      FPreClq := FieldByName('CMD_PRECLQ').AsFloat;
      FPreCus := FieldByName('CMD_PRECUS').AsFloat;
      FGirP03 := FieldByName('CMD_GIRP03').AsFloat;
      FGirP06 := FieldByName('CMD_GIRP06').AsFloat;
      FGirP12 := FieldByName('CMD_GIRP12').AsFloat;
      FIdePro := FieldByName('CMD_IDEPRO').AsString;
      FIteTin := FieldByName('CMD_ITETIN').AsString;
      FTinDes := FieldByName('CMD_TINDES').AsString;
      FCodPcl := FieldByName('CMD_CODPCL').AsString;

      FCodEmp := FieldByName('CMD_CODEMP').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{*******************************************}
{* GRAVA DADOS NA CAMDET                   *}
{****************************************RL*}
function TCamDet.fGravaCamDet(strAutInc: String; strSeqCmg,
  strCodIte: String; fltQtdIte, fltVlrUni, fltVlrIte, fltPreCus,
  fltGirP03, fltGirP06, fltGirP12: Double; strCodEmp, strIdePro,
  strIteTin, strTinDes : String; fltTinVol: Double; strCodPcl : String;
  fltPreClq: Double): Boolean;
begin

  Result := True;

  Try

    With qryCamDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CAMDET WHERE AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutInc;
      Open;

      If IsEmpty Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('CAMDET', strCodEmp);
        FieldByName('CMD_SEQCMG').AsString :=  strSeqCmg;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('CMD_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      FieldByName('CMD_CODITE').AsString := strCodIte;
      FieldByName('CMD_QTDITE').AsFloat  := fltQtdIte;
      FieldByName('CMD_VLRUNI').AsFloat  := fltvlrUni;
      FieldByName('CMD_VLRITE').AsFloat  := fltVlrIte;
      FieldByName('CMD_PRECLQ').AsFloat  := fltPreClq;
      FieldByName('CMD_PRECUS').AsFloat  := fltPreCus;
      FieldByName('CMD_GIRP03').AsFloat  := fltGirP03;
      FieldByName('CMD_GIRP06').AsFloat  := fltGirP06;
      FieldByName('CMD_GIRP12').AsFloat  := fltGirP12;
      FieldByName('CMD_IDEPRO').AsString := IIF(fEmptyStr(strIdePro),'NOR',strIdePro);
      FieldByName('CMD_ITETIN').AsString := strIteTin;
      FieldByName('CMD_TINDES').AsString := strTinDes;
      FieldByName('CMD_CODPCL').AsString := strCodPcl;

      If Not fEmptyStr(strIteTin) And (fltTinVol > 0) Then
        FieldByName('CMD_TINVOL').AsFloat := fltTinVol;

      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryCamDet.Cancel;
      pMensagensErro(E.Message, '[fGravaCamDet]');
      Result := False;
    End;
  End;

end;

{*******************************************}
{* LIMPA DADOS DAS VARIÁVEIS               *}
{****************************************RL*}
procedure TCamDet.pLimpaDadosDet;
begin

  FSeqCmg := '';
  FAutInc := '';
  FCodIte := '';
  FDesIte := '' ;
  FQtdIte := 0;
  FVlrUni := 0;
  FVlrIte := 0;
  FPreClq := 0;
  FPreCus := 0;
  FGirP03 := 0;
  FGirP06 := 0;
  FGirP12 := 0;
  FIdePro := '';
  FIteTin := '';
  FTinDes := '';
  FCodPcl := '';
  FCodEmp := '';
  FDesEmp := '';

end;

procedure TCamDet.pCarregaCamDet(strSeqCmg: String; intFiltro: Integer = 1; blnFiltraDataAtual: Boolean = False);
  Var strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT              ';
  strSQL := strSQL + '  CAMDET.CMD_SEQCMG,       ';
  strSQL := strSQL + '  CAMDET.AUTOINCREM,       ';
  strSQL := strSQL + '  CAMDET.CMD_CODITE,       ';
  strSQL := strSQL + '  CAMDET.CMD_QTDITE,       ';
  strSQL := strSQL + '  CAMDET.CMD_VLRUNI,       ';
  strSQL := strSQL + '  CAMDET.CMD_VLRITE,       ';
  strSQL := strSQL + '  CAMDET.CMD_PRECLQ,       ';
  strSQL := strSQL + '  CAMDET.CMD_PRECUS,       ';
  strSQL := strSQL + '  CAMDET.CMD_GIRP03,       ';
  strSQL := strSQL + '  CAMDET.CMD_GIRP06,       ';
  strSQL := strSQL + '  CAMDET.CMD_GIRP12,       ';
  strSQL := strSQL + '  CAMDET.CMD_IDEPRO,       ';
  strSQL := strSQL + '  CAMDET.CMD_ITETIN,       ';
  strSQL := strSQL + '  CAMDET.CMD_TINDES,       ';
  strSQL := strSQL + '  CAMDET.CMD_CODEMP,       ';
  strSQL := strSQL + '  CAMDET.CMD_CODPCL        ';
  strSQL := strSQL + 'FROM                ';
  strSQL := strSQL + '  CAMDET            ';

  If blnFiltraDataAtual Then
  Begin
    strSQL := strSQL + '  INNER JOIN CAMGER ON CMG_CODCMG = CMD_SEQCMG  ';
    strSQL := strSQL + '             AND '+ fCurrentDate +' BETWEEN CMG_DTAINI AND CMG_DTAFIN ';
  End;

  If intFiltro = 1 Then
  Begin

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CMD_SEQCMG = :SEQCMG ';

  End;

  With qryCamDet Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If intFiltro = 1 Then
        ParamByName('SEQCMG').AsString := strSeqCmg;

      Open;

      If (Not Active) Or (IsEmpty) Then
        pLimpaDadosDet
      Else
      Begin

        If intFiltro = 1 Then
          pAtuDadosDet;

        {pCarregaArrayCampanhaDet(FieldByName('CMD_SEQCMG').AsString,
                                 FieldByName('CMD_CODITE').AsString);}

        pCarregaArrayCampanhaDet;
        First;

      End;

    End;

end;

//procedure TCamDet.pCarregaArrayCampanhaDet(strSeqCmg, strCodIte: String);
procedure TCamDet.pCarregaArrayCampanhaDet;
  Var
    i: Integer;
begin

  i := 0;
  SetLength(ArrCampanhaDet, qryCamDet.RecordCount);

  With qryCamDet Do
    While Not Eof Do
    Begin

      arrCampanhaDet[i].strCodCmg := FieldByName('CMD_SEQCMG').AsString;
      arrCampanhaDet[i].strCodIte := FieldByName('CMD_CODITE').AsString;
      Next;

      Inc(i);

    End;

end;

{*******************************************}
{* SETA A QTD DE PRODUTO                   *}
{****************************************RL*}
procedure TCamDet.setQtdIte(const Value: String);
begin
  FQtdIte := fStrToFloat(Value);
end;


{*******************************************}
{* SETA O VALOR DO PRODUTO                 *}
{****************************************RL*}
procedure TCamDet.setVlrIte(const Value: String);
begin
  FVlrIte := fStrToFloat(Value);
end;

{*******************************************}
{* FORMATA VALOR DO PRODUTO                *}
{****************************************RL*}
function TCamDet.getVlrUni: String;
begin
  Result := FloatToStrF(FVlrUni, ffFixed, 12, 4);
end;

{*******************************************}
{* SETA VALOR UNITÁRIO DO PRODUTO          *}
{****************************************RL*}
procedure TCamDet.setVlrUni(const Value: String);
begin
  FVlrUni := fStrToFloat(Value);
end;

{ TCamGer }

{*******************************************}
{* CREATE                                  *}
{****************************************RL*}
constructor TCamGer.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FdicFiltro := TDicionario.Create;

  Try

    {**********************************************}
    {* CLIENTDATASET E DATASETPROVIDER UTILIZADOS *}
    {* APENAS PARA GERA O RELATÓRIO               *}
    {*******************************************RL*}

    qryCamGer := fCriaQuery(Self);
    dspCamGer := TUniDataSetProvider.Create(Self);
    cdsCamGer := TUniClientDataSet.Create(Self);

  {$IFNDEF LINUX}
    dtsCamGer := fCriaDataSource(qryCamGer);
  {$ENDIF}

    dspCamGer.DataSet      := qryCamGer;
    dspCamGer.Name         := 'dspCamGer';
    cdsCamGer.ProviderName := 'dspCamGer';

    objCamDet := TCamDet.Create(Self);
    objCamGen := TCamGen.Create(Self);

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*******************************************}
{* DESTROY                                 *}
{****************************************RL*}
destructor TCamGer.Destroy;
begin

  cdsCamGer.Close;
  FreeAndNil(FdicFiltro);

  inherited;

end;

function TCamGer.fLimpaCamCli(strAutInc: String): Boolean;
Var
  qryCamCli : TUniQuery;
begin
  Result := True;
  qryCamCli := fCriaQuery;

  Try
    Try
      qryCamCli.SQL.Add('  DELETE FROM CAMCLI WHERE CCM_CODGER=:CODGER  ');
      qryCamCli.ParamByName('CODGER').AsString := strAutInc;
      qryCamCli.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLimpaCamCli]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCamCli);
  End;
end;

function TCamGer.fCarregaCamCli(strAutInc: String): TList<String>;
Var
  qryCamCli : TUniQuery;
begin
  Result := TList<String>.Create;

  qryCamCli := fCriaQuery;

  Try
    Try
      qryCamCli.SQL.Add('  SELECT CCM_CODCLI FROM CAMCLI WHERE CCM_CODGER=:CODGER  ');
      qryCamCli.ParamByName('CODGER').AsString := strAutInc;
      qryCamCli.Open;

      qryCamCli.First;
      While Not qryCamCli.Eof Do
      Begin
        Result.Add(qryCamCli.FieldByName('CCM_CODCLI').AsString);
        qryCamCli.Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fCarregaCamCli]');
    End;
  Finally
    FreeAndNil(qryCamCli);
  End;
end;

function TCamGer.fGravaCamCli(strAutInc, strCodCli: String): Boolean;
Var
  qryCamCli : TUniQuery;
begin
  Result := True;
  qryCamCli := fCriaQuery;

  Try
    Try
      qryCamCli.SQL.Clear;
      qryCamCli.SQL.Add('  INSERT INTO CAMCLI (CCM_CODCLI, CCM_CODGER) VALUES (:CODCLI, :CODGER)  ');

      qryCamCli.ParamByName('CODGER').AsString := strAutInc;
      qryCamCli.ParamByName('CODCLI').AsString := strCodCli;
      qryCamCli.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fGravaCamCli]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCamCli);
  End;
end;

function TCamGer.fGravaCamCnd(strAutoinCnd, strCodCmg, strCodCnd,
  strCodFpg: String): Boolean;
  Var
    qryCamCnd: TUniQuery;
begin
  Result := True;
  qryCamCnd := fCriaQuery;

  Try
    Try
      With qryCamCnd Do
      Begin
        SQL.Add('SELECT * FROM CAMCND WHERE AUTOINCREM = :AUTINC');
        ParamByName('AUTINC').AsString := strAutoinCnd;
        Open;

        If IsEmpty Then
        Begin
          Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAMCND', VS_strCodEmp);
        End
        Else
          Edit;

        FieldByName('CND_CODCMG').AsString := strCodCmg;
        FieldByName('CND_CODCND').AsString := strCodCnd;
        FieldByName('CND_CODFPG').AsString := strCodFpg;
        Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fGravaCamCnd]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCamCnd);
  End;
end;

{*******************************************}
{* GRAVA CAMGER                            *}
{****************************************RL*}
function TCamGer.fGravaCamGer(Var strAutInc: String;
  strCodCmg, strDesCmg, strCodRed, strCodCli, strObs_01, strObs_02,
  strObs_03, strCodEmp, strBrinde: String; dtaDtaEnt, dtaDtaIni,
  dtaDtaFin: TDateTime; strAtiva: String): Boolean;
begin

  Result := True;

  Try

    With qryCamGer Do
    Begin

      If Not Active Then
      Begin
        pCarregaCamGer(strCodCmg);
        Open;
      End;

      If fEmptyStr(strCodCmg) Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('CAMGER', strCodEmp);

        FieldByName('CMG_CODCMG').AsString := fAtualizaProCod('CAMGER', 'CMG_CODCMG');
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('CMG_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      strAutInc := FieldByName('AUTOINCREM').AsString;

      FieldByName('CMG_DESCMG').AsString   := strDesCmg;
      FieldByName('CMG_OBS_01').AsString   := strObs_01;
      FieldByName('CMG_OBS_02').AsString   := strObs_02;
      FieldByName('CMG_OBS_03').AsString   := strObs_03;
      FieldByName('CMG_BRINDE').AsString   := strBrinde;
      FieldByName('CMG_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('CMG_DTAINI').AsDateTime := dtaDtaIni;
      FieldByName('CMG_DTAFIN').AsDateTime := dtaDtaFin;
      FieldByName('CMG_ATIVA_').AsString   := strAtiva;

      Post;

    End;

    pAtuDadosGer;

  Except
    On E: Exception Do
    Begin
      qryCamGer.Cancel;
      pMensagensErro(E.Message, '[fGravaCamGer]');
      Result := False;
    End;
  End;

end;

{*******************************************}
{* RETORNA O NOME DA CAMPANHA              *}
{****************************************RL*}
function TCamGer.fRetornaNomeCampanha(strCodCmg: String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := '';

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT                  ';
  strSQL := strSQL + '  CMG_DESCMG            ';
  strSQL := strSQL + 'FROM                    ';
  strSQL := strSQL + '  CAMGER                ';
  strSQL := strSQL + 'WHERE                   ';
  strSQL := strSQL + '  CMG_CODCMG = :CODCMG  ';

  With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCMG').AsString := strCodCmg;

      Open;

      Result := FieldByName('CMG_DESCMG').AsString;

      Close;
    End;

  FreeAndNil(qryTmp);

end;

{*******************************************}
{* PEGA NOME DO CLIENTE                    *}
{****************************************RL*}
function TCamGer.getCdsCamGer: TUniClientDataSet;
begin
  Result := FcdsCamGer;
end;

function TCamGer.fBuscaPrecoVenda(strCodIte: String): Double;
  Var
    strSQL      : String;
    qryTmpIteGer: TUniQuery;
Begin

    Result := 0;

    qryTmpIteGer := fCriaQuery;

    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_PREVE1 PREVEN ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ITEGER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  ITE_CODITE = :CODITE ';

      With qryTmpIteGer Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODITE').AsString := strCodIte;

          Open;
          Result := FieldByName('PREVEN').AsFloat;
          Close;
        End;

      FreeAndNil(qryTmpIteGer);
    Except
      FreeAndNil(qryTmpIteGer);
    End;

End;

function TCamGer.getDesCli: String;
begin
  Result := fRetNomCliente(FCodCli);
end;

function TCamGer.getDesCmg: String;
begin
  Result := FDesCmg;
end;

{*******************************************}
{* PEGA NOME DA EMPRESA                    *}
{****************************************RL*}
function TCamGer.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

{*******************************************}
{* PEGA NOME DA REDE DE LOJAS              *}
{****************************************RL*}
function TCamGer.getDesRed: String;
begin
  Result := fRetNomeRedeLoja(FCodRed);
end;

{*******************************************}
{* FORMATA DTAENT                          *}
{****************************************RL*}
function TCamGer.getDtaEnt: String;
begin
  Result := IfThen(FDtaEnt = 0, '', FormatDateTime('dd/mm/yyyy',FDtaEnt));
end;

{*******************************************}
{* FORMATA DTAFIN                          *}
{****************************************RL*}
function TCamGer.getDtaFin: String;
begin
  Result := IfThen(FDtaFin = 0, '', FormatDateTime('dd/mm/yyyy',FDtaFin));
end;

{*******************************************}
{* FORMATA DTAINI                          *}
{****************************************RL*}
function TCamGer.getDtaIni: String;
begin
  Result := IfThen(FDtaIni = 0, '', FormatDateTime('dd/mm/yyyy',FDtaIni));
end;

procedure TCamGer.pAcrescentaExcecaoCampanha(const strCodIte: String);
begin
  If (Self.objCamDet.stlItensNaoTemCampanha.IndexOf(strCodIte) = -1) Then
    Self.objCamDet.stlItensNaoTemCampanha.Add(strCodIte);
end;

procedure TCamGer.pAcrescentaExcecaoCampanha(const arrItens: TArrString);
  Var
    intCnt : Integer;
begin
  For intCnt := Low(arrItens) To High(arrItens) Do
    pAcrescentaExcecaoCampanha(arrItens[intCnt]);
end;

procedure TCamGer.pAtuDadosGer;
begin

  Try

    If (Not qryCamGer.Active) Or (qryCamGer.IsEmpty) Then
    Begin
      pLimpaDadosGer;
      Exit;
    End;

    With qryCamGer Do
    Begin

      FCodCmg := FieldByName('CMG_CODCMG').AsString;
      FDesCmg := FieldByName('CMG_DESCMG').AsString;
      FObs_01 := FieldByName('CMG_OBS_01').AsString;
      FObs_02 := FieldByName('CMG_OBS_02').AsString;
      FObs_03 := FieldByName('CMG_OBS_03').AsString;
      FBrinde := FieldByName('CMG_BRINDE').AsString;
      FDtaEnt := FieldByName('CMG_DTAENT').AsDateTime;
      FDtaIni := FieldByName('CMG_DTAINI').AsDateTime;
      FDtaFin := FieldByName('CMG_DTAFIN').AsDateTime;
      FCodEmp := FieldByName('CMG_CODEMP').AsString;
      FAtiva_ := FieldByName('CMG_ATIVA_').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{*******************************************}
{* CARREGA DADOS DA TABELA CAMGER          *}
{****************************************RL*}
procedure TCamGer.pCarregaCamGer(strCodCmg: String);
  Var strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT                  ';
  strSQL := strSQL + '  CMG_CODCMG,           ';
  strSQL := strSQL + '  CMG_DESCMG,           ';
  strSQL := strSQL + '  CMG_OBS_01,           ';
  strSQL := strSQL + '  CMG_OBS_02,           ';
  strSQL := strSQL + '  CMG_OBS_03,           ';
  strSQL := strSQL + '  CMG_BRINDE,           ';
  strSQL := strSQL + '  CMG_DTAENT,           ';
  strSQL := strSQL + '  CMG_DTAINI,           ';
  strSQL := strSQL + '  CMG_DTAFIN,           ';
  strSQL := strSQL + '  CMG_CODEMP,           ';
  strSQL := strSQL + '  CMG_ATIVA_,           ';
  strSQL := strSQL + '  AUTOINCREM            ';
  strSQL := strSQL + 'FROM                    ';
  strSQL := strSQL + '  CAMGER                ';
  strSQL := strSQL + 'WHERE                   ';
  strSQL := strSQL + '  CMG_CODCMG = :CODCMG  ';

  With qryCamGer Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODCMG').AsString := strCodCmg;

    Open;

    If (Not Active) Or (IsEmpty) Then
    Begin
      pLimpaDadosGer;
      Close;
    End
    Else
    Begin
      pAtuDadosGer;

      FDesCli := fRetNomCliente(FCodCli);
      FDesRed := fRetNomeRedeLoja(FCodRed);
    End;
  End;
end;

{******************************************************}
{* RETORNA OS CLIENTES PARTICIPANTES DA REDE          *}
{***************************************************RL*}
function TCamGer.fRetornaClientesRede(strCodRed: String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  Result := '';

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT         ';
  strSQL := strSQL + '  C.CLI_CODCLI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI C ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  C.CLI_CODRED = :CODRED ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODRED').AsString := strCodRed;

      Open;

      If Not IsEmpty Then
      Begin
        While Not Eof Do
        Begin

          Result :=  Result + QuotedStr(FieldByName('CLI_CODCLI').AsString) + ',';
          Next;

        End;

      End;

      Close;

      Result := Copy(Result, 1, Length(Result) - 1);

      If fEmptyStr(Result) Then
        Result := QuotedStr('');

    End;

  FreeAndNil(qryTmp);

End;

{******************************************************}
{* RETORNA O CÓDIGO DA REDE QUE O CLIENTE PARTICIPA   *}
{***************************************************RL*}
function TCamGer.fRetornaRedeCliente(strCodCli: String): String;
begin
  Result := fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
end;

function TCamGer.fTemItensParaImportar(strNumDoc, strEspDoc,
  strCodEmp: String; var strTabela, strPrefixo: String): Boolean;
var
  qryTmp: TUniQuery;
  strTabGer,
  strTabDet,
  strPreGer,
  strPreDet: String;

  function fSQLGer: String;
  begin
    Result := '';
    Result := Result + 'SELECT AUTOINCREM FROM ' + strTabGer + ' WHERE ';
    Result := Result + strPreGer + 'NUMDOC = :NUMDOC AND ';
    Result := Result + strPreGer + 'ESPDOC = :ESPDOC AND ';
    Result := Result + strPreGer + 'CODEMP = :CODEMP ';
  end;

  function fSQLDet(): String;
  Begin
    Result := '';
    Result := Result + 'SELECT AUTOINCREM FROM ' + strTabDet + ' WHERE ';
    Result := Result + strPreDet + 'NUMDOC = :NUMDOC AND ';
    Result := Result + strPreDet + 'ESPDOC = :ESPDOC AND ';
    Result := Result + strPreDet + 'CODEMP = :CODEMP ';
    Result := Result + 'AND ' + strPreDet + 'IDEPRO = ''NOR'' ';
    Result := Result + 'AND ' + strPreDet + 'PROACA = ''N'' ';
    Result := Result + 'AND ' + strPreDet + 'PROEMB <> ''S'' ';
  End;

  function fDocumentoExiste : Boolean;
  begin
    Result := False;

    qryTmp := fCriaQuery();

    Try
      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(fSQLGer);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If IsEmpty Then
        Begin
          If Pos(strEspDoc, 'PD_OR_') <= 0 Then
          Begin
            Close;
            strTabGer := 'NOTGER';
            strTabDet := 'NOTDET';
            SQL.Clear;
            SQL.Add(fSQLGer);
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODEMP').AsString := strCodEmp;
            Open;
          End;
        End;

        If Not IsEmpty Then
        Begin
          strTabela  := strTabDet;
          strPrefixo := strPreDet;
          Result := True;
        End;
      End;

    Finally
      qryTmp.Close;
      FreeAndNil(qryTmp);
    End;

  end;

  function fTemProdutosParaImportar : Boolean;
  begin
    Result := False;

    qryTmp := fCriaQuery();

    Try
      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(fSQLDet);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
          Result := True;
      End;

    Finally
      qryTmp.Close;
      FreeAndNil(qryTmp);
    End;

  end;

begin
  Result := False;

  If Pos(strEspDoc, 'PD_OR_') > 0 Then
  Begin
    strTabGer := 'FATGOR';
    strTabDet := 'FATDOR';
    strPreGer := 'FGO_';
    strPreDet := 'FDO_';
  End
  Else
  Begin
    strTabGer := 'MOVGER';
    strTabDet := 'MOVDET';
    strPreGer := 'GER_';
    strPreDet := 'DET_';
  End;

  If Not fDocumentoExiste Then
  Begin
    pMensagemOk('Documento não encontrado');
    Exit;
  End;

  If Not fTemProdutosParaImportar Then
  Begin
    pMensagemOk('Nenhum item do documento satisfaz as condições para ser importado');
    Exit;
  End;

  Result := True;
end;

{****************************************************************}
{* VERIFICA SE EXISTE CAMPANHA DENTRO DE UM DETERMINADO PERÍODO *}
{*************************************************************RL*}
function TCamGer.fExisteCampanha(dtaDtaAtu: TDatetime): Boolean;
 Var
   qryTmp: TUniQuery;
   strSQL: String;
begin
  If (fCampoTabela('COUNT(*)', 'CAMGER', ['CMG_ATIVA_'], ['S'], False) = 0) Then
    Exit(False);

  Result := False;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '  COUNT(*) QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CAMGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CMG_ATIVA_ = "S" AND ';
  strSQL := strSQL + '  (:DTAATU >= CMG_DTAINI AND :DTAATU <= CMG_DTAFIN) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAATU').AsDateTime := dtaDtaAtu;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;

    End;

  FreeAndNil(qryTmp);

end;


{*******************************************}
{* LIMPA DADOS DAS VARIÁVEIS               *}
{****************************************RL*}
procedure TCamGer.pLimpaDadosGer;
begin

  FCodCmg := '';
  FDesCmg := '';
  FCodRed := '';
  FCodCli := '';
  FObs_01 := '';
  FObs_02 := '';
  FObs_03 := '';
  FBrinde := '';
  FDtaEnt := 0;
  FDtaIni := 0;
  FDtaFin := 0;
  FCodEmp := '';
  FAtiva_ := '';
  FAutInc := '';
end;

{*******************************************}
{* SETA DTAENT                             *}
{****************************************RL*}
procedure TCamGer.setCdsCamGer(DataSet: TUniClientDataSet);
begin
  FcdsCamGer := DataSet;
end;

procedure TCamGer.setDesCmg(Value: String);
begin
  FDesCmg := Value;
end;

procedure TCamGer.setDtaEnt(const Value: String);
begin
  FDtaEnt := StrToDateDef(Value,0);
end;

{*******************************************}
{* SETA DTAFIN                             *}
{****************************************RL*}
procedure TCamGer.setDtaFin(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDtaFin := StrToDate(Value)
  Else
    Raise Exception.Create('A data de término de campanha deve ser preenchida !');

end;

{*******************************************}
{* SETA DTAINI                             *}
{****************************************RL*}
procedure TCamGer.setDtaIni(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDtaIni := StrToDate(Value)
  Else
    Raise Exception.Create('A data de início de campanha deve ser preenchida !');

end;

{ TCamGen }

constructor TCamGen.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  Try
    qryCamGen := fCriaQuery;
   {$IFNDEF LINUX}
    dtsCamGen := fCriaDataSource(qryCamGen);
   {$ENDIF}
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

destructor TCamGen.Destroy;
begin
 {$IFNDEF LINUX}
  FreeAndNil(dtsCamGen);
 {$ENDIF}

  FreeAndNil(qryCamGen);

  inherited;
end;

function TCamGen.fDeletaCamGen(strSeqCmg, strOpcao_,
  strCodOpc: String{, strCodEmp: String}): Boolean;
  Var qryTmpDel: TUniQuery;
      strSQL   : String;
begin

  Result := True;

  qryTmpDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM ';
  strSQL := strSQL + '  CAMGEN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GEN_SEQCMG = :SEQCMG AND ';
  strSQL := strSQL + '  GEN_OPCAO_ = :OPCAO  AND ';
  //strSQL := strSQL + '  GEN_CODEMP = :CODEMP AND ';

  If strOpcao_ = '1' Then
    strSQL := strSQL + '  GEN_CODGRU IN (' + strCodOpc + ')'
  Else If strOpcao_ = '2' Then
    strSQL := strSQL + '  GEN_CODFOR IN (' + strCodOpc + ')'
  Else
    strSQL := strSQL + '  GEN_CODMAR IN (' + strCodOpc + ')';

  Try

    With qryTmpDel Do
      Try

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('SEQCMG').AsString := strSeqCmg;
        ParamByName('OPCAO').AsString  := strOpcao_;
        //ParamByName('CODEMP').AsString := strCodEmp;

        Open;
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade('frmCadCampanhaVendas', 'CAMGEN', qryTmpDel);
          Delete;
        End;

      Except
        On E: Exception Do
        Begin

          Result := False;
          Raise Exception.Create('Erro ao deletar item. ' + E.Message);

        End;
      End;

  Finally

    FreeAndNil(qryTmpDel);

  End;

end;

function TCamGen.fGravaCamGen(strAutInc: String; strSeqCmg, strOpcao_,
  strCodGru, strCodFor, strCodMar: String; fltVlrFat: Double;
  strCodEmp: String): Boolean;
  Var
    strChave: String;
    strValor: String;
begin

  Result := True;

  Try

    With qryCamGen Do
    Begin

      If Not Active Then
      Begin
        pCarregaCamGen(strSeqCmg);
        Open;
      End;

      First;

      strChave := '';
      strValor := '';

      If strOpcao_ = '1' Then
      Begin

        strChave := 'AUTOINCREM;GEN_CODGRU;GEN_SEQCMG;GEN_OPCAO_';
        strValor := strCodGru;

      End
      Else If strOpcao_ = '2' Then
      Begin

        strChave := 'AUTOINCREM;GEN_CODFOR;GEN_SEQCMG;GEN_OPCAO_';
        strValor := strCodFor;

      End
      Else
      Begin

        strChave := 'AUTOINCREM;GEN_CODMAR;GEN_SEQCMG;GEN_OPCAO_';
        strValor := strCodMar;

      End;


      If Not Self.qryCamGen.Locate(strChave, VarArrayOf([strAutInc, strValor, Self.strSeqCmg, strOpcao_]), []) Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('CAMGEN', strCodEmp);

        FieldByName('GEN_SEQCMG').AsString := strSeqCmg;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('GEN_OPCAO_').AsString := strOpcao_;
        FieldByName('GEN_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      FieldByName('GEN_CODGRU').Value := IIF(strCodGru = '', Null, strCodGru);
      FieldByName('GEN_CODFOR').Value := IIF(strCodFor = '', Null, strCodFor);
      FieldByName('GEN_CODMAR').Value := IIF(strCodMar = '', Null, strCodMar);
      FieldByName('GEN_VLRFAT').AsFloat  := fltVlrFat;

      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryCamGen.Cancel;
      pMensagensErro(E.Message, '[fGravaCamGen]');
      Result := False;
    End;
  End;

end;

{********************************************}
{* VERIFICA SE A TABELA CAMGEN POSSUI DADOS *}
{*****************************************RL*}
function TCamGen.fUsaCampanhaGenerica: Boolean;
begin

  Result := (fCampoTabela('COUNT(*) AS QTD', 'CAMGEN', [], [], False) > 0);

end;

{*********************************************}
{* VERIFICA SE O GRUPO, A MARCA OU O FORNEC. *}
{* DO PRODUTO PARTICIPA DE ALGUMA CAMPANHA   *}
{* GENÉRICA                                  *}
{******************************************RL*}
function TCamGen.fVerificaProdutoCampGenerica(strCodCli, strCodGru,
 strCodMar, strCodFor: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin
  qryTmp := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                              ';
    strSQL := strSQL + '    CN.GEN_SEQCMG                                                                                                     ';
    strSQL := strSQL + '  FROM                                                                                                                ';
    strSQL := strSQL + '    (SELECT                                                                                                           ';
    strSQL := strSQL + '      DISTINCT CG.CMG_CODCMG                                                                                          ';
    strSQL := strSQL + '    FROM                                                                                                              ';
    strSQL := strSQL + '      (                                                                                                               ';
    strSQL := strSQL + '  	    SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL    ';
    strSQL := strSQL + '        UNION                                                                                                         ';
    strSQL := strSQL + '        SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI =:CODCLI  ';
    strSQL := strSQL + '      ) CG                                                                                                            ';
    strSQL := strSQL + '    WHERE                                                                                                             ';
    strSQL := strSQL + '      (CURRENT_DATE >= CG.CMG_DTAINI AND CURRENT_DATE <= CG.CMG_DTAFIN)                                               ';
    strSQL := strSQL + '    )CG                                                                                                               ';
    strSQL := strSQL + '  INNER JOIN                                                                                                          ';
    strSQL := strSQL + '    CAMGEN CN ON (CN.GEN_SEQCMG = CG.CMG_CODCMG)                                                                      ';
    strSQL := strSQL + '  WHERE                                                                                                               ';
    strSQL := strSQL + '    ((CN.GEN_CODGRU = :CODGRU) OR (CN.GEN_CODMAR = :CODMAR) OR (CN.GEN_CODFOR = :CODFOR))                             ';

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);

    qryTmp.ParamByName('CODCLI').AsString   := strCodCli;
    qryTmp.ParamByName('CODGRU').AsString   := strCodGru;
    qryTmp.ParamByName('CODMAR').AsString   := strCodMar;
    qryTmp.ParamByName('CODFOR').AsString   := strCodFor;

    qryTmp.Open;

    Result := (Not qryTmp.IsEmpty);
  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TCamGen.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

function TCamGen.getDesFor: String;
begin
  Result := fRetNomFornecedor(FCodFor);
end;

function TCamGen.getDesGru: String;
begin
  Result := fRetNomeLinhaGrupo(FCodGru);
end;

function TCamGen.getDesMar: String;
begin
  Result := fRetNomMarca(FCodMar);
end;

function TCamGen.getVlrFat: String;
begin
  Result := FloatToStrF(FVlrFat, ffFixed, 14, 3);
end;

procedure TCamGen.pAtuDadosGen;
begin

  Try

    If (Not qryCamGen.Active) Or (qryCamGen.IsEmpty) Then
    Begin
      pLimpaDadosGen;
    End;

    With qryCamGen Do
    Begin

      FSeqCmg := FieldByName('GEN_SEQCMG').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FOpcao_ := FieldByName('GEN_OPCAO_').AsString;
      FCodMar := FieldByName('GEN_CODMAR').AsString;
      FCodGru := FieldByName('GEN_CODGRU').AsString;
      FCodFor := FieldByName('GEN_CODFOR').AsString;
      FVlrFat := FieldByName('GEN_VLRFAT').AsFloat;
      FCodEmp := FieldByName('GEN_CODEMP').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TCamGen.pCarregaCamGen(strSeqCmg: String);
  Var
    strSQL: String;
begin

  If fEmptyStr(strSeqCmg) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT     ';
  strSQL := strSQL + '  GEN_SEQCMG,          ';
  strSQL := strSQL + '  AUTOINCREM,          ';
  strSQL := strSQL + '  GEN_OPCAO_,          ';
  strSQL := strSQL + '  GEN_CODMAR,          ';
  strSQL := strSQL + '  GEN_CODGRU,          ';
  strSQL := strSQL + '  GEN_CODFOR,          ';
  strSQL := strSQL + '  GEN_VLRFAT,          ';
  strSQL := strSQL + '  GEN_CODEMP           ';
  strSQL := strSQL + 'FROM                   ';
  strSQL := strSQL + '  CAMGEN               ';
  strSQL := strSQL + 'WHERE                  ';
  strSQL := strSQL + '  GEN_SEQCMG = :SEQCMG ';

  With qryCamGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('SEQCMG').AsString := strSeqCmg;

      Open;

      If (Not Active) Or (IsEmpty) Then
        pLimpaDadosGen
      Else
        pAtuDadosGen;

     End;

end;

procedure TCamGen.pLimpaDadosGen;
begin

  FSeqCmg := '';
  FAutInc := '';
  FOpcao_ := '';
  FCodMar := '';
  FDesMar := '';
  FCodGru := '';
  FDesGru := '';
  FCodFor := '';
  FDesFor := '';
  FVlrFat := 0;
  FCodEmp := '';
  FDesEmp := '';

end;

procedure TCamGen.setVlrFat(const Value: String);
begin
  FVlrFat := fStrToFloat(Value);
end;

{*******************************************}
{* DELETA PRODUTO INSERIDO NA CAMPANHA     *}
{****************************************RL*}
function TCamDet.fDeletaCamDet(ACodigoCampanha : String; AProdutosExcluidos : TUniClientDataSet): Boolean;
  Var qryTmpDel: TUniQuery;
      strSQL   : String;
begin

  Result := True;

  qryTmpDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM ';
  strSQL := strSQL + '  CAMDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CMD_SEQCMG = :SEQCMG AND ';
  strSQL := strSQL + '  CMD_CODITE = :CODITE AND ';
  strSQL := strSQL + '  CMD_IDEPRO = :IDEPRO AND ';
  strSQL := strSQL + '  CMD_ITETIN = :ITETIN ';

  Try
    Try
      qryTmpDel.SQL.Add(strSQL);

      AProdutosExcluidos.fIRST;
      while not AProdutosExcluidos.Eof do
      begin
        qryTmpDel.Close;
        qryTmpDel.ParamByName('SEQCMG').AsString := ACodigoCampanha;
        qryTmpDel.ParamByName('CODITE').AsString := AProdutosExcluidos.FieldByName('CODITE').AsString;
        qryTmpDel.ParamByName('IDEPRO').AsString := AProdutosExcluidos.FieldByName('IDEPRO').AsString;
        qryTmpDel.ParamByName('ITETIN').AsString := AProdutosExcluidos.FieldByName('ITETIN').AsString;
        qryTmpDel.Open;

        If Not qryTmpDel.IsEmpty Then
        Begin
          fVerificaIntegridade('frmCadCampanhaVendas', 'CAMDET', qryTmpDel);
          qryTmpDel.Delete;
        End;

        AProdutosExcluidos.Next;
      end;

    Except
      On E: Exception Do
      Begin

        Result := False;
        Raise Exception.Create('Erro ao deletar item. ' + E.Message);

      End
    End;

  Finally
    FreeAndNil(qryTmpDel);
  End;

end;

{*******************************************}
{* RETORNA SIMILARIDADE                    *}
{****************************************RL*}
function TCamDet.fRetornaSimilaridade(strCodIte: String): String;
begin
  Result := '';

  If (fEmptyStr(strCodIte)) Then
    Exit;

  Result := fCampoTabela('ITE_CODSIM', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

function TCamDet.fRetornaSomenteItensEmCampanhaDaLista(strLisCodIteOrc: String): TStringList;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Result := TStringList.Create;

  If fEmptyStr(strLisCodIteOrc) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CMD_CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CAMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CMD_CODITE IN ('+(strLisCodIteOrc)+')';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      
      Open;
      If Not qryGen.IsEmpty Then
      Begin 
        First;

        While Not Eof Do
        Begin
          Result.Add(FieldByName('CMD_CODITE').AsString);

          Next;
        End;
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

{*******************************************}
{* VERIFICA SE O PRODUTO PARTICIPA DE      *}
{* UMA DETERMINADA CAMPANHA                *}
{****************************************RL*}
function TCamDet.fVerificaProdutoCampanha(strCodCmg,
  strCodIte: String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;

begin

  Result := '-1';

  If (stlItensNaoTemCampanha.IndexOf(strCodIte) >= 0) Then
  Begin
    If fCfgSis('SIMCAM', varBoolean) Then
    Begin
      If (fEmptyStr(fRetornaSimilaridade(strCodIte))) Then 
         Exit
    End
    Else
      Exit
  End;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '  CMD_SEQCMG, ';
  strSQL := strSQL + '  CMD_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CAMGER, ';
  strSQL := strSQL + '  CAMDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CMD_SEQCMG = :CODCMG AND ';
  strSQL := strSQL + '  CMD_CODITE = :CODITE AND ';
  strSQL := strSQL + '  CMG_CODCMG = CMD_SEQCMG AND ';
  strSQL := strSQL + '  (:DTAATU >= CMG_DTAINI AND :DTAATU <= CMG_DTAFIN) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCMG').AsString   := strCodCmg;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If RecordCount > 0 Then
        Result := FieldByName('CMD_SEQCMG').AsString;

      Close;

    End;

  FreeAndNil(qryTmp);

end;

{*******************************************}
{* VERIFICA SE O PRODUTO PARTICIPA DE      *}
{* ALGUMA CAMPANHA DIRETAMENTE OU SE       *}
{* PARTICIPADA POR SIMILARIDADE            *}
{****************************************RL*}
function TCamDet.fVerificaProdutoCampanha(strCodCli, strCodIte, strIdePro, strIteTin: String;
  fltTinVol: Double; var fltVlrUni : Double; var strCodCam: String;
  var fltPreClq: Double): Boolean;
Var
  qryTmp: TUniQuery;
  strSQL: String;
  objDados: IMyCampoTabela;
begin

  If (stlItensNaoTemCampanha.IndexOf(strCodIte) >= 0) Then
  Begin
    If fCfgSis('SIMCAM', varBoolean) Then
    Begin
      If (fEmptyStr(fRetornaSimilaridade(strCodIte))) Then
         Exit(False)
    End
    Else
      Exit(False)
  End;

  Result := False;

  qryTmp := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                              ';
    strSQL := strSQL + '    CD.CMD_CODITE,                                                                                                    ';
    strSQL := strSQL + '    CD.CMD_VLRUNI,                                                                                                    ';
    strSQL := strSQL + '    CG.CMG_CODCMG,                                                                                                    ';
    strSQL := strSQL + '    CD.CMD_TINVOL,                                                                                                    ';
    strSQL := strSQL + '    CD.CMD_PRECLQ                                                                                                     ';
    strSQL := strSQL + '  FROM                                                                                                                ';
    strSQL := strSQL + '    (SELECT                                                                                                           ';
    strSQL := strSQL + '       DISTINCT CG.CMG_CODCMG                                                                                         ';
    strSQL := strSQL + '     FROM                                                                                                             ';
    strSQL := strSQL + '       (                                                                                                              ';
    strSQL := strSQL + '         SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL   ';
    strSQL := strSQL + '         UNION                                                                                                        ';
    strSQL := strSQL + '         SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI =:CODCLI ';
    strSQL := strSQL + '       ) CG                                                                                                           ';
    strSQL := strSQL + '     WHERE                                                                                                            ';
    strSQL := strSQL + '       (CURRENT_DATE >= CG.CMG_DTAINI AND CURRENT_DATE <= CG.CMG_DTAFIN) AND                                          ';
    strSQL := strSQL + '       CG.CMG_ATIVA_ = "S"                                                                                            ';
    strSQL := strSQL + '    )CG                                                                                                               ';
    strSQL := strSQL + '  INNER JOIN                                                                                                          ';
    strSQL := strSQL + '    CAMDET CD ON (CD.CMD_SEQCMG = CG.CMG_CODCMG)                                                                      ';
    strSQL := strSQL + '  WHERE                                                                                                               ';
    strSQL := strSQL + '    CD.CMD_CODITE = :CODITE                                                                                           ';

    If (Not fEmptyStr(strIdePro)) And (Not fEmptyStr(strIteTin)) Then
    Begin
      strSQL := strSQL + '  AND CD.CMD_IDEPRO = :IDEPRO ';
      strSQL := strSQL + '  AND CD.CMD_ITETIN = :ITETIN ';
    End
    Else
    Begin
      strSQL := strSQL + '  AND CD.CMD_IDEPRO = "NOR" ';
      strSQL := strSQL + '  AND TRIM(IFNULL(CD.CMD_ITETIN,"")) = "" ';
    End;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);

    qryTmp.ParamByName('CODITE').AsString   := strCodIte;
    qryTmp.ParamByName('CODCLI').AsString   := strCodCli;

    If (Not fEmptyStr(strIdePro)) And (Not fEmptyStr(strIteTin)) Then
    Begin
      qryTmp.ParamByName('IDEPRO').AsString   := strIdePro;
      qryTmp.ParamByName('ITETIN').AsString   := strIteTin;
    End;

    objDados := ExecutarQueryEmCache(qryTmp);

    If Not fEmptyStr(objDados.FieldByName('CMG_CODCMG')) Then
    Begin
      fltVlrUni := objDados.FieldByName('CMD_VLRUNI');
      strCodCam := objDados.FieldByName('CMG_CODCMG');
      fltPreClq := objDados.FieldByName('CMD_PRECLQ');
      Result    := True;

      //valor proporcional ao volume da tinta
      If (fltTinVol > 0) And (objDados.FieldByName('CMD_TINVOL').AsFloat > 0) Then
        fltVlrUni := (fltVlrUni * fltTinVol) / objDados.FieldByName('CMD_TINVOL').AsFloat;
    End
    Else If fCfgSis('SIMCAM', varBoolean) Then
    Begin
      If (Not fEmptyStr(fRetornaSimilaridade(strCodIte))) Then
      Begin
        strSQL := '';
        strSQL := strSQL + '  SELECT                                                                                                               ';
        strSQL := strSQL + '    CD.CMD_CODITE,                                                                                                     ';
        strSQL := strSQL + '    CD.CMD_VLRUNI,                                                                                                     ';
        strSQL := strSQL + '    CG.CMG_CODCMG,                                                                                                     ';
        strSQL := strSQL + '    CD.CMD_TINVOL,                                                                                                     ';
        strSQL := strSQL + '    CD.CMD_PRECLQ                                                                                                      ';
        strSQL := strSQL + '  FROM                                                                                                                 ';
        strSQL := strSQL + '    (SELECT                                                                                                            ';
        strSQL := strSQL + '       DISTINCT CG.CMG_CODCMG                                                                                          ';
        strSQL := strSQL + '     FROM                                                                                                              ';
        strSQL := strSQL + '       (                                                                                                               ';
        strSQL := strSQL + '         SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL    ';
        strSQL := strSQL + '         UNION                                                                                                         ';
        strSQL := strSQL + '         SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI =:CODCLI  ';
        strSQL := strSQL + '       ) CG                                                                                                            ';
        strSQL := strSQL + '     WHERE                                                                                                             ';
        strSQL := strSQL + '       CG.CMG_ATIVA_ = "S" AND                                                                                         ';
        strSQL := strSQL + '       (CURRENT_DATE >= CG.CMG_DTAINI AND CURRENT_DATE <= CG.CMG_DTAFIN)                                               ';
        strSQL := strSQL + '    ) CG                                                                                                               ';
        strSQL := strSQL + '  INNER JOIN                                                                                                           ';
        strSQL := strSQL + '    CAMDET CD ON (CG.CMG_CODCMG = CD.CMD_SEQCMG)                                                                       ';
        strSQL := strSQL + '  WHERE                                                                                                                ';
        strSQL := strSQL + '    CD.CMD_CODITE IN (SELECT ITE_CODITE FROM CADITE WHERE ITE_CODSIM = :CODSIM) AND                                    ';
        strSQL := strSQL + '    CD.CMD_IDEPRO = "NOR" AND                                                                                          ';
        strSQL := strSQL + '    TRIM(IFNULL(CD.CMD_ITETIN,"")) = ""                                                                                ';

        qryTmp.Close;
        qryTmp.SQL.Clear;
        qryTmp.SQL.Add(strSQL);

        qryTmp.ParamByName('CODSIM').AsString   := fRetornaSimilaridade(strCodIte);
        qryTmp.ParamByName('CODCLI').AsString   := strCodCli;

        objDados := ExecutarQueryEmCache(qryTmp);

        If Not fEmptyStr(objDados.FieldByName('CMG_CODCMG')) Then
        Begin
          fltVlrUni := objDados.FieldByName('CMD_VLRUNI');
          strCodCam := objDados.FieldByName('CMG_CODCMG');
          fltPreClq := objDados.FieldByName('CMD_PRECLQ');
          Result    := True;

          //valor proporcional ao volume da tinta
          If (fltTinVol > 0) And (objDados.FieldByName('CMD_TINVOL').AsFloat > 0) Then
            fltVlrUni := (fltVlrUni * fltTinVol) / objDados.FieldByName('CMD_TINVOL').AsFloat;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TCamGer.fVerificaCustoItemCampanha(strCodEmp, strCodCli, strCodIte,
    strIdePro, strIteTin: String; var fltPreCus: Double): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin
  fltPreCus := 0;

  qryTmp := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                            ';
    strSQL := strSQL + '    CD.CMD_PRECUS                                                                                                   ';
    strSQL := strSQL + '  FROM                                                                                                              ';
    strSQL := strSQL + '    (                                                                                                               ';
    strSQL := strSQL + '      SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL    ';
    strSQL := strSQL + '      UNION                                                                                                         ';
    strSQL := strSQL + '      SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI =:CODCLI  ';
    strSQL := strSQL + '    ) CG                                                                                                            ';
    strSQL := strSQL + '  INNER JOIN                                                                                                        ';
    strSQL := strSQL + '    CAMDET CD ON (CD.CMD_SEQCMG = CG.CMG_CODCMG)                                                                    ';
    strSQL := strSQL + '  WHERE                                                                                                             ';
    strSQL := strSQL + '    CG.CMG_ATIVA_ = "S" AND                                                                                         ';
    strSQL := strSQL + '    CG.CMG_CODEMP = :CODEMP AND                                                                                     ';
    strSQL := strSQL + '    (CURRENT_DATE BETWEEN CG.CMG_DTAINI AND CG.CMG_DTAFIN) AND                                                      ';
    strSQL := strSQL + '    CD.CMD_CODITE = :CODITE                                                                                         ';

    If (Not fEmptyStr(strIdePro)) And (Not fEmptyStr(strIteTin)) Then
    Begin
      strSQL := strSQL + '  AND CD.CMD_IDEPRO = :IDEPRO ';
      strSQL := strSQL + '  AND CD.CMD_ITETIN = :ITETIN ';
    End
    Else
    Begin
      strSQL := strSQL + '  AND CD.CMD_IDEPRO = "NOR" ';
      strSQL := strSQL + '  AND TRIM(IFNULL(CD.CMD_ITETIN,"")) = "" ';
    End;


    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);

    qryTmp.ParamByName('CODEMP').AsString   := strCodEmp;
    qryTmp.ParamByName('CODCLI').AsString   := strCodCli;
    qryTmp.ParamByName('CODITE').AsString   := strCodIte;

    If (Not fEmptyStr(strIdePro)) And (Not fEmptyStr(strIteTin)) Then
    Begin
      qryTmp.ParamByName('IDEPRO').AsString   := strIdePro;
      qryTmp.ParamByName('ITETIN').AsString   := strIteTin;
    End;

    qryTmp.Open;

    If Not qryTmp.IsEmpty Then
      fltPreCus := qryTmp.FieldByName('CMD_PRECUS').AsFloat;
  Finally
    FreeAndNil(qryTmp);
  End;

  Result := (fltPreCus > 0);
End;

{******************************************************}
{* VERIFICA SE O CLIENTE PARTICIPA DE ALGUMA CAMPANHA *}
{***************************************************RL*}
function TCamGer.fVerificaClienteCampanha(strCodCli: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin
  qryTmp := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                            ';
    strSQL := strSQL + '    CG.CCM_CODCLI                                                                                                   ';
    strSQL := strSQL + '  FROM                                                                                                              ';
    strSQL := strSQL + '    (                                                                                                               ';
    strSQL := strSQL + '      SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL    ';
    strSQL := strSQL + '      UNION                                                                                                         ';
    strSQL := strSQL + '      SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI =:CODCLI  ';
    strSQL := strSQL + '    ) CG                                                                                                            ';
    strSQL := strSQL + '  WHERE                                                                                                             ';
    strSQL := strSQL + '    CG.CMG_ATIVA_ = "S" AND                                                                                         ';
    strSQL := strSQL + '    CURRENT_DATE BETWEEN CG.CMG_DTAINI AND CG.CMG_DTAFIN                                                            ';



    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);

    qryTmp.ParamByName('CODCLI').AsString   := strCodCli;

    qryTmp.Open;

    Result := (Not qryTmp.IsEmpty);
  Finally
    FreeAndNil(qryTmp);
  End;
End;

function TCamGer.fConfirmaCondPagCampanha(strCodCmg, strCodCnd, strCodFpg: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  Result := True;

  qryTmp := fCriaQuery;


  strSQL := '';
  strSQL := strSQL + 'SELECT AUTOINCREM FROM CAMCND ';
  strSQL := strSQL + ' WHERE CND_CODCMG = :CODCMG  ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCMG').AsString   := strCodCmg;

      Open;

      If IsEmpty Then
      Begin

        Close;
        FreeAndNil(qryTmp);
        Exit;

      End;

      Close;

    End;


  strSQL := '';
  strSQL := strSQL + 'SELECT AUTOINCREM ';
  strSQL := strSQL + ' FROM CAMCND ';
  strSQL := strSQL + 'WHERE CND_CODCMG = :CODCMG ';
  strSQL := strSQL + '  AND CND_CODCND = :CODCND ';
  strSQL := strSQL + '  AND CND_CODFPG = :CODFPG ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCMG').AsString   := strCodCmg;
      ParamByName('CODCND').AsString   := strCodCnd;
      ParamByName('CODFPG').AsString   := strCodFpg;

      Open;

      Result := Not IsEmpty;

      Close;

    End;

  FreeAndNil(qryTmp);

End;

function TCamGer.fDeletaCamCnd(strAutoinCnd: String): Boolean;
  Var qryTmpDel: TUniQuery;
      strSQL: String;
begin
  Result := True;

  qryTmpDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM CAMCND ';
  strSQL := strSQL + 'WHERE AUTOINCREM IN (' + strAutoinCnd + ')';

  Try
    With qryTmpDel Do
      Try
        SQL.Add(strSQL);
        Open;

        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade('frmCadCampanhaVendas', 'CAMCND', qryTmpDel);
          Delete;
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          Raise Exception.Create('Erro ao deletar condição de pagamento. ' + E.Message);
        End;
      End;
  Finally
    FreeAndNil(qryTmpDel);
  End;
end;

procedure TCamGer.pCarregaProdutos(qryProdutos : TUniQuery);

  function fSQLProdutos : String;
  begin
    Result := Result + 'SELECT ';

    Result := Result + 'IFNULL(( SELECT ';
    Result := Result + fGetSQLGiro('ENT','GICPMD', FdicFiltro['DTCTIN'], True, 3);
    Result := Result + '  ),0) AS GIRP03, ';

    Result := Result + 'IFNULL(( SELECT ';
    Result := Result + fGetSQLGiro('ENT','GICPMD', FdicFiltro['DTCTIN'], True, 6);
    Result := Result + '  ),0) AS GIRP06, ';

    Result := Result + 'IFNULL(( SELECT ';
    Result := Result + fGetSQLGiro('ENT','GICPMD', FdicFiltro['DTCTIN'], True, 12);
    Result := Result + '  ),0) AS GIRP12, ';

    Result := Result + '    IT.ITE_CODITE AS CODITE, ';
    Result := Result + '    SP.SIT_CORSIT AS CORSIT, ';
    Result := Result + '    IF(IFNULL(CP.CMD_TINDES,"")="",IT.ITE_DESITE, CP.CMD_TINDES) AS DESITE, ';
    Result := Result + '    IG.ITE_CODEMP AS CODEMP, ';
    Result := Result + '    FN.FOR_NOMFOR AS NOMFOR, ';
    Result := Result + '    DP.DEP_DESCRI AS DEPDES, ';
    Result := Result + '    IG.ITE_PREUVE AS ULTVEN, ';
    Result := Result + '    CP.CMD_QTDITE AS QTDITE, ';
    Result := Result + '    CP.CMD_VLRUNI AS VLRUNI, ';
    Result := Result + '    CP.CMD_PRECLQ AS PRECLQ, ';
    Result := Result + '    CP.CMD_PRECUS AS PRECUS, ';
    Result := Result + '    CP.CMD_IDEPRO AS IDEPRO, ';
    Result := Result + '    CP.CMD_ITETIN AS ITETIN, ';
    Result := Result + '    CP.CMD_TINVOL AS TINVOL, ';
    Result := Result + '    CP.AUTOINCREM AS AUTINC, ';
    Result := Result + '    CG.CMG_DTAINI AS DTAINI, ';
    Result := Result + '    CG.CMG_DTAFIN AS DTAFIN, ';
    Result := Result + '    IT.ITE_NVLGIR AS NVLGIR, ';
    Result := Result + '    IT.ITE_NVLCRI AS NVLCRI, ';
    Result := Result + '    0.00 AS GICPMD, ';
    Result := Result + '    0.00 AS CUSCTR, ';
    Result := Result + '    0.00 AS MARLIQ, ';
    Result := Result + '    0.00 AS RESLIQ, ';
    Result := Result + '    0.00 AS RLIQGI, ';
    Result := Result + '    0.00 AS PERACT, ';
    Result := Result + '    0.00 AS RLIQAC, ';
    Result := Result + '    0.00 AS RESPER, ';

    If Not fEmptyStr(FdicFiltro['IMPDOC']) Then
    Begin
      Result := Result + '    D.' + FdicFiltro['IMPPRE'] + 'QTDITE AS QTDITED, ';
      Result := Result + '    D.' + FdicFiltro['IMPPRE'] + 'UNITAR AS UNITARD, ';
      Result := Result + '    (D.' + FdicFiltro['IMPPRE'] + 'TOTCUS/D.' + FdicFiltro['IMPPRE'] + 'QTDITE) AS TOTCUSD, ';
    End;

    Result := Result + '    IG.ITE_PRECUS AS ITECUS, ';
    Result := Result + '    IG.ITE_OUTVAL AS ITEOUT, ';
    Result := Result + '    IG.ITE_ICMSAI AS ICMSAI, ';
    Result := Result + '    IG.ITE_IMPFED AS IMPFED, ';
    Result := Result + '    IG.ITE_DESOPE AS DESOPE, ';
    Result := Result + '    IG.ITE_ESTMIN AS ESTMIN, ';
    Result := Result + '    IG.ITE_ESTMAX AS ESTMAX, ';
    Result := Result + '    IT.ITE_CODGRU AS CODGRU, ';
    Result := Result + '    IT.ITE_CODFOR AS CODFOR, ';
    Result := Result + '    IT.ITE_CODMAR AS CODMAR, ';
    Result := Result + '    IT.ITE_CLAIPI AS CLAIPI, ';
    Result := Result + '    IT.ITE_REFERE AS REFERE, ';
    Result := Result + '    IT.ITE_CODUNI AS CODUNI, ';
    Result := Result + '    IT.ITE_SITPRO AS SITPRO, ';
    Result := Result + '    IT.ITE_CLACRM AS CLACRM, ';

    Result := Result + '     @TOTITE := IFNULL((SELECT SUM( ';
    Result := Result + '         IF((LOCATE(DT.DET_ESPDOC, "BR_OI_") > 0) ';
    Result := Result + '             OR LOCATE(DT.DET_CLAFIS, "5910_6910_"), 0.00, ';
    Result := Result + '             IF(LEFT(DT.DET_CLAFIS, 1) < 5, - ( ';
    Result := Result + '                 DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF), ';
    Result := Result + '               DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF)) ';
    Result := Result + '       ) FROM MOVDET DT ';
    Result := Result + '         WHERE DT.DET_CODITE = IT.ITE_CODITE ';
    Result := Result + '         AND DT.DET_DTAENT BETWEEN :DTAINI AND :DTAFIM ';
    Result := Result + '         AND DT.DET_PROEMB <> "S" ';
    Result := Result + '         AND DT.DET_TIP_FC = "C" ';
    Result := Result + '       ),0) AS TOTITE, ';

    // Total do custo final
    Result := Result + '    @TOTCU2 := IFNULL((SELECT SUM( ';
    Result := Result + '        IF(LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '          - IFNULL(ROUND((IFNULL(DT.DET_TOTCU2, 0)), 2), 0), ';
    Result := Result + '          IFNULL(ROUND((IFNULL(DT.DET_TOTCU2, 0)), 2), 0)) ';
    Result := Result + '      ) FROM MOVDET DT ';
    Result := Result + '        WHERE DT.DET_CODITE = IT.ITE_CODITE ';
    Result := Result + '        AND DT.DET_DTAENT BETWEEN :DTAINI AND :DTAFIM ';
    Result := Result + '        AND DT.DET_PROEMB <> "S" ';
    Result := Result + '        AND DT.DET_TIP_FC = "C" ';
    Result := Result + '        AND DT.DET_ESPDOC <> "OI"';
    Result := Result + '      ),0) AS TOTCU2, ';

    // Margem
    Result := Result + '    IF(@TOTCU2>0 AND @TOTITE>0,((1-(@TOTCU2/@TOTITE))*100),0) AS MARGEM, ';

    // Total do custo
    Result := Result + '    SUM(IF(DT.DET_ESPDOC = "OI", 0.00,     ';
    Result := Result + '        IF(LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '         - IFNULL(ROUND((IFNULL(DT.DET_TOTCUS, 0)), 2), 0), ';
    Result := Result + '           IFNULL(ROUND((IFNULL(DT.DET_TOTCUS, 0)), 2), 0)))) ';
    Result := Result + '    AS TOTCUS, ';

    // Preço antes do contrato
    Result := Result + '(SELECT ';
    Result := Result + '  IF(DET_DESCON < 0, DET_UNITAR, DET_UNIORI) * IF(DET_CLAFIS < 5000, - 1, 1) ';
    Result := Result + 'FROM MOVDET WHERE ';
    Result := Result + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    Result := Result + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';
    If fCfgSis('ENTBRF', varBoolean) Then
      Result := Result + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      Result := Result + ') ';
    Result := Result + '  AND LOCATE(DET_ESPDOC, "AJ_TR_OI_") <= 0 ';
    Result := Result + '  AND DET_CODITE = IT.ITE_CODITE         ';
    Result := Result + '  AND DET_DTAENT < CG.CMG_DTAINI         ';
    Result := Result + 'ORDER BY DET_DTAENT DESC LIMIT 1) AS ULTPRE, ';

    // Percentual atingido
    Result := Result + '  ((SELECT ';
    Result := Result + '    SUM((IF(DET_CLAFIS < 5000, - 1, 1) * DET_QTDITE)) ';
    Result := Result + '  FROM ';
    Result := Result + '    MOVDET DET ';
    Result := Result + '  WHERE DET.DET_CODITE = IT.ITE_CODITE ';
    Result := Result + '    AND DET.DET_DTAENT BETWEEN :DTCTIN AND :DTCTFI ';
    Result := Result + '    AND DET.DET_PROEMB <> "S" ';
    Result := Result + '    AND DET.DET_ESPDOC <> "OI" ';
    Result := Result + '    AND DET.DET_TIP_FC = "C")/CP.CMD_QTDITE)*100 AS PEROBJ, ';

    // Vendas no período da campanha - Quantidade
    Result := Result + '(SELECT ';
    Result := Result + '    SUM((IF((LOCATE(DT.DET_ESPDOC, "BR_OI_") > 0) OR LOCATE(DT.DET_CLAFIS,'+ CLAFIS_BR +'), 0.00, ';
    Result := Result + '         IF(LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '            - (DT.DET_QTDITE), ';
    Result := Result + '               DT.DET_QTDITE)))) ';
    Result := Result + 'FROM MOVDET DT ';
    Result := Result + 'WHERE DT.DET_CODITE = IT.ITE_CODITE AND ';
    Result := Result + '      DT.DET_DTAENT BETWEEN :DTCTIN AND :DTCTFI AND ';
    Result := Result + '	    DT.DET_PROEMB <> "S" AND ';
    Result := Result + '	    DT.DET_TIP_FC = "C") ';
    Result := Result + ' AS QTDPER, ';

    // Vendas no período da campanha
    Result := Result + '(SELECT ';
    Result := Result + '    SUM((IF((LOCATE(DT.DET_ESPDOC, "BR_OI_") > 0) OR LOCATE(DT.DET_CLAFIS,'+ CLAFIS_BR +'), 0.00, ';
    Result := Result + '         IF(LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '            - (DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF), ';
    Result := Result + '               DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF)))) ';
    Result := Result + 'FROM MOVDET DT ';
    Result := Result + 'WHERE DT.DET_CODITE = IT.ITE_CODITE AND ';
    Result := Result + '      DT.DET_DTAENT BETWEEN :DTCTIN AND :DTCTFI AND ';
    Result := Result + '	    DT.DET_PROEMB <> "S" AND ';
    Result := Result + '	    DT.DET_TIP_FC = "C") ';
    Result := Result + ' AS VENPER, ';

    Result := Result + '@TOTCU3 := IFNULL((SELECT IFNULL((SUM(IF( ';
    Result := Result + '       LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '       - IFNULL(ROUND((IFNULL(DT.DET_TOTCU2, 0)), 2), 0), ';
    Result := Result + '       IFNULL(ROUND((IFNULL(DT.DET_TOTCU2, 0)), 2), 0)))),0) ';
    Result := Result + 'FROM MOVDET DT ';
    Result := Result + 'WHERE DT.DET_CODITE = IT.ITE_CODITE ';
    Result := Result + '  AND DT.DET_DTAENT BETWEEN :DTCTIN AND :DTCTFI ';
    Result := Result + '  AND DT.DET_PROEMB <> "S" ';
    Result := Result + '  AND DT.DET_ESPDOC <> "OI" ';
    Result := Result + '  AND DT.DET_TIP_FC = "C"),0) AS TOTCU3, ';

    Result := Result + '@TOTIT3 := IFNULL((SELECT IFNULL((SUM((IF((LOCATE(DT.DET_ESPDOC, "BR_OI_") > 0) OR LOCATE(DT.DET_CLAFIS, "5910_6910_"), ';
    Result := Result + '            0.00, IF(LEFT(DT.DET_CLAFIS, 1) < 5, ';
    Result := Result + '            - (DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF), ';
    Result := Result + '               DT.DET_TOTITE - DT.DET_DESESP - DT.DET_DESCFF))))),0) ';
    Result := Result + 'FROM MOVDET DT ';
    Result := Result + 'WHERE DT.DET_CODITE = IT.ITE_CODITE ';
    Result := Result + '  AND DT.DET_DTAENT BETWEEN :DTCTIN AND :DTCTFI ';
    Result := Result + '  AND DT.DET_PROEMB <> "S" ';
    Result := Result + '  AND DT.DET_TIP_FC = "C"),0) AS TOTIT3, ';

    Result := Result + 'IF(@TOTCU3>0 AND @TOTIT3>0,((1-(@TOTCU3/@TOTIT3))*100),0) AS MARPER, ';

    Result := Result + 'CP.CMD_CODPCL AS CODPCL ';

    If Not fEmptyStr(FdicFiltro['CODCMG']) Then
    Begin
      Result := Result + '  FROM CAMGER CG ';
      Result := Result + '  INNER JOIN CAMDET CP ON CP.CMD_SEQCMG = CG.CMG_CODCMG ';
      Result := Result + '  INNER JOIN CADITE IT ON IT.ITE_CODITE = CP.CMD_CODITE ';
    End
    Else
    Begin
      Result := Result + '  FROM CADITE IT ';
      Result := Result + '  LEFT JOIN CAMGER CG ON CG.CMG_CODCMG = :CODCMG ';
      Result := Result + '  LEFT JOIN CAMDET CP ON CP.CMD_CODITE = IT.ITE_CODITE AND CP.CMD_SEQCMG = CG.CMG_CODCMG ';

      If Not fEmptyStr(FdicFiltro['IDEPRO']) Then
          Result := Result + '  AND CP.CMD_IDEPRO = :IDEPRO ';

      If Not fEmptyStr(FdicFiltro['ITETIN']) Then
          Result := Result + '  AND CP.CMD_ITETIN = :ITETIN ';
    End;

    Result := Result + '    LEFT JOIN MOVDET DT  ';
    Result := Result + '      ON DT.DET_CODITE = IT.ITE_CODITE AND  ';
    Result := Result + '         DT.DET_DTAENT BETWEEN :DTAINI AND :DTAFIM AND ';
    Result := Result + '	       DT.DET_PROEMB <> "S" AND ';
    Result := Result + '	       DT.DET_TIP_FC = "C" ';

    Result := Result + '    INNER JOIN CADFOR FN ';
    Result := Result + '      ON FN.FOR_CODFOR = IT.ITE_CODFOR ';
    Result := Result + '    LEFT JOIN CADDEP DP ';
    Result := Result + '      ON DP.DEP_CODIGO = IT.ITE_CODDEP ';
    Result := Result + '    INNER JOIN ITEGER IG ';
    Result := Result + '      ON IG.ITE_CODITE = IT.ITE_CODITE AND IG.ITE_CODEMP = :EMPITE ';
    Result := Result + '    LEFT JOIN SITPRO SP ';
    Result := Result + '      ON SP.SIT_CODIGO = IT.ITE_SITPRO ';

    If Not fEmptyStr(FdicFiltro['IMPDOC']) Then
    Begin
      Result := Result + '  LEFT JOIN ' + FdicFiltro['IMPTAB'] + ' D ';
      Result := Result + '    ON D.' + FdicFiltro['IMPPRE'] + 'CODITE = IT.ITE_CODITE AND ';
      Result := Result + '       D.' + FdicFiltro['IMPPRE'] + 'CODEMP = :CODEMP AND ';
      Result := Result + '       D.' + FdicFiltro['IMPPRE'] + 'ESPDOC = :ESPDOC AND ';
      Result := Result + '       D.' + FdicFiltro['IMPPRE'] + 'NUMDOC = :NUMDOC ';
    End;

    Result := Result + '  WHERE TRUE ';

    If Not fEmptyStr(FdicFiltro['IMPDOC']) Then
    Begin
      Result := Result + '  AND IT.ITE_CODITE IN ( ' ;
      Result := Result + '    SELECT ' + FdicFiltro['IMPPRE'] + 'CODITE FROM ' + FdicFiltro['IMPTAB'];
      Result := Result + '     WHERE ' + FdicFiltro['IMPPRE'] + 'NUMDOC = :NUMDOC AND ';
      Result := Result + '           ' + FdicFiltro['IMPPRE'] + 'ESPDOC = :ESPDOC AND ';
      Result := Result + '           ' + FdicFiltro['IMPPRE'] + 'CODEMP = :CODEMP AND ';
      Result := Result + '           ' + FdicFiltro['IMPPRE'] + 'IDEPRO = "NOR"   AND ';
      Result := Result + '           ' + FdicFiltro['IMPPRE'] + 'PROACA = "N"     AND ';
      Result := Result + '           ' + FdicFiltro['IMPPRE'] + 'PROEMB <> "S")       ';
    End

    Else If (Not fEmptyStr(FdicFiltro['CODCMG'])) Then
      Result := Result + '  AND CG.CMG_CODCMG = :CODCMG '

    Else If (Not fEmptyStr(FdicFiltro['CODITE'])) Then
      Result := Result + '  AND IT.ITE_CODITE = :CODITE '
    Else
    Begin
      If Not fEmptyStr(FdicFiltro['CODGRU']) Then
      Begin
        If RightStr(FdicFiltro['CODGRU'],3) = '000' Then
          Result := Result + '  AND LEFT(IT.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          Result := Result + '  AND IT.ITE_CODGRU = :CODGRU ';
      End;

      If Not fEmptyStr(FdicFiltro['CODFOR']) Then
        Result := Result + '  AND IT.ITE_CODFOR = :CODFOR ';

      If Not fEmptyStr(FdicFiltro['CODMAR']) Then
        Result := Result + '  AND IT.ITE_CODMAR = :CODMAR ';

      If (Not fEmptyStr(FdicFiltro['DESINI'])) and (Not fEmptyStr(FdicFiltro['DESFIN'])) Then
        Result := Result + '  AND LEFT(IT.ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

      If Not fEmptyStr(FdicFiltro['CLAIPI']) Then
        Result := Result + '  AND IT.ITE_CLAIPI LIKE "%' + FdicFiltro['CLAIPI'] + '%"';

      If Not fEmptyStr(FdicFiltro['REFERE']) Then
        Result := Result + '  AND IT.ITE_REFERE = :REFERE ';

      If Not fEmptyStr(FdicFiltro['CODUNI']) Then
        Result := Result + '  AND IT.ITE_CODUNI = :CODUNI ';

      If Not fEmptyStr(FdicFiltro['CODSIT']) Then
        Result := Result + '  AND IT.ITE_SITPRO = :SITPRO ';

      If Not fEmptyStr(FdicFiltro['CLACRM']) Then
        Result := Result + '  AND IT.ITE_CLACRM = :CLACRM ';
    End;

    Result := Result + ' GROUP BY CODITE, IDEPRO, ITETIN ';

    Result := Result + ' ORDER BY CODITE ';
  end;

begin

  Try

    With qryProdutos Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLProdutos);

      ParamByName('DTAINI').AsDateTime := FdicFiltro['GDTINI'];
      ParamByName('DTAFIM').AsDateTime := FdicFiltro['GDTFIM'];

      ParamByName('DTCTIN').AsDateTime := FdicFiltro['DTCTIN'];
      ParamByName('DTCTFI').AsDateTime := FdicFiltro['DTCTFI'];

      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If (Not fEmptyStr(FdicFiltro['CODITE'])) And (Assigned(FindParam('CODITE'))) Then
        ParamByName('CODITE').AsString := FdicFiltro['CODITE'];

      If (Not fEmptyStr(FdicFiltro['CODCMG'])) And (Assigned(FindParam('CODCMG'))) Then
        ParamByName('CODCMG').AsString := FdicFiltro['CODCMG'];

      If (Not fEmptyStr(FdicFiltro['CODCMGEDT'])) And (fEmptyStr(FdicFiltro['CODCMG'])) Then
        If FindParam('CODCMG') <> Nil Then
          ParamByName('CODCMG').AsString := FdicFiltro['CODCMGEDT'];
          
      If Not fEmptyStr(FdicFiltro['CODEMP']) Then
        ParamByName('EMPITE').AsString := FdicFiltro['CODEMP']
      Else
        ParamByName('EMPITE').AsString := VS_strCodEmp;

      If fEmptyStr(FdicFiltro['CODITE']) Then
      Begin
        If Not fEmptyStr(FdicFiltro['CODGRU']) Then
          ParamByName('CODGRU').AsString := FdicFiltro['CODGRU'];

        If Not fEmptyStr(dicFiltro['CODFOR']) Then
          ParamByName('CODFOR').AsString := FdicFiltro['CODFOR'];

        If Not fEmptyStr(dicFiltro['CODMAR']) Then
          ParamByName('CODMAR').AsString := FdicFiltro['CODMAR'];

        If (Not fEmptyStr(FdicFiltro['DESINI'])) and (Not fEmptyStr(FdicFiltro['DESFIN'])) Then
        Begin
          ParamByName('MAIOR').AsString   := FdicFiltro['DESINI'];
          ParamByName('DESITE').AsString  := FdicFiltro['DESINI'];
          ParamByName('DESITE1').AsString := FdicFiltro['DESFIN'];
        End;

        If Not fEmptyStr(FdicFiltro['REFERE']) Then
          ParamByName('REFERE').AsString := FdicFiltro['REFERE'];

        If Not fEmptyStr(FdicFiltro['CODUNI']) Then
          ParamByName('CODUNI').AsString := FdicFiltro['CODUNI'];

        If Not fEmptyStr(FdicFiltro['CODSIT']) Then
          ParamByName('SITPRO').AsString := FdicFiltro['CODSIT'];

        If Not fEmptyStr(FdicFiltro['CLACRM']) Then
          ParamByName('CLACRM').AsString := FdicFiltro['CLACRM'];

        If Not fEmptyStr(FdicFiltro['IMPDOC']) Then
        Begin
          ParamByName('NUMDOC').AsString := FdicFiltro['IMPDOC'];
          ParamByName('ESPDOC').AsString := FdicFiltro['ESPDOC'];
          ParamByName('CODEMP').AsString := FdicFiltro['CODEMP'];
        End;

      End;

      If Not fEmptyStr(dicFiltro['IDEPRO']) Then
        ParamByName('IDEPRO').AsString := dicFiltro['IDEPRO'];

      If Not fEmptyStr(dicFiltro['ITETIN']) Then
        ParamByName('ITETIN').AsString := dicFiltro['ITETIN'];

      Open;
    End;

  Finally

  End;


end;

function TCamGer.fGetSQLGiro(strTipo, strCampo : string; dtaInicio: TDate; blnMedia : Boolean; intMeses: Integer = 0) : string;
var
  intIdx : Integer;
  strTag : String;
  dtaData: TDate;
begin
  Result := '(SELECT SUM(';

  strTag  := '';
  dtaData := dtaInicio;
  for intIdx := 1 to intMeses do
  begin
    dtaData := IncMonth(dtaData, -1);
    Result  := Result + strTag + 'IF(GIR_A_N_O_ = '+YearOf(dtaData).ToString()+',IFNULL(GIR_Q'+strTipo+fStrZero(MonthOf(dtaData), 2)+',0),0) ';
    strTag   := ' + ';
  end;

  Result := Result + ')     FROM GIRITE ';
  Result := Result + '     WHERE GIR_CODITE = IT.ITE_CODITE AND ';
  Result := Result + '           GIR_CODEMP = IG.ITE_CODEMP AND (';

  strTag  := '';
  dtaData := dtaInicio;
  for intIdx := 1 to intMeses do
  begin
    dtaData := IncMonth(dtaData, -1);
    Result  := Result + strTag + ' (GIR_A_N_O_ = ' + YearOf(dtaData).ToString() + ' AND GIR_Q' + strTipo + fStrZero(MonthOf(dtaData), 2)  + ' > 0) ';
    strTag   := ' OR ';
  end;

  Result := Result + IIF(blnMedia, '))/'+intMeses.ToString()+' AS ' + strCampo,')) AS ' + strCampo);

end;

{************************************************************************************}
{* VERIFICA SE O CODIGO DO PRODUTO DO CLIENTE PARTICIPA DE                          *}
{* ALGUMA CAMPANHA ATIVA PARA O CLIENTE / REDE DO CLIENTE / CLIENTES DA REDE        *}
{* SE SIM, TRARÁ O CODIGO DO PRODUTO ASSOCIADO                                      *}
{*********************************************************************************KM*}
function TCamGer.fVerificaCodigoProdutoCliente(strCodCli, strCodProdIte, strCodCmg : String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;

begin
  Result := '-1';

  Try
    qryTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CD.CMD_SEQCMG, ';
    strSQL := strSQL + '  CD.CMD_CODITE ';
    strSQL := strSQL + 'FROM CAMGER CG ';
    strSQL := strSQL + ' INNER JOIN CAMDET CD ON CG.CMG_CODCMG = CD.CMD_SEQCMG ';
    strSQL := strSQL + ' INNER JOIN CAMCLI CC ON CG.AUTOINCREM = CC.CCM_CODGER ';
    strSQL := strSQL + 'WHERE ';

    If not fEmptyStr(strCodCli) Then   //POR CLIENTE
      strSQL := strSQL + '  (CC.CCM_CODCLI  = :CODCLI) AND ';

    strSQL := strSQL + '   CD.CMD_CODPCL  = :CODPCL AND ';

    If not fEmptyStr(strCodCmg) Then {Excluir Campanha atual}
      strSQL := strSQL + '  (CD.CMD_SEQCMG <> :CMD_SEQCMG) AND ';

    strSQL := strSQL + '  (CURRENT_DATE >= CG.CMG_DTAINI AND CURRENT_DATE <= CG.CMG_DTAFIN) ';


    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);

    If not fEmptyStr(strCodCli) Then
      qryTmp.ParamByName('CODCLI').AsString     := strCodCli;


    If not fEmptyStr(strCodCmg) Then {Excluir Campanha atual}
      qryTmp.ParamByName('CMD_SEQCMG').AsString := strCodCmg;

    qryTmp.ParamByName('CODPCL').AsString       := strCodProdIte;
    qryTmp.Open;

    If qryTmp.RecordCount > 0 Then
      Result := qryTmp.FieldByName('CMD_CODITE').AsString;

    qryTmp.Close;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

End.

