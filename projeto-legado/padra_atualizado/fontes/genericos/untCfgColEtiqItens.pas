unit untCfgColEtiqItens;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, untcxGridDBColumnHelper,
  UniClientDataSet, cxGrid, cxGridDBTableView;

type
  TrecColEtiqItens = record
    strFieldName : String;
    strCaption   : String;
    intWidth     : Integer;
    blnVisible   : Boolean;
    intIndex     : Integer;
  end;

type
  TArrayOfColEtiqItens = Array Of TrecColEtiqItens;

type
  TCfgColEtiqItens = Class
  private
    class var arrColsDad : TArrayOfColEtiqItens;
    class procedure pSalvaEstadoPadrao(dbgDados: TcxGridDBTableView);

  public
    class var arrColsOri : TArrayOfColEtiqItens;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColEtiqItens);

    class procedure pIniciar(dbgDados: TcxGrid; dbgDadosView: TcxGridDBTableView);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColEtiqItens; cdsOrd: TUniClientDataSet);
    class procedure pSetaEstado(dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColEtiqItens);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TcxGridDBTableView);
    class procedure pSetarPadrao(dbgDados: TcxGridDBTableView);
    class procedure pCarregarDadosSalvos(dbgDadosView: TcxGridDBTableView);
    class function fUtilizarColuna(AField: String): Boolean; static;
  End;

implementation

{ TCfgColEtiqItens }

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

class procedure TCfgColEtiqItens.pSalvarEstado(dbgDados: TcxGridDBTableView; var arrCol : TArrayOfColEtiqItens);
  Var
    intCnt : Integer;
begin
  SetLength(arrCol, 0);

  For intCnt := 0 To dbgDados.ColumnCount -1 Do
  Begin
    SetLength(arrCol, Length(arrCol) + 1);
    arrCol[ Length(arrCol)-1 ].intIndex     := dbgDados.Columns[intCnt].Index;
    arrCol[ Length(arrCol)-1 ].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
    arrCol[ Length(arrCol)-1 ].strCaption   := dbgDados.Columns[intCnt].Caption;
    arrCol[ Length(arrCol)-1 ].intWidth     := dbgDados.Columns[intCnt].Width;
    arrCol[ Length(arrCol)-1 ].blnVisible   := dbgDados.Columns[intCnt].Visible;
  End;
end;

class procedure TCfgColEtiqItens.pSetaEstado(dbgDados: TcxGridDBTableView;
  var arrCol: TArrayOfColEtiqItens);
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
        End;
      End;
    End;
  Finally
    dbgDados.DataController.DataSource := DataSource;
  End;
end;

class procedure TCfgColEtiqItens.pSetarPadrao(dbgDados: TcxGridDBTableView);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColEtiqItens.pSetarUltimosDadosCarregados(dbgDados: TcxGridDBTableView);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColEtiqItens.pGravarDadosNoBanco(arrCol: TArrayOfColEtiqItens; cdsOrd: TUniClientDataSet );
  Var
    qryColEtiqItens : TUniQuery;
    qryOrdEtiqItens : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColEtiqItens := fCriaQuery;
  qryOrdEtiqItens := fCriaQuery;

  fStartTransaction;
  Try
    Try

      qryColEtiqItens.Close;
      qryColEtiqItens.SQL.Clear;
      qryColEtiqItens.SQL.Add('DELETE FROM COLETI WHERE ETI_CODEMP = :CODEMP');
      qryColEtiqItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColEtiqItens.ExecSQL;

      qryColEtiqItens.Close;
      qryColEtiqItens.SQL.Clear;
      qryColEtiqItens.SQL.Add('SELECT * FROM COLETI WHERE FALSE');
      qryColEtiqItens.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColEtiqItens.Append;
          qryColEtiqItens.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLETI', VS_strCodEmp);
          qryColEtiqItens.FieldByName('ETI_CODEMP').AsString := VS_strCodEmp;
          qryColEtiqItens.FieldByName('ETI_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColEtiqItens.FieldByName('ETI_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColEtiqItens.FieldByName('ETI_COLORD').AsInteger := intIndex;
          qryColEtiqItens.FieldByName('ETI_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColEtiqItens.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdEtiqItens.Close;
      qryOrdEtiqItens.SQL.Clear;
      qryOrdEtiqItens.SQL.Add('DELETE FROM ORDETI WHERE ETI_CODEMP = :CODEMP');
      qryOrdEtiqItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdEtiqItens.ExecSQL;

      qryOrdEtiqItens.Close;
      qryOrdEtiqItens.SQL.Clear;
      qryOrdEtiqItens.SQL.Add('SELECT * FROM ORDETI WHERE FALSE');
      qryOrdEtiqItens.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdEtiqItens.Append;
        qryOrdEtiqItens.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDETI', VS_strCodEmp);
        qryOrdEtiqItens.FieldByName('ETI_CODEMP').AsString  := VS_strCodEmp;
        qryOrdEtiqItens.FieldByName('ETI_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdEtiqItens.FieldByName('ETI_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdEtiqItens.FieldByName('ETI_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdEtiqItens.FieldByName('ETI_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdEtiqItens.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColEtiqItens.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColEtiqItens);
  End;
end;

class procedure TCfgColEtiqItens.pIniciar(dbgDados: TcxGrid; dbgDadosView: TcxGridDBTableView);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDadosView);
  pCarregarDadosSalvos(dbgDadosView);
end;

class procedure TCfgColEtiqItens.pSalvaEstadoPadrao(dbgDados: TcxGridDBTableView);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;

class function TCfgColEtiqItens.fUtilizarColuna(AField: String): Boolean;
begin
  result := true;

  {If AField.Equals('EPROMO') Then
    Result := false;}

end;

class procedure TCfgColEtiqItens.pCarregarDadosSalvos(dbgDadosView: TcxGridDBTableView);
  Var
    intCnt    : Integer;
    qryColEtiqItens : TUniQuery;
    Coluna    : TcxGridDBColumn;
    intIndex  : Integer;
    DtaSource : TDataSource;

begin

  qryColEtiqItens := fCriaQuery;

  Try
    qryColEtiqItens.Close;
    qryColEtiqItens.SQL.Clear;
    qryColEtiqItens.SQL.Add(' SELECT * ');
    qryColEtiqItens.SQL.Add('   FROM COLETI');
    qryColEtiqItens.SQL.Add('  WHERE ETI_CODEMP = :CODEMP ');
    qryColEtiqItens.SQL.Add('  ORDER BY ETI_COLORD ');
    qryColEtiqItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryColEtiqItens.Open;

    SetLength(arrColsDad, 0);

    If Not qryColEtiqItens.IsEmpty Then
    Begin
      DtaSource := dbgDadosView.DataController.DataSource;
      dbgDadosView.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDadosView.ColumnCount -1 Do
          dbgDadosView.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryColEtiqItens.First;

        While Not qryColEtiqItens.Eof Do
        Begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, qryColEtiqItens.FieldByName('ETI_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;
            Coluna.Index   := intIndex;

            Coluna.Caption := qryColEtiqItens.FieldByName('ETI_COLCAP').AsString;
            Coluna.Width   := qryColEtiqItens.FieldByName('ETI_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDad, Length(arrColsDad) + 1);
            arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Caption;
            arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
            arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
            arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;

            intIndex := intIndex + 1;
          End;

          qryColEtiqItens.Next;
        End;
      Finally
        dbgDadosView.DataController.DataSource  := DtaSource;
      End;

    End;

  Finally
    FreeAndNil(qryColEtiqItens);
  End;
end;

end.
