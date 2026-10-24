unit untAbstractDigTintaIndustrial;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms, untPai, StdCtrls, EditFocus, Controls, BitBtnLockedIncrem,
  Buttons, AppEvnts, ExtCtrls, Menus, frxClass, frxExportCSVTestabilidade,
  Winapi.Windows, Winapi.Messages,
  Vcl.Graphics, Vcl.Dialogs,
{$ENDIF}
  System.SysUtils,
  System.Variants,
  System.Classes,
  untAbstractDigTintaImobiliaria,
  untIDicionario, untIDataSet;

type
 {$IFNDEF LINUX}
  TAbstractDigTintaIndustrialController = class;

  TfrmAbstractDigTintaIndustrial = class(TfrmAbstractDigTintaImobiliaria)
    rdgEmbalagens: TRadioGroup;
    chkUsaCatalisador: TCheckBox;
    lblVolumeFinal: TLabel;
    edtVolumeFinal: TEditFocus;
    procedure rdgEmbalagensClick(Sender: TObject);
    procedure edtNovBasExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkUsaCatalisadorClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pAtualizarTitulo;
    procedure pRetInfoCliente(strCodCli : String; Var strNomCli : String; Var strCliCid : String; Var strCliCpf : String);
    function fLiberarTrocaBase: Boolean;
  protected
    function GetController: TAbstractDigTintaIndustrialController;
  public
    procedure SetController(AValue: TAbstractDigTintaImobiliariaController);
  end;
 {$ENDIF}

 {$IFDEF LINUX}
  TCheckBox = record
    Checked: Boolean;
    Enabled: Boolean;
  end;

  TRadioGroup = record
    Caption: string;
    ItemIndex: Integer;
    Items: TStrings;
  end;
 {$ENDIF}

  TAbstractDigTintaIndustrialController = class(TAbstractDigTintaImobiliariaController)
  public
    strNovaEmbalagem: String;
    blnUsaCatalisador: Boolean;
    dicCodigosEmbalagens: IDicionario;
    dicProdutosBase: IDicionario;
    dicEmbalagens: IDicionario;
    edtVolumeFinal: TEditFocus;
    chkUsaCatalisador: TCheckBox;
    rdgEmbalagens: TRadioGroup;
    procedure pCarregaEmbalagem;
    procedure pSelecionarEmbalagem;
    procedure pOnShow(Sender: TObject); override;
    procedure AtualizarTela; virtual;
    function fConfirmar(): Boolean; override;
    constructor Create; override;
  end;

{$IFNDEF LINUX}
var
  frmAbstractDigTintaIndustrial: TfrmAbstractDigTintaIndustrial;
{$ENDIF}

implementation

uses
{$IFNDEF LINUX}
  untFormulacaoImobiliaria,
{$ENDIF}
  untAutcomTintaFactory, untUltConsultas, untStrUtils,
  untLibTintaFactory, untFuncoesGenerica;

const
  PERSONALIZADA: String = 'PERSONALIZADA';

{$R *.dfm}

procedure TAbstractDigTintaIndustrialController.AtualizarTela;
begin
  Self.formula.ZerarPrecos;
  Self.pCarregaBaseAtu;
  Self.pCarregaNovaBase;
  Self.formula.CalcularPrecosIndustrial;
  chkUsaCatalisador.Enabled := Self.formula.TemCatalisador;
  if not Self.formula.TemCatalisador then
    chkUsaCatalisador.Checked := False;

{$IFNDEF LINUX}
  If (rdgEmbalagens.ItemIndex <> rdgEmbalagens.Items.IndexOf(PERSONALIZADA)) Then
  Begin
    edtValBas.Text := FormatCurr('0.00', Self.formula.BasePrecoVenda);
    edtPreBasAtu.Text := FormatCurr('0.00', Self.formula.BasePrecoVenda);
    edtPreNovBas.Text := FormatCurr('0.00', Self.formula.BasePrecoVenda);
  End
  Else
  Begin
    edtValBas.Text := FormatCurr('0.00', Self.formula.PrecoVendaEmbalagem);
    edtPreBasAtu.Text := FormatCurr('0.00', Self.formula.PrecoVendaEmbalagem);
    edtPreNovBas.Text := FormatCurr('0.00', Self.formula.PrecoVendaEmbalagem);
  End;
{$ENDIF}

  edtValCol.Text := FormatCurr('0.00', Self.formula.ColorantePrecoVenda);  //VerificarPreco;

  If TAutcomTintaFactory.Get.fGetConfTinta(Self.Formula.GetIdePro).fGet('ACRMOB') = '1' Then
    edtValTin.Text := FormatCurr('0.00', Self.formula.PrecoVendaIndustrial * (1 + Self.Formula.AcrMob / 100))
  Else
    edtValTin.Text := FormatCurr('0.00', Self.formula.PrecoVendaIndustrial + Self.Formula.AcrMob);
  edtVolumeFinal.Text := FormatCurr('0.000', Self.formula.VolumeFinal);
end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  If Not Controller.fConfirmar Then
    Exit;

  Close;
  ModalResult := mrOk;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.chkUsaCatalisadorClick(
  Sender: TObject);
begin
  inherited;
  Controller.formula.UsaCatalisador := chkUsaCatalisador.Checked;
  If Assigned(Controller.formula.tintaDeMaquina) Then //REQ 188627.: Movi tintaDeMaquina.Limpar senão ao alternar entre usar ou não catalizador sem o tintaDeMaquina.Limpar o preço não muda;
    Controller.formula.tintaDeMaquina.Limpar;
  TAbstractDigTintaIndustrialController(Controller).AtualizarTela;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.edtNovBasExit(Sender: TObject);
begin
  inherited;
  If Not fLiberarTrocaBase Then
  Begin
    edtBasAtu.Text := Controller.formula.ItemBaseOriginal;
    edtNovBas.Text := Controller.formula.ItemBaseOriginal;

    Controller.pCarregaBaseAtu;
    Controller.pCarregaNovaBase;
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TfrmAbstractDigTintaIndustrial.fLiberarTrocaBase: Boolean;
Var
  strNomCli : String;
  strCliCid : String;
  strCliCpf : String;
begin
  Result := True;

  if (TAutcomTintaFactory.Get.fCfgSis('TRODIR') = 'S')
    And (edtNovBas.Text <> Controller.formula.ItemBaseOriginal) Then
  Begin
    If TStrUtils.fEmptyStr(Controller.formula.strCodCli) Then
      Exit;

    pRetInfoCliente(Controller.formula.strCodCli, strNomCli, strCliCid, strCliCpf);

    Result := TAutcomTintaFactory.Get.fDigSenVarTroDir( Controller.formula.strCodCli + ' - ' + strNomCli
                                                      , strCliCpf
                                                      , strCliCid
                                                      , TAutcomTintaFactory.Get.GetUsuarioLogado
                                                      , Controller.formula.GetIdePro
                                                      , Controller.formula.Descricao
                                                      , Controller.formula.Unidade
                                                      , edtBasAtu.Text + ' - '+ edtDesBasAtu.Text
                                                      , edtNovBas.Text + ' - '+ edtDesNovBas.Text
                                                      , edtDesAdi.Text);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  TAutcomTintaFactory.Get.pSetaCodIte(edtBasAtu);
  TAutcomTintaFactory.Get.pSetaCodIte(edtNovBas);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Or
                  (ActiveControl Is TComboBox) Then
                 SelectNext(ActiveControl, True, True);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TfrmAbstractDigTintaIndustrial.GetController: TAbstractDigTintaIndustrialController;
begin
  Result := TAbstractDigTintaIndustrialController(Self.Controller);
end;
{$ENDIF}

procedure TAbstractDigTintaIndustrialController.pOnShow(Sender: TObject);
begin
  inherited;
  Self.formula.CarregaPrecosColorantes;
  Self.formula.CarregarPrecosBases;
  Self.formula.CarregaPrecosEmbalagens;
  Self.formula.UsaCatalisador := False;

{$IFNDEF LINUX}
  Self.pCarregaEmbalagem;
{$ENDIF}
  AtualizarTela;
 {$IFNDEF LINUX}
  edtBasAtu.SelectAll;
  edtNovBas.SelectAll;
  pSetFocus(edtBasAtu);
  rdgEmbalagens.Buttons[rdgEmbalagens.Items.IndexOf(PERSONALIZADA)].Enabled := False;
 {$ENDIF}
end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.pAtualizarTitulo;
Var
  strAtual:String;
begin
  For strAtual In rdgEmbalagens.Items Do
    Self.Caption := StringReplace(Self.Caption, strAtual, rdgEmbalagens.Items[rdgEmbalagens.ItemIndex], []);
end;
{$ENDIF}

procedure TAbstractDigTintaIndustrialController.pCarregaEmbalagem;
Var
  intContador: Integer;
  intMaxEmbalagem:Integer;
begin

  dicEmbalagens.Limpar;
  rdgEmbalagens.Items.Clear;

  formula.GetEmbalagensDisponivels(dicEmbalagens, dicCodigosEmbalagens, dicProdutosBase);
  intMaxEmbalagem := Formula.MaxEmbalagem;

  For intContador := 0 To intMaxEmbalagem - 1 Do
  Begin
    rdgEmbalagens.Items.Add(Formula.DescEmbalagem[intContador]);
  End;

  rdgEmbalagens.Items.Add(PERSONALIZADA);
  rdgEmbalagens.ItemIndex := rdgEmbalagens.Items.IndexOf(formula.EmbalagemBase);
end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.pRetInfoCliente(strCodCli: String;
  var strNomCli, strCliCid, strCliCpf: String);
var
  qryAux: IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT CLI_NOMCLI '+
                '     , CLI_C_G_C_ '+
                '     , CONCAT(CID_NOMCID,"/",CID_ESTADO) CIDADE '+
                '  FROM CADCLI'+
                ' INNER JOIN CADCID ON CLI_CODCID = CID_CODCID '+
                ' WHERE CLI_CODCLI = :CODCLI';
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;

  strNomCli := qryAux.FieldByName('CLI_NOMCLI').AsString;
  strCliCpf := qryAux.FieldByName('CLI_C_G_C_').AsString;
  strCliCid := qryAux.FieldByName('CIDADE').AsString;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.rdgEmbalagensClick(Sender: TObject);
begin
  GetController.pSelecionarEmbalagem;
  pAtualizarTitulo;
  SelectNext(rdgEmbalagens, True, True);
end;
{$ENDIF}

procedure TAbstractDigTintaIndustrialController.pSelecionarEmbalagem;
begin
{$IFNDEF LINUX}
  Self.formula.Personalizada := rdgEmbalagens.ItemIndex = rdgEmbalagens.Items.IndexOf(PERSONALIZADA);
  edtVolumeFinal.Enabled := Self.formula.Personalizada;
  edtVolumeFinal.ReadOnly := Not Self.formula.Personalizada;
  edtBasAtu.Visible := Not Self.formula.Personalizada;
  edtNovBas.Visible := Not Self.formula.Personalizada;
  edtDesBasAtu.Visible := Not Self.formula.Personalizada;
  edtDesNovBas.Visible := Not Self.formula.Personalizada;

  If (rdgEmbalagens.ItemIndex <> rdgEmbalagens.Items.IndexOf(PERSONALIZADA)) Then
  Begin
    Self.formula.CodigoEmbalagemBase :=
    Self.dicCodigosEmbalagens[rdgEmbalagens.Items[rdgEmbalagens.ItemIndex]];
    Self.formula.ItemBase := Self.dicProdutosBase[rdgEmbalagens.Items[rdgEmbalagens.ItemIndex]];
    Self.formula.VolumeFinal := Self.dicEmbalagens[rdgEmbalagens.Items[rdgEmbalagens.ItemIndex]];
    lblValBas.Caption := 'Valor da Base';
  End
  Else
  Begin
    lblValBas.Caption := 'Valor da Embalagem';
  End;
{$ENDIF}


  Self.AtualizarTela;
end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaIndustrial.SetController(
  AValue: TAbstractDigTintaImobiliariaController);
begin
  Self.Controller := AValue;
  GetController.edtBasAtu := Self.edtBasAtu;
  GetController.edtNovBas := Self.edtNovBas;
  GetController.edtDesAdi := Self.edtDesAdi;
  GetController.edtDesNovBas := Self.edtDesNovBas;
  GetController.edtDesBasAtu := Self.edtDesBasAtu;
  GetController.edtPreBasAtu := Self.edtPreBasAtu;
  GetController.edtPreNovBas := Self.edtPreNovBas;
  GetController.edtValBas := Self.edtValBas;
  GetController.edtValCol := Self.edtValCol;
  GetController.edtValTin := Self.edtValTin;
  GetController.lblNovBas := Self.lblNovBas;
  GetController.lblValBas := Self.lblValBas;
  GetController.lblPreNovBas := Self.lblPreNovBas;
  GetController.edtVolumeFinal := Self.edtVolumeFinal;
  GetController.chkUsaCatalisador := Self.chkUsaCatalisador;
  GetController.rdgEmbalagens := Self.rdgEmbalagens;
end;
{$ENDIF}

constructor TAbstractDigTintaIndustrialController.Create;
begin
  inherited;
  dicEmbalagens := TAutcomTintaFactory.Get.GetDicionario;
  dicProdutosBase := TAutcomTintaFactory.Get.GetDicionario;
  dicCodigosEmbalagens := TAutcomTintaFactory.Get.GetDicionario;
end;

function TAbstractDigTintaIndustrialController.fConfirmar(): Boolean;
begin
  If TAutcomTintaFactory.Get.fStrToFloat(edtValTin.Text) <= 0 Then
    Exit(False);

  If edtNovBas.Text <> Self.formula.ItemBase Then
    Self.Formula.ItemBase := edtNovBas.Text;

  If TAutcomTintaFactory.Get.fStrToFloat(edtVolumeFinal.Text) <= 0 Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'O volume final deve ser maior que Zero!', ['&Ok']);
    edtVolumeFinal.Text := FormatFloat('0.000', Self.formula.VolumeOriginal);
    Exit(False);
  End;

  Self.strDesCor := edtDesAdi.Text;
  Self.fltPreCus := Self.formula.PrecoCustoIndustrial;
  Self.fltPreVen := Self.formula.PrecoVendaIndustrial;
{$IFNDEF LINUX}
  Self.strNovaEmbalagem := rdgEmbalagens.Items[rdgEmbalagens.ItemIndex];
{$ENDIF}
  Self.blnUsaCatalisador := chkUsaCatalisador.Checked;

  Result := True;
end;

end.
