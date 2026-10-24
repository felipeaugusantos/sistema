unit untCalNivGirEstFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Mask, MaskEditFocus,
  CurrencyEditFocus, untFuncoesSimples,  ComCtrls,
  DBClient, StrUtils,  DB, DBCtrls, Uni,
  DBEditFocus, untZClient, ComboBoxFocus, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, frxClass, frxExportCSVTestabilidade,
  untTypesSistema, UniClientDataSet;

type
  TfrmCalNivGirEstFornecedor = class(TfrmPaiConfirma)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    GroupBox1: TGroupBox;
    lblOrdemQtdValor: TColorLabel;
    edtOrdem: TEditFocus;
    edtDesEmpresa: TEditFocus;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ceValNiA: TCurrencyEditFocus;
    ceValNB1: TCurrencyEditFocus;
    ceValNiC: TCurrencyEditFocus;
    ceValNB2: TCurrencyEditFocus;
    pgbStatus: TProgressBar;
    shpMultSel: TShape;
    Label1: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    rdgGerNiv: TRadioGroup;
    btnGravar: TBitBtnLocked;
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadFor: TUniQuery;
    strFornec,
    strEmpAtu: String;

    cdsCadGrp: TZClient;

    arrFornec: TConsultasArray;

    Function fSQLGrupos: String;
    Function fSQLFrom: String;
    Function fSQLFornecedores: String;
    Function fRetCampoCalc: String;

    procedure pAbreFornecedores;
    procedure pAbreConsulta(qryConsulta: TUniQuery);
    procedure pCalcula;
    procedure pFormataCamposItens(cdsItens: TUniClientDataSet);
    procedure pTotalizarGrupoProduto(cdsItens: TUniClientDataSet);
    procedure pInsereGrupo(strCodGru: String);
    procedure pInsereTodosGrupos(ASql: String);
    function fTemPrincipal(ACodFor: string): Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmCalNivGirEstFornecedor: TfrmCalNivGirEstFornecedor;

implementation

uses untCalNivGirEstFornecGrid,
     untConsultas, untConstantes,untFuncoesConsulta;

{$R *.dfm}

Function TfrmCalNivGirEstFornecedor.fSQLFrom: String;
Var
  strSQL   : String;
Begin
  strSQL := '';

  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     CADITE I ';

  strSQL := strSQL + '     INNER JOIN MOVDET M ON M.DET_CODITE = I.ITE_CODITE      ';

  strSQL := strSQL + '     INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI      ';

  strSQL := strSQL + '     INNER JOIN ITEGER G ON G.ITE_CODITE = M.DET_CODITE AND  ';
  strSQL := strSQL + '                            G.ITE_CODEMP = M.DET_CODEMP      ';

  strSQL := strSQL + '     LEFT JOIN SITPRO S ON S.SIT_CODIGO = I.ITE_SITPRO       ';

  strSQL := strSQL + '     LEFT JOIN GRPPRD ON GRPPRD.PRD_CODGRU = I.ITE_PRDGRU ';

  strSQL := strSQL + '   WHERE ';
  strSQL := strSQL + '     M.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

  strSQL := strSQL + '     M.DET_TIP_FC = "C" AND ';
  strSQL := strSQL + '     M.DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '     I.ITE_ITEATI = "S" AND ';
  strSQL := strSQL + '     M.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '     ((LOCATE(M.DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(M.DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' OR (M.DET_ESPDOC = "BR") OR LOCATE(M.DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  If (Not fEmptyStr(edtCodEmpresa.Text)) Then
    strSQL := strSQL + '  AND M.DET_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(M.DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  strSql := strSQL + fStrLocate(edtFornecedor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');

  Result := strSQL;
End;

Function TfrmCalNivGirEstFornecedor.fSQLFornecedores: String;
Var
  strSQL: String;
  strSQLFor: String;
Begin
  strSQLFor := '';
  strSQLFor := strSQLFor + ' SELECT DISTINCT ';

  If rdgGerNiv.ItemIndex = 0 Then
    strSQLFor := strSQLFor + ' I.ITE_CODFOR '
  Else
    strSQLFor := strSQLFor + ' I.ITE_CODFOR, IFNULL(I.ITE_PRDGRU, "") AS ITE_CODGRP ';

  strSQLFor := strSQLFor + fSQLFrom;

  strSQL := ' /* untCalNivGirEstFornecedor.fSQLFornecedores */ ';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE DISTINCT';

  If rdgGerNiv.ItemIndex = 0 Then
  Begin
    strSQL := strSQL + '   ITE_CODFOR AS CODFOR ';
  End Else
  Begin
    strSQL := strSQL + '   ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '   IFNULL(ITE_CODGRP, "") AS CODGRP  ';
  End;

  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + strSQLFor;

  strSQL := strSQL + ' ) AS TAB';
  Result := strSQL;
End;

procedure TfrmCalNivGirEstFornecedor.pAbreFornecedores;
Begin
  With qryCadFor Do
  Begin
    SQL.Text := fSQLFornecedores;
    pAbreConsulta(qryCadFor);
    qryCadFor.Open;
  End;
End;

procedure TfrmCalNivGirEstFornecedor.pAbreConsulta(qryConsulta: TUniQuery);
Begin
  With qryConsulta Do
  Begin
    Close;

    pSetaParam(edtFornecedor.Text, arrFornec, strFornec, 'CODFOR', qryConsulta);

    If Params.FindParam('DTAINI') <> Nil Then
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);

    If Params.FindParam('DTAFIN') <> Nil Then
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If Params.FindParam('CLAFIS') <> Nil Then
      ParamByName('CLAFIS').AsString := VS_strClaVen;

    If Params.FindParam('CLADEV') <> Nil Then
      ParamByName('CLADEV').AsString := VS_strClaDev;

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
    Begin
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Params.FindParam('EMPATU') <> Nil Then
        ParamByName('EMPATU').AsString := edtCodEmpresa.Text;

      strEmpAtu := edtCodEmpresa.Text;
    End Else
    Begin
      If Params.FindParam('EMPATU') <> Nil Then
        ParamByName('EMPATU').AsString := VS_strCodEmp;

      strEmpAtu := VS_strCodEmp;
    End;

    If Params.FindParam('FATREV') <> Nil Then
        ParamByName('FATREV').AsFloat := fCfgSis('FATREV', varDouble);
  End;
End;

Function TfrmCalNivGirEstFornecedor.fRetCampoCalc: String;
Begin
  Case edtOrdem.Text[1] Of
    'Q': Result := 'QTDITE';
    'L': Result := 'PESLIT';
    'V': Result := 'TOTITE';
    Else Result := 'TOTITE';
  End;
End;

procedure TfrmCalNivGirEstFornecedor.pFormataCamposItens(cdsItens: TUniClientDataSet);
Begin
  With cdsItens Do
  Begin
    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(2);
    TFloatField(FieldByName('TOTITE')).DisplayFormat := fMskDigitos(2);
    TFloatField(FieldByName('REPITE')).DisplayFormat := fMskDigitos(2);
    TFloatField(FieldByName('REPACU')).DisplayFormat := fMskDigitos(2);
    TFloatField(FieldByName('MARBRU')).DisplayFormat := fMskDigitos(2);

    TFloatField(FieldByName('PREVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('PREVEN_CNV')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('PREREV')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('PREREV_CNV')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('PRECUS')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('PRECUS_CNV')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('VALUNI')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

    FieldByName('NVLFOR').Alignment := taCenter;
  End;
end;

procedure TfrmCalNivGirEstFornecedor.pTotalizarGrupoProduto(cdsItens: TUniClientDataSet);
  Type
    TGrupo = Record
      strCodGru: String;
      fltTotal: Double;
    End;

  Var
    gru: TGrupo;
    arrGru: Array Of TGrupo;
    fltTotal: Double;
    fltValDiv: Double;

  procedure pAddGru(strCodGru: String; fltTotal: Double);
    Var
      intGru: Integer;
  begin
    For intGru := 0 To Length(arrGru) -1 Do
    Begin
      If arrGru[intGru].strCodGru = strCodGru Then
      Begin
        arrGru[intGru].fltTotal := arrGru[intGru].fltTotal + fltTotal;
        Exit;
      End;
    End;

    SetLength(arrGru, Length(arrGru) + 1);
    arrGru[High(arrGru)].strCodGru := strCodGru;
    arrGru[High(arrGru)].fltTotal := fltTotal;
  end;

  function fGetGru(strCodGru: String): TGrupo;
    Var
      gru: TGrupo;
  begin
    For gru In arrGru Do
    Begin
      If gru.strCodGru = strCodGru Then
      Begin
        Result := gru;
        Exit;
      End;
    End;
  end;

begin
  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin
    pAddGru(cdsItens.FieldByName('CODGRP').AsString, cdsItens.FieldByName('TOTITE').AsFloat);
    cdsItens.Next;
  End;

  fltTotal := 0;
  For gru In arrGru Do
    fltTotal := fltTotal + gru.fltTotal;

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    gru := fGetGru(cdsItens.FieldByName('CODGRP').AsString);

    If fltTotal > 0 Then
      fltValDiv := (gru.fltTotal / fltTotal)
    Else
      fltValDiv := 0;

    cdsItens.Edit;
    cdsItens.FieldByName('DESGRU').AsString := gru.strCodGru +  IIf(gru.strCodGru = '', '', ' - ' + fRetNomeGrupoProduto(gru.strCodGru))
                                             + '   Total Vendido: '+ FormatFloat('#,##0.00', gru.fltTotal)
                                             + '   Repres: ' + FormatFloat('#,##0.00', fltValDiv * 100) + ' %';
    cdsItens.Post;

    cdsItens.Next;
  End;

  cdsItens.First;
End;

procedure TfrmCalNivGirEstFornecedor.pInsereTodosGrupos(ASql: String);
  Var
    qryGrupos: TUniQuery;
Begin
  qryGrupos := fCriaQuery(Self);

  With qryGrupos, SQL Do
  Begin
    Add(ASql);
    pAbreConsulta(qryGrupos);
    Open;

    While Not Eof Do
    Begin
      pInsereGrupo(FieldByName('CODGRP').AsString);

      Next;
    End;

  End;
  FreeAndNil(qryGrupos);
End;

procedure TfrmCalNivGirEstFornecedor.pInsereGrupo(strCodGru: String);
Begin
  If (rdgGerNiv.ItemIndex = 0)  Then
  begin
    If  (cdsCadGrp.RecordCount = 0) then
    Begin
      cdsCadGrp.Insert;
      cdsCadGrp.FieldByName('CODGRP').AsString := '';

      cdsCadGrp.FieldByName('MKPNVA').AsFloat := 0;
      cdsCadGrp.FieldByName('MKPNVB').AsFloat := 0;
      cdsCadGrp.FieldByName('MKPNVC').AsFloat := 0;

      cdsCadGrp.FieldByName('DESGRP').AsString := 'TODOS OS GRUPOS';

      cdsCadGrp.Post;
    End;
  End
  Else
  begin
    If Not cdsCadGrp.Locate('CODGRP', strCodGru, []) Then
    Begin
      cdsCadGrp.Insert;
      cdsCadGrp.FieldByName('CODGRP').AsString := strCodGru;

      cdsCadGrp.FieldByName('MKPNVA').AsFloat := 0;
      cdsCadGrp.FieldByName('MKPNVB').AsFloat := 0;
      cdsCadGrp.FieldByName('MKPNVC').AsFloat := 0;

      If fEmptyStr(strCodGru) Then
        cdsCadGrp.FieldByName('DESGRP').AsString := 'ITENS SEM GRUPO'
      Else
        cdsCadGrp.FieldByName('DESGRP').AsString := fRetNomeGrupoProduto(strCodGru);

      cdsCadGrp.Post;
    End;
  End;
End;

procedure TfrmCalNivGirEstFornecedor.pCalcula;
CONST
  STR_CUSTO_CONVERTIDO = ' G.ITE_PRECUS / 1 ';
Var
  strSQL   : String;
  strSQL1  : String;

  qryUpd   : TUniQuery;

  cdsItens: TZClient;

  blnTemA,
  blnTemB: Boolean;

  fltNivA  : Double;
  fltNivB2 : Double;
  fltNivC  : Double;
  fltRepIte: Double;
  strNivel : String;
  fltTotRep: Double;
  fltSomaGeral : Double;

  strSQLGroupCODGRP: String;

  Procedure pUpdateNivel(strNivel: String);
  Begin
    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE CADITE SET ITE_NVLFOR = :NVLGIR WHERE ITE_CODITE = :CODITE ');
      ParamByName('NVLGIR').AsString := strNivel;
      ParamByName('CODITE').AsString := cdsItens.fieldbyname('CODITE').AsString;
      ExecSQL;
    End;
  End;


  function fDefineGir(ANIvelGir: String): String;
  Begin
    Result := ANIvelGir;
    If ANIvelGir = 'C' Then
    Begin
      If Not blnTemB Then
        Result := fDefineGir('B');
    End;

    If ANIvelGir = 'B' Then
    Begin
      If Not blnTemA Then
        Result := fDefineGir('A');
    End;
  End;


  Procedure pAtulizaNivel(strNivGir: String);
    Var
      strFilter  : String;
      intContador: Integer;
  Begin

    With cdsItens Do
    Begin
      strFilter := Filter;

      Filter := Filter + ' AND NVLFOR = ' + QuotedStr(strNivGir);

      intContador := 0;

      First;
      While Not Eof Do
      Begin
        Inc(intContador);

        Edit;
        FieldByName('NVLFOR').AsString := fieldbyname('NVLFOR').AsString + fStrZero(IntToStr(intContador), 5);
        Post;
        pgbStatus.StepBy(1);
        Application.ProcessMessages;
      End;

      Filter := strFilter;
    End;

  End;

  Procedure pNivelFornecedor;
  Begin
    cdsItens.Filtered := False;

    cdsItens.Filter   := 'CODFOR = ' + QuotedStr(qryCadFor.FieldByName('CODFOR').AsString);

    If rdgGerNiv.ItemIndex = 1 Then
      cdsItens.Filter   := cdsItens.Filter + ' AND CODGRP = ' + QuotedStr(qryCadFor.FieldByName('CODGRP').AsString);

    cdsItens.Filtered := True;

    fltSomaGeral      := TAggregateField(cdsItens.FieldByName('TOTAL')).Value;

    fltTotRep := 0;

    cdsItens.First;

   {****************************************************************************}
   {* SERA ATUALIZADA A TABELA CADITE (ITE_NVLFOR) APARTIR DO PERCENTUAL DE    *}
   {* REPRESENT. CALCULADO E OS PERCENTUAIS INFORMADOS PARA OS NIVEIS A, B E C *}
   {*************************************************************************LU*}
    blnTemA := False;
    blnTemB := False;
    While Not cdsItens.Eof Do
    Begin
      Application.ProcessMessages;

      If fltSomaGeral > 0 Then
        fltRepIte := (cdsItens.fieldbyname(fRetCampoCalc).AsFloat / fltSomaGeral) * 100
      Else
        fltRepIte := 0;

      fltTotRep := fltTotRep + fltRepIte;

      cdsItens.Edit;
      cdsItens.FieldByName('REPITE').AsFloat := fltRepIte;
      cdsItens.FieldByName('REPACU').AsFloat := fltTotRep;
      cdsItens.Post;

      If fltTotRep <= fltNivA Then
        strNivel := 'A'
      Else If (fltTotRep <= fltNivB2) Then
        strNivel := 'B'
      Else If fltTotRep > fltNivC Then
        strNivel := 'C';
      cdsItens.Edit;
      If cdsItens.fieldbyname('COMGIR').AsString = '1' Then
      Begin
        cdsItens.FieldByName('NVLFOR').AsString := fDefineGir(strNivel);
        If cdsItens.FieldByName('NVLFOR').AsString = 'A' then
          blnTemA := True;
        If cdsItens.FieldByName('NVLFOR').AsString = 'B' then
          blnTemB := True;
      End;
      cdsItens.Post;

      pInsereGrupo(cdsItens.FieldByName('CODGRP').AsString);

      cdsItens.Next;

      pgbStatus.StepBy(1);
    End;

    pAtulizaNivel('A');
    pAtulizaNivel('B');
    pAtulizaNivel('C');
  End;

begin
  inherited;

  {**************************************************}
  {* O CALCULO SEMPRE SERA FEITO PARA O CAIXA 1 E 2 *}
  {***********************************************LU*}
  pnlInfo.Caption := 'Calculando...';
  Application.ProcessMessages;
  btnConfirma.Enabled := False;
  btnSair.Enabled := False;

  cdsItens := TZClient.Create(Self);

  cdsCadGrp.EmptyDataSet;


 {**************************************************************************}
 {* SOMATORIO DO TOTITE PARA O CALCULO DO PERCENTUAL DE REPRESENTATIVIDADE *}
 {***********************************************************************LU*}
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOTAL';
    FieldName     := 'TOTAL';
    DataSet       := cdsItens;
    Expression    := 'SUM('+ fRetCampoCalc + ')';
    Active        := True;
  End;

  cdsItens.IndexDefs.Add('IDX_TOTITE', fRetCampoCalc, [ixDescending]);
  cdsItens.IndexName := 'IDX_TOTITE';
  cdsItens.DisableControls;

  Try
    strSQLGroupCODGRP := 'SELECT CODGRP FROM(';


    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COMGIR, ';
    strSQL := strSQL + '   CODFOR, ';
    strSQL := strSQL + '   CODTAB, ';
    strSQL := strSQL + '   AUTDET, ';
    strSQL := strSQL + '   CODGRP, ';
    strSQL := strSQL + '   FORMULA, ';
    strSQL := strSQL + '   CALCULO, ';
    strSQL := strSQL + '   FORMULA1, ';
    strSQL := strSQL + '   CALCULO1, ';
    strSQL := strSQL + '   FORMULA2, ';
    strSQL := strSQL + '   CALCULO2, ';
    strSQL := strSQL + '   FORMULA3, ';
    strSQL := strSQL + '   CALCULO3, ';
    strSQL := strSQL + '   FORMULA4, ';
    strSQL := strSQL + '   CALCULO4, ';
    strSQL := strSQL + '   FORMULA5, ';
    strSQL := strSQL + '   CALCULO5, ';
    strSQL := strSQL + '   FORMULA6, ';
    strSQL := strSQL + '   CALCULO6, ';
    strSQL := strSQL + '   FORMULA7, ';
    strSQL := strSQL + '   CALCULO7, ';
    strSQL := strSQL + '   CODITE, ';
    strSQL := strSQL + '   CODFAB, ';
    strSQL := strSQL + '   DESITE, ';
    strSQL := strSQL + '   SITPRO, ';
    strSQL := strSQL + '   REFERE, ';
    strSQL := strSQL + '   SUM(QTDITE) AS QTDITE, ';
    strSQL := strSQL + '   VALEST, ';
    strSQL := strSQL + '   SALEST, ';
    strSQL := strSQL + '   CNVCUS, ';
    strSQL := strSQL + '   ATUPRO, ';
    strSQL := strSQL + '   PRECUS, ';
    strSQL := strSQL + '   PRECUS_CNV, ';
    strSQL := strSQL + '   ICMSAI, ';
    strSQL := strSQL + '   IMPFED, ';
    strSQL := strSQL + '   DESOPE, ';
    strSQL := strSQL + '   COMTBL, ';

    strSQL := strSQL + '   OUTVAL, ';
    strSQL := strSQL + '   ITE_TABPR1, ';
    strSQL := strSQL + '   ITE_TABPR2, ';
    strSQL := strSQL + '   ITE_TABPR3, ';
    strSQL := strSQL + '   ITE_TABPR4, ';
    strSQL := strSQL + '   ITE_TABPR5, ';
    strSQL := strSQL + '   ITE_TABPR6, ';
    strSQL := strSQL + '   ITE_TABPR7, ';

    strSQL := strSQL + '  ITE_PREVE1_OLD, ';
    strSQL := strSQL + '  ITE_PREVE2_OLD, ';
    strSQL := strSQL + '  ITE_PREVE3_OLD, ';
    strSQL := strSQL + '  ITE_PREVE4_OLD, ';
    strSQL := strSQL + '  ITE_PREVE5_OLD, ';
    strSQL := strSQL + '  ITE_PREVE6_OLD, ';
    strSQL := strSQL + '  ITE_PREVE7_OLD, ';

    strSQL := strSQL + '   ITE_PREVE1, ';
    strSQL := strSQL + '   ITE_PREVE2, ';
    strSQL := strSQL + '   ITE_PREVE3, ';
    strSQL := strSQL + '   ITE_PREVE4, ';
    strSQL := strSQL + '   ITE_PREVE5, ';
    strSQL := strSQL + '   ITE_PREVE6, ';
    strSQL := strSQL + '   ITE_PREVE7, ';



    strSQL := strSQL + '   ITE_PRECOM, ';
    strSQL := strSQL + '   ITE_DESF01, ';
    strSQL := strSQL + '   ITE_DESF02, ';
    strSQL := strSQL + '   ITE_DESF03, ';
    strSQL := strSQL + '   ITE_DESF04, ';
    strSQL := strSQL + '   ITE_DESF05, ';
    strSQL := strSQL + '   ITE_DESF06, ';
    strSQL := strSQL + '   ITE_ICMENT, ';
    strSQL := strSQL + '   ITE_IPIENT, ';
    strSQL := strSQL + '   ITE_FREENT, ';
    strSQL := strSQL + '   ITE_ACRFIN, ';
    strSQL := strSQL + '   ITE_SUBSTI, ';
    strSQL := strSQL + '   ITE_VALFRE, ';
    strSQL := strSQL + '   ITE_DESADB, ';

    strSQL := strSQL + '   ITE_TCIFCU, ';
    strSQL := strSQL + '   ITE_TSCUST, ';
    strSQL := strSQL + '   ITE_DEPICO, ';
    strSQL := strSQL + '   ITE_DEICMS, ';
    strSQL := strSQL + '   ITE_FATREG, ';


    strSQL := strSQL + '  ITE_PRECUS1,';
    strSQL := strSQL + '  ITE_PRECUS2,';
    strSQL := strSQL + '  ITE_PRECUS3,';
    strSQL := strSQL + '  ITE_PRECUS4,';
    strSQL := strSQL + '  ITE_PRECUS5,';
    strSQL := strSQL + '  ITE_PRECUS6,';
    strSQL := strSQL + '  ITE_PRECUS7,';


    strSQL := strSQL + '   CUS_ICMSAI1,';
    strSQL := strSQL + '   CUS_IMPFED1,';
    strSQL := strSQL + '   CUS_SUBFED1,';
    strSQL := strSQL + '   CUS_DESOPE1,';
    strSQL := strSQL + '   CUS_OUTVAL1,';

    strSQL := strSQL + '   CUS_ICMSAI2,';
    strSQL := strSQL + '   CUS_IMPFED2,';
    strSQL := strSQL + '   CUS_SUBFED2,';
    strSQL := strSQL + '   CUS_DESOPE2,';
    strSQL := strSQL + '   CUS_OUTVAL2,';
    strSQL := strSQL + '   CUS_ICMSAI3,';
    strSQL := strSQL + '   CUS_IMPFED3,';
    strSQL := strSQL + '   CUS_SUBFED3,';
    strSQL := strSQL + '   CUS_DESOPE3,';
    strSQL := strSQL + '   CUS_OUTVAL3,';
    strSQL := strSQL + '   CUS_ICMSAI4,';
    strSQL := strSQL + '   CUS_IMPFED4,';
    strSQL := strSQL + '   CUS_SUBFED4,';
    strSQL := strSQL + '   CUS_DESOPE4,';
    strSQL := strSQL + '   CUS_OUTVAL4,';
    strSQL := strSQL + '   CUS_ICMSAI5,';
    strSQL := strSQL + '   CUS_IMPFED5,';
    strSQL := strSQL + '   CUS_SUBFED5,';
    strSQL := strSQL + '   CUS_DESOPE5,';
    strSQL := strSQL + '   CUS_OUTVAL5,';
    strSQL := strSQL + '   CUS_ICMSAI6,';
    strSQL := strSQL + '   CUS_IMPFED6,';
    strSQL := strSQL + '   CUS_SUBFED6,';
    strSQL := strSQL + '   CUS_DESOPE6,';
    strSQL := strSQL + '   CUS_OUTVAL6,';
    strSQL := strSQL + '   CUS_ICMSAI7,';
    strSQL := strSQL + '   CUS_IMPFED7,';
    strSQL := strSQL + '   CUS_SUBFED7,';
    strSQL := strSQL + '   CUS_DESOPE7,';
    strSQL := strSQL + '   CUS_OUTVAL7, ';
    strSQL := strSQL + '   ITE_PREDOL, ';

    strSQL := strSQL + '   PREVEN, ';
    strSQL := strSQL + '   PREVEN_CNV, ';
    strSQL := strSQL + '   MARBRU, ';
    strSQL := strSQL + '   SUM(TOTITE) AS TOTITE, ';
    strSQL := strSQL + '   SUM(TOTCUS) AS TOTCUS, ';
    strSQL := strSQL + '   SUM(TOTITE)/SUM(QTDITE) AS UNITAR, ';
    strSQL := strSQL + '   (PESLIT * SUM(QTDITE)) AS PESLIT ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ( ';

    strSQL := strSQL + '     SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '       "1" AS COMGIR, ';
    strSQL := strSQL + '       I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '       G.ITE_TABPR1 AS CODTAB, ';
    strSQL := strSQL + '       CAST("" AS CHAR(20)) AS AUTDET, ';
    strSQL := strSQL + '       IFNULL(I.ITE_PRDGRU, "") AS CODGRP, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA1, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO1, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA2, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO2, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA3, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO3, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA4, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO4, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA5, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO5, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA6, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO6, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA7, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO7, ';

    strSQL := strSQL + '       I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '       I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '       I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '       S.SIT_CODIGO AS SITPRO, ';
    strSQL := strSQL + '       I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '       U.UNI_PESLIT AS PESLIT, ';

    strSQL := strSQL + '       IFNULL(G.ITE_PRECUS, 0)  AS PRECUS,     ';
    strSQL := strSQL +         STR_CUSTO_CONVERTIDO + ' AS PRECUS_CNV, ';
    strSQL := strSQL + '       1 AS CNVCUS, ';
    strSQL := strSQL + '       1 AS ATUPRO, ';


    strSQL := strSQL + '       G.ITE_COMTB1                         AS COMTBL, ';
    strSQL := strSQL + '       G.ITE_ICMSAI                         AS ICMSAI, ';
    strSQL := strSQL + '       G.ITE_IMPFED                         AS IMPFED, ';
    strSQL := strSQL + '       G.ITE_DESOPE                         AS DESOPE, ';

    strSQL := strSQL + '       G.ITE_OUTVAL                         AS OUTVAL, ';
    strSQL := strSQL + '       G.ITE_TABPR1                         AS ITE_TABPR1, ';
    strSQL := strSQL + '       G.ITE_TABPR2                         AS ITE_TABPR2, ';
    strSQL := strSQL + '       G.ITE_TABPR3                         AS ITE_TABPR3, ';
    strSQL := strSQL + '       G.ITE_TABPR4                         AS ITE_TABPR4, ';
    strSQL := strSQL + '       G.ITE_TABPR5                         AS ITE_TABPR5, ';
    strSQL := strSQL + '       G.ITE_TABPR6                         AS ITE_TABPR6, ';
    strSQL := strSQL + '       G.ITE_TABPR7                         AS ITE_TABPR7, ';

    strSQL := strSQL + '       G.ITE_PREVE1             AS ITE_PREVE1_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE2             AS ITE_PREVE2_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE3             AS ITE_PREVE3_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE4             AS ITE_PREVE4_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE5             AS ITE_PREVE5_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE6             AS ITE_PREVE6_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE7             AS ITE_PREVE7_OLD, ';

    strSQL := strSQL + '       0.0000                               AS ITE_PREVE1, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE2, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE3, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE4, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE5, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE6, ';
    strSQL := strSQL + '       0.0000                               AS ITE_PREVE7, ';

    strSQL := strSQL + '       G.ITE_PRECOM, ';
    strSQL := strSQL + '       G.ITE_DESF01, ';
    strSQL := strSQL + '       G.ITE_DESF02, ';
    strSQL := strSQL + '       G.ITE_DESF03, ';
    strSQL := strSQL + '       G.ITE_DESF04, ';
    strSQL := strSQL + '       G.ITE_DESF05, ';
    strSQL := strSQL + '       G.ITE_DESF06, ';
    strSQL := strSQL + '       G.ITE_ICMENT, ';
    strSQL := strSQL + '       G.ITE_IPIENT, ';
    strSQL := strSQL + '       G.ITE_FREENT, ';
    strSQL := strSQL + '       G.ITE_ACRFIN, ';
    strSQL := strSQL + '       G.ITE_SUBSTI, ';
    strSQL := strSQL + '       G.ITE_VALFRE, ';
    strSQL := strSQL + '       G.ITE_DESADB, ';

    strSQL := strSQL + '       G.ITE_TCIFCU, ';
    strSQL := strSQL + '       G.ITE_TSCUST, ';
    strSQL := strSQL + '       G.ITE_DEPICO, ';
    strSQL := strSQL + '       G.ITE_DEICMS, ';
    strSQL := strSQL + '       G.ITE_FATREG, ';


    strSQL := strSQL + '      0.000 AS ITE_PRECUS1,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS2,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS3,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS4,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS5,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS6,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS7,';

    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI1,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED1,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED1,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE1,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL1,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI2,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED2,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED2,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE2,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL2,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI3,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED3,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED3,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE3,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL3,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI4,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED4,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED4,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE4,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL4,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI5,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED5,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED5,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE5,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL5,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI6,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED6,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED6,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE6,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL6,';
    strSQL := strSQL + '        0.0000 AS CUS_ICMSAI7,';
    strSQL := strSQL + '        0.0000 AS CUS_IMPFED7,';
    strSQL := strSQL + '        0.0000 AS CUS_SUBFED7,';
    strSQL := strSQL + '        0.0000 AS CUS_DESOPE7,';
    strSQL := strSQL + '        0.0000 AS CUS_OUTVAL7, ';
    strSQL := strSQL + '        G.ITE_PREDOL, ';

    strSQL := strSQL + '       0.0000                               AS PREVEN, ';
    strSQL := strSQL + '       0.0000                               AS PREVEN_CNV, ';
    strSQL := strSQL + '       0.00                                 AS MARBRU, ';

    strSQL := strSQL + '       SUM(IF(LEFT(M.DET_CLAFIS,1) < 5, -1, 1 ) * M.DET_QTDITE) AS QTDITE, ';

    strSQL := strSQL + '       SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0, IF(LEFT(M.DET_CLAFIS,1) < 5, -(M.DET_TOTITE - M.DET_DESESP - M.DET_DESCFF) , (M.DET_TOTITE - M.DET_DESESP - M.DET_DESCFF)))) AS TOTITE, ';

    strSQL := strSQL + '       SUM(G.ITE_PRECUS * ITE_SALDOS) AS VALEST, ';
    strSQL := strSQL + '       SUM(ITE_SALDOS) AS SALEST, ';
    strSQL := strSQL + '       SUM(IF(LEFT(M.DET_CLAFIS,1) < 5, -M.DET_TOTCUS , M.DET_TOTCUS)) AS TOTCUS ';

    strSQL := strSQL +       fSQLFrom;

    strSQL := strSQL + '     GROUP BY ';
    strSQL := strSQL + '       I.ITE_CODITE ) AS TAB1 ';
    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '   IFNULL(TOTITE, 0) <> 0 AND ';
    strSQL := strSQL + '   TOTITE IS NOT NULL ';

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   CODITE ';

    {*** union para trazer os itens sem movimento do mesmo fornecedor que nao tem giro ***}

    strSQL := strSQL + ' UNION ';

    strSQL := strSQL + '     SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '      "0" AS COMGIR, ';
    strSQL := strSQL + '       I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '       G.ITE_TABPR1 AS CODTAB, ';
    strSQL := strSQL + '       CAST("" AS CHAR(20)) AS AUTDET, ';
    strSQL := strSQL + '       IFNULL(I.ITE_PRDGRU, "") AS CODGRP, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA1, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO1, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA2, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO2, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA3, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO3, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA4, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO4, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA5, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO5, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA6, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO6, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS FORMULA7, ';
    strSQL := strSQL + '       CAST("" AS CHAR(300)) AS CALCULO7, ';

    strSQL := strSQL + '       I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '       I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '       I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '       S.SIT_CODIGO AS SITPRO, ';
    strSQL := strSQL + '       I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '       0.0000       AS QTDITE, ';
    strSQL := strSQL + '       0.0000       AS VALEST, ';
    strSQL := strSQL + '       0.0000       AS SALEST, ';
    strSQL := strSQL + '       1 AS CNVCUS, ';
    strSQL := strSQL + '       1 AS ATUPRO, ';

    strSQL := strSQL + '       IFNULL(G.ITE_PRECUS, 0)  AS PRECUS, ';
    strSQL := strSQL +         STR_CUSTO_CONVERTIDO + ' AS PRECUS_CNV, ';

    strSQL := strSQL + '       IFNULL(G.ITE_COMTB1, 0)  AS COMTBL, ';
    strSQL := strSQL + '       IFNULL(G.ITE_ICMSAI, 0)  AS ICMSAI, ';
    strSQL := strSQL + '       IFNULL(G.ITE_IMPFED, 0)  AS IMPFED, ';
    strSQL := strSQL + '       IFNULL(G.ITE_DESOPE, 0)  AS DESOPE, ';

    strSQL := strSQL + '       G.ITE_OUTVAL             AS OUTVAL, ';
    strSQL := strSQL + '       G.ITE_TABPR1             AS ITE_TABPR1, ';
    strSQL := strSQL + '       G.ITE_TABPR2             AS ITE_TABPR2, ';
    strSQL := strSQL + '       G.ITE_TABPR3             AS ITE_TABPR3, ';
    strSQL := strSQL + '       G.ITE_TABPR4             AS ITE_TABPR4, ';
    strSQL := strSQL + '       G.ITE_TABPR5             AS ITE_TABPR5, ';
    strSQL := strSQL + '       G.ITE_TABPR6             AS ITE_TABPR6, ';
    strSQL := strSQL + '       G.ITE_TABPR7             AS ITE_TABPR7, ';

    strSQL := strSQL + '       G.ITE_PREVE1             AS ITE_PREVE1_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE2             AS ITE_PREVE2_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE3             AS ITE_PREVE3_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE4             AS ITE_PREVE4_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE5             AS ITE_PREVE5_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE6             AS ITE_PREVE6_OLD, ';
    strSQL := strSQL + '       G.ITE_PREVE7             AS ITE_PREVE7_OLD, ';

    strSQL := strSQL + '       0.0000                   AS ITE_PREVE1, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE2, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE3, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE4, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE5, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE6, ';
    strSQL := strSQL + '       0.0000                   AS ITE_PREVE7, ';


    strSQL := strSQL + '       G.ITE_PRECOM, ';
    strSQL := strSQL + '       G.ITE_DESF01, ';
    strSQL := strSQL + '       G.ITE_DESF02, ';
    strSQL := strSQL + '       G.ITE_DESF03, ';
    strSQL := strSQL + '       G.ITE_DESF04, ';
    strSQL := strSQL + '       G.ITE_DESF05, ';
    strSQL := strSQL + '       G.ITE_DESF06, ';
    strSQL := strSQL + '       G.ITE_ICMENT, ';
    strSQL := strSQL + '       G.ITE_IPIENT, ';
    strSQL := strSQL + '       G.ITE_FREENT, ';
    strSQL := strSQL + '       G.ITE_ACRFIN, ';
    strSQL := strSQL + '       G.ITE_SUBSTI, ';
    strSQL := strSQL + '       G.ITE_VALFRE, ';
    strSQL := strSQL + '       G.ITE_DESADB, ';

    strSQL := strSQL + '       G.ITE_TCIFCU, ';
    strSQL := strSQL + '       G.ITE_TSCUST, ';
    strSQL := strSQL + '       G.ITE_DEPICO, ';
    strSQL := strSQL + '       G.ITE_DEICMS, ';
    strSQL := strSQL + '       G.ITE_FATREG, ';



    strSQL := strSQL + '      0.000 AS ITE_PRECUS1,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS2,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS3,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS4,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS5,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS6,';
    strSQL := strSQL + '      0.000 AS ITE_PRECUS7,';


    strSQL := strSQL + '      0.000 AS CUS_ICMSAI1,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED1,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED1,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE1,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL1,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI2,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED2,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED2,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE2,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL2,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI3,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED3,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED3,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE3,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL3,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI4,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED4,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED4,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE4,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL4,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI5,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED5,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED5,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE5,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL5,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI6,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED6,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED6,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE6,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL6,';
    strSQL := strSQL + '      0.000 AS CUS_ICMSAI7,';
    strSQL := strSQL + '      0.000 AS CUS_IMPFED7,';
    strSQL := strSQL + '      0.000 AS CUS_SUBFED7,';
    strSQL := strSQL + '      0.000 AS CUS_DESOPE7,';
    strSQL := strSQL + '      0.000 AS CUS_OUTVAL7, ';
    strSQL := strSQL + '       G.ITE_PREDOL, ';

    strSQL := strSQL + '       0.0000       AS PREVEN, ';
    strSQL := strSQL + '       0.0000       AS PREVEN_CNV, ';
    strSQL := strSQL + '       0.00         AS MARBRU, ';
    strSQL := strSQL + '       0.0000       AS TOTITE, ';
    strSQL := strSQL + '       0.0000       AS TOTCUS, ';
    strSQL := strSQL + '       0.0000       AS UNITAR, ';
    strSQL := strSQL + '       U.UNI_PESLIT AS PESLIT  ';

    strSQL := strSQL + '   FROM ';

    strSQL := strSQL + '     CADITE I ';
    strSQL := strSQL + '     INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';

    strSQL := strSQL + '     INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                            G.ITE_CODEMP = :EMPATU          ';

    strSQL := strSQL + '     LEFT JOIN SITPRO S ON S.SIT_CODIGO = I.ITE_SITPRO      ';

    strSQL := strSQL + '     LEFT JOIN GRPPRD ON GRPPRD.PRD_CODGRU = I.ITE_PRDGRU ';


    strSQL := strSQL + '   WHERE ';

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      strSQL := strSQL + '   G.ITE_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '   LOCATE(G.ITE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + '     AND I.ITE_ITEATI = "S"  ';

    strSql := strSQL + fStrLocate(edtFornecedor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');


    {*** fim do union para trazer os itens sem movimento do mesmo fornecedor que nao tem giro ***}

    strSQL1 := '';
    strSQL1 := strSQL1 + 'SELECT ';
    strSQL1 := strSQL1 + '  "C99999"   AS NVLFOR, ';
    strSQL1 := strSQL1 + '  0.0000     AS REPITE, ';
    strSQL1 := strSQL1 + '  0.0000     AS REPACU, ';
    strSQL1 := strSQL1 + '  COMGIR, ';
    strSQL1 := strSQL1 + '  CODFOR, ';
    strSQL1 := strSQL1 + '  FOR_NOMFOR AS NOMFOR, ';
    strSQL1 := strSQL1 + '  CODTAB, ';
    strSQL1 := strSQL1 + '  AUTDET, ';
    strSQL1 := strSQL1 + '  CODGRP, ';
    strSQL1 := strSQL1 + '  FORMULA, ';
    strSQL1 := strSQL1 + '  CALCULO, ';
    strSQL1 := strSQL1 + '  FORMULA1, ';
    strSQL1 := strSQL1 + '  CALCULO1, ';
    strSQL1 := strSQL1 + '  FORMULA2, ';
    strSQL1 := strSQL1 + '  CALCULO2, ';
    strSQL1 := strSQL1 + '  FORMULA3, ';
    strSQL1 := strSQL1 + '  CALCULO3, ';
    strSQL1 := strSQL1 + '  FORMULA4, ';
    strSQL1 := strSQL1 + '  CALCULO4, ';
    strSQL1 := strSQL1 + '  FORMULA5, ';
    strSQL1 := strSQL1 + '  CALCULO5, ';
    strSQL1 := strSQL1 + '  FORMULA6, ';
    strSQL1 := strSQL1 + '  CALCULO6, ';
    strSQL1 := strSQL1 + '  FORMULA7, ';
    strSQL1 := strSQL1 + '  CALCULO7, ';

    strSQL1 := strSQL1 + '  CODITE, ';
    strSQL1 := strSQL1 + '  CODFAB, ';
    strSQL1 := strSQL1 + '  DESITE, ';
    strSQL1 := strSQL1 + '  SITPRO, ';
    strSQL1 := strSQL1 + '  REFERE, ';
    strSQL1 := strSQL1 + '  ICMSAI, ';
    strSQL1 := strSQL1 + '  IMPFED, ';
    strSQL1 := strSQL1 + '  DESOPE, ';
    strSQL1 := strSQL1 + '  OUTVAL, ';
    strSQL1 := strSQL1 + '  ITE_TABPR1, ';
    strSQL1 := strSQL1 + '  ITE_TABPR2, ';
    strSQL1 := strSQL1 + '  ITE_TABPR3, ';
    strSQL1 := strSQL1 + '  ITE_TABPR4, ';
    strSQL1 := strSQL1 + '  ITE_TABPR5, ';
    strSQL1 := strSQL1 + '  ITE_TABPR6, ';
    strSQL1 := strSQL1 + '  ITE_TABPR7, ';
    strSQL1 := strSQL1 + '    ITE_PREVE1_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE2_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE3_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE4_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE5_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE6_OLD, ';
    strSQL1 := strSQL1 + '    ITE_PREVE7_OLD, ';

    strSQL1 := strSQL1 + '  ITE_PREVE1, ';
    strSQL1 := strSQL1 + '  ITE_PREVE2, ';
    strSQL1 := strSQL1 + '  ITE_PREVE3, ';
    strSQL1 := strSQL1 + '  ITE_PREVE4, ';
    strSQL1 := strSQL1 + '  ITE_PREVE5, ';
    strSQL1 := strSQL1 + '  ITE_PREVE6, ';
    strSQL1 := strSQL1 + '  ITE_PREVE7, ';

    strSQL1 := strSQL1 + '  ITE_PRECOM, ';
    strSQL1 := strSQL1 + '  ITE_DESF01, ';
    strSQL1 := strSQL1 + '  ITE_DESF02, ';
    strSQL1 := strSQL1 + '  ITE_DESF03, ';
    strSQL1 := strSQL1 + '  ITE_DESF04, ';
    strSQL1 := strSQL1 + '  ITE_DESF05, ';
    strSQL1 := strSQL1 + '  ITE_DESF06, ';
    strSQL1 := strSQL1 + '  ITE_ICMENT, ';
    strSQL1 := strSQL1 + '  ITE_IPIENT, ';
    strSQL1 := strSQL1 + '  ITE_FREENT, ';
    strSQL1 := strSQL1 + '  ITE_ACRFIN, ';
    strSQL1 := strSQL1 + '  ITE_SUBSTI, ';
    strSQL1 := strSQL1 + '  ITE_VALFRE, ';
    strSQL1 := strSQL1 + '  ITE_DESADB, ';

    strSQL1 := strSQL1 + '  ITE_TCIFCU, ';
    strSQL1 := strSQL1 + '  ITE_TSCUST, ';
    strSQL1 := strSQL1 + '  ITE_DEPICO, ';
    strSQL1 := strSQL1 + '  ITE_DEICMS, ';
    strSQL1 := strSQL1 + '  ITE_FATREG, ';


    strSQL1 := strSQL1 + '  ITE_PRECUS1,';
    strSQL1 := strSQL1 + '  ITE_PRECUS2,';
    strSQL1 := strSQL1 + '  ITE_PRECUS3,';
    strSQL1 := strSQL1 + '  ITE_PRECUS4,';
    strSQL1 := strSQL1 + '  ITE_PRECUS5,';
    strSQL1 := strSQL1 + '  ITE_PRECUS6,';
    strSQL1 := strSQL1 + '  ITE_PRECUS7,';

    strSQL1 := strSQL1 + '  CUS_ICMSAI1,';
    strSQL1 := strSQL1 + '  CUS_IMPFED1,';
    strSQL1 := strSQL1 + '  CUS_SUBFED1,';
    strSQL1 := strSQL1 + '  CUS_DESOPE1,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL1,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI2,';
    strSQL1 := strSQL1 + '  CUS_IMPFED2,';
    strSQL1 := strSQL1 + '  CUS_SUBFED2,';
    strSQL1 := strSQL1 + '  CUS_DESOPE2,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL2,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI3,';
    strSQL1 := strSQL1 + '  CUS_IMPFED3,';
    strSQL1 := strSQL1 + '  CUS_SUBFED3,';
    strSQL1 := strSQL1 + '  CUS_DESOPE3,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL3,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI4,';
    strSQL1 := strSQL1 + '  CUS_IMPFED4,';
    strSQL1 := strSQL1 + '  CUS_SUBFED4,';
    strSQL1 := strSQL1 + '  CUS_DESOPE4,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL4,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI5,';
    strSQL1 := strSQL1 + '  CUS_IMPFED5,';
    strSQL1 := strSQL1 + '  CUS_SUBFED5,';
    strSQL1 := strSQL1 + '  CUS_DESOPE5,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL5,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI6,';
    strSQL1 := strSQL1 + '  CUS_IMPFED6,';
    strSQL1 := strSQL1 + '  CUS_SUBFED6,';
    strSQL1 := strSQL1 + '  CUS_DESOPE6,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL6,';
    strSQL1 := strSQL1 + '  CUS_ICMSAI7,';
    strSQL1 := strSQL1 + '  CUS_IMPFED7,';
    strSQL1 := strSQL1 + '  CUS_SUBFED7,';
    strSQL1 := strSQL1 + '  CUS_DESOPE7,';
    strSQL1 := strSQL1 + '  CUS_OUTVAL7, ';
    strSQL1 := strSQL1 + '  ITE_PREDOL, ';




    strSQL1 := strSQL1 + '  COMTBL, ';
    strSQL1 := strSQL1 + '  CNVCUS, ';
    strSQL1 := strSQL1 + '  ATUPRO, ';

    strSQL1 := strSQL1 + '  PRECUS, ';
    strSQL1 := strSQL1 + '  PRECUS_CNV, ';
    strSQL1 := strSQL1 + '  PREVEN, ';
    strSQL1 := strSQL1 + '  PREVEN_CNV, ';
    strSQL1 := strSQL1 + '  MARBRU, ';

    strSQL1 := strSQL1 + '  ROUND(:FATREV * ROUND(PREVEN, 2), 2) AS PREREV, ';
    strSQL1 := strSQL1 + '  ROUND(:FATREV * ROUND(PREVEN_CNV, 2), 2) AS PREREV_CNV, ';

    strSQL1 := strSQL1 + '  SUM(VALEST) AS VALEST, ';
    strSQL1 := strSQL1 + '  SUM(SALEST) AS SALEST, ';
    strSQL1 := strSQL1 + '  SUM(TOTCUS) AS TOTCUS, ';
    strSQL1 := strSQL1 + '  SUM(TOTITE) AS TOTITE, ';
    strSQL1 := strSQL1 + '  SUM(QTDITE) AS QTDITE, ';
    strSQL1 := strSQL1 + '  SUM(TOTITE) / SUM(QTDITE) AS VALUNI, ';
    strSQL1 := strSQL1 + '  (PESLIT * SUM(QTDITE)) AS PESLIT, ';
    strSQL1 := strSQL1 + '  "'+StringOfChar(' ', 100)+'" AS DESGRU';

    strSQL1 := strSQL1 + '  FROM ';
    strSQL1 := strSQL1 + '  ( ' + strSQL + ' ) AS TABTOTAL ';

    strSQL1 := strSQL1 + '  INNER JOIN CADFOR ON FOR_CODFOR = CODFOR ';

    strSQL1 := strSQL1 + ' GROUP BY ';
    strSQL1 := strSQL1 + '   CODITE ';
    strSQL1 := strSQL1 + ' ORDER BY ';

    If edtOrdem.Text = 'Q' Then
      strSQL1 := strSQL1 + '  QTDITE DESC, TOTITE DESC '
    Else If edtOrdem.Text = 'V' Then
      strSQL1 := strSQL1 + '  TOTITE DESC, QTDITE DESC '
    Else If edtOrdem.Text = 'L' Then
      strSQL1 := strSQL1 + '  PESLIT DESC, TOTITE DESC ';

    With cdsItens.qryQuery Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL1);
    End;

    strSQLGroupCODGRP :=  strSQLGroupCODGRP + strSQL1 + ') GRP GROUP BY CODGRP';

    pAbreConsulta(cdsItens.qryQuery);
    cdsItens.fLeDados('TfrmCalNivGirEstFornecedor.pCalcula');

    pFormataCamposItens(cdsItens);

    If Not cdsItens.IsEmpty Then
    Begin
      If rdgGerNiv.ItemIndex = 1 Then
        pTotalizarGrupoProduto(cdsItens);

      If rdgGerNiv.ItemIndex = 1 Then
        pInsereTodosGrupos(strSQLGroupCODGRP);

      cdsItens.AggregatesActive := True;

      pgbStatus.Max := 2 * cdsItens.RecordCount;

      pgbStatus.Position := 0;
      pgbStatus.Visible  := True;

      fltNivA  := ceValNiA.Value;
      fltNivB2 := ceValNB2.Value;
      fltNivC  := ceValNiC.Value;

      qryUpd := fCriaQuery;

      pAbreFornecedores;

      While Not qryCadFor.Eof Do
      Begin
        pNivelFornecedor;
        qryCadFor.Next;
      End;



      cdsItens.Filtered        := False;
      cdsItens.Filter := '';
      cdsItens.IndexFieldNames := 'CODFOR;NVLFOR;REPACU';
      cdsItens.First;
      cdsItens.EnableControls;
      If (rdgGerNiv.ItemIndex = 0) And (cdsCadGrp.IsEmpty) Then
        pInsereGrupo('');

      pCriarFormularios(TfrmCalNivGirEstFornecGrid, frmCalNivGirEstFornecGrid);
      frmCalNivGirEstFornecGrid.dtsItens.DataSet := cdsItens;
      frmCalNivGirEstFornecGrid.strCodFor := edtFornecedor.Text;
      frmCalNivGirEstFornecGrid.strCodTab := '';
      frmCalNivGirEstFornecGrid.strDtaIni := mskDtaIni.Text;
      frmCalNivGirEstFornecGrid.strDtaFin := mskDtaFin.Text;
      frmCalNivGirEstFornecGrid.strEmpAtu := strEmpAtu;
      frmCalNivGirEstFornecGrid.blnPorGru := rdgGerNiv.ItemIndex = 1;
      frmCalNivGirEstFornecGrid.cdsCadGrp := cdsCadGrp;

      frmCalNivGirEstFornecGrid.ShowModal;

      FreeAndNil(frmCalNivGirEstFornecGrid);

      cdsItens.AfterPost := Nil;
      cdsItens.IndexFieldNames := '';

      pSetFocus(mskDtaIni);
    End
    Else
    Begin
      fMensagem('','Não há dados para calcular o Nível do Giro de Estoque.', ['&O K']);
      pSetFocus(mskDtaIni);
    End;

  Finally
    btnConfirma.Enabled  := True;
    btnSair.Enabled := True;
    pgbStatus.Visible := False;
    FreeAndNil(qryUpd);
    FreeAndNil(cdsItens);
  End;

  pnlInfo.Caption   := '';
  Application.ProcessMessages;
end;

procedure TfrmCalNivGirEstFornecedor.btnConfirmaClick(Sender: TObject);
begin
//  inherited;

  pCalcula;
end;

procedure TfrmCalNivGirEstFornecedor.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    pCalcula;
end;

procedure TfrmCalNivGirEstFornecedor.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmCalNivGirEstFornecedor.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmCalNivGirEstFornecedor.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;


Function TfrmCalNivGirEstFornecedor.fSQLGrupos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   PRD_CODGRU AS CODGRP, ';
  Result := Result + '   PRD_DESGRU AS DESGRP, ';
  Result := Result + '   0.00       AS MKPNVA, ';
  Result := Result + '   0.00       AS MKPNVB, ';
  Result := Result + '   0.00       AS MKPNVC  ';
  Result := Result + ' FROM                    ';
  Result := Result + '   GRPPRD                ';
  Result := Result + ' WHERE                   ';
  Result := Result + '   FALSE                 ';
End;

function TfrmCalNivGirEstFornecedor.fTemPrincipal(ACodFor: string): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADITE WHERE ITE_CODFOR = "'+ ACodFor + '"');
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmCalNivGirEstFornecedor.FormCreate(Sender: TObject);
begin
  inherited;

  qryCadFor := fCriaQuery(Self);

  cdsCadGrp := TZClient.Create(Self, fSQLGrupos);

  cdsCadGrp.fAbreClient(True, 'TfrmCalNivGirEstFornecedor.FormCreate');
  cdsCadGrp.IndexFieldNames := 'CODGRP';
end;

procedure TfrmCalNivGirEstFornecedor.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  pSetFocus(mskDtaIni);
end;

function TfrmCalNivGirEstFornecedor.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

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

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS'
      End
      Else
      Begin

        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
          Result := False;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrFornec);

      If fEmptyStr(edtFornecedor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código do Fornecedor!', ['&O k']);
        Result := False;
      End;

      If Result Then
      If Not fTemPrincipal(edtFornecedor.Text) then
      Begin
        fMensagem('ATENÇÃO!', 'Não exite item com este Fornecedor como Principal!', ['&O k']);
        Result := False;
      End


    End

    {******************************}
    {* VALIDA ORDEM               *}
    {***************************LU*}
    Else If (Sender = edtOrdem) Then
    Begin
      If (edtOrdem.Text <> 'Q') And (edtOrdem.Text <> 'V') And (edtOrdem.Text <> 'L') Then
      Begin
        fMensagem('ATENÇÃO!','O campo ordem (Q)uantidade / (V)alor / (L)itragem deve ser Q, V ou L!',['&O K']);
        Result := False;
      End;
    End
    {******************************}
    {* VALIDA OOS NIVEIS          *}
    {***************************LU*}
    Else If (Sender = ceValNiA) Then
    Begin
      If fEmptyStr(ceValNiA.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível A deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
        ceValNB1.Text := FloatToStr(fStrToFloat(ceValNiA.Text) + 0.01);
    End
    Else If (Sender = ceValNB1) Then
    Begin
      If fEmptyStr(ceValNB1.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual inicial do nível B deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = ceValNB2) Then
    Begin
      If fEmptyStr(ceValNB2.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual final do nível B deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        ceValNiC.Text := FloatToStr(fStrToFloat(ceValNB2.Text));
      End;
    End
    Else If (Sender = ceValNiC) Then
    Begin
      If fEmptyStr(ceValNiC.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível C deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.

