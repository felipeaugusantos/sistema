unit untCfgColRomLoteSep;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, UniClientDataSet, cxGridCitel,
     cxGridDBTableView;

type
  TrecColRomLoteSep = record
    strFieldName : String;
    strCaption : String;
    intWidth : Integer;
    blnVisible : Boolean;
    Alignment: TAlignment;
    intIndex : Integer;
  end;

type
  TArrayOfColRomLoteSep = Array Of TrecColRomLoteSep;

type
  TCfgColRomLoteSep = Class
  private
    class var arrColsDad : TArrayOfColRomLoteSep;
    class procedure pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
  public
    class var arrColsOri : TArrayOfColRomLoteSep;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(cxgDados: TcxGridDBTableViewCitel;
                                  dbgDados: TDBGridCitel;
                                  var arrCol : TArrayOfColRomLoteSep);
    class procedure pIniciar(cxgDados: TcxGridCitel;
                             cxgDadosView: TcxGridDBTableViewCitel);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColRomLoteSep; cdsOrd: TUniClientDataSet);
    class procedure pSetaEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColRomLoteSep);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
    class procedure pSetarPadrao(dbgDados: TDBGridCitel);
    class procedure pCarregarDadosSalvos(cxgDados: TcxGridDBTableViewCitel);
    class function fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
    class procedure pGravarDadosRodaPe(cdsCamRod: TUniClientDataSet);
    class procedure pDefinirOrdenacao(cxgDados: TcxGridDBTableViewCitel);
  End;

const
  COLUNAS_INGNORADAS: array[0..1] of string = ('SEQUEN', 'AUTINC');

implementation

{ TCfgColRomLoteSep }

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

class procedure TCfgColRomLoteSep.pSalvarEstado(cxgDados: TcxGridDBTableViewCitel;
                                                dbgDados: TDBGridCitel;
                                                var arrCol : TArrayOfColRomLoteSep);
  Var
    intCnt : Integer;
begin
  SetLength(arrCol, 0);

  if Assigned(cxgDados) then
  begin
    For intCnt := 0 To cxgDados.ColumnCount -1 Do
    Begin
      SetLength(arrCol, Length(arrCol) + 1);
      arrCol[ Length(arrCol)-1 ].intIndex     := cxgDados.Columns[intCnt].Index;
      arrCol[ Length(arrCol)-1 ].strFieldName := cxgDados.Columns[intCnt].DataBinding.FieldName;
      arrCol[ Length(arrCol)-1 ].strCaption   := cxgDados.Columns[intCnt].Caption;
      arrCol[ Length(arrCol)-1 ].intWidth     := cxgDados.Columns[intCnt].Width;
      arrCol[ Length(arrCol)-1 ].blnVisible   := cxgDados.Columns[intCnt].Visible;
      arrCol[ Length(arrCol)-1 ].Alignment    := cxgDados.Columns[intCnt].HeaderAlignmentHorz;
    End;
  end
  else
  begin
    For intCnt := 0 To dbgDados.Columns.Count -1 Do
    Begin
      SetLength(arrCol, Length(arrCol) + 1);
      arrCol[ Length(arrCol)-1 ].intIndex     := dbgDados.Columns[intCnt].Index;
      arrCol[ Length(arrCol)-1 ].strFieldName := dbgDados.Columns[intCnt].FieldName;
      arrCol[ Length(arrCol)-1 ].strCaption   := dbgDados.Columns[intCnt].Title.Caption;
      arrCol[ Length(arrCol)-1 ].intWidth     := dbgDados.Columns[intCnt].Width;
      arrCol[ Length(arrCol)-1 ].blnVisible   := dbgDados.Columns[intCnt].Visible;
      arrCol[ Length(arrCol)-1 ].Alignment    := dbgDados.Columns[intCnt].Alignment;
    End;
  end;
end;

class procedure TCfgColRomLoteSep.pSetaEstado(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColRomLoteSep);
  Var
    intCnt : Integer;
    Column : TColumn;
    DataSource : TDataSource;
begin
  DataSource := dbgDados.DataSource;
  dbgDados.DataSource := Nil;
  Try
    For intCnt := 0 To dbgDados.Columns.Count -1 Do
      dbgDados.Columns[intCnt].Visible := False;

    For intCnt := Low(arrCol) To High(arrCol) Do
    Begin
      If (arrCol[intCnt].blnVisible) Then
      Begin
        Column := fFindColumnByName(dbgDados, arrCol[intCnt].strFieldName);

        If (Column <> Nil) Then
        Begin
          Column.Index := arrCol[intCnt].intIndex;
          Column.FieldName := arrCol[intCnt].strFieldName;
          Column.Title.Caption := arrCol[intCnt].strCaption;
          Column.Width := arrCol[intCnt].intWidth;
          Column.Visible := arrCol[intCnt].blnVisible;
          Column.Alignment :=  arrCol[intCnt].Alignment;
        End;
      End;
    End;
  Finally
    dbgDados.DataSource := DataSource;
  End;
end;

class procedure TCfgColRomLoteSep.pSetarPadrao(dbgDados: TDBGridCitel);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColRomLoteSep.pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColRomLoteSep.pGravarDadosNoBanco(arrCol: TArrayOfColRomLoteSep; cdsOrd: TUniClientDataSet );
  Var
    qryColRomLoteSep : TUniQuery;
    qryOrdRomLoteSep : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColRomLoteSep := fCriaQuery;
  qryOrdRomLoteSep := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryColRomLoteSep.Close;
      qryColRomLoteSep.SQL.Clear;
      qryColRomLoteSep.SQL.Add('DELETE FROM COLRLS WHERE RLS_CODEMP = :CODEMP');
      qryColRomLoteSep.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColRomLoteSep.ExecSQL;

      qryColRomLoteSep.Close;
      qryColRomLoteSep.SQL.Clear;
      qryColRomLoteSep.SQL.Add('SELECT * FROM COLRLS WHERE FALSE');
      qryColRomLoteSep.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColRomLoteSep.Append;
          qryColRomLoteSep.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLRLS', VS_strCodEmp);
          qryColRomLoteSep.FieldByName('RLS_CODEMP').AsString := VS_strCodEmp;
          qryColRomLoteSep.FieldByName('RLS_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColRomLoteSep.FieldByName('RLS_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColRomLoteSep.FieldByName('RLS_COLORD').AsInteger := intIndex;
          qryColRomLoteSep.FieldByName('RLS_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColRomLoteSep.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdRomLoteSep.Close;
      qryOrdRomLoteSep.SQL.Clear;
      qryOrdRomLoteSep.SQL.Add('DELETE FROM ORDRLS WHERE RLS_CODEMP = :CODEMP');
      qryOrdRomLoteSep.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdRomLoteSep.ExecSQL;

      qryOrdRomLoteSep.Close;
      qryOrdRomLoteSep.SQL.Clear;
      qryOrdRomLoteSep.SQL.Add('SELECT * FROM ORDRLS WHERE FALSE');
      qryOrdRomLoteSep.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdRomLoteSep.Append;
        qryOrdRomLoteSep.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDRLS', VS_strCodEmp);
        qryOrdRomLoteSep.FieldByName('RLS_CODEMP').AsString  := VS_strCodEmp;
        qryOrdRomLoteSep.FieldByName('RLS_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdRomLoteSep.FieldByName('RLS_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdRomLoteSep.FieldByName('RLS_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdRomLoteSep.FieldByName('RLS_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdRomLoteSep.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColRomLoteSep.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColRomLoteSep);
    FreeAndNil(qryOrdRomLoteSep);
  End;
end;

class procedure TCfgColRomLoteSep.pIniciar(cxgDados: TcxGridCitel;
                                           cxgDadosView: TcxGridDBTableViewCitel);
begin
  intMaxWidthGrid := cxgDados.Width;
  pSalvaEstadoPadrao(cxgDadosView);
  pCarregarDadosSalvos(cxgDadosView);
end;

class procedure TCfgColRomLoteSep.pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
begin
  pSalvarEstado(cxgDados, nil, arrColsOri);
end;

class procedure TCfgColRomLoteSep.pCarregarDadosSalvos(cxgDados: TcxGridDBTableViewCitel);
  Var
    intCnt : Integer;
    qryCOLRLS : TUniQuery;
    Coluna : TcxGridDBColumn;
    intIndex : Integer;
    DtaSource : TDataSource;
begin
  pDefinirOrdenacao(cxgDados) ;

  qryCOLRLS := fCriaQuery;
  Try
    qryCOLRLS.Close;
    qryCOLRLS.SQL.Clear;
    qryCOLRLS.SQL.Add(' SELECT * ');
    qryCOLRLS.SQL.Add('   FROM COLRLS ');
    qryCOLRLS.SQL.Add('  WHERE RLS_CODEMP = :CODEMP ');
    qryCOLRLS.SQL.Add('  ORDER BY RLS_COLORD ');
    qryCOLRLS.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCOLRLS.Open;

    SetLength(arrColsDad, 0);

    If Not qryCOLRLS.IsEmpty Then
    Begin
      DtaSource := cxgDados.DataController.DataSource;
      cxgDados.DataController.DataSource := Nil;
      Try
        For intCnt := 0 To cxgDados.ColumnCount -1 Do
          cxgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCOLRLS.First;
        While Not qryCOLRLS.Eof Do
        Begin
          Coluna := fFindColumnByNameCx(cxgDados, qryCOLRLS.FieldByName('RLS_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;
            Coluna.Index := intIndex;
            Coluna.Caption := qryCOLRLS.FieldByName('RLS_COLCAP').AsString;
            Coluna.Width := qryCOLRLS.FieldByName('RLS_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDad, Length(arrColsDad) + 1);
            arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Caption;
            arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
            arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
            arrColsDad[ Length(arrColsDad)-1 ].Alignment    := Coluna.HeaderAlignmentHorz;
            arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;

            intIndex := intIndex + 1;
          End;

          qryCOLRLS.Next;
        End;
      Finally
        cxgDados.DataController.DataSource := DtaSource;
      End;
    End;
  Finally
    FreeAndNil(qryCOLRLS);
  End;
end;

class function TCfgColRomLoteSep.fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
  var
    intIndex: Integer;
begin
  Result := Nil;
  For intIndex := 0 To cxgDados.ColumnCount -1 Do
    If cxgDados.Columns[intIndex].DataBinding.FieldName = strField Then
    Begin
      Result := cxgDados.Columns[intIndex];
      Break;
    End;
end;

class procedure TCfgColRomLoteSep.pGravarDadosRodaPe(cdsCamRod: TUniClientDataSet);
  Var
    qryCamRodLoteSep : TUniQuery;
begin
  qryCamRodLoteSep := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryCamRodLoteSep.Close;
      qryCamRodLoteSep.SQL.Clear;
      qryCamRodLoteSep.SQL.Add('DELETE FROM VISRLS WHERE RLS_CODEMP = :CODEMP');
      qryCamRodLoteSep.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCamRodLoteSep.ExecSQL;

      qryCamRodLoteSep.Close;
      qryCamRodLoteSep.SQL.Clear;
      qryCamRodLoteSep.SQL.Add('SELECT * FROM VISRLS WHERE FALSE');
      qryCamRodLoteSep.Open;

      cdsCamRod.First;
      while not cdsCamRod.Eof do
      begin
        qryCamRodLoteSep.Append;
        qryCamRodLoteSep.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VISRLS', VS_strCodEmp);
        qryCamRodLoteSep.FieldByName('RLS_CODEMP').AsString := VS_strCodEmp;
        qryCamRodLoteSep.FieldByName('RLS_NAMCOM').AsString := cdsCamRod.FieldByName('CAMPO').AsString;
        qryCamRodLoteSep.FieldByName('RLS_DESCOM').AsString := cdsCamRod.FieldByName('DESCRICAO').AsString;
        qryCamRodLoteSep.FieldByName('RLS_VISIBL').AsString := cdsCamRod.FieldByName('VISIVEL').AsString;
        qryCamRodLoteSep.Post;

        cdsCamRod.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColRomLoteSep.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryCamRodLoteSep);
  End;
end;

class procedure TCfgColRomLoteSep.pDefinirOrdenacao(cxgDados: TcxGridDBTableViewCitel);
  var
    qryTmp: TUniQuery;
    cdsOrd: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
Begin
  Try
    qryTmp := fCriaQuery;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDRLS          ');
    qryTmp.SQL.Add(' WHERE RLS_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY RLS_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    cdsOrd := TUniClientDataSet( cxgDados.DataController.DataSource.DataSet );
    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexFieldNames := '';
    cdsOrd.IndexName := '';

    if not qryTmp.isEmpty then
    Begin

        qryTmp.first;
        While not qryTmp.eof do
        Begin
          if qryTmp.FieldByName('RLS_ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := qryTmp.FieldByName('RLS_ORDNAM').AsString
            else
              strDescFields := strFields + ';' + qryTmp.FieldByName('RLS_ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := qryTmp.FieldByName('RLS_ORDNAM').AsString
          else
            strFields := strFields + ';' + qryTmp.FieldByName('RLS_ORDNAM').AsString ;

          qryTmp.Next;
        End;

      cdsOrd.IndexDefs.AddIndexDef.Name   := 'IDX_001';
      cdsOrd.IndexDefs.AddIndexDef.Fields := strFields;
      cdsOrd.IndexDefs.AddIndexDef.DescFields := strDescFields;
      cdsOrd.IndexName := 'IDX_001';
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
End;

end.
