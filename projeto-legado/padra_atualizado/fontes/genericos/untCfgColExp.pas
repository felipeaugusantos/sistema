unit untCfgColExp;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, UniClientDataSet;

type
  TrecColExp = record
    strFieldName : String;
    strCaption : String;
    intWidth : Integer;
    blnVisible : Boolean;
    Alignment: TAlignment;
    intIndex : Integer;
  end;

type
  TArrayOfColExp = Array Of TrecColExp;

type
  TCfgColExp = Class
  private
    class var arrColsDad : TArrayOfColExp;
    class procedure pSalvaEstadoPadrao(dbgDados: TDBGridCitel);
    class function fDataSetAtivo(dbgDados: TDBGridCitel): Boolean;
    class function fDataSetPopulado(dbgDados: TDBGridCitel): Boolean;
  public
    class var arrColsOri : TArrayOfColExp;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExp);
    class procedure pIniciar(dbgDados: TDBGridCitel);
    class procedure pGravarDadosNoBanco(arrCol: TArrayOfColExp; cdsOrd: TUniClientDataSet);
    class procedure pSetaEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExp);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
    class procedure pSetarPadrao(dbgDados: TDBGridCitel);
    class procedure pCarregarDadosSalvos(dbgDados: TDBGridCitel);
  End;

implementation

{ TCfgColExp }

uses untFuncoesSimples, untTypesSistema, Uni, SysUtils, Data.Db;

class function TCfgColExp.fDataSetAtivo(dbgDados: TDBGridCitel): Boolean;
begin
  Result := False;

  If (Assigned(dbgDados.DataSource)) Then
    If (Assigned(dbgDados.DataSource.DataSet)) Then
       Result := (Not dbgDados.DataSource.DataSet.ControlsDisabled);
end;

class function TCfgColExp.fDataSetPopulado(dbgDados: TDBGridCitel): Boolean;
begin
  Result := False;

  If (Assigned(dbgDados.DataSource)) Then
    If (Assigned(dbgDados.DataSource.DataSet)) Then
      Result := (dbgDados.DataSource.DataSet.FieldCount > 0);
end;

class procedure TCfgColExp.pSalvarEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExp);
  Var
    intCnt : Integer;
begin
  SetLength(arrCol, 0);

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

class procedure TCfgColExp.pSetaEstado(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColExp);
  Var
    intCnt : Integer;
    Column : TColumn;
    prcScroll: TprcScroll;
    blnDisable: Boolean;
begin
  blnDisable := fDataSetAtivo(dbgDados);
  Try
    If (blnDisable) Then
      pDisableControls(dbgDados.DataSource.DataSet, prcScroll);

    dbgDados.Columns.BeginUpdate;
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
      dbgDados.Columns.EndUpdate;
    End;
  Finally
    If (blnDisable) Then
      pEnableControls(dbgDados.DataSource.DataSet, prcScroll);
  End;
end;

class procedure TCfgColExp.pSetarPadrao(dbgDados: TDBGridCitel);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExp.pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColExp.pGravarDadosNoBanco(arrCol: TArrayOfColExp; cdsOrd: TUniClientDataSet );
  Var
    qryColExp : TUniQuery;
    qryOrdExp : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColExp := Nil;
  qryOrdExp := Nil;

  Try
    qryColExp := fCriaQuery;
    qryOrdExp := fCriaQuery;

    fStartTransaction;
    Try
      With qryColExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM COLEXP WHERE EXP_TIPEXP = :TIPEXP AND EXP_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := VS_strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryColExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COLEXP WHERE FALSE');
        Open;

        intIndex := 0;

        For intCnt := Low(arrCol) To High(arrCol) Do
        Begin
          If (arrCol[intCnt].blnVisible) Then
          Begin
            Insert;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLEXP', VS_strCodEmp);
            FieldByName('EXP_TIPEXP').AsString := VS_strTipExp;
            FieldByName('EXP_CODEMP').AsString := VS_strCodEmp;
            FieldByName('EXP_COLNAM').AsString := arrCol[intCnt].strFieldName;
            FieldByName('EXP_COLCAP').AsString := arrCol[intCnt].strCaption;
            FieldByName('EXP_COLORD').AsInteger := intIndex;
            FieldByName('EXP_COLTAM').AsInteger := arrCol[intCnt].intWidth;
            Post;

            intIndex := intIndex + 1;
          End;
        End;
      End;

      With qryOrdExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ORDEXP WHERE EXP_TIPEXP = :TIPEXP AND EXP_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := VS_strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryOrdExp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM ORDEXP WHERE FALSE');
        Open;

        cdsOrd.First;
        While Not cdsOrd.Eof do
        Begin
          Insert;
          FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDEXP', VS_strCodEmp);
          FieldByName('EXP_TIPEXP').AsString  := VS_strTipExp;
          FieldByName('EXP_CODEMP').AsString  := VS_strCodEmp;
          FieldByName('EXP_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
          FieldByName('EXP_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
          FieldByName('EXP_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
          FieldByName('EXP_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
          Post;

          cdsOrd.Next;
        End;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExp.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    If Assigned(qryColExp) Then
      FreeAndNil(qryColExp);

    If Assigned(qryOrdExp) Then
      FreeAndNil(qryOrdExp);
  End;
end;

class procedure TCfgColExp.pIniciar(dbgDados: TDBGridCitel);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDados);
  pCarregarDadosSalvos(dbgDados);
end;

class procedure TCfgColExp.pSalvaEstadoPadrao(dbgDados: TDBGridCitel);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExp.pCarregarDadosSalvos(dbgDados: TDBGridCitel);
  Var
    intCnt : Integer;
    qryColExp : TUniQuery;
    Coluna : TColumn;
    intIndex : Integer;
    intIdxArr : Integer;
    LUsaOndaSeparacaoAgrupamento: Boolean;
    prcScroll: TprcScroll;
    blnDisable: Boolean;
    cdsOrd: TUniClientDataSet;

    procedure pLimparIndices;
    Begin
      If (fDataSetPopulado(dbgDados)) Then
      Begin
        cdsOrd.IndexDefs.Clear;
        cdsOrd.IndexFieldNames := '';
        cdsOrd.IndexName := '';

        cdsOrd.Filtered := False;
        cdsOrd.Filter := '';
      End;
    End;

    procedure pDefinirOrdenacao;
    var       qryTmp: TUniQuery;
           strFields: String;
       strDescFields: String;
    Begin
      If (fDataSetPopulado(dbgDados)) Then
      Begin
        qryTmp := Nil;
        Try
          qryTmp := fCriaQuery;
          With qryTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM ORDEXP          ');
            SQL.Add(' WHERE EXP_TIPEXP = :TIPEXP   ');
            SQL.Add('   AND EXP_CODEMP = :CODEMP   ');
            SQL.Add(' ORDER BY EXP_ORDCAM ');
            ParamByName('TIPEXP').AsString := VS_strTipExp;
            ParamByName('CODEMP').AsString := VS_strCodEmp;
            Open;
          End;

          pLimparIndices;

          If Not qryTmp.isEmpty Then
          Begin
            With qryTmp do
            Begin
              First;
              While Not Eof Do
              Begin
                If FieldByName('EXP_ORDDSC').AsString = 'S' Then
                Begin
                  If fEmptyStr(strDescFields) Then
                    strDescFields := FieldByName('EXP_ORDNAM').AsString
                  Else
                    strDescFields := strDescFields + ';' + FieldByName('EXP_ORDNAM').AsString ;
                End;

                If fEmptyStr(strFields) Then
                  strFields := FieldByName('EXP_ORDNAM').AsString
                Else
                  strFields := strFields + ';' + FieldByName('EXP_ORDNAM').AsString ;

                Next;
              End;
            End;

            With cdsOrd.IndexDefs.AddIndexDef Do
            Begin
              Name   := 'IDX_001';
              Fields := strFields;
              DescFields := strDescFields;
            End;
            cdsOrd.IndexName := 'IDX_001';
          End;

        Finally
          If Assigned(qryTmp) Then
            FreeAndNil(qryTmp);
        End;
      End;
    End;

begin
  LUsaOndaSeparacaoAgrupamento := fUsaOndaSeparacaoAgrupamento;

  qryColExp := Nil;
  blnDisable := fDataSetAtivo(dbgDados);
  If (fDataSetPopulado(dbgDados)) Then
   cdsOrd := TUniClientDataSet(dbgDados.DataSource.DataSet);
  Try
    pLimparIndices;

    If (blnDisable) Then
      pDisableControls(dbgDados.DataSource.DataSet, prcScroll);

    qryColExp := fCriaQuery;
    With qryColExp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM COLEXP ');
      SQL.Add('  WHERE EXP_TIPEXP = :TIPEXP ');
      SQL.Add('    AND EXP_CODEMP = :CODEMP ');
      SQL.Add('  ORDER BY EXP_COLORD ');
      ParamByName('TIPEXP').AsString := VS_strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      SetLength(arrColsDad, 0);

      If Not IsEmpty Then
      Begin
        dbgDados.Columns.BeginUpdate;
        Try
          For intCnt := 0 To dbgDados.Columns.Count -1 Do
            dbgDados.Columns[intCnt].Visible := False;

          intIndex := 0;
          intUtiWidthGrid := 0;

          First;
          While Not Eof Do
          Begin
            Coluna := fFindColumnByName(dbgDados, FieldByName('EXP_COLNAM').AsString);

            If (Coluna <> Nil) Then
            Begin
              Coluna.Visible := True;
              Coluna.Index := intIndex;
              Coluna.Title.Caption := FieldByName('EXP_COLCAP').AsString;
              Coluna.Width := FieldByName('EXP_COLTAM').AsInteger;

              intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

              SetLength(arrColsDad, Length(arrColsDad) + 1);
              intIdxArr := Length(arrColsDad)-1;

              arrColsDad[intIdxArr].strFieldName := Coluna.FieldName;
              If (Coluna.FieldName = 'SEQSEP') Then
                arrColsDad[intIdxArr].strCaption := IIF(LUsaOndaSeparacaoAgrupamento, 'Remessa de Pedido', 'Seq. Separação')
              Else
                arrColsDad[intIdxArr].strCaption := Coluna.Title.Caption;
              arrColsDad[intIdxArr].intWidth     := Coluna.Width;
              arrColsDad[intIdxArr].blnVisible   := Coluna.Visible;
              arrColsDad[intIdxArr].Alignment    := Coluna.Alignment;
              arrColsDad[intIdxArr].intIndex     := Coluna.Index;

              intIndex := intIndex + 1;
            End;

            Next;
          End;
        Finally
          dbgDados.Columns.EndUpdate;
        End;
      End;
    End;

    pDefinirOrdenacao;
  Finally
    If (blnDisable) Then
      pEnableControls(dbgDados.DataSource.DataSet, prcScroll);

    If Assigned(qryColExp) Then
      FreeAndNil(qryColExp);
  End;
end;

end.
