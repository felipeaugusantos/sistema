unit untCfgColExpRetornoConsig;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, UniClientDataSet, cxGridCitel,
     cxGridDBTableView;

type
  TrecColExpRetornoConsig = record
    strFieldName : String;
    strCaption : String;
    intWidth : Integer;
    blnVisible : Boolean;
    Alignment: TAlignment;
    intIndex : Integer;
  end;

type
  TArrayOfColExpRetornoConsig = Array Of TrecColExpRetornoConsig;

type
  TCfgColExpRetornoConsig = Class
  private
    class var arrColsDad : TArrayOfColExpRetornoConsig;
    class var arrColsDadAnalit : TArrayOfColExpRetornoConsig;
    class procedure pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
    class procedure pSalvaEstadoPadraoAnalit(cxgDados: TcxGridDBTableViewCitel);
  public
    class var arrColsOri : TArrayOfColExpRetornoConsig;
    class var arrColsOriAnalit : TArrayOfColExpRetornoConsig;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(cxgDados: TcxGridDBTableViewCitel; dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpRetornoConsig);
    class procedure pSalvarEstadoAnalit(cxgDados: TcxGridDBTableViewCitel; dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpRetornoConsig);
    class procedure pIniciar(cxgDados: TcxGridCitel;
                             cxgDadosView: TcxGridDBTableViewCitel);
    class procedure pIniciarAnalit(cxgDados: TcxGridCitel;
                                   cxgDadosView: TcxGridDBTableViewCitel);
    class procedure pSetaEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpRetornoConsig);
    class procedure pSetaEstadoAnalit(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpRetornoConsig);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
    class procedure pSetarUltimosDadosCarregadosAnalit(dbgDados: TDBGridCitel);
    class procedure pSetarPadrao(dbgDados: TDBGridCitel);
    class procedure pSetarPadraoAnalit(dbgDados: TDBGridCitel);
    class function fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
    class procedure pGravarDadosNoBancoSintet(arrCol: TArrayOfColExpRetornoConsig; cdsOrd: TUniClientDataSet);
    class procedure pGravarDadosNoBancoAnalit(arrCol: TArrayOfColExpRetornoConsig; cdsOrd: TUniClientDataSet);
    class procedure pCarregarDadosSalvosSintet(cxgDados: TcxGridDBTableViewCitel);
    class procedure pCarregarDadosSalvosAnalit(cxgDados: TcxGridDBTableViewCitel);
    class procedure pDefinirOrdenacaoSintet(cxgDados: TcxGridDBTableViewCitel);
    class procedure pDefinirOrdenacaoAnalit(cxgDados: TcxGridDBTableViewCitel);

  End;

implementation

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

{ TCfgColExpRetornoConsig }

class procedure TCfgColExpRetornoConsig.pIniciar(cxgDados: TcxGridCitel;
                                                cxgDadosView: TcxGridDBTableViewCitel);
begin
  intMaxWidthGrid := cxgDados.Width;
  pSalvaEstadoPadrao(cxgDadosView);
  pCarregarDadosSalvosSintet(cxgDadosView);
end;

class procedure TCfgColExpRetornoConsig.pIniciarAnalit(cxgDados: TcxGridCitel;
                                                    cxgDadosView: TcxGridDBTableViewCitel);
begin
  intMaxWidthGrid := cxgDados.Width;
  pSalvaEstadoPadraoAnalit(cxgDadosView);
  pCarregarDadosSalvosAnalit(cxgDadosView);
end;

class procedure TCfgColExpRetornoConsig.pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
begin
  pSalvarEstado(cxgDados, nil, arrColsOri);
end;

class procedure TCfgColExpRetornoConsig.pSalvaEstadoPadraoAnalit(cxgDados: TcxGridDBTableViewCitel);
begin
  pSalvarEstadoAnalit(cxgDados, nil, arrColsOriAnalit);
end;

class procedure TCfgColExpRetornoConsig.pSalvarEstado(cxgDados: TcxGridDBTableViewCitel;
                                                   dbgDados: TDBGridCitel;
                                                   var arrCol : TArrayOfColExpRetornoConsig);
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

class procedure TCfgColExpRetornoConsig.pSalvarEstadoAnalit(cxgDados: TcxGridDBTableViewCitel;
                                                           dbgDados: TDBGridCitel;
                                                           var arrCol : TArrayOfColExpRetornoConsig);
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

class procedure TCfgColExpRetornoConsig.pSetaEstado(dbgDados: TDBGridCitel; var arrCol: TArrayOfColExpRetornoConsig);
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

class procedure TCfgColExpRetornoConsig.pSetaEstadoAnalit(dbgDados: TDBGridCitel; var arrCol: TArrayOfColExpRetornoConsig);
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

class procedure TCfgColExpRetornoConsig.pSetarPadrao(dbgDados: TDBGridCitel);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExpRetornoConsig.pSetarPadraoAnalit(dbgDados: TDBGridCitel);
begin
  pSetaEstadoAnalit(dbgDados, arrColsOriAnalit);
end;

class procedure TCfgColExpRetornoConsig.pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColExpRetornoConsig.pSetarUltimosDadosCarregadosAnalit( dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDadanalit) > 0) Then
    pSetaEstadoAnalit(dbgDados, arrColsDadanalit);
end;

class procedure TCfgColExpRetornoConsig.pCarregarDadosSalvosAnalit(cxgDados: TcxGridDBTableViewCitel);
  Var
    intCnt : Integer;
    qryCOLRCA : TUniQuery;
    Coluna : TcxGridDBColumn;
    intIndex : Integer;
    DtaSource : TDataSource;
Begin
  pDefinirOrdenacaoAnalit(cxgDados) ;

  qryCOLRCA := fCriaQuery;
  Try
    qryCOLRCA.Close;
    qryCOLRCA.SQL.Clear;
    qryCOLRCA.SQL.Add(' SELECT * ');
    qryCOLRCA.SQL.Add('   FROM COLRCA ');
    qryCOLRCA.SQL.Add('  WHERE RCA_CODEMP = :CODEMP ');
    qryCOLRCA.SQL.Add('  ORDER BY RCA_COLORD ');
    qryCOLRCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCOLRCA.Open;

    SetLength(arrColsDadAnalit, 0);

    If Not qryCOLRCA.IsEmpty Then
    Begin
      DtaSource := cxgDados.DataController.DataSource;
      cxgDados.DataController.DataSource := Nil;
      Try
        For intCnt := 0 To cxgDados.ColumnCount -1 Do
          cxgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCOLRCA.First;
        While Not qryCOLRCA.Eof Do
        Begin
          Coluna := fFindColumnByNameCx(cxgDados, qryCOLRCA.FieldByName('RCA_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;

            Coluna.Index := intIndex;
            Coluna.Caption := qryCOLRCA.FieldByName('RCA_COLCAP').AsString;
            Coluna.Width := qryCOLRCA.FieldByName('RCA_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(arrColsDadAnalit, Length(arrColsDadAnalit) + 1);
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].strFieldName := Coluna.DataBinding.FieldName;
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].strCaption   := Coluna.Caption;
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].intWidth     := Coluna.Width;
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].blnVisible   := Coluna.Visible;
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].Alignment    := Coluna.HeaderAlignmentHorz;
            arrColsDadAnalit[ Length(arrColsDadAnalit)-1 ].intIndex     := Coluna.Index;

            intIndex := intIndex + 1;
          End;

          qryCOLRCA.Next;
        End;
      Finally
        cxgDados.DataController.DataSource := DtaSource;
      End;
    End;
  Finally
    FreeAndNil(qryCOLRCA);
  End;
end;

class procedure TCfgColExpRetornoConsig.pCarregarDadosSalvosSintet(cxgDados: TcxGridDBTableViewCitel);
  Var
    intCnt : Integer;
    qryCOLRCS : TUniQuery;
    Coluna : TcxGridDBColumn;
    intIndex : Integer;
    DtaSource : TDataSource;
Begin
  pDefinirOrdenacaoSintet(cxgDados) ;

  qryCOLRCS := fCriaQuery;
  Try
    qryCOLRCS.Close;
    qryCOLRCS.SQL.Clear;
    qryCOLRCS.SQL.Add(' SELECT * ');
    qryCOLRCS.SQL.Add('   FROM COLRCS ');
    qryCOLRCS.SQL.Add('  WHERE RCS_CODEMP = :CODEMP ');
    qryCOLRCS.SQL.Add('  ORDER BY RCS_COLORD ');
    qryCOLRCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCOLRCS.Open;

    SetLength(arrColsDad, 0);

    If Not qryCOLRCS.IsEmpty Then
    Begin
      DtaSource := cxgDados.DataController.DataSource;
      cxgDados.DataController.DataSource := Nil;
      Try
        For intCnt := 0 To cxgDados.ColumnCount -1 Do
          cxgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCOLRCS.First;
        While Not qryCOLRCS.Eof Do
        Begin
          Coluna := fFindColumnByNameCx(cxgDados, qryCOLRCS.FieldByName('RCS_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;

            Coluna.Index := intIndex;
            Coluna.Caption := qryCOLRCS.FieldByName('RCS_COLCAP').AsString;
            Coluna.Width := qryCOLRCS.FieldByName('RCS_COLTAM').AsInteger;

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

          qryCOLRCS.Next;
        End;
      Finally
        cxgDados.DataController.DataSource := DtaSource;
      End;
    End;
  Finally
    FreeAndNil(qryCOLRCS);
  End;
end;

class procedure TCfgColExpRetornoConsig.pGravarDadosNoBancoAnalit(arrCol: TArrayOfColExpRetornoConsig; cdsOrd: TUniClientDataSet);
  Var
    qryColRCA : TUniQuery;
    qryOrdRCA : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColRCA := fCriaQuery;
  qryOrdRCA := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryColRCA.Close;
      qryColRCA.SQL.Clear;
      qryColRCA.SQL.Add('DELETE FROM COLRCA WHERE RCA_CODEMP = :CODEMP');
      qryColRCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColRCA.ExecSQL;

      qryColRCA.Close;
      qryColRCA.SQL.Clear;
      qryColRCA.SQL.Add('SELECT * FROM COLRCA WHERE FALSE');
      qryColRCA.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColRCA.Append;
          qryColRCA.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLRCA', VS_strCodEmp);
          qryColRCA.FieldByName('RCA_CODEMP').AsString := VS_strCodEmp;
          qryColRCA.FieldByName('RCA_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColRCA.FieldByName('RCA_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColRCA.FieldByName('RCA_COLORD').AsInteger := intIndex;
          qryColRCA.FieldByName('RCA_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColRCA.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdRCA.Close;
      qryOrdRCA.SQL.Clear;
      qryOrdRCA.SQL.Add('DELETE FROM ORDRCA WHERE RCA_CODEMP = :CODEMP');
      qryOrdRCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdRCA.ExecSQL;

      qryOrdRCA.Close;
      qryOrdRCA.SQL.Clear;
      qryOrdRCA.SQL.Add('SELECT * FROM ORDRCA WHERE FALSE');
      qryOrdRCA.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdRCA.Append;
        qryOrdRCA.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDRCA', VS_strCodEmp);
        qryOrdRCA.FieldByName('RCA_CODEMP').AsString  := VS_strCodEmp;
        qryOrdRCA.FieldByName('RCA_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdRCA.FieldByName('RCA_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdRCA.FieldByName('RCA_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdRCA.FieldByName('RCA_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdRCA.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpRetornoConsig.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColRCA);
    FreeAndNil(qryOrdRCA);
  End;
end;
class procedure TCfgColExpRetornoConsig.pGravarDadosNoBancoSintet( arrCol: TArrayOfColExpRetornoConsig; cdsOrd: TUniClientDataSet);
  Var
    qryColRCS : TUniQuery;
    qryOrdRCS : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColRCS := fCriaQuery;
  qryOrdRCS := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryColRCS.Close;
      qryColRCS.SQL.Clear;
      qryColRCS.SQL.Add('DELETE FROM COLRCS WHERE RCS_CODEMP = :CODEMP');
      qryColRCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColRCS.ExecSQL;

      qryColRCS.Close;
      qryColRCS.SQL.Clear;
      qryColRCS.SQL.Add('SELECT * FROM COLRCS WHERE FALSE');
      qryColRCS.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColRCS.Append;
          qryColRCS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLRCS', VS_strCodEmp);
          qryColRCS.FieldByName('RCS_CODEMP').AsString := VS_strCodEmp;
          qryColRCS.FieldByName('RCS_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColRCS.FieldByName('RCS_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColRCS.FieldByName('RCS_COLORD').AsInteger := intIndex;
          qryColRCS.FieldByName('RCS_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColRCS.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdRCS.Close;
      qryOrdRCS.SQL.Clear;
      qryOrdRCS.SQL.Add('DELETE FROM ORDRCS WHERE RCS_CODEMP = :CODEMP');
      qryOrdRCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdRCS.ExecSQL;

      qryOrdRCS.Close;
      qryOrdRCS.SQL.Clear;
      qryOrdRCS.SQL.Add('SELECT * FROM ORDRCS WHERE FALSE');
      qryOrdRCS.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdRCS.Append;
        qryOrdRCS.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDRCS', VS_strCodEmp);
        qryOrdRCS.FieldByName('RCS_CODEMP').AsString  := VS_strCodEmp;
        qryOrdRCS.FieldByName('RCS_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdRCS.FieldByName('RCS_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdRCS.FieldByName('RCS_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdRCS.FieldByName('RCS_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdRCS.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpRetornoConsig.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColRCS);
    FreeAndNil(qryOrdRCS);
  End;
end;

class procedure TCfgColExpRetornoConsig.pDefinirOrdenacaoSintet(cxgDados: TcxGridDBTableViewCitel);
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
    qryTmp.SQL.Add('SELECT * FROM ORDRCS          ');
    qryTmp.SQL.Add(' WHERE RCS_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY RCS_ORDCAM ');
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
          if qryTmp.FieldByName('RCS_ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := qryTmp.FieldByName('RCS_ORDNAM').AsString
            else
              strDescFields := strFields + ';' + qryTmp.FieldByName('RCS_ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := qryTmp.FieldByName('RCS_ORDNAM').AsString
          else
            strFields := strFields + ';' + qryTmp.FieldByName('RCS_ORDNAM').AsString ;

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

class procedure TCfgColExpRetornoConsig.pDefinirOrdenacaoAnalit(cxgDados: TcxGridDBTableViewCitel);
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
    qryTmp.SQL.Add('SELECT * FROM ORDRCA          ');
    qryTmp.SQL.Add(' WHERE RCA_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY RCA_ORDCAM ');
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
          if qryTmp.FieldByName('RCA_ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := qryTmp.FieldByName('RCA_ORDNAM').AsString
            else
              strDescFields := strFields + ';' + qryTmp.FieldByName('RCA_ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := qryTmp.FieldByName('RCA_ORDNAM').AsString
          else
            strFields := strFields + ';' + qryTmp.FieldByName('RCA_ORDNAM').AsString ;

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

class function TCfgColExpRetornoConsig.fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
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






end.
