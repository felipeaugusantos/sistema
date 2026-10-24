unit untCadProdutosCompCusto;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, DB,  Uni, BitBtnLockedIncrem,
  MemDS, DBAccess, frxClass, frxExportCSVTestabilidade, untFuncoesRel, untFuncoesRel2, System.Math, Core.Funcoes,
  untTabelasDoItemFrame, untTabelasDoItemGrid, untTabelasDoItem,
  untUltimasCompras;

type
  TfrmCadProdutosCompCusto = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtDesIte: TEditFocus;
    pnlCentral: TPanel;
    dbePreCom: TDBEditFocus;
    gpbDescontos: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    dbeDesf01: TDBEditFocus;
    dbeDesf02: TDBEditFocus;
    dbeDesf03: TDBEditFocus;
    dbeDesf04: TDBEditFocus;
    dbeDesf05: TDBEditFocus;
    dbeDesf06: TDBEditFocus;
    gpbImpOutros: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    dbeIcmEnt: TDBEditFocus;
    dbeIpiEnt: TDBEditFocus;
    dbeFreEnt: TDBEditFocus;
    Label23: TLabel;
    dbeAcrFin: TDBEditFocus;
    Label42: TLabel;
    Label24: TLabel;
    dbeSubsti: TDBEditFocus;
    Label43: TLabel;
    dtsCadIte: TDataSource;
    qryCadIte: TUniQuery;
    Label3: TLabel;
    dbeSubFed: TDBEditFocus;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label25: TLabel;
    Label28: TLabel;
    Label66: TLabel;
    lblOutVal: TLabel;
    Label44: TLabel;
    Label29: TLabel;
    lblDesOpePer: TLabel;
    dbeIcmSai: TDBEditFocus;
    dbeImpFed: TDBEditFocus;
    dbeDesOpe: TDBEditFocus;
    dbeOutVal: TDBEditFocus;
    lblValFre: TLabel;
    dbeValFre: TDBEditFocus;
    lblDesAdi: TLabel;
    dbeDesAdb: TDBEditFocus;
    Label133: TLabel;
    dbeTCIFCu: TDBEditFocus;
    dbeTSCust: TDBEditFocus;
    dbeDePiCo: TDBEditFocus;
    dbeDeICMS: TDBEditFocus;
    dbeFatReg: TDBEditFocus;
    lblFatReg: TLabel;
    lblDeICMS: TLabel;
    lblDePiCo: TLabel;
    lblTSCust: TLabel;
    lblTCIFCu: TLabel;
    lblPerFatReg: TLabel;
    lblPerDeICMS: TLabel;
    lblPerDePiCo: TLabel;
    lblPerTSCust: TLabel;
    lblPerTCIFCu: TLabel;
    Label2: TLabel;
    edtPreLiq: TEditFocus;
    lblCusReaTit: TLabel;
    edtCusRea: TEditFocus;
    lblPrecoCusto: TLabel;
    dbPrecoCusto: TDBEditFocus;
    pnlCompras: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnUltCmpClick(Sender: TObject);
  private
    { Private declarations }
    strDesValFre,
    strMarMkp: String;
    objTabelas: TTabelasDoItem;
    qryCadIteTabPre: TUniQuery;
    qryItegerTabPre: TUniQuery;
    frmTabelasDoItem: TfrmTabelasDoItemFrame;



    function fCalculaCustoReal : Double;
    procedure pMostraCampoSuframa;
    procedure pCarregaUltimasCompras;

  public
    { Public declarations }
    strCodIte: String;
    blnExibirMovimentoFornecedorFilial : Boolean;

    Class procedure pMostraComposicaoPrecoCusto(strCodIte: String);  end;


implementation

uses SysUtils, untFuncoesSimples, untModulo;

{$R *.dfm}

procedure TfrmCadProdutosCompCusto.FormShow(Sender: TObject);
  Var
    fltPreLiq: Double;
    intIndice: Integer;
    strCodAbf: String;
begin

  inherited;
  If fVerificaAcessoSistema('NFPRCU') then
    pCarregaUltimasCompras;

  If fCfgSis('TABPRD', varBoolean) Then
  Begin
    qryItegerTabPre.SQL.Clear;
    qryItegerTabPre.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = "' +strCodIte + '" AND ITE_CODEMP = "' + VS_strCodEmp + '"');
    qryCadIteTabPre.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = "' +strCodIte + '"');
    qryItegerTabPre.Open;
    qryCadIteTabPre.Open;

    objTabelas := TTabelasDoItem.Create(Self, qryItegerTabPre, qryCadIteTabPre);

    frmTabelasDoItem := TfrmTabelasDoItemFrame.Create(Self);
    frmTabelasDoItem.objTabelas := objTabelas;
    frmTabelasDoItem.frmPai := Self;
    frmTabelasDoItem.Dock(pnlCentral, pnlCentral.BoundsRect);
    frmTabelasDoItem.pInicializaDados(qryCadIteTabPre, qryItegerTabPre);

    objTabelas.fCarregaPrecos;
    objTabelas.pRecalculaTodasTabelas(qryCadIteTabPre.FieldByName('ITE_INCPIS').ASString);

    frmTabelasDoItem.cxvPrecosPromocao.Visible := False;

    pnlCentral.Enabled := True;

    edtDesIte.Text := qryCadIteTabPre.FieldByName('ITE_CODITE').AsString + ' - ' +
                      qryCadIteTabPre.FieldByName('ITE_DESITE').AsString;
  End
  Else
  Begin

    strMarMkp := fCfgSis('MARMKP');
    lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';

    qryCadIte.Connection := frmModulo.GetCurrentConnection;

    qryCadIte.SQL.Clear;
    qryCadIte.SQL.Add('SELECT ');
    qryCadIte.SQL.Add('  CONCAT(CADITE.ITE_CODITE, " - ", ITE_DESITE) AS ITE_DESITE, ');
    qryCadIte.SQL.Add('  ITE_PRECOM, ');
    qryCadIte.SQL.Add('  ITE_DESF01, ');
    qryCadIte.SQL.Add('  ITE_DESF02, ');
    qryCadIte.SQL.Add('  ITE_DESF03, ');
    qryCadIte.SQL.Add('  ITE_DESF04, ');
    qryCadIte.SQL.Add('  ITE_DESF05, ');
    qryCadIte.SQL.Add('  ITE_DESF06, ');
    qryCadIte.SQL.Add('  ITE_ICMENT, ');
    qryCadIte.SQL.Add('  ITE_SUBFED, ');
    qryCadIte.SQL.Add('  ITE_IPIENT, ');
    qryCadIte.SQL.Add('  ITE_FREENT, ');
    qryCadIte.SQL.Add('  ITE_VALFRE, ');
    qryCadIte.SQL.Add('  ITE_SUBSTI, ');
    qryCadIte.SQL.Add('  ITE_ACRFIN, ');
    qryCadIte.SQL.Add('  ITE_DESADB, ');
    qryCadIte.SQL.Add('  ITE_PRECUS, ');
    qryCadIte.SQL.Add('  ITE_TCIFCU, ');
    qryCadIte.SQL.Add('  ITE_TSCUST, ');
    qryCadIte.SQL.Add('  ITE_DEPICO, ');
    qryCadIte.SQL.Add('  ITE_DEICMS, ');
    qryCadIte.SQL.Add('  ITE_FATREG, ');
    {*************************************************************}
    {* ACRESCENTOU PREÇO DE CUSTO REAL, PRECISOU DE NOVOS CAMPOS *}
    {**********************************************************DP*}
    qryCadIte.SQL.Add('  ITE_OUTVAL, ');
    qryCadIte.SQL.Add('  ITE_DESOPE, ');
    qryCadIte.SQL.Add('  ITE_IMPFED, ');
    qryCadIte.SQL.Add('  ITE_ICMSAI, ');
    {****************************************}
    {* CAMPO NECESSÁRIO PARA CALCULO DO IVA *}
    {************Req.100797**18/05/2018**WS**}
    If fCfgSis('TIPABF') = '2' Then
      qryCadIte.SQL.Add('  ITEGER.ITE_CODABF ')
    Else
      qryCadIte.SQL.Add('  CADITE.ITE_CODABF ');

    qryCadIte.SQL.Add('FROM ');
    qryCadIte.SQL.Add('  CADITE ');
    qryCadIte.SQL.Add('  JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
    qryCadIte.SQL.Add('WHERE ');
    qryCadIte.SQL.Add('  ITEGER.ITE_CODITE = :CODITE AND ');
    qryCadIte.SQL.Add('  ITEGER.ITE_CODEMP = :CODEMP ');

    qryCadIte.ParamByName('CODITE').AsString := strCodIte;
    qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadIte.Open;

    edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;

    With qryCadIte Do
    Begin
      TFloatField(FieldByName('ITE_PRECOM')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      TFloatField(FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      TFloatField(FieldByName('ITE_DESF01')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESF02')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESF03')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESF04')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESF05')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESF06')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_ICMENT')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_SUBFED')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_IPIENT')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_FREENT')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_VALFRE')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      TFloatField(FieldByName('ITE_SUBSTI')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_ACRFIN')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESADB')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_OUTVAL')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DESOPE')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_IMPFED')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_ICMSAI')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_TCIFCU')).DisplayFormat := fMskDigitos(6);
      TFloatField(FieldByName('ITE_TSCUST')).DisplayFormat := fMskDigitos(6);
      TFloatField(FieldByName('ITE_DEPICO')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_DEICMS')).DisplayFormat := fMskDigitos(2);
      TFloatField(FieldByName('ITE_FATREG')).DisplayFormat := fMskDigitos(2);
    End;

    With qryCadIte Do
    Begin
      fltPreLiq := FieldByName('ITE_PRECOM').AsFloat;

      For intIndice := 1 To 6 Do
        fltPreLiq := fltPreLiq - (fltPreLiq * FieldByName('ITE_DESF0' + IntToStr(intIndice)).AsFloat/100);

      edtPreLiq.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltPreLiq);
    End;

    If (strMarMkp = '4') Then
    Begin
      lblCusReaTit.Caption := 'IVA:';
      strCodAbf := qryCadIte.FieldByName('ITE_CODABF').AsString;
      If Not fEmptyStr(strCodAbf) Then
        edtCusRea.Text := FormatFloat(fMskDigitos(4), fRetornaPercIVA(strCodAbf, fCadEmp('ESTADO'), '_SAI_CCO'))
      Else
        edtCusRea.Text := FormatFloat(fMskDigitos(4), 0);
    End
    Else
      edtCusRea.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fCalculaCustoReal);

    Try
      Screen.Cursor := crHourGlass;
    Finally
      Screen.Cursor := crDefault;
    End;

    pMostraCampoSuframa;
  End;

end;

{*****************************************************}
{* ACRESCENTOU CUSTO REAL , IGUAL A TELA DE CADASTRO *}
{**************************************************DP*}
procedure TfrmCadProdutosCompCusto.btnUltCmpClick(Sender: TObject);
begin
  inherited;

  If not fVerificaAcessoSistema('NFPRCU') then
    exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(194, 7491, [],
                        ['CODITE','CODFOR','CODEMP'],
                        [strCodIte,
                        '',
                        VS_strCodEmp],
                        Sender,
                        ['CODITE','CODFOR'],
                        False);
  End;

end;

function TfrmCadProdutosCompCusto.fCalculaCustoReal: Double;
Begin
  Result := untfuncoesSimples.fCalculaCustoReal(qryCadIte.FieldByName('ITE_PRECUS').AsFloat,
                                                qryCadIte.FieldByName('ITE_ICMSAI').AsFloat,
                                                qryCadIte.FieldByName('ITE_IMPFED').AsFloat,
                                                qryCadIte.FieldByName('ITE_DESOPE').AsFloat,
                                                qryCadIte.FieldByName('ITE_OUTVAL').AsFloat);
End;

procedure TfrmCadProdutosCompCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryCadIte.Close;
  If fCfgSis('TABPRD', VarBoolean) Then
  Begin
    FreeAndNil(qryCadIteTabPre);
    FreeAndNil(qryItegerTabPre);
    FreeAndNil(frmTabelasDoItem);
  End;

end;

procedure TfrmCadProdutosCompCusto.FormCreate(Sender: TObject);
begin
  inherited;
  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';

  strDesValFre := fCfgSis('DESVFR');
  lblValFre.Caption := strDesValFre + ' (+):';
  If fCfgSis('TABPRD', VarBoolean) Then
  Begin
    qryCadIteTabPre := fCriaQuery;
    qryItegerTabPre := fCriaQuery;
  End;

end;

procedure TfrmCadProdutosCompCusto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
  Begin
    Close;
  End;

end;

procedure TfrmCadProdutosCompCusto.pMostraCampoSuframa;
begin
  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    lblTCIFCu.Visible := True;
    lblTSCust.Visible := True;
    lblDePiCo.Visible := True;
    lblDeICMS.Visible := True;
    lblFatReg.Visible := True;

    dbeTCIFCu.Visible := True;
    dbeTSCust.Visible := True;
    dbeDePiCo.Visible := True;
    dbeDeICMS.Visible := True;
    dbeFatReg.Visible := True;

    lblPerTCIFCu.Visible := True;
    lblPerTSCust.Visible := True;
    lblPerDePiCo.Visible := True;
    lblPerDeICMS.Visible := True;
    lblPerFatReg.Visible := True;

    gpbImpOutros.Height := 345;
	  pnlCentral.Height   := 384;
  end
  else
  begin
    lblTCIFCu.Visible := False;
    lblTSCust.Visible := False;
    lblDePiCo.Visible := False;
    lblDeICMS.Visible := False;
    lblFatReg.Visible := False;

    dbeTCIFCu.Visible := False;
    dbeTSCust.Visible := False;
    dbeDePiCo.Visible := False;
    dbeDeICMS.Visible := False;
    dbeFatReg.Visible := False;

    lblPerTCIFCu.Visible := False;
    lblPerTSCust.Visible := False;
    lblPerDePiCo.Visible := False;
    lblPerDeICMS.Visible := False;
    lblPerFatReg.Visible := False;

    dbPrecoCusto.Top    := 202;
    lblPrecoCusto.Top   := 205;
    gpbImpOutros.Height := 225;
    pnlCentral.Height   := 260;
  end;
end;

Class procedure TfrmCadProdutosCompCusto.pMostraComposicaoPrecoCusto(strCodIte: String);
  Var
    frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  Try
    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := strCodIte;
    frmCadprodutosCompCusto.blnExibirMovimentoFornecedorFilial := fCfgSis('ECCMFF', varBoolean);
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmCadprodutosCompCusto);
end;

procedure TfrmCadProdutosCompCusto.pCarregaUltimasCompras;

Begin
  Try

    pCriarFormularios(TfrmUltimasCompras, frmUltimasCompras);
    frmUltimasCompras.blnExibirMovimentoFornecedorFilial := blnExibirMovimentoFornecedorFilial;

    If Assigned(frmUltimasCompras) Then
    Begin
      frmUltimasCompras.blnFecharComEscape := False;
      frmUltimasCompras.BorderStyle        := bsNone;
      frmUltimasCompras.Align              := alClient;
      frmUltimasCompras.pnlBotoes.Visible  := False;
      frmUltimasCompras.pnlStatus.Visible  := False;
      frmUltimasCompras.Dock(pnlCompras, pnlCompras.BoundsRect);

      frmUltimasCompras.strCodFor := '';
      frmUltimasCompras.strCodIte := strCodIte;
      frmUltimasCompras.Show;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadProdutosCompCusto.pCarregaUltimasCompras]');
    End;

  End;

End;

end.
