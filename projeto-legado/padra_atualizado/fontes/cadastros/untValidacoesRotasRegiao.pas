unit untValidacoesRotasRegiao;

interface

uses Classes, StrUtils, SysUtils, Uni, DBClient, Provider, DB, Forms, ComCtrls,
     Controls, untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untLiberacao, untMsgLiberacao;

Type
  TRotReg = Class(TComponent)
  Private
    FCodRot: String;
    FPesBru: Double;
    FTotPro: Double;
    FCodVen: String;
    FCodDig: String;
    FNumOrc: String;
    FSeqFgo: String;
    FCodCli: String;
    FPesMax: Double;
    FTotPed: Double;
    FEspDoc: String;
    FdtaDtaEnt: TDateTime;
    objLiberacao : TLiberacao;

    procedure pRetornaValoresPadroes(Var horHorMax: TTime;
                                     Var horHorCar: TTime;
                                     Var strCodReg: String;
                                     Var dtaDatMax: TDate);

    function fValidacao(strDirAce, strSenLib, strMenSen: String): Boolean;
    function fVeiculoCapacidade: Double;
    function fRetornaPesoTotalRota(aStrSeqFgo: String; aStrCndCon: String='<>'): Double;
    //function fRetornaValorTotalRota: Double;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property strCodRot: String Read FCodRot Write FCodRot;
    property fltPesBru: Double Read FPesBru Write FPesBru;
    property fltTotPro: Double Read FTotPro Write FTotPro;
    property strCodVen: String Read FCodVen Write FCodVen;
    property strCodDig: String Read FCodDig Write FCodDig;
    property strNumOrc: String Read FNumOrc Write FNumOrc;
    property strSeqFgo: String Read FSeqFgo Write FSeqFgo;
    property strCodCli: String Read FCodCli Write FCodCli;
    property fltPesMax: Double Read FPesMax Write FPesMax;
    property fltTotPed: Double Read FTotPed Write FTotPed;
    property dtaDtaEnt: TDateTime read FdtaDtaEnt write FdtaDtaEnt;
    property strEspDoc: String Read FEspDoc Write FEspDoc;

    function fExisteRota: Boolean;
    function fIniciaValidacoes: Boolean;
    function fRetTranspRota: String;
    function fAlteraStatusRota: Boolean;
    function fLiberaImpSeparacao(blnLibSep: Boolean): Boolean;
    class function fRetornaValorContabilDosPedidosNaRota(strCodRot: string): double;
    class procedure pValorContabilPorCodRot(var qryValRot: TUniQuery; const strLisCodRot: String);
  End;

implementation
uses
    untFuncFat;

{ TRotReg }

constructor TRotReg.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  objLiberacao := Tliberacao.Create;

end;

destructor TRotReg.Destroy;
begin
  if Assigned(objLiberacao) then
    freeandnil(objLiberacao);
  inherited Destroy;
end;

function fRetSQLBase(const FLisCodRot: String=''): String;
Begin
  Result := ' SELECT EXTGOR.FGO_CODROT AS CODROT, SUM(FGO_VLRCON) AS VLRCON ' +
            '   FROM FATGOR '+
            ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
            ' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
            ' INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
            ' WHERE FATGOR.FGO_ESPDOC = "PD" '+
            '   AND EXTGOR.FGO_CODROT '+IIF(FLisCodRot='',' = :CODROT ',' IN ('+FLisCodRot+') ')+
            '   AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((IFNULL(FGO_MOTBAI, "") <> "") AND (IFNULL(FDO_NUMFAT, "") <> ""))) '+
            ' GROUP BY EXTGOR.FGO_CODROT ';
End;

function TRotReg.fAlteraStatusRota: Boolean;
  function fRetUpdateSQL: String;
  Begin
    Result := '';
    Result := Result + 'UPDATE ENTREG               ';
    Result := Result + '   SET ENT_STATUS = :STATUS ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT ';
  End;

  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + 'SELECT ENT_STATUS           ';
    Result := Result + '  FROM ENTREG               ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT ';
  End;
var
  qryCons   : TUniQuery;
  strStatus : String;
begin
  Result := True;
  Try
    qryCons := fCriaQuery(Nil);
    Try
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('CODROT').AsString := FCodRot;
        Open;

        If Not IsEmpty Then
        Begin
          strStatus := FieldByName('ENT_STATUS').AsString;

          Close;
          SQL.Clear;
          SQL.Add(fRetUpdateSQL);
          ParamByName('STATUS').AsString := IIF(strStatus = 'A', 'B', 'A');
          ParamByName('CODROT').AsString := FCodRot;
          ExecSQL;
        End;
      End;
    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fAlteraStatusRota]');
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TRotReg.fExisteRota: Boolean;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + 'SELECT ENT_CODIGO ';
    Result := Result + '  FROM ENTREG ';
    Result := Result + ' INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT ';
  End;
var
  qryCons: TUniQuery;
begin
  Try
    Result := False;

    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL);
      ParamByName('CODROT').AsString := FCodRot;
      Open;

      Result := qryCons.RecordCount > 0;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TRotReg.fIniciaValidacoes: Boolean;
var
  horHorMax,
  horHorCar: TTime;
  dtaDtaMax: TDate;
  strCodReg: String;
  fltPesPed: Double;
  fltPesAtu: Double;
  fltPesDis: Double;
  intTamTab: Integer;
  LCpfCnpjCli: String;
begin
  Result := True;

  LCpfCnpjCli := '';

  If (fEmptyStr(strNumOrc)) Then
    intTamTab := 21
  Else
    intTamTab := 31;

  pRetornaValoresPadroes(horHorMax, horHorCar, strCodReg, dtaDtaMax);

  dtaDtaEnt := dtaDtaMax;

  fltPesMax := fVeiculoCapacidade;
  fltPesPed := fRetornaPesoTotalRota(FSeqFgo);
  fltPesAtu := fRetornaPesoTotalRota(FSeqFgo, '=');
  fltPesDis := fltPesMax - (fRetornaPesoTotalRota(FSeqFgo) + fltPesBru);

  If ((fRetDataServidor = dtaDtaMax) And (horHorMax < fRetHoraServidor)) Or (fRetDataServidor > dtaDtaMax) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Excedido o horário máximo permitido para emissão do pedido da Rota !');
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'            ,  FCodCli + ' - ' + fRetNomCliente(FCodCli)    , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento' ,  FormatFloat('##,#0.00',FTotPro)              , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Região'             ,  strCodReg + ' - ' + fRetNomRegiao(strCodReg) , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Até as'      ,  TimeToStr(horHorMax)                         , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Horário da Carga'   ,  TimeToStr(horHorCar)                         , intTamTab);

    If (Not fEmptyStr(strNumOrc)) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Nº'        , strNumOrc                                     , intTamTab)
    Else
      objLiberacao.objMsgLibera.pAddTexto('Pedido Novo');

    objLiberacao.objMsgLibera.pAddTextoCaption('Peso Pedido'        , FormatFloat('##,#0.00',fltPesBru)             , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Peso Disponível'    , FormatFloat('##,#0.00',fltPesDis)             , intTamTab);

    Result := fValidacao('EXEHMP', fCfgSis('SENHMP'), 'Foi excedido o horário máximo permitido para emissão do pedido da rota !');
  End;

  If Result And (fltPesDis < 0) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Excedido o peso máximo permitido para a Rota !');
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'            ,  FCodCli + ' - ' + fRetNomCliente(FCodCli)    , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento' ,  FormatFloat('##,#0.00',FTotPro)              , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Região'             ,  strCodReg + ' - ' + fRetNomRegiao(strCodReg) , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Até as'      ,  TimeToStr(horHorMax)                         , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Horário da Carga'   ,  TimeToStr(horHorCar)                         , intTamTab);

    If (Not fEmptyStr(strNumOrc)) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Nº'        , strNumOrc                                     , intTamTab)
    Else
      objLiberacao.objMsgLibera.pAddTexto('Pedido Novo');

    objLiberacao.objMsgLibera.pAddTextoCaption('Peso Máximo'        , FormatFloat('##,#0.00',fltPesMax)             , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Peso demais pedidos', FormatFloat('##,#0.00',fltPesPed)             , intTamTab);
    If (Not fEmptyStr(strNumOrc)) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Peso deste pedido já nesta rota', FormatFloat('##,#0.00',fltPesAtu) , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Peso '+IIF(fEmptyStr(strNumOrc),'','atual ')+'deste pedido' , FormatFloat('##,#0.00',fltPesBru) , intTamTab);
    objLiberacao.objMsgLibera.pAddTextoCaption('Peso Disponível'    , FormatFloat('##,#0.00',fltPesDis)             , intTamTab);

    Result := fValidacao('EXEPMR', fCfgSis('SENPMR'), 'Foi excedido o peso máximo permitido para a Rota !');
  End;

  If (Result) And (Not fPermiteEntrega(FCodCli, dtaDtaEnt)) Then
  Begin
    LCpfCnpjCli :=  fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
    objLiberacao.Clear;
    objLiberacao.strDirAce  := 'UTDTEN';
    objLiberacao.strMsgSen  := 'Cliente selecionado não permite entrega nesta data.';
    objLiberacao.strCodOpe  := strCodVen;
    objLiberacao.strCodDig  := strCodDig;
    objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
    objLiberacao.strCpfCnpj := LCpfCnpjCli;

    objLiberacao.objMsgLibera.pAddTexto('Cliente selecionado não permite entrega nesta data.');
    objLiberacao.objMsgLibera.pAddTexto('Verifique em > Cadastro de Clientes > ABA "Datas de Controle" (CFG_UTDTFE).');

    if not objLiberacao.fLibera then
      Result := False;
  End;

  If (Result) And (strEspDoc = 'PD') And (fCfgSis('TRAROT', varString) = 'S') And (fCampoTabela('ENT_DTAENT','ENTREG',['ENT_CODIGO'],[strCodRot], False) <= fRetDataServidor) Then
  Begin
    If fEmptyStr(LCpfCnpjCli) then
      LCpfCnpjCli :=  fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Data de saída da rota marcada para o dia de hoje.');
    objLiberacao.strDirAce  := 'DATAROTPED';
    objLiberacao.strMsgSen  := 'Data de saída da rota marcada para o dia de hoje.';
    objLiberacao.strCodOpe  := strCodVen;
    objLiberacao.strCodDig  := strCodDig;
    objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
    objLiberacao.strCpfCnpj := LCpfCnpjCli;

    if not objLiberacao.fLibera then
      Result := False;
  End;
end;

function TRotReg.fLiberaImpSeparacao(blnLibSep: Boolean): Boolean;
  function fRetUpdateSQL: String;
  Begin
    Result := '';
    Result := Result + 'UPDATE ENTREG               ';
    Result := Result + '   SET ENT_LIBSEP = :LIBSEP ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT ';
  End;
var
  qryCons: TUniQuery;
begin
  Result := True;
  Try
    qryCons := fCriaQuery(Nil);
    Try
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetUpdateSQL);
        ParamByName('LIBSEP').AsString := IIF(blnLibSep, 'S', 'N');
        ParamByName('CODROT').AsString := FCodRot;
        ExecSQL;
      End;
    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fAlteraStatusRota]');
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;

end;

function TRotReg.fVeiculoCapacidade: Double;
var
  qryTmp: TUniQuery;
Begin
  Try
    Result := 0;
    qryTmp := fCriaQuery(Nil);
    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT VEI_CAPCAR AS CAPCAR FROM ROTREV       ');
      SQL.Add('INNER JOIN ENTREG ON REV_CODIGO = ENT_ROTVEI  ');
      SQL.Add('INNER JOIN CADVEI ON VEI_PLAVEI = REV_PLAVEI  ');
      SQL.Add('WHERE ENT_CODIGO = :CODROT                    ');
      ParamByName('CODROT').AsString := FCodRot;
      Open;
      Result := FieldByName('CAPCAR').AsFloat;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
End;

function TRotReg.fRetornaPesoTotalRota(aStrSeqFgo: String; aStrCndCon: String='<>'): Double;

  function fRetSQL: String;
  Begin
    Result := '  SELECT IFNULL(SUM(EXTDOR.FDO_PESBRU), 0) AS PESROT ' +
              '    FROM FATGOR '+
              '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '  INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
              '  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
              '  WHERE EXTGOR.FGO_CODROT = :CODROT '+
              '    AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((IFNULL(FGO_MOTBAI, "") <> "") AND (IFNULL(FDO_NUMFAT, "") <> ""))) ';

    If (Not fEmptyStr(aStrSeqFgo)) Then
      Result := Result + ' AND FATGOR.AUTOINCREM '+aStrCndCon+' '+QuotedStr(aStrSeqFgo);

    If (fEmptyStr(aStrSeqFgo)) And (Pos('=', aStrCndCon) > 0) Then
      Result := Result + ' AND FALSE ';
  End;

var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL);
      ParamByName('CODROT').AsString := FCodRot;
      Open;

      Result := (qryCons.FieldByName('PESROT').AsFloat);
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

class procedure TRotReg.pValorContabilPorCodRot(var qryValRot: TUniQuery; const strLisCodRot: String);
begin
  If (Not Assigned(qryValRot)) Then
    qryValRot := fCriaQuery;

  qryValRot.Close;

  If (strLisCodRot = '') Then
    Exit;

  qryValRot.SQL.Text := fRetSQLBase(strLisCodRot);
  qryValRot.Open;
end;

class function TRotReg.fRetornaValorContabilDosPedidosNaRota(
  strCodRot: string): double;
var
  qryCons: TUniQuery;
begin
  if fEmptyStr(strCodRot) then
    Exit(0.00);

  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLBase);
      ParamByName('CODROT').AsString := strCodRot;
      Open;

      Result := (qryCons.FieldByName('VLRCON').AsFloat);
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

{function TRotReg.fRetornaValorTotalRota: Double;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + '  SELECT IFNULL(SUM(FGO_TOTPRO),0) AS TOTPRO          ';
    Result := Result + '  FROM FATGOR                                         ';
    Result := Result + '  INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
    Result := Result + '  INNER JOIN ENTREG ON ENT_CODIGO = EXTGOR.FGO_CODROT ';
    Result := Result + '  WHERE ENT_CODIGO = :CODROT ';
    If Not fEmptyStr(FNumOrc) Then
      Result := Result + '   AND FGO_NUMDOC <> :NUMDOC ';
  End;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL);
      ParamByName('CODROT').AsString := FCodRot;
      If Not fEmptyStr(FNumOrc) Then
        ParamByName('NUMDOC').AsString := FNumOrc;
      Open;

      Result := FieldByName('TOTPRO').AsFloat;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;}

function TRotReg.fRetTranspRota: String;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ROT_CODTRA  ';
    Result := Result + ' FROM ENTREG        ';
    Result := Result + ' INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT                   ';
  End;
var
  qryCons: TUniQuery;
begin
  Result := '';
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL);
      ParamByName('CODROT').AsString := FCodRot;
      Open;

      Result := FieldByName('ROT_CODTRA').AsString;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TRotReg.fValidacao(strDirAce, strSenLib,
  strMenSen: String): Boolean;
begin

  objLiberacao.strDirAce := strDirAce;
  objLiberacao.strSenLib := strSenLib;
  objLiberacao.strMsgSen := strMenSen;
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := FCodVen;
  objLiberacao.strCodDig := FCodDig;

  Result := objLiberacao.fLibera;
end;

procedure TRotReg.pRetornaValoresPadroes(Var horHorMax: TTime;  Var horHorCar: TTime;
                                         Var strCodReg: String; Var dtaDatMax: TDate);

  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ENT_CODIGO, ';
    Result := Result + '        ENT_CODREG, ';
    Result := Result + '        ENT_DTAENT, ';
    Result := Result + '        ROT_HORCAR, ';
    Result := Result + '        ROT_HOREMI  ';
    Result := Result + '  FROM ENTREG       ';
    Result := Result + '  INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
    Result := Result + '  WHERE ENT_CODIGO = :CODROT                   ';

    if fCfgSis('ROTEMP', varBoolean) then
      Result := Result + ' AND ENT_CODEMP = :CODEMP ';
  End;

var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL);
      ParamByName('CODROT').AsString := FCodRot;

      if fCfgSis('ROTEMP', varBoolean) then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      horHorMax := FieldByName('ROT_HOREMI').AsDateTime;
      horHorCar := FieldByName('ROT_HORCAR').AsDateTime;
      dtaDatMax := FieldByName('ENT_DTAENT').AsDateTime;
      strCodReg := FieldByName('ENT_CODREG').AsString;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.
