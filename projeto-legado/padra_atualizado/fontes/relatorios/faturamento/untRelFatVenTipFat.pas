unit untRelFatVenTipFat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema, ComboBoxFocus,
  BitBtnLockedIncrem, untExcel, untGeraExcel, ComCtrls, DB,
  frxExportCSVTestabilidade, Vcl.CheckLst;

type
  TfrmRelFatVenTipFat = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtProdutos: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    Label12: TLabel;
    Label11: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    edtCodVendedor: TEditFocus;
    edtMarca: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lstClaFis: TMemo;
    Label2: TLabel;
    cbxOpcSin: TComboBoxFocus;
    Label10: TLabel;
    edtCodRepresentante: TEditFocus;
    Label4: TLabel;
    edtDesRepresentante: TEditFocus;
    Label13: TLabel;
    edtEstado: TEditFocus;
    edtDesEstado: TEditFocus;
    lbl1: TLabel;
    cbxEmpresa: TComboBoxFocus;
    shpVen: TShape;
    Label14: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    pgbProgresso: TProgressBar;
    chkEnt_CD: TCheckBox;
    gpbCalculo: TGroupBox;
    cbbComCus: TComboBoxFocus;
    clbTabPre: TCheckListBox;
    Label15: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);


    procedure pAtualizaClaFis;
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);

    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtEstadoExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure clbTabPreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    blnLiberado: Boolean;
    strCodVen: String;
    QryRel      : TUniQuery;

    arrCliente : TConsultasArray;
    arrRede    : TConsultasArray;

    function fSQLFiltroEmpresa: String;
    procedure pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape);

    procedure pGetTotConBri(Var fltTotCon, fltTotBri: Double);
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    function  fMarkup4(strCampoTotIte: String): String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatVenTipFat: TfrmRelFatVenTipFat;

implementation

uses untQckFatVenTipFat, untFuncoesFactory, untIFuncoes, untConstantes,
  untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatVenTipFat.FormShow(Sender: TObject);
begin
  pCarregaComposicaoCusto(cbbComCus);
  pCarregaChkLisTabPre(clbTabPre);

  strCodVen   := '';
  blnLiberado := fVerificaAcessoSistema('VDTFGR');
  pVerdeVermelho(edtCodVendedor, shpVen);

  blnExcel := True;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',Vs_date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',Vs_date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
    gpbCalculo.Caption := 'Cálculo da Margem Sobre: '
  Else
    gpbCalculo.Caption := 'Cálculo do Markup Sobre: ';

  If (fCfgSis('MARMKP') = '4') Then
  Begin
    cbbComCus.Enabled := False;
    gpbCalculo.Visible := False;
  End;

  inherited;
end;

procedure TfrmRelFatVenTipFat.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
  pAtualizaClafis;
end;

procedure TfrmRelFatVenTipFat.pAtualizaClaFis;
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
end;

procedure TfrmRelFatVenTipFat.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
  edtDesProduto.Text := '';
end;

procedure TfrmRelFatVenTipFat.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmRelFatVenTipFat.pCarregaGrupo(Var qryCadGru: TUniQuery);
begin

  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';

end;

procedure TfrmRelFatVenTipFat.edtProdutosExit(Sender: TObject);
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

procedure TfrmRelFatVenTipFat.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelFatVenTipFat.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    function fFiltro(strCod, strDes: String; blnTodas: Boolean = False): String;
    Begin
      If fEmptyStr(strCod) Then
        Result := IfThen(blnTodas, 'TODAS', 'TODOS')
      Else
        Result := strCod + IfThen(fEmptyStr(strDes), '', ' - ' + strDes);
    End;
begin
  objGeraExcel := nil;
  Try
    objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

    With objGeraExcel do
    Begin
      strNomRel := 'RELATÓRIO VENDAS POR TIPO DE FATURAMENTO';

      AddFiltro('REFERENTE AO PERÍODO DE ' + mskDtaIni.Text+ ' A ' + mskDtaFin.Text);

      AddFiltro('LINHA/GRUPO: '    + fFiltro(mskLinhaGrupo.Text,       edtDesGrupo.Text              ));
      AddFiltro('PRODUTO: '        + fFiltro(edtProdutos.Text,         edtDesProduto.Text            ));
      AddFiltro('VENDEDOR: '       + fFiltro(strCodVen,                edtDesVendedor.Text           ));
      AddFiltro('REPRESENTANTE: '  + fFiltro(edtCodRepresentante.Text, edtDesRepresentante.Text      ));
      AddFiltro('MARCA: '          + fFiltro(edtMarca.Text,            edtDesMarca.Text,         True));
      AddFiltro('CLIENTE: '        + fFiltro(edtCodCliente.Text,       edtDesCliente.Text            ));
      AddFiltro('REDE DE LOJAS: '  + fFiltro(edtCodRede.Text,          edtDesRede.Text,          True));
      AddFiltro('ESTADO: '         + fFiltro(edtEstado.Text,           edtDesEstado.Text             ));
      AddFiltro('EMPRESA: '        + fFiltro(edtCodEmpresa.Text,       edtDesEmpresa.Text,       True));
      AddFiltro('SOMENTE CLASS.: ' + VS_strClaVen);
      AddFiltro('TABELAS DE PRECO: '+IfThen(fEmptyStr(fRetTabPreSelChkLis(clbTabPre)), 'TODAS', fRetTabPreSelChkLis(clbTabPre)));
      AddFiltro(AnsiUpperCase(gpbCalculo.Caption) + cbbComCus.Text);

      If chkEnt_CD.Checked Then
        AddFiltro(UpperCase(chkEnt_CD.Caption) + ': SIM')
      Else
        AddFiltro(UpperCase(chkEnt_CD.Caption) + ': TODOS');

      Case cbxOpcSin.ItemIndex Of
        0: AddCampo('LINHA', 'COD / LINHA');
        1: AddCampo('CODGRU', 'COD / GRUPO');
        2: AddCampo('DTAENT', 'DATA');
        3: AddCampo('CODMAR', 'COD / MARCA');
        4: AddCampo('CODCLI', 'COD / NOME CLIENTE');
        5: AddCampo('CODVEN', 'COD / NOME VENDEDOR');
        6: AddCampo('CODREP', 'COD / NOME REPRESENTANTE');
      End;

      AddCampo('TOTNF', 'TOT. NF/IF');
      AddCampo('TOTMI', 'TOT. MI');
      AddCampo('TOTFF', 'TOT. FF');
      AddCampo('TOTTR', 'TOT. TR');
      AddCampo('TOTDV', 'TOT. DV');
      AddCampo('VALTOT', 'TOT. GERAL');
      AddCampo('TOTCUS', 'CUSTO');

      If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
        AddCampo('MARGEM', '%MARGEM')
      Else
        AddCampo('MARGEM', '%MARKUP');

      AddTotais('TOTNF');
      AddTotais('TOTMI');
      AddTotais('TOTFF');
      AddTotais('TOTTR');
      AddTotais('TOTDV');

      AddTotais('VALTOT');
      AddTotais('TOTCUS');
      AddTotais('TOTCO');
      AddTotais('TOTBR');
      AddTotais('MAMKP4');
    End;
    
    objGeraExcel.OnMontaResumo := pMontaResumo;
    objGeraExcel.OnSomaResumo := pSomaTotais;
    objGeraExcel.OnImpDetalhes := pImpDetalhe;

    If objGeraExcel.fGerarRelatorio Then
       fMensagem('','Arquivo gerado com sucesso!',['&O k']);
  Finally
    objGeraExcel.Free;
  End;
end;

procedure TfrmRelFatVenTipFat.pGetTotConBri(var fltTotCon, fltTotBri: Double);
  Var
    qryTot: TUniQuery;
begin
  qryTot := fCriaQuery;
  Try
    With qryTot, SQL Do
    Begin
      Add('SELECT SQL_NO_CACHE');
      Add('  IF(DET_ESPDOC = "CO",                                         DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS TOTCON,');
      Add('  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS TOTBRI');
      Add('FROM');
      Add('  MOVDET ');
      Add('  JOIN CADITE ON ITE_CODITE = DET_CODITE');
      Add('  JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR');
      Add('  JOIN CADCLI ON CLI_CODCLI = DET_CODCLI');
      Add('  JOIN CADOPE ON OPE_CODOPE = DET_CODVEN');
      Add('WHERE');
      Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ');
      Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ');
      Add('  (DET_ESPDOC IN ("CO", "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) AND');
      Add('  DET_PROEMB <> "S" AND ');
      Add('  DET_TIP_FC = "C" ');

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If (Length(mskLinhaGrupo.Text) = 6) And
           (RightStr(mskLinhaGrupo.Text, 3) = '000') Then
        Begin
          Add('  AND CONCAT(LEFT(ITE_CODGRU, 3), "000") = :CODGRU');
        End
        Else
          Add('  AND ITE_CODGRU = :CODGRU');
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
        Add('  AND DET_CODITE = :CODITE');

      If Not fEmptyStr(edtCodVendedor.Text) Then
        Add('  AND DET_CODVEN = :CODVEN');

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        Add('  AND DET_CODREP = :CODREP');

      If Not fEmptyStr(edtMarca.Text) Then
        Add('  AND ITE_CODMAR = :CODMAR');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add('  AND DET_CODCLI = :CODCLI');

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        Add('  AND DET_CODEMP = :CODEMP');

      If Not fEmptyStr(fRetTabPreSelChkLis(clbTabPre)) Then
        Add( ' AND DET_TABPRE IN (' + fRetTabPreSelChkLis(clbTabPre) + ')');

      Text := 'SELECT SUM(TOTCON) AS TOTCON, SUM(TOTBRI) AS TOTBRI FROM ('+ Text +') TAB';

      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(edtProdutos.Text) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODVEN').AsString := strCodVen;

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        ParamByName('CODREP').AsString := edtCodRepresentante.Text;

      If Not fEmptyStr(edtMarca.Text) Then
        ParamByName('CODMAR').AsString := edtMarca.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;

      fltTotCon := FieldByName('TOTCON').AsFloat;
      fltTotBri := FieldByName('TOTBRI').AsFloat;
    End;
  Finally
    FreeAndNil(qryTot);
  End;
end;

procedure TfrmRelFatVenTipFat.pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  Var
    strDescri: String;
Begin
  Case cbxOpcSin.ItemIndex Of
    0: strDescri := Dados.FieldByName('LINHA').AsString  + ' - ' + Dados.FieldByName('NOMLIN').AsString;
    1: strDescri := Dados.FieldByName('CODGRU').AsString + ' - ' + Dados.FieldByName('DESGRU').AsString;
    2: strDescri := FormatDateTime('DD/MM/YYYY', Dados.FieldByName('DTAENT').AsDateTime);
    3: strDescri := Dados.FieldByName('CODMAR').AsString + ' - ' + Dados.FieldByName('DESMAR').AsString;
    4: strDescri := Dados.FieldByName('CODCLI').AsString + ' - ' + Dados.FieldByName('NOMCLI').AsString;
    5: strDescri := Dados.FieldByName('CODVEN').AsString + ' - ' + Dados.FieldByName('NOMOPE').AsString;
    6: strDescri := Dados.FieldByName('CODREP').AsString + ' - ' + Dados.FieldByName('NOMREP').AsString;
  End;
  Excel.Escrever(Excel.LinhaAtual, 1, strDescri);
end;

procedure TfrmRelFatVenTipFat.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strLinIni: String;
    fltMargem,
    fltTotCon,
    fltTotBri: Double;
begin
  With Excel Do
  Begin
    ProximaLinha;

    strLinIni := IntToStr(LinhaAtual);

    Escrever(LinhaAtual, 1, 'TOTAL GERAL: ');
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTNF'].Coluna,  Quebra.Totais['TOTNF']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTMI'].Coluna,  Quebra.Totais['TOTMI']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTFF'].Coluna,  Quebra.Totais['TOTFF']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTTR'].Coluna,  Quebra.Totais['TOTTR']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTDV'].Coluna,  Quebra.Totais['TOTDV']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['VALTOT'].Coluna, Quebra.Totais['VALTOT']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna, Quebra.Totais['TOTCUS']);

    If (Quebra.Totais['TOTCUS'] = 0) Or (Quebra.Totais['VALTOT'] = 0) Then
      fltMargem := 0
    Else
    Begin
      If (fCfgSis('MARMKP') = '4') Then
        fltMargem := (((Quebra.Totais['MAMKP4'] / Quebra.Totais['TOTCUS'])-1) * 100)
      Else If Pos(fCfgSis('MARMKP'), '1_5_') = 0 Then
        fltMargem := ((Quebra.Totais['VALTOT'] / Quebra.Totais['TOTCUS']) * 100) - 100
      Else
        fltMargem := (1 - (Quebra.Totais['TOTCUS'] / Quebra.Totais['VALTOT']) )  * 100;
    End;
    Escrever(LinhaAtual, Campos.ColunaPorNome['MARGEM'].Coluna, fltMargem);

    ProximaLinha;

    pGetTotConBri(fltTotCon, fltTotBri);

    Escrever(LinhaAtual, 1, 'TOTAL USO E CONSUMO:');
    Escrever(LinhaAtual, Campos.ColunaPorNome['VALTOT'].Coluna, fltTotCon);

    ProximaLinha;

    Escrever(LinhaAtual, 1, 'TOTAL BRINDE:');
    Escrever(LinhaAtual, Campos.ColunaPorNome['VALTOT'].Coluna, fltTotBri);

    FormatoNumerico('B' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    
    Negrito    ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), CinzaEscuro);
    CorFonte   ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
  End;
end;

procedure TfrmRelFatVenTipFat.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  Totais['TOTNF']  := Totais['TOTNF']  + Dados.FieldByName('TOTNF').AsFloat;
  Totais['TOTMI']  := Totais['TOTMI']  + Dados.FieldByName('TOTMI').AsFloat;
  Totais['TOTFF']  := Totais['TOTFF']  + Dados.FieldByName('TOTFF').AsFloat;
  Totais['TOTTR']  := Totais['TOTTR']  + Dados.FieldByName('TOTTR').AsFloat;
  Totais['TOTDV']  := Totais['TOTDV']  + Dados.FieldByName('TOTDV').AsFloat;
  Totais['VALTOT'] := Totais['VALTOT'] + Dados.FieldByName('VALTOT').AsFloat;
  Totais['TOTCUS'] := Totais['TOTCUS'] + Dados.FieldByName('TOTCUS').AsFloat;
  Totais['MAMKP4'] := Totais['MAMKP4'] + Dados.FieldByName('MAMKP4').AsFloat;
end;

procedure TfrmRelFatVenTipFat.pVerdeVermelho(edtCodVen: TEditFocus;
  shaVen: TShape);
begin
  If (Not blnLiberado) Then
  Begin
    edtCodVen.MaxLength := 10;
    edtCodVen.TamCampo  := 10;
    edtCodVen.CompZeros := False;
    edtCodVen.PasswordChar := '*';
    edtCodVen.TipoTexto := ttAlfanumerico;
    shaVen.Brush.Color  := clRed;
  End
  Else
  Begin
    shaVen.Brush.Color  := clGreen;
  End;
end;

procedure TfrmRelFatVenTipFat.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If (blnLiberado) And (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrSel)) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVenTipFat.edtMarcaExit(Sender: TObject);
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

procedure TfrmRelFatVenTipFat.edtMarcaKeyPress(Sender: TObject;
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

procedure TfrmRelFatVenTipFat.clbTabPreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    If (Key = VK_RETURN) Or (Key = VK_TAB) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelFatVenTipFat.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrCliente, Nil, fRetNomCliente, 'do cliente');
  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtEstado);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelFatVenTipFat.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVenTipFat.pCarregaCliente(Var qryCadCli: TUniQuery);
begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
end;

function TfrmRelFatVenTipFat.fSQLFiltroEmpresa: String;
begin
  If (cbxEmpresa.ItemIndex = 0) Then
    Result := ' DET_CODEMP '
  Else
    Result := ' MOVTRI.DET_EMPORI ';
end;

function TfrmRelFatVenTipFat.fValidaCampos(Sender: TWinControl;
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

    Else If (Sender = mskLinhaGrupo) Then
    Begin

      If fEmptyStr(mskLinhaGrupo.Text) Then
        edtProdutos.Enabled := True
      Else
        edtProdutos.Enabled := False;

    End

    Else If (Sender = edtCodVendedor) Then
    Begin

      If blnLiberado Then
      Begin
        If fEmptyStr(edtCodVendedor.Text) Then
          edtDesVendedor.Text := 'TODOS'
        Else
          edtDesVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);

        If fEmptyStr(edtDesVendedor.Text) And (Not fEmptyStr(edtCodVendedor.Text))  Then
        Begin
          fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
          edtCodVendedor.Clear;
          pSetFocus(edtCodVendedor);
        End;

        strCodVen := edtCodVendedor.Text;
      End

      Else If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        strCodVen := fRetCodVendedor(edtCodVendedor.Text);

        If Not fEmptyStr(strCodVen) Then
          edtDesVendedor.Text := fRetNomVendRep(strCodVen)
        Else
        Begin
          Result := False;
          fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
        End;

      End

      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;

    End

    Else If (Sender = edtEstado) Then
    Begin
      If (Not fEmptyStr(edtEstado.Text)) Then
      Begin
        If (Not fValidaEstado(edtEstado.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O Campo Estado não é valido!', ['&Ok']);
          edtEstado.Clear;
          Result := False;
        End;
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
    Else If (Sender = edtCodRepresentante) Then
    Begin
      If fEmptyStr(edtCodRepresentante.Text) Then
        edtDesRepresentante.Text := 'TODOS'
      Else
        edtDesRepresentante.Text := fRetNomVendRep(edtCodRepresentante.Text);

      If fEmptyStr(edtDesRepresentante.Text) And (Not fEmptyStr(edtCodRepresentante.Text))  Then
      Begin
        fMensagem('AVISO','Código do representante não encontrado.', ['&O K']);
        edtCodRepresentante.Clear;
        Result := False;
      End;
    End;


  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatVenTipFat.btnImprimirClick(Sender: TObject);
Var
    strSQL   : String;
    strSqlDet: String;
    qryGenFat: TUniQuery;
    strCusTmp: String;
    strTotTmp: String;

  Function fGetSqlMargem: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    {*****************************************}
    {* intOpcCalculo -> 1 Margem             *}
    {*               -> 2 MarKup             *}
    {**************************************LA*}
    If (fCfgSis('MARMKP') = '4') Then
    Begin
      strSQL := strSQL + ' IF((((ROUND(SUM(MAMKP4), 2) / ROUND(SUM(TOTCUS), 2))-1)*100) IS NULL, 0, ';
      strSQL := strSQL + '    (((ROUND(SUM(MAMKP4), 2) / ROUND(SUM(TOTCUS), 2))-1)*100)) ';
    End Else
    If Pos(fCfgSis('MARMKP'), '1_5_') = 0 Then
    Begin
      strSQL := strSQL + ' (                                                                  ';
      strSQL := strSQL + '   (                                                                ';
      strSQL := strSQL + '      SUM(IFNULL(VALTOT , 0) ) / ';
      strSQL := strSQL + '      IF(SUM(TOTCUS) = 0,        ';
      strSQL := strSQL + '         1,                                                         ';
      strSQL := strSQL + '         SUM(TOTCUS))            ';
      strSQL := strSQL + '    ) * 100                                                         ';
      strSQL := strSQL + ' ) - 100                                                            ';
    End Else
    Begin
      strSQL := strSQL + ' (                                                                    ';
      strSQL := strSQL + '   (                                                                  ';
      strSQL := strSQL + '     1 -                                                              ';
      strSQL := strSQL + '     (                                                                ';
      strSQL := strSQL + '       SUM(IFNULL( TOTCUS , 0) ) /  ';
      strSQL := strSQL + '       IF(SUM(VALTOT) = 0,         ';
      strSQL := strSQL + '          1,                                                          ';
      strSQL := strSQL + '          SUM(VALTOT))            ';
      strSQL := strSQL + '     )                                                                ';
      strSQL := strSQL + '   )                                                                  ';
      strSQL := strSQL + ' ) * 100                                                              ';
    End;


    Result := ' ( ' + strSQL + ') ';
  End;

begin

  qryGenFat := fCriaQuery(Self);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If fEmptyStr(strCodVen) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor!', ['&Ok']);
    pSetFocus(edtCodVendedor);
  End;

  If blnImprime Then
  Begin
    strTotTmp := '  (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) ';

    If (fCfgSis('MARMKP') = '4') Then
      strCusTmp := ' IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * IFNULL(DET_TOTCUS,0) '
    Else
      strCusTmp := ' IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  DET_CODVEN AS CODVEN, ';
    strSQL := strSQL + '  DET_CODREP AS CODREP, ';
    strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  DET_CLAFIS AS CLAFIS, ';
    strSQL := strSQL + '  IF(DET_ESPDOC IN ("NF","EL","IF","IV","D1") AND LEFT(DET_CLAFIS,1) >= 5, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0) AS TOTNF, ';
    strSQL := strSQL + '  IF(DET_ESPDOC IN ("MI"),                IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0) AS TOTMI, ';
    strSQL := strSQL + '  IF(DET_ESPDOC IN ("FF"),                IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0) AS TOTFF, ';
    strSQL := strSQL + '  IF(DET_ESPDOC IN ("TR"),                IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0) AS TOTTR, ';
    strSQL := strSQL + '  IF(DET_ESPDOC IN ("DV","PD","NF") AND LEFT(DET_CLAFIS,1) < 5, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0) AS TOTDV, ';
    strSQL := strSQL + '  IFNULL(' + fMarkup4(strTotTmp) + ', 0) AS MAMKP4, ';
    strSQL := strSQL + strTotTmp + ' AS VALTOT, ';
    strSQL := strSQL + strCusTmp + ' AS TOTCUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  JOIN CADCLI    ON DET_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  JOIN CADITE    ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + '  JOIN MOVGER    ON DET_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  JOIN AUXMOV A  ON A.AUX_SEQGER  = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  JOIN CADEMP EP ON EP.EMP_CODEMP = DET_CODEMP  ';
    strSQL := strSQL + '  JOIN CADCID CE ON CE.CID_CODCID = EP.EMP_CODCID ';
    strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM AND MOVDET.DET_VALRET = 0 ';

    If chkEnt_CD.Checked Then
    Begin
      strSQL := strSQL + '  LEFT JOIN FATGOR ON DET_NUM_PD = FGO_NUMDOC AND ';
      strSQL := strSQL + '                      DET_ESP_PD = FGO_ESPDOC AND ';
      strSQL := strSQL + '                      DET_EMP_PD = FGO_CODEMP ';
    End;

    strSQL := strSQL + ' LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

    strSQL := strSQL + cnsFiltroFFDVTR;    

    If chkEnt_CD.Checked Then
      strSQL := strSQL + '  COALESCE(FGO_ENT_CD, "N") = "S" AND ';

    strSQL := strSQL + '  DET_PROEMB <> "S"                       AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"                        AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)  ';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If (Length(mskLinhaGrupo.Text) = 6) And
         (RightStr(mskLinhaGrupo.Text, 3) = '000') Then
      Begin
        strSQL := strSQL + '  AND CONCAT(LEFT(ITE_CODGRU, 3), "000") = :CODGRU ';
      End
      Else
        strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    End;

    If Not fEmptyStr(edtProdutos.Text) Then
      strSQL := strSQL + '  AND DET_CODITE = :CODITE ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + '  AND DET_CODVEN = :CODVEN ';

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      strSQL := strSQL + '  AND DET_CODREP = :CODREP ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + '  AND DET_CODCLI = :CODCLI ';

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND DET_ESTADO = :ESTADO ';

    If Not fEmptyStr(fRetTabPreSelChkLis(clbTabPre)) Then
      strSQL := strSQL + ' AND DET_TABPRE IN (' + fRetTabPreSelChkLis(clbTabPre) + ')';

    {**************************************}
    {* REDE DE LOJAS - ACRESCENTOU FILTRO *}
    {***********************************DP*}
    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND ' + fSQLFiltroEmpresa + ' = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(' + fSQLFiltroEmpresa + ',' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSqlDet := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CODMAR, ';
    strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '  CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CODVEN, ';
    strSQL := strSQL + '  CODREP, ';
    strSQL := strSQL + '  VEN.OPE_NOMOPE AS NOMOPE, ';
    strSQL := strSQL + '  REP.OPE_NOMOPE AS NOMREP, ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  GRU_DESGRU AS DESGRU, ';
    strSQL := strSQL + '  CONCAT(LEFT(CODGRU,3),"000") AS LINHA, ';
    strSQL := strSQL + '  (SELECT SQL_NO_CACHE GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = LINHA ) AS NOMLIN,   ';
    strSQL := strSQL + '  DTAENT, ';
    strSQL := strSQL + '  CLAFIS, ';
    strSQL := strSQL + '  SUM(TOTNF) AS TOTNF, ';
    strSQL := strSQL + '  SUM(TOTMI) AS TOTMI, ';
    strSQL := strSQL + '  SUM(TOTFF) AS TOTFF, ';
    strSQL := strSQL + '  SUM(TOTTR) AS TOTTR, ';
    strSQL := strSQL + '  SUM(TOTDV) AS TOTDV, ';
    strSQL := strSQL + '  SUM(VALTOT) AS VALTOT, ';
    strSQL := strSQL + '  SUM(TOTCUS) AS TOTCUS, ';
    strSQL := strSQL + '  SUM(MAMKP4) AS MAMKP4, ';

    strSQL := strSQL +  fGetSqlMargem +  '   AS MARGEM ';

    strSQL := strSQL + 'FROM (' + strSqlDet + ' ) AS TAB ';

    strSQL := strSQL + ' INNER JOIN CADCLI ON CODCLI = CLI_CODCLI  ';
    strSQL := strSQL + ' LEFT  JOIN CADGRU ON GRU_CODGRU = CODGRU  ';
    strSQL := strSQL + ' LEFT  JOIN CADMAR ON MAR_CODMAR = CODMAR  ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE VEN ON VEN.OPE_CODOPE = CODVEN ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE REP ON REP.OPE_CODOPE = CODREP ';

    strSQL := strSQL + 'GROUP BY ';

    Case cbxOpcSin.ItemIndex Of
      0: Begin
          strSQL := strSQL + '  LINHA ';
          strSQL := strSQL + 'ORDER BY ';
          strSQL := strSQL + '  LINHA ';
         End;
      1: Begin
           strSQL := strSQL + '  CODGRU ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  CODGRU ';
         End;
      2: Begin
           strSQL := strSQL + '  DTAENT ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  DTAENT ';
         End;
      3: Begin
           strSQL := strSQL + '  CODMAR ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  CODMAR ';
         End;
      4: Begin
           strSQL := strSQL + '  CODCLI ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  CODCLI ';
         End;
      5: Begin
           strSQL := strSQL + '  CODVEN ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  CODVEN ';
         End;
      6: Begin
           strSQL := strSQL + '  CODREP ';
           strSQL := strSQL + 'ORDER BY ';
           strSQL := strSQL + '  CODREP ';
         End;
    End;

    QryRel := fCriaQuery;

    frxRelatorio.DataSet := QryRel;

    With QryRel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(edtProdutos.Text) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODVEN').AsString := strCodVen;

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        ParamByName('CODREP').AsString := edtCodRepresentante.Text;

      If Not fEmptyStr(edtMarca.Text) Then
        ParamByName('CODMAR').AsString := edtMarca.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      pSetaParamOR(edtCodRede,arrRede,'CODRED',QryRel);

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;
    End;

    If Not QryRel.IsEmpty Then
    Begin
      If edtDestino.Text = 'E' Then
        pGeraExcel(QryRel)
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckFatVenTipFat,frmQckFatVenTipFat);

          frmQckFatVenTipFat.dtaDtaIni := StrToDate(mskDtaIni.Text);
          frmQckFatVenTipFat.dtaDtaFin := StrToDate(mskDtaFin.Text);
          frmQckFatVenTipFat.strLinGru := mskLinhaGrupo.Text;
          frmQckFatVenTipFat.strCodIte := edtProdutos.Text;
          frmQckFatVenTipFat.strCodVen := strCodVen;
          frmQckFatVenTipFat.strCodRep := edtCodRepresentante.Text;
          frmQckFatVenTipFat.strCodMar := edtMarca.Text;
          frmQckFatVenTipFat.strCodCli := edtCodCliente.Text;
          frmQckFatVenTipFat.strCodEmp := edtCodEmpresa.Text;
          frmQckFatVenTipFat.clbTabPre := clbTabPre;

          If strTipImp = 'M' Then
            frmQckFatVenTipFat.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFatVenTipFat.qckPagina.DefaultFilter := Nil;

          frmQckFatVenTipFat.rllCusto.Visible        := blnLiberado;
          frmQckFatVenTipFat.rdbCusto.Visible        := blnLiberado;
          frmQckFatVenTipFat.rdbResultCusto.Visible  := blnLiberado;
          frmQckFatVenTipFat.rllMargem.Visible       := blnLiberado;
          frmQckFatVenTipFat.rdbMargem.Visible       := blnLiberado;
          frmQckFatVenTipFat.rdbResultMargem.Visible := blnLiberado;

          If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
            frmQckFatVenTipFat.rllMargem.Caption := '%MARGEM'
          Else
            frmQckFatVenTipFat.rllMargem.Caption := '%MARKUP';

          {********************}
          {* CABEÇALHO DO QCK *}
          {*****************LB*}

          frmQckFatVenTipFat.rllNomeRelatorio.Caption := IfThen(strTipImp = 'M','RELATORIO','RELATÓRIO')+' VENDAS POR TIPO DE FATURAMENTO ';

          frmQckFatVenTipFat.strOrdem := 'REFERENTE AO '+IfThen(strTipImp = 'M','PERIODO','PERÍODO')+' DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If fEmptyStr(mskLinhaGrupo.Text) Then
            frmQckFatVenTipFat.rllLinhaGrupo.Caption := 'LINHA/GRUPO: TODOS '
          Else
            frmQckFatVenTipFat.rllLinhaGrupo.Caption := 'LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text;

          If fEmptyStr(edtProdutos.Text) Then
            frmQckFatVenTipFat.rllProduto.Caption := 'PRODUTO: TODOS'
          Else
            frmQckFatVenTipFat.rllProduto.Caption := 'PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text;

          If fEmptyStr(edtCodVendedor.Text) Then
            frmQckFatVenTipFat.rllVendedor.Caption := 'VENDEDOR: TODOS'
          Else
            frmQckFatVenTipFat.rllVendedor.Caption := 'VENDEDOR: ' + strCodVen + ' - ' + edtDesVendedor.Text;

          If fEmptyStr(edtCodRepresentante.Text) Then
            frmQckFatVenTipFat.rllRepresentante.Caption := 'REPRESENTANTE: TODOS'
          Else
            frmQckFatVenTipFat.rllRepresentante.Caption := 'REPRESENTANTE: ' + edtCodRepresentante.Text + ' - ' + edtDesRepresentante.Text;

          If fEmptyStr(edtMarca.Text) Then
            frmQckFatVenTipFat.rllMarca.Caption := 'MARCA: TODOS '
          Else
            frmQckFatVenTipFat.rllMarca.Caption := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text;

          If fEmptyStr(edtCodCliente.Text) Then
            frmQckFatVenTipFat.rllCliente.Caption := 'CLIENTE: TODOS '
          Else
            frmQckFatVenTipFat.rllCliente.Caption := 'CLIENTE: ' + edtCodCliente.Text + ' - ' + edtDesCliente.Text;

          If fEmptyStr(edtCodRede.Text) Then
            frmQckFatVenTipFat.rllRedeLoja.Caption := 'REDE DE LOJAS: TODAS '
          Else
            frmQckFatVenTipFat.rllRedeLoja.Caption := 'REDE DE LOJAS: ' + edtCodRede.Text + ' - ' + edtDesRede.Text;

          If fEmptyStr(edtEstado.Text) Then
            frmQckFatVenTipFat.rllEstado.Caption := 'ESTADO: TODOS '
          Else
            frmQckFatVenTipFat.rllEstado.Caption := 'ESTADO: ' + edtEstado.Text + ' - ' + edtDesEstado.Text;

          If fEmptyStr(edtCodEmpresa.Text) Then
            frmQckFatVenTipFat.rllEmpresa.Caption := 'EMPRESA: TODOS ' + IfThen(cbxEmpresa.ItemIndex = 0, '  [FATURAMENTO]', '   [ORIGEM]')
          Else
            frmQckFatVenTipFat.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text + IfThen(cbxEmpresa.ItemIndex = 0, '  [FATURAMENTO]', '   [ORIGEM]');

          frmQckFatVenTipFat.rllCustoFil.Caption := AnsiUpperCase(gpbCalculo.Caption) + cbbComCus.Text;

          If fEmptyStr(fRetTabPreSelChkLis(clbTabPre)) Then
            frmQckFatVenTipFat.rllTab.Caption := 'TABELAS DE PREÇO: TODAS'
          Else
            frmQckFatVenTipFat.rllTab.Caption := 'TABELAS DE PREÇO: ' + fRetTabPreSelChkLis(clbTabPre);

          {******************************************************}
          {* ATRIBUI O NOME NA BANDA TITULO E NA BANDA DETALHES *}
          {* DO QCK DE ACORDO COM A OPÇAO ESCOLHIDA             *}
          {***************************************************LB*}
          Case cbxOpcSin.ItemIndex Of
            0: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+'  /  LINHA ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('LINHA').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('NOMLIN').FieldName;
               End;
            1: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+'  /  GRUPO ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('CODGRU').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('DESGRU').FieldName;
               End;
            2: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption :=  'DATA ';
                 frmQckFatVenTipFat.rdbOpcao.DataField := QryRel.FieldByName('DTAENT').FieldName;
               End;
            3: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+' /  MARCA ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('CODMAR').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('DESMAR').FieldName;
               End;
            4: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+'  /  NOME CLIENTE ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('CODCLI').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('NOMCLI').FieldName;
               End;
            5: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+'  /  NOME VENDEDOR ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('CODVEN').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('NOMOPE').FieldName;
               End;
            6: Begin
                 frmQckFatVenTipFat.rllNomeOpcao.Caption  := IfThen(strTipImp = 'M','CODIGO','CÓDIGO')+'  /  NOME REPRESENTANTE ';
                 frmQckFatVenTipFat.rdbOpcao.DataField    := QryRel.FieldByName('CODREP').FieldName;
                 frmQckFatVenTipFat.rdbDesOpcao.DataField := QryRel.FieldByName('NOMREP').FieldName;
               End;
          End;

          frmQckFatVenTipFat.rllPag.Caption := IfThen(strTipImp = 'M','PAGINA','PÁGINA');
          If chkEnt_CD.Checked Then
            frmQckFatVenTipFat.rllEnt_CD.Caption := UpperCase(chkEnt_CD.Caption) + ': SIM'
          Else
            frmQckFatVenTipFat.rllEnt_CD.Caption := UpperCase(chkEnt_CD.Caption) + ': TODOS';

          frmQckFatVenTipFat.dtsRelatorio.DataSet := QryRel;
          frmQckFatVenTipFat.qckPagina.DataSource := frmQckFatVenTipFat.dtsRelatorio;

          If edtDestino.Text = 'V' Then
            frmQckFatVenTipFat.qckPagina.PreviewModal
          Else
            frmQckFatVenTipFat.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFatVenTipFat);
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';

  End;

  FreeAndNil(qryGenFat);

end;

procedure TfrmRelFatVenTipFat.mskLinhaGrupoKeyPress(Sender: TObject;
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

procedure TfrmRelFatVenTipFat.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelFatVenTipFat.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelFatVenTipFat.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatVenTipFat.edtCodRedeKeyPress(Sender: TObject;
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

procedure TfrmRelFatVenTipFat.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatVenTipFat.edtEstadoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEstado.Text) Then
    edtDesEstado.Text := 'TODOS'
  Else
  Begin
    If Not fValidaEstado(edtEstado.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Estado não é válido.', ['&O K']);
      edtEstado.Clear;
      pSetFocus(edtEstado);
    End
    Else
      edtDesEstado.Text := fRetNomeEstado(edtEstado.Text);
  End;
end;

function TfrmRelFatVenTipFat.fMarkup4(strCampoTotIte: String): String;

  function fEhSubstituido: String;
  begin
    Result := ' (LOCATE(DET_CODFIS, ' + QuotedStr(CST_SUBSTITUICAO) + ') > 0) ';
  end;

  function fDentroEstado: String;
  begin
    Result := ' ((DET_ESTADO = CE.CID_ESTADO) OR (IFNULL(A.AUX_VENPRE, "N") = "S")) ';
  end;

  function fIcmSai: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ' , 0.00, ROUND((IFNULL(DET_ICMSAI,0) / ' + '(' + strCampoTotIte + ')) * 100, 2))) ';
  end;

  function fImpFed: String;
  begin
    Result := ' (ROUND((IFNULL(DET_IMPFED,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fDesOpe: String;
  begin
    Result := ' (ROUND((IFNULL(DET_DESOPE,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fComTbl: String;
  begin
    Result := ' (0.00) ';
  end;

  function fIcmsST: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ', (IFNULL(DET_ICMPAV, 0)*DET_QTDITE), 0.00)) ';
  end;

begin
  Result := 'ROUND((' + strCampoTotIte + ' * (1 - ((' + fIcmSai + ' + ' + fImpFed + ' + ' + fDesOpe + ' + ' + fComTbl +  ')/100)) - (' + fIcmsST + ')' + '), 2)';
end;

end.
