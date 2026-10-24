{**********************************************************************************}
{* Tela no qual o usuario pode alterar as informação da tinta no momente da venda *}
{*******************************************************************************PH*}
unit untAbstractDigTintaImobiliaria;

interface

uses
  Forms, untPai, StdCtrls, EditFocus, Controls, BitBtnLockedIncrem, Classes, ExtCtrls,
  untIDataSet, untAbstractFormulaImobiliaria, AppEvnts,
  Buttons, SysUtils, Menus;

type
  TfrmAbstractDigTintaImobiliaria = class(TfrmPai)
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
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    procedure edtNovBasKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
  private
    qryBasAtu: IDataSet;
    FfltQtdMaximo: Double;
    procedure pCarregaNovaBase;
    procedure pCarregaBaseAtu;
    procedure pCarregaItem(qryCadIte: IDataSet; strCodIte: String;
      Var strDesIte: String);

    procedure SetfltQtdMaximo(const Value: Double);
    { Private declarations }
  protected
    qryNovBas: IDataSet;
    procedure pCalculaTotais;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  public
    { Public declarations }
    formula: TAbstractFormulaImobiliaria;

    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String; // cor adicional
    fltPreCus: Double;
    fltPreVen: Double;

    property fltQtdMaximo: Double read FfltQtdMaximo write SetfltQtdMaximo;
  end;

var
  frmAbstractDigTintaImobiliaria: TfrmAbstractDigTintaImobiliaria;

implementation

uses
  untAutcomTintaFactory, untUltConsultas, untStrUtils, untFormulacaoImobiliaria, 
  untLibTintaFactory;

{$R *.dfm}

procedure TfrmAbstractDigTintaImobiliaria.pConsultaItem(edtItem,
  edtDesIte: TEdit);
var
  strSQL: String;
  stlCamIndIte: TStringList;
  stlDesIndIte: TStringList;
  qryConsulta: IDataSet;
begin
  stlCamIndIte := nil;
  stlDesIndIte := nil;
  Try
    Try
      stlCamIndIte := TStringList.Create;
      stlDesIndIte := TStringList.Create;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_DESITE AS "Descrição", ';
      strSQL := strSQL + '  ITE_REFERE AS "Referência", ';
      strSQL := strSQL + '  ITE_CODITE AS "Código", ';
      strSQL := strSQL + '  ITE_CODBAR AS "Cód. Barras", ';
      strSQL := strSQL + '  ITE_CODUNI AS "Unidade", ';
      strSQL := strSQL + '  UNI_SIGUNI AS "Sigla. Unid.", ';
      strSQL := strSQL + '  CADITE.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_ITEBAS = "S" ';

      If (Pos('TEXTURA', strDesBas + strRefere + strDesCor +
        formula.Descricao) < 0) And (Not TAutcomTintaFactory.Get.fCfgSis('TRBAUD',varBoolean)) Then
      Begin
        strSQL := strSQL + '  AND UNI_SIGUNI = ' + QuotedStr(qryBasAtu.FieldByName('UNI_SIGUNI').AsString);
      End;

      stlCamIndIte.Add('ITE_DESITE');
      stlCamIndIte.Add('ITE_REFERE');
      stlCamIndIte.Add('ITE_CODITE');
      stlCamIndIte.Add('ITE_CODBAR');

      stlDesIndIte.Add('Descrição');
      stlDesIndIte.Add('Referência');
      stlDesIndIte.Add('Código');
      stlDesIndIte.Add('Cód. Barras');

      TUltConsultas.GetUltConsultas.Limpar(Self.Name + 'CADITE');

      If TAutcomTintaFactory.Get.pConsultaComp(qryConsulta,
        'CADITE',
        strSQL,
        stlCamIndIte.Text,
        stlDesIndIte.Text) Then
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
    if Assigned(stlCamIndIte) then FreeAndNil(stlCamIndIte);
    if Assigned(stlDesIndIte) then FreeAndNil(stlDesIndIte);
  End;
End;

procedure TfrmAbstractDigTintaImobiliaria.edtNovBasKeyPress(Sender: TObject;
  var Key: Char);
var
  strKey: String;
begin
  strKey := Key;

  If (TAutcomTintaFactory.Get.fEntraCons(strKey)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesNovBas);
  End;
end;

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
      pCarregaNovaBase;
      If qryNovBas.IsEmpty Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If qryNovBas.FieldByName('ITE_ITEBAS').AsString <> 'S' Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&Ok']);
        Result := False;
      End
      Else If Not SameText(qryNovBas.FieldByName('UNI_SIGUNI').AsString , qryBasAtu.FieldByName('UNI_SIGUNI').AsString)
        And (Pos('TEXTURA', strDesBas + strRefere + strDesCor + formula.Descricao) <= 0)
        And (Not TAutcomTintaFactory.Get.fCfgSis('TRBAUD',varBoolean)) Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', Format('A Sigla da Unidade da nova base (%s) deve ser a mesma da base atual (%s)!',
          [qryNovBas.FieldByName('UNI_SIGUNI').AsString , qryBasAtu.FieldByName('UNI_SIGUNI').AsString]), ['&Ok']);
        Result := False;
      End
      Else
      Begin
        formula.ItemBase := edtNovBas.Text;
        pCalculaTotais;
        edtPreNovBas.Text := FloatToStrF(formula.BasePrecoVenda, ffFixed, 12, 2);
      End;
    End;

  End;

end;

procedure TfrmAbstractDigTintaImobiliaria.FormCreate(Sender: TObject);
begin
  inherited;
  qryNovBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasAtu := TAutcomTintaFactory.Get.fGetDataSet;
end;

procedure TfrmAbstractDigTintaImobiliaria.pCarregaNovaBase;
var
  strSql: String;
begin
  strSql :=
    ' SELECT                             ' +
    '   I.ITE_CODITE                     ' +
    '   , I.ITE_DESITE                   ' +
    '   , I.ITE_REFERE                   ' +
    '   , I.ITE_CODUNI                   ' +
    '   , I.ITE_ITEBAS                   ' +
    '   , G.ITE_PRECUS                   ' +
    '   , G.ITE_PREVE' + formula.TabPre + ' AS ITE_PREVEN     ' +
    '   , UNI_SIGUNI                     ' +
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

  strNovBas := qryNovBas.FieldByName('ITE_CODITE').AsString;
  strDesBas := qryNovBas.FieldByName('ITE_DESITE').AsString;
  strRefere := qryNovBas.FieldByName('ITE_REFERE').AsString;
  strUniBas := qryNovBas.FieldByName('ITE_CODUNI').AsString;
end;

procedure TfrmAbstractDigTintaImobiliaria.pCarregaItem(qryCadIte: IDataSet;
  strCodIte: String; var strDesIte: String);
var
  strSql: String;
begin
  strSql :=
    ' SELECT                             ' +
    '   I.ITE_DESITE                     ' +
    '   , G.ITE_PRECUS                   ' +
    '   , G.ITE_PREVE' + formula.TabPre + ' AS ITE_PREVEN     ' +
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

procedure TfrmAbstractDigTintaImobiliaria.pCarregaBaseAtu;
  Var
    strDesIte: String;
begin
  pCarregaItem(qryBasAtu, edtBasAtu.Text, strDesIte);

  edtDesBasAtu.Text := strDesIte;
  edtPreBasAtu.Text := FloatToStrF(formula.BasePrecoVenda , ffFixed, 12, 2);
end;

procedure TfrmAbstractDigTintaImobiliaria.FormShow(Sender: TObject);
begin
  inherited;

  edtBasAtu.Text := formula.ItemBaseOriginal;
  edtNovBas.Text := formula.ItemBaseOriginal;

  pCarregaBaseAtu;
  pCarregaNovaBase;
end;

procedure TfrmAbstractDigTintaImobiliaria.pCalculaTotais;
begin
  Try
    formula.CalcularPrecos;
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;
  End;

  edtValBas.Text := FloatToStrF(formula.BasePrecoVenda, ffFixed, 12, 2);
  edtValCol.Text := FloatToStrF(formula.GetCalculador.PrecoVenda, ffFixed, 12, 2);
  edtValTin.Text := FloatToStrF(formula.GetCalculador.PrecoVenda + formula.BasePrecoVenda, ffFixed, 12, 2);
end;

procedure TfrmAbstractDigTintaImobiliaria.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;
    
  If (StrToFloatDef(edtValCol.Text, 0) <= 0) Then
  Begin
    Exit;
  End;
  
  strDesCor := edtDesAdi.Text;
  fltPreCus := formula.PrecoCusto + formula.BasePrecoCusto;
  fltPreVen := formula.PrecoVenda + formula.BasePrecoVenda;
  ModalResult := mrOk;
end;

procedure TfrmAbstractDigTintaImobiliaria.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoImobiliaria := nil;
  Try
    Try
      inherited;
      Self.formula.CarregaPrecosColorantes;
      frmFormulacaoImobiliaria := TfrmFormulacaoImobiliaria.Create(Self);
      frmFormulacaoImobiliaria.formula := Self.formula;
      frmFormulacaoImobiliaria.Caption := frmFormulacaoImobiliaria.Caption + formula.Descricao;
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


procedure TfrmAbstractDigTintaImobiliaria.SetfltQtdMaximo(const Value: Double);
begin
  FfltQtdMaximo := Value;
end;

end.
