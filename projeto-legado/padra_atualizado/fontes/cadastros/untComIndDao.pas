unit untComIndDao;

interface

uses DB, SysUtils, Uni, Variants, StrUtils, UniClientDataSet;

type
  TComIndDao = class(TObject)
  private
  public
    function fGravaMetaAtingida(cdsComIndAti: TUniClientDataSet): Boolean;
    function fGravaMetaNaoAtingida(cdsComIndNAt: TUniClientDataSet): Boolean;

    function fGetMetaFaturamento: Double;
    function fGetAllComInd(strTabela: String): TUniQuery;
  End;

implementation

uses untFuncoesSimples;

{ TComIndDao }

function TComIndDao.fGetAllComInd(strTabela: String): TUniQuery;
  Var
    strSQL: String;
begin
  Result := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   0 AUTOINCREM, ';
    strSQL := strSQL + '   COM_DESCRI, ';
    strSQL := strSQL + '   COM_VALINI, ';
    strSQL := strSQL + '   COM_VALFIN, ';
    strSQL := strSQL + '   COM_PERCOM ';

    If SameText(strTabela, 'COMIAT') Then
      strSQL := strSQL + '  ,COM_METFAT ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strTabela;

    With Result Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      pSetaClient(Result);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'fGetAllComInd');
  End;
end;


function TComIndDao.fGetMetaFaturamento: Double;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Result := 0;

  Try
    qryTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   MAX(COM_METFAT) AS COM_METFAT ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  COMIAT ';
    strSQL := strSQL + ' LIMIT 1 ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If Not IsEmpty Then
        Result := FieldByName('COM_METFAT').AsFloat;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'fGetMetaFaturamento');
  End;

  FreeAndNil(qryTmp);
end;

function TComIndDao.fGravaMetaAtingida(cdsComIndAti: TUniClientDataSet): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Result := False;

  Try
    {******************************************************}
    {* DELETA TODOS OS REGISTRO POIS O CLIENT VEM COM     *}
    {* TODOS AS FAIXAS ANTEIORES E NOVAS DO BANCO         *}
    {* FEITO ISSO POIS NÃO EXISTE AUTOINCREM NESTA TABELA *}
    {***************************************************FC*}
    strSQL := ' DELETE FROM COMIAT ';

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ';
      strSQL := strSQL + '   COMIAT ';
      strSQL := strSQL + ' (COM_DESCRI, ';
      strSQL := strSQL + '  COM_VALINI, ';
      strSQL := strSQL + '  COM_VALFIN, ';
      strSQL := strSQL + '  COM_PERCOM, ';
      strSQL := strSQL + '  COM_METFAT) ';
      strSQL := strSQL + '    VALUES ';
      strSQL := strSQL + '  (:DESCRI, ';
      strSQL := strSQL + '   :VALINI, ';
      strSQL := strSQL + '   :VALFIN, ';
      strSQL := strSQL + '   :PERCOM, ';
      strSQL := strSQL + '   :METFAT) ';

      cdsComIndAti.First;

      While Not cdsComIndAti.Eof Do
      Begin
        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);

        ParamByName('DESCRI').AsString := cdsComIndAti.FieldByName('COM_DESCRI').AsString;
        ParamByName('VALINI').AsFloat  := cdsComIndAti.FieldByName('COM_VALINI').AsFloat;
        ParamByName('VALFIN').AsFloat  := cdsComIndAti.FieldByName('COM_VALFIN').AsFloat;
        ParamByName('PERCOM').AsFloat  := cdsComIndAti.FieldByName('COM_PERCOM').AsFloat;
        ParamByName('METFAT').AsFloat  := cdsComIndAti.FieldByName('COM_METFAT').AsFloat;

        ExecSQL;

        cdsComIndAti.Next;
      End;

      Result := True;
    End;
  Except
    On E:Exception Do
      pMensagensErro('', E.Message + '[TComIndDao.fGravaMetaAtingida]');
  End;

  FreeAndNil(qryTmp);
end;

function TComIndDao.fGravaMetaNaoAtingida(
  cdsComIndNAt: TUniClientDataSet): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Result := False;

  Try
    {******************************************************}
    {* DELETA TODOS OS REGISTRO POIS O CLIENT VEM COM     *}
    {* TODOS AS FAIXAS ANTEIORES E NOVAS DO BANCO         *}
    {* FEITO ISSO POIS NÃO EXISTE AUTOINCREM NESTA TABELA *}
    {***************************************************FC*}
    strSQL := ' DELETE FROM COMINT ';

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ';
      strSQL := strSQL + '   COMINT ';
      strSQL := strSQL + ' (COM_DESCRI, ';
      strSQL := strSQL + '  COM_VALINI, ';
      strSQL := strSQL + '  COM_VALFIN, ';
      strSQL := strSQL + '  COM_PERCOM) ';
      strSQL := strSQL + '    VALUES ';
      strSQL := strSQL + '  (:DESCRI, ';
      strSQL := strSQL + '   :VALINI, ';
      strSQL := strSQL + '   :VALFIN, ';
      strSQL := strSQL + '   :PERCOM) ';

      cdsComIndNAt.First;

      While Not cdsComIndNAt.Eof Do
      Begin
        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);

        ParamByName('DESCRI').AsString := cdsComIndNAt.FieldByName('COM_DESCRI').AsString;
        ParamByName('VALINI').AsFloat  := cdsComIndNAt.FieldByName('COM_VALINI').AsFloat;
        ParamByName('VALFIN').AsFloat  := cdsComIndNAt.FieldByName('COM_VALFIN').AsFloat;
        ParamByName('PERCOM').AsFloat  := cdsComIndNAt.FieldByName('COM_PERCOM').AsFloat;

        ExecSQL;

        cdsComIndNAt.Next;
      End;

      Result := True;
    End;
  Except
    On E:Exception Do
      pMensagensErro('', E.Message + '[TComIndDao.fGravaMetaNaoAtingida]');
  End;

  FreeAndNil(qryTmp);
end;

end.
