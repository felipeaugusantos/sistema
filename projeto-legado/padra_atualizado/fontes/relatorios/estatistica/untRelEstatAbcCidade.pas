{***************************}
{* qryConOpe -> CADOPE     *}
{************************JB*}
unit untRelEstatAbcCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, ComObj, Uni,
  AppEvnts, UniClientDataSet, DB, BitBtnLockedIncrem, Math,
  frxExportCSVTestabilidade, ComboBoxFocus;

type
  TfrmRelEstatAbcCidade = class(TfrmPaiRelatorio)
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblEmpresa: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodVendedor: TEditFocus;
    edtCodRepresentante: TEditFocus;
    edtQtdCid: TEditFocus;
    lstClaFis: TMemo;
    edtDesVendedor: TEditFocus;
    edtDesRepresentante: TEditFocus;
    edtAtividade: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    svdExcel: TSaveDialog;
    gpbMargem: TGroupBox;
    ColorLabel4: TColorLabel;
    edtMargem: TEditFocus;
    Label10: TLabel;
    lblFornec: TLabel;
    lblProduto: TLabel;
    lblCliente: TLabel;
    edtCodFor: TEditFocus;
    edtCodPro: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodAti: TEditFocus;
    Label11: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    rdgEmpresa: TRadioGroup;
    Label12: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    shpMultiSelecao: TShape;
    lblComCus: TLabel;
    cbbComCus: TComboBoxFocus;
    edtDesFor: TEditFocus;
    Label4: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    edtDesPro: TEditFocus;
    edtDesCli: TEditFocus;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure FormCreate(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodProExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
  private
    fltSoma  : Double;

    procedure pGeraExcelAbcCidade(cdsDados: TUniClientDataSet);
    function fCriaCdsCidAbc: TUniClientDataSet;
    procedure pMontaDadosRelatorioAbc(qryDados: TUniQuery; cdsDados: TUniClientDataSet);
    function fGetSqlPesoLitroKilo(strTipUni, fStrRelFatorLit: String): String;

    { Private declarations }
  public
    { Public declarations }
    arrAtividade,
    arrRede,
    arrRegiao,
    arrRepresentante,
    arrVendedor,
    arrFornec,
    arrMarca,
    arrProduto,
    arrClientes,
    arrEmp: TConsultasArray;

    strAtividade,
    strRede,
    strRegiao,
    strRepresentante,
    strVendedor,
    strFornecedor,
    strMarca,
    strProduto,
    strClientes,
    strEmpresa: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEstatAbcCidade: TfrmRelEstatAbcCidade;

implementation

uses untQckEstatAbcCidade, untConstantes,
     untExcel, untFuncoesFactory, untIFuncoes, untClassPanelCx;

{$R *.dfm}

procedure TfrmRelEstatAbcCidade.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'
  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;
End;

procedure TfrmRelEstatAbcCidade.pGeraExcelAbcCidade(cdsDados: TUniClientDataSet);
  Var
    objExcel: TExcel;
    intTotCliCom: Integer;
    intTotCliAti: Integer;
    fltTotCtr: Double;
    fltTotChq: Double;
    fltTotCom: Double;
    fltTotCus: Double;
    fltAcuRep: Double;
    fltTotLit: Double;
    fltTotKil: Double;
    strLetra: String;
begin
  intTotCliCom := 0;
  intTotCliAti := 0;
  fltTotCtr := 0.0;
  fltTotChq := 0.0;
  fltTotCom := 0.0;
  fltTotCus := 0.0;
  fltAcuRep := 0.0;
  fltTotLit := 0.0;
  fltTotKil := 0.0;

  strLetra := IfThen(SameText(edtMargem.Text, 'S'), 'L', 'K');

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************MV*}
  objExcel := TExcel.fCriarExcel(Self);

  {*******************************************}
  {* ADICIONA UMA PASTA DE TRABALHO          *}
  {****************************************MV*}
  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    LinhaAtual := 01;
    {********************************}
    {* EMPRESA PADRAO DO SISTEMA    *}
    {*****************************MV*}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {****************************************MV*}
    Escrever(ProximaLinha, 01, 'RELATORIO DE CURVA ABC DE CIDADE - QTD. CIDADES: ' + edtQtdCid.Text);

    ProximaLinha;

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {****************************************MV*}
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmpresa, 'EMPRESA ' + IfThen(rdgEmpresa.ItemIndex = 0, '(FATURAMENTO)', '(ORIGEM)')));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodRepresentante.Text, edtDesRepresentante, arrRepresentante, strRepresentante, 'REPRESENTANTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtMarca.Text, edtDesMarca, arrMarca, strMarca, 'MARCA'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodFor.Text, edtDesFor, arrFornec, strFornecedor, 'FORNECEDOR'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodPro.Text, edtDesPro, arrProduto, strProduto, 'PRODUTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCli.Text, edtDesCli, arrClientes, strClientes, 'CLIENTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodAti.Text, edtAtividade, arrAtividade, strAtividade, 'ATIVIDADE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodReg.Text, edtDesReg, arrRegiao, strRegiao, 'REGIÃO'));
    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    {********************************}
    {* COLOCA EM NEGRITO E ALINHA   *}
    {* AO CENTRO DA CELULA          *}
    {*****************************MV*}
    Mesclar('A1', strLetra + '1');
    Mesclar('A2', strLetra + '2');
    Mesclar('A3', strLetra + '3');
    Alinhamento('A1', strLetra + '3', Centro);
    Negrito('A1', strLetra + '3', True);

    Mesclar('A4', strLetra + '4');
    Mesclar('A5', strLetra + '5');
    Mesclar('A6', strLetra + '6');
    Mesclar('A7', strLetra + '7');
    Mesclar('A8', strLetra + '8');
    Mesclar('A9', strLetra + '9');
    Mesclar('A10',strLetra + '10');
    Mesclar('A11', strLetra + '11');
    Mesclar('A12', strLetra + '12');
    Mesclar('A13', strLetra + '13');
    Mesclar('A14', strLetra + '14');
    Alinhamento('A4', strLetra + '14', Centro);
    Negrito('A4', strLetra + '14', True);

    ProximaLinha;

    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************MV*}
    Escrever(LinhaAtual, 01, 'CODIGO');
    Escrever(LinhaAtual, 02, 'NOME DA CIDADE');
    Escrever(LinhaAtual, 03, 'CLIENTES ATIVOS');
    Escrever(LinhaAtual, 04, 'CLIENTES COMPRARAM');
    Escrever(LinhaAtual, 05, 'CTR ABERTO');
    Escrever(LinhaAtual, 06, 'CHEQUE');
    Escrever(LinhaAtual, 07, 'LITROS/KILOS');
    Escrever(LinhaAtual, 08, 'TOTAL COMPRA');
    Escrever(LinhaAtual, 09, 'TOTAL CUSTO');
    If SameText(edtMargem.Text, 'S') Then
      Escrever(LinhaAtual, 10, 'MARGEM');
    Escrever(LinhaAtual, IfThen(SameText(edtMargem.Text, 'S'), 11, 10), '% REP.');
    Escrever(LinhaAtual, IfThen(SameText(edtMargem.Text, 'S'), 12, 11), '% ACUM.');

    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************MV*}
    Negrito('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************MV*}
    CorFundo('A2' , strLetra + '3' , Cinza);
    CorFundo('A15', strLetra + '15', Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************MV*}
    Bordas('A2', strLetra + '3');
    Bordas('A4', strLetra + '15');

    With cdsDados Do
    Begin
      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        Escrever(LinhaAtual, 01, fStrZero(FieldByName('CODCID').AsString, 8));
        Escrever(LinhaAtual, 02, FieldByName('NOMCID').AsString);
        Escrever(LinhaAtual, 03, FieldByName('CLIATI').AsString);
        Escrever(LinhaAtual, 04, FieldByName('CLICOM').AsString);
        Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('VALDUP').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 06, FloatToStrF(FieldByName('VALCHQ').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 07, FloatToStrF(FieldByName('PESLIT').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 08, FloatToStrF(FieldByName('TOTCOM').AsFloat, ffFixed, 12, 2));
        Escrever(LinhaAtual, 09, FloatToStrF(FieldByName('TOTCUS').AsFloat, ffFixed, 12, 2));
        If SameText(edtMargem.Text, 'S') Then
          Escrever(LinhaAtual, 10, FloatToStrF(fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                   FieldByName('TOTCOM').AsFloat, 0, 0, 0, 0, 0), ffFixed, 12, 2));

        Escrever(LinhaAtual, IfThen(SameText(edtMargem.Text, 'S'), 11, 10), FloatToStrF((FieldByName('TOTCOM').AsFloat / fltSoma) * 100, ffFixed, 12, 2));

        fltAcuRep := fltAcuRep + ((FieldByName('TOTCOM').AsFloat / fltSoma) * 100);
        Escrever(LinhaAtual, IfThen(SameText(edtMargem.Text, 'S'), 12, 11), FloatToStrF(fltAcuRep, ffFixed, 12, 2));

        Bordas('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual));
        Alinhamento('C' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), Direita);

        intTotCliCom := intTotCliCom + FieldByName('CLICOM').AsInteger;
        intTotCliAti := intTotCliAti + FieldByName('CLIATI').AsInteger;

        fltTotCtr := fltTotCtr + FieldByName('VALDUP').AsFloat;
        fltTotChq := fltTotChq + FieldByName('VALCHQ').AsFloat;
        fltTotCom := fltTotCom + FieldByName('TOTCOM').AsFloat;
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
        fltTotLit := fltTotLit + FieldByName('TOTLIT').AsFloat;
        fltTotKil := fltTotKil +  FieldByName('TOTKIL').AsFloat;
        ProximaLinha;

        Next;
      End;

      Escrever(LinhaAtual, 02, 'TOTAL:');
      Escrever(LinhaAtual, 03, IntToStr(intTotCliAti));
      Escrever(LinhaAtual, 04, IntToStr(intTotCliCom));
      Escrever(LinhaAtual, 05, FloatToStrF(fltTotCtr, ffFixed, 12, 2));
      Escrever(LinhaAtual, 06, FloatToStrF(fltTotChq, ffFixed, 12, 2));
      Escrever(LinhaAtual, 07, ' ');
      Escrever(LinhaAtual, 08, FloatToStrF(fltTotCom, ffFixed, 12, 2));
      Escrever(LinhaAtual, 09, FloatToStrF(fltTotCus, ffFixed, 12, 2));
      If SameText(edtMargem.Text, 'S') Then
        Escrever(LinhaAtual, 10, FloatToStrF(fCalculaPrecoVenda(2, fltTotCus, fltTotCom, 0, 0, 0, 0, 0), ffFixed, 12, 2));
      Bordas('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), Direita);
      Negrito(LinhaAtual, 02, True);

      ProximaLinha;
      Escrever(LinhaAtual, 02, 'TOTAL LITROS:');
      Escrever(LinhaAtual, 07, FloatToStrF(fltTotLit, ffFixed, 12, 2));
      Bordas('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), Direita);
      Negrito(LinhaAtual, 02, True);

      ProximaLinha;
      Escrever(LinhaAtual, 02, 'TOTAL KILOS:');
      Escrever(LinhaAtual, 07, FloatToStrF(fltTotKil, ffFixed, 12, 2));
      Bordas('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), Direita);
      Negrito(LinhaAtual, 02, True);

      Bordas('A' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual));
      Alinhamento('B' + IntToStr(LinhaAtual), strLetra + IntToStr(LinhaAtual), Direita);
      Negrito(LinhaAtual, 02, True);
    End;

    CongelarPaines('A16');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstatAbcCidade.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmRelEstatAbcCidade.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;  

end;

procedure TfrmRelEstatAbcCidade.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da Rede');
end;

procedure TfrmRelEstatAbcCidade.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstatAbcCidade.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg,edtDesReg,arrRegiao,nil,fRetNomRegiao,'da Região');
end;

procedure TfrmRelEstatAbcCidade.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    If fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCidade.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante,edtDesRepresentante,arrRepresentante,fRetNomVendRep,nil,'do Representante');
end;

procedure TfrmRelEstatAbcCidade.edtCodRepresentanteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepresentante, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCidade.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti,edtAtividade, arrAtividade, nil, fRetNomAtividade,'da Atividade');
end;

procedure TfrmRelEstatAbcCidade.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmRelEstatAbcCidade.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelEstatAbcCidade.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstatAbcCidade.edtDestinoExit(Sender: TObject);
begin
  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If (Copy(edtDestino.Text, 1, 1) <> 'V') And
          (COpy(edtDestino.Text, 1, 1) <> 'I') And
          (Copy(edtDestino.Text, 1, 1) <> 'E') Then
  Begin
    pSetFocus(edtDestino);
  End;
end;

procedure TfrmRelEstatAbcCidade.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEstatAbcCidade.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCidade.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    qryGenAbc: TUniQuery;
    cdsCidAbc: TUniClientDataSet;
    strAti   : string;
    strCusto : string;
begin
  qryGenAbc := fCriaQuery(Self);
  cdsCidAbc := fCriaCdsCidAbc;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;
  If blnImprime Then
  Begin
    strCusto := 'IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0)';

    {********************************}
    {* VAI COMEÇA UM SELECT MONSTRO *}
    {*****************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CID_CODCID AS CODCID, ';
    strSQL := strSQL + '  CID_NOMCID AS NOMCID, ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI,';
    strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF ))) AS TOTCOM, ';
    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, - ('  + strCusto + '), (' + strCusto + '))) AS TOTCUS, ';

    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) * ' + fStrRelFatorLit + ') AS PESLIT, ';

    {******************************************************}
    {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
    {****************************************************FC}
    strSQL := strSQL + fGetSqlPesoLitroKilo('L', fStrRelFatorLit) + ' AS TOTLIT, ';
    strSQL := strSQL + fGetSqlPesoLitroKilo('K', fStrRelFatorLit) + ' AS TOTKIL, ';

    {*******************************}
    {* PEGA NO CADREC/X A SOMA DAS *}
    {* DUPLICATAS DE ACORDO COM O  *}
    {* CODIGO DO CLIENTE           *}
    {****************************AF*}
    strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '     SUM(CTR_VALDUP) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     CADREC ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     CTR_DTAREC IS NULL ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CTR_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '      CTR_CODCLI = CLI_CODCLI ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'CTR_CODCLI', 'CODCLI');

    strSQL := strSQL + ' ) AS VALDUP, ';

    {*******************************}
    {* PEGA NO CADCHQ/X A SOMA DOS *}
    {* CHEQUES DE ACORDO COM O     *}
    {* CODIGO DE CLIENTES          *}
    {****************************AF*}
    strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '     SUM(CHQ_VALCHQ) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     CADCHQ ';
    strSQL := strSQL + '   WHERE TRUE ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CHQ_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + ' AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + ' AND CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '     CHQ_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '     CHQ_DTADEP IS NULL AND ';
    strSQL := strSQL + '     CHQ_INCCTR = "N" ) AS VALCHQ ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI  ';
    strSQL := strSQL + '  JOIN CADCID ON CLI_CODCID = CID_CODCID ';
    strSQL := strSQL + '  JOIN MOVDET ON DET_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + 'LEFT JOIN CADUNI ON (UNI_CODUNI = DET_UNIDAD) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND '; {EDUARDO}
    strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + cnsFiltroFFDVTR;

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

    If fCfgSis('ENTBRF') = 'S' Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'DET_CODVEN', 'CODVEN');

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRepresentante, arrRepresentante, 'CLI_CODREP', 'CODREP');

    If Not fEmptyStr(edtCodFor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'DET_FORITE', 'CODFOR');

    If Not fEmptyStr(edtCodPro.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPro, arrProduto, 'DET_CODITE', 'CODITE');

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'DET_CODCLI', 'CODCLI');

    {***********************}
    {*    INCLUIDO MARCA   *}
    {********************CI*}

    If Not fEmptyStr(edtMarca.Text) Then
    Begin
      strSQL := strSQL + '  AND EXISTS (SELECT ';
      strSQL := strSQL + '                ITE_CODMAR ';
      strSQL := strSQL + '              FROM ';
      strSQL := strSQL + '                CADITE ';
      strSQL := strSQL + '              WHERE ';
      strSQL := strSQL + '                ITE_CODITE = DET_CODITE ';
      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'ITE_CODMAR', 'CODMAR');
      strSQL := strSQL + '              ) ';
    End;

    {***************************************************}
    {* INCLUIDO REDE DE LOJAS , UTILIZANDO CLAUSULA OR *}
    {**01/03/2011-09:20******************************DP*}
    If Not fEmptyStr(edtCodRede.Text) Then
       strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodReg.Text) Then
      strSQL := strSQL + fStrLocate(edtCodReg,arrRegiao,'CLI_CODREG','CODREG');

    If Not fEmptyStr(edtCodAti.Text) Then
       strSQL := strSQL + fStrLocate(edtCodAti,arrAtividade,'CLI_CODATI','CODATI');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'DET_CODEMP', 'CODEMP');
        1:strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'MOVTRI.DET_EMPORI', 'CODEMP');
      End;
    End
    Else
    Begin
      Case rdgEmpresa.ItemIndex Of
        0:strSQL := strSQL + ' AND LOCATE(DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
        1:strSQL := strSQL + ' AND LOCATE(MOVTRI.DET_EMPORI, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;
    End;

    strSQL := strSQL + 'GROUP BY CODCLI ';

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

    strSQL := 'SELECT '
            + '  CODCID, '
            + '  NOMCID, '
            + '  SUM(PESLIT) AS PESLIT, '
            + '  SUM(TOTLIT) AS TOTLIT, '
            + '  SUM(TOTKIL) AS TOTKIL, '
            + '  SUM(TOTCUS) AS TOTCUS, '
            + '  SUM(TOTCOM) AS TOTCOM, '
            + '  SUM(VALDUP) AS VALDUP, '
            + '  SUM(VALCHQ) AS VALCHQ, '
            + '  COUNT(DISTINCT CODCLI) AS CLICOM, '
            + '  (SELECT COUNT(1) FROM CADCLI WHERE CLI_CODCID = CODCID AND CLI_STATUS = "A") AS CLIATI '
            + 'FROM '
            + '  ('+strSQL+') TAB '
            + 'GROUP BY '
            + '  CODCID ';
    With qryGenAbc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;
      
      If Not fEmptyStr(edtCodRepresentante.Text) Then
        pSetaParam(edtCodRepresentante.Text, arrRepresentante, strRepresentante, 'CODREP', qryGenAbc);

      If Not fEmptyStr(edtMarca.Text) Then
        pSetaParam(edtMarca.Text, arrMarca, strMarca, 'CODMAR', qryGenAbc);

      If Not fEmptyStr(edtCodVendedor.Text) Then
        pSetaParam(edtCodVendedor.Text, arrVendedor, strVendedor, 'CODVEN', qryGenAbc);

      If Not fEmptyStr(edtCodFor.Text) Then
        pSetaParam(edtCodFor.Text, arrFornec, strFornecedor, 'CODFOR', qryGenAbc);

      If Not fEmptyStr(edtCodPro.Text) Then
        pSetaParam(edtCodPro.Text, arrProduto, strProduto, 'CODITE', qryGenAbc);

      If Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryGenAbc);

      {***************************************************}
      {* INCLUIDO REDE DE LOJAS , UTILIZANDO CLAUSULA OR *}
      {**01/03/2011-09:37******************************DP*}
      If Not fEmptyStr(edtCodRede.Text) Then
        pSetaParamOR(edtCodRede,arrRede,'CODRED',qryGenAbc);

      If Not fEmptyStr(edtCodReg.Text) Then
        pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryGenAbc);

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text,arrAtividade,strAti,'CODATI',qryGenAbc);

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmpresa, 'CODEMP', qryGenAbc);

      Open;

      pMontaDadosRelatorioAbc(qryGenAbc, cdsCidAbc);

    End;

    If Not cdsCidAbc.IsEmpty Then
    Begin

      {**************************************}
      {* SE UTILIZAR MARGEM PEDE SENHA      *}
      {***********************************LU*}
      If edtMargem.Text = 'S' Then
      Begin
        If Not fEmptyStr(fCfgSis('SENMLC')) Then
        Begin
          ffrmSenha(strSenha,'Margem');
          If strSenha <> fCfgSis('SENMLC') Then
            edtMargem.Text := 'N';
        End;
      End;

      If (edtDestino.Text = 'E') Then
      Begin
        pGeraExcelAbcCidade(cdsCidAbc);
        btnImprimir.Enabled := True;
        pnlInfo.Caption := '';
      End
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckEstatAbcCidade,frmQckEstatAbcCidade);

          frmQckEstatAbcCidade.dtsAbcCidade.DataSet := cdsCidAbc;

          frmQckEstatAbcCidade.fltSoma := fltSoma;

          If strTipImp = 'M' Then
            frmQckEstatAbcCidade.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckEstatAbcCidade.qckPagina.DefaultFilter := Nil;

          frmQckEstatAbcCidade.strOrdem   := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          {**********************************************}
          {* EMPRESA DE FATURAMENTO / EMPRESA DE ORIGEM *}
          {*******************************************DP*}
          frmQckEstatAbcCidade.rllEmpresa.Caption       := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmpresa, 'EMPRESA ' + IfThen(rdgEmpresa.ItemIndex = 0, '(FATURAMENTO)', '(ORIGEM)'));
          frmQckEstatAbcCidade.rllRepresentante.Caption := fStrTitulo(edtCodRepresentante.Text, edtDesRepresentante, arrRepresentante, strRepresentante, 'REPRESENTANTE');
          frmQckEstatAbcCidade.rllMarca.Caption         := fStrTitulo(edtMarca.Text, edtDesMarca, arrMarca, strMarca, 'MARCA');
          frmQckEstatAbcCidade.rllVendedor.Caption      := fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR');
          frmQckEstatAbcCidade.rllFornecedor.Caption    := fStrTitulo(edtCodFor.Text, edtDesFor, arrFornec, strFornecedor, 'FORNECEDOR');
          frmQckEstatAbcCidade.rllProduto.Caption       := fStrTitulo(edtCodPro.Text, edtDesPro, arrProduto, strProduto, 'PRODUTO');
          frmQckEstatAbcCidade.rllCliente.Caption       := fStrTitulo(edtCodCli.Text, edtDesCli, arrClientes, strClientes, 'CLIENTE');
          frmQckEstatAbcCidade.rllAtividade.Caption     := fStrTitulo(edtCodAti.Text, edtAtividade, arrAtividade, strAtividade, 'ATIVIDADE');

          {****************************************}
          {* ACRESCENTOU FILTRO POR REDE DE LOJAS *}
          {*************************************DP*}
          frmQckEstatAbcCidade.rllRedeLoja.Caption      := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS');
          frmQckEstatAbcCidade.rllRegiao.Caption        := fStrTitulo(edtCodReg, edtDesReg, arrRegiao, strRegiao, IfThen(strTipImp = 'M', 'REGIAO', 'REGIÃO'));

          frmQckEstatAbcCidade.rllNomeRelatorio.Caption := 'RELATORIO DE CURVA ABC POR CIDADE - QTD. CIDADES: ' + edtQtdCid.Text;

          If edtMargem.Text = 'N' Then
          Begin
            frmQckEstatAbcCidade.rllDesMargem.Visible := False;
            frmQckEstatAbcCidade.rllMargem.Visible    := False;
            frmQckEstatAbcCidade.rllTotMar.Visible    := False;
          End;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frmQckEstatAbcCidade.qckPagina, frmQckEstatAbcCidade.rpsSetup)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstatAbcCidade.qckPagina);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;

        pFreeAndNil(frmQckEstatAbcCidade);

      End;

    End
    Else
      pTabelaVazia;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  FreeAndNil(qryGenAbc);
  FreeAndNil(cdsCidAbc);

  If blnImprime Then
    pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAbcCidade.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  inherited;
end;

procedure TfrmRelEstatAbcCidade.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAbcCidade.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaComposicaoCusto(cbbComCus);

  edtCodEmpresa.Text    := VS_strCodEmp;
  edtDesEmpresa.Text    := fRetNomeEmpresa;

  pAtualizaClaFis;
  pSetaCodIte(edtCodPro);
end;

procedure TfrmRelEstatAbcCidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ActiveControl Is TRadioButton Then
    Self.SelectNext(ActiveControl, True, True)
  Else
    inherited;
end;

function TfrmRelEstatAbcCidade.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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

    {*****************************************}
    {* VALIDA O FORNECEDOR                   *}
    {**************************************PZ*}
    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor,arrFornec);
    End

    {******************************}
    {* VALIDA MARCA               *}
    {***************************CI*}
    Else If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca,arrMarca);
    End

    {*****************************************}
    {* VALIDA O PRODUTO                      *}
    {**************************************PZ*}
    Else If (Sender = edtCodPro) Then
    Begin
      pDesmarcaLista(edtCodPro,arrProduto);
    End

    {*****************************************}
    {* VALIDA O CLIENTE                      *}
    {**************************************PZ*}
    Else If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli,arrClientes);
    End

    {*****************************************}
    {* VALIDA A ATIVIDADE                    *}
    {**************************************JB*}
    Else If (Sender = edtCodAti) Then
    Begin
      pDesmarcaLista(edtCodAti,arrAtividade);
    End

    {*********************}
    {* VALIDA EMPRESA    *}
    {******************JB*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If (Not fEmptyStr(edtCodEmpresa.Text)) and (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtQtdCid) Then
    Begin

      If StrToInt(edtQtdCid.Text) < 1 Then
      Begin
        fMensagem('ATENÇÃO!','A quantidade de cidades a ser impressos deve ser maior ou igual a 1!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtMargem) Then
    Begin

      If Pos(edtMargem.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Mostrar Margem deve ser S ou N!',['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstatAbcCidade.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro,edtDesPro,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelEstatAbcCidade.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodPro, edtDesPro, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodPro,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCidade.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtDesFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelEstatAbcCidade.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatAbcCidade.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli,edtDesCli,arrClientes,nil,fRetNomCliente,'do Cliente');
end;

procedure TfrmRelEstatAbcCidade.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstatAbcCidade.fCriaCdsCidAbc: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  Result.AggregatesActive := True;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCID';
    DataType := ftString;
    Size     := 5;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMCID';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALDUP';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALCHQ';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TOTCOM';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TOTCUS';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.IndexDefs.AddIndexDef Do
  Begin
    Name   := 'IDX_CODCID';
    Fields := 'CODCID';
  End;

  With Result.IndexDefs.AddIndexDef Do
  Begin
    Name       := 'IDX_TOTCOM';
    Fields     := 'TOTCOM';
    DescFields := 'TOTCOM';
  End;

  With TAggregateField.Create(Result) Do
  Begin
    Name       := 'AGG_TOTCOM';
    FieldName  := 'AGG_TOTCOM';
    DataSet    := Result;
    IndexName  := 'IDX_TOTCOM';
    Expression := 'SUM(TOTCOM)';
    DisplayFormat := '#,##0.00';
    Active     := True;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLICOM';
    DataType := ftInteger;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIATI';
    DataType := ftInteger;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PESLIT';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTLIT';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTKIL';
    DataType := ftFloat;
    Required := False;
  End;


  Result.IndexName := 'IDX_CODCID';
  Result.CreateDataSet;
  Result.Open;
end;

function TfrmRelEstatAbcCidade.fGetSqlPesoLitroKilo(strTipUni, fStrRelFatorLit: String): String;
begin
  Result := '';
  Result := Result + ' SUM(IF(COALESCE(IF(TRIM(UNI_KILLIT) = "", "L", UNI_KILLIT), "L") = "' + strTipUni + '", IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) * ' + fStrRelFatorLit + ', 0)) ';
end;

procedure TfrmRelEstatAbcCidade.pMontaDadosRelatorioAbc(qryDados: TUniQuery; cdsDados: TUniClientDataSet);
begin
  cdsDados.EmptyDataSet;

  with qryDados Do
  begin
    First;
    while not Eof do
    begin
      if (not FieldByName('TOTCOM').IsNull) And
         (not FieldByName('TOTCUS').IsNull) Then
      begin

        if not cdsDados.FindKey([FieldByName('CODCID').AsString]) then
        begin
          cdsDados.Append;
          cdsDados.FieldByName('CODCID').AsString  := FieldByName('CODCID').AsString;
          cdsDados.FieldByName('NOMCID').AsString  := FieldByName('NOMCID').AsString;
          cdsDados.FieldByName('VALDUP').AsFloat   := FieldByName('VALDUP').AsFloat;
          cdsDados.FieldByName('VALCHQ').AsFloat   := FieldByName('VALCHQ').AsFloat;
          cdsDados.FieldByName('TOTCOM').AsFloat   := FieldByName('TOTCOM').AsFloat;
          cdsDados.FieldByName('TOTCUS').AsFloat   := FieldByName('TOTCUS').AsFloat;
          cdsDados.FieldByName('CLICOM').AsInteger := FieldByName('CLICOM').AsInteger;
          cdsDados.FieldByName('CLIATI').AsInteger := FieldByName('CLIATI').AsInteger;
          cdsDados.FieldByName('PESLIT').AsFloat   := FieldByName('PESLIT').AsFloat;
          cdsDados.FieldByName('TOTLIT').AsFloat   := FieldByName('TOTLIT').AsFloat;
          cdsDados.FieldByName('TOTKIL').AsFloat   := FieldByName('TOTKIL').AsFloat;
          cdsDados.Post;
        end
        else
        begin
          cdsDados.Edit;
          cdsDados.FieldByName('VALDUP').AsFloat   := cdsDados.FieldByName('VALDUP').AsFloat + FieldByName('VALDUP').AsFloat;
          cdsDados.FieldByName('VALCHQ').AsFloat   := cdsDados.FieldByName('VALCHQ').AsFloat + FieldByName('VALCHQ').AsFloat;
          cdsDados.FieldByName('TOTCOM').AsFloat   := cdsDados.FieldByName('TOTCOM').AsFloat + FieldByName('TOTCOM').AsFloat;
          cdsDados.FieldByName('TOTCUS').AsFloat   := cdsDados.FieldByName('TOTCUS').AsFloat + FieldByName('TOTCUS').AsFloat;
          cdsDados.FieldByName('CLICOM').AsInteger := FieldByName('CLICOM').AsInteger;
          cdsDados.FieldByName('CLIATI').AsInteger := FieldByName('CLIATI').AsInteger;
          cdsDados.FieldByName('PESLIT').AsFloat   := FieldByName('PESLIT').AsFloat + FieldByName('PESLIT').AsFloat;
          cdsDados.FieldByName('TOTLIT').AsFloat   := FieldByName('TOTLIT').AsFloat + FieldByName('TOTLIT').AsFloat;
          cdsDados.FieldByName('TOTKIL').AsFloat   := FieldByName('TOTKIL').AsFloat + FieldByName('TOTKIL').AsFloat;
          cdsDados.Post;
        end;

      end;
      Next;
    end;
    First;
  end;

  With cdsDados Do
  Begin
    IndexName := 'IDX_TOTCOM';
    First;
    While Not Eof Do
    Begin
      If RecNo <= StrToIntDef(edtQtdCid.Text, 0) Then
        Next
      Else
        Delete;
    End;
    First;

    Active := False;
    Active := True;

    If IsEmpty Then
      fltSoma := 0.00
    Else
      fltSoma := TAggregateField(cdsDados.FieldByName('AGG_TOTCOM')).Value;
  End;
end;

end.

