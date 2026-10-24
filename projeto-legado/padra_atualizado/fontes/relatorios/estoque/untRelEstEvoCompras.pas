unit untRelEstEvoCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, untfuncoesSimples,
  DateUtils, StrUtils, RLReport, RLTypes, Comobj, DB, untConsultas, untFuncoesConsulta,
  Uni, ComCtrls, frxDesgn, untTypesSistema,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts,untClassPanelCx,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untConstantes, untIFuncoes;

type
  TfrmRelEstEvoCompras = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskMesBas: TMaskEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label11: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    Label8: TLabel;
    edtCodUnidade: TEditFocus;
    edtDesUnidade: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    edtOpcao: TEditFocus;
    gpbOpcao2: TGroupBox;
    lblOpcao2: TColorLabel;
    edtOpcao2: TEditFocus;
    rdgData: TRadioGroup;
    Label3: TLabel;
    ColorLabel2: TColorLabel;
    edtQtdMes: TEditFocus;
    chkTransf: TCheckBox;
    lstClaFis: TMemo;
    Label5: TLabel;
    svdExcel: TSaveDialog;
    ColorLabel6: TColorLabel;
    pgbStatus: TProgressBar;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lbl1: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label12: TLabel;
    ColorLabel9: TColorLabel;
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUnidadeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryRelatorio: TUniQuery;

    function fRetornaForFil: String;

    procedure pAtualizaClaFis;
    procedure pGeraExcelEvoCompras(intOpcao: Integer);
    procedure pCriaQryRelatorio;

  public
    { Public declarations }

    arrLinhaGrupo: TConsultasArray;
    arrLinhaForne: TConsultasArray;
    arrProduto   : TConsultasArray;
    arrUnidade   : TConsultasArray;
    arrEmpresa   : TConsultasArray;
    arrMarca     : TConsultasArray;
    arrGruCmp    : TConsultasArray;

    strLinGru: String;
    strLinFor: String;
    strLinPro: String;
    strLinUni: String;
    strLinEmp: String;
    strLinMar: String;
    strGruCmp: String;

    class function fRetClaCom: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelEstEvoCompras: TfrmRelEstEvoCompras;

implementation

uses untQckEstEvoCompras, untPai;

Var
  arrDatas   : Array [0..11] Of String[7];


{$R *.dfm}

function TfrmRelEstEvoCompras.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  {*******************}
  {* VALIDA MÊS BASE *}
  {****************RL*}
  If (Sender = mskMesBas) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text)) Then
    Begin
      fMensagem('','O mês base deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If Not IsValidDate(StrToInt(Trim(RightStr(mskMesBas.Text,4))), StrToInt(LeftStr(Trim(mskMesBas.Text),2)), 01) Then
      Begin
        fMensagem('','O mês base digitado não é valido!',['&OK']);
        Result := False;
      End

    End;

  End

  {******************************}
  {* VALIDA FORNECEDOR          *}
  {***************************RL*}
  Else If (Sender = edtFornecedor) Then
  Begin
    pDesmarcaLista(edtFornecedor,arrLinhaForne);
  End

  {**********************}
  {* VALIDA LINHA GRUPO *}
  {*******************RL*}
  Else  If (Sender = mskLinhaGrupo) Then
  Begin
    pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
  End

  {******************************}
  {* VALIDA PRODUTO              *}
  {***************************RL*}
  Else If (Sender = edtCodProduto) Then
  Begin
    pDesmarcaLista(edtCodProduto,arrProduto);
  End

  {******************************}
  {* VALIDA MARCA                *}
  {***************************IV*}
  Else If (Sender = edtMarca) Then
  Begin
    pDesmarcaLista(edtMarca, arrMarca);
  End

  {******************************}
  {* VALIDA UNIDADE             *}
  {***************************RL*}
  Else If (Sender = edtCodUnidade) Then
  Begin
    pDesmarcaLista(edtCodUnidade,arrUnidade,'',edtCodUnidade.MaxLength);
  End

  {*****************}
  {* VALIDA QTDMES *}
  {**************RL*}
  Else If (Sender = edtQtdMes) Then
  Begin

    If fEmptyStr(edtQtdMes.Text) Then
    Begin
      fMensagem('','A quantidade de meses deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If (StrToInt(edtQtdMes.Text) > 12) Or (StrToInt(edtQtdMes.Text) < 1) Then
      Begin
        fMensagem('','A quantidade de meses deve ser de 1 a 12!',['&OK']);
        Result := False;
      End;

    End;

  End

  {****************}
  {* VALIDA OPÇÃO *}
  {*************RL*}
  Else If (Sender = edtOpcao) Then
  Begin

    If fEmptyStr(edtOpcao.Text) Then
    Begin
      fMensagem('','A Opção de quebra deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If Pos(edtOpcao.Text,'1_2_3_4_5_6_7') <= 0 Then
      Begin
        fMensagem('','A Opção de quebra deve ser 1, 2, 3, 4, 5, 6 ou 7!',['&OK']);
        Result := False;
      End;

    End;

  End

  {*****************}
  {* VALIDA OPÇÃO2 *}
  {**************RL*}
  Else If (Sender = edtOpcao2) Then
  Begin

    If fEmptyStr(edtOpcao2.Text) Then
    Begin
      fMensagem('','A Opção deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If fCfgSis('USATMQ', varBoolean) Then
      Begin

        If SameText(fCfgSis('LITGAL'), 'L') Then
        Begin
          If Pos(edtOpcao2.Text,'L_Q_V_') <= 0 Then
          Begin
            fMensagem('','A Opção deve ser L, Q ou V!',['&OK']);
            Result := False;
          End;
        End Else
        Begin
          If Pos(edtOpcao2.Text,'G_Q_V_') <= 0 Then
          Begin
            fMensagem('','A Opção deve ser G, Q ou V!',['&OK']);
            Result := False;
          End;
        End;

      End
      Else
      Begin

        If Pos(edtOpcao2.Text,'Q_V_') <= 0 Then
        Begin
          fMensagem('','A Opção deve ser Q ou V!',['&OK']);
          Result := False;
        End;

      End;

    End;

  End
  Else If (Sender = edtDestino) Then
  Begin

    If fEmptyStr(edtDestino.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (edtDestino.Text <> 'V') And
            (edtDestino.Text <> 'I') And
            (edtDestino.Text <> 'E') Then
    Begin
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEstEvoCompras.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinhaForne, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');

end;

procedure TfrmRelEstEvoCompras.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstEvoCompras.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor, arrLinhaForne,fRetNomFornecedor,Nil,'do Fornecedor');

end;

procedure TfrmRelEstEvoCompras.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstEvoCompras.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtCodProduto,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.edtCodProdutoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProduto,edtDesProduto,arrProduto,Nil,fRetNomProduto,'do Produto');

end;

procedure TfrmRelEstEvoCompras.edtCodUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUnidade, edtDesUnidade, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.edtCodUnidadeExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUnidade,edtDesUnidade,arrUnidade,fRetNomUnidade,Nil,'da Unidade',edtCodUnidade.MaxLength);

end;

procedure TfrmRelEstEvoCompras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    If (ActiveControl.Parent = rdgData) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelEstEvoCompras.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strSqlTmp: String;
    strData  : String;
    rllLabel : TRLLabel;
    rdbLabel : TRLDBText;
    rdbResult: TRLDBResult;
    intContador: Integer;
    intInicio  : Integer;
    strDtaRel : String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  strDtaRel := ifthen(rdgData.ItemIndex = 0, 'DET_DTAENT', 'DET_DTADOC');


  inherited;

  If blnImprime Then
  Begin

    {**************************}
    {* MONTA MATRIZ DAS DATAS *}
    {***********************RL*}
    strData := mskMesBas.Text;

    For intContador := Low(arrDatas) To High(arrDatas) Do
      arrDatas[intContador] := '';

    intInicio := (StrToInt(edtQtdMes.Text) - 1);
    For intContador := intInicio DownTo 0 Do
    Begin
      arrDatas[intContador] := ShortString(FormatDateTime('mm/yyyy',StrToDate('01/' + strData)));
      strData               := FormatDateTime('mm/yyyy',IncMonth( StrToDate('01/' + strData), -1 ));
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DET_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '  DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  ITE_GRUCMP, ';
    strSQL := strSQL + '  GRU_DESCRI, ';
    strSQL := strSQL + '  DET_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';

    {**************************************}
    {* MONTA TODAS AS COLUNAS             *}
    {***********************************RL*}
    For intContador := 0 To 11 Do
    Begin

      {**************************************}
      {* LITRAGEM                           *}
      {***********************************RL*}
      If (edtOpcao2.Text = 'L') Or (edtOpcao2.Text = 'G') Then
      Begin
        If fEmptyStr(String(arrDatas[intContador])) Then
          strSQL := strSQL + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
        Else
        Begin
          strSQL := strSQL + '  SUM(IF(DATE_FORMAT(' + strDtaRel + ',"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', DET_QTDITE * UNI_PESLIT / :LITGAL, 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';

        End;
      End

      {**************************************}
      {* UNITARIO                           *}
      {***********************************RL*}
      Else If edtOpcao2.Text = 'Q' Then
      Begin
        If fEmptyStr(String(arrDatas[intContador])) Then
          strSQL := strSQL + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
        Else
          strSQL := strSQL + '  SUM(IF(DATE_FORMAT(' + strDtaRel + ',"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', DET_QTDITE, 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
      End

      {**************************************}
      {* VALOR                              *}
      {***********************************RL*}
      Else If edtOpcao2.Text = 'V' Then
      Begin
        If fEmptyStr(String(arrDatas[intContador])) Then
          strSQL := strSQL + '  0.00 AS DATA0' + IntToStr(intContador + 1) + ', '
        Else
          strSQL := strSQL + '  SUM(IF(DATE_FORMAT(' + strDtaRel + ',"%m/%Y") = ' + QuotedStr(String(arrDatas[intContador])) + ', DET_VALRET + DET_VAERET + DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) + DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE, 0)) AS DATA0' + IntToStr(intContador + 1) + ', ';
       End;

    End;

    strSQL := strSQL + '  (SELECT SQL_NO_CACHE GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = ITE_CODGRU) AS NOMGRU, ';

    If (edtOpcao.Text = '6') Then
      strSQL := strSQL + '  (SELECT SQL_NO_CACHE GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU,3),"000")) AS NOMLIN, ';

    strSQL := strSQL + '  ITE_DESITE AS DESITE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  JOIN CADFOR      ON DET_CODFOR        = FOR_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON DET_UNIDAD        = UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN CADMAR ON DET_CODMAR        = MAR_CODMAR ';
    strSQL := strSQL + '  JOIN CADITE      ON ITE_CODITE        = DET_CODITE ';
    strSQL := strSQL + '  LEFT JOIN GRU_COMPRA ON GRU_CODIGO    = ITE_GRUCMP ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CLAFIS IN (' + fRetClaCom + ') AND ';
    strSQL := strSQL + '  DET_TIP_FC = "F" AND ';

    {********************************************}
    {* INCLUIR OU NÃO TRANSFERÊNCIA ENTRE LOJAS *}
    {*****************************************RL*}
    If Not chkTransf.Checked Then
      strSQL := strSQL + '  DET_CODFOR NOT IN (' + fRetornaForFil + ') AND ';

    {*******************************************}
    {* FILTRA DATA DE ENT. OU DATA DO DOC.     *}
    {****************************************RL*}
    strSQL := strSQL + strDtaRel + '  BETWEEN :MESINI AND :MESFIN ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'ITE_CODGRU', 'CODGRU');

    If Not fEmptyStr(edtGruCmp.Text) Then
      strSQL := strSQL + fStrLocate(edtGruCmp, arrGruCmp, 'ITE_GRUCMP', 'GRUCMP');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      If Length(arrEmpresa) > 1 Then
      Begin
        strSQL := strSQL + '  AND LOCATE(DET_CODEMP,:CODEMP) > 0 ';
      End
      Else
      Begin
        strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    strSql := strSQL + fStrLocate(edtMarca,arrMarca,'DET_CODMAR','CODMAR');
    strSql := strSQL + fStrLocate(edtFornecedor,arrLinhaForne,'DET_CODFOR','CODFOR');
    strSql := strSQL + fStrLocate(edtCodProduto,arrProduto,'DET_CODITE','CODITE');
    strSql := strSQL + fStrLocate(edtCodUnidade,arrUnidade,'DET_UNIDAD','CODUNI');

    strSQL := strSQL + 'GROUP BY ';

    If (edtOpcao.Text = '1') Then
      strSQL := strSQL + '  DET_CODFOR, DET_CODITE '
    Else If (edtOpcao.Text = '2') Then
      strSQL := strSQL + '  DET_CODITE '
    Else If (edtOpcao.Text = '3') Then
      strSQL := strSQL + '  DET_CODITE '
    Else If (edtOpcao.Text = '4') Then
      strSQL := strSQL + '  DET_CODFOR '
    Else If (edtOpcao.Text = '5') Then
      strSQL := strSQL + '  DET_CODITE '
    Else If (edtOpcao.Text = '7') Then
      strSQL := strSQL + '  ITE_GRUCMP, DET_CODITE '

    Else

      strSQL := strSQL + '  DET_CODITE ';

    strSqlTmp := strSQL;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CODFOR,           ';
    strSQL := strSQL + '  NOMFOR,           ';
    strSQL := strSQL + '  CODITE,           ';
    strSQL := strSQL + '  CODGRU,           ';
    strSQL := strSQL + '  DESITE,           ';
    strSQL := strSQL + '  NOMGRU,           ';
    strSQL := strSQL + '  ITE_GRUCMP,       ';
    strSQL := strSQL + '  GRU_DESCRI,       ';

    If (edtOpcao.Text = '6') Then
      strSQL := strSQL + '  NOMLIN,         ';
    strSQL := strSQL + '  CODMAR,           ';
    strSQL := strSQL + '  DESMAR,           ';

    {strSQL := strSQL + '  C_G_C_, ';
    strSQL := strSQL + '  FONE01, ';
    strSQL := strSQL + '  ENDERE, ';
    strSQL := strSQL + '  NOMCID, ';}

    {**************************************}
    {* DEFINE A QUEBRA DO RELATORIO       *}
    {***********************************RL*}
    Case StrToInt(edtOpcao.Text) Of
      1: strSQL := strSQL + ' CONCAT("FORNECEDOR: ",IFNULL(CODFOR,""),"-",IFNULL(NOMFOR,"")) AS QUEBRA, ';
      2: strSQL := strSQL + ' CONCAT("GRUPO: ",IFNULL(CODGRU,""),"-",IFNULL(NOMGRU,"")) AS QUEBRA, ';
      3: strSQL := strSQL + ' DESITE AS QUEBRA, ';
      4: strSQL := strSQL + ' NOMFOR AS QUEBRA, ';
      5: strSQL := strSQL + ' CONCAT("MARCA: ",IFNULL(CODMAR,""),"-",IFNULL(DESMAR,"")) AS QUEBRA, ';
      7: strSQL := strSQL + ' CONCAT("GRUPO DE COMPRA: ", IFNULL(ITE_GRUCMP, "NAO DEFINIDO"), " - ", IFNULL(GRU_DESCRI, "")) AS QUEBRA, ';
      6: Begin
           strSQL := strSQL + ' CONCAT(LEFT(CODGRU,3),".", "000") AS LINHA, ';
           strSQL := strSQL + ' CONCAT(LEFT(CODGRU,3),".", RIGHT(CODGRU,3)) AS GRUPO, ';

         End;

    End;

    {**************************************}
    {* MONTA AS COLUNAS SOMADAS           *}
    {***********************************RL*}
    For intContador := 1 To 12  Do
      strSQL := strSQL + '  SUM(DATA0' + IntToStr(intContador) + ') AS DATA0' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '  ( ';

    {**************************************}
    {* MONTA A COLUNA DE SOMA             *}
    {***********************************RL*}
    For intContador := 1 To 12 Do
      strSQL := strSQL + '   SUM(DATA0' + IntToStr(intContador) + ') + ';

    strSQL := LeftStr(strSQL, Length(strSQL)-2);
    strSQL := strSQL + '   ) AS TOTDTA ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  (' + strSqlTmp + ') T ';

    strSQL := strSQL + 'GROUP BY ';

    If (edtOpcao.Text = '1') Then
      strSQL := strSQL + ' CODFOR, CODITE '
    Else If (edtOpcao.Text = '2') Then
      strSQL := strSQL + ' CODGRU, CODITE '
    Else If (edtOpcao.Text = '3') Then
      strSQL := strSQL + ' CODITE '
    Else If (edtOpcao.Text = '4') Then
      strSQL := strSQL + ' CODFOR '
    Else If (edtOpcao.Text = '5') Then
      strSQL := strSQL + ' CODITE '
    Else If (edtOpcao.Text = '7') Then
      strSQL := strSQL + ' ITE_GRUCMP, CODITE '
    Else
      strSQL := strSQL + ' CODITE ';

    strSQL := strSQL + 'HAVING ';
    strSQL := strSQL + '  ( ';

    {**************************************}
    {* MONTA A COLUNA DE SOMA             *}
    {***********************************RL*}
    For intContador := 1 To 12 Do
      strSQL := strSQL + '   SUM(DATA0' + IntToStr(intContador) + ') + ';

    strSQL := LeftStr(strSQL, Length(strSQL)-2);
    strSQL := strSQL + '   ) <> 0.00 ';

    strSQL := strSQL + 'ORDER BY ';
    If (edtOpcao.Text = '1') Then
      strSQL := strSQL + '  QUEBRA, CODITE '
    Else If (edtOpcao.Text = '2') Then
      strSQL := strSQL + '  QUEBRA, CODITE '
    Else If (edtOpcao.Text = '3') Then
      strSQL := strSQL + '  CODITE '
    Else If (edtOpcao.Text = '4') Then
      strSQL := strSQL + '  CODFOR '
    Else  If (edtOpcao.Text = '5') Then
      strSQL := strSQL + '  CODMAR '
    Else  If (edtOpcao.Text = '7') Then
      strSQL := strSQL + '  ITE_GRUCMP, DESITE '
    Else
      strSQL := strSQL + '  LINHA, GRUPO, DESITE ';


    With qryRelatorio, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);

      //ParamByName('MESINI').AsDate   := StrToDate('01/' + arrDatas[11 - (StrToInt(edtQtdMes.Text)-1)]);
      ParamByName('MESINI').AsDate   := StrToDate('01/' + String(arrDatas[0]));
      //ParamByName('MESFIN').AsDate   := StrToDate( IntToStr( DaysInAMonth(StrToInt(RightStr(arrDatas[11],4)), StrToInt(LeftStr(arrDatas[11],2))) ) + '/' + arrDatas[11]);
      ParamByName('MESFIN').AsDate   := StrToDate( IntToStr( DaysInAMonth(StrToInt(RightStr(String(arrDatas[StrToInt(edtQtdMes.Text)-1]),4)), StrToInt(LeftStr(String(arrDatas[StrToInt(edtQtdMes.Text)-1]),2))) ) + '/' + String(arrDatas[StrToInt(edtQtdMes.Text)-1]));
//      ParamByName('CLACOM').AsString := VS_strClaCom;

      pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU',qryRelatorio);
      pSetaParam(edtFornecedor.Text,arrLinhaForne,strLinFor,'CODFOR',qryRelatorio);
      pSetaParam(edtCodProduto.Text,arrProduto,strLinPro,'CODITE',qryRelatorio);
      pSetaParam(edtCodUnidade.Text,arrUnidade,strLinUni,'CODUNI',qryRelatorio);
      pSetaParam(edtCodEmpresa.Text,arrEmpresa,strLinEmp,'CODEMP',qryRelatorio);
      pSetaParam(edtMarca.Text,arrMarca,strLinMar,'CODMAR',qryRelatorio);
      pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'GRUCMP', qryRelatorio);
      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;

      Open;

      If Not IsEmpty Then
      Begin

        If (edtDestino.Text = 'E') Then
          pGeraExcelEvoCompras(StrToInt(edtOpcao.Text))

        Else
        Begin

          Try
            pCriarFormularios(TfrmQckEstEvoCompras,frmQckEstEvoCompras);

            frmQckEstEvoCompras.dtsRelatorio.DataSet := qryRelatorio;

            If StrToInt(edtQtdMes.Text) > 7 Then
            Begin
              fMensagem('ATENÇÃO!', 'O Relatório será impresso em 132 colunas.', ['&Ok']);
              frmQckEstEvoCompras.qckPagina.PageSetup.Orientation := poLandscape;
            End
            Else
            Begin
              frmQckEstEvoCompras.qckPagina.PageSetup.Orientation := poPortrait;

              frmQckEstEvoCompras.rllTotDta.Left    := frmQckEstEvoCompras.rllMes8.Left;
              frmQckEstEvoCompras.rdbTotDta.Left    := frmQckEstEvoCompras.rdbDta008.Left;
              frmQckEstEvoCompras.rdbTotDtaTot.Left := frmQckEstEvoCompras.rdbTotDta8.Left;
              frmQckEstEvoCompras.rdbTotDta_2.Left  := frmQckEstEvoCompras.rdbDta008_2.Left;
              frmQckEstEvoCompras.rdbTotDtaGer.Left := frmQckEstEvoCompras.rdbGerDta8.Left;

              frmQckEstEvoCompras.rdbTotDtaGru.Left    := frmQckEstEvoCompras.rdg_Mes008.Left;
              frmQckEstEvoCompras.rdbTotDtaGruTot.Left := frmQckEstEvoCompras.rdg_TotG008.Left;
              frmQckEstEvoCompras.rdbTotDtaLinTot.Left := frmQckEstEvoCompras.rdg_TotL008.Left;

            End;

            If strTipImp = 'M' Then
              frmQckEstEvoCompras.qckPagina.DefaultFilter := rldFiltro
            Else
              frmQckEstEvoCompras.qckPagina.DefaultFilter := Nil;

            {**************************}
            {* CABECALHO DO RELATORIO *}
            {***********************RL*}
            frmQckEstEvoCompras.strFornecedor := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR');
            frmQckEstEvoCompras.strNomProduto := fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO');
            frmQckEstEvoCompras.strNomUnidade := fStrTitulo(edtCodUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE');
            frmQckEstEvoCompras.strLinhaGrupo := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO');
            frmQckEstEvoCompras.strLinhaEmpr  := fStrTitulo(edtCodEmpresa.Text,edtDesEmpresa,arrEmpresa,strLinEmp,'EMPRESA');
            frmQckEstEvoCompras.strLinhaMarca := fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strLinMar,'MARCA');
            frmQckEstEvoCompras.strGruCmp     := fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA');

            frmQckEstEvoCompras.strOrdem      := 'MES BASE: ' + mskMesBas.Text;

            Case StrToInt(edtOpcao.Text) Of
              1: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR FORN. / PRODUTO ' ;
              2: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR GRUPO '           ;
              3: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR PRODUTO '         ;
              4: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR FORNECEDOR '      ;
              5: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR MARCA'            ;
              6: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR LINHA/GRUPO'      ;
              7: frmQckEstEvoCompras.strNomRelatorio := 'RELATORIO DE EVOLUCAO DE COMPRAS POR GRUPO DE COMPRA ';
            End;

            frmQckEstEvoCompras.rdbCodIte.Visible := True;

            {**************************************}
            {* RENOMEIA AS COLUNAS                *}
            {***********************************RL*}
//            For intContador := 11 DownTo 11 - (StrToInt(edtQtdMes.Text) - 1) Do
            intInicio := (StrToInt(edtQtdMes.Text) - 1);
            For intContador := intInicio DownTo 0 Do
            Begin
              rllLabel := (fComponentByName(frmQckEstEvoCompras.rlbTitulo,'rllMes' + IntToStr(intContador + 1)) As TRLLabel);
              rllLabel.Caption := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + RightStr(String(arrDatas[intContador]),5);
            End;

            {*********************************}
            {* SETA COLUNAS QUE SERÃO USADAS *}
            {******************************RL*}
//            For intContador := 12 DownTo ((12 - StrToInt(edtQtdMes.Text)) + 1) Do
            intInicio := StrToInt(edtQtdMes.Text);
            For intContador := intInicio DownTo 1 Do
            Begin
              rllLabel := (fComponentByName(frmQckEstEvoCompras.rlbTitulo,'rllMes' + IntToStr(intContador)) As TRLLabel);
              rllLabel.Visible := True;

              If StrToInt(edtOpcao.Text) in [1,2,5,7] Then
              Begin
                rdbLabel := (fComponentByName(frmQckEstEvoCompras.rlbDetalheGrupo,'rdbDta00' + IntToStr(intContador)) As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbResumoGrupo,'rdbTotDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbTotalGeral,'rdbGerDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
              End
              Else
              If edtOpcao.Text = '6' Then
              Begin
                rdbLabel := (fComponentByName(frmQckEstEvoCompras.rlbDetGrupo,'rdg_Mes' + fPadL(IntToStr(intContador), 3, '0') ) As TRLDBText);
                rdbLabel.Visible := True;

                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbResumoGrupo2,'rdg_TotG' + fPadL(IntToStr(intContador), 3, '0')) As TRLDBResult);
                rdbResult.Visible := True;

                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbResumoLinha,'rdg_TotL' + fPadL(IntToStr(intContador), 3, '0')) As TRLDBResult);
                rdbResult.Visible := True;

                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbTotalGeral,'rdbGerDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;

              End
              Else
              Begin

                rdbLabel := (fComponentByName(frmQckEstEvoCompras.rlbDetalhe,'rdbDta00' + IntToStr(intContador) + '_2') As TRLDBText);
                rdbLabel.Visible := True;
                rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbTotalGeral,'rdbGerDta' + IntToStr(intContador)) As TRLDBResult);
                rdbResult.Visible := True;
              End;
            End;

            rllLabel := (fComponentByName(frmQckEstEvoCompras.rlbTitulo,'rllTotDta') As TRLLabel);
            rllLabel.Visible := True;

            If StrToInt(edtOpcao.Text) in [1, 2, 5, 7] Then
            Begin
              rdbLabel := (fComponentByName(frmQckEstEvoCompras.rlbDetalheGrupo,'rdbTotDta') As TRLDBText);
              rdbLabel.Visible := True;
            End
            Else
            Begin
              rdbLabel := (fComponentByName(frmQckEstEvoCompras.rlbDetalhe,'rdbTotDta_2') As TRLDBText);
              rdbLabel.Visible := True;
            End;

            frmQckEstEvoCompras.intOpcao := 0;

            If StrToInt(edtOpcao.Text) in [1, 2, 5, 7] Then
            Begin
              rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbResumoGrupo,'rdbTotDtaTot') As TRLDBResult);
              rdbResult.Visible := True;
            End;

            rdbResult := (fComponentByName(frmQckEstEvoCompras.rlbTotalGeral,'rdbTotDtaGer') As TRLDBResult);
            rdbResult.Visible := True;

            frmQckEstEvoCompras.qckPagina.PageSetup.PaperSize := fpLetter;

            If edtOpcao.Text = '3' Then
            Begin
              frmQckEstEvoCompras.rlbGrupo.Visible   := False;
              frmQckEstEvoCompras.rlbDetalhe.Visible := True;
            End
            Else If edtOpcao.Text = '4' Then
            Begin
              frmQckEstEvoCompras.intOpcao             := 4;
              frmQckEstEvoCompras.rllProduto.Caption   := 'FORNECEDOR';
              frmQckEstEvoCompras.rdbCodIte2.DataField := 'CODFOR';
              frmQckEstEvoCompras.rlbGrupo.Visible     := False;
              frmQckEstEvoCompras.rlbDetalhe.Visible   := True;
            End
            Else If (edtOpcao.Text = '6') Then
            Begin
              frmQckEstEvoCompras.rlbGrupo.Visible   := False;
              frmQckEstEvoCompras.rlbGrupo.Visible   := False;
              frmQckEstEvoCompras.rlgLinha.Visible   := True;
            End;

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frmQckEstEvoCompras.qckPagina, frmQckEstEvoCompras.rpsSetup)
            Else
              pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstEvoCompras.qckPagina);

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;

          pFreeAndNil(frmQckEstEvoCompras);

        End;

      End
      Else
        pTabelaVazia;

    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskMesBas);

end;

procedure TfrmRelEstEvoCompras.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskMesBas);
end;

procedure TfrmRelEstEvoCompras.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodProduto);
  pAtualizaClaFis;
  pSetaCodIte(edtCodProduto);

end;

procedure TfrmRelEstEvoCompras.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

{**************************************}
{* ATUALIZA LIST DE CLASSIFICAÇÕES    *}
{***********************************AF*}
procedure TfrmRelEstEvoCompras.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin

  //strClaFis := VS_strClaVen + VS_strClaDev;
  strClaFis := VS_strClaCom;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelEstEvoCompras.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

{*******************************************}
{* GERAR RELATÓRIO EM PLANILHA EXCEL       *}
{****************************************RL*}
procedure TfrmRelEstEvoCompras.pGeraExcelEvoCompras(intOpcao: Integer);
  Var
    Excel       : Variant;
    intCol      : Integer;
    intColAux   : Integer;
    intRow      : Integer;
    strLetra    : String;
    strGrupo    : String;
    intQtdMes   : Integer;
    i           : Integer;
    strMes      : String;
    arrTotalParc: Array Of Double;
    arrTotal    : Array Of Double;
    intContador : Integer;
    intInicio   : Integer;

    strLinha    : String;
    arrTotalLin : Array Of Double;
begin

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************RL*}
  Excel         := CreateOleObject('Excel.Application');
  Excel.Visible := False;

  Try
    Try

      intQtdMes := StrToInt(edtQtdMes.Text);
      strLetra  := Chr(Ord('B') + intQtdMes);

      {*******************************************}
      {* ADICIONA UMA PASTA DE TRABALHO          *}
      {****************************************RL*}
      Excel.Workbooks.Add;

      {********************************}
      {* EMPRESA PADRAO DO SISTEMA    *}
      {*****************************RL*}
      Excel.WorkBooks[1].Sheets[1].Cells[01,01] := fRetNomeEmpresaSelec(VS_strCodEmp);

      {*******************************************}
      {* TITULO DO RELATORIO                     *}
      {****************************************RL*}
      Case intOpcao Of
        1: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR FORN. / PRODUTO ';
        2: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR GRUPO '          ;
        3: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR PRODUTO '        ;
        4: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR FORNECEDOR '     ;
        5: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR MARCA '          ;
        6: Excel.WorkBooks[1].Sheets[1].Cells[02, 01] := 'RELATORIO DE EVOLUCAO DE COMPRAS POR LINHA/GRUPO'     ;
      End;

      {*******************************************}
      {* OUTROS DADOS DO RELATÓRIO               *}
      {****************************************RL*}
      If fEmptyStr(edtFornecedor.Text) Then
        Excel.WorkBooks[1].Sheets[1].Cells[04, 01] := 'FORNECEDOR: TODOS'
      Else
        Excel.WorkBooks[1].Sheets[1].Cells[04, 01] := 'FORNECEDOR: '  + edtFornecedor.Text + '-' + edtDesFornecedor.Text;

      If fEmptyStr(mskLinhaGrupo.Text) Then
        Excel.WorkBooks[1].Sheets[1].Cells[05, 01] := 'LINHA/GRUPO: TODOS'
      Else
        Excel.WorkBooks[1].Sheets[1].Cells[05, 01] := 'LINHA/GRUPO: ' + mskLinhaGrupo.Text + '-' + edtDesGrupo.Text;

      If fEmptyStr(edtCodProduto.Text) Then
        Excel.WorkBooks[1].Sheets[1].Cells[06, 01] := 'PRODUTO: TODOS'
      Else
        Excel.WorkBooks[1].Sheets[1].Cells[06, 01] := edtCodProduto.Text + ' - ' + edtDesProduto.Text;

      If fEmptyStr(edtCodUnidade.Text) Then
        Excel.WorkBooks[1].Sheets[1].Cells[07, 01] := 'UNIDADE: TODOS'
      Else
        Excel.WorkBooks[1].Sheets[1].Cells[07, 01] := edtCodUnidade.Text + ' - ' + edtDesUnidade.Text;

      If fEmptyStr(edtMarca.Text) Then
        Excel.WorkBooks[1].Sheets[1].Cells[08, 01] := 'MARCA: TODOS'
      Else
        Excel.WorkBooks[1].Sheets[1].Cells[08, 01] := edtMarca.Text + ' - ' + edtDesMarca.Text;

      Excel.WorkBooks[1].Sheets[1].Cells[09, 01] := fStrTitulo(edtGruCmp.Text,edtDesGruCmp, arrGruCmp, strGruCmp,'GRUPO DE COMPRA');

      Excel.WorkBooks[1].Sheets[1].Cells[10, 01] := 'MES BASE: ' + mskMesBas.Text;

      {********************************}
      {* MESCLA AS COLUNAS            *}
      {*****************************RL*}
      Excel.Range['A1',strLetra + '1'].Merge;
      Excel.Range['A2',strLetra + '2'].Merge;
      Excel.Range['A3',strLetra + '3'].Merge;
      Excel.Range['A4',strLetra + '4'].Merge;
      Excel.Range['A5',strLetra + '5'].Merge;
      Excel.Range['A6',strLetra + '6'].Merge;
      Excel.Range['A7',strLetra + '7'].Merge;
      Excel.Range['A8',strLetra + '8'].Merge;
      Excel.Range['A9',strLetra + '9'].Merge;
      Excel.Range['A10',strLetra + '10'].Merge;

      {********************************}
      {* COLOCA EM NEGRITO E ALINHA   *}
      {* AO CENTRO DA CELULA          *}
      {*****************************RL*}
      Excel.Range['A1',strLetra + '2'].HorizontalAlignment  := 3;
      Excel.Range['A1',strLetra + '2'].Font.Bold            := True;
      Excel.Range['A4',strLetra + '10'].HorizontalAlignment := 3;
      Excel.Range['A4',strLetra + '10'].Font.Bold           := True;

      {*************************************}
      {* COLORE O FUNDO DA CELULA P/ CINZA *}
      {**********************************RL*}
      Excel.Range['A1',strLetra + '1'].Interior.ColorIndex := 15;
      Excel.Range['A2',strLetra + '2'].Interior.ColorIndex := 15;

      {********************************}
      {* INSERE BORDAS NA CELULA      *}
      {*****************************RL*}
      Excel.Range['A1',strLetra + '1'].Borders.LineStyle     := 1;
      Excel.Range['A2',strLetra + '2'].Borders.LineStyle     := 1;
      Excel.Range['A3',strLetra + '10'].Borders[07].LineStyle := 1;
      Excel.Range['A3',strLetra + '10'].Borders[10].LineStyle := 1;
      Excel.Range['A10',strLetra + '10'].Borders[09].LineStyle := 1;

      {*******************************************}
      {* DE ACORDO COM A QTD DE MESES INFORMADA  *}
      {* SETA A VAR. intCol COM O NR. DA COLUNA  *}
      {* QUE COMEÇARÁ A PREENCHER OS VALORES DE  *}
      {* CADA MÊS                                *}
      {****************************************RL*}
//      If (intOpcao <= 4) Then
        Case StrToInt(edtQtdMes.Text) Of
          1:  intCol  := 2;
          2:  intCol  := 3;
          3:  intCol  := 4;
          4:  intCol  := 5;
          5:  intCol  := 6;
          6:  intCol  := 7;
          7:  intCol  := 8;
          8:  intCol  := 9;
          9:  intCol  := 10;
          10: intCol  := 11;
          11: intCol  := 12;
          12: intCol  := 13;
        End;

      intRow := 11;

      {********************************}
      {* ALINHA AS CÉLULAS DA LINHA E *}
      {* CONTORNA AS CÉLULAS          *}
      {*****************************RL*}
       Excel.Range['A'+ IntToStr(intRow) , strLetra+ IntToStr(intRow)].Borders.LineStyle   := 1;
       Excel.Range['B'+ IntToStr(intRow) , strLetra+ IntToStr(intRow)].HorizontalAlignment := -4152;

      {*************************************}
      {* COLORE O FUNDO DA CELULA P/ CINZA *}
      {* E MUDA A FONTE PARA NEGRITO       *}
      {**********************************RL*}
      Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Interior.ColorIndex := 15;
      Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Font.Bold           := True;

      {*********************************************}
      {* CABEÇALHO DA COLUNA 01 E DA ÚLTIMA COLUNA *}
      {******************************************RL*}
      Excel.WorkBooks[1].Sheets[1].Cells[IntToStr(intRow), 01] := 'PRODUTO';

      If intOpcao = 4 Then
        Excel.WorkBooks[1].Sheets[1].Cells[IntToStr(intRow), 01] := 'FORNECEDOR';

      Excel.WorkBooks[1].Sheets[1].Cells[IntToStr(intRow), intCol + 1] := 'TOTAL';

      {*********************************************}
      {* CABEÇALHO DAS COLUNAS COM OS MESES        *}
      {******************************************RL*}
//      For intContador := 11 DownTo 11 - (intQtdMes - 1) Do
      intInicio := intQtdMes - 1;
      For intContador := intInicio DownTo 0 Do
      Begin

        Excel.Range['A' + IntToStr(intRow),strLetra + IntToStr(intRow)].NumberFormat := '@';
        Excel.WorkBooks[1].Sheets[1].Cells[IntToStr(intRow), intCol] := String(arrMesAbr[StrToInt(LeftStr(String(arrDatas[intContador]),2))]) + RightStr(String(arrDatas[intContador]),5);

        intCol := intCol - 1;

      End;

      {********************************************}
      {* SETA VARIÁVEL QUE CONTROLA A LINHA ATUAL *}
      {*****************************************RL*}
      If (intOpcao <= 4) Then
        intRow := 11;

      {*******************************************}
      {* CRIA VETORES DINÂMICOS PARA TOTALIZAÇÃO *}
      {* PARCIAL E GERAL                         *}
      {****************************************RL*}
      SetLength(arrTotalParc, intQtdMes + 1);
      SetLength(arrTotalLin, intQtdMes + 1);
      SetLength(arrTotal, intQtdMes + 1);

      {***********************************************}
      {* SETA A VARIÁVEL intCol DE ACORDO COM A      *}
      {* QTD DE MESES INFORMADA. DESSA VEZ A VAR.    *}
      {* intCol É UTILIZADA PARA REFERÊNCIA AOS      *}
      {* CAMPOS DA QUERY QUE ESTÃO DESCRITOS DA      *}
      {* SEGUINTE MANEIRA: DATA01...DATA06...DATA012 *}
      {********************************************RL*}
//      If (intOpcao <= 4 ) Then
        Case intQtdMes Of
          1:  intCol  := 12;
          2:  intCol  := 11;
          3:  intCol  := 10;
          4:  intCol  := 9;
          5:  intCol  := 8;
          6:  intCol  := 7;
          7:  intCol  := 6;
          8:  intCol  := 5;
          9:  intCol  := 4;
          10: intCol  := 3;
          11: intCol  := 2;
          12: intCol  := 1;
        End;

      {*******************************************}
      {* GERAR OS DADOS NA PLANILHA              *}
      {****************************************RL*}
      With qryRelatorio Do
      Begin

        {********************************}
        {* ALINHA AS CÉLULAS DA LINHA E *}
        {* CONTORNA AS CÉLULAS          *}
        {*****************************RL*}
        Excel.Range['A'+ IntToStr(intRow) , strLetra+ IntToStr(intCol + 2)].Borders.LineStyle   := 1;
        Excel.Range['B'+ IntToStr(intRow) , strLetra+ IntToStr(intCol + 2)].HorizontalAlignment := -4152;

        First;

        If (intOpcao in [1, 2, 5]) Then
        Begin
          strGrupo                                       := FieldByName('QUEBRA').AsString;
          Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('QUEBRA').AsString;
        End
        Else
        If (intOpcao = 6) Then
        Begin
          strLinha := '';
          strGrupo := '';
        End;

        {********************************}
        {* NEGRITO PARA O NOME DO GRUPO *}
        {*****************************RL*}
        Excel.Range['A' + IntToStr(intRow),'A' + IntToStr(intRow)].Font.Bold := True;

        intRow := intRow + 1;

        pgbStatus.Visible  := True;
        pgbStatus.Position := 0;
        pgbStatus.Max      := RecordCount;

        While (Not Eof) Do
        Begin

          Case intOpcao Of
               1, 2,
               3, 5 : Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString;
                  4 : Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('CODFOR').AsString + '-' + FieldByName('NOMFOR').AsString;
                  6 : Begin
                        {**************************}
                        {*QUEBRA LINHA/GRUPO      *}
                        {***********************GB*}
                        If (strLinha <> FieldByName('LINHA').AsString ) Then
                        Begin
                          Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('LINHA').AsString + '-' + FieldByName('NOMLIN').AsString;
                          Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold := True;
                          Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Interior.ColorIndex := 24;

                          Inc(intRow);
                        End;

                        If (strGrupo <> FieldByName('GRUPO').AsString ) Then
                        Begin
                          Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('GRUPO').AsString + '-' + FieldByName('NOMGRU').AsString;
                          Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold := True;

                          Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold := True;
                          Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Interior.ColorIndex := 22;

                          Inc(intRow);
                        End;

                      End;
            Else      Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('CODMAR').AsString + '-' + FieldByName('DESMAR').AsString;
          End;

          intColAux := 2;
          intQtdMes := StrToInt(edtQtdMes.Text);

//          If (intOpcao <= 4) Then
            Case intQtdMes Of
              1:  intCol  := 12;
              2:  intCol  := 11;
              3:  intCol  := 10;
              4:  intCol  := 9;
              5:  intCol  := 8;
              6:  intCol  := 7;
              7:  intCol  := 6;
              8:  intCol  := 5;
              9:  intCol  := 4;
              10: intCol  := 3;
              11: intCol  := 2;
              12: intCol  := 1;
            End;

          {********************************}
          {* ALINHA AS CÉLULAS DA LINHA E *}
          {* CONTORNA AS CÉLULAS          *}
          {*****************************RL*}
          Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].Borders.LineStyle   := 1;
          Excel.Range['B'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].HorizontalAlignment := -4152;

          intCol:= intQtdMes;

          For i := 1 to StrToInt(edtQtdMes.Text) Do
          Begin

//            strMes := '0' + IntToStr(intCol);
//            Inc(intCol, 1);

            strMes := '0' + IntToStr(i);
            Inc(intCol, -1);

            Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(FieldByName('DATA'+ strMes).AsFloat, ffFixed, 12, 2);

            {*******************************************}
            {* ALIMENTA VETORES DE TOTALIZAÇÃO         *}
            {****************************************RL*}
            arrTotalParc[i - 1] := arrTotalParc[i - 1] + FieldByName('DATA'+ strMes).AsFloat;
            arrTotalLin[i - 1]  := arrTotalLin[i - 1] + FieldByName('DATA'+ strMes).AsFloat;
            arrTotal[i - 1]     := arrTotal[i - 1] + FieldByName('DATA'+ strMes).AsFloat;

            If High(arrTotalParc) = i  Then
            Begin

              arrTotalParc[i] := arrTotalParc[i] + FieldByName('TOTDTA').AsFloat;
              arrTotal[i]     := arrTotal[i] + FieldByName('TOTDTA').AsFloat;

            End;

            intColAux := intColAux + 1;

          End;

          {*******************************************}
          {* ESCREVE TOTAL PARCIAL                   *}
          {****************************************RL*}
          Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(FieldByName('TOTDTA').AsFloat, ffFixed, 12, 2);

          if (intOpcao = 6) Then
          Begin
            strLinha := FieldByName('LINHA').AsString;
            strGrupo := FieldByName('GRUPO').AsString;
          End;

          Next;

          {******************************************}
          {*AGRUPAMENTO POR LINHA/GRUPO             *}
          {***************************************GB*}
          If (intOpcao = 6) Then
          Begin
            If ((strGrupo <> FieldByName('GRUPO').AsString) Or (Eof)) Then
            Begin
              Inc(intRow);
              intColAux := 2;

              {*******************************************}
              {* CONFIGURA COLUNA A01 DO TOTAL DO GRUPO  *}
              {****************************************RL*}
              Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].HorizontalAlignment := -4152;
              Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold           := True;
              Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01]                                  := 'TOTAL DO GRUPO';
              Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Interior.ColorIndex := 22;

              {*******************************************}
              {* ESCREVE T0TALIZAÇÃO PARCIAL NA LINHA    *}
              {****************************************RL*}
              For i := 0 to Length(arrTotalParc) - 1 Do
              Begin

                Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(arrTotalParc[i], ffFixed, 12, 2);

                arrTotalParc[i] := 0;
                intColAux       := intColAux + 1;

              End;

            End;

            If ((strLinha <> FieldByName('LINHA').AsString) Or (Eof)) Then
            Begin
              Inc(intRow);
              intColAux := 2;
              {*******************************************}
              {* CONFIGURA COLUNA A01 DO TOTAL DO GRUPO  *}
              {****************************************RL*}
              Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].HorizontalAlignment := -4152;
              Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold           := True;
              Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01]                                  := 'TOTAL DA LINHA';
              Excel.Range['A' + IntToStr(intRow), strLetra + IntToStr(intRow)].Interior.ColorIndex := 24;

              {*******************************************}
              {* ESCREVE T0TALIZAÇÃO PARCIAL NA LINHA    *}
              {****************************************RL*}
              For i := 0 to Length(arrTotalLin) - 1 Do
              Begin

                Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(arrTotalLin[i], ffFixed, 12, 2);

                arrTotalLin[i] := 0;
                intColAux       := intColAux + 1;

              End;
            End;
          End;

          {************************************************}
          {* AGRUPAMENTO POR (FORNECEDOR / PRODUTO, GRUPO *}
          {* QUANDO MUDAR O NOME DO AGRUP., EXECUTA OS    *}
          {* PROCEDIMENTOS ABAIXO                         *}
          {*********************************************RL*}
          If (intOpcao <> 3) And (intOpcao <> 4) And (intOpcao <> 6)
          And ((strGrupo <> FieldByName('QUEBRA').AsString) Or (Eof)) Then
          Begin

            intColAux := 2;
            intRow    := intRow + 1;

            {*******************************************}
            {* CONFIGURA COLUNA A01 DO TOTAL PARCIAL   *}
            {****************************************RL*}
            Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].HorizontalAlignment := -4152;
            Excel.Range['A'+ IntToStr(intRow) , 'A' + IntToStr(intRow)].Font.Bold           := True;
            Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01]                                  := 'TOTAL';

            {*******************************************}
            {* ESCREVE T0TALIZAÇÃO PARCIAL NA LINHA    *}
            {****************************************RL*}
            For i := 0 to Length(arrTotalParc) - 1 Do
            Begin

              Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(arrTotalParc[i], ffFixed, 12, 2);

              arrTotalParc[i] := 0;
              intColAux       := intColAux + 1;

            End;

            {*******************************************}
            {* CONFIGURA LINHA / COLUNA PARA O PRÓXIMO *}
            {* AGRUPAMENTO                             *}
            {****************************************RL*}
            If (Not Eof) and (intOpcao <> 6) Then
            Begin

              intRow := intRow + 2;

              strGrupo                                       := FieldByName('QUEBRA').AsString;
              Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01] := FieldByName('QUEBRA').AsString;

              Excel.Range['A' + IntToStr(intRow),'A' + IntToStr(intRow)].Font.Bold := True;

              intRow := intRow + 1;

            End;

            {********************************}
            {* ALINHA AS CÉLULAS DA LINHA E *}
            {* CONTORNA AS CÉLULAS          *}
            {*****************************RL*}
            Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].Borders.LineStyle   := 1;
            Excel.Range['B'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].HorizontalAlignment := -4152;

          End

          Else
          Begin

            {********************************}
            {* ALINHA AS CÉLULAS DA LINHA E *}
            {* CONTORNA AS CÉLULAS          *}
            {*****************************RL*}
            Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].Borders.LineStyle   := 1;
            Excel.Range['B'+ IntToStr(intRow) , strLetra + IntToStr(intCol + 2)].HorizontalAlignment := -4152;

            intRow := intRow + 1;

          End;

          pgbStatus.Position := pgbStatus.Position + 1;
          Application.ProcessMessages;

        End;

        {*******************************************}
        {* TOTAL GERAL                             *}
        {****************************************RL*}
        intColAux := 2;
        intRow    := intRow + 1;

        {********************************}
        {* CONFIGURA LINHA / COLUNAS    *}
        {* PARA TOTALIZAÇÃO GERAL       *}
        {*****************************RL*}
        Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intRow)].Borders.LineStyle   := 1;
        Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intRow)].HorizontalAlignment := -4152;
        Excel.Range['A'+ IntToStr(intRow) , strLetra + IntToStr(intRow)].Font.Bold           := True;
        Excel.WorkBooks[1].Sheets[1].Cells[intRow, 01]                                       := 'TOTAL GERAL';

        {********************************}
        {* ESCREVE TOTALIZAÇÃO GERAL    *}
        {*****************************RL*}
        For i := 0 to Length(arrTotal) - 1 Do
        Begin

          Excel.WorkBooks[1].Sheets[1].Cells[intRow, intColAux] := FloatToStrF(arrTotal[i], ffFixed, 12, 2);

          arrTotal[i] := 0;
          intColAux   := intColAux + 1;

        End;

      End;

      Excel.ActiveSheet.PageSetup.Orientation := 2;
      Excel.Columns.AutoFit;

      {********************************}
      {* SALVA PLANILHA               *}
      {*****************************RL*}
      If (svdExcel.Execute) Then
      Begin

        If (Not fEmptyStr(svdExcel.FileName)) Then
          Excel.WorkBooks[1].SaveAs(svdExcel.FileName);

      End;

      pgbStatus.Visible  := False;
      pgbStatus.Position := 0;

      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

    Except
      On E: Exception Do
      Begin
        pMensagensErro('Não foi possível gerar o arquivo! ' + #13 + 'Erro: ' + E.Message, 'pGeraExcelEvoVendas');
        pgbStatus.Visible  := False;
        pgbStatus.Position := 0;
      End;
    End;
  Finally
    Excel.Quit;
  End;
end;

procedure TfrmRelEstEvoCompras.FormShow(Sender: TObject);
begin
  mskMesBas.Text := FormatDateTime('mm/yyyy', VS_Date);

  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***08/02/2008*******************ER*}
  shpMultSel.Visible := True;

  If SameText(fCfgSis('LITGAL'), 'L') Then
   lblOpcao2.Caption := '(L)itros/Kilos (Q)uantidade (V)alor'
  Else
   lblOpcao2.Caption := '(G)alonagem (Q)uantidade (V)alor';

  inherited;
  pCriaQryRelatorio;
end;

procedure TfrmRelEstEvoCompras.edtDestinoExit(Sender: TObject);
begin
  //inherited;

end;

class function TfrmRelEstEvoCompras.fRetClaCom: String;
begin
  Result := VS_strClaCom;
  If AnsiEndsText('_', Result) Then
  Begin
    Result := LeftStr(Result, Length(Result)-1);
  End;

  While (Pos(' ', Result) > 0) Do
  Begin
    Result := AnsiReplaceText(Result, ' ', '_');
  End;

  Result := AnsiReplaceStr(Result, '_', '","');
  Result := '"' + Result + '"';
  Result := AnsiReplaceStr(Result, '"",', '');
end;

function TfrmRelEstEvoCompras.fRetornaForFil: String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := '';

  qryTmp := fCriaQuery;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result + '"' + FieldByName('EMP_FORFIL').AsString + '", ';
          Next;
        End;

        Result := Copy(Result, 1, Length(Result) - 2);
      End;

  Finally
    qryTmp.Close;
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmRelEstEvoCompras.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmRelEstEvoCompras.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fvalidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstEvoCompras.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

end.

