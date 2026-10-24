{**********************************************************************************}
{* Tela no qual o usuario pode alterar as informação da tinta no momente da venda *}
{*******************************************************************************PH*}
unit untAbstractDigTintaImobiliaria;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms, untPai, StdCtrls, EditFocus, Controls, BitBtnLockedIncrem,
  Buttons, AppEvnts, ExtCtrls, Menus, frxClass, frxExportCSVTestabilidade,
{$ENDIF}
  Classes,
  untIDataSet, untAbstractFormulaImobiliaria, SysUtils;

type
 {$IFNDEF LINUX}
  TAbstractDigTintaImobiliariaController = class;

  TfrmAbstractDigTintaImobiliaria = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtBasAtu: TEditFocus;
    edtDesBasAtu: TEditFocus;
    Label2: TLabel;
    edtPreBasAtu: TEditFocus;
    lblNovBas: TLabel;
    edtNovBas: TEditFocus;
    edtDesNovBas: TEditFocus;
    lblPreNovBas: TLabel;
    edtPreNovBas: TEditFocus;
    edtDesAdi: TEditFocus;
    Label5: TLabel;
    pnlTotais: TPanel;
    lblValBas: TLabel;
    edtValBas: TEditFocus;
    edtValCol: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtValTin: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    procedure edtNovBasKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDesAdiExit(Sender: TObject);
    procedure edtNovBasExit(Sender: TObject);
  private
    procedure pRetInfoCliente(strCodCli : String; Var strNomCli : String; Var strCliCid : String; Var strCliCpf : String);
    function fLiberarTrocaBase: Boolean;
    { Private declarations }
  protected
    Controller: TAbstractDigTintaImobiliariaController;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  public
    { Public declarations }
    procedure SetController(AValue: TAbstractDigTintaImobiliariaController);
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
 {$ENDIF}

  TAbstractDigTintaImobiliariaController = class
  private
    qryBasAtu: IDataSet;
    qryNovBas: IDataSet;
    FfltQtdMaximo: Double;
    procedure SetfltQtdMaximo(const Value: Double);
  public
    formula: TAbstractFormulaImobiliaria;

    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String; // cor adicional
    fltPreCus: Double;
    fltPreVen: Double;

    edtBasAtu: TEditFocus;
    edtNovBas: TEditFocus;
    edtDesAdi: TEditFocus;

    edtDesNovBas: TEditFocus;
    edtDesBasAtu: TEditFocus;
    edtPreBasAtu: TEditFocus;
    edtPreNovBas: TEditFocus;

    edtValBas: TEditFocus;
    edtValCol: TEditFocus;
    edtValTin: TEditFocus;

    lblNovBas: TLabel;
    lblValBas: TLabel;
    lblPreNovBas: TLabel;

    procedure pOnShow(Sender: TObject); virtual;

    procedure pCarregaItem(qryCadIte: IDataSet; strCodIte: String; var strDesIte: String);

    procedure pCarregaNovaBase;
    procedure pCarregaBaseAtu;

    procedure pCalculaTotais;

    function fConfirmar(): Boolean; virtual;

    property fltQtdMaximo: Double read FfltQtdMaximo write SetfltQtdMaximo;

    constructor Create; virtual;
  end;

{$IFNDEF LINUX}
var
  frmAbstractDigTintaImobiliaria: TfrmAbstractDigTintaImobiliaria;
{$ENDIF}

implementation

uses
{$IFNDEF LINUX}
  untFormulacaoImobiliaria,
{$ENDIF}
  untAutcomTintaFactory, untUltConsultas, untStrUtils,
  untLibTintaFactory, untFuncoesGenerica;

{$IFNDEF LINUX}
  {$R *.dfm}
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.pConsultaItem(edtItem,
  edtDesIte: TEdit);
var
  strSQL, strSQLWhere: String;
  qryConsulta: IDataSet;

  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_DESITE, '; pAddNomeColuna('Descrição');
    strSQL := strSQL + '  ITE_REFERE, '; pAddNomeColuna('Referência');
    strSQL := strSQL + '  CADITE.ITE_CODITE, '; pAddNomeColuna('Código');
    strSQL := strSQL + '  ITE_CODBAR, '; pAddNomeColuna('Cód. Barras');
    strSQL := strSQL + '  ITE_CODUNI, '; pAddNomeColuna('Unidade');
    strSQL := strSQL + '  UNI_SIGUNI, '; pAddNomeColuna('Sigla. Unid.');
    strSQL := strSQL + '  ITE_SALDIS, '; pAddNomeColuna('Saldo Disponivel');
    strSQL := strSQL + '  ITE_SALFIS,  '; pAddNomeColuna('Saldo Físico');
    strSQL := strSQL + '  ITE_COMSAL, '; pAddNomeColuna('Com Saldo');
    strSQL := strSQL + '  CADITE.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + '     INNER JOIN ITEGER ON         ';
    strSQL := strSQL + '       CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND    ';
    strSQL := strSQL + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
    strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
    strSQLWhere := strSQLWhere + 'WHERE ';
    strSQLWhere := strSQLWhere + '  ITE_ITEBAS = "S" AND ';
    strSQLWhere := strSQLWhere + '  ITEGER.ITE_IMPLIS = "S" AND  ';
    strSQLWhere := strSQLWhere + '  IFNULL(CADITE.ITE_ITEATI, "N") = "S" AND ';
    strSQLWhere := strSQLWhere + '  CADITE.ITE_DESITE NOT LIKE "%ITEM ESPECIAL%" ';

    If (Pos('TEXTURA', Controller.strDesBas + Controller.strRefere + Controller.strDesCor +
      Controller.formula.Descricao) < 0) And (Not TAutcomTintaFactory.Get.fCfgSis('TRBAUD',varBoolean)) Then
    Begin
      strSQLWhere := strSQLWhere + '  AND UNI_SIGUNI = ' + QuotedStr(Controller.qryBasAtu.FieldByName('UNI_SIGUNI').AsString);
    End;

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM', 'CADITE', Self.Name, 'Consulta -  Item Base',  qryConsulta,
      [TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True), TAutcomTintaFactory.Get.fSQLSaldoFisico], ['ITE_SALDIS', 'ITE_SALFIS'], True) Then
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
End;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.edtDesAdiExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := TAutcomTintaFactory.Get.fRetirarEspacos(Sender);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.edtNovBasExit(Sender: TObject);
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
procedure TfrmAbstractDigTintaImobiliaria.edtNovBasKeyPress(Sender: TObject; var Key: Char);
var
  strKey: String;
begin
  strKey := Key;

  If (TAutcomTintaFactory.Get.fEntraCons(strKey)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesNovBas);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TfrmAbstractDigTintaImobiliaria.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNovBas) Then
  Begin
    If (TStrUtils.fEmptyStr(edtNovBas.Text)) Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A nova base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Controller.pCarregaNovaBase;
      If Controller.qryNovBas.IsEmpty Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If Controller.qryNovBas.FieldByName('ITE_ITEBAS').AsString <> 'S' Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&Ok']);
        Result := False;
      End
      Else If Controller.qryNovBas.FieldByName('ITE_ITEATI').AsString <> 'S' Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Esse produto está inativo!', ['&Ok']);
        Result := False;
      End
      Else If Controller.qryNovBas.FieldByName('ITE_IMPLIS').AsString <> 'S' Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'O campo imprime lista deve estar como "S" no cadastro de produtos!', ['&Ok']);
        Result := False;
      End
      Else If Not SameText(Controller.qryNovBas.FieldByName('UNI_SIGUNI').AsString , Controller.qryBasAtu.FieldByName('UNI_SIGUNI').AsString)
        And (Pos('TEXTURA', Controller.strDesBas + Controller.strRefere + Controller.strDesCor + Controller.formula.Descricao) <= 0)
        And (Not TAutcomTintaFactory.Get.fCfgSis('TRBAUD',varBoolean)) Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', Format('A Sigla da Unidade da nova base (%s) deve ser a mesma da base atual (%s)!',
          [Controller.qryNovBas.FieldByName('UNI_SIGUNI').AsString , Controller.qryBasAtu.FieldByName('UNI_SIGUNI').AsString]), ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Controller.formula.ItemBase := edtNovBas.Text;
        Controller.pCalculaTotais;
      End;
    End;

  End;

end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNovBas);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.FormCreate(Sender: TObject);
begin
  inherited;

  TAutcomTintaFactory.Get.pSetaCodIte(edtBasAtu);
  TAutcomTintaFactory.Get.pSetaCodIte(edtNovBas);

  If (TAutcomTintaFactory.Get.fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  TAutcomTintaFactory.Get.fVerificaAcessoSistema('DIRVISFOR');
end;
{$ENDIF}

procedure TAbstractDigTintaImobiliariaController.pCarregaNovaBase;
var
  strSql: String;
begin
  strSql :=
    ' SELECT                             ' +
    '   I.ITE_CODITE                     ' +
    '   , IFNULL(I.ITE_ITEATI,"N") AS ITE_ITEATI  ' +
    '   , I.ITE_DESITE                   ' +
    '   , I.ITE_REFERE                   ' +
    '   , I.ITE_CODUNI                   ' +
    '   , I.ITE_ITEBAS                   ' +
    '   , G.ITE_PRECUS                   ' +
    '   , G.ITE_PREVE' + Self.formula.TabPre + ' AS ITE_PREVEN     ' +
    '   , UNI_SIGUNI                     ' +
    '   , G.ITE_IMPLIS                   ' +
    ' FROM                               ' +
    '   CADITE I                         ' +
    '   JOIN ITEGER G                    ' +
    '     ON I.ITE_CODITE = G.ITE_CODITE ' +
    '   JOIN CADUNI                      ' +
    '     ON I.ITE_CODUNI = UNI_CODUNI   ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ' +
    '   AND I.ITE_CODITE = :CODITE       ';

  qryNovBas.SQL := strSql;
  qryNovBas.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryNovBas.ParamByName('CODITE').AsString := edtNovBas.Text;
  qryNovBas.Open;

  edtDesNovBas.Text := qryNovBas.FieldByName('ITE_DESITE').AsString;

  Self.strNovBas := qryNovBas.FieldByName('ITE_CODITE').AsString;
  Self.strDesBas := qryNovBas.FieldByName('ITE_DESITE').AsString;
  Self.strRefere := qryNovBas.FieldByName('ITE_REFERE').AsString;
  Self.strUniBas := qryNovBas.FieldByName('ITE_CODUNI').AsString;
end;

procedure TAbstractDigTintaImobiliariaController.pCarregaItem(qryCadIte: IDataSet;
  strCodIte: String; var strDesIte: String);
var
  strSql: String;
begin
  strSql :=
    ' SELECT                             ' +
    '   I.ITE_DESITE                     ' +
    '   , G.ITE_PRECUS                   ' +
    '   , G.ITE_PREVE' + Self.formula.TabPre + ' AS ITE_PREVEN     ' +
    '   , UNI_SIGUNI                     ' +
    ' FROM                               ' +
    '   CADITE I                         ' +
    '   JOIN ITEGER G                    ' +
    '     ON I.ITE_CODITE = G.ITE_CODITE ' +
    '   JOIN CADUNI                      ' +
    '     ON I.ITE_CODUNI = UNI_CODUNI   ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ' +
    '   AND I.ITE_CODITE = :CODITE       ';

  qryCadIte.SQL := strSql;
  qryCadIte.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryCadIte.ParamByName('CODITE').AsString := edtNovBas.Text;
  qryCadIte.Open;

  strDesIte     := qryCadIte.FieldByName('ITE_DESITE').AsString;
end;

{$IFNDEF LINUX}
function TfrmAbstractDigTintaImobiliaria.fLiberarTrocaBase: Boolean;
Var
  strNomCli : String;
  strCliCid : String;
  strCliCpf : String;
Begin
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

constructor TAbstractDigTintaImobiliariaController.Create;
begin
  qryNovBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasAtu := TAutcomTintaFactory.Get.fGetDataSet;
end;

procedure TAbstractDigTintaImobiliariaController.pCarregaBaseAtu;
  Var
    strDesIte: String;
begin
  pCarregaItem(qryBasAtu, edtBasAtu.Text, strDesIte);

  edtDesBasAtu.Text := strDesIte;
  edtPreBasAtu.Text := FloatToStrF(Self.formula.BasePrecoVenda , ffFixed, 12, 2);
end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.FormShow(Sender: TObject);
begin
  inherited;
  Controller.pOnShow(Sender);
end;
{$ENDIF}

procedure TAbstractDigTintaImobiliariaController.pOnShow(Sender: TObject);
begin
  edtBasAtu.Text := Self.formula.ItemBaseOriginal;
  edtNovBas.Text := Self.formula.ItemBaseOriginal;

  Self.pCarregaBaseAtu;
  Self.pCarregaNovaBase;

  if (TAutcomTintaFactory.Get.fCfgSis('TROBAS') = 'N') then
  begin
    Self.formula.ItemBase := edtNovBas.Text;
    Self.pCalculaTotais;
    edtPreNovBas.Text := FloatToStrF(Self.formula.BasePrecoVenda, ffFixed, 12, 2);

   {$IFNDEF LINUX}
    lblNovBas.Visible    := False;
    edtNovBas.Visible    := False;
    edtDesNovBas.Visible := False;
    edtPreNovBas.Visible := False;
    lblPreNovBas.Visible := False;
    pSetFocus(edtBasAtu);
   {$ENDIF}
  end;
end;

function TAbstractDigTintaImobiliariaController.fConfirmar: Boolean;
begin
  If Self.formula.Count <= 0 Then
    Exit(False);

  If (strToFloatDef(edtValTin.Text, 0) <= 0) Then
    Exit(False);

  Self.strDesCor := edtDesAdi.Text;
  Self.fltPreCus := Self.formula.PrecoCusto + Self.formula.BasePrecoCusto;
  Self.fltPreVen := Self.formula.PrecoVenda + Self.formula.BasePrecoVenda;

  Result := True;
end;

procedure TAbstractDigTintaImobiliariaController.pCalculaTotais;
begin
  Try
    If Not Self.formula.fMostrarFormulacaoIndustrial Then
      Self.formula.CalcularPrecos
    Else
      Self.formula.CalcularPrecosIndustrial;
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;
  End;

  If Not Self.formula.fMostrarFormulacaoIndustrial Then
  Begin
    edtValBas.Text := FloatToStrF(Self.formula.BasePrecoVenda, ffFixed, 12, 2);
    If  TAutcomTintaFactory.Get.fGetConfTinta(Self.Formula.GetIdePro).fGet('ZERCOL') = 'S' Then
      edtValCol.Text := FloatToStrF(0.0, ffFixed, 12, 2)
    Else
      edtValCol.Text := FloatToStrF(Self.formula.GetCalculador.PrecoVenda, ffFixed, 12, 2);

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.Formula.GetIdePro).fGet('ACRMOB') = '1' Then
      edtValTin.Text := FloatToStrF((Self.formula.GetCalculador.PrecoVenda + Self.formula.BasePrecoVenda) * (1 + Self.Formula.AcrMob / 100), ffFixed, 12, 2)
    Else
      edtValTin.Text := FloatToStrF(Self.formula.GetCalculador.PrecoVenda + Self.formula.BasePrecoVenda + Self.Formula.AcrMob, ffFixed, 12, 2);

    edtPreNovBas.Text := FloatToStrF(Self.formula.BasePrecoVenda, ffFixed, 12, 2);
  End
  Else
  Begin
    edtValBas.Text := TAutcomTintaFactory.Get.IIF(Not Self.formula.Personalizada, FloatToStrF(Self.formula.BasePrecoVenda, ffFixed, 12, 2),
      FloatToStrF(Self.formula.PrecoVendaEmbalagem, ffFixed, 12, 2));
    edtValCol.Text := FloatToStrF(Self.formula.ColorantePrecoVenda, ffFixed, 12, 2);
    edtValTin.Text := FloatToStrF(Self.formula.PrecoVendaIndustrial, ffFixed, 12, 2);
    edtPreNovBas.Text := TAutcomTintaFactory.Get.IIF(Not Self.formula.Personalizada, FloatToStrF(Self.formula.BasePrecoVenda, ffFixed, 12, 2),
      FloatToStrF(Self.formula.PrecoVendaEmbalagem, ffFixed, 12, 2));
  End;

end;

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.btnConfirmaClick(Sender: TObject);
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
procedure TfrmAbstractDigTintaImobiliaria.pRetInfoCliente(strCodCli : String; Var strNomCli : String; Var strCliCid : String; Var strCliCpf : String);

 var
  qryAux: IDataSet;
Begin
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
procedure TfrmAbstractDigTintaImobiliaria.SetController(
  AValue: TAbstractDigTintaImobiliariaController);
begin
  Controller := AValue;
  Controller.edtBasAtu := Self.edtBasAtu;
  Controller.edtNovBas := Self.edtNovBas;
  Controller.edtDesAdi := Self.edtDesAdi;
  Controller.edtDesNovBas := Self.edtDesNovBas;
  Controller.edtDesBasAtu := Self.edtDesBasAtu;
  Controller.edtPreBasAtu := Self.edtPreBasAtu;
  Controller.edtPreNovBas := Self.edtPreNovBas;
  Controller.edtValBas := Self.edtValBas;
  Controller.edtValCol := Self.edtValCol;
  Controller.edtValTin := Self.edtValTin;
  Controller.lblNovBas := Self.lblNovBas;
  Controller.lblValBas := Self.lblValBas;
  Controller.lblPreNovBas := Self.lblPreNovBas;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmAbstractDigTintaImobiliaria.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoImobiliaria := nil;
  Try
    Try
      inherited;
      Self.Controller.formula.CarregaPrecosColorantes;
      frmFormulacaoImobiliaria := TfrmFormulacaoImobiliaria.Create(Self);
      frmFormulacaoImobiliaria.formula := Self.Controller.formula;
      frmFormulacaoImobiliaria.Caption := frmFormulacaoImobiliaria.Caption + Controller.formula.Descricao;
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
{$ENDIF}

procedure TAbstractDigTintaImobiliariaController.SetfltQtdMaximo(const Value: Double);
begin
  FfltQtdMaximo := Value;
end;

end.

