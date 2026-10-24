unit untSaldosLojasProdutosAcabados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxProgressBar, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, Math;

type
  TCampos = Record
    Name        : String;
    DataType    : TFieldType;
    Size        : Integer;
    DisplayName : String;
  End;

type
  TfrmSaldosLojasProdutosAcabados = class(TfrmPai)
    cxItens     : TcxGrid;
    cxItensTblv : TcxGridDBTableView;
    cxItenslvl  : TcxGridLevel;
    dtsItens: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    arrCampos: array of TCampos;

    strEmp_CD : String;
    cdsSaldos : TUniClientDataSet;

    cdsFiltro: TUniClientDataSet;
    blnFiltrar: Boolean;

    function fCriaClientDataSet : TUniClientDataSet;
    procedure pCentralizar(cdsDados : TUniClientDataSet);

    function fPreencheClientDataSet(cxProgress: TcxProgressBar) : Boolean;
    procedure pInformaSaldo(strEmpEst : String; fltSaldo : Real = 0);

    function fCriarcxGrid(cxProgress : TcxProgressBar) : Boolean;
    function fBuscarSaldosLojas(cxProgress : TcxProgressBar): Boolean;
    function fGetSQL : String;

    procedure pAddCampo(Name        : String;
                        DataType    : TFieldType;
                        Size        : Integer;
                        DisplayName : String);

    function fGetTamanhoCampo(strCampo : String) : Integer;

  public
    procedure pCdsFiltro(const cdsConsulta: TUniClientDataSet);
    procedure pMostrarSaldoLojas;

  end;

implementation

uses
  untFuncoesGen, untGravando, untFuncoesSimples;

{$R *.dfm}

{ TfrmSaldosLojasProdutosAcabados }

function TfrmSaldosLojasProdutosAcabados.fBuscarSaldosLojas(cxProgress: TcxProgressBar): Boolean;
begin

  cdsSaldos := fCriaClientDataSet;
  Result := Assigned(cdsSaldos) And fCriarcxGrid(cxProgress) And fPreencheClientDataSet(cxProgress);

end;

function TfrmSaldosLojasProdutosAcabados.fCriaClientDataSet: TUniClientDataSet;
var
  qryEmpresas : TUniQuery;
  Field       : TFieldDef;
  i           : Integer;
begin

  FillChar(Result, SizeOf(arrCampos), #0);

  pAddCampo('IDEPRO', ftString,   3, 'Sigla');
  pAddCampo('CODIGO', ftString,  10, 'Código');
  pAddCampo('CODACA', ftString,   6, 'Código');
  pAddCampo('DESCRI', ftString, 100, 'Descrição');
  pAddCampo('SALLOG',  ftFloat,   0, 'Emp. Logada');
  pAddCampo('SAL_CD',  ftFloat,   0, 'CD');
  pAddCampo('EMPACA', ftString,   3, 'Empresa');
  pAddCampo('EMPEST', ftString,   3, 'Empresa Estoque');

  //Demais Empresas...
  qryEmpresas := fCriaQuery(Self);

  Try

    qryEmpresas.Close;
    qryEmpresas.SQL.Clear;
    qryEmpresas.SQL.Add('SELECT * FROM CADEMP ORDER BY EMP_CODEMP');
    qryEmpresas.Open;

    qryEmpresas.First;
    While Not qryEmpresas.Eof Do
    Begin

      If (qryEmpresas.FieldByName('EMP_CODEMP').AsString <> VS_strCodEmp) And
         (qryEmpresas.FieldByName('EMP_CODEMP').AsString <> strEmp_CD) Then
      Begin

        pAddCampo('SAL' + qryEmpresas.FieldByName('EMP_CODEMP').AsString,
                  ftFloat,
                  0,
                  qryEmpresas.FieldByName('EMP_CODEMP').AsString);

      End;

      qryEmpresas.Next;

    End;

  Finally
    FreeAndNil(qryEmpresas);
  End;

  Result := TUniClientDataSet.Create(Self);

  for i := 0 to Length(arrCampos) -1 do
  begin

    Field := Result.FieldDefs.AddFieldDef;
    Field.Name     := arrCampos[i].Name;
    Field.DataType := arrCampos[i].DataType;

    If (arrCampos[i].DataType = ftString) Then
      Field.Size := arrCampos[i].Size;

    Field.DisplayName := arrCampos[i].DisplayName;

  end;

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  {Centraliza}
  pCentralizar(Result);

end;

function TfrmSaldosLojasProdutosAcabados.fCriarcxGrid(cxProgress : TcxProgressBar) : Boolean;
var
  iCol : Integer;
begin

  If cdsSaldos.FieldCount <= 0 Then
    Exit(False);

  Try

    pInformacao('Aguarde...', cxProgress);

    cxProgress.Properties.Max := Length(arrCampos);
    cxProgress.Position       := 0;

    cxItensTblv.BeginUpdate;

    Try

      for iCol := 0 to Length(arrCampos) -1 do
      begin

        cxItensTblv.CreateColumn;
        cxItensTblv.Columns[iCol].Width                 := fGetTamanhoCampo(arrCampos[iCol].Name);
        cxItensTblv.Columns[iCol].DataBinding.FieldName := arrCampos[iCol].Name;
        cxItensTblv.Columns[iCol].Caption               := arrCampos[iCol].DisplayName;

        If (arrCampos[iCol].Name <> 'DESCRI') Then
          cxItensTblv.Columns[iCol].HeaderAlignmentHorz := taCenter;

        If (arrCampos[iCol].Name = 'EMPACA') Or
           (arrCampos[iCol].Name = 'EMPEST') Or
           (arrCampos[iCol].Name = 'CODACA') Then
          cxItensTblv.Columns[iCol].Visible := False;

        cxProgress.Position := cxProgress.Position + 1;

        If (Floor(cxProgress.Position) Mod 10) = 0 Then
          Application.ProcessMessages;

      end;

    Finally
      cxItensTblv.EndUpdate;
    End;

    Result := True;

  Except
    Result := False;
  End;

end;

function TfrmSaldosLojasProdutosAcabados.fGetSQL: String;
begin

  Result := '';
  Result := Result + 'SELECT * FROM (                                            ' +
                     'SELECT                                                     ' +
                     '  T.FDO_IDEPRO AS IDEPRO,                                  ' +
                     '  T.FDO_DESCRI AS DESCRI,                                  ' +
                     '  A.ACA_CODACA AS CODACA,                                  ' +
                     '  A.ACA_CODEMP AS EMPACA,                                  ' +
                     '  A.ACA_EMPEST AS EMPEST,                                  ' +
                     '  A.ACA_SALDOS AS SALDOS                                   ' +
                     'FROM                                                       ' +
                     '  ACAGER A                                                 ' +
                     '  INNER JOIN TINDOR T ON (T.FDO_CODACA = A.ACA_CODACA AND  ' +
                     '                          T.FDO_EMPACA = A.ACA_CODEMP)     ' +
                     'WHERE                                                      ' +
                     '  A.ACA_SALDOS <> 0                                        ' +

                     'UNION ALL                                                  ' +

                     'SELECT                                                     ' +
                     '  T.DET_IDEPRO AS IDEPRO,                                  ' +
                     '  T.DET_DESCRI AS DESCRI,                                  ' +
                     '  A.ACA_CODACA AS CODACA,                                  ' +
                     '  A.ACA_CODEMP AS EMPACA,                                  ' +
                     '  A.ACA_EMPEST AS EMPEST,                                  ' +
                     '  A.ACA_SALDOS AS SALDOS                                   ' +
                     'FROM                                                       ' +
                     '  ACAGER A                                                 ' +
                     '  INNER JOIN TINDET T ON (T.DET_CODACA = A.ACA_CODACA AND  ' +
                     '                          T.DET_EMPACA = A.ACA_CODEMP)     ' +
                     'WHERE                                                      ' +
                     '  A.ACA_SALDOS <> 0) AS TEMP                               ' +

                     'GROUP BY IDEPRO, DESCRI, CODACA, EMPACA, EMPEST, SALDOS    ';
end;

function TfrmSaldosLojasProdutosAcabados.fGetTamanhoCampo(strCampo: String): Integer;
begin
  Result := IIF(strCampo = 'DESCRI', 650, 80);
end;

procedure TfrmSaldosLojasProdutosAcabados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If Assigned(cdsSaldos) Then
    FreeAndNil(cdsSaldos);

  FreeAndNil(cdsFiltro);

  Action := caFree;

end;

procedure TfrmSaldosLojasProdutosAcabados.FormCreate(Sender: TObject);
begin
  inherited;
  cdsFiltro := TUniClientDataSet.Create(Nil);
  blnFiltrar := False;
  strEmp_CD := fCfgSis('EMP_CD', varString, VS_strCodEmp);
end;

function TfrmSaldosLojasProdutosAcabados.fPreencheClientDataSet(cxProgress: TcxProgressBar): Boolean;
Var
  qrySaldos : TUniQuery;
  strCodAca : String;
  strEmpAca : String;
begin

  pInformacao('Aguarde, consolidando dados...', cxProgress);

  qrySaldos := fCriaQuery(Self);
  cdsSaldos.DisableControls;

  Try

    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add(fGetSQL);
    qrySaldos.Open;

    cxProgress.Properties.Max := qrySaldos.RecordCount;
    cxProgress.Position       := 0;

    cdsSaldos.IndexFieldNames := 'CODACA;EMPACA';

    qrySaldos.First;
    While Not qrySaldos.Eof Do
    Begin

      strCodAca := qrySaldos.FieldByName('CODACA').AsString;
      strEmpAca := qrySaldos.FieldByName('EMPACA').AsString;

      if (blnFiltrar and cdsFiltro.Locate('ACA_CODACA', strCodAca, [])) or (not blnFiltrar) then
      begin

        If cdsSaldos.FindKey([strCodAca, strEmpAca]) Then
          cdsSaldos.Edit
        Else
        Begin
          cdsSaldos.Insert;
          cdsSaldos.FieldByName('IDEPRO').AsString := qrySaldos.FieldByName('IDEPRO').AsString;
          cdsSaldos.FieldByName('CODIGO').AsString := qrySaldos.FieldByName('CODACA').AsString + '-' + qrySaldos.FieldByName('EMPACA').AsString;
          cdsSaldos.FieldByName('CODACA').AsString := qrySaldos.FieldByName('CODACA').AsString;
          cdsSaldos.FieldByName('EMPACA').AsString := qrySaldos.FieldByName('EMPACA').AsString;
          cdsSaldos.FieldByName('EMPEST').AsString := qrySaldos.FieldByName('EMPEST').AsString;
          cdsSaldos.FieldByName('DESCRI').AsString := qrySaldos.FieldByName('DESCRI').AsString;
        End;

        pInformaSaldo(qrySaldos.FieldByName('EMPEST').AsString,
                      qrySaldos.FieldByName('SALDOS').AsFloat);

        cdsSaldos.Post;
      end;

      qrySaldos.Next;

      cxProgress.Position := cxProgress.Position + 1;

      If (Floor(cxProgress.Position) Mod 1000) = 0 Then
        Application.ProcessMessages;

    End;

    cdsSaldos.First;

    Result := Not cdsSaldos.IsEmpty;

    If (Result) Then
    Begin
      dtsItens.DataSet := cdsSaldos;
      cdsSaldos.IndexFieldNames := 'IDEPRO;DESCRI';
    End;

  Finally
    FreeAndNil(qrySaldos);
    cdsSaldos.EnableControls;
  End;

end;

procedure TfrmSaldosLojasProdutosAcabados.pAddCampo(Name: String; DataType: TFieldType; Size: Integer; DisplayName: String);
begin

  SetLength(arrCampos, Length(arrCampos)+1);

  arrCampos[Length(arrCampos)-1].Name        := Name;
  arrCampos[Length(arrCampos)-1].DataType    := DataType;
  arrCampos[Length(arrCampos)-1].Size        := Size;
  arrCampos[Length(arrCampos)-1].DisplayName := DisplayName;

end;

procedure TfrmSaldosLojasProdutosAcabados.pCdsFiltro(
  const cdsConsulta: TUniClientDataSet);
begin
  cdsFiltro.CloneCursor(cdsConsulta, True);
  blnFiltrar := True;
end;

procedure TfrmSaldosLojasProdutosAcabados.pCentralizar(cdsDados: TUniClientDataSet);
Var
  i : Integer;
begin
  if (cdsDados.FieldCount > 0) then
    for i := 0 to cdsDados.FieldCount -1 do
      if (cdsDados.Fields[i].FieldName <> 'DESCRI') then
        cdsDados.Fields[i].Alignment := taCenter;
end;

procedure TfrmSaldosLojasProdutosAcabados.pInformaSaldo(strEmpEst: String; fltSaldo: Real = 0);
begin

  {Empresa CD}
  If (strEmpEst = strEmp_CD) then
    cdsSaldos.FieldByName('SAL_CD').AsFloat := cdsSaldos.FieldByName('SAL_CD').AsFloat + fltSaldo

  Else

  {Empresa Logada}
  If (strEmpEst = VS_strCodEmp) then
    cdsSaldos.FieldByName('SALLOG').AsFloat := cdsSaldos.FieldByName('SALLOG').AsFloat + fltSaldo

  Else

  {Demais Empresas...}
  If cdsSaldos.FindField('SAL' + strEmpEst) <> Nil Then
    cdsSaldos.FieldByName('SAL' + strEmpEst).AsFloat := cdsSaldos.FieldByName('SAL' + strEmpEst).AsFloat + fltSaldo;

end;

procedure TfrmSaldosLojasProdutosAcabados.pMostrarSaldoLojas;
var
  frmGravando : TfrmGravando;
begin

  {Processamento/Consultas}
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando saldos...';
    frmGravando.fExecutarAcao := fBuscarSaldosLojas;
    frmGravando.ShowModal;
  Finally
    If Assigned(frmGravando) Then
      FreeAndNil(frmGravando);
  End;

end;

end.
