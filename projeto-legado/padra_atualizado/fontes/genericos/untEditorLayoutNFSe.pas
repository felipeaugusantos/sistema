unit untEditorLayoutNFSe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Samples.Spin, strUtils, fs_iinterpreter, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxLabel, cxDropDownEdit,
  untLayCfs,
  untLayDNS,
  untLayXNS,
  untCadLayoutXMLNFSe, cxMaskEdit, Datasnap.DBClient, UniClientDataSet, cxDBTL,
  cxTLData, cxDBLookupComboBox;

type
  TfrmEditorLayoutNFSe = class(TfrmPaiConfirma)
    edtNomLayout: TEdit;
    fsScript1: TfsScript;
    pnlHintCodigo: TPanel;
    Label3: TLabel;
    trlXML: TcxTreeList;
    colXML: TcxTreeListColumn;
    colCampo: TcxTreeListColumn;
    colCampoCompleto: TcxTreeListColumn;
    colFormato: TcxTreeListColumn;
    btnCadastrarCampos: TBitBtnLocked;
    pnlTop: TPanel;
    lblTitulo: TLabel;
    colTipo: TcxTreeListColumn;
    dsCamposCadFis: TDataSource;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastrarCamposClick(Sender: TObject);
    procedure colCampoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FstrMensagem: String;
    FobjLayXNS: TLayXNS;
    FobjLayDNS: TLayDNS;
    FobjLayCFS: TLayCFS;

    FstrSchema: String;
    FstrSchemaMD5: String;
    FobjCamposAntigos: TStrings;
    FobjCampos: TStrings;
    FobjLayout: TStrings;
    FstrAutoIncrem: String;
    procedure pAdicionarNo(strNo: String; strNoCompleto: String;
      strTipo: String);
    function fLocalizarNo(strNo: String): Boolean;
    procedure pCarregarCampos;
    procedure pExcluirCamposAntigo(strCampo: String);
    procedure pValidarCamposObrigatorios;
    procedure pValidarCamposData(objNo: TcxTreeListNode);
    function fValidarTipoCampo(strCampo, strTipo: String): Boolean;
    function fLocalizarCampo(objNo: TcxTreeListNode; strNo: String): String;
    procedure pSalvarCampos(objNo: TcxTreeListNode);
    procedure pSalvarXML;
    procedure pValidar(blnErro: Boolean; strMensagem: String);
    function fCampo(strCampo: String): TCampo;
    function fRetTipoNome(strTipo: String): String;
  public
    function fCarregarTreeView: TfrmEditorLayoutNFSe;
    function fSchemaMD5(strSchemaMD5: String): TfrmEditorLayoutNFSe;
    function fSchema(strSchema: String): TfrmEditorLayoutNFSe;
    function fLayout(objLayout: TStrings): TfrmEditorLayoutNFSe; overload;
    function fLayout: TStrings; overload;
    function fAutoIncrem: String; overload;
    function fAutoIncrem(strAutoIncrem: String): TfrmEditorLayoutNFSe; overload;
    function fTitulo(strTitulo: String):TfrmEditorLayoutNFSe;
    { Public declarations }
  end;

var
  frmEditorLayoutNFSe: TfrmEditorLayoutNFSe;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEditorLayoutNFSe.btnCadastrarCamposClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadLayoutXMLNFSe);

  FobjCampos := FobjLayCFS
    .fCampos;

  FobjLayCFS
    .fOpen;
end;

procedure TfrmEditorLayoutNFSe.pExcluirCamposAntigo(strCampo: String);
Begin
  if Not fEmptyStr(strCampo) Then
    If FobjCamposAntigos.IndexOfName(strCampo) >= 0 Then
      FobjCamposAntigos.Delete(FobjCamposAntigos.IndexOfName(strCampo));
End;

procedure TfrmEditorLayoutNFSe.colCampoPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  strCampoXML: String;
  strNomeCampoXML: String;
  strTipo: String;
  strCampo: String;
  strValor: String;
  strTipoNome:String;
  objCampo: TCampo;
begin
  inherited;
  strNomeCampoXML := VarToStrDef(trlXML.FocusedNode.Values[colXML.ItemIndex],'');
  strValor := VarToStrDef(DisplayValue,'');
  strCampo := Copy(strValor,1, Pos('(', strValor) -1).Trim;
  strTipo := VarToStrDef(trlXML.FocusedNode.Values[colTipo.ItemIndex],'');
  If Not fEmptyStr(strValor) Then
     strCampoXML := fLocalizarCampo(trlXML.Root, strValor);

  Try
    objCampo := fCampo(strCampo);
    If Assigned(objCampo) Then
      strTipoNome := fRetTipoNome(objCampo.fTipoCampo);
    pValidar((AnsiIndexStr(strTipoNome,['TEXTO','']) < 0) And fValidarTipoCampo(strCampo, strTipo),
      Format('O campo do XML %s está definido como o tipo %s, mas deveria ser do tipo %s conforme definido no campo %s!' + #13 +
        'Verificar o "[F5] Cadastro de Campos!"',
      [strNomeCampoXML, fRetTipoNome(strTipo), strTipoNome, strValor]));


    pValidar((Not fEmptyStr(strCampoXML)), 'O campo já utilizado na tag ' + strCampoXML);

    If strValor.IsEmpty Then
      pExcluirCamposAntigo(strCampo)
    Else
      FobjCamposAntigos.Values[strCampo] := trlXML.FocusedNode.Values[colCampoCompleto.ItemIndex];
  Except
    On e: Exception Do
    Begin
      Error := true;
      pMensagemOk(e.Message);
    End;
  End;

end;

procedure TfrmEditorLayoutNFSe.pValidar(blnErro: Boolean; strMensagem: String);
Begin
  If blnErro Then
    raise Exception.Create(strMensagem);
end;

function TfrmEditorLayoutNFSe.fCampo(strCampo: String): TCampo;
Var
  intIndex: Integer;
Begin
  intIndex := FobjCampos.IndexOf(strCampo);
  Result := TCampo(FobjCampos.Objects[intIndex]);
End;

function TfrmEditorLayoutNFSe.fValidarTipoCampo(strCampo: String; strTipo: String): Boolean;
Var
  intIndex: Integer;
Begin
  Result := False;
  intIndex := FobjCampos.IndexOf(strCampo);
  If intIndex > 0 Then
    Result := TCampo(FobjCampos.Objects[intIndex]).fTipoCampo <> strTipo;
End;

procedure TfrmEditorLayoutNFSe.pSalvarXML;
begin
  FstrAutoIncrem :=
    FObjLayXNS
        .fSchema(FstrSchema)
        .fSchemaMD5(FstrSchemaMD5)
        .fConsultar
        .fSalvar
          .FieldByName('AUTOINCREM')
          .AsString;

  FObjLayDNS
      .fSeqLay(FstrAutoIncrem)
      .fOpen
      .fExcluirTodos;

  pSalvarCampos(trlXML.Root);
End;

procedure TfrmEditorLayoutNFSe.pSalvarCampos(objNo: TcxTreeListNode);
Var
  intContador: Integer;
  objCampo: TCampo;
  intCampo: Integer;
  strCampoXML: String;
  strFormato: String;
  strCampoCadFis: String;
Begin
  For intContador := 0 to objNo.Count -1  do
  Begin
    If Not objNo.Items[intContador].Texts[colCampo.ItemIndex].IsEmpty Then
    Begin
      strCampoCadFis := VarToStr(objNo.Items[intContador].Values[colCampo.ItemIndex]);
      intCampo := FobjCampos.IndexOf(strCampoCadFis );
      objCampo := TCampo(FobjCampos.Objects[intCampo]);
      strCampoXML := objNo.Items[intContador].Texts[colCampoCompleto.ItemIndex];
      strFormato := objNo.Items[intContador].Texts[colFormato.ItemIndex];

      FObjLayDNS
          .fSeqLay(FstrAutoIncrem)
          .fCampoXML(strCampoXML)
          .fFormato(strFormato)
          .fCampo(objCampo.fCodigo)
          .fConsultar
          .fSalvar;
    End
    Else If objNo.Items[intContador].Count > 0 Then
      pSalvarCampos(objNo.Items[intContador]);
  End;
End;

function TfrmEditorLayoutNFSe.fAutoIncrem: String;
begin
  Result := FstrAutoIncrem;
end;

function TfrmEditorLayoutNFSe.fAutoIncrem(strAutoIncrem: String): TfrmEditorLayoutNFSe;
begin
  Result := Self;
  FstrAutoIncrem := strAutoIncrem;
end;

function TfrmEditorLayoutNFSe.fCarregarTreeView: TfrmEditorLayoutNFSe;
Var
  strCampos: String;
  strCampo: String;
  strCampoXML: String;
  strCampoAnterior: String;
  arrCampos: TArray<String>;
  intContador: Integer;
  strTipo: String;
begin
  Result := Self;
  For strCampos In FstrSchema.Split([#13]) do
  Begin
    strCampoAnterior := '';
    trlXML.FocusedNode := nil;
    strCampoXML := strCampos.Split(['|'])[0];

    strTipo := '';
    If Pos('|',strCampos) > 0 Then
      strTipo := strCampos.Split(['|'])[1][1];

    arrCampos := strCampoXML.Split([';']);
    For intContador := 0 To High(arrCampos) DO
    Begin
      strCampo := arrCampos[intContador];
      fLocalizarNo(strCampo);
      If intContador = High(arrCampos) Then
        pAdicionarNo(strCampo, strCampoXML, strTipo);
      strCampoAnterior := strCampo;
    End;
  End;
  trlXML.Root.Expand(true);
end;

procedure TfrmEditorLayoutNFSe.pAdicionarNo(strNo: String; strNoCompleto: String; strTipo: String);
begin
  trlXML.FocusedNode := trlXML.AddChild(trlXML.FocusedNode);
  FobjLayDNS
    .fSeqLay(fAutoIncrem)
    .fCampoXML(strNoCompleto)
    .fConsultar;

  trlXML.FocusedNode.Values[colCampoCompleto.ItemIndex] := strNoCompleto;
  trlXML.FocusedNode.Values[colXML.ItemIndex] := strNo;
  trlXML.FocusedNode.Values[colCampo.ItemIndex] := FobjLayDNS.FieldByName('LAY_DESCAM').AsString;
  trlXML.FocusedNode.Values[colFormato.ItemIndex] := FobjLayDNS.FieldByName('LAY_FORMAT').AsString;
  trlXML.FocusedNode.Values[colTipo.ItemIndex] := strTipo;

  If Not FobjLayDNS.FieldByName('LAY_DESCAM').AsString.IsEmpty Then
    FobjCamposAntigos.Values[FobjLayDNS.FieldByName('LAY_DESCAM').AsString] := strNoCompleto;
End;

function TfrmEditorLayoutNFSe.fLayout: TStrings;
Var
  strCampos: String;
  strCampoAnterior: String;
  strCampo: String;
  objCampo: TCampo;
  intCampo: Integer;
begin
  Result := TStringList.Create;

  For strCampos In FstrSchema.Split([#13]) do
  Begin
    strCampoAnterior := '';
    trlXML.FocusedNode := nil;
    For strCampo in strCampos.Split([';']) do
    Begin
      If fLocalizarNo(strCampoAnterior)  Or (Not fLocalizarNo(strCampo)) Then
        trlXML.FocusedNode := trlXML.FocusedNode;

      intCampo := FobjCampos.IndexOf(VarToString( trlXML.FocusedNode.Values[colCampo.ItemIndex] ));
      objCampo := TCampo(FobjCampos.Objects[intCampo]);
      If Assigned(objCampo) Then
        Result.Values[trlXML.FocusedNode.Values[colCampoCompleto.ItemIndex]] := objCampo.fCodigo;

      strCampoAnterior := strCampo;
    End;
  End;
end;

function TfrmEditorLayoutNFSe.fLocalizarNo(strNo: String): Boolean;
Var
  intContador: Integer;
Begin
  Result := False;
  If  trlXML.Root.Count = 0 Then
    Exit(true);

  If Not Assigned(trlXML.FocusedNode) Then
    For intContador := 0 to trlXML.Root.Count -1  do
      If trlXML.Root.Items[intContador].Texts[colXML.ItemIndex].Equals(strNo) Then
      Begin
        trlXML.FocusedNode := trlXML.Root.Items[intContador];
        Exit(true);
      End;

  If Assigned(trlXML.FocusedNode) Then
    For intContador := 0 To trlXML.FocusedNode.Count -1 Do
      If trlXML.FocusedNode.Items[intContador].Texts[colXML.ItemIndex].Equals(strNo) Then
      Begin
        trlXML.FocusedNode := trlXML.FocusedNode.Items[intContador];
        Exit(true);
      End;
end;


function TfrmEditorLayoutNFSe.fLocalizarCampo(objNo: TcxTreeListNode; strNo: String): String;
Var
  intContador: Integer;
Begin
  Result := '';
  For intContador := 0 to objNo.Count -1  do
  Begin
    If Not fEmptyStr(Result) Then
      Exit(Result)
    Else If objNo.Items[intContador].Texts[colCampo.ItemIndex].Equals(strNo) Then
      Exit(objNo.Items[intContador].Values[colXML.ItemIndex])
    Else If objNo.Items[intContador].Count > 0 Then
      Result := fLocalizarCampo(objNo.Items[intContador], strNo);
  End;
End;

procedure TfrmEditorLayoutNFSe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Action <> canone Then
    pSalvarXML;
end;

procedure TfrmEditorLayoutNFSe.FormCreate(Sender: TObject);
begin
  inherited;
  FobjCamposAntigos := TStringList.Create;

  lblTitulo.Caption  := '';
  FobjLayXNS := TLayXNS
    .fNovo;

  FobjLayDNS := TLayDNS
    .fNovo;
end;

procedure TfrmEditorLayoutNFSe.FormDestroy(Sender: TObject);
begin
  inherited;
  pFreeAndNil(FobjLayXNS);
  pFreeAndNil(FobjLayDNS);
end;

procedure TfrmEditorLayoutNFSe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_F5 Then
    btnCadastrarCampos.Click;
end;

procedure TfrmEditorLayoutNFSe.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarCampos;
end;

function TfrmEditorLayoutNFSe.fSchema(strSchema: String): TfrmEditorLayoutNFSe;
begin
  Result := Self;
  FstrSchema := strSchema;
end;

function TfrmEditorLayoutNFSe.fSchemaMD5(
  strSchemaMD5: String): TfrmEditorLayoutNFSe;
begin
  Result := Self;
  FstrSchemaMD5 := strSchemaMD5;
end;

function TfrmEditorLayoutNFSe.fTitulo(strTitulo: String): TfrmEditorLayoutNFSe;
begin
  Result := Self;
  lblTitulo.Caption := strTitulo;
end;

procedure TfrmEditorLayoutNFSe.pCarregarCampos;
begin
  FobjLayCFS := TLayCFS.fNovo;

  FobjCampos := FobjLayCFS
    .fNovo
    .fCampos;

  dsCamposCadFis.DataSet := FobjLayCFS.fOpen;
end;

function TfrmEditorLayoutNFSe.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := False;
  FstrMensagem := '';

  pValidarCamposObrigatorios;
  pValidarCamposData(trlXML.Root);

  If Not fEmptyStr(fstrMensagem) Then
  Begin
    pMensagemOk(FstrMensagem, 0, 200 + FstrMensagem.CountChar(#13) * 10);

  End
  Else
    Result := True;
end;

function TfrmEditorLayoutNFSe.fLayout(objLayout: TStrings): TfrmEditorLayoutNFSe;
begin
  Result := Self;
  FobjLayout := objLayout;
end;

procedure TfrmEditorLayoutNFSe.pValidarCamposObrigatorios;
Var
  objCampo: TCampo;
  intContador: Integer;
  strMensagem: String;
Begin
  For intContador := 0 To FobjCampos.Count -1 Do
  Begin
    objCampo := TCampo( FObjCampos.Objects[intContador]);
    If Not Assigned(objCampo) Then
      Continue;
    If objCampo.fObrigatorio = 'S' Then
      If FobjCamposAntigos.IndexOfName(objCampo.fDescricao) < 0 Then
        strMensagem := strMensagem + objCampo.fDescricao + ' - ' +  objCampo.fCadFis + #13;
  End;
  If Not fEmptyStr(strMensagem) Then
    FstrMensagem := FstrMensagem + #13 + 'O(s) campo(s) obrigatório não foram relacionados! ' + #13 + strMensagem;
End;


procedure TfrmEditorLayoutNFSe.pValidarCamposData(objNo: TcxTreeListNode);
Var
  intContador: Integer;
  objCampo: TCampo;
  intCampo: Integer;
  strFormato: String;
  strCampoCadFis: String;
  strMensagem: String;
Begin
  For intContador := 0 to objNo.Count -1  do
  Begin
    If objNo.Items[intContador].Count > 0 Then
      pValidarCamposData(objNo.Items[intContador])
    Else If objNo.Items[intContador].Texts[colFormato.ItemIndex].IsEmpty Then
    Begin
      strCampoCadFis := VarToStr(objNo.Items[intContador].Values[colCampo.ItemIndex]);
      intCampo := FobjCampos.IndexOf(strCampoCadFis );
      objCampo := TCampo(FobjCampos.Objects[intCampo]);
      strFormato := objNo.Items[intContador].Texts[colFormato.ItemIndex];

      If Assigned(objCampo) Then
        If objCampo.fTipoCampo = 'D' Then
          strMensagem := strMensagem + objCampo.fDescricao + ' - ' +  objCampo.fCadFis + #13;
    End

  End;
  If Not fEmptyStr(strMensagem) Then
    FstrMensagem := FstrMensagem + #13 + 'Campos data sem formatação! ' + #13 + strMensagem;
End;

function TfrmEditorLayoutNFSe.fRetTipoNome(strTipo: String): String;
Begin
  case AnsiIndexStr(strTipo,['N','S','D','B']) of
    0: Result := 'NUMERO';
    1: Result := 'TEXTO';
    2: Result := 'DATA';
    3: Result := 'BOLEANO';
  Else
    Result := '';
  End;
End;





end.
