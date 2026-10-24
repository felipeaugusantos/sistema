{*******************************************}
{* CLASSE PARA BONUS DE VENDAS             *}
{* DATA: 13/11/2007                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untBonGer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  UniClientDataSet, UniDataSetProvider, untFuncoesSimples,
{$ENDIF}
  Uni, Db, Classes;

Type TBonusDet = Record
       strCodBmg: String;
       strCodIte: String;
     End;

Type TBonGen = Class(TComponent)
  Private

    FSeqBmg: String;
    FAutInc: String;
    FOpcao_: String;
    FCodMar: String;
    FDesMar: String;
    FCodGru: String;
    FDesGru: String;
    FCodFor: String;
    FDesFor: String;
    FVlrDes: Double;
    FCodEmp: String;
    FDesEmp: String;

    {*******************************************}
    {* FUNCTIONS                               *}
    {****************************************RL*}
    function getDesEmp: String;
    function getDesFor: String;
    function getDesGru: String;
    function getDesMar: String;
    function getVlrDes: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    procedure setVlrDes(const Value: String);

  Public

    qryBonGen: TUniQuery;
  {$IFNDEF LINUX}
    dtsBonGen: TDataSource;
  {$ENDIF}

    function fGravaBonGen(strAutInc: String;
                          strSeqBmg,
                          strOpcao_: String;
                          strCodGru,
                          strCodFor,
                          strCodMar: String;
                          fltVlrDes: Double;
                          strCodEmp: String): Boolean;

    function fDeletaBonGen(strSeqBmg,
                           strOpcao_,
                           strCodOpc: String
                           {strCodEmp: String}): Boolean;

    function fUsaBonusGenerico: Boolean;
    function fVerificaProdutoBonusGenerico(strCodCli, strCodRed, strCodGru,
     strCodMar, strCodFor: String): Boolean;
    function fRetornaValorBonusGenerico(strCodBmg, strCodGru, strCodMar, strCodFor: String): Double;

    procedure pLimpaDadosGen;
    procedure pAtuDadosGen;
    procedure pCarregaBonGen(strSeqBmg: String);

    property strSeqBmg: String Read FSeqBmg   Write FSeqBmg;
    property strAutInc: String Read FAutInc   Write FAutInc;
    property strOpcao_: String Read FOpcao_   Write FOpcao_;
    property strCodMar: String Read FCodMar   Write FCodMar;
    property strDesMar: String Read getDesMar Write FDesMar;
    property strCodGru: String Read FCodGru   Write FCodGru;
    property strDesGru: String Read getDesGru Write FDesGru;
    property strCodFor: String Read FCodFor   Write FCodFor;
    property strDesFor: String Read getDesFor Write FCodFor;
    property strVlrDes: String Read getVlrDes Write setVlrDes;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

Type TBonDet = Class(TComponent)

  Private

    FSeqBmg: String;
    FAutInc: String;
    FCodIte: String;
    FDesIte: String;
    FVlrDes: Double;
    FCodEmp: String;
    FDesEmp: String;

    {*******************************************}
    {* FUNCTIONS                               *}
    {****************************************RL*}
    function getDesEmp: String;
    function getDesIte: String;
    function getVlrDes: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    procedure setVlrDes(const Value: String);

  Public

    qryBonDet: TUniQuery;
  {$IFNDEF LINUX}
    dtsBonDet: TDataSource;
  {$ENDIF}

    arrBonusDet: Array Of TBonusDet;

    function fGravaBonDet(strAutInc: String;
                          strSeqBmg,
                          strCodIte: String;
                          fltVlrDes: Double;
                          strCodEmp: String): Boolean;

    function fDeletaBonDet(strSeqBmg,
                           strCodIte: String
                           {strCodEmp: String}): Boolean;

    function fRetornaSimilaridade(strCodIte: String): String;
    function fConsisteSimilaridade(strCodIte: String; DataSet: TDataSet): Boolean;
    function fVerificaProdutoBonus(strCodBmg, strCodIte: String): String; Overload;
    function fVerificaProdutoBonus(strCodCli, strCodIte, strCodRed: String): Boolean; Overload;
    function fRetornaValorBonus(strCodBmg, strCodIte: String): Double;

    procedure pLimpaDadosDet;
    procedure pAtuDadosDet;
    procedure pCarregaBonDet(strSeqBmg: String; intFiltro: Integer = 1);
    procedure pCarregaArrayBonusDet;
    //procedure pCarregaArrayBonusDet(strSeqBmg, strCodIte: String);



    property strSeqBmg: String Read FSeqBmg   Write FSeqBmg;
    property strAutInc: String Read FAutInc   Write FAutInc;
    property strCodIte: String Read FCodIte   Write FCodIte;
    property strDesIte: String Read getDesIte Write FDesIte;
    property strVlrDes: String Read getVlrDes Write setVlrDes;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

Type TBonGer = Class(TComponent)
  Private

    FCodBmg: String;
    FDesBmg: String;
    FCodRed: String;
    FDesRed: String;
    FCodCli: String;
    FDesCli: String;
    FObs_01: String;
    FObs_02: String;
    FObs_03: String;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FCodEmp: String;
    FDesEmp: String;
    FAutInc: String;

    {*******************************************}
    {* FUNCOES                                 *}
    {****************************************RL*}
    function getDesCli: String;
    function getDesEmp: String;
    function getDesRed: String;
    //function getDtaEnt: String;
    function getDtaFin: String;
    function getDtaIni: String;

    {*******************************************}
    {* PROCEDURES                              *}
    {****************************************RL*}
    //procedure setDtaEnt(const Value: String);
    procedure setDtaFin(const Value: String);
    procedure setDtaIni(const Value: String);

  Public

    blnComBonus: Boolean;

    qryBonGer: TUniQuery;
    cdsBonGer: TUniClientDataSet;
    dspBonGer: TUniDataSetProvider;

  {$IFNDEF LINUX}
    dtsBonGer: TDataSource;
  {$ENDIF}

    objBonDet: TBonDet;
    objBonGen: TBonGen;

    function fGravaBonGer(Var strAutInc: String;
                          strCodBmg,
                          strDesBmg,
                          strCodRed,
                          strCodCli,
                          strObs_01,
                          strObs_02,
                          strObs_03,
                          strCodEmp: String;
                          dtaDtaIni,
                          dtaDtaFin: TDateTime): Boolean;

    function fVerificaClienteComBonus(strCodCli: String): Boolean;
    function fRetornaRedeCliente(strCodCli: String): String;
    function fExisteBonus(dtaDtaAtu: TDatetime): Boolean;

    procedure pLimpaDadosGer;
    procedure pAtuDadosGer;
    procedure pCarregaBonGer(strCodBmg: String);
    procedure pDeletaBonus(strCodBmg: String);

    property strCodBmg: String Read FCodBmg   Write FCodBmg;
    property strDesBmg: String Read FDesBmg   Write FDesBmg;
    property strCodRed: String Read FCodRed   Write FCodRed;
    property strDesRed: String Read getDesRed Write FDesRed;
    property strCodCli: String Read FCodCli   Write FCodCli;
    property strDesCli: String Read getDesCli Write FDesCli;
    property strObs_01: String Read FObs_01   Write FObs_01;
    property strObs_02: String Read FObs_02   Write FObs_02;
    property strObs_03: String Read FObs_03   Write FObs_03;
    property strDtaIni: String Read getDtaIni Write setDtaIni;
    property strDtaFin: String Read getDtaFin Write setDtaFin;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strDesEmp: String Read getDesEmp Write FDesEmp;
    property strAutInc: String Read FAutInc   Write FAutInc;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

implementation

uses StrUtils, SysUtils, Variants;

{ TBonDet }

{*******************************************}
{* CREATE                                  *}
{****************************************RL*}
constructor TBonDet.Create(Owner: TComponent);
begin

  inherited Create(Owner);
  
  Try
    qryBonDet := fCriaQuery;
  {$IFNDEF LINUX}
    dtsBonDet := fCriaDataSource(qryBonDet);
  {$ENDIF}
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*******************************************}
{* DESTROY                                 *}
{****************************************RL*}
destructor TBonDet.Destroy;
begin
 {$IFNDEF LINUX}
  FreeAndNil(dtsBonDet);
 {$ENDIF}

  FreeAndNil(qryBonDet);

  arrBonusDet := Nil;

  inherited;

end;

{*******************************************}
{* PEGA DESCRIÇÃO DA EMPRESA               *}
{****************************************RL*}
function TBonDet.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

{*******************************************}
{* PEGA DESCRIÇÃO DO PRODUTO               *}
{****************************************RL*}
function TBonDet.getDesIte: String;
begin
  Result := fRetNomProduto(FCodIte);
end;

{*******************************************}
{* FORMATA DESCONTO DO PRODUTO             *}
{****************************************RL*}
function TBonDet.getVlrDes: String;
begin
  Result := FloatToStrF(FVlrDes, ffFixed, 12, 4);
end;

{*******************************************}
{* ATUALIZA DADOS DAS VARIÁVEIS            *}
{****************************************RL*}
procedure TBonDet.pAtuDadosDet;
begin

  Try

    If (Not qryBonDet.Active) Or (qryBonDet.IsEmpty) Then
    Begin
      pLimpaDadosDet;
    End;

    With qryBonDet Do
    Begin

      FSeqBmg := FieldByName('BMD_SEQBMG').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FCodIte := FieldByName('BMD_CODITE').AsString;
      FVlrDes := FieldByName('BMD_VLRDES').AsFloat;
      FCodEmp := FieldByName('BMD_CODEMP').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{*******************************************}
{* GRAVA DADOS NA BONDET                   *}
{****************************************RL*}
function TBonDet.fGravaBonDet(strAutInc: String; strSeqBmg,
  strCodIte: String; fltVlrDes: Double; strCodEmp: String): Boolean;
begin

  Try

    With qryBonDet Do
    Begin

      If Not Active Then
      Begin
        pCarregaBonDet(strSeqBmg);
        Open;
      End;

      First;

      If Not Self.qryBonDet.Locate('AUTOINCREM;BMD_SEQBMG;BMD_CODITE', VarArrayOf([strAutInc, strSeqBmg, strCodIte]), []) Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('BONDET', strCodEmp);

        FieldByName('BMD_SEQBMG').AsString := strSeqBmg;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('BMD_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      FieldByName('BMD_CODITE').AsString := strCodIte;
      FieldByName('BMD_VLRDES').AsFloat  := fltVlrDes;

      Post;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      qryBonDet.Cancel;
      Raise Exception.Create(E.Message);
     End;
  End;

end;

{*******************************************}
{* LIMPA DADOS DAS VARIÁVEIS               *}
{****************************************RL*}
procedure TBonDet.pLimpaDadosDet;
begin

  FSeqBmg := '';
  FAutInc := '';
  FCodIte := '';
  FDesIte := '' ;
  FVlrDes := 0;
  FCodEmp := '';
  FDesEmp := '';

end;

procedure TBonDet.pCarregaBonDet(strSeqBmg: String; intFiltro: Integer = 1);
  Var strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMD_SEQBMG, ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  BMD_CODITE, ';
  strSQL := strSQL + '  BMD_VLRDES, ';
  strSQL := strSQL + '  BMD_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONDET ';

  If intFiltro = 1 Then
  Begin

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BMD_SEQBMG = :SEQBMG ';

  End;

  With qryBonDet Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If intFiltro = 1 Then
        ParamByName('SEQBMG').AsString := strSeqBmg;

      Open;

      If (Not Active) Or (IsEmpty) Then
        pLimpaDadosDet
      Else
      Begin

        If intFiltro = 1 Then
          pAtuDadosDet;

        {pCarregaArrayBonusDet(FieldByName('BMD_SEQBMG').AsString,
                              FieldByName('BMD_CODITE').AsString);}

        pCarregaArrayBonusDet;
        First;

      End;

    End;

end;

//procedure TBonDet.pCarregaArrayBonusDet(strSeqBmg, strCodIte: String);
procedure TBonDet.pCarregaArrayBonusDet;
  Var
    i: Integer;
begin

  i := 0;
  SetLength(ArrBonusDet, qryBonDet.RecordCount);

  With qryBonDet Do
    While Not Eof Do
    Begin

      arrBonusDet[i].strCodBmg := FieldByName('BMD_SEQBMG').AsString;
      arrBonusDet[i].strCodIte := FieldByName('BMD_CODITE').AsString;
      Next;

      Inc(i);

    End;

end;

{*******************************************}
{* SETA DESCONTO DO PRODUTO                *}
{****************************************RL*}
procedure TBonDet.setVlrDes(const Value: String);
begin
  FVlrDes := fStrToFloat(Value);
end;

{ TBonGer }

{*******************************************}
{* CREATE                                  *}
{****************************************RL*}
constructor TBonGer.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  Try

    {**********************************************}
    {* CLIENTDATASET E DATASETPROVIDER UTILIZADOS *}
    {* APENAS PARA GERA O RELATÓRIO               *}
    {*******************************************RL*}

    qryBonGer := fCriaQuery(Self);
    dspBonGer := TUniDataSetProvider.Create(Self);
    cdsBonGer := TUniClientDataSet.Create(Self);
  {$IFNDEF LINUX}
    dtsBonGer := fCriaDataSource(qryBonGer);
  {$ENDIF}

    dspBonGer.DataSet      := qryBonGer;
    dspBonGer.Name         := 'dspBonGer';
    cdsBonGer.ProviderName := 'dspBonGer';

    objBonDet := TBonDet.Create(Self);
    objBonGen := TBonGen.Create(Self); 

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*******************************************}
{* DESTROY                                 *}
{****************************************RL*}
destructor TBonGer.Destroy;
begin

  cdsBonGer.Close;

  inherited;

end;

{*******************************************}
{* GRAVA BONGER                            *}
{****************************************RL*}
function TBonGer.fGravaBonGer(Var strAutInc: String;
  strCodBmg, strDesBmg, strCodRed, strCodCli, strObs_01, strObs_02,
  strObs_03, strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime): Boolean;
begin

  Result := True;

  Try

    With qryBonGer Do
    Begin

      If Not Active Then
      Begin
        pCarregaBonGer(strCodBmg);
        Open;
      End;

      If fEmptyStr(strCodBmg) Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('BONGER', strCodEmp);

        FieldByName('BMG_CODBMG').AsString := fAtualizaProCod('BONGER', 'BMG_CODBMG');
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('BMG_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      FieldByName('BMG_DESBMG').AsString   := strDesBmg;
      FieldByName('BMG_CODRED').Value      := IIF(fEmptyStr(strCodRed), Null, strCodRed);
      FieldByName('BMG_CODCLI').Value      := IIF(fEmptyStr(strCodCli), Null, strCodCli);
      FieldByName('BMG_OBS_01').AsString   := strObs_01;
      FieldByName('BMG_OBS_02').AsString   := strObs_02;
      FieldByName('BMG_OBS_03').AsString   := strObs_03;
      FieldByName('BMG_DTAINI').AsDateTime := dtaDtaIni;
      FieldByName('BMG_DTAFIN').AsDateTime := dtaDtaFin;

      Post;

    End;

    pAtuDadosGer;

  Except
    On E: Exception Do
    Begin
      qryBonGer.Cancel;
      pMensagensErro(E.Message, '[TBonGer.fGravaBonGer]');
      Result := False;
    End;
  End;

end;

(*{*******************************************}
{* RETORNA O NOME DA CAMPANHA              *}
{****************************************RL*}
function TBonGer.fRetornaNomeCampanha(strCodCmg: String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := '';

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CMG_DESCMG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CMG_CODCMG = :CODCMG ';

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

end;*)

{******************************************************}
{* VERIFICA SE O CLIENTE POSSUI ALGUM BÔNUS           *}
{***************************************************RL*}
function TBonGer.fVerificaClienteComBonus(strCodCli: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  Result := False;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMG_CODCLI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMG_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If Not IsEmpty Then
      Begin

        Result := True;
        Close;
        FreeAndNil(qryTmp);
        Exit;

      End;

      Close;

    End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_CODRED ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER, ';
  strSQL := strSQL + '  CADCLI, ';
  strSQL := strSQL + '  CADRED ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CLI_CODRED = RED_CODRED AND ';
  strSQL := strSQL + '  BMG_CODRED = RED_CODRED AND ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If Not IsEmpty Then
      Begin

        Result := True;
        Exit;

      End;

      Close;

    End;

  FreeAndNil(qryTmp);

End;

{******************************************************}
{* RETORNA O CÓDIGO DA REDE QUE O CLIENTE PARTICIPA   *}
{***************************************************RL*}
function TBonGer.fRetornaRedeCliente(strCodCli: String): String;
begin
  Result := fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
end;

{*******************************************}
{* PEGA NOME DO CLIENTE                    *}
{****************************************RL*}
function TBonGer.getDesCli: String;
begin
  Result := fRetNomCliente(FCodCli);
end;

{*******************************************}
{* PEGA NOME DA EMPRESA                    *}
{****************************************RL*}
function TBonGer.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

{*******************************************}
{* PEGA NOME DA REDE DE LOJAS              *}
{****************************************RL*}
function TBonGer.getDesRed: String;
begin
  Result := fRetNomeRedeLoja(FCodRed);
end;

{*******************************************}
{* FORMATA DTAFIN                          *}
{****************************************RL*}
function TBonGer.getDtaFin: String;
begin
  Result := IfThen(FDtaFin = 0, '', FormatDateTime('dd/mm/yyyy',FDtaFin));
end;

{*******************************************}
{* FORMATA DTAINI                          *}
{****************************************RL*}
function TBonGer.getDtaIni: String;
begin
  Result := IfThen(FDtaIni = 0, '', FormatDateTime('dd/mm/yyyy',FDtaIni));
end;

{*******************************************}
{* ATUALIZA DADOS DAS VARIÁVEIS            *}
{****************************************RL*}
procedure TBonGer.pAtuDadosGer;
begin

  Try

    If (Not qryBonGer.Active) Or (qryBonGer.IsEmpty) Then
    Begin
      pLimpaDadosGer;
      Exit;
    End;

    With qryBonGer Do
    Begin

      FCodBmg := FieldByName('BMG_CODBMG').AsString;
      FDesBmg := FieldByName('BMG_DESBMG').AsString;
      FCodRed := FieldByName('BMG_CODRED').AsString;
      FCodCli := FieldByName('BMG_CODCLI').AsString;
      FObs_01 := FieldByName('BMG_OBS_01').AsString;
      FObs_02 := FieldByName('BMG_OBS_02').AsString;
      FObs_03 := FieldByName('BMG_OBS_03').AsString;
      FDtaIni := FieldByName('BMG_DTAINI').AsDateTime;
      FDtaFin := FieldByName('BMG_DTAFIN').AsDateTime;
      FCodEmp := FieldByName('BMG_CODEMP').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{*******************************************}
{* CARREGA DADOS DA TABELA BONGER          *}
{****************************************RL*}
procedure TBonGer.pCarregaBonGer(strCodBmg: String);
  Var strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMG_CODBMG, ';
  strSQL := strSQL + '  BMG_DESBMG, ';
  strSQL := strSQL + '  BMG_CODRED, ';
  strSQL := strSQL + '  BMG_CODCLI, ';
  strSQL := strSQL + '  BMG_OBS_01, ';
  strSQL := strSQL + '  BMG_OBS_02, ';
  strSQL := strSQL + '  BMG_OBS_03, ';
  strSQL := strSQL + '  BMG_DTAINI, ';
  strSQL := strSQL + '  BMG_DTAFIN, ';
  strSQL := strSQL + '  BMG_CODEMP, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMG_CODBMG = :CODBMG ';

  With qryBonGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODBMG').AsString := strCodBmg;

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

        objBonDet.pCarregaBonDet(strCodBmg);
        objBonGen.pCarregaBonGen(strCodBmg);

      End;

     End;

end;

{*******************************************}
{* EXCLUI BÔNUS                            *}
{****************************************RL*}
procedure TBonGer.pDeletaBonus(strCodBmg: String);
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  qryTmp := fCriaQuery;

  Try
    Try

      fStartTransaction;

      {*******************************************}
      {* BONGEN                                  *}
      {****************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  BONGEN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GEN_SEQBMG = :CODBMG';

      With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBMG').AsString := strCodBmg;
          ExecSQL;
        End;

      {*******************************************}
      {*  BONDET                                 *}
      {****************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  BONDET ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BMD_SEQBMG = :CODBMG';

      With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBMG').AsString := strCodBmg;
          ExecSQL;
        End;

      {*******************************************}
      {* BONGER                                  *}
      {****************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  BONGER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BMG_CODBMG = :CODBMG';

      With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBMG').AsString := strCodBmg;
          ExecSQL;
        End;

      fCommit;

    Except
      On E: Exception Do
      Begin
       pMensagensErro(E.Message,'[TBonGer.pDeletaBonus]');
       fRollBack;
      End;
    End;

  Finally;
    FreeAndNil(qryTmp);
  End;

end;

{*************************************************************}
{* VERIFICA SE EXISTE BÔNUS DENTRO DE UM DETERMINADO PERÍODO *}
{**********************************************************RL*}
function TBonGer.fExisteBonus(dtaDtaAtu: TDatetime): Boolean;
 Var
   qryTmp: TUniQuery;
   strSQL: String;
begin

  Result := False;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

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
procedure TBonGer.pLimpaDadosGer;
begin

  FCodBmg := '';
  FDesBmg := '';
  FCodRed := '';
  FCodCli := '';
  FObs_01 := '';
  FObs_02 := '';
  FObs_03 := '';
  FDtaIni := 0;
  FDtaFin := 0;
  FCodEmp := '';
  FAutInc := '';

end;

{*******************************************}
{* SETA DTAFIN                             *}
{****************************************RL*}
procedure TBonGer.setDtaFin(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDtaFin := StrToDate(Value)
  Else
    Raise Exception.Create('A data de término do bônus deve ser preenchida !');

end;

{*******************************************}
{* SETA DTAINI                             *}
{****************************************RL*}
procedure TBonGer.setDtaIni(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDtaIni := StrToDate(Value)
  Else
    Raise Exception.Create('A data de início do bônus deve ser preenchida !');

end;

{ TBonGen }

constructor TBonGen.Create(Owner: TComponent);
begin

  inherited Create(Owner);
  Try

    qryBonGen := fCriaQuery;
  {$IFNDEF LINUX}
    dtsBonGen := fCriaDataSource(qryBonGen);
  {$ENDIF}

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

destructor TBonGen.Destroy;
begin
  {$IFNDEF LINUX}
  FreeAndNil(dtsBonGen);
  {$ENDIF}
  FreeAndNil(qryBonGen);
  inherited;
end;

function TBonGen.fDeletaBonGen(strSeqBmg, strOpcao_,
  strCodOpc{, strCodEmp}: String): Boolean;
  Var qryTmpDel: TUniQuery;
      strSQL   : String;
begin

  Result := True;

  qryTmpDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  BONGEN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GEN_SEQBMG = :SEQBMG AND ';
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

        ParamByName('SEQBMG').AsString := strSeqBmg;
        ParamByName('OPCAO').AsString  := strOpcao_;
        //ParamByName('CODEMP').AsString := strCodEmp;

        ExecSQL;

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

function TBonGen.fGravaBonGen(strAutInc: String; strSeqBmg, strOpcao_,
  strCodGru, strCodFor, strCodMar: String; fltVlrDes: Double;
  strCodEmp: String): Boolean;
  Var
    strChave: String;
    strValor: String;
begin

  Result := True;

  Try

    With qryBonGen Do
    Begin

      If Not Active Then
      Begin
        pCarregaBonGen(strSeqBmg);
        Open;
      End;

      First;

      strChave := '';
      strValor := '';

      If strOpcao_ = '1' Then
      Begin

        strChave := 'AUTOINCREM;GEN_CODGRU;GEN_SEQBMG;GEN_OPCAO_';
        strValor := strCodGru;

      End
      Else If strOpcao_ = '2' Then
      Begin

        strChave := 'AUTOINCREM;GEN_CODFOR;GEN_SEQBMG;GEN_OPCAO_';
        strValor := strCodFor;

      End
      Else
      Begin

        strChave := 'AUTOINCREM;GEN_CODMAR;GEN_SEQBMG;GEN_OPCAO_';
        strValor := strCodMar;

      End;


      If Not Self.qryBonGen.Locate(strChave, VarArrayOf([strAutInc, strValor, Self.strSeqBmg, strOpcao_]), []) Then
      Begin
        Insert;

        strAutInc := fRetAutoIncrem('BONGEN', strCodEmp);

        FieldByName('GEN_SEQBMG').AsString := strSeqBmg;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('GEN_OPCAO_').AsString := strOpcao_;
        FieldByName('GEN_CODEMP').AsString := strCodEmp;

      End
      Else
        Edit;

      FieldByName('GEN_CODGRU').Value := IIF(strCodGru = '', Null, strCodGru);
      FieldByName('GEN_CODFOR').Value := IIF(strCodFor = '', Null, strCodFor);
      FieldByName('GEN_CODMAR').Value := IIF(strCodMar = '', Null, strCodMar);
      FieldByName('GEN_VLRDES').AsFloat  := fltVlrDes;

      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryBonGen.Cancel;
      pMensagensErro(E.Message, '[TBonGen.fGravaBonGen]');
      Result := False;
    End;
  End;

end;

{********************************************}
{* VERIFICA SE A TABELA BONGEN POSSUI DADOS *}
{*****************************************RL*}
function TBonGen.fUsaBonusGenerico: Boolean;
 Var
   qryTmpBonGen: TUniQuery;
   strSQL      : String;
begin

  Result := False;

  qryTmpBonGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGEN';

  With qryTmpBonGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;

    End;

  FreeAndNil(qryTmpBonGen);

end;

{************************************************}
{* VERIFICA SE O GRUPO, A MARCA OU O FORNEC.    *}
{* DO PRODUTO PARTICIPA DE ALGUM BÕNUS GENÉRICO *}
{*********************************************RL*}
function TBonGen.fVerificaProdutoBonusGenerico(strCodCli, strCodRed, strCodGru,
 strCodMar, strCodFor: String): Boolean;
  Var
    qryTmp   : TUniQuery;
    strSQL   : String;
    strSeqBmg: String;
begin
  Result := False;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GEN_SEQBMG AS "SEQBMG" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER, ';
  strSQL := strSQL + '  BONGEN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (BMG_CODCLI = :CODCLI OR BMG_CODRED = :CODRED) AND ';
  strSQL := strSQL + '  ((GEN_CODGRU = :CODGRU) OR (GEN_CODMAR = :CODMAR) OR (GEN_CODFOR = :CODFOR)) AND ';
  strSQL := strSQL + '  GEN_SEQBMG = BMG_CODBMG AND ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODRED').AsString   := strCodRed;
      ParamByName('CODGRU').AsString   := strCodGru;
      ParamByName('CODMAR').AsString   := strCodMar;
      ParamByName('CODFOR').AsString   := strCodFor;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If RecordCount > 0 Then
      Begin

        While Not Eof Do
        Begin
          strSeqBmg := strSeqBmg + QuotedStr(FieldByName('SEQBMG').AsString) + ',';
          Next;
        End;

        strSeqBmg := Copy(strSeqBmg, 1, Length(strSeqBmg) - 1);

        Result  := True;
        FVlrDes := fRetornaValorBonusGenerico(strSeqBmg, strCodGru, strCodMar, strCodFor);
       End;

      Close;

    End;

  FreeAndNil(qryTmp);

end;

{*******************************************}
{* RETORNA VALOR DO BÔNUS GENÉRICO         *}
{****************************************RL*}
function TBonGen.fRetornaValorBonusGenerico(strCodBmg, strCodGru,
  strCodMar, strCodFor: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := 0;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(GEN_VLRDES) AS "VLRDES" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGEN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GEN_SEQBMG IN (' + strCodBmg + ') AND ';
  strSQL := strSQL + '  ((GEN_CODGRU = :CODGRU) OR (GEN_CODMAR = :CODMAR) OR (GEN_CODFOR = :CODFOR)) ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODGRU').AsString := strCodGru;
      ParamByName('CODMAR').AsString := strCodMar;
      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If RecordCount > 0 Then
        Result := fStrToFloat(FloatToStrF(FieldByName('VLRDES').AsFloat, ffFixed, 12, 2));

      Close;

    End;

  FreeAndNil(qryTmp);

end;


function TBonGen.getDesEmp: String;
begin
  Result := fRetNomeEmpresa(FCodEmp);
end;

function TBonGen.getDesFor: String;
begin
  Result := fRetNomFornecedor(FCodFor);
end;

function TBonGen.getDesGru: String;
begin
  Result := fRetNomeLinhaGrupo(FCodGru);
end;

function TBonGen.getDesMar: String;
begin
  Result := fRetNomMarca(FCodMar);
end;

function TBonGen.getVlrDes: String;
begin
  Result := FloatToStrF(FVlrDes, ffFixed, 12, 4);
end;

procedure TBonGen.pAtuDadosGen;
begin

  Try

    If (Not qryBonGen.Active) Or (qryBonGen.IsEmpty) Then
    Begin
      pLimpaDadosGen;
    End;

    With qryBonGen Do
    Begin

      FSeqBmg := FieldByName('GEN_SEQBMG').AsString;
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FOpcao_ := FieldByName('GEN_OPCAO_').AsString;
      FCodMar := FieldByName('GEN_CODMAR').AsString;
      FCodGru := FieldByName('GEN_CODGRU').AsString;
      FCodFor := FieldByName('GEN_CODFOR').AsString;
      FVlrDes := FieldByName('GEN_VLRDES').AsFloat;
      FCodEmp := FieldByName('GEN_CODEMP').AsString;

    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TBonGen.pCarregaBonGen(strSeqBmg: String);
  Var
    strSQL: String;
begin

  If fEmptyStr(strSeqBmg) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GEN_SEQBMG, ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  GEN_OPCAO_, ';
  strSQL := strSQL + '  GEN_CODMAR, ';
  strSQL := strSQL + '  GEN_CODGRU, ';
  strSQL := strSQL + '  GEN_CODFOR, ';
  strSQL := strSQL + '  GEN_VLRDES, ';
  strSQL := strSQL + '  GEN_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGEN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GEN_SEQBMG = :SEQBMG ';

  With qryBonGen Do
  Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('SEQBMG').AsString := strSeqBmg;

      Open;

      If (Not Active) Or (IsEmpty) Then
        pLimpaDadosGen
      Else
        pAtuDadosGen;
  End;

end;

procedure TBonGen.pLimpaDadosGen;
begin

  FSeqBmg := '';
  FAutInc := '';
  FOpcao_ := '';
  FCodMar := '';
  FDesMar := '';
  FCodGru := '';
  FDesGru := '';
  FCodFor := '';
  FDesFor := '';
  FVlrDes := 0;
  FCodEmp := '';
  FDesEmp := '';

end;

{*******************************************}
{* SETA DESCONTO DO BÔNUS                  *}
{****************************************RL*}
procedure TBonGen.setVlrDes(const Value: String);
begin
  FVlrDes := fStrToFloat(Value);
end;

{*******************************************}
{* DELETA PRODUTO INSERIDO NA CAMPANHA     *}
{****************************************RL*}
function TBonDet.fDeletaBonDet(strSeqbmg, strCodIte: String {strCodEmp: String}): Boolean;
  Var qryTmpDel: TUniQuery;
      strSQL   : String;
begin

  Result := True;

  qryTmpDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  BONDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMD_SEQBMG = :SEQBMG AND ';
  strSQL := strSQL + '  BMD_CODITE IN (' + strCodIte + ') ';
  //strSQL := strSQL + '  BMD_CODEMP = :CODEMP';

  Try

    With qryTmpDel Do
      Try

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('SEQBMG').AsString := strSeqBmg;
        //ParamByName('CODEMP').AsString := strCodEmp;

        ExecSQL;

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
function TBonDet.fRetornaSimilaridade(strCodIte: String): String;
begin
  Result := '';

  If (fEmptyStr(strCodIte)) Then
    Exit;

  Result := fCampoTabela('ITE_CODSIM', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

{**************************************}
{* VERIFICA SE O PRODUTO PARTICIPA DE *}
{* UM DETERMINADO BÕNUS               *}
{***********************************RL*}
function TBonDet.fVerificaProdutoBonus(strCodBmg,
  strCodIte: String): String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;

begin

  Result := '-1';

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMD_SEQBMG, ';
  strSQL := strSQL + '  BMD_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER, ';
  strSQL := strSQL + '  BONDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMD_SEQBMG = :CODBMG AND ';
  strSQL := strSQL + '  BMD_CODITE = :CODITE AND ';
  strSQL := strSQL + '  BMG_CODBMG = BMD_SEQBMG AND ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';


  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODBMG').AsString   := strCodBmg;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If RecordCount > 0 Then
        Result := FieldByName('BMD_SEQBMG').AsString;

      Close;

    End;

  FreeAndNil(qryTmp);

end;

{***********************************************}
{* VERIFICA SE O PRODUTO PARTICIPA DIRETAMENTE *}
{* DE UM BÕNUS, OU PARTICIPA POR SIMILARIDADE  *}
{********************************************RL*}
function TBonDet.fVerificaProdutoBonus(strCodCli, strCodIte, 
 strCodRed: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := False;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMD_SEQBMG AS "SEQBMG", ';
  strSQL := strSQL + '  BMD_CODITE AS "CODITE" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONGER, ';
  strSQL := strSQL + '  BONDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMD_CODITE = :CODITE AND ';
  strSQL := strSQL + '  BMG_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  BMD_SEQBMG = BMG_CODBMG AND ';
  strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

  With qryTmp Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODITE').AsString   := strCodIte;
    ParamByName('CODCLI').AsString   := strCodCli;
    ParamByName('DTAATU').AsDateTime := VS_Date;

    Open;

    If RecordCount > 0 Then
      Result := True
    Else If Not fEmptyStr(strCodRed) Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BMD_SEQBMG AS "SEQBMG", ';
      strSQL := strSQL + '  BMD_CODITE AS "CODITE" ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  BONGER, ';
      strSQL := strSQL + '  BONDET, ';
      strSQL := strSQL + '  CADRED ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BMG_CODRED = :CODRED AND ';
      strSQL := strSQL + '  BMD_CODITE = :CODITE AND ';
      strSQL := strSQL + '  BMD_SEQBMG = BMG_CODBMG AND ';
      strSQL := strSQL + '  BMG_CODRED = RED_CODRED AND ';
      strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('CODRED').AsString   := strCodRed;
      ParamByName('DTAATU').AsDateTime := VS_Date;

      Open;

      If RecordCount > 0 Then
        Result := True

      Else If fCfgSis('SIMCAM', varBoolean) Then
      Begin

        If (Not fEmptyStr(fRetornaSimilaridade(strCodIte))) Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  BMD_SEQBMG AS "SEQBMG", ';
          strSQL := strSQL + '  BMD_CODITE AS "CODITE" ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  BONGER, ';
          strSQL := strSQL + '  BONDET ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  BMD_CODITE IN (SELECT ITE_CODITE FROM CADITE WHERE ITE_CODSIM = :CODSIM) AND ';
          strSQL := strSQL + '  (BMG_CODCLI = :CODCLI OR BMG_CODRED = :CODRED) AND ';
          strSQL := strSQL + '  BMG_CODBMG = BMD_SEQBMG AND ';
          strSQL := strSQL + '  (:DTAATU >= BMG_DTAINI AND :DTAATU <= BMG_DTAFIN) ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODSIM').AsString := fRetornaSimilaridade(strCodIte);
          //ParamByName('CODITE').AsString   := strCodIte;
          ParamByName('CODCLI').AsString   := strCodCli;
          ParamByName('CODRED').AsString   := strCodRed;
          ParamByName('DTAATU').AsDateTime := VS_Date;

          Open;

          If RecordCount > 0 Then
            Result := True;
        End;

      End;
      
    End;

    If RecordCount > 0 Then
      FVlrDes :=  fRetornaValorBonus(FieldByName('SEQBMG').AsString, FieldByName('CODITE').AsString);

    Close;

  End;

  FreeAndNil(qryTmp);

end;

{*******************************************}
{* RETORNA VALOR DO BÔNUS                  *}
{****************************************RL*}
function TBonDet.fRetornaValorBonus(strCodBmg, strCodIte: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := 0;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BMD_VLRDES AS "VLRDES" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BONDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BMD_SEQBMG = :CODBMG AND ';
  strSQL := strSQL + '  BMD_CODITE = :CODITE ';

  With qryTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODBMG').AsString := strCodBmg;
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      If RecordCount > 0 Then
        Result := fStrToFloat(FloatToStrF(FieldByName('VLRDES').AsFloat, ffFixed, 12, 2));

      Close;

    End;

  FreeAndNil(qryTmp);

end;


{*******************************************}
{* VERIFICA SE OS PRODUTOS SÃO SIMILARES   *}
{****************************************RL*}
function TBonDet.fConsisteSimilaridade(strCodIte: String; DataSet: TDataSet): Boolean;
  Var
    BookMark : TBookMark;
    strCodSim: String;
begin

  Result := False;

  BookMark  := DataSet.GetBookmark;
  strCodSim := fRetornaSimilaridade(strCodIte);

  With DataSet Do
  Begin

    DisableControls;
    First;

    While Not Eof do
    Begin

      If (strCodSim = FieldByName('ITESIM').AsString) And (strCodIte <> FieldByName('CODITE').AsString) And
        (Not fEmptyStr(FieldByName('ITESIM').AsString)) Then
      Begin

        fMensagem('', 'Não é permitido adicionar o produto ' + strCodIte + '.' + #13 +
                      'Ele é um produto similar a outro produto já adicionado no Bônus!', ['&Ok']);
        Result := True;
        Break;

      End;

      Next;

    End;

  End;

  DataSet.GotoBookmark(BookMark);
  DataSet.FreeBookmark(BookMark);
  DataSet.EnableControls;

end;

End.

