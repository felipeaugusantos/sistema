unit untDigTintaIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Math, Uni, untFuncEspecificas, untTMatrizSaldosColorantes,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaIndustrial = class(TfrmPai) 
    pnlGeral: TPanel;
    Label1: TLabel;
    edtBasAtu: TEditFocus;
    edtDesBasAtu: TEditFocus;
    Label2: TLabel;
    edtPreBasAtu: TEditFocus;
    lblCompB: TLabel;
    edtBasB: TEditFocus;
    edtDesBasB: TEditFocus;
    lblPreCompB: TLabel;
    edtPreBasB: TEditFocus;
    edtDesAdi: TEditFocus;
    Label5: TLabel;
    pnlTotais: TPanel;
    Label7: TLabel;
    edtValBas: TEditFocus;
    edtValCol: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtValTin: TEditFocus;
    lblNovaBas: TLabel;
    edtNovaBase: TEditFocus;
    edtDesNovaBase: TEditFocus;
    edtPreNovaBase: TEditFocus;
    lblPreNovaBase: TLabel;
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNovaBaseKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    function GetNovaBase: Boolean;
  private
    FfltQtdMaximo: Double;
    FmatrizSaldosColorantes: TClassMatrizSaldosColorantes;

    procedure pCarregaItem(edtCodItem, edtDesItem: TEdit);
    procedure SetfltQtdMaximo(const Value: Double);
    procedure SetmatrizSaldosColorantes(const Value: TClassMatrizSaldosColorantes);
    property blnNovaBase: Boolean read GetNovaBase;
    function fRetornarValidacaoItem(strCodItem : String): String;
    function fMesmaUnidade(strCodItem1, strCodItem2: String): Boolean;
    function fRetSigUniItem(strCodItem: String): String;
    procedure pCarregaItens;
    procedure pHabilitaComplemento;
    procedure pCalcularTotais;
    procedure pCarregaVariaveis;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objFormula: TFormulaIndustrial;

    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String; // cor adicional
    fltPreCus: Double;
    fltPreVen: Double;

    property fltQtdMaximo: Double read FfltQtdMaximo write SetfltQtdMaximo;
    property matrizSaldosColorantes: TClassMatrizSaldosColorantes read FmatrizSaldosColorantes write SetmatrizSaldosColorantes;
  end;

var
  frmDigTintaIndustrial: TfrmDigTintaIndustrial;

implementation

uses  DB, StrUtils,
  untFormulacaoImobiliaria, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}




{************************************************************************}
{* CONFIRMA A TINTA, SELECIONANDO A BASE E COMPLEMENTO CASO SEJA O CASO *}
{*********************************************************************PH*}
procedure TfrmDigTintaIndustrial.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(edtValTin.Text) <= 0) Then
  Begin
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  strDesCor := edtDesAdi.Text;
  fltPreCus := objFormula.fltPreCus;
  fltPreVen := objFormula.fltPreVen;

  FmatrizSaldosColorantes := objFormula.fRetMatrizSaldosColorantes(strNovBas);

  ModalResult := mrOk;
end;


{********************************}
{* EXIBE A FORMULACAO DA TINTA  *}
{*****************************PH*}
procedure TfrmDigTintaIndustrial.btnFormulacaoClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmFormulacaoImobiliaria, frmFormulacaoImobiliaria);
  frmFormulacaoImobiliaria.objFormula := objFormula;
  frmFormulacaoImobiliaria.Caption := frmFormulacaoImobiliaria.Caption + objFormula.strDescri;
  frmFormulacaoImobiliaria.ShowModal;
  FreeAndNil(frmFormulacaoImobiliaria);
end;


procedure TfrmDigTintaIndustrial.SetfltQtdMaximo(const Value: Double);
begin
  FfltQtdMaximo := Value;
end;

{****************************}
{* SETA A MATRIZ DE SALDOS  *}
{*************************PH*}
procedure TfrmDigTintaIndustrial.SetmatrizSaldosColorantes(
  const Value: TClassMatrizSaldosColorantes);
begin
  FmatrizSaldosColorantes := Value;
end;

{*******************************************************************}
{* HABILITA QUANDO O USUARIO FOR ESCOLHER UMA BASE DE OUTRA MARCA, *}
{* SENDO ASSIM VAI TER QUE BAIXAR O COMPLEMENTO SEPARADAMENTE      *}
{****************************************************************PH*}
procedure TfrmDigTintaIndustrial.pHabilitaComplemento;
begin
  edtBasB.Visible := blnNovaBase;
  lblCompB.Visible := blnNovaBase;
  edtDesBasB.Visible := blnNovaBase;
  edtPreBasB.Visible := blnNovaBase;
  lblPreCompB.Visible := blnNovaBase;

  objFormula.strCompB := IfThen(objFormula.strCompB <> '', objFormula.strCompB, ''); 
end;

procedure TfrmDigTintaIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');

end;

procedure TfrmDigTintaIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  edtBasAtu.Text := objFormula.strIteBasOri;
  edtNovaBase.Text := objFormula.strIteBasOri;

  pCarregaItens;
end;

procedure TfrmDigTintaIndustrial.pCarregaItem(edtCodItem,
  edtDesItem: TEdit);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := edtCodItem.Text;
  qryGen.Open;

  edtDesItem.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

function TfrmDigTintaIndustrial.GetNovaBase: Boolean;
begin
  Result := edtBasAtu.Text <> edtNovaBase.Text;
end;

function TfrmDigTintaIndustrial.fValidaCampos(Sender: TWinControl;blnBuscaPorChave: Boolean): Boolean;
Var
  strMensagem : String;
begin
  Result := True;

  {*******************************************}
  {* FAZ AS VALIDACOES NO ITEM DA BASE NOVA  *}
  {****************************************PH*}
  If inherited fValidaCampos(sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtNovaBase Then
    Begin
      pCarregaItem(edtNovaBase, edtDesNovaBase);
      If fEmptyStr(edtNovaBase.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base deve ser escolhida!', ['OK']) = - 1;
      End
      Else If fEmptyStr(edtDesNovaBase.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Item não está cadastrado', ['OK']) = -1;
      End;

      strMensagem := fRetornarValidacaoItem(edtNovaBase.Text);

      if Not fEmptyStr(strMensagem) Then
      Begin
        Result := fMensagem('ATENÇÃO', strMensagem, ['OK']) = -1;
      End
      Else If Not fMesmaUnidade(edtBasAtu.Text, edtNovaBase.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'As unidades não são iguais!', ['OK']) = -1;
      End
      Else
      Begin
        {********************************************************}
        {* CASO PASSE POR TODAS AS VALIDACOES FAZER OS CALCULOS *}
        {*****************************************************PH*}
        {*******************************************}
        {* HABILITAR OU NAO O CAMPO DE COMPLEMENTO *}
        {****************************************PH*}
        pHabilitaComplemento;
        objFormula.strIteBas := edtNovaBase.Text;
        pCarregaVariaveis;
        pCalcularTotais;
      End;
    End
    Else If (Sender = edtBasB) And (edtBasB.Visible) Then
    Begin
      If Not fEmptyStr(edtBasB.Text) Then
      Begin
        pCarregaItem(edtBasB, edtDesBasB);

        If fEmptyStr(edtDesBasB.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O Item não está cadastrado', ['OK']) = -1;
        End;

        strMensagem := fRetornarValidacaoItem(edtBasB.Text);

        if Not fEmptyStr(strMensagem) Then
        Begin
          Result := fMensagem('ATENÇÃO', strMensagem, ['OK']) = -1;
        End
        Else
        Begin
          pHabilitaComplemento;
          objFormula.strCompB := edtBasB.Text;
          pCalcularTotais;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigTintaIndustrial.pCarregaItens;
begin
  pCarregaItem(edtBasAtu, edtDesBasAtu);
  pCarregaItem(edtNovaBase, edtDesNovaBase);

  edtPreBasAtu.Text := FormatFloat('0.00', objFormula.fltVenBas);
end;

{********************************}
{* RETORNA SE O ITEM ESTA ATIVO *}
{*****************************PH*}
function TfrmDigTintaIndustrial.fRetornarValidacaoItem(strCodItem: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Text := 'SELECT I.ITE_ITEBAS '+
                       '     , I.ITE_ITEATI '+
                       '     , G.ITE_IMPLIS '+
                       '  FROM CADITE I     '+
                       ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE '+
                       '                    AND G.ITE_CODEMP = I.ITE_CODEMP '+
                       ' WHERE I.ITE_CODITE = :CODITE ';

    qryGen.ParamByName('CODITE').AsString := strCodItem;
    qryGen.Open;

    If qryGen.FieldByName('ITE_PROEMB').AsString <> 'S' Then
      Result := 'Este produto não é uma embalagem!'
    else
    If qryGen.FieldByName('ITE_ITEATI').AsString <> 'S' Then
      Result := 'Este produto não é está ativo!'
    else
    If qryGen.FieldByName('ITE_IMPLIS').AsString <> 'S' Then
      Result := 'O campo imprime lista deve estar como "S" no cadastro de produtos!'
    else
      Result := '';
  Finally
    FreeAndNil(qryGen);
  End;
end;

{*********************************}
{* RETORNA SE E A MESMA UNIDADE  *}
{******************************PH*}
function TfrmDigTintaIndustrial.fMesmaUnidade(strCodItem1,
  strCodItem2: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM CADITE C1, ');
  qryGen.SQL.Add('   CADUNI U1, ');
  qryGen.SQL.Add('   CADITE C2, ');
  qryGen.SQL.Add('   CADUNI U2 ');
  qryGen.SQL.Add(' WHERE C1.ITE_CODUNI = U1.UNI_CODUNI ');
  qryGen.SQL.Add('     AND C2.ITE_CODUNI = U2.UNI_CODUNI ');
  qryGen.SQL.Add('     AND U1.UNI_SIGUNI = U2.UNI_SIGUNI ');
  qryGen.SQL.Add('     AND C1.ITE_CODITE = :CODITE1 ');
  qryGen.SQL.Add('     AND C2.ITE_CODITE = :CODITE2; ');

  qryGen.ParamByName('CODITE1').AsString := strCodItem1;
  qryGen.ParamByName('CODITE2').AsString := strCodItem2;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmDigTintaIndustrial.pCalcularTotais;
begin
  {************************************************************}
  {* TENTE CALCULAR OS TOTAIS, CASO DE ERRO MOSTRE AO USUARIO *}
  {*********************************************************PH*}
  Try
    objFormula.pCalculaPreco;
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO', E.Message, ['OK']);
    End;
  End;

  {*******************************************}
  {* APOS FAZER OS CALCULOS, MOSTRAR NA TELA *}
  {****************************************PH*}
  edtPreNovaBase.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);

  {******************************************************}
  {* CALCULAR COMPLEMENTO B CASO O MESMO ESTEJA VISIVEL *}
  {***************************************************PH*}
  If (edtBasB.Visible) And (objFormula.strCompB <> '') Then
  Begin
    edtPreBasB.Text := FloatToStrF(objFormula.fltVenBasB, ffFixed, 12, 2);
  End;

  edtValBas.Text := FloatToStrF(objFormula.fltVenBas + objFormula.fltVenBasB , ffFixed, 12, 2);
  edtValCol.Text := FloatToStrF(objFormula.fltVenCol, ffFixed, 12, 2);
  edtValTin.Text := FloatToStrF(objFormula.fltPreVen, ffFixed, 12, 2);
end;


{****************************}
{* TROCA A BASE DA FORMULA  *}
{*************************PH*}
procedure TfrmDigTintaIndustrial.edtNovaBaseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItemEmbalagem(Self, TEdit(Sender), Nil, Nil, key, arrSel, False,  'AND UNI_SIGUNI = "' + fRetSigUniItem(edtBasAtu.Text) + '"') Then
    If fValidaCampos(TEdit(Sender), True) Then
      SelectNext(TEdit(Sender), True, True);
end;

{******************************}
{* RETORNA A SIGLA DA UNIDADE *}
{***************************PH*}
function TfrmDigTintaIndustrial.fRetSigUniItem(strCodItem: String): String;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   UNI_SIGUNI ');
  qryGen.SQL.Add(' FROM CADITE ');
  qryGen.SQL.Add('   INNER JOIN CADUNI ');
  qryGen.SQL.Add('     ON ITE_CODUNI = UNI_CODUNI ');
  qryGen.SQL.Add(' WHERE ITE_CODITE = :CODITE ');

  qryGen.ParamByName('CODITE').AsString := strCodItem;
  qryGen.Open;

  Result := qryGen.FieldByName('UNI_SIGUNI').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmDigTintaIndustrial.pCarregaVariaveis;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_CODITE, ITE_DESITE, ITE_REFERE, ITE_CODUNI FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := objFormula.strIteBas;
  qryGen.Open;

  strNovBas := qryGen.FieldByName('ITE_CODITE').AsString;
  strDesBas := qryGen.FieldByName('ITE_DESITE').AsString;
  strRefere := qryGen.FieldByName('ITE_REFERE').AsString;
  strUniBas := qryGen.FieldByName('ITE_CODUNI').AsString;
  FreeAndNil(qryGen);
end;

end.


