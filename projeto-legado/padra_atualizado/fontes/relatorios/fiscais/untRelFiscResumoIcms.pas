{***********************}
{* qryConEmp -> CADEMP *}
{********************JB*}

unit untRelFiscResumoIcms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  EditFocus, Grids, StrUtils, ComCtrls, frxClass, frxDBSet, DB,
  Uni, AppEvnts, UniDataSetProvider, UniClientDataSet,
  BitBtnLockedIncrem, Contnrs, frxExportCSVTestabilidade, untTypesSistema,
  untSelecionaEmpresa, frxDesgn, RLFilters, RLDraftFilter, frxExportRTF,
  frxExportXLS, frxExportHTML, frxExportPDF, frxDMPExport;

type
  TfrmRelFiscResumoIcms = class(TfrmPai)
    Panel3: TPanel;
    edtEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    pgcPrincipal: TPageControl;
    pnlDados: TPanel;
    grdIcms: TStringGrid;
    grdIpi: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    grdCofins: TStringGrid;
    rdgFiltroDatas: TRadioGroup;
    grdPis: TStringGrid;
    btnCalcular: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnGravaSaldo: TBitBtnLocked;
    shpMultSel: TShape;
    chkEnviarValorCupomConfirmado: TCheckBox;
    chkEnviaTotalCredIcmCat158: TCheckBox;
    lblDesDtaFin: TLabel;
    lblDesDtaIni: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    mskDtaIni: TMaskEditFocus;
    chkEnviaCreDebDifal: TCheckBox;
    chkIncNFServicos: TCheckBox;
    chkConsolidarSaldoCredorEmp: TCheckBox;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    rldFiltro: TRLDraftFilter;
    frxRelatorio: TfrxDBDataset;
    frxReportJ: TfrxReport;
    frxComandos: TfrxUserDataSet;
    frxGen: TfrxUserDataSet;
    pnlFiltroMarca: TPanel;
    lblMarca: TLabel;
    edtDesMar: TEditFocus;
    edtCodMar: TEditFocus;
    pnlFiltros: TPanel;
    procedure FormShow(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);

    procedure btnCalcularClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGravaSaldoClick(Sender: TObject);
    procedure rdgFiltroDatasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
  private
    { Private declarations }
    QryRelatorio : TUniQuery;
    arrEmpresa   : TConsultasArray;
    strEmpresa   : String;
    strDtaSped   : String;
    fltTotDebSaida: Double;
    fltTotCredEntrada: Double;
    fltTotalCredCat158: double;
    fltDebDifal: double;
    fltCreDifal: double;
    blnUtilizaNFCE: Boolean;
    fltSomaTodosValoresIcmsIf: Double;
    arrMarca     : TConsultasArray;
    blnFiltrouMarca: Boolean;

    procedure pMostraResumoICMS(stgGrid: TStringGrid; strCodEmp: String);
    procedure pMostraResumoIPI(stgGrid: TStringGrid);
    procedure pMostraResumoPIS(stgGrid: TStringGrid);
    procedure pMostraResumoCOF(stgGrid: TStringGrid);

    procedure pRetSqlTotais(Var strSQL: String; strCampo, strNome: String;
      blnVirgula: Boolean = True; blnFiltrarIF: Boolean = False);
    procedure pCarregaValoresIcmsCupons(strCodEmp: String; var fltValorContabil,
      fltTotalBaseIcms, fltTotalValorIcms: Double);
    function fReducoesOk: Boolean;
    function fRetornaMesRefCreFis: String;
    function fRetTipoAjusteIcms(intIndex: integer): string;

    procedure pCarregaValoresOutrasIcms(strCodEmp: string);
    procedure pCarregaCreditoCat158(strCodEmp: string);
    procedure pCarregaValoresDifal(strCodEmp: string);

    procedure pCarregaDadosAjusteIcmsImpressao(qryRel : TUniQuery);
    procedure pCarregaDadosDifalImpressao(qryRel : TUniQuery);
    procedure pCarregaDadosCat158Impressao(qryRel : TUniQuery);

    procedure pVerificaUtilizacaoNFCE;

    function fRetEmpresasSelecionadas: string;
    function fConsolidarSaldoCredor: Boolean;

    procedure pCalcular;
    procedure pCalcularMarca;
    procedure pRetSqlTotaisMarca(Var strSQL: String; strCampo, strNome: String;
      blnVirgula: Boolean = True; blnFiltrarIF: Boolean = False);

    procedure pAjustaLinhas;

    procedure pImprimir;
    procedure pImprimirMarca;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFiscResumoIcms: TfrmRelFiscResumoIcms;

implementation

uses untFrameSheet, untFrameICMSIPI, untConstantes, untTApuradorAjustesIcms,
     untInformacoesECF, untFuncoesSimples, untFuncoesConsulta, untIFuncoes,
     untModulo, untTDadosCreditoCat158, untTDadosDifal, untConsultas;

{$R *.dfm}

procedure TfrmRelFiscResumoIcms.FormShow(Sender: TObject);
begin
  edtEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  strDtaSped := fCfgSis('INOBSF');

  QryRelatorio := fCriaQuery;

  pnlFiltroMarca.Visible := fCfgSis('UFMTRI', varBoolean);

  inherited;
end;

procedure TfrmRelFiscResumoIcms.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca', edtCodMar.MaxLength);
end;

procedure TfrmRelFiscResumoIcms.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, True) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFiscResumoIcms.edtEmpresaExit(Sender: TObject);
  Var qryTmpLojas: TUniQuery;
      aba        : TFrameSheet;
      strSQL     : String;
      Rect       : TGridRect;
      stgGrid    : TStringGrid;
begin
  inherited;

  pEdtCodSelectExit(edtEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');

  qryTmpLojas := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_CODEMP AS CODEMP ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '  CADEMP ';

  If Not fEmptyStr(edtEmpresa.Text) Then
  Begin
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP', True);
  End;

  strSQL := strSQL + ' ORDER BY EMP_CODEMP ';

  With qryTmpLojas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryTmpLojas);

    Open;

    If pgcPrincipal.PageCount > 0 Then
      While pgcPrincipal.PageCount > 0 Do
        pgcPrincipal.Pages[pgcPrincipal.PageCount - 1].Free;

    While Not Eof Do
    Begin

      aba             := TFrameSheet.Create(pgcPrincipal);
      aba.PageControl := pgcPrincipal;
      aba.Caption     := 'Empresa - ' + FieldByName('CODEMP').AsString;
      aba.Name        := 'tbsEmp' + FieldByName('CODEMP').AsString;
      aba.Frame       := TfrmFrameICMSIPI.Create(aba);
      aba.Frame.Align := alClient;

      { GRADE RESUMO DE ICMS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIcms;

      Rect.Left         := -1;
      Rect.Top          := -1;
      Rect.Right        := -1;
      Rect.Bottom       := -1;
      grdIcms.Selection := Rect;

      stgGrid.Cells[1,0] := fPadC('VR.CONTÁBIL',12);
      stgGrid.Cells[2,0] := fPadC('BASE ICMS',12);
      stgGrid.Cells[3,0] := fPadC('VR.ICMS',12);
      stgGrid.Cells[4,0] := fPadC('BASE ST',12);
      stgGrid.Cells[5,0] := fPadC('VR.ICMS ST',12);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
      stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
      stgGrid.Cells[0,7] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,8] := 'COMPRAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,9] := 'COMPRAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,10] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
      stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
      stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
      stgGrid.Cells[0,14] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,15] := 'TOTAL';

      stgGrid.ColWidths[0] := 150;
      stgGrid.ColWidths[1] := 116;
      stgGrid.ColWidths[2] := 116;
      stgGrid.ColWidths[3] := 110;
      stgGrid.ColWidths[4] := 105;
      stgGrid.ColWidths[5] := 105;

      { GRADE RESUMO DE IPI }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIpi;

      stgGrid.Cells[1,0] := fPadC('VR.CONTÁBIL',16);
      stgGrid.Cells[2,0] := fPadC('BASE',16);
      stgGrid.Cells[3,0] := fPadC('VR.IPI',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
      stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
      stgGrid.Cells[0,7] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,8] := 'COMPRAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,9] := 'COMPRAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,10] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
      stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
      stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
      stgGrid.Cells[0,14] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,15] := 'TOTAL';

      stgGrid.ColWidths[0] := 156;
      stgGrid.ColWidths[1] := 126;
      stgGrid.ColWidths[2] := 126;
      stgGrid.ColWidths[3] := 126;

      {*****************************************}
      {* COLOCADO MAIS 2 GRIDS PARA PIS/COFINS *}
      {**************************************AF*}
      { GRADE RESUMO DE PIS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdPis;

      stgGrid.Cells[1,0] := fPadL('BASE',16);
      stgGrid.Cells[2,0] := fPadL('VR.PIS',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,6] := 'COMPRAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,7] := 'COMPRAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,8] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,9] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,10] := 'TOTAL';

      { GRADE RESUMO DE COFINS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdCofins;

      stgGrid.Cells[1,0] := fPadL('BASE',16);
      stgGrid.Cells[2,0] := fPadL('VR.COFINS',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,6] := 'COMPRAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,7] := 'COMPRAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,8] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,9] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,10] := 'TOTAL';

      Next;

    End;

    {***************************************}
    {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
    {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
    {************************************RL*}
    If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
    Begin
      aba             := TFrameSheet.Create(pgcPrincipal);
      aba.PageControl := pgcPrincipal;
      aba.Caption     := 'Total';
      aba.Name        := 'tbsTotal';
      aba.Frame       := TfrmFrameICMSIPI.Create(aba);
      aba.Frame.Align := alClient;

      { GRADE RESUMO DE ICMS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIcms;

      Rect.Left         := -1;
      Rect.Top          := -1;
      Rect.Right        := -1;
      Rect.Bottom       := -1;
      grdIcms.Selection := Rect;

      stgGrid.Cells[1,0] := fPadC('VR.CONTÁBIL',12);
      stgGrid.Cells[2,0] := fPadC('BASE ICMS',12);
      stgGrid.Cells[3,0] := fPadC('VR.ICMS',12);
      stgGrid.Cells[4,0] := fPadC('BASE ST',12);
      stgGrid.Cells[5,0] := fPadC('VR.ICMS ST',12);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
      stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
      stgGrid.Cells[0,7] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,8] := 'COMPRAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,9] := 'COMPRAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,10] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
      stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
      stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
      stgGrid.Cells[0,14] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,15] := 'TOTAL';

      { GRADE RESUMO DE IPI }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIpi;

      stgGrid.Cells[1,0] := fPadC('VR.CONTÁBIL',16);
      stgGrid.Cells[2,0] := fPadC('BASE',16);
      stgGrid.Cells[3,0] := fPadC('VR.IPI',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
      stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
      stgGrid.Cells[0,7] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,8] := 'COMPRAS DE PRODUTOS';

      //***************//
      stgGrid.Cells[0,9] := 'COMPRAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,10] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
      stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
      stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
      stgGrid.Cells[0,14] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,15] := 'TOTAL';

      {*****************************************}
      {* COLOCADO MAIS 2 GRIDS PARA PIS/COFINS *}
      {**************************************AF*}
      { GRADE RESUMO DE PIS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdPis;

      stgGrid.Cells[1,0] := fPadL('BASE',16);
      stgGrid.Cells[2,0] := fPadL('VR.PIS',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,6] := 'COMPRAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,7] := 'COMPRAS SERVIÇOS';
      //***************//

      stgGrid.Cells[0,8] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,9] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,10] := 'TOTAL';

      { GRADE RESUMO DE COFINS }
      stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdCofins;

      stgGrid.Cells[1,0] := fPadL('BASE',16);
      stgGrid.Cells[2,0] := fPadL('VR.COFINS',16);

      stgGrid.Cells[0,1] := 'MÊS ANT.';
      stgGrid.Cells[0,2] := 'VENDAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,3] := 'VENDAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,4] := 'OUTRAS SAÍDAS';
      stgGrid.Cells[0,5] := 'TOTAL DE SAÍDAS';
      stgGrid.Cells[0,6] := 'COMPRAS PRODUTOS';

      //***************//
      stgGrid.Cells[0,7] := 'COMPRAS DE SERVIÇOS';
      //***************//

      stgGrid.Cells[0,8] := 'OUTRAS ENTRADAS';
      stgGrid.Cells[0,9] := 'TOTAL DE ENTRADAS';
      stgGrid.Cells[0,10] := 'TOTAL';

    End;

  End;

  pgcPrincipal.TabIndex := 0;

  FreeAndNil(qryTmpLojas);
  pnlDados.Visible := False;
end;

procedure TfrmRelFiscResumoIcms.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFiscResumoIcms.fReducoesOk: Boolean;
  Var
    infoEcf: TInformacoesEcf;
begin
  infoEcf := TInformacoesECF.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  Result := infoEcf.fReducoesOk(edtEmpresa.Text);
  FreeAndNil(infoEcf);
end;

function TfrmRelFiscResumoIcms.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtEmpresa) Then
    Begin
      If Not fEmptyStr(edtEmpresa.Text) And (edtEmpresa.Text <> '000') Then
      Begin
        If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodMar) Then
    begin

      If fEmptyStr(edtCodMar.Text) Then
      Begin

        edtDesMar.Clear;

      End Else
      Begin

        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);

        If fEmptyStr(edtDesMar.Text) Then
        Begin
          pMensagemOk('Marca não encontrada!');
          edtCodMar.clear;
          Result := False;
        End;

      End;

    End;

  End;
end;

procedure TfrmRelFiscResumoIcms.pRetSqlTotais(Var strSQL: String; strCampo, strNome: String; blnVirgula: Boolean = True; blnFiltrarIF: Boolean = False);
  Var
    strEsp: String;
Begin
  If blnFiltrarIF Then
    strEsp := '"IF", "IV"'
  Else
    strEsp := '""';

  If blnFiltrarIF Then
  Begin

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC2,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC2, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC3,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC3, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC4,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC4, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC5,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC5, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS' +  strNome + ', ';

    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03) <> 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC2, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03) <> 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC3, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03) <> 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC4, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03) <> 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC5, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS OUTSAI' +  strNome + ', ';

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)<> 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC2, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)<> 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC3, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)<> 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC4, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)<> 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC5, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS_PRODUTOS' +  strNome + ', ';
    //***************************//

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
    if chkIncNFServicos.Checked then
    begin
      strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)= 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC2, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)= 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC3, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)= 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC4, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)= 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC5, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS_SERVICOS' +  strNome + ', ';
    end else
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOS' +  strNome + ', ';
    //***************************//
  End
  Else
  Begin
    (****************************************************************************************)
    (* VENDAS / OUTRAS SAIDAS                                                               *)
    (*************************************************************************************LA*)
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC2,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC2, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC3,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC3, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC4,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC4, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC5,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC5, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS' +  strNome + ', ';

    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03) <> 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC2, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03) <> 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC3, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03) <> 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC4, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03) <> 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC5, :CLAVEN) = 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS OUTSAI' +  strNome + ', ';

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)<> 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC2, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)<> 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC3, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)<> 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC4, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)<> 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC5, :CLAVEN) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS_PRODUTOS' +  strNome + ', ';
    //***************************//

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
    if chkIncNFServicos.Checked then
    begin
      strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)= 933) AND (LEFT(FIS_CLFSC2,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC2, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)= 933) AND (LEFT(FIS_CLFSC3,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC3, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)= 933) AND (LEFT(FIS_CLFSC4,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC4, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
      strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)= 933) AND (LEFT(FIS_CLFSC5,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC5, "5933_6933_") > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS VENDAS_SERVICOS' +  strNome + ', ';
    end else
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOS' +  strNome + ', ';
    //***************************//
  End;

  (****************************************************************************************)
  (* COMPRAS / OUTRAS ENTRADAS                                                            *)
  (*************************************************************************************LA*)
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
  strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC2,01) < 5) AND (LOCATE(FIS_CLFSC2, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
  strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC3,01) < 5) AND (LOCATE(FIS_CLFSC3, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
  strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC4,01) < 5) AND (LOCATE(FIS_CLFSC4, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
  strSQL := strSQL + '       IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC5,01) < 5) AND (LOCATE(FIS_CLFSC5, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS COMPRA' + strNome + ', ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03) <> 933) AND (LEFT(FIS_CLFSC2,01) < 5) AND (LOCATE(FIS_CLFSC2, :CLACOM) = 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03) <> 933) AND (LEFT(FIS_CLFSC3,01) < 5) AND (LOCATE(FIS_CLFSC3, :CLACOM) = 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03) <> 933) AND (LEFT(FIS_CLFSC4,01) < 5) AND (LOCATE(FIS_CLFSC4, :CLACOM) = 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03) <> 933) AND (LEFT(FIS_CLFSC5,01) < 5) AND (LOCATE(FIS_CLFSC5, :CLACOM) = 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS OUTENT' + strNome + ', ';

  //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)<> 933) AND (LEFT(FIS_CLFSC2,01) < 5) AND (LOCATE(FIS_CLFSC2, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)<> 933) AND (LEFT(FIS_CLFSC3,01) < 5) AND (LOCATE(FIS_CLFSC3, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)<> 933) AND (LEFT(FIS_CLFSC4,01) < 5) AND (LOCATE(FIS_CLFSC4, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
  strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)<> 933) AND (LEFT(FIS_CLFSC5,01) < 5) AND (LOCATE(FIS_CLFSC5, :CLACOM) > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS COMPRA_PRODUTOS' + strNome + ', ';
  //***************************//

  //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
  if chkIncNFServicos.Checked then
  begin
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0), IFNULL(FIS_' + strCampo + '1, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC2,03)= 933) AND (LEFT(FIS_CLFSC2,01) < 5) AND (LOCATE(FIS_CLFSC2, "1933_2933_") > 0), IFNULL(FIS_' + strCampo + '2, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC3,03)= 933) AND (LEFT(FIS_CLFSC3,01) < 5) AND (LOCATE(FIS_CLFSC3, "1933_2933_") > 0), IFNULL(FIS_' + strCampo + '3, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC4,03)= 933) AND (LEFT(FIS_CLFSC4,01) < 5) AND (LOCATE(FIS_CLFSC4, "1933_2933_") > 0), IFNULL(FIS_' + strCampo + '4, 0), 0 ) +  ';
    strSQL := strSQL + '       IF( (RIGHT(FIS_CLFSC5,03)= 933) AND (LEFT(FIS_CLFSC5,01) < 5) AND (LOCATE(FIS_CLFSC5, "1933_2933_") > 0), IFNULL(FIS_' + strCampo + '5, 0), 0 ) ) AS COMPRA_SERVICOS' + strNome + ' ';
  end else
    strSQL := strSQL + '  SUM( 0) AS COMPRA_SERVICOS' + strNome + ' ';
  //***************************//

  If blnVirgula Then
    strSQL := strSQL + ', ';
End;

procedure TfrmRelFiscResumoIcms.pRetSqlTotaisMarca(var strSQL: String; strCampo,
  strNome: String; blnVirgula, blnFiltrarIF: Boolean);
Var
    strEsp: String;
Begin
  If blnFiltrarIF Then
    strEsp := '"IF", "IV"'
  Else
    strEsp := '""';

  If blnFiltrarIF Then
  Begin
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS' +  strNome + ', ';

    strSQL := strSQL + '   SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS OUTSAI' +  strNome + ', ';

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS_PRODUTOS' +  strNome + ', ';
    //***************************//

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
    if chkIncNFServicos.Checked then
      strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN (' + strEsp + '))) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS_SERVICOS' +  strNome + ', '
    else
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOS' +  strNome + ', ';
    //***************************//
  End
  Else
  Begin
    (****************************************************************************************)
    (* VENDAS / OUTRAS SAIDAS                                                               *)
    (*************************************************************************************LA*)
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS' +  strNome + ', ';

    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS OUTSAI' +  strNome + ', ';

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS_PRODUTOS' +  strNome + ', ';
    //***************************//

    //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
    if chkIncNFServicos.Checked then
      strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND FIS_ESPDOC NOT IN(' + strEsp + ') AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS VENDAS_SERVICOS' +  strNome + ', '
    else
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOS' +  strNome + ', ';
    //***************************//
  End;

  (****************************************************************************************)
  (* COMPRAS / OUTRAS ENTRADAS                                                            *)
  (*************************************************************************************LA*)
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS COMPRA' + strNome + ', ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS OUTENT' + strNome + ', ';

  //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E DIFERENTE DE x933 (SOMENTE PRODUTO) *****//
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03)<> 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS COMPRA_PRODUTOS' + strNome + ', ';
  //***************************//

  //* CALCULA TODAS CFOP MAIOR OU IGUAL A 5 E IGUAIS DE x933 (SOMENTE SERVIÇOS) *****//
  if chkIncNFServicos.Checked then
    strSQL := strSQL + ' SUM( IF( (RIGHT(FIS_CLFSC1,03)= 933) AND (LEFT(FIS_CLFSC1,01) < 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0), IFNULL(DET_' + strCampo + ', 0), 0 ) ) AS COMPRA_SERVICOS' + strNome + ' '
  else
    strSQL := strSQL + '  SUM( 0) AS COMPRA_SERVICOS' + strNome + ' ';
  //***************************//

  If blnVirgula Then
    strSQL := strSQL + ', ';
End;

procedure TfrmRelFiscResumoIcms.pVerificaUtilizacaoNFCE;
  Var
    qryAux: TUniQuery;                       
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_USNFCE" AND SIS_CODEMP = :CODEMP ';
    qryAux.ParamByName('CODEMP').AsString := IfThen(fEmptyStr(edtEmpresa.Text), VS_strCodEmp, edtEmpresa.Text);
    qryAux.Open;

    blnUtilizaNFCE := qryAux.FieldByName('SIS_VALCFG').AsString = 'S';
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmRelFiscResumoIcms.pMostraResumoICMS(stgGrid: TStringGrid; strCodEmp: String);
  Var
    fltValorContabil, fltTotalBaseIcms, fltTotalValorIcms: Double;
Begin
  If Not fEmptyStr(strCodEmp) Then
  Begin
    pCarregaValoresIcmsCupons(strCodEmp, fltValorContabil, fltTotalBaseIcms, fltTotalValorIcms);
    fltSomaTodosValoresIcmsIf := fltSomaTodosValoresIcmsIf + fltTotalValorIcms;
  End
  Else
    fltTotalValorIcms := fltSomaTodosValoresIcmsIf;

  stgGrid.Cells[1,1] := '';
  stgGrid.Cells[2,1] := '';
  stgGrid.Cells[3,1] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ICMANT').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,1] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ST_ANT').AsFloat,ffNumber,15,2),14);

  // SAIDAS { não utilizar momento }
  { stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASVLRICM').AsFloat + fltTotalValorIcms, ffNumber,15,2),14); }

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSVLRICM').AsFloat + fltTotalValorIcms, ffNumber,15,2),14);
  stgGrid.Cells[4,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSBAS_ST').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[5,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSVLR_ST').AsFloat, ffNumber,15,2),14);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSBASICM').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[3,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSVLRICM').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[4,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSBAS_ST').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[5,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSVLR_ST').AsFloat, ffNumber,15,2),14);
  //********************************************************//

  stgGrid.Cells[1,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIVLRICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[4,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIBAS_ST').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIVLR_ST').AsFloat,ffNumber,15,2),14);

  //ajustes de débito AJUICM + AJUSTE > FISAJU + AJUSTE > FISADJ + AJUSTE
  stgGrid.Cells[1,5] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);
  stgGrid.Cells[3,5] := fPadL(FloatToStrF(fltTotDebSaida,ffNumber,15,2),14);
  stgGrid.Cells[4,5] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);
  stgGrid.Cells[5,5] := fPadL(FloatToStrF(0,ffNumber,15,2),14);

  //débitos difal
  stgGrid.Cells[1,6] := fPadL(FloatToStrF(0, ffNumber,15,2), 15);
  stgGrid.Cells[2,6] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[3,6] := fPadL(FloatToStrF(fltDebDifal, ffNumber,15,2), 14);
  stgGrid.Cells[4,6] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[5,6] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);

  stgGrid.Cells[1,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_BASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLRICM').AsFloat + fltTotalValorIcms + fltTotDebSaida + fltDebDifal, ffNumber,15,2),14);
  stgGrid.Cells[4,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_BAS_ST').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[5,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLR_ST').AsFloat, ffNumber,15,2),14);

  // ENTRADAS { não utilizar no momento }
  { stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRABASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRAVLRICM').AsFloat,ffNumber,15,2),14); }

  //********************************************************//
  // ENTRADAS PRODUTOS
  stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSVLRICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[4,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSBAS_ST').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSVLR_ST').AsFloat,ffNumber,15,2),14);
  //********************************************************//
  // ENTRADAS SERVIÇOS
  stgGrid.Cells[1,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSVLRICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[4,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSBAS_ST').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSVLR_ST').AsFloat,ffNumber,15,2),14);
  //********************************************************//

  stgGrid.Cells[1,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTBASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTVLRICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[4,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTBAS_ST').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTVLR_ST').AsFloat,ffNumber,15,2),14);

  //ajustes de crédito AJUICM + AJUSTE > FISAJU + AJUSTE > FISADJ + AJUSTE
  stgGrid.Cells[1,11] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,11] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);
  stgGrid.Cells[3,11] := fPadL(FloatToStrF(fltTotCredEntrada, ffNumber, 15, 2),14);
  stgGrid.Cells[4,11] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[5,11] := fPadL(FloatToStrF(0, ffNumber, 15, 2),14);

  //créditos difal
  stgGrid.Cells[1,12] := fPadL(FloatToStrF(0, ffNumber,15,2), 15);
  stgGrid.Cells[2,12] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[3,12] := fPadL(FloatToStrF(fltCreDifal, ffNumber,15,2), 14);
  stgGrid.Cells[4,12] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[5,12] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);

  //créditos CAT-158
  stgGrid.Cells[1,13] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,13] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);
  stgGrid.Cells[3,13] := fPadL(FloatToStrF(fltTotalCredCat158, ffNumber,15,2), 14);
  stgGrid.Cells[4,13] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);
  stgGrid.Cells[5,13] := fPadL(FloatToStrF(0, ffNumber,15,2), 14);

  stgGrid.Cells[1,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_BASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_VLRICM').AsFloat + fltTotCredEntrada + fltCreDifal + fltTotalCredCat158, ffNumber, 15, 2),14);
  stgGrid.Cells[4,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_BAS_ST').AsFloat, ffNumber,15,2),14);
  stgGrid.Cells[5,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_VLR_ST').AsFloat, ffNumber,15,2),14);

  // TOTAL
  stgGrid.Cells[1,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_BASICM').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[3,15] := fPadL(FloatToStrF((QryRelatorio.FieldByName('SAI_VLRICM').AsFloat +
                                            fltDebDifal +
                                            fltTotalValorIcms +
                                            fltTotDebSaida) -
                                            (QryRelatorio.FieldByName('ENT_VLRICM').AsFloat +
                                            fltTotCredEntrada +
                                            fltCreDifal +
                                            fltTotalCredCat158) -
                                            QryRelatorio.FieldByName('ICMANT').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[4,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_BAS_ST').AsFloat,ffNumber,15,2),14);
  stgGrid.Cells[5,15] := fPadL(FloatToStrF((QryRelatorio.FieldByName('SAI_VLR_ST').AsFloat) -
                                            (QryRelatorio.FieldByName('ENT_VLR_ST').AsFloat) -
                                            QryRelatorio.FieldByName('ST_ANT').AsFloat,ffNumber,15,2),14);
End;

procedure TfrmRelFiscResumoIcms.pAjustaLinhas;
var
  stgGrid: TStringGrid;
  intContador, intRow, intCol : Integer;
begin
  If pgcPrincipal.PageCount > 0 Then
  Begin
    For intContador := 0 To pgcPrincipal.PageCount -1 Do
    Begin
      if pgcPrincipal.Pages[intContador].Name = 'tbsTotal' then
      begin
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIcms;
        stgGrid.RowHeights[5] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[6] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[11] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[12] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[13] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);

        if blnFiltrouMarca then
        begin
          for intRow := 0 to stgGrid.RowCount -1 do
          begin
            if stgGrid.RowHeights[intRow] = -1 then
            begin
              for intCol := 0 to stgGrid.ColCount -1 do
                stgGrid.Cells[intCol, intRow] := EmptyStr;
            end;
          end;
        end
        else
        begin
          stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
          stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
          stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
          stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
          stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
        end;

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIpi;
        stgGrid.RowHeights[5] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[6] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[11] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[12] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[13] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);

        if blnFiltrouMarca then
        begin
          for intRow := 0 to stgGrid.RowCount -1 do
          begin
            if stgGrid.RowHeights[intRow] = -1 then
            begin
              for intCol := 0 to stgGrid.ColCount -1 do
                stgGrid.Cells[intCol, intRow] := EmptyStr;
            end;
          end;
        end
        else
        begin
          stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
          stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
          stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
          stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
          stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
        end;
      end
      else
      begin
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdIcms;
        stgGrid.RowHeights[5] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[6] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[11] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[12] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[13] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);

        if blnFiltrouMarca then
        begin
          for intRow := 0 to stgGrid.RowCount -1 do
          begin
            if stgGrid.RowHeights[intRow] = -1 then
            begin
              for intCol := 0 to stgGrid.ColCount -1 do
                stgGrid.Cells[intCol, intRow] := EmptyStr;
            end;
          end;
        end
        else
        begin
          stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
          stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
          stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
          stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
          stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
        end;

        stgGrid  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdIpi;
        stgGrid.RowHeights[5] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[6] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[11] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[12] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);
        stgGrid.RowHeights[13] := IIF(blnFiltrouMarca, -1, stgGrid.RowHeights[1]);

        if blnFiltrouMarca then
        begin
          for intRow := 0 to stgGrid.RowCount -1 do
          begin
            if stgGrid.RowHeights[intRow] = -1 then
            begin
              for intCol := 0 to stgGrid.ColCount -1 do
                stgGrid.Cells[intCol, intRow] := EmptyStr;
            end;
          end;
        end
        else
        begin
          stgGrid.Cells[0,5] := 'DÉBITOS AJUSTE';
          stgGrid.Cells[0,6] := 'DÉBITOS DIFAL';
          stgGrid.Cells[0,11] := 'CRÉDITOS AJUSTE';
          stgGrid.Cells[0,12] := 'CRÉDITOS DIFAL';
          stgGrid.Cells[0,13] := 'CRÉDITOS CAT-158';
        end;
      end;
    End;
  End;
end;

procedure TfrmRelFiscResumoIcms.pCalcular;
Var
    strSQL  : String;
    stgGrid : TStringGrid;
begin
  try
    {*******************************************}
    {* RELATÓRIOS DE ICMS/ICMS-ST              *}
    {****************************************MV*}

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CODEMP, ICMANT, IPIANT, PISANT, COFANT, ST_ANT, ';
    strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
    strSQL := strSQL + '  SUM(SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5) AS SAI_BASICM, ';
    strSQL := strSQL + '  SUM(SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5) AS SAI_VLRICM, ';
    strSQL := strSQL + '  SUM(SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5) AS SAI_BAS_ST, ';
    strSQL := strSQL + '  SUM(SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5) AS SAI_VLR_ST, ';

    strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
    strSQL := strSQL + '  SUM(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5) AS ENT_BASICM, ';
    strSQL := strSQL + '  SUM(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) AS ENT_VLRICM, ';
    strSQL := strSQL + '  SUM(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5) AS ENT_BAS_ST, ';
    strSQL := strSQL + '  SUM(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) AS ENT_VLR_ST, ';
    strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

    //********************/
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASICM) AS VENDAS_PRODUTOSBASICM, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRICM) AS VENDAS_PRODUTOSVLRICM, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBAS_ST) AS VENDAS_PRODUTOSBAS_ST, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLR_ST) AS VENDAS_PRODUTOSVLR_ST, ';
    // VENDA SERVIÇOS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASICM) AS VENDAS_SERVICOSBASICM, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRICM) AS VENDAS_SERVICOSVLRICM, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBAS_ST) AS VENDAS_SERVICOSBAS_ST, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLR_ST) AS VENDAS_SERVICOSVLR_ST, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
    strSQL := strSQL + '  SUM(VENDASBASICM) AS VENDASBASICM, ';
    strSQL := strSQL + '  SUM(OUTSAIBASICM) AS OUTSAIBASICM, ';
    strSQL := strSQL + '  SUM(VENDASBAS_ST) AS VENDASBAS_ST, ';
    strSQL := strSQL + '  SUM(OUTSAIBAS_ST) AS OUTSAIBAS_ST, ';

    strSQL := strSQL + '  SUM(VENDASVLRICM) AS VENDASVLRICM, ';
    strSQL := strSQL + '  SUM(OUTSAIVLRICM) AS OUTSAIVLRICM, ';
    strSQL := strSQL + '  SUM(VENDASVLR_ST) AS VENDASVLR_ST, ';
    strSQL := strSQL + '  SUM(OUTSAIVLR_ST) AS OUTSAIVLR_ST, ';
    strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

    //********************/
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASICM) AS COMPRA_PRODUTOSBASICM, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRICM) AS COMPRA_PRODUTOSVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBAS_ST) AS COMPRA_PRODUTOSBAS_ST, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLR_ST) AS COMPRA_PRODUTOSVLR_ST, ';
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASICM) AS COMPRA_SERVICOSBASICM, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRICM) AS COMPRA_SERVICOSVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBAS_ST) AS COMPRA_SERVICOSBAS_ST, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLR_ST) AS COMPRA_SERVICOSVLR_ST, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
    strSQL := strSQL + '  SUM(COMPRABASICM) AS COMPRABASICM, ';
    strSQL := strSQL + '  SUM(OUTENTBASICM) AS OUTENTBASICM, ';
    strSQL := strSQL + '  SUM(COMPRABAS_ST) AS COMPRABAS_ST, ';
    strSQL := strSQL + '  SUM(OUTENTBAS_ST) AS OUTENTBAS_ST, ';

    strSQL := strSQL + '  SUM(COMPRAVLRICM) AS COMPRAVLRICM, ';
    strSQL := strSQL + '  SUM(OUTENTVLRICM) AS OUTENTVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRAVLR_ST) AS COMPRAVLR_ST, ';
    strSQL := strSQL + '  SUM(OUTENTVLR_ST) AS OUTENTVLR_ST, ';

    strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
    strSQL := strSQL + '  SUM((SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5)-(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5)) AS TOT_BASICM, ';
    strSQL := strSQL + '  SUM((SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5)-(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5)) - ICMANT AS TOT_VLRICM, ';
    strSQL := strSQL + '  SUM((SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5)-(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5)) AS TOT_BAS_ST, ';
    strSQL := strSQL + '  SUM((SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5)-(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5)) - ST_ANT AS TOT_VLR_ST ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
    strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
    strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
    strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
    strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) AS SAI_VLCON1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) AS SAI_VLCON2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) AS SAI_VLCON3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) AS SAI_VLCON4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIC1, 0 ) ) AS SAI_BASIC1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIC2, 0 ) ) AS SAI_BASIC2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIC3, 0 ) ) AS SAI_BASIC3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIC4, 0 ) ) AS SAI_BASIC4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIC5, 0 ) ) AS SAI_BASIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC1, 0 ) ) AS SAI_VLRIC1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC2, 0 ) ) AS SAI_VLRIC2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC3, 0 ) ) AS SAI_VLRIC3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC4, 0 ) ) AS SAI_VLRIC4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC5, 0 ) ) AS SAI_VLRIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BCRET1, 0 ) ) AS SAI_BASST1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BCRET2, 0 ) ) AS SAI_BASST2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BCRET3, 0 ) ) AS SAI_BASST3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BCRET4, 0 ) ) AS SAI_BASST4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BCRET5, 0 ) ) AS SAI_BASST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID1, 0 ) ) AS SAI_VLRST1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID2, 0 ) ) AS SAI_VLRST2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID3, 0 ) ) AS SAI_VLRST3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID4, 0 ) ) AS SAI_VLRST4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID5, 0 ) ) AS SAI_VLRST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLCON1, 0 ) ) AS ENT_VLCON1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLCON2, 0 ) ) AS ENT_VLCON2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLCON3, 0 ) ) AS ENT_VLCON3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLCON4, 0 ) ) AS ENT_VLCON4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLCON5, 0 ) ) AS ENT_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIC1, 0 ) ) AS ENT_BASIC1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIC2, 0 ) ) AS ENT_BASIC2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIC3, 0 ) ) AS ENT_BASIC3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIC4, 0 ) ) AS ENT_BASIC4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIC5, 0 ) ) AS ENT_BASIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIC1, 0 ) ) AS ENT_VLRIC1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIC2, 0 ) ) AS ENT_VLRIC2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIC3, 0 ) ) AS ENT_VLRIC3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIC4, 0 ) ) AS ENT_VLRIC4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIC5, 0 ) ) AS ENT_VLRIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BCRET1, 0 ) ) AS ENT_BASST1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BCRET2, 0 ) ) AS ENT_BASST2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BCRET3, 0 ) ) AS ENT_BASST3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BCRET4, 0 ) ) AS ENT_BASST4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BCRET5, 0 ) ) AS ENT_BASST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_RETID1, 0 ) ) AS ENT_VLRST1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_RETID2, 0 ) ) AS ENT_VLRST2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_RETID3, 0 ) ) AS ENT_VLRST3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_RETID4, 0 ) ) AS ENT_VLRST4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_RETID5, 0 ) ) AS ENT_VLRST5, ';

    pRetSqlTotais(strSQL, 'VLCON', '', True);
    pRetSqlTotais(strSQL, 'BASIC', 'BASICM', True);
    pRetSqlTotais(strSQL, 'VLRIC', 'VLRICM', True, True);
    pRetSqlTotais(strSQL, 'BCRET', 'BAS_ST', True);
    pRetSqlTotais(strSQL, 'RETID', 'VLR_ST', False, True);

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';

    strSQL := strSQL + '  LEFT JOIN CADEMP ';
    strSQL := strSQL + '   ON EMP_CODEMP = FIS_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa, arrEmpresa, 'FIS_CODEMP', 'CODEMP');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    strSQL := strSQL + ' ) relatorio ';

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;

      Open;

      While Not Eof Do
      Begin
        pCarregaValoresOutrasIcms(FieldByName('CODEMP').AsString);
        pCarregaCreditoCat158(FieldByName('CODEMP').AsString);
        pCarregaValoresDifal(FieldByName('CODEMP').AsString);

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIcms;

        pMostraResumoICMS(stgGrid, FieldByName('CODEMP').AsString);

        Next;
      End;

      Close;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';
        strSQL := strSQL + '  SUM(ICMANT) AS ICMANT, ';
        strSQL := strSQL + '  SUM(IPIANT) AS IPIANT, ';
        strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
        strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';
        strSQL := strSQL + '  SUM(ST_ANT) AS ST_ANT, ';
        strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
        strSQL := strSQL + '  SUM(SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5) AS SAI_BASICM, ';
        strSQL := strSQL + '  SUM(SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5) AS SAI_VLRICM, ';
        strSQL := strSQL + '  SUM(SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5) AS SAI_BAS_ST, ';
        strSQL := strSQL + '  SUM(SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5) AS SAI_VLR_ST, ';

        strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
        strSQL := strSQL + '  SUM(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5) AS ENT_BASICM, ';
        strSQL := strSQL + '  SUM(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) AS ENT_VLRICM, ';
        strSQL := strSQL + '  SUM(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5) AS ENT_BAS_ST, ';
        strSQL := strSQL + '  SUM(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) AS ENT_VLR_ST, ';
        strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

        //********************/
        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASICM) AS VENDAS_PRODUTOSBASICM, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRICM) AS VENDAS_PRODUTOSVLRICM, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBAS_ST) AS VENDAS_PRODUTOSBAS_ST, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLR_ST) AS VENDAS_PRODUTOSVLR_ST, ';
        // VENDA SERVIÇOS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASICM) AS VENDAS_SERVICOSBASICM, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRICM) AS VENDAS_SERVICOSVLRICM, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBAS_ST) AS VENDAS_SERVICOSBAS_ST, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLR_ST) AS VENDAS_SERVICOSVLR_ST, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
        strSQL := strSQL + '  SUM(VENDASBASICM) AS VENDASBASICM, ';
        strSQL := strSQL + '  SUM(OUTSAIBASICM) AS OUTSAIBASICM, ';
        strSQL := strSQL + '  SUM(VENDASBAS_ST) AS VENDASBAS_ST, ';
        strSQL := strSQL + '  SUM(OUTSAIBAS_ST) AS OUTSAIBAS_ST, ';

        strSQL := strSQL + '  SUM(VENDASVLRICM) AS VENDASVLRICM, ';
        strSQL := strSQL + '  SUM(OUTSAIVLRICM) AS OUTSAIVLRICM, ';
        strSQL := strSQL + '  SUM(VENDASVLR_ST) AS VENDASVLR_ST, ';
        strSQL := strSQL + '  SUM(OUTSAIVLR_ST) AS OUTSAIVLR_ST, ';
        strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

        //********************/
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASICM) AS COMPRA_PRODUTOSBASICM, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRICM) AS COMPRA_PRODUTOSVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBAS_ST) AS COMPRA_PRODUTOSBAS_ST, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLR_ST) AS COMPRA_PRODUTOSVLR_ST, ';
        // COMPRA SERVIÇOS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASICM) AS COMPRA_SERVICOSBASICM, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRICM) AS COMPRA_SERVICOSVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBAS_ST) AS COMPRA_SERVICOSBAS_ST, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLR_ST) AS COMPRA_SERVICOSVLR_ST, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
        strSQL := strSQL + '  SUM(COMPRABASICM) AS COMPRABASICM, ';
        strSQL := strSQL + '  SUM(OUTENTBASICM) AS OUTENTBASICM, ';
        strSQL := strSQL + '  SUM(COMPRABAS_ST) AS COMPRABAS_ST, ';
        strSQL := strSQL + '  SUM(OUTENTBAS_ST) AS OUTENTBAS_ST, ';

        strSQL := strSQL + '  SUM(COMPRAVLRICM) AS COMPRAVLRICM, ';
        strSQL := strSQL + '  SUM(OUTENTVLRICM) AS OUTENTVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRAVLR_ST) AS COMPRAVLR_ST, ';
        strSQL := strSQL + '  SUM(OUTENTVLR_ST) AS OUTENTVLR_ST, ';

        strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
        strSQL := strSQL + '  SUM((SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5)-(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5)) AS TOT_BASICM, ';
        strSQL := strSQL + '  SUM((SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5)-(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) - ICMANT) AS TOT_VLRICM, ';
        strSQL := strSQL + '  SUM((SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5)-(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5)) AS TOT_BAS_ST, ';
        strSQL := strSQL + '  SUM((SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5)-(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) - ST_ANT) AS TOT_VLR_ST ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  (  ';

        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
        strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
        strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
        strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
        strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
        strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) AS SAI_VLCON1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) AS SAI_VLCON2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) AS SAI_VLCON3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) AS SAI_VLCON4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIC1, 0 ) ) AS SAI_BASIC1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIC2, 0 ) ) AS SAI_BASIC2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIC3, 0 ) ) AS SAI_BASIC3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIC4, 0 ) ) AS SAI_BASIC4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIC5, 0 ) ) AS SAI_BASIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC1, 0 ) ) AS SAI_VLRIC1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC2, 0 ) ) AS SAI_VLRIC2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC3, 0 ) ) AS SAI_VLRIC3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC4, 0 ) ) AS SAI_VLRIC4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_VLRIC5, 0 ) ) AS SAI_VLRIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BCRET1, 0 ) ) AS SAI_BASST1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BCRET2, 0 ) ) AS SAI_BASST2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BCRET3, 0 ) ) AS SAI_BASST3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BCRET4, 0 ) ) AS SAI_BASST4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BCRET5, 0 ) ) AS SAI_BASST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID1, 0 ) ) AS SAI_VLRST1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID2, 0 ) ) AS SAI_VLRST2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID3, 0 ) ) AS SAI_VLRST3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID4, 0 ) ) AS SAI_VLRST4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), FIS_RETID5, 0 ) ) AS SAI_VLRST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLCON1, 0 ) ) AS ENT_VLCON1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLCON2, 0 ) ) AS ENT_VLCON2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLCON3, 0 ) ) AS ENT_VLCON3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLCON4, 0 ) ) AS ENT_VLCON4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLCON5, 0 ) ) AS ENT_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIC1, 0 ) ) AS ENT_BASIC1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIC2, 0 ) ) AS ENT_BASIC2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIC3, 0 ) ) AS ENT_BASIC3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIC4, 0 ) ) AS ENT_BASIC4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIC5, 0 ) ) AS ENT_BASIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIC1, 0 ) ) AS ENT_VLRIC1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIC2, 0 ) ) AS ENT_VLRIC2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIC3, 0 ) ) AS ENT_VLRIC3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIC4, 0 ) ) AS ENT_VLRIC4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIC5, 0 ) ) AS ENT_VLRIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BCRET1, 0 ) ) AS ENT_BASST1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BCRET2, 0 ) ) AS ENT_BASST2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BCRET3, 0 ) ) AS ENT_BASST3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BCRET4, 0 ) ) AS ENT_BASST4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BCRET5, 0 ) ) AS ENT_BASST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_RETID1, 0 ) ) AS ENT_VLRST1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_RETID2, 0 ) ) AS ENT_VLRST2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_RETID3, 0 ) ) AS ENT_VLRST3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_RETID4, 0 ) ) AS ENT_VLRST4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_RETID5, 0 ) ) AS ENT_VLRST5, ';

        pRetSqlTotais(strSQL, 'VLCON', '', True);
        pRetSqlTotais(strSQL, 'BASIC', 'BASICM', True);
        pRetSqlTotais(strSQL, 'VLRIC', 'VLRICM', True, True);
        pRetSqlTotais(strSQL, 'BCRET', 'BAS_ST', True);
        pRetSqlTotais(strSQL, 'RETID', 'VLR_ST', False, True);

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                       CRE_MESREF = :MESREF ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';

        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        Open;

        pCarregaValoresOutrasIcms(fRetEmpresasSelecionadas);
        pCarregaCreditoCat158(fRetEmpresasSelecionadas);
        pCarregaValoresDifal(fRetEmpresasSelecionadas);

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIcms;

        pMostraResumoICMS(stgGrid, '');
      End;
    End;

    {*******************************************}
    {* RELATÓRIO DE IPI                        *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CODEMP, ';
    strSQL := strSQL + '  IPIANT, ';
    strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
    strSQL := strSQL + '  SUM(SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5) AS SAI_BASIPI, ';
    strSQL := strSQL + '  SUM(SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI) AS SAI_VLRIPI, ';

    strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
    strSQL := strSQL + '  SUM(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5) AS ENT_BASIPI, ';
    strSQL := strSQL + '  SUM(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) AS ENT_VLRIPI, ';
    strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

    //********************/
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASIPI) AS VENDAS_PRODUTOSBASIPI, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRIPI) AS VENDAS_PRODUTOSVLRIPI, ';
    // VENDA SERVIÇOS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASIPI) AS VENDAS_SERVICOSBASIPI, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRIPI) AS VENDAS_SERVICOSVLRIPI, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
    strSQL := strSQL + '  SUM(VENDASBASIPI) AS VENDASBASIPI, ';
    strSQL := strSQL + '  SUM(OUTSAIBASIPI) AS OUTSAIBASIPI, ';

    strSQL := strSQL + '  SUM(VENDASVLRIPI) AS VENDASVLRIPI, ';
    strSQL := strSQL + '  SUM(OUTSAIVLRIPI) AS OUTSAIVLRIPI, ';
    strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

    strSQL := strSQL + '  SUM(SAI_AJUIPI) AS AJUSAIVLRIPI, ';

    //********************/
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASIPI) AS COMPRA_PRODUTOSBASIPI, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRIPI) AS COMPRA_PRODUTOSVLRIPI, ';
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASIPI) AS COMPRA_SERVICOSBASIPI, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRIPI) AS COMPRA_SERVICOSVLRIPI, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
    strSQL := strSQL + '  SUM(COMPRABASIPI) AS COMPRABASIPI, ';
    strSQL := strSQL + '  SUM(OUTENTBASIPI) AS OUTENTBASIPI, ';

    strSQL := strSQL + '  SUM(COMPRAVLRIPI) AS COMPRAVLRIPI, ';
    strSQL := strSQL + '  SUM(OUTENTVLRIPI) AS OUTENTVLRIPI, ';

    strSQL := strSQL + '  SUM(ENT_AJUIPI) AS AJUENTVLRIPI, ';

    strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
    strSQL := strSQL + '  SUM((SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5)-(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5)) AS TOT_BASIPI, ';
    strSQL := strSQL + '  SUM((SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI)-(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI)) - IPIANT AS TOT_VLRIPI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
    strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT,  ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) AS SAI_VLCON1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) AS SAI_VLCON2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) AS SAI_VLCON3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) AS SAI_VLCON4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIP1, 0 ) ) AS SAI_BASIP1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIP2, 0 ) ) AS SAI_BASIP2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIP3, 0 ) ) AS SAI_BASIP3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIP4, 0 ) ) AS SAI_BASIP4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIP5, 0 ) ) AS SAI_BASIP5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLRIP1, 0 ) ) AS SAI_VLRIP1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLRIP2, 0 ) ) AS SAI_VLRIP2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLRIP3, 0 ) ) AS SAI_VLRIP3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLRIP4, 0 ) ) AS SAI_VLRIP4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLRIP5, 0 ) ) AS SAI_VLRIP5, ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(IPI_VALAJU) FROM APUIPI WHERE IPI_INDAJU = "0" AND IPI_CODEMP = EMP_CODEMP AND CONCAT(RIGHT(IPI_MESANO, 4), LEFT(IPI_MESANO, 2)) BETWEEN DATE_FORMAT(:DTAINI, "%Y%m") AND DATE_FORMAT(:DTAFIN, "%Y%m")), 0) AS SAI_AJUIPI, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLCON1, 0 ) ) AS ENT_VLCON1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLCON2, 0 ) ) AS ENT_VLCON2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLCON3, 0 ) ) AS ENT_VLCON3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLCON4, 0 ) ) AS ENT_VLCON4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLCON5, 0 ) ) AS ENT_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIP1, 0 ) ) AS ENT_BASIP1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIP2, 0 ) ) AS ENT_BASIP2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIP3, 0 ) ) AS ENT_BASIP3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIP4, 0 ) ) AS ENT_BASIP4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIP5, 0 ) ) AS ENT_BASIP5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIP1, 0 ) ) AS ENT_VLRIP1, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIP2, 0 ) ) AS ENT_VLRIP2, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIP3, 0 ) ) AS ENT_VLRIP3, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIP4, 0 ) ) AS ENT_VLRIP4, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIP5, 0 ) ) AS ENT_VLRIP5, ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(IPI_VALAJU) FROM APUIPI WHERE IPI_INDAJU = "1" AND IPI_CODEMP = EMP_CODEMP AND CONCAT(RIGHT(IPI_MESANO, 4), LEFT(IPI_MESANO, 2)) BETWEEN DATE_FORMAT(:DTAINI, "%Y%m") AND DATE_FORMAT(:DTAFIN, "%Y%m")), 0) AS ENT_AJUIPI, ';

    pRetSqlTotais(strSQL, 'VLCON', '');
    pRetSqlTotais(strSQL, 'BASIP', 'BASIPI');
    pRetSqlTotais(strSQL, 'VLRIP', 'VLRIPI', False);

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS  ';
    strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';
    strSQL := strSQL + ' ) relatorio ';
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;

      Open;

      While Not Eof Do
      Begin
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIpi;

        pMostraResumoIPI(stgGrid);

        Next;
      End;

      Close;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';
        strSQL := strSQL + '  SUM(IPIANT) AS IPIANT, ';
        strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
        strSQL := strSQL + '  SUM(SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5) AS SAI_BASIPI, ';
        strSQL := strSQL + '  SUM(SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI) AS SAI_VLRIPI, ';

        strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
        strSQL := strSQL + '  SUM(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5) AS ENT_BASIPI, ';
        strSQL := strSQL + '  SUM(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) AS ENT_VLRIPI, ';
        strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

        //********************/
        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASIPI) AS VENDAS_PRODUTOSBASIPI, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRIPI) AS VENDAS_PRODUTOSVLRIPI, ';
        // VENDA SERVIÇOS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASIPI) AS VENDAS_SERVICOSBASIPI, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRIPI) AS VENDAS_SERVICOSVLRIPI, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
        strSQL := strSQL + '  SUM(VENDASBASIPI) AS VENDASBASIPI, ';
        strSQL := strSQL + '  SUM(OUTSAIBASIPI) AS OUTSAIBASIPI, ';

        strSQL := strSQL + '  SUM(VENDASVLRIPI) AS VENDASVLRIPI, ';
        strSQL := strSQL + '  SUM(OUTSAIVLRIPI) AS OUTSAIVLRIPI, ';
        strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

        strSQL := strSQL + '  SUM(SAI_AJUIPI) AS AJUSAIVLRIPI, ';

        //********************/
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASIPI) AS COMPRA_PRODUTOSBASIPI, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRIPI) AS COMPRA_PRODUTOSVLRIPI, ';
        // COMPRA SERVIÇOS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASIPI) AS COMPRA_SERVICOSBASIPI, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRIPI) AS COMPRA_SERVICOSVLRIPI, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
        strSQL := strSQL + '  SUM(COMPRABASIPI) AS COMPRABASIPI, ';
        strSQL := strSQL + '  SUM(OUTENTBASIPI) AS OUTENTBASIPI, ';

        strSQL := strSQL + '  SUM(COMPRAVLRIPI) AS COMPRAVLRIPI, ';
        strSQL := strSQL + '  SUM(OUTENTVLRIPI) AS OUTENTVLRIPI, ';

        strSQL := strSQL + '  SUM(ENT_AJUIPI) AS AJUENTVLRIPI, ';

        strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
        strSQL := strSQL + '  SUM((SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5)-(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5)) AS TOT_BASIPI, ';
        strSQL := strSQL + '  SUM((SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI)-(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) - IPIANT) AS TOT_VLRIPI ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ( ';

        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
        strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) AS SAI_VLCON1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) AS SAI_VLCON2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) AS SAI_VLCON3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) AS SAI_VLCON4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIP1, 0 ) ) AS SAI_BASIP1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIP2, 0 ) ) AS SAI_BASIP2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIP3, 0 ) ) AS SAI_BASIP3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIP4, 0 ) ) AS SAI_BASIP4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIP5, 0 ) ) AS SAI_BASIP5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLRIP1, 0 ) ) AS SAI_VLRIP1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLRIP2, 0 ) ) AS SAI_VLRIP2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLRIP3, 0 ) ) AS SAI_VLRIP3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLRIP4, 0 ) ) AS SAI_VLRIP4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLRIP5, 0 ) ) AS SAI_VLRIP5, ';

        strSQL := strSQL + '  IFNULL((SELECT SUM(IPI_VALAJU) FROM APUIPI WHERE IPI_INDAJU = "0" AND IPI_CODEMP = EMP_CODEMP AND CONCAT(RIGHT(IPI_MESANO, 4), LEFT(IPI_MESANO, 2)) BETWEEN DATE_FORMAT(:DTAINI, "%Y%m") AND DATE_FORMAT(:DTAFIN, "%Y%m")), 0) AS SAI_AJUIPI, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLCON1, 0 ) ) AS ENT_VLCON1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLCON2, 0 ) ) AS ENT_VLCON2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLCON3, 0 ) ) AS ENT_VLCON3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLCON4, 0 ) ) AS ENT_VLCON4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLCON5, 0 ) ) AS ENT_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIP1, 0 ) ) AS ENT_BASIP1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIP2, 0 ) ) AS ENT_BASIP2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIP3, 0 ) ) AS ENT_BASIP3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIP4, 0 ) ) AS ENT_BASIP4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIP5, 0 ) ) AS ENT_BASIP5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIP1, 0 ) ) AS ENT_VLRIP1, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIP2, 0 ) ) AS ENT_VLRIP2, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIP3, 0 ) ) AS ENT_VLRIP3, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIP4, 0 ) ) AS ENT_VLRIP4, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIP5, 0 ) ) AS ENT_VLRIP5, ';

        strSQL := strSQL + '  IFNULL((SELECT SUM(IPI_VALAJU) FROM APUIPI WHERE IPI_INDAJU = "1" AND IPI_CODEMP = EMP_CODEMP AND CONCAT(RIGHT(IPI_MESANO, 4), LEFT(IPI_MESANO, 2)) BETWEEN DATE_FORMAT(:DTAINI, "%Y%m") AND DATE_FORMAT(:DTAFIN, "%Y%m")), 0) AS ENT_AJUIPI, ';

        pRetSqlTotais(strSQL, 'VLCON', '');
        pRetSqlTotais(strSQL, 'BASIP', 'BASIPI');
        pRetSqlTotais(strSQL, 'VLRIP', 'VLRIPI', False);

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';
        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;

        Open;

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIpi;

        pMostraResumoIPI(stgGrid);

      End;

      Close;
    End;

    {*******************************************}
    {* RELATÓRIO DE PIS E COFINS               *}
    {****************************************MV*}

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CODEMP, ';
    strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
    strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';

    strSQL := strSQL + '  SUM(SAI_BASPIS) AS SAI_BASPIS, ';
    strSQL := strSQL + '  SUM(SAI_TOTPIS) AS SAI_TOTPIS, ';
    strSQL := strSQL + '  SUM(SAI_BASCOF) AS SAI_BASCOF, ';
    strSQL := strSQL + '  SUM(SAI_TOTCOF) AS SAI_TOTCOF, ';

    strSQL := strSQL + '  SUM(ENT_BASPIS) AS ENT_BASPIS, ';
    strSQL := strSQL + '  SUM(ENT_TOTPIS) AS ENT_TOTPIS, ';
    strSQL := strSQL + '  SUM(ENT_BASCOF) AS ENT_BASCOF, ';
    strSQL := strSQL + '  SUM(ENT_TOTCOF) AS ENT_TOTCOF, ';

    strSQL := strSQL + '  SUM(SAI_BASPIS - ENT_BASPIS) AS TOT_BASPIS, ';
    strSQL := strSQL + '  SUM(SAI_TOTPIS - ENT_TOTPIS) - IFNULL(PISANT,0) AS TOT_TOTPIS, ';
    strSQL := strSQL + '  SUM(SAI_BASCOF - ENT_BASCOF) AS TOT_BASCOF, ';
    strSQL := strSQL + '  SUM(SAI_TOTCOF - ENT_TOTCOF) - IFNULL(COFANT,0) AS TOT_TOTCOF, ';

    strSQL := strSQL + '  SUM(VENDASBASPIS) AS VENDASBASPIS, ';
    strSQL := strSQL + '  SUM(VENDASTOTPIS) AS VENDASTOTPIS, ';
    strSQL := strSQL + '  SUM(VENDASBASCOF) AS VENDASBASCOF, ';
    strSQL := strSQL + '  SUM(VENDASTOTCOF) AS VENDASTOTCOF, ';

    strSQL := strSQL + '  SUM(OUTSAIBASPIS) AS OUTSAIBASPIS, ';
    strSQL := strSQL + '  SUM(OUTSAITOTPIS) AS OUTSAITOTPIS, ';
    strSQL := strSQL + '  SUM(OUTSAIBASCOF) AS OUTSAIBASCOF, ';
    strSQL := strSQL + '  SUM(OUTSAITOTCOF) AS OUTSAITOTCOF, ';

    strSQL := strSQL + '  SUM(COMPRABASPIS) AS COMPRABASPIS, ';
    strSQL := strSQL + '  SUM(COMPRATOTPIS) AS COMPRATOTPIS, ';
    strSQL := strSQL + '  SUM(COMPRABASCOF) AS COMPRABASCOF, ';
    strSQL := strSQL + '  SUM(COMPRATOTCOF) AS COMPRATOTCOF, ';

    strSQL := strSQL + '  SUM(OUTENTBASPIS) AS OUTENTBASPIS, ';
    strSQL := strSQL + '  SUM(OUTENTTOTPIS) AS OUTENTTOTPIS, ';
    strSQL := strSQL + '  SUM(OUTENTBASCOF) AS OUTENTBASCOF, ';
    strSQL := strSQL + '  SUM(OUTENTTOTCOF) AS OUTENTTOTCOF, ';

    // SAIDAS PRODUTOS PIS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASPIS) AS VENDAS_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTPIS) AS VENDAS_PRODUTOSTOTPIS, ';
    // SAIDAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASPIS) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTPIS) AS VENDAS_SERVICOSTOTPIS, ';
    //********************************************************//
    // ENTRADAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASPIS) AS COMPRA_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTPIS) AS COMPRA_PRODUTOSTOTPIS, ';
    // ENTRADAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASPIS) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTPIS) AS COMPRA_SERVICOSTOTPIS, ';
    //********************************************************//

    // SAIDAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASCOF) AS VENDAS_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTCOF) AS VENDAS_PRODUTOSTOTCOF, ';
    // ENTRADAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASCOF) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTCOF) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // SAIDAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASCOF) AS COMPRA_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTCOF) AS COMPRA_PRODUTOSTOTCOF, ';
    // ENTRADAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASCOF) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTCOF) AS COMPRA_SERVICOSTOTCOF ';
    //********************************************************//

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
    strSQL := strSQL + '  CRE_PISANT AS PISANT,  ';
    strSQL := strSQL + '  CRE_COFANT AS COFANT,  ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASPIS, 0 ) ) AS SAI_BASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTPIS, 0 ) ) AS SAI_TOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASCOF, 0 ) ) AS SAI_BASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTCOF, 0 ) ) AS SAI_TOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDASBASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDASTOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDASBASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDASTOTCOF, ';

    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTPIS, 0 ) ) AS OUTSAITOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTCOF, 0 ) ) AS OUTSAITOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASPIS, 0 ) ) AS ENT_BASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTPIS, 0 ) ) AS ENT_TOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASCOF, 0 ) ) AS ENT_BASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTCOF, 0 ) ) AS ENT_TOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRABASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRATOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRABASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRATOTCOF, ';

    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTPIS, 0 ) ) AS OUTENTTOTPIS, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTCOF, 0 ) ) AS OUTENTTOTCOF, ';

    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
    //********************************************************//
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
    //********************************************************//

    if chkIncNFServicos.Checked then
    begin
      // VENDA SERVICOS
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
      //********************************************************//
      // COMPRA SERVICOS
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF ';
    end
    else
    begin
      // VENDA SERVICOS
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
      //********************************************************//
      // COMPRA SERVICOS
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF ';
    end;
    //********************************************************//

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    strSQL := strSQL + ' ) relatorio ';

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;

      Open;

      While Not Eof Do
      Begin

        {**************************************}
        {* PIS                                *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdPis;

        pMostraResumoPIS(stgGrid);

        {**************************************}
        {* COFINS                             *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdCofins;

        pMostraResumoCOF(stgGrid);

        Next;
      End;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';

        strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
        strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';

        strSQL := strSQL + '  SUM(SAI_BASPIS) AS SAI_BASPIS, ';
        strSQL := strSQL + '  SUM(SAI_TOTPIS) AS SAI_TOTPIS, ';
        strSQL := strSQL + '  SUM(SAI_BASCOF) AS SAI_BASCOF, ';
        strSQL := strSQL + '  SUM(SAI_TOTCOF) AS SAI_TOTCOF, ';

        strSQL := strSQL + '  SUM(ENT_BASPIS) AS ENT_BASPIS, ';
        strSQL := strSQL + '  SUM(ENT_TOTPIS) AS ENT_TOTPIS, ';
        strSQL := strSQL + '  SUM(ENT_BASCOF) AS ENT_BASCOF, ';
        strSQL := strSQL + '  SUM(ENT_TOTCOF) AS ENT_TOTCOF, ';

        strSQL := strSQL + '  SUM(SAI_BASPIS - ENT_BASPIS) AS TOT_BASPIS, ';
        strSQL := strSQL + '  SUM(SAI_TOTPIS - ENT_TOTPIS - IFNULL(PISANT,0)) AS TOT_TOTPIS, ';
        strSQL := strSQL + '  SUM(SAI_BASCOF - ENT_BASCOF) AS TOT_BASCOF, ';
        strSQL := strSQL + '  SUM(SAI_TOTCOF - ENT_TOTCOF - IFNULL(COFANT,0)) AS TOT_TOTCOF, ';

        strSQL := strSQL + '  SUM(VENDASBASPIS) AS VENDASBASPIS, ';
        strSQL := strSQL + '  SUM(VENDASTOTPIS) AS VENDASTOTPIS, ';
        strSQL := strSQL + '  SUM(VENDASBASCOF) AS VENDASBASCOF, ';
        strSQL := strSQL + '  SUM(VENDASTOTCOF) AS VENDASTOTCOF, ';

        strSQL := strSQL + '  SUM(OUTSAIBASPIS) AS OUTSAIBASPIS, ';
        strSQL := strSQL + '  SUM(OUTSAITOTPIS) AS OUTSAITOTPIS, ';
        strSQL := strSQL + '  SUM(OUTSAIBASCOF) AS OUTSAIBASCOF, ';
        strSQL := strSQL + '  SUM(OUTSAITOTCOF) AS OUTSAITOTCOF, ';

        strSQL := strSQL + '  SUM(COMPRABASPIS) AS COMPRABASPIS, ';
        strSQL := strSQL + '  SUM(COMPRATOTPIS) AS COMPRATOTPIS, ';
        strSQL := strSQL + '  SUM(COMPRABASCOF) AS COMPRABASCOF, ';
        strSQL := strSQL + '  SUM(COMPRATOTCOF) AS COMPRATOTCOF, ';

        strSQL := strSQL + '  SUM(OUTENTBASPIS) AS OUTENTBASPIS, ';
        strSQL := strSQL + '  SUM(OUTENTTOTPIS) AS OUTENTTOTPIS, ';
        strSQL := strSQL + '  SUM(OUTENTBASCOF) AS OUTENTBASCOF, ';
        strSQL := strSQL + '  SUM(OUTENTTOTCOF) AS OUTENTTOTCOF, ';

        // SAIDAS PRODUTOS PIS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASPIS) AS VENDAS_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTPIS) AS VENDAS_PRODUTOSTOTPIS, ';
        // SAIDAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASPIS) AS VENDAS_SERVICOSBASPIS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTPIS) AS VENDAS_SERVICOSTOTPIS, ';
        //********************************************************//
        // ENTRADAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASPIS) AS COMPRA_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTPIS) AS COMPRA_PRODUTOSTOTPIS, ';
        // ENTRADAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASPIS) AS COMPRA_SERVICOSBASPIS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTPIS) AS COMPRA_SERVICOSTOTPIS, ';
        //********************************************************//

        // SAIDAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASCOF) AS VENDAS_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTCOF) AS VENDAS_PRODUTOSTOTCOF, ';
        // ENTRADAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASCOF) AS VENDAS_SERVICOSBASCOF, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTCOF) AS VENDAS_SERVICOSTOTCOF, ';
        //********************************************************//
        // SAIDAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASCOF) AS COMPRA_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTCOF) AS COMPRA_PRODUTOSTOTCOF, ';
        // ENTRADAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASCOF) AS COMPRA_SERVICOSBASCOF, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTCOF) AS COMPRA_SERVICOSTOTCOF ';
        //********************************************************//

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ( ';

        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
        strSQL := strSQL + '  CRE_PISANT AS PISANT,  ';
        strSQL := strSQL + '  CRE_COFANT AS COFANT,  ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASPIS, 0 ) ) AS SAI_BASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTPIS, 0 ) ) AS SAI_TOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASCOF, 0 ) ) AS SAI_BASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTCOF, 0 ) ) AS SAI_TOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDASBASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDASTOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDASBASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDASTOTCOF, ';

        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTPIS, 0 ) ) AS OUTSAITOTPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTCOF, 0 ) ) AS OUTSAITOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASPIS, 0 ) ) AS ENT_BASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTPIS, 0 ) ) AS ENT_TOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASCOF, 0 ) ) AS ENT_BASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTCOF, 0 ) ) AS ENT_TOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRABASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRATOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRABASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRATOTCOF, ';

        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTPIS, 0 ) ) AS OUTENTTOTPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTCOF, 0 ) ) AS OUTENTTOTCOF, ';

        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
        //********************************************************//
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
        //********************************************************//

        if chkIncNFServicos.Checked then
        begin
          // VENDA SERVICOS
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
          //********************************************************//
          // COMPRA SERVICOS
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF ';
        end
        else
        begin
          // VENDA SERVICOS
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
          //********************************************************//
          // COMPRA SERVICOS
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF ';
        end;
        //********************************************************//

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS  ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';

        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;

        Open;

        {**************************************}
        {* PIS                                *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdPis;

        pMostraResumoPIS(stgGrid);

        {**************************************}
        {* COFINS                             *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdCofins;

        pMostraResumoCOF(stgGrid);
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante o cálculo)]');
    End;
  End;
end;

procedure TfrmRelFiscResumoIcms.pCalcularMarca;
Var
    strSQL, strMar  : String;
    stgGrid : TStringGrid;
begin
  try
    {*******************************************}
    {* RELATÓRIOS DE ICMS/ICMS-ST              *}
    {****************************************MV*}

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CODEMP, ICMANT, IPIANT, PISANT, COFANT, ST_ANT, ';
    strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
    strSQL := strSQL + '  SUM(SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5) AS SAI_BASICM, ';
    strSQL := strSQL + '  SUM(SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5) AS SAI_VLRICM, ';
    strSQL := strSQL + '  SUM(SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5) AS SAI_BAS_ST, ';
    strSQL := strSQL + '  SUM(SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5) AS SAI_VLR_ST, ';

    strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
    strSQL := strSQL + '  SUM(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5) AS ENT_BASICM, ';
    strSQL := strSQL + '  SUM(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) AS ENT_VLRICM, ';
    strSQL := strSQL + '  SUM(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5) AS ENT_BAS_ST, ';
    strSQL := strSQL + '  SUM(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) AS ENT_VLR_ST, ';
    strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

    //********************/
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASICM) AS VENDAS_PRODUTOSBASICM, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRICM) AS VENDAS_PRODUTOSVLRICM, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBAS_ST) AS VENDAS_PRODUTOSBAS_ST, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLR_ST) AS VENDAS_PRODUTOSVLR_ST, ';
    // VENDA SERVIÇOS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASICM) AS VENDAS_SERVICOSBASICM, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRICM) AS VENDAS_SERVICOSVLRICM, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBAS_ST) AS VENDAS_SERVICOSBAS_ST, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLR_ST) AS VENDAS_SERVICOSVLR_ST, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
    strSQL := strSQL + '  SUM(VENDASBASICM) AS VENDASBASICM, ';
    strSQL := strSQL + '  SUM(OUTSAIBASICM) AS OUTSAIBASICM, ';
    strSQL := strSQL + '  SUM(VENDASBAS_ST) AS VENDASBAS_ST, ';
    strSQL := strSQL + '  SUM(OUTSAIBAS_ST) AS OUTSAIBAS_ST, ';

    strSQL := strSQL + '  SUM(VENDASVLRICM) AS VENDASVLRICM, ';
    strSQL := strSQL + '  SUM(OUTSAIVLRICM) AS OUTSAIVLRICM, ';
    strSQL := strSQL + '  SUM(VENDASVLR_ST) AS VENDASVLR_ST, ';
    strSQL := strSQL + '  SUM(OUTSAIVLR_ST) AS OUTSAIVLR_ST, ';
    strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

    //********************/
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASICM) AS COMPRA_PRODUTOSBASICM, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRICM) AS COMPRA_PRODUTOSVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBAS_ST) AS COMPRA_PRODUTOSBAS_ST, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLR_ST) AS COMPRA_PRODUTOSVLR_ST, ';
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASICM) AS COMPRA_SERVICOSBASICM, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRICM) AS COMPRA_SERVICOSVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBAS_ST) AS COMPRA_SERVICOSBAS_ST, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLR_ST) AS COMPRA_SERVICOSVLR_ST, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
    strSQL := strSQL + '  SUM(COMPRABASICM) AS COMPRABASICM, ';
    strSQL := strSQL + '  SUM(OUTENTBASICM) AS OUTENTBASICM, ';
    strSQL := strSQL + '  SUM(COMPRABAS_ST) AS COMPRABAS_ST, ';
    strSQL := strSQL + '  SUM(OUTENTBAS_ST) AS OUTENTBAS_ST, ';

    strSQL := strSQL + '  SUM(COMPRAVLRICM) AS COMPRAVLRICM, ';
    strSQL := strSQL + '  SUM(OUTENTVLRICM) AS OUTENTVLRICM, ';
    strSQL := strSQL + '  SUM(COMPRAVLR_ST) AS COMPRAVLR_ST, ';
    strSQL := strSQL + '  SUM(OUTENTVLR_ST) AS OUTENTVLR_ST, ';

    strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
    strSQL := strSQL + '  SUM((SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5)-(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5)) AS TOT_BASICM, ';
    strSQL := strSQL + '  SUM((SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5)-(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5)) - ICMANT AS TOT_VLRICM, ';
    strSQL := strSQL + '  SUM((SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5)-(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5)) AS TOT_BAS_ST, ';
    strSQL := strSQL + '  SUM((SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5)-(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5)) - ST_ANT AS TOT_VLR_ST ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
    strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
    strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
    strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
    strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) ) AS SAI_VLCON1, ';
    strSQL := strSQL + '  0 AS SAI_VLCON2, ';
    strSQL := strSQL + '  0 AS SAI_VLCON3, ';
    strSQL := strSQL + '  0 AS SAI_VLCON4, ';
    strSQL := strSQL + '  0 AS SAI_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASICM, 0 ) ) AS SAI_BASIC1, ';
    strSQL := strSQL + '  0 AS SAI_BASIC2, ';
    strSQL := strSQL + '  0 AS SAI_BASIC3, ';
    strSQL := strSQL + '  0 AS SAI_BASIC4, ';
    strSQL := strSQL + '  0 AS SAI_BASIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), DET_VALICM, 0 ) ) AS SAI_VLRIC1, ';
    strSQL := strSQL + '  0 AS SAI_VLRIC2, ';
    strSQL := strSQL + '  0 AS SAI_VLRIC3, ';
    strSQL := strSQL + '  0 AS SAI_VLRIC4, ';
    strSQL := strSQL + '  0 AS SAI_VLRIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASRET, 0 ) ) AS SAI_BASST1, ';
    strSQL := strSQL + '  0 AS SAI_BASST2, ';
    strSQL := strSQL + '  0 AS SAI_BASST3, ';
    strSQL := strSQL + '  0 AS SAI_BASST4, ';
    strSQL := strSQL + '  0 AS SAI_BASST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), DET_VALRET, 0 ) ) AS SAI_VLRST1, ';
    strSQL := strSQL + '  0 AS SAI_VLRST2, ';
    strSQL := strSQL + '  0 AS SAI_VLRST3, ';
    strSQL := strSQL + '  0 AS SAI_VLRST4, ';
    strSQL := strSQL + '  0 AS SAI_VLRST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VLRCON, 0 ) ) AS ENT_VLCON1, ';
    strSQL := strSQL + '  0 AS ENT_VLCON2, ';
    strSQL := strSQL + '  0 AS ENT_VLCON3, ';
    strSQL := strSQL + '  0 AS ENT_VLCON4, ';
    strSQL := strSQL + '  0 AS ENT_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASICM, 0 ) ) AS ENT_BASIC1, ';
    strSQL := strSQL + '  0 AS ENT_BASIC2, ';
    strSQL := strSQL + '  0 AS ENT_BASIC3, ';
    strSQL := strSQL + '  0 AS ENT_BASIC4, ';
    strSQL := strSQL + '  0 AS ENT_BASIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALICM, 0 ) ) AS ENT_VLRIC1, ';
    strSQL := strSQL + '  0 AS ENT_VLRIC2, ';
    strSQL := strSQL + '  0 AS ENT_VLRIC3, ';
    strSQL := strSQL + '  0 AS ENT_VLRIC4, ';
    strSQL := strSQL + '  0 AS ENT_VLRIC5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASRET, 0 ) ) AS ENT_BASST1, ';
    strSQL := strSQL + '  0 AS ENT_BASST2, ';
    strSQL := strSQL + '  0 AS ENT_BASST3, ';
    strSQL := strSQL + '  0 AS ENT_BASST4, ';
    strSQL := strSQL + '  0 AS ENT_BASST5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALRET, 0 ) ) AS ENT_VLRST1, ';
    strSQL := strSQL + '  0 AS ENT_VLRST2, ';
    strSQL := strSQL + '  0 AS ENT_VLRST3, ';
    strSQL := strSQL + '  0 AS ENT_VLRST4, ';
    strSQL := strSQL + '  0 AS ENT_VLRST5, ';

    pRetSqlTotaisMarca(strSQL, 'VLRCON', '', True);
    pRetSqlTotaisMarca(strSQL, 'BASICM', 'BASICM', True);
    pRetSqlTotaisMarca(strSQL, 'VALICM', 'VLRICM', True, True);
    pRetSqlTotaisMarca(strSQL, 'BASRET', 'BAS_ST', True);
    pRetSqlTotaisMarca(strSQL, 'VALRET', 'VLR_ST', False, True);

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';

    strSQL := strSQL + '  LEFT JOIN CADEMP ';
    strSQL := strSQL + '   ON EMP_CODEMP = FIS_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

    strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
    strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
    strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
    strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
    strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
    strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa, arrEmpresa, 'FIS_CODEMP', 'CODEMP');

    strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    strSQL := strSQL + ' ) relatorio ';

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
      Open;

      While Not Eof Do
      Begin
        pCarregaValoresOutrasIcms(FieldByName('CODEMP').AsString);
        pCarregaCreditoCat158(FieldByName('CODEMP').AsString);
        pCarregaValoresDifal(FieldByName('CODEMP').AsString);

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIcms;

        pMostraResumoICMS(stgGrid, FieldByName('CODEMP').AsString);

        Next;
      End;

      Close;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';
        strSQL := strSQL + '  SUM(ICMANT) AS ICMANT, ';
        strSQL := strSQL + '  SUM(IPIANT) AS IPIANT, ';
        strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
        strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';
        strSQL := strSQL + '  SUM(ST_ANT) AS ST_ANT, ';
        strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
        strSQL := strSQL + '  SUM(SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5) AS SAI_BASICM, ';
        strSQL := strSQL + '  SUM(SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5) AS SAI_VLRICM, ';
        strSQL := strSQL + '  SUM(SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5) AS SAI_BAS_ST, ';
        strSQL := strSQL + '  SUM(SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5) AS SAI_VLR_ST, ';

        strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
        strSQL := strSQL + '  SUM(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5) AS ENT_BASICM, ';
        strSQL := strSQL + '  SUM(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) AS ENT_VLRICM, ';
        strSQL := strSQL + '  SUM(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5) AS ENT_BAS_ST, ';
        strSQL := strSQL + '  SUM(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) AS ENT_VLR_ST, ';
        strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

        //********************/
        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASICM) AS VENDAS_PRODUTOSBASICM, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRICM) AS VENDAS_PRODUTOSVLRICM, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBAS_ST) AS VENDAS_PRODUTOSBAS_ST, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLR_ST) AS VENDAS_PRODUTOSVLR_ST, ';
        // VENDA SERVIÇOS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASICM) AS VENDAS_SERVICOSBASICM, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRICM) AS VENDAS_SERVICOSVLRICM, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBAS_ST) AS VENDAS_SERVICOSBAS_ST, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLR_ST) AS VENDAS_SERVICOSVLR_ST, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
        strSQL := strSQL + '  SUM(VENDASBASICM) AS VENDASBASICM, ';
        strSQL := strSQL + '  SUM(OUTSAIBASICM) AS OUTSAIBASICM, ';
        strSQL := strSQL + '  SUM(VENDASBAS_ST) AS VENDASBAS_ST, ';
        strSQL := strSQL + '  SUM(OUTSAIBAS_ST) AS OUTSAIBAS_ST, ';

        strSQL := strSQL + '  SUM(VENDASVLRICM) AS VENDASVLRICM, ';
        strSQL := strSQL + '  SUM(OUTSAIVLRICM) AS OUTSAIVLRICM, ';
        strSQL := strSQL + '  SUM(VENDASVLR_ST) AS VENDASVLR_ST, ';
        strSQL := strSQL + '  SUM(OUTSAIVLR_ST) AS OUTSAIVLR_ST, ';
        strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

        //********************/
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASICM) AS COMPRA_PRODUTOSBASICM, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRICM) AS COMPRA_PRODUTOSVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBAS_ST) AS COMPRA_PRODUTOSBAS_ST, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLR_ST) AS COMPRA_PRODUTOSVLR_ST, ';
        // COMPRA SERVIÇOS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASICM) AS COMPRA_SERVICOSBASICM, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRICM) AS COMPRA_SERVICOSVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBAS_ST) AS COMPRA_SERVICOSBAS_ST, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLR_ST) AS COMPRA_SERVICOSVLR_ST, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
        strSQL := strSQL + '  SUM(COMPRABASICM) AS COMPRABASICM, ';
        strSQL := strSQL + '  SUM(OUTENTBASICM) AS OUTENTBASICM, ';
        strSQL := strSQL + '  SUM(COMPRABAS_ST) AS COMPRABAS_ST, ';
        strSQL := strSQL + '  SUM(OUTENTBAS_ST) AS OUTENTBAS_ST, ';

        strSQL := strSQL + '  SUM(COMPRAVLRICM) AS COMPRAVLRICM, ';
        strSQL := strSQL + '  SUM(OUTENTVLRICM) AS OUTENTVLRICM, ';
        strSQL := strSQL + '  SUM(COMPRAVLR_ST) AS COMPRAVLR_ST, ';
        strSQL := strSQL + '  SUM(OUTENTVLR_ST) AS OUTENTVLR_ST, ';

        strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
        strSQL := strSQL + '  SUM((SAI_BASIC1+SAI_BASIC2+SAI_BASIC3+SAI_BASIC4+SAI_BASIC5)-(ENT_BASIC1+ENT_BASIC2+ENT_BASIC3+ENT_BASIC4+ENT_BASIC5)) AS TOT_BASICM, ';
        strSQL := strSQL + '  SUM((SAI_VLRIC1+SAI_VLRIC2+SAI_VLRIC3+SAI_VLRIC4+SAI_VLRIC5)-(ENT_VLRIC1+ENT_VLRIC2+ENT_VLRIC3+ENT_VLRIC4+ENT_VLRIC5) - ICMANT) AS TOT_VLRICM, ';
        strSQL := strSQL + '  SUM((SAI_BASST1+SAI_BASST2+SAI_BASST3+SAI_BASST4+SAI_BASST5)-(ENT_BASST1+ENT_BASST2+ENT_BASST3+ENT_BASST4+ENT_BASST5)) AS TOT_BAS_ST, ';
        strSQL := strSQL + '  SUM((SAI_VLRST1+SAI_VLRST2+SAI_VLRST3+SAI_VLRST4+SAI_VLRST5)-(ENT_VLRST1+ENT_VLRST2+ENT_VLRST3+ENT_VLRST4+ENT_VLRST5) - ST_ANT) AS TOT_VLR_ST ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  (  ';

        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
        strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
        strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
        strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
        strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
        strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) ) AS SAI_VLCON1, ';
        strSQL := strSQL + '  0 AS SAI_VLCON2, ';
        strSQL := strSQL + '  0 AS SAI_VLCON3, ';
        strSQL := strSQL + '  0 AS SAI_VLCON4, ';
        strSQL := strSQL + '  0 AS SAI_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASICM, 0 ) ) AS SAI_BASIC1, ';
        strSQL := strSQL + '  0 AS SAI_BASIC2, ';
        strSQL := strSQL + '  0 AS SAI_BASIC3, ';
        strSQL := strSQL + '  0 AS SAI_BASIC4, ';
        strSQL := strSQL + '  0 AS SAI_BASIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), DET_VALICM, 0 ) ) AS SAI_VLRIC1, ';
        strSQL := strSQL + '  0 AS SAI_VLRIC2, ';
        strSQL := strSQL + '  0 AS SAI_VLRIC3, ';
        strSQL := strSQL + '  0 AS SAI_VLRIC4, ';
        strSQL := strSQL + '  0 AS SAI_VLRIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASRET, 0 ) ) AS SAI_BASST1, ';
        strSQL := strSQL + '  0 AS SAI_BASST2, ';
        strSQL := strSQL + '  0 AS SAI_BASST3, ';
        strSQL := strSQL + '  0 AS SAI_BASST4, ';
        strSQL := strSQL + '  0 AS SAI_BASST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))), DET_VALRET, 0 ) ) AS SAI_VLRST1, ';
        strSQL := strSQL + '  0 AS SAI_VLRST2, ';
        strSQL := strSQL + '  0 AS SAI_VLRST3, ';
        strSQL := strSQL + '  0 AS SAI_VLRST4, ';
        strSQL := strSQL + '  0 AS SAI_VLRST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VLRCON, 0 ) ) AS ENT_VLCON1, ';
        strSQL := strSQL + '  0 AS ENT_VLCON2, ';
        strSQL := strSQL + '  0 AS ENT_VLCON3, ';
        strSQL := strSQL + '  0 AS ENT_VLCON4, ';
        strSQL := strSQL + '  0 AS ENT_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASICM, 0 ) ) AS ENT_BASIC1, ';
        strSQL := strSQL + '  0 AS ENT_BASIC2, ';
        strSQL := strSQL + '  0 AS ENT_BASIC3, ';
        strSQL := strSQL + '  0 AS ENT_BASIC4, ';
        strSQL := strSQL + '  0 AS ENT_BASIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALICM, 0 ) ) AS ENT_VLRIC1, ';
        strSQL := strSQL + '  0 AS ENT_VLRIC2, ';
        strSQL := strSQL + '  0 AS ENT_VLRIC3, ';
        strSQL := strSQL + '  0 AS ENT_VLRIC4, ';
        strSQL := strSQL + '  0 AS ENT_VLRIC5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASRET, 0 ) ) AS ENT_BASST1, ';
        strSQL := strSQL + '  0 AS ENT_BASST2, ';
        strSQL := strSQL + '  0 AS ENT_BASST3, ';
        strSQL := strSQL + '  0 AS ENT_BASST4, ';
        strSQL := strSQL + '  0 AS ENT_BASST5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALRET, 0 ) ) AS ENT_VLRST1, ';
        strSQL := strSQL + '  0 AS ENT_VLRST2, ';
        strSQL := strSQL + '  0 AS ENT_VLRST3, ';
        strSQL := strSQL + '  0 AS ENT_VLRST4, ';
        strSQL := strSQL + '  0 AS ENT_VLRST5, ';

        pRetSqlTotaisMarca(strSQL, 'VLRCON', '', True);
        pRetSqlTotaisMarca(strSQL, 'BASICM', 'BASICM', True);
        pRetSqlTotaisMarca(strSQL, 'VALICM', 'VLRICM', True, True);
        pRetSqlTotaisMarca(strSQL, 'BASRET', 'BAS_ST', True);
        pRetSqlTotaisMarca(strSQL, 'VALRET', 'VLR_ST', False, True);

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                       CRE_MESREF = :MESREF ';

        strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
        strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
        strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
        strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
        strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
        strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

        strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';

        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
        Open;

        pCarregaValoresOutrasIcms(fRetEmpresasSelecionadas);
        pCarregaCreditoCat158(fRetEmpresasSelecionadas);
        pCarregaValoresDifal(fRetEmpresasSelecionadas);

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIcms;

        pMostraResumoICMS(stgGrid, '');
      End;
    End;

    {*******************************************}
    {* RELATÓRIO DE IPI                        *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CODEMP, ';
    strSQL := strSQL + '  IPIANT, ';
    strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
    strSQL := strSQL + '  SUM(SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5) AS SAI_BASIPI, ';
    strSQL := strSQL + '  SUM(SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI) AS SAI_VLRIPI, ';

    strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
    strSQL := strSQL + '  SUM(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5) AS ENT_BASIPI, ';
    strSQL := strSQL + '  SUM(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) AS ENT_VLRIPI, ';
    strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

    //********************/
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASIPI) AS VENDAS_PRODUTOSBASIPI, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRIPI) AS VENDAS_PRODUTOSVLRIPI, ';
    // VENDA SERVIÇOS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASIPI) AS VENDAS_SERVICOSBASIPI, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRIPI) AS VENDAS_SERVICOSVLRIPI, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
    strSQL := strSQL + '  SUM(VENDASBASIPI) AS VENDASBASIPI, ';
    strSQL := strSQL + '  SUM(OUTSAIBASIPI) AS OUTSAIBASIPI, ';

    strSQL := strSQL + '  SUM(VENDASVLRIPI) AS VENDASVLRIPI, ';
    strSQL := strSQL + '  SUM(OUTSAIVLRIPI) AS OUTSAIVLRIPI, ';
    strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

    strSQL := strSQL + '  SUM(SAI_AJUIPI) AS AJUSAIVLRIPI, ';

    //********************/
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASIPI) AS COMPRA_PRODUTOSBASIPI, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRIPI) AS COMPRA_PRODUTOSVLRIPI, ';
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASIPI) AS COMPRA_SERVICOSBASIPI, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRIPI) AS COMPRA_SERVICOSVLRIPI, ';
    //********************/

    strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
    strSQL := strSQL + '  SUM(COMPRABASIPI) AS COMPRABASIPI, ';
    strSQL := strSQL + '  SUM(OUTENTBASIPI) AS OUTENTBASIPI, ';

    strSQL := strSQL + '  SUM(COMPRAVLRIPI) AS COMPRAVLRIPI, ';
    strSQL := strSQL + '  SUM(OUTENTVLRIPI) AS OUTENTVLRIPI, ';

    strSQL := strSQL + '  SUM(ENT_AJUIPI) AS AJUENTVLRIPI, ';

    strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
    strSQL := strSQL + '  SUM((SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5)-(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5)) AS TOT_BASIPI, ';
    strSQL := strSQL + '  SUM((SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI)-(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI)) - IPIANT AS TOT_VLRIPI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
    strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT,  ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) ) AS SAI_VLCON1, ';
    strSQL := strSQL + '  0 AS SAI_VLCON2, ';
    strSQL := strSQL + '  0 AS SAI_VLCON3, ';
    strSQL := strSQL + '  0 AS SAI_VLCON4, ';
    strSQL := strSQL + '  0 AS SAI_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASIPI, 0 ) ) AS SAI_BASIP1, ';
    strSQL := strSQL + '  0 AS SAI_BASIP2, ';
    strSQL := strSQL + '  0 AS SAI_BASIP3, ';
    strSQL := strSQL + '  0 AS SAI_BASIP4, ';
    strSQL := strSQL + '  0 AS SAI_BASIP5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALIPI, 0 ) ) AS SAI_VLRIP1, ';
    strSQL := strSQL + '  0 AS SAI_VLRIP2, ';
    strSQL := strSQL + '  0 AS SAI_VLRIP3, ';
    strSQL := strSQL + '  0 AS SAI_VLRIP4, ';
    strSQL := strSQL + '  0 AS SAI_VLRIP5, ';

    strSQL := strSQL + '  0 AS SAI_AJUIPI, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VLRCON, 0 ) ) AS ENT_VLCON1, ';
    strSQL := strSQL + '  0 AS ENT_VLCON2, ';
    strSQL := strSQL + '  0 AS ENT_VLCON3, ';
    strSQL := strSQL + '  0 AS ENT_VLCON4, ';
    strSQL := strSQL + '  0 AS ENT_VLCON5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASIPI, 0 ) ) AS ENT_BASIP1, ';
    strSQL := strSQL + '  0 AS ENT_BASIP2, ';
    strSQL := strSQL + '  0 AS ENT_BASIP3, ';
    strSQL := strSQL + '  0 AS ENT_BASIP4, ';
    strSQL := strSQL + '  0 AS ENT_BASIP5, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALIPI, 0 ) ) AS ENT_VLRIP1, ';
    strSQL := strSQL + '  0 AS ENT_VLRIP2, ';
    strSQL := strSQL + '  0 AS ENT_VLRIP3, ';
    strSQL := strSQL + '  0 AS ENT_VLRIP4, ';
    strSQL := strSQL + '  0 AS ENT_VLRIP5, ';

    strSQL := strSQL + '  0 AS ENT_AJUIPI, ';

    pRetSqlTotaisMarca(strSQL, 'VLRCON', '');
    pRetSqlTotaisMarca(strSQL, 'BASIPI', 'BASIPI');
    pRetSqlTotaisMarca(strSQL, 'VALIPI', 'VLRIPI', False);

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS  ';
    strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

    strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
    strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
    strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
    strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
    strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
    strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

    strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';
    strSQL := strSQL + ' ) relatorio ';
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
      Open;

      While Not Eof Do
      Begin
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdIpi;

        pMostraResumoIPI(stgGrid);

        Next;
      End;

      Close;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';
        strSQL := strSQL + '  SUM(IPIANT) AS IPIANT, ';
        strSQL := strSQL + '  SUM(SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5) AS SAI_VLCONT, ';
        strSQL := strSQL + '  SUM(SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5) AS SAI_BASIPI, ';
        strSQL := strSQL + '  SUM(SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI) AS SAI_VLRIPI, ';

        strSQL := strSQL + '  SUM(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5) AS ENT_VLCONT, ';
        strSQL := strSQL + '  SUM(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5) AS ENT_BASIPI, ';
        strSQL := strSQL + '  SUM(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) AS ENT_VLRIPI, ';
        strSQL := strSQL + '  SUM(VENDAS) AS VENDAS, ';

        //********************/
        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOS) AS VENDAS_PRODUTOS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASIPI) AS VENDAS_PRODUTOSBASIPI, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSVLRIPI) AS VENDAS_PRODUTOSVLRIPI, ';
        // VENDA SERVIÇOS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOS) AS VENDAS_SERVICOS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASIPI) AS VENDAS_SERVICOSBASIPI, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSVLRIPI) AS VENDAS_SERVICOSVLRIPI, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTSAI) AS OUTSAI, ';
        strSQL := strSQL + '  SUM(VENDASBASIPI) AS VENDASBASIPI, ';
        strSQL := strSQL + '  SUM(OUTSAIBASIPI) AS OUTSAIBASIPI, ';

        strSQL := strSQL + '  SUM(VENDASVLRIPI) AS VENDASVLRIPI, ';
        strSQL := strSQL + '  SUM(OUTSAIVLRIPI) AS OUTSAIVLRIPI, ';
        strSQL := strSQL + '  SUM(COMPRA) AS COMPRA, ';

        strSQL := strSQL + '  SUM(SAI_AJUIPI) AS AJUSAIVLRIPI, ';

        //********************/
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOS) AS COMPRA_PRODUTOS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASIPI) AS COMPRA_PRODUTOSBASIPI, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSVLRIPI) AS COMPRA_PRODUTOSVLRIPI, ';
        // COMPRA SERVIÇOS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOS) AS COMPRA_SERVICOS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASIPI) AS COMPRA_SERVICOSBASIPI, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSVLRIPI) AS COMPRA_SERVICOSVLRIPI, ';
        //********************/

        strSQL := strSQL + '  SUM(OUTENT) AS OUTENT, ';
        strSQL := strSQL + '  SUM(COMPRABASIPI) AS COMPRABASIPI, ';
        strSQL := strSQL + '  SUM(OUTENTBASIPI) AS OUTENTBASIPI, ';

        strSQL := strSQL + '  SUM(COMPRAVLRIPI) AS COMPRAVLRIPI, ';
        strSQL := strSQL + '  SUM(OUTENTVLRIPI) AS OUTENTVLRIPI, ';

        strSQL := strSQL + '  SUM(ENT_AJUIPI) AS AJUENTVLRIPI, ';

        strSQL := strSQL + '  SUM((SAI_VLCON1+SAI_VLCON2+SAI_VLCON3+SAI_VLCON4+SAI_VLCON5)-(ENT_VLCON1+ENT_VLCON2+ENT_VLCON3+ENT_VLCON4+ENT_VLCON5)) AS TOT_VLCONT, ';
        strSQL := strSQL + '  SUM((SAI_BASIP1+SAI_BASIP2+SAI_BASIP3+SAI_BASIP4+SAI_BASIP5)-(ENT_BASIP1+ENT_BASIP2+ENT_BASIP3+ENT_BASIP4+ENT_BASIP5)) AS TOT_BASIPI, ';
        strSQL := strSQL + '  SUM((SAI_VLRIP1+SAI_VLRIP2+SAI_VLRIP3+SAI_VLRIP4+SAI_VLRIP5+SAI_AJUIPI)-(ENT_VLRIP1+ENT_VLRIP2+ENT_VLRIP3+ENT_VLRIP4+ENT_VLRIP5+ENT_AJUIPI) - IPIANT) AS TOT_VLRIPI ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ( ';

        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
        strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) ) AS SAI_VLCON1, ';
        strSQL := strSQL + '  0 AS SAI_VLCON2, ';
        strSQL := strSQL + '  0 AS SAI_VLCON3, ';
        strSQL := strSQL + '  0 AS SAI_VLCON4, ';
        strSQL := strSQL + '  0 AS SAI_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASIPI, 0 ) ) AS SAI_BASIP1, ';
        strSQL := strSQL + '  0 AS SAI_BASIP2, ';
        strSQL := strSQL + '  0 AS SAI_BASIP3, ';
        strSQL := strSQL + '  0 AS SAI_BASIP4, ';
        strSQL := strSQL + '  0 AS SAI_BASIP5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALIPI, 0 ) ) AS SAI_VLRIP1, ';
        strSQL := strSQL + '  0 AS SAI_VLRIP2, ';
        strSQL := strSQL + '  0 AS SAI_VLRIP3, ';
        strSQL := strSQL + '  0 AS SAI_VLRIP4, ';
        strSQL := strSQL + '  0 AS SAI_VLRIP5, ';

        strSQL := strSQL + '  0 AS SAI_AJUIPI, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VLRCON, 0 ) ) AS ENT_VLCON1, ';
        strSQL := strSQL + '  0 AS ENT_VLCON2, ';
        strSQL := strSQL + '  0 AS ENT_VLCON3, ';
        strSQL := strSQL + '  0 AS ENT_VLCON4, ';
        strSQL := strSQL + '  0 AS ENT_VLCON5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASIPI, 0 ) ) AS ENT_BASIP1, ';
        strSQL := strSQL + '  0 AS ENT_BASIP2, ';
        strSQL := strSQL + '  0 AS ENT_BASIP3, ';
        strSQL := strSQL + '  0 AS ENT_BASIP4, ';
        strSQL := strSQL + '  0 AS ENT_BASIP5, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALIPI, 0 ) ) AS ENT_VLRIP1, ';
        strSQL := strSQL + '  0 AS ENT_VLRIP2, ';
        strSQL := strSQL + '  0 AS ENT_VLRIP3, ';
        strSQL := strSQL + '  0 AS ENT_VLRIP4, ';
        strSQL := strSQL + '  0 AS ENT_VLRIP5, ';

        strSQL := strSQL + '  0 AS ENT_AJUIPI, ';

        pRetSqlTotaisMarca(strSQL, 'VLRCON', '');
        pRetSqlTotaisMarca(strSQL, 'BASIPI', 'BASIPI');
        pRetSqlTotaisMarca(strSQL, 'VALIPI', 'VLRIPI', False);

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

        strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
        strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
        strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
        strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
        strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
        strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

        strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';
        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
        Open;

        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdIpi;

        pMostraResumoIPI(stgGrid);
      End;

      Close;
    End;

    {*******************************************}
    {* RELATÓRIO DE PIS E COFINS               *}
    {****************************************MV*}

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CODEMP, ';
    strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
    strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';

    strSQL := strSQL + '  SUM(SAI_BASPIS) AS SAI_BASPIS, ';
    strSQL := strSQL + '  SUM(SAI_TOTPIS) AS SAI_TOTPIS, ';
    strSQL := strSQL + '  SUM(SAI_BASCOF) AS SAI_BASCOF, ';
    strSQL := strSQL + '  SUM(SAI_TOTCOF) AS SAI_TOTCOF, ';

    strSQL := strSQL + '  SUM(ENT_BASPIS) AS ENT_BASPIS, ';
    strSQL := strSQL + '  SUM(ENT_TOTPIS) AS ENT_TOTPIS, ';
    strSQL := strSQL + '  SUM(ENT_BASCOF) AS ENT_BASCOF, ';
    strSQL := strSQL + '  SUM(ENT_TOTCOF) AS ENT_TOTCOF, ';

    strSQL := strSQL + '  SUM(SAI_BASPIS - ENT_BASPIS) AS TOT_BASPIS, ';
    strSQL := strSQL + '  SUM(SAI_TOTPIS - ENT_TOTPIS) - IFNULL(PISANT,0) AS TOT_TOTPIS, ';
    strSQL := strSQL + '  SUM(SAI_BASCOF - ENT_BASCOF) AS TOT_BASCOF, ';
    strSQL := strSQL + '  SUM(SAI_TOTCOF - ENT_TOTCOF) - IFNULL(COFANT,0) AS TOT_TOTCOF, ';

    strSQL := strSQL + '  SUM(VENDASBASPIS) AS VENDASBASPIS, ';
    strSQL := strSQL + '  SUM(VENDASTOTPIS) AS VENDASTOTPIS, ';
    strSQL := strSQL + '  SUM(VENDASBASCOF) AS VENDASBASCOF, ';
    strSQL := strSQL + '  SUM(VENDASTOTCOF) AS VENDASTOTCOF, ';

    strSQL := strSQL + '  SUM(OUTSAIBASPIS) AS OUTSAIBASPIS, ';
    strSQL := strSQL + '  SUM(OUTSAITOTPIS) AS OUTSAITOTPIS, ';
    strSQL := strSQL + '  SUM(OUTSAIBASCOF) AS OUTSAIBASCOF, ';
    strSQL := strSQL + '  SUM(OUTSAITOTCOF) AS OUTSAITOTCOF, ';

    strSQL := strSQL + '  SUM(COMPRABASPIS) AS COMPRABASPIS, ';
    strSQL := strSQL + '  SUM(COMPRATOTPIS) AS COMPRATOTPIS, ';
    strSQL := strSQL + '  SUM(COMPRABASCOF) AS COMPRABASCOF, ';
    strSQL := strSQL + '  SUM(COMPRATOTCOF) AS COMPRATOTCOF, ';

    strSQL := strSQL + '  SUM(OUTENTBASPIS) AS OUTENTBASPIS, ';
    strSQL := strSQL + '  SUM(OUTENTTOTPIS) AS OUTENTTOTPIS, ';
    strSQL := strSQL + '  SUM(OUTENTBASCOF) AS OUTENTBASCOF, ';
    strSQL := strSQL + '  SUM(OUTENTTOTCOF) AS OUTENTTOTCOF, ';

    // SAIDAS PRODUTOS PIS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASPIS) AS VENDAS_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTPIS) AS VENDAS_PRODUTOSTOTPIS, ';
    // SAIDAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASPIS) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTPIS) AS VENDAS_SERVICOSTOTPIS, ';
    //********************************************************//
    // ENTRADAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASPIS) AS COMPRA_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTPIS) AS COMPRA_PRODUTOSTOTPIS, ';
    // ENTRADAS SERVIÇOS PIS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASPIS) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTPIS) AS COMPRA_SERVICOSTOTPIS, ';
    //********************************************************//

    // SAIDAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASCOF) AS VENDAS_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTCOF) AS VENDAS_PRODUTOSTOTCOF, ';
    // ENTRADAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASCOF) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTCOF) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // SAIDAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASCOF) AS COMPRA_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTCOF) AS COMPRA_PRODUTOSTOTCOF, ';
    // ENTRADAS PRODUTOS COFINS
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASCOF) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTCOF) AS COMPRA_SERVICOSTOTCOF ';
    //********************************************************//

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ';

    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
    strSQL := strSQL + '  CRE_PISANT AS PISANT,  ';
    strSQL := strSQL + '  CRE_COFANT AS COFANT,  ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASPIS, 0 ) ) AS SAI_BASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALPIS, 0 ) ) AS SAI_TOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASCOF, 0 ) ) AS SAI_BASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALCOF, 0 ) ) AS SAI_TOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDASBASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDASTOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDASBASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDASTOTCOF, ';

    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALPIS, 0 ) ) AS OUTSAITOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALCOF, 0 ) ) AS OUTSAITOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASPIS, 0 ) ) AS ENT_BASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALPIS, 0 ) ) AS ENT_TOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASCOF, 0 ) ) AS ENT_BASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALCOF, 0 ) ) AS ENT_TOTCOF, ';

    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRABASPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRATOTPIS, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRABASCOF, ';
    strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRATOTCOF, ';

    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALPIS, 0 ) ) AS OUTENTTOTPIS, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
    strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALCOF, 0 ) ) AS OUTENTTOTCOF, ';

    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
    //********************************************************//
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
    //********************************************************//

    if chkIncNFServicos.Checked then
    begin
      // VENDA SERVICOS
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
      //********************************************************//
      // COMPRA SERVICOS
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF ';
    end
    else
    begin
      // VENDA SERVICOS
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
      //********************************************************//
      // COMPRA SERVICOS
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
      strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF ';
    end;
    //********************************************************//

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
    strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

    strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
    strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
    strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
    strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
    strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
    strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

    strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

    If rdgFiltroDatas.ItemIndex = 0 Then
      strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

    If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
      strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

    strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    strSQL := strSQL + ' ) relatorio ';

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '  CODEMP ';

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
      pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
      Open;

      While Not Eof Do
      Begin
        {**************************************}
        {* PIS                                *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdPis;

        pMostraResumoPIS(stgGrid);

        {**************************************}
        {* COFINS                             *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + FieldByName('CODEMP').AsString)).Frame).grdCofins;

        pMostraResumoCOF(stgGrid);

        Next;
      End;

      {***************************************}
      {SE TRAZER TODAS AS LOJAS, ENTÃO, GERA  }
      {UMA ABA COM A TOTALIZAÇÃO DAS LOJAS    }
      {************************************RL*}
      If fEmptyStr(edtEmpresa.Text) Or (edtEmpresa.Text = '000') Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT  ';

        strSQL := strSQL + '  SUM(PISANT) AS PISANT, ';
        strSQL := strSQL + '  SUM(COFANT) AS COFANT, ';

        strSQL := strSQL + '  SUM(SAI_BASPIS) AS SAI_BASPIS, ';
        strSQL := strSQL + '  SUM(SAI_TOTPIS) AS SAI_TOTPIS, ';
        strSQL := strSQL + '  SUM(SAI_BASCOF) AS SAI_BASCOF, ';
        strSQL := strSQL + '  SUM(SAI_TOTCOF) AS SAI_TOTCOF, ';

        strSQL := strSQL + '  SUM(ENT_BASPIS) AS ENT_BASPIS, ';
        strSQL := strSQL + '  SUM(ENT_TOTPIS) AS ENT_TOTPIS, ';
        strSQL := strSQL + '  SUM(ENT_BASCOF) AS ENT_BASCOF, ';
        strSQL := strSQL + '  SUM(ENT_TOTCOF) AS ENT_TOTCOF, ';

        strSQL := strSQL + '  SUM(SAI_BASPIS - ENT_BASPIS) AS TOT_BASPIS, ';
        strSQL := strSQL + '  SUM(SAI_TOTPIS - ENT_TOTPIS - IFNULL(PISANT,0)) AS TOT_TOTPIS, ';
        strSQL := strSQL + '  SUM(SAI_BASCOF - ENT_BASCOF) AS TOT_BASCOF, ';
        strSQL := strSQL + '  SUM(SAI_TOTCOF - ENT_TOTCOF - IFNULL(COFANT,0)) AS TOT_TOTCOF, ';

        strSQL := strSQL + '  SUM(VENDASBASPIS) AS VENDASBASPIS, ';
        strSQL := strSQL + '  SUM(VENDASTOTPIS) AS VENDASTOTPIS, ';
        strSQL := strSQL + '  SUM(VENDASBASCOF) AS VENDASBASCOF, ';
        strSQL := strSQL + '  SUM(VENDASTOTCOF) AS VENDASTOTCOF, ';

        strSQL := strSQL + '  SUM(OUTSAIBASPIS) AS OUTSAIBASPIS, ';
        strSQL := strSQL + '  SUM(OUTSAITOTPIS) AS OUTSAITOTPIS, ';
        strSQL := strSQL + '  SUM(OUTSAIBASCOF) AS OUTSAIBASCOF, ';
        strSQL := strSQL + '  SUM(OUTSAITOTCOF) AS OUTSAITOTCOF, ';

        strSQL := strSQL + '  SUM(COMPRABASPIS) AS COMPRABASPIS, ';
        strSQL := strSQL + '  SUM(COMPRATOTPIS) AS COMPRATOTPIS, ';
        strSQL := strSQL + '  SUM(COMPRABASCOF) AS COMPRABASCOF, ';
        strSQL := strSQL + '  SUM(COMPRATOTCOF) AS COMPRATOTCOF, ';

        strSQL := strSQL + '  SUM(OUTENTBASPIS) AS OUTENTBASPIS, ';
        strSQL := strSQL + '  SUM(OUTENTTOTPIS) AS OUTENTTOTPIS, ';
        strSQL := strSQL + '  SUM(OUTENTBASCOF) AS OUTENTBASCOF, ';
        strSQL := strSQL + '  SUM(OUTENTTOTCOF) AS OUTENTTOTCOF, ';

        // SAIDAS PRODUTOS PIS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASPIS) AS VENDAS_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTPIS) AS VENDAS_PRODUTOSTOTPIS, ';
        // SAIDAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASPIS) AS VENDAS_SERVICOSBASPIS, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTPIS) AS VENDAS_SERVICOSTOTPIS, ';
        //********************************************************//
        // ENTRADAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASPIS) AS COMPRA_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTPIS) AS COMPRA_PRODUTOSTOTPIS, ';
        // ENTRADAS SERVIÇOS PIS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASPIS) AS COMPRA_SERVICOSBASPIS, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTPIS) AS COMPRA_SERVICOSTOTPIS, ';
        //********************************************************//

        // SAIDAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSBASCOF) AS VENDAS_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM(VENDAS_PRODUTOSTOTCOF) AS VENDAS_PRODUTOSTOTCOF, ';
        // ENTRADAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSBASCOF) AS VENDAS_SERVICOSBASCOF, ';
        strSQL := strSQL + '  SUM(VENDAS_SERVICOSTOTCOF) AS VENDAS_SERVICOSTOTCOF, ';
        //********************************************************//
        // SAIDAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSBASCOF) AS COMPRA_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM(COMPRA_PRODUTOSTOTCOF) AS COMPRA_PRODUTOSTOTCOF, ';
        // ENTRADAS PRODUTOS COFINS
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSBASCOF) AS COMPRA_SERVICOSBASCOF, ';
        strSQL := strSQL + '  SUM(COMPRA_SERVICOSTOTCOF) AS COMPRA_SERVICOSTOTCOF ';
        //********************************************************//

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ( ';

        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + '  FIS_CODEMP AS CODEMP,  ';
        strSQL := strSQL + '  CRE_PISANT AS PISANT,  ';
        strSQL := strSQL + '  CRE_COFANT AS COFANT,  ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASPIS, 0 ) ) AS SAI_BASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALPIS, 0 ) ) AS SAI_TOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASCOF, 0 ) ) AS SAI_BASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALCOF, 0 ) ) AS SAI_TOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDASBASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDASTOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDASBASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDASTOTCOF, ';

        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALPIS, 0 ) ) AS OUTSAITOTPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALCOF, 0 ) ) AS OUTSAITOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASPIS, 0 ) ) AS ENT_BASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALPIS, 0 ) ) AS ENT_TOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASCOF, 0 ) ) AS ENT_BASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALCOF, 0 ) ) AS ENT_TOTCOF, ';

        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRABASPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRATOTPIS, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRABASCOF, ';
        strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRATOTCOF, ';

        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALPIS, 0 ) ) AS OUTENTTOTPIS, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
        strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALCOF, 0 ) ) AS OUTENTTOTCOF, ';

        // VENDAS PRODUTOS
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
        //********************************************************//
        // COMPRA PRODUTOS
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
        strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
        //********************************************************//

        if chkIncNFServicos.Checked then
        begin
          // VENDA SERVICOS
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
          //********************************************************//
          // COMPRA SERVICOS
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF ';
        end
        else
        begin
          // VENDA SERVICOS
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
          //********************************************************//
          // COMPRA SERVICOS
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
          strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF ';
        end;
        //********************************************************//

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADFIS  ';
        strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
        strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
        strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

        strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
        strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
        strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
        strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
        strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
        strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

        strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

        strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

        If rdgFiltroDatas.ItemIndex = 0 Then
          strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
        Else
          strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

        If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
          strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

        strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

        strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODEMP ';

        strSQL := strSQL + ' ) relatorio ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRelatorio);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', QryRelatorio);
        Open;

        {**************************************}
        {* PIS                                *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdPis;

        pMostraResumoPIS(stgGrid);

        {**************************************}
        {* COFINS                             *}
        {***********************************AF*}
        stgGrid := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsTotal')).Frame).grdCofins;

        pMostraResumoCOF(stgGrid);
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante o cálculo)]');
    End;
  End;
end;

procedure TfrmRelFiscResumoIcms.pCarregaCreditoCat158(strCodEmp: string);
  var
    dadosCat158: TDadosCreditoCat158;
begin
  fltTotalCredCat158 := 0;

  if blnFiltrouMarca then
    Exit;

  if chkEnviaTotalCredIcmCat158.Checked then
  begin
    dadosCat158 := TDadosCreditoCat158.Create(frmModulo.GetCurrentConnection);
    try
      fltTotalCredCat158 := dadosCat158.fRetCreditoPeriodo(StrToDate(mskDtaIni.Text), strCodEmp);
    finally
      dadosCat158.Free;
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pCarregaDadosAjusteIcmsImpressao(qryRel : TUniQuery);
begin
  with qryRel do
  begin
    FieldByName('VLR_DEBITO_AJUSTE_ICMS').ReadOnly := False;
    FieldByName('VLR_CREDITO_AJUSTE_ICMS').ReadOnly := False;

    First;
    while not Eof do
    begin
      pCarregaValoresOutrasIcms(FieldByName('CODEMP').AsString);

      //carrega analítico
      Edit;
      FieldByName('VLR_DEBITO_AJUSTE_ICMS').AsFloat := fltTotDebSaida;
      FieldByName('VLR_CREDITO_AJUSTE_ICMS').AsFloat := fltTotCredEntrada;
      Post;

      Next;
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pCarregaDadosCat158Impressao(qryRel : TUniQuery);
begin
  with qryRel do
  begin
    FieldByName('VLR_CRED_ICMS_CAT158').ReadOnly := False;

    First;
    while not Eof do
    begin
      pCarregaCreditoCat158(FieldByName('CODEMP').AsString);

      //carrega analítico
      Edit;
      FieldByName('VLR_CRED_ICMS_CAT158').AsFloat := fltTotalCredCat158;
      Post;

      Next;
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pCarregaDadosDifalImpressao(qryRel : TUniQuery);
begin
  with qryRel do
  begin
    FieldByName('VLR_DEBITO_DIFAL').ReadOnly := False;
    FieldByName('VLR_CREDITO_DIFAL').ReadOnly := False;

    First;
    while not Eof do
    begin
      pCarregaValoresDifal(FieldByName('CODEMP').AsString);

      //carrega analítico
      Edit;
      FieldByName('VLR_DEBITO_DIFAL').AsFloat := fltDebDifal;
      FieldByName('VLR_CREDITO_DIFAL').AsFloat := fltCreDifal;
      Post;

      Next;
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pCarregaValoresDifal(strCodEmp: string);
  var
    dadosDifal: TDadosDifal;
begin
  fltDebDifal := 0;
  fltCreDifal := 0;

  if blnFiltrouMarca then
    Exit;

  if chkEnviaCreDebDifal.Checked then
  begin
    dadosDifal := TDadosDifal.Create(frmModulo.GetCurrentConnection);
    try
      fltDebDifal := dadosDifal.fRetDebitoPeriodo(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), arrEmpresa, strCodEmp);
      fltCreDifal := dadosDifal.fRetCreditoPeriodo(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), arrEmpresa, strCodEmp);
    finally
      dadosDifal.Free;
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pCarregaValoresIcmsCupons(strCodEmp: String;
  Var fltValorContabil, fltTotalBaseIcms, fltTotalValorIcms: Double);
  Var
    informacoesEcf: TInformacoesECF;
begin
  fltTotalBaseIcms  := 0;
  fltTotalValorIcms := 0;

  if blnFiltrouMarca then
    Exit;

  informacoesEcf := TInformacoesECF.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  informacoesEcf.pProcessarInformacoes;
  informacoesEcf.pTotaisPorLoja(strCodEmp, fltValorContabil, fltTotalBaseIcms, fltTotalValorIcms);
  FreeAndNil(informacoesEcf);
end;

procedure TfrmRelFiscResumoIcms.pCarregaValoresOutrasIcms(strCodEmp: string);
  var
    apuradorIcms: TApuradorAjustesIcms;
    intIndex: integer;
begin
  fltTotDebSaida := 0;
  fltTotCredEntrada := 0;

  if blnFiltrouMarca then
    Exit;

  apuradorIcms := TApuradorAjustesIcms.Create(frmModulo.GetCurrentConnection);
  try
    for intIndex := 0 to 2 do
    begin
      apuradorIcms.pCarregarAjustes(fRetTipoAjusteIcms(intIndex),
                                    StrToDate(mskDtaIni.Text),
                                    StrToDate(mskDtaFin.Text),
                                    strCodEmp);

      fltTotDebSaida := fltTotDebSaida + apuradorIcms.fRetValorOutrosDebitos + apuradorIcms.fRetValorEstornoCredito;
      fltTotCredEntrada := fltTotCredEntrada + apuradorIcms.fRetValorOutrosCreditos + apuradorIcms.fRetValorEstornoDebito;
    end;
  finally
    apuradorIcms.Free;
  end;
end;

procedure TfrmRelFiscResumoIcms.pImprimir;
Var
  strSQL,
  strSQLValIcmsEcf:    String;
  qryRel : TUniQuery;
  frxReport: TfrxReport;
begin
  {****************************************************}
  {* SELECIONA INFORMAÇÕES PARA A IMPRESSÃO DO RESUMO *}
  {***07/12/2007************************************ER*}

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CONCAT(FIS_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
  strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
  strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
  strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
  strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
  strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

  strSQL := strSQL + '  0.00 AS VLR_DEBITO_AJUSTE_ICMS, ';
  strSQL := strSQL + '  0.00 AS VLR_CREDITO_AJUSTE_ICMS, ';

  strSQL := strSQL + '  0.00 AS VLR_DEBITO_DIFAL, ';
  strSQL := strSQL + '  0.00 AS VLR_CREDITO_DIFAL, ';

  strSQL := strSQL + '  0.00 AS VLR_CRED_ICMS_CAT158, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLCON1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLCON2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLCON3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLCON4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLCON5, 0 ) ) AS SAI_VLCON_IPI, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIC1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIC2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIC3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIC4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIC5, 0 ) ) AS SAI_BASIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_VLRIC1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_VLRIC2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_VLRIC3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_VLRIC4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_VLRIC5, 0 ) ) AS SAI_VLRIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BCRET1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BCRET2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BCRET3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BCRET4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BCRET5, 0 ) ) AS SAI_BCRET, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_RETID1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_RETID2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_RETID3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_RETID4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  FIS_RETID5, 0 ) ) AS SAI_RETID, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASIP1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_BASIP2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_BASIP3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_BASIP4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_BASIP5, 0 ) ) AS SAI_BASIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_VLRIP1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)>= 5,  FIS_VLRIP2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)>= 5,  FIS_VLRIP3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)>= 5,  FIS_VLRIP4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)>= 5,  FIS_VLRIP5, 0 ) ) AS SAI_VLRIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLCON1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLCON2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLCON3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLCON4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLCON5, 0 ) ) AS ENT_VLCON, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIC1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIC2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIC3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIC4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIC5, 0 ) ) AS ENT_BASIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIC1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIC2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIC3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIC4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIC5, 0 ) ) AS ENT_VLRIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BCRET1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BCRET2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BCRET3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BCRET4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BCRET5, 0 ) ) AS ENT_BCRET, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_RETID1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_RETID2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_RETID3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_RETID4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_RETID5, 0 ) ) AS ENT_RETID, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASIP1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_BASIP2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_BASIP3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_BASIP4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_BASIP5, 0 ) ) AS ENT_BASIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_VLRIP1, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC2,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC2,01)< 5,   FIS_VLRIP2, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC3,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC3,01)< 5,   FIS_VLRIP3, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC4,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC4,01)< 5,   FIS_VLRIP4, 0 ) ) + ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC5,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC5,01)< 5,   FIS_VLRIP5, 0 ) ) AS ENT_VLRIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASPIS, 0 ) ) AS SAI_BASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTPIS, 0 ) ) AS SAI_TOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_BASCOF, 0 ) ) AS SAI_BASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  FIS_TOTCOF, 0 ) ) AS SAI_TOTCOF, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASPIS, 0 ) ) AS ENT_BASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTPIS, 0 ) ) AS ENT_TOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_BASCOF, 0 ) ) AS ENT_BASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   FIS_TOTCOF, 0 ) ) AS ENT_TOTCOF, ';

  pRetSqlTotais(strSQL, 'VLCON', '', True);
  pRetSqlTotais(strSQL, 'VLCON', 'IPI', True);

  pRetSqlTotais(strSQL, 'BASIC', 'BASICM', True);
  pRetSqlTotais(strSQL, 'VLRIC', 'VLRICM', True, True);

  pRetSqlTotais(strSQL, 'BASIP', 'BASIPI', True);
  pRetSqlTotais(strSQL, 'VLRIP', 'VLRIPI', True);

  pRetSqlTotais(strSQL, 'BCRET', 'BAS_ST', True);
  pRetSqlTotais(strSQL, 'RETID', 'VLR_ST', True, True);

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDASBASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDASTOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDASBASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDASTOTCOF, ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTPIS, 0 ) ) AS OUTSAITOTPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  FIS_TOTCOF, 0 ) ) AS OUTSAITOTCOF, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRABASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRATOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRABASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRATOTCOF, ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTPIS, 0 ) ) AS OUTENTTOTPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  FIS_TOTCOF, 0 ) ) AS OUTENTTOTCOF, ';

  // VENDAS PRODUTOS
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
  //********************************************************//
  // COMPRA PRODUTOS
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
  //********************************************************//

  if chkIncNFServicos.Checked then
  begin
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  FIS_TOTCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  FIS_TOTCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF, ';
    //********************************************************//
  end
  else
  begin
    // VENDAS SERVIÇOS
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF, ';
    //********************************************************//
  end;

  // TRATAMENTO PARA IMPRESSORA FISCAL

  strSQLValIcmsEcf := strSQLValIcmsEcf + '  (SELECT ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    SUM(IFNULL(TOT_VALIMP, 0)) AS VALIMP ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  FROM ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    RDZTOT ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  JOIN CADRDZ ON RDZ_QTDRDZ = TOT_NUMCRZ AND ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '                 RDZ_CODECF = TOT_CODECF ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  WHERE ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    LOCATE(RDZ_CODECF, (GROUP_CONCAT(DISTINCT ECF_CODECF))) > 0 AND ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ) ';

  strSQL := strSQL + '  ' + strSQLValIcmsEcf + ' AS VALICM_ECF ';

  //********************************************************///

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS  ';
  strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
  strSQL := strSQL + '  LEFT JOIN CADECF ON ECF_NUMSER = REPLACE(FIS_NUMSER, "\0", "") ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

  If rdgFiltroDatas.ItemIndex = 0 Then
    strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
  Else
    strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

  If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
    strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

  strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  CODEMP ';

  qryRel := fCriaQuery;

  try
    Try
      with qryRel do
      begin
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRel);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        Open;

        if not IsEmpty then
        begin
          pCarregaDadosAjusteIcmsImpressao(qryRel);
          pCarregaDadosDifalImpressao(qryRel);
          pCarregaDadosCat158Impressao(qryRel);

          frxRelatorio.DataSet := qryRel;
          frxReport := frxReportJ;

          frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
          frxReport.Script.Variables['NOMREL'] := 'Resumo de Impostos';
          frxReport.Script.Variables['PERIODO'] := 'PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          pPreviewReport(Self.Name, Self.Caption, frxReport);
        end
        else
          fMensagem('Aviso', 'Nenhuma informação foi encontrada', ['&OK']);
      end;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
      End;
    End;
  finally
    begin
      FreeAndNil(qryRel);
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pImprimirMarca;
Var
  strSQL,
  strSQLValIcmsEcf, strMar:    String;
  qryRel : TUniQuery;
  frxReport: TfrxReport;
begin
  {****************************************************}
  {* SELECIONA INFORMAÇÕES PARA A IMPRESSÃO DO RESUMO *}
  {***07/12/2007************************************ER*}

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CONCAT(FIS_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
  strSQL := strSQL + '  IFNULL(CRE_ICMANT, 0.00) AS ICMANT, ';
  strSQL := strSQL + '  IFNULL(CRE_IPIANT, 0.00) AS IPIANT, ';
  strSQL := strSQL + '  IFNULL(CRE_PISANT, 0.00) AS PISANT, ';
  strSQL := strSQL + '  IFNULL(CRE_COFANT, 0.00) AS COFANT, ';
  strSQL := strSQL + '  IFNULL(CRE_ST_ANT, 0.00) AS ST_ANT, ';

  strSQL := strSQL + '  0.00 AS VLR_DEBITO_AJUSTE_ICMS, ';
  strSQL := strSQL + '  0.00 AS VLR_CREDITO_AJUSTE_ICMS, ';

  strSQL := strSQL + '  0.00 AS VLR_DEBITO_DIFAL, ';
  strSQL := strSQL + '  0.00 AS VLR_CREDITO_DIFAL, ';

  strSQL := strSQL + '  0.00 AS VLR_CRED_ICMS_CAT158, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) ) AS SAI_VLCON, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VLRCON, 0 ) )AS SAI_VLCON_IPI, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASICM, 0 ) ) AS SAI_BASIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  DET_VALICM, 0 ) ) AS SAI_VLRIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASRET, 0 ) ) AS SAI_BCRET, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5 AND (NOT (IFNULL(FIS_NUMSER, "") <> "" AND IFNULL(FIS_ACESSO, "") = "" AND FIS_ESPDOC IN ("IF", "IV"))),  DET_VALRET, 0 ) ) AS SAI_RETID, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASIPI, 0 ) ) AS SAI_BASIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALIPI, 0 ) ) AS SAI_VLRIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VLRCON, 0 ) ) AS ENT_VLCON, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASICM, 0 ) ) AS ENT_BASIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALICM, 0 ) ) AS ENT_VLRIC, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASRET, 0 ) ) AS ENT_BCRET, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALRET, 0 ) ) AS ENT_RETID, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASIPI, 0 ) ) AS ENT_BASIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALIPI, 0 ) ) AS ENT_VLRIP, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASPIS, 0 ) ) AS SAI_BASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALPIS, 0 ) ) AS SAI_TOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_BASCOF, 0 ) ) AS SAI_BASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)>= 5,  DET_VALCOF, 0 ) ) AS SAI_TOTCOF, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASPIS, 0 ) ) AS ENT_BASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALPIS, 0 ) ) AS ENT_TOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_BASCOF, 0 ) ) AS ENT_BASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' LEFT(FIS_CLFSC1,01)< 5,   DET_VALCOF, 0 ) ) AS ENT_TOTCOF, ';

  pRetSqlTotaisMarca(strSQL, 'VLRCON', '', True);
  pRetSqlTotaisMarca(strSQL, 'VLRCON', 'IPI', True);

  pRetSqlTotaisMarca(strSQL, 'BASICM', 'BASICM', True);
  pRetSqlTotaisMarca(strSQL, 'VALICM', 'VLRICM', True, True);

  pRetSqlTotaisMarca(strSQL, 'BASIPI', 'BASIPI', True);
  pRetSqlTotaisMarca(strSQL, 'VALIPI', 'VLRIPI', True);

  pRetSqlTotaisMarca(strSQL, 'BASRET', 'BAS_ST', True);
  pRetSqlTotaisMarca(strSQL, 'VALRET', 'VLR_ST', True, True);

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDASBASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDASTOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDASBASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDASTOTCOF, ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASPIS, 0 ) ) AS OUTSAIBASPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALPIS, 0 ) ) AS OUTSAITOTPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_BASCOF, 0 ) ) AS OUTSAIBASCOF, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) = 0),  DET_VALCOF, 0 ) ) AS OUTSAITOTCOF, ';

  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRABASPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRATOTPIS, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRABASCOF, ';
  strSQL := strSQL + '  SUM( IF(' + ( IIF(chkIncNFServicos.Checked,'','(RIGHT(FIS_CLFSC1,03) <> 933) AND') ) + ' (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRATOTCOF, ';

  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASPIS, 0 ) ) AS OUTENTBASPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALPIS, 0 ) ) AS OUTENTTOTPIS, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_BASCOF, 0 ) ) AS OUTENTBASCOF, ';
  strSQL := strSQL + '  SUM( IF( (RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) = 0),  DET_VALCOF, 0 ) ) AS OUTENTTOTCOF, ';

  // VENDAS PRODUTOS
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASPIS, 0 ) ) AS VENDAS_PRODUTOSBASPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALPIS, 0 ) ) AS VENDAS_PRODUTOSTOTPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_BASCOF, 0 ) ) AS VENDAS_PRODUTOSBASCOF, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, :CLAVEN) > 0),  DET_VALCOF, 0 ) ) AS VENDAS_PRODUTOSTOTCOF, ';
  //********************************************************//
  // COMPRA PRODUTOS
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASPIS, 0 ) ) AS COMPRA_PRODUTOSBASPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALPIS, 0 ) ) AS COMPRA_PRODUTOSTOTPIS, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_BASCOF, 0 ) ) AS COMPRA_PRODUTOSBASCOF, ';
  strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) <> 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, :CLACOM) > 0),  DET_VALCOF, 0 ) ) AS COMPRA_PRODUTOSTOTCOF, ';
  //********************************************************//

  if chkIncNFServicos.Checked then
  begin
    // VENDAS PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASPIS, 0 ) ) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALPIS, 0 ) ) AS VENDAS_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_BASCOF, 0 ) ) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)>= 5) AND (LOCATE(FIS_CLFSC1, "5933_6933_") > 0),  DET_VALCOF, 0 ) ) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // COMPRA PRODUTOS
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASPIS, 0 ) ) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALPIS, 0 ) ) AS COMPRA_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_BASCOF, 0 ) ) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM( IF((RIGHT(FIS_CLFSC1,03) = 933) AND (LEFT(FIS_CLFSC1,01)< 5) AND (LOCATE(FIS_CLFSC1, "1933_2933_") > 0),  DET_VALCOF, 0 ) ) AS COMPRA_SERVICOSTOTCOF, ';
    //********************************************************//
  end
  else
  begin
    // VENDAS SERVIÇOS
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(0) AS VENDAS_SERVICOSTOTCOF, ';
    //********************************************************//
    // COMPRA SERVIÇOS
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASPIS, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTPIS, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSBASCOF, ';
    strSQL := strSQL + '  SUM(0) AS COMPRA_SERVICOSTOTCOF, ';
    //********************************************************//
  end;

  // TRATAMENTO PARA IMPRESSORA FISCAL

  strSQLValIcmsEcf := strSQLValIcmsEcf + '  (SELECT ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    SUM(IFNULL(TOT_VALIMP, 0)) AS VALIMP ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  FROM ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    RDZTOT ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  JOIN CADRDZ ON RDZ_QTDRDZ = TOT_NUMCRZ AND ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '                 RDZ_CODECF = TOT_CODECF ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '  WHERE ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    LOCATE(RDZ_CODECF, (GROUP_CONCAT(DISTINCT ECF_CODECF))) > 0 AND ';
  strSQLValIcmsEcf := strSQLValIcmsEcf + '    RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ) ';

  strSQL := strSQL + '  ' + strSQLValIcmsEcf + ' AS VALICM_ECF ';

  //********************************************************///

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS  ';
  strSQL := strSQL + '  INNER JOIN CADEMP ON FIS_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '  LEFT  JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '                      CRE_MESREF = :MESREF ';
  strSQL := strSQL + '  LEFT JOIN CADECF ON ECF_NUMSER = REPLACE(FIS_NUMSER, "\0", "") ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
  strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
  strSQL := strSQL + '                      IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  strSQL := strSQL + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
  strSQL := strSQL + '                      IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI AND ';
  strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';

  strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

  If rdgFiltroDatas.ItemIndex = 0 Then
    strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN '
  Else
    strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';

  If (Not (chkEnviarValorCupomConfirmado.Checked)) Then
    strSQL := strSQL + ' AND FIS_CLFSC1 NOT IN ("5929", "6929") ';

  strSQL := strSQL + fStrLocateEmpresa(edtEmpresa,  arrEmpresa,  'EMP_CODEMP', 'CODEMP');

  strSQL := strSQL + fStrLocate(edtCodMar, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  CODEMP ';

  qryRel := fCriaQuery;

  try
    Try
      with qryRel do
      begin
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;
        pSetaParam(edtEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRel);
        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLACOM').AsString := VS_strClaCom;
        pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', qryRel);
        Open;

        if not IsEmpty then
        begin
          pCarregaDadosAjusteIcmsImpressao(qryRel);
          pCarregaDadosDifalImpressao(qryRel);
          pCarregaDadosCat158Impressao(qryRel);

          frxRelatorio.DataSet := qryRel;
          frxReport := frxReportJ;

          frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
          frxReport.Script.Variables['NOMREL'] := 'Resumo de Impostos';
          frxReport.Script.Variables['PERIODO'] := 'PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          pPreviewReport(Self.Name, Self.Caption, frxReport);
        end
        else
          fMensagem('Aviso', 'Nenhuma informação foi encontrada', ['&OK']);
      end;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
      End;
    End;
  finally
    begin
      FreeAndNil(qryRel);
    end;
  end;
end;

procedure TfrmRelFiscResumoIcms.pMostraResumoIPI(stgGrid: TStringGrid);
Begin
  stgGrid.Cells[1,1] := '';
  stgGrid.Cells[2,1] := '';
  stgGrid.Cells[3,1] := fPadL(FloatToStrF(QryRelatorio.FieldByName('IPIANT').AsFloat,ffNumber,15,2),14);

  // SAIDAS { não utilizar momento }
  {stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASVLRIPI').AsFloat,ffNumber,15,2),14);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSVLRIPI').AsFloat, ffNumber,15,2),14);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSVLRIPI').AsFloat, ffNumber,15,2),14);
  //********************************************************//

  stgGrid.Cells[1,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIVLRIPI').AsFloat,ffNumber,15,2),14);

  stgGrid.Cells[1,5] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[3,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('AJUSAIVLRIPI').AsFloat,ffNumber,15,2), 14);

  stgGrid.Cells[1,6] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,6] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[3,6] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);

  stgGrid.Cells[1,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_BASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLRIPI').AsFloat,ffNumber,15,2),14);

  // ENTRADAS { não utilizar momento }
  {stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRABASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRAVLRIPI').AsFloat,ffNumber,15,2),14);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSVLRIPI').AsFloat, ffNumber,15,2),14);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOS').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSVLRIPI').AsFloat, ffNumber,15,2),14);
  //********************************************************//

  stgGrid.Cells[1,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTBASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTVLRIPI').AsFloat,ffNumber,15,2),14);

  stgGrid.Cells[1,11] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,11] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[3,11] := fPadL(FloatToStrF(QryRelatorio.FieldByName('AJUENTVLRIPI').AsFloat,ffNumber,15,2), 14);

  stgGrid.Cells[1,12] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,12] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[3,12] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);

  stgGrid.Cells[1,13] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[2,13] := fPadL(FloatToStrF(0,ffNumber,15,2), 15);
  stgGrid.Cells[3,13] := fPadL(FloatToStrF(0,ffNumber,15,2), 14);

  stgGrid.Cells[1,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_BASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,14] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_VLRIPI').AsFloat,ffNumber,15,2),14);

  stgGrid.Cells[1,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_VLCONT').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[2,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_BASIPI').AsFloat,ffNumber,15,2),15);
  stgGrid.Cells[3,15] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_VLRIPI').AsFloat -
                                          QryRelatorio.FieldByName('ENT_VLRIPI').AsFloat -
                                          QryRelatorio.FieldByName('IPIANT').AsFloat,ffNumber,15,2),14);
End;

procedure TfrmRelFiscResumoIcms.pMostraResumoPIS(stgGrid: TStringGrid);
Begin
  stgGrid.Cells[1,1] := '';
  stgGrid.Cells[2,1] := fPadL(FloatToStrF(QryRelatorio.FieldByName('PISANT').AsFloat,ffNumber,15,2),21);

  // SAIDAS { não utilizar momento }
  {stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASTOTPIS').AsFloat,ffNumber,15,2),21);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSTOTPIS').AsFloat,ffNumber,15,2),21);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSTOTPIS').AsFloat,ffNumber,15,2),21);
  //********************************************************//

  stgGrid.Cells[1,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAITOTPIS').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_BASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_TOTPIS').AsFloat,ffNumber,15,2),21);

  // ENTRADAS { não utilizar momento }
  {stgGrid.Cells[1,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRABASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRATOTPIS').AsFloat,ffNumber,15,2),21);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,6] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,6] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSTOTPIS').AsFloat,ffNumber,15,2),21);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSTOTPIS').AsFloat,ffNumber,15,2),21);
  //********************************************************//

  stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTBASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTTOTPIS').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_BASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_TOTPIS').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_BASPIS').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_TOTPIS').AsFloat,ffNumber,15,2),21);
End;

procedure TfrmRelFiscResumoIcms.pMostraResumoCOF(stgGrid: TStringGrid);
Begin
  stgGrid.Cells[1,1] := '';
  stgGrid.Cells[2,1] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COFANT').AsFloat,ffNumber,15,2),21);

  // SAIDAS { não utilizar momento }
  {stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDASTOTCOF').AsFloat,ffNumber,15,2),21);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,2] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_PRODUTOSTOTCOF').AsFloat,ffNumber,15,2),21);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,3] := fPadL(FloatToStrF(QryRelatorio.FieldByName('VENDAS_SERVICOSTOTCOF').AsFloat,ffNumber,15,2),21);
  //********************************************************//

  stgGrid.Cells[1,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAIBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,4] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTSAITOTCOF').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_BASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('SAI_TOTCOF').AsFloat,ffNumber,15,2),21);

  // ENTRADAS { não utilizar momento }
  {stgGrid.Cells[1,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRABASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,5] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRATOTCOF').AsFloat,ffNumber,15,2),21);}

  //********************************************************//
  // SAIDAS PRODUTOS
  stgGrid.Cells[1,6] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,6] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_PRODUTOSTOTCOF').AsFloat,ffNumber,15,2),21);
  //********************************************************//
  // SAIDAS SERVIÇOS
  stgGrid.Cells[1,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,7] := fPadL(FloatToStrF(QryRelatorio.FieldByName('COMPRA_SERVICOSTOTCOF').AsFloat,ffNumber,15,2),21);
  //********************************************************//

  stgGrid.Cells[1,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTBASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,8] := fPadL(FloatToStrF(QryRelatorio.FieldByName('OUTENTTOTCOF').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_BASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,9] := fPadL(FloatToStrF(QryRelatorio.FieldByName('ENT_TOTCOF').AsFloat,ffNumber,15,2),21);

  stgGrid.Cells[1,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_BASCOF').AsFloat,ffNumber,15,2),21);
  stgGrid.Cells[2,10] := fPadL(FloatToStrF(QryRelatorio.FieldByName('TOT_TOTCOF').AsFloat,ffNumber,15,2),21);
End;

procedure TfrmRelFiscResumoIcms.btnCalcularClick(Sender: TObject);
begin
  inherited;

  edtCodMarExit(Sender);

  blnFiltrouMarca := (fCfgSis('UFMTRI', varBoolean) and not fEmptyStr(edtCodMar.Text));

  btnGravaSaldo.Enabled := not blnFiltrouMarca;

  fltSomaTodosValoresIcmsIf := 0;

  pVerificaUtilizacaoNFCE;

  pnlInfo.Caption:= 'Aguarde... Gerando Resumo de Impostos';
  Application.ProcessMessages;

  If (fVerificaCampos) Then
  Begin
    If (StrToDate(mskDtaIni.Text) <> StrToDate(mskDtaFin.Text)) Then
    Begin
     If Not fReducoesOk Then
       Exit;
    End;

    {**********************************************}
    {* SE O USUÁRIO NÃO PASSAR PELO CAMPO EMPRESA *}
    {* O FRAME NÃO É CRIADO E DÁ ERRO NO CALCULAR *}
    {***21/01/2008******************************ER*}
    edtEmpresaExit(Self);

    pAjustaLinhas;

    if blnFiltrouMarca then
      pCalcularMarca
    else
      pCalcular;
  End;

  pnlInfo.Caption:= '';
  Application.ProcessMessages;
end;

procedure TfrmRelFiscResumoIcms.btnImprimirClick(Sender: TObject);
begin
  inherited;

  edtCodMarExit(Sender);

  blnFiltrouMarca := (fCfgSis('UFMTRI', varBoolean) and not fEmptyStr(edtCodMar.Text));

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  if blnFiltrouMarca then
    pImprimirMarca
  else
    pImprimir;

  pSetFocus(rdgFiltroDatas);
  pnlInfo.Caption := '';
end;

function TfrmRelFiscResumoIcms.fConsolidarSaldoCredor: Boolean;
var
  strCodEmp: String;
  qryIns: TUniQuery;
  stgGrid_pis,
  stgGrid_cof: TStringGrid;
begin
  If (Not chkConsolidarSaldoCredorEmp.Checked) And (Length(arrEmpresa) = 1) Then
    Exit(False);

  Try
    Application.CreateForm(TfrmSelecionaEmpresa, frmSelecionaEmpresa);
    frmSelecionaEmpresa.blnPermitirMultiSelecao := False;
    frmSelecionaEmpresa.ShowModal;
  Finally
    strCodEmp := Copy(frmSelecionaEmpresa.strCodEmpresa, 0, 3);
    FreeAndNil(frmSelecionaEmpresa);
  End;

  If fEmptyStr(strCodEmp) Then
  Begin
    pMensagemOk('Você deve selecionar uma empresa para consolidar o saldo!');
    Exit(True);
  End;

  Try
    qryIns := fCriaQuery;
    qryIns.SQL.Clear;
    qryIns.SQL.Add('REPLACE INTO CREFIS ( AUTOINCREM, CRE_CODEMP, CRE_MESREF, CRE_PISANT, CRE_COFANT )');
    qryIns.SQL.Add('            VALUES (:AUTOINCREM,:CRE_CODEMP,:CRE_MESREF,:CRE_PISANT,:CRE_COFANT )');

    qryIns.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CREFIS', VS_strCodEmp);
    qryIns.ParamByName('CRE_CODEMP').AsString := strCodEmp;
    qryIns.ParamByName('CRE_MESREF').AsString := FormatDateTime('mmyyyy', StrToDate(mskDtaIni.Text));

    stgGrid_pis  := TfrmFrameICMSIPI(TFrameSheet(pgcPrincipal.Pages[pgcPrincipal.PageCount-1]).Frame).grdPis;
    stgGrid_cof  := TfrmFrameICMSIPI(TFrameSheet(pgcPrincipal.Pages[pgcPrincipal.PageCount-1]).Frame).grdCofins;

    If (fStrToFloat(stgGrid_pis.Cells[2,10]) < 0) Then
      qryIns.ParamByName('CRE_PISANT').AsFloat := Abs(fStrToFloat(stgGrid_pis.Cells[2,10]))
    Else
      qryIns.ParamByName('CRE_PISANT').AsFloat := 0;
    If (fStrToFloat(stgGrid_cof.Cells[2,10]) < 0) Then
      qryIns.ParamByName('CRE_COFANT').AsFloat := Abs(fStrToFloat(stgGrid_cof.Cells[2,10]))
    Else
      qryIns.ParamByName('CRE_COFANT').AsFloat := 0;
    Try
      fStartTransaction;
      qryIns.ExecSQL;
      fCommit;
      fMensagem('Informação', 'Gravação efetuada com sucesso', ['&OK']);
      Result := True;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmRelFiscResumoIcms.pConsolidarSaldoCredor');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmRelFiscResumoIcms.btnGravaSaldoClick(Sender: TObject);
var
  stgGrid_icms: TStringGrid;
  stgGrid_ipi : TStringGrid;
  stgGrid_pis : TStringGrid;
  stgGrid_cof : TStringGrid;
  intContador : Integer;
  qryIcmIPI   : TUniQuery;
begin
  inherited;

  If fConsolidarSaldoCredor Then
    Exit;

  {**************************************}
  {* GRAVA OS VALORES DE SALDO ANTERIOR *}
  {* NA TABELA CADEMP                   *}
  {**22/01/2008**********************ER**}

  qryIcmIPI := fCriaQuery;

  fStartTransaction;

  Try
    If pgcPrincipal.PageCount > 1 Then
    Begin
      For intContador := 0 To pgcPrincipal.PageCount -2 Do
      Begin

        With qryIcmIPI Do
        Begin

          {*******************************************************************}
          {* VERIFICA SE O VALOR DO ICMS É NEGATIVO, CASO FOR NEGATIVO GRAVA *}
          {* NA TABELA CADEMP O VALOR ZERO                                   *}
          {****************************************************************LU*}

          stgGrid_icms := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdIcms;
          stgGrid_ipi  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdIpi;
          stgGrid_pis  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdPis;
          stgGrid_cof  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + RightStr(pgcPrincipal.Pages[intContador].Caption, 3))).Frame).grdCofins;

     		  SQL.Clear;
          SQL.Add(' REPLACE INTO  ');
          SQL.Add('  CREFIS ');
          SQL.Add(' ( ');
          SQL.Add('  AUTOINCREM, ');
          SQL.Add('  CRE_CODEMP, ');
          SQL.Add('  CRE_MESREF, ');
          SQL.Add('  CRE_ICMANT, ');
          SQL.Add('  CRE_IPIANT, ');
          SQL.Add('  CRE_PISANT, ');
          SQL.Add('  CRE_COFANT, ');
          SQL.Add('  CRE_ST_ANT) ');
          SQL.Add(' VALUES ( ');
          SQL.Add('  :AUTINC, ');
          SQL.Add('  :CODEMP, ');
          SQL.Add('  :MESREF, ');
          SQL.Add('  :ICMANT, ');
          SQL.Add('  :IPIANT, ');
          SQL.Add('  :PISANT, ');
          SQL.Add('  :COFANT, ');
          SQL.Add('  :ST_ANT) ');

          ParamByName('AUTINC').AsString := fRetAutoIncrem('CREFIS', VS_strCodEmp);
          ParamByName('CODEMP').AsString := RightStr(pgcPrincipal.Pages[intContador].Caption, 3);
          ParamByName('MESREF').AsString := FormatDateTime('mmyyyy', StrToDate(mskDtaIni.Text));

          If (fStrToFloat(stgGrid_icms.Cells[3,15]{[3,13]}) < 0) Then
            ParamByName('ICMANT').AsFloat := Abs(fStrToFloat(stgGrid_icms.Cells[3,15]{[3,13]}))
          Else
            ParamByName('ICMANT').AsFloat := 0;

          If (fStrToFloat(stgGrid_ipi.Cells[3,15]{[3,13]}) < 0) Then
            ParamByName('IPIANT').AsFloat := Abs(fStrToFloat(stgGrid_ipi.Cells[3,15]{[3,13]}))
          Else
            ParamByName('IPIANT').AsFloat := 0;

          If (fStrToFloat(stgGrid_pis.Cells[2,10]{[2,8]}) < 0) Then
            ParamByName('PISANT').AsFloat := Abs(fStrToFloat(stgGrid_pis.Cells[2,10]{[2,8]}))
          Else
            ParamByName('PISANT').AsFloat := 0;

          If (fStrToFloat(stgGrid_cof.Cells[2,10]{[2,8]}) < 0) Then
            ParamByName('COFANT').AsFloat := Abs(fStrToFloat(stgGrid_cof.Cells[2,10]{[2,8]}))
          Else
            ParamByName('COFANT').AsFloat := 0;

          If (fStrToFloat(stgGrid_icms.Cells[5,15]{[3,13]}) < 0) Then
            ParamByName('ST_ANT').AsFloat := Abs(fStrToFloat(stgGrid_icms.Cells[5,15]{[3,13]}))
          Else
            ParamByName('ST_ANT').AsFloat := 0;

          ExecSQL;

        End;

      End;
    End
    Else
    Begin
      With qryIcmIPI Do
      Begin
        stgGrid_icms := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + edtEmpresa.Text)).Frame).grdIcms;
        stgGrid_ipi  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + edtEmpresa.Text)).Frame).grdIpi;
        stgGrid_pis  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + edtEmpresa.Text)).Frame).grdPis;
        stgGrid_cof  := TfrmFrameICMSIPI(TFrameSheet(fComponentByName(pgcPrincipal, 'tbsEmp' + edtEmpresa.Text)).Frame).grdCofins;

        Sql.Clear;
        SQL.Add(' REPLACE INTO  ');
        SQL.Add('  CREFIS ');
        SQL.Add(' ( ');
        SQL.Add('  AUTOINCREM, ');
        SQL.Add('  CRE_CODEMP, ');
        SQL.Add('  CRE_MESREF, ');
        SQL.Add('  CRE_ICMANT, ');
        SQL.Add('  CRE_IPIANT, ');
        SQL.Add('  CRE_PISANT, ');
        SQL.Add('  CRE_COFANT, ');
        SQL.Add('  CRE_ST_ANT) ');
        SQL.Add(' VALUES ( ');
        SQL.Add('  :AUTINC, ');
        SQL.Add('  :CODEMP, ');
        SQL.Add('  :MESREF, ');
        SQL.Add('  :ICMANT, ');
        SQL.Add('  :IPIANT, ');
        SQL.Add('  :PISANT, ');
        SQL.Add('  :COFANT, ');
        SQL.Add('  :ST_ANT) ');

        ParamByName('AUTINC').AsString := fRetAutoIncrem('CREFIS', VS_strCodEmp);
        ParamByName('CODEMP').AsString := edtEmpresa.Text;
        ParamByName('MESREF').AsString := FormatDateTime('mmyyyy', StrToDate(mskDtaIni.Text));

        If (fStrToFloat(stgGrid_icms.Cells[3,15]{[3,13]})) < 0 then
          ParamByName('ICMANT').AsFloat := Abs(fStrToFloat(stgGrid_icms.Cells[3,15]{[3,13]}))
        Else
          ParamByName('ICMANT').AsFloat := 0;

        If (fStrToFloat(stgGrid_ipi.Cells[3,15]{[3,13]})) < 0 then
          ParamByName('IPIANT').AsFloat := Abs(fStrToFloat(stgGrid_ipi.Cells[3,15]{[3,13]}))
        Else
          ParamByName('IPIANT').AsFloat := 0;

        If (fStrToFloat(stgGrid_pis.Cells[2,10]{[2,8]}) < 0) Then
          ParamByName('PISANT').AsFloat := Abs(fStrToFloat(stgGrid_pis.Cells[2,10]{[2,8]}))
        Else
          ParamByName('PISANT').AsFloat := 0;

        If (fStrToFloat(stgGrid_cof.Cells[2,10]{[2,8]}) < 0) Then
          ParamByName('COFANT').AsFloat := Abs(fStrToFloat(stgGrid_cof.Cells[2,10]{[2,8]}))
        Else
          ParamByName('COFANT').AsFloat := 0;

        If (fStrToFloat(stgGrid_icms.Cells[5,15]{[3,13]})) < 0 then
          ParamByName('ST_ANT').AsFloat := Abs(fStrToFloat(stgGrid_icms.Cells[5,15]{[3,13]}))
        Else
          ParamByName('ST_ANT').AsFloat := 0;

        ExecSQL;
      End;

    End;

    fCommit;

    fMensagem('Informação', 'Gravação efetuada com sucesso', ['&OK']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Gravar Saldo Anterior]');
    End;
  End;

  FreeAndNil(qryIcmIPI);
end;

procedure TfrmRelFiscResumoIcms.rdgFiltroDatasClick(Sender: TObject);
begin
  inherited;
  If rdgFiltroDatas.ItemIndex = 0 Then
  Begin
    lblDesDtaIni.Caption := '(DATA DE ENTRADA)';
    lblDesDtaFin.Caption := '(DATA DE ENTRADA)';
  End
  Else
  Begin
    lblDesDtaIni.Caption := '(DATA DE DOCUMENTO)';
    lblDesDtaFin.Caption := '(DATA DE DOCUMENTO)';
  End;
end;

procedure TfrmRelFiscResumoIcms.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscResumoIcms.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  edtCodMar.MaxLength := fTamCodMar;
  edtCodMar.TamCampo := edtCodMar.MaxLength;

  blnFiltrouMarca := False;
end;

procedure TfrmRelFiscResumoIcms.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    If ActiveControl Is TRadioButton Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmRelFiscResumoIcms.fRetEmpresasSelecionadas: string;
  var
    intIndex: integer;
begin
  Result := '';

  for intIndex := Low(arrEmpresa) to High(arrEmpresa) do
  begin
    Result := Result + arrEmpresa[intIndex].strCodigo + '_';
  end;
end;

function TfrmRelFiscResumoIcms.fRetornaMesRefCreFis: String;
  Var
    dtaIni: TDateTime;
begin
  dtaIni := StrToDateDef(mskDtaIni.Text, 0);
  Result := FormatDateTime('mmyyyy', IncMonth(dtaIni, -1));
end;

function TfrmRelFiscResumoIcms.fRetTipoAjusteIcms(intIndex: integer): string;
begin
  case intIndex of
    0: Result := 'GERAL';
    1: Result := 'DOCUMENTO';
    2: Result := 'PRODUTO';
  end;
end;

end.

