unit untRelEstKardexFiscal;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, Uni,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts, untCadLote,
  ComCtrls, untGeraExcel, untExcel, UniClientDataSet, DB, BitBtnLockedIncrem,
  untTypesSistema, frxExportCSVTestabilidade, untFuncoesConsulta, ComboBoxFocus;

type
  TfrmRelEstKardexFiscal = class(TfrmPaiRelatorio)
    pnlTopo: TPanel;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    pnlGeral: TPanel;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    Label6: TLabel;
    edtDesProduto: TEditFocus;
    Label11: TLabel;
    edtDesMarca: TEditFocus;
    Label1: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    edtOpcao: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    pgbProgresso: TProgressBar;
    ColorLabel5: TColorLabel;
    shpLibPre: TShape;
    frxRelatorioJ: TfrxReport;
    frxRelatorioM: TfrxReport;
    cbbComCus: TComboBoxFocus;
    lblComCus: TLabel;
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaProduto(Var qryCadIte: TUniQuery);
    procedure edtProdutosEnter(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtEmpresaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function frxRelatorioMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    blnLibPre: Boolean;

    arrLinhaProdu: TConsultasArray;

    objCadLot: TCadLot;

    fltCnvMl: Double; // Fator Tintométrico.
    fltSaldoIni: Double;
    fltSaldoRea: Double;

    qryRelatorio: TUniQuery;

    Function fSQLCampos: String;
    Function fSQLWhere: String;
    function fRetMarcaItem(strCodIte: String): String;

    procedure pAbreConsulta(qryRelatorio: TUniQuery; strSQL: String);
    procedure pMostraLote;
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
//    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pImprimeFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: Array Of String);
    procedure pCriaQryRelatorio;

    {********************************************}
    {* FUNÇÕES PARA IMPRESSÃO DO RELATÓIRO FAST *}
    {*****************************************JU*}
    function fImprimeClienteFornecedor(strTip_FC, strCodigo, strNumDoc, strEspDoc, strCodEmp: String): String;
    function fVerificaDocumentoAlterado(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie_, strTip_FC, strClaFis: String): String;
    function fVerificaFatorQuantidadeItem(fltQtdIte, fltCnvML: Double; strEspOri, strCancel: String): String;
    function fVerificaFatorValorUnitario(blnComIpi: Boolean; fltUnitar, fltValIpi, fltCnvML: Double): String;
    function fVerificaCustoItem(fltCusto, fltCnvML: Double): String;
    function fFormataQuantidadeTotal(fltQtdIte: Double): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    fltSaldo    : Double;
    fltQtdIteSai: Double;
    fltQtdIteEnt: Double;
  end;

implementation

uses untfuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmRelEstKardexFiscal.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
Begin
  If Not (fEmptyStr(edtEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmRelEstKardexFiscal.edtProdutosExit(Sender: TObject);
begin
  inherited;

  If btnSair.Focused Then
    Exit;

  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrLinhaProdu,nil,fRetNomProduto,'do Produto');


end;

procedure TfrmRelEstKardexFiscal.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrLinhaProdu, True, nil, 'Consulta de Itens', '1') Then
    Self.SelectNext(ActiveControl, True, True);

end;

function TfrmRelEstKardexFiscal.fFormataQuantidadeTotal(fltQtdIte: Double): String;
  var
    intQtdDec : Integer;
begin
  intQtdDec := IIF(fltCnvMl > 1, 4, fCfgSis('DECQTD',varInteger));
  Result := FloatToStrF(fltQtdIte, ffFixed, 15, intQtdDec);
end;

function TfrmRelEstKardexFiscal.fImprimeClienteFornecedor(strTip_FC, strCodigo, strNumDoc, strEspDoc, strCodEmp: String): String;
begin
  If strTip_FC = 'C' Then
  Begin
    Result := strCodigo + '-' +
            IIF(fClienteConsumidor(fRetNomCliente(strCodigo)),
                fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp),
                fRetNomCliente(strCodigo));
  End
  Else
  Begin
    Result := strCodigo + '-' +
              fRetNomFornecedor(strCodigo);
  End;
end;

procedure TfrmRelEstKardexFiscal.pCarregaProduto(Var qryCadIte: TUniQuery);
Begin

  If Not (fEmptyStr(edtProdutos.Text)) Then
  Begin
    edtDesProduto.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
    edtDesMarca.Text   := fRetMarcaItem(edtProdutos.Text);
  End
  Else
  Begin
    edtDesProduto.Clear;
    edtDesMarca.Clear;
  End;


End;

procedure TfrmRelEstKardexFiscal.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstKardexFiscal.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    cdsDados: TUniClientDataSet;
    fltQtdEnt: Double;
    fltQtdSai: Double;
begin
  cdsDados := fCriaClientDatset(qryDados);

  fltSaldo := fltSaldoIni;

  With cdsDados Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      cdsDados.FieldByName('DTAHOR').AsString := FormatDateTime('dd/mm/yy', FieldByName('DTAENT').AsDateTime) + ' ' +
                                        FormatDateTime('hh:mm',    FieldByName('HORENT').AsDateTime);

      If (FieldByName('TIP_FC').AsString = 'C') Then
      Begin
        cdsDados.FieldByName('NOMCLI').AsString := FieldByName('CODCLI').AsString + '-' +
                                                   fRetNomCliente(FieldByName('CODCLI').AsString);
      End
      Else
      Begin
        cdsDados.FieldByName('NOMCLI').AsString := FieldByName('CODFOR').AsString + '-' +
                                                   fRetNomFornecedor(FieldByName('CODFOR').AsString);
      End;
      {****************}
      {* QTD. ENTRADA *}
      {*************RV*}
      If (FieldByName('CLAFIS').AsInteger >= 5) Then
      Begin
        FieldByName('QTDENT').AsString := '0,00';
      End
      Else
      Begin
        fltQtdEnt := FieldByName('QTDITE').AsFloat;
        If (FieldByName('ESPORI').AsString <> 'ML') And (fltCnvMl > 1) Then
        Begin
          fltQtdEnt := fltQtdEnt * fltCnvMl;
        End;

        If (FieldByName('CANCEL').AsString <> 'S')  Then
        Begin
          fltSaldo     := fltSaldo + (fltQtdEnt);
          fltQtdIteEnt := fltQtdIteEnt + (fltQtdEnt);
        End;

        FieldByName('QTDENT').AsFloat := fltQtdEnt;
      End;
      {****************}
      {* QTD. SAÍDA   *}
      {*************RV*}
      If (FieldByName('CLAFIS').AsInteger < 5) Then
      Begin
        FieldByName('QTDSAI').AsFloat := 0;
      End
      Else
      Begin
        fltQtdSai := FieldByName('QTDITE').AsFloat;
        If (FieldByName('ESPORI').AsString <> 'ML') And (fltCnvMl > 1) Then
        Begin
          fltQtdSai := fltQtdSai * fltCnvMl;
        End;

        If (FieldByName('CANCEL').AsString <> 'S')  Then
        Begin
          fltSaldo     := fltSaldo - fltQtdSai;
          fltQtdIteSai := fltQtdIteSai + fltQtdSai;
        End;

        FieldByName('QTDSAI').AsFloat := fltQtdSai;
      End;
      If (FieldByName('QTDENT').AsFloat > 0) Then
      Begin
        {**********************}
        {* VLR. UNIT. ENTRADA *}
        {*******************RV*}
        If (FieldByName('CLAFIS').AsInteger >= 5) Then
        Begin
          FieldByName('UNIENT').AsFloat := 0.0000;
          FieldByName('CUSENT').AsFloat := 0.0000;
        End
        Else If (edtOpcao.Text = '2') Then
        Begin
          FieldByName('UNIENT').AsFloat := fFormataFloat(FieldByName('UNITAR').asFloat + FieldByName('VALIPIENT').asFloat, 4);
        End;
        If (fltCnvMl <> 0) Then
        Begin
          FieldByName('UNIENT').AsFloat := fFormataFloat(FieldByName('UNITAR').asFloat / fltCnvMl, 4);
          FieldByName('CUSENT').AsFloat := fFormataFloat(FieldByName('TOTCUS').asFloat / fltCnvMl, 2);
        End
        Else
        Begin
          FieldByName('UNIENT').AsFloat := 0.0000;
          FieldByName('CUSENT').AsFloat := 0.0000;
        End;
      End
      Else
      Begin
        {**********************}
        {* VLR. UNIT. SAÍDA   *}
        {*******************RV*}
        If (FieldByName('CLAFIS').AsInteger < 5) Then
        Begin
          FieldByName('UNISAI').AsFloat := 0.0000;
          FieldByName('CUSSAI').AsFloat := 0.0000;
        End
        Else If (edtOpcao.Text = '2') Then
        Begin
          FieldByName('UNISAI').AsFloat := fFormataFloat(FieldByName('UNITAR').asFloat + FieldByName('VALIPISAI').asFloat, 4);
        End;
        If (fltCnvMl <> 0) Then
        Begin
          FieldByName('UNISAI').AsFloat := fFormataFloat(FieldByName('UNITAR').asFloat / fltCnvMl, 4);
          FieldByName('CUSSAI').AsFloat := fFormataFloat(FieldByName('TOTCUS').asFloat / fltCnvMl, 2);
        End
        Else
        Begin
          FieldByName('UNISAI').AsFloat := 0.0000;
          FieldByName('CUSSAI').AsFloat := 0.0000;
        End;
      End;

      FieldByName('SALDO').AsFloat := fFormataFloat(fltSaldo, 3);

      Post;
      Next;
    End;
    First;
  End;

  objGeraExcel := TGeraExcel.Create(cdsDados, pgbProgresso);

  objGeraExcel.AddFiltro('LOTE: ' + IIF(fEmptyStr(edtNumLot.Text), 'TODOS', edtNumLot.Text));
  If edtOpcao.Text = '3' Then
    objGeraExcel.AddFiltro('CUSTO SOBRE: ' + cbbComCus.Text);
  objGeraExcel.AddCampo( 'NUMDOC', 'DOCUMENTO');
  objGeraExcel.AddCampo( 'ESPDOC', 'TP');
  objGeraExcel.AddCampo( 'CODEMP', 'EMP');
  objGeraExcel.AddCampo( 'DTAHOR', 'DATA/HORA');
  objGeraExcel.AddCampo( 'NOMCLI', 'CODIGO-NOME DO CLIENTE/FORNEC.');
  objGeraExcel.AddCampo( 'CODOPE', 'OPE.');
  objGeraExcel.AddCampo( 'CFOP', 'CFOP');
  objGeraExcel.AddCampo( 'QTDENT', 'QTDE');

  If blnLibPre Then
  Begin
    If Pos(edtOpcao.Text,'34') > 0 Then
    Begin
      objGeraExcel.AddCampo( 'CUSENT', 'CUSTO');
    End;
    objGeraExcel.AddCampo( 'UNIENT', 'VALOR UNIT');
  End;

  objGeraExcel.AddCampo( 'QTDSAI', 'QTDE');

  If blnLibPre Then
  Begin
    If Pos(edtOpcao.Text,'34') > 0 Then
    Begin
      objGeraExcel.AddCampo( 'CUSSAI', 'CUSTO');
    End;
    objGeraExcel.AddCampo( 'UNISAI', 'VALOR UNIT');
  End;

//  objGeraExcel.AddCampo( 'SALDO', '');

  objGeraExcel.AddTotais('QTDENT');
  objGeraExcel.AddTotais('QTDSAI');
//  objGeraExcel.AddTotais('SALDO');

  objGeraExcel.AddFiltro('PERIODO: DE '        + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));

  objGeraExcel.strNomRel := 'RELATORIO DE FICHA KARDEX FISCAL DE PRODUTOS ';

  objGeraExcel.OnMontaResumo := pMontaResumo;
  objGeraExcel.OnSomaResumo  := pSomaTotais;
//  objGeraExcel.OnImpDetalhes := pImprimeDetalhes;
  objGeraExcel.OnImpFiltros  := pImprimeFiltros;

  objGeraExcel.strMsgRod := '(**) TRANSFERENCIA DE MERCADORIAS';  

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);
  FreeAndNil(cdsDados);
end;

(*procedure TfrmRelEstKardexFiscal.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos);
begin
  With Excel Do
  Begin
    ProximaLinha;
    Escrever(LinhaAtual, 1, 'ITEM: ' + qryRelatorio.FieldByName('CODGRU').AsString + '.' + edtProdutos.Text + ' - ' + edtDesProduto.Text);
    Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Bordas ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    If Dados.RecNo Mod 2 = 0 Then
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Cinza);
  End;

end;*)

procedure TfrmRelEstKardexFiscal.pImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: array of String);
  Var
    strCodGru: String;
    strCodIte: String;
    strDesIte: String;
    strRefere: String;
    strCodMar: String;
    strUnidad: String;
begin
  strCodIte := qryRelatorio.FieldByName('CODITE').AsString;
  pRetDadosItem(strCodIte, strDesIte, strRefere, strCodMar, strUnidad);
  With Excel Do
  Begin
    ProximaLinha;
    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['NUMDOC'].Coluna, 'ITEM: ' + strCodGru + '.' + strCodIte + ' - ' + strDesIte + ' LOTE: ' + IfThen(fEmptyStr(edtNumLot.Text), 'TODOS', edtNumLot.Text));
    Escrever(LinhaAtual, Campos.ColunaPorNome['CODOPE'].Coluna, 'REFERÊNCIA: ' + strRefere);
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDSAI'].Coluna, 'UNIDADE: ' + fRetSiglaUnidade(strUnidad));
    Escrever(LinhaAtual, Campos.ColunaPorNome['UNISAI'].Coluna, 'MARCA: ' + fRetNomMarca(strCodMar));

    Mesclar    (fGetLetraAlfa(Campos.ColunaPorNome['NUMDOC'].Coluna) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['NOMCLI'].Coluna) + IntToStr(LinhaAtual));
    Mesclar    (fGetLetraAlfa(Campos.ColunaPorNome['CODOPE'].Coluna) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIENT'].Coluna) + IntToStr(LinhaAtual));
    Mesclar    (fGetLetraAlfa(Campos.ColunaPorNome['UNISAI'].Coluna) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['QTDSAI'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), True);

//    NovaLinha;
//    Escrever(LinhaAtual, Campos.Colunas['NUMDOC'].Coluna, 'SALDO INICIAL DO ITEM: ' + FloatToStrF(fltSaldoIni,ffNumber,15,2));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['DTAHOR'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), True);

    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDENT'].Coluna, 'ENTRADAS');
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDSAI'].Coluna, 'SAÍDAS');
//    Escrever(LinhaAtual, Campos.Colunas['SALDO'].Coluna, 'SALDO');

    Mesclar    (fGetLetraAlfa(Campos.ColunaPorNome['QTDENT'].Coluna) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNIENT'].Coluna) + IntToStr(LinhaAtual));
    Mesclar    (fGetLetraAlfa(Campos.ColunaPorNome['QTDSAI'].Coluna) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['UNISAI'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count)+ IntToStr(LinhaAtual), Preto);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Centro);
  End;
end;

function TfrmRelEstKardexFiscal.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Result := True;

  qryGenIte := fCriaQuery(Self);

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

    Else If (Sender = edtOpcao) Then
    Begin

      If edtOpcao.Enabled And (Pos(edtOpcao.Text, '1_2_3_4') <= 0) Then
      Begin
        fMensagem('','O opção de Preço deve ser 1, 2, 3 ou 4!',['&O K']);
        Result := False;
      End;

      cbbComCus.Enabled := Result And (edtOpcao.Text = '3');
      lblComCus.Enabled := cbbComCus.Enabled;
    End

    {*****************************}
    {* VERIFICA CAMPO DO PRODUTO *}
    {**************************AF*}
    Else If (Sender = edtProdutos) Then
    Begin

      If fEmptyStr(edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Produto deve ser preenchido!',['&O K']);
        Result := False;
      End;

      pMostraLote;

    End
    {*****************************}
    {* VERIFICA CAMPO DA EMPRESA *}
    {**************************AF*}
    Else If (Sender = edtEmpresa) Then
    Begin

      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin

        With qryGenIte Do
        Begin
          If fEmptyStr(edtNumLot.Text) Then
          Begin
            strSQL := '';
            strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
            strSQL := strSQL + '  * ';
            strSQL := strSQL + 'FROM ';
            strSQL := strSQL + '  ITEGER ';
            strSQL := strSQL + '  JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '  ITEGER.ITE_CODITE = :CODITE AND ';
            strSQL := strSQL + '  ITEGER.ITE_CODEMP = :CODEMP ';
          End Else
          Begin
            strSQL := '';
            strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
            strSQL := strSQL + '  ITE_CNV_ML,               ';
            strSQL := strSQL + '  LOT_SAL_ML AS ITE_SAL_ML, ';
            strSQL := strSQL + '  LOT_ML_BAL AS ITE_ML_BAL, ';
            strSQL := strSQL + '  LOT_SALDOS AS ITE_SALDOS, ';
            strSQL := strSQL + '  LOT_SALBAL AS ITE_SALBAL, ';
            strSQL := strSQL + '  LOT_DTABAL AS ITE_DTABAL  ';
            strSQL := strSQL + 'FROM ';
            strSQL := strSQL + '  CADLOT ';
            strSQL := strSQL + '  JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE     ';
            strSQL := strSQL + '  JOIN ITEGER G ON G.ITE_CODITE = LOT_CODITE AND ';
            strSQL := strSQL + '                   G.ITE_CODEMP = LOT_CODEMP     ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
            strSQL := strSQL + '  LOT_CODEMP = :CODEMP AND ';
            strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT     ';
          End;

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODITE').AsString := edtProdutos.Text;
          ParamByName('CODEMP').AsString := edtEmpresa.Text;

          If Not fEmptyStr(edtNumLot.Text) Then
            ParamByName('NUMLOT').AsString := edtNumLot.Text;

          Open;

{          If FieldByName('ITE_DTABAL').IsNull Then
          Begin
            fMensagem('ATENÇÃO!','O produto solicitado não possui data de saldo inicial!',['&O K']);
            Result := False;
          End
          Else
          Begin}
            {********************************************}
            {* CASO O FATOR TINTOMÉTRICO ESTEJA ZERO,   *}
            {* USA O VALOR 1, ASSIM, NÃO SE ALTERA      *}
            {* OS PRODUTOS QUE NÃO SÃO BASES/COLORANTES *}
            {*****************************************AF*}
            fltCnvMl                    := IIF(FieldByName('ITE_CNV_ML').AsFloat > 0, FieldByName('ITE_CNV_ML').AsFloat, 1);
            fltSaldoIni                 := (FieldByName('ITE_SALBAL').AsFloat * fltCnvMl) + IIF(fltCnvMl <> 1, FieldByName('ITE_ML_BAL').AsFloat, 0);

            fltSaldoRea                 := FieldByName('ITE_SALDOS').AsFloat;

{            fltSalMlRea                 := FieldByName('ITE_SAL_ML').AsFloat;
            dtaSaldo                    := FieldByName('ITE_DTABAL').AsDateTime;
            lblSaldoInicial.Caption     := 'Saldo Inicial: ' + FloatToStrF(fltSaldoIni, ffNumber,15,IIF(fltCnvMl > 1, 4, fCfgSis('DECQTD',varInteger)));
            lblDataDaldoInicial.Caption := 'Data Saldo Inicial: ' + FormatDateTime('dd/mm/yyyy',FieldByName('ITE_DTABAL').AsDateTime +1);

            If fltCnvMl > 1 Then
              lblSaldoInicial.Caption := lblSaldoInicial.Caption + ' (g/ml)';
          End;                                                               }

          Close;
        End;


      End;

      pMostraLote;

    End

    Else If (Sender = edtNumLot) Then
    Begin
      If edtNumLot.Enabled Then
      Begin
        If (Not fEmptyStr(edtNumLot.Text)) And
           (Not objCadLot.fExisteLote(edtProdutos.Text, edtEmpresa.Text, edtNumLot.Text, False)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
          Result := False;
        End
      End;
    End

    {**************************}
    {* VERIFICA CAMPO DESTINO *}
    {***********************RV*}
    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

  FreeAndNil(qryGenIte);

end;

function TfrmRelEstKardexFiscal.fVerificaCustoItem(fltCusto,
  fltCnvML: Double): String;
begin
  If fltCnvMl <> 0 Then
    Result := FloatToStrF(fltCusto / fltCnvMl, ffFixed, 12, 2)
  Else
    Result := FloatToStrF(fltCusto, ffFixed, 12, 2);
end;

function TfrmRelEstKardexFiscal.fVerificaDocumentoAlterado(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie_, strTip_FC, strClaFis: String): String;
  Var
    qryAux: TUniQuery;
begin
  If (strTip_FC = 'F') And
     (strClaFis < '5000') Then
  Begin
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(*) AS QTD ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  DOCDTA ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  DOC_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  DOC_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  DOC_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  DOC_FORCLI = :FORCLI AND ');
    qryAux.SQL.Add('  IFNULL(DOC_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('  DOC_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strCodFor;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    If (qryAux.FieldByName('QTD').AsInteger > 0) Then
      Result := '***'
    Else
      Result := '';

    FreeAndNil(qryAux);
  End
  Else
    Result := '';
end;

function TfrmRelEstKardexFiscal.fVerificaFatorQuantidadeItem(fltQtdIte, fltCnvML: Double; strEspOri, strCancel: String): String;
  var
    intQtdDec: Integer;
begin
  If (strEspOri <> 'ML') And
     (fltCnvMl > 1)      Then
  Begin
    fltQtdIte := fltQtdIte * fltCnvMl;
  End;
  intQtdDec := IIF(fltCnvMl > 1, 4, fCfgSis('DECQTD',varInteger));
  Result := FloatToStrF(fltQtdIte, ffFixed, 15, intQtdDec);
end;

function TfrmRelEstKardexFiscal.fVerificaFatorValorUnitario(blnComIpi: Boolean; fltUnitar, fltValIpi, fltCnvML: Double): String;
begin
  If blnComIpi Then
    Result := FloatToStrF(fltUnitar + fltValIpi, ffFixed, 15, 4)
  Else
    Result := FloatToStrF(fltUnitar, ffFixed, 15, 4);

  If fltCnvMl <> 0 Then
    Result := FloatToStrF(fStrToFloat(Result) / fltCnvMl, ffFixed, 12, 4);
end;

procedure TfrmRelEstKardexFiscal.edtProdutosEnter(Sender: TObject);
begin
  inherited;
  edtDesProduto.Clear;
  edtDesMarca.Clear;
end;

Function TfrmRelEstKardexFiscal.fSQLWhere: String;
   Const
     STR_ESPDOCS = '"NF", "IF", "IV", "EL", "NS", "NV", "IV", "D1"';
   Var
     strSQL: String;
Begin
  strSQL := '';
{  strSQL := strSQL + '  DET_ESPDOC <> "TM" AND ';
  strSQL := strSQL + '  DET_ESPDOC <> "DF" AND ';
  strSQL := strSQL + '  DET_ESPDOC <> "PR" AND ';}

  strSQL := strSQL + '  ((DET_ESPDOC IN (' + STR_ESPDOCS + ')) ';
  strSQL := strSQL + '  OR (DET_ESPDOC = "ML" AND DET_TIPFAT IN (' + STR_ESPDOCS + ') )) AND ';

  strSQL := strSQL + '  DET_FILKAR = FALSE AND ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  RIGHT(DET_CLAFIS,3) <> "929" ';

  If Not fEmptyStr(edtNumLot.Text) Then
    strSQL := strSQL + '  AND DET_NUMLOT = :NUMLOT ';

  Result := strSQL;
End;

procedure TfrmRelEstKardexFiscal.pAbreConsulta(qryRelatorio: TUniQuery; strSQL: String);
Begin
  With qryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODITE').AsString := edtProdutos.Text;
    ParamByName('CODEMP').AsString := edtEmpresa.Text;

    If Params.FindParam('FORFIL') <> Nil Then
      ParamByName('FORFIL').AsString := fRetForFilialTodos;

    If Params.FindParam('CLIFIL') <> Nil Then
      ParamByName('CLIFIL').AsString := fRetClientesFilial;

    If Not fEmptyStr(edtNumLot.Text) Then
      ParamByName('NUMLOT').AsString := edtNumLot.Text;

    Open;
  End;
End;

Function TfrmRelEstKardexFiscal.fSQLCampos: String;
  Var
    strSQL: String;
    strCusTmp: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  IF(DET_ESPDOC = "ML" AND DET_DTAFAT IS NOT NULL, DET_NUMFAT, DET_NUMDOC) AS NUMDOC, ';
  strSQL := strSQL + '  DET_CODITE AS CODITE, ';
  strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "ML" AND DET_DTAFAT IS NOT NULL, DET_TIPFAT, DET_ESPDOC) AS ESPDOC, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPORI, ';
  strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  DET_HORENT AS HORENT, ';
  strSQL := strSQL + '  DET_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  DET_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  LEFT(DET_CLAFIS,1) AS CLAFIS, ';
  strSQL := strSQL + '  DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS UNITAR, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, DET_QTDITE, 0) AS QTDITESAI, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, DET_UNITAR, 0) AS UNITARSAI, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, DET_QTDITE, 0) AS QTDITEENT, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, DET_UNITAR, 0) AS UNITARENT, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "AJ", DET_CODDIG, DET_CODVEN) AS CODOPE, ';

  strSQL := strSQL + '  CONCAT(DET_CLAFIS, ';
  strSQL := strSQL + '    IF((DET_CODCLI IS NOT NULL AND LOCATE(DET_CODCLI, :CLIFIL) > 0) OR ';
  strSQL := strSQL + '       (DET_CODFOR IS NOT NULL AND LOCATE(DET_CODFOR, :FORFIL) > 0), " **", "")) AS CFOP, ';

  If edtOpcao.Text = '3' Then
  Begin
    strCusTmp := ' IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';
    strSQL := strSQL + '  (' + strCusTmp + '/ DET_QTDITE) AS TOTCUS, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, (' + strCusTmp + ' / DET_QTDITE), 0) AS TOTCUSSAI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5,  (' + strCusTmp + ' / DET_QTDITE), 0) AS TOTCUSENT, ';
  End
  Else If edtOpcao.Text = '4' Then
  Begin
    strSQL := strSQL + '  (DET_TOTCU2 / DET_QTDITE) AS TOTCUS, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, (DET_TOTCU2 / DET_QTDITE), 0) AS TOTCUSSAI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, (DET_TOTCU2 / DET_QTDITE), 0) AS TOTCUSENT, ';
  End
  Else
  Begin
    strSQL := strSQL + '  (DET_TOTCUS / DET_QTDITE) AS TOTCUS, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, (DET_TOTCUS / DET_QTDITE), 0) AS TOTCUSSAI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, (DET_TOTCUS / DET_QTDITE), 0) AS TOTCUSENT, ';
  End;

  If edtOpcao.Text <> '2' Then
  Begin
    strSQL := strSQL + ' 0.00 AS VALIPIENT, ';
    strSQL := strSQL + ' 0.00 AS VALIPISAI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1)  < 5, (DET_VALIPI / DET_QTDITE), 0.00) AS VALIPIENT, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= 5, (DET_VALIPI / DET_QTDITE), 0.00) AS VALIPISAI, ';
  End;

  strSQL := strSQL + '  ITE_CNV_ML, ';

  {*****************************************}
  {* CAMPOS UTILIZADOS NA GERAÇÃO DO EXCEL *}
  {**************************************RV*}
  strSQL := strSQL + '  "                                                  " AS NOMCLI, ';
  strSQL := strSQL + '  "2010-01-01 00:00:00" AS DTAHOR, ';
  strSQL := strSQL + '  0.00   AS QTDENT, ';
  strSQL := strSQL + '  0.0000 AS UNIENT, ';
  strSQL := strSQL + '  0.00   AS CUSENT, ';
  strSQL := strSQL + '  0.0000 AS TOTENT, ';
  strSQL := strSQL + '  0.00   AS QTDSAI, ';
  strSQL := strSQL + '  0.00   AS CUSSAI, ';
  strSQL := strSQL + '  0.0000 AS UNISAI, ';
  strSQL := strSQL + '  0.0000 AS TOTSAI, ';
  strSQL := strSQL + '  0.0000 AS SALDO,    ';
  strSQL := strSQL + '  DET_SERIE_ AS SERIE_ ';

  Result := strSQL;
End;

procedure TfrmRelEstKardexFiscal.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strCodIte: String;
    strDesIte: String;
    strCodGru: String;
    strRefere: String;
    strCodMar: String;
    strUnidad: String;
    frxRel : TfrxReport;
begin
  inherited;
  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  "N" AS CANCEL, ';
    strSQL := strSQL + fSQLCampos;
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    If edtOpcao.Text = '3' Then
      strSQL := strSQL + '  JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

    strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM AND MOVDET.DET_VALRET = 0 ';
    strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + fSQLWhere;

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'),
                                                       'DET_FILKAR = FALSE AND', ''), 'MOVTRI', 'NOTTRI') ;

    strSQL := strSQL + ' AND LEFT(DET_CLAFIS, 1) <> "3" ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   DTAENT, HORENT, ESPORI, NUMDOC ';

    pAbreConsulta(qryRelatorio, strSQL);

    If Not qryRelatorio.IsEmpty Then
    Begin
      If (edtDestino.Text = 'E') Then
      Begin
        pGeraExcel(qryRelatorio);
      End
      Else
      Begin
        Try
          frxRelatorio.DataSet := qryRelatorio;

          If SameText(strTipImp,'M') Then
          Begin
            frxRelatorioM.AddFunction('function fImprimeClienteFornecedor(strTip_FC, strCodigo, strNumDoc, strEspDoc, strCodEmp: String): String');
            frxRelatorioM.AddFunction('function fVerificaDocumentoAlterado(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie_, strTip_FC, strClaFis: String): String');
            frxRelatorioM.AddFunction('function fVerificaFatorQuantidadeItem(fltQtdIte, fltCnvML: Double; strEspOri, strCancel: String): String');
            frxRelatorioM.AddFunction('function fVerificaFatorValorUnitario(blnComIpi: Boolean; fltUnitar, fltValIpi, fltCnvML: Double): String');
            frxRelatorioM.AddFunction('function fVerificaCustoItem(fltCusto, fltCnvML: Double): String');
            frxRelatorioM.AddFunction('function fFormataQuantidadeTotal(fltQtdIte: Double): String');
            frxRel := frxRelatorioM;
          End
          Else
          Begin
            frxRelatorioJ.AddFunction('function fImprimeClienteFornecedor(strTip_FC, strCodigo, strNumDoc, strEspDoc, strCodEmp: String): String');
            frxRelatorioJ.AddFunction('function fVerificaDocumentoAlterado(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie_, strTip_FC, strClaFis: String): String');
            frxRelatorioJ.AddFunction('function fVerificaFatorQuantidadeItem(fltQtdIte, fltCnvML: Double; strEspOri, strCancel: String): String');
            frxRelatorioJ.AddFunction('function fVerificaFatorValorUnitario(blnComIpi: Boolean; fltUnitar, fltValIpi, fltCnvML: Double): String');
            frxRelatorioJ.AddFunction('function fVerificaCustoItem(fltCusto, fltCnvML: Double): String');
            frxRelatorioJ.AddFunction('function fFormataQuantidadeTotal(fltQtdIte: Double): String');
            TfrxMemoView(frxRelatorioJ.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
            frxRel := frxRelatorioJ;
            frxRel.DotMatrixReport           := False;
            frxRel.PrintOptions.PrintMode    := pmScale;
            frxRel.PrintOptions.PrintOnSheet := 9; //A4
          End;

          pRetDadosItem(edtProdutos.Text, strDesIte, strRefere, strCodMar, strUnidad);

          strCodGru               := qryRelatorio.FieldByName('CODGRU').AsString;
          frxRel.Script.Variables['ITEM']       := 'ITEM: ' + strCodGru + '.' + strCodIte + ' - ' + strDesIte;

          If SameText(strTipImp,'M') Then
            frxRel.Script.Variables['REFERENCIA'] := 'REFERENCIA: ' + strRefere
          Else
            frxRel.Script.Variables['REFERENCIA'] := 'REFERÊNCIA: ' + strRefere;

          frxRel.Script.Variables['UNIDADE']    := 'UNIDADE: ' + fRetSiglaUnidade(strUnidad);
          frxRel.Script.Variables['MARCA']      := 'MARCA: ' + strCodMar + ' - ' + fRetNomMarca(strCodMar);
          frxRel.Script.Variables['LOTE']       := 'LOTE: ' + IIF(fEmptyStr(edtNumLot.Text), 'TODOS', edtNumLot.Text);

          If Not blnLibPre Then
          Begin
            TfrxMemoView(frxRel.FindObject('lblCustoEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblValUniEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbTotCusEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbUnitarEnt')).Visible := False;

            TfrxMemoView(frxRel.FindObject('lblCustoSai')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblValUniSai')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbTotCusSai')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbUnitarSai')).Visible := False;
          End;

          {**************************************}
          {* PREÇO DE ENTRADA\SAIDA SEM IPI     *}
          {***********************************JB*}
          If edtOpcao.Text = '1' Then
          Begin
            TfrxMemoView(frxRel.FindObject('rdbTotCusEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbTotCusSai')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblCustoEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblCustoSai')).Visible := False;
          End
          {**************************************}
          {* PREÇO DE ENTRADA\SAIDA COM IPI     *}
          {***********************************JB*}
          Else If edtOpcao.Text = '2' Then
          Begin
            TfrxMemoView(frxRel.FindObject('rdbTotCusEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbTotCusSai')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblCustoEnt')).Visible := False;
            TfrxMemoView(frxRel.FindObject('lblCustoSai')).Visible := False;
          End
          {************************************}
          {* PREÇO DE CUSTO                   *}
          {*********************************JB*}
          Else If (Pos(edtOpcao.Text,'34') > 0) And blnLibPre Then
          Begin
            TfrxMemoView(frxRel.FindObject('rdbTotCusEnt')).Visible := True;
            TfrxMemoView(frxRel.FindObject('rdbTotCusSai')).Visible := True;
            TfrxMemoView(frxRel.FindObject('lblCustoEnt')).Visible := True;
            TfrxMemoView(frxRel.FindObject('lblCustoSai')).Visible := True;
          End;

          frxRel.Script.Variables['PERIODO'] :=  'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
          frxRel.Script.Variables['ITEM'] := 'ITEM: ' + qryRelatorio.FieldByName('CODGRU').AsString + '.' + edtProdutos.Text + ' - ' + edtDesProduto.Text;

          TfrxMemoView(frxRel.FindObject('rlbResumo3')).Visible := (qryRelatorio.FieldByName('ITE_CNV_ML').AsFloat > 0);
          frxRel.Script.Variables['FATTIN'] := FloatToStrF(qryRelatorio.FieldByName('ITE_CNV_ML').AsFloat,ffNumber,15,2);

          If qryRelatorio.FieldByName('CANCEL').AsString = 'N' Then
            TfrxMemoView(frxRel.FindObject('rllProCan')).Visible := True
          Else
            TfrxMemoView(frxRel.FindObject('rllProCan')).Visible := False;

          If edtOpcao.Text = '3' Then
            frxRel.Script.Variables['CUSTO']  := 'CUSTO SOBRE: ' + cbbComCus.Text
          Else
            frxRel.Script.Variables['CUSTO']  := '';

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxRel)
          Else
          Begin
            If frxRel.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
end;

procedure TfrmRelEstKardexFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaComposicaoCusto(cbbComCus);

  objCadLot := TCadLot.Create(Self);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  {*******************************************************}
  {* DEFINE PADRAO COMO PREÇO DE ENTRADA\SAIDA SEM IPI   *}
  {****************************************************JB*}
  edtOpcao.Text  := '1';

  edtEmpresa.Text := VS_strCodEmp;

  pSetaCodIte(edtProdutos);

end;


procedure TfrmRelEstKardexFiscal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstKardexFiscal.FormShow(Sender: TObject);
begin
  inherited;

  blnLibPre := fVerificaAcessoSistema('MKPPREUNI');

  If blnLibPre Then
    shpLibPre.Brush.Color := clGreen
  Else
    shpLibPre.Brush.Color := clRed;

  edtOpcao.Enabled := blnLibPre;

  If Not edtOpcao.Enabled Then
    edtOpcao.Text := '';

  pCriaQryRelatorio;

end;

function TfrmRelEstKardexFiscal.fRetMarcaItem(strCodIte: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;                                                     
Begin
  Result := '';

  If (fEmptyStr(strCodIte)) Then
    Exit;

  qryGen := fCriaQuery;    

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  ITE_CODMAR, ';
  strSQL := strSQL + '  MAR_DESMAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE, ';
  strSQL := strSQL + '  CADMAR  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  MAR_CODMAR = ITE_CODMAR  ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := FieldByName('ITE_CODMAR').AsString + ' - ' + FieldByName('MAR_DESMAR').AsString;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TfrmRelEstKardexFiscal.frxRelatorioMUserFunction(const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'fImprimeClienteFornecedor') Then
    Result := fImprimeClienteFornecedor(Params[0], Params[1], Params[2], Params[3], Params[4])
  Else If SameText(MethodName, 'fVerificaDocumentoAlterado') Then
    Result := fVerificaDocumentoAlterado(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5], Params[6])
  Else If SameText(MethodName, 'fVerificaFatorQuantidadeItem') Then
    Result := fVerificaFatorQuantidadeItem(Params[0], Params[1], Params[2], Params[3])
  Else If SameText(MethodName, 'fVerificaFatorValorUnitario') Then
    Result := fVerificaFatorValorUnitario(Params[0], Params[1], Params[2], Params[3])
  Else If SameText(MethodName, 'fVerificaCustoItem') Then
    Result := fVerificaCustoItem(Params[0], Params[1])
  Else If SameText(MethodName, 'fFormataQuantidadeTotal') Then
    Result := fFormataQuantidadeTotal(Params[0]);
end;

procedure TfrmRelEstKardexFiscal.edtDestinoExit(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmRelEstKardexFiscal.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEmpresa.Text) Then
  Begin
    pSetFocus(edtEmpresa);
    edtEmpresa.SelectAll;
  End
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtEmpresa.Clear;
    pSetFocus(edtEmpresa);
  End
  Else
    fValidaCampos(edtEmpresa,False);
end;

procedure TfrmRelEstKardexFiscal.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstKardexFiscal.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If objCadLot.fedtNumLotKeyPress(edtProdutos.Text, Sender, Key,
       edtNumLot, Self, False) Then
  Begin
    fValidaCampos(edtNumLot, True);
  End;

end;

procedure TfrmRelEstKardexFiscal.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
//  Var
//    strTotal: String;
begin
  With Excel Do
  Begin

//    strTotal := 'SALDO REAL DO PRODUTO: ' + FormatFloat('##,#0.00', Quebra.Totais['SALDO']);

    ProximaLinha;

//    Escrever(LinhaAtual, 01, strTotal);
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDENT'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['QTDENT']), 14));
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDSAI'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['QTDSAI']), 14));
//    Escrever(LinhaAtual, Campos.Colunas['SALDO'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['SALDO']), 14));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['DTAHOR'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

  End;
end;

procedure TfrmRelEstKardexFiscal.pMostraLote;
Begin
  lblNumLot.Enabled := objCadLot.fExisteLote(edtProdutos.Text, edtEmpresa.Text, '', False);
  edtNumLot.Enabled := lblNumLot.Enabled;

  If Not edtNumLot.Enabled Then
    edtNumLot.Clear;
End;

procedure TfrmRelEstKardexFiscal.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  Totais['QTDENT'] := Totais['QTDENT'] + Dados.FieldByName('QTDENT').AsCurrency;
  Totais['QTDSAI'] := Totais['QTDSAI'] + Dados.FieldByName('QTDSAI').AsCurrency;
//  Totais['SALDO']  := Dados.FieldByName('SALDO').AsCurrency;
end;

procedure TfrmRelEstKardexFiscal.edtNumLotExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtEmpresa, True);
end;

procedure TfrmRelEstKardexFiscal.edtEmpresaEnter(Sender: TObject);
begin
  inherited;

  edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);
  edtDesMarca.Text   := fRetMarcaItem(edtProdutos.Text);

  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End
  Else
    fValidaCampos(edtProdutos,False);

end;

end.
