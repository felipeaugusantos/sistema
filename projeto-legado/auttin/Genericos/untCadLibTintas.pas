{***********************************************************************************************}
{* Tela que realiza qualquer cadastro que venha o objeto cadLibTintas: ICadLibTintas, com isso *}
{* basta alterar o objeto e a tela se auto adequa ao cadastro                                  *}
{********************************************************************************************PH*}
unit untCadLibTintas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  untICadLibTintas, untFuncTinta, StrUtils, Uni, DB, untFuncoesSimples, Mask, DBCtrls,
  Math, untILibTintaControleVisual, ImgList, TypInfo, EditFocus, untFuncoesGenerica,
  untDBEditFocusLibTintaControleFactory, DBEditFocus, DBComboBoxFocus,
  untMskTelefone, MaskEditFocus, FilenameEditFocus, DirectoryEditFocus,
  ComboBoxFocus, CurrencyEditFocus, frxClass, frxExportCSVTestabilidade,
  System.ImageList, 
  untFrameDirectoryEditFocus;

type
  TfrmCadLibTintas = class(TfrmPaiCad, ITelaCadLibTintas)
    pnlCampos: TPanel;
    ilImagens: TImageList;
    btnAtivarNfm: TBitBtnLocked;
    DBComboBox: TDBComboBoxFocus;
    ComboBox: TComboBoxFocus;
    DBRadioGroup: TDBRadioGroup;
    DBTipoFormula: TDBComboBoxFocus;
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAtivarNfmClick(Sender: TObject);
    procedure DBRadioGroupClick(Sender: TObject);
    procedure DBComboBoxClick(Sender: TObject);
  private
    function GetStrState(): string;
    { Private declarations }
  protected
    cadLibTintas: ICadLibTintas;
    qryCadastro: TUniQuery;
    dtsCadastro: TDataSource;
    strNomeCampoRelacionamentoConsulta: string;
  protected
    procedure ConstruirTela;
    procedure ConstruirComponentes;
    procedure ConstruirControle(const controle: ILibTintaControleVisual);
    procedure pInicializaIndices; override;
    procedure pCriarDataSets; virtual;
    procedure pLigarDataSets; overload; virtual;
    procedure pLigarDataSets(dbeEdit: TDBEdit; lblLabel: TLabel; strNomeCampo: String); overload; virtual;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); virtual;
    procedure pSetaCamposChaves; virtual;
    function fGetDbEditByFieldName(const strNomeCampo: String): TDBEdit;
    procedure FormatarCampos();
    procedure HabilitaBotoesAIE();
  protected
    function GetComponenteByName(const componenteRaiz: TComponent; const strNome: string): TComponent;
    function GetLibTintaControleVisualNome(const strNome: string): ILibTintaControleVisual;
    function GetSelf: ILibTintaControleVisual;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pDesabilitaCamposChaves();
    procedure LigarKeyDowns;
    procedure AjustarTela;
    procedure PreencherDBComboBox;
    procedure PreencherComboBox;
    procedure PreencherDBRadioGroup;
    procedure PreencherDBTipoFormula;
  public
    constructor Create(AOwner: TComponent; const cadLibTintas: ICadLibTintas); reintroduce;
    procedure SelectNext;
    function GetBlnAlterou: Boolean;
    function GetBlnExcluiu: Boolean;
    function GetBlnGravou: Boolean;
    procedure pSetarFocus;
    function GetTextDBComboBox: String;

    { Public declarations }
  end;

var
  frmCadLibTintas: TfrmCadLibTintas;

implementation

uses untLibTintaControleFactory, untControlILibTintaControleVisualWrapper,
  untUniQueryDataSetWrapper, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmPaiCadLibTintas }

procedure TfrmCadLibTintas.AjustarTela;
var
  intMaximaAltura: Integer;

  procedure GetAlturaMaxima(const componenteRaiz: TComponent);
  var
    intCont: Integer;
  begin
    if not (Assigned(GetPropInfo(componenteRaiz, 'Top'))
      and Assigned(GetPropInfo(componenteRaiz, 'Height'))) then
      Exit;

    for intCont := 0 to componenteRaiz.ComponentCount - 1 do
    begin
      intMaximaAltura := Max(intMaximaAltura,
        GetPropValue(componenteRaiz.Components[intCont], 'Top') +
        GetPropValue(componenteRaiz.Components[intCont], 'Height'));
      GetAlturaMaxima(componenteRaiz.Components[intCont]);
    end;
  end;
begin
  intMaximaAltura := 0;
  GetAlturaMaxima(pnlCampos);
  Self.ClientHeight := Self.ClientHeight - pnlCampos.Height + Trunc(15 + intMaximaAltura);
  cadLibTintas.AjustarTela(Self);
end;

procedure TfrmCadLibTintas.btnAlterarClick(Sender: TObject);
begin
  if cadLibTintas.fPodeAlterar then
  begin
    cadLibTintas.AlterarAntes(Self, GetStrState);
    inherited;
    pDesabilitaCamposChaves;
    SelectFirst;
    cadLibTintas.AlterarDepois(Self, GetStrState);
  end;
end;

procedure TfrmCadLibTintas.btnAtivarNfmClick(Sender: TObject);
begin
  If qryCadastro.IsEmpty Then
  Begin
   fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
   Exit;
  End;

  cadLibTintas.AtivarNovasFormulas(Self, GetStrState);
end;

procedure TfrmCadLibTintas.btnCancelaClick(Sender: TObject);
begin
  cadLibTintas.CancelarAntes(Self, GetStrState);
  inherited;
  cadLibTintas.CarregarDescricoes(Self);
  cadLibTintas.CancelarDepois(Self, GetStrState);
end;

procedure TfrmCadLibTintas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  if cadLibTintas.fPodeExcluir then
  begin
    cadLibTintas.ExcluirAntes(Self, GetStrState);
    inherited;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;

    cadLibTintas.ExcluirDepois(Self, GetStrState);
  end;
end;

procedure TfrmCadLibTintas.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  if cadLibTintas.fPodeGravar(self, GetStrState) then
  begin
    cadLibTintas.GravarAntes(Self, GetStrState);
    inherited;

    If blnGravou Then
      fCommit
    Else
      fRollBack;

    cadLibTintas.GravarDepois(Self, GetStrState);
  end;
end;

procedure TfrmCadLibTintas.btnIncluirClick(Sender: TObject);
begin
  if cadLibTintas.fPodeIncluir(self, GetStrState) then
  Begin
    cadLibTintas.IncluirAntes(Self, GetStrState);

    inherited;

    blnUsaProCodigo := False;
    SelectFirst;
    cadLibTintas.IncluirDepois(Self, GetStrState);
  End;
end;

procedure TfrmCadLibTintas.btnPesquisaClick(Sender: TObject);
var
  arrSel: TConsultasArray;
  key: Char;
begin
  cadLibTintas.PesquisarAntes(Self, GetStrState);
  Key := '/';
  if fPesqGenericaTinta(Self, cadLibTintas.NomeTabela, qryTabela, Key, arrSel, True, cadLibTintas.GetNomeCampoItem, '', False) Then
  Begin
    pSetFocus(btnAlterar);
    cadLibTintas.CarregarDescricoes(Self);
    FormatarCampos();
  End;
  cadLibTintas.PesquisarDepois(Self, GetStrState);
end;

procedure TfrmCadLibTintas.ConstruirComponentes;
var
  intCont: Integer;
begin
  for intCont := 0 to cadLibTintas.LibTintaControlesVisuaisCont - 1 do
  begin
    ConstruirControle(cadLibTintas.LibTintaControlesVisuais[intCont]);
  end;

end;

procedure TfrmCadLibTintas.ConstruirControle(const controle: ILibTintaControleVisual);
var
  control: TControl;
begin
  control := TLibTintaControleFactory.GetControl(controle, pnlCampos, Self);
  control.Tag := 99;
end;

procedure TfrmCadLibTintas.ConstruirTela;
begin
  Self.Caption := fRetornaNomeTinta(cadLibTintas.IdePro) + ' - ' + cadLibTintas.Titulo;
  Self.strNomeTabela := cadLibTintas.NomeTabela;
  Self.strNomeCampo := cadLibTintas.NomeCampo;
  pnlNomeForm.Caption := cadLibTintas.ClassName;
  ConstruirComponentes;
end;

constructor TfrmCadLibTintas.Create(AOwner: TComponent; const cadLibTintas: ICadLibTintas);
begin
  Self.cadLibTintas := cadLibTintas;
  inherited Create(AOwner);
  pCriarDataSets;
  Self.strNomeCampoRelacionamentoConsulta := cadLibTintas.NomeCampoRelacionamento;
  ConstruirTela;
  pLigarDataSets;
  pSetaCamposChaves;
  LigarKeyDowns;
end;

procedure TfrmCadLibTintas.DBComboBoxClick(Sender: TObject);
begin
  CadLibTintas.AjustarCampos(Self);
end;

procedure TfrmCadLibTintas.DBRadioGroupClick(Sender: TObject);
begin
  If DBRadioGroup.Items[DBRadioGroup.ItemIndex] = 'ML' Then
    cadLibTintas.pAjustarCamposMl(Self)
  Else
    cadLibTintas.pAjustarCamposOnca(Self);
end;

function TfrmCadLibTintas.fGetDbEditByFieldName(const strNomeCampo: String): TDBEdit;
  function fGetDbEditByFieldName(const componente: TComponent; const strNomeCampo: String): TDBEdit;
  var
    intCont: Integer;
  begin
    Result := nil;
    if not Assigned(componente) then
      Exit;

    if ((componente is TDBEdit) and ((componente as TDBEdit).DataField = strNomeCampo)) then
    begin
      Result := componente as TDBEdit;
      Exit;
    end;

    for intCont := 0 to componente.ComponentCount - 1 do
    begin
      Result := fGetDbEditByFieldName(componente.Components[intCont], strNomeCampo);
      if Assigned(Result) then
        Exit;
    end;
  end;
begin
  Result := fGetDbEditByFieldName(Self, strNomeCampo);
end;

procedure TfrmCadLibTintas.FormatarCampos;
var
  intCont: Integer;
  intPropriedade: Integer;
  arrPropriedades: TCadLibTintasStringArray;
  arrValores: TCadLibTintasVariantArray;
begin
  for intCont := 0 to qryCadastro.FieldCount - 1 do
  begin
    SetLength(arrPropriedades, 0);
    SetLength(arrValores, 0);
    cadLibTintas.FormatarCampo(qryCadastro.Fields[intCont].FieldName, arrPropriedades, arrValores);
    for intPropriedade := 0 to Length(arrPropriedades) - 1 do
    begin
      SetPropValue(qryCadastro.Fields[intCont], arrPropriedades[intPropriedade], arrValores[intPropriedade]);
    end;
  end;
end;

procedure TfrmCadLibTintas.FormShow(Sender: TObject);
begin
  inherited;
  inherited SelectNext(pnlBotoes, True, True);
  HabilitaBotoesAIE();
  AjustarTela;
  PreencherDBComboBox;
  PreencherComboBox;
  PreencherDBRadioGroup;
  PreencherDBTipoFormula;
end;

function TfrmCadLibTintas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strRetorno: String;
begin
  Result := True;

  If qryCadastro.State in [dsEdit, dsInsert] Then
  Begin
    cadLibTintas.CarregarDescricoes(Self);
    Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

    If Result then
    Begin
      If (Sender Is TDBEdit) Then
        Result := cadLibTintas.fValidaCampos(Self, TDBEdit(Sender).DataField, TDBEdit(Sender).Text, strRetorno)
      Else If (Sender Is TDBComboBox) Then
        Result := cadLibTintas.fValidaCampos(Self, TDBComboBox(Sender).DataField, TDBComboBox(Sender).Text, strRetorno)
      Else If (Sender Is TDBCheckBox) Then
        Result := cadLibTintas.fValidaCampos(Self, TDBCheckBox(Sender).DataField, IIF(TDBCheckBox(Sender).Checked, 'S', 'N') , strRetorno);


      if Length(arrCamposChave) > 0 then
      begin
        If Result And (Sender = arrCamposChave[cadLibTintas.fGetCountCamposChave - 1])
                  And (blnBuscaPorChave) Then
        Begin
          If (Not fBuscaPorCamposChave) Then
          Begin
            pLimparCampos;
          End
          Else
          Begin
            cadLibTintas.CarregarDescricoes(Self);
            FormatarCampos();
          End;

          pSetFocus(Sender);
        End;
      end;
    End;
  End;

  If Not Result Then
  Begin
    If (Not fEmptyStr(strRetorno)) Then
      fMensagem('ATENÇÃO', strRetorno, ['OK']);
    pSetFocus(Sender);
  End;
end;

function TfrmCadLibTintas.GetBlnAlterou: Boolean;
begin
  Result := blnAlterou;
end;

function TfrmCadLibTintas.GetBlnExcluiu: Boolean;
begin
  Result := blnExcluiu;
end;

function TfrmCadLibTintas.GetBlnGravou: Boolean;
begin
  Result := blnGravou;
end;

function TfrmCadLibTintas.GetComponenteByName(const componenteRaiz: TComponent; const strNome: string): TComponent;
var
  intCont: Integer;
begin
  Result := nil;
  if componenteRaiz.Name = strNome then
  begin
    Result := componenteRaiz;
    Exit;
  end;

  for intCont := 0 to componenteRaiz.ComponentCount - 1 do
  begin
    Result := GetComponenteByName(componenteRaiz.Components[intCont], strNome);
    if Assigned(Result) then
      Exit;
  end;

end;

function TfrmCadLibTintas.GetLibTintaControleVisualNome(const strNome: string): ILibTintaControleVisual;
var
  controle: TComponent;
begin
  Result := nil;
  controle := GetComponenteByName(Self, strNome);
  if Assigned(controle) and (controle is TControl) then
    Result := TControlILibTintaControleVisualWrapper.Create(controle as TControl, Self)
  else
    raise Exception.CreateFmt('Não foi possivel encontrar o controle [%s]', [strNome]);
end;

function TfrmCadLibTintas.GetSelf: ILibTintaControleVisual;
begin
  Result := GetLibTintaControleVisualNome(Self.Name);
end;

function TfrmCadLibTintas.GetStrState: string;
begin
  Result := GetEnumName(TypeInfo(TDataSetState), Integer(qryCadastro.State));
end;

function TfrmCadLibTintas.GetTextDBComboBox: String;
begin
  Result := DBComboBox.Text;
end;

procedure TfrmCadLibTintas.HabilitaBotoesAIE;
begin
  btnIncluir.Visible := True;
  btnExcluir.Visible := True;
  btnAlterar.Visible := True;
end;

procedure TfrmCadLibTintas.LigarKeyDowns;
  procedure LigarKeyDowns(const componente: TComponent);
  var
    intCont: Integer;
  begin
    if not Assigned(componente) then
      Exit;

    If (componente Is TDBEditFocus) Then
    Begin
      (componente As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (componente Is TDBCheckBox) Then
    Begin
      (componente As TDBCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TCheckBox) Then
    Begin
      (componente As TCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TRadioButton) Then
    Begin
      (componente As TRadioButton).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TDBComboBoxFocus) Then
    Begin
      (componente As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (componente Is TEditFocus) Then
    Begin
      (componente As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (componente Is TMaskEditTelefone) Then
    Begin
      TMaskEditTelefone(componente).pSetTelefo(opcBrasil);

      If (componente As TMaskEditTelefone).Tag = 99 Then
        (componente As TMaskEditTelefone).OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TMaskEditTelefone).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TMaskEditFocus) Then
    Begin
      If (componente As TMaskEditFocus).Tag = 99 Then
        (componente As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TMaskEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TFilenameEditFocus) Then
    Begin
      If (componente As TFilenameEditFocus).Tag = 99 Then
        (componente As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TfraDirectoryEditFocus) Then
    Begin
      If (componente As TfraDirectoryEditFocus).Tag = 99 Then
        (componente As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDown;
    End

    Else If (componente Is TComboBoxFocus) Then
    Begin

      If (componente As TComboBoxFocus).Tag = 99 Then
        (componente As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TComboBoxFocus).OnKeyDown := pOnKeyDown;

    End

    Else If (componente Is TCurrencyEditFocus) Then
    Begin
      If (componente As TCurrencyEditFocus).Tag = 99 Then
        (componente As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (componente As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
    End;

    for intCont := 0 to componente.ComponentCount - 1 do
    begin
      LigarKeyDowns(componente.Components[intCont]);
    end;
  end;
begin
  LigarKeyDowns(Self);
end;

procedure TfrmCadLibTintas.pCriarDataSets;
begin
  qryCadastro := fCriarQuery('SELECT * FROM ' + cadLibTintas.NomeTabela, Self);
  cadLibTintas.SetQueryCadastro(TUniQueryDataSetWrapper.Create(qryCadastro));
  dtsCadastro := fCriaDataSource(qryCadastro);

  qryTabela := qryCadastro;

  qryCadastro.AfterInsert := pSetaEnableReadOnly;
  qryCadastro.AfterEdit := pSetaEnableReadOnly;
  qryCadastro.AfterPost := pSetaEnableReadOnly;
  qryCadastro.AfterDelete := pSetaEnableReadOnly;
  qryCadastro.AfterOpen := pSetaEnableReadOnly;
  qryCadastro.AfterRefresh := pSetaEnableReadOnly;
  qryCadastro.AfterScroll := pSetaEnableReadOnly;
  qryCadastro.AfterCancel := pSetaEnableReadOnly;

  FormatarCampos();

end;

procedure TfrmCadLibTintas.pDesabilitaCamposChaves;
var
  intCont: Integer;
begin
  For intCont := 0 To Length(arrCamposChave) - 1 Do
  Begin
    arrCamposChave[intCont].Enabled := False;
  End;
end;

procedure TfrmCadLibTintas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  if Assigned(cadLibTintas.GetConsulta) then
  begin
    stlCampos.Text := cadLibTintas.GetConsulta.fGetTodosCamposIndices();
    stlCamInd.Text := cadLibTintas.GetConsulta.fGetTodosCamposIndices();
    stlDesInd.Text := cadLibTintas.GetConsulta.fGetTodosDesCamposIndices();
  end;
end;

procedure TfrmCadLibTintas.pLigarDataSets(dbeEdit: TDBEdit; lblLabel: TLabel; strNomeCampo: String);
begin
  If Assigned(dbeEdit) Then
  Begin
    dbeEdit.DataField := strNomeCampo;
    dbeEdit.Visible := Not fEmptyStr(strNomeCampo);
    dbeEdit.Tag := IfThen(dbeEdit.Visible, 99, 0);
  End;

  If Assigned(lblLabel) Then
  Begin
    lblLabel.Visible := Not fEmptyStr(strNomeCampo);
  End;
end;

procedure TfrmCadLibTintas.PreencherComboBox;
var
  stlDesc: TStringList;
  intCont: Integer;
begin
  If cadLibTintas.GetPreencherComboBox Then
  Begin
    Try
      stlDesc := TStringList.Create;
      stlDesc.StrictDelimiter := True;
      stlDesc.CommaText := cadLibTintas.GetDescComboBox;

      If stlDesc.Count > 0 Then
      Begin
        for intCont := 0 to stlDesc.Count - 1 do
          ComboBox.Items.Add(stlDesc[intCont]);
      End;

      ComboBox.Style := csOwnerDrawFixed;
    Finally
      FreeAndNil(stlDesc);
    End;
  End;
end;

procedure TfrmCadLibTintas.PreencherDBComboBox;
var
  stlDesc: TStringList;
  intCont: Integer;
begin
  If cadLibTintas.GetPreencherDbComboBox Then
  Begin
    Try
      stlDesc := TStringList.Create;
      stlDesc.StrictDelimiter := True;
      stlDesc.CommaText := cadLibTintas.GetDescDbComboBox;

      If stlDesc.Count > 0 Then
      Begin
        for intCont := 0 to stlDesc.Count - 1 do
          DBComboBox.Items.Add(stlDesc[intCont]);
      End;

      DBComboBox.Style := csOwnerDrawFixed;
    Finally
      FreeAndNil(stlDesc);
    End;
  End;
end;

procedure TfrmCadLibTintas.PreencherDBRadioGroup;
begin
  If cadLibTintas.GetPreencherDBRadioGroup Then
  Begin
    DBRadioGroup.ItemIndex := 3;
    cadLibTintas.pAjustarRadioGroup(Self, DBRadioGroup.Items);
  End;
end;

procedure TfrmCadLibTintas.PreencherDBTipoFormula;
begin
  If CadLibTintas.GetTipoFormula Then
  Begin
    DBTipoFormula.Visible := True;
    CadLibTintas.PreencherTipoFormula(Self, DBTipoFormula.Items);
  End;
end;

procedure TfrmCadLibTintas.pLigarDataSets;
  procedure pLigarDataSetTodos(const componenteRaiz: TComponent);
  var
    intComp: Integer;
  begin
    if not Assigned(componenteRaiz) then
      Exit;

    if (dtsCadastro.DataSet = componenteRaiz) then
      Exit;

    if Assigned(GetPropInfo(componenteRaiz, 'DataSource')) then
      SetObjectProp(componenteRaiz, 'DataSource', dtsCadastro);

    for intComp := 0 to componenteRaiz.ComponentCount - 1 do
      pLigarDataSetTodos(componenteRaiz.Components[intComp]);
  end;
begin
  pLigarDataSetTodos(Self);
end;

procedure TfrmCadLibTintas.pSetaCamposChaves;
var
  intCont: Integer;
  dbeCampo: TDBEdit;
begin

  SetLength(arrCamposChave, cadLibTintas.fGetCountCamposChave);
  For intCont := 0 To cadLibTintas.fGetCountCamposChave - 1 Do
  Begin
    dbeCampo := fGetDbEditByFieldName(cadLibTintas.fGetCampoChave(intCont));
    arrCamposChave[intCont] := dbeCampo;
  End;
end;

procedure TfrmCadLibTintas.pSetaEnableReadOnly(DataSet: TDataSet);
var
  blnCondicao: Boolean;
  blnCondicaoInsert: Boolean;
  blnEnabled: Boolean;


  procedure pSetaEnableReadOnlyInterna(const componente: TComponent);
  var
    intCont: Integer;
  begin
    if not Assigned(componente) then
      Exit;

    For intCont := 0 To componente.ComponentCount - 1 Do
    Begin
      if Assigned(GetPropInfo(componente.Components[intCont], 'DataSource')) then
      Begin
        if Assigned(GetObjectProp(componente.Components[intCont], 'DataSource'))
          and (GetObjectProp(componente.Components[intCont], 'DataSource') = dtsCadastro) then
        begin
          SetPropValue(componente.Components[intCont], 'Enabled', blnEnabled);
          SetPropValue(componente.Components[intCont], 'ReadOnly', Not blnCondicaoInsert);

          if blnCondicao then
          begin
            if MatchStr(GetPropValue(componente.Components[intCont], 'DataField'),
              cadLibTintas.GetCamposDesabilitadosEdit) then
            begin
              SetPropValue(componente.Components[intCont], 'Enabled', False);
              SetPropValue(componente.Components[intCont], 'ReadOnly', True);
            end;
          end;
        end;

      End;
      pSetaEnableReadOnlyInterna(componente.Components[intCont]);
    End;
  end;


begin
  Try
    blnCondicao := qryCadastro.State = dsEdit;
    blnCondicaoInsert := blnCondicao Or (qryCadastro.State = dsInsert);
    blnEnabled := blnCondicaoInsert;

    cadLibTintas.pSetaEnableReadOnly(Self, GetStrState);
    pSetaEnableReadOnlyInterna(Self);

  Except
  End;
end;

procedure TfrmCadLibTintas.pSetarFocus;
begin
  pSetFocus(pnlBotoes);
end;

procedure TfrmCadLibTintas.SelectNext;
begin
  inherited SelectNext(ActiveControl, True, True);
end;

end.
