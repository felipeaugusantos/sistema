unit untCfgColExpItensCaixa;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, UniClientDataSet;

type
  TrecColExpItensCaixa = record
    strFieldName : String;
    strCaption : String;
    intWidth : Integer;
    blnVisible : Boolean;
    Alignment: TAlignment;
    intIndex : Integer;
  end;

type
  TArrayOfColExpItensCaixa = Array Of TrecColExpItensCaixa;

type
  TCfgColExpItensCaixa = Class
  private
    class var arrColsDad : TArrayOfColExpItensCaixa;
    class var arrColsDadCaixa : TArrayOfColExpItensCaixa;
    class procedure pSalvaEstadoPadrao(dbgDados: TDBGridCitel);
    class procedure pSalvaEstadoPadraoCaixa(dbgDados: TDBGridCitel);
  public
    class var strTipExp : String;
    class var arrColsOri : TArrayOfColExpItensCaixa;
    class var arrColsOriCaixa : TArrayOfColExpItensCaixa;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpItensCaixa);
    class procedure pSalvarEstadoCaixa(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpItensCaixa);
    class procedure pSetaEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpItensCaixa);
    class procedure pSetaEstadoCaixa(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpItensCaixa);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
    class procedure pSetarUltimosDadosCarregadosCaixa(dbgDados: TDBGridCitel);
    class procedure pSetarPadrao(dbgDados: TDBGridCitel);
    class procedure pSetarPadraoCaixa(dbgDados: TDBGridCitel);
    class procedure pGravarDadosNoBancoItens(arrCol: TArrayOfColExpItensCaixa; cdsOrd: TUniClientDataSet);
    class procedure pGravarDadosNoBancoCaixa(arrCol: TArrayOfColExpItensCaixa; cdsOrd: TUniClientDataSet);
    class procedure pCarregarDadosSalvosItens(dbgDados: TDBGridCitel);
    class procedure pCarregarDadosSalvosCaixa(dbgDados: TDBGridCitel);
    class procedure pIniciar(dbgDados: TDBGridCitel);
    class procedure pIniciarCaixa(dbgDados: TDBGridCitel);
  End;

implementation

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

{ TCfgColExpItensCaixa }

class procedure TCfgColExpItensCaixa.pCarregarDadosSalvosCaixa(
  dbgDados: TDBGridCitel);
  Var
    intCnt : Integer;
    qryColExpCaixa : TUniQuery;
    Coluna : TColumn;
    intIndex : Integer;
    DtaSource : TDataSource;

    procedure pDefinirOrdenacao;
    var      qryTmp: TUniQuery;
             cdsOrd: TUniClientDataSet;
          strFields: String;
      strDescFields: String;
    Begin
      Try
        qryTmp := fCriaQuery;
        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM OREXCA          ');
          SQL.Add(' WHERE XCA_TIPEXP = :TIPEXP   ');
          SQL.Add('   AND XCA_CODEMP = :CODEMP   ');
          SQL.Add(' ORDER BY XCA_ORDCAM ');
          ParamByName('TIPEXP').AsString := Self.strTipExp;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          Open;
        End;

        cdsOrd := TUniClientDataSet( dbgDados.DataSource.DataSet );
        cdsOrd.IndexDefs.Clear;
        cdsOrd.IndexFieldNames := '';
        cdsOrd.IndexName := '';

        if not qryTmp.isEmpty then
        Begin
          With qryTmp do
          Begin
            first;
            While not eof do
            Begin
              if FieldByName('XCA_ORDDSC').AsString = 'S' then
              Begin
                if fEmptyStr(strDescFields) then
                  strDescFields := FieldByName('XCA_ORDNAM').AsString
                else
                  strDescFields := strFields + ';' + FieldByName('XCA_ORDNAM').AsString ;
              End;

              if fEmptyStr(strFields) then
                strFields := FieldByName('XCA_ORDNAM').AsString
              else
                strFields := strFields + ';' + FieldByName('XCA_ORDNAM').AsString ;

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
        FreeAndNil(qryTmp);
      End;
    End;

begin
  pDefinirOrdenacao ;

  qryColExpCaixa := fCriaQuery;
  Try
    With qryColExpCaixa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM COLCXA ');
      SQL.Add('  WHERE CXA_TIPEXP = :TIPEXP ');
      SQL.Add('    AND CXA_CODEMP = :CODEMP ');
      SQL.Add('  ORDER BY CXA_COLORD ');
      ParamByName('TIPEXP').AsString := Self.strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      SetLength(arrColsDadCaixa, 0);

      If Not IsEmpty Then
      Begin
        DtaSource := dbgDados.DataSource;
        dbgDados.DataSource := Nil;
        Try
          For intCnt := 0 To dbgDados.Columns.Count -1 Do
            dbgDados.Columns[intCnt].Visible := False;

          intIndex := 0;
          intUtiWidthGrid := 0;

          First;
          While Not Eof Do
          Begin
            Coluna := fFindColumnByName(dbgDados, FieldByName('CXA_COLNAM').AsString);

            If (Coluna <> Nil) Then
            Begin
              Coluna.Visible := True;
              Coluna.Index := intIndex;
              Coluna.Title.Caption := FieldByName('CXA_COLCAP').AsString;
              Coluna.Width := FieldByName('CXA_COLTAM').AsInteger;

              intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

              SetLength(arrColsDadCaixa, Length(arrColsDadCaixa) + 1);
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].strFieldName := Coluna.FieldName;
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].strCaption   := Coluna.Title.Caption;
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].intWidth     := Coluna.Width;
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].blnVisible   := Coluna.Visible;
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].Alignment    := Coluna.Alignment;
              arrColsDadCaixa[ Length(arrColsDadCaixa)-1 ].intIndex     := Coluna.Index;

              intIndex := intIndex + 1;
            End;

            Next;
          End;
        Finally
          dbgDados.DataSource := DtaSource;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryColExpCaixa);
  End;
end;

class procedure TCfgColExpItensCaixa.pCarregarDadosSalvosItens(
  dbgDados: TDBGridCitel);
  Var
    intCnt : Integer;
    qryColExpItens : TUniQuery;
    Coluna : TColumn;
    intIndex : Integer;
    DtaSource : TDataSource;

    procedure pDefinirOrdenacao;
    var      qryTmp: TUniQuery;
             cdsOrd: TUniClientDataSet;
          strFields: String;
      strDescFields: String;
    Begin
      Try
        qryTmp := fCriaQuery;
        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM OREXIT          ');
          SQL.Add(' WHERE XIT_TIPEXP = :TIPEXP   ');
          SQL.Add('   AND XIT_CODEMP = :CODEMP   ');
          SQL.Add(' ORDER BY XIT_ORDCAM ');
          ParamByName('TIPEXP').AsString := Self.strTipExp;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          Open;
        End;

        cdsOrd := TUniClientDataSet( dbgDados.DataSource.DataSet );
        cdsOrd.IndexDefs.Clear;
        cdsOrd.IndexFieldNames := '';
        cdsOrd.IndexName := '';

        if not qryTmp.isEmpty then
        Begin
          With qryTmp do
          Begin
            first;
            While not eof do
            Begin
              if FieldByName('XIT_ORDDSC').AsString = 'S' then
              Begin
                if fEmptyStr(strDescFields) then
                  strDescFields := FieldByName('XIT_ORDNAM').AsString
                else
                  strDescFields := strFields + ';' + FieldByName('XIT_ORDNAM').AsString ;
              End;

              if fEmptyStr(strFields) then
                strFields := FieldByName('XIT_ORDNAM').AsString
              else
                strFields := strFields + ';' + FieldByName('XIT_ORDNAM').AsString ;

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
        FreeAndNil(qryTmp);
      End;
    End;

begin
  pDefinirOrdenacao ;

  qryColExpItens := fCriaQuery;
  Try
    With qryColExpItens Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM COLITE ');
      SQL.Add('  WHERE ITE_TIPEXP = :TIPEXP ');
      SQL.Add('    AND ITE_CODEMP = :CODEMP ');
      SQL.Add('  ORDER BY ITE_COLORD ');
      ParamByName('TIPEXP').AsString := Self.strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      SetLength(arrColsDad, 0);

      If Not IsEmpty Then
      Begin
        DtaSource := dbgDados.DataSource;
        dbgDados.DataSource := Nil;
        Try
          For intCnt := 0 To dbgDados.Columns.Count -1 Do
            dbgDados.Columns[intCnt].Visible := False;

          intIndex := 0;
          intUtiWidthGrid := 0;

          First;
          While Not Eof Do
          Begin
            Coluna := fFindColumnByName(dbgDados, FieldByName('ITE_COLNAM').AsString);

            If (Coluna <> Nil) Then
            Begin
              Coluna.Visible := True;
              Coluna.Index := intIndex;
              Coluna.Title.Caption := FieldByName('ITE_COLCAP').AsString;
              Coluna.Width := FieldByName('ITE_COLTAM').AsInteger;

              intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

              SetLength(arrColsDad, Length(arrColsDad) + 1);
              arrColsDad[ Length(arrColsDad)-1 ].strFieldName := Coluna.FieldName;
              arrColsDad[ Length(arrColsDad)-1 ].strCaption   := Coluna.Title.Caption;
              arrColsDad[ Length(arrColsDad)-1 ].intWidth     := Coluna.Width;
              arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := Coluna.Visible;
              arrColsDad[ Length(arrColsDad)-1 ].Alignment    := Coluna.Alignment;
              arrColsDad[ Length(arrColsDad)-1 ].intIndex     := Coluna.Index;

              intIndex := intIndex + 1;
            End;

            Next;
          End;
        Finally
          dbgDados.DataSource := DtaSource;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryColExpItens);
  End;
end;

class procedure TCfgColExpItensCaixa.pGravarDadosNoBancoCaixa(
  arrCol: TArrayOfColExpItensCaixa; cdsOrd: TUniClientDataSet);
  Var
    qryColExpCaixa : TUniQuery;
    qryOrdExpCaixa : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColExpCaixa := fCriaQuery;
  qryOrdExpCaixa := fCriaQuery;

  fStartTransaction;
  Try
    Try
      With qryColExpCaixa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM COLCXA WHERE CXA_TIPEXP = :TIPEXP AND CXA_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := Self.strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryColExpCaixa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COLCXA WHERE FALSE');
        Open;

        intIndex := 0;

        For intCnt := Low(arrCol) To High(arrCol) Do
        Begin
          If (arrCol[intCnt].blnVisible) Then
          Begin
            Append;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLCXA', VS_strCodEmp);
            FieldByName('CXA_TIPEXP').AsString := Self.strTipExp;
            FieldByName('CXA_CODEMP').AsString := VS_strCodEmp;
            FieldByName('CXA_COLNAM').AsString := arrCol[intCnt].strFieldName;
            FieldByName('CXA_COLCAP').AsString := arrCol[intCnt].strCaption;
            FieldByName('CXA_COLORD').AsInteger := intIndex;
            FieldByName('CXA_COLTAM').AsInteger := arrCol[intCnt].intWidth;
            Post;

            intIndex := intIndex + 1;
          End;
        End;
      End;

      With qryOrdExpCaixa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM OREXCA WHERE XCA_TIPEXP = :TIPEXP AND XCA_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := Self.strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryOrdExpCaixa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM OREXCA WHERE FALSE');
        Open;

        cdsOrd.first;
        While not cdsOrd.eof do
        Begin
          Append;
          FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OREXCA', VS_strCodEmp);
          FieldByName('XCA_TIPEXP').AsString  := Self.strTipExp;
          FieldByName('XCA_CODEMP').AsString  := VS_strCodEmp;
          FieldByName('XCA_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
          FieldByName('XCA_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
          FieldByName('XCA_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
          FieldByName('XCA_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
          Post;

          cdsOrd.Next;
        End;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpItensCaixa.pGravarDadosNoBancoCaixa]');
      End;
    End;
  Finally
    FreeAndNil(qryColExpCaixa);
  End;
end;
class procedure TCfgColExpItensCaixa.pGravarDadosNoBancoItens(
  arrCol: TArrayOfColExpItensCaixa; cdsOrd: TUniClientDataSet);
  Var
    qryColExpItens : TUniQuery;
    qryOrdExpItens : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColExpItens := fCriaQuery;
  qryOrdExpItens := fCriaQuery;

  fStartTransaction;
  Try
    Try
      With qryColExpItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM COLITE WHERE ITE_TIPEXP = :TIPEXP AND ITE_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := Self.strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryColExpItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COLITE WHERE FALSE');
        Open;

        intIndex := 0;

        For intCnt := Low(arrCol) To High(arrCol) Do
        Begin
          If (arrCol[intCnt].blnVisible) Then
          Begin
            Append;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLITE', VS_strCodEmp);
            FieldByName('ITE_TIPEXP').AsString := Self.strTipExp;
            FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
            FieldByName('ITE_COLNAM').AsString := arrCol[intCnt].strFieldName;
            FieldByName('ITE_COLCAP').AsString := arrCol[intCnt].strCaption;
            FieldByName('ITE_COLORD').AsInteger := intIndex;
            FieldByName('ITE_COLTAM').AsInteger := arrCol[intCnt].intWidth;
            Post;

            intIndex := intIndex + 1;
          End;
        End;
      End;

      With qryOrdExpItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM OREXIT WHERE XIT_TIPEXP = :TIPEXP AND XIT_CODEMP = :CODEMP');
        ParamByName('TIPEXP').AsString := Self.strTipExp;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      With qryOrdExpItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM OREXIT WHERE FALSE');
        Open;

        cdsOrd.first;
        While not cdsOrd.eof do
        Begin
          Append;
          FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OREXIT', VS_strCodEmp);
          FieldByName('XIT_TIPEXP').AsString  := Self.strTipExp;
          FieldByName('XIT_CODEMP').AsString  := VS_strCodEmp;
          FieldByName('XIT_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
          FieldByName('XIT_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
          FieldByName('XIT_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
          FieldByName('XIT_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
          Post;

          cdsOrd.Next;
        End;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpItensCaixa.pGravarDadosNoBancoItens]');
      End;
    End;
  Finally
    FreeAndNil(qryColExpItens);
  End;
end;

class procedure TCfgColExpItensCaixa.pIniciar(dbgDados: TDBGridCitel);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDados);
  pCarregarDadosSalvosItens(dbgDados);
end;

class procedure TCfgColExpItensCaixa.pIniciarCaixa(dbgDados: TDBGridCitel);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadraoCaixa(dbgDados);
  pCarregarDadosSalvosCaixa(dbgDados);
end;

class procedure TCfgColExpItensCaixa.pSalvaEstadoPadrao(dbgDados: TDBGridCitel);
begin
  pSalvarEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExpItensCaixa.pSalvaEstadoPadraoCaixa(
  dbgDados: TDBGridCitel);
begin
  pSalvarEstadoCaixa(dbgDados, arrColsOriCaixa);
end;

class procedure TCfgColExpItensCaixa.pSalvarEstado(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColExpItensCaixa);
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

class procedure TCfgColExpItensCaixa.pSalvarEstadoCaixa(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColExpItensCaixa);
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

class procedure TCfgColExpItensCaixa.pSetaEstado(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColExpItensCaixa);
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

class procedure TCfgColExpItensCaixa.pSetaEstadoCaixa(dbgDados: TDBGridCitel;
  var arrCol: TArrayOfColExpItensCaixa);
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

class procedure TCfgColExpItensCaixa.pSetarPadrao(dbgDados: TDBGridCitel);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExpItensCaixa.pSetarPadraoCaixa(dbgDados: TDBGridCitel);
begin
  pSetaEstadoCaixa(dbgDados, arrColsOriCaixa);
end;

class procedure TCfgColExpItensCaixa.pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColExpItensCaixa.pSetarUltimosDadosCarregadosCaixa(
  dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDadCaixa) > 0) Then
    pSetaEstadoCaixa(dbgDados, arrColsDadCaixa);
end;

end.
