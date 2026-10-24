unit untImpOrdProIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem, EditFocus, untOrdProIndustrial, frxClass,
  frxExportCSVTestabilidade, MemoFocus, untSalvaDadosInterface,
  untTEditFocusWithTConsultasArray, Uni, Data.DB, untEstadoTela;

type
  TfrmImpOrdProIndustrial = class(TfrmPaiEdit)
    btnImprimir: TBitBtnLocked;
    pnlOPCompleta: TPanel;
    chkOpComp: TCheckBox;
    pnlOpcoes: TPanel;
    pnlFaseDisp: TPanel;
    chkFasDis: TCheckBox;
    Label1: TLabel;
    edtQtdFas: TEditFocus;
    pnlModelo5: TPanel;
    lblQuantidadePartida: TLabel;
    edtQtdPar: TEditFocus;
    Label3: TLabel;
    mmoObservacao: TMemoFocus;
    chkFormul: TCheckBox;
    chkConQua: TCheckBox;
    chkTemPro: TCheckBox;
    chkEnvase: TCheckBox;
    chkCorrec: TCheckBox;
    ChkExtrusao: TCheckBox;
    ChkAnaFor: TCheckBox;
    ChkDadCli: TCheckBox;
    chkVisCon: TCheckBox;
    chkLocFis: TCheckBox;
    chkObsAss: TCheckBox;
    procedure chkOpCompClick(Sender: TObject);
    procedure chkFasDisClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure chkFormulClick(Sender: TObject);
  private
    { Private declarations }
    objSalvaFiltros: TSalvaInterface;
    objEstadoTela : TEstadoTela;
    procedure ExibeChkLocFisVisCon;
  public
    { Public declarations }
    objOrdPro: TOrdProIndustrial;
    blnSoConfigurar : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmImpOrdProIndustrial: TfrmImpOrdProIndustrial;

implementation

uses untFuncoesSimples, untSalvaConfiguracaoGrid;

{$R *.dfm}

procedure TfrmImpOrdProIndustrial.btnImprimirClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  With objOrdPro, recImpres Do
  Begin
    objEstadoTela.pSetEstadoTela;

    blnFormul := chkFormul.Checked;
    blnCorrec := chkCorrec.Checked;
    blnConQua := chkConQua.Checked;
    blnTemPro := chkTemPro.Checked;
    blnEnvase := chkEnvase.Checked;
    blnFasDis := chkFasDis.Checked;
    blnLocFis := chkLocFis.Checked;
    blnVisCon := chkVisCon.Checked;
    blnExtrus := chkExtrusao.Checked;
    blnAnaFor := ChkAnaFor.Checked;
    blnDadCli := ChkDadCli.Checked;
    intQtdFas := StrToIntDef(edtQtdFas.Text, 0);
    strObserv := mmoObservacao.Texto;
    intQtdPar := StrToIntDef(edtQtdPar.Text,0);
    blnObsAss := chkObsAss.Checked;

    If not blnSoConfigurar Then
    Begin
      If fEmptyStr(strCodCorDesenv) Then
        pImprimeOP
      Else
        pImprimeDesenvOP;
    End
    Else
      ModalResult := mrOK;

  End;
end;

procedure TfrmImpOrdProIndustrial.chkFasDisClick(Sender: TObject);
begin
  inherited;

  If chkFasDis.Checked And fEmptyStr(fCfgSis('FASDIS')) Then
  Begin
    pMensagemOk('Configure a Fase de Dispersão em Configurações / Industrial!');
    chkFasDis.Checked := False;
  End;

  edtQtdFas.Enabled := chkFasDis.Checked;

  If edtQtdFas.Enabled Then
    edtQtdFas.Text := '1';

  If Not edtQtdFas.Enabled Then
    edtQtdFas.Clear;
end;

procedure TfrmImpOrdProIndustrial.chkOpCompClick(Sender: TObject);
begin
  inherited;

  pnlOpcoes.Enabled := Not chkOpComp.Checked;
  chkExtrusao.Visible:= fCfgSis('EXMOPI', varBoolean);

  ChkDadCli.Visible := fCfgSis('MDORIN', varInteger) = 4;

  If chkOpComp.Checked Then
  Begin
    chkFormul.Checked := True;
    chkCorrec.Checked := True;
    chkConQua.Checked := True;
    chkTemPro.Checked := True;
    chkEnvase.Checked := True;
    chkExtrusao.Checked := True;
    ChkDadCli.Checked := True;
    chkLocFis.Checked := True;
    chkVisCon.Checked := True;
    chkObsAss.Checked := True;
  End;

  chkExtrusao.Enabled:= Not chkOpComp.Checked;
  chkFormul.Enabled  := Not chkOpComp.Checked;
  chkCorrec.Enabled  := Not chkOpComp.Checked;
  chkConQua.Enabled  := Not chkOpComp.Checked;
  chkTemPro.Enabled  := Not chkOpComp.Checked;
  chkEnvase.Enabled  := Not chkOpComp.Checked;
  ChkAnaFor.Enabled  := Not chkOpComp.Checked;
  ChkDadCli.Enabled  := Not chkOpComp.Checked;
  chkLocFis.Enabled  := Not chkOpComp.Checked;
  chkVisCon.Enabled  := Not chkOpComp.Checked;
  chkObsAss.Enabled  := Not chkOpComp.Checked;
end;

procedure TfrmImpOrdProIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  objSalvaFiltros.fAtualizaDados;
  objSalvaFiltros.fSalvaDados('', 'frmImpOrdProIndustrial', strLoginUsuarioLogado, True, nil);
  FreeAndNil(objSalvaFiltros);
end;

procedure TfrmImpOrdProIndustrial.ExibeChkLocFisVisCon;
begin
  If (fCfgSis('MDORIN', varInteger) = 4) Then
  Begin
    chkLocFis.Visible := chkFormul.Checked;
    chkVisCon.Visible := chkFormul.Checked;
  End;
end;

procedure TfrmImpOrdProIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  blnSoConfigurar := False;
  strFilRel := 'frmManOrdProIndustrial';
  objSalvaFiltros := TSalvaInterface.Create(Self);
  objEstadoTela := TEstadoTela.Create(Self.Name, strLoginUsuarioLogado);
  objEstadoTela.pAddComponenteSalvar(chkOpComp);
  objEstadoTela.pAddComponenteSalvar(chkCorrec);
  objEstadoTela.pAddComponenteSalvar(chkConQua);
  objEstadoTela.pAddComponenteSalvar(chkTemPro);
  objEstadoTela.pAddComponenteSalvar(chkEnvase);
  objEstadoTela.pAddComponenteSalvar(chkFasDis);
  objEstadoTela.pAddComponenteSalvar(edtQtdFas);
  objEstadoTela.pAddComponenteSalvar(chkLocFis);
  objEstadoTela.pAddComponenteSalvar(chkVisCon);
  objEstadoTela.pAddcomponenteSalvar(chkObsAss);
end;

procedure TfrmImpOrdProIndustrial.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objEstadoTela);
end;

procedure TfrmImpOrdProIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  pnlModelo5.Visible := (Pos(fCfgSis('MDORIN', varInteger),'5_8_9_31') > 0) and fEmptyStr(objOrdPro.recImpres.strCodCorDesenv);
  lblQuantidadePartida.Visible:= (fCfgSis('MDORIN', varInteger) <> 8);
  edtQtdPar.Visible:= lblQuantidadePartida.Visible;

  If Not pnlModelo5.Visible Then
    Self.Height := Self.Height - pnlModelo5.Height + 2;

  chkOpComp.Checked := True;
  chkFormul.Checked := True;
  chkCorrec.Checked := True;
  chkConQua.Checked := True;
  chkTemPro.Checked := True;
  chkEnvase.Visible := True;
  chkEnvase.Checked := True;
  pnlFaseDisp.Visible := fCfgSis('MDORIN', varInteger) <> 32;
  chkExtrusao.Visible:= fCfgSis('EXMOPI', varBoolean);
  chkExtrusao.Checked:= True;
  ChkAnaFor.Visible := (fCfgSis('MDORIN', varInteger) = 10);
  ChkAnaFor.Checked := False;
  ChkDadCli.Visible := fCfgSis('MDORIN', varInteger) = 4;
  ChkDadCli.Checked := True;
  chkObsAss.Visible := fCfgSis('MDORIN', varInteger) = 1;
  chkObsAss.Checked := False;
  ExibeChkLocFisVisCon;

  If objSalvaFiltros.fCarregaDados('', Self, 'frmImpOrdProIndustrial', strLoginUsuarioLogado, True, False) Then
  Begin
    objSalvaFiltros.fAtualizaDados;
  End;

  objEstadoTela.pGetEstadoTela;
end;

function TfrmImpOrdProIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtQtdFas) Then
    Begin

      If edtQtdFas.Enabled Then
      Begin

        If chkFasDis.Checked And (StrToIntDef(edtQtdFas.Text, 0) <= 0) Then
        Begin
          pMensagemOk('A Quantidade de Fases deve ser maior que zero!');
          Result := False;
        End;

      End;

    End

    Else
    If (Sender = edtQtdPar) And pnlModelo5.Visible Then
    Begin
      Result := StrToIntDef(edtQtdPar.Text,0) >= 1;

      If Not Result Then
        pMensagemOK('Valor inválido! Digite um valor maior ou igual a 1!');
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImpOrdProIndustrial.chkFormulClick(Sender: TObject);
begin
  ExibeChkLocFisVisCon;
end;

end.

