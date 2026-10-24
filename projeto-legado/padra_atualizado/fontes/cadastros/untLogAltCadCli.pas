unit untLogAltCadCli;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, Datasnap.DBClient, System.Generics.Collections;

Type
  TGenericProcedure = procedure(cdsAux : TUniClientDataSet);

Type
  TLogarTabela = Record
    strTabela   : String;
    arrCamposPK : Array of String;
    strWhere    : String;
    pDisplays   : TGenericProcedure;
    cdsAntes    : TUniClientDataSet;
    cdsDepois   : TUniClientDataSet;
  End;

Type
  TLogAltCadCli = Class(TComponent)
  Private

    FTabelas : array of TLogarTabela;
    FLogVar: TDictionary<String, String>;
    FUltCompra: TDictionary<String, TDateTime>;

    function fRetCodCliTabs(cdsAux : TDataSet; strTabela : String) : String;
    function fRetCamCliTabs(strTabela : String) : String;
    function fRetDataSet_To_String(cdsAux : TDataSet) : String;
    function fUpper(strInfo: String) : String;
    procedure pGravaLog(cdsAux_Ant,
                        cdsAux_Pos  : TUniClientDataSet;
                        strTabela   : String;
                        arrCamposPK : Array of String);
    function fLengthAutIncLogCCL(const cdsAux_Pos, cdsAux_Ant : TUniClientDataSet): Integer;
  Public

    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; Override;

    procedure pClearDataSets;

    procedure pLogAdd(strTabela   : String;
                      arrCamposPK : Array of String;
                      strWhere    : String;
                      pDisplays   : TGenericProcedure = nil);

    procedure pProcessarLogs(strWhereInsert : String = '');
    property LogVar: TDictionary<String, String> read FLogVar;
    property UltCompra: TDictionary<String, TDateTime> read FUltCompra;
  End;

implementation

Uses
  untFuncoesSimples;

constructor TLogAltCadCli.Create(Owner: TComponent);
begin

  Inherited Create(Owner);

  SetLength(FTabelas, 0);
  FLogVar := TDictionary<string, string>.Create;
  FUltCompra := TDictionary<string, TDateTime>.Create;

End;

destructor TLogAltCadCli.Destroy;
begin
  pClearDataSets;
  FLogVar.Free;
  FUltCompra.Free;
  inherited Destroy;
end;

function TLogAltCadCli.fRetCamCliTabs(strTabela: String): String;
begin

  Result := '';

  {Clientes}
  if (UpperCase(strTabela) = 'CADCLI') then
    Result := 'CLI_CODCLI';

  {Contatos}
  if (UpperCase(strTabela) = 'CLICTT') then
    Result := 'CLI_CODCLI';

  {End. Entrega}
  if (UpperCase(strTabela) = 'ENTCLI') then
    Result := 'ETC_CODCLI';

  {Quadro Societário}
  if (UpperCase(strTabela) = 'CADFIC') then
    Result := 'FIC_CODCLI';

  if (UpperCase(strTabela) = 'CLISCO') then
    Result := 'SCO_CODCLI';

  {Ref. Comerciais}
  if (UpperCase(strTabela) = 'CLIRCO') then
    Result := 'CLI_CODCLI';

  {Inf. Crediário}
  if (UpperCase(strTabela) = 'CLI_INFCRE') then
    Result := 'CLI_CODCLI';

  {Relacionamento Cliente Produto}
  if (UpperCase(strTabela) = 'CLIPRO') then
    Result := 'CLI_CODCLI';

  {Veículos}
  if (UpperCase(strTabela) = 'CLIVEI') then
    Result := 'CLI_CODCLI';

  {Condição de Pagamento}
  if (UpperCase(strTabela) = 'CLICND') then
    Result := 'CND_CODCLI';

  {Profissionais}
  if (UpperCase(strTabela) = 'CLIDIV') then
    Result := 'DIV_CODCLI';

  {Conta Contábil/Empresa}
  if (UpperCase(strTabela) = 'CCCLIE') then
    Result := 'CCC_CODCLI';

  {Bairros Atendidos}
  if (UpperCase(strTabela) = 'CLIBAT') then
    Result := 'BAT_CODCLI';

  {Fazendas}
  if (UpperCase(strTabela) = 'CADFAZ') then
    Result := 'FAZ_CODCLI';

  {Inteligência de Vendas}
  if (UpperCase(strTabela) = 'CLIFOR') then
    Result := 'CLF_CODCLI';

  {Embarcações}
  if (UpperCase(strTabela) = 'CLIEMB') then
    Result := 'EMB_CODCLI';

end;

function TLogAltCadCli.fRetCodCliTabs(cdsAux: TDataSet; strTabela: String): String;
begin

  Result := '';

  {Clientes}
  if (UpperCase(strTabela) = 'CADCLI') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {Contatos}
  if (UpperCase(strTabela) = 'CLICTT') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {End. Entrega}
  if (UpperCase(strTabela) = 'ENTCLI') then
    if (cdsAux.FindField('ETC_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('ETC_CODCLI').AsString;

  {Quadro Societário}
  if (UpperCase(strTabela) = 'CADFIC') then
    if (cdsAux.FindField('FIC_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('FIC_CODCLI').AsString;

  {Ref. Comerciais}
  if (UpperCase(strTabela) = 'CLIRCO') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {Inf. Crediário}
  if (UpperCase(strTabela) = 'CLI_INFCRE') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {Relacionamento Cliente Produto}
  if (UpperCase(strTabela) = 'CLIPRO') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {Veículos}
  if (UpperCase(strTabela) = 'CLIVEI') then
    if (cdsAux.FindField('CLI_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLI_CODCLI').AsString;

  {Condição de Pagamento}
  if (UpperCase(strTabela) = 'CLICND') then
    if (cdsAux.FindField('CND_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CND_CODCLI').AsString;

  {Profissionais}
  if (UpperCase(strTabela) = 'CLIDIV') then
    if (cdsAux.FindField('DIV_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('DIV_CODCLI').AsString;

  {Conta Contábil/Empresa}
  if (UpperCase(strTabela) = 'CCCLIE') then
    if (cdsAux.FindField('CCC_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CCC_CODCLI').AsString;

  {Bairros Atendidos}
  if (UpperCase(strTabela) = 'CLIBAT') then
    if (cdsAux.FindField('BAT_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('BAT_CODCLI').AsString;

  {Fazendas}
  if (UpperCase(strTabela) = 'CADFAZ') then
    if (cdsAux.FindField('FAZ_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('FAZ_CODCLI').AsString;

  {Inteligência de Vendas}
  if (UpperCase(strTabela) = 'CLIFOR') then
    if (cdsAux.FindField('CLF_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('CLF_CODCLI').AsString;

  {Embarcações}
  if (UpperCase(strTabela) = 'CLIEMB') then
    if (cdsAux.FindField('EMB_CODCLI') <> nil) then
      Result := cdsAux.FieldByName('EMB_CODCLI').AsString;

end;

function TLogAltCadCli.fRetDataSet_To_String(cdsAux: TDataSet): String;
var
  i : Integer;
  strDados : String;
begin

  Result   := '';
  strDados := '';

  For i := 0 To cdsAux.Fields.Count -1 Do
    if (not cdsAux.Fields[i].IsNull) and (cdsAux.Fields[i].AsString <> '') then
      strDados := strDados + fUpper(cdsAux.Fields[i].FieldName) + ' = ' + cdsAux.Fields[i].AsString + #13;

  if (strDados <> '') then
    Result := strDados;

end;

function TLogAltCadCli.fLengthAutIncLogCCL(const cdsAux_Pos, cdsAux_Ant : TUniClientDataSet) : Integer;
  Var
    intContador : Integer;
begin
  Result := 0;
  For intContador := 0 To cdsAux_Pos.Fields.Count - 1 Do
  begin
    If (cdsAux_Ant.Fields[intContador].Value <> cdsAux_Pos.Fields[intContador].Value) Then
      Inc(Result);
  End;
end;

function TLogAltCadCli.fUpper(strInfo: String): String;
Const
  ComAcento = 'àâêôûãõáéíóúçü´';
Var
  intContador: Integer;
begin

  Result := UpperCase(strInfo);

  For intContador := 1 To Length(strInfo) Do
    Case Result[intContador] Of
      'à': Result[intContador] := 'À';
      'â': Result[intContador] := 'Â';
      'ê': Result[intContador] := 'Ê';
      'ô': Result[intContador] := 'Ô';
      'û': Result[intContador] := 'Û';
      'ã': Result[intContador] := 'Ã';
      'õ': Result[intContador] := 'Õ';
      'á': Result[intContador] := 'Á';
      'é': Result[intContador] := 'É';
      'í': Result[intContador] := 'Í';
      'ó': Result[intContador] := 'Ó';
      'ú': Result[intContador] := 'Ú';
      'ç': Result[intContador] := 'Ç';
      'ü': Result[intContador] := 'Ü';
    End;

end;

procedure TLogAltCadCli.pClearDataSets;
var
  i : Integer;
begin

  for i := 0 to Length(FTabelas) -1 do
  begin

    if Assigned(FTabelas[i].cdsAntes) then
      FreeAndNil(FTabelas[i].cdsAntes);

    if Assigned(FTabelas[i].cdsDepois) then
      FreeAndNil(FTabelas[i].cdsDepois);

  end;

  {Limpa array}
  SetLength(FTabelas, 0);
end;

procedure TLogAltCadCli.pGravaLog(cdsAux_Ant,
                                  cdsAux_Pos  : TUniClientDataSet;
                                  strTabela   : String;
                                  arrCamposPK : Array of String);
Var
  qryLogCcl      : TUniQuery;
  intContador, i : Integer;

  strLocateCam : String;
  arrLocateVal : Array of Variant;

  blnInsert,
  blnEdit,
  blnDelete,
  blnVazio_Ant,
  blnVazio_Pos,
  blnRegPos_ExisteAnt,
  blnRegAnt_ExistePos : Boolean;
  strOperadoLiberacao: String;
  dtaUltCompra: TDateTime;
  intLengthAutIncLogCCL : Integer;
  strAutCCL : String;
Begin

  qryLogCcl := fCriaQuery;
  qryLogCcl.SQL.Text := 'SELECT * FROM LOGCCL WHERE FALSE';
  qryLogCcl.Open;

  blnVazio_Ant := cdsAux_Ant.IsEmpty;
  blnVazio_Pos := cdsAux_Pos.IsEmpty;

  {No ANT procuro Exclusões}
  cdsAux_Ant.First;
  while not cdsAux_Ant.Eof do
  begin

    strLocateCam := '';
    SetLength(arrLocateVal, 0);
    SetLength(arrLocateVal, Length(arrCamposPk));
    for i := 0 to Length(arrCamposPk) -1 do
    begin

      if (strLocateCam = '') then
        strLocateCam := arrCamposPk[i]
      else
        strLocateCam := strLocateCam + ';' + arrCamposPk[i];

      arrLocateVal[i] := cdsAux_Ant.FieldByName(arrCamposPk[i]).Value;

    end;

    blnRegAnt_ExistePos := cdsAux_Pos.Locate(strLocateCam, VarArrayOf(arrLocateVal), []);

    {Exclusão}
    if (not blnRegAnt_ExistePos) then
      blnDelete := True
    else
      blnDelete := False;

    if (blnDelete) then
    begin

      With qryLogCcl Do
      begin

        Insert;

        FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCCL', VS_strCodEmp);
        FieldByName('LOG_CODCLI').AsString   := fRetCodCliTabs(cdsAux_Ant, strTabela);
        FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
        FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
        FieldByName('LOG_HORALT').AsDateTime := fTime();
        FieldByName('LOG_NOMCAM').AsString   := '';
        FieldByName('LOG_DESCAM').AsString   := '';
        FieldByName('LOG_EMPLOG').AsString   := VS_strCodEmp;
        FieldByName('LOG_EMPFIS').AsString   := fRetEmpresaFisica;
        FieldByName('LOG_NOMTAB').AsString   := fUpper(strTabela);

        for i := 0 to Length(arrCamposPK) -1 do
        begin
          if (FieldByName('LOG_PK_NOM').AsString = '') then
          begin
            FieldByName('LOG_PK_NOM').AsString := cdsAux_Ant.FieldByName(arrCamposPK[i]).FieldName;
            FieldByName('LOG_PK_VAL').AsString := cdsAux_Ant.FieldByName(arrCamposPK[i]).AsString;
          end
          else
          begin
            FieldByName('LOG_PK_NOM').AsString := FieldByName('LOG_PK_NOM').AsString + ',' + cdsAux_Ant.FieldByName(arrCamposPK[i]).FieldName;
            FieldByName('LOG_PK_VAL').AsString := FieldByName('LOG_PK_VAL').AsString + ',' + cdsAux_Ant.FieldByName(arrCamposPK[i]).AsString;
          end;
        end;

        FieldByName('LOG_VALANT').AsString   := '';
        FieldByName('LOG_EVENTO').AsString   := 'D'; {Delete}
        FieldByName('LOG_VALPOS').AsString   := fRetDataSet_To_String(cdsAux_Ant);

        Post;

      End;

    end;

    cdsAux_Ant.Next;

  end;

  {No POS procuro Inserção e Alteração}
  cdsAux_Pos.First;
  while not cdsAux_Pos.Eof do
  begin

    strLocateCam := '';
    SetLength(arrLocateVal, 0);
    SetLength(arrLocateVal, Length(arrCamposPk));
    for i := 0 to Length(arrCamposPk) -1 do
    begin

      if (strLocateCam = '') then
        strLocateCam := arrCamposPk[i]
      else
        strLocateCam := strLocateCam + ';' + arrCamposPk[i];

      arrLocateVal[i] := cdsAux_Pos.FieldByName(arrCamposPk[i]).Value;

    end;

    blnRegPos_ExisteAnt := cdsAux_Ant.Locate(strLocateCam, VarArrayOf(arrLocateVal), []);

    {Inserção}
    if ((blnVazio_Ant) and (not blnVazio_Pos)) or ((not blnVazio_Ant) and (not blnRegPos_ExisteAnt)) then
      blnInsert := True
    else
      blnInsert := False;

    {Alteração}
    if (blnRegPos_ExisteAnt) then
      blnEdit := True
    else
      blnEdit := False;

    if (blnInsert) then
    begin

      With qryLogCcl Do
      begin

        Insert;

        FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCCL', VS_strCodEmp);
        FieldByName('LOG_CODCLI').AsString   := fRetCodCliTabs(cdsAux_Pos, strTabela);
        FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
        FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
        FieldByName('LOG_HORALT').AsDateTime := fTime();
        FieldByName('LOG_NOMCAM').AsString   := '';
        FieldByName('LOG_DESCAM').AsString   := '';
        FieldByName('LOG_EMPLOG').AsString   := VS_strCodEmp;
        FieldByName('LOG_EMPFIS').AsString   := fRetEmpresaFisica;
        FieldByName('LOG_NOMTAB').AsString   := fUpper(strTabela);

        if FLogVar.TryGetValue(FieldByName('LOG_NOMCAM').AsString, strOperadoLiberacao) then
          FieldByName('LOG_OPELIB').AsString := strOperadoLiberacao;

        for i := 0 to Length(arrCamposPK) -1 do
        begin
          if (FieldByName('LOG_PK_NOM').AsString = '') then
          begin
            FieldByName('LOG_PK_NOM').AsString := cdsAux_Pos.FieldByName(arrCamposPK[i]).FieldName;
            FieldByName('LOG_PK_VAL').AsString := cdsAux_Pos.FieldByName(arrCamposPK[i]).AsString;
          end
          else
          begin
            FieldByName('LOG_PK_NOM').AsString := FieldByName('LOG_PK_NOM').AsString + ',' + cdsAux_Pos.FieldByName(arrCamposPK[i]).FieldName;
            FieldByName('LOG_PK_VAL').AsString := FieldByName('LOG_PK_VAL').AsString + ',' + cdsAux_Pos.FieldByName(arrCamposPK[i]).AsString;
          end;
        end;

        FieldByName('LOG_VALANT').AsString   := '';
        FieldByName('LOG_EVENTO').AsString   := 'I'; {Inserção}
        FieldByName('LOG_VALPOS').AsString   := fRetDataSet_To_String(cdsAux_Pos);

        Post;

      End;

    end
    else
    if (blnEdit) then
    begin

      strAutCCL := EmptyStr;
      intLengthAutIncLogCCL := fLengthAutIncLogCCL(cdsAux_Pos, cdsAux_Ant);
      If (intLengthAutIncLogCCL > 0) Then
      Begin
        strAutCCL := fRetAutoIncrem('LOGCCL', VS_strCodEmp, intLengthAutIncLogCCL);

        With qryLogCcl Do
        For intContador := 0 To cdsAux_Pos.Fields.Count - 1 Do
        begin

          if (cdsAux_Ant.Fields[intContador].Value <> cdsAux_Pos.Fields[intContador].Value) then
          Begin

            Insert;

            FieldByName('AUTOINCREM').AsString   := strAutCCL;
            FieldByName('LOG_CODCLI').AsString   := fRetCodCliTabs(cdsAux_Pos, strTabela);
            FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
            FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
            FieldByName('LOG_HORALT').AsDateTime := fTime();
            FieldByName('LOG_NOMCAM').AsString   := fUpper(cdsAux_Pos.Fields[intContador].FieldName);
            FieldByName('LOG_DESCAM').AsString   := fUpper(cdsAux_Pos.Fields[intContador].DisplayLabel);
            FieldByName('LOG_EMPLOG').AsString   := VS_strCodEmp;
            FieldByName('LOG_EMPFIS').AsString   := fRetEmpresaFisica;
            FieldByName('LOG_NOMTAB').AsString   := fUpper(strTabela);

            if FLogVar.TryGetValue(FieldByName('LOG_NOMCAM').AsString, strOperadoLiberacao) then
              FieldByName('LOG_OPELIB').AsString := strOperadoLiberacao;

            for i := 0 to Length(arrCamposPK) -1 do
            begin
              if (FieldByName('LOG_PK_NOM').AsString = '') then
              begin
                FieldByName('LOG_PK_NOM').AsString := cdsAux_Pos.FieldByName(arrCamposPK[i]).FieldName;
                FieldByName('LOG_PK_VAL').AsString := cdsAux_Pos.FieldByName(arrCamposPK[i]).AsString;
              end
              else
              begin
                FieldByName('LOG_PK_NOM').AsString := FieldByName('LOG_PK_NOM').AsString + ',' + cdsAux_Pos.FieldByName(arrCamposPK[i]).FieldName;
                FieldByName('LOG_PK_VAL').AsString := FieldByName('LOG_PK_VAL').AsString + ',' + cdsAux_Pos.FieldByName(arrCamposPK[i]).AsString;
              end;
            end;

            FieldByName('LOG_EVENTO').AsString   := 'E'; {Edição}

            Case cdsAux_Pos.Fields[intContador].DataType of
              ftFloat : Begin
                          FieldByName('LOG_VALANT').AsString := FormatFloat('#,##0.00', cdsAux_Ant.Fields[intContador].AsFloat);
                          FieldByName('LOG_VALPOS').AsString := FormatFloat('#,##0.00', cdsAux_Pos.Fields[intContador].AsFloat);
                        End;

              ftTime : Begin
                         FieldByName('LOG_VALANT').AsString := FormatDateTime('HH:NN', cdsAux_Ant.Fields[intContador].AsDateTime);
                         FieldByName('LOG_VALPOS').AsString := FormatDateTime('HH:NN', cdsAux_Pos.Fields[intContador].AsDateTime);
                       End;

              ftDate : Begin
                         FieldByName('LOG_VALANT').AsString := FormatDateTime('DD/MM/YYYY', cdsAux_Ant.Fields[intContador].AsDateTime);
                         FieldByName('LOG_VALPOS').AsString := FormatDateTime('DD/MM/YYYY', cdsAux_Pos.Fields[intContador].AsDateTime);
                       End;

              ftDateTime : Begin
                             FieldByName('LOG_VALANT').AsString := FormatDateTime('DD/MM/YYYY HH:NN', cdsAux_Ant.Fields[intContador].AsDateTime);
                             FieldByName('LOG_VALPOS').AsString := FormatDateTime('DD/MM/YYYY HH:NN', cdsAux_Pos.Fields[intContador].AsDateTime);
                           End;

              ftWord,
              ftInteger,
              ftMemo,
              ftString,
              ftLongWord : Begin
                           FieldByName('LOG_VALANT').AsString := cdsAux_Ant.Fields[intContador].AsString;

                           if FUltCompra.TryGetValue(FieldByName('LOG_NOMCAM').AsString, dtaUltCompra) then
                             FieldByName('LOG_VALPOS').AsString := cdsAux_Pos.Fields[intContador].AsString + ' - CLI_ULTCOM = ' + FormatDateTime('dd/mm/yyyy', dtaUltCompra)
                           else
                             FieldByName('LOG_VALPOS').AsString := cdsAux_Pos.Fields[intContador].AsString;
                         End;
            End;

            Post;

            strAutCCL := fNextAutoIncrem(strAutCCL);
          End;

        End;
      End;

    end;

    cdsAux_Pos.Next;

  end;

  FreeAndNil(qryLogCcl);

End;

procedure TLogAltCadCli.pLogAdd(strTabela   : String;
                                arrCamposPK : Array of String;
                                strWhere    : String;
                                pDisplays   : TGenericProcedure = nil);
var
  qryAux : TUniQuery;
  i      : Integer;
begin

  qryAux := fCriaQuery;

  try

    {Nova Posição}
    SetLength(FTabelas, Length(FTabelas) +1);

    {Busca dados anteriores}
    qryAux.Close;
    qryAux.SQL.Clear;

    if (Trim(strWhere) <> '') then
    begin
      qryAux.SQL.Add('SELECT * FROM ' + Trim(strTabela) + ' WHERE ' + Trim(strWhere));
      FTabelas[Length(FTabelas)-1].strWhere := strWhere;
    end
    else
    begin
      qryAux.SQL.Add('SELECT * FROM ' + Trim(strTabela) + ' WHERE FALSE');
      FTabelas[Length(FTabelas)-1].strWhere := 'FALSE';
    end;

    qryAux.Open;

    FTabelas[Length(FTabelas)-1].strTabela := strTabela;

    {Campos da PK (Simples ou Composta)}
    SetLength(FTabelas[Length(FTabelas)-1].arrCamposPK, Length(arrCamposPK));
    for i := 0 to Length(arrCamposPK) -1 do
      FTabelas[Length(FTabelas)-1].arrCamposPK[i] := arrCamposPK[i];

    {Displays}
    FTabelas[Length(FTabelas)-1].pDisplays := pDisplays;

    {Converte para TUniClientDataSet}
    FTabelas[Length(FTabelas)-1].cdsAntes := fCriaClientDatset(qryAux);

    {Display Labels}
    if Assigned(pDisplays) then
      pDisplays(FTabelas[Length(FTabelas)-1].cdsAntes);

    FTabelas[Length(FTabelas)-1].cdsDepois := nil;

  finally
    FreeAndNil(qryAux);
  end;

end;

procedure TLogAltCadCli.pProcessarLogs(strWhereInsert : String = '');
var
  i      : Integer;
  qryAux : TUniQuery;
begin

  try

    for i := 0 to Length(FTabelas) -1 do
    begin

      qryAux := fCriaQuery;

      try

        {Busca dados posteriores}
        qryAux.Close;
        qryAux.SQL.Clear;

        if (strWhereInsert = '') then
          qryAux.SQL.Add('SELECT * FROM ' + Trim(FTabelas[i].strTabela) + ' WHERE ' + Trim(FTabelas[i].strWhere))
        else
          qryAux.SQL.Add('SELECT * FROM ' + Trim(FTabelas[i].strTabela) + ' WHERE ' + fRetCamCliTabs(FTabelas[i].strTabela) + strWhereInsert);

        qryAux.Open;

        {Converte para TUniClientDataSet}
        FTabelas[i].cdsDepois := fCriaClientDatset(qryAux);

        {Display Labels}
        if Assigned(FTabelas[i].pDisplays) then
          FTabelas[i].pDisplays(FTabelas[i].cdsDepois);

        if Assigned(FTabelas[i].cdsAntes) and Assigned(FTabelas[i].cdsDepois) then
          pGravaLog(FTabelas[i].cdsAntes, FTabelas[i].cdsDepois, FTabelas[i].strTabela, FTabelas[i].arrCamposPK);

      finally
        FreeAndNil(qryAux);
      end;

    end;

    pClearDataSets;

  finally

  end;

end;

end.
