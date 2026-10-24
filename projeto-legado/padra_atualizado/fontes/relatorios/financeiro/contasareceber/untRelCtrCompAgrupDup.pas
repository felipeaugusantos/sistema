unit untRelCtrCompAgrupDup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus,
  Uni, DB, UniClientDataSet, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  ComboBoxFocus;

type
  TfrmRelCtrCompAgrupDup = class(TfrmPaiRelatorio)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label20: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    dbgAgrupamentos: TDBGridCitel;
    Label2: TLabel;
    Label3: TLabel;
    edtNumAgr: TEditFocus;
    Label4: TLabel;
    cbxImpAG: TComboBoxFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbgAgrupamentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbgAgrupamentosDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    
    intRecAtu: Integer;

    cdsAgrup : TUniClientDataSet;
    dtsAgrup : TDataSource;

    procedure pBuscaAgrupamentos;
    procedure pMarcaDesmarca;
    procedure pAfterScrollCds(DataSet: TDataSet);
    procedure pLimparConsulta;

    function fVerificaNumAgr(strNumAgr: String): Boolean;
    procedure pCarregaEmpresaLogada;

  public
    { Public declarations }
    
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

uses untFuncoesSimples, untConsultas,
     untCtrAgrupDupRecibo, untPai, untTypesSistema;

{$R *.dfm}

procedure TfrmRelCtrCompAgrupDup.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCompAgrupDup.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtrCompAgrupDup.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumAgr) Then
    Begin
      If Not (fEmptyStr(edtNumAgr.Text)) Then
      Begin
        If fVerificaNumAgr(edtNumAgr.Text) Then
        Begin
          If (blnBuscaPorChave) Then
          Begin
            pBuscaAgrupamentos;
            blnMudarFoco := False;
            pSetFocus(dbgAgrupamentos);
          End;
        End
        Else
        Begin
          edtNumAgr.Clear;
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := 'TODOS';
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If ( blnBuscaPorChave ) Then
        Begin
          pBuscaAgrupamentos;
        End;  
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
        Result := True;
        If ( blnBuscaPorChave) Then
          pBuscaAgrupamentos;
      End;
    End;


    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
{    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    {Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
        Else If ( blnBuscaPorChave ) Then
        Begin
          pBuscaAgrupamentos;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser digitada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End;
    End;}

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtrCompAgrupDup.pBuscaAgrupamentos;
  Var
    strSql    : String;
    qryAgrup  : TUniQuery;
begin

  cdsAgrup.EmptyDataSet;

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE            ';
	strSql := strSql + '  	CTR_NUMAGR AS NUMAGR,        ';
	strSql := strSql + '  	CTR_CODCLI AS CODCLI,        ';
	strSql := strSql + '  	CLI_NOMCLI AS NOMCLI,        ';
	strSql := strSql + '  	CTR_EMPAGR AS EMPAGR,        ';
	strSql := strSql + '  	SUM(CTR_VALDUP+CTR_VALJUR) AS TOTAGR ';
	strSql := strSql + '  FROM                           ';
	strSql := strSql + '  	DUPAGR,                      ';
	strSql := strSql + '  	CADCLI                       ';
	strSql := strSql + '  WHERE                          ';
	strSql := strSql + '  	CLI_CODCLI = CTR_CODCLI	     ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSql := strSql + '  AND CTR_CODCLI = :CODCLI     ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSql := strSql + '  AND CTR_EMPAGR = :CODEMP     ';

  If Not fEmptyStr(edtNumAgr.Text) Then
    strSql := strSql + '  AND CTR_NUMAGR = :NUMAGR     ';

  strSql := strSql + '  GROUP BY                       ';
  strSql := strSql + '  	CTR_CODCLI,CTR_NUMAGR        ';
  strSql := strSql + '  ORDER BY                       ';
  strSql := strSql + '  	CTR_NUMAGR                   ';

  qryAgrup := fCriaQuery(Nil);

  With qryAgrup Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(edtNumAgr.Text) Then
      ParamByName('NUMAGR').AsString := edtNumAgr.Text;

    Open;

    If Not IsEmpty Then
    Begin

      First;

      dbgAgrupamentos.DataSource.DataSet.DisableControls;

      While Not Eof Do
      Begin
        cdsAgrup.Append;
        cdsAgrup.FieldByName('NUMAGR').AsString := FieldByName('NUMAGR').AsString;
        cdsAgrup.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
        cdsAgrup.FieldByName('NOMCLI').AsString := FieldByName('NOMCLI').AsString;
        cdsAgrup.FieldByName('EMPAGR').AsString := FieldByName('EMPAGR').AsString;
        cdsAgrup.FieldByName('TOTAGR').AsFloat  := FieldByName('TOTAGR').AsFloat;
        cdsAgrup.FieldByName('MARDES').AsString := 'N';
        cdsAgrup.Post;

        Next;

        Application.ProcessMessages;

      End;

      (cdsAgrup.FieldByName('TOTAGR') As TFloatField).DisplayFormat := '##,#0.00';

    End
    Else
      fMensagem('', 'Nenhum agrupamento foi encontrado !', ['&O K']);

    dtsAgrup.DataSet.First;
    dbgAgrupamentos.DataSource.Dataset.EnableControls;
  End;


  FreeAndNil(qryAgrup);

end;

procedure TfrmRelCtrCompAgrupDup.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumAgr);
end;

procedure TfrmRelCtrCompAgrupDup.FormCreate(Sender: TObject);
begin
  inherited;

  pCarregaEmpresaLogada;

  cdsAgrup := TUniClientDataSet.Create(Self);
  dtsAgrup := TDataSource.Create(Self);

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMAGR';
    DataType := ftString;
    Size := 12;
  End;

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMCLI';
    DataType := ftString;
    Size := 50;
  End;

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMPAGR';
    DataType := ftString;
    Size := 3;
  End;

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTAGR';
    DataType := ftFloat;
  End;

  With cdsAgrup.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MARDES';
    DataType := ftString;
    Size := 1;
  End;
  cdsAgrup.CreateDataSet;
  cdsAgrup.AfterScroll := pAfterScrollCds;

  dtsAgrup.DataSet := cdsAgrup;
  dbgAgrupamentos.DataSource := dtsAgrup;

  edtNumAgr.MaxLength := fTamDocCadRec();
  edtNumAgr.TamCampo  := edtNumAgr.MaxLength;
end;

procedure TfrmRelCtrCompAgrupDup.pAfterScrollCds(DataSet: TDataSet);
begin
  intRecAtu := cdsAgrup.RecNo;
end;

procedure TfrmRelCtrCompAgrupDup.pMarcaDesmarca;
begin

  With cdsAgrup Do
  Begin

    If IsEmpty Then
      Exit;

    If FieldByName('MARDES').AsString = 'S' Then
    Begin
      Edit;
      FieldByName('MARDES').AsString := 'N';
      Post;
    End
    Else
    Begin
      Edit;
      FieldByName('MARDES').AsString := 'S';
      Post;
    End;

  End;

end;

procedure TfrmRelCtrCompAgrupDup.dbgAgrupamentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With cdsAgrup Do
  Begin

    If Not Active Then
      Exit;

    If FieldByName('MARDES').AsString = 'S' Then
    Begin
      If (intRecAtu = RecNo) Then
        dbgAgrupamentos.Canvas.Font.Color := clLime
      Else
        dbgAgrupamentos.Canvas.Font.Color := clBlue;
    End;

  End;

  dbgAgrupamentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  ShowScrollBar(dbgAgrupamentos.Handle,SB_VERT,True);

end;

procedure TfrmRelCtrCompAgrupDup.pLimparConsulta;
begin
  edtNumAgr.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  Self.SelectFirst;
  cdsAgrup.EmptyDataSet;
  pCarregaEmpresaLogada;
end;

procedure TFrmRelCtrCompAgrupDup.pCarregaEmpresaLogada;
begin
  edtCodEmp.Text := VS_strCodEmp;

  If (fEmptyStr(edtCodEmp.Text)) Then
    edtNomEmp.Text := 'TODOS'
  Else
   edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  If fEmptyStr(edtNomEmp.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
    pSetFocus(edtCodEmp);
  End
  Else
    pSetFocus(edtNumAgr);
end;


procedure TfrmRelCtrCompAgrupDup.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    If (Sender = dbgAgrupamentos) Then
      pLimparConsulta;
  End;

  If Key = VK_RETURN Then
  Begin
    If (sender = dbgAgrupamentos) Then
      pMarcaDesmarca;
  End;

end;

procedure TfrmRelCtrCompAgrupDup.FormShow(Sender: TObject);
begin
  inherited;
  Self.SelectFirst;
  edtCodEmp.Text := VS_strCodEmp;
end;

procedure TfrmRelCtrCompAgrupDup.btnImprimirClick(Sender: TObject);
  Var
    stlAgrup : TStringList;
    stlEmpre : TStringList;
    stlClien : TStringList;
begin
  inherited;

  stlAgrup := TStringList.Create;
  stlEmpre := TStringList.Create;
  stlClien := TStringList.Create;

  With cdsAgrup Do
  Begin

    If Not IsEmpty Then
    Begin


      dbgAgrupamentos.DataSource.DataSet.DisableControls;

      First;



      While Not Eof Do
      Begin
        If FieldByName('MARDES').AsString = 'S' Then
        Begin
          stlAgrup.Add(FieldByName('NUMAGR').AsString) ;
          stlEmpre.Add(FieldByName('EMPAGR').AsString) ;
          stlClien.Add(FieldByName('CODCLI').AsString) ;
        End;

        Next;

      End;

      First;
      dbgAgrupamentos.DataSource.DataSet.EnableControls;


      If stlAgrup.Count = 0 Then
        fMensagem('', 'Nenhum agrupamento foi selecionado !', ['&O K'])
      Else If fMensagem('','Deseja imprimir o(s) comprovante(s) ?', ['','']) = 1 Then
      Begin
        Try
          pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
          frmCtrAgrupDupRecibo.blnImprimePorNomCli := IIF(cbxImpAG.ItemIndex = 0, False, True);
          frmCtrAgrupDupRecibo.pImprimeComprovante(FieldByName('NUMAGR').AsString, Self.Name, stlAgrup, stlEmpre,stlClien);

        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[Erro ao tentar reimprimir comprovante agrupamento duplicatas]');
        End;

        pFreeAndNil(frmCtrAgrupDupRecibo);
        pLimparConsulta;

      End;

    End
    Else
    Begin
      fMensagem('', 'Não há registros para gerar impressão !', ['&O K']);
    End;

  End;

  FreeAndNil(stlAgrup);
  FreeAndNil(stlEmpre);
  pFreeAndNil(stlClien);

end;

procedure TfrmRelCtrCompAgrupDup.dbgAgrupamentosDblClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarca;

end;

function TfrmRelCtrCompAgrupDup.fVerificaNumAgr(strNumAgr: String): Boolean;
  Var
    strSQL : String;
    qryGen : TUniQuery;
begin

  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUPAGR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR ';

  if Not fEmptyStr(edtCodEmp.text) then
  begin
    strSQL := strSQL + '  AND CTR_EMPAGR = :EMPAGR ';
    strSQL := strSQL + '  GROUP BY  CTR_CODCLI     ';
  end;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if Not fEmptyStr(edtCodEmp.Text) then
      ParamByName('EMPAGR').AsString := edtCodEmp.Text;

    ParamByName('NUMAGR').AsString := strNumAgr;
    Open;

    If Not IsEmpty Then
    Begin
      Result := True;
      If (RecordCount = 1) Then
      Begin
        edtCodCli.Text := FieldByName('CTR_CODCLI').AsString;
        edtCodEmp.Text := FieldByName('CTR_EMPAGR').AsString;
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('', 'Não existe um agrupamento com esse número!', ['&O k']);
    End;

  End;

  qryGen.Close;
  FreeAndNil(qryGen);

end;

end.
