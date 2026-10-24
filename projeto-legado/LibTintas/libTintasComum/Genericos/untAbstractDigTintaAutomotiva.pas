unit untAbstractDigTintaAutomotiva;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, ComboBoxFocus, EditFocus, Vcl.DBCtrls, untFormulacaoAutomotiva,
{$ENDIF}
  SysUtils, Variants, Classes, untAbstractFormulaAutomotiva,
  untIDataSet, untStrUtils, untUltConsultas, untFuncoesGenerica,
  untModoVenda, untTipoEmbalagem, untFloatUtils,  untIConfTinta;

type
{$IFNDEF LINUX}
  TAbstractDigTintaAutomotivaController = Class;

  TfrmAbstractDigTintaAutomotiva = Class(TfrmPai)
    pnlGeral: TPanel;
    btnFormulacao: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlCabecalho: TPanel;
    gpbEmbalagem: TGroupBox;
    Label1: TLabel;
    lblTipo: TLabel;
    edtQtdEmb: TEditFocus;
    rdbLitro: TRadioButton;
    rdbGalao: TRadioButton;
    rdbCopo: TRadioButton;
    rdbSpray: TRadioButton;
    rdgAcerto: TRadioGroup;
    rdbTambor: TRadioButton;
    rdbLata: TRadioButton;
    cmbTipoEmbalagem: TComboBoxFocus;
    rdbBalde: TRadioButton;
    pnlPreco: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    edtPreco: TEditFocus;
    edtPreEmb: TEditFocus;
    edtPrecoSemEmb: TEditFocus;
    pnlAdicional: TPanel;
    lblAdicional: TLabel;
    cmbListaAdicional: TComboBoxFocus;
    pnlRodape: TPanel;
    Label3: TLabel;
    lblQtdMinPermitida: TLabel;
    edtVolume: TEditFocus;
    chkComCat: TCheckBox;
    edtVolMinPermitida: TEditFocus;
    rdbSpraySint: TRadioButton;
    rdbSprayPoli: TRadioButton;
    rdbSprayDuco: TRadioButton;
    pnlTrocaEmb: TPanel;
    pnlConsEmb: TPanel;
    pnlModoVenda: TPanel;
    rdgModoVenda: TRadioGroup;
    chkConsEmb: TCheckBox;
    lblProEmb: TLabel;
    edtProEmb: TEditFocus;
    edtDesProEmb: TEditFocus;
    pnlObservacao: TPanel;
    Label6: TLabel;
    rdgTipoFormula: TRadioGroup;
    edtDescricaoColorista: TEditFocus;
    lblPorcentagemDiluente: TLabel;
    edtDil: TEditFocus;
    lblInfoDilu1: TLabel;
    lblInfoDilu2: TLabel;
    chkResina325: TCheckBox;
    edtPerf: TEditFocus;
    lblPerf: TLabel;
    lblCatalizador: TLabel;
    cmbListaCatalizador: TComboBoxFocus;
    lblDesAdc: TLabel;
    edtDesAdc: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure cmbTipoEmbalagemSelect(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkComCatClick(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure cmbListaAdicionalExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipoEmbalagemExit(Sender: TObject);
    procedure chkConsEmbClick(Sender: TObject);
    procedure rdgAcertoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtProEmbExit(Sender: TObject);
    procedure edtProEmbKeyPress(Sender: TObject; var Key: Char);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure rdgModoVendaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDescricaoColoristaExit(Sender: TObject);
    procedure edtDilExit(Sender: TObject);
    procedure cmbListaAdicionalClick(Sender: TObject);
    procedure edtPerfExit(Sender: TObject);
    procedure cmbListaCatalizadorChange(Sender: TObject);
    procedure cmbListaCatalizadorExit(Sender: TObject);
    procedure edtDesAdcExit(Sender: TObject);
    procedure rdbSprayClick(Sender: TObject);
  private
    { Private declarations }
    procedure pVolumeOriginal();
    procedure pMarcarParaRecarregarBases;
  protected
    Controller: TAbstractDigTintaAutomotivaController;
    procedure pConsultaProEmb(edtItem, edtDesIte: TEdit);
  public
    { Public declarations }
    procedure SetController(AValue: TAbstractDigTintaAutomotivaController);
  end;
  {$ENDIF}

 {$IFDEF LINUX}
  TEditFocus = record
    Text: string;
    Enabled: Boolean;
    ReadOnly: Boolean;
    Visible: Boolean;
  end;

  TLabel = record
    Caption: string;
    Visible: Boolean;
  end;

  TRadioButton = record
    Checked: Boolean;
    Visible: Boolean;
  end;

  TComboBoxFocus = record
    ItemIndex: Integer;
    Items: TStringList;
    Visible: Boolean;
    Enabled: Boolean;
    Text: String;
    Width: Integer;
  end;

  TRadioGroup = record
    ItemIndex: Integer;
    Visible: Boolean;
    Enabled: Boolean;
  end;

  TCheckBox = record
    Visible: Boolean;
    Checked: Boolean;
    Enabled: Boolean;
    Caption: String;
  end;

  TPanel = Record
    Visible: Boolean;
    Height: Integer;
  End;
 {$ENDIF}

 TAbstractDigTintaAutomotivaController = class
 Private
   strEmbPro: String;
   strModVen: String;
   procedure pExitVolume();
   procedure pClickLitro();
   procedure pEmbalagemSelect();
   procedure pClickModoVenda(Sender: TObject);
   procedure SetVolMinimoPermitido();
   procedure AjustaComCatalisador();
   procedure VerificaConexaoSQLServer;
   procedure pVolumeOriginal();
   procedure pMarcarParaRecarregarBases();
 Protected
   blnHabTipoEmb: Boolean;
   intAlturaOri: Integer;
   procedure pDefineEmbalagem; virtual;
   procedure pEmbalagemNaoConfigurada(strCodEmb: String);
   function fPermiteMostrarComboDeEmbalagem: Boolean; virtual;
   procedure pMostrarAcertoTinta;
   procedure pCarregaInfoAdicionais;
   procedure pEmbalagemMudou(strCodEmb: String);
   function  fProdutoEmbalagem(strCodIte: String): String;
 Public
   dtsCadTin: IDataSet;
   Label1: TLabel;
   Label2: TLabel;
   Label3: TLabel;
   Label4: TLabel;
   Label5: TLabel;
   Label6: TLabel;
   lblTipo: TLabel;
   lblAdicional: TLabel;
   lblQtdMinPermitida: TLabel;
   lblProEmb: TLabel;
   lblPorcentagemDiluente: TLabel;
   lblInfoDilu1: TLabel;
   lblInfoDilu2: TLabel;
   lblPerf: TLabel;
   lblCatalizador: TLabel;
   edtQtdEmb: TEditFocus;
   edtPreco: TEditFocus;
   edtPreEmb: TEditFocus;
   edtPrecoSemEmb: TEditFocus;
   edtVolume: TEditFocus;
   edtVolMinPermitida: TEditFocus;
   edtProEmb: TEditFocus;
   edtDesProEmb: TEditFocus;
   edtDescricaoColorista: TEditFocus;
   edtDesAdc: TEditFocus;
   edtDil: TEditFocus;
   edtPerf: TEditFocus;
   rdbLitro: TRadioButton;
   rdbGalao: TRadioButton;
   rdbLata: TRadioButton;
   rdbCopo: TRadioButton;
   rdbSpray: TRadioButton;
   rdbBalde: TRadioButton;
   rdbTambor: TRadioButton;
   rdbSpraySint: TRadioButton;
   rdbSprayPoli: TRadioButton;
   rdbSprayDuco: TRadioButton;
   cmbTipoEmbalagem: TComboBoxFocus;
{$IFNDEF LINUX}
   cmbListaAdicional: TComboBoxFocus;
{$ELSE}
   cmbListaAdicional: TStringList;
{$ENDIF}
   cmbListaCatalizador: TComboBoxFocus;
   rdgModoVenda: TRadioGroup;
   rdgAcerto: TRadioGroup;
   rdgTipoFormula: TRadioGroup;
   chkComCat: TCheckBox;
   chkResina325: TCheckBox;
   chkConsEmb: TCheckBox;
   pnlConsEmb: TPanel;
   pnlTrocaEmb: TPanel;
   pnlAdicional: TPanel;
   Formula: TAbstractFormulaAutomotiva;
   FormulaQtdEsp: TAbstractFormulaAutomotiva;
   strSistema   : String;
   strLinha     : String;
   strDesCor    : String;
   stlDesEmb    : TStringList;
   stlProEmbLt  : TStringList;
   stlProEmbGl  : TStringList;
   stlProEmbLa  : TStringList;
   strProEmbCo  : String; // Copo
   strProEmbSp  : String; // Spray
   strProEmbTb  : String; // Tambor
   strProEmbLa  : String; // Lata
   strProEmbBa  : String; // Balde
   strProEmbSs  : String; // Spray Sintético
   strProEmbPo  : String; // Spray Poliester
   strProEmbSd  : String; // Spray Duco
   fltMixVolMiC : Double; // Volume minímo concentrado
   fltMixVolMiD : Double; // Volume minímo Diluído
   intIndEmb: Integer;
   fltVolumePadraoLitro: Double;
   fltVolumeMaximoLitro: Double;
   fltVolumePadraoGalao: Double;
   fltVolumeMaximoGalao: Double;
   fltVolumePadraoSpray: Double;
   fltVolumeMaximoSpray: Double;
   fltVolumePadraoCopo: Double;
   fltVolumeMaximoCopo: Double;
   fltVolumePadraoTambor: Double;
   fltVolumeMaximoTambor: Double;
   fltVolumePadraoLata: Double;
   fltVolumeMaximoLata: Double;
   fltVolumePadraoBalde: Double;
   fltVolumeMaximoBalde: Double;
   fltVolumePadraoSpraySint: Double;
   fltVolumeMaximoSpraySint: Double;
   fltVolumePadraoSprayPoli: Double;
   fltVolumeMaximoSprayPoli: Double;
   fltVolumePadraoSprayDuco: Double;
   fltVolumeMaximoSprayDuco: Double;
   strVolumeDiluente : String;
   blnConsLinhaDesBas: Boolean;
   blnMosDil2: Boolean;
   strQualid: String;
   procedure pAtualizaPrecos;
   procedure pCalculaPrecos;
   function fConfirmar(): Boolean; virtual;
   procedure pOnShow(Sender: TObject); virtual;
   constructor Create(Formula: TAbstractFormulaAutomotiva); virtual;
   destructor Destroy; override;
 Public
   property EmbPro: String Read strEmbPro Write strEmbPro;
   property ModVen: String Read strModVen Write strModVen;
 End;


{$IFNDEF LINUX}
var
  frmAbstractDigTintaAutomotiva: TfrmAbstractDigTintaAutomotiva;

{$ENDIF}

implementation

uses
  untAutcomTintaFactory;

{$IFNDEF LINUX}
{$R *.dfm}
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not Controller.fConfirmar Then
    Exit;

  ModalResult := mrOk;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.btnFormulacaoClick(Sender: TObject);
begin
  inherited;
  frmFormulacaoAutomotiva := nil;
  Try
    If Controller.formula.EdtDil Then
    Begin
      Controller.formula.pReformulaNovo(cmbListaAdicional.Text, edtDil.Text, Controller.dtsCadTin);
    End;

    Application.CreateForm(TfrmFormulacaoAutomotiva, frmFormulacaoAutomotiva);
    frmFormulacaoAutomotiva.Formula       := Controller.Formula;
    frmFormulacaoAutomotiva.FormulaQtdEsp := Controller.FormulaQtdEsp;

    If (Not Controller.blnMosDil2) Then
    Begin
      frmFormulacaoAutomotiva.lsvFormulacao.Columns[4].Width := 0;
      frmFormulacaoAutomotiva.Width := frmFormulacaoAutomotiva.Width - 100;
    End;

    frmFormulacaoAutomotiva.Caption := frmFormulacaoAutomotiva.Caption + Controller.formula.Descricao;

    frmFormulacaoAutomotiva.blnConsLinhaDesBas := Controller.blnConsLinhaDesBas;

    frmFormulacaoAutomotiva.ShowModal;
  Finally
    If Assigned(frmFormulacaoAutomotiva) Then FreeAndNil(frmFormulacaoAutomotiva);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.chkComCatClick(Sender: TObject);
begin
  inherited;
  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.Formula.ComCatalisador := chkComCat.Checked;
  Controller.Formula.PerfomanceAgent := chkComCat.Checked;

  If Not Controller.Formula.PerfomanceAgent Then
  Begin
    edtPerf.Text := '0';
    edtPerf.Visible := Controller.Formula.fUtilizarPorcentagemAgentePerformance(False);
    edtPerf.Enabled := Controller.Formula.fUtilizarPorcentagemAgentePerformance(False);
    lblPerf.Visible := Controller.Formula.fUtilizarPorcentagemAgentePerformance(False);

    If Controller.Formula.fUtilizaBlinder Then
    Begin
      cmbListaCatalizador.Visible := False;
      lblCatalizador.Visible := False;
    End;
  End
  Else
  Begin
    edtPerf.Visible := Controller.Formula.fUtilizarPorcentagemAgentePerformance(True);
    edtPerf.Enabled := Controller.Formula.fUtilizarPorcentagemAgentePerformance(True);
    lblPerf.Visible := Controller.Formula.fUtilizarPorcentagemAgentePerformance(True);

    If Controller.Formula.fUtilizaBlinder Then
    Begin
      cmbListaCatalizador.Visible := True;
      lblCatalizador.Visible := True;
      cmbListaCatalizador.Left := Controller.Formula.fLeftListaBinder();
      lblCatalizador.Left := Controller.Formula.fLeftListaBinder();
      edtPerf.Left := Controller.Formula.fLeftPercentualBinder();
      lblPerf.Left := Controller.Formula.fLeftPercentualBinder() - 15;
    End;
  End;

  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.chkConsEmbClick(Sender: TObject);
begin
  inherited;
  Controller.Formula.ConsiderarEmbalagem := chkConsEmb.Checked;
  Controller.Formula.Promoc := '';

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  If Not Controller.Formula.ConsiderarEmbalagem Then
    Controller.Formula.CodEmb := '';

  If Controller.Formula.ConsiderarEmbalagem Then
    Controller.pDefineEmbalagem;

  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbListaAdicionalChange(
  Sender: TObject);
begin
  inherited;
  Controller.Formula.IndiceAdicional := cmbListaAdicional.ItemIndex;

  Controller.Formula.pDefineVolumeOriginal;
  Controller.Formula.DefineRegraListaAdicionalChange(edtVolume);

  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbListaAdicionalClick(
  Sender: TObject);
begin
  inherited;
  Controller.pCarregaInfoAdicionais;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbListaAdicionalExit(Sender: TObject);
begin
  inherited;  If (cmbListaAdicional.ItemIndex < 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O campo ' + lblAdicional.Caption + ' deve ser preenchido.', ['&Ok']);
    pSetFocus(cmbListaAdicional);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbListaCatalizadorChange(
  Sender: TObject);
begin
  Controller.Formula.IndiceCatalizador := cmbListaCatalizador.ItemIndex;
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbListaCatalizadorExit(
  Sender: TObject);
begin
  inherited;

  If (cmbListaCatalizador.ItemIndex < 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O campo ' + lblCatalizador.Caption + ' deve ser preenchido.', ['&Ok']);
    pSetFocus(cmbListaCatalizador);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbTipoEmbalagemExit(Sender: TObject);
begin
  inherited;
  If (cmbTipoEmbalagem.ItemIndex < 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O tipo de embalagem deve ser preenchido.', ['&Ok']);
    pSetFocus(cmbListaAdicional);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.cmbTipoEmbalagemSelect(
  Sender: TObject);
begin
  inherited;

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;
  Controller.pDefineEmbalagem;
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtDesAdcExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := TAutcomTintaFactory.Get.fRetirarEspacos(Sender);
end;

procedure TfrmAbstractDigTintaAutomotiva.edtDescricaoColoristaExit(
  Sender: TObject);
begin
  inherited;

  If ((btnConfirma.Visible) And (btnConfirma.Enabled)) Then
    pSetFocus(btnConfirma);

end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtDilExit(Sender: TObject);
begin
  inherited;
  Controller.formula.PorDil := StrToFloat(edtDil.Text);
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtPerfExit(Sender: TObject);
begin
  inherited;
  Controller.Formula.PorPer := StrToFloat(edtPerf.Text);
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtProEmbExit(Sender: TObject);
Var
  strMensagem : String;
begin
  inherited;
  If TStrUtils.fEmptyStr(edtProEmb.Text) Then
  Begin
    If (Not TAutcomTintaFactory.Get.fCfgSis('AUTEMB', varBoolean)) Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('', 'É necessário escolher um produto embalagem.', ['&Ok']);
      pSetFocus(edtProEmb);
      Exit;
    End;
  End
  Else
  Begin
    strMensagem := Controller.fProdutoEmbalagem(edtProEmb.Text);

    If Not TStrUtils.fEmptyStr(strMensagem) Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('', strMensagem, ['&Ok']);
      pSetFocus(edtProEmb);
      Exit;
    End;
  End;

  Controller.Formula.CodEmb := edtProEmb.Text;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtProEmbKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaProEmb(TEdit(Sender), edtDesProEmb);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtQtdEmbExit(Sender: TObject);
begin
  inherited;

  If (TStrUtils.fEmptyStr(edtQtdEmb.Text)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'A quantidade da embalagem deve ser preenchida!', ['&Ok']);
    pSetFocus(edtQtdEmb);
    Exit;
  End
  Else If (TAutcomTintaFactory.Get.fStrToFloat(edtQtdEmb.Text) <= 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'A quantidade da embalagem deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtQtdEmb);
    Exit;
  End;

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.edtVolumeExit(Sender: TObject);
begin
  inherited;
  If (TStrUtils.fEmptyStr(edtVolume.Text)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume deve ser preenchido!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) <= 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLitro.Checked) And (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoLitro, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Litro é ' + FloatTOStrF(Controller.fltVolumeMaximoLitro, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbGalao.Checked) And (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoGalao, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Galão é ' + FloatToStrF(Controller.fltVolumeMaximoGalao, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbCopo.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > Controller.fltVolumeMaximoCopo) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(Controller.fltVolumeMaximoCopo, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoSpray, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray é ' + FloatToStrF(Controller.fltVolumeMaximoSpray, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoTambor, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Tambor é ' + FloatToStrF(Controller.fltVolumeMaximoTambor, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLata.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoLata, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Lata é ' + FloatToStrF(Controller.fltVolumeMaximoLata, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbBalde.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoBalde, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Balde é ' + FloatToStrF(Controller.fltVolumeMaximoBalde, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpraySint.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.Formula.fVolumeMaximoSpraySint(Controller.fltVolumeMaximoSpraySint), 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Sintético é ' + FloatToStrF(Controller.Formula.fVolumeMaximoSpraySint(Controller.fltVolumeMaximoSpraySint), ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayPoli.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoSprayPoli, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Poliéster é ' + FloatToStrF(Controller.fltVolumeMaximoSprayPoli, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayDuco.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Controller.fltVolumeMaximoSprayDuco, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Duco é ' + FloatToStrF(Controller.fltVolumeMaximoSprayDuco, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;



  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.Formula.VolumePro := TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text);
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.FormActivate(Sender: TObject);
begin
  inherited;
//
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Controller.Formula.OnEmbalagemMudou := Nil;
  inherited;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  edtQtdEmb.Text := '1';
  chkConsEmb.Visible := TAutcomTintaFactory.Get.fCfgSis('AUTEMB', varBoolean);
  pnlConsEmb.Visible := Self.chkConsEmb.Visible;
  TAutcomTintaFactory.Get.pSetaCodIte(edtProEmb);

  If (TAutcomTintaFactory.Get.fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  TAutcomTintaFactory.Get.fVerificaAcessoSistema('DIRVISFOR');
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.FormKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  inherited;
{  If Key = VK_RETURN Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End;
  }
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  Controller.intAlturaOri   := Self.Height;
  chkComCat.Visible := Controller.Formula.fMostrarComCatalisador;
  Controller.pOnShow(Sender);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.pConsultaProEmb(edtItem,
  edtDesIte: TEdit);
  Var
    strSQL, strSQLWhere: String;
    qryConsulta: IDataSet;

    arrTitCol: array of string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try

      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_DESITE, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  ITE_REFERE, '; pAddNomeColuna('Referência');
      strSQL := strSQL + '  ITE_CODITE, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  ITE_CODBAR, '; pAddNomeColuna('Cód. Barras');
      strSQL := strSQL + '  ITE_CODUNI, '; pAddNomeColuna('Unidade');
      strSQL := strSQL + '  UNI_SIGUNI, '; pAddNomeColuna('Sigla. Unid.');
      strSQL := strSQL + '  CADITE.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
      strSQLWhere := strSQLWhere + 'WHERE ';
      strSQLWhere := strSQLWhere + '  ITE_PROEMB = "S" ';

      If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM', 'CADITE',
                                               'untAbstractDigTintaAutomotiva', 'Consulta de Itens', qryConsulta, [], []) Then
      Begin

        edtItem.Text := qryConsulta.FieldByName('ITE_CODITE').AsString;
        If fValidaCampos(edtItem, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.pMarcarParaRecarregarBases;
begin
  Controller.Formula.RecBases := True;
  Controller.Formula.Resina325 := chkComCat.Checked;
  If Assigned(Controller.FormulaQtdEsp) Then
  Begin
    Controller.FormulaQtdEsp.RecBases := True;
    Controller.FormulaQtdEsp.Resina325 := chkComCat.Checked;
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.SetController(
  AValue: TAbstractDigTintaAutomotivaController);
Begin
  Controller := AValue;
  Controller.Label1 := Self.Label1;
  Controller.Label2 := Self.Label2;
  Controller.Label3 := Self.Label3;
  Controller.Label4 := Self.Label4;
  Controller.Label5 := Self.Label5;
  Controller.Label6 := Self.Label6;
  Controller.lblTipo := Self.lblTipo;
  Controller.lblAdicional := Self.lblAdicional;
  Controller.lblQtdMinPermitida := Self.lblQtdMinPermitida;
  Controller.lblProEmb := Self.lblProEmb;
  Controller.lblPorcentagemDiluente := Self.lblPorcentagemDiluente;
  Controller.lblInfoDilu1 := Self.lblInfoDilu1;
  Controller.lblInfoDilu2 := Self.lblInfoDilu2;
  Controller.lblPerf := Self.lblPerf;
  Controller.lblCatalizador := Self.lblCatalizador;
  Controller.edtQtdEmb := Self.edtQtdEmb;
  Controller.edtPreco := Self.edtPreco;
  Controller.edtPreEmb := Self.edtPreEmb;
  Controller.edtPrecoSemEmb := Self.edtPrecoSemEmb;
  Controller.edtVolume := Self.edtVolume;
  Controller.edtVolMinPermitida := Self.edtVolMinPermitida;
  Controller.edtProEmb := Self.edtProEmb;
  Controller.edtDesProEmb := Self.edtDesProEmb;
  Controller.edtDescricaoColorista := Self.edtDescricaoColorista;
  Controller.edtDesAdc := Self.edtDesAdc;
  Controller.edtDil := Self.edtDil;
  Controller.edtPerf := Self.edtPerf;
  Controller.rdbLitro := Self.rdbLitro;
  Controller.rdbGalao := Self.rdbGalao;
  Controller.rdbLata := Self.rdbLata;
  Controller.rdbCopo := Self.rdbCopo;
  Controller.rdbSpray := Self.rdbSpray;
  Controller.rdbBalde := Self.rdbBalde;
  Controller.rdbTambor := Self.rdbTambor;
  Controller.rdbSpraySint := Self.rdbSpraySint;
  Controller.rdbSprayPoli := Self.rdbSprayPoli;
  Controller.rdbSprayDuco := Self.rdbSprayDuco;
  Controller.cmbTipoEmbalagem := Self.cmbTipoEmbalagem;
  Controller.cmbListaAdicional := Self.cmbListaAdicional;
  Controller.cmbListaCatalizador := Self.cmbListaCatalizador;
  Controller.rdgModoVenda := Self.rdgModoVenda;
  Controller.rdgAcerto := Self.rdgAcerto;
  Controller.rdgTipoFormula := Self.rdgTipoFormula;
  Controller.chkComCat := Self.chkComCat;
  Controller.chkConsEmb := Self.chkConsEmb;
  Controller.pnlConsEmb := Self.pnlConsEmb;
  Controller.pnlAdicional := Self.pnlAdicional;
  Controller.pnlTrocaEmb := Self.pnlTrocaEmb;
End;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.pVolumeOriginal;
begin
  If (rdbLitro.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teLitro;
    edtVolume.Text := FloatToStrF(Controller.formula.fVolumePadraoLitro(Controller.fltVolumePadraoLitro, rdgModoVenda.ItemIndex, Controller.dtsCadTin), ffNumber, 12, 3);
  End
  Else If (rdbGalao.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teGalao;
    edtVolume.Text := FloatToStrF(Controller.formula.GetVolumePadraGalao(Controller.dtsCadTin), ffNumber, 12, 3);
  End
  Else If (rdbCopo.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teCopo;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoCopo, ffNumber, 12, 3);
  End
  Else If (rdbSpray.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teSpray;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoSpray, ffNumber, 12, 3);
  End
  Else If (rdbTambor.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teTambor;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoTambor, ffNumber, 12, 3);
  End
  Else If (rdbLata.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teLata;
    edtVolume.Text := FloatToStrF(Controller.formula.GetVolumePadraoLata(Controller.dtsCadTin), ffNumber, 12, 3);
  End
  Else If (rdbBalde.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teBalde;
    edtVolume.Text := FloatToStrF(Controller.formula.GetVolumePadraoBalde(Controller.dtsCadTin), ffNumber, 12, 3);
  End
  Else If (rdbSpraySint.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teSintetico;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoSpraySint, ffNumber, 12, 3);
  End
  Else If (rdbSprayPoli.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := tePoliester;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoSprayPoli, ffNumber, 12, 3);
  End
  Else If (rdbSprayDuco.Checked) Then
  Begin
    Controller.Formula.tpeTipEmb := teDuco;
    edtVolume.Text := FloatToStrF(Controller.fltVolumePadraoSprayDuco, ffNumber, 12, 3);
  End;

  Controller.Formula.VolumePro := TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.rdbLitroClick(Sender: TObject);
begin
  inherited;
  pVolumeOriginal();

  If Controller.Formula.GetIdePro = 'LAZ' Then
    Controller.rdgModoVenda.ItemIndex := Controller.Formula.fOutrasEmbalagens(Controller.dtsCadTin, Controller.rdgModoVenda.ItemIndex);


  If Controller.fPermiteMostrarComboDeEmbalagem Then
  Begin
    If Controller.blnHabTipoEmb Then
    Begin
      lblTipo.Visible          := True;
      cmbTipoEmbalagem.Visible := True;
    End;
    cmbTipoEmbalagemSelect(cmbTipoEmbalagem);
  End
  Else
  Begin
    lblTipo.Visible          := False;
    cmbTipoEmbalagem.Visible := False;
    Controller.pDefineEmbalagem;
  End;

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.pAtualizaPrecos;
end;
procedure TfrmAbstractDigTintaAutomotiva.rdbSprayClick(Sender: TObject);
begin
  pVolumeOriginal();

  If Controller.Formula.GetIdePro = 'LAZ' Then
    Controller.rdgModoVenda.ItemIndex :=  Controller.Formula.fSprayVendaConcentrado(Controller.dtsCadTin, Controller.rdgModoVenda.ItemIndex);

  If Controller.fPermiteMostrarComboDeEmbalagem Then
  Begin
    If Controller.blnHabTipoEmb Then
    Begin
      lblTipo.Visible          := True;
      cmbTipoEmbalagem.Visible := True;
    End;
    cmbTipoEmbalagemSelect(cmbTipoEmbalagem);
  End
  Else
  Begin
    lblTipo.Visible          := False;
    cmbTipoEmbalagem.Visible := False;
    Controller.pDefineEmbalagem;
  End;

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.pAtualizaPrecos;
end;

{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.rdgAcertoClick(Sender: TObject);
begin
  inherited;
  Case rdgAcerto.ItemIndex Of
    0: Controller.Formula.FatorAcerto := TAutcomTintaFactory.Get.IIF(Controller.Formula.AcertoValor, 0.0, 1.0);
    1: Controller.Formula.FatorAcerto := TAutcomTintaFactory.Get.fCfgSis('FATAC1', varDouble);
    2: Controller.Formula.FatorAcerto := TAutcomTintaFactory.Get.fCfgSis('FATAC2', varDouble);
  End;
  Controller.Formula.Promoc := '';
  Controller.Formula.pCarregaPrecoPromocaoEmbalagem(Controller.Formula.TabPre);
  Controller.pAtualizaPrecos;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.rdgModoVendaClick(Sender: TObject);
begin
  inherited;
  Case rdgModoVenda.ItemIndex Of
    0: Controller.Formula.mveModoVenda := mvConcentrado;
    Else
      Controller.Formula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) And (Controller.Formula.AdicionalConcentrado) And (Controller.Formula.ListaAdicional.Count > 0)  Then
    pnlAdicional.Visible := True
  Else If (rdgModoVenda.ItemIndex = 1) And (Controller.Formula.AdicionalDiluido) And (Controller.Formula.ListaAdicional.Count > 0)  Then
    pnlAdicional.Visible := True
  Else
    pnlAdicional.Visible := False;

{  If (pnlAdicional.Visible) Then
    Self.Height := 430
  Else
    Self.Height := 387;}

  Self.Height := Controller.intAlturaOri;

  If Not pnlAdicional.Visible Then
    Self.Height := Self.Height - pnlAdicional.Height;

  If Not Controller.pnlConsEmb.Visible Then
    Self.Height := Self.Height - Controller.pnlConsEmb.Height;

  If Not Controller.pnlTrocaEmb.Visible Then
    Self.Height := Self.Height - Controller.pnlTrocaEmb.Height;

  Controller.Formula.pDefineVolumeOriginal;
  pVolumeOriginal();
  Controller.Formula.pModoVendaClick(edtVolume, rdgModoVenda.ItemIndex, cmbListaAdicional.ItemIndex);

  If Controller.formula.fPossuiConexaoSQLServer Then
  Begin
    If Controller.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Controller.pAtualizaPrecos;
  Controller.SetVolMinimoPermitido;
  Controller.AjustaComCatalisador;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaAutomotiva.rdgModoVendaExit(Sender: TObject);
begin
  inherited;
  If(Controller.pnlConsEmb.Visible)Then
    pSetFocus(Controller.pnlConsEmb)
  else
    If (edtProEmb.Visible)Then
      pSetFocus(edtProEmb);
end;
{$ENDIF}

{ TAbstractDigTintaAutomotivaController }

procedure TAbstractDigTintaAutomotivaController.AjustaComCatalisador;
begin
  If (rdgModoVenda.ItemIndex = 0) And (chkComCat.Visible) And (Not Formula.fUtilizaBlinder) Then //Concentrado
  Begin
    chkComCat.Visible := False;
    chkComCat.Checked := False;
  End
  Else If (rdgModoVenda.ItemIndex = 1) And (Not chkComCat.Visible) And Self.Formula.fMostrarComCatalisador Then
    chkComCat.Visible := True;

  If (rdgModoVenda.ItemIndex = 0) And (cmbListaCatalizador.Visible) And (Not Formula.fUtilizaBlinder) Then
  Begin
    cmbListaCatalizador.Visible := False;
    lblCatalizador.Visible      := False;
  End
  Else If (rdgModoVenda.ItemIndex = 1) And (Not cmbListaCatalizador.Visible) And Self.Formula.fMostrarCatalizadorNv(Self.dtsCadTin) Then
  Begin
    cmbListaCatalizador.Visible := True;
    lblCatalizador.Visible := True;
  End;

  If Formula.fUtilizaBlinder Then
  Begin
    chkComCat.Visible := Formula.fVisibleBinder(Self.dtsCadTin);
    chkComCat.Caption := Formula.fCaptionCheckBinder();
  End;
end;

constructor TAbstractDigTintaAutomotivaController.Create(Formula: TAbstractFormulaAutomotiva);
begin
  Self.blnMosDil2     := False;
  Self.intIndEmb      := -1;
  edtQtdEmb.Text := '1';
  Self.strSistema    := '';
  Self.strProEmbCo    := '';
  Self.strProEmbSp    := '';
  Self.strProEmbTb    := '';
  Self.strProEmbLa    := '';
  Self.strProEmbBa    := '';
  Self.strProEmbSs    := '';
  Self.strProEmbPo    := '';
  Self.strProEmbSd    := '';
  Self.fltVolumePadraoLitro  := 0.900;
  Self.fltVolumePadraoGalao  := 3.600;
  Self.fltVolumePadraoSpray  := 0.400;
  Self.fltVolumePadraoCopo   := 0.500;
  Self.fltVolumePadraoTambor := 200.000;
  Self.fltVolumePadraoLata   := 18.000;
  Self.fltVolumePadraoBalde  := 18.000;
  Self.fltVolumePadraoSpraySint  := 0.150;
  Self.fltVolumePadraoSprayPoli  := 0.150;
  Self.fltVolumePadraoSprayDuco  := 0.150;
  Self.blnConsLinhaDesBas := False;

{$IFDEF LINUX}
  If Formula.DadosAdicionais Then
    cmbListaAdicional := TStringList.Create();
{$ENDIF}
end;

destructor TAbstractDigTintaAutomotivaController.Destroy;
begin
  inherited;
{$IFDEF LINUX}
  If Assigned(cmbListaAdicional) Then
    FreeAndNil(cmbListaAdicional);
{$ENDIF}
end;

function TAbstractDigTintaAutomotivaController.fConfirmar: Boolean;
var
  strMensagem: String;
begin
  If (TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) <= 0.0) Then
    Exit(False);

  If (Self.Formula.ConsiderarEmbalagem) And (TStrUtils.fEmptyStr(Self.Formula.CodEmb)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A embalagem não está configurada corretamente. Favor verificar.', ['&Ok']);
    Exit(False);
  End;

  If (Self.Formula.ConsiderarEmbalagem) And (TStrUtils.fEmptyStr(VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [Self.Formula.CodEmb]), ''))) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'O produto embalagem configurado não está cadastrado no sistema.', ['&Ok']);
    Exit(False);
  End;

  If (Self.Formula.ConsiderarEmbalagem) And (Not (TStrUtils.fEmptyStr(Self.Formula.CodEmb))) Then
  Begin
    strMensagem := Self.fProdutoEmbalagem(Self.Formula.CodEmb);

    If Not TStrUtils.fEmptyStr(strMensagem) Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
      Exit(False);
    End;
  End;

{$IFNDEF LINUX}
  if (lblQtdMinPermitida.Visible) and (TAutcomTintaFactory.Get.fStrToFloat(edtVolMinPermitida.text) > 0.0)then
  begin
    if ( TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) < TAutcomTintaFactory.Get.fStrToFloat(edtVolMinPermitida.text)) then
    begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'O volume vendido deverá ser maior que o volume minímo permitido, '+#13#10+'pois um ou mais componentes da formulação ficarão zerados.', ['&Ok']);
      Exit(False);
    end;
  end;

  If (rdgTipoFormula.ItemIndex = -1) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'É necessário escolher o tipo de fórmula (original ou ajustada)!', ['&Ok']);
    pSetFocus(rdgTipoFormula);
    Exit(False);
  End;
{$ENDIF}

  If TAutcomTintaFactory.Get.fCfgSis('TREMTA', varBoolean) And (TStrUtils.fEmptyStr(Self.Formula.CodEmb)) And
    (Not TAutcomTintaFactory.Get.fCfgSis('AUTEMB', varBoolean)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'É necessário escolher um produto embalagem.', ['&Ok']);
    Exit(False);
  End;

  If (Not lblQtdMinPermitida.Visible) Then
  Begin
    If Self.Formula.fQuantidadeMenorIgualZero Then
    Begin
      Exit(False);
    End;
  End;

  If Self.Formula.UsaChapinha And TStrUtils.fEmptyStr(Self.Formula.ProCha) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A fórmula está sem o produto chapinha configurado.' + #13#10 +
                                  'Favor entrar em contato com a Citel.', ['&OK']);
    Exit(False);
  End;

  Self.Formula.QtdEmb   := StrToInt(edtQtdEmb.Text);

  If Self.Formula.EdtDil Then
  Begin
    Self.Formula.PorDil := StrToFloat(edtDil.Text);
  End;

  Self.strDesCor := edtDesAdc.Text;

  Result := True;
end;

function TAbstractDigTintaAutomotivaController.fPermiteMostrarComboDeEmbalagem: Boolean;
begin
  Result := (rdbLitro.Checked) Or (rdbGalao.Checked) Or (rdbLata.Checked);
end;

function TAbstractDigTintaAutomotivaController.fProdutoEmbalagem(
  strCodIte: String): String;
Var
  qryCadIte: IDataSet;
begin
  qryCadIte := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadIte.SQL := 'SELECT I.ITE_PROEMB '+
                   '     , I.ITE_ITEATI '+
                   '     , G.ITE_IMPLIS '+
                   '  FROM CADITE I     '+
                   ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE '+
                   '                    AND G.ITE_CODEMP = :CODEMP '+
                   ' WHERE I.ITE_CODITE = :CODITE';
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryCadIte.Open;

  If qryCadIte.FieldByName('ITE_PROEMB').AsString <> 'S' Then
    Result := 'Este produto não é uma embalagem!'
  else
  If qryCadIte.FieldByName('ITE_ITEATI').AsString <> 'S' Then
    Result := 'Esse produto está inativo!'
  else
  If qryCadIte.FieldByName('ITE_IMPLIS').AsString <> 'S' Then
    Result := 'O campo imprime lista deve estar como "S" no cadastro de produtos!'
  Else
    Result := '';
end;

procedure TAbstractDigTintaAutomotivaController.pAtualizaPrecos;
begin
{$IFNDEF LINUX}
  If Formula.fUtilizaBlinder And (Formula.PerfomanceAgent) Then
  Begin
    Formula.pAtuPorcentagemBlinder(Formula, dtsCadTin);

    If Not TStrUtils.fEmptyStr(cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex]) Then
      Formula.pCalculaBaseAdicional(FloatToStr(Formula.PorPer), dtsCadTin, cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex]);
  End
  Else If (Formula.fUtilizaBlinder) And (Not Formula.PerfomanceAgent) Then
  Begin
    Formula.pAtuPorcentagemBlinder(Formula, dtsCadTin);

    If Not TStrUtils.fEmptyStr(cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex]) Then
      Formula.pCalculaBaseAdicional('0', dtsCadTin, cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex]);
  End;
{$ENDIF}

{$IFNDEF LINUX}
  If cmbListaAdicional.Items <> Nil Then
{$ELSE}
  If cmbListaAdicional <> Nil Then
{$ENDIF}
  Begin
  {$IFNDEF LINUX}
    If Not TStrUtils.fEmptyStr(cmbListaAdicional.Items[cmbListaAdicional.ItemIndex]) Then
  {$ELSE}
    If Not TStrUtils.fEmptyStr(cmbListaAdicional[Self.Formula.SetItemIndexLinuxDiluente(Self.dtsCadTin, cmbListaAdicional)]) Then
  {$ENDIF}
    Begin
    {$IFNDEF LINUX}
      Self.Formula.IndiceAdicional := cmbListaAdicional.ItemIndex;
    {$ELSE}
      Self.Formula.IndiceAdicional := 0;
    {$ENDIF}
      Self.Formula.pAtualizaPorcentagem(Self.Formula, Self.dtsCadTin);

      edtDil.Text    := FloatToStr(Self.formula.PorDil);
      edtPerf.Text   := FloatToStr(Self.Formula.PorPer);

      Self.Formula.pCalcularDiluente({$IFNDEF LINUX}cmbListaAdicional.Items[cmbListaAdicional.ItemIndex],
                                {$ELSE} cmbListaAdicional[Self.Formula.SetItemIndexLinuxDiluente(Self.dtsCadTin, cmbListaAdicional)],{$ENDIF}
                                Self.formula.PorDil, Self.dtsCadTin);

      Self.formula.pReformulaNovo({$IFNDEF LINUX}
                                     cmbListaAdicional.Items[cmbListaAdicional.ItemIndex],
                                     edtDil.Text,
                                  {$ELSE}
                                     cmbListaAdicional[Self.Formula.SetItemIndexLinuxDiluente(Self.dtsCadTin, cmbListaAdicional)],
                                     FloatToStr(Self.Formula.PorDil),
                                  {$ENDIF}
                                  Self.dtsCadTin);

      edtDil.Enabled := Self.formula.HabDil;

      If Pos(Self.Formula.GetIdePro, 'ROB_FAR_DU2_MZA_MZD_AJT_LCA_ALA_') <= 0 Then
      Begin
        edtDil.Visible := Self.formula.EdtDil;
        lblPorcentagemDiluente.Visible := (Self.Formula.EdtDil);
      End
      Else
      Begin
        edtDil.Visible := Self.Formula.HabDil;
        lblPorcentagemDiluente.Visible := (Self.Formula.HabDil);
      End;
    End;
  End;

{$IFNDEF LINUX}
  If (cmbListaCatalizador.Items <> Nil) Then
  Begin
    If Not TStrUtils.fEmptyStr(cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex]) Then
    Begin
      Self.Formula.IndiceCatalizador := cmbListaCatalizador.ItemIndex;
      Self.Formula.pReformulaNovoCatalizador(cmbListaCatalizador.Items[cmbListaCatalizador.ItemIndex], Self.dtsCadTin);
    End;
  End;
{$ENDIF}

  Self.Formula.pCarregaPrecoChapinha(Formula.TabPre);
  Self.pCalculaPrecos;
end;

procedure TAbstractDigTintaAutomotivaController.pCalculaPrecos;
begin
  Try
    Self.Formula.pCarregarBasesSQLServerCasoNecessario;
    Self.Formula.CalcularPrecos;
  Except
    on E: EAbort do
    begin
      raise;
    end;

    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('', E.Message, ['&Ok']);
    End;
  End;


  edtPreEmb.Text := FloatToStrF(Self.Formula.EmbPrecoVenda * TAutcomTintaFactory.Get.fStrToFloat(edtQtdEmb.Text), ffFixed, 12, 2);

  If (rdgModoVenda.ItemIndex = 0) Then
    Self.edtPrecoSemEmb.Text  := FloatToStrF(Self.Formula.PrecoVendaCon, ffFixed, 12, 2)
  Else
    Self.edtPrecoSemEmb.Text  := FloatToStrF(Self.Formula.PrecoVendaDil, ffFixed, 12, 2);

  edtPrecoSemEmb.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) * TAutcomTintaFactory.Get.fStrToFloat(edtQtdEmb.Text),
    ffFixed, 12, 2);

  If TAutcomTintaFactory.Get.fGetConfTinta(Self.Formula.GetIdePro).fGet('ACRMOB') = '1' Then
    edtPreco.Text := FloatToStrF((TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) + TAutcomTintaFactory.Get.fStrToFloat(edtPreEmb.Text)) * (1 + Self.Formula.AcrMob / 100),
      ffFixed, 12, 2)
  Else
    edtPreco.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) + TAutcomTintaFactory.Get.fStrToFloat(edtPreEmb.Text) + Self.Formula.AcrMob,
      ffFixed, 12, 2);

  If Formula.UsaChapinha Then
    edtPreco.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPreco.Text) + Self.Formula.ChaPrecoVenda, ffFixed, 12, 2);

  If Self.Formula.AcertoValor Then
  Begin
    edtPrecoSemEmb.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) + Self.Formula.FatorAcerto, ffFixed, 12, 2);
    edtPreco.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPreco.Text) + Self.Formula.FatorAcerto, ffFixed, 12, 2);
  End
  Else
  Begin
    edtPrecoSemEmb.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPrecoSemEmb.Text) * Formula.FatorAcerto, ffFixed, 12, 2);
    edtPreco.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPreco.Text) * Formula.FatorAcerto, ffFixed, 12, 2);
    edtPreEmb.Text := FloatToStrF(TAutcomTintaFactory.Get.fStrToFloat(edtPreEmb.Text) * Formula.FatorAcerto, ffFixed, 12, 2);
  End;
end;

procedure TAbstractDigTintaAutomotivaController.pCarregaInfoAdicionais;
begin
  If Self.formula.GetIdePro = 'DOX' Then
  Begin
    Self.formula.EdtDil := (Self.formula.ListaAdicional[3] = 'STBLCOATA') Or
    (Self.formula.ListaAdicional[4] = 'STBLADJSL');

    If ((cmbListaAdicional.Text <> 'STBLCOATA') And (cmbListaAdicional.Text <> 'STBLADJSL')) Then
      Self.formula.EdtDil := False;

    If (cmbListaAdicional.Text = 'STBLCOATA') Or (cmbListaAdicional.Text = 'STBLADJSL') Then
    Begin
      lblInfoDilu1.Visible := True;
      lblInfoDilu2.Visible := True;
    End
    Else
    Begin
      lblInfoDilu1.Visible := False;
      lblInfoDilu2.Visible := False;
    End;
  End;
end;

procedure TAbstractDigTintaAutomotivaController.pClickLitro;
begin
  Self.pVolumeOriginal();


  If Self.fPermiteMostrarComboDeEmbalagem Then
  Begin
    If Self.blnHabTipoEmb Then
    Begin
      lblTipo.Visible          := True;
      cmbTipoEmbalagem.Visible := True;
    End;
    pEmbalagemSelect();
  End
  Else
  Begin
    lblTipo.Visible          := False;
    cmbTipoEmbalagem.Visible := False;
    Self.pDefineEmbalagem;
  End;

  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Self.pAtualizaPrecos;
end;

procedure TAbstractDigTintaAutomotivaController.pClickModoVenda(Sender: TObject);
begin
  Case rdgModoVenda.ItemIndex Of
    0: Self.Formula.mveModoVenda := mvConcentrado;
    Else
      Self.Formula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) And (Self.Formula.AdicionalConcentrado) And (Self.Formula.ListaAdicional.Count > 0)  Then
    pnlAdicional.Visible := True
  Else If (rdgModoVenda.ItemIndex = 1) And (Self.Formula.AdicionalDiluido) And (Self.Formula.ListaAdicional.Count > 0)  Then
    pnlAdicional.Visible := True
  Else
    pnlAdicional.Visible := False;

 {$IFNDEF LINUX}
  TForm(Sender).Height := Self.intAlturaOri;

  If Not pnlAdicional.Visible Then
    TForm(Sender).Height := TForm(Sender).Height - pnlAdicional.Height;

  If Not Self.pnlConsEmb.Visible Then
    TForm(Sender).Height := TForm(Sender).Height - Self.pnlConsEmb.Height;

  If Not Self.pnlTrocaEmb.Visible Then
    TForm(Sender).Height := TForm(Sender).Height - Self.pnlTrocaEmb.Height;
 {$ENDIF}

  Self.Formula.pDefineVolumeOriginal;

{$IFNDEF LINUX}
  Self.Formula.pModoVendaClick(edtVolume, rdgModoVenda.ItemIndex, cmbListaAdicional.ItemIndex);
{$ENDIF}

  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Self.pAtualizaPrecos;
  Self.SetVolMinimoPermitido;
  Self.AjustaComCatalisador;
end;

procedure TAbstractDigTintaAutomotivaController.pDefineEmbalagem;
begin
  Self.Formula.Promoc := '';
  Try
    Try
      If Self.Formula.ConsiderarEmbalagem Then
      Begin
        If (rdbLitro.Checked) Or (Self.EmbPro = 'Litro') Then
        Begin
          Self.Formula.CodEmb := Self.stlProEmbLt[cmbTipoEmbalagem.ItemIndex];
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbGalao.Checked) Or (Self.EmbPro = 'Galão') Then
        Begin
          Self.Formula.CodEmb := Self.stlProEmbGl[cmbTipoEmbalagem.ItemIndex];
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbCopo.Checked) Or (Self.EmbPro = 'Copo') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbCo;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbSpray.Checked) Or (Self.EmbPro = 'Spray') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbSp;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbTambor.Checked) Or (Self.EmbPro = 'Tambor') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbTb;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbLata.Checked) Or (Self.EmbPro = 'Lata') Then
        Begin
          if Self.strProEmbLa = '' then
            Self.Formula.CodEmb := Self.stlProEmbLa[cmbTipoEmbalagem.ItemIndex]
          else
            Self.Formula.CodEmb := Self.strProEmbLa;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbBalde.Checked) Or (Self.EmbPro = 'Balde') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbBa;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbSpraySint.Checked) Or (Self.EmbPro = 'Spray Sintetico') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbSs;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbSprayPoli.Checked) Or (Self.EmbPro = 'Spray Poliester') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbPo;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End
        Else If (rdbSprayDuco.Checked) Or (Self.EmbPro = 'Spray Duco') Then
        Begin
          Self.Formula.CodEmb := Self.strProEmbSd;
          Self.pEmbalagemNaoConfigurada(Self.Formula.CodEmb);
        End;
      End;
    Except
      on E: Exception do
      begin
        Self.Formula.CodEmb := '';
        edtPreEmb.Text := '0,00';
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'A embalagem não está configurada corretamente. Favor verificar.', ['OK']);
        Abort;
      end;
    End;
  Finally
  End;
end;

procedure TAbstractDigTintaAutomotivaController.pEmbalagemMudou(
  strCodEmb: String);
begin
  edtProEmb.Text := strCodEmb;
  If TStrUtils.fEmptyStr(strCodEmb) Then
    edtDesProEmb.Text := ''
  Else
    edtDesProEmb.Text := VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [strCodEmb]), '');

  If TAutcomTintaFactory.Get.fCfgSis('TREMTA', varBoolean) Then
    Self.Formula.ConsiderarEmbalagem := (Not TStrUtils.fEmptyStr(edtProEmb.Text));

  Self.pAtualizaPrecos;
end;

procedure TAbstractDigTintaAutomotivaController.pEmbalagemNaoConfigurada(
  strCodEmb: String);
begin
  If TAutcomTintaFactory.Get.fCfgSis('TREMTA', varBoolean) And (TStrUtils.fEmptyStr(strCodEmb)) Then
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A embalagem selecionada não está configurada no auttin. Favor configurar.', ['&Ok']);
end;

procedure TAbstractDigTintaAutomotivaController.pEmbalagemSelect;
begin
  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;
  Self.pDefineEmbalagem;
  Self.pAtualizaPrecos;
end;

procedure TAbstractDigTintaAutomotivaController.pExitVolume();
begin
{$IFNDEF LINUX}
  If (TStrUtils.fEmptyStr(edtVolume.Text)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume deve ser preenchido!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) <= 0) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLitro.Checked) And (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoLitro, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Litro é ' + FloatTOStrF(Self.fltVolumeMaximoLitro, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbGalao.Checked) And (TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoGalao, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Galão é ' + FloatToStrF(Self.fltVolumeMaximoGalao, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbCopo.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > Self.fltVolumeMaximoCopo) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(Self.fltVolumeMaximoCopo, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoSpray, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray é ' + FloatToStrF(Self.fltVolumeMaximoSpray, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoTambor, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Tambor é ' + FloatToStrF(Self.fltVolumeMaximoTambor, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLata.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoLata, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Lata é ' + FloatToStrF(Self.fltVolumeMaximoLata, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbBalde.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoBalde, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Balde é ' + FloatToStrF(Self.fltVolumeMaximoBalde, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpraySint.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.Formula.fVolumeMaximoSpraySint(Self.fltVolumeMaximoSpraySint), 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Sintético é ' + FloatToStrF(Self.Formula.fVolumeMaximoSpraySint(Self.fltVolumeMaximoSpraySint), ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayPoli.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoSprayPoli, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Poliéster é ' + FloatToStrF(Self.fltVolumeMaximoSprayPoli, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayDuco.Checked) And (TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text), 3) > TFloatUtils.fFormataFloat(Self.fltVolumeMaximoSprayDuco, 3)) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'O volume máximo para Spray Duco é ' + FloatToStrF(Self.fltVolumeMaximoSprayDuco, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;
{$ENDIF}



  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
      pMarcarParaRecarregarBases;
  End;

  Self.Formula.VolumePro := TAutcomTintaFactory.Get.fStrToFloat(edtVolume.Text);
  Self.pAtualizaPrecos;
end;

procedure TAbstractDigTintaAutomotivaController.pMarcarParaRecarregarBases;
begin
  Self.Formula.RecBases := True;
  Self.Formula.Resina325 := chkComCat.Checked;
  If Assigned(Self.FormulaQtdEsp) Then
  Begin
    Self.FormulaQtdEsp.RecBases := True;
    Self.FormulaQtdEsp.Resina325 := chkComCat.Checked;
  End;
end;

procedure TAbstractDigTintaAutomotivaController.pMostrarAcertoTinta;
begin
  if (TAutcomTintaFactory.Get.fCfgSis('FATAC1', varDouble) > 1) or (TAutcomTintaFactory.Get.fCfgSis('FATAC2', varDouble) > 1) then
  begin
    rdgAcerto.Visible := True;
  end
  else
  begin
    rdgAcerto.Visible := False;
  end;
end;

procedure TAbstractDigTintaAutomotivaController.pOnShow(Sender: TObject);
Var
  LTipFormulaOriAju: String;
begin
  Self.Formula.OnEmbalagemMudou := Self.pEmbalagemMudou;
  LTipFormulaOriAju := TAutcomTintaFactory.Get.fCfgSis('TIPFOA');

{$IFNDEF LINUX}
  If TAutcomTintaFactory.Get.fCfgSis('TREMTA', varBoolean) Then
  Begin
    Self.chkConsEmb.Visible := False;
    Self.pnlConsEmb.Visible := False;
  End
  Else
  Begin
    lblProEmb.Visible := False;
    edtProEmb.Visible := False;
    edtDesProEmb.Visible := False;
    Self.pnlTrocaEmb.Visible := False;
  End;
{$ENDIF}

  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
      Self.chkResina325.Visible := True;

    If Pos('ESP', Self.formula.Descricao) > 0 Then
      Self.chkResina325.Visible := False;

    If Self.formula.fModoIntegracaoSistema Then
      Self.VerificaConexaoSQLServer;
  End;


  rdgModoVenda.Enabled := Self.Formula.fHabilitaRdgModoVenda(Self.dtsCadTin, Self.Formula.blnTemDiluido, Self.Formula.blnTemConcentrado);

{$IFNDEF LINUX}
  If Self.Formula.fAumentarCampoDiluente Then
    cmbListaAdicional.Width := 220;
{$ENDIF}

  If rdgModoVenda.Enabled Then
    rdgModoVenda.ItemIndex := TAutcomTintaFactory.Get.fGetConfTinta(Self.formula.GetIdePro).fGetInteger('MODVEN')
  Else
    rdgModoVenda.ItemIndex := Self.Formula.fOpcaoRdgMovoVenda(Self.dtsCadTin, Self.Formula.blnTemConcentrado);

  Case rdgModoVenda.ItemIndex Of
    0: Self.Formula.mveModoVenda := mvConcentrado;
    Else
       Self.Formula.mveModoVenda := mvDiluido;
  End;


  If Self.formula.fPossuiConexaoSQLServer Then
  Begin
    If Self.formula.fModoIntegracaoSistema Then
    Begin
      If Pos(Copy(Self.strLinha, 1, 4), Self.formula.LinhaDil) > 0 Then
      Begin
        rdgModoVenda.Enabled := True;
        rdgModoVenda.ItemIndex := 1;
      End
      Else
        rdgModoVenda.ItemIndex := 0;
    End;
  End;

  If Pos(Copy(Self.strLinha,1, 4), Self.formula.LinhaRes) > 0 Then
    Self.chkResina325.Enabled := True;

  If TStrUtils.fEmptyStr(Self.strProEmbCo) Then
    rdbCopo.Visible := False;

  If TStrUtils.fEmptyStr(Self.strProEmbSp) Then
    rdbSpray.Visible := False;

  If TStrUtils.fEmptyStr(Self.strProEmbTb) Then
    rdbTambor.Visible := False;

  If Assigned(Self.stlProEmbLa) Then
  Begin
    If TStrUtils.fEmptyStr(Self.strProEmbLa) And (Self.stlProEmbLa.Count <= 0) Then
      rdbLata.Visible := False;
  End
  Else
  Begin
    If TStrUtils.fEmptyStr(Self.strProEmbLa) Then
      rdbLata.Visible := False;
  End;

  If TStrUtils.fEmptyStr(Self.strProEmbBa) Then
    rdbBalde.Visible := False;

  If TStrUtils.fEmptyStr(Self.strProEmbSs) Then
    rdbSpraySint.Visible := False;

  If TStrUtils.fEmptyStr(Self.strProEmbPo) Then
    rdbSprayPoli.Visible := False;

  If TStrUtils.fEmptyStr(Self.strProEmbSd) Then
    rdbSprayDuco.Visible := False;

  Self.pMostrarAcertoTinta;

{$IFNDEF LINUX}
  cmbTipoEmbalagem.Items.Assign(Self.stlDesEmb);
  If cmbTipoEmbalagem.Items.Count < 1 Then
  Begin
    Raise Exception.Create('Atenção: as embalagens dessa fórmula não foram setadas. Não será possível continuar.');
  End
  Else If cmbTipoEmbalagem.Items.Count = 1 Then
  Begin
    cmbTipoEmbalagem.ItemIndex := 0;
    lblTipo.Visible          := Self.formula.MostrarEmbalagem;
    cmbTipoEmbalagem.Visible := Self.formula.MostrarEmbalagem;
    cmbTipoEmbalagem.Enabled := False;
  End;
{$ENDIF}

  Self.blnHabTipoEmb := cmbTipoEmbalagem.Visible;

  If (Self.Formula.DadosAdicionais) Then
  Begin
    lblAdicional.Caption := Self.Formula.CaptionAdicional;
  {$IFNDEF LINUX}
    cmbListaAdicional.Items.Assign(Self.Formula.ListaAdicional);
    cmbListaAdicional.ItemIndex := 0;
  {$ELSE}
    cmbListaAdicional.Assign(Self.Formula.ListaAdicional);
  {$ENDIF}
  End;

{$IFNDEF LINUX}
  If (Self.Formula.DadosCatalizador) Then
  Begin
    lblCatalizador.Caption  := Self.formula.CaptionCatalizador;
    cmbListaCatalizador.Items.Assign(Self.Formula.ListaCatalizador);
    cmbListaCatalizador.ItemIndex := 0;
  End;
{$ENDIF}

  cmbTipoEmbalagem.ItemIndex := 0;

  Try
    Self.formula.pCarregarBasesSQLServerCasoNecessario;
    Self.Formula.CalcularPrecos;

    If (Self.intIndEmb >= 0) Then
    Begin
      cmbTipoEmbalagem.ItemIndex := Self.intIndEmb;

      If Self.Formula.fBloqueiaTipoEmbalagem Then
        cmbTipoEmbalagem.Enabled   := False;

      If Self.formula.fTipoEmbalagem(Self.intIndEmb, Self.strQualid) Then
      Begin
        rdgModoVenda.ItemIndex := 0;
        rdgModoVenda.Enabled   := False;
      End;
    End
    Else
    Begin
      cmbTipoEmbalagem.ItemIndex := 0;
    End;

    pExitVolume();
    pClickLitro();
    pEmbalagemSelect();
    Self.pAtualizaPrecos;
    pClickModoVenda(Sender);
    Self.SetVolMinimoPermitido;
    Self.AjustaComCatalisador;

  {$IFNDEF LINUX}
    If rdgModoVenda.Enabled and rdgModoVenda.Visible then
      pSetFocus(rdgModoVenda)
    Else If Self.pnlConsEmb.Visible Then
      pSetFocus(Self.chkConsEmb)
    Else If Self.pnlTrocaEmb.Visible and edtProEmb.Enabled Then
      pSetFocus(edtProEmb)
    else If edtQtdEmb.Visible and edtQtdEmb.Enabled Then
      pSetFocus(edtQtdEmb);

      If LTipFormulaOriAju = 'FA' Then
      rdgTipoFormula.ItemIndex := 1
    Else If LTipFormulaOriAju = 'EB' Then
      rdgTipoFormula.ItemIndex := -1;
  {$ENDIF}
  Except
    On E: EAbort Do
    Begin
      Abort;
    End;

    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('', E.Message, ['&Ok']);
    End;
  End;
end;

procedure TAbstractDigTintaAutomotivaController.pVolumeOriginal;
Var
  fltVolumePro: Double;
begin
  fltVolumePro := 0;

  If (rdbLitro.Checked) Or (Self.EmbPro = 'Litro') Then
  Begin
    Self.Formula.tpeTipEmb := teLitro;
    edtVolume.Text := FloatToStrF(Self.formula.fVolumePadraoLitro(Self.fltVolumePadraoLitro, rdgModoVenda.ItemIndex, Self.dtsCadTin), ffNumber, 12, 3);
    fltVolumePro := Self.formula.fVolumePadraoLitro(Self.fltVolumePadraoLitro, rdgModoVenda.ItemIndex, Self.dtsCadTin);
  End
  Else If (rdbGalao.Checked) Or (Self.EmbPro = 'Galão') Then
  Begin
    Self.Formula.tpeTipEmb := teGalao;
    edtVolume.Text := FloatToStrF(Self.formula.GetVolumePadraGalao(Self.dtsCadTin), ffNumber, 12, 3);
    fltVolumePro := Self.formula.GetVolumePadraGalao(Self.dtsCadTin);
  End
  Else If (rdbCopo.Checked) Or (Self.EmbPro = 'Copo') Then
  Begin
    Self.Formula.tpeTipEmb := teCopo;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoCopo, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoCopo;
  End
  Else If (rdbSpray.Checked) Or (Self.EmbPro = 'Spray') Then
  Begin
    Self.Formula.tpeTipEmb := teSpray;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoSpray, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoSpray;
  End
  Else If (rdbTambor.Checked) Or (Self.EmbPro = 'Tambor') Then
  Begin
    Self.Formula.tpeTipEmb := teTambor;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoTambor, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoTambor;
  End
  Else If (rdbLata.Checked) Or (Self.EmbPro = 'Lata') Then
  Begin
    Self.Formula.tpeTipEmb := teLata;
    edtVolume.Text := FloatToStrF(Self.formula.GetVolumePadraoLata(Self.dtsCadTin), ffNumber, 12, 3);
    fltVolumePro := Self.formula.GetVolumePadraoLata(Self.dtsCadTin as IDataSet);
  End
  Else If (rdbBalde.Checked) Or (Self.EmbPro = 'Balde') Then
  Begin
    Self.Formula.tpeTipEmb := teBalde;
    edtVolume.Text := FloatToStrF(Self.formula.GetVolumePadraoBalde(Self.dtsCadTin), ffNumber, 12, 3);
    fltVolumePro := Self.formula.GetVolumePadraoBalde(Self.dtsCadTin);
  End
  Else If (rdbSpraySint.Checked) Or (Self.EmbPro = 'Spray Sintetico') Then
  Begin
    Self.Formula.tpeTipEmb := teSintetico;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoSpraySint, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoSpraySint;
  End
  Else If (rdbSprayPoli.Checked) Or (Self.EmbPro = 'Spray Poliester') Then
  Begin
    Self.Formula.tpeTipEmb := tePoliester;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoSprayPoli, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoSprayPoli;
  End
  Else If (rdbSprayDuco.Checked) Or (Self.EmbPro = 'Spray Duco') Then
  Begin
    Self.Formula.tpeTipEmb := teDuco;
    edtVolume.Text := FloatToStrF(Self.fltVolumePadraoSprayDuco, ffNumber, 12, 3);
    fltVolumePro := Self.fltVolumePadraoSprayDuco;
  End;

  Self.Formula.VolumePro := fltVolumePro;
end;

procedure TAbstractDigTintaAutomotivaController.SetVolMinimoPermitido;
begin
  If (rdgModoVenda.ItemIndex =  0) Or (Self.ModVen = 'C') Then // Concentrado
  Begin
    If (Self.fltMixVolMiC > 0) Then
    begin
      lblQtdMinPermitida.Visible := True;
      edtVolMinPermitida.Visible := True;
      edtVolMinPermitida.Text := FloatToStrF(Self.fltMixVolMiC, ffNumber, 12, 3)
    End
    Else
    Begin
      lblQtdMinPermitida.Visible := false;
      edtVolMinPermitida.Visible := false;
    End
  End
  Else // Diluída
  Begin
    If (Self.fltMixVolMiD > 0) then
    Begin
      lblQtdMinPermitida.Visible := True;
      edtVolMinPermitida.Visible := True;
      edtVolMinPermitida.Text := FloatToStrF(Self.fltMixVolMiD, ffNumber, 12, 3);
    End
    Else
    Begin
      lblQtdMinPermitida.Visible := false;
      edtVolMinPermitida.Visible := false;
    End
  End;
end;

procedure TAbstractDigTintaAutomotivaController.VerificaConexaoSQLServer;
Var
  strSenha    : String;
  strUsuario  : String;
  strHost     : String;
  strDatabase : String;
  Conf        : IConfTinta;
begin
  Conf := TAutcomTintaFactory.Get.fGetConfTinta(Self.formula.GetIdePro);

  strUsuario  := Conf.fGet('USUSQS');
  strSenha    := Conf.fGet('SENSQS');
  strDatabase := Conf.fGet('DATSQS');
  strHost     := Conf.fGet('HOSSQS');

  If TStrUtils.fEmptyStr(strUsuario) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'É necessario configurar a integração com o sistema ' + Self.formula.NomeTinta + '.' + #13 +
      'Campo "Usuário" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If TStrUtils.fEmptyStr(strSenha) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'É necessario configurar a integração com o sistema ' + Self.formula.NomeTinta + '.' + #13 +
      'Campo "Senha" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If TStrUtils.fEmptyStr(strDatabase) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'É necessario configurar a integração com o sistema ' + Self.formula.NomeTinta + '.' + #13 +
    'Campo "Banco" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If TStrUtils.fEmptyStr(strHost) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('', 'É necessario configurar a integração com o sistema ' + Self.formula.NomeTinta + '.' + #13 +
    'Campo "IP / Host" está vazio nas configurações.', ['&Ok']);
    Exit;
  End;
end;

end.
