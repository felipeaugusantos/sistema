unit untAlessiImobiliariaNovasFormulasDinamica;

interface

uses
  Uni, SysUtils, DB,
  Classes, untIConfTinta, Variants;


type
  TAlessiImobiliariaNovasFormulasDinamica = class(TInterfacedObject)
  private
    stlUnidades: TStringList;
    conf: IConfTinta;
    strInsert: string;
  public
    function fRemoverFormula(strCodNfm: String): Boolean;
    function fGravaCadNfm(qryCadNfm: TDataSet): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
  end;
  
implementation

uses untFuncoesSimples, untFuncTinta, untAlessiGravandoCores;

function TAlessiImobiliariaNovasFormulasDinamica.fRemoverFormula(strCodNfm: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' DELETE                       ' +
        '   FROM                       ' +
        '   ALE_CADALE                 ' +
        ' WHERE ALE_CODNFM = :CODNFM   ';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

constructor TAlessiImobiliariaNovasFormulasDinamica.Create;
begin
  inherited Create;
  stlUnidades := TStringList.Create;
  conf        := fGetConfTinta('ALE');
  strInsert   := fGetInsert('ALE_CADALE');
end;

destructor TAlessiImobiliariaNovasFormulasDinamica.Destroy;
begin
  if Assigned(stlUnidades) then FreeAndNil(stlUnidades);  
  inherited;
end;

function TAlessiImobiliariaNovasFormulasDinamica.fGravaCadNfm(qryCadNfm: TDataSet): Boolean;
var
  cmdInsert: TUniQuery;
  intCol: Integer;
  intAutoIncrem: Integer;
  qryCadBasEmb: TUniQuery;
  fltQtdEmbatual: Double;
begin
  cmdInsert := nil;
  Result := False;
  qryCadBasEmb := nil;
  Try
    Try
      cmdInsert := fCriaQuery(nil);
      intAutoIncrem := fRetAutoIncremInteger('ALE_CADALE', VS_strCodEmp);

      qryCadBasEmb := fCriaQuery();
      qryCadBasEmb.SQL.Text := ' SELECT EMB_NOME__               ' +
                               '      , EMB_QTDEMB               ' +
                               '      , EMB_CODUNI               ' +
                               '   FROM ALE_CADBAS               ' +
                               '  INNER JOIN ALE_CADEMB          ' +
                               '     ON BAS_CODUNI  = EMB_CODUNI ' +
                               '  WHERE BAS_PRODUT  = :PRODUT    ' +
                               '    AND BAS_BASE__  = :BASE__    ';

      qryCadBasEmb.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
      qryCadBasEmb.ParamByName('BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

      qryCadBasEmb.Open;

      fltQtdEmbatual := 0;

      if qryCadBasEmb.Locate('EMB_NOME__', VarArrayOf([qryCadNfm.FieldByName('NFM_EMBALA').AsString]), []) then
        fltQtdEmbatual := qryCadBasEmb.FieldByName('EMB_QTDEMB').AsFloat;

      qryCadBasEmb.First;
      while not qryCadBasEmb.Eof do
      begin
        cmdInsert.SQL.Clear;
        cmdInsert.SQL.Text := strInsert;
        Inc(intAutoIncrem);

        cmdInsert.ParamByName('INCREM').AsString    := fFormataAutInc(intAutoIncrem, VS_strCodEmp, VS_strCodEmp);
        cmdInsert.ParamByName('PRODUT').AsString    := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        cmdInsert.ParamByName('BASE__').AsString    := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        cmdInsert.ParamByName('EMBALA').AsString    := qryCadBasEmb.FieldByName('EMB_NOME__').AsString;
        cmdInsert.ParamByName('NOMCOR').AsString    := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
        cmdInsert.ParamByName('NOMLON').AsString    := qryCadNfm.FieldByName('NFM_NOMLON').AsString;
        cmdInsert.ParamByName('CODUNI').AsString    := qryCadBasEmb.FieldByName('EMB_CODUNI').AsString;
        cmdInsert.ParamByName('DTACAD').AsDateTime    := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
        cmdInsert.ParamByName('ATIVAD').AsString    := IfNull(qryCadNfm.FieldByName('NFM_ATIVAD').AsString, 'S');

        for intCol := 1 to 20 do
        begin
          if fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCol, 2)).AsString) then
            Continue;

          cmdInsert.ParamByName('CODC' + fStrZero(intCol, 2)).AsString    := qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCol, 2)).AsString;

          cmdInsert.ParamByName('QTOZ' + fStrZero(intCol, 2)).AsInteger   := TAlessiGravandoCores.GetFatorInteiroOnca(
                                                                              qryCadNfm.FieldByName('NFM_QTOZ' + fStrZero(intCol, 2)).AsInteger,
                                                                              qryCadNfm.FieldByName('NFM_QSHO' + fStrZero(intCol, 2)).AsFloat,
                                                                              qryCadBasEmb.FieldByName('EMB_QTDEMB').AsFloat / fltQtdEmbatual);

          cmdInsert.ParamByName('QSHO' + fStrZero(intCol, 2)).AsFloat     := TAlessiGravandoCores.GetFatorFracaoOnca(
                                                                              qryCadNfm.FieldByName('NFM_QTOZ' + fStrZero(intCol, 2)).AsInteger,
                                                                              qryCadNfm.FieldByName('NFM_QSHO' + fStrZero(intCol, 2)).AsFloat,
                                                                              qryCadBasEmb.FieldByName('EMB_QTDEMB').AsFloat / fltQtdEmbatual);
        end;

        cmdInsert.ParamByName('CODNFM').AsString    := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        cmdInsert.ParamByName('CODNFM').AsString    := qryCadNfm.FieldByName('NFM_CODNFM').AsString;

        cmdInsert.ParamByName('MD5KEY').AsString    := GetMD5(cmdInsert.ParamByName('PRODUT').AsString +
                                                              cmdInsert.ParamByName('BASE__').AsString +
                                                              qryCadBasEmb.FieldByName('EMB_NOME__').AsString +
                                                              cmdInsert.ParamByName('NOMCOR').AsString +
                                                              cmdInsert.ParamByName('NOMLON').AsString +
                                                              cmdInsert.ParamByName('CODNFM').AsString);

        cmdInsert.ExecSQL;
        qryCadBasEmb.Next;
      end;

      pAtualizaProCodAutInc('ALE_CADALE', intAutoIncrem);
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(cmdInsert) then FreeAndNil(cmdInsert);
    if Assigned(qryCadBasEmb) then FreeAndNil(qryCadBasEmb);
  End;
end;

end.
