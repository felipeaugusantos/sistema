unit untCfgColExpFaturaConsig;

interface

uses DBGridCitel, Vcl.DBGrids, System.Classes, Datasnap.DBClient, UniClientDataSet, cxGridCitel,
     cxGridDBTableView;

type
  TrecColExpFaturaConsig = record
    strFieldName : String;
    strCaption : String;
    intWidth : Integer;
    blnVisible : Boolean;
    Alignment: TAlignment;
    intIndex : Integer;
  end;

type
  TArrayOfColExpFaturaConsig = Array Of TrecColExpFaturaConsig;

type
  TCfgColExpFaturaConsig = Class
  private
    class var arrColsDad : TArrayOfColExpFaturaConsig;
    class var arrColsDadAnalit : TArrayOfColExpFaturaConsig;
    class procedure pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
    class procedure pSalvaEstadoPadraoAnalit(cxgDados: TcxGridDBTableViewCitel);
  public
    class var arrColsOri : TArrayOfColExpFaturaConsig;
    class var arrColsOriAnalit : TArrayOfColExpFaturaConsig;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(cxgDados: TcxGridDBTableViewCitel; dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpFaturaConsig);
    class procedure pSalvarEstadoAnalit(cxgDados: TcxGridDBTableViewCitel; dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpFaturaConsig);
    class procedure pIniciar(cxgDados: TcxGridCitel;
                             cxgDadosView: TcxGridDBTableViewCitel);
    class procedure pIniciarAnalit(cxgDados: TcxGridCitel;
                                   cxgDadosView: TcxGridDBTableViewCitel);
    class procedure pSetaEstado(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpFaturaConsig);
    class procedure pSetaEstadoAnalit(dbgDados: TDBGridCitel; var arrCol : TArrayOfColExpFaturaConsig);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
    class procedure pSetarUltimosDadosCarregadosAnalit(dbgDados: TDBGridCitel);
    class procedure pSetarPadrao(dbgDados: TDBGridCitel);
    class procedure pSetarPadraoAnalit(dbgDados: TDBGridCitel);
    class function fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
    class procedure pGravarDadosNoBancoSintet(arrCol: TArrayOfColExpFaturaConsig; cdsOrd: TUniClientDataSet);
    class procedure pGravarDadosNoBancoAnalit(arrCol: TArrayOfColExpFaturaConsig; cdsOrd: TUniClientDataSet);
    class procedure pCarregarDadosSalvosSintet(cxgDados: TcxGridDBTableViewCitel);
    class procedure pCarregarDadosSalvosAnalit(cxgDados: TcxGridDBTableViewCitel);
    class procedure pDefinirOrdenacaoSintet(cxgDados: TcxGridDBTableViewCitel);
    class procedure pDefinirOrdenacaoAnalit(cxgDados: TcxGridDBTableViewCitel);

  End;

implementation

uses untFuncoesSimples, Uni, SysUtils, Data.Db;

{ TCfgColExpFaturaConsig }

class procedure TCfgColExpFaturaConsig.pIniciar(cxgDados: TcxGridCitel;
                                                cxgDadosView: TcxGridDBTableViewCitel);
begin
  intMaxWidthGrid := cxgDados.Width;
  pSalvaEstadoPadrao(cxgDadosView);
  pCarregarDadosSalvosSintet(cxgDadosView);
end;

class procedure TCfgColExpFaturaConsig.pIniciarAnalit(cxgDados: TcxGridCitel;
                                                    cxgDadosView: TcxGridDBTableViewCitel);
begin
  intMaxWidthGrid := cxgDados.Width;
  pSalvaEstadoPadraoAnalit(cxgDadosView);
  pCarregarDadosSalvosAnalit(cxgDadosView);
end;

class procedure TCfgColExpFaturaConsig.pSalvaEstadoPadrao(cxgDados: TcxGridDBTableViewCitel);
begin
  pSalvarEstado(cxgDados, nil, arrColsOri);
end;

class procedure TCfgColExpFaturaConsig.pSalvaEstadoPadraoAnalit(cxgDados: TcxGridDBTableViewCitel);
begin
  pSalvarEstadoAnalit(cxgDados, nil, arrColsOriAnalit);
end;

class procedure TCfgColExpFaturaConsig.pSalvarEstado(cxgDados: TcxGridDBTableViewCitel;
                                                   dbgDados: TDBGridCitel;
                                                   var arrCol : TArrayOfColExpFaturaConsig);
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

class procedure TCfgColExpFaturaConsig.pSalvarEstadoAnalit(cxgDados: TcxGridDBTableViewCitel;
                                                           dbgDados: TDBGridCitel;
                                                           var arrCol : TArrayOfColExpFaturaConsig);
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

class procedure TCfgColExpFaturaConsig.pSetaEstado(dbgDados: TDBGridCitel; var arrCol: TArrayOfColExpFaturaConsig);
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

class procedure TCfgColExpFaturaConsig.pSetaEstadoAnalit(dbgDados: TDBGridCitel; var arrCol: TArrayOfColExpFaturaConsig);
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

class procedure TCfgColExpFaturaConsig.pSetarPadrao(dbgDados: TDBGridCitel);
begin
  pSetaEstado(dbgDados, arrColsOri);
end;

class procedure TCfgColExpFaturaConsig.pSetarPadraoAnalit(dbgDados: TDBGridCitel);
begin
  pSetaEstadoAnalit(dbgDados, arrColsOriAnalit);
end;

class procedure TCfgColExpFaturaConsig.pSetarUltimosDadosCarregados(dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDad) > 0) Then
    pSetaEstado(dbgDados, arrColsDad);
end;

class procedure TCfgColExpFaturaConsig.pSetarUltimosDadosCarregadosAnalit( dbgDados: TDBGridCitel);
begin
  If (Length(arrColsDadanalit) > 0) Then
    pSetaEstadoAnalit(dbgDados, arrColsDadanalit);
end;

class procedure TCfgColExpFaturaConsig.pCarregarDadosSalvosAnalit(cxgDados: TcxGridDBTableViewCitel);
  Var
    intCnt : Integer;
    qryCOLFCA : TUniQuery;
    Coluna : TcxGridDBColumn;
    intIndex : Integer;
    DtaSource : TDataSource;
Begin
  pDefinirOrdenacaoAnalit(cxgDados) ;

  qryCOLFCA := fCriaQuery;
  Try
    qryCOLFCA.Close;
    qryCOLFCA.SQL.Clear;
    qryCOLFCA.SQL.Add(' SELECT * ');
    qryCOLFCA.SQL.Add('   FROM COLFCA ');
    qryCOLFCA.SQL.Add('  WHERE FCA_CODEMP = :CODEMP ');
    qryCOLFCA.SQL.Add('  ORDER BY FCA_COLORD ');
    qryCOLFCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCOLFCA.Open;

    SetLength(arrColsDadAnalit, 0);

    If Not qryCOLFCA.IsEmpty Then
    Begin
      DtaSource := cxgDados.DataController.DataSource;
      cxgDados.DataController.DataSource := Nil;
      Try
        For intCnt := 0 To cxgDados.ColumnCount -1 Do
          cxgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCOLFCA.First;
        While Not qryCOLFCA.Eof Do
        Begin
          Coluna := fFindColumnByNameCx(cxgDados, qryCOLFCA.FieldByName('FCA_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            {Tratando as colunas que dependem da configuração para serem exibidas - KM}
            If Pos(qryCOLFCA.FieldByName('FCA_COLNAM').AsString,'DET_DESCON_DET_VALUNI_DET_UNICAL_') > 0 Then
              Coluna.Visible := fCfgSis('VALFMC', varBoolean)
            Else
              Coluna.Visible := True;

            Coluna.Index := intIndex;
            Coluna.Caption := qryCOLFCA.FieldByName('FCA_COLCAP').AsString;
            Coluna.Width := qryCOLFCA.FieldByName('FCA_COLTAM').AsInteger;

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

          qryCOLFCA.Next;
        End;
      Finally
        cxgDados.DataController.DataSource := DtaSource;
      End;
    End;
  Finally
    FreeAndNil(qryCOLFCA);
  End;
end;

class procedure TCfgColExpFaturaConsig.pCarregarDadosSalvosSintet(cxgDados: TcxGridDBTableViewCitel);
  Var
    intCnt : Integer;
    qryCOLFCS : TUniQuery;
    Coluna : TcxGridDBColumn;
    intIndex : Integer;
    DtaSource : TDataSource;
Begin
  pDefinirOrdenacaoSintet(cxgDados) ;

  qryCOLFCS := fCriaQuery;
  Try
    qryCOLFCS.Close;
    qryCOLFCS.SQL.Clear;
    qryCOLFCS.SQL.Add(' SELECT * ');
    qryCOLFCS.SQL.Add('   FROM COLFCS ');
    qryCOLFCS.SQL.Add('  WHERE FCS_CODEMP = :CODEMP ');
    qryCOLFCS.SQL.Add('  ORDER BY FCS_COLORD ');
    qryCOLFCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCOLFCS.Open;

    SetLength(arrColsDad, 0);

    If Not qryCOLFCS.IsEmpty Then
    Begin
      DtaSource := cxgDados.DataController.DataSource;
      cxgDados.DataController.DataSource := Nil;
      Try
        For intCnt := 0 To cxgDados.ColumnCount -1 Do
          cxgDados.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCOLFCS.First;
        While Not qryCOLFCS.Eof Do
        Begin
          Coluna := fFindColumnByNameCx(cxgDados, qryCOLFCS.FieldByName('FCS_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            {Tratando as colunas que dependem da configuração para serem exibidas - KM}
            If Pos(qryCOLFCS.FieldByName('FCS_COLNAM').AsString,'DET_DESCON_DET_VALUNI_DET_UNICAL_') > 0 Then
              Coluna.Visible := fCfgSis('VALFMC', varBoolean)
            Else
              Coluna.Visible := True;

            Coluna.Index := intIndex;
            Coluna.Caption := qryCOLFCS.FieldByName('FCS_COLCAP').AsString;
            Coluna.Width := qryCOLFCS.FieldByName('FCS_COLTAM').AsInteger;

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

          qryCOLFCS.Next;
        End;
      Finally
        cxgDados.DataController.DataSource := DtaSource;
      End;
    End;
  Finally
    FreeAndNil(qryCOLFCS);
  End;
end;

class procedure TCfgColExpFaturaConsig.pGravarDadosNoBancoAnalit(arrCol: TArrayOfColExpFaturaConsig; cdsOrd: TUniClientDataSet);
  Var
    qryColFCA : TUniQuery;
    qryOrdFCA : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColFCA := fCriaQuery;
  qryOrdFCA := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryColFCA.Close;
      qryColFCA.SQL.Clear;
      qryColFCA.SQL.Add('DELETE FROM COLFCA WHERE FCA_CODEMP = :CODEMP');
      qryColFCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColFCA.ExecSQL;

      qryColFCA.Close;
      qryColFCA.SQL.Clear;
      qryColFCA.SQL.Add('SELECT * FROM COLFCA WHERE FALSE');
      qryColFCA.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColFCA.Append;
          qryColFCA.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLFCA', VS_strCodEmp);
          qryColFCA.FieldByName('FCA_CODEMP').AsString := VS_strCodEmp;
          qryColFCA.FieldByName('FCA_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColFCA.FieldByName('FCA_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColFCA.FieldByName('FCA_COLORD').AsInteger := intIndex;
          qryColFCA.FieldByName('FCA_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColFCA.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdFCA.Close;
      qryOrdFCA.SQL.Clear;
      qryOrdFCA.SQL.Add('DELETE FROM ORDFCA WHERE FCA_CODEMP = :CODEMP');
      qryOrdFCA.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdFCA.ExecSQL;

      qryOrdFCA.Close;
      qryOrdFCA.SQL.Clear;
      qryOrdFCA.SQL.Add('SELECT * FROM ORDFCA WHERE FALSE');
      qryOrdFCA.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdFCA.Append;
        qryOrdFCA.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDFCA', VS_strCodEmp);
        qryOrdFCA.FieldByName('FCA_CODEMP').AsString  := VS_strCodEmp;
        qryOrdFCA.FieldByName('FCA_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdFCA.FieldByName('FCA_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdFCA.FieldByName('FCA_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdFCA.FieldByName('FCA_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdFCA.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpFaturaConsig.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColFCA);
    FreeAndNil(qryOrdFCA);
  End;
end;
class procedure TCfgColExpFaturaConsig.pGravarDadosNoBancoSintet( arrCol: TArrayOfColExpFaturaConsig; cdsOrd: TUniClientDataSet);
  Var
    qryColFCS : TUniQuery;
    qryOrdFCS : TUniQuery;
    intCnt : Integer;
    intIndex : Integer;
begin
  qryColFCS := fCriaQuery;
  qryOrdFCS := fCriaQuery;

  fStartTransaction;
  Try
    Try
      qryColFCS.Close;
      qryColFCS.SQL.Clear;
      qryColFCS.SQL.Add('DELETE FROM COLFCS WHERE FCS_CODEMP = :CODEMP');
      qryColFCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColFCS.ExecSQL;

      qryColFCS.Close;
      qryColFCS.SQL.Clear;
      qryColFCS.SQL.Add('SELECT * FROM COLFCS WHERE FALSE');
      qryColFCS.Open;

      intIndex := 0;

      For intCnt := Low(arrCol) To High(arrCol) Do
      Begin
        If (arrCol[intCnt].blnVisible) Then
        Begin
          qryColFCS.Append;
          qryColFCS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLFCS', VS_strCodEmp);
          qryColFCS.FieldByName('FCS_CODEMP').AsString := VS_strCodEmp;
          qryColFCS.FieldByName('FCS_COLNAM').AsString := arrCol[intCnt].strFieldName;
          qryColFCS.FieldByName('FCS_COLCAP').AsString := arrCol[intCnt].strCaption;
          qryColFCS.FieldByName('FCS_COLORD').AsInteger := intIndex;
          qryColFCS.FieldByName('FCS_COLTAM').AsInteger := arrCol[intCnt].intWidth;
          qryColFCS.Post;

          intIndex := intIndex + 1;
        End;
      End;

      qryOrdFCS.Close;
      qryOrdFCS.SQL.Clear;
      qryOrdFCS.SQL.Add('DELETE FROM ORDFCS WHERE FCS_CODEMP = :CODEMP');
      qryOrdFCS.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdFCS.ExecSQL;

      qryOrdFCS.Close;
      qryOrdFCS.SQL.Clear;
      qryOrdFCS.SQL.Add('SELECT * FROM ORDFCS WHERE FALSE');
      qryOrdFCS.Open;

      cdsOrd.first;
      While not cdsOrd.eof do
      Begin
        qryOrdFCS.Append;
        qryOrdFCS.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ORDFCS', VS_strCodEmp);
        qryOrdFCS.FieldByName('FCS_CODEMP').AsString  := VS_strCodEmp;
        qryOrdFCS.FieldByName('FCS_ORDNAM').AsString  := cdsOrd.FieldByName('ORDNAM').AsString ;
        qryOrdFCS.FieldByName('FCS_ORDCAP').AsString  := cdsOrd.FieldByName('ORDCAP').AsString ;
        qryOrdFCS.FieldByName('FCS_ORDDSC').AsString  := cdsOrd.FieldByName('ORDDSC').AsString ;
        qryOrdFCS.FieldByName('FCS_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger ;
        qryOrdFCS.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColExpFaturaConsig.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryColFCS);
    FreeAndNil(qryOrdFCS);
  End;
end;

class procedure TCfgColExpFaturaConsig.pDefinirOrdenacaoSintet(cxgDados: TcxGridDBTableViewCitel);
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
    qryTmp.SQL.Add('SELECT * FROM ORDFCS          ');
    qryTmp.SQL.Add(' WHERE FCS_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY FCS_ORDCAM ');
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
          if qryTmp.FieldByName('FCS_ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := qryTmp.FieldByName('FCS_ORDNAM').AsString
            else
              strDescFields := strFields + ';' + qryTmp.FieldByName('FCS_ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := qryTmp.FieldByName('FCS_ORDNAM').AsString
          else
            strFields := strFields + ';' + qryTmp.FieldByName('FCS_ORDNAM').AsString ;

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

class procedure TCfgColExpFaturaConsig.pDefinirOrdenacaoAnalit(cxgDados: TcxGridDBTableViewCitel);
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
    qryTmp.SQL.Add('SELECT * FROM ORDFCA          ');
    qryTmp.SQL.Add(' WHERE FCA_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY FCA_ORDCAM ');
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
          if qryTmp.FieldByName('FCA_ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := qryTmp.FieldByName('FCA_ORDNAM').AsString
            else
              strDescFields := strFields + ';' + qryTmp.FieldByName('FCA_ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := qryTmp.FieldByName('FCA_ORDNAM').AsString
          else
            strFields := strFields + ';' + qryTmp.FieldByName('FCA_ORDNAM').AsString ;

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

class function TCfgColExpFaturaConsig.fFindColumnByNameCx(cxgDados: TcxGridDBTableViewCitel; strField: String): TcxGridDBColumn;
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
