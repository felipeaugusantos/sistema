{*****************************************}
{* FEITO ORIGINALMENTE PARA O CLIENTE    *}
{* P-FER -> PALACIO DAS FERRAMENTAS      *}
{**************************************MV*}

unit untExportacaoSiteMod1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ComCtrls, StdCtrls, Mask, DirectoryEditFocus, untTypesSistema,
  AppEvnts, Menus, Buttons, ExtCtrls, Uni, ComboBoxFocus, StrUtils,
  XMLDoc, XMLIntf, BitBtnLockedIncrem, EditFocus, untFuncoesSimples, MaskEditFocus,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type

  TArquivoCSV = class
  private
    FArquivoCSV: TStringList;
    FNomeArquivo: String;
    function fFormataValor(strValor: String): String;
    function fUltimaLinha: String;
  public
    constructor Create(strNomeArquivo: String = '');
    destructor Destroy; override;

    procedure AddValor(strValor: String);
    procedure NovaLinha;
    procedure SalvarArquivo;
  End;

  TfrmExportacaoSiteMod1 = class(TfrmPai)
    pnlGeral: TPanel;
    gpbData: TGroupBox;
    lblTabela: TLabel;
    lblMarca: TLabel;
    lblInicial: TLabel;
    lblFinal: TLabel;
    lblLinhaGrupo: TLabel;
    lblDescri: TLabel;
    lblRefere: TLabel;
    lblProduto: TLabel;
    lblUnidade: TLabel;
    lblPath: TLabel;
    lblFornecedor: TLabel;
    edtDesGru: TEditFocus;
    edtDescri: TEditFocus;
    edtRefere: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    cmbTabPre: TComboBoxFocus;
    rdgStatus: TRadioGroup;
    rdgEstoque: TRadioGroup;
    pgbProgresso: TProgressBar;
    btnConfirmaDados: TBitBtnLocked;
    shpMultSel: TShape;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodGru: TMaskEditFocus;
    lblProgresso: TLabel;
    fraPatExp: TfraDirectoryEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodGruExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    xmlDoc   : TXMLDocument;
    xmlAtual : IXMLNode;
    strPatXml,
    strIteAti: String;
    arrUni,
    arrIte,
    arrGru,
    arrMar,
    arrFor: TConsultasArray;

    procedure pExportarXML;
    procedure pExportarCSV;
    procedure pExportarTXT;
    procedure pAddFiltros(qry: TUniQuery; blnFiltraEstoque: Boolean = True);
    procedure pExportarXMLMod6;
    procedure pExportXLSMod7;
    procedure pExportarXMLMod8;

    function fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
  protected
    function fXmlGeraArq(Var xmlNo: IXMLNode): Boolean;
    function fXmlGeraDados(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

Const
  SAL_TODOS = 0;
  SAL_POSITIVO = 1;
  SAL_NEGATIVO = 2;
  SAL_ZERO = 3;

implementation

uses untFuncoesConsulta, untConsultas, untExcel, Data.DB, untIFatReservaSaldo,
  untTFatReservaSaldo;

{$R *.dfm}

procedure TfrmExportacaoSiteMod1.btnConfirmaDadosClick(Sender: TObject);
  Var
    qryItens: TUniQuery;
    stlItens: TStringList;
    strModelo: String;
    fltSalDis: Double;
begin
  inherited;

  strModelo := fCfgSis('MOEXSI');

  If Not fVerificaCampos Then
    Exit;

  btnConfirmaDados.Enabled := False;
  btnSair.Enabled := False;
  Try
    Case rdgStatus.ItemIndex Of
      0: strIteAti := '';
      1: strIteAti := 'S';
      2: strIteAti := 'N';
    End;

    If strModelo = '3' Then
      pExportarXML

    Else If strModelo = '4' Then
      pExportarCSV

    Else If strModelo = '5' Then
      pExportarTXT

    Else If strModelo = '6' Then
      pExportarXMLMod6

    Else If strModelo = '7' Then
      pExportXLSMod7

    Else If strModelo = '8' Then
      pExportarXMLMod8

    Else
    Begin
      stlItens := TStringList.Create;

      qryItens := fCriaQuery(Self);
      qryItens.SQL.Add('SELECT ');
      qryItens.SQL.Add('  I.ITE_CODITE, ');
      qryItens.SQL.Add('  IFNULL(D.ITE_DESITE,I.ITE_DESITE) AS ITE_DESITE, ');
      qryItens.SQL.Add('  G.ITE_PREVE' + cmbTabPre.Text + ' AS ITE_PRESIT, ');
      qryItens.SQL.Add('  U.UNI_DESUNI, ');
      qryItens.SQL.Add('  G.ITE_SALDOS, ');
      qryItens.SQL.Add('  M.MAR_DESMAR ');
      qryItens.SQL.Add('FROM ');
      qryItens.SQL.Add('  CADITE I ');
      qryItens.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
      qryItens.SQL.Add('       JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ');
      qryItens.SQL.Add('       JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ');
      qryItens.SQL.Add('  LEFT JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE ');
    
      pAddFiltros(qryItens);
      
      qryItens.Open;

      pgbProgresso.Max := qryItens.RecordCount;
      pgbProgresso.Position := 0;

      While (Not qryItens.Eof) Do
      Begin
        If strModelo = '1' Then
        Begin
          fltSalDis := qryItens.FieldByName('ITE_SALDOS').AsFloat - TSaldoReservado.New(
                                                                      TReservaParametros.New()
                                                                        .EmpresaItem(VS_strCodEmp)
                                                                        .CodigoItem(qryItens.FieldByName('ITE_CODITE').AsString)
                                                                        .CodEmpresa(VS_strCodEmp)
                                                                      ).fGetQuantidade();

          stlItens.Add(qryItens.FieldByName('ITE_CODITE').AsString + '|' +
                       AnsiReplaceText(FloatToStrF(qryItens.FieldByName('ITE_PRESIT').AsFloat, ffNumber, 12, 2), '.', '') + '|' +
                       AnsiReplaceText(FloatToStrF(fltSalDis, ffNumber, 12, 2), '.', ''));
        End
        Else
        Begin
          stlItens.Add(qryItens.FieldByName('ITE_CODITE').AsString + '|' +
                       AnsiReplaceStr(qryItens.FieldByName('ITE_DESITE').AsString,'<<csq>>', '<br>') + '|' +
                       AnsiReplaceText(FloatToStrF(qryItens.FieldByName('ITE_PRESIT').AsFloat, ffNumber, 12, 2), '.', '') + '|' +
                       qryItens.FieldByName('UNI_DESUNI').AsString + '|' +
                       AnsiReplaceText(FloatToStrF(qryItens.FieldByName('ITE_SALDOS').AsFloat, ffNumber, 12, 2), '.', '') + '|' +
                       qryItens.FieldByName('MAR_DESMAR').AsString );
        End;

        qryItens.Next;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
      End;

      stlItens.SaveToFile(fraPatExp.edtDirectory.text + '\produtos.txt');

      FreeAndNil(qryItens);

      FreeAndNil(stlItens);

      fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso! Anote o caminho: ' + #13#10 +
                            fraPatExp.edtDirectory.text + '\produtos.txt', ['&Ok']);
    End;
  Finally
    btnConfirmaDados.Enabled := True;
    btnSair.Enabled := True;
    pgbProgresso.Position := 0;
  End;
end;

procedure TfrmExportacaoSiteMod1.edtCodUniKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, Key, arrUni, False) Then
  Begin
    If fValidaCampos(edtCodUni, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExportacaoSiteMod1.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrIte, False, Nil, 'Consulta de Produto', '1') Then
  Begin
    If fValidaCampos(edtCodIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExportacaoSiteMod1.edtCodGruKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupo(Self, edtCodGru, edtDesGru, Nil, Key, arrGru, False) Then
  Begin
    If fValidaCampos(edtCodGru, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExportacaoSiteMod1.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, nil, Key, arrFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmExportacaoSiteMod1.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  
  If fPesqMarcas(Self, edtCodMar, edtDesMar, nil, Key, arrMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmExportacaoSiteMod1.edtCodUniExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodUni, edtDesUni, arrUni, fRetNomUnidade, nil, 'da Unidade');
end;

procedure TfrmExportacaoSiteMod1.edtCodIteExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrIte, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmExportacaoSiteMod1.edtCodGruExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodGru, edtDesGru, arrGru, fRetNomeLinhaGrupo, Nil, 'do Grupo', 6);
end;

procedure TfrmExportacaoSiteMod1.edtCodForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmExportacaoSiteMod1.edtCodMarExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmExportacaoSiteMod1.pAddFiltros(qry: TUniQuery; blnFiltraEstoque: Boolean = True);
  Var
    strUni, strIte, strGru, strFor, strMar: String;
begin
  qry.SQL.Add('WHERE');
  qry.SQL.Add('  I.ITE_EXPSIT = "S" AND');
  qry.SQL.Add('  G.ITE_CODEMP = :CODEMP');

  // Filtra data de cadastro inicial
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    qry.SQL.Add('  AND I.ITE_DTACAD >= :DTAINI');

  // Filtra data de cadastro final
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    qry.SQL.Add('  AND I.ITE_DTACAD <= :DTAFIN');

  // Filtra status (ativo 'S' ou 'N')
  If Not fEmptyStr(strIteAti) Then
    qry.SQL.Add('  AND I.ITE_ITEATI = :ITEATI');

  // Filtra saldo
  If blnFiltraEstoque Then
  Case rdgEstoque.ItemIndex Of
    SAL_TODOS: ;
    SAL_POSITIVO: qry.SQL.Add('  AND IFNULL(G.ITE_SALDOS, 0) > 0');
    SAL_NEGATIVO: qry.SQL.Add('  AND IFNULL(G.ITE_SALDOS, 0) < 0');
    SAL_ZERO    : qry.SQL.Add('  AND IFNULL(G.ITE_SALDOS, 0) = 0');
  End;

  // Filtra descrição
  If Not fEmptyStr(edtDescri.Text) Then
    qry.SQL.Add('  AND I.ITE_DESITE LIKE :DESITE');

  // Filtra referencia
  If Not fEmptyStr(edtRefere.Text) Then
    qry.SQL.Add('  AND I.ITE_REFERE LIKE :REFERE');

  // Filtra unidade
  If Not fEmptyStr(edtCodUni.Text) Then
    qry.SQL.Add(fStrLocate(edtCodUni, arrUni, 'I.ITE_CODUNI', 'CODUNI'));

  // Filtra produto
  If Not fEmptyStr(edtCodIte.Text) Then
    qry.SQL.Add(fStrLocate(edtCodIte, arrIte, 'I.ITE_CODITE', 'CODITE'));

  // Filtra linha/grupo
  If Not fEmptyStr(edtCodGru.Text) Then
    qry.SQL.Add(fStrLocateLinGru(edtCodGru, arrGru, 'I.ITE_CODGRU', 'CODGRU'));

  // Filtra fornecedor
  If Not fEmptyStr(edtCodFor.Text) Then
    qry.SQL.Add(fStrLocate(edtCodFor, arrFor, 'I.ITE_CODFOR', 'CODFOR'));

  // Filtra marca
  If Not fEmptyStr(edtCodMar.Text) Then
    qry.SQL.Add(fStrLocate(edtCodMar, arrMar, 'I.ITE_CODMAR', 'CODMAR'));

  // Seta empresa
  qry.ParamByName('CODEMP').AsString := VS_strCodEmp;

  // Seta data inicial
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    qry.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);

  // Seta data final
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    qry.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

  // Seta status
  If Not fEmptyStr(strIteAti) Then
    qry.ParamByName('ITEATI').AsString := strIteAti;

  // Seta descrição
  If Not fEmptyStr(edtDescri.Text) Then
    qry.ParamByName('DESITE').AsString := '%' + edtDescri.Text + '%';

  // Seta referencia
  If Not fEmptyStr(edtRefere.Text) Then
    qry.ParamByName('REFERE').AsString := '%' + edtRefere.Text + '%';

  // Seta unidade
  If Not fEmptyStr(edtCodUni.Text) Then
    pSetaParam(edtCodUni.Text, arrUni, strUni, 'CODUNI', qry);

  // Seta produto
  If Not fEmptyStr(edtCodIte.Text) Then
    pSetaParam(edtCodIte.Text, arrIte, strIte, 'CODITE', qry);

  // Seta linha/grupo
  If qry.Params.FindParam('CODGRU') <> nil Then
    pSetaParam(edtCodGru.Text, arrGru, strGru, 'CODGRU', qry);

  // Seta fornecedor
  If Not fEmptyStr(edtCodFor.Text) Then
    pSetaParam(edtCodFor.Text, arrFor, strFor, 'CODFOR', qry);

  // Seta marca
  If Not fEmptyStr(edtCodMar.Text) Then
    pSetaParam(edtCodMar.Text, arrMar, strMar, 'CODMAR', qry);
end;

procedure TfrmExportacaoSiteMod1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  
  If (Key = VK_RETURN) Then
    If (Assigned(ActiveControl)) And (ActiveControl Is TRadioButton) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmExportacaoSiteMod1.FormShow(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  For intContador := 1 To Length(VS_strTabVen) Do
  Begin
    If VS_strTabVen[intContador] = 'S' Then
    Begin
      cmbTabPre.Items.Add(IntToStr(intContador));
    End;
  End;

  cmbTabPre.ItemIndex := 0;

  pSetaCodIte( edtCodIte );

end;

function TfrmExportacaoSiteMod1.fProcurarElemento(ElementoPai: IXMLNode;
  strNome: String): IXMLNode;
begin
  If (ElementoPai = Nil) Then
  Begin
    Result := Nil;
    Exit;
  End;
  If (ElementoPai.LocalName = strNome) Then
  Begin
    Result := ElementoPai;
    Exit;
  End;
  Result := fProcurarElemento(ElementoPai.ChildNodes.First, strNome);
  If (Result <> Nil) Then
  Begin
    Exit;
  End;
  Result := fProcurarElemento(ElementoPai.NextSibling, strNome);
  If (Result <> Nil) Then
  Begin
    Exit;
  End;
  Result := Nil;
end;

function TfrmExportacaoSiteMod1.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    strMsg: String;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
    Exit(False);
  //
  Result := True;

  If (Sender = fraPatExp) Then
  Begin
    If fEmptyStr(fraPatExp.edtDirectory.text) Then
      strMsg := 'Path para Exportação deve ser preenchido!'

    Else If Not DirectoryExists(fraPatExp.edtDirectory.text) Then
    Begin
      If fMensagem('ATENÇÃO!', 'O Path informado não existe, deseja criá-lo?', ['&Sim', '&Não']) = 1 Then
        CreateDir(fraPatExp.edtDirectory.text)
      Else
        Result := False
    End;
  End

  Else If (Sender = cmbTabPre) Then
  Begin
    If cmbTabPre.Items.IndexOf(cmbTabPre.Text) < 0 Then
      strMsg := 'Informe corretamente a tabela de preços!';
  End

  Else If (Sender = mskDtaIni) Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If StrToDateDef(mskDtaIni.Text, 0) = 0 Then
        strMsg := 'Informe corretamente a data de cadastro inicial!'

      // Valida se a data inicial é menor que data final
      Else If (StrToDateDef(mskDtaFin.Text, 0) > 0) And (StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text)) Then
        strMsg := 'Data inicial deve ser menor ou igual a data final!';
    End
  End

  Else If (Sender = mskDtaFin) Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      If StrToDateDef(mskDtaFin.Text, 0) = 0 Then
        strMsg := 'Informe corretamente a data de cadastro final!'

      // Valida se a data inicial é menor que a data final
      Else If (StrToDateDef(mskDtaIni.Text, 0) > 0) And (StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text)) Then
        strMsg := 'Data final deve ser maior ou igual a data inicial!';
    End;
  End

  Else If (Sender = edtCodUni) Then
    if (fTabelaExiste('UNIDADE_TMP')) and (fCampoExiste('UNIDADE_TMP', 'MARDES')) then
      pDesmarcaLista(edtCodUni, arrUni, 'UNIDADE_TMP')

  Else If (Sender = edtCodIte) Then
    if (fTabelaExiste('PRODUTO_TMP')) and (fCampoExiste('PRODUTO_TMP', 'MARDES')) then
      pDesmarcaLista(edtCodIte, arrIte, 'PRODUTO_TMP')

  Else If (Sender = edtCodGru) Then
    if (fTabelaExiste('GRUPO_TMP')) and (fCampoExiste('GRUPO_TMP', 'MARDES')) then
      pDesmarcaLista(edtCodGru, arrGru, 'GRUPO_TMP')

  Else If (Sender = edtCodFor) Then
    if (fTabelaExiste('FORNECEDOR_TMP')) and (fCampoExiste('FORNECEDOR_TMP', 'MARDES')) then
      pDesmarcaLista(edtCodFor, arrFor, 'FORNECEDOR_TMP')

  Else If (Sender = edtCodMar) Then
    if (fTabelaExiste('MARCA_TMP')) and (fCampoExiste('MARCA_TMP', 'MARDES')) then
      pDesmarcaLista(edtCodMar, arrMar, 'MARCA_TMP');

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', strMsg, ['&O k']);
    pSetFocus(Sender);
  End;
end;

function TfrmExportacaoSiteMod1.fXmlGeraArq(var xmlNo: IXMLNode): Boolean;
begin
  xmlDoc.AddChild('products');
  xmlNo  := fProcurarElemento(xmlDoc.Node, 'products');
  Result := True;
end;

function TfrmExportacaoSiteMod1.fXmlGeraDados(var xmlNo: IXMLNode;
  qryDados: TUniQuery): Boolean;
  Var
    xmlSku: IXMLNode;
begin
  xmlNo  := xmlNo.AddChild('item');
  xmlNo.AddChild('name').NodeValue            := AnsiReplaceStr(qryDados.FieldByName('ITE_DESITE').AsString,'<<csq>>', '<br>');
  xmlNo.AddChild('reference').NodeValue       := Copy(UpperCase(qryDados.FieldByName('ITE_REFERE').AsString), 1, 1) +
                                                 Copy(LowerCase(qryDados.FieldByName('ITE_REFERE').AsString), 2, 100);

  xmlSku := xmlNo.AddChild('model');
  xmlSku.Attributes['sku']                    := Copy(UpperCase(qryDados.FieldByName('ITE_DESFAB').AsString), 1, 1) +
                                                 Copy(LowerCase(qryDados.FieldByName('ITE_DESFAB').AsString), 2, 100);
  xmlSku.NodeValue                            := Copy(UpperCase(qryDados.FieldByName('ITE_DESFAB').AsString), 1, 1) +
                                                 Copy(LowerCase(qryDados.FieldByName('ITE_DESFAB').AsString), 2, 100);

  xmlNo.AddChild('category').NodeValue        := 'Início,' +
                                                 Copy(UpperCase(qryDados.FieldByName('GRU_DESGRU').AsString), 1, 1)   +
                                                 Copy(LowerCase(qryDados.FieldByName('GRU_DESGRU').AsString), 2, 100) +
                                                 '| ' +
                                                 Copy(UpperCase(qryDados.FieldByName('ITE_REFERE').AsString), 1, 1)   +
                                                 Copy(LowerCase(qryDados.FieldByName('ITE_REFERE').AsString), 2, 100);

  xmlNo.AddChild('manufacturer').NodeValue    := Copy(UpperCase(qryDados.FieldByName('MAR_DESMAR').AsString), 1, 1) +
                                                 Copy(LowerCase(qryDados.FieldByName('MAR_DESMAR').AsString), 2, 100);

  xmlNo.AddChild('description').NodeValue     := AnsiReplaceStr(qryDados.FieldByName('ITE_DESITE').AsString,'<<csq>>', '<br>');

  //QUEBRA DE LINHA HTML <br>
  xmlNo.AddChild('longdescription').NodeValue := AnsiReplaceStr(qryDados.FieldByName('ITE_APLICA').AsString,'<<csq>>', '<br>');

  FormatSettings.DecimalSeparator := '.';
  xmlNo.AddChild('price').NodeValue           := FormatFloat('0.00', qryDados.FieldByName('ITE_PRECUS').AsFloat);
  xmlNo.AddChild('msrp').NodeValue            := FormatFloat('0.00', qryDados.FieldByName('ITE_PREVEN').AsFloat);
  xmlNo.AddChild('quantity').NodeValue        := FormatFloat('0.00', qryDados.FieldByName('ITE_SALDOS').AsFloat);
  xmlNo.AddChild('weight').NodeValue          := FormatFloat('0.00', qryDados.FieldByName('ITE_PESOIT').AsFloat);
  FormatSettings.DecimalSeparator := ',';

  xmlNo.AddChild('image').NodeValue           := qryDados.FieldByName('ITE_URLIMG').AsString;
  xmlNo  := xmlNo.ParentNode;
  Result := True;
end;

procedure TfrmExportacaoSiteMod1.pExportarCSV;
  Var
    csvArq: TArquivoCSV;
    qryItens: TUniQuery;
Begin
  csvArq := TArquivoCSV.Create(fraPatExp.edtDirectory.text + '\PRODUTOS_'+ FormatDateTime('YYYY-MM-DD', Date) +'.csv');
  qryItens := fCriaQuery;
  Try
    With qryItens.SQL Do
    Begin
      Add('SELECT');
      Add('  I.ITE_CODITE,');
      Add('  I.ITE_DESITE,');
      Add('  M.MAR_DESMAR,');
      Add('  G.ITE_PREVE'+ cmbTabPre.Text +' AS ITE_PREVEN,');
      Add('  I.ITE_PESOIT,');
      Add('  G.ITE_SALDOS,');
      Add('  D.ITE_DESITE AS ITE_DESSIT');
      Add('FROM');
      Add('  CADITE I');
      Add('       JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
      Add('       JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR');
      Add('  LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE');
    End;

    pAddFiltros(qryItens);

    With csvArq Do
    Begin
      NovaLinha;
      AddValor('Produto Tipo');
      AddValor('Código');
      AddValor('Nome');
      AddValor('Marca');
      AddValor('Preço de Venda');
      AddValor('Peso');
      AddValor('Produto no Estoque');
      AddValor('Categoria Detalhes');

      qryItens.Open;

      pgbProgresso.Max := qryItens.RecordCount;
      
      While not qryItens.Eof Do
      Begin
        NovaLinha;
        AddValor('P');
        
        AddValor(qryItens.FieldByName('ITE_CODITE').AsString);
        AddValor(qryItens.FieldByName('ITE_DESITE').AsString);
        AddValor(qryItens.FieldByName('MAR_DESMAR').AsString);
        AddValor('R$ '+ FormatFloat('##,#0.00', qryItens.FieldByName('ITE_PREVEN').AsFloat));
        AddValor(FormatFloat('#0.0000', qryItens.FieldByName('ITE_PESOIT').AsFloat));
        AddValor(qryItens.FieldByName('ITE_SALDOS').AsString);
        AddValor(qryItens.FieldByName('ITE_DESSIT').AsString);

        pgbProgresso.StepBy(1);

        qryItens.Next;
      End;

      SalvarArquivo;
      pgbProgresso.Position := 0;
    End;

  Finally
    FreeAndNil(csvArq);
    FreeAndNil(qryItens);
  End;
end;

procedure TfrmExportacaoSiteMod1.pExportarTXT;
  var
    strLinha,
    strNomArq,
    strPath : String;

    qryArq: TUniQuery;

    stlArq: TStringList;
begin

  strPath   := fraPatExp.edtDirectory.text;
  strNomArq := 'SITE.TXT';
  qryArq    := fCriaQuery(nil);

  qryArq.SQL.Add('SELECT');
  qryArq.SQL.Add('  I.ITE_CODITE AS CODITE,');
  qryArq.SQL.Add('  I.ITE_DESITE AS DESITE,');
  qryArq.SQL.Add('  I.ITE_REFERE AS REFERE,');
  qryArq.SQL.Add('  I.ITE_CODFAB AS CODFAB,');
  qryArq.SQL.Add('  G.ITE_PREVE' + cmbTabPre.Text + ' AS PREVE1,');
  qryArq.SQL.Add('  G.ITE_SALDOS AS SALDOS,');
  qryArq.SQL.Add('  U.UNI_SIGUNI AS SIGUNI');
  qryArq.SQL.Add('FROM');
  qryArq.SQL.Add('  CADITE I');
  qryArq.SQL.Add('  LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
  qryArq.SQL.Add('  LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI');

  pAddFiltros(qryArq);

  qryArq.Open;

  pgbProgresso.Max      := qryArq.RecordCount;
  pgbProgresso.Position := 0;

  stlArq := TStringList.Create();

  With qryArq Do
  Begin

    strLinha := '';

    {*******************}
    {*CARREGA O ARQUIVO*}
    {****************PZ*}
    While Not Eof Do
    Begin

      Application.ProcessMessages;

      strLinha := fPadR(FieldByName('CODITE').AsString, fTamCodIte)  +
                  fPadR(FieldByName('DESITE').AsString, 70) +
                  fPadR(FieldByName('REFERE').AsString, 16) +
                  fPadR(FieldByName('SIGUNI').AsString, 4)  +
                  fPadR(FieldByName('CODFAB').AsString, 25) +
                  AnsiReplaceStr(fPadL(FormatFloat('##0.00',FieldByName('PREVE1').AsFloat), 12),',','.') +
                  AnsiReplaceStr(fPadL(FormatFloat('##0.000',FieldByName('SALDOS').AsFloat), 14),',','.');

      stlArq.Add(strLinha);

      pgbProgresso.Position := pgbProgresso.Position + 1;

      Next;

    End;
    {*****************}
    {*GRAVA O ARQUIVO*}
    {**************PZ*}
    stlArq.SaveToFile(strPath + '\' + strNomArq);
  End;

  FreeAndNil(qryArq);
  FreeAndNil(stlArq);

  fMensagem('','O Arquivo foi gerado com sucesso!',['&O k']);
end;

procedure TfrmExportacaoSiteMod1.pExportarXML;
  Var
    strArqXml: String;
    blnGerou : Boolean;
    qryItens : TUniQuery;
begin
  xmlDoc         := TXMLDocument.Create(Self);
  xmlDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAutoPrefix, doNamespaceDecl];

  strPatXml := fraPatExp.edtDirectory.text;
  strArqXml := strPatXml + '\PRODUTOS_' + Trim(FormatDateTime('ddmmyyyy', Date)) + '.XML';

  xmlDoc.Active   := True;
  xmlDoc.Version  := '1.0';
  xmlDoc.Encoding := 'UTF-8';

  qryItens := fCriaQuery(Self);

  qryItens.SQL.Add('SELECT SQL_NO_CACHE');
  qryItens.SQL.Add('  I.ITE_CODITE,');
  qryItens.SQL.Add('  IFNULL(D.ITE_DESITE,I.ITE_DESITE) AS ITE_DESITE,');
  qryItens.SQL.Add('  IFNULL(D.ITE_URLIMG,"")           AS ITE_URLIMG,');
  qryItens.SQL.Add('  I.ITE_REFERE,');
  qryItens.SQL.Add('  I.ITE_DESFAB,');
  qryItens.SQL.Add('  I.ITE_APLICA,');
  qryItens.SQL.Add('  I.ITE_PESOIT,');
  qryItens.SQL.Add('  M.MAR_DESMAR,');
  qryItens.SQL.Add('  TRIM(L.GRU_DESGRU)       AS GRU_DESGRU,');
  qryItens.SQL.Add('  IFNULL(I.ITE_REFERE, "") AS ITE_REFERE,');
  qryItens.SQL.Add('  G.ITE_PRECUS,');
  qryItens.SQL.Add('  G.ITE_PREVE' + cmbTabPre.Text + ' AS ITE_PREVEN,');
  qryItens.SQL.Add('  G.ITE_SALDOS');
  qryItens.SQL.Add('FROM');
  qryItens.SQL.Add('  CADITE I');
  qryItens.SQL.Add('       JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
  qryItens.SQL.Add('       JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR');
  qryItens.SQL.Add('       JOIN CADGRU L ON L.GRU_CODGRU = I.ITE_CODGRU');
  qryItens.SQL.Add('  LEFT JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE');

  pAddFiltros(qryItens);

  qryItens.Open;

  pgbProgresso.Max      := qryItens.RecordCount;
  pgbProgresso.Position := 0;

  blnGerou := fXmlGeraArq(xmlAtual);
  While (Not qryItens.Eof) Do
  Begin
    fXmlGeraDados(xmlAtual, qryItens);

    qryItens.Next;

    pgbProgresso.StepBy(1);
  End;
  FreeAndNil(qryItens);

  If blnGerou Then
  Begin
    xmlDoc.SaveToFile(strArqXml);
    fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso! Anote o caminho: ' + #13#10 +
                          strArqXml, ['&Ok']);
  End;
end;

procedure TfrmExportacaoSiteMod1.pExportarXMLMod6;
  Var
    qryItens,
    qryPromo: TUniQuery;
    xmlProdutos,
    xmlNode: IXMLNode;
    fltPreVen: Double;
    fltSalDis: Double;
    blnValidouSaldo: Boolean;
    strTipoPreco,
    strFileName: String;
  procedure pSQLExp(qry: TUniQuery);
  begin
    qry.SQL.Add('SELECT SQL_NO_CACHE');
    qry.SQL.Add('  I.ITE_CODITE,');
    qry.SQL.Add('  D.ITE_NOMITE,');
    qry.SQL.Add('  D.ITE_APLITE,');
    qry.SQL.Add('  D.ITE_DESITE,');
    qry.SQL.Add('  G.ITE_PREVE'+ cmbTabPre.Text + ' AS ITE_PREVEN,');
    qry.SQL.Add('  G.ITE_SALDOS,');
    qry.SQL.Add('  I.ITE_PESLIQ,');
    qry.SQL.Add('  I.ITE_DTACAD,');
    qry.SQL.Add('  D.ITE_CODCAT');
    qry.SQL.Add('FROM');
    qry.SQL.Add('  CADITE I');
    qry.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
    qry.SQL.Add('  JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE');
  end;

  procedure pSQLPromo(qry: TUniQuery);
  begin
    qry.SQL.Add('SELECT IPR_CODITE,');
    qry.SQL.Add('       IPR_PREVEN');
    qry.SQL.Add('  FROM CADPRO');
    qry.SQL.Add('  JOIN ITEPRO ON IPR_SEQGER = CADPRO.AUTOINCREM');
    qry.SQL.Add('  JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM');
    qry.SQL.Add(' WHERE PRO_DTAINI <= :DTA');
    qry.SQL.Add('   AND PRO_DTAFIN >= :DTA');
    qry.SQL.Add('   AND PROEMP.PRO_CODEMP = :CODEMP');
    qry.ParamByName('DTA').AsDateTime := VS_Date;
    qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
  end;
begin
  // Utilizando Self como Owner, faz o xmlDoc se comportar como objeto invés de interface. Assim, temos certeza que será liberado da memória.
  xmlDoc := TXMLDocument.Create(Self);
  qryItens := fCriaQuery;
  qryPromo := fCriaQuery;
  Try
    xmlDoc.Options  := [doNodeAutoCreate, doNodeAutoIndent, doAutoPrefix, doNamespaceDecl];
    xmlDoc.Active   := True;
    xmlDoc.Version  := '1.0';
    xmlDoc.Encoding := 'iso-8859-1';

    pSQLExp(qryItens);
    pAddFiltros(qryItens, False);

    qryItens.Open;

    If qryItens.IsEmpty Then
    Begin
      pMensagemOk('Nenhum item encontrado!');
      Exit;
    End;
    blnValidouSaldo := False;
    pSQLPromo(qryPromo);
    qryPromo.Open;

    xmlProdutos := xmlDoc.AddChild('produtos');
    lblProgresso.Caption := '';

    pgbProgresso.Position := 0;
    pgbProgresso.Max := qryItens.RecordCount;
    While Not qryItens.Eof Do
    Begin
      lblProgresso.Caption := 'Processando Registro ' + IntToStr(qryItens.RecNo) + '/' + IntToStr(qryItens.RecordCount);
      Application.ProcessMessages;
      fltPreVen := qryItens.FieldByName('ITE_PREVEN').AsFloat;
      strTipoPreco := 'Varejo';

      If qryPromo.Locate('IPR_CODITE', qryItens.FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        fltPreVen := qryPromo.FieldByName('IPR_PREVEN').AsFloat;
        strTipoPreco := 'Promoção';
      End;

      fltSalDis := qryItens.FieldByName('ITE_SALDOS').AsFloat - TSaldoReservado.New(
                                                                  TReservaParametros.New()
                                                                    .EmpresaItem(VS_strCodEmp)
                                                                    .CodigoItem(qryItens.FieldByName('ITE_CODITE').AsString)
                                                                    .CodEmpresa(VS_strCodEmp)
                                                                  ).fGetQuantidade();

      // Filtra saldo
      Case rdgEstoque.ItemIndex Of
        SAL_TODOS   : blnValidouSaldo := True;
        SAL_POSITIVO: blnValidouSaldo := fltSalDis > 0;
        SAL_NEGATIVO: blnValidouSaldo := fltSalDis < 0;
        SAL_ZERO    : blnValidouSaldo := fltSalDis = 0;
      End;

      If Not blnValidouSaldo Then
      Begin
        qryItens.Next;
        pgbProgresso.StepBy(1);
        Continue;
      End;

      xmlNode := xmlProdutos.AddChild('produto');
      xmlNode.AddChild('cod_sistema').NodeValue   := qryItens.FieldByName('ITE_CODITE').AsString;
      xmlNode.AddChild('nome').NodeValue          := qryItens.FieldByName('ITE_NOMITE').AsString;
      xmlNode.AddChild('resumo').NodeValue        := qryItens.FieldByName('ITE_APLITE').AsString;
      xmlNode.AddChild('descricao').NodeValue     := qryItens.FieldByName('ITE_DESITE').AsString;
      xmlNode.AddChild('valor_venda').NodeValue   := FormatFloat('0.00', fltPreVen);
      xmlNode.AddChild('tipo_preco').NodeValue    := strTipoPreco;
      xmlNode.AddChild('qtd_estoque').NodeValue   := FormatFloat('0.00', fltSalDis);
      xmlNode.AddChild('peso_liquido').NodeValue  := FormatFloat('0.00', qryItens.FieldByName('ITE_PESLIQ').AsFloat);
      xmlNode.AddChild('data_cadastro').NodeValue := FormatDateTime('dd-mm-yyyy', qryItens.FieldByName('ITE_DTACAD').AsDateTime) + ' 00:00:00';
      xmlNode.AddChild('id_categoria').NodeValue  := qryItens.FieldByName('ITE_CODCAT').AsString;

      qryItens.Next;
      pgbProgresso.StepBy(1);
    End;

    pgbProgresso.Position := 0;

    strFileName := fraPatExp.edtDirectory.text + '\PRODUTOS_' + Trim(FormatDateTime('ddmmyyyy', VS_Date)) + '.XML';
    xmlDoc.SaveToFile(strFileName);

    pMensagemOK('Arquivo salvo em: '+ strFileName);
  Finally
    xmlDoc.Free;
    qryItens.Free;
    qryPromo.Free;
    lblProgresso.Caption := '';    
  End;
end;

procedure TfrmExportacaoSiteMod1.pExportarXMLMod8;
var
  qryItens,
  qryPromo        : TUniQuery;
  xmlProdutos,
  xmlNode         : IXMLNode;
  fltPreVen       : Double;
  fltSalDis       : Double;
  blnValidouSaldo : Boolean;
  strTipoPreco,
  strFileName     : String;

  procedure pSQLExp(qry: TUniQuery);
  begin
    qry.SQL.Add('SELECT SQL_NO_CACHE');
    qry.SQL.Add('  I.ITE_CODITE,');
    qry.SQL.Add('  D.ITE_NOMITE,');
    qry.SQL.Add('  D.ITE_APLITE,');
    qry.SQL.Add('  D.ITE_DESITE,');
    qry.SQL.Add('  G.ITE_PREVE'+ cmbTabPre.Text + ' AS ITE_PREVEN,');
    qry.SQL.Add('  G.ITE_SALDOS,');
    qry.SQL.Add('  I.ITE_PESLIQ,');
    qry.SQL.Add('  I.ITE_DTACAD,');
    qry.SQL.Add('  D.ITE_CODCAT,');
    qry.SQL.Add('  IFNULL(F.FOR_NOMFAN, F.FOR_NOMFOR) AS FOR_NOMFAN, ');
    qry.SQL.Add('  M.MAR_DESMAR,');
    qry.SQL.Add('  (SELECT ');
    qry.SQL.Add('     GRU_DESGRU ');
    qry.SQL.Add('   FROM CADGRU ');
    qry.SQL.Add('   WHERE GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"000")) AS ITE_DESLIN, ');
    qry.SQL.Add('  (SELECT ');
    qry.SQL.Add('     GRU_DESGRU ');
    qry.SQL.Add('   FROM CADGRU ');
    qry.SQL.Add('   WHERE GRU_CODGRU = I.ITE_CODGRU) AS ITE_DESGRU ');
    qry.SQL.Add(' FROM CADITE I ');
    qry.SQL.Add('   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
    qry.SQL.Add('   JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE ');
    qry.SQL.Add('   JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ');
    qry.SQL.Add('   JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ');
  end;

  procedure pSQLPromo(qry: TUniQuery);
  begin
    qry.SQL.Add('SELECT IPR_CODITE,');
    qry.SQL.Add('       IPR_PREVEN');
    qry.SQL.Add('  FROM CADPRO');
    qry.SQL.Add('  JOIN ITEPRO ON IPR_SEQGER = CADPRO.AUTOINCREM');
    qry.SQL.Add('  JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM');
    qry.SQL.Add(' WHERE PRO_DTAINI <= :DTA');
    qry.SQL.Add('   AND PRO_DTAFIN >= :DTA');
    qry.SQL.Add('   AND PROEMP.PRO_CODEMP = :CODEMP');
    qry.ParamByName('DTA').AsDateTime := VS_Date;
    qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
  end;
begin
  // Utilizando Self como Owner, faz o xmlDoc se comportar como objeto invés de interface. Assim, temos certeza que será liberado da memória.
  xmlDoc   := TXMLDocument.Create(Self);
  qryItens := fCriaQuery;
  qryPromo := fCriaQuery;
  Try
    xmlDoc.Options  := [doNodeAutoCreate, doNodeAutoIndent, doAutoPrefix, doNamespaceDecl];
    xmlDoc.Active   := True;
    xmlDoc.Version  := '1.0';
    xmlDoc.Encoding := 'iso-8859-1';

    pSQLExp(qryItens);
    pAddFiltros(qryItens, False);

    qryItens.Open;

    If qryItens.IsEmpty Then
    Begin
      pMensagemOk('Nenhum item encontrado!');
      Exit;
    End;

    blnValidouSaldo := false;

    pSQLPromo(qryPromo);
    qryPromo.Open;

    xmlProdutos := xmlDoc.AddChild('produtos');
    lblProgresso.Caption := '';

    pgbProgresso.Position := 0;
    pgbProgresso.Max := qryItens.RecordCount;
    While Not qryItens.Eof Do
    Begin
      lblProgresso.Caption := 'Processando Registro ' + IntToStr(qryItens.RecNo) + '/' + IntToStr(qryItens.RecordCount);
      Application.ProcessMessages;
      fltPreVen    := qryItens.FieldByName('ITE_PREVEN').AsFloat;
      strTipoPreco := 'Varejo';

      If qryPromo.Locate('IPR_CODITE', qryItens.FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        fltPreVen    := qryPromo.FieldByName('IPR_PREVEN').AsFloat;
        strTipoPreco := 'Promoção';
      End;

      fltSalDis := qryItens.FieldByName('ITE_SALDOS').AsFloat - TSaldoReservado.New(
                                                                  TReservaParametros.New()
                                                                    .EmpresaItem(VS_strCodEmp)
                                                                    .CodigoItem(qryItens.FieldByName('ITE_CODITE').AsString)
                                                                    .CodEmpresa(VS_strCodEmp)
                                                                  ).fGetQuantidade();

      // Filtra saldo
      Case rdgEstoque.ItemIndex Of
        SAL_TODOS    : blnValidouSaldo := True;
        SAL_POSITIVO : blnValidouSaldo := fltSalDis > 0;
        SAL_NEGATIVO : blnValidouSaldo := fltSalDis < 0;
        SAL_ZERO     : blnValidouSaldo := fltSalDis = 0;
      End;

      If Not blnValidouSaldo Then
      Begin
        qryItens.Next;
        pgbProgresso.StepBy(1);
        Continue;
      End;

      xmlNode := xmlProdutos.AddChild('produto');
      xmlNode.AddChild('cod_sistema').NodeValue   := qryItens.FieldByName('ITE_CODITE').AsString;
      xmlNode.AddChild('nome').NodeValue          := qryItens.FieldByName('ITE_NOMITE').AsString;
      xmlNode.AddChild('resumo').NodeValue        := qryItens.FieldByName('ITE_APLITE').AsString;
      xmlNode.AddChild('descricao').NodeValue     := qryItens.FieldByName('ITE_DESITE').AsString;
      xmlNode.AddChild('valor_venda').NodeValue   := FormatFloat('0.00', fltPreVen);
      xmlNode.AddChild('tipo_preco').NodeValue    := strTipoPreco;
      xmlNode.AddChild('qtd_estoque').NodeValue   := FormatFloat('0.00', fltSalDis);
      xmlNode.AddChild('peso_liquido').NodeValue  := FormatFloat('0.00', qryItens.FieldByName('ITE_PESLIQ').AsFloat);
      xmlNode.AddChild('data_cadastro').NodeValue := FormatDateTime('dd-mm-yyyy', qryItens.FieldByName('ITE_DTACAD').AsDateTime) + ' 00:00:00';
      xmlNode.AddChild('id_categoria').NodeValue  := qryItens.FieldByName('ITE_CODCAT').AsString;
      xmlNode.AddChild('fabricante').NodeValue    := qryItens.FieldByName('FOR_NOMFAN').AsString;
      xmlNode.AddChild('marca').NodeValue         := qryItens.FieldByName('MAR_DESMAR').AsString;
      xmlNode.AddChild('linha').NodeValue         := qryItens.FieldByName('ITE_DESLIN').AsString;
      xmlNode.AddChild('grupo').NodeValue         := qryItens.FieldByName('ITE_DESGRU').AsString;

      qryItens.Next;
      pgbProgresso.StepBy(1);
    End;

    pgbProgresso.Position := 0;

    strFileName := fraPatExp.edtDirectory.text + '\PRODUTOS_' + Trim(FormatDateTime('ddmmyyyy', VS_Date)) + '.XML';
    xmlDoc.SaveToFile(strFileName);

    pMensagemOK('Arquivo salvo em: '+ strFileName);
  Finally
    xmlDoc.Free;
    qryItens.Free;
    qryPromo.Free;
    lblProgresso.Caption := '';
  End;
end;

procedure TfrmExportacaoSiteMod1.pExportXLSMod7;
  Var
    objExcel: TExcel;
    qryIte: TUniQuery;
    intLinha: Integer;
    function fLinhaAtual: Integer;
    begin
      Result := intLinha;
    end;

    function fProximaLinha: Integer;
    begin
      Inc(intLinha);
      Result := intLinha;
    end;

    procedure pSetProgress(intEtapa, intPos, intMax: Integer);
      Const
        QTD_ETAPA = 3;
    begin
      pgbProgresso.Max := QTD_ETAPA * 100;

      pgbProgresso.Position := Round((intEtapa - 1) * 100 + ((intPos / intMax) * 100));
    end;

    function fGetCampos(arrColunas, arrCampos: Array Of String): String;
      Var
        strVal: String;
    begin
      Result := '';
      For strVal In arrColunas Do
        Result := Result + '     ' + IIF(strVal = arrColunas[0], '', ', ') + ReplaceStr(arrCampos[IndexStr(strVal, arrColunas)], '_TABPRE_', cmbTabPre.Text) + ' AS '+ QuotedStr(strVal) + #13#10;
    end;

    procedure pEscrevePlanilha(qry: TUniQuery; intPlanilha: Integer; arrColunas: Array Of String);
      Var
        strVal    : String;
        fltSalRes,
        fltSalReG,
        fltSalDis : Double;
    begin
      intLinha := 1;

      While Not qry.Eof Do
      Begin
        pSetProgress(intPlanilha, qry.RecNo, qry.RecordCount);

        If qry.Bof Then
          For strVal In arrColunas Do
            objExcel.Escrever(fLinhaAtual, IndexStr(strVal, arrColunas)+1, strVal);

        fProximaLinha;

        For strVal In arrColunas Do
        Begin

          If Pos(strVal, 'model-category_id-parent_id-categories') > 0 Then
            objExcel.Escrever(fLinhaAtual, IndexStr(strVal, arrColunas)+1, '''' + qry.FieldByName(strVal).AsString)
          Else
          Begin
            If Pos(strVal, 'quantity') > 0 Then
            Begin
              fltSalRes := TSaldoReservado.New(
                             TReservaParametros.New()
                              .EmpresaItem(VS_strCodEmp)
                              .CodigoItem(qry.FieldByName('product_id').AsString)
                              .CodEmpresa(VS_strCodEmp)
                              .TipoReserva(trsPedidoVenda)
                             ).fGetQuantidade();

              fltSalReG := TSaldoReservado.New(
                             TReservaParametros.New()
                              .EmpresaItem(VS_strCodEmp)
                              .CodigoItem(qry.FieldByName('product_id').AsString)
                              .CodEmpresa(VS_strCodEmp)
                              .TipoReserva(trsGarantia)
                             ).fGetQuantidade();
              fltSalDis := qry.FieldByName(strVal).AsFloat - fltSalRes - fltSalReG;

              objExcel.Escrever(fLinhaAtual, IndexStr(strVal, arrColunas)+1, FormatFloat('#,##0.00', fltSalDis));
            End
            Else
            Begin
              objExcel.Escrever(fLinhaAtual, IndexStr(strVal, arrColunas)+1, qry.FieldByName(strVal).AsString);
            End;
          End;
        End;

        qry.Next;
      End;
    end;

  Const
    arrColunasP1: Array[0..4] Of String = ('category_id',
                                           'parent_id',
                                           'name',
                                           'top',
                                           'status enabled');


    arrCamposP1: Array[0..4] Of String =  ('DEP_CODIGO',
                                           'DEP_CODIGO',
                                           'DEP_DESCRI',
                                           '""',
                                           '"S"');

    arrColunasP2: Array[0..16] Of String = ('product_id',
                                            'name',
                                            'categories',
                                            'quantity',
                                            'model',
                                            'manufacturer',
                                            'image_name',
                                            'requires shipping',
                                            'price',
                                            'weight',
                                            'unit',
                                            'length',
                                            'width',
                                            'height',
                                            'length unit',
                                            'status enable',
                                            'decription');

    arrCamposP2: Array[0..16] Of String =  ('I.ITE_CODITE',
                                            'REPLACE(D.ITE_DESITE, "<BR>", " ")',
                                            'I.ITE_CODDEP',
                                            'G.ITE_SALDOS',
                                            'I.ITE_REFERE',
                                            'MAR_DESMAR',
                                            'D.ITE_URLIMG',
                                            '""',
                                            'FORMAT(G.ITE_PREVE_TABPRE_, 2)',
                                            'FORMAT(I.ITE_PESOIT, 3)',
                                            'U.UNI_SIGUNI',
                                            'FORMAT(IFNULL(D.ITE_EXPPRO, 0), 3)',
                                            'FORMAT(IFNULL(D.ITE_EXPLAR, 0), 3)',
                                            'FORMAT(IFNULL(D.ITE_EXPALT, 0), 3)',
                                            'U.UNI_SIGUNI',
                                            'I.ITE_ITEATI',
                                            'D.ITE_APLITE');

    arrColunasP3: Array[0..1] Of String = ('product_id',
                                           'price');

    arrCamposP3: Array[0..1] Of String =  ('I.ITE_CODITE',
                                           'FORMAT(IFNULL(D.ITE_DESSIT, 0), 3)');

begin
  objExcel := TExcel.fCriarExcel(Nil);
  qryIte := fCriaQuery;
  pSetProgress(1, 0, 1);
  Try
    objExcel.CriarArquivo(fraPatExp.edtDirectory.text + '\exp_' + FormatDateTime('yyyymmdd', VS_Date) + '.xls');
      
    intLinha := 1;
    objExcel.SetaNomePlanilha(1, 'Categories');

    // Planilha 1
    qryIte.SQL.Add('SELECT DISTINCT');
    qryIte.SQL.Add(fGetCampos(arrColunasP1, arrCamposP1));
    qryIte.SQL.Add('  FROM ITEGER G');
    qryIte.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    qryIte.SQL.Add('  JOIN CADDEP   ON   DEP_CODIGO = I.ITE_CODDEP ');
    pAddFiltros(qryIte);
    qryIte.SQL.Add('');
    qryIte.Open;

    pEscrevePlanilha(qryIte, 1, arrColunasP1);

    // Planilha 2
    objExcel.AdicionaPlanilha;
    objExcel.SheetIndex := 2;
    objExcel.SetaNomePlanilha(2, 'Products');
    qryIte.Close;
    qryIte.SQL.Clear;
    qryIte.SQL.Add('SELECT');
    qryIte.SQL.Add(fGetCampos(arrColunasP2, arrCamposP2));
    qryIte.SQL.Add('  FROM ITEGER G');
    qryIte.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    qryIte.SQL.Add('  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI');
    qryIte.SQL.Add('  JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE');
    qryIte.SQL.Add('  JOIN CADMAR   ON I.ITE_CODMAR =   MAR_CODMAR ');
    pAddFiltros(qryIte);
    qryIte.Open;

    pEscrevePlanilha(qryIte, 2, arrColunasP2);

    // Planilha 3
    objExcel.AdicionaPlanilha;
    objExcel.SheetIndex := 3;
    objExcel.SetaNomePlanilha(3, 'Specials');
    qryIte.Close;
    qryIte.SQL.Clear;
    qryIte.SQL.Add('SELECT');
    qryIte.SQL.Add(fGetCampos(arrColunasP3, arrCamposP3));
    qryIte.SQL.Add('  FROM ITEGER G');
    qryIte.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    qryIte.SQL.Add('  JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE ');
    pAddFiltros(qryIte);
    qryIte.Open;

    pEscrevePlanilha(qryIte, 3, arrColunasP3);

    objExcel.SalvarArquivo;

    pMensagemOK('Gravação efetuada com sucesso! ['+objExcel.NomeArquivo+']');
  Finally
    pSetProgress(1, 0, 1);
    objExcel.FecharArquivo;
    objExcel.Free;
    qryIte.Free;
  End;
end;

{ TArquivoCSV }

procedure TArquivoCSV.AddValor(strValor: String);
Begin
  FArquivoCSV[FArquivoCSV.Count -1] := FArquivoCSV[FArquivoCSV.Count -1] + fFormataValor(strValor);
end;

constructor TArquivoCSV.Create(strNomeArquivo: String);
var svdCSV: TSaveDialog;
Begin
  If strNomeArquivo = '' Then
  Begin
    svdCSV := TSaveDialog.Create(Nil);
    svdCSV.Filter := 'Texto separado por vírgula|*.csv';
    svdCSV.DefaultExt := 'csv';
    Try
      If svdCSV.Execute Then
         strNomeArquivo := svdCSV.FileName
    Finally
       svdCSV.Free;
    End;
  End;

  FNomeArquivo := strNomeArquivo;
  FArquivoCSV := TStringList.Create;
end;

destructor TArquivoCSV.Destroy;
begin
  FArquivoCSV.Free;
  inherited;
end;

function TArquivoCSV.fFormataValor(strValor: String): String;
Begin
  Result := strValor;
  
  If (Pos(' ', strValor) > 0) or (Pos(',', strValor) > 0) Then
     Result := '"' + Result + '"';
     
  If fUltimaLinha <> '' Then
    Result := ',' + Result;
end;

function TArquivoCSV.fUltimaLinha: String;
begin
  Result := FArquivoCSV[FArquivoCSV.Count -1];
end;

procedure TArquivoCSV.NovaLinha;
begin
  FArquivoCSV.Add('');
End;

procedure TArquivoCSV.SalvarArquivo;
begin
  If FNomeArquivo <> '' Then
  Begin
    FArquivoCSV.SaveToFile(FNomeArquivo);
    fMensagem('', 'Arquivo "'+ FNomeArquivo +'" salvo com sucesso!', ['&O k']);
  End
  Else
    fMensagem('', 'Falha ao salvar arquivo, nenhum arquivo selecionado!', ['&O k']);
end;

end.
