{***************************}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untRelChqEmCustodia;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, untTypesSistema,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, Uni, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem, untFuncoesFactory, untGeraExcel, DB,
  untExcel, frxExportCSVTestabilidade, untIFuncoes, untMskC_G_C_;

type
  TfrmRelChqEmCustodia = class(TfrmPaiRelatorio)
    gpbOrdem: TGroupBox;
    edtOrdem: TEditFocus;
    Label9: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    edtCodPor: TEditFocus;
    ColorLabel2: TColorLabel;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    rdgOpcChq: TRadioGroup;
    lbl1: TLabel;
    edtLotCus: TEditFocus;
    chkLotCus: TCheckBox;
    Label2: TLabel;

    Label3: TLabel;

    Label4: TLabel;
    Label5: TLabel;
    mskDtaIniVen: TMaskEditFocus;
    mskDtaFinVen: TMaskEditFocus;
    edtNomEmit: TEditFocus;
    edtValidaCnpjCpf: TEditFocus;
    lblCnpjCpf: TLabel;
    mskCnpjCpf: TMaskEditC_G_C_;
    lblEmit: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure pCarregaPortador;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryConPor: TUniQuery;

    arrPortador,
    arrClientes,
    arrEmp,
    arrEmi   : TConsultasArray;

    strClientes : String;
    strPortador : String;
    strEmp      : String;
    strNomEmi, strEndere, strTele01, strCgc: String;

    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    procedure pGeraExcel;
    function fRetornaCpfCnpjFormatado: String;
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelChqEmCustodia: TfrmRelChqEmCustodia;

implementation

uses untQckChqEmCustodia, untClassPanelcx,untFuncoesGenerica;

{$R *.dfm}

procedure TfrmRelChqEmCustodia.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  inherited;

  blnExcel := True;
  shpMultSel.Visible := True;

end;

procedure TfrmRelChqEmCustodia.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strPeriodo : String;
begin
  inherited;
  {***********************************}
  {* VERIFICACAO DAS DATAS           *}
  {********************************LE*}

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) and fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) OR
    (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) and fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) Then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    Exit;
  End;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  Q.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  P.POR_NOMPOR, ';
    strSQL := strSQL + fRetornaCpfCnpjFormatado; 
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADPOR P  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODCLI = CLI_CODCLI      ';
    strSQL := strSQL + '  AND CHQ_PORCUS = POR_CODPOR  ';

    if (not fEmptyDate(mskDtaIni.Text)) And (not fEmptyDate(mskDtaFin.Text)) then
      strSQL := strSQL + ' AND CHQ_DTACUS BETWEEN :DTAINI AND :DTAFIN ';

    if (not fEmptyDate(mskDtaIniVen.Text)) And (not fEmptyDate(mskDtaFinVen.Text)) then
      strSQL := strSQL + ' AND CHQ_DTAVEN BETWEEN :DTAINIVEN AND :DTAFINVEN ';

    If Not fEmptyStr(edtLotCus.Text) Then
      strSQL := strSQL + '  AND CHQ_LOTCUS = :LOTCUS ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text))then
      strSQL := strSQL + ' AND Q.CHQ_C_G_C_ = :CADEMI_C_G_C_  ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CHQ_PORCUS', 'PORCUS')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(CHQ_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(CHQ_PORCUS, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(CHQ_PORDEB, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(CHQ_PORCHQ, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If Not fEmptyStr(edtCliente.Text) Then
      strSQL := strSQL + fStrLocate(edtCliente, arrClientes, 'CHQ_CODCLI', 'CODCLI');

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CHQ_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If (rdgOpcChq.ItemIndex = 1) Then
      strSQL := strSQL + '  AND IFNULL(CHQ_DTADEP, "") = "" '
    Else If (rdgOpcChq.ItemIndex = 2) Then
      strSQL := strSQL + '  AND IFNULL(CHQ_DTADEP, "") <> "" ';

    strSQL := strSQL + ' ORDER BY ';

    If edtDestino.Text = 'E' Then
      strSQL := strSQL + '  CHQ_CODEMP, CHQ_DTAVEN, CHQ_CODBCO, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ '
    Else
    Begin
      If edtOrdem.Text = 'C' Then
        strSQL := strSQL + '  CHQ_DTACUS '
      Else
        strSQL := strSQL + '  CHQ_DTAVEN ';
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      if (not fEmptyDate(mskDtaIni.Text)) And (not fEmptyDate(mskDtaFin.Text)) then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;  

      if (not fEmptyDate(mskDtaIniVen.Text)) And (not fEmptyDate(mskDtaFinVen.Text)) then
      Begin
        ParamByName('DTAINIVEN').AsDate := StrToDate(mskDtaIniVen.Text);
        ParamByName('DTAFINVEN').AsDate := StrToDate(mskDtaFinVen.Text);
      End;

      If Not fEmptyStr(edtLotCus.Text) Then
        ParamByName('LOTCUS').AsString := edtLotCus.Text;

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'PORCUS', qryRelatorio);

      If Not fEmptyStr(edtCliente.Text) Then
        pSetaParam(edtCliente.Text, arrClientes, strClientes, 'CODCLI', qryRelatorio);

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text))then
        pSetaParam(mskCnpjCpf.Text,arrEmi,strCgc,'CADEMI_C_G_C_',qryRelatorio);

      Open;

    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckChqEmCustodia,frmQckChqEmCustodia);

        frmQckChqEmCustodia.dtsRelatorio.DataSet := qryRelatorio;

        frmQckChqEmCustodia.rllNomeRelatorio.Caption := 'RELATORIO DE CHEQUES EM CUSTODIA';

        If strTipImp = 'M' Then
          frmQckChqEmCustodia.qckPagina.DefaultFilter := rldFiltro
        Else frmQckChqEmCustodia.qckPagina.DefaultFilter := Nil;


        strPeriodo := '';

        if (not fEmptyDate(mskDtaIni.Text)) And (not fEmptyDate(mskDtaFin.Text)) then
          strPeriodo := mskDtaIni.Text + ' A ' + mskDtaFin.Text + ' (CUSTODIA) ';

        if (not fEmptyDate(mskDtaIniVen.Text)) And (not fEmptyDate(mskDtaFinVen.Text)) then
        Begin
          If Not fEmptyStr(strPeriodo) Then
            strPeriodo := strPeriodo + ' E ';

          strPeriodo := strPeriodo + mskDtaIniVen.Text + ' A ' + mskDtaFinVen.Text + ' (VENCIMENTO) ';
        End;

        frmQckChqEmCustodia.strOrdem := 'REFERENTE AO PERIODO DE ' + strPeriodo ;


        If edtCodPor.Text = '' Then
          frmQckChqEmCustodia.rllPor.Caption := 'PORTADOR: TODOS'
        Else frmQckChqEmCustodia.rllPor.Caption := fStrTitulo(edtCodPor.Text, edtDesPor, arrPortador, strPortador, 'PORTADOR');

        If edtCliente.Text = '' Then
          frmQckChqEmCustodia.rllCliente.Caption := 'CLIENTE: TODOS'
        Else frmQckChqEmCustodia.rllCliente.Caption := fStrTitulo(edtCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE');

        If edtCodEmpresa.Text = '' Then
          frmQckChqEmCustodia.rllEmpresa.Caption := 'EMPRESA: TODAS'
        Else frmQckChqEmCustodia.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');

        If fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text))then
          frmQckChqEmCustodia.rllCgc.Caption := 'EMITENTE: TODOS'
         Else frmQckChqEmCustodia.rllCgc.Caption := 'EMITENTE:'+ edtNomEmit.Text;

        If edtOrdem.Text = 'C' Then
        Begin
          frmQckChqEmCustodia.rllOrdenacao.Caption := 'ORDEM: CUSTODIA';
          frmQckChqEmCustodia.blnVencimento        := False;
          frmQckChqEmCustodia.rlbGrupo.DataFields  := 'CHQ_DTACUS';
        End
        Else
        Begin
          frmQckChqEmCustodia.rllOrdenacao.Caption := 'ORDEM: VENCIMENTO';
          frmQckChqEmCustodia.blnVencimento        := True;
          frmQckChqEmCustodia.rlbGrupo.DataFields  := 'CHQ_DTAVEN';
        End;

        If fEmptyStr(edtLotCus.Text) Then
          frmQckChqEmCustodia.rllNroLote.Caption   := ''
        Else frmQckChqEmCustodia.rllNroLote.Caption   := 'LOTE DE CUSTODIA: ' + edtLotCus.Text;

        If chkLotCus.Checked Then
        Begin
          frmQckChqEmCustodia.rllCusLot.DataField  := 'CHQ_LOTCUS';
          frmQckChqEmCustodia.rllCabCusLot.Caption := 'NRO. LOTE';
          frmQckChqEmCustodia.rllNroLote.Visible   := False;
        End
        Else
        Begin
          frmQckChqEmCustodia.rllCusLot.DataField  := 'CHQ_DOCCUS';
          frmQckChqEmCustodia.rllCabCusLot.Caption := 'DOC. CUSTODIA';
          frmQckChqEmCustodia.rllNroLote.Visible   := True;
        End;

        If (rdgOpcChq.ItemIndex = 2) Then
          frmQckChqEmCustodia.rllFiltro.Caption := 'FILTRO: DEPOSITADOS'
        Else If (rdgOpcChq.ItemIndex = 1) Then
          frmQckChqEmCustodia.rllFiltro.Caption := 'FILTRO: EM ABERTO'
        Else
          frmQckChqEmCustodia.rllFiltro.Caption := 'FILTRO: TODOS';

        If edtDestino.Text = 'V' Then
          frmQckChqEmCustodia.qckPagina.PreviewModal
        Else If edtDestino.Text = 'I' Then
          frmQckChqEmCustodia.qckPagina.Print
        Else
          pGeraExcel;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckChqEmCustodia);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pSetFocus(edtOrdem);
end;

procedure TfrmRelChqEmCustodia.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrPortador, False) Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqEmCustodia.pCarregaPortador;
begin

  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmRelChqEmCustodia.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelChqEmCustodia.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(qryRelatorio, Nil);

  If objGeraExcel <> Nil Then
  Begin

    With objGeraExcel Do
    Begin
      strNomRel := 'RELATORIO DE CHEQUES EM CUSTÓDIA';
      pnlInfo.Caption := 'Aguarde... Gerando Relatório...';
      pnlInfo.Repaint;

    {***********************************}
    {* VERIFICA DATAS AO GERAR O EXECEL*}
    {********************************LE*}
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) and Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))
      and Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) and Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text)) Then
        AddFiltro('PERIODO: DE (CUSTÓDIA) ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A '
        + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text))
        +' E (VENCIMENTO) DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIniVen.Text))
        + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFinVen.Text)))

      Else If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) and Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        AddFiltro('PERIODO: DE (CUSTÓDIA) ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)))

      Else If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) and Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text)) Then
        AddFiltro('PERIODO: DE (VENCIMENTO) ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIniVen.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFinVen.Text)));

      AddFiltro(fStrTitulo(edtCodPor.Text,     edtDesPor,     arrPortador, strPortador, 'PORTADOR'));
      AddFiltro(fStrTitulo(edtCliente.Text,    edtDesCliente, arrClientes, strClientes, 'CLIENTE'));
      AddFiltro(fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp,      strEmp,      'EMPRESA'));
      AddFiltro(IfThen(fEmptyStr(mskCnpjCpf.Text), 'EMITENTE: TODOS','EMITENTE: '+ edtNomEmit.Text));
      AddFiltro(IfThen(fEmptyStr(edtLotCus.Text), '', 'LOTE CUSTÓDIA: ' + edtLotCus.Text));

      // EMP / BANCO / AGENCIA / CONTA CORRENTE / CHEQUE / CLIENTE / EMITENTE / CPF/CNPJ / DTA.CUSTODIA
      // DTA.VENCIMENTO / VR.CHEQUE

      AddCampo( 'CHQ_CODEMP', 'EMPRESA');
      AddCampo( 'CHQ_CODBCO', 'BANCO');
      AddCampo( 'CHQ_NUMAGE', 'AGENCIA');
      AddCampo( 'CHQ_CONCOR', 'CONTA CORRENTE');
      AddCampo( 'CHQ_NUMCHQ', 'CHEQUE');
      AddCampo( 'CLI_NOMCLI', 'CLIENTE');
      AddCampo( 'CHQ_NOMEMI', 'EMITENTE');
      AddCampo( 'CGC_CPF',    'CPF/CNPJ');
      AddCampo( 'CHQ_DTACUS', 'DTA CUSTODIA');
      AddCampo( 'CHQ_DTAVEN', 'DTA VENCTO');
      AddCampo( 'CHQ_VALCHQ', 'VLR. CHEQUE');
      
      If chkLotCus.Checked Then
        AddCampo('CHQ_LOTCUS', 'NRO. LOTE')
      Else
        AddCampo('CHQ_DOCCUS', 'DOC. CUSTODIA');

      AddQuebra('CHQ_DTAVEN', 'VENCTO', False);
      AddTotais('TOTCHQ'); 
 //     AddTotais('DTACHQ');

      OnSomaResumo  := pSomaTotais;
      OnMontaResumo := pMontaResumo;
    End;

    If objGeraExcel.fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

    FreeAndNil(objGeraExcel);
  End
  Else
    pMensagemOK('Aplicativo não encontrado [Oficce até 2007 ou BROffice]');

  pnlInfo.Caption := '';
end;

procedure TfrmRelChqEmCustodia.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'CHQ_DTAVEN') Then
    Begin
      ProximaLinha;
      Mesclar ('A' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual) );
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito(LinhaAtual,  Campos.ColunaPorNome['CHQ_CODEMP'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['CHQ_CODEMP'].Coluna, 'TOTAL VENCTO: ' + Quebra.ValorAtual);
      Negrito(LinhaAtual,  Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTCHQ']), 14));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, Direita);
    End;
    If (Quebra.NomeCampo = '[GERAL]') Then
    Begin
      ProximaLinha;
      Mesclar ('A' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual) );
      Bordas('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito(LinhaAtual,  Campos.ColunaPorNome['CHQ_CODEMP'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['CHQ_CODEMP'].Coluna, 'TOTAL GERAL: ');
      Negrito(LinhaAtual,  Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, True);
      Escrever(LinhaAtual, Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTCHQ']), 14));
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['CHQ_VALCHQ'].Coluna, Direita);
    End;
  End;
end;

procedure TfrmRelChqEmCustodia.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['TOTCHQ'] := Totais['TOTCHQ'] + Dados.FieldByName('CHQ_VALCHQ').AsFloat ;   
//  Totais['DTACHQ'] := Dados.FieldByName('CHQ_DTACUS').AsFloat ;
end;

function TfrmRelChqEmCustodia.fRetornaCpfCnpjFormatado: String;
begin
  Result :=          '  IF(  ' ;
  Result := Result + '      CHQ_CGCCPF = "2",       ';
  Result := Result + '      CONCAT(                 ';
  Result := Result + '      MID(CHQ_C_G_C_, 1, 3),  ';
  Result := Result + '      ".",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 4, 3),  ';
  Result := Result + '      ".",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 7, 3),  ';
  Result := Result + '      "-",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 10, 2)  ';
  Result := Result + '    ),                        ';
  Result := Result + '    CONCAT(                   ';
  Result := Result + '      MID(CHQ_C_G_C_, 1, 2),  ';
  Result := Result + '      ".",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 3, 3),  ';
  Result := Result + '      ".",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 6, 3),  ';
  Result := Result + '      "/",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 9, 4),  ';
  Result := Result + '      "-",                    ';
  Result := Result + '      MID(CHQ_C_G_C_, 13, 2)  ';
  Result := Result + '    )                         ';
  Result := Result + '  ) AS CGC_CPF                ';
end;

function TfrmRelChqEmCustodia.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
     {*********************}
    {* VALIDA DATAS      *}
    {******************LE*}
   If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final de custódia informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de custódia deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de custódia deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data Inicial de custódia deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de custódia informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End
    Else

     {******************************}
    {* VALIDA DATAS VENCIMENTO     *}
    {******************LE***********}

    If (Sender = mskDtaFinVen) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (StrToDateDef(mskDtaFinVen.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIniVen;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) Then
          Begin
            If StrToDate(mskDtaIniVen.Text) > StrToDate(mskDtaFinVen.Text) Then
            Begin
              fMensagem('','A data Inicial de vencimento deve ser menor que a data final de Vencimento!',['&O K']);
              Result := False;
              Sender := mskDtaIniVen;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIniVen) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) and (StrToDateDef(mskDtaIniVen.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIniVen;
      End;
    End
    Else
    {******************}
    {* VERIFICA ORDEM *}
    {***************AF*}
    If (Sender = edtOrdem) Then
    Begin
      If edtOrdem.Text = '' Then
      Begin

        fMensagem('ATENÇÃO!','O campo ordem deve ser preenchido!',['&O K']);
        Result := False;

      End
      Else
      Begin

        If (edtOrdem.Text <> 'C') And (edtOrdem.Text <> 'V') Then
        Begin
          fMensagem('ATENÇÃO!','O campo ordem deve ser C ou V!',['&O K']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
        edtDesPor.Text := 'TODOS'
      Else If (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pDesmarcaLista(edtCodEmpresa, arrEmp)
      Else
        edtDesEmpresa.Text := 'TODOS';
    End

    Else If (Sender = edtCliente) Then
    Begin

      If fEmptyStr(edtCliente.Text) Then
        edtDesCliente.Text := 'TODOS';
    End

    {***********************************}
    {*  RETORNA NOME POR  CPF OU CNPJ  *}
    {********************************LE*}
    Else if (Sender = edtValidaCnpjCpf) Then
    Begin
      If edtValidaCnpjCpf.Text = '' Then
      Begin
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
      End
      Else Begin
        If Pos(edtValidaCnpjCPf.Text,'1_2') <= 0  Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CNPJ/CPF deve ser 1 ou 2!', ['&OK']);
          Result := False;
        End
        Else Begin
          mskCnpjCpf.Enabled := True;
          If edtValidaCnpjCPf.Text = '1'  Then
            mskCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
          Else
            mskCnpjCPf.EditMask := fRetMascaraC_G_C_(fSetaPais,C_P_F_);
        End;
      End;
    End

    Else if (Sender = mskCnpjCpf) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
      Begin
        strCgc := fTiraCaracEspeciais(mskCnpjCpf.Text);
        If (Length(strCgc) < 14) AND (edtValidaCnpjCpf.Text = '1') OR   (Length(strCgc) < 11) OR
         (Length(strCgc) > 11) AND (edtValidaCnpjCpf.Text = '2') Then
        Begin
          fMensagem('ATENÇÃO', mskCnpjCpf.Text + ' não é um número de '+IfThen(edtValidaCnpjCpf.Text ='1','CNPJ','CPF')+' válido!', ['&Ok']);
          edtNomEmit.Text := 'TODOS';
          Result := False;
        End
        Else  Begin
        fRetDadosEmitente(mskCnpjCPf.Text, strNomEmi, strEndere, strTele01);
        If strNomEmi = '' Then
          edtNomEmit.Text := 'NÃO CADASTRADO'
        Else
         edtNomEmit.Text := strNomEmi;
        End;
      End
      Else Begin
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtValidaCnpjCpf.Text := '';
      End;
    End

  Else
  {******************}
  {* VERIFICA Destino*}
  {***************LE*}
  If (Sender = edtDestino) Then
  Begin
    If edtDestino.Text = '' Then
    Begin
      fMensagem('ATENÇÃO!','O campo destino deve ser preenchido!',['&O K']);
      Result := False;
    End
    Else
    Begin
      If (edtDestino.Text <> 'V') And (edtDestino.Text <> 'I')
      And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('ATENÇÃO!','O campo destino deve ser V, I ou E!',['&O K']);
        Result := False;
      End;
    End;
  End;

End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelChqEmCustodia.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtOrdem);
end;

procedure TfrmRelChqEmCustodia.FormCreate(Sender: TObject);
begin
  inherited;

  qryConPor := fCriaQuery(Self);

end;

procedure TfrmRelChqEmCustodia.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelChqEmCustodia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (ActiveControl Is TRadioButton) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelChqEmCustodia.edtClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente');

end;

procedure TfrmRelChqEmCustodia.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqEmCustodia.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelChqEmCustodia.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.

