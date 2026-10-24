unit untRelEstListaAjuste;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, Windows, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, DB, untTypesSistema,
  untFuncoesFactory, Uni, AppEvnts, BitBtnLockedIncrem,untClassPanelCx,
  ComCtrls, untExcel, untGeraExcel, frxExportCSVTestabilidade, untIFuncoes;

type
  TfrmRelEstListaAjuste = class(TfrmPaiRelatorio)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label3: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtNumDoc: TEditFocus;
    Label7: TLabel;
    lblDescricao: TLabel;
    edtDescri: TEditFocus;
    edtLocFis: TEditFocus;
    Label5: TLabel;
    Label1: TLabel;
    edtRefere: TEditFocus;
    edtRefFin: TEditFocus;
    Label4: TLabel;
    Label2: TLabel;
    edtUnidade: TEditFocus;
    rdgOrdem: TRadioGroup;
    chkImpObs: TCheckBox;
    pgbProgresso: TProgressBar;
    edtCodDig: TEditFocus;
    lblCodDig: TLabel;
    edtNomDig: TEditFocus;
    rdgOriAju: TRadioGroup;
    GroupBox2: TGroupBox;
    cmbPreExi: TComboBox;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNumDocExit(Sender: TObject);
    procedure rdgOrdemClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cmbPreExiKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    blnCadLoc: Boolean;

    qryRelatorio: TUniQuery;

    arrAjuste: TConsultasArray;
    strImpAju: String;

    procedure pSetaExibir;
    function fGetCampoTotal : String;
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);

    procedure pCriaQryRelatorio;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelEstListaAjuste: TfrmRelEstListaAjuste;

implementation

uses untQckEstListaAjuste, untPai;

{$R *.dfm}

procedure TfrmRelEstListaAjuste.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstListaAjuste.pCarregaGrupo(Var qryCadGru: TUniQuery);
Begin
  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';
End;

procedure TfrmRelEstListaAjuste.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstListaAjuste.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text)
     Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmRelEstListaAjuste.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmRelEstListaAjuste.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstListaAjuste.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelEstListaAjuste.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);


  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;

end;

procedure TfrmRelEstListaAjuste.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstListaAjuste.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtNumDoc Then
    Begin
      pDesmarcaLista(edtNumDoc,arrAjuste);
    End

    Else If (Sender = edtLocFis) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFis.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
          Begin
            pMensagemOk('Localização Física não encontrada!');
            Result := False;
          End

        End;

      End;

    End

    Else If (Sender = edtUnidade) Then
    Begin
      If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) And (Not fEmptyStr(edtUnidade.Text))  Then
      Begin
        fMensagem('ATENÇÃO!','Código da Unidade não encontrado!', ['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEstListaAjuste.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strAjuste: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE                            ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODGRU,".",DET_CODITE) AS CODITE, ';
    strSQL := strSQL + '  CONCAT(DET_CODACA, "-", DET_EMPACA) AS CODACA, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU,                      ';
    strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3),"000", " - ", LIN.GRU_DESGRU) AS LINHA, ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODGRU, " - ", GRU.GRU_DESGRU) AS GRUPO, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR,                      ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR,                        ';
    strSQL := strSQL + '  DET_CODEMP AS CODEMP,                        ';
    strSQL := strSQL + '  EMP_NOMEMP AS NOMEMP,                        ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE,                        ';
    strSQL := strSQL + '  DET_REFERE AS REFERE,                        ';
    strSQL := strSQL + '  DET_NUMLOT AS NUMLOT,                        ';
    strSQL := strSQL + '  DET_UNIDAD AS UNIDAD,                        ';
    strSQL := strSQL + '  DET_NUMDOC AS NUMDOC,                        ';
    strSQL := strSQL + '  DET_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '  DET_QTDITE AS QTDITE,                        ';
    strSQL := strSQL + '  DET_CODDIG AS CODDIG,                        ';
    strSQL := strSQL + '  DET_CODVEN AS CODVEN,                        ';
    strSQL := strSQL + '  0.0000     AS QTD_ML,                        ';
    strSQL := strSQL + '  IF(DET_CLAFIS = "1999", "ENT", "SAI") AS ENTSAI, ';
    strSQL := strSQL + '  GER_MEN001 AS MEN001, ';
    strSQL := strSQL + '  GER_MEN002 AS MEN002, ';

    strSQL := strSQL + '  (SELECT COUNT(*) FROM MOVDET D  ';
    strSQL := strSQL + '   WHERE D.DET_SEQGER = M.AUTOINCREM) AS QTDREG, ';

    strSQL := strSQL + fGetCampoTotal + ' AS VALAJU ';

    strSQL := strSQL + 'FROM                                           ';
    strSQL := strSQL + '  MOVDET                                      ';

    strSQL := strSQL + 'INNER JOIN MOVGER M ON M.AUTOINCREM = MOVDET.DET_SEQGER  ';
    strSQL := strSQL + 'INNER JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM  ';

    strSQL := strSQL + 'INNER JOIN ITEGER G ON           ';
    strSQL := strSQL + '  DET_CODITE = G.ITE_CODITE AND  ';
    strSQL := strSQL + '  DET_CODEMP = G.ITE_CODEMP      ';

    strSQL := strSQL + 'INNER JOIN CADITE I ON           ';
    strSQL := strSQL + '  DET_CODITE = I.ITE_CODITE      ';

    strSQL := strSQL + 'INNER JOIN CADEMP ON           ';
    strSQL := strSQL + '  EMP_CODEMP = DET_CODEMP      ';

    strSQL := strSQL + 'LEFT JOIN CADFOR     ON FOR_CODFOR = I.ITE_CODFOR        ';
    strSQL := strSQL + 'LEFT JOIN CADGRU LIN ON LIN.GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"000") ';
    strSQL := strSQL + 'LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = I.ITE_CODGRU ';

    strSQL := strSQL + 'WHERE                            ';

    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  AND ';
    strSQL := strSQL + '  DET_ESPDOC = "AJ"                           ';

    strSql := strSQL + fStrLocate(edtNumDoc,arrAjuste,'DET_NUMDOC','NUMDOC');

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin

      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';

    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND DET_CODEMP = :CODEMP   '
    Else
      strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtProdutos.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODITE = :CODITE ';

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';

    If Not fEmptyStr(edtCodDig.Text) Then
      strSQL := strSQL + '  AND DET_CODDIG = :CODDIG ';

    If Not fEmptyStr(edtDescri.Text) Then
      strSQL := strSQL + '  AND (LOCATE(:DESITE, I.ITE_DESITE) >0 ) ';

    If Not fEmptyStr(edtRefere.Text) Then
    Begin

      If (Not fEmptyStr(edtRefFin.Text)) Then
        strSQL := strSQL + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN '
      Else
        strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';

    End;

    If Not fEmptyStr(edtLocFis.Text) Then
      strSQL := strSQL + '  AND G.ITE_LOCFIS LIKE :LOCFIS ';

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';

    Case rdgOriAju.ItemIndex Of
      0: strSQL := strSQL + '  AND GER_MEN001 <> "REF.: CONTAGEM DE BALANCO" ';
      1: strSQL := strSQL + '  AND GER_MEN001 = "REF.: CONTAGEM DE BALANCO" ';
    End;

    strSQL := strSQL + ' UNION ALL                                     ';

    strSQL := strSQL + 'SELECT SQL_NO_CACHE                            ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODGRU,".",DET_CODITE) AS CODITE, ';
    strSQL := strSQL + '  CONCAT(DET_CODACA, "-", DET_EMPACA) AS CODACA, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU,                      ';
    strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3),"000", " - ", LIN.GRU_DESGRU) AS LINHA, ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODGRU, " - ", GRU.GRU_DESGRU) AS GRUPO, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR,                      ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR,                        ';
    strSQL := strSQL + '  DET_CODEMP AS CODEMP,                        ';
    strSQL := strSQL + '  EMP_NOMEMP AS NOMEMP,                        ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE,                        ';
    strSQL := strSQL + '  DET_REFERE AS REFERE,                        ';
    strSQL := strSQL + '  DET_NUMLOT AS NUMLOT,                        ';
    strSQL := strSQL + '  DET_UNIDAD AS UNIDAD,                        ';
    strSQL := strSQL + '  DET_NUMFAT AS NUMDOC,                        ';
    strSQL := strSQL + '  DET_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '  0.0000     AS QTDITE,                        ';
    strSQL := strSQL + '  DET_CODDIG AS CODDIG,                        ';
    strSQL := strSQL + '  DET_CODVEN AS CODVEN,                        ';
    strSQL := strSQL + '  DET_QTDITE AS QTD_ML,                        ';
    strSQL := strSQL + '  IF(DET_CLAFIS = "1999", "ENT", "SAI") AS ENTSAI, ';
    strSQL := strSQL + '  GER_MEN001 AS MEN001, ';
    strSQL := strSQL + '  GER_MEN002 AS MEN002, ';

    strSQL := strSQL + '  (SELECT COUNT(*) FROM MOVDET D  ';
    strSQL := strSQL + '   WHERE D.DET_SEQGER = M.AUTOINCREM) AS QTDREG, ';

    strSQL := strSQL + fGetCampoTotal + ' AS VALAJU ';

    strSQL := strSQL + 'FROM                                           ';
    strSQL := strSQL + '  MOVDET                                      ';

    strSQL := strSQL + 'INNER JOIN MOVGER M ON M.AUTOINCREM = MOVDET.DET_SEQGER  ';
    strSQL := strSQL + 'INNER JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM ';

    strSQL := strSQL + 'INNER JOIN ITEGER G ON           ';
    strSQL := strSQL + '  DET_CODITE = G.ITE_CODITE AND  ';
    strSQL := strSQL + '  DET_CODEMP = G.ITE_CODEMP      ';

    strSQL := strSQL + 'INNER JOIN CADITE I ON           ';
    strSQL := strSQL + '  DET_CODITE = I.ITE_CODITE      ';

    strSQL := strSQL + 'INNER JOIN CADEMP ON           ';
    strSQL := strSQL + '  EMP_CODEMP = DET_CODEMP      ';

    strSQL := strSQL + 'LEFT JOIN CADFOR     ON FOR_CODFOR = I.ITE_CODFOR        ';
    strSQL := strSQL + 'LEFT JOIN CADGRU LIN ON LIN.GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"000") ';
    strSQL := strSQL + 'LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = I.ITE_CODGRU ';

    strSQL := strSQL + 'WHERE                            ';

    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  AND  ';
    strSQL := strSQL + '  DET_ESPDOC = "ML"                       AND  ';
    strSQL := strSQL + '  DET_TIPFAT = "AJ"                            ';

    strSql := strSQL + fStrLocate(edtNumDoc,arrAjuste,'DET_NUMFAT','NUMDOC');

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin

      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';

    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND DET_CODEMP = :CODEMP   '
    Else
      strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtProdutos.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODITE = :CODITE ';

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';

    If Not fEmptyStr(edtCodDig.Text) Then
      strSQL := strSQL + '  AND DET_CODDIG = :CODDIG ';

    If Not fEmptyStr(edtDescri.Text) Then
      strSQL := strSQL + '  AND (LOCATE(:DESITE, I.ITE_DESITE) >0 ) ';

    If Not fEmptyStr(edtRefere.Text) Then
    Begin

      If (Not fEmptyStr(edtRefFin.Text)) Then
        strSQL := strSQL + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN '
      Else
        strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';

    End;

    If Not fEmptyStr(edtLocFis.Text) Then
      strSQL := strSQL + '  AND G.ITE_LOCFIS LIKE :LOCFIS ';

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';

    Case rdgOriAju.ItemIndex Of
      0: strSQL := strSQL + '  AND GER_MEN001 <> "REF.: CONTAGEM DE BALANCO" ';
      1: strSQL := strSQL + '  AND GER_MEN001 = "REF.: CONTAGEM DE BALANCO" ';
    End;

    strSQL := strSQL + ' ORDER BY ';

    Case rdgOrdem.Itemindex Of
      0: strSQL := strSQL + ' CODITE, DTAENT, NUMDOC ';
      1: strSQL := strSQL + ' NUMDOC, DESITE ';
      2: strSQL := strSQL + ' DTAENT, NUMDOC, DESITE ';
      3: strSQL := strSQL + ' DESITE, DTAENT, NUMDOC ';
      4: strSQL := strSQL + ' CODGRU, DESITE, DTAENT, NUMDOC ';      
      5: strSQL := strSQL + ' NOMFOR, DESITE, DTAENT, NUMDOC ';
      6: strSQL := strSQL + ' CODEMP, DTAENT, NUMDOC, DESITE ';

    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      pSetaParam(edtNumDoc.Text,arrAjuste,strAjuste,'NUMDOC',qryRelatorio);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(edtProdutos.Text) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtFornecedor.Text) Then
        ParamByName('CODFOR').AsString := edtFornecedor.Text;

      If Not fEmptyStr(edtMarca.Text) Then
        ParamByName('CODMAR').AsString := edtMarca.Text;

      If Not fEmptyStr(edtCodDig.Text) Then
        ParamByName('CODDIG').AsString := edtCodDig.Text;
        
      If Not fEmptyStr(edtDescri.Text) Then
        ParamByName('DESITE').AsString := edtDescri.Text;

      If Not fEmptyStr(edtLocFis.Text) Then
        ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';

      If Not fEmptyStr(edtRefere.Text) Then
      Begin

        If (Not fEmptyStr(edtRefFin.Text)) Then
        Begin
          ParamByName('REFERE').AsString := edtRefere.Text;
          ParamByName('REFFIN').AsString := edtRefFin.Text;

          If Length(edtRefere.Text) > Length(edtRefFin.Text) Then
            ParamByName('MAIOR').AsString := edtRefere.Text
          Else
            ParamByName('MAIOR').AsString := edtRefFin.Text;

        End
        Else
          ParamByName('REFERE').AsString := edtRefere.Text + '%';

      End;

      If Not fEmptyStr(edtUnidade.Text) Then
        ParamByName('CODUNI').AsString := edtUnidade.Text;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        If (edtDestino.Text = 'E') Then
          pGeraExcel(qryRelatorio)
        Else
        Begin
          pCriarFormularios(TfrmQckEstListaAjuste,frmQckEstListaAjuste);

          If fCfgSis('CTLEST') <> 1 Then
            frmQckEstListaAjuste.lblLote.Caption := 'ARMAZEM';

          frmQckEstListaAjuste.dtsRelatorio.DataSet := qryRelatorio;

          frmQckEstListaAjuste.blnImpObs := chkImpObs.Checked;

          If strTipImp = 'M' Then
            frmQckEstListaAjuste.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckEstListaAjuste.qckPagina.DefaultFilter := Nil;

          frmQckEstListaAjuste.rllNomeRelatorio.Caption := 'RELATORIO DE AJUSTES DE ESTOQUES';

          frmQckEstListaAjuste.rllPeriodo.Caption := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          frmQckEstListaAjuste.rllDocumento.Caption := fStrTitulo(edtNumDoc.Text,Nil,arrAjuste,strAjuste,'NUMERO DO AJUSTE');


          Case rdgOrdem.ItemIndex Of
            0: frmQckEstListaAjuste.rllOrdem.Caption := 'ORDENADO POR CODIGO DO PRODUTO';
            1: frmQckEstListaAjuste.rllOrdem.Caption := 'ORDENADO POR NUMERO DO AJUSTE';
            2: frmQckEstListaAjuste.rllOrdem.Caption := 'ORDENADO POR DATA DE EMISSAO';
            3: frmQckEstListaAjuste.rllOrdem.Caption := 'ORDENADO POR DESCRICAO DO PRODUTO';
          End;

          Case rdgOriAju.ItemIndex Of
            0: frmQckEstListaAjuste.rllOriAju.Caption := 'ORIGEM DO AJUSTE: AJUSTE PELA MOVIMENTAÇÃO DE ITENS';
            1: frmQckEstListaAjuste.rllOriAju.Caption := 'ORIGEM DO AJUSTE: AJUSTE POR BALANÇO DE ESTOQUE';
            2: frmQckEstListaAjuste.rllOriAju.Caption := 'ORIGEM DO AJUSTE: TODOS';
          End;

          frmQckEstListaAjuste.rllExiPre.Caption := 'EXIBIR PRECO DE VENDA: SIM';
          frmQckEstListaAjuste.rllTabPre.Visible := True;
          frmQckEstListaAjuste.rllTabPre.Caption := 'TABELA DE VENDA PARA PRECO SUGERIDO: ' + cmbPreExi.Text;
          frmQckEstListaAjuste.rldValAju.Visible := True;
          frmQckEstListaAjuste.rllValAju.Visible := True;
          frmQckEstListaAjuste.rldTotAju.Visible := True;
          frmQckEstListaAjuste.rldTotQtd.Visible := True;
          frmQckEstListaAjuste.rllTotVen.Visible := True;
          frmQckEstListaAjuste.rllValSai.Visible := True;
          frmQckEstListaAjuste.rllValEnt.Visible := True;
          frmQckEstListaAjuste.rllValSal.Visible := True;


          frmQckEstListaAjuste.rllNomeRelatorio.Caption := 'RELATORIO DE AJUSTES DE ESTOQUES';

          If Not fEmptyStr(edtFornecedor.Text) Then
            frmQckEstListaAjuste.rllFornecedor.Caption := 'FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text
          Else
            frmQckEstListaAjuste.rllFornecedor.Caption := 'FORNECEDOR: TODOS';

          If Not fEmptyStr(mskLinhaGrupo.Text) Then
            frmQckEstListaAjuste.rllGrupo.Caption    := 'LINHA / GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
          Else
            frmQckEstListaAjuste.rllGrupo.Caption    := 'LINHA / GRUPO: TODOS';

          If Not fEmptyStr(edtUnidade.Text) Then
            frmQckEstListaAjuste.rllUnidade.Caption  := 'UNIDADE: ' + edtUnidade.Text
          Else
            frmQckEstListaAjuste.rllUnidade.Caption  := 'UNIDADE: TODAS';

          If Not fEmptyStr(edtMarca.Text) Then
            frmQckEstListaAjuste.rllMarcaOrd.Caption := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text
          Else
            frmQckEstListaAjuste.rllMarcaOrd.Caption := 'MARCA: TODAS';

          If Not fEmptyStr(edtCodDig.Text) Then
            frmQckEstListaAjuste.rllDigitador.Caption := 'DIGITADOR: ' + edtCodDig.Text + ' - ' + edtNomDig.Text
          Else
            frmQckEstListaAjuste.rllDigitador.Caption := 'DIGITADOR: TODOS';

          If Not fEmptyStr(edtDescri.Text) Then
            frmQckEstListaAjuste.rllDescri.Caption := 'DESCRICAO: ' + edtDescri.Text
          Else
            frmQckEstListaAjuste.rllDescri.Caption := 'DESCRICAO: TODAS';

          If Not fEmptyStr(edtRefere.Text) Then
          Begin
            frmQckEstListaAjuste.rllRef.Caption := 'REFERENCIA: ' + edtRefere.Text;
            If (Not fEmptyStr(edtRefFin.Text)) Then
              frmQckEstListaAjuste.rllRef.Caption := frmQckEstListaAjuste.rllRef.Caption + ' A ' + edtRefFin.Text;
          End
          Else
            frmQckEstListaAjuste.rllRef.Caption := 'REFERENCIA: TODAS';

          If Not fEmptyStr(edtProdutos.Text) Then
            frmQckEstListaAjuste.rllProdutoOrd.Caption := 'PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text
          Else
            frmQckEstListaAjuste.rllProdutoOrd.Caption := 'PRODUTOS: TODOS';

          If Not fEmptyStr(edtLocFis.Text) Then
            frmQckEstListaAjuste.rllLocFis.Caption := 'LOC. FISICA INICIADA POR: ' + edtLocFis.Text
          Else
            frmQckEstListaAjuste.rllLocFis.Caption := 'LOC. FISICA INICIADA POR: TODAS';

          frmQckEstListaAjuste.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text;

          frmQckEstListaAjuste.rllValAju.Caption := 'PREÇO';

          Case fCfgSis('DEQTAJ', varInteger) Of
            1 : frmQckEstListaAjuste.rdbQtdIte.DisplayMask := '#,#0.0';
            2 : frmQckEstListaAjuste.rdbQtdIte.DisplayMask := '#,##0.00';
            3 : frmQckEstListaAjuste.rdbQtdIte.DisplayMask := '#,###0.000';
            4 : frmQckEstListaAjuste.rdbQtdIte.DisplayMask := '#,####0.0000';
          End;

          With frmQckEstListaAjuste Do
          Begin
            Case rdgOrdem.ItemIndex Of
              5,  // Fornecedor e Empresa
              6 : Begin
                    rlbGrupo.Visible      := True;
                    rlbDetalhe.Visible    := False;
                    rllGroupLinha.Visible := False;
                    if rdgOrdem.ItemIndex = 5 Then
                    Begin
                      rlbGrupo.DataFields  := 'NOMFOR';
                      rllQuebraG.Caption   := 'Fornecedor:';
                      rlbQuebraG.DataField := 'NOMFOR';
                    End
                    Else
                    Begin
                      rlbGrupo.DataFields  := 'CODEMP';
                      rllQuebraG.Caption   := 'Empresa:';
                      rlbQuebraG.DataField := 'NOMEMP';
                    End;


                  End;

                  // Linha Grupo
              4 : Begin
                    rlbGrupo.Visible      := False;
                    rlbDetalhe.Visible    := False;
                    rllGroupLinha.Visible := True;

                  End;

              Else
              Begin
                  rlbGrupo.Visible      := False;
                  rlbDetalhe.Visible    := True;
                  rllGroupLinha.Visible := False;


              End;

            End;
          End;




          If edtDestino.Text = 'V' Then
            frmQckEstListaAjuste.qckPagina.PreviewModal
          Else
            frmQckEstListaAjuste.qckPagina.Print;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckEstListaAjuste);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelEstListaAjuste.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrSel) Then  
  Begin
    fvalidaCampos(edtUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstListaAjuste.edtProdutosExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);

  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;

end;

procedure TfrmRelEstListaAjuste.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Cosulta de Itens', '1') Then
    SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelEstListaAjuste.cmbPreExiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    pSetFocus(edtDestino);
end;

procedure TfrmRelEstListaAjuste.edtCodDigExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodDig.Text) Then
    edtNomDig.Text := 'TODOS'
  Else
    edtNomDig.Text := fRetNomeOperador(edtCodDig.Text);


  If fEmptyStr(edtNomDig.Text) And (Not fEmptyStr(edtCodDig.Text))  Then
  Begin
    fMensagem('AVISO','Código do digitador não encontrado.', ['&O K']);
    edtCodDig.Clear;
    pSetFocus(edtCodDig);
  End;

end;

procedure TfrmRelEstListaAjuste.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodDig, edtNomDig, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstListaAjuste.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelEstListaAjuste.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelEstListaAjuste.edtDestinoExit(Sender: TObject);
begin
  If edtDestino.Text <> 'E' Then
    inherited;
end;

procedure TfrmRelEstListaAjuste.pSetaExibir;
Begin
  if strImpAju = 'TOTITE' Then
    cmbPreExi.ItemIndex := 0
  Else
  if strImpAju = 'TOTCUS' Then
    cmbPreExi.ItemIndex := 1
  Else
  if strImpAju = 'TOTULT' Then
    cmbPreExi.ItemIndex := 2
  Else
  if strImpAju = 'IMPULT' Then
    cmbPreExi.ItemIndex := 3
  Else
  if strImpAju = 'TOTMED' Then
    cmbPreExi.ItemIndex := 4;

End;

function TfrmRelEstListaAjuste.fGetCampoTotal : String;
Begin
  if cmbPreExi.ItemIndex = 0 Then
    Result := 'DET_TOTITE'
  Else
  if cmbPreExi.ItemIndex = 1 Then
    Result := 'DET_TOTCUS'
  Else
  if cmbPreExi.ItemIndex = 2 Then
    Result := 'DET_TOTULT'
  Else
  if cmbPreExi.ItemIndex = 3 Then
    Result := 'DET_IMPULT'
  Else
  if cmbPreExi.ItemIndex = 4 Then
    Result := 'DET_TOTMED';

end;

procedure TfrmRelEstListaAjuste.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    strAjuste: String;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

  objGeraExcel.strNomRel := 'RELATÓRIO DE AJUSTE DE ESTOQUE';

  objGeraExcel.AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);
  objGeraExcel.AddFiltro(fStrTitulo(edtNumDoc.Text, nil, arrAjuste, strAjuste, 'NUMERO DO AJUSTE'));

  Case rdgOrdem.ItemIndex Of
    0: objGeraExcel.AddFiltro('ORDENADO POR CODIGO DO PRODUTO');
    1: objGeraExcel.AddFiltro('ORDENADO POR NUMERO DO AJUSTE');
    2: objGeraExcel.AddFiltro('ORDENADO POR DATA DE EMISSAO');
    3: objGeraExcel.AddFiltro('ORDENADO POR DESCRICAO DO PRODUTO');
  End;

  Case rdgOriAju.ItemIndex Of
    0: objGeraExcel.AddFiltro('ORIGEM DO AJUSTE: AJUSTE PELA MOVIMENTAÇÃO DE ITENS');
    1: objGeraExcel.AddFiltro('ORIGEM DO AJUSTE: AJUSTE POR BALANÇO DE ESTOQUE');
    2: objGeraExcel.AddFiltro('ORIGEM DO AJUSTE: TODOS');
  End;

  objGeraExcel.AddFiltro('EXIBIR PRECO DE VENDA: SIM');
  objGeraExcel.AddFiltro('TABELA DE VENDA PARA PRECO SUGERIDO: ' + cmbPreExi.Text);

  If Not fEmptyStr(edtFornecedor.Text) Then
    objGeraExcel.AddFiltro('FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text)
  Else
    objGeraExcel.AddFiltro('FORNECEDOR: TODOS');

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    objGeraExcel.AddFiltro('LINHA / GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text)
  Else
    objGeraExcel.AddFiltro('LINHA / GRUPO: TODOS');

  If Not fEmptyStr(edtUnidade.Text) Then
    objGeraExcel.AddFiltro('UNIDADE: ' + edtUnidade.Text)
  Else
    objGeraExcel.AddFiltro('UNIDADE: TODAS');

  If Not fEmptyStr(edtMarca.Text) Then
    objGeraExcel.AddFiltro('MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text)
  Else
    objGeraExcel.AddFiltro('MARCA: TODAS');

  If Not fEmptyStr(edtCodDig.Text) Then
    objGeraExcel.AddFiltro('DIGITADOR: ' + edtCodDig.Text + ' - ' + edtNomDig.Text)
  Else
    objGeraExcel.AddFiltro('DIGITADOR: TODOS');
    
  If Not fEmptyStr(edtDescri.Text) Then
    objGeraExcel.AddFiltro('DESCRICAO: ' + edtDescri.Text)
  Else
    objGeraExcel.AddFiltro('DESCRICAO: TODAS');

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    objGeraExcel.AddFiltro('REFERENCIA: ' + edtRefere.Text + ifthen(Not fEmptyStr(edtRefFin.Text), ' A ' + edtRefFin.Text, ''));
  End
  Else
    objGeraExcel.AddFiltro('REFERENCIA: TODAS');

  If Not fEmptyStr(edtProdutos.Text) Then
    objGeraExcel.AddFiltro('PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text)
  Else
    objGeraExcel.AddFiltro('PRODUTOS: TODOS');

  If Not fEmptyStr(edtLocFis.Text) Then
    objGeraExcel.AddFiltro('LOC. FISICA INICIADA POR: ' + edtLocFis.Text)
  Else
    objGeraExcel.AddFiltro('LOC. FISICA INICIADA POR: TODAS');

  objGeraExcel.AddFiltro('EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text);

  objGeraExcel.AddCampo('CODITE', 'CODIGO');
  objGeraExcel.AddCampo('CODACA', 'COD.PROD.ACABADO');
  objGeraExcel.AddCampo('DESITE', 'DESCRICAO');
  objGeraExcel.AddCampo('REFERE', 'REFERENCIA');
  objGeraExcel.AddCampo('UNIDAD', 'UN');
  objGeraExcel.AddCampo('NUMDOC', 'Nº AJUSTE');
  objGeraExcel.AddCampo('DTAENT', 'EMISSÃO');
  objGeraExcel.AddCampo('ENTSAI', 'ENT/SAI');
  objGeraExcel.AddCampo('CODDIG', 'DIG');
  objGeraExcel.AddCampo('CODVEN', 'VEN');  
  objGeraExcel.AddCampo('QTDITE', 'QUANT.');
  objGeraExcel.AddCampo('QTD_ML', 'QUANT. ML/GR');

  objGeraExcel.AddCampo('VALAJU', 'PREÇO');


  if rdgOrdem.ItemIndex = 4 Then
  Begin
    //Linha Grupo
    objGeraExcel.AddQuebra('LINHA', 'LINHA: ');
    objGeraExcel.AddQuebra('GRUPO', 'GRUPO: ');

  End
  Else
  if rdgOrdem.ItemIndex = 5 Then
  Begin
    //Fornecedor
    objGeraExcel.AddQuebra('NOMFOR', 'FORNECEDOR: ');

  End
  Else
  if rdgOrdem.ItemIndex = 6 Then
  Begin
    //Empresa;
    objGeraExcel.AddQuebra('NOMEMP', 'EMPRESA: ');
  End;




  objGeraExcel.AddTotais('QTDENT');
  objGeraExcel.AddTotais('VALENT');
  objGeraExcel.AddTotais('QTDSAI');
  objGeraExcel.AddTotais('VALSAI');

  objGeraExcel.OnMontaResumo := pMontaResumo;
  objGeraExcel.OnSomaResumo  := pSomaTotais;

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!',['&OK']);

  FreeAndNil(objGeraExcel);
end;

procedure TfrmRelEstListaAjuste.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['ENTSAI'].Coluna, fPadL('TOTAL DE SAÍDAS:', 18));
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDITE'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['QTDSAI']), 14));
    Escrever(LinhaAtual, Campos.ColunaPorNome['VALAJU'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VALSAI']), 14));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['ENTSAI'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['ENTSAI'].Coluna, fPadL('TOTAL DE ENTRADAS:', 18));
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDITE'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['QTDENT']), 14));

    Escrever(LinhaAtual, Campos.ColunaPorNome['VALAJU'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VALENT']), 14));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['ENTSAI'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['ENTSAI'].Coluna, fPadL('SALDO:', 18));
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDITE'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['QTDENT']-Quebra.Totais['QTDSAI']), 14));

    Escrever(LinhaAtual, Campos.ColunaPorNome['VALAJU'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VALENT']-Quebra.Totais['VALSAI']), 14));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['ENTSAI'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
  End;
end;

procedure TfrmRelEstListaAjuste.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  If (Dados.FieldByName('ENTSAI').AsString = 'ENT') Then
  Begin
    Totais['QTDENT'] := Totais['QTDENT'] + Dados.FieldByName('QTDITE').AsCurrency;
    Totais['VALENT'] := Totais['VALENT'] + Dados.FieldByName('VALAJU').AsCurrency;
  End
  Else If (Dados.FieldByName('ENTSAI').AsString = 'SAI') Then
  Begin
    Totais['QTDSAI'] := Totais['QTDSAI'] + Dados.FieldByName('QTDITE').AsCurrency;
    Totais['VALSAI'] := Totais['VALSAI'] + Dados.FieldByName('VALAJU').AsCurrency;
  End;
end;

procedure TfrmRelEstListaAjuste.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  blnCadLoc      := fCfgSis('CADLOC', varBoolean);
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  pSetFocus(mskDtaIni);

  strImpAju := fCfgSis('IMPAJU', varString);
  pSetaExibir;

  inherited;

end;

procedure TfrmRelEstListaAjuste.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqAjuste(Self, edtNumDoc, nil, Key, arrSel, edtCodEmpresa.Text) Then
  Begin
    If fvalidaCampos(edtNumDoc,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstListaAjuste.FormCreate(Sender: TObject);
begin
  inherited;

  SetLength(arrAjuste,0);

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmRelEstListaAjuste.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstListaAjuste.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstListaAjuste.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  SetLength(arrAjuste,0);
end;

procedure TfrmRelEstListaAjuste.edtNumDocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtNumDoc,nil,arrAjuste,nil,Nil,'do Ajuste');
end;

procedure TfrmRelEstListaAjuste.rdgOrdemClick(Sender: TObject);
begin
  inherited;

  chkImpObs.Enabled := rdgOrdem.ItemIndex <> 0;

  If Not chkImpObs.Enabled Then
    chkImpObs.Checked := False;
end;

end.
