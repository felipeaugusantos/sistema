unit untCfgColDebCtr;

interface

uses Vcl.DBGrids, System.Classes, Datasnap.DBClient,untcxGridDBColumnHelper,
  UniClientDataSet,cxGrid, cxGridDBTableView;

type
  TrecColDebCtr = record
    strFieldName : String;
    strCaption   : String;
    intWidth     : Integer;
    blnVisible   : Boolean;
    Alignment    : TAlignment;
    intIndex     : Integer;
  end;

type
  TArrayOfColDebCtr = Array Of TrecColDebCtr;

type
  TCfgColDebCtr= Class
  private
    class var arrColsDad : TArrayOfColDebCtr;
    class procedure pSalvaEstadoPadrao(Const dbgDados: TcxGridDBTableView);
    class procedure pDefinirOrdenacao(dbgDadosView: TcxGridDBTableView);

  public
    class var arrColsOri : TArrayOfColDebCtr;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColDebCtr);
    class procedure pIniciar(Const dbgDados: TcxGrid; Const dbgDadosView: TcxGridDBTableView);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColDebCtr; cdsOrd: TUniClientDataSet);
    class procedure pSetaEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColDebCtr);
    class procedure pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableView);
    class procedure pSetarPadrao(Const dbgDados: TcxGridDBTableView);
    class procedure pCarregarDadosSalvos(Const dbgDadosView: TcxGridDBTableView);
  End;


implementation

{ TCfgColDebCtr }

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

class procedure TCfgColDebCtr.pSalvarEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColDebCtr);
  Var
    intCnt : Integer;
begin
  SetLength(arrCol, 0);

  For intCnt := 0 To dbgDados.ColumnCount -1 Do
  Begin
    if Not fEmptyStr(dbgDados.Columns[intCnt].DataBinding.FieldName) then
    begin
      SetLength(arrCol, Length(arrCol) + 1);
      arrCol[ Length(arrCol)-1 ].intIndex     := dbgDados.Columns[intCnt].Index;
      arrCol[ Length(arrCol)-1 ].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
      arrCol[ Length(arrCol)-1 ].strCaption   := dbgDados.Columns[intCnt].Caption;
      arrCol[ Length(arrCol)-1 ].intWidth     := dbgDados.Columns[intCnt].Width;
      arrCol[ Length(arrCol)-1 ].blnVisible   := dbgDados.Columns[intCnt].Visible;
      arrCol[ Length(arrCol)-1 ].Alignment    := dbgDados.Columns[intCnt].DataBinding.Field.Alignment;
    end;
  End;
end;

class procedure TCfgColDebCtr.pSetaEstado(Const dbgDados: TcxGridDBTableView;
  var arrCol: TArrayOfColDebCtr);
  Var
    intCnt : Integer;
    Column : TcxGridDBColumn;
    DataSource : TDataSource;
begin
  DataSource := dbgDados.DataController.DataSource;
  dbgDados.DataController.DataSource := Nil;
  Try
    For intCnt := 0 To dbgDados.ColumnCount -1 Do
      dbgDados.Columns[intCnt].Visible := False;

    For intCnt := Low(arrCol) To High(arrCol) Do
    Begin
      If (arrCol[intCnt].blnVisible) Then
      Begin
        Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDados, arrCol[intCnt].strFieldName);

        If (Column <> Nil) Then
        Begin
          Column.Index                       := arrCol[intCnt].intIndex;
          Column.DataBinding.FieldName       := arrCol[intCnt].strFieldName;
          Column.Caption                     := arrCol[intCnt].strCaption;
          Column.Width                       := arrCol[intCnt].intWidth;
          Column.Visible                     := arrCol[intCnt].blnVisible;
          Column.DataBinding.Field.Alignment := arrCol[intCnt].Alignment;
        End;
      End;
    End;
  Finally
    dbgDados.DataController.DataSource := DataSource;
  End;
end;

class procedure TCfgColDebCtr.pSetarPadrao(Const dbgDados: TcxGridDBTableView);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColDebCtr.pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableView);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColDebCtr.pGravarDadosNoBanco(arrCol: TArrayOfColDebCtr; cdsOrd: TUniClientDataSet );
  Var
    qryColDebCtr: TUniQuery;
    qryOrdDebCtr: TUniQuery;
    intCnt        : Integer;
    intIndex      : Integer;
begin
  Try
    qryColDebCtr:= fCriaQuery;
    qryOrdDebCtr:= fCriaQuery;

    fStartTransaction;

    Try
      qryColDebCtr.Close;
      qryColDebCtr.SQL.Clear;
      qryColDebCtr.SQL.Add('DELETE '+
              '  FROM COLCTR '+
              ' WHERE CTR_CODEMP = :CODEMP');
      qryColDebCtr.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColDebCtr.ExecSQL;

      qryColDebCtr.Close;
      qryColDebCtr.SQL.Clear;
      qryColDebCtr.SQL.Add('SELECT * '+
              '  FROM COLCTR '+
              ' WHERE FALSE');
      qryColDebCtr.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColDebCtr.Append;
          qryColDebCtr.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('COLCTR', VS_strCodEmp);
          qryColDebCtr.FieldByName('CTR_CODEMP').AsString  := VS_strCodEmp;
          qryColDebCtr.FieldByName('CTR_COLNAM').AsString  := arrCol[intCnt].strFieldName;
          qryColDebCtr.FieldByName('CTR_COLCAP').AsString  := arrCol[intCnt].strCaption;
          qryColDebCtr.FieldByName('CTR_COLORD').AsInteger := intIndex;
          qryColDebCtr.FieldByName('CTR_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColDebCtr.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdDebCtr.Close;
      qryOrdDebCtr.SQL.Clear;
      qryOrdDebCtr.SQL.Add('DELETE '+
              '  FROM ORDCTR '+
              ' WHERE CTR_CODEMP = :CODEMP');
      qryOrdDebCtr.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdDebCtr.ExecSQL;

      qryOrdDebCtr.Close;
      qryOrdDebCtr.SQL.Clear;
      qryOrdDebCtr.SQL.Add('SELECT * FROM ORDCTR WHERE FALSE');
      qryOrdDebCtr.Open;

      cdsOrd.first;

      While not cdsOrd.eof do
      Begin
        qryOrdDebCtr.Append;
        qryOrdDebCtr.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDCTR', VS_strCodEmp);
        qryOrdDebCtr.FieldByName('CTR_CODEMP').AsString  := VS_strCodEmp;
        qryOrdDebCtr.FieldByName('CTR_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdDebCtr.FieldByName('CTR_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdDebCtr.FieldByName('CTR_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdDebCtr.FieldByName('CTR_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdDebCtr.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColDebCtr.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColDebCtr);
    FreeAndNil(qryOrdDebCtr);
  End;
end;

class procedure TCfgColDebCtr.pIniciar(Const dbgDados: TcxGrid; Const dbgDadosView: TcxGridDBTableView);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDadosView);
  pCarregarDadosSalvos(dbgDadosView);
end;

class procedure TCfgColDebCtr.pSalvaEstadoPadrao(Const dbgDados: TcxGridDBTableView);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColDebCtr.pCarregarDadosSalvos(Const dbgDadosView: TcxGridDBTableView);
  Var
    intCnt    : Integer;
    qryColDebCtr : TUniQuery;
    Coluna    : TcxGridDBColumn;
    intIndex  : Integer;
    DtaSource : TDataSource;

begin
  pDefinirOrdenacao(dbgDadosView);

  qryColDebCtr := fCriaQuery;

  Try
    qryColDebCtr.Close;
    qryColDebCtr.SQL.Clear;
    qryColDebCtr.SQL.Add(' SELECT * ');
    qryColDebCtr.SQL.Add('   FROM COLCTR');
    qryColDebCtr.SQL.Add('  WHERE CTR_CODEMP = :CODEMP ');
    qryColDebCtr.SQL.Add('  ORDER BY CTR_COLORD ');
    qryColDebCtr.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryColDebCtr.Open;

    SetLength(arrColsDad, 0);

    If Not qryColDebCtr.IsEmpty Then
    Begin
      DtaSource := dbgDadosView.DataController.DataSource;
      dbgDadosView.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDadosView.ColumnCount -1 Do
          dbgDadosView.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryColDebCtr.First;

        While Not qryColDebCtr.Eof Do
        Begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, qryColDebCtr.FieldByName('CTR_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;
            Coluna.Index   := intIndex;

            Coluna.Caption := qryColDebCtr.FieldByName('CTR_COLCAP').AsString;
            Coluna.Width   := qryColDebCtr.FieldByName('CTR_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDad, Length(arrColsDad) + 1);
            arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Caption;
            arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
            arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
            arrColsDad[ Length(arrColsDad)-1 ].Alignment    := Coluna.DataBinding.Field.Alignment;
            arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;

            intIndex := intIndex + 1;
          End;

          qryColDebCtr.Next;
        End;
      Finally
        dbgDadosView.DataController.DataSource  := DtaSource;
      End;

    End;

  Finally
    FreeAndNil(qryColDebCtr);
  End;
end;

class procedure TCfgColDebCtr.pDefinirOrdenacao(
  dbgDadosView: TcxGridDBTableView);
var
  qryTmp        : TUniQuery;
  cdsOrd        : TUniClientDataSet;
  strFields     : String;
  strDescFields : String;
  LAggregatesActive : Boolean;
  LIndex: TIndexDef;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDCTR          ');
    qryTmp.SQL.Add(' WHERE CTR_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY CTR_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    if not qryTmp.isEmpty then
    Begin
      cdsOrd := TUniClientDataSet( dbgDadosView.DataController.DataSet );
      LAggregatesActive := cdsOrd.AggregatesActive;
      cdsOrd.AggregatesActive := False;
      cdsOrd.IndexDefs.Clear;
      cdsOrd.IndexFieldNames := '';
      cdsOrd.IndexName := '';

      qryTmp.first;
      While not qryTmp.eof do
      Begin
        if qryTmp.FieldByName('CTR_ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := qryTmp.FieldByName('CTR_ORDNAM').AsString
          else
            strDescFields := strFields + ';' + qryTmp.FieldByName('CTR_ORDNAM').AsString ;
        End;

        if fEmptyStr(strFields) then
          strFields := qryTmp.FieldByName('CTR_ORDNAM').AsString
        else
          strFields := strFields + ';' + qryTmp.FieldByName('CTR_ORDNAM').AsString ;

        qryTmp.Next;
      End;

      LIndex := cdsOrd.IndexDefs.AddIndexDef;
      LIndex.Name   := 'IDX_001';
      LIndex.Fields := strFields;
      LIndex.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.AggregatesActive := LAggregatesActive;
      cdsOrd.First;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

end.
