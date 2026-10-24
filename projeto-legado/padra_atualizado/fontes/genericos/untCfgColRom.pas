unit untCfgColRom;

interface

uses Vcl.DBGrids, System.Classes, Datasnap.DBClient,untcxGridDBColumnHelper,
  UniClientDataSet,cxGrid, cxGridDBTableView;

type
  TrecColRom = record
    strFieldName : String;
    strCaption   : String;
    intWidth     : Integer;
    blnVisible   : Boolean;
    Alignment    : TAlignment;
    intIndex     : Integer;
    blnUtilizar  : Boolean;
  end;

type
  TArrayOfColRom = Array Of TrecColRom;

type
  TCfgColRom= Class
  private
    class var arrColsDad : TArrayOfColRom;
    class procedure pSalvaEstadoPadrao(Const dbgDados: TcxGridDBTableView);


  public
    class var arrColsOri : TArrayOfColRom;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class function fUtilizarColuna(AField: String): Boolean;
    class procedure pSalvarEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColRom);
    class procedure pIniciar(Const dbgDados: TcxGrid; Const dbgDadosView: TcxGridDBTableView);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColRom; cdsOrd: TUniClientDataSet);
    class procedure pSetaEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColRom);
    class procedure pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableView);
    class procedure pSetarPadrao(Const dbgDados: TcxGridDBTableView);
    class procedure pCarregarDadosSalvos(Const dbgDadosView: TcxGridDBTableView);
  End;


implementation

{ TCfgColRom }

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

class procedure TCfgColRom.pSalvarEstado(Const dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColRom);
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

class procedure TCfgColRom.pSetaEstado(Const dbgDados: TcxGridDBTableView;
  var arrCol: TArrayOfColRom);
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
          Column.Visible                     := arrCol[intCnt].blnVisible And arrCol[intCnt].blnUtilizar;
          Column.DataBinding.Field.Alignment := arrCol[intCnt].Alignment;
        End;
      End;
    End;
  Finally
    dbgDados.DataController.DataSource := DataSource;
  End;
end;

class procedure TCfgColRom.pSetarPadrao(Const dbgDados: TcxGridDBTableView);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColRom.pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableView);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColRom.pGravarDadosNoBanco(arrCol: TArrayOfColRom; cdsOrd: TUniClientDataSet );
  Var
    qryColRom: TUniQuery;
    qryOrdRom: TUniQuery;
    intCnt        : Integer;
    intIndex      : Integer;
begin
  Try
    qryColRom:= fCriaQuery;
    qryOrdRom:= fCriaQuery;

    fStartTransaction;

    Try
      qryColRom.Close;
      qryColRom.SQL.Clear;
      qryColRom.SQL.Add('DELETE '+
              '  FROM COLROM '+
              ' WHERE ROM_TIPROM = :TIPROM '+
              '   AND ROM_CODEMP = :CODEMP');
      qryColRom.ParamByName('TIPROM').AsString := fCfgSis('OPCROM');
      qryColRom.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColRom.ExecSQL;

      qryColRom.Close;
      qryColRom.SQL.Clear;
      qryColRom.SQL.Add('SELECT * '+
              '  FROM COLROM '+
              ' WHERE FALSE');
      qryColRom.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColRom.Append;
          qryColRom.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('COLROM', VS_strCodEmp);
          qryColRom.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM');
          qryColRom.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
          qryColRom.FieldByName('ROM_COLNAM').AsString  := arrCol[intCnt].strFieldName;
          qryColRom.FieldByName('ROM_COLCAP').AsString  := arrCol[intCnt].strCaption;
          qryColRom.FieldByName('ROM_COLORD').AsInteger := intIndex;
          qryColRom.FieldByName('ROM_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColRom.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdRom.Close;
      qryOrdRom.SQL.Clear;
      qryOrdRom.SQL.Add('DELETE '+
              '  FROM ORDROM '+
              ' WHERE ROM_TIPROM = :TIPROM '+
              '   AND ROM_CODEMP = :CODEMP');
      qryOrdRom.ParamByName('TIPROM').AsString := fCfgSis('OPCROM');
      qryOrdRom.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdRom.ExecSQL;

      qryOrdRom.Close;
      qryOrdRom.SQL.Clear;
      qryOrdRom.SQL.Add('SELECT * FROM ORDROM WHERE FALSE');
      qryOrdRom.Open;

      cdsOrd.first;

      While not cdsOrd.eof do
      Begin
        qryOrdRom.Append;
        qryOrdRom.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDROM', VS_strCodEmp);
        qryOrdRom.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM');
        qryOrdRom.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
        qryOrdRom.FieldByName('ROM_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdRom.FieldByName('ROM_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdRom.FieldByName('ROM_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdRom.FieldByName('ROM_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdRom.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColRom.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColRom);
    FreeAndNil(qryOrdRom);
  End;
end;

class procedure TCfgColRom.pIniciar(Const dbgDados: TcxGrid; Const dbgDadosView: TcxGridDBTableView);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDadosView);
  pCarregarDadosSalvos(dbgDadosView);
end;

class procedure TCfgColRom.pSalvaEstadoPadrao(Const dbgDados: TcxGridDBTableView);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;



class function TCfgColRom.fUtilizarColuna(AField: String): Boolean;
begin
  Result := True;

  If AField.Equals('GER_CODDIV') Then
    Result := (fCfgSis('NROPRO', varstring) = '2');

  If AField.Equals('GER_NOMDIV') Then
    Result := (fCfgSis('NROPRO', varstring) = '2');
end;

class procedure TCfgColRom.pCarregarDadosSalvos(Const dbgDadosView: TcxGridDBTableView);
  Var
    intCnt    : Integer;
    qryColRom : TUniQuery;
    Coluna    : TcxGridDBColumn;
    intIndex  : Integer;
    DtaSource : TDataSource;
begin

  qryColRom := fCriaQuery;

  Try
    qryColRom.Close;
    qryColRom.SQL.Clear;
    qryColRom.SQL.Add(' SELECT * ');
    qryColRom.SQL.Add('   FROM COLROM');
    qryColRom.SQL.Add('  WHERE ROM_TIPROM = :TIPROM ');
    qryColRom.SQL.Add('    AND ROM_CODEMP = :CODEMP ');
    qryColRom.SQL.Add('  ORDER BY ROM_COLORD ');
    qryColRom.ParamByName('TIPROM').AsString := fCfgSis('OPCROM');
    qryColRom.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryColRom.Open;

    SetLength(arrColsDad, 0);

    If Not qryColRom.IsEmpty Then
    Begin
      DtaSource := dbgDadosView.DataController.DataSource;
      dbgDadosView.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDadosView.ColumnCount -1 Do
          dbgDadosView.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryColRom.First;

        While Not qryColRom.Eof Do
        Begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, qryColRom.FieldByName('ROM_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;
            Coluna.Index   := intIndex;

            Coluna.Caption := qryColRom.FieldByName('ROM_COLCAP').AsString;
            Coluna.Width   := qryColRom.FieldByName('ROM_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDad, Length(arrColsDad) + 1);
            arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Caption;
            arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
            arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
            arrColsDad[ Length(arrColsDad)-1 ].Alignment    := Coluna.DataBinding.Field.Alignment;
            arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;
            arrColsDad[ Length(arrColsDad)-1 ].blnUtilizar  := fUtilizarColuna(Coluna.DataBinding.FieldName);

            intIndex := intIndex + 1;
          End;

          qryColRom.Next;
        End;
      Finally
        dbgDadosView.DataController.DataSource  := DtaSource;
      End;

    End;

  Finally
    FreeAndNil(qryColRom);
  End;
end;

end.
