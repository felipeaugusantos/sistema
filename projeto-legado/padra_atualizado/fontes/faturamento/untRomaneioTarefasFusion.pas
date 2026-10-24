unit untRomaneioTarefasFusion;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, Datasnap.DBClient, System.Generics.Collections;

type
  TTabelas = Record
    strTabela: String;
    arrCampos: Array of String;
    strWhere : String;
    strInner : String;
    cdsAntes : TUniClientDataSet;
    cdsDepois: TUniClientDataSet;
  end;

type
  TRomaneioTarefasFusion = class(TComponent)
  private
    FTabelas : array of TTabelas;
    procedure pGravaTarefa(cdsAuxAnt,
                           cdsAuxPos: TUniClientDataSet;
                           strTabela: String;
                           arrCampos: Array of String;
                           var blnContinuar: Boolean);

    procedure pAlterarIntFus(cdsAuxAnt,
                             cdsAuxPos: TUniClientDataSet;
                             strTabela: String;
                             arrCampos: Array of String);

    function fConcatena(strValor, strValorConcatenar: String): String;
    class function fRetEmpExp(strNumDoc, strEspDoc, strCodEmp: String): String;
  public
    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; Override;

    procedure pClearDataSets;
    procedure pProcessarTarefas;

    procedure pLogAdd(strTabela: String;
                      arrCampos: Array of String;
                      strWhere : String;
                      strInner: String = '');

    class procedure pInsereTarFus(strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp, strEvento: String);
  end;

implementation

uses
  untFuncoesSimples;

{ TRomaneioTarefasFusion }

constructor TRomaneioTarefasFusion.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  SetLength(FTabelas, 0);
end;

destructor TRomaneioTarefasFusion.Destroy;
begin
  pClearDataSets;

  inherited Destroy;
end;

function TRomaneioTarefasFusion.fConcatena(strValor, strValorConcatenar: String): String;
begin
  if fEmptyStr(strValor) then
    Result := strValorConcatenar
  else
    Result := strValor + ';' + strValorConcatenar;
end;

procedure TRomaneioTarefasFusion.pAlterarIntFus(cdsAuxAnt,
  cdsAuxPos: TUniClientDataSet; strTabela: String; arrCampos: array of String);
var
  intCont: Integer;
  blnVazio_Pos: Boolean;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    qryAux.SQL.Add('UPDATE ' + strTabela);
    qryAux.SQL.Add('SET ' + IIF((strTabela = 'CADVEI'), 'VEI_', 'MOT_') + 'INTFUS = "N" ');
    qryAux.SQL.Add('WHERE ' + arrCampos[0] + ' = :CHAVE ');

    blnVazio_Pos := cdsAuxPos.IsEmpty;

    if blnVazio_Pos then
      Exit;

    for intCont := 0 to Pred(cdsAuxAnt.Fields.Count) do
    begin
      if (cdsAuxAnt.Fields[intCont].Value <> cdsAuxPos.Fields[intCont].Value) then
      begin
        qryAux.Close;
        qryAux.ParamByName('CHAVE').AsString := cdsAuxAnt.FieldByName(arrCampos[0]).AsString;
        qryAux.ExecSQL;

        Break;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TRomaneioTarefasFusion.pClearDataSets;
var
  intCont: Integer;
begin
  for intCont := 0 to Pred(Length(FTabelas)) do
  begin
    if Assigned(FTabelas[intCont].cdsAntes) then
      FreeAndNil(FTabelas[intCont].cdsAntes);

    if Assigned(FTabelas[intCont].cdsDepois) then
      FreeAndNil(FTabelas[intCont].cdsDepois);
  end;

  SetLength(FTabelas, 0);
end;

procedure TRomaneioTarefasFusion.pGravaTarefa(cdsAuxAnt,
                                              cdsAuxPos: TUniClientDataSet;
                                              strTabela: String;
                                              arrCampos: Array of String;
                                              var blnContinuar: Boolean);
var
  intCont: Integer;
  blnVazio_Pos,
  blnRomGer,
  blnRegAnt_ExistePos,
  blnRegPos_ExisteAnt,
  blnInsert,
  blnDelete: Boolean;
  strLocateCam,
  strPre: String;
  arrLocateVal: Array of Variant;
begin
  try
    blnVazio_Pos := cdsAuxPos.IsEmpty;
    blnRomGer := (strTabela = 'ROMGERX');
    strPre := IIF(((blnRomGer) or (fCfgSis('OPCROM', varInteger)=2)), 'GER_', 'FGO_');

    // Insere cancelamento Romaneio
    if blnVazio_Pos and blnRomGer then
    begin
      pInsereTarFus(cdsAuxAnt.FieldByName('GER_NUMROM').AsString,
                    cdsAuxAnt.FieldByName('GER_EMPROM').AsString,
                    '',
                    '',
                    '',
                    'C');

      Exit;
    end;

    // Valida se houve remoção de PD, NF, IF
    cdsAuxAnt.First;

    while not cdsAuxAnt.Eof do
    begin
      strLocateCam := '';
      SetLength(arrLocateVal, 0);
      SetLength(arrLocateVal, Length(arrCampos));

      for intCont := 0 to Pred(Length(arrCampos)) do
      begin
        strLocatecam := fConcatena(strLocatecam, arrCampos[intCont]);
        arrLocateVal[intCont] := cdsAuxAnt.FieldByName(arrCampos[intCont]).Value;
      end;

      blnRegAnt_ExistePos := cdsAuxPos.Locate(strLocateCam, VarArrayOf(arrLocateVal), []);

      {Exclusão}
      blnDelete := (not blnRegAnt_ExistePos);

      if blnDelete then
      begin
        // Insere remoção PD, NF, IF do romaneio
        pInsereTarFus(cdsAuxAnt.FieldByName(strPre + 'NUMROM').AsString,
                      cdsAuxAnt.FieldByName(strPre + 'EMPROM').AsString,
                      cdsAuxAnt.FieldByName(strPre + 'NUMDOC').AsString,
                      cdsAuxAnt.FieldByName(strPre + 'ESPDOC').AsString,
                      cdsAuxAnt.FieldByName(strPre + 'CODEMP').AsString,
                      IIF(blnRomGer, 'E', 'P'));

        if (not blnRomGer) then
        begin
          blnContinuar := False;
          Exit;
        end;
      end;

      cdsAuxAnt.Next;
    end;

    //Valida se houve inclusão de PD, NF, IF
    cdsAuxPos.First;

    while not cdsAuxPos.Eof do
    begin
      strLocateCam := '';
      SetLength(arrLocateVal, 0);
      SetLength(arrLocateVal, Length(arrCampos));

      for intCont := 0 to Pred(Length(arrCampos)) do
      begin
        strLocatecam := fConcatena(strLocatecam, arrCampos[intCont]);
        arrLocateVal[intCont] := cdsAuxPos.FieldByName(arrCampos[intCont]).Value;
      end;

      blnRegPos_ExisteAnt := cdsAuxAnt.Locate(strLocateCam, VarArrayOf(arrLocateVal), []);
      blnInsert := (not blnRegPos_ExisteAnt);

      if blnInsert then
      begin
        pInsereTarFus(cdsAuxPos.FieldByName(strPre + 'NUMROM').AsString,
                      cdsAuxPos.FieldByName(strPre + 'EMPROM').AsString,
                      cdsAuxPos.FieldByName(strPre + 'NUMDOC').AsString,
                      cdsAuxPos.FieldByName(strPre + 'ESPDOC').AsString,
                      cdsAuxPos.FieldByName(strPre + 'CODEMP').AsString,
                      IIF(blnRomGer, 'I', 'P'));

        if (not blnRomGer) then
        begin
          blnContinuar := False;
          Exit;
        end;
      end;

      cdsAuxPos.Next;
    end;
  finally

  end;
end;

class procedure TRomaneioTarefasFusion.pInsereTarFus(strNumRom, strEmpRom, strNumDoc,
  strEspDoc, strCodEmp, strEvento: String);
const
  strInsert: String = 'INSERT INTO TARFUS ' +
    '(AUTOINCREM, FUS_NUMDOC, FUS_ESPDOC, FUS_EMPDOC, FUS_NUMROM, FUS_EMPROM, FUS_EVENTO, ' +
    'FUS_DTAINC, FUS_HRAINC, FUS_DTALEI, FUS_HRALEI, FUS_EMPTAR) ' +
    'VALUES ' +
    '(:AUTINC, :NUMDOC, :ESPDOC, :EMPDOC, :NUMROM, :EMPROM, :EVENTO, ' +
    ':DTAINC, :HRAINC, :DTALEI, :HRALEI, :EMPTAR) ';
var
  qryTarFus: TUniQuery;
begin
  qryTarFus := fCriaQuery;

  try
    qryTarFus.SQL.Add(strInsert);
    qryTarFus.ParamByName('AUTINC').AsString   := fRetAutoIncrem('TARFUS', VS_strCodEmp);
    qryTarFus.ParamByName('NUMROM').AsString   := strNumRom;
    qryTarFus.ParamByName('EMPROM').AsString   := strEmpRom;
    qryTarFus.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryTarFus.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryTarFus.ParamByName('EMPDOC').AsString   := strCodEmp;
    qryTarFus.ParamByName('EVENTO').AsString   := strEvento;
    qryTarFus.ParamByName('DTAINC').AsDateTime := VS_Date;
    qryTarFus.ParamByName('HRAINC').AsDateTime := fTime();
    qryTarFus.ParamByName('EMPTAR').AsString   := fRetEmpExp(strNumDoc, strEspDoc, strCodEmp);
    qryTarFus.ExecSQL;
  finally
    FreeAndNil(qryTarFus);
  end;
end;

class function TRomaneioTarefasFusion.fRetEmpExp(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryExtGor: TUniQuery;
begin
  Result := VS_strCodEmp;

  if fCfgSis('OPCROM', varInteger) = 2 then
    Exit;

  if fEmptyStr(strNumDoc) then
    Exit;

  if fEmptyStr(strEspDoc) then
    Exit;

  if fEmptyStr(strCodEmp) then
    Exit;

  qryExtGor := fCriaQuery;
  try
    qryExtGor.Close;
    qryExtGor.SQL.Text :=
    ' SELECT '+
    '   FGO_EMPEXP '+
    ' FROM '+
    '   FATGOR '+
    ' INNER JOIN EXTGOR ON '+
    '   FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO '+
    ' WHERE '+
    '  FGO_NUMDOC = :NUMDOC AND '+
    '  FGO_ESPDOC = :ESPDOC AND '+
    '  FGO_CODEMP = :CODEMP ';

    qryExtGor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryExtGor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryExtGor.ParamByName('CODEMP').AsString := strCodEmp;
    qryExtGor.Open;

    if not fEmptyStr(qryExtGor.FieldByName('FGO_EMPEXP').AsString) then
      Result := qryExtGor.FieldByName('FGO_EMPEXP').AsString;
  finally
    FreeAndNil(qryExtGor);
  end;
end;

procedure TRomaneioTarefasFusion.pLogAdd(strTabela: String;
  arrCampos: array of String; strWhere: String; strInner: String = '');
var
  qryAux : TUniQuery;
  intCont: Integer;
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  qryAux := fCriaQuery;

  try
    {Nova Posição}
    SetLength(FTabelas, Length(FTabelas) +1);

    {Busca dados anteriores}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM ' + Trim(strTabela));

    if (not fEmptyStr(strInner)) then
    begin
      qryAux.SQL.Add(strInner);
      FTabelas[Length(FTabelas)-1].strInner := strInner;
    end;

    qryAux.SQL.Add('WHERE ' + Trim(strWhere));
    qryAux.Open;

    FTabelas[Length(FTabelas)-1].strTabela := strTabela;
    FTabelas[Length(FTabelas)-1].strWhere := strWhere;

    {Campos da PK (Simples ou Composta)}
    SetLength(FTabelas[Length(FTabelas)-1].arrCampos, Length(arrCampos));

    for intCont := 0 to Pred(Length(arrCampos)) do
      FTabelas[Length(FTabelas) - 1].arrCampos[intCont] := arrCampos[intCont];

    {Converte para TUniClientDataSet}
    FTabelas[Length(FTabelas)-1].cdsAntes := fCriaClientDatset(qryAux);
    FTabelas[Length(FTabelas)-1].cdsDepois := nil;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TRomaneioTarefasFusion.pProcessarTarefas;
const
  strTabelas_Alt: String = 'CADVEI_CADMOT';
var
  intCont: Integer;
  qryAux: TUniQuery;
  blnContinuar: Boolean;
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  blnContinuar := True;

  try
    for intCont := 0 to Length(FTabelas) -1 do
    begin
      qryAux := fCriaQuery;

      try
        {Busca dados posteriores}
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT * FROM ' + Trim(FTabelas[intCont].strTabela));

        if (not fEmptyStr(FTabelas[intCont].strInner)) then
          qryAux.SQL.Add(FTabelas[intCont].strInner);

        qryAux.SQL.Add('WHERE ' + Trim(FTabelas[intCont].strWhere));
        qryAux.Open;

        {Converte para TUniClientDataSet}
        FTabelas[intCont].cdsDepois := fCriaClientDatset(qryAux);

        if (Pos(FTabelas[intCont].strTabela, strTabelas_Alt) > 0) then
        begin
          if Assigned(FTabelas[intCont].cdsAntes) and Assigned(FTabelas[intCont].cdsDepois) and (not FTabelas[intCont].cdsAntes.IsEmpty) then
            pAlterarIntFus(FTabelas[intCont].cdsAntes, FTabelas[intCont].cdsDepois, FTabelas[intCont].strTabela, FTabelas[intCont].arrCampos);
        end
        else
        begin
          if Assigned(FTabelas[intCont].cdsAntes) and Assigned(FTabelas[intCont].cdsDepois) and (not FTabelas[intCont].cdsAntes.IsEmpty) then
            pGravaTarefa(FTabelas[intCont].cdsAntes, FTabelas[intCont].cdsDepois, FTabelas[intCont].strTabela, FTabelas[intCont].arrCampos, blnContinuar);
        end;

        if (not blnContinuar) then
          Break;
      finally
        FreeAndNil(qryAux);
      end;
    end;
  finally
    pClearDataSets;
  end;
end;

end.

