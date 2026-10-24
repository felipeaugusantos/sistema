unit untConfiguracoesDupont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, StrUtils, AppEvnts, QColorLabel, Uni, 
  untIConsultaTinta, untIConfTinta, untConfConsulta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesDupont = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    pnlBotoesConf: TPanel;
    pnlCentral: TPanel;
    chkUsaFor: TCheckBox;
    chkUsaDup: TCheckBox;
    edtTraDup: TEditFocus;
    edtFatDup: TEditFocus;
    Label1: TLabel;
    edtFatCus: TEditFocus;
    Label4: TLabel;
    edtNfmDup: TEditFocus;
    Label13: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    rgOpcoes: TRadioGroup;
    pnlCabecalho: TPanel;
    tbsConfCampos: TTabSheet;
    edtDtaAtu: TMaskEditFocus;
    lblDtaAtu: TLabel;
    lblVersao: TLabel;
    edtVersao: TEditFocus;
    TabSheet1: TTabSheet;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    lblVendaChroma: TLabel;
    edtVendaChroma: TEditFocus;
    edtDesVendaChroma: TEditFocus;
    lblVendaDuxone: TLabel;
    edtVendaDuxone: TEditFocus;
    edtDesVendaDuxone: TEditFocus;
    edtDesVendaIron: TEditFocus;
    edtVendaIron: TEditFocus;
    lblVendaIron: TLabel;
    lblVendaNason: TLabel;
    edtVendaNason: TEditFocus;
    edtDesVendaNason: TEditFocus;
    lblCormax: TLabel;
    edtVendaCormax: TEditFocus;
    edtDesVendaCormax: TEditFocus;
    pnlEmbalagens: TPanel;
    sbEmbalagens: TScrollBox;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtIte1_4: TEditFocus;
    edtIteGal: TEditFocus;
    edtDesIteGal: TEditFocus;
    edtDesIte1_4: TEditFocus;
    edtIteCop: TEditFocus;
    edtDesIteCop: TEditFocus;
    edtIteSpr: TEditFocus;
    edtDesIteSpr: TEditFocus;
    edtIteSps: TEditFocus;
    edtDesIteSps: TEditFocus;
    edtIteSpo: TEditFocus;
    edtDesIteSpo: TEditFocus;
    edtIteSdu: TEditFocus;
    edtDesIteSdu: TEditFocus;
    edtEmbGal: TEditFocus;
    edtEmb1_4: TEditFocus;
    edtNasoLT: TEditFocus;
    edtNasoGL: TEditFocus;
    edtDesNasoGL: TEditFocus;
    edtDesNasoLT: TEditFocus;
    edtChroLT: TEditFocus;
    edtChroGL: TEditFocus;
    edtDesChroGL: TEditFocus;
    edtDesChroLT: TEditFocus;
    edtImroLT: TEditFocus;
    edtImroGL: TEditFocus;
    edtDesImroGL: TEditFocus;
    edtDesImroLT: TEditFocus;
    edtIteLat: TEditFocus;
    edtDesIteLat: TEditFocus;
    edtNasoLA: TEditFocus;
    edtDesNasoLA: TEditFocus;
    edtChroLA: TEditFocus;
    edtDesChroLA: TEditFocus;
    edtImroLA: TEditFocus;
    edtDesImroLA: TEditFocus;
    edtIteBal: TEditFocus;
    edtDesIteBal: TEditFocus;
    edtIteTam: TEditFocus;
    edtDesIteTam: TEditFocus;
    Label29: TLabel;
    edtCormLT: TEditFocus;
    edtDesCormLT: TEditFocus;
    Label30: TLabel;
    edtCormGL: TEditFocus;
    edtDesCormGL: TEditFocus;
    Label31: TLabel;
    edtCormLA: TEditFocus;
    edtDesCormLA: TEditFocus;
    Label32: TLabel;
    edtDecFor: TEditFocus;
    ColorLabel1: TColorLabel;
    Label33: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    fraPatDup: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtProDupKeyPress(Sender: TObject; var Key: Char);
    procedure edtIte1_4KeyPress(Sender: TObject; var Key: Char);
    procedure edtIteGalKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure edtVendaChromaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaDupont: TfrmConfConsulta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure pRetornaDescricaoItem(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
    procedure pRetornaDescricaoItemEsp(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
    function fValidaEmbalagem(edtEmb: TEdit): Boolean;
    function fGetEdtDescri(edtCod: TEdit): TEdit;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  frmConfiguracoesDupont: TfrmConfiguracoesDupont;

implementation

uses
  untFuncoesSimples, Math, untFuncTinta, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesDupont }

procedure TfrmConfiguracoesDupont.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesDupont.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA DUPONT               *}
  {**************************************MV*}

  chkUsaDup.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  
  edtVendaChroma.Text := IfThen(conf.fGet('PROCHR') = '', conf.fGet('PRODUP'), conf.fGet('PROCHR'));
  edtVendaDuxone.Text := IfThen(conf.fGet('PRODUX') = '', conf.fGet('PRODUP'), conf.fGet('PRODUX'));
  edtVendaIron.Text := IfThen(conf.fGet('PROIRO') = '', conf.fGet('PRODUP'), conf.fGet('PROIRO'));
  edtVendaNason.Text := IfThen(conf.fGet('PRONAS') = '', conf.fGet('PRODUP'), conf.fGet('PRONAS'));
  edtVendaCormax.Text := IfThen(conf.fGet('PROCOR') = '', conf.fGet('PRODUP'), conf.fGet('PROCOR'));

  edtDesVendaChroma.Text := fRetNomProduto(edtVendaChroma.Text);
  edtDesVendaDuxone.Text := fRetNomProduto(edtVendaDuxone.Text);
  edtDesVendaIron.Text := fRetNomProduto(edtVendaIron.Text);
  edtDesVendaNason.Text := fRetNomProduto(edtVendaNason.Text);
  edtDesVendaCormax.Text := fRetNomProduto(edtVendaCormax.Text);

  edtEmb1_4.Text    := conf.fGet('EMB1_4');
  edtIte1_4.Text    := conf.fGet('ITE1_4');
  edtDesIte1_4.Text := fRetNomProduto(edtIte1_4.Text);

  edtEmbGal.Text    := conf.fGet('EMBGAL');
  edtIteGal.Text    := conf.fGet('ITEGAL');
  edtIteLat.Text    := conf.fGet('ITELAT');
  edtDesIteGal.Text := fRetNomProduto(edtIteGal.Text);
  edtDesIteLat.Text := fRetNomProduto(edtIteLat.Text);

  edtNasoLT.Text    := conf.fGet('NASOLT');
  edtDesNasoLT.Text := fRetNomProduto(edtNasoLT.Text);
  edtNasoGL.Text    := conf.fGet('NASOGL');
  edtDesNasoGL.Text := fRetNomProduto(edtNasoGL.Text);
  edtNasoLA.Text    := conf.fGet('NASOLA');
  edtDesNasoLA.Text := fRetNomProduto(edtNasoLA.Text);

  edtChroLT.Text    := conf.fGet('CHROLT');
  edtDesChroLT.Text := fRetNomProduto(edtChroLT.Text);

  edtChroGL.Text    := conf.fGet('CHROGL');
  edtDesChroGL.Text := fRetNomProduto(edtChroGL.Text);

  edtChroLA.Text    := conf.fGet('CHROLA');
  edtDesChroLA.Text := fRetNomProduto(edtChroLA.Text);

  edtImroLT.Text    := conf.fGet('IMROLT');
  edtDesImroLT.Text := fRetNomProduto(edtImroLT.Text);

  edtCormLT.Text    := conf.fGet('CORMLT');
  edtDesCormLT.Text := fRetNomProduto(edtCormLT.Text);

  edtCormGL.Text    := conf.fGet('CORMGL');
  edtDesCormGL.Text := fRetNomProduto(edtCormGL.Text);

  edtCormLA.Text    := conf.fGet('CORMLA');
  edtDesCormLA.Text := fRetNomProduto(edtCormLA.Text);

  edtImroGL.Text    := conf.fGet('IMROGL');
  edtDesImroGL.Text := fRetNomProduto(edtImroGL.Text);

  edtImroLA.Text    := conf.fGet('IMROLA');
  edtDesImroLA.Text := fRetNomProduto(edtImroLA.Text);

  edtIteCop.Text    := conf.fGet('ITECOP');
  edtDesIteCop.Text := fRetNomProduto(edtIteCop.Text);

  edtIteSps.Text    := conf.fGet('ITESPS');
  edtDesIteSps.Text := fRetNomProduto(edtIteSps.Text);

  edtIteSpo.Text    := conf.fGet('ITESPO');
  edtDesIteSpo.Text := fRetNomProduto(edtIteSpo.Text);

  edtIteSdu.Text    := conf.fGet('ITESDU');
  edtDesIteSdu.Text := fRetNomProduto(edtIteSdu.Text);

  edtIteBal.Text    := conf.fGet('ITEBAL');
  edtDesIteBal.Text := fRetNomProduto(edtIteBal.Text);

  edtIteTam.Text    := conf.fGet('ITETAM');
  edtDesIteTam.Text := fRetNomProduto(edtIteTam.Text);

  edtTraDup.Text    := conf.fGet('TRADUP');
  edtFatDup.Text    := conf.fGet('FATDUP');
  edtFatCus.Text    := conf.fGet('FATCUS');
  fraPatDup.edtDirectory.text    := conf.fGet('PATDUP');
  edtNfmDup.Text    := conf.fGet('NFMDUP');

  edtAcuAbs.Text    := conf.fGet('ACUABS');
  rgOpcoes.ItemIndex := conf.fGetInteger('TXTDUP');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');

  edtDecFor.Text := conf.fGet('DECFOR');

  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

end;

function TfrmConfiguracoesDupont.fGetEdtDescri(edtCod: TEdit): TEdit;
var
  strNome: string;
begin
  strNome := edtCod.Name;
  Insert('Des', strNome, 4);
  Result := TEdit(FindComponent(strNome));
end;

procedure TfrmConfiguracoesDupont.pGravaArqIni;

begin
  {*****************************************}
  {* GRAVA DADOS DA DUPONT                 *}
  {**************************************MV*}
  conf.pSetBoolean('USATIN', chkUsaDup.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);

  conf.pSet('PROCHR', edtVendaChroma.Text);
  conf.pSet('PRODUX', edtVendaDuxone.Text);
  conf.pSet('PROIRO', edtVendaIron.Text);
  conf.pSet('PRONAS', edtVendaNason.Text);
  conf.pSet('PROCOR', edtVendaCormax.Text);

  conf.pSet('EMB1_4', edtEmb1_4.Text);
  conf.pSet('ITE1_4', edtIte1_4.Text);
  conf.pSet('EMBGAL', edtEmbGal.Text);
  conf.pSet('ITEGAL', edtIteGal.Text);
  conf.pSet('ITELAT', edtIteLat.Text);  
  conf.pSet('NASOLT', edtNasoLT.Text);
  conf.pSet('NASOGL', edtNasoGL.Text);
  conf.pSet('NASOLA', edtNasoLA.Text);
  conf.pSet('CHROLT', edtChroLT.Text);
  conf.pSet('CHROGL', edtChroGL.Text);
  conf.pSet('CHROLA', edtChroLA.Text);
  conf.pSet('IMROLT', edtImroLT.Text);
  conf.pSet('CORMLT', edtCormLT.Text);
  conf.pSet('CORMGL', edtCormGL.Text);
  conf.pSet('CORMLA', edtCormLA.Text);
  conf.pSet('IMROGL', edtImroGL.Text);
  conf.pSet('IMROLA', edtImroLA.Text);  
  conf.pSet('ITECOP', edtIteCop.Text);
  conf.pSet('ITESPS', edtIteSps.Text);
  conf.pSet('ITESPO', edtIteSpo.Text);
  conf.pSet('ITESDU', edtIteSdu.Text);
  conf.pSet('ITEBAL', edtIteBal.Text);
  conf.pSet('ITETAM', edtIteTam.Text);
  conf.pSet('TRADUP', edtTraDup.Text);
  conf.pSet('FATDUP', edtFatDup.Text);
  conf.pSet('FATCUS', edtFatCus.Text);
  conf.pSet('PATDUP', fraPatDup.edtDirectory.text);
  conf.pSet('NFMDUP', edtNfmDup.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);
  conf.pSetInteger('TXTDUP', rgOpcoes.ItemIndex);

  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);
  conf.pSet('DECFOR', edtDecFor.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaDupont.pSalvarConfs;
  fCommit;
end;

procedure TfrmConfiguracoesDupont.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;
end;

procedure TfrmConfiguracoesDupont.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('DUP');
  conf := fGetConfTinta('DUP');

  conf.pInsereCodigo('USATIN', 'Utilizar esta tinta de maquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', 'S');
  conf.pInsereCodigo('PRODUP', 'Produto para venda', '');
  conf.pInsereCodigo('EMB1_4', 'Preço embalagem 1/4', '0,00');
  conf.pInsereCodigo('ITE1_4', 'Produto embalagem 1/4', '');
  conf.pInsereCodigo('EMBGAL', 'Preço embalagem galão', '0,00');
  conf.pInsereCodigo('ITEGAL', 'Produto embalagem galão', '');
  conf.pInsereCodigo('ITELAT', 'Produto embalagem lata', '');  

  conf.pInsereCodigo('NASOLT', 'Produto embalagem Nason litro', '');
  conf.pInsereCodigo('NASOGL', 'Produto embalagem Nason galão', '');
  conf.pInsereCodigo('NASOLA', 'Produto embalagem Nason lata', '');

  conf.pInsereCodigo('CHROLT', 'Produto embalagem Chroma litro', '');
  conf.pInsereCodigo('CHROGL', 'Produto embalagem Chroma galão', '');
  conf.pInsereCodigo('CHROLA', 'Produto embalagem Chroma lata', '');

  conf.pInsereCodigo('IMROLT', 'Produto embalagem Imron litro', '');
  conf.pInsereCodigo('IMROGL', 'Produto embalagem Imron galão', '');
  conf.pInsereCodigo('IMROLA', 'Produto embalagem Imron lata', '');

  conf.pInsereCodigo('CORMLT', 'Produto embalagem Cormax litro', '');
  conf.pInsereCodigo('CORMGL', 'Produto embalagem Cormax galão', '');
  conf.pInsereCodigo('CORMLA', 'Produto embalagem Cormax lata', '');

  conf.pInsereCodigo('ITECOP', 'Produto embalagem copo', '');
//comentado a pedido do ronaldo pelo cliente(cimet - colorimetria)  
//  conf.pInsereCodigo('ITESPR', 'Produto embalagem spray', '');
  conf.pInsereCodigo('ITESPS', 'Produto embalagem spray sintético', '');
  conf.pInsereCodigo('ITESPO', 'Produto embalagem spray poliéster', '');
  conf.pInsereCodigo('ITESDU', 'Produto embalagem spray duco', '');
  conf.pInsereCodigo('ITEBAL', 'Produto embalagem balde', '');
  conf.pInsereCodigo('ITETAM', 'Produto embalagem tambor', '');    
  conf.pInsereCodigo('TRADUP', 'Trava de preço', 'VEN');
  conf.pInsereCodigo('FATDUP', 'Fator da trava de preço', '1,00');
  conf.pInsereCodigo('FATCUS', 'Fator da trava de preço de custo', '1,00');
  conf.pInsereCodigo('PATDUP', 'Path para a geração dos arquivos', '');
  conf.pInsereCodigo('NFMDUP', 'Próximo código da novas fórmulas', '1');
  conf.pInsereCodigo('ACUABS', 'Acumulado / Absoluto', '1');
  conf.pInsereCodigo('TXTDUP', 'Tipo da geração dos arquivos', '1');

  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');

  conf.pInsereCodigo('PROCHR', 'Produto Venda da Linha CHROMA', '');
  conf.pInsereCodigo('PRODUX', 'Produto Venda da Linha DUXONE', '');
  conf.pInsereCodigo('PROIRO', 'Produto Venda da Linha IMRON', '');
  conf.pInsereCodigo('PRONAS', 'Produto Venda da Linha NASON', '');
  conf.pInsereCodigo('PROCOR', 'Produto Venda da Linha CORMAX', '');

  conf.pInsereCodigo('DECFOR', 'Quantidade de casas decimais que serão exibidas nas quantidades da formulação', '1');

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  frmConfConsultaDupont := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
end;

function TfrmConfiguracoesDupont.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtVendaChroma)
      or (Sender = edtVendaDuxone)
      or (Sender = edtVendaIron)
      or (Sender = edtVendaCormax)
      or (Sender = edtVendaNason) Then
    Begin
{
      If (fEmptyStr(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
}
      If (Not (fEmptyStr(TEditFocus(Sender).Text))) Then
      Begin
        pRetornaDescricaoItemEsp(TEditFocus(Sender), pnlCentral);
        If (fEmptyStr(fGetEdtDescri(TEdit(Sender)).Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*******************************************}
    {* EMBALAGEM (1/4)                         *}
    {****************************************MV*}
    Else If (Sender = edtEmb1_4) Then
    Begin
      If (fEmptyStr(edtEmb1_4.Text)) Then
      Begin
        edtEmb1_4.Text := '0,00';
      End
      Else If (fStrToFloat(edtEmb1_4.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço da embalagem (1/4) deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtIte1_4)Or
            (Sender = edtIteGal) Or
            (Sender = edtIteLat) Or
            (Sender = edtNasoLT) Or
            (Sender = edtNasoGL) Or
            (Sender = edtNasoLA) Or
            (Sender = edtChroLT) Or
            (Sender = edtChroGL) Or
            (Sender = edtChroLA) Or
            (Sender = edtImroLT) Or
            (Sender = edtCormLT) Or
            (Sender = edtCormGL) Or
            (Sender = edtCormLA) Or
            (Sender = edtImroGL) Or
            (Sender = edtImroLA) Then
    Begin
      Result := fValidaEmbalagem(TEdit(Sender));
    End

    {*******************************************}
    {* EMBALAGEM (GAL)                         *}
    {****************************************MV*}
    Else If (Sender = edtEmbGal) Then
    Begin
      If (fEmptyStr(edtEmbGal.Text)) Then
      Begin
        edtEmbGal.Text := '0,00';
      End
      Else If (fStrToFloat(edtEmbGal.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço da embalagem (1 GALÃO) deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtIteCop) Then
    Begin
{ ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteCop.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 COPO) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteCop);
        If (fEmptyStr(edtDesIteCop.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteCop.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteCop);
        If (fEmptyStr(edtDesIteCop.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
//comentado a pedido do ronaldo pelo cliente(cimet - colorimetria)    
{
    Else If (Sender = edtIteSpr) Then
    Begin
      If (fEmptyStr(edtIteSpr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 SPRAY) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteSpr);
        If (fEmptyStr(edtDesIteSpr.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
}
    Else If (Sender = edtIteSps) Then
    Begin
{ ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteSps.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 SPRAY) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteSps);
        If (fEmptyStr(edtDesIteSps.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteSps.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteSps);
        If (fEmptyStr(edtDesIteSps.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtIteSpo) Then
    Begin
{  ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteSpo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 SPRAY POLIESTER) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteSpo);
        If (fEmptyStr(edtDesIteSpo.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteSpo.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteSpo);
        If (fEmptyStr(edtDesIteSpo.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtIteSdu) Then
    Begin
{ ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteSdu.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 SPRAY DUCO) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteSdu);
        If (fEmptyStr(edtDesIteSdu.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteSdu.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteSdu);
        If (fEmptyStr(edtDesIteSdu.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtIteBal) Then
    Begin
{ ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteBal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (1 BALDE) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteBal);
        If (fEmptyStr(edtDesIteBal.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteBal.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteBal);
        If (fEmptyStr(edtDesIteBal.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtIteTam) Then
    Begin
{ ronaldo pedio para comentar pq nao quer mais que as embalagens sejam obrigatorias
      If (fEmptyStr(edtIteTam.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para embalagem (TAMBOR) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtIteTam);
        If (fEmptyStr(edtDesIteTam.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
}
      If (not fEmptyStr(edtIteTam.Text)) Then
      Begin
        pRetornaDescricaoItem(edtIteTam);
        If (fEmptyStr(edtDesIteTam.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA CAMPOS DA DUPONT               *}
    {**************************************MV*}
    Else If (Sender = edtTraDup) Then
    Begin

      If fEmptyStr(edtTraDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraDup.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraDup.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatCus) Then
    Begin

      If fEmptyStr(edtFatCus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatCus.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatDup) Then
    Begin

      If fEmptyStr(edtFatDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatDup.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = fraPatDup) Then
    Begin
      If (fEmptyStr(fraPatDup.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

      End;
    End

    Else If (Sender = edtAcuAbs) Then
    Begin
      if not (Pos(edtAcuAbs.Text, '12') > 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
      end;
    End

    Else If (Sender = edtDecFor) Then
    Begin
      If (Pos(edtDecFor.Text, '123') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor das casas decimais deve ser 1,2 ou 3!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDesOpe) Then
    begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesDupont.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmConfiguracoesDupont.Destroy;
begin
  if Assigned(frmConfConsultaDupont) then FreeAndNil(frmConfConsultaDupont);  
  inherited;
end;

procedure TfrmConfiguracoesDupont.edtProDupKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesDupont.edtVendaChromaKeyPress(Sender: TObject; var Key: Char);
begin
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), fGetEdtDescri(TEdit(Sender)));
  End;
end;

procedure TfrmConfiguracoesDupont.edtIte1_4KeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesDupont.edtIteGalKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(pnlEmbalagens, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesDupont.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesDupont.pRetornaDescricaoItem(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
var
  strNomEdt: String;
  edtDesIte: TEdit;
begin    
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(FindComponent(strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesDupont.pRetornaDescricaoItemEsp(edtCodIte: TEdit; pnlPainel: TPanel);
begin
  fGetEdtDescri(edtCodIte).Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesDupont.btnRestaurarClick(Sender: TObject);
begin
  frmConfConsultaDupont.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesDupont.pgcDadosChange(Sender: TObject);
begin
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

function TfrmConfiguracoesDupont.fValidaEmbalagem(edtEmb: TEdit): Boolean;
  Var
    edtDesEmb: TEdit;
    strNomEdt: String;
begin
  Result := True;
{ // comentado a pedido do ronaldo que nao quer mais a obrigatoriedade do preenchimento
  // das embalagens.
  If (fEmptyStr(edtEmb.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Todos os produtos para embalagem devem ser preenchidos!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    strNomEdt := 'edtDes' + RightStr(edtEmb.Name, 6);
    edtDesEmb := TEdit(fComponentByName(pnlEmbalagens, strNomEdt));
    pRetornaDescricaoItem(edtEmb);
    If (fEmptyStr(edtDesEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
      Result := False;
    End;
  End;
}
  If (not fEmptyStr(edtEmb.Text)) Then
  Begin
    strNomEdt := 'edtDes' + RightStr(edtEmb.Name, 6);
    edtDesEmb := TEdit(FindComponent(strNomEdt));
    pRetornaDescricaoItem(edtEmb);
    If (fEmptyStr(edtDesEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
      Result := False;
    End;
  End;
end;

end.
