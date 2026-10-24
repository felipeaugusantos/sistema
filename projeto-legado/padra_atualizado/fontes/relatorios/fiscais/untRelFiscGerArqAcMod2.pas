unit untRelFiscGerArqAcMod2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, Menus, Buttons, untIZClient,
  ExtCtrls, DirectoryEditFocus, StrUtils, AppEvnts, untExcel, DB, untTypesSistema, untIFuncoes,
  ComObj, ComCtrls, BitBtnLockedIncrem, Provider, uni, untFuncoesGenerica, untGeraExcel, untClassPanelCx,
  frxClass, frxExportCSVTestabilidade, UniClientDataSet, UniDataSetProvider,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmRelFiscGerArqAcMod2 = class(TfrmPai)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPathExp: TLabel;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    pgbItem: TProgressBar;
    lbl4: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    chkInfAdi: TCheckBox;
    chkSoResumo: TCheckBox;
    fraPathExp: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);

    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    strNroCef: String;

    blnDeuErro: Boolean;

    cdsResumoItem : IZClient;
    cdsCreditoIcms: IZClient;
    cdsResumoQuadro4: IZClient;

    FPais: TPais;
    arrProduto: TConsultasArray;

    strCliAti: String;

    strArqInv,
    strEstEmp,
    strEmpIES: String;

    qryInventario: TUniQuery;

    cdsEntrada: IZClient;
    cdsSaida  : IZClient;
    cdsItens  : IZClient;

    cdsCadAbf,
    cdsEntSai,
    cdsCodSit: IZClient;

    Function fSaidaSaiNoRel: Boolean;
    Function fRetCodAbf(strCodIte: String): String;
    Function fSQLResumoItem: String;
    Function fSQLCreditoICMS: String;

    function fGetSitTributariaEstadoEmpresa(strCodAbf: String): String;
    Function fRetDescTipFor(strTipFor: String): String;

    Function  fRetSaldoInventario(strCodIte: String; Var fltPreUlt: Double): Double;

    procedure pCriaClientResumoItem;
    procedure pCriaClientCreditoIcms;
    procedure pMontaCreditoICMS;

    procedure pMontaResumoQuadro4;
    procedure pSomaResumoQuadro4(strCnpDes, strUnFDes, strNumDoc: String;
        dtaDtaEnt: Tdate; fltBasIcm, fltValIcm, fltBasRet, fltValRet: Double);

    procedure pMontaResumoQuadro04(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);

    procedure pSomaTotaisResumoQuadro04(Var Totais: TTotais; Dados: TDataSet);

    procedure pCriaClientResumoQuadro04;

    procedure pCriaEntSai;
    procedure pCriaCodSit;
    procedure pCriaCadAbf;

    procedure pMontaResumoExcel;

    procedure pSomaTotaisResumo(Var Totais: TTotais; Dados: TDataSet);
    procedure pSomaTotaisCredito(Var Totais: TTotais; Dados: TDataSet);

    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pMontaResumoCredito(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);

    procedure pRetDadosAbfICMS(    strTip_FC,
                                   strCodAbf,
                                   strEstado,
                                   strIES,
                                   strTipFor,
                                   strConsum,
                                   strCodAti,
                                   strProRur,
                                   strMicEmp,
                                   strRegTri,
                                   strIndust,
                                   strFilial: String;
                                   blnPesJur: Boolean;
                               Var fltAlqIcm,
                                   fltAlqRet,
                                   fltValIva,
                                   fltPerBas,
                                   fltPeBaST: Double;
                               Var strCodSit: String );

    procedure pCalculaSubTributariaEntrada( strEstado,
                                            strIES,
                                            strTipFor,
                                            strConsum,
                                            strCodAti,
                                            strProRur,
                                            strMicEmp,
                                            strRegTri,
                                            strPesJur,
                                            strCodIte,
                                            strCodAbf: String;
                                            fltTotIte,
                                            fltTotFre,
                                            fltDesEsp,
                                            fltIpiEnt: Double;
                                        Var fltBasRet,
                                            fltAlqRet,
                                            fltValRet,
                                            fltBasIcm,
                                            fltValIcm,
                                            fltAlqIcm,
                                            fltValIVA,
                                            fltValIpi: Double;
                                            blnEntrad: Boolean);

    procedure pNotasSaidas(qryDados: IZClient; blnProdutos: Boolean);

    Procedure pGetValProporcional(    strCodIte,
                                      strAutSai,
                                      strInvent: String;
                                      fltQtdIte: Double;
                                  Var fltBasRet,
                                      fltValRet,
                                      fltBasIcm,
                                      fltValIcm,
                                      fltPriAlq,
                                      fltValIPI,
                                      fltValFre: Double;
                                  Var strNFEntr: String);

    Function fNotasEntrada: Boolean;

    procedure pGeraNotasEntrada;

    procedure pSomaResumoItem(strCodIte: String; fltIcmDen, fltIcmFor: Double);
    procedure pSomaCreditoItem(strCodIte, strNumDoc, strQuadro: String; fltCreIcm: Double);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmRelFiscGerArqAcMod2: TfrmRelFiscGerArqAcMod2;

implementation

uses  untFuncoesSimples, untConsultas, untFuncoesConsulta, untConstantes, Math,
      untZClient;

{$R *.dfm}

Const
  STR_ESPECIES = '''NF'',''EL'',''D1'',''IF'',''NV'',''IV''';


procedure TfrmRelFiscGerArqAcMod2.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
  blnDeuErro := False;

  strNroCef := fCfgSis('NROCEF');

  strCliAti :=  fCfgSis('CLIATI');

  FPais := fSetaPais;

  qryInventario := fCriaQuery(Self);

  cdsEntrada    := TZClient.Create(Self);
  cdsSaida      := TZClient.Create(Self);
  cdsItens      := TZClient.Create(Self);

  cdsEntSai := TZClient.Create(Self);
  cdsCodSit := TZClient.Create(Self);
  cdsCadAbf := TZClient.Create(Self);
  pCriaEntSai;
  pCriaCodSit;
  pCriaCadAbf;

  strArqInv     := fCfgSis('ARQINV');

  pCriaClientResumoItem;
  pCriaClientCreditoIcms;
  pCriaClientResumoQuadro04;
end;

procedure TfrmRelFiscGerArqAcMod2.FormPaint(Sender: TObject);
begin
  inherited;
  If blnDeuErro Then
    Close;
end;

procedure TfrmRelFiscGerArqAcMod2.pCriaEntSai;
Begin
  With cdsEntSai Do
  Begin
    qryQuery.SQL.Add('SELECT ');
    qryQuery.SQL.Add('  "N"        AS UTILIZ,  ');
    qryQuery.SQL.Add('  "' + fStrZero('0', fTamCodIte) + '"    AS CODITE, ');
    qryQuery.SQL.Add('  0.0000     AS QTDITE, ');
    qryQuery.SQL.Add('  0.0000     AS PREULT, ');
    qryQuery.SQL.Add('  0.0000     AS IPIENT, ');
    qryQuery.SQL.Add('  "00000"    AS CODABF, ');
    qryQuery.SQL.Add('  AUTOINCREM AS AUTENT, ');
    qryQuery.SQL.Add('  AUTOINCREM AS AUTSAI  ');
    qryQuery.SQL.Add('FROM                    ');
    qryQuery.SQL.Add('  MOVDET                ');
    qryQuery.SQL.Add('WHERE                   ');
    qryQuery.SQL.Add('  FALSE                 ');

    fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaEntSai');
  End;

End;

procedure TfrmRelFiscGerArqAcMod2.pCriaCodSit;
Begin
  With cdsCodSit, qryQuery.SQL Do
  Begin
    Add('SELECT ');
    Add('  ABF_CODABF, ');
    Add('  ABF_ESTADO, ');
    Add('  ABF_CODSIT_SAI_CCO ');
    Add('FROM ');
    Add('  ABFICM ');
    Add('WHERE ');
    Add('  FALSE ');

    fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaCodSit');

  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pCriaCadAbf;
Begin
  With cdsCadAbf, qryQuery.SQL Do
  Begin
    Add('SELECT ');
    Add(' * ');
    Add('FROM ');
    Add('  ABFICM ');

    Add('WHERE ');
    Add('  FALSE ');

    fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaCadAbf');

  End;
End;



procedure TfrmRelFiscGerArqAcMod2.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  fraPathExp.edtDirectory.text := ExtractFilePath(Application.ExeName) + 'Acordo_SEFAZ_' + AnsiReplaceStr(strNroCef, '/', '_');

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscGerArqAcMod2.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFiscGerArqAcMod2.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos, edtDesProduto, arrProduto, Nil, fRetNomProduto, 'do Produto');

end;

procedure TfrmRelFiscGerArqAcMod2.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If Not fValidaCampos(edtProdutos, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFiscGerArqAcMod2.edtCodEmpresaExit(Sender: TObject);
  Var
    arrEmp : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
  If fEmptyStr(edtCodEmpresa.Text) Then edtDesEmpresa.Clear;
end;

procedure TfrmRelFiscGerArqAcMod2.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
end;

procedure TfrmRelFiscGerArqAcMod2.pRetDadosAbfICMS(    strTip_FC,
                                                       strCodAbf,
                                                       strEstado,
                                                       strIES,
                                                       strTipFor,
                                                       strConsum,
                                                       strCodAti,
                                                       strProRur,
                                                       strMicEmp,
                                                       strRegTri,
                                                       strIndust,
                                                       strFilial: String;
                                                       blnPesJur: Boolean;
                                                   Var fltAlqIcm,
                                                       fltAlqRet,
                                                       fltValIva,
                                                       fltPerBas,
                                                       fltPeBaST: Double;
                                                   Var strCodSit: String );
  Var
    qryAux: TUniQuery;
    strTipAbf: String;
    intContador: Integer;
begin
  If cdsCadAbf.Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([strCodAbf, strEstado]), []) Then
  Begin

  End Else
  Begin
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add(' * ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  ABFICM ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  ABF_CODABF = :CODABF AND ');
    qryAux.SQL.Add('  ABF_ESTADO = :ESTADO ');

    qryAux.ParamByName('CODABF').AsString := strCodAbf;
    qryAux.ParamByName('ESTADO').AsString := strEstado;

    qryAux.Open;

    cdsCadAbf.Insert;

    For intContador := 0 To qryAux.Fields.Count - 1 Do
      cdsCadAbf.Fields[intContador].Value := qryAux.Fields[intContador].Value;

    cdsCadAbf.Post;

    FreeAndNil(qryAux);
  End;

  With cdsCadAbf Do
  Begin
    strTipAbf := fGetTipoAbf(strTip_FC, IfThen(blnPesJur, 'J', 'F'), strIES, strConsum, strCodAti, strProRur,
                             strMicEmp, strRegTri, strTipFor, strIndust, strFilial);

    fltValIva := FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat;
    fltAlqIcm := FieldByName('ABF_ALQICM' + strTipAbf).AsFloat;
    fltAlqRet := FieldByName('ABF_ALQRET' + strTipAbf).AsFloat;
    fltPerBas := FieldByName('ABF_BASICM' + strTipAbf).AsFloat;
    fltPeBaST := FieldByName('ABF_BASRET' + strTipAbf).AsFloat;

    strCodSit := FieldByName('ABF_CODSIT' + strTipAbf).AsString;
  End;

end;

function TfrmRelFiscGerArqAcMod2.fGetSitTributariaEstadoEmpresa(strCodAbf: String): String;
  Var
    qryAux: TUniQuery;
begin
  If cdsCodSit.Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([strCodAbf, strEstEmp]), []) Then
  Begin
    Result := cdsCodSit.FieldByName('ABF_CODSIT_SAI_CCO').AsString;
  End Else
  Begin
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('SELECT SQL_NO_CACHE');
    qryAux.SQL.Add('  ABF_CODSIT_SAI_CCO ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  ABFICM ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  ABF_CODABF = :CODABF AND ');
    qryAux.SQL.Add('  ABF_ESTADO = :ESTADO ');

    qryAux.ParamByName('CODABF').AsString := strCodAbf;
    qryAux.ParamByName('ESTADO').AsString := strEstEmp;

    qryAux.Open;

    Result := qryAux.FieldByName('ABF_CODSIT_SAI_CCO').AsString;

    With cdsCodSit Do
    Begin
      Insert;
      FieldByName('ABF_CODSIT_SAI_CCO').AsString := qryAux.FieldByName('ABF_CODSIT_SAI_CCO').AsString;
      FieldByName('ABF_CODABF').AsString         := strCodAbf;
      FieldByName('ABF_ESTADO').AsString         := strEstEmp;
      Post;
    End;

    FreeAndNil(qryAux);
  End;

end;

procedure TfrmRelFiscGerArqAcMod2.pCalculaSubTributariaEntrada(    strEstado,
                                                                   strIES,
                                                                   strTipFor,
                                                                   strConsum,
                                                                   strCodAti,
                                                                   strProRur,
                                                                   strMicEmp,
                                                                   strRegTri,
                                                                   strPesJur,
                                                                   strCodIte,
                                                                   strCodAbf: String;
                                                                   fltTotIte,
                                                                   fltTotFre,
                                                                   fltDesEsp,
                                                                   fltIpiEnt: Double;
                                                               Var fltBasRet,
                                                                   fltAlqRet,
                                                                   fltValRet,
                                                                   fltBasIcm,
                                                                   fltValIcm,
                                                                   fltAlqIcm,
                                                                   fltValIVA,
                                                                   fltValIpi: Double;
                                                                   blnEntrad: Boolean);
  Var
    strCodSit: String;
    fltBasIpi: Double;

    fltPerBas: Double;
    fltPeBaST: Double;
begin
  fltTotIte := fltTotIte - fltDesEsp;

  pRetDadosAbfICMS(ifThen(blnEntrad, 'F', 'C'), strCodAbf, strEstado, strIES, strTipFor,
    strConsum, strCodAti, strProRur, strMicEmp, strRegTri, '', '', (strPesJur = 'S'), fltAlqIcm, fltAlqRet, fltValIva,
    fltPerBas, fltPeBaST, strCodSit);

  strCodSit := fGetSitTributariaEstadoEmpresa(strCodAbf);//Deve olhar se a saída do produto é ST e não a entrada

  fltBasIpi := fltTotIte;
  fltValIpi := fFormataFloat(fltBasIpi * (fltIpiEnt / 100), 2);

  If fltValIpi <= 0 Then
  Begin
    fltValIpi := 0;
  End;

  fltBasIcm := fFormataFloat(fltTotIte * (fltPerBas / 100), 2);
  fltValIcm := fFormataFloat(fltBasIcm * (fltAlqIcm / 100), 2);

  If fltValIcm <= 0 Then
  Begin
    fltBasIcm := 0;
    fltAlqIcm := 0;
    fltValIcm := 0;
  End;

  If Pos(strCodSit, CST_SUBSTITUICAO) > 0 Then
  Begin
    fltBasRet := fFormataFloat((fltTotIte + fltTotFre + fltValIpi) * (fltPeBaST / 100) * fltValIva, 2);
    fltValRet := fFormataFloat(fltBasRet * (fltAlqRet / 100) - fltValIcm, 2);
  End
  Else
    fltValRet := 0;

  If fltValRet <= 0 Then
  Begin
    fltBasRet := 0;
    fltAlqRet := 0;
    fltValRet := 0;
  End;

end;

Function TfrmRelFiscGerArqAcMod2.fNotasEntrada: Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE            ';
  strSQL := strSQL + '       D.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '       D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       D.DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '       D.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       D.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       D.DET_QTDITE AS QTDITE, ';

  strSQL := strSQL + '       D.DET_QTDITE AS QTDDIS, ';

  strSQL := strSQL + '       "N"          AS UTILIZ, ';

  strSQL := strSQL + '       D.DET_QTDEMB AS QTDEMB, ';
  strSQL := strSQL + '       D.DET_ALQICM AS ALQICM, ';
  strSQL := strSQL + '       D.DET_TOTITE AS TOTITE, ';
  strSQL := strSQL + '       D.DET_DESESP AS DESESP, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '     C.ITE_CODABF AS CODABF, '
  Else
    strSQL := strSQL + '     I.ITE_CODABF AS CODABF, ';

  strSQL := strSQL + '       ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '       D.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       D.DET_VALICM AS VALICM, ';

  strSQL := strSQL + '       (D.DET_BASRET + IFNULL(T.DET_BAERET, 0)) AS BASRET, ';
  strSQL := strSQL + '       (D.DET_VALRET + IFNULL(T.DET_VAERET, 0)) AS VALRET, ';

  strSQL := strSQL + '       (D.DET_TOTFRE + IFNULL(T.DET_CONFRE, 0)) AS TOTFRE, ';

  strSQL := strSQL + '       FOR_C_G_C_ AS FORCGC, ';
  strSQL := strSQL + '       FOR_I_E_S_ AS FORIES, ';
  strSQL := strSQL + '       FOR_MATREV AS TIPFOR, ';
  strSQL := strSQL + '       IF(FOR_CGCCPF = 1, "S", "N") AS PESJUR ';

  strSQL := strSQL + '  FROM ';

  strSQL := strSQL + '    MOVDET D ';

  strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ';

  strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  INNER JOIN ITEGER I ON I.ITE_CODITE = D.DET_CODITE AND I.ITE_CODEMP = D.DET_CODEMP ';

  strSQL := strSQL + '  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  WHERE ';

  strSQL := strSQL + '    D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    RIGHT(D.DET_CLAFIS,3) <> "929" AND ';
  strSQL := strSQL + '    D.DET_ESPDOC IN (' + STR_ESPECIES + ') AND ';
  strSQL := strSQL + '    LEFT(D.DET_CLAFIS, 1) < "5" AND ';

  strSQL := strSQL + '    D.DET_DTAENT >= :DTAENT ';

  If Not fEmptyStr(edtProdutos.Text) Then
    strSQL := strSQL + '  AND D.DET_CODITE = :ITESEL ';

  strSQL := strSQL + '  ORDER BY DTADOC, NUMDOC ';

  With cdsEntrada  Do
  Begin
    qryQuery.SQL.Text := strSQL;

    qryQuery.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtProdutos.Text) Then
      qryQuery.ParamByName('ITESEL').AsString := edtProdutos.Text;

    qryQuery.ParamByName('DTAENT').AsDate := fCfgSis('DTAINV', varDate);

    Result := fAbreClient(True, 'pNotasEntrada');

  End;

  cdsEntrada.IndexFieldNames := 'DTADOC;NUMDOC';
  cdsEntrada.First;

end;

procedure TfrmRelFiscGerArqAcMod2.pNotasSaidas(qryDados: IZClient; blnProdutos: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '       "N"          AS INVENT, ';
  strSQL := strSQL + '       S.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '       S.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       ITE_IPIENT   AS IPIENT, ';
  strSQL := strSQL + '       ITE_PREULT   AS PREULT, ';


  strSQL := strSQL + '       B.ABF_CODABF AS CODABF, ';
  strSQL := strSQL + '       CLI_C_G_C_   AS CLICGC, ';
  strSQL := strSQL + '       CLI_I_E_S_   AS I_E_S_, ';
  strSQL := strSQL + '       CLI_CODATI   AS CODATI, ';
  strSQL := strSQL + '       CLI_PRORUR   AS PRORUR, ';
  strSQL := strSQL + '       CLI_MICEMP   AS MICEMP, ';
  strSQL := strSQL + '       CLI_REGTRI   AS REGTRI, ';
  strSQL := strSQL + '       CLI_CONSUM   AS CLICON, ';
  strSQL := strSQL + '       CLI_INDUST   AS INDUST, ';
  strSQL := strSQL + '       CLI_CODCLI   AS CODCLI, ';

  strSQL := strSQL + '       IF(CLI_CGCCPF = 1, "S", "N") AS PESJUR, ';

  strSQL := strSQL + '       IFNULL(CLI_ART534, "N") AS ART534, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       S.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       S.DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '       S.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       S.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       S.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       S.DET_BASRET AS BASRET, ';
  strSQL := strSQL + '       S.DET_VALRET AS VALRET, ';
  strSQL := strSQL + '       S.DET_TOTITE AS TOTITE, ';
  strSQL := strSQL + '       S.DET_DESESP AS DESESP, ';
  strSQL := strSQL + '       S.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       S.DET_VALICM AS VALICM, ';
  strSQL := strSQL + '       S.DET_PROEMB AS PROEMB, ';
  strSQL := strSQL + '       S.DET_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '       ROUND((S.DET_BASICM * 12)/100, 2) AS ICM12, ';
  strSQL := strSQL + '       ROUND((S.DET_BASICM *  1)/100, 2) AS ICM01, ';

  strSQL := strSQL + '       IF(S.DET_DTAENT >= :INIPER, "S", "N") AS FILDTA ';

  strSQL := strSQL + '  FROM MOVDET S ';

  strSQL := strSQL + '       JOIN MOVTRI T ON T.DET_SEQGER = S.AUTOINCREM ';

  strSQL := strSQL + '       JOIN CADITE D ON D.ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + '       JOIN ITEGER I ON I.ITE_CODITE = DET_CODITE AND I.ITE_CODEMP = DET_CODEMP ';

  strSQL := strSQL + '       JOIN CADCLI C ON CLI_CODCLI = S.DET_CODCLI ';
  strSQL := strSQL + '       JOIN CADCID CI ON CID_CODCID = CLI_CODCID ';

  If fCfgSis('TIPABF') = '1' Then
  Begin
    strSQL := strSQL + '       LEFT JOIN ABFICM A ON A.ABF_CODABF = D.ITE_CODABF AND A.ABF_ESTADO = :ESTADO ';
    strSQL := strSQL + '       LEFT JOIN ABFICM B ON B.ABF_CODABF = D.ITE_CODABF AND B.ABF_ESTADO = CI.CID_ESTADO '
  End Else
  Begin
    strSQL := strSQL + '       LEFT JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF AND A.ABF_ESTADO = :ESTADO ';
    strSQL := strSQL + '       LEFT JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND B.ABF_ESTADO = CI.CID_ESTADO ';
  End;

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   (LOCATE(A.ABF_CODSIT_SAI_CCO, "'+ CST_SUBSTITUICAO +'") > 0 ) AND ';
  strSQL := strSQL + '   S.DET_PROEMB <> "S" AND';
  strSQL := strSQL + '   S.DET_TIP_FC = "C" AND ';
  strSQL := strSQL + '   S.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   S.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '   LEFT(S.DET_CLAFIS, 1) >= "5" AND ';
  strSQL := strSQL + '   RIGHT(S.DET_CLAFIS,3) <> "929" AND ';
  strSQL := strSQL + '   S.DET_ESPDOC IN (' + STR_ESPECIES + ') ';

  If Not fEmptyStr(edtProdutos.Text) Then
    strSQL := strSQL + '  AND S.DET_CODITE = :ITESEL ';

  If blnProdutos Then
    strSQL := strSQL + '  GROUP BY S.DET_CODITE ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSQL := strSQL + '  ORDER BY DTADOC, NUMDOC ';

  With qryDados, qryQuery Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    ParamByName('INIPER').AsDate := StrToDate(mskDtaIni.Text);

    ParamByName('DTAINI').AsDate   := fCfgSis('DTAINV', varDate);

    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('ESTADO').AsString := fRetUFEmpresa(edtCodEmpresa.Text);

    If Not fEmptyStr(edtProdutos.Text) Then
      ParamByName('ITESEL').AsString := edtProdutos.Text;

    fAbreClient(True, 'pNotasSaidas');
  End;

  qryDados.IndexFieldNames := 'DTADOC;NUMDOC';
  qryDados.First;
end;

function TfrmRelFiscGerArqAcMod2.fValidaCampos(Sender: TWinControl;
           blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave )) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Final deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser menor que a Data Final!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO','O código da empresa deve ser preenchido!',['&OK']);
        Result := False;
      End;

    End

    Else
    If (Sender  = fraPathExp) Then
    Begin

      If fEmptyStr(fraPathExp.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO','O Path para geração do arquivo deve ser preenchido!', ['&OK']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelFiscGerArqAcMod2.fSaidaSaiNoRel: Boolean;
Begin
  Result := False;

  If cdsSaida.FieldByName('FILDTA').AsString = 'S' Then
  Begin

    If Not (
        // QUADRO 05
        (Not (((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
            (cdsSaida.FieldByName('ART534').AsString = 'N')) And
            (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0))) And

        // QUADRO 06
        (Not (((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
             (cdsSaida.FieldByName('VALRET').AsFloat <> 0)) And
             (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0))) And

        // QUADRO 07
        (Not (((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
             (cdsSaida.FieldByName('ART534').AsString = 'S')) And
             (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0))) And

        // QUADRO 08
        (Not (((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
            (cdsSaida.FieldByName('CLICON').AsString = 'S') And
            (cdsSaida.FieldByName('VALRET').AsFloat = 0)) And
            (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0))) ) Then

     Result := True;
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pGeraNotasEntrada;
  Var
    fltSaldos: Double;
    fltQtdSai: Double;
    fltQtdUsu: Double;
    fltPreUlt: Double;
Begin

  With cdsItens Do
  Begin
    First;

    pgbProgresso.Position := 0;
    pgbProgresso.Max      := RecordCount;

    While Not Eof Do
    Begin
      fltSaldos := fRetSaldoInventario(FieldByName('CODITE').AsString, fltPreUlt);

      cdsSaida.Filter   := 'CODITE = ' + QuotedStr(FieldByName('CODITE').AsString);
      cdsSaida.Filtered := True;
      cdsSaida.First;

      cdsEntrada.Filter   := 'CODITE = ' + QuotedStr(FieldByName('CODITE').AsString);
      cdsEntrada.Filtered := True;
      cdsEntrada.First;

      While Not cdsSaida.Eof Do
      Begin
        fltQtdSai := cdsSaida.FieldByName('QTDITE').AsFloat;

        If fltSaldos > 0 Then
        Begin

          If fltSaldos > fltQtdSai Then
          Begin
            fltSaldos := fltSaldos - fltQtdSai;
            fltQtdUsu := fltQtdSai;
            fltQtdSai := 0;
          End Else
          Begin
            fltQtdUsu := fltSaldos;
            fltQtdSai := fltQtdSai - fltSaldos;
            fltSaldos := 0;
          End;

          cdsEntSai.Filtered := False;
          If Not cdsEntSai.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
          Begin
            cdsEntSai.Insert;
            cdsEntSai.FieldByName('QTDITE').AsFloat  := 0;
            cdsEntSai.FieldByName('IPIENT').AsFloat  := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('CODITE').AsString, edtCodEmpresa.Text]);

            If fCfgSis('TIPABF') = '1' Then
              cdsEntSai.FieldByName('CODABF').AsString := fCampoTabela('ITE_CODABF', 'CADITE', ['ITE_CODITE'], [FieldByName('CODITE').AsString])
            Else
              cdsEntSai.FieldByName('CODABF').AsString := fCampoTabela('ITE_CODABF', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('CODITE').AsString, edtCodEmpresa.Text]);

            cdsEntSai.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
          End Else
          Begin
            cdsEntSai.Edit;
          End;

          If (((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
               (cdsSaida.FieldByName('ART534').AsString = 'N')) Or

              ((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
               (cdsSaida.FieldByName('VALRET').AsFloat = 0) And
               (cdsSaida.FieldByName('CLICON').AsString = 'N')) Or

               ((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
                (cdsSaida.FieldByName('VALRET').AsFloat <> 0)) Or

               ((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
                (cdsSaida.FieldByName('ART534').AsString = 'S')) Or

               ((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
                (cdsSaida.FieldByName('CLICON').AsString = 'S') And
                (cdsSaida.FieldByName('VALRET').AsFloat = 0))) And

             (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0) And
             (cdsSaida.FieldByName('DTADOC').AsDateTime >= StrToDateDef(mskDtaIni.Text, 0)) Then
          Begin
            cdsEntSai.FieldByName('QTDITE').AsFloat  := cdsEntSai.FieldByName('QTDITE').AsFloat + fltQtdUsu;

            cdsSaida.Edit;
            cdsSaida.FieldByName('INVENT').AsString := 'S';
            cdsSaida.Post;
          End;

          If fSaidaSaiNoRel Then
            cdsEntSai.FieldByName('UTILIZ').AsString := 'S';

          cdsEntSai.FieldByName('PREULT').AsFloat  := fltPreUlt;
          cdsEntSai.FieldByName('AUTSAI').AsString := '---------';
          cdsEntSai.FieldByName('AUTENT').AsString := 'INVENTARIO';
          cdsEntSai.Post;
        End;

        cdsEntrada.First;

        While (fltQtdSai > 0) And (Not cdsEntrada.Eof) And
              (cdsEntrada.FieldByName('DTADOC').AsDateTime <= cdsSaida.FieldByName('DTADOC').AsDateTime) Do
        Begin

          If cdsEntrada.FieldByName('QTDDIS').AsFloat > 0 Then
          Begin
            cdsEntrada.Edit;

            If cdsEntrada.FieldByName('QTDDIS').AsFloat > fltQtdSai Then
            Begin
              cdsEntrada.FieldByName('QTDDIS').AsFloat := cdsEntrada.FieldByName('QTDDIS').AsFloat - fltQtdSai;
              fltQtdSai := 0;

              If fSaidaSaiNoRel Then
                cdsEntrada.FieldByName('UTILIZ').AsString := 'S';
            End Else
            Begin
              fltQtdSai := fltQtdSai - cdsEntrada.FieldByName('QTDDIS').AsFloat;
              cdsEntrada.FieldByName('QTDDIS').AsFloat := 0;

              If fSaidaSaiNoRel Then
                cdsEntrada.FieldByName('UTILIZ').AsString := 'S';
            End;

            cdsEntrada.Post;

            cdsEntSai.Insert;
            cdsEntSai.FieldByName('AUTENT').AsString := cdsEntrada.FieldByName('AUTINC').AsString;
            cdsEntSai.FieldByName('AUTSAI').AsString := cdsSaida.FieldByName('AUTINC').AsString;
            cdsEntSai.Post;
          End;

          If cdsEntrada.FieldByName('QTDDIS').AsFloat <= 0 Then
            cdsEntrada.Next;
        End;

        cdsSaida.Next;
      End;

      Next;
      pgbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

  End;

End;

Function TfrmRelFiscGerArqAcMod2.fRetSaldoInventario(strCodIte: String; Var fltPreUlt: Double): Double;
Begin
  With qryInventario, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT');
    Add('  IFNULL(ITE_SALDOS, 0) AS SALDOS, ');
    Add('  IFNULL(ITE_PREULT, 0) AS PREULT  ');
    Add('FROM');
    Add(strArqInv);
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND');
    Add('  ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    Open;

    If IsEmpty Then
    Begin
      Result    := 0;
      fltPreUlt := 0;
    End Else
    Begin
      Result    := FieldByName('SALDOS').AsFloat;
      fltPreUlt := FieldByName('PREULT').AsFloat;
    End;

  End;
End;

Procedure TfrmRelFiscGerArqAcMod2.pGetValProporcional(    strCodIte,
                                                          strAutSai,
                                                          strInvent: String;
                                                          fltQtdIte: Double;
                                                      Var fltBasRet,
                                                          fltValRet,
                                                          fltBasIcm,
                                                          fltValIcm,
                                                          fltPriAlq,
                                                          fltValIPI,
                                                          fltValFre: Double;
                                                      Var strNFEntr: String);
  Var
    fltAlqIcm,
    fltBasRetEnt,
    fltAlqRetEnt,
    fltValRetEnt,
    fltTotBas,
    fltTotRet,

    fltTotIPI,
    fltTotFre,

    fltTotBasIcm,
    fltTotValIcm,

    fltValIva,
    fltTotQtd: Double;
    blnPriNot: Boolean;
begin
  strNFEntr := '';

  With cdsEntSai Do
  Begin
    fltBasRet := 0;
    fltValRet := 0;

    fltValIPI := 0;
    fltTotIPI := 0;

    fltTotFre := 0;
    fltValFre := 0;

    fltTotBas := 0;
    fltTotRet := 0;

    fltBasIcm := 0;
    fltValIcm := 0;

    fltTotBasIcm := 0;
    fltTotValIcm := 0;

    fltTotQtd := 0;

    Filtered := False;

    blnPriNot := True;

    If (strInvent = 'S') And Locate('CODITE;AUTENT', VarArrayOf([strCodIte, 'INVENTARIO']), []) Then
    Begin
      pCalculaSubTributariaEntrada(strEstEmp,
                                   strEmpIES,
                                   '',
                                   'S',
                                   '',
                                   '',
                                   '',
                                   '',
                                   'S',
                                   FieldByName('CODITE').AsString,
                                   FieldByName('CODABF').AsString,
                                   FieldByName('QTDITE').AsFloat * FieldByName('PREULT').AsFloat,
                                   0,
                                   0,
                                   FieldByName('IPIENT').AsFloat,
                                   fltBasRetEnt,
                                   fltAlqRetEnt,
                                   fltValRetEnt,
                                   fltBasIcm,
                                   fltValIcm,
                                   fltPriAlq,
                                   fltValIva,
                                   fltValIPI,
                                   True);

      fltTotBas := fltTotBas + fltBasRetEnt;
      fltTotRet := fltTotRet + fltValRetEnt;

      fltTotBasIcm := fltTotBasIcm + fltBasIcm;
      fltTotValIcm := fltTotValIcm + fltValIcm;

      fltTotIPI := fltTotIPI + fltValIPI;

      fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;

      strNFEntr := 'INVENTÁRIO';
    End;

    Filter   := 'AUTSAI = ' + QuotedStr(strAutSai);
    Filtered := True;
    First;

    While Not Eof Do
    Begin

      If cdsEntrada.Locate('AUTINC', FieldByName('AUTENT').AsString, []) Then
      Begin
        pCalculaSubTributariaEntrada( cdsEntrada.FieldByName('ESTADO').AsString,
                                      cdsEntrada.FieldByName('FORIES').AsString,
                                      cdsEntrada.FieldByName('TIPFOR').AsString,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      cdsEntrada.FieldByName('PESJUR').AsString,
                                      cdsEntrada.FieldByName('CODITE').AsString,
                                      cdsEntrada.FieldByName('CODABF').AsString,
                                      cdsEntrada.FieldByName('TOTITE').AsFloat,
                                      cdsEntrada.FieldByName('TOTFRE').AsFloat,
                                      cdsEntrada.FieldByName('DESESP').AsFloat,
                                      cdsEntrada.FieldByName('IPIENT').AsFloat,
                                      fltBasRetEnt,
                                      fltAlqRetEnt,
                                      fltValRetEnt,
                                      fltBasIcm,
                                      fltValIcm,
                                      fltAlqIcm,
                                      fltValIva,
                                      fltValIPI,
                                      True);

        If blnPriNot Then
        Begin
          fltPriAlq := fltAlqIcm;;
          blnPriNot := False;
        End;

        fltTotBas := fltTotBas + fltBasRetEnt;
        fltTotRet := fltTotRet + fltValRetEnt;

        fltTotBasIcm := fltTotBasIcm + fltBasIcm;
        fltTotValIcm := fltTotValIcm + fltValIcm;

        fltTotIPI    := fltTotIPI + fltValIPI;

        fltTotQtd := fltTotQtd + cdsEntrada.FieldByName('QTDITE').AsFloat;

        fltTotFre := fltTotFre + cdsEntrada.FieldByName('TOTFRE').AsFloat;

        strNFEntr := strNFEntr + ' ' + cdsEntrada.FieldByName('NUMDOC').AsString;
      End;

      Next;
    End;

    If fltTotQtd = 0 Then
    Begin

 //     If Locate('CODITE;AUTENT', VarArrayOf([strCodIte, 'INVENTARIO']), []) Then
      Begin
        pCalculaSubTributariaEntrada(strEstEmp,
                                     strEmpIES,
                                     '',
                                     'S',
                                     '',
                                     '',
                                     '',
                                     '',
                                     'S',
                                     strCodIte,
                                     cdsSaida.FieldByName('CODABF').AsString,
                                     fltQtdIte * cdsSaida.FieldByName('PREULT').AsFloat,
                                     0,
                                     0,
                                     cdsSaida.FieldByName('IPIENT').AsFloat,
                                     fltBasRetEnt,
                                     fltAlqRetEnt,
                                     fltValRetEnt,
                                     fltBasIcm,
                                     fltValIcm,
                                     fltPriAlq,
                                     fltValIva,
                                     fltValIPI,
                                     True);

        fltTotBas := fltTotBas + fltBasRetEnt;
        fltTotRet := fltTotRet + fltValRetEnt;

        fltTotBasIcm := fltTotBasIcm + fltBasIcm;
        fltTotValIcm := fltTotValIcm + fltValIcm;

        fltTotIPI := fltTotIPI + fltValIPI;

        fltTotQtd := fltTotQtd + fltQtdIte;
      End;

    End;

    If fltTotQtd > 0 Then
    Begin
      fltBasRet := (fltTotBas / fltTotQtd) * fltQtdIte;
      fltValRet := (fltTotRet / fltTotQtd) * fltQtdIte;

      fltBasIcm := (fltTotBasIcm / fltTotQtd) * fltQtdIte;
      fltValIcm := (fltTotValIcm / fltTotQtd) * fltQtdIte;

      fltValIPI := (fltTotIPI / fltTotQtd)* fltQtdIte;

      fltValFre := (fltTotFre / fltTotQtd)* fltQtdIte;
    End;
  End;
end;

Function TfrmRelFiscGerArqAcMod2.fSQLResumoItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                  ';
  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   0.00       AS ICMDEN, ';
  strSQL := strSQL + '   0.00       AS ICMFOR  ';
  strSQL := strSQL + ' FROM               ';
  strSQL := strSQL + '   CADITE           ';
  strSQL := strSQL + ' WHERE              ';
  strSQL := strSQL + '   FALSE            ';

  Result := strSQL;
End;

procedure TfrmRelFiscGerArqAcMod2.pCriaClientResumoItem;
Begin
  cdsResumoItem := TZClient.Create(Self);
  cdsResumoItem.qryQuery.SQL.Text := fSQLResumoItem;

  cdsResumoItem.pCriaSoma('ICMDEN', 'TOTDEN');
  cdsResumoItem.pCriaSoma('ICMFOR', 'TOTFOR');

  If Not cdsResumoItem.fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaClientResumoItem') Then
    blnDeuErro := True;
End;

Function TfrmRelFiscGerArqAcMod2.fSQLCreditoICMS: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                  ';
  strSQL := strSQL + '   "00"       AS QUADRO, ';
  strSQL := strSQL + '   "000000"   AS NUMDOC, ';
  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   0.00       AS CREICM  ';
  strSQL := strSQL + ' FROM               ';
  strSQL := strSQL + '   CADITE           ';
  strSQL := strSQL + ' WHERE              ';
  strSQL := strSQL + '   FALSE            ';

  Result := strSQL;
End;

procedure TfrmRelFiscGerArqAcMod2.pCriaClientCreditoIcms;
Begin
  cdsCreditoIcms := TZClient.Create(Self);
  cdsCreditoIcms.qryQuery.SQL.Text := fSQLCreditoICMS;
  cdsCreditoIcms.Open;
  If Not cdsCreditoIcms.fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaClientCreditoIcms') Then
    blnDeuErro := True;
End;

procedure TfrmRelFiscGerArqAcMod2.pSomaResumoItem(strCodIte: String; fltIcmDen, fltIcmFor: Double);
Begin
  With cdsResumoItem Do
  If (fltIcmDen > 0) Or  (fltIcmFor > 0) Then
  Begin
    If Locate('CODITE', strCodIte, []) Then
    Begin
      Edit;
    End Else
    Begin
      Insert;
      FieldByName('CODITE').AsString := strCodIte;
      FieldByName('DESITE').AsString := fRetNomProduto(strCodIte);

      FieldByName('ICMDEN').AsFloat  := 0;
      FieldByName('ICMFOR').AsFloat  := 0;
    End;

    FieldByName('ICMDEN').AsFloat  := FieldByName('ICMDEN').AsFloat + fltIcmDen;
    FieldByName('ICMFOR').AsFloat  := FieldByName('ICMFOR').AsFloat + fltIcmFor;
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pSomaCreditoItem(strCodIte, strNumDoc, strQuadro: String; fltCreIcm: Double);
Begin
  If fltCreIcm > 0 Then
  With cdsCreditoIcms Do
  Begin
    Insert;
    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := fRetNomProduto(strCodIte);
    FieldByName('NUMDOC').AsString := strNumDoc;
    FieldByName('QUADRO').AsString := strQuadro;
    FieldByName('CREICM').AsFloat  := fltCreIcm;
    Post;
  End;
End;

Function TfrmRelFiscGerArqAcMod2.fRetCodAbf(strCodIte: String): String;
  Var
    strSQL: String;
    qryCodAbf: TUniQuery;
Begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
  strSQL := strSQL + '   ITE_CODABF AS CODABF ';
  strSQL := strSQL + ' FROM ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '     CADITE '
  Else
    strSQL := strSQL + '     ITEGER ';

  strSQL := strSQL +  ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE  ';

  If fCfgSis('TIPABF') <> '1' Then
    strSQL := strSQL +  '   AND ITE_CODEMP = :CODEMP  ';

  qryCodAbf := fCriaQuery(Self);

  With qryCodAbf Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODITE').AsString := strCodIte;

    If fCfgSis('TIPABF') <> '1' Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('CODABF').AsString;

    Close;
  End;

  FreeAndNil(qryCodAbf);
End;

Function TfrmRelFiscGerArqAcMod2.fRetDescTipFor(strTipFor: String): String;
Begin
  Result := '';

  If strTipFor = '' Then
    Exit;

  Case strTipFor[1] Of
   'C': Result := 'COMÉRCIO';
   'D': Result := 'DISTRIBUIDOR';
   'I': Result := 'INDÚSTRIA';
   'R': Result := 'REVENDA';
   'M': Result := 'MATERIAL DE CONSUMO';
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.btnConfirmaClick(Sender: TObject);

  function fBarraNoFinal(strPath: String) : String;
    Var
      strTmp : String;
  Begin
    strTmp := strPath;
    If Not (strTmp[Length(strTmp)] = '\') Then
      Result := strTmp + '\'
    Else
      Result := strTmp;
  End;

  Var
    objExcel : TExcel;
    qryEmp : TUniQuery;

    fltValIva,
    fltBasRetEnt : Double;
    fltAlqRetEnt : Double;
    fltValRetEnt : Double;

    fltIcmSaiDentro,
    fltIcmSaiForaSemST,
    fltIcmSaiForaComST,
    fltIcmSaiDentroArt534,
    fltIcmSaiForaConsumidor,

    fltTotIcmsSaiDentro,
    fltTotIcmsSaiFora,

    fltCredIcmConsIte,

    fltBasRet,
    fltValRet,

    fltValIPI,
    fltValFre,

    fltPriAlq,

    fltBasIcm,
    fltValIcm: Double;

    blnGerTot,
    blnTemSaida: Boolean;

    strNFEntr: String;

    fltAlqIcm2,
    fltAlqRet2,
    fltValIva2,
    fltPerBas2,
    fltPeBaST2: Double;

    strCodSit2: String;

begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Screen.Cursor := crHourGlass;
  fraPathExp.edtDirectory.text := fBarraNoFinal(fraPathExp.edtDirectory.text);
  qryEmp := fCriaQuery(Self);

  objExcel := TExcel.fCriarExcel(Self);

  Try
    If Not DirectoryExists(fraPathExp.edtDirectory.text) Then
      ForceDirectories(fraPathExp.edtDirectory.text);

    btnConfirma.Enabled := False;
    pnlInfo.Caption := 'Gerando Arquivos...';
    pnlInfo.Repaint;
    Application.ProcessMessages;

    qryEmp.SQL.Add('SELECT CADEMP.*,');
    qryEmp.SQL.Add('       CID_ESTADO AS ESTADO ');
    qryEmp.SQL.Add('  FROM CADEMP');
    qryEmp.SQL.Add('       JOIN CADCID ON CID_CODCID = EMP_CODCID');
    qryEmp.SQL.Add(' WHERE EMP_CODEMP = :CODEMP ');
    qryEmp.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    qryEmp.Open;

    strEstEmp := qryEmp.FieldByName('ESTADO').AsString;
    strEmpIES := qryEmp.FieldByName('EMP_I_E_S_').AsString;

    cdsEntSai.EmptyDataSet;

    cdsResumoItem.EmptyDataSet;
    cdsCreditoIcms.EmptyDataSet;
    cdsResumoQuadro4.EmptyDataSet;

    pNotasSaidas(cdsItens, True);

    If cdsItens.IsEmpty Then
    Begin
      fMensagem('', 'Nenhum há dados para geração dos arquivos!', ['&O k']);
      Exit;
    End;

    pNotasSaidas(cdsSaida, False);

    If Not fNotasEntrada Then
      Exit;

    pGeraNotasEntrada;

    pgbProgresso.Max      := cdsItens.RecordCount;
    pgbProgresso.Position := 0;
    Application.ProcessMessages;

    fltTotIcmsSaiDentro := 0;
    fltTotIcmsSaiFora   := 0;

    blnGerTot := False;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin

      fltIcmSaiDentro         := 0;
      fltIcmSaiForaSemST      := 0;
      fltIcmSaiForaComST      := 0;
      fltIcmSaiDentroArt534   := 0;
      fltIcmSaiForaConsumidor := 0;

      With objExcel Do
      Begin

        If Not chkSoResumo.Checked Then
        Begin

          objExcel.CriarArquivo(fraPathExp.edtDirectory.text + 'Acordo_SEFAZ_' + AnsiReplaceStr(strNroCef, '/', '_') + cdsItens.FieldByName('CODITE').AsString);

          PintarTudo(Branco);
          DefinirFonte(Times, 08);

          Escrever(02, 01, 'ANEXO ÚNICO DO TERMO DE ACORDO SEFAZ Nº ' + strNroCef);
          Negrito (02, 01, True);
          Mesclar('A2', 'Q2');
          Alinhamento('A2', 'A2', Centro);

          Escrever(03, 01, 'TERMO DE ACORDO DE SUBSTITUIÇÃO TRIBUTÁRIA');
          Negrito (03, 01, True);
          Mesclar('A3', 'Q3');
          Alinhamento('A3', 'A3', Centro);

          Escrever(04, 01, 'DEMONSTRATIVO DO CÁLCULO DO ICMS-ST A RECOLHER');
          Negrito (04, 01, True);
          Mesclar('A4', 'Q4');
          Alinhamento('A4', 'A4', Centro);

          Bordas('A8',  'H15', True, True, True, True);
          Bordas('I8',  'Q15', True, True, True, True);
          Bordas('A18', 'K19', True, True, True, True);

          (**************************************************************************************************)
          Escrever(08, 01, ' QUADRO 01 - Razão Social - Periodo: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text);
          Negrito (08, 01, True);
          Mesclar('A8', 'G8');
          Escrever(10, 01, fRetNomeEmpresaSelec(edtCodEmpresa.Text));
          Negrito (10, 01, True);
          Escrever(11, 01, fRetEnderecoEmpresa(edtCodEmpresa.Text));
          Negrito (11, 01, True);
          Escrever(12, 01, qryEmp.FieldByName('EMP_BAIRRO').AsString);
          Negrito (12, 01, True);
          Escrever(13, 01, 'CNPJ: ' + fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, FPais));
          Negrito (13, 01, True);
          Escrever(14, 01, 'I.ESTADUAL: ' + qryEmp.FieldByName('EMP_I_E_S_').AsString);
          Negrito (14, 01, True);

          (**************************************************************************************************)
          Escrever(08, 09, ' QUADRO 02');
          Negrito (08, 09, True);
          Mesclar('I8', 'P8');
          Escrever(09, 09, 'Produto: ');
          Negrito (09, 09, True);
          Escrever(09, 10, fRetNomProduto(cdsItens.FieldByName('CODITE').AsString));
          CorFonte('J9', 'J9', Vermelho);
          Negrito (09, 10, True);
          Mesclar('J9', 'Q9');

          If chkInfAdi.Checked Then
          Begin
            Escrever(10, 09, 'NCM: ');
            Negrito (10, 09, True);
            Escrever(10, 10, fCampoTabela('ITE_CLAIPI', 'CADITE', ['ITE_CODITE'], [cdsItens.FieldByName('CODITE').AsString]));
            CorFonte('J10', 'J10', Vermelho);
            Negrito (10, 10, True);
            Mesclar('J10', 'Q10');
            Alinhamento('J10', 'Q10', Esquerda);

            Escrever(11, 09, 'ABR.FISCAL: ');
            Negrito (11, 09, True);
            Escrever(11, 10, '''' + fRetCodAbf(cdsItens.FieldByName('CODITE').AsString));
            CorFonte('J10', 'J10', Vermelho);
            Negrito (11, 10, True);
            Mesclar('J11', 'Q11');
            Alinhamento('J11', 'Q11', Esquerda);
          End;

          (**************************************************************************************************)
          Escrever(18, 01, ' QUADRO 03 - NOTAS FISCAIS DE ENTRADA');
          Escrever(20, 01, 'CNPJ REMETENTE');
          Bordas('A20', 'A20');
          Escrever(20, 02, 'UF');
          Bordas('B20', 'B20');
          Escrever(20, 03, 'N° NF');
          Bordas('C20', 'C20');
          Escrever(20, 04, 'DATA');
          Bordas('D20', 'D20');
          Escrever(20, 05, 'QUANT.');
          Bordas('E20', 'E20');
          Escrever(20, 06, 'B.CALC.');
          Bordas('F20', 'F20');
          Escrever(20, 07, 'ICMS');
          Bordas('G20', 'G20');
          Escrever(20, 08, 'B.CALC.R');
          Bordas('H20', 'H20');
          Escrever(20, 09, 'ICMS R.');
          Bordas('I20', 'I20');
          Escrever(20, 10, 'BCR.UNIT.');
          Bordas('J20', 'J20');
          Escrever(20, 11, 'ICMS R.UNIT.');
          Bordas('K20', 'K20');
          Mesclar('A18', 'K18');

          CorFundo('A18', 'K20', RGB(135,200,250));

          If chkInfAdi.Checked Then
          Begin
            Escrever(20, 12, '%ICMS');
            Bordas('L20', 'L20');

            Escrever(20, 13, '%MVA');
            Bordas('M20', 'M20');

            Escrever(20, 14, 'IPI');
            Bordas('N20', 'N20');

            Escrever(20, 15, 'FRETE');
            Bordas('O20', 'O20');

            Escrever(20, 16, 'TIPO FORNEC.');
            Bordas('P20', 'P20');
          End;

          LinhaAtual := 20;
        End;

        cdsEntrada.Filter := 'CODITE = '+ QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND UTILIZ = ' + QuotedStr('S');
        cdsEntrada.Filtered := True;
        cdsEntrada.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsEntrada.RecordCount;
        Application.ProcessMessages;

        cdsEntSai.Filtered := False;
        If cdsEntSai.Locate('CODITE;AUTENT', VarArrayOf([cdsItens.FieldByName('CODITE').AsString,'INVENTARIO']), []) And
           (cdsEntSai.FieldByName('UTILIZ').AsString = 'S') Then
        Begin
          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;
          End;

          pCalculaSubTributariaEntrada(strEstEmp,
                                       strEmpIES,
                                       '',
                                       'S',
                                       '',
                                       '',
                                       '',
                                       '',
                                       'S',
                                       cdsEntSai.FieldByName('CODITE').AsString,
                                       cdsEntSai.FieldByName('CODABF').AsString,
                                       cdsEntSai.FieldByName('PREULT').AsFloat * cdsEntSai.FieldByName('QTDITE').AsFloat,
                                       0,
                                       0,
                                       cdsEntSai.FieldByName('IPIENT').AsFloat,
                                       fltBasRetEnt,
                                       fltAlqRetEnt,
                                       fltValRetEnt,
                                       fltBasIcm,
                                       fltValIcm,
                                       fltPriAlq,
                                       fltValIva,
                                       fltValIPI,
                                       True);

          If Not chkSoResumo.Checked Then
          Begin

            Escrever(LinhaAtual, 01, '''' + qryEmp.FieldByName('EMP_C_G_C_').AsString);
            Escrever(LinhaAtual, 02, strEstEmp);


            Escrever(LinhaAtual, 03, 'INVENTARIO');

            Escrever(LinhaAtual, 05, cdsEntSai.FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 05);

            Escrever(LinhaAtual, 06, fltBasIcm);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, fltValIcm);
            FormatoNumerico(LinhaAtual, 07);

            Escrever(LinhaAtual, 08, fltBasRetEnt);
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 09, fltValRetEnt);
            FormatoNumerico(LinhaAtual, 09);

            If cdsEntSai.FieldByName('QTDITE').AsFloat <> 0 Then
              Escrever(LinhaAtual, 10, fltBasRetEnt / cdsEntSai.FieldByName('QTDITE').AsFloat)
            Else
              Escrever(LinhaAtual, 10, 0.00);

            FormatoNumerico(LinhaAtual, 10);

            If cdsEntSai.FieldByName('QTDITE').AsFloat <> 0 Then
              Escrever(LinhaAtual, 11, fltValRetEnt / cdsEntSai.FieldByName('QTDITE').AsFloat)
            Else
              Escrever(LinhaAtual, 11, 0.00);

            FormatoNumerico(LinhaAtual, 11);

            If chkInfAdi.Checked Then
            Begin
              Escrever(LinhaAtual, 12, fltPriAlq);
              FormatoNumerico(LinhaAtual, 12);

              If fltValIva < 1 Then
                fltValIva := 1;

              Escrever(LinhaAtual, 13, (fltValIva - 1) * 100);
              FormatoNumerico(LinhaAtual, 13);

              Escrever(LinhaAtual, 14, fltValIPI);
              FormatoNumerico(LinhaAtual, 14);

              Escrever(LinhaAtual, 15, 0);
              FormatoNumerico(LinhaAtual, 15);
            End;

            Alinhamento('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), True);
          End;

        End;

        While Not cdsEntrada.Eof Do
        Begin
          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;
          End;

          pCalculaSubTributariaEntrada( cdsEntrada.FieldByName('ESTADO').AsString,
                                        cdsEntrada.FieldByName('FORIES').AsString,
                                        cdsEntrada.FieldByName('TIPFOR').AsString,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        cdsEntrada.FieldByName('PESJUR').AsString,
                                        cdsEntrada.FieldByName('CODITE').AsString,
                                        cdsEntrada.FieldByName('CODABF').AsString,
                                        cdsEntrada.FieldByName('TOTITE').AsFloat,
                                        cdsEntrada.FieldByName('TOTFRE').AsFloat,
                                        cdsEntrada.FieldByName('DESESP').AsFloat,
                                        cdsEntrada.FieldByName('IPIENT').AsFloat,
                                        fltBasRetEnt,
                                        fltAlqRetEnt,
                                        fltValRetEnt,
                                        fltBasIcm,
                                        fltValIcm,
                                        fltPriAlq,
                                        fltValIva,
                                        fltValIPI,
                                        True);

          If Not chkSoResumo.Checked Then
          Begin
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsEntrada.FieldByName('FORCGC').AsString, FPais));
            Escrever(LinhaAtual, 02, cdsEntrada.FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, cdsEntrada.FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsEntrada.FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, cdsEntrada.FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, fltBasIcm);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, fltValIcm);
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 08, fltBasRetEnt);
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 09, fltValRetEnt);
            FormatoNumerico(LinhaAtual, 09);
            Escrever(LinhaAtual, 10, fltBasRetEnt / cdsEntrada.FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 10);
            Escrever(LinhaAtual, 11, fltValRetEnt / cdsEntrada.FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 11);

            If chkInfAdi.Checked Then
            Begin
              Escrever(LinhaAtual, 12, fltPriAlq);
              FormatoNumerico(LinhaAtual, 12);

              If fltValIva < 1 Then
                fltValIva := 1;

              Escrever(LinhaAtual, 13, (fltValIva - 1) * 100);
              FormatoNumerico(LinhaAtual, 13);

              Escrever(LinhaAtual, 14, fltValIPI);
              FormatoNumerico(LinhaAtual, 14);

              Escrever(LinhaAtual, 15, cdsEntrada.FieldByName('TOTFRE').AsFloat);
              FormatoNumerico(LinhaAtual, 15);

              Escrever(LinhaAtual, 16, fRetDescTipFor(cdsEntrada.FieldByName('TIPFOR').AsString));

            End;

            Alinhamento('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), True);
          End;

          cdsEntrada.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;

        End;

        If Not chkSoResumo.Checked Then
        Begin

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha, 01, ' QUADRO 04 - NOTAS FISCAIS DE SAÍDAS INTERNAS');
          Bordas('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), True, True, True, True);
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), RGB(135,200,250));
          Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));

          ProximaLinha;
          ProximaLinha;

          Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
          Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 02, 'UF');
          Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 03, 'N° NF');
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 04, 'DATA');
          Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 05, 'QUANT.');
          Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 06, 'B.CALC.');
          Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 07, 'ICMS');
          Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 08, 'B.CALC.R');
          Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 09, 'ICMS R.');
          Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), RGB(135,200,250));

          If chkInfAdi.Checked Then
          Begin
            Escrever(LinhaAtual, 10, 'NFE Entrada');
            Bordas('J' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
          End;
        End;

        // Saídas internas (Dentro do estado)
        cdsSaida.Filter := ' CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND FILDTA = '  + QuotedStr('S');

        cdsSaida.Filtered := True;
        cdsSaida.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsSaida.RecordCount;
        Application.ProcessMessages;

        blnTemSaida := False;

        While Not cdsSaida.Eof Do
        Begin
          If Not (((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
                  (cdsSaida.FieldByName('ART534').AsString = 'N')) And
                  (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0)) Then
          Begin
            cdsSaida.Next;
            pgbItem.StepBy(1);
            Application.ProcessMessages;
            Continue;
          End;

          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;

            blnTemSaida := True;

            //CNPJ
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais));

            //Estado
            Escrever(LinhaAtual, 02, cdsSaida.FieldByName('ESTADO').AsString);

            //Nº Documento
            Escrever(LinhaAtual, 03, cdsSaida.FieldByName('NUMDOC').AsString);

            //Data Documento
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsSaida.FieldByName('DTADOC').AsDateTime));

            //Quantidade Itens
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 05, cdsSaida.FieldByName('QTDITE').AsFloat);
          End;

          pGetValProporcional(cdsSaida.FieldByName('CODITE').AsString,
                              cdsSaida.FieldByName('AUTINC').AsString,
                              cdsSaida.FieldByName('INVENT').AsString,
                              cdsSaida.FieldByName('QTDITE').AsFloat,
                              fltBasRet, fltValRet, fltBasIcm, fltValIcm, fltPriAlq, fltValIPI, fltValFre,
                              strNFEntr);

          If Not chkSoResumo.Checked Then
          Begin

            // Base ICMS -> TOTITE - DESESP
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 06, fltBasIcm);

            // Valor ICMS -> (TOTITE - DESESP) * ALIQUOTA
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 07, fltValIcm);


            // Base Retido
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 08, fltBasRet);

            // Valor Retido
            FormatoNumerico(LinhaAtual, 09);
            Escrever(LinhaAtual, 09, fltValRet);

            If chkInfAdi.Checked Then
              Escrever(LinhaAtual, 10, '''' + strNFEntr);
          End;

          fltIcmSaiDentro := fltIcmSaiDentro + fltValRet;

          fltTotIcmsSaiDentro := fltTotIcmsSaiDentro + fltValRet;

          pSomaResumoItem(cdsItens.FieldByName('CODITE').AsString, fltValRet, 0);

          If Not chkSoResumo.Checked Then
          Begin
            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
          End;

          pSomaResumoQuadro4(fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais),
                                            cdsSaida.FieldByName('ESTADO').AsString,
                                            cdsSaida.FieldByName('NUMDOC').AsString,
                                            cdsSaida.FieldByName('DTADOC').AsDateTime,
                                            fltBasIcm, fltValIcm, fltBasRet, fltValRet);

          cdsSaida.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;
        End;

        If Not chkSoResumo.Checked Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 08, 'TOTAL A');
          FormatoNumerico(LinhaAtual, 09);
          Escrever(LinhaAtual, 09, fltIcmSaiDentro);
          Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha, 01, ' QUADRO 05 - NOTAS FISCAIS DE SAÍDAS INTERESTADUAIS');
          Bordas('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual+1), True, True, True, True);
          CorFundo('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual+1), RGB(135,200,250));
          Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

          ProximaLinha;
          ProximaLinha;

          Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
          Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 02, 'UF');
          Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 03, 'N° NF');
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 04, 'DATA');
          Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 05, 'QUANT.');
          Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 06, 'B.CALC.');
          Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 07, 'ICMS 12%');
          Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 08, 'ICMS 1%');
          Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), RGB(135,200,250));
        End;

        // Interestaduais, não consumidor e sem substituição
        cdsSaida.Filter := ' CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND FILDTA = '  + QuotedStr('S');

        cdsSaida.Filtered := True;
        cdsSaida.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsSaida.RecordCount;
        Application.ProcessMessages;

        While Not cdsSaida.Eof Do
        Begin
          If Not (((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
                  (cdsSaida.FieldByName('VALRET').AsFloat = 0) And
                  (cdsSaida.FieldByName('CLICON').AsString = 'N')) And
                  (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0)) Then
          Begin
            cdsSaida.Next;
            pgbItem.StepBy(1);
            Application.ProcessMessages;
            Continue;
          End;

          blnTemSaida := True;

          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;

            //CNPJ
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais));

            //Estado
            Escrever(LinhaAtual, 02, cdsSaida.FieldByName('ESTADO').AsString);

            //Nº Documento
            Escrever(LinhaAtual, 03, cdsSaida.FieldByName('NUMDOC').AsString);

            //Data Documento
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsSaida.FieldByName('DTADOC').AsDateTime));

            //Qtd. Item
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 05, cdsSaida.FieldByName('QTDITE').AsFloat);

            //Base ICMS
            Escrever(LinhaAtual, 06, cdsSaida.FieldByName('BASICM').AsFloat);
            FormatoNumerico(LinhaAtual, 06);

            //ICMS 12%
            Escrever(LinhaAtual, 07, cdsSaida.FieldByName('ICM12').AsFloat);
            FormatoNumerico(LinhaAtual, 07);

            //ICMS 1%
            Escrever(LinhaAtual, 08, cdsSaida.FieldByName('ICM01').AsFloat);
            FormatoNumerico(LinhaAtual, 08);
          End;

          fltIcmSaiForaSemST := fltIcmSaiForaSemST + cdsSaida.FieldByName('ICM01').AsFloat;
          fltTotIcmsSaiFora := fltTotIcmsSaiFora + cdsSaida.FieldByName('ICM01').AsFloat;

          pSomaResumoItem(cdsItens.FieldByName('CODITE').AsString, 0, cdsSaida.FieldByName('ICM01').AsFloat);

          If Not chkSoResumo.Checked Then
          Begin
            Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);
          End;

          cdsSaida.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;
        End;

        If Not chkSoResumo.Checked Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 07, 'TOTAL B');
          FormatoNumerico(LinhaAtual, 08);
          Escrever(LinhaAtual, 08, fltIcmSaiForaSemST);
          Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha, 01, ' QUADRO 06 - NOTAS FISCAIS DE SAÍDAS INTERESTADUAIS COM SUBSTITUIÇÃO TRIBUTÁRIA');
          Bordas('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual+1), True, True, True, True);
          CorFundo('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual+1), RGB(135,200,250));
          Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));

          ProximaLinha;
          ProximaLinha;

          Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
          Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 02, 'UF');
          Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 03, 'N° NF');
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 04, 'DATA');
          Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 05, 'QUANT.');
          Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 06, 'B.CALC.');
          Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 07, 'ICMS 12%');
          Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 08, 'ICMS 1%');
          Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 09, 'B.CALC.R');
          Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 10, 'ICMS R.');
          Bordas('J' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), RGB(135,200,250));
        End;

        // Interestaduais e com substituição
        cdsSaida.Filter := ' CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND FILDTA = '  + QuotedStr('S');

        cdsSaida.Filtered := True;
        cdsSaida.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsSaida.RecordCount;
        Application.ProcessMessages;

        While Not cdsSaida.Eof Do
        Begin
          If Not (((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
                   (cdsSaida.FieldByName('VALRET').AsFloat <> 0)) And
                   (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0)) Then
          Begin
            cdsSaida.Next;
            pgbItem.StepBy(1);
            Application.ProcessMessages;
            Continue;
          End;

          blnTemSaida := True;

          If Not chkSoResumo.Checked Then
          Begin

            ProximaLinha;

            //CNPJ
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais));

            //Estado
            Escrever(LinhaAtual, 02, cdsSaida.FieldByName('ESTADO').AsString);

            //Nº Documento
            Escrever(LinhaAtual, 03, cdsSaida.FieldByName('NUMDOC').AsString);

            //Data Documento
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsSaida.FieldByName('DTADOC').AsDateTime));

            //Qtd. Item
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 05, cdsSaida.FieldByName('QTDITE').AsFloat);

            //Base ICMS
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 06, cdsSaida.FieldByName('BASICM').AsFloat);

            //ICMS 12 %
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 07, cdsSaida.FieldByName('ICM12').AsFloat);

            //ICMS 1 %
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 08, cdsSaida.FieldByName('ICM01').AsFloat);

            //Base Retido
            FormatoNumerico(LinhaAtual, 09);
            Escrever(LinhaAtual, 09, cdsSaida.FieldByName('BASRET').AsFloat);

            //Valor Retido
            FormatoNumerico(LinhaAtual, 10);
            Escrever(LinhaAtual, 10, cdsSaida.FieldByName('VALRET').AsFloat);
          End;

          fltIcmSaiForaComST := fltIcmSaiForaComST + cdsSaida.FieldByName('ICM01').AsFloat;
          fltTotIcmsSaiFora := fltTotIcmsSaiFora + cdsSaida.FieldByName('ICM01').AsFloat;

          pSomaResumoItem(cdsItens.FieldByName('CODITE').AsString, 0, cdsSaida.FieldByName('ICM01').AsFloat);

          If Not chkSoResumo.Checked Then
          Begin
            Alinhamento('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), True);
          End;

          cdsSaida.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;
        End;

        If Not chkSoResumo.Checked Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 07, 'TOTAL C');
          FormatoNumerico(LinhaAtual, 08);
          Escrever(LinhaAtual, 08, fltIcmSaiForaComST);
          Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha, 01, ' QUADRO 07 - NOTAS FISCAIS DE SAÍDAS DENTRO DO ESTADO - ARTIGO 534ZZA');
          Bordas('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), True, True, True, True);
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), RGB(135,200,250));
          Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));

          ProximaLinha;
          ProximaLinha;

          Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
          Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 02, 'UF');
          Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 03, 'N° NF');
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 04, 'DATA');
          Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 05, 'QUANT.');
          Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 06, 'B.CALC.');
          Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 07, 'ICMS');
          Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 08, 'CRED.ICMS');
          Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 09, 'ICMS A PAGAR');
          Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), RGB(135,200,250));
        End;

        // Dentro do estado Artigo 534ZZA
        cdsSaida.Filter := ' CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND FILDTA = '  + QuotedStr('S');
        cdsSaida.Filtered := True;
        cdsSaida.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsSaida.RecordCount;
        Application.ProcessMessages;

        While Not cdsSaida.Eof Do
        Begin
          If Not (((cdsSaida.FieldByName('ESTADO').AsString = strEstEmp) And
                   (cdsSaida.FieldByName('ART534').AsString = 'S')) And
                   (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0)) Then
          Begin
            cdsSaida.Next;
            pgbItem.StepBy(1);
            Application.ProcessMessages;
            Continue;
          End;

          blnTemSaida := True;

          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;

            //CNPJ
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais));

            //Estado
            Escrever(LinhaAtual, 02, cdsSaida.FieldByName('ESTADO').AsString);

            //Nº Documento
            Escrever(LinhaAtual, 03, cdsSaida.FieldByName('NUMDOC').AsString);

            //Data Documento
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsSaida.FieldByName('DTADOC').AsDateTime));

            //Qtd. Item
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 05, cdsSaida.FieldByName('QTDITE').AsFloat);
          End;

          pGetValProporcional(cdsSaida.FieldByName('CODITE').AsString,
                              cdsSaida.FieldByName('AUTINC').AsString,
                              cdsSaida.FieldByName('INVENT').AsString,
                              cdsSaida.FieldByName('QTDITE').AsFloat,
                              fltBasRet, fltValRet, fltBasIcm, fltValIcm, fltPriAlq, fltValIPI, fltValFre, strNFEntr);

          fltCredIcmConsIte := fltValIcm;

          pSomaCreditoItem(cdsSaida.FieldByName('CODITE').AsString,
                           cdsSaida.FieldByName('NUMDOC').AsString,
                           '07',
                           fltCredIcmConsIte);

          If fEmptyStr(cdsSaida.FieldByName('I_E_S_').AsString) Or (cdsSaida.FieldByName('CODATI').AsString = strCliAti) Then
          Begin
            fltBasIcm := cdsSaida.FieldByName('TOTITE').AsFloat - cdsSaida.FieldByName('DESESP').AsFloat;
            fltValIcm := RoundTo(fltBasIcm * (fRetornaAliquotaIcmsInternaDoEstado(cdsSaida.FieldByName('ESTADO').AsString) /100), -2);
          End Else
          Begin
            fltBasIcm := cdsSaida.FieldByName('BASICM').AsFloat;
            fltValIcm := cdsSaida.FieldByName('VALICM').AsFloat;
          End;

          If Not chkSoResumo.Checked Then
          Begin
            //Base ICMS
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 06, fltBasIcm);

            //Valor ICMS
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 07, fltValIcm);

            Escrever(LinhaAtual, 08, FloatToStr(fltCredIcmConsIte));
            FormatoNumerico(LinhaAtual, 08);

            Escrever(LinhaAtual, 09, FloatToStr(fltValIcm - fltCredIcmConsIte));//ICMS A PAGAR VALICM - CRED.ICMS
            FormatoNumerico(LinhaAtual, 09);
          End;

          fltIcmSaiDentroArt534 := fltIcmSaiDentroArt534 + (fltValIcm - fltCredIcmConsIte);
          fltTotIcmsSaiDentro := fltTotIcmsSaiDentro + (fltValIcm - fltCredIcmConsIte);

          pSomaResumoItem(cdsItens.FieldByName('CODITE').AsString, (fltValIcm - fltCredIcmConsIte), 0);

          If Not chkSoResumo.Checked Then
          Begin
            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
          End;

          cdsSaida.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;
        End;

        If Not chkSoResumo.Checked Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 08, 'TOTAL D');
          FormatoNumerico(LinhaAtual, 09);
          Escrever(LinhaAtual, 09, fltIcmSaiDentroArt534);
          Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha, 01, ' QUADRO 08 - NOTAS FISCAIS DE SAÍDAS CONSUMIDOR FINAL FORA DO ESTADO');
          Bordas('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), True, True, True, True);
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), RGB(135,200,250));
          Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));

          ProximaLinha;
          ProximaLinha;

          Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
          Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 02, 'UF');
          Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 03, 'N° NF');
          Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 04, 'DATA');
          Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 05, 'QUANT.');
          Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 06, 'B.CALC.');
          Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 07, 'ICMS');
          Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 08, 'CRED.ICMS');
          Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
          Escrever(LinhaAtual, 09, 'ICMS A PAGAR');
          Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), RGB(135,200,250));
        End;

        // Interestadual, consumidor final sem substituição
        cdsSaida.Filter := ' CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND FILDTA = '  + QuotedStr('S');

        cdsSaida.Filtered := True;
        cdsSaida.First;

        pgbItem.Position := 0;
        pgbItem.Max := cdsSaida.RecordCount;
        Application.ProcessMessages;

        While Not cdsSaida.Eof Do
        Begin
          If Not (((cdsSaida.FieldByName('ESTADO').AsString <> strEstEmp) And
                  (cdsSaida.FieldByName('CLICON').AsString = 'S') And
                  (cdsSaida.FieldByName('VALRET').AsFloat = 0)) And
                  (Pos(cdsSaida.FieldByName('CLAFIS').AsString, VS_strClaVen) > 0)) Then
          Begin
            cdsSaida.Next;
            pgbItem.StepBy(1);
            Application.ProcessMessages;
            Continue;
          End;

          blnTemSaida := True;

          If Not chkSoResumo.Checked Then
          Begin
            ProximaLinha;

            //CNPJ
            Escrever(LinhaAtual, 01, fFormataCpfCgc(cdsSaida.FieldByName('CLICGC').AsString, FPais));

            //Estado
            Escrever(LinhaAtual, 02, cdsSaida.FieldByName('ESTADO').AsString);

            //Nº Documento
            Escrever(LinhaAtual, 03, cdsSaida.FieldByName('NUMDOC').AsString);

            //Data Documento
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', cdsSaida.FieldByName('DTADOC').AsDateTime));

            //Qtd. Item
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 05, cdsSaida.FieldByName('QTDITE').AsFloat);
          End;

          pGetValProporcional(cdsSaida.FieldByName('CODITE').AsString,
                              cdsSaida.FieldByName('AUTINC').AsString,
                              cdsSaida.FieldByName('INVENT').AsString,
                              cdsSaida.FieldByName('QTDITE').AsFloat,
                              fltBasRet, fltValRet, fltBasIcm, fltValIcm, fltPriAlq, fltValIPI, fltValFre, strNFEntr);

          fltCredIcmConsIte := fltValIcm;

          pSomaCreditoItem(cdsSaida.FieldByName('CODITE').AsString,
                           cdsSaida.FieldByName('NUMDOC').AsString,
                           '08',
                           fltCredIcmConsIte);

          If fEmptyStr(cdsSaida.FieldByName('I_E_S_').AsString) Or (cdsSaida.FieldByName('CODATI').AsString = strCliAti) Then
          Begin
            fltBasIcm := cdsSaida.FieldByName('TOTITE').AsFloat - cdsSaida.FieldByName('DESESP').AsFloat;

            pRetDadosAbfICMS('C',
                             cdsSaida.FieldByName('CODABF').AsString,
                             cdsSaida.FieldByName('ESTADO').AsString,
                             cdsSaida.FieldByName('I_E_S_').AsString,
                             '',
                             cdsSaida.FieldByName('CLICON').AsString,
                             cdsSaida.FieldByName('CODATI').AsString,
                             cdsSaida.FieldByName('PRORUR').AsString,
                             cdsSaida.FieldByName('MICEMP').AsString,
                             cdsSaida.FieldByName('REGTRI').AsString,
                             cdsSaida.FieldByName('INDUST').AsString,
                             IfThen(Pos(cdsSaida.FieldByName('CODCLI').AsString, VS_strCliFil) > 0, 'S', 'N'),
                             (cdsSaida.FieldByName('PESJUR').AsString = 'S'),
                             fltAlqIcm2,
                             fltAlqRet2,
                             fltValIva2,
                             fltPerBas2,
                             fltPeBaST2,
                             strCodSit2);

            fltValIcm := RoundTo(fltBasIcm * (fltAlqIcm2 /100), -2);
          End Else
          Begin
            fltBasIcm := cdsSaida.FieldByName('BASICM').AsFloat;
            fltValIcm := cdsSaida.FieldByName('VALICM').AsFloat;
          End;

          If Not chkSoResumo.Checked Then
          Begin
            //Base ICMS
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 06, fltBasIcm);

            //Valor ICMS
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 07, fltValIcm);


            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 08, fltCredIcmConsIte);
            FormatoNumerico(LinhaAtual, 09);
            Escrever(LinhaAtual, 09, fltValIcm - fltCredIcmConsIte);//ICMS A PAGAR VALICM - CRED.ICMS
          End;

          fltIcmSaiForaConsumidor := fltIcmSaiForaConsumidor + (fltValIcm - fltCredIcmConsIte);
          fltTotIcmsSaiFora := fltTotIcmsSaiFora + (fltValIcm - fltCredIcmConsIte);

          pSomaResumoItem(cdsItens.FieldByName('CODITE').AsString, 0, (fltValIcm - fltCredIcmConsIte));

          If Not chkSoResumo.Checked Then
          Begin
            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
            Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
          End;

          cdsSaida.Next;

          pgbItem.StepBy(1);
          Application.ProcessMessages;
        End;

        If Not chkSoResumo.Checked Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 08, 'TOTAL E');
          FormatoNumerico(LinhaAtual, 09);
          Escrever(LinhaAtual, 09, fltIcmSaiForaConsumidor);
          Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
          Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

          ProximaLinha;
          ProximaLinha;

          (**************************************************************************************************)
          Escrever(ProximaLinha,  01, ' QUADRO 09 ');  // 2
          Escrever(LinhaAtual, 04, 'TOTAL A (+)');
          Escrever(LinhaAtual, 07, 'TOTAL B (+)');
          Escrever(LinhaAtual, 10, 'TOTAL C (+)');
          Escrever(LinhaAtual, 13, 'TOTAL D (+)');
          Escrever(LinhaAtual, 16, 'TOTAL E (+)');
          Escrever(LinhaAtual, 18, ' ');
          Escrever(LinhaAtual, 19, 'TOTAL F = TOTAL A + TOTAL B + TOTAL C + TOTAL D + TOTAL E');
          Escrever(LinhaAtual, 20, ' ');
          ProximaLinha;
          ProximaLinha;
          Escrever(LinhaAtual, 03, 'Icms-ST a recolher nas');
          Escrever(LinhaAtual, 06, 'Icms a recolher nas');
          Escrever(LinhaAtual, 09, 'Icms a recolher nas saídas');
          Escrever(LinhaAtual, 12, 'Icms a recolher nas saídas');
          Escrever(LinhaAtual, 15, 'Icms a recolher nas saídas');
          Escrever(LinhaAtual, 18, 'Valor a recolher a título de ST');
          ProximaLinha;
          Escrever(LinhaAtual, 03, 'saídas internas');
          Escrever(LinhaAtual, 06, 'saídas interestaduais');
          Escrever(LinhaAtual, 09, 'interestaduais com Sit. Trib.');
          Escrever(LinhaAtual, 12, 'dentro do estado - Artigo 534ZZA.');
          Escrever(LinhaAtual, 15, 'a consumidor final fora do estado.');
          Escrever(LinhaAtual, 18, '(cláusula terceira Termo de Acordo SEFAZ Nº ' + strNroCef + ')');
          ProximaLinha;
          FormatoNumerico(LinhaAtual, 04);
          Escrever(LinhaAtual, 04, fltIcmSaiDentro);
          FormatoNumerico(LinhaAtual, 07);
          Escrever(LinhaAtual, 07, fltIcmSaiForaSemST);
          FormatoNumerico(LinhaAtual, 10);
          Escrever(LinhaAtual, 10, fltIcmSaiForaComST);
          FormatoNumerico(LinhaAtual, 13);
          Escrever(LinhaAtual, 13, fltIcmSaiDentroArt534);
          FormatoNumerico(LinhaAtual, 16);
          Escrever(LinhaAtual, 16, fltIcmSaiForaConsumidor);
          FormatoNumerico(LinhaAtual, 19);
          Escrever(LinhaAtual, 19, fltIcmSaiDentro+fltIcmSaiForaSemST+fltIcmSaiForaComST+fltIcmSaiDentroArt534+fltIcmSaiForaConsumidor);

          Mesclar('A'     + IntToStr(LinhaAtual-4), 'B' + IntToStr(LinhaAtual-4));
          Bordas('A'      + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('A' + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), Esquerda);

          Mesclar('C'     + IntToStr(LinhaAtual-1), 'E' + IntToStr(LinhaAtual-1));
          Mesclar('C'     + IntToStr(LinhaAtual-2), 'E' + IntToStr(LinhaAtual-2));
          Bordas('C'      + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('C' + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), Centro);

          Mesclar('F'     + IntToStr(LinhaAtual-1), 'H' + IntToStr(LinhaAtual-1));
          Mesclar('F'     + IntToStr(LinhaAtual-2), 'H' + IntToStr(LinhaAtual-2));
          Bordas('F'      + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('F' + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), Centro);

          Mesclar('I'     + IntToStr(LinhaAtual-1), 'K' + IntToStr(LinhaAtual-1));
          Mesclar('I'     + IntToStr(LinhaAtual-2), 'K' + IntToStr(LinhaAtual-2));
          Bordas('I'      + IntToStr(LinhaAtual)  , 'K' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('I' + IntToStr(LinhaAtual)  , 'K' + IntToStr(LinhaAtual-4), Centro);

          Mesclar('L'     + IntToStr(LinhaAtual-1), 'N' + IntToStr(LinhaAtual-1));
          Mesclar('L'     + IntToStr(LinhaAtual-2), 'N' + IntToStr(LinhaAtual-2));
          Bordas('L'      + IntToStr(LinhaAtual)  , 'N' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('L' + IntToStr(LinhaAtual)  , 'N' + IntToStr(LinhaAtual-4), Centro);

          Mesclar('O'     + IntToStr(LinhaAtual-1), 'Q' + IntToStr(LinhaAtual-1));
          Mesclar('O'     + IntToStr(LinhaAtual-2), 'Q' + IntToStr(LinhaAtual-2));
          Bordas('O'      + IntToStr(LinhaAtual)  , 'Q' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('O' + IntToStr(LinhaAtual)  , 'Q' + IntToStr(LinhaAtual-4), Centro);

          Mesclar('R'     + IntToStr(LinhaAtual-1), 'T' + IntToStr(LinhaAtual-1));
          Mesclar('R'     + IntToStr(LinhaAtual-2), 'T' + IntToStr(LinhaAtual-2));
          Bordas('R'      + IntToStr(LinhaAtual)  , 'T' + IntToStr(LinhaAtual-4), True, True, True, True);
          Alinhamento('R' + IntToStr(LinhaAtual)  , 'T' + IntToStr(LinhaAtual-4), Centro);

          CorFundo('A'    + IntToStr(LinhaAtual), 'T' + IntToStr(LinhaAtual-4), RGB(135,200,250));

          AutoAjuste;
        End;

        If blnTemSaida Then
        Begin
          blnGerTot := True;

          If Not chkSoResumo.Checked Then
          Begin
            SalvarArquivo;
          End;
        End;

        If Not chkSoResumo.Checked Then
          FecharArquivo;

      End;

      cdsItens.Next;

      pgbProgresso.StepBy(1);
      Application.ProcessMessages;

    End;

    If blnGerTot Then
    With objExcel Do
    Begin
      objExcel.CriarArquivo(fraPathExp.edtDirectory.text + 'Acordo_SEFAZ_' + AnsiReplaceStr(strNroCef, '/', '_') + '_TOTAIS');

      PintarTudo(Branco);
      DefinirFonte(Times, 08);

      Escrever(02, 01, 'ANEXO ÚNICO DO TERMO DE ACORDO SEFAZ Nº ' + strNroCef);
      Negrito (02, 01, True);
      Mesclar('A2', 'M2');
      Alinhamento('A2', 'A2', Centro);

      Escrever(03, 01, 'TERMO DE ACORDO DE SUBSTITUIÇÃO TRIBUTÁRIA');
      Negrito (03, 01, True);
      Mesclar('A3', 'M3');
      Alinhamento('A3', 'A3', Centro);

      Escrever(04, 01, 'DEMONSTRATIVO DO CÁLCULO DO ICMS-ST A RECOLHER');
      Negrito (04, 01, True);
      Mesclar('A4', 'M4');
      Alinhamento('A4', 'A4', Centro);

      Bordas('A8',  'H15', True, True, True, True);
      Bordas('I8',  'M15', True, True, True, True);

      (**************************************************************************************************)
      Escrever(08, 01, ' QUADRO 01 - Razão Social - Periodo: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text);
      Negrito (08, 01, True);
      Mesclar('A8', 'G8');
      Escrever(10, 01, fRetNomeEmpresaSelec(edtCodEmpresa.Text));
      Negrito (10, 01, True);
      Escrever(11, 01, fRetEnderecoEmpresa(edtCodEmpresa.Text));
      Negrito (11, 01, True);
      Escrever(12, 01, qryEmp.FieldByName('EMP_BAIRRO').AsString);
      Negrito (12, 01, True);
      Escrever(13, 01, 'CNPJ: ' + fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, FPais));
      Negrito (13, 01, True);
      Escrever(14, 01, 'I.ESTADUAL: ' + qryEmp.FieldByName('EMP_I_E_S_').AsString);
      Negrito (14, 01, True);

      (**************************************************************************************************)
      Escrever(08, 09, ' QUADRO 02');
      Negrito (08, 09, True);
      Mesclar('I8', 'L8');
      Escrever(09, 09, 'Produto: ');
      Negrito (09, 09, True);
      Escrever(09, 10, 'TODOS');
      CorFonte('J9', 'J9', Vermelho);
      Negrito (09, 10, True);
      Mesclar('J9', 'M9');

      LinhaAtual := 17;

      (**************************************************************************************************)
      Escrever(ProximaLinha,  01, ' QUADRO 03 ');  // 2
      Escrever(LinhaAtual, 04, 'TOTAL A (+)');
      Escrever(LinhaAtual, 07, 'TOTAL B (+)');
      Escrever(LinhaAtual, 11, 'TOTAL C = TOTAL A + TOTAL B');
      ProximaLinha;
      ProximaLinha;
      Escrever(LinhaAtual, 03, 'Icms-ST a recolher nas saídas internas');
      Escrever(LinhaAtual, 06, 'Icms a recolher nas saídas interestaduais');
      Escrever(LinhaAtual, 09, 'Valor a recolher a título de ST');
      ProximaLinha;
      Escrever(LinhaAtual, 03, '(TOTAL DO PERÍODO)');
      Escrever(LinhaAtual, 06, '(TOTAL DO PERÍODO)');
      Escrever(LinhaAtual, 09, '(cláusula terceira Termo de Acordo SEFAZ Nº ' + strNroCef + ')');
      ProximaLinha;
      Escrever(LinhaAtual, 04, fltTotIcmsSaiDentro);
      FormatoNumerico(LinhaAtual, 04);
      Escrever(LinhaAtual, 07, fltTotIcmsSaiFora);
      FormatoNumerico(LinhaAtual, 07);
      Escrever(LinhaAtual, 11, fltTotIcmsSaiDentro+fltTotIcmsSaiFora);
      FormatoNumerico(LinhaAtual, 11);

      Mesclar('A'     + IntToStr(LinhaAtual-4), 'B' + IntToStr(LinhaAtual-4));
      Bordas('A'      + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('A' + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), Esquerda);

      Mesclar('C'     + IntToStr(LinhaAtual-1), 'E' + IntToStr(LinhaAtual-1));
      Mesclar('C'     + IntToStr(LinhaAtual-2), 'E' + IntToStr(LinhaAtual-2));
      Bordas('C'      + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('C' + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), Centro);

      Mesclar('F'     + IntToStr(LinhaAtual-1), 'H' + IntToStr(LinhaAtual-1));
      Mesclar('F'     + IntToStr(LinhaAtual-2), 'H' + IntToStr(LinhaAtual-2));
      Bordas('F'      + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('F' + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), Centro);

      Mesclar('I'     + IntToStr(LinhaAtual-1), 'M' + IntToStr(LinhaAtual-1));
      Mesclar('I'     + IntToStr(LinhaAtual-2), 'M' + IntToStr(LinhaAtual-2));
      Bordas('I'      + IntToStr(LinhaAtual)  , 'M' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('I' + IntToStr(LinhaAtual)  , 'M' + IntToStr(LinhaAtual-4), Centro);

      CorFundo('A'    + IntToStr(LinhaAtual), 'M' + IntToStr(LinhaAtual-4), RGB(255,250,130));

      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;
    End;

    If blnGerTot Or chkSoResumo.Checked Then
    Begin
      pMontaResumoExcel;
      pMontaCreditoICMS;
      pMontaResumoQuadro4;

      fMensagem('', 'O arquivo de exportação foi gerado com sucesso!', ['&OK']);
    End Else
    Begin
      pMensagemOk('Não há informações para geração!');
    End;

  Finally
    FreeAndNil(qryEmp);
    FreeAndNil(objExcel);
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
    pgbProgresso.Position := 0;
    pgbItem.Position := 0;
    btnConfirma.Enabled := True;
  End;
end;

procedure TfrmRelFiscGerArqAcMod2.pMontaResumoExcel;
  Var
    objGeraExcel: TGeraExcel;
    qryArqRes: TUniQuery;
Begin
  fDropTable('ARQRES');

  qryArqRes := fCriaQuery;

  With qryArqRes, SQL Do
  Begin
    Add('CREATE TABLE ARQRES (');
    Add('CODITE CHAR(' + IntToStr(fTamCodIte) + '),');
    Add('DESITE VARCHAR(70),');
    Add('ICMDEN DECIMAL(12,2),');
    Add('ICMFOR DECIMAL(12,2)');
    Add('  )');

    ExecSQL;

    qryArqRes.SQL.Clear;

    Add('INSERT INTO ARQRES');
    Add('VALUES');
    Add('(:CODITE, :DESITE, :ICMDEN, :ICMFOR)');
  End;

  With cdsResumoItem Do
  Begin
    IndexFieldNames := 'DESITE';
    First;

    While Not Eof Do
    Begin
      qryArqRes.Close;
      qryArqRes.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
      qryArqRes.ParamByName('DESITE').AsString := FieldByName('DESITE').AsString;
      qryArqRes.ParamByName('ICMDEN').AsFloat  := FieldByName('ICMDEN').AsFloat;
      qryArqRes.ParamByName('ICMFOR').AsFloat  := FieldByName('ICMFOR').AsFloat;
      qryArqRes.ExecSQL;

      Next;
    End;
  End;

  FreeAndNil(qryArqRes);

  Exit;
  objGeraExcel := TGeraExcel.Create(cdsResumoItem.qryQuery, pgbProgresso);
  With objGeraExcel, cdsResumoItem Do
  Begin
    IndexFieldNames := 'DESITE';
    First;

    strNomRel := 'RESUMO DO TERMO DE ACORDO DO RESSARCIMENTO';

    strNomArq  := ExtractFilePath(Application.ExeName) + 'RESUMO_RESSARCIMENTO.XLS';

    If FileExists(strNomArq) Then
      DeleteFile(strNomArq);

    AddCampo( 'CODITE', 'CÓDIGO');
    AddCampo( 'DESITE', 'DESCRIÇÃO DO ITEM');
    AddCampo( 'ICMDEN', 'Icms-ST a recolher nas saídas internas');
    AddCampo( 'ICMFOR', 'Icms a recolher nas saídas interestaduais');

    AddTotais('ICMDEN');
    AddTotais('ICMFOR');

    OnSomaResumo  := pSomaTotaisResumo;
    OnMontaResumo := pMontaResumo;

    objGeraExcel.fGerarRelatorio;

    FreeAndNil(objGeraExcel);
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pCriaClientResumoQuadro04;
  Var
    sqlSQL: String;
Begin
   sqlSQL := '';
   sqlSQL := sqlSQL + ' SELECT ';
   sqlSQL := sqlSQL + '   CAST("" AS CHAR(50)) AS CNPDES, ';
   sqlSQL := sqlSQL + '   CAST("" AS CHAR(3))  AS UNFDES, ';
   sqlSQL := sqlSQL + '   CAST("" AS CHAR(6))  AS NUMDOC, ';
   sqlSQL := sqlSQL + '   CURRENT_DATE()       AS DTAENT, ';
   sqlSQL := sqlSQL + '   0.00 AS BASICM, ';
   sqlSQL := sqlSQL + '   0.00 AS VALICM, ';
   sqlSQL := sqlSQL + '   0.00 AS BASRET, ';
   sqlSQL := sqlSQL + '   0.00 AS VALRET  ';
   sqlSQL := sqlSQL + ' FROM CADEMP ';
   sqlSQL := sqlSQL + ' WHERE FALSE ';
   cdsResumoQuadro4 := TZClient.Create(Self);
   cdsResumoQuadro4.qryQuery.SQL.Text:= sqlSQL;
   If Not cdsResumoQuadro4.fAbreClient(True, 'TfrmRelFiscGerArqAcMod2.pCriaClientResumoQuadro04') Then
     blnDeuErro := True;
End;

procedure TfrmRelFiscGerArqAcMod2.pMontaResumoQuadro4;
  Var
    objGeraExcel: TGeraExcel;
Begin
  objGeraExcel := TGeraExcel.Create(cdsResumoQuadro4.qryQuery, pgbProgresso);
  With objGeraExcel, cdsResumoQuadro4 Do
  Begin
    strNomRel := 'RESUMO DO QUADRO 4 - NOTAS FISCAIS DE SAÍDAS INTERNAS';

    strNomArq  := ExtractFilePath(Application.ExeName) + 'RESUMO_QUADRO_04.XLS';

    If FileExists(strNomArq) Then
      DeleteFile(strNomArq);

    AddCampo( 'CNPDES', 'CNPJ DESTINATÁRIO');
    AddCampo( 'UNFDES', 'UF');
    AddCampo( 'NUMDOC', 'No. NF');
    AddCampo( 'DTAENT', 'Data');
    AddCampo( 'BASICM', 'Base Cálculo');
    AddCampo( 'VALICM', 'Valor ICMS');
    AddCampo( 'BASRET', 'Base Retido');
    AddCampo( 'VALRET', 'Valor Retido');

    AddTotais('BASICM');
    AddTotais('VALICM');
    AddTotais('BASRET');
    AddTotais('VALRET');

    OnSomaResumo  := pSomaTotaisResumoQuadro04;
    OnMontaResumo := pMontaResumoQuadro04;

    fGerarRelatorio;

  End;
  FreeAndNil(objGeraExcel);
End;

procedure TfrmRelFiscGerArqAcMod2.pMontaResumoQuadro04(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    Escrever(ProximaLinha, 02, 'TOTAL GERAL');
    Alinhamento(LinhaAtual, 02, Direita);

    Escrever(LinhaAtual,   05, Quebra.Totais['BASICM']);
    Escrever(LinhaAtual,   06, Quebra.Totais['VALICM']);
    Escrever(LinhaAtual,   07, Quebra.Totais['BASRET']);
    Escrever(LinhaAtual,   08, Quebra.Totais['VALRET']);

    FormatoNumerico(LinhaAtual,   05);
    FormatoNumerico(LinhaAtual,   06);
    FormatoNumerico(LinhaAtual,   07);
    FormatoNumerico(LinhaAtual,   08);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;

procedure TfrmRelFiscGerArqAcMod2.pSomaResumoQuadro4(strCnpDes, strUnFDes,
  strNumDoc: String; dtaDtaEnt: Tdate; fltBasIcm, fltValIcm, fltBasRet, fltValRet: Double);
Begin
  With cdsResumoQuadro4 Do
  Begin
    If Locate('CNPDES;NUMDOC', VarArrayOf([strCnpDes, strNumDoc]), []) Then
    Begin
      Edit;
    End Else
    Begin
      Insert;

      FieldByName('CNPDES').AsString   := strCnpDes;
      FieldByName('UNFDES').AsString   := strUnFDes;
      FieldByName('NUMDOC').AsString   := strNumDoc;
      FieldByName('DTAENT').AsDateTime := dtaDtaEnt;

      FieldByName('BASICM').AsFloat    := 0;
      FieldByName('VALICM').AsFloat    := 0;
      FieldByName('BASRET').AsFloat    := 0;
      FieldByName('VALRET').AsFloat    := 0;
    End;

    FieldByName('BASICM').AsFloat    := FieldByName('BASICM').AsFloat + fltBasIcm;
    FieldByName('VALICM').AsFloat    := FieldByName('VALICM').AsFloat + fltValIcm;
    FieldByName('BASRET').AsFloat    := FieldByName('BASRET').AsFloat + fltBasRet;
    FieldByName('VALRET').AsFloat    := FieldByName('VALRET').AsFloat + fltValRet;

    Post;
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pSomaTotaisResumoQuadro04(Var Totais: TTotais; Dados: TDataSet);
begin
  Totais['BASICM'] := Totais['BASICM'] + (Dados.FieldByName('BASICM').AsCurrency);
  Totais['VALICM'] := Totais['VALICM'] + (Dados.FieldByName('VALICM').AsCurrency);
  Totais['BASRET'] := Totais['BASRET'] + (Dados.FieldByName('BASRET').AsCurrency);
  Totais['VALRET'] := Totais['VALRET'] + (Dados.FieldByName('VALRET').AsCurrency);
End;

procedure TfrmRelFiscGerArqAcMod2.pSomaTotaisResumo(Var Totais: TTotais; Dados: TDataSet);
begin
  Totais['ICMDEN'] := Totais['ICMDEN'] + (Dados.FieldByName('ICMDEN').AsCurrency);
  Totais['ICMFOR'] := Totais['ICMFOR'] + (Dados.FieldByName('ICMFOR').AsCurrency);
End;

procedure TfrmRelFiscGerArqAcMod2.pMontaResumo(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    Escrever(ProximaLinha, 02, 'TOTAL GERAL');
    Alinhamento(LinhaAtual, 02, Direita);

    Escrever(LinhaAtual,   03, Quebra.Totais['ICMDEN']);
    Escrever(LinhaAtual,   04, Quebra.Totais['ICMFOR']);

    FormatoNumerico(LinhaAtual,   03);
    FormatoNumerico(LinhaAtual,   04);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;

procedure TfrmRelFiscGerArqAcMod2.pMontaCreditoICMS;
  Var
    objGeraExcel: TGeraExcel;
Begin
  objGeraExcel := TGeraExcel.Create(cdsCreditoIcms.qryQuery, pgbProgresso);
  With objGeraExcel, cdsCreditoIcms Do
  Begin
    IndexFieldNames := 'QUADRO;NUMDOC;DESITE';
    First;

    strNomRel := 'CRÉDITO DE ICMS - TERMO DE ACORDO DO RESSARCIMENTO';

    strNomArq  := ExtractFilePath(Application.ExeName) + 'CREDITO_ICMS_RESSARCIMENTO.XLS';

    If FileExists(strNomArq) Then
      DeleteFile(strNomArq);

    AddCampo( 'CODITE', 'CÓDIGO');
    AddCampo( 'DESITE', 'DESCRIÇÃO DO ITEM');
    AddCampo( 'CREICM', 'CRÉDITO ICMS');

    AddTotais('CRENOT');

    AddQuebra('QUADRO', 'QUADRO: ');
    AddQuebra('NUMDOC', 'DOCUEMTO: ');

    OnSomaResumo  := pSomaTotaisCredito;
    OnMontaResumo := pMontaResumoCredito;

    objGeraExcel.fGerarRelatorio;

    FreeAndNil(objGeraExcel);
  End;
End;

procedure TfrmRelFiscGerArqAcMod2.pSomaTotaisCredito(Var Totais: TTotais; Dados: TDataSet);
begin
  Totais['CRENOT'] := Totais['CRENOT'] + (Dados.FieldByName('CREICM').AsCurrency);
End;

procedure TfrmRelFiscGerArqAcMod2.pMontaResumoCredito(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin

    If (Quebra.NomeCampo = 'NUMDOC') Then
      Escrever(ProximaLinha, 02, 'DOCUMENTO: ')

    Else If (Quebra.NomeCampo = 'QUADRO') Then
      Escrever(ProximaLinha, 02, 'QUADRO: ')

    Else If (Quebra.NomeCampo = 'QUADRO') Then
      Escrever(ProximaLinha, 02, Quebra.NomeCampo);

    Alinhamento(LinhaAtual, 02, Direita);
    Escrever(LinhaAtual,   03, Quebra.Totais['CRENOT']);

    FormatoNumerico(LinhaAtual,   03);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;


end.

