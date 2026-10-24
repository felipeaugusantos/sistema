unit untDigTintaImobiliaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Math, Uni, untFuncEspecificas, untTMatrizSaldosColorantes,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaImobiliaria = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtBasAtu: TEditFocus;
    edtDesBasAtu: TEditFocus;
    Label2: TLabel;
    edtPreBasAtu: TEditFocus;
    Label3: TLabel;
    edtNovBas: TEditFocus;
    edtDesNovBas: TEditFocus;
    Label4: TLabel;
    edtPreNovBas: TEditFocus;
    edtDesAdi: TEditFocus;
    Label5: TLabel;
    pnlTotais: TPanel;
    Label7: TLabel;
    edtValBas: TEditFocus;
    edtValCol: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtValTin: TEditFocus;
    lblDesSuv: TLabel;
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    procedure edtNovBasKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDesAdiExit(Sender: TObject);
    procedure edtNovBasExit(Sender: TObject);
  private
    qryBasAtu: TUniQuery;
    FfltQtdMaximo: Double;
    FmatrizSaldosColorantes: TClassMatrizSaldosColorantes;
    procedure pCarregaNovaBase;
    procedure pCarregaBaseAtu;
    procedure pCarregaItem(qryCadIte: TUniQuery; strCodIte: String;Var strDesIte: String);

    function fLiberarTrocaBase : Boolean;
    function fRetCpfCnpjCliente(strCodCli : String) : String;
    function fRetCidade(strCodCli : String) : String;

    procedure SetfltQtdMaximo(const Value: Double);
    procedure SetmatrizSaldosColorantes(
      const Value: TClassMatrizSaldosColorantes);
    { Private declarations }
  protected
    qryNovBas: TUniQuery;
    procedure pCalculaTotais;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  public
    { Public declarations }
    objFormula: TFormulaImobiliaria;
    objFormulaEsp: TFormulaImobiliaria;

    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String; // cor adicional
    fltPreCus: Double;
    fltPreVen: Double;

    strIdePro: String;
    fltPerDes: Double;

    property fltQtdMaximo: Double read FfltQtdMaximo write SetfltQtdMaximo;
    property matrizSaldosColorantes: TClassMatrizSaldosColorantes read FmatrizSaldosColorantes write SetmatrizSaldosColorantes;
  end;

var
  frmDigTintaImobiliaria: TfrmDigTintaImobiliaria;

implementation

uses  DB, StrUtils,
  untFormulacaoImobiliaria, untFuncoesSimples, untTypesSistema, untConsultas,
  untTintaMaquina;

{$R *.dfm}

procedure TfrmDigTintaImobiliaria.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    strWhere: string;
    Key: char;
begin
  Key := '/';
  strWhere := strWhere + ' AND ITE_ITEBAS = "S" ';


{  If (Pos('TEXTURA', strDesBas + strRefere + strDesCor + objFormula.strDescri + objFormula.strDesAdi) <= 0) And (Not fCfgSis('TRBAUD',varBoolean)) Then
    strWhere := strWhere + '  AND UNI_SIGUNI = ' + QuotedStr(qryBasAtu.FieldByName('UNI_SIGUNI').AsString);
    }

  If fPesqItemEmbalagem(Self, edtItem, Nil, Nil, Key, arrSel, False, strWhere) Then
  Begin
    If fValidaCampos(edtItem, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmDigTintaImobiliaria.edtDesAdiExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fRetirarEspacos(Sender);
end;

procedure TfrmDigTintaImobiliaria.edtNovBasExit(Sender: TObject);
begin
  inherited;

  If (edtNovBas.Text = objFormula.strIteBasOri) Then
    Exit
  else
  If Not fLiberarTrocaBase Then
  Begin
    edtNovBas.Text := objFormula.strIteBasOri;

    pCarregaNovaBase;
    pCalculaTotais;
  end;

end;

procedure TfrmDigTintaImobiliaria.edtNovBasKeyPress(Sender: TObject; Var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesNovBas);
  End;

End;

function TfrmDigTintaImobiliaria.fLiberarTrocaBase: Boolean;
Begin
  Result := True;

  if (fCfgSis('TRODIR') = 'S') then
  Begin
    If fEmptyStr(objFormula.strCodCli) Then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Troca de Base de Tinta Imobiliária.');
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'    , objFormula.strCodCli +' - '+ fRetNomCliente(objFormula.strCodCli)     , 11);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'   , fRetCpfCnpjCliente(objFormula.strCodCli)                              , 11);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cidade'     , fRetCidade(objFormula.strCodCli)                                      , 11);
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'   , strLoginUsuarioLogado +' - '+ fRetNomeOperador(strLoginUsuarioLogado) , 11);
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTextoCaption('IDEPRO'     , strIdePro                                                             , 11);
    objLiberacao.objMsgLibera.pAddTextoCaption('Tinta'      , objFormula.strDescri                                                  , 11);
    objLiberacao.objMsgLibera.pAddTextoCaption('Unidade'    , objFormula.strUnidad                                                  , 11);
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTextoCaption('Base Atual' , edtBasAtu.Text + ' - ' + edtDesBasAtu.Text                            , 11);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nova Base'  , edtNovBas.Text + ' - ' + edtDesNovBas.Text                            , 11);
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTextoCaption('Descrição Adicional', edtDesAdi.Text);
    objLiberacao.objMsgLibera.pAddSeparador(100);

    objLiberacao.strDirAce := 'TRODIR';
    objLiberacao.strMsgSen := 'Troca de Base de Tinta Imobiliária.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;

  end;

end;

function TfrmDigTintaImobiliaria.fRetCidade(strCodCli: String): String;
 var
  qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT CONCAT(CID_NOMCID,"/",CID_ESTADO) CIDADE '+
                       '  FROM CADCID'+
                       ' INNER JOIN  CADCLI '+
                       '    ON CLI_CODCID = CID_CODCID'+
                       ' WHERE CLI_CODCLI = :CODCLI ';
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    Result := qryAux.FieldByName('CIDADE').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmDigTintaImobiliaria.fRetCpfCnpjCliente(strCodCli: String): String;
 var
  qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CLI_C_G_C_');
    qryAux.SQL.Add('FROM CADCLI');
    qryAux.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryAux.SQL.Add(fGetFiltroClienteEmpresaIdentificadora(strLoginUsuarioLogado));
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    Result := qryAux.FieldByName('CLI_C_G_C_').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmDigTintaImobiliaria.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNovBas) Then
  Begin

    If (fEmptyStr(edtNovBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nova base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaNovaBase;
      If qryNovBas.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If qryNovBas.FieldByName('ITE_ITEBAS').AsString <> 'S' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&Ok']);
        Result := False;
      End
      Else If qryNovBas.FieldByName('ITE_IMPLIS').AsString <> 'S' Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo imprime lista deve estar como "S" no cadastro de produtos!', ['&Ok']);
        Result := False;
      End
      Else If qryNovBas.FieldByName('ITE_ITEATI').AsString <> 'S' Then
      Begin
        fMensagem('ATENÇÃO!','Este produto não é está ativo!', ['&Ok']);
        Result := False;
      End
      Else If Not SameText(qryNovBas.FieldByName('UNI_SIGUNI').AsString, qryBasAtu.FieldByName('UNI_SIGUNI').AsString)
        And (Pos('TEXTURA', strDesBas + strRefere + strDesCor + objFormula.strDescri + objFormula.strDesAdi) <= 0) And (Not fCfgSis('TRBAUD',varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Sigla da Unidade da nova base deve ser a mesma da base atual!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        objFormula.strIteBas := edtNovBas.Text;
        edtPreNovBas.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);
        pCalculaTotais;
      End;
    End;

  End;

end;

procedure TfrmDigTintaImobiliaria.FormCreate(Sender: TObject);
begin
  inherited;
  qryNovBas := fCriaQuery(Self);
  qryBasAtu := fCriaQuery(Self);

  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

procedure TfrmDigTintaImobiliaria.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNovBas);
end;

procedure TfrmDigTintaImobiliaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryNovBas);
  FreeAndNil(qryBasAtu);
end;

procedure TfrmDigTintaImobiliaria.pCarregaNovaBase;
begin
  qryNovBas.SQL.Clear;
  qryNovBas.SQL.Add('SELECT ');
  qryNovBas.SQL.Add('  I.ITE_CODITE, ');
  qryNovBas.SQL.Add('  I.ITE_DESITE, ');
  qryNovBas.SQL.Add('  I.ITE_REFERE, ');
  qryNovBas.SQL.Add('  I.ITE_CODUNI, ');
  qryNovBas.SQL.Add('  I.ITE_ITEBAS, ');
  qryNovBas.SQL.Add('  I.ITE_ITEATI, ');
  qryNovBas.SQL.Add('  G.ITE_IMPLIS, ');
  qryNovBas.SQL.Add('  G.ITE_PRECUS, ');
  qryNovBas.SQL.Add('  G.ITE_PREVE' + objFormula.strTabPre + ' AS ITE_PREVEN, ');
  qryNovBas.SQL.Add('  UNI_SIGUNI    ');
  qryNovBas.SQL.Add('FROM ');
  qryNovBas.SQL.Add('  CADITE I ');
  qryNovBas.SQL.Add('JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ');
  qryNovBas.SQL.Add('JOIN CADUNI   ON I.ITE_CODUNI = UNI_CODUNI   ');
  qryNovBas.SQL.Add('WHERE ');
  qryNovBas.SQL.Add('  G.ITE_CODEMP = :CODEMP AND ');
  qryNovBas.SQL.Add('  I.ITE_CODITE = :CODITE ');

  qryNovBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryNovBas.ParamByName('CODITE').AsString := edtNovBas.Text;
  qryNovBas.Open;

  edtDesNovBas.Text := qryNovBas.FieldByName('ITE_DESITE').AsString;

  strNovBas := qryNovBas.FieldByName('ITE_CODITE').AsString;
  strDesBas := qryNovBas.FieldByName('ITE_DESITE').AsString;
  strRefere := qryNovBas.FieldByName('ITE_REFERE').AsString;
  strUniBas := qryNovBas.FieldByName('ITE_CODUNI').AsString;
end;

procedure TfrmDigTintaImobiliaria.pCarregaItem(qryCadIte: TUniQuery;
  strCodIte: String; var strDesIte: String);
begin
  qryCadIte.SQL.Clear;
  qryCadIte.SQL.Add('SELECT ');
  qryCadIte.SQL.Add('  I.ITE_DESITE, ');
  qryCadIte.SQL.Add('  G.ITE_PRECUS, ');
  qryCadIte.SQL.Add('  G.ITE_PREVE' + objFormula.strTabPre + ' AS ITE_PREVEN, ');
  qryCadIte.SQL.Add('  UNI_SIGUNI    ');
  qryCadIte.SQL.Add('FROM ');
  qryCadIte.SQL.Add('  CADITE I ');
  qryCadIte.SQL.Add('JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ');
  qryCadIte.SQL.Add('JOIN CADUNI   ON I.ITE_CODUNI = UNI_CODUNI   ');
  qryCadIte.SQL.Add('WHERE ');
  qryCadIte.SQL.Add('  G.ITE_CODEMP = :CODEMP AND ');
  qryCadIte.SQL.Add('  I.ITE_CODITE = :CODITE ');

  qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadIte.ParamByName('CODITE').AsString := edtNovBas.Text;
  qryCadIte.Open;

  strDesIte     := qryCadIte.FieldByName('ITE_DESITE').AsString;
end;

procedure TfrmDigTintaImobiliaria.pCarregaBaseAtu;
  Var
    strDesIte: String;
begin
  pCarregaItem(qryBasAtu, edtBasAtu.Text, strDesIte);

  edtDesBasAtu.Text := strDesIte;
  edtPreBasAtu.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);
end;

procedure TfrmDigTintaImobiliaria.FormShow(Sender: TObject);
begin
  inherited;

  edtBasAtu.Text := objFormula.strIteBasOri;
  edtNovBas.Text := objFormula.strIteBasOri;

  pCarregaBaseAtu;
  pCarregaNovaBase;

  lblDesSuv.Visible := fltPerDes > 0;

  if (fCfgSis('TROBAS') = 'N') then
  begin
    objFormula.strIteBas := edtNovBas.Text;
    edtPreNovBas.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);
    pCalculaTotais;
    pSetFocus(edtBasAtu);
  end;

  Label3.Visible        := Not(fCfgSis('TROBAS') = 'N');
  edtNovBas.Visible     := Not(fCfgSis('TROBAS') = 'N');
  edtDesNovBas.Visible  := Not(fCfgSis('TROBAS') = 'N');
  edtPreNovBas.Visible  := Not(fCfgSis('TROBAS') = 'N');
  Label4.Visible        := Not(fCfgSis('TROBAS') = 'N');
end;

procedure TfrmDigTintaImobiliaria.pCalculaTotais;
begin
  Try
    objFormula.pCalculaPreco;
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;
  End;

  edtValBas.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);
  edtValCol.Text := FloatToStrF(objFormula.fltVenCol, ffFixed, 12, 2);
  edtValTin.Text := FloatToStrF(objFormula.fltPreVen, ffFixed, 12, 2);

end;

procedure TfrmDigTintaImobiliaria.btnConfirmaClick(Sender: TObject);
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

procedure TfrmDigTintaImobiliaria.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoImobiliaria := nil;
  Try
    Try
      inherited;
      frmFormulacaoImobiliaria := TfrmFormulacaoImobiliaria.Create(Self);
      frmFormulacaoImobiliaria.objFormula := objFormula;
      frmFormulacaoImobiliaria.objFormulaEsp := objFormulaEsp;
      frmFormulacaoImobiliaria.Caption := frmFormulacaoImobiliaria.Caption + objFormula.strDescri + ' - ' + objFormula.strUnidad;
      frmFormulacaoImobiliaria.strIdePro := strIdePro;
      frmFormulacaoImobiliaria.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacaoImobiliaria) then FreeAndNil(frmFormulacaoImobiliaria);
  End;
end;


procedure TfrmDigTintaImobiliaria.SetfltQtdMaximo(const Value: Double);
begin
  FfltQtdMaximo := Value;
end;

procedure TfrmDigTintaImobiliaria.SetmatrizSaldosColorantes(
  const Value: TClassMatrizSaldosColorantes);
begin
  FmatrizSaldosColorantes := Value;
end;

end.
