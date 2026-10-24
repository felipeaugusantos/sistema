unit untCfgColAdt;

interface

uses
  cxGrid, cxGridDBTableView, Vcl.DBGrids, System.Classes, SysUtils, Data.DB,
  Datasnap.DBClient,untcxGridDBColumnHelper, UniClientDataSet, Uni;

type
  TrecColAdt = record
    strFieldName: String;
    strCaption  : String;
    intWidth    : Integer;
    blnVisible  : Boolean;
    Alignment   : TAlignment;
    intIndex    : Integer;
  end;

type
  TArrayOfColAdt = Array of TrecColAdt;

type
  TCfgColAdt = Class
  private
    class var arrColsDad : TArrayOfColAdt;
    class procedure pSalvaEstadoPadrao(dbgDados: TcxGridDBTableView);
  public
    class var arrColsOri : TArrayOfColAdt;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(dbgDados: TcxGridDBTableView; var arrCol: TArrayOfColAdt);
    class procedure pIniciar(const dbgDados: TcxGrid; dbgDadosView: TcxGridDBTableView);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColAdt);
    class procedure pSetaEstado(dbgDados: TcxGridDBTableView; var arrCol: TArrayOfColAdt);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TcxGridDBTableView);
    class procedure pSetarPadrao(dbgDados: TcxGridDBTableView);
    class procedure pCarregarDadosSalvos(dbgDados: TcxGridDBTableView);
  End;

implementation

{ TCfgColAdt }

uses
  untFuncoesSimples;

class procedure TCfgColAdt.pCarregarDadosSalvos(dbgDados: TcxGridDBTableView);
var
  intCnt   : Integer;
  qryColAdt: TUniQuery;
  Coluna   : TcxGridDBColumn;
  intIndex : Integer;
  DtaSource: TDataSource;
begin
  qryColAdt := fCriaQuery;

  try
    qryColAdt.Close;
    qryColAdt.SQL.Clear;
    qryColAdt.SQL.Add('SELECT * ');
    qryColAdt.SQL.Add('FROM COLADT ');
    qryColAdt.SQL.Add('WHERE ADT_CODEMP = :CODEMP ');
    qryColAdt.SQL.Add('ORDER BY ADT_COLORD ');
    qryColAdt.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryColAdt.Open;

    SetLength(arrColsDad, 0);

    If Not qryColAdt.IsEmpty Then
    Begin
      DtaSource := dbgDados.DataController.DataSource;
      dbgDados.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDados.ColumnCount -1 Do
          dbgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryColAdt.First;

        while not qryColAdt.Eof do
        begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDados, qryColAdt.FieldByName('ADT_COLNAM').AsString);

          if (Coluna <> nil) then
          begin
            Coluna.Visible := True;
            Coluna.Index   := intIndex;
            Coluna.Caption := qryColAdt.FieldByName('ADT_COLCAP').AsString;
            Coluna.Width   := qryColAdt.FieldByName('ADT_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDad, Length(arrColsDad) + 1);
            arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Caption;
            arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
            arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
            arrColsDad[ Length(arrColsDad)-1 ].Alignment    := Coluna.DataBinding.Field.Alignment;
            arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;

            intIndex := intIndex + 1;
          end;

          qryColAdt.Next;
        end;
      finally
        dbgDados.DataController.DataSource := DtaSource;
      end;
    end;
  finally
    FreeAndNil(qryColAdt);
  end;
end;

class procedure TCfgColAdt.pGravarDadosNoBanco(arrCol: TArrayOfColAdt);
var
  qryColAdt: TUniQuery;
  intCnt   : Integer;
  intIndex : Integer;
begin
  qryColAdt := fCriaQuery;

  fStartTransaction;

  try
    try
      qryColAdt.Close;
      qryColAdt.SQL.Clear;
      qryColAdt.SQL.Add('DELETE FROM COLADT WHERE ADT_CODEMP = :CODEMP');
      qryColAdt.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColAdt.ExecSQL;

      qryColAdt.Close;
      qryColAdt.SQL.Clear;
      qryColAdt.SQL.Add('SELECT * FROM COLADT WHERE FALSE');
      qryColAdt.Open;

      intIndex := 0;

      for intCnt := Low(arrCol) to High(arrCol) do
      begin
        if (arrCol[intCnt].blnVisible) then
        begin
          qryColAdt.Append;
          qryColAdt.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('COLADT', VS_strCodEmp);
          qryColAdt.FieldByName('ADT_CODEMP').AsString  := VS_strCodEmp;
          qryColAdt.FieldByName('ADT_COLNAM').AsString  := arrCol[intCnt].strFieldName;
          qryColAdt.FieldByName('ADT_COLCAP').AsString  := arrCol[intCnt].strCaption;
          qryColAdt.FieldByName('ADT_COLORD').AsInteger := intIndex;
          qryColAdt.FieldByName('ADT_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColAdt.Post;

          intIndex := intIndex + 1;
        end;
      end;

      fCommit;
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColAdt.pGravarDadosNoBanco]');
      end;
    end;
  finally
    FreeAndNil(qryColAdt);
  end;
end;

class procedure TCfgColAdt.pIniciar(const dbgDados: TcxGrid; dbgDadosView: TcxGridDBTableView);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDadosView);
  pCarregarDadosSalvos(dbgDadosView);
end;

class procedure TCfgColAdt.pSalvaEstadoPadrao(dbgDados: TcxGridDBTableView);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColAdt.pSalvarEstado(dbgDados: TcxGridDBTableView; var arrCol: TArrayOfColAdt);
var
  intCnt : Integer;
begin
  SetLength(arrCol, 0);

  for intCnt := 0 to Pred(dbgDados.ColumnCount) Do
  begin
    if not fEmptyStr(dbgDados.Columns[intCnt].DataBinding.FieldName) then
    begin
      SetLength(arrCol, Length(arrCol) + 1);
      arrCol[Length(arrCol)-1].intIndex     := dbgDados.Columns[intCnt].Index;
      arrCol[Length(arrCol)-1].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
      arrCol[Length(arrCol)-1].strCaption   := dbgDados.Columns[intCnt].Caption;
      arrCol[Length(arrCol)-1].intWidth     := dbgDados.Columns[intCnt].Width;
      arrCol[Length(arrCol)-1].blnVisible   := dbgDados.Columns[intCnt].Visible;
      arrCol[Length(arrCol)-1].Alignment    := dbgDados.Columns[intCnt].DataBinding.Field.Alignment;
    end;
  end;
end;

class procedure TCfgColAdt.pSetaEstado(dbgDados: TcxGridDBTableView; var arrCol: TArrayOfColAdt);
var
  intCnt    : Integer;
  Column    : TcxGridDBColumn;
  DataSource: TDataSource;
begin
  DataSource := dbgDados.DataController.DataSource;
  dbgDados.DataController.DataSource := Nil;

  try
    for intCnt := 0 to Pred(dbgDados.ColumnCount) do
      dbgDados.Columns[intCnt].Visible := False;

    for intCnt := Low(arrCol) to High(arrCol) do
    begin
      if (arrCol[intCnt].blnVisible) then
      begin
        Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDados, arrCol[intCnt].strFieldName);

        if (Column <> nil) then
        begin
          Column.Index                       := arrCol[intCnt].intIndex;
          Column.DataBinding.FieldName       := arrCol[intCnt].strFieldName;
          Column.Caption                     := arrCol[intCnt].strCaption;
          Column.Width                       := arrCol[intCnt].intWidth;
          Column.Visible                     := arrCol[intCnt].blnVisible;
          Column.DataBinding.Field.Alignment := arrCol[intCnt].Alignment;
        end;
      end;
    end;
  finally
    dbgDados.DataController.DataSource := DataSource;
  end;
end;

class procedure TCfgColAdt.pSetarPadrao(dbgDados: TcxGridDBTableView);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColAdt.pSetarUltimosDadosCarregados(dbgDados: TcxGridDBTableView);
begin
  if (Length(arrColsDad) > 0) then
    pSetaEstado(dbgDados, arrColsDad);
end;

end.

