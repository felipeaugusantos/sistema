unit untRelLstPreAlt;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, Mask, MaskEditFocus, RLFilters,
  RLDraftFilter, EditFocus, Buttons, ExtCtrls, DB, QColorLabel, Menus,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, ComObj, StrUtils, Windows, untTypesSistema,
  Uni, AppEvnts, CheckLst, ComCtrls,  UniClientDataSet, untFuncoesFactory,
  BitBtnLockedIncrem, untGeraExcel, untExcel, frxExportCSVTestabilidade,
  untIFuncoes, untClassPanelCx;

type
  TfrmRelLstPreAlt = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    svdExcel: TSaveDialog;
    chkIncNov: TCheckBox;
    chkLisPre: TCheckListBox;
    Label1: TLabel;
    rdgTipRel: TRadioGroup;
    chkListAlt: TCheckListBox;
    Label2: TLabel;
    rdgOpcQuebra: TRadioGroup;
    pgbStatus: TProgressBar;
    chkImpRef: TCheckBox;
    lblDescricao: TLabel;
    lbl1: TLabel;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    Label12: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lbl2: TLabel;
    edtCodDig: TEditFocus;
    edtDesDig: TEditFocus;
    rdgOpcOrd: TRadioGroup;
    chkOriAlt: TCheckBox;
    Label3: TLabel;
    chkImprimir: TCheckListBox;
    shaListAlt: TShape;
    shaImpAlt: TShape;
    grpDadosNE: TGroupBox;
    Label4: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    mskDtaEntIni: TMaskEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    Bevel1: TBevel;
    Label11: TLabel;
    edtLocIni: TEditFocus;
    chkLocFis: TCheckBox;
    Label13: TLabel;
    edtLocFin: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkLisPreClickCheck(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure rdgOpcQuebraClick(Sender: TObject);
    procedure edtDocumentoExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure edtForNotExit(Sender: TObject);
    procedure grpDadosNEEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    qryRelatorio: TUniQuery;
    arrLinhaForne: TConsultasArray;
    arrDigitador : TConsultasArray;

    blnCadLoc: Boolean;

    Function fQtdMarcados(chkList : TCheckListBox): Integer;
    Function fGetMarcado: Integer;

    procedure pMontaWhere(Var strSql: String);
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pImprimeFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: Array Of String);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pCarregaPrecos;
    procedure pAjustaRel;
    procedure pSetaComponente(blnVisible: Boolean; intIndex: Integer);
    procedure pDesmarca4(intMaxMarc: Integer);
    procedure pHabilitaOrdenacao;
    procedure pVerdeVermelho(chkLstAlt: TCheckListBox; shaAltera: TShape; blnLiberado: Boolean);
    function fGeraItensEntrada :  String;
    procedure pCriaQryRelatorio;

    { Private declarations }

  Protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelLstPreAlt: TfrmRelLstPreAlt;

implementation

uses RLReport, untQckLstPreAlt, System.UITypes, untPai;

{$R *.dfm}

procedure TfrmRelLstPreAlt.pVerdeVermelho(chkLstAlt: TCheckListBox; shaAltera: TShape; blnLiberado: Boolean);
Begin
  If (blnLiberado) Then
  Begin
    chkLstAlt.ItemEnabled[0] := True;
    chkLstAlt.ItemEnabled[1] := True;
    chkLstAlt.ItemEnabled[2] := True;
    chkLstAlt.ItemEnabled[3] := True;
    chkLstAlt.Checked[0]     := True;
    chkLstAlt.Checked[1]     := True;
    chkLstAlt.Checked[2]     := True;
    chkLstAlt.Checked[3]     := True;
    shaAltera.Brush.Color    := clGreen;
  End
  Else
  Begin
    chkLstAlt.ItemEnabled[0] := False;
    chkLstAlt.ItemEnabled[1] := False;
    chkLstAlt.ItemEnabled[2] := True;
    chkLstAlt.ItemEnabled[3] := False;
    chkLstAlt.Checked[0]     := False;
    chkLstAlt.Checked[1]     := False;
    chkLstAlt.Checked[2]     := True;
    chkLstAlt.Checked[3]     := False;
    shaAltera.Brush.Color    := clRed;
  End;
End;

procedure TfrmRelLstPreAlt.pCarregaPrecos;
  Var
    intIndex: Integer;
    intMarcados: Integer;
Begin
  intMarcados := 0;
  chkLisPre.Items.Clear;
  For intIndex := 1 To Length(VS_strTabPrc) Do
    if VS_strTabPrc[intIndex] = 'S' Then
    Begin

      chkLisPre.Items.Add('Tabela ' + IntToStr(intIndex));

      If IntMarcados < 3 Then
        chkLisPre.Checked[intMarcados] := True;

      inc(intMarcados);
    End;
End;

procedure TfrmRelLstPreAlt.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  qryRelatorio.SmartFetch.LiveBlock := True;

end;

Function TfrmRelLstPreAlt.fQtdMarcados(chkList : TCheckListBox): Integer;
  Var
    intIndex: Integer;
Begin
  Result := 0;
  For intIndex := 0 To chkList.Count - 1 Do
    If chkList.Checked[intIndex] Then
      Inc(Result);
End;

procedure TfrmRelLstPreAlt.FormShow(Sender: TObject);
begin
  blnCadLoc      := fCfgSis('CADLOC', varBoolean);
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  pCarregaPrecos;

  pVerdeVermelho(chkListAlt, shaListAlt, fVerificaAcessoSistema('LSTPREALT'));
  pVerdeVermelho(chkImprimir, shaImpAlt, fVerificaAcessoSistema('IMPPREALT'));
  
  inherited;

  edtDocumento.TamCampo  := fTamNumDoc();
  edtDocumento.MaxLength := edtDocumento.TamCampo;

  pHabilitaOrdenacao;
  pCriaQryRelatorio;
end;

procedure TfrmRelLstPreAlt.pSetaComponente(blnVisible: Boolean; intIndex: Integer);
Begin
  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBr' + IntToStr(intIndex))).Visible    := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAnt' + IntToStr(intIndex))).Visible      := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAtu' + IntToStr(intIndex))).Visible      := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAnt' + IntToStr(intIndex))).Visible     := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtu' + IntToStr(intIndex))).Visible     := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVe' + IntToStr(intIndex))).Visible    := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAnt' + IntToStr(intIndex))).Visible      := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAtu' + IntToStr(intIndex))).Visible      := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAnt' + IntToStr(intIndex))).Visible     := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtu' + IntToStr(intIndex))).Visible     := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBrFor' + IntToStr(intIndex))).Visible := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAntFor' + IntToStr(intIndex))).Visible   := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllMarAtuFor' + IntToStr(intIndex))).Visible   := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAntFor' + IntToStr(intIndex))).Visible  := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtuFor' + IntToStr(intIndex))).Visible  := blnVisible;

  TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVeFor' + IntToStr(intIndex))).Visible := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAntFor' + IntToStr(intIndex))).Visible   := blnVisible;
  TrlLabel(frmQckLstPreAlt.FindComponent('rllPreAtuFor' + IntToStr(intIndex))).Visible   := blnVisible;

  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAntFor' + IntToStr(intIndex))).Visible  := blnVisible;
  TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtuFor' + IntToStr(intIndex))).Visible  := blnVisible;
End;

procedure TfrmRelLstPreAlt.pAjustaRel;
  Var
    intIndex: Integer;
    intSobrando: Integer;
    strPreco: String;
Begin
  With frmQckLstPreAlt Do
  Begin
    For intIndex := 1 To 3 Do
      pSetaComponente(False, intIndex);

    intSobrando := 3;
    For intIndex := chkLisPre.Count - 1 DownTo 0 Do
      If chkLisPre.Checked[intIndex] Then
      Begin
        strPreco := RightStr(chkLisPre.Items[intIndex], 1);

        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBr' + IntToStr(intSobrando))).Caption := 'MARG. BRUTA' + strPreco;
        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVe' + IntToStr(intSobrando))).Caption := 'PR. VENDA' + strPreco;

        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAnt' + IntToStr(intSobrando))).DataFormula := 'MA' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtu' + IntToStr(intSobrando))).DataFormula := 'MA' + strPreco + 'ATU';

        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAnt' + IntToStr(intSobrando))).DataFormula := 'VE' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtu' + IntToStr(intSobrando))).DataFormula := 'VE' + strPreco + 'ATU';

        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitMarBrFor' + IntToStr(intSobrando))).Caption := 'MARG. BRUTA' + strPreco;
        TrlLabel(frmQckLstPreAlt.FindComponent('rllTitPreVeFor' + IntToStr(intSobrando))).Caption := 'PR. VENDA' + strPreco;

        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAntFor' + IntToStr(intSobrando))).DataFormula := 'MA' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldMarAtuFor' + IntToStr(intSobrando))).DataFormula := 'MA' + strPreco + 'ATU';

        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAntFor' + IntToStr(intSobrando))).DataFormula := 'VE' + strPreco + 'ANT';
        TRldbText(frmQckLstPreAlt.FindComponent('rldPreAtuFor' + IntToStr(intSobrando))).DataFormula := 'VE' + strPreco + 'ATU';

        pSetaComponente(True, intSobrando);

        Dec(intSobrando);
      End;
  End;

  If (rdgTipRel.ItemIndex = 0) Then
  Begin
    If (rdgOpcQuebra.ItemIndex = 0) Then
    Begin
      frmQckLstPreAlt.rlbGrupo.Visible     := True;
      frmQckLstPreAlt.rlbTitulo.Visible    := True;
      frmQckLstPreAlt.rlbGrupoOpe.Visible  := False;
      frmQckLstPreAlt.rlbTituloFor.Visible := False;
    End
    Else
    Begin
      frmQckLstPreAlt.rlbGrupo.Visible     := False;
      frmQckLstPreAlt.rlbTitulo.Visible    := False;
      frmQckLstPreAlt.rlbGrupoOpe.Visible  := True;
      frmQckLstPreAlt.rlbTituloFor.Visible := True;
    End;
  End;

  If intSobrando > 0 Then
  Begin
    frmQckLstPreAlt.rllTitCusto.Left     := frmQckLstPreAlt.rllTitCusto.Left     + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCustoAnt.Left  := frmQckLstPreAlt.rllTitCustoAnt.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCustoAtu.Left  := frmQckLstPreAlt.rllTitCustoAtu.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCusto2.Left    := frmQckLstPreAlt.rllTitCusto2.Left    + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCustoAnt2.Left := frmQckLstPreAlt.rllTitCustoAnt2.Left + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCustoAtu2.Left := frmQckLstPreAlt.rllTitCustoAtu2.Left + (160 * intSobrando);

    frmQckLstPreAlt.rdbCustoAnt.Left     := frmQckLstPreAlt.rdbCustoAnt.Left     + (160 * intSobrando);
    frmQckLstPreAlt.rdbCustoAtu.Left     := frmQckLstPreAlt.rdbCustoAtu.Left     + (160 * intSobrando);
    frmQckLstPreAlt.rdbCustoAnt2.Left    := frmQckLstPreAlt.rdbCustoAnt2.Left    + (160 * intSobrando);
    frmQckLstPreAlt.rdbCustoAtu2.Left    := frmQckLstPreAlt.rdbCustoAtu2.Left    + (160 * intSobrando);
  End;

  // SE NAO VAI IMPRIMIR O CUSTO
  If Not chkImprimir.Checked[0] Then
    Inc(intSobrando);

  If intSobrando > 0 Then
  Begin
    frmQckLstPreAlt.rllTitCompra.Left     := frmQckLstPreAlt.rllTitCompra.Left     + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCompraAnt.Left  := frmQckLstPreAlt.rllTitCompraAnt.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCompraAtu.Left  := frmQckLstPreAlt.rllTitCompraAtu.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCompra2.Left    := frmQckLstPreAlt.rllTitCompra2.Left    + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCompraAnt2.Left := frmQckLstPreAlt.rllTitCompraAnt2.Left + (160 * intSobrando);
    frmQckLstPreAlt.rllTitCompraAtu2.Left := frmQckLstPreAlt.rllTitCompraAtu2.Left + (160 * intSobrando);

    frmQckLstPreAlt.rdbCompraAnt.Left     := frmQckLstPreAlt.rdbCompraAnt.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rdbCompraAtu.Left     := frmQckLstPreAlt.rdbCompraAtu.Left  + (160 * intSobrando);
    frmQckLstPreAlt.rdbCompraAnt2.Left    := frmQckLstPreAlt.rdbCompraAnt2.Left + (160 * intSobrando);
    frmQckLstPreAlt.rdbCompraAtu2.Left    := frmQckLstPreAlt.rdbCompraAtu2.Left + (160 * intSobrando);
  End;

  frmQckLstPreAlt.rllHorAlt.Left   := frmQckLstPreAlt.rllTitCompra.Left  - 39;
  frmQckLstPreAlt.rllCodOpe2.Left  := frmQckLstPreAlt.rllTitCompra2.Left - 29;

  frmQckLstPreAlt.rdbHorAlt.Left   := frmQckLstPreAlt.rllTitCompra.Left  - 39;
  frmQckLstPreAlt.rdbCodOpe2.Left  := frmQckLstPreAlt.rllTitCompra2.Left - 29;

  frmQckLstPreAlt.rllCodOpe.Left   := frmQckLstPreAlt.rllHorAlt.Left    - 24;
  frmQckLstPreAlt.rllDatAlt.Left   := frmQckLstPreAlt.rllCodOpe2.Left   - 46;

  frmQckLstPreAlt.rdbCodOpe.Left   := frmQckLstPreAlt.rllHorAlt.Left    - 24;
  frmQckLstPreAlt.rdbDatAlt.Left   := frmQckLstPreAlt.rllCodOpe2.Left   - 46;

  If (intSobrando > 0) Then
  Begin
    frmQckLstPreAlt.rllDesIte.Width  := frmQckLstPreAlt.rllDesIte.Width  + (160 * intSobrando);
    frmQckLstPreAlt.rllDesIte2.Width := frmQckLstPreAlt.rllDesIte2.Width + (160 * intSobrando);

    frmQckLstPreAlt.rdbDesIte.Width  := frmQckLstPreAlt.rdbDesIte.Width  + (160 * intSobrando);
    frmQckLstPreAlt.rdbDesIte2.Width := frmQckLstPreAlt.rdbDesIte2.Width + (160 * intSobrando);
  End;

End;

function TfrmRelLstPreAlt.fGeraItensEntrada: String;
  Var
    strSQLProd: String;
begin
  {*****************************************************************}
  {* FAZ A CONSULTA EM UM DETERMINADO DOCUMENTO/PERIODO DE ENTRADA *}
  {**************************************************************RN*}

  strSQLProd :=              ' SELECT ';
  strSQLProd := strSQLProd + '  DET_CODITE ';
  strSQLProd := strSQLProd + ' FROM ';
  strSQLProd := strSQLProd + '  MOVDET ';
  strSQLProd := strSQLProd + ' WHERE ';

  If (Not fEmptyStr(edtDocumento.Text)) Then
  Begin
    strSQLProd := strSQLProd + ' DET_NUMDOC = :NUMDOC          ';
    strSQLProd := strSQLProd + ' AND DET_ESPDOC = :ESPDOC      ';
    If Not fEmptyStr(edtForNot.Text) Then
      strSQLProd := strSQLProd + ' AND DET_CODFOR = :FORNOT    ';
    strSQLProd := strSQLProd + ' AND DET_CODEMP = :CODEMP      ';
    If (Not fEmptyStr(edtSerie.Text)) Then
      strSQLProd := strSQLProd + ' AND DET_SERIE_ = :SERDOC    ';
  End
  Else If ((Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text))) Then
  Begin
    strSQLProd := strSQLProd + ' DET_DTAENT BETWEEN :DTAINIENT AND :DTAFINENT ';
    strSQLProd := strSQLProd + ' AND DET_TIP_FC = "F" ';
    strSQLProd := strSQLProd + ' AND (LOCATE(DET_CLAFIS, :CLACOM) > 0) ';
  End;

  Result := strSQLProd;

end;

Function TfrmRelLstPreAlt.fGetMarcado: Integer;
  Var
    intIndex: Integer;
Begin
  Result := 0;
  For intIndex := 0 To chkLisPre.Count - 1 Do
    If chkLisPre.Checked[intIndex] Then
    Begin
      Result := StrToInt(Rightstr(chkLisPre.Items[intIndex],1));
      Exit;
    End;
End;

procedure TfrmRelLstPreAlt.btnImprimirClick(Sender: TObject);
  Var
    strSQL    : String;
    strLinFor : String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
    strSQL := strSQL + '  ALT_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  ALT_CODITE AS CODITE, ';
    strSQL := strSQL + '  ALT_DTAALT AS DTAALT, ';
    strSQL := strSQL + '  ALT_HORALT AS HORALT, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  ALT_CODOPE AS CODOPE, ';
    strSQL := strSQL + '  ALT_COMANT AS COMANT, ';
    strSQL := strSQL + '  ALT_COMATU AS COMATU, ';
    strSQL := strSQL + '  ALT_CUSANT AS CUSANT, ';
    strSQL := strSQL + '  ALT_CUSATU AS CUSATU, ';
    strSQL := strSQL + '  ALT_VE1ANT AS VE1ANT, ';
    strSQL := strSQL + '  ALT_VE1ATU AS VE1ATU, ';
    strSQL := strSQL + '  ALT_MA1ANT AS MA1ANT, ';
    strSQL := strSQL + '  ALT_MA1ATU AS MA1ATU, ';
    strSQL := strSQL + '  ALT_VE2ANT AS VE2ANT, ';
    strSQL := strSQL + '  ALT_VE2ATU AS VE2ATU, ';
    strSQL := strSQL + '  ALT_MA2ANT AS MA2ANT, ';
    strSQL := strSQL + '  ALT_MA2ATU AS MA2ATU, ';
    strSQL := strSQL + '  ALT_VE3ANT AS VE3ANT, ';
    strSQL := strSQL + '  ALT_VE3ATU AS VE3ATU, ';
    strSQL := strSQL + '  ALT_MA3ANT AS MA3ANT, ';
    strSQL := strSQL + '  ALT_MA3ATU AS MA3ATU, ';
    strSQL := strSQL + '  ALT_VE4ANT AS VE4ANT, ';
    strSQL := strSQL + '  ALT_VE4ATU AS VE4ATU, ';
    strSQL := strSQL + '  ALT_MA4ANT AS MA4ANT, ';
    strSQL := strSQL + '  ALT_MA4ATU AS MA4ATU, ';
    strSQL := strSQL + '  ALT_VE5ANT AS VE5ANT, ';
    strSQL := strSQL + '  ALT_VE5ATU AS VE5ATU, ';
    strSQL := strSQL + '  ALT_MA5ANT AS MA5ANT, ';
    strSQL := strSQL + '  ALT_MA5ATU AS MA5ATU, ';
    strSQL := strSQL + '  ALT_VE6ANT AS VE6ANT, ';
    strSQL := strSQL + '  ALT_VE6ATU AS VE6ATU, ';
    strSQL := strSQL + '  ALT_MA6ANT AS MA6ANT, ';
    strSQL := strSQL + '  ALT_MA6ATU AS MA6ATU, ';
    strSQL := strSQL + '  ALT_VE7ANT AS VE7ANT, ';
    strSQL := strSQL + '  ALT_VE7ATU AS VE7ATU, ';
    strSQL := strSQL + '  ALT_MA7ANT AS MA7ANT, ';
    strSQL := strSQL + '  ALT_MA7ATU AS MA7ATU, ';
    strSQL := strSQL + '  ALT_NOMFRM AS NOMFRM, ';
    strSQL := strSQL + '  UNI_DESUNI AS DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  G.ITE_LOCFIS AS LOCFIS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PREALT ';
    strSQL := strSQL + '  JOIN CADITE I ON I.ITE_CODITE = ALT_CODITE ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI   ';
    strSQL := strSQL + '  LEFT JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = ALT_CODEMP ';
    strSQL := strSQL + 'WHERE ';

    If (Not fEmptyStr(edtProdutos.Text)) Then
      strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';

    If (Not fEmptyStr(edtDescri.Text)) Then
      strSQL := strSQL + '  I.ITE_DESITE LIKE :DESITE AND ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  I.ITE_REFERE LIKE :REFERE AND ';

    If (Not fEmptyStr(edtCodDig.Text)) Then
      strSQL := strSQL + '  ALT_CODOPE = :CODOPE AND ';

    strSQL := strSQL + '  ALT_DTAALT BETWEEN :DTAINI AND :DTAFIN ';

    strSql := strSQL + fStrLocate(edtCodFornecedor,arrLinhaForne,'ITE_CODFOR','CODFOR');

    If (Not fEmptyStr(edtDocumento.Text)) Or ((Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text))) Then
      strSQL := strSQL + ' AND I.ITE_CODITE IN ( ' + fGeraItensEntrada + ' )';

    If Not fEmptyStr(edtLocIni.Text) Then
    Begin

      If (Not fEmptyStr(edtLocFin.Text)) Then
        strSQL := strSQL + ' AND LEFT(IFNULL(G.ITE_LOCFIS, ""), LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '

      Else strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") LIKE :LOCINI ';

    End;

    pMontaWhere(strSQL);

    If (chkIncNov.Checked) Then
    Begin

      strSQL := strSQL + 'UNION ALL ';

      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
      strSQL := strSQL + '  I.ITE_DTACAD AS DTAALT, ';
      strSQL := strSQL + '  "00:00:00"   AS HORALT, ';
      strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  ""           AS CODOPE, ';
      strSQL := strSQL + '  0.0000       AS COMANT, ';
      strSQL := strSQL + '  G.ITE_PRECOM AS COMATU, ';
      strSQL := strSQL + '  0.0000       AS CUSANT, ';
      strSQL := strSQL + '  G.ITE_PRECUS AS CUSATU, ';
      strSQL := strSQL + '  0.0000       AS VE1ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE1 AS VE1ATU, ';
      strSQL := strSQL + '  0.0000       AS MA1ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR1 AS MA1ATU, ';
      strSQL := strSQL + '  0.0000       AS VE2ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE2 AS VE2ATU, ';
      strSQL := strSQL + '  0.0000       AS MA2ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR2 AS MA2ATU, ';
      strSQL := strSQL + '  0.0000       AS VE3ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE3 AS VE3ATU, ';
      strSQL := strSQL + '  0.00000      AS MA3ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR3 AS MA3ATU, ';
      strSQL := strSQL + '  0.0000       AS VE4ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE4 AS VE4ATU, ';
      strSQL := strSQL + '  0.00000      AS MA4ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR4 AS MA4ATU, ';
      strSQL := strSQL + '  0.0000       AS VE5ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE5 AS VE5ATU, ';
      strSQL := strSQL + '  0.00000      AS MA5ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR5 AS MA5ATU, ';
      strSQL := strSQL + '  0.0000       AS VE6ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE6 AS VE6ATU, ';
      strSQL := strSQL + '  0.00000      AS MA6ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR6 AS MA6ATU, ';
      strSQL := strSQL + '  0.0000       AS VE7ANT, ';
      strSQL := strSQL + '  G.ITE_PREVE7 AS VE7ATU, ';
      strSQL := strSQL + '  0.00000      AS MA7ANT, ';
      strSQL := strSQL + '  G.ITE_MARBR7 AS MA7ATU, ';
      strSQL := strSQL + '  ""           AS NOMFRM, ';

      strSQL := strSQL + '  UNI_DESUNI   AS DESUNI, ';
      strSQL := strSQL + '  ITE_CODBAR   AS CODBAR, ';
      strSQL := strSQL + '  ITE_REFERE   AS REFERE, ';
      strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
      strSQL := strSQL + '  G.ITE_LOCFIS AS LOCFIS  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE I ';
      strSQL := strSQL + '  JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE  ';
      strSQL := strSQL + '  LEFT JOIN PREALT ON ALT_CODITE = I.ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI   ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  ALT_CODITE IS NULL AND  '; // SOMENTE ITENS QUE NÃO ESTÃO NO PREALT.

      If (Not fEmptyStr(edtProdutos.Text)) Then
        strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';

      If Not fEmptyStr(edtDescri.Text) Then
        strSQL := strSQL + '  I.ITE_DESITE LIKE :DESITE AND ';

      If Not fEmptyStr(edtRefere.Text) Then
        strSQL := strSQL + '  I.ITE_REFERE LIKE :REFERE AND ';

      strSQL := strSQL + '  I.ITE_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

      strSql := strSQL + fStrLocate(edtCodFornecedor,arrLinhaForne,'ITE_CODFOR','CODFOR');

      If Not fEmptyStr(edtLocIni.Text) Then
      Begin

        If (Not fEmptyStr(edtLocFin.Text)) Then
          strSQL := strSQL + ' AND LEFT(IFNULL(G.ITE_LOCFIS, ""), LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '

        Else strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") LIKE :LOCINI ';

      End;

    End;

    strSQL := strSQL + 'ORDER BY ';

    If rdgTipRel.ItemIndex = 0 Then
    Begin
      If (rdgOpcQuebra.ItemIndex = 0) Then
        strSQL := strSQL + ' DTAALT, HORALT, DESITE '
      Else
      Begin
        strSQL := strSQL + ' CODFOR, ';

        If rdgOpcOrd.ItemIndex = 0 Then
          strSQL := strSQL + ' DTAALT, HORALT, DESITE '
        Else
          strSQL := strSQL + ' DESITE '

      End;
    End
    Else
    Begin
      If rdgOpcOrd.ItemIndex = 0 Then
        strSQL := strSQL + ' DTAALT, HORALT, DESITE '
      Else
        strSQL := strSQL + ' DESITE ';
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtProdutos.Text)) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESITE').AsString := edtDescri.Text + '%';

      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';

      If (Not fEmptyStr(edtCodDig.Text)) Then
        ParamByName('CODOPE').AsString := edtCodDig.Text;

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      If (chkIncNov.Checked) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      pSetaParam(edtCodFornecedor.Text,arrLinhaForne,strLinFor,'CODFOR',qryRelatorio);

      If Not fEmptyStr(edtDocumento.Text) Then
      Begin
        ParamByName('NUMDOC').AsString := edtDocumento.Text;
        ParamByName('ESPDOC').AsString := edtEspecie.Text;

        If Not fEmptyStr(edtSerie.Text) Then
          ParamByName('SERDOC').AsString := edtSerie.Text;

        If Not fEmptyStr(edtForNot.Text) Then
          ParamByName('FORNOT').AsString := edtForNot.Text;

        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      End;

      If (Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text)) Then
      Begin
        ParamByName('CLACOM').AsString := VS_strClaCom;
        ParamByName('DTAINIENT').AsDate := StrToDate(mskDtaEntIni.Text);
        ParamByName('DTAFINENT').AsDate := StrToDate(mskDtaEntFin.Text);
      End;

      If Not fEmptyStr(edtLocIni.Text) Then
      Begin

        If (Not fEmptyStr(edtLocFin.Text)) Then
        Begin
          ParamByName('LOCINI').AsString := edtLocIni.Text;
          ParamByName('LOCFIN').AsString := edtLocFin.Text;

          If Length(edtLocIni.Text) > Length(edtLocFin.Text) Then
            ParamByName('MAIOR').AsString := edtLocIni.Text
          Else
            ParamByName('MAIOR').AsString := edtLocFin.Text;

        End
        Else
          ParamByName('LOCINI').AsString := edtLocIni.Text + '%';

      End;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try

        pCriarFormularios(TfrmQckLstPreAlt,frmQckLstPreAlt);

        frmQckLstPreAlt.dtsRelatorio.DataSet:= qryRelatorio;


        frmQckLstPreAlt.blnImpCus := chkImprimir.Checked[0];
        frmQckLstPreAlt.blnImpMar := chkImprimir.Checked[1];
        frmQckLstPreAlt.blnImpVen := chkImprimir.Checked[2];
        frmQckLstPreAlt.blnImpCom := chkImprimir.Checked[3];

        frmQckLstPreAlt.rlbGrupo.Visible          := rdgTipRel.ItemIndex = 0;
        frmQckLstPreAlt.rlbDetalhe.Visible        := rdgTipRel.ItemIndex = 1;
        frmQckLstPreAlt.rlbTitulo.Visible         := rdgTipRel.ItemIndex = 0;
        frmQckLstPreAlt.rlbTituloResumido.Visible := rdgTipRel.ItemIndex = 1;

        frmQckLstPreAlt.rllRefTitulo.Visible := chkImpRef.Checked;
        frmQckLstPreAlt.rllRefTitFor.Visible := chkImpRef.Checked;
        frmQckLstPreAlt.rllRefTitRes.Visible := chkImpRef.Checked;
        frmQckLstPreAlt.rlbRefDetGru.Visible := chkImpRef.Checked;
        frmQckLstPreAlt.rlbRefDetFor.Visible := chkImpRef.Checked;
        frmQckLstPreAlt.rlbRefDet.Visible    := chkImpRef.Checked;

        frmQckLstPreAlt.rllLocFisica.Visible    := chkLocFis.Checked;
        frmQckLstPreAlt.rllLocFisRes.Visible    := chkLocFis.Checked;
        frmQckLstPreAlt.rllLocFisicaFor.Visible := chkLocFis.Checked;

        frmQckLstPreAlt.rllOriTitulo.Visible := chkOriAlt.Checked;
        frmQckLstPreAlt.rllOriTitFor.Visible := chkOriAlt.Checked;
        frmQckLstPreAlt.rllOriTitRes.Visible := chkOriAlt.Checked;
        frmQckLstPreAlt.rdbNomFrm.Visible    := chkOriAlt.Checked;
        frmQckLstPreAlt.rdbNomFrmFor.Visible := chkOriAlt.Checked;
        frmQckLstPreAlt.rdbNomFrmGru.Visible := chkOriAlt.Checked;

        If (chkImpRef.Checked) Or (chkOriAlt.Checked) Or (chkLocFis.Checked) Then
        Begin
          frmQckLstPreAlt.rlbTitulo.Height         := 39;
          frmQckLstPreAlt.rlbTituloFor.Height      := 39;
          frmQckLstPreAlt.rlbTituloResumido.Height := 26;

          frmQckLstPreAlt.rlbDetalhe.Height      := 26;
          frmQckLstPreAlt.rlbDetalheFor.Height   := 26;
          frmQckLstPreAlt.rlbDetalheGrupo.Height := 26;
        End
        Else
        Begin
          frmQckLstPreAlt.rlbTitulo.Height         := 26;
          frmQckLstPreAlt.rlbTituloFor.Height      := 26;
          frmQckLstPreAlt.rlbTituloResumido.Height := 14;

          frmQckLstPreAlt.rlbDetalhe.Height      := 14;
          frmQckLstPreAlt.rlbDetalheFor.Height   := 14;
          frmQckLstPreAlt.rlbDetalheGrupo.Height := 14;
        End;

        If strTipImp = 'M' Then
          frmQckLstPreAlt.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckLstPreAlt.qckPagina.DefaultFilter := Nil;

        frmQckLstPreAlt.intPreUsa := fGetMarcado;

        frmQckLstPreAlt.rllProduto.Caption := 'PRODUTO: ';
        If (fEmptyStr(edtProdutos.Text)) Then
          frmQckLstPreAlt.rllProduto.Caption := frmQckLstPreAlt.rllProduto.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllProduto.Caption := frmQckLstPreAlt.rllProduto.Caption + edtProdutos.Text + '-' +
                                                                                     edtDesProduto.Text;

        frmQckLstPreAlt.rllDescricao.Caption := 'DESCRIÇÃO: ';
        If (fEmptyStr(edtDescri.Text)) Then
          frmQckLstPreAlt.rllDescricao.Caption := frmQckLstPreAlt.rllDescricao.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllDescricao.Caption := frmQckLstPreAlt.rllDescricao.Caption + edtDescri.Text + '%';

        frmQckLstPreAlt.rllRefere.Caption := 'REFERÊNCIA: ';
        If (fEmptyStr(edtRefere.Text)) Then
          frmQckLstPreAlt.rllRefere.Caption := frmQckLstPreAlt.rllRefere.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllRefere.Caption := frmQckLstPreAlt.rllRefere.Caption + edtRefere.Text + '%';

        frmQckLstPreAlt.rllDigitador.Caption := 'DIGITADOR: ';
        If (fEmptyStr(edtCodDig.Text)) Then
          frmQckLstPreAlt.rllDigitador.Caption := frmQckLstPreAlt.rllDigitador.Caption + 'TODOS'
        Else
          frmQckLstPreAlt.rllDigitador.Caption := frmQckLstPreAlt.rllDigitador.Caption + edtCodDig.Text + '-' +
                                                                                         edtDesDig.Text;

        frmQckLstPreAlt.rllOrdem.Caption := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        frmQckLstPreAlt.rllFornecedor.Caption := fStrTitulo(edtCodFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR');

        If Not fEmptyStr(edtLocIni.Text) Then
          frmQckLstPreAlt.rllLocIni.Caption := 'LOC. FISICA INICIAL: ' + edtLocIni.Text
        Else
          frmQckLstPreAlt.rllLocIni.Caption := 'LOC. FISICA INICIAL: TODAS';

        If Not fEmptyStr(edtLocFin.Text) Then
          frmQckLstPreAlt.rllLocFin.Caption := 'LOC. FISICA FINAL: ' + edtLocFin.Text
        Else
          frmQckLstPreAlt.rllLocFin.Caption := 'LOC. FISICA FINAL: TODAS';

        pAjustaRel;

        If edtDestino.Text = 'V' Then
          frmQckLstPreAlt.qckPagina.PreviewModal
        Else If edtDestino.Text = 'I' Then
          frmQckLstPreAlt.qckPagina.Print
        Else If edtDestino.Text = 'E' Then
          pGeraExcel(qryRelatorio);
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckLstPreAlt);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pSetFocus(mskDtaIni);
  pnlInfo.Caption := '';
end;

function TfrmRelLstPreAlt.fValidaCampos(Sender: TWinControl;
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
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
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

    Else If (Sender = edtCodFornecedor) Then
    Begin
      pDesmarcaLista(edtCodFornecedor,arrLinhaForne);
    End

    Else If (Sender = edtDocumento) Then
    Begin
       edtDocumentoExit(Nil)
    End

    Else If Sender = chkLisPre Then
    Begin

      If fQtdMarcados(chkLisPre) = 0 Then
      Begin
        fMensagem('','Selecione uma Tabela de Preço!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If rdgTipRel.ItemIndex = 0 Then
        Begin
          If Pos(edtDestino.Text, 'V_I_E') <= 0 Then
          Begin
            fMensagem('ATENÇÃO','O campo Destino deve ser V, I ou E!',['&O K']);
            Result := False;
          End;
        End
        Else
        Begin
          If Pos(edtDestino.Text, 'V_I') <= 0 Then
          Begin
            fMensagem('ATENÇÃO','O campo Destino deve ser V ou I!',['&O K']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Sender = chkListAlt Then
    Begin

      If fQtdMarcados(chkListAlt) = 0 Then
      Begin
        fMensagem('','Selecione pelo menos um campo para consulta !',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtLocIni) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocIni.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocIni.Text)) Then
          Begin
            pMensagemOk('Localização Física inicial não encontrada!');
            Result := False;
          End

        End;

      End;

      edtLocFin.Enabled := Not fEmptyStr(edtLocIni.Text);

      If Not edtLocFin.Enabled Then
        edtLocFin.Clear;

    End

    Else If (Sender = edtLocFin) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFin.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFin.Text)) Then
          Begin
            pMensagemOk('Localização Física final não encontrada!');
            Result := False;
          End

        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmRelLstPreAlt.grpDadosNEEnter(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDocumento);

end;

procedure TfrmRelLstPreAlt.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Self.SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelLstPreAlt.edtProdutosExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);


  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;
end;

procedure TfrmRelLstPreAlt.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

procedure TfrmRelLstPreAlt.edtDocumentoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDocumento.Text) Then
  Begin
    edtSerie.Clear;
    edtCodEmpresa.Clear;
    edtDesEmpresa.Clear;
    edtForNot.Clear;
    edtDesForNot.Clear;
    edtEspecie.Text       := 'NF';
    lblEspecie.Enabled    := False;
    lblSerie.Enabled      := False;
    lblEmpresa.Enabled    := False;
    edtEspecie.Enabled    := False;
    edtSerie.Enabled      := False;
    edtForNot.Enabled     := False;
    mskDtaEntIni.Enabled  := True;
    mskDtaEntFin.Enabled  := True;
  End
  Else
  Begin
    lblEspecie.Enabled := True;
    lblSerie.Enabled   := True;
    lblEmpresa.Enabled := True;
    edtEspecie.Enabled := True;
    edtSerie.Enabled   := True;
    edtForNot.Enabled  := True;
    edtCodEmpresa.Text := VS_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);
    mskDtaEntIni.Clear;
    mskDtaEntFin.Clear;
    mskDtaEntIni.Enabled := False;
    mskDtaEntFin.Enabled := False;
  End;

end;

procedure TfrmRelLstPreAlt.edtForNotExit(Sender: TObject);
  Var
    arrFornec : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtForNot, edtDesForNot, arrFornec, fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelLstPreAlt.edtForNotKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLstPreAlt.edtLocFinKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFin, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelLstPreAlt.edtLocIniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelLstPreAlt.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelLstPreAlt.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
end;

procedure TfrmRelLstPreAlt.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelLstPreAlt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : Close;
    VK_RETURN : If (ActiveControl Is TComboBox) Or
                   (ActiveControl Is TCheckListBox) Then
                  Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLstPreAlt.pDesmarca4(intMaxMarc: Integer);
  Var
    intIndex: Integer;
    intMarcados: Integer;
Begin
  intMarcados := 0;

  For intIndex := 0 To chkLisPre.Count - 1 Do
  Begin
    If chkLisPre.Checked[intIndex] Then
      inc(intMarcados);

    If intMarcados > intMaxMarc Then
      chkLisPre.Checked[intIndex] := FALSE;
  End;    
End;

procedure TfrmRelLstPreAlt.chkLisPreClickCheck(Sender: TObject);
begin
  inherited;

  If rdgTipRel.ItemIndex = 0 Then
    pDesmarca4(3)
  Else
    pDesmarca4(1);

end;

procedure TfrmRelLstPreAlt.pHabilitaOrdenacao;
Begin
  rdgOpcOrd.Enabled := (rdgTipRel.ItemIndex = 1) Or
                       ((rdgOpcQuebra.ItemIndex = 1) And rdgOpcQuebra.Enabled);

End;

procedure TfrmRelLstPreAlt.rdgOpcQuebraClick(Sender: TObject);
begin
  inherited;

  pHabilitaOrdenacao;
end;

procedure TfrmRelLstPreAlt.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  If rdgTipRel.ItemIndex = 0 Then
  Begin
    pDesmarca4(3);
    rdgOpcQuebra.Enabled := True;

    If (shaImpAlt.Brush.Color = clGreen) Then
    Begin
      chkImprimir.ItemEnabled[0] := True;
      chkImprimir.ItemEnabled[1] := True;
      chkImprimir.Checked[0]     := True;
      chkImprimir.Checked[1]     := True;

    End
    Else
    Begin
      chkImprimir.ItemEnabled[0] := False;
      chkImprimir.ItemEnabled[1] := False;
      chkImprimir.Checked[0]     := False;
      chkImprimir.Checked[1]     := False;
    End;
    chkImprimir.Checked[2]     := True;
    chkImprimir.ItemEnabled[2] := True;

    ColorLabel1.Caption        := '(V)ídeo (I)mpressora (E)xcel';
    ColorLabel1.Width          := 138;

  End
  Else
  Begin
    pDesmarca4(1);
    rdgOpcQuebra.Enabled       := False;
    chkImprimir.Checked[0]     := False;
    chkImprimir.Checked[1]     := False;
    chkImprimir.Checked[2]     := True;
    chkImprimir.ItemEnabled[0] := False;
    chkImprimir.ItemEnabled[1] := False;
    chkImprimir.ItemEnabled[2] := False;
    ColorLabel1.Caption        := '(V)ídeo (I)mpressora';
    ColorLabel1.Width          := 104;
    edtDestino.Text            := 'V';

  End;

  chkImprimir.Refresh;
  pHabilitaOrdenacao;
end;

{****************************************************************************}
{* MONTA A CONDICAO WHERE DE MODO QUE TRAGA REGISTROS ONDE HOUVE ALTERACAO  *}
{* NO CAMPO SELECIONADO SEJA O MESMO REFERENTE A QUALQUER UMA DAS TABELAS   *}
{* DE PRECO SELECIONADAS                                                    *}
{*************************************************************************JC*}
procedure TfrmRelLstPreAlt.pMontaWhere(Var strSql: String);
  Var
    strTabPr: String;
    intIndex: Integer;
begin

  strSql := strSql + '  AND ( ';

  If chkListAlt.Checked[0] Then
  Begin
    strSql := strSql + ' (ALT_CUSANT <> ALT_CUSATU) OR ';
  End;

  If chkListAlt.Checked[3] Then
  Begin
    strSql := strSql + ' (ALT_COMANT <> ALT_COMATU) OR ';
  End;

  If chkListAlt.Checked[1] Then
  Begin
    For intIndex := 0 To chkLisPre.Count - 1 Do
    Begin
      If chkLisPre.Checked[intIndex] Then
      Begin
        strTabPr := RightStr(chkLisPre.Items[IntIndex], 1);
        strSql := strSql + ' (ALT_MA' + strTabPr + 'ANT <> ALT_MA' + strTabPr + 'ATU) OR ';
      End;
    End;
  End;

  If chkListAlt.Checked[2] Then
  Begin
    For intIndex := 0 To chkLisPre.Count - 1 Do
    Begin
      If chkLisPre.Checked[intIndex] Then
      Begin
        strTabPr := RightStr(chkLisPre.Items[IntIndex], 1);
        strSql := strSql + ' (ALT_VE' + strTabPr + 'ANT <> ALT_VE' + strTabPr + 'ATU) OR ';
      End;
    End;
  End;

  If AnsiEndsStr('OR ', strSql) Then
    strSql := Copy(strSql, 0, Length(strSql) - 3);

  strSql := strSql + '  )  ';

end;

procedure TfrmRelLstPreAlt.edtCodDigExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDig, edtDesDig, arrDigitador, fRetNomVendRep, nil, 'do Digitador');
end;

procedure TfrmRelLstPreAlt.edtCodDigKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodDig, edtDesDig, nil, Key, arrSel) Then  
  Begin
    fValidaCampos(edtCodDig, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLstPreAlt.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelLstPreAlt.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLstPreAlt.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFornecedor,edtDesFornecedor,
                    arrLinhaForne,fRetNomFornecedor,nil,'do Fornecedor');
  
end;

procedure TfrmRelLstPreAlt.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrLinhaForne, False) Then
  Begin
    fValidaCampos(edtCodFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLstPreAlt.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel:  TGeraExcel;
    cdsDados:      TUniClientDataSet;
    arrProduto:    TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrDigitador:  TConsultasArray;
    strLinPro:     String;
    strLinFor:     String;
    strLinDig:     String;
    strArqPDF:     String;

begin
  {***************************}
  {* OPÇÃO IMPRESSÃO EXCEL   *}
  {** 28/02/2012 **********CI*}

  cdsDados     := fCriaClientDatset(qryDados);
  objGeraExcel := TGeraExcel.Create(cdsDados, pgbStatus);

  With objGeraExcel Do
  Begin

    strNomRel :=  'LISTA DE PREÇOS ALTERADOS';

    Case rdgOpcQuebra.ItemIndex Of
      0: AddQuebra('DTAALT','', False);
      1: AddQuebra('CODFOR', '', False);
    End;

    AddFiltro('REFERENTE AO PERIODO DE ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text))) ;
    AddFiltro(Ifthen(fEmptyStr(edtProdutos.Text), 'PRODUTOS: TODOS'  , fStrTitulo(edtProdutos.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO')));
    AddFiltro(Ifthen(fEmptyStr(edtDescri.Text), 'DESCRICAO: TODAS'  , edtDescri.Text));
    AddFiltro(fStrTitulo(edtCodFornecedor.Text, edtDesFornecedor, arrFornecedor, strLinFor, 'FORNECEDOR'));
    AddFiltro(Ifthen(fEmptyStr(edtRefere.Text), 'REFERENCIA: TODAS'  , edtRefere.Text));
    AddFiltro(Ifthen(fEmptyStr(edtCodDig.Text), 'DIGITADOR: TODOS'  , fStrTitulo(edtCodDig.Text,edtDesDig,arrDigitador,strLinDig,'DIGITADOR')));

    AddFiltro('LOC. FÍSICA INICIAL: ' + Ifthen(Not fEmptyStr(edtLocIni.Text), edtLocIni.Text,'TODAS'));
    AddFiltro('LOC. FÍSICA FINAL  : ' + Ifthen(Not fEmptyStr(edtLocFin.Text), edtLocFin.Text,'TODAS'));

    AddCampo('CODITE', 'COD.');
    AddCampo('DESITE', 'DESCRICAO DO PRODUTO');
    AddCampo('REFERE', 'REFERENCIA');
    AddCampo('LOCFIS', 'LOCALIZACAO FISICA');
    AddCampo('NOMFRM', 'ORIGEM DA ALTERACAO DE PRECO');

    If (rdgOpcQuebra.ItemIndex = 0) Then
    Begin
      AddCampo('CODOPE', 'OPE');
      AddCampo('HORALT', 'HORA');
    End
    Else
    Begin
      AddCampo('DTAALT', 'DATA');
      AddCampo('CODOPE', 'OPE');
    End;

    If (chkImprimir.Checked[3]) Then
    Begin
      // Imprime preço de custo
      AddCampo('COMANT', '  ANTER. ');
      AddCampo('COMATU', '  ATUAL  ');
    End;

    If (chkImprimir.Checked[0]) Then
    Begin
      // Imprime preço de custo
      AddCampo('CUSANT', '  ANTER. ');
      AddCampo('CUSATU', '  ATUAL  ');
    End;

    If (chkImprimir.Checked[1]) And
       (chkImprimir.Checked[2]) Then
    Begin
      {**************************************}
      {* IMPRIME MARGEM E PREÇO DE VENDA    *}
      {** 28/02/2012 *********************CI*}

      AddCampo('MA1ANT', '  ANTER. ');
      AddCampo('MA1ATU', '  ATUAL  ');
      AddCampo('VE1ANT', '  ANTER. ');
      AddCampo('VE1ATU', '  ATUAL  ');
      AddCampo('MA2ANT', '  ANTER. ');
      AddCampo('MA2ATU', '  ATUAL  ');
      AddCampo('VE2ANT', '  ANTER. ');
      AddCampo('VE2ATU', '  ATUAL  ');
      AddCampo('MA3ANT', '  ANTER. ');
      AddCampo('MA3ATU', '  ATUAL  ');
      AddCampo('VE3ANT', '  ANTER. ');
      AddCampo('VE3ATU', '  ATUAL  ');
      AddCampo('MA4ANT', '  ANTER. ');
      AddCampo('MA4ATU', '  ATUAL  ');
      AddCampo('VE4ANT', '  ANTER. ');
      AddCampo('VE4ATU', '  ATUAL  ');
      AddCampo('MA5ANT', '  ANTER. ');
      AddCampo('MA5ATU', '  ATUAL  ');
      AddCampo('VE5ANT', '  ANTER. ');
      AddCampo('VE5ATU', '  ATUAL  ');
      AddCampo('MA6ANT', '  ANTER. ');
      AddCampo('MA6ATU', '  ATUAL  ');
      AddCampo('VE6ANT', '  ANTER. ');
      AddCampo('VE6ATU', '  ATUAL  ');
      AddCampo('MA7ANT', '  ANTER. ');
      AddCampo('MA7ATU', '  ATUAL  ');
      AddCampo('VE7ANT', '  ANTER. ');
      AddCampo('VE7ATU', '  ATUAL  ');

    End
    Else If (chkImprimir.Checked[1]) Then
    Begin
      {****************************}
      {* IMPRIME APENAS MARGEM    *}
      {** 28/02/2012 ***********CI*}

      AddCampo('MA1ANT', '  ANTER. ');
      AddCampo('MA1ATU', '  ATUAL  ');
      AddCampo('MA2ANT', '  ANTER. ');
      AddCampo('MA2ATU', '  ATUAL  ');
      AddCampo('MA3ANT', '  ANTER. ');
      AddCampo('MA3ATU', '  ATUAL  ');
      AddCampo('MA4ANT', '  ANTER. ');
      AddCampo('MA4ATU', '  ATUAL  ');
      AddCampo('MA5ANT', '  ANTER. ');
      AddCampo('MA5ATU', '  ATUAL  ');
      AddCampo('MA6ANT', '  ANTER. ');
      AddCampo('MA6ATU', '  ATUAL  ');
      AddCampo('MA7ANT', '  ANTER. ');
      AddCampo('MA7ATU', '  ATUAL  ');

    End
    Else If (chkImprimir.Checked[2]) Then
    Begin
      {************************************}
      {* IMPRIME APENAS PREÇO DE VENDA    *}
      {** 28/02/2012 *******************CI*}

      AddCampo('VE1ANT', '  ANTER. ');
      AddCampo('VE1ATU', '  ATUAL  ');
      AddCampo('VE2ANT', '  ANTER. ');
      AddCampo('VE2ATU', '  ATUAL  ');
      AddCampo('VE3ANT', '  ANTER. ');
      AddCampo('VE3ATU', '  ATUAL  ');
      AddCampo('VE4ANT', '  ANTER. ');
      AddCampo('VE4ATU', '  ATUAL  ');
      AddCampo('VE5ANT', '  ANTER. ');
      AddCampo('VE5ATU', '  ATUAL  ');
      AddCampo('VE6ANT', '  ANTER. ');
      AddCampo('VE6ATU', '  ATUAL  ');
      AddCampo('VE7ANT', '  ANTER. ');
      AddCampo('VE7ATU', '  ATUAL  ');

    End;

    AddTotais('CODITE');
    OnMontaResumo := pMontaResumo;
    OnSomaResumo  := pSomaTotais;
    OnImpFiltros  := pImprimeFiltros;

    If fGerarRelatorio Then
    Begin
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);
      strArqPDF := objExcel.NomeArquivo;
    End;

  End;

  FreeAndNil(objGeraExcel);
  FreeAndNil(cdsDados);
End;

procedure TfrmRelLstPreAlt.pImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: array of String);

Var
   strLinha: String;
begin
    Excel.ProximaLinha;

    strLinha := IntToStr(Length(Filtros) + 4);

  With Excel Do
  Begin
    If (chkImprimir.Checked[3]) Then
    Begin
      Escrever(LinhaAtual, Campos.ColunaPorNome['COMANT'].Coluna, 'PRECO COMPRA');
      Mesclar(Campos.ColunaPorNome['COMANT'].Letra + strLinha, (Campos.ColunaPorNome['COMATU'].Letra + strLinha));
    End;

    If (chkImprimir.Checked[0]) Then
    Begin
      Escrever(LinhaAtual, Campos.ColunaPorNome['CUSANT'].Coluna, 'PRECO CUSTO');
      Mesclar(Campos.ColunaPorNome['CUSANT'].Letra + strLinha, (Campos.ColunaPorNome['CUSATU'].Letra + strLinha));
    End;

    If (chkImprimir.Checked[1]) And
       (chkImprimir.Checked[2]) Then
    Begin
      {****************************************************}
      {* IMPRIME CABECALHO COM MARGEM E PREÇO DE VENDA    *}
      {** 28/02/2012 ***********************************CI*}

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA1ANT'].Coluna, 'MARGEM BRUTA1');
      Mesclar(Campos.ColunaPorNome['MA1ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA1ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE1ANT'].Coluna, 'PRECO VENDA1');
      Mesclar(Campos.ColunaPorNome['VE1ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE1ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA2ANT'].Coluna, 'MARGEM BRUTA2');
      Mesclar(Campos.ColunaPorNome['MA2ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA2ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE2ANT'].Coluna, 'PRECO VENDA2');
      Mesclar(Campos.ColunaPorNome['VE2ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE2ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA3ANT'].Coluna, 'MARGEM BRUTA3');
      Mesclar(Campos.ColunaPorNome['MA3ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA3ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE3ANT'].Coluna, 'PRECO VENDA3');
      Mesclar(Campos.ColunaPorNome['VE3ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE3ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA4ANT'].Coluna, 'MARGEM BRUTA4');
      Mesclar(Campos.ColunaPorNome['MA4ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA4ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE4ANT'].Coluna, 'PRECO VENDA4');
      Mesclar(Campos.ColunaPorNome['VE4ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE4ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA5ANT'].Coluna, 'MARGEM BRUTA5');
      Mesclar(Campos.ColunaPorNome['MA5ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA5ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE5ANT'].Coluna, 'PRECO VENDA5');
      Mesclar(Campos.ColunaPorNome['VE5ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE5ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA6ANT'].Coluna, 'MARGEM BRUTA6');
      Mesclar(Campos.ColunaPorNome['MA6ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA6ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE6ANT'].Coluna, 'PRECO VENDA6');
      Mesclar(Campos.ColunaPorNome['VE6ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE6ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA7ANT'].Coluna, 'MARGEM BRUTA7');
      Mesclar(Campos.ColunaPorNome['MA7ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA7ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE7ANT'].Coluna, 'PRECO VENDA7');
      Mesclar(Campos.ColunaPorNome['VE7ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE7ATU'].Letra + strLinha));
    End
    Else If (chkImprimir.Checked[1]) Then
    Begin
      {******************************************}
      {* IMPRIME CABECALHO APENAS COM MARGEM    *}
      {** 28/02/2012 *************************CI*}

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA1ANT'].Coluna, 'MARGEM BRUTA1');
      Mesclar(Campos.ColunaPorNome['MA1ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA1ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA2ANT'].Coluna, 'MARGEM BRUTA2');
      Mesclar(Campos.ColunaPorNome['MA2ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA2ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA3ANT'].Coluna, 'MARGEM BRUTA3');
      Mesclar(Campos.ColunaPorNome['MA3ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA3ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA4ANT'].Coluna, 'MARGEM BRUTA4');
      Mesclar(Campos.ColunaPorNome['MA4ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA4ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA5ANT'].Coluna, 'MARGEM BRUTA5');
      Mesclar(Campos.ColunaPorNome['MA5ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA5ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA6ANT'].Coluna, 'MARGEM BRUTA6');
      Mesclar(Campos.ColunaPorNome['MA6ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA6ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['MA7ANT'].Coluna, 'MARGEM BRUTA7');
      Mesclar(Campos.ColunaPorNome['MA7ANT'].Letra + strLinha, (Campos.ColunaPorNome['MA7ATU'].Letra + strLinha));

    End
    Else If (chkImprimir.Checked[2]) Then
    Begin
      {**********************************************}
      {* IMPRIME CABECALHO APENAS PREÇO DE VENDA    *}
      {** 28/02/2012 *****************************CI*}

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE1ANT'].Coluna, 'PRECO VENDA1');
      Mesclar(Campos.ColunaPorNome['VE1ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE1ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE2ANT'].Coluna, 'PRECO VENDA2');
      Mesclar(Campos.ColunaPorNome['VE2ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE2ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE3ANT'].Coluna, 'PRECO VENDA3');
      Mesclar(Campos.ColunaPorNome['VE3ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE3ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE4ANT'].Coluna, 'PRECO VENDA4');
      Mesclar(Campos.ColunaPorNome['VE4ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE4ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE5ANT'].Coluna, 'PRECO VENDA5');
      Mesclar(Campos.ColunaPorNome['VE5ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE5ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE6ANT'].Coluna, 'PRECO VENDA6');
      Mesclar(Campos.ColunaPorNome['VE6ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE6ATU'].Letra + strLinha));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VE7ANT'].Coluna, 'PRECO VENDA7');
      Mesclar(Campos.ColunaPorNome['VE7ANT'].Letra + strLinha, (Campos.ColunaPorNome['VE7ATU'].Letra + strLinha));

    End;

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), Preto);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Centro);
  End;

end;

procedure TfrmRelLstPreAlt.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['NUMITE'] := Totais['NUMITE'] + 1;
  Totais['DTAALT'] := Dados.FieldByName('DTAALT').AsDateTime;
  Totais['CODFOR'] := Dados.FieldByName('CODFOR').AsFloat;
end;

procedure TfrmRelLstPreAlt.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strTotal: String;
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'DTAALT') Then
      strTotal := 'TOTAL DE PRODUTOS LISTADOS REFERENTE AO DIA ' + DateToStr(Quebra.Totais['DTAALT']) + ' : ' +
                  fStrZero(FormatFloat('##,#0', Quebra.Totais['NUMITE']), 6)
    Else If (Quebra.NomeCampo = 'CODFOR') Then
      strTotal := 'TOTAL DE PRODUTOS LISTADOS REFERENTE AO FORNECEDOR (' +  FormatFloat('##,#0', Quebra.Totais['CODFOR']) + '-' + fRetNomFornecedor(fPadL(FloatToStr(Quebra.Totais['CODFOR']), 8, '0')) + '): ' +
                  fStrZero(FormatFloat('##,#0', Quebra.Totais['NUMITE']), 6)
    Else
       strTotal := '';

    ProximaLinha;

    Escrever(LinhaAtual, 01, strTotal);
    Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Esquerda);

  End;

End;

end.

