unit untRelCadCustosIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, BitBtnLockedIncrem, Mask, MaskEditFocus,
  untFuncoesSimples, untZClient, Uni,
  untOrdProIndustrial, UniClientDataSet, DB, untParCalculaPrecoCusto, ComCtrls,
  frxExportCSVTestabilidade, strUtils, Math,

  REST.Json,

  OrdemProducaoIndustrial.TEmbalagem,
  OrdemProducaoIndustrial.TMateriaPrima,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.TOrdemProducao,
  OrdemProducaoIndustrial.TCorrecao,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TCdsProdutoAcabado,
  OrdemProducaoIndustrial.TCdsFormula,
  OrdemProducaoIndustrial.TCdsComposicao;

type
  TfrmRelCadCustosIndustrial = class(TfrmPaiRelatorio)
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label2: TLabel;
    Label11: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodMarAca: TEditFocus;
    edtDesMarAca: TEditFocus;
    mskLinGruAca: TMaskEditFocus;
    edtDesGruAca: TEditFocus;
    edtCodProdutoAca: TEditFocus;
    edtDesProdutoAca: TEditFocus;
    frxReportJ: TfrxReport;
    frxDBCombo: TfrxDBDataset;
    frxDBFormula: TfrxDBDataset;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label6: TLabel;
    Label8: TLabel;
    edtNumOrd: TEditFocus;
    mskDtaCad: TMaskEditFocus;
    dtsItens: TDataSource;
    dtsComposicao: TDataSource;
    dtsFormula: TDataSource;
    prbProgresso: TProgressBar;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    chkQbrOrd: TCheckBox;
    chkExbQtd: TCheckBox;
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarAcaExit(Sender: TObject);
    procedure edtCodMarAcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruAcaExit(Sender: TObject);
    procedure mskLinGruAcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoAcaExit(Sender: TObject);
    procedure edtCodProdutoAcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    cpcParams    : TParCalculaPrecoCusto;

    arrLinGru    : TConsultasArray;
    arrMarca     : TConsultasArray;
    arrProduto   : TConsultasArray;
    arrLinGruAca : TConsultasArray;
    arrMarcaAca  : TConsultasArray;
    arrProdutoAca: TConsultasArray;

    strLinGru,
    strMarca,
    strProduto,
    strLinGruAca,
    strMarcaAca,
    strProdutoAca: String;

    fltValorRecuo: Double;

    cdsItens : TCdsProdutoAcabado;
    cdsFormula : TCdsFormula;
    cdsComposicao : TCdsComposicao;
    qryOrdemProducao : TUniQuery;

    intDECRCA: Integer;

    Function fSQLIteger: String;
    Function fCalculaPrecoCusto(strCodIte: String; fltPreCom: Double): Double;
    Function fCarregaItens: Boolean;


    Procedure pAfterScrollItens(dataset: TDataSet);
    function fMontaCalculo: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untConsultas, untFuncoesConsulta, untTConfiguracao,
  OrdemProducaoIndustrial.FuncoesJson, OrdemProducaoIndustrial.TFiltroProduto;

{$R *.dfm}

procedure TfrmRelCadCustosIndustrial.btnImprimirClick(Sender: TObject);
var
  intComp: Integer;
  strFiltro: string;
  intPos: Integer;

begin
  inherited;

  Try

    If blnImprime And fMontaCalculo Then
    Begin

      // req 200648 (resolvi mexer aqui para alterar somente o relatório)
      strFiltro := '';
      cdsItens.Filter := '';
      cdsItens.Filtered := False;
      if not fEmptyStr(edtCodProdutoAca.Text) then
      begin
        if Length(arrProdutoAca) = 0 then
          strFiltro := 'CODIGO_PRODUTO_ACABADO = ' + QuotedStr(edtCodProdutoAca.Text)
        else
        begin
          for intPos := 0 to Length(arrProdutoAca) - 1 do
            strFiltro := strFiltro + IfThen(fEmptyStr(strFiltro), '', ' OR ') + '(CODIGO_PRODUTO_ACABADO = ' + QuotedStr(arrProdutoAca[intPos].strCodigo) + ')';
        end;
        cdsItens.Filter := '(' + strFiltro + ')';
        cdsItens.Filtered := True;
      end;

      If Not cdsItens.IsEmpty Then
      Begin
        pnlInfo.Caption := 'Gerando Relatório...';
        pnlInfo.Repaint;
        Application.ProcessMessages;

        With frxReportJ Do
        Begin
          Script.Variables['NOMREL']  := 'PREÇOS E COMPOSIÇÃO DE PRODUTOS ACABADOS';

          Script.Variables['MARCA']   := fStrTitulo(edtCodMar.Text,     edtDesMar,     arrMarca,   strMarca,   'MARCA DO GRANEL');
          Script.Variables['PRODUTO'] := fStrTitulo(edtCodProduto.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO A GRANEL');
          Script.Variables['LINGRU']  := fStrTitulo(mskLinGru.Text,     edtDesGru,     arrLinGru,  strLinGru,  'LINHA/GRUPO A GRANEL');

          Script.Variables['MARACA']  := fStrTitulo(edtCodMarAca.Text,     edtDesMarAca,     arrMarcaAca,   strMarcaAca,   'MARCA DO ACABADO');
          Script.Variables['PROACA']  := fStrTitulo(edtCodProdutoAca.Text, edtDesProdutoAca, arrProdutoAca, strProdutoAca, 'PRODUTO ACABADO');
          Script.Variables['LINACA']  := fStrTitulo(mskLinGruAca.Text,     edtDesGruAca,     arrLinGruAca,  strLinGruAca,  'LINHA/GRUPO ACABADO');

          TfrxGroupHeader(frxReportJ.FindObject('GroupHeaderOP')).StartNewPage := chkQbrOrd.Checked;

          TFrxMemoView(frxReportJ.FindObject('Memo49')).DisplayFormat.FormatStr := '%2.' + IntToStr(intDECRCA) + 'f';
          TFrxMemoView(frxReportJ.FindObject('Memo51')).DisplayFormat.FormatStr := '%2.' + IntToStr(intDECRCA) + 'f';
          TFrxMemoView(frxReportJ.FindObject('mmoCusPro')).DisplayFormat.FormatStr := '%2.' + IntToStr(intDECRCA) + 'f';

          if chkExbQtd.Checked then
          begin
            if fltValorRecuo = 0 then
            begin
              fltValorRecuo := 150;
              for intComp := 0 to frxReportJ.ComponentCount - 1 do
              begin
                if frxReportJ.Components[intComp].Tag = 9 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Left := TfrxMemoView(frxReportJ.Components[intComp]).Left - fltValorRecuo;
                if frxReportJ.Components[intComp].Tag = 8 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Width := TfrxMemoView(frxReportJ.Components[intComp]).Width - fltValorRecuo;
                if frxReportJ.Components[intComp].Tag = 7 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Visible := True;
              end;
            end;
          end
          else
          begin
            if fltValorRecuo <> 0 then
            begin
              for intComp := 0 to frxReportJ.ComponentCount - 1 do
              begin
                if frxReportJ.Components[intComp].Tag = 9 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Left := TfrxMemoView(frxReportJ.Components[intComp]).Left + fltValorRecuo;
                if frxReportJ.Components[intComp].Tag = 8 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Width := TfrxMemoView(frxReportJ.Components[intComp]).Width + fltValorRecuo;
                if frxReportJ.Components[intComp].Tag = 7 then
                  TfrxMemoView(frxReportJ.Components[intComp]).Visible := False;
              end;
              fltValorRecuo := 0;
            end;
          end;

          PrepareReport;

          If (edtDestino.Text = 'V') Then
            pPreviewReport(Self.Name, Self.Caption, frxReportJ)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxReportJ);

        End

      End
      Else
        pTabelaVazia;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelCadCustosIndustrial.btnImprimirClick]');
    End;
  End;

  pnlInfo.Caption := '';
  pSetFocus(edtCodMar);
end;

procedure TfrmRelCadCustosIndustrial.edtCodMarAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMarAca, edtDesMarAca, arrMarcaAca, fRetNomMarca,nil,'da Marca');
  
end;

procedure TfrmRelCadCustosIndustrial.edtCodMarAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMarAca,
                 edtDesMarAca,
                 Nil,
                 Key,
                 arrMarcaAca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMarAca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCadCustosIndustrial.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
  
end;

procedure TfrmRelCadCustosIndustrial.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMar,
                 edtDesMar,
                 Nil,
                 Key,
                 arrMarca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCadCustosIndustrial.edtCodProdutoAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProdutoAca, edtDesProdutoAca, arrProdutoAca, nil, fRetNomProduto, 'do Produto');
  
end;

procedure TfrmRelCadCustosIndustrial.edtCodProdutoAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProdutoAca, edtDesProdutoAca,
               nil, Key, arrProdutoAca, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               True,  {Departamento produto acabados cadestruturaindustrial}
               False,
               False) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodProdutoAca,False) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCadCustosIndustrial.edtCodProdutoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodProduto,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');

end;

procedure TfrmRelCadCustosIndustrial.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto,
               nil, Key, arrProduto, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               False,
               False,
               True) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodProduto,False) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCadCustosIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodProduto);
  pSetaCodIte(edtCodProdutoAca);
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  qryOrdemProducao := fCriaQuery(nil);
  cdsItens := TCdsProdutoAcabado.Create(nil);
  cdsFormula := TCdsFormula.Create(nil);
  cdsComposicao := TCdsComposicao.Create(nil);

  dtsItens.DataSet:= cdsItens;
  dtsFormula.DataSet := cdsFormula;
  dtsComposicao.DataSet := cdsComposicao;

  fltValorRecuo := 0;
  intDECRCA := fCfgSis('DECRCA', varInteger);

  TFloatField(cdsFormula.FieldByName('CUSTO_UNITARIO')).DisplayFormat := fMskDigitos(intDECRCA);
  TFloatField(cdsFormula.FieldByName('CUSTO_100KG')).DisplayFormat := fMskDigitos(intDECRCA);
  TFloatField(cdsFormula.FieldByName('CUSTO_PRODUCAO')).DisplayFormat := fMskDigitos(intDECRCA);
end;

procedure TfrmRelCadCustosIndustrial.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryOrdemProducao);
  FreeAndNil(cdsItens);
  FreeAndNil(cdsFormula);
  FreeAndNil(cdsComposicao);
end;

procedure TfrmRelCadCustosIndustrial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelCadCustosIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6)
    End

    Else If (Sender = edtCodProduto) Then
    Begin
      pDesmarcaLista(edtCodProduto, arrProduto);

      If (Not fEmptyStr(edtCodProduto.Text)) And
         (Not SameText(edtCodProduto.Text, fStrZero('0', edtCodProduto.TamCampo))) And
         (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProduto.Text]) <>
           fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProduto.Text])), 'PROGRA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é A Granel!');
      End;
    End

    Else If (Sender = edtCodMarAca) Then
    Begin
      pDesmarcaLista(edtCodMarAca, arrMarcaAca);
    End

    Else If (Sender = mskLinGruAca) Then
    Begin
      pDesmarcaLista(mskLinGruAca, arrLinGruAca, '', 6)
    End

    Else If (Sender = edtCodProdutoAca) Then
    Begin
      pDesmarcaLista(edtCodProdutoAca, arrProdutoAca);

      If (Not fEmptyStr(edtCodProdutoAca.Text)) And
         (Not SameText(edtCodProdutoAca.Text, fStrZero('0', edtCodProdutoAca.TamCampo))) And
         (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProdutoAca.Text]) <>
           fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodProdutoAca.Text])), 'PROACA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é Acabado!');
      End;
    End;

    If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));
    End
    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
          mskDtaFin.Text := DateToStr(VS_Date);
        End
        Else
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtNumOrd) Then
    Begin
      mskDtaCad.Enabled := not fEmptyStr(edtNumOrd.Text);
    End

    Else If (Sender = mskDtaCad) And (mskDtaCad.Enabled) Then
    Begin

      If fEmptyDate(mskDtaCad.Text) Then
      Begin
        pMensagemOk('Informe a Data de Cadastro da Ordem de Produção!');
        Result := False;
      End

    End;


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCadCustosIndustrial.mskLinGruAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGruAca, edtDesGruAca, arrLinGruAca, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);
  
end;

procedure TfrmRelCadCustosIndustrial.mskLinGruAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGruAca,
                edtDesGruAca,
                Nil,
                Key,
                arrLinGruAca,
                False) Then
  Begin
    If fValidaCampos(mskLinGruAca, True) then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmRelCadCustosIndustrial.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);

end;

procedure TfrmRelCadCustosIndustrial.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGru,
                edtDesGru,
                Nil,
                Key,
                arrLinGru,
                False) Then
  Begin
    If fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

Function TfrmRelCadCustosIndustrial.fCarregaItens: Boolean;
var
  objOrdemProducao : TOrdemProducao;

  objProdutoAcabado : TProdutoAcabado;
  objMateriaPrima : TMateriaPrima;
  objCorrecao : TCorrecao;
  objEmbalagem : TEmbalagem;
  fltCustoKilo : double;
  objFiltroProdutoAcabado : TFiltroProduto;
Begin
    qryOrdemProducao.SQL.Clear;
    qryOrdemProducao.SQL.Add(' /* untfrmRelCadCustosIndustrial.fSQLItens */               ');
    qryOrdemProducao.SQL.Add(' SELECT SQL_NO_CACHE DISTINCT                               ');
    qryOrdemProducao.SQL.Add('    GR.ITE_CODITE     AS CODIGO_PRODUTO_GRANEL,             ');
    qryOrdemProducao.SQL.Add('    GR.ITE_DESITE     AS DESCRICAO_PRODUTO_GRANEL,          ');
    qryOrdemProducao.SQL.Add('    ORD_CODORD        AS CODIGO_ORDEM_PRODUCAO,             ');
    qryOrdemProducao.SQL.Add('    ORD_CODCOR        AS CODIGO_COR,                        ');
    qryOrdemProducao.SQL.Add('    COR_DESCOR        AS DESCRICAO_COR,                     ');
    qryOrdemProducao.SQL.Add('    ORD_DTACAD        AS DATA_CADASTRO,                     ');
    qryOrdemProducao.SQL.Add('    ORD_DTABAI        AS DATA_BAIXA,                        ');
    qryOrdemProducao.SQL.Add('    ORD_CODOPE        AS CODIGO_OPERADOR,                ');
    qryOrdemProducao.SQL.Add('    ORD_OPEBAI        AS CODIGO_OPEBAIXA,                ');
    qryOrdemProducao.SQL.Add('    CO.OPE_NOMOPE     AS NOME_OPERADOR,                  ');
    qryOrdemProducao.SQL.Add('    CP.OPE_NOMOPE     AS NOME_OPEBAIXA,                  ');
    qryOrdemProducao.SQL.Add('    ORDGER.AUTOINCREM AS SEQUENCIAL_ORDEM_PRODUCAO,         ');
    qryOrdemProducao.SQL.Add('    ORD_PESREA        AS PESO_REAL,                         ');
    qryOrdemProducao.SQL.Add('    UNI_KILLIT        AS TIPO_MEDIDA                        ');
    qryOrdemProducao.SQL.Add('  FROM                                                      ');
    qryOrdemProducao.SQL.Add('    ORDGER                                                  ');
    qryOrdemProducao.SQL.Add('    INNER JOIN CADITE GR ON GR.ITE_CODITE = ORD_CODITE      ');
    qryOrdemProducao.SQL.Add('    INNER JOIN CADITE I  ON I.ITE_CODPAG = GR.ITE_CODITE    ');
    qryOrdemProducao.SQL.Add( '   INNER JOIN CADUNI UGR ON UGR.UNI_CODUNI = GR.ITE_CODUNI ');
    qryOrdemProducao.SQL.Add('    INNER JOIN CADCOR    ON COR_CODCOR = ORD_CODCOR         ');
    qryOrdemProducao.SQL.Add('    LEFT JOIN CADOPE CO ON CO.OPE_CODOPE = ORD_CODOPE       ');
    qryOrdemProducao.SQL.Add('    LEFT JOIN CADOPE CP ON CP.OPE_CODOPE = ORD_OPEBAI       ');
    qryOrdemProducao.SQL.Add('  WHERE ORD_CODEMP = :CODIGO_EMPRESA                        ');
    qryOrdemProducao.SQL.Add('    AND ORD_DTABAI IS NOT NULL                              ');
    qryOrdemProducao.SQL.Add('    AND GR.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ') ');

    If not fEmptyDate(mskDtaIni.Text) Then
      qryOrdemProducao.SQL.Add('    AND ORD_DTABAI BETWEEN :DATA_INICIAL AND :DATA_FINAL ');

    If (not fEmptyStr(edtNumOrd.Text)) and ( not fEmptyDate(mskDtaCad.Text)) Then
    Begin
      qryOrdemProducao.SQL.Add('    AND ORD_CODORD = :CODIGO_ORDEM_PRODUCAO        ');
      qryOrdemProducao.SQL.Add('    AND ORD_DTACAD = :DATA_CADASTRO_ORDEM_PRODUCAO ');
    End;

    qryOrdemProducao.SQL.Add(fStrLocateLinGru(mskLinGru, arrLinGru,  'GR.ITE_CODGRU', 'CODIGO_GRUPO_GRANEL'));
    qryOrdemProducao.SQL.Add(fStrLocate(edtCodMar,       arrMarca,   'GR.ITE_CODMAR', 'CODIGO_MARCA_GRANEL'));
    qryOrdemProducao.SQL.Add(fStrLocate(edtCodProduto,   arrProduto, 'GR.ITE_CODITE', 'CODIGO_PRODUTO_GRANEL'));

    qryOrdemProducao.SQL.Add(fStrLocateLinGru(mskLinGruAca, arrLinGruAca,  'I.ITE_CODGRU', 'CODIGO_GRUPO_ACABADO'));
    qryOrdemProducao.SQL.Add(fStrLocate(edtCodMarAca,       arrMarcaAca,   'I.ITE_CODMAR', 'CODIGO_MARCA_ACABADO'));
    qryOrdemProducao.SQL.Add(fStrLocate(edtCodProdutoAca,   arrProdutoAca, 'I.ITE_CODITE', 'CODIGO_PRODUTO_ACABADO'));

    qryOrdemProducao.SQL.Add(' ORDER BY        ');
    qryOrdemProducao.SQL.Add('    GR.ITE_CODITE, I.ITE_CODCOR, I.ITE_DESITE ');


    If not fEmptyDate(mskDtaIni.Text) Then
    Begin
      qryOrdemProducao.ParamByName('DATA_INICIAL').AsDateTime := StrToDateDef(mskDtaIni.Text, 0);
      qryOrdemProducao.ParamByName('DATA_FINAL').AsDateTime := StrToDateDef(mskDtaFin.Text, 0);
    End;

    If (not fEmptyStr(edtNumOrd.Text)) and ( not fEmptyDate(mskDtaCad.Text)) Then
    Begin
      qryOrdemProducao.ParamByName('CODIGO_ORDEM_PRODUCAO').AsString   := edtNumOrd.Text;
      qryOrdemProducao.ParamByName('DATA_CADASTRO_ORDEM_PRODUCAO').AsDateTime := StrToDateDef(mskDtaCad.Text, 0);
    End;

    pSetaParam(mskLinGru.Text,     arrLinGru,  strLinGru,  'CODIGO_GRUPO_GRANEL', qryOrdemProducao);
    pSetaParam(edtCodMar.Text,     arrMarca,   strMarca,   'CODIGO_MARCA_GRANEL', qryOrdemProducao);
    pSetaParam(edtCodProduto.Text, arrProduto, strProduto, 'CODIGO_PRODUTO_GRANEL', qryOrdemProducao);

    pSetaParam(mskLinGruAca.Text,     arrLinGruAca,  strLinGruAca,  'CODIGO_GRUPO_ACABADO', qryOrdemProducao);
    pSetaParam(edtCodMarAca.Text,     arrMarcaAca,   strMarcaAca,   'CODIGO_MARCA_ACABADO', qryOrdemProducao);
    pSetaParam(edtCodProdutoAca.Text, arrProdutoAca, strProdutoAca, 'CODIGO_PRODUTO_ACABADO', qryOrdemProducao);

    qryOrdemProducao.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;

    qryOrdemProducao.Open;

    prbProgresso.Position := 0;
    prbProgresso.Max      := qryOrdemProducao.RecordCount;
    Application.ProcessMessages;

    objFiltroProdutoAcabado := TFiltroProduto.Create;
    objFiltroProdutoAcabado.strCodigo      := objFiltroProdutoAcabado.fRetornaFiltro(edtCodProdutoAca.Text, arrProdutoAca);
    objFiltroProdutoAcabado.strLinhaGrupo  := objFiltroProdutoAcabado.fRetornaFiltro(mskLinGruAca.Text, arrLinGruAca);
    objFiltroProdutoAcabado.strCodigoMarca := objFiltroProdutoAcabado.fRetornaFiltro(edtCodMarAca.Text, arrMarcaAca);

    cdsItens.EmptyDataSet;
    qryOrdemProducao.First;
    while not qryOrdemProducao.eof do
    begin
      objOrdemProducao := fGetTOrdemProducaoFromOPJSON(qryOrdemProducao.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString, objFiltroProdutoAcabado);

      for objMateriaPrima in objOrdemProducao.objFormula.lstMateriasPrimas do
      begin
        objMateriaPrima.blnArredondarValor:= False;

        cdsFormula.Append;
        cdsFormula.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := objOrdemProducao.strAutoincrem;
        cdsFormula.FieldByName('TIPO').AsString := 'NORMAL';
        cdsFormula.FieldByName('CODIGO_ITEM').AsString := objMateriaPrima.strCodigo;
        cdsFormula.FieldByName('DESCRICAO_ITEM').AsString := objMateriaPrima.strDescricao;
        cdsFormula.FieldByName('QUANTIDADE').AsFloat := objMateriaPrima.fltPercentualFormula;
        cdsFormula.FieldByName('CUSTO_UNITARIO').AsFloat := objMateriaPrima.fltCusto;
        cdsFormula.FieldByName('CUSTO_100KG').AsFloat := objMateriaPrima.fRetornaCustoProduzidoKilo(100);
        cdsFormula.FieldByName('CUSTO_PRODUCAO').AsFloat := objMateriaPrima.fRetornaCustoProduzidoKilo(objOrdemProducao.fRetornaPesoProduzidoTotal);
        cdsFormula.FieldByName('QTD_PRODUCAO').AsFloat := objMateriaPrima.fRetornaCustoProduzidoKilo(objOrdemProducao.fRetornaPesoProduzidoTotal) / objMateriaPrima.fltCusto;
        cdsFormula.Post;
      end;

      for objCorrecao in objOrdemProducao.lstCorrecoes do
      begin
        cdsFormula.Append;
        cdsFormula.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := objOrdemProducao.strAutoincrem;
        cdsFormula.FieldByName('TIPO').AsString := 'CORRECAO';
        cdsFormula.FieldByName('CODIGO_ITEM').AsString := objCorrecao.strCodigo;
        cdsFormula.FieldByName('DESCRICAO_ITEM').AsString := objCorrecao.strDescricao;
        If fEmptyStr(cdsFormula.FieldByName('DESCRICAO_ITEM').AsString) Then
          cdsFormula.FieldByName('DESCRICAO_ITEM').AsString := fCampoTabela('ITE_DESITE', 'CADITE',['ITE_CODITE'],[objCorrecao.strCodigo]);
        cdsFormula.FieldByName('QUANTIDADE').AsFloat := objCorrecao.fltQuantidade;
        cdsFormula.FieldByName('CUSTO_UNITARIO').AsFloat := objCorrecao.fltCusto;
        cdsFormula.FieldByName('CUSTO_100KG').AsFloat := 0;
        cdsFormula.FieldByName('CUSTO_PRODUCAO').AsFloat := objCorrecao.fRetornaCustoTotal;
        cdsFormula.FieldByName('QTD_PRODUCAO').AsFloat := objCorrecao.fRetornaCustoTotal / objCorrecao.fltCusto;
        cdsFormula.Post;
      end;


      fltCustoKilo := objOrdemProducao.fRetornaCustoKilo;
      for objProdutoAcabado in objOrdemProducao.lstProdutosAcabados do
      begin
        if objProdutoAcabado.fltQuantidadeEnvasada > 0 then
        begin
          cdsItens.Append;
          cdsItens.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := objOrdemProducao.strAutoincrem;
          cdsItens.FieldByName('CODIGO_ORDEM_PRODUCAO').AsString := objOrdemProducao.strCodigo;
          cdsItens.FieldByName('DATA_CADASTRO_ORDEM_PRODUCAO').AsDateTime := objOrdemProducao.dtaDataCadastro;
          cdsItens.FieldByName('DATA_BAIXA_ORDEM_PRODUCAO').AsDateTime := objOrdemProducao.dtaDataBaixa;
          cdsItens.FieldByName('CODIGO_OPERADOR').AsString := objOrdemProducao.strCodigoOperador;
          cdsItens.FieldByName('NOME_OPERADOR').AsString := objOrdemProducao.strNomeOperador;
          cdsItens.FieldByName('CODIGO_OPEBAIXA').AsString := objOrdemProducao.strCodigoOpeBaixa;
          cdsItens.FieldByName('NOME_OPEBAIXA').AsString := objOrdemProducao.strNomeOpeBaixa;
          cdsItens.FieldByName('PESO_REAL').AsFloat := objOrdemProducao.objFormula.fltPesoReal;
          cdsItens.FieldByName('CODIGO_PRODUTO_GRANEL').AsString := objOrdemProducao.objFormula.objProdutoGranel.strCodigo;
          cdsItens.FieldByName('DESCRICAO_PRODUTO_GRANEL').AsString := objOrdemProducao.objFormula.objProdutoGranel.strDescricao;
          cdsItens.FieldByName('KILO_LITRO_GRANEL').AsString := fTipoMedidaUnidadeToStr(objOrdemProducao.objFormula.objProdutoGranel.enuMedidaUnidade);
          cdsItens.FieldByName('CODIGO_COR').AsString := objOrdemProducao.objFormula.objCor.strCodigo;
          cdsItens.FieldByName('DESCRICAO_COR').AsString := objOrdemProducao.objFormula.objCor.strDescricao;
          cdsItens.FieldByName('CUSTO_KILO').AsFloat := fltCustoKilo;
          cdsItens.FieldByName('CUSTO_LITRO').AsFloat := objOrdemProducao.fRetornaCustoLitro;
          cdsItens.FieldByName('TOTAL_ENVASADO_KILO').AsFloat := objOrdemProducao.fRetornaPesoEnvasadoTotal;
          cdsItens.FieldByName('TOTAL_ENVASADO_LITRO').AsFloat := objOrdemProducao.fRetornaVolumeEnvasadoTotal;
          cdsItens.FieldByName('TOTAL_PRODUZIDO_KILO').AsFloat := objOrdemProducao.fRetornaPesoProduzidoTotal;
          cdsItens.FieldByName('CUSTO_TOTAL_PRODUCAO').AsFloat := objOrdemProducao.fRetornaCustoTotalProducao;

          cdsItens.FieldByName('CODIGO_PRODUTO_ACABADO').AsString := objProdutoAcabado.strCodigo;
          cdsItens.FieldByName('DESCRICAO_PRODUTO_ACABADO').AsString := objProdutoAcabado.strDescricao;
          cdsItens.FieldByName('PESO_LITRO_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fltPesoLitro;
          cdsItens.FieldByName('QUANTIDADE_PRODUZIDA_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fltQuantidadeProduzida;
          cdsItens.FieldByName('QUANTIDADE_ENVASADA_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fltQuantidadeEnvasada;
          cdsItens.FieldByName('PESO_PRODUZIDO_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fRetornaPesoProduzido;
          cdsItens.FieldByName('CUSTO_RELATIVO_PRODUCAO_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fRetornaCustoRelativoProducao(objOrdemProducao.fRetornaCustoTotalProducao, objOrdemProducao.fRetornaPesoProduzidoTotal);
          cdsItens.FieldByName('CUSTO_FORMULA_UNITARIO_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fRetornaCustoUnitarioFormula(fltCustoKilo);
          cdsItens.FieldByName('CUSTO_COMPOSICAO_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fRetornaCustoUnitarioComposicao;
          cdsItens.FieldByName('PRECO_COMPRA_PRODUTO_ACABADO').AsFloat := objProdutoAcabado.fRetornaCustoUnitario(fltCustoKilo);
          cdsItens.FieldByName('CUSTO_PRODUTO_ACABADO').AsFloat := fCalculaPrecoCusto(objProdutoAcabado.strCodigo, objProdutoAcabado.fRetornaCustoUnitario(fltCustoKilo));

          cdsItens.Post;

          for objEmbalagem in objProdutoAcabado.objComposicao.lstEmbalagens do
          begin
            cdsComposicao.Append;
            cdsComposicao.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := objOrdemProducao.strAutoincrem;
            cdsComposicao.FieldByName('CODIGO_PRODUTO_ACABADO').AsString := objProdutoAcabado.strCodigo;
            cdsComposicao.FieldByName('CODIGO_COMPOSICAO').AsString := objProdutoAcabado.objComposicao.strCodigo;
            cdsComposicao.FieldByName('DESCRICAO_COMPOSICAO').AsString := objProdutoAcabado.objComposicao.strDescricao;
            cdsComposicao.FieldByName('CODIGO_ITEM').AsString := objEmbalagem.strCodigo;
            cdsComposicao.FieldByName('DESCRICAO_ITEM').AsString := objEmbalagem.strDescricao;
            cdsComposicao.FieldByName('QUANTIDADE').AsFloat := objEmbalagem.fltQuantidade;
            cdsComposicao.FieldByName('CUSTO_UNITARIO').AsFloat := objEmbalagem.fltCusto;
            cdsComposicao.FieldByName('CUSTO_TOTAL').AsFloat := objEmbalagem.fRetornaCusto(objProdutoAcabado.fltQuantidadeEnvasada);
            cdsComposicao.Post;
          end;
        end;
      end;

      FreeAndNil(objOrdemProducao);

      qryOrdemProducao.Next;

      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    end;

    Result := True;
End;

Function TfrmRelCadCustosIndustrial.fSQLIteger: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ITE_DESF01, ';
  Result := Result + '   ITE_DESF02, ';
  Result := Result + '   ITE_DESF03, ';
  Result := Result + '   ITE_DESF04, ';
  Result := Result + '   ITE_DESF05, ';
  Result := Result + '   ITE_DESF06, ';
  Result := Result + '   ITE_ICMENT, ';
  Result := Result + '   ITE_IPIENT, ';
  Result := Result + '   ITE_FREENT, ';
  Result := Result + '   ITE_VALFRE, ';
  Result := Result + '   ITE_ACRFIN, ';
  Result := Result + '   ITE_SUBSTI, ';
  Result := Result + '   ITE_DESADB, ';
  Result := Result + '   ITE_SUBFED, ';
  Result := Result + '   ITE_TCIFCU, ';
  Result := Result + '   ITE_TSCUST, ';
  Result := Result + '   ITE_DEPICO, ';
  Result := Result + '   ITE_DEICMS, ';
  Result := Result + '   ITE_FATREG  ';
  Result := Result + ' FROM          ';
  Result := Result + '   ITEGER      ';
  Result := Result + ' WHERE         ';
  Result := Result + '   ITE_CODITE = :CODITE AND';
  Result := Result + '   ITE_CODEMP = :CODEMP    ';
End;

Function TfrmRelCadCustosIndustrial.fCalculaPrecoCusto(strCodIte: String; fltPreCom: Double): Double;
  Var
    qryIteGer: TUniQuery;
Begin
  qryIteGer := fCriaQuery;
  qryIteGer.SQL.Text := fSQLIteger;

  With cpcParams, qryIteGer Do
  Begin
    Close;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    If IsEmpty Then
      Result := 0
    Else
    Begin
      curPreCom := fltPreCom;
      curDesF01 := FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := FieldByName('ITE_DESF06').AsFloat;
      curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := FieldByName('ITE_FREENT').AsFloat;
      curValFre := FieldByName('ITE_VALFRE').AsFloat;
      curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
      curDesAdb := FieldByName('ITE_DESADB').AsFloat;
      curSubFed := FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
        curTSCust := FieldByName('ITE_TSCUST').AsFloat;
        curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
        curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
        curFatReg := FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;

      Result := fCalculaPrecoCusto();
    End;
  End;

  FreeAndNil(qryIteGer);
End;

Procedure TfrmRelCadCustosIndustrial.pAfterScrollItens(dataset: TDataSet);
Begin
  cdsComposicao.Filter := '    SEQUENCIAL_ORDEM_PRODUCAO = ' + QuotedStr(dataSet.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString) +
                          'AND CODIGO_PRODUTO_ACABADO    = ' + QuotedStr(dataSet.FieldByName('CODIGO_PRODUTO_ACABADO').AsString);
  cdsComposicao.Filtered := True;
  cdsComposicao.First;

  cdsFormula.Filter   := 'SEQUENCIAL_ORDEM_PRODUCAO = ' + QuotedStr(dataSet.FieldByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString);
  cdsFormula.Filtered :=  True;
  cdsFormula.First;
End;

Function TfrmRelCadCustosIndustrial.fMontaCalculo: Boolean;
Begin
  Try
    qryOrdemProducao.AfterScroll := Nil;
    qryOrdemProducao.IndexFieldNames := '';
    qryOrdemProducao.Filtered := False;

    cdsItens.EmptyDataSet;
    cdsFormula.EmptyDataSet;
    cdsComposicao.EmptyDataSet;

    Result := False;

    If Not fCarregaItens Then
      Exit;

    cdsItens.AfterScroll := pAfterScrollItens;
    cdsItens.First;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRelCadCustosIndustrial.fMontaCalculo]');
    End;
  End;

  prbProgresso.Position := 0;
  Application.ProcessMessages;
End;


end.
