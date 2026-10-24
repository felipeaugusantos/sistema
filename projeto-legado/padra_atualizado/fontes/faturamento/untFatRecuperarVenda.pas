unit untFatRecuperarVenda;

interface

uses System.SysUtils, System.Classes, System.StrUtils, Vcl.Forms, Vcl.Controls,
  Data.DB, UniClientDataSet, Uni, System.UITypes, Variants, Shared.Functions.DataSet;

type
  TRecuperarVenda = class sealed
  private
    FTabGer: String;
    FTabDet: String;
    FFrmVen: TForm;
    FObjVen: Pointer;
    FCdsVen: TUniClientDataSet;
    FEnabled: Boolean;
    FDelTab: Boolean;
    FCliCsn: String;
    FTmpTabGer: String;
    FTmpTabDet: String;
    FPixNaTela: String;
  private
    function fGetEditText(const aFrm: TForm; const AName: String): String;
    function fGetCamposFormulario(const aFrm: TForm): String;
    function fGetMatrizCalcFlex: String;
    function fGetSubItensVidro(AIndex: Integer): String;
    function fGetMatrizColorantes(AIndex: Integer): String;
    function fSetCamposFormulario(const AFrmVal: String; var aFrm: TForm): String;
    function fRestaurarVenda(ATabGer: String): Boolean;
    function fValidouPrincipaisDadosDaVenda(strFrmVal: String): Boolean;
    procedure pRecuperaMatrizFormulacaoTinta(qryQuery: TUniQuery);
    procedure pRecuperaSubItensDoVidro(qryQuery: TUniQuery);
    function fRegistroCdsValido : Boolean;
  private
    procedure pCriarTabelas;
    procedure pExcluirItem;
    procedure pCdsVendaAfterPost(ADataset: TDataset);
    procedure pCdsVendaBeforeDelete(ADataset: TDataset);
    function fAdicionaVendaQueNaoFoiFinalizadaCorretamente(strTabGer: String; AFields: IMyCampoTabela; strTabFields: String): Boolean;
    function fValidaValDoc(strTabFields: String; AFields: IMyCampoTabela): Boolean;
    function fValidaNaoFinalizadoRecebidoPorPixQRCode(strTabFields: String; AFields: IMyCampoTabela): Boolean;
    function fExisteVendaNaoFinalizadaPixQRCode(const AShowTables: String): Boolean;
    procedure pAtualizarDadosItemReplaceGeral;
    function fBindValue(const AValue: Variant; const ADataType: TFieldType) : String;
  public
    constructor Create(AForm: TForm; AFatVenda: Pointer; ADataset: TUniClientDataSet; const AHabilitado : Boolean);
    destructor Destroy; override;
  public
    function fRecuperarVendaNaoFinalizada: Boolean;
  public
    procedure pGetDadosClienteConsumidor(const aFrm: TForm);
    procedure pSetDadosClienteConsumidor(var aFrm: TForm);

    procedure pAtualizarDadosGerais;
    procedure pAtualizarDadosItem;
    procedure pAtualizarDadosItensPixQRCode;

    procedure pDisableEventHandlers();
    procedure pEnableEventHandlers(blnDoAfterPost: Boolean = False; blnDoBeforeDelete:Boolean = False);
    procedure pCarregarVendaParaRecuperacao;
  public
    property Habilitado: Boolean read FEnabled write FEnabled;
    property ExcluirTabelasAoFinalizar: Boolean read FDelTab write FDelTab;
    property TmpTabGer: String read FTmpTabGer write FTmpTabGer;
    property TmpTabDet: String read FTmpTabDet write FTmpTabDet;
    property PixNaTela: String read FPixNaTela write FPixNaTela;
  end;

implementation

uses
  untFuncoesSimples, EditFocus, MaskEditFocus, ComboBoxFocus, Vcl.StdCtrls,
  Vcl.ExtCtrls, untFatRecuperarVendaSelec, untPai, untTMatrizSaldosColorantes,
  untFuncFat, untFatDigEstruturaVidro, untFatEstruturaVidro,
  untFuncFatTypes, untConstantes;

{ TRecuperarVenda }

constructor TRecuperarVenda.Create(AForm: TForm; AFatVenda: Pointer;
  ADataset: TUniClientDataSet; const AHabilitado : Boolean);
var
  LTabKey: String;
begin
  FEnabled := AHabilitado;
  FDelTab := True;
  FFrmVen := AForm;
  FCdsVen := ADataset;
  FObjVen := AFatVenda;
  FPixNaTela := 'N';
  FCliCsn := '';
  repeat
    LTabKey := FormatDateTime('yyyymmddhhnnsszzz', fNow());
    LTabKey := Concat(Trim(VS_strCodEmp), Trim(strLoginUsuarioLogado), LTabKey);
    FTabGer := Format('TMP_RECUP_VENDA_GER_%s', [LTabKey]);
    FTabDet := Format('TMP_RECUP_VENDA_DET_%s', [LTabKey]);
  until not fTabelaExiste(FTabGer);
  Self.pCriarTabelas;
  Self.FCdsVen.AfterPost := Self.pCdsVendaAfterPost;
  Self.FCdsVen.BeforeDelete := Self.pCdsVendaBeforeDelete;
end;

destructor TRecuperarVenda.Destroy;
begin
  Self.FCdsVen.AfterPost := nil;
  Self.FCdsVen.BeforeDelete := nil;
  if Self.ExcluirTabelasAoFinalizar then
  begin
    fDropTable(FTabGer);
    fDropTable(FTabDet);
  end;
  inherited;
end;

function TRecuperarVenda.fGetCamposFormulario(const aFrm: TForm): String;
var
  LLista: TStringList;
  LIndice: Integer;
Begin
  LLista := TStringList.Create;
  try
    for LIndice := 0 to aFrm.ComponentCount - 1 do
    begin
      if aFrm.Components[LIndice] is TEditFocus then
        LLista.Add(String(aFrm.Components[LIndice].Name + ':' +
          TEditFocus(aFrm.Components[LIndice]).Text)
            .Replace(#13, ' ').Replace(#10, ' '))

      else if aFrm.Components[LIndice] is TMaskEditFocus then
        LLista.Add(String(aFrm.Components[LIndice].Name + ':' +
          TMaskEditFocus(aFrm.Components[LIndice]).Text)
            .Replace(#13, ' ').Replace(#10, ' '))

      else if aFrm.Components[LIndice] is TCheckBox then
        LLista.Add(aFrm.Components[LIndice].Name + ':' +
          IIF(TCheckBox(aFrm.Components[LIndice]).Checked, 'T', 'F'))

      else if aFrm.Components[LIndice] is TRadioButton then
        LLista.Add(aFrm.Components[LIndice].Name + ':' +
          IIF(TRadioButton(aFrm.Components[LIndice]).Checked, 'T', 'F'))

      else if aFrm.Components[LIndice] is TComboBoxFocus then
        LLista.Add(aFrm.Components[LIndice].Name + ':' +
          TComboBoxFocus(aFrm.Components[LIndice]).ItemIndex.ToString)

      else if aFrm.Components[LIndice] is TRadioGroup then
        LLista.Add(aFrm.Components[LIndice].Name + ':' +
          TRadioGroup(aFrm.Components[LIndice]).ItemIndex.ToString);
    end;
    Result := LLista.Text;
  finally
    FreeAndNil(LLista);
  end;
end;

function TRecuperarVenda.fGetEditText(const aFrm: TForm; const AName: String): String;
begin
  Result := EmptyStr;
  if aFrm.FindComponent(AName) <> nil then
    Result := TEdit(aFrm.FindComponent(AName)).Text;
end;

function TRecuperarVenda.fGetSubItensVidro(AIndex: Integer): String;
begin
  Result := EmptyStr;
  if Assigned(TFatVenda(FObjVen).objEstruturaVidros) then
    if TFatVenda(FObjVen).objEstruturaVidros.dicEstruturasSalvas.ContainsKey
      (AIndex) then
      Result := TFatVenda(FObjVen).objEstruturaVidros.dicEstruturasSalvas
        [AIndex].ToJsonString;
end;

function TRecuperarVenda.fGetMatrizCalcFlex: String;
begin
  Result := TFatVenda(FObjVen).objMatrizCalcFlex.ToJsonString;
end;

function TRecuperarVenda.fGetMatrizColorantes(AIndex: Integer): String;
begin
  Result := EmptyStr;
  if Assigned(TFatVenda(FObjVen).dicFormulas.RetornaObjeto(AIndex.ToString))
  then
    Result := TClassMatrizSaldosColorantes(TFatVenda(FObjVen)
      .dicFormulas.RetornaObjeto(AIndex.ToString)).ToJsonString;
end;

function TRecuperarVenda.fSetCamposFormulario(const AFrmVal: String; var aFrm: TForm): String;
var
  LComp: String;
  LName: String;
  LValue: String;
  LLista: TStringList;
  LObject: TObject;
Begin
  LLista := TStringList.Create;
  try
    LLista.Text := AFrmVal;
    for LComp in LLista do
    begin
      if not LComp.Contains(':') then
        Continue;

      LName := LComp.Split([':'])[0];
      LValue := LComp.Replace(Concat(LName, ':'), EmptyStr);

      LObject := aFrm.FindComponent(LName);

      if not Assigned(LObject) then
        Continue;

      if LObject is TEditFocus then
        TEditFocus(LObject).Text := LValue

      else if LObject is TMaskEditFocus then
        TMaskEditFocus(LObject).Text := LValue

      else if LObject is TCheckBox then
        TCheckBox(LObject).Checked := LValue.Equals('T')

      else if LObject is TRadioButton then
        TRadioButton(LObject).Checked := LValue.Equals('T')

      else if LObject is TComboBoxFocus then
        TComboBoxFocus(LObject).ItemIndex := LValue.ToInteger()

      else if LObject is TRadioGroup then
        TRadioGroup(LObject).ItemIndex := LValue.ToInteger();
    end;
  finally
    FreeAndNil(LLista);
  end;
end;

function TRecuperarVenda.fValidaNaoFinalizadoRecebidoPorPixQRCode(
  strTabFields: String; AFields: IMyCampoTabela): Boolean;
begin
  Result := False;

  if strTabFields.Contains('RCV_PIXTEL') Then
    Result := AFields.FieldByName('RCV_PIXTEL').AsString.Equals('S');
end;

function TRecuperarVenda.fValidaValDoc(strTabFields: String; AFields: IMyCampoTabela): Boolean;
begin
  Result := True;
  if strTabFields.Contains('RCV_VALDOC') then
    if AFields.FieldByName('RCV_VALDOC').AsFloat = 0 then
      Result := False;
end;

procedure TRecuperarVenda.pGetDadosClienteConsumidor(const aFrm: TForm);
begin
  FCliCsn := fGetCamposFormulario(aFrm);
end;

procedure TRecuperarVenda.pSetDadosClienteConsumidor(var aFrm: TForm);
begin
  If (Pos(':', FCliCsn) > 0) Then
    fSetCamposFormulario(FCliCsn, aFrm);
end;

procedure TRecuperarVenda.pAtualizarDadosGerais;
var
  LQuery: TUniQuery;
  LModify: Boolean;
  LField: TField;
begin
  if not FEnabled then
    exit;
  if not fTabelaExiste(FTabGer) then pCriarTabelas;
  LQuery := fCriarQuery('SELECT * FROM ' + FTabGer, nil);
  try
    LQuery.Open;
    If LQuery.IsEmpty Then
      LQuery.Append
    Else
      LQuery.Edit;
    LQuery.FieldByName('RCV_OPCDOC').AsString := TFatVenda(FObjVen).strOpcDoc;
    LQuery.FieldByName('RCV_CODCLI').AsString := TFatVenda(FObjVen).strCodCli;
    LQuery.FieldByName('RCV_NUMDOC').AsString := TFatVenda(FObjVen).strNumOrc;
    LQuery.FieldByName('RCV_ESPDOC').AsString := TFatVenda(FObjVen).strEspOrc;
    LQuery.FieldByName('RCV_EMPDOC').AsString := TFatVenda(FObjVen).strEmpOri;
    LQuery.FieldByName('RCV_VALDOC').AsFloat  := fStrToFloat(fGetEditText(FFrmVen, 'edtTotGer'));
    LQuery.FieldByName('RCV_FRMVAL').AsString := fGetCamposFormulario(FFrmVen);
    LQuery.FieldByName('RCV_FRMCNS').AsString := FCliCsn;
    LQuery.FieldByName('RCV_MATFLE').AsString := fGetMatrizCalcFlex;
    LQuery.FieldByName('RCV_DTABKP').AsDateTime := fNow();
    LQuery.FieldByName('RCV_PIXTEL').AsString := FPixNaTela;
    LModify := False;
    for LField in LQuery.Fields do
      if LField.Value <> LField.OldValue then
        LModify := True;
    if LModify then
      LQuery.Post
    else
      LQuery.Cancel;
  finally
    LQuery.Free;
  end;
end;

procedure TRecuperarVenda.pAtualizarDadosItem;
var
  LQuery: TUniQuery;
  LField: TField;
  LModify: Boolean;
  LObjCol: String;
  LObjVid: String;
begin
  If (Not fRegistroCdsValido) Then
    Exit;
  if not fTabelaExiste(FTabDet) then pCriarTabelas;
  LQuery := fCriaQuery(nil);
  try
    LQuery.SQL.Text := 'SELECT * FROM ' + FTabDet + ' WHERE AUTOINCREM = ' +
      FCdsVen.FieldByName('AUTOINCREM').AsString;
    LQuery.Open;

    if LQuery.IsEmpty then
      LQuery.Append
    else
      LQuery.Edit;

    LModify := False;
    for LField in FCdsVen.Fields do
      if LQuery.FindField(LField.FieldName) <> nil then
        if LQuery.FieldByName(LField.FieldName).Value <> LField.Value then
        begin
          LQuery.FieldByName(LField.FieldName).Value := LField.Value;
          LModify := True;
        end;

    LObjCol := fGetMatrizColorantes(FCdsVen.FieldByName('AUTOINCREM')
      .AsInteger);

    if LQuery.FieldByName('ITE_OBJCOL').Value <> LObjCol then
    begin
      LQuery.FieldByName('ITE_OBJCOL').Value := LObjCol;
      LModify := True;
    end;

    LObjVid := fGetSubItensVidro(FCdsVen.FieldByName('AUTOINCREM').AsInteger);

    if LQuery.FieldByName('ITE_OBJVID').Value <> LObjVid then
    begin
      LQuery.FieldByName('ITE_OBJVID').Value := LObjVid;
      LModify := True;
    end;

    if LModify then
      LQuery.Post
    else
      LQuery.Cancel;
  finally
    LQuery.Free;
  end;
end;

procedure TRecuperarVenda.pAtualizarDadosItensPixQRCode;
var
  LQuery: TUniQuery;
  LField: TField;
  LModify: Boolean;
  LObjCol: String;
  LObjVid: String;

  LRecNo: Integer;
begin
  If (Not fRegistroCdsValido) Then
    Exit;
  if not fTabelaExiste(FTabDet) then pCriarTabelas;

  LRecNo := FCdsVen.RecNo;
  LQuery := fCriaQuery(nil);
  try
    FCdsVen.First;
    While Not FCdsVen.Eof Do
    Begin
      LQuery.Close;
      LQuery.SQL.Text := 'SELECT * FROM ' + FTabDet + ' WHERE AUTOINCREM = ' +
        FCdsVen.FieldByName('AUTOINCREM').AsString;
      LQuery.Open;

      if LQuery.IsEmpty then
        LQuery.Append
      else
        LQuery.Edit;

      LModify := False;
      for LField in FCdsVen.Fields do
        if LQuery.FindField(LField.FieldName) <> nil then
          if LQuery.FieldByName(LField.FieldName).Value <> LField.Value then
          begin
            LQuery.FieldByName(LField.FieldName).Value := LField.Value;
            LModify := True;
          end;

      LObjCol := fGetMatrizColorantes(FCdsVen.FieldByName('AUTOINCREM')
        .AsInteger);

      if LQuery.FieldByName('ITE_OBJCOL').Value <> LObjCol then
      begin
        LQuery.FieldByName('ITE_OBJCOL').Value := LObjCol;
        LModify := True;
      end;

      LObjVid := fGetSubItensVidro(FCdsVen.FieldByName('AUTOINCREM').AsInteger);

      if LQuery.FieldByName('ITE_OBJVID').Value <> LObjVid then
      begin
        LQuery.FieldByName('ITE_OBJVID').Value := LObjVid;
        LModify := True;
      end;

      if LModify then
        LQuery.Post
      else
        LQuery.Cancel;

      FCdsVen.Next;
    End;
  finally
    FCdsVen.RecNo := LRecNo;
    LQuery.Free;
  end;
end;

procedure TRecuperarVenda.pCdsVendaAfterPost(ADataset: TDataset);
begin
  if not FEnabled then
    exit;
  pAtualizarDadosItem;
  pAtualizarDadosGerais;
end;

procedure TRecuperarVenda.pCdsVendaBeforeDelete(ADataset: TDataset);
begin
  if not FEnabled then
    exit;
  pExcluirItem;
  pAtualizarDadosGerais;
end;

procedure TRecuperarVenda.pCriarTabelas;
const
  SQL_CREATE_TABLE = 'CREATE TABLE %s (%s) ENGINE MYISAM';
  SQL_PRIMARY_KEY = 'ALTER TABLE %s ADD PRIMARY KEY (%s)';
var
  LCampo: String;
  LCampos: String;
  LField: TField;
begin
  LCampos := EmptyStr;
  LCampos := LCampos + ' RCV_OPCDOC CHAR(2), ';
  LCampos := LCampos + ' RCV_CODCLI VARCHAR (8), ';
  LCampos := LCampos + ' RCV_NUMDOC VARCHAR (12), ';
  LCampos := LCampos + ' RCV_ESPDOC CHAR(2), ';
  LCampos := LCampos + ' RCV_EMPDOC CHAR(3), ';
  LCampos := LCampos + ' RCV_VALDOC DECIMAL(12,2), ';
  LCampos := LCampos + ' RCV_FRMVAL TEXT, ';
  LCampos := LCampos + ' RCV_FRMCNS TEXT, ';
  LCampos := LCampos + ' RCV_MATFLE TEXT, ';
  LCampos := LCampos + ' RCV_DTABKP DATETIME, ';
  LCampos := LCampos + ' RCV_PIXTEL VARCHAR(1)';

  if not fTabelaExiste(FTabGer) then
    fExecutaSQL(Format(SQL_CREATE_TABLE, [FTabGer, LCampos]), True);

  FTmpTabGer := FTabGer;

  LCampos := EmptyStr;

  for LField in FCdsVen.Fields do
  begin
    case LField.DataType of
      ftString:
        LCampo := LField.FieldName + ' VARCHAR(' + LField.Size.ToString + ') ';
      ftMemo:
        LCampo := LField.FieldName + ' TEXT ';
      ftDate:
        LCampo := LField.FieldName + ' DATE ';
      ftTime:
        LCampo := LField.FieldName + ' TIME ';
      ftDateTime:
        LCampo := LField.FieldName + ' DATETIME ';
      ftBoolean:
        LCampo := LField.FieldName + ' TINYINT(11) ';
      ftInteger:
        LCampo := LField.FieldName + ' INT(11) ';
      ftFloat:
        LCampo := LField.FieldName + ' DECIMAL(18,8) ';
    else
      raise Exception.Create('Unknown LField.DataType');
    end;
    if not LCampos.IsEmpty then
      LCampos := LCampos + ', ';
    LCampos := LCampos + LCampo;
  end;

  If fEmptyStr(LCampos) Then
    LCampos := 'ITE_OBJCOL TEXT '
  Else
    LCampos := LCampos + ', ITE_OBJCOL TEXT ';

  LCampos := LCampos + ', ITE_OBJVID TEXT ';

  if not fTabelaExiste(FTabDet) then
  begin
    fExecutaSQL(Format(SQL_CREATE_TABLE, [FTabDet, LCampos]), True);
    fExecutaSQL(Format(SQL_PRIMARY_KEY, [FTabDet, 'AUTOINCREM']), True);
  end;

  FTmpTabDet := FTabDet;
end;

procedure TRecuperarVenda.pDisableEventHandlers;
begin
  Self.FCdsVen.AfterPost    := Nil;
  Self.FCdsVen.BeforeDelete := Nil;
end;

procedure TRecuperarVenda.pEnableEventHandlers(blnDoAfterPost: Boolean = False; blnDoBeforeDelete:Boolean = False);
begin
  Self.FCdsVen.AfterPost    := Self.pCdsVendaAfterPost;
  Self.FCdsVen.BeforeDelete := Self.pCdsVendaBeforeDelete;

  If blnDoAfterPost Then
    Self.pCdsVendaAfterPost(Nil);

  If blnDoBeforeDelete Then
    Self.pCdsVendaBeforeDelete(Nil);
end;

procedure TRecuperarVenda.pExcluirItem;
var
  LQuery: TUniQuery;
begin
  If (Not fRegistroCdsValido) Then
    Exit;
  LQuery := fCriaQuery(nil);
  try
    LQuery.SQL.Text := 'DELETE FROM ' + FTabDet + ' WHERE AUTOINCREM = ' +
      FCdsVen.FieldByName('AUTOINCREM').AsString;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

function TRecuperarVenda.fAdicionaVendaQueNaoFoiFinalizadaCorretamente(strTabGer: String; AFields: IMyCampoTabela; strTabFields: String): Boolean;
begin
  Result := Self.FEnabled;

  if strTabGer.Equals(Self.FTabGer) then
    Result := False;

  if (AFields.FieldByName('RCV_OPCDOC').AsString <> TFatVenda(FObjVen).strOpcDoc) then
    Result := False;

  if (AFields.FieldByName('RCV_NUMDOC').AsString <> TFatVenda(FObjVen).strNumOrc) then
    Result := False;

  if (AFields.FieldByName('RCV_ESPDOC').AsString <> TFatVenda(FObjVen).strEspOrc) then
    Result := False;

  if (AFields.FieldByName('RCV_EMPDOC').AsString <> TFatVenda(FObjVen).strEmpOri) then
    Result := False;

  if AFields.FieldByName('RCV_CODCLI').AsString.IsEmpty then
    Result := False;

  if not fValidaValDoc(strTabFields, AFields) then
    Result := False;

  if not Result then
    Result := fValidaNaoFinalizadoRecebidoPorPixQRCode(strTabFields, AFields);

  if Result Then
    if TFatVenda(FObjVen).strNumOrc.IsEmpty then
      if not TFatVenda(FObjVen).strCodCli.IsEmpty then
        Result := AFields.FieldByName('RCV_CODCLI').AsString.Equals(TFatVenda(FObjVen).strCodCli);
end;

function TRecuperarVenda.fExisteVendaNaoFinalizadaPixQRCode(
  const AShowTables: String): Boolean;
var
  LQuery: TUniQuery;

  LTabGer,
  LTabFields: String;
begin
  Result := False;
  Try
    LQuery := fCriarQuery(Format(AShowTables,
                                [VS_strCodEmp, strLoginUsuarioLogado, '%']), nil);

    LQuery.Open;

    while not LQuery.Eof do
    begin
      LTabGer := LQuery.Fields[0].AsString;
      LTabFields := fListarCamposTabela(LTabGer);

      if Not LTabFields.Contains('RCV_PIXTEL') then
      begin
        LQuery.Next;
        Continue;
      end;

      if fCampoTabela('RCV_PIXTEL', LTabGer, [], []) = 'S' then
        Exit(True);

      LQuery.Next;
    end;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TRecuperarVenda.fRecuperarVendaNaoFinalizada: Boolean;
const
  SHOW_TABLES_LIKE = 'SHOW TABLES LIKE "TMP_RECUP_VENDA_GER_%s%s%s"';
var
  LQuery: TUniQuery;
  LFields: IMyCampoTabela;
  LTabGer: String;
  LTabFields: String;
  LFrmSel: TfrmRecuperarVendaSelec;
begin
  Result := False;
  if not FEnabled then
  begin
    if not fExisteVendaNaoFinalizadaPixQRCode(SHOW_TABLES_LIKE)  Then
      exit;
  end;

  pCriarFormularios(TfrmRecuperarVendaSelec, LFrmSel);
  try
    LQuery := fCriarQuery(Format(SHOW_TABLES_LIKE,
      [VS_strCodEmp, strLoginUsuarioLogado, '%']), nil);
    Try
      LQuery.Open;

      while not LQuery.Eof do
      begin
        LTabGer := LQuery.Fields[0].AsString;
        LTabFields := fListarCamposTabela(LTabGer);
        LFields := fCampoTabela(LTabFields.Replace(' ', '').Split([',']), LTabGer, [], []);

        if fAdicionaVendaQueNaoFoiFinalizadaCorretamente(LTabGer, LFields, LTabFields) Then
        begin
          LFrmSel.cdsVendas.Append;

          if not LFields.FieldByName('RCV_NUMDOC').AsString.IsEmpty then
            LFrmSel.cdsVendasNUMDOC.AsString := Format('%s-%s-%s',
              [LFields.FieldByName('RCV_NUMDOC').AsString,
               LFields.FieldByName('RCV_ESPDOC').AsString,
               LFields.FieldByName('RCV_EMPDOC').AsString]);

          if LTabFields.Contains('RCV_VALDOC') then
            LFrmSel.cdsVendasVALDOC.AsFloat  := LFields.FieldByName('RCV_VALDOC').AsFloat;

          LFrmSel.cdsVendasCODOPE.AsString   := strLoginUsuarioLogado;
          LFrmSel.cdsVendasNOMOPE.AsString   := strDescriUsuarioLogado;
          LFrmSel.cdsVendasCODEMP.AsString   := VS_strCodEmp;
          LFrmSel.cdsVendasCODCLI.AsString   := LFields.FieldByName('RCV_CODCLI').AsString;
          LFrmSel.cdsVendasNOMCLI.AsString   := fRetNomCliente(LFields.FieldByName('RCV_CODCLI').AsString);
          LFrmSel.cdsVendasHORVEN.AsDateTime := LFields.FieldByName('RCV_DTABKP').AsDateTime;
          LFrmSel.cdsVendasNOMTAB.AsString   := LTabGer;
          LFrmSel.cdsVendas.Post;
        end;

        LQuery.Next;
      end;

      if LFrmSel.cdsVendas.IsEmpty then
        exit;

      if LFrmSel.ShowModal <> mrOk then
        exit;

      Result := fRestaurarVenda(LFrmSel.cdsVendasNOMTAB.AsString);
    Finally
      FreeAndNil(LQuery);
    End;
  finally
    pFreeAndNil(LFrmSel);
  end;
end;

type
  TfrmPaiHack = class(TfrmPai);

procedure TRecuperarVenda.pRecuperaSubItensDoVidro(qryQuery: TUniQuery);
begin
  if qryQuery.FindField('ITE_OBJVID') = nil then
    Exit;

  if qryQuery.FieldByName('ITE_OBJVID').AsString.IsEmpty then
    Exit;

  if Not Assigned(TFatVenda(FObjVen).objEstruturaVidros) then
    Exit;

  TFatVenda(FObjVen).objEstruturaVidros.dicEstruturasSalvas.Add(FCdsVen.FieldByName('AUTOINCREM').AsInteger,
    TSubItensVidro.FromJsonString(qryQuery.FieldByName('ITE_OBJVID').AsString));
end;

procedure TRecuperarVenda.pRecuperaMatrizFormulacaoTinta(qryQuery: TUniQuery);
begin
  if qryQuery.FindField('ITE_OBJCOL') = nil then
    Exit;

  if qryQuery.FieldByName('ITE_OBJCOL').AsString.IsEmpty then
    Exit;

  TFatVenda(FObjVen).dicFormulas.AdicionarObjeto(FCdsVen.FieldByName('AUTOINCREM').AsString, TClassMatrizSaldosColorantes.FromJsonString(qryQuery.FieldByName('ITE_OBJCOL').AsString));
end;

function TRecuperarVenda.fValidouPrincipaisDadosDaVenda(strFrmVal: String): Boolean;
begin
  Result := True;

  if (Not TFatVenda(FObjVen).strNumDoc.IsEmpty) then
    Exit;

  fSetCamposFormulario(strFrmVal, FFrmVen);
  if not TfrmPaiHack(FFrmVen).fValidaCampos(TWinControl(FFrmVen.FindComponent('edtCodCli')), True) then
    if not fPergunta('Validação do código do cliente falhou. Deseja ' +
      'continuar com a recuperação da venda assim mesmo?') then
      exit(False);

  fSetCamposFormulario(strFrmVal, FFrmVen);
  if not TfrmPaiHack(FFrmVen).fValidaCampos(TWinControl(FFrmVen.FindComponent('edtCodCnd')), True) then
    if not fPergunta('Validação do código da condição de pagamento falhou. ' +
      'Deseja continuar com a recuperação da venda assim mesmo?') then
      exit(False);

  fSetCamposFormulario(strFrmVal, FFrmVen);
  if not TfrmPaiHack(FFrmVen).fValidaCampos(TWinControl(FFrmVen.FindComponent('mskCndPag')), True) then
    if not fPergunta('Validação da condição de pagamento falhou. ' +
      'Deseja continuar com a recuperação da venda assim mesmo?') then
      exit(False);

  fSetCamposFormulario(strFrmVal, FFrmVen);
  if not TfrmPaiHack(FFrmVen).fValidaCampos(TWinControl(FFrmVen.FindComponent('edtForPag')), True) then
    if not fPergunta('Validação do código da forma de pagamento falhou. ' +
      'Deseja continuar com a recuperação da venda assim mesmo?') then
      exit(False);
end;

function TRecuperarVenda.fRestaurarVenda(ATabGer: String): Boolean;
var
  LFrmVal: String;
  LMatFlex: String;
  LQuery: TUniQuery;
  LField: TField;
begin
  if not fTabelaExiste(ATabGer) then
    exit(False);

  LFrmVal := fCampoTabela('RCV_FRMVAL', ATabGer, [], []);

  if fListarCamposTabela(ATabGer).Contains('RCV_MATFLE') then
    LMatFlex := fCampoTabela('RCV_MATFLE', ATabGer, [], []);

  // Carrega valores salvos da tela de cliente consumidor cajo haja
  if fListarCamposTabela(ATabGer).Contains('RCV_FRMCNS') then
    FCliCsn := fCampoTabela('RCV_FRMCNS', ATabGer, [], []);

  If (Not fValidouPrincipaisDadosDaVenda(LFrmVal)) Then
    Exit(False);

  // Restaura os campos da tabela da venda
  fSetCamposFormulario(LFrmVal, FFrmVen);

  // Restaura a matriz de calculo do flex
  if not LMatFlex.IsEmpty Then
    TFatVenda(FObjVen).objMatrizCalcFlex := TMatrizCalcFlexObject.FromJsonString
      (LMatFlex);

  LQuery := fCriaQuery(nil);
  try
    // Limpa o clientdataset da venda
    FCdsVen.EmptyDataSet;
    FCdsVen.DisableControls;

    // Limpa o dicionario de formulacao de tinta de maquina
    TFatVenda(FObjVen).dicFormulas.LimparObjetos;
    TFatVenda(FObjVen).dicFormulas.Limpar;

    // limpa o dicionario de subitens do iitem vidro
    if Assigned(TFatVenda(FObjVen).objEstruturaVidros) then
      TFatVenda(FObjVen).objEstruturaVidros.dicEstruturasSalvas.Clear;

    // carrega o backup dos produtos da venda
    LQuery.SQL.Text := 'SELECT * FROM ' + ATabGer.Replace('GER', 'DET');
    LQuery.Open;
    while not LQuery.Eof do
    begin
      FCdsVen.Append;
      // Recupera os dados dos itens (cdsvenda)
      for LField in FCdsVen.Fields do
        if MatchStr(LField.FieldName, ['ITE_LIBUNI', 'ITE_LIBEST']) then
          LField.Value := 'N'
        else if LQuery.FindField(LField.FieldName) <> nil then
          LField.Value := LQuery.FieldByName(LField.FieldName).Value;

      pRecuperaMatrizFormulacaoTinta(LQuery);
      pRecuperaSubItensDoVidro(LQuery);

      // Seta indice do primeiro item inserido
      if LQuery.Recno = 1 then
        TFatVenda(FObjVen).pSetaIndiceDestino(LQuery.FieldByName('ITE_ENTRET')
          .AsString);

      FCdsVen.Post;
      LQuery.Next;
    end;
  finally
    FCdsVen.EnableControls;
    LQuery.Free;
  end;

  // exclui as tabelas de backup GER E DET
  fDropTable(ATabGer);
  fDropTable(ATabGer.Replace('GER', 'DET'));

  pMensagemOk('Venda restaurada com sucesso!');
  Result := True;
end;

function TRecuperarVenda.fRegistroCdsValido: Boolean;
begin
  Result := False;

  If Not Assigned(FCdsVen) Then
    Exit;

  If (Not FCdsVen.Active) Then
    Exit;

  If (FCdsVen.IsEmpty) Then
    Exit;

  If FCdsVen.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit;

  Result := True;
end;

procedure TRecuperarVenda.pCarregarVendaParaRecuperacao;
begin
  pAtualizarDadosGerais;
  pAtualizarDadosItemReplaceGeral;
end;

procedure TRecuperarVenda.pAtualizarDadosItemReplaceGeral;
  Var
    LClone : TUniClientDataSet;
    LReplace : TUniQuery;
    LField : TField;
    LReplaceFields : String;
    LReplaceValues : String;
    LRowValues : String;
    LCount : Integer;
    LObjCol : String;
    LObjVid : String;
begin
  If Not Assigned(FCdsVen) Then
    Exit;

  If (Not FCdsVen.Active) Then
    Exit;

  If (FCdsVen.IsEmpty) Then
    Exit;

  If (FCdsVen.FieldCount = 0) Then
    Exit;

  If (Not fTabelaExiste(FTabDet)) Then
    pCriarTabelas;

  LClone := TUniClientDataSet.Create(Nil);
  Try
    LReplace := fCriaQuery;
    Try
      pCloneDataSet(LClone, FCdsVen);

      LReplace.SQL.Text := 'DELETE FROM ' + FTabDet;
      LReplace.ExecSQL;

      LReplaceFields := '';
      For LField In LClone.Fields Do
      Begin
        If LReplaceFields.IsEmpty Then
          LReplaceFields := LField.FieldName
        Else
          LReplaceFields := LReplaceFields + ', ' + LField.FieldName;
      End;

      LReplaceFields := LReplaceFields + ', ITE_OBJCOL, ITE_OBJVID';

      LCount := 0;
      LReplaceValues := '';

      LClone.First;
      While Not LClone.Eof Do
      Begin
        if LClone.FieldByName('AUTOINCREM').AsString.IsEmpty then
        Begin
          LClone.Next;
          Continue;
        End;

        LRowValues := '';
        For LField In LClone.Fields Do
        Begin
          If LRowValues.IsEmpty Then
            LRowValues := fBindValue(LField.Value, LField.DataType)
          Else
            LRowValues := LRowValues + ', ' + fBindValue(LField.Value, LField.DataType);
        End;

        LObjCol := fGetMatrizColorantes(LClone.FieldByName('AUTOINCREM').AsInteger);
        If LObjCol.IsEmpty Then
          LRowValues := LRowValues + ', NULL '
        Else
          LRowValues := LRowValues + ', ' + QuotedStr(LObjCol);

        LObjVid := fGetSubItensVidro(LClone.FieldByName('AUTOINCREM').AsInteger);
        If LObjVid.IsEmpty Then
          LRowValues := LRowValues + ', NULL '
        Else
          LRowValues := LRowValues + ', ' + QuotedStr(LObjVid);

        Inc(LCount);

        If LReplaceValues.IsEmpty Then
          LReplaceValues := '(' + LRowValues + ')'
        Else
          LReplaceValues := LReplaceValues + ', ' + '(' + LRowValues + ')';

        LClone.Next;

        If ((LClone.Eof) Or (LCount >= 50)) And (Not LReplaceValues.IsEmpty) Then
        Begin
          LReplace.SQL.Text := 'REPLACE INTO ' + FTabDet + ' (' + LReplaceFields + ') VALUES ' + LReplaceValues;
          LReplace.ExecSQL;
          LReplaceValues := '';
          LCount := 0;
        End;
      End;

      If (Not LReplaceValues.IsEmpty) Then
      Begin
        LReplace.SQL.Text := 'REPLACE INTO ' + FTabDet + ' (' + LReplaceFields + ') VALUES ' + LReplaceValues;
        LReplace.ExecSQL;
        LReplaceValues := '';
      End;
    Finally
      FreeAndNil(LReplace);
    End;
  Finally
    FreeAndNil(LClone);
  End;
end;

function TRecuperarVenda.fBindValue(const AValue: Variant; const ADataType: TFieldType) : String;
begin
  If (VarIsNull(AValue)) Then
    Result := 'NULL'
  Else
  Begin
    Case ADataType Of
      ftDateTime:
        Result := QuotedStr(FormatDateTime('yyyy-mm-dd HH:nn:ss', AValue));
      ftDate:
        Result := QuotedStr(FormatDateTime('yyyy-mm-dd', AValue));
      ftFloat:
        Result := QuotedStr(AnsiReplaceStr(FloatToStrF(AValue, ffFixed, 12, 2),',','.'));
      ftInteger:
        Result := IntToStr(AValue);
      ftBoolean:
        Result := IIF(AValue, '1', '0');
      ftTime:
        Result := QuotedStr(FormatDateTime('HH:nn:ss', AValue))
      Else
        Result := QuotedStr(fSafeSQLValue(fTiraEnter(AValue)));
    End;
  End;
end;

end.
