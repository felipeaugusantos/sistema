unit untConfiguraSQLConsultaEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, BCEditor.Editor.Base, BCEditor.Editor,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  untConfiguraSQLConsulta, cxCheckBox, Vcl.DBCtrls, DBComboBoxFocus, Vcl.Mask,
  DBEditFocus, cxCurrencyEdit, cxDropDownEdit, untClassPanelCx, MemoFocus, System.UITypes;

type
  TfrmConfiguraSQLConsultaEdicao = class(TfrmPaiConfirma)
    dtsSelCon: TDataSource;
    pgcPages: TPageControl;
    tbsSQL: TTabSheet;
    tbsCampos: TTabSheet;
    tbsDiversos: TTabSheet;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    dbeDesAti: TDBEditFocus;
    dbeTABELA: TDBEditFocus;
    Panel1: TPanel;
    Label1: TLabel;
    dbeCAMKEY: TDBLookupComboBox;
    cxgCampos: TcxGrid;
    cxvCampos: TcxGridDBTableView;
    cxvCamposALIAS_: TcxGridDBColumn;
    cxvCamposTITULO: TcxGridDBColumn;
    cxvCamposTIPCAM: TcxGridDBColumn;
    cxvCamposPOSSQL: TcxGridDBColumn;
    cxvCamposEXIBIR: TcxGridDBColumn;
    cxgCamposLevel1: TcxGridLevel;
    bceDefSQL: TBCEditor;
    Label4: TLabel;
    dbeCodBus: TDBLookupComboBox;
    cxvCamposNRODEC: TcxGridDBColumn;
    cxvCamposMASCAR: TcxGridDBColumn;
    btnAltCam: TBitBtnLocked;
    dbeATISEL: TDBCheckBox;
    btnAjuda: TBitBtnLocked;
    btnSQLPadrao: TBitBtnLocked;
    mmoInfo: TMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure cxvCamposTIPCAMGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgcPagesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvCamposNRODECPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnAltCamClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
    procedure btnSQLPadraoClick(Sender: TObject);
  private
    { Private declarations }
    objConfig: TConfiguraSQLConsulta;

    Procedure pAjustaEditorSQL(bceDefSQL: TBCEditor);
    function fVerificaTamanhoTela: Boolean;
    function StrToFont(strFont: string): TFont;

  public
    { Public declarations }

    Class Function fConfiguraConsulta(objDefConsulta: Pointer {TDefConsulta}): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmConfiguraSQLConsultaEdicao: TfrmConfiguraSQLConsultaEdicao;

implementation

{$R *.dfm}

Uses
  StrUtils,
  untAjudaVariaveis,
  untFuncoesSimples,
  untPedeDadosCampoSQL;

Const
  CSFSBOLD      = '|fsBold';
  CSFSITALIC    = '|fsItalic';
  CSFSUNDERLINE = '|fsUnderline';
  CSFSSTRIKEOUT = '|fsStrikeOut';

function TfrmConfiguraSQLConsultaEdicao.StrToFont(strFont: string): TFont;
var
  intPosition: Integer;
  strStyle: string;
begin
  Result := TFont.Create;

  intPosition := Pos(',', strFont);
  Result.Name := Copy(strFont, 1, intPosition - 1);
  Delete(strFont, 1, intPosition);
  intPosition := Pos(',', strFont);
  Result.Size := StrToInt(Copy(strFont, 2, intPosition - 2));
  Delete(strFont, 1, intPosition);
  intPosition := Pos(',', strFont);
  strStyle := '|' + Copy(strFont, 3, intPosition - 4);
  Delete(strFont, 1, intPosition);
  Result.Color := StringToColor(Copy(strFont, 2, Length(strFont)));
  Result.Style := [];
  if(Pos(CSFSBOLD, strStyle ) > 0) then
    Result.Style := Result.Style + [fsBold];
  if(Pos(CSFSITALIC, strStyle) > 0) then
    Result.Style := Result.Style + [fsItalic];
  if(Pos(CSFSUNDERLINE, strStyle) > 0) then
    Result.Style := Result.Style + [fsUnderline];
  if(Pos(CSFSSTRIKEOUT, strStyle) > 0) then
    Result.Style := Result.Style + [fsStrikeout];
end;

procedure TfrmConfiguraSQLConsultaEdicao.btnAjudaClick(Sender: TObject);
  Var
    frmAjudaVariaveis: TfrmAjudaVariaveis;
    mmfMemo: TMemoFocus;
    tbsSheet: TTabSheet;
begin
  inherited;

  pCriarFormularios(TfrmAjudaVariaveis, frmAjudaVariaveis);

  frmAjudaVariaveis.blnCarregaEditor := False;

  // ajuste necessário devido nova rotina que alimenta via banco
  // aqui não será executado, por isso tem que criar dinamicamente

  tbsSheet := TTabSheet.Create(frmAjudaVariaveis.pgcInfo);
  tbsSheet.Name := 'tbsCampos1';
  tbsSheet.Caption := '1 - Variáveis';
  tbsSheet.PageControl := frmAjudaVariaveis.pgcInfo;

  mmfMemo := TMemoFocus.Create(frmAjudaVariaveis);
  mmfMemo.Parent := tbsSheet;
  mmfMemo.Name := 'mmfCampos1';
  mmfMemo.Align := alClient;
  mmfMemo.Color := clInfoBk;
  mmfMemo.ScrollBars := ssVertical;
  mmfMemo.Font := StrToFont('Arial, 8, [fsBold], 000000');
  mmfMemo.Lines.Clear;

  mmfMemo.Text := objConfig.fAjudaVariaveis;
  frmAjudaVariaveis.ShowModal;

  pFreeAndNil(frmAjudaVariaveis);
end;

procedure TfrmConfiguraSQLConsultaEdicao.btnAltCamClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmPedeDadosCampoSQL, frmPedeDadosCampoSQL);


  frmPedeDadosCampoSQL.objConsulta := objConfig;
  frmPedeDadosCampoSQL.dtsCampos.DataSet := objConfig.cdsCampos;

  frmPedeDadosCampoSQL.ShowModal;

  pFreeAndNil(frmPedeDadosCampoSQL);
end;

procedure TfrmConfiguraSQLConsultaEdicao.btnSQLPadraoClick(Sender: TObject);
begin
  inherited;

  mmoInfo.color := clInfobk;

  If fPergunta('Deseja carregar o SQL padrão sobrescrevendo a consulta atual?') Then
  Begin
    bceDefSQL.Text := objConfig.objDefConsulta.strSQLPadrao;
    If objConfig.fVerificaSQL(bceDefSQL.Text) And objConfig.fAtualizaCampos Then
      objConfig.pPreencheNomeColunasSQLPadrao;
  End;

end;

procedure TfrmConfiguraSQLConsultaEdicao.cxvCamposNRODECPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If StrToIntDef(DisplayValue, 0) < 0 Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('O Número de decimais deve ser maior ou igual a zero!');
  End;

end;

procedure TfrmConfiguraSQLConsultaEdicao.cxvCamposTIPCAMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If AText = '0' Then
    AText := 'Campo'

  Else If AText = '0' Then
    AText := 'Sub-select';
end;

procedure TfrmConfiguraSQLConsultaEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;

    If objConfig.fSalvaDados(bceDefSQL.Text) Then
      pMensagemOk('Configurações salvas, será necessário reabrir a consulta!')
    Else
      Action := caNone;
  End;

end;

Procedure TfrmConfiguraSQLConsultaEdicao.pAjustaEditorSQL(bceDefSQL: TBCEditor);
  Var
    rscSQL: TResourceStream;
    rscCores: TResourceStream;
Begin
  Try
    rscSQL   := TResourceStream.Create(HInstance,'MySQLJson',RT_RCDATA);
    bceDefSQL.Highlighter.LoadFromStream(rscSQL);
    FreeAndNil(rscSQL);

    rscCores := TResourceStream.Create(HInstance,'CoresJson',RT_RCDATA);
    bceDefSQL.Highlighter.Colors.LoadFromStream(rscCores);
    FreeAndNil(rscCores);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmConfiguraSQLConsultaEdicao.pAjustaEditorSQL');
  End;

End;

procedure TfrmConfiguraSQLConsultaEdicao.FormCreate(Sender: TObject);
begin
  inherited;

  pAjustaEditorSQL(bceDefSQL);

  objConfig := TConfiguraSQLConsulta.Create(Self);

  cxvCampos.DataController.DataSource := objConfig.cdsCampos.dtsSource;

  dtsSelCon.DataSet := objConfig;

  dbeCAMKEY.ListSource := objConfig.cdsCampos.dtsSource;
  dbeCodBus.ListSource := objConfig.cdsCampos.dtsSource;

  TcxCustomComboBoxProperties(cxvCamposMASCAR.Properties).Items.Text := TConfiguraSQLConsulta.fRetDescricaoMascara;

  If fVerificaTamanhoTela Then
    Self.Position := poScreenCenter;
end;

procedure TfrmConfiguraSQLConsultaEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10:    btnConfirma.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgCampos) Then
               Begin

                 If cxvCamposTITULO.Focused Then
                 Begin
                   If cxvCampos.DataController.IsEOF Then
                     pSetFocus(btnConfirma)
                   Else
                     cxvCampos.NavigatorButtons.Next.Click;
                 End;
               End;
  End;
end;

procedure TfrmConfiguraSQLConsultaEdicao.FormShow(Sender: TObject);
begin
  inherited;

  If objConfig.fCarregaDados(objConfig.objDefConsulta.strChaveConsulta) Then
  Begin
    bceDefSQL.Text := AnsiReplaceStr(objConfig.FieldByName('SEL_SQLCON').AsString, '<<csq>>', #13#10);

    objConfig.Edit;

    cxvCampos.NavigatorButtons.First.Click;
  End;

  pgcPages.ActivePage := tbsSQL;
End;


procedure TfrmConfiguraSQLConsultaEdicao.pgcPagesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  If pgcPages.ActivePage = tbsSQL Then
  Begin
    If Not objConfig.fVerificaSQL(bceDefSQL.Text) Then
    Begin
      AllowChange := False;
      Exit;
    End;

    If Not objConfig.fAtualizaCampos Then
    Begin
      AllowChange := False;
      Exit;
    End;
  End;

end;

function TfrmConfiguraSQLConsultaEdicao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCAMKEY) Then
    Begin

      (*
      If fEmptyStr(dbeCAMKEY.Text) Then
      Begin
        pMensagemOk('O Campo chave deve ser informado!');
        Result := False;
      End;
       *)
    End

    Else If (Sender = dbeTABELA) Then
    Begin

      (*
      If fEmptyStr(dbeTABELA.Text) Then
      Begin
        pMensagemOk('Tabela principal do SQL deve ser informada!');
        Result := False;
      End

      Else If Pos(dbeTABELA.Text, fRetSQL) = 0 Then
      Begin
        pMensagemOk('Tabela não encontrada no SQL!');
        Result := False;
      End;
      *)

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmConfiguraSQLConsultaEdicao.fVerificaTamanhoTela: Boolean;
begin
  Result := False;
  If ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Screen.Width <= 1366) Then
    Result := True
end;

Class Function TfrmConfiguraSQLConsultaEdicao.fConfiguraConsulta(objDefConsulta: Pointer {TDefConsulta}): Boolean;
  Var
    frmConfiguraSQLConsultaEdicao: TfrmConfiguraSQLConsultaEdicao;
Begin
  pCriarFormularios(TfrmConfiguraSQLConsultaEdicao, frmConfiguraSQLConsultaEdicao);

  frmConfiguraSQLConsultaEdicao.objConfig.objDefConsulta := TDefConsulta(objDefConsulta);
  frmConfiguraSQLConsultaEdicao.objConfig.objDefConsulta.blnEditandoSQLConsultaConfigurado := True;

  Result := frmConfiguraSQLConsultaEdicao.ShowModal = mrOk;

  pFreeAndNil(frmConfiguraSQLConsultaEdicao);
End;

end.
