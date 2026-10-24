unit untCfgColFlx;

interface

uses cxGrid, cxGridDBTableView, Vcl.DBGrids, System.Classes, SysUtils, Data.DB,
  Datasnap.DBClient, untcxGridDBBandedColumnHelper, UniClientDataSet, Uni, cxGridDBBandedTableView;

type
  TrecBandFlx = record
    strCaption: String;
    blnVisible: Boolean;
    intIndex  : Integer;
  end;

  TrecColFlx = record
    strFieldName: String;
    strCaption  : String;
    intWidth    : Integer;
    blnVisible  : Boolean;
    Alignment   : TAlignment;
    intIndex    : Integer;
    strBand     : String;
    strClassName: String;
  end;

type
  TArrayOfBandFlx = Array of TrecBandFlx;
  TArrayOfColFlx  = Array of TrecColFlx;

type
  TCfgColFlx = class
  private
    class var arrBandsDad: TArrayOfBandFlx;
    class var arrColsDad : TArrayOfColFlx;
    class procedure pSalvaEstadoPadrao(dbgDados: TcxGridDBBandedTableView);
  public
    class var arrBandsOri: TArrayOfBandFlx;
    class var arrColsOri : TArrayOfColFlx;
    class var intMaxWidthGrid : Integer;
    class var intUtiWidthGrid : Integer;
    class procedure pSalvarEstado(dbgDados: TcxGridDBBandedTableView; var arrBand: TArrayOfBandFlx; var arrCol: TArrayOfColFlx);
    class procedure pIniciar(const dbgDados: TcxGrid; dbgDadosView: TcxGridDBBandedTableView);
    class procedure pGravarDadosNoBanco(arrBand: TArrayOfBandFlx; arrCol: TArrayOfColFlx);
    class procedure pSetaEstado(dbgDados: TcxGridDBBandedTableView; var arrBand: TArrayOfBandFlx; var arrCol: TArrayOfColFlx);
    class procedure pSetarUltimosDadosCarregados(dbgDados: TcxGridDBBandedTableView);
    class procedure pSetarPadrao(dbgDados: TcxGridDBBandedTableView);
    class procedure pCarregarDadosSalvos(dbgDados: TcxGridDBBandedTableView);
  end;

implementation

{ TCfgColFlx }

uses
  cxGridBandedTableView, untFuncoesSimples, untTypesSistema;

class procedure TCfgColFlx.pCarregarDadosSalvos(dbgDados: TcxGridDBBandedTableView);
var
  intCnt   : Integer;
  qryGrpFlx: TUniQuery;
  qryColFlx: TUniQuery;
  LcxBand  : TcxGridBand;
  LcxColumn: TcxGridDBBandedColumn;
  intIxBand: Integer;
  intIxCol : Integer;
  DtaSource: TDataSource;
  LScroll: TprcScroll;
begin
  qryGrpFlx := fCriaQuery;
  qryColFlx := fCriaQuery;
  DtaSource := dbgDados.DataController.DataSource;
  pDisableControls(DtaSource.DataSet, LScroll);

  try
    dbgDados.DataController.DataSource := nil;

    qryGrpFlx.Close;
    qryGrpFlx.SQL.Clear;
    qryGrpFlx.SQL.Add('SELECT * ');
    qryGrpFlx.SQL.Add('FROM GRPFLX ');
    qryGrpFlx.SQL.Add('WHERE FLX_CODEMP = :CODEMP ');
    qryGrpFlx.SQL.Add('ORDER BY FLX_GRPORD ');
    qryGrpFlx.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGrpFlx.Open;

    if qryGrpFlx.IsEmpty then
      Exit;

    qryColFlx.SQL.Clear;
    qryColFlx.SQL.Add('SELECT * ');
    qryColFlx.SQL.Add('FROM COLFLX ');
    qryColFlx.SQL.Add('WHERE FLX_CODEMP = :CODEMP ');
    qryColFlx.SQL.Add('  AND FLX_SEQGRP = :SEQGRP ');
    qryColFlx.SQL.Add('ORDER BY FLX_COLORD ');

    qryGrpFlx.First;

    SetLength(arrBandsDad, 0);
    SetLength(arrColsDad, 0);

    for intCnt := 0 to dbgDados.ColumnCount -1 do
      dbgDados.Columns[intCnt].Visible := False;

    for intCnt := 0 to Pred(dbgDados.Bands.Count) do
      dbgDados.Bands[intCnt].Visible := False;

    intIxBand := 0;
    intUtiWidthGrid := 0;

    while not qryGrpFlx.Eof do
    begin
      LcxBand := TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgDados, qryGrpFlx.FieldByName('FLX_GRPCAP').AsString);

      if (LcxBand <> nil) then
      begin
        LcxBand.Visible := True;
        LcxBand.Index   := intIxBand;
        LcxBand.Caption := qryGrpFlx.FieldByName('FLX_GRPCAP').AsString;

        SetLength(arrBandsDad, Length(arrBandsDad) + 1);
        arrBandsDad[ Length(arrBandsDad)-1 ].strCaption := LcxBand.Caption;
        arrBandsDad[ Length(arrBandsDad)-1 ].blnVisible := LcxBand.Visible;
        arrBandsDad[ Length(arrBandsDad)-1 ].intIndex   := LcxBand.Index;

        qryColFlx.Close;
        qryColFlx.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryColFlx.ParamByName('SEQGRP').AsString := qryGrpFlx.FieldByName('AUTOINCREM').AsString;
        qryColFlx.Open;

        if not qryColFlx.IsEmpty then
        begin
          intIxCol := 0;

          qryColFlx.First;

          while not qryColFlx.Eof do
          begin
            LcxColumn := TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(dbgDados, qryColFlx.FieldByName('FLX_COLNAM').AsString);

            if (LcxColumn <> nil) then
            begin
              LcxColumn.Visible := True;
              LcxColumn.Position.ColIndex   := intIxCol;
              LcxColumn.Caption := qryColFlx.FieldByName('FLX_COLCAP').AsString;
              LcxColumn.Width   := qryColFlx.FieldByName('FLX_COLTAM').AsInteger;

              intUtiWidthGrid := intUtiWidthGrid + LcxColumn.Width;

              SetLength(arrColsDad, Length(arrColsDad) + 1);
              arrColsDad[ Length(arrColsDad)-1 ].strFieldName := LcxColumn.DataBinding.FieldName;
              arrColsDad[ Length(arrColsDad)-1 ].strCaption   := LcxColumn.Caption;
              arrColsDad[ Length(arrColsDad)-1 ].intWidth     := LcxColumn.Width;
              arrColsDad[ Length(arrColsDad)-1 ].blnVisible   := LcxColumn.Visible;
              arrColsDad[ Length(arrColsDad)-1 ].Alignment    := LcxColumn.DataBinding.Field.Alignment;
              arrColsDad[ Length(arrColsDad)-1 ].intIndex     := LcxColumn.Position.ColIndex;
              arrColsDad[ Length(arrColsDad)-1 ].strClassName := LcxColumn.PropertiesClassName;
              arrColsDad[ Length(arrColsDad)-1 ].strBand      := qryGrpFlx.FieldByName('FLX_GRPCAP').AsString;

              intIxCol := intIxCol + 1;
            end;

            qryColFlx.Next;
          end;
        end;

        intIxBand := intIxBand + 1;
      end;

      qryGrpFlx.Next;
    end;
  finally
    dbgDados.DataController.DataSource := DtaSource;
    pEnableControls(DtaSource.DataSet, LScroll);
    FreeAndNil(qryGrpFlx);
    FreeAndNil(qryColFlx);
  end;
end;

class procedure TCfgColFlx.pGravarDadosNoBanco(arrBand: TArrayOfBandFlx; arrCol: TArrayOfColFlx);
var
  qryGrpFlx: TUniQuery;
  qryColFlx: TUniQuery;
  intCntGrp: Integer;
  intCntCol: Integer;
  strSeqGrp: String;
begin
  qryGrpFlx := fCriaQuery;
  qryColFlx := fCriaQuery;

  fStartTransaction;

  try
    try
      qryColFlx.Close;
      qryColFlx.SQL.Clear;
      qryColFlx.SQL.Add('DELETE FROM COLFLX WHERE FLX_CODEMP = :CODEMP');
      qryColFlx.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryColFlx.ExecSQL;

      qryColFlx.Close;
      qryColFlx.SQL.Clear;
      qryColFlx.SQL.Add('SELECT * FROM COLFLX WHERE FALSE');
      qryColFlx.Open;

      qryGrpFlx.Close;
      qryGrpFlx.SQL.Clear;
      qryGrpFlx.SQL.Add('DELETE FROM GRPFLX WHERE FLX_CODEMP = :CODEMP');
      qryGrpFlx.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGrpFlx.ExecSQL;

      qryGrpFlx.Close;
      qryGrpFlx.SQL.Clear;
      qryGrpFlx.SQL.Add('SELECT * FROM GRPFLX WHERE FALSE');
      qryGrpFlx.Open;

      for intCntGrp := Low(arrBand) to High(arrBand) do
      begin
        if (arrBand[intCntGrp].blnVisible) then
        begin
          strSeqGrp := fRetAutoIncrem('GRPFLX', VS_strCodEmp);

          qryGrpFlx.Append;
          qryGrpFlx.FieldByName('AUTOINCREM').AsString  := strSeqGrp;
          qryGrpFlx.FieldByName('FLX_CODEMP').AsString  := VS_strCodEmp;
          qryGrpFlx.FieldByName('FLX_GRPCAP').AsString  := arrBand[intCntGrp].strCaption;
          qryGrpFlx.FieldByName('FLX_GRPORD').AsInteger := arrBand[intCntGrp].intIndex;
          qryGrpFlx.Post;

          for intCntCol := Low(arrCol) to High(arrCol) do
          begin
            if (arrCol[intCntCol].blnVisible) and (arrCol[intCntCol].strBand = arrBand[intCntGrp].strCaption) then
            begin
              qryColFlx.Append;
              qryColFlx.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('COLFLX', VS_strCodEmp);
              qryColFlx.FieldByName('FLX_SEQGRP').AsString  := strSeqGrp;
              qryColFlx.FieldByName('FLX_CODEMP').AsString  := VS_strCodEmp;
              qryColFlx.FieldByName('FLX_COLNAM').AsString  := arrCol[intCntCol].strFieldName;
              qryColFlx.FieldByName('FLX_COLCAP').AsString  := arrCol[intCntCol].strCaption;
              qryColFlx.FieldByName('FLX_COLORD').AsInteger := arrCol[intCntCol].intIndex;
              qryColFlx.FieldByName('FLX_COLTAM').AsInteger := arrCol[intCntCol].intWidth;
              qryColFlx.Post;
            end;
          end;
        end;
      end;

      fCommit;
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgColFlx.pGravarDadosNoBanco]');
      end;
    end;
  finally
    FreeAndNil(qryColFlx);
    FreeAndNil(qryGrpFlx);
  end;
end;

class procedure TCfgColFlx.pIniciar(const dbgDados: TcxGrid; dbgDadosView: TcxGridDBBandedTableView);
begin
  intMaxWidthGrid := dbgDados.Width;
  pSalvaEstadoPadrao(dbgDadosView);
  pCarregarDadosSalvos(dbgDadosView);
end;

class procedure TCfgColFlx.pSalvaEstadoPadrao(dbgDados: TcxGridDBBandedTableView);
begin
  pSalvarEstado(dbgDados, arrBandsOri, arrColsOri);
end;

class procedure TCfgColFlx.pSalvarEstado(dbgDados: TcxGridDBBandedTableView; var arrBand: TArrayOfBandFlx; var arrCol: TArrayOfColFlx);
var
  intCnt : Integer;
begin
  SetLength(arrBand, 0);
  SetLength(arrCol, 0);

  for intCnt := 0 to Pred(dbgDados.Bands.Count) do
  begin
    if not fEmptyStr(dbgDados.Bands[intCnt].Caption) then
    begin
      SetLength(arrBand, Length(arrBand) + 1);
      arrBand[Length(arrBand)-1].intIndex     := dbgDados.Bands[intCnt].Index;
      arrBand[Length(arrBand)-1].strCaption   := dbgDados.Bands[intCnt].Caption;
      arrBand[Length(arrBand)-1].blnVisible   := dbgDados.Bands[intCnt].Visible;
    end;
  end;

  for intCnt := 0 to Pred(dbgDados.ColumnCount) do
  begin
    if not fEmptyStr(dbgDados.Columns[intCnt].DataBinding.FieldName) then
    begin
      SetLength(arrCol, Length(arrCol) + 1);
      arrCol[Length(arrCol)-1].strBand      := dbgDados.Columns[intCnt].Position.Band.Caption;
      arrCol[Length(arrCol)-1].intIndex     := dbgDados.Columns[intCnt].Position.ColIndex;
      arrCol[Length(arrCol)-1].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
      arrCol[Length(arrCol)-1].strCaption   := dbgDados.Columns[intCnt].Caption;
      arrCol[Length(arrCol)-1].intWidth     := dbgDados.Columns[intCnt].Width;
      arrCol[Length(arrCol)-1].blnVisible   := dbgDados.Columns[intCnt].Visible;
      arrCol[Length(arrCol)-1].Alignment    := dbgDados.Columns[intCnt].DataBinding.Field.Alignment;
      arrCol[Length(arrCol)-1].strClassName := dbgDados.Columns[intCnt].PropertiesClassName;
    end;
  end;
end;

class procedure TCfgColFlx.pSetaEstado(dbgDados: TcxGridDBBandedTableView; var arrBand: TArrayOfBandFlx; var arrCol: TArrayOfColFlx);
var
  intCnt    : Integer;
  LcxBand   : TcxGridBand;
  LcxColumn : TcxGridDBBandedColumn;
  DataSource: TDataSource;
begin
  DataSource := dbgDados.DataController.DataSource;
  dbgDados.DataController.DataSource := Nil;

  try
    for intCnt := 0 to Pred(dbgDados.ColumnCount) do
      dbgDados.Columns[intCnt].Visible := False;

    for intCnt := 0 to Pred(dbgDados.Bands.Count) do
      dbgDados.Bands[intCnt].Visible := False;

    for intCnt := Low(arrBand) to High(arrBand) do
    begin
      if (arrBand[intCnt].blnVisible) then
      begin
        LcxBand := TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgDados, arrBand[intCnt].strCaption);

        if (LcxBand <> nil) then
        begin
          LcxBand.Index   := arrBand[intCnt].intIndex;
          LcxBand.Caption := arrBand[intCnt].strCaption;
          LcxBand.Visible := arrBand[intCnt].blnVisible;
        end;
      end;
    end;

    for intCnt := Low(arrCol) to High(arrCol) do
    begin
      if (arrCol[intCnt].blnVisible) then
      begin
        LcxColumn := TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(dbgDados, arrCol[intCnt].strFieldName);

        if (LcxColumn <> nil) then
        begin
          LcxColumn.Position.ColIndex           := arrCol[intCnt].intIndex;
          LcxColumn.DataBinding.FieldName       := arrCol[intCnt].strFieldName;
          LcxColumn.Caption                     := arrCol[intCnt].strCaption;
          LcxColumn.Width                       := arrCol[intCnt].intWidth;
          LcxColumn.Visible                     := arrCol[intCnt].blnVisible;
          LcxColumn.DataBinding.Field.Alignment := arrCol[intCnt].Alignment;
          LcxColumn.PropertiesClassName         := arrCol[intCnt].strClassName;
        end;
      end;
    end;
  finally
    dbgDados.DataController.DataSource := DataSource;
  end;
end;

class procedure TCfgColFlx.pSetarPadrao(dbgDados: TcxGridDBBandedTableView);
begin
  pSetaEstado(dbgDados, arrBandsOri, arrColsOri);
end;

class procedure TCfgColFlx.pSetarUltimosDadosCarregados(dbgDados: TcxGridDBBandedTableView);
begin
  if (Length(arrColsDad) > 0) then
    pSetaEstado(dbgDados, arrBandsDad, arrColsDad);
end;

end.
