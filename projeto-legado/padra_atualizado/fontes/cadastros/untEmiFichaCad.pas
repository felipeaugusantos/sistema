unit untEmiFichaCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, RLFilters, RLPDFFilter, frxClass, frxDBSet, frxExportPDF,
  untFuncoesGenerica, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  MemDS, DBAccess, Data.DB, Uni, Vcl.CheckLst, Datasnap.DBClient, frxChBox,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, frxExportRTF, untWord, System.StrUtils, untTypesSistema;

type
  TfrmEmiFichaCad = class(TfrmPaiConfirma)
    rdgModelo: TRadioGroup;
    gpbContato: TGroupBox;
    lblEmail: TLabel;
    lblContato: TLabel;
    edtEmail: TEditFocus;
    edtContato: TEditFocus;
    frxRelatorio: TfrxDBDataset;
    frxExportaPDF: TfrxPDFExport;
    frxReportJ: TfrxReport;
    qryRelatorioContatos: TUniQuery;
    dtsRelatorioContatos: TDataSource;
    frxRelatorioContatos: TfrxDBDataset;
    chklstOpcoes: TCheckListBox;
    cdsOpcoes: TUniClientDataSet;
    cdsOpcoesINDICE_LISTA: TIntegerField;
    cdsOpcoesNOME_ABA: TStringField;
    cdsOpcoesSELECIONADO: TBooleanField;
    cdsOpcoesSIGLA: TStringField;
    cdsResumoFinanceiro: TUniClientDataSet;
    cdsResumoFinanceiroTOT_DUP_ABE_QTD: TIntegerField;
    cdsResumoFinanceiroTOT_DUP_ABE_VAL: TFloatField;
    cdsResumoFinanceiroTOT_DUP_LIQ_QTD: TIntegerField;
    cdsResumoFinanceiroTOT_DUP_LIQ_VAL: TFloatField;
    cdsResumoFinanceiroTOT_DUP_ATR_QTD: TIntegerField;
    cdsResumoFinanceiroTOT_DUP_ATR_VAL: TFloatField;
    cdsResumoFinanceiroTOT_DUP_LTR_QTD: TIntegerField;
    cdsResumoFinanceiroTOT_DUP_LTR_VAL: TFloatField;
    cdsResumoFinanceiroLIM_CRE_DISPONI: TFloatField;
    cdsResumoFinanceiroDIAS_SEM_VENDA_: TIntegerField;
    cdsResumoFinanceiroULT_COMPRA_DATA: TStringField;
    cdsResumoFinanceiroULT_COMPRA_NOTA: TStringField;
    cdsResumoFinanceiroULT_COMPRA_VAL_: TFloatField;
    cdsResumoFinanceiroMAI_COMPRA_DATA: TStringField;
    cdsResumoFinanceiroMAI_COMPRA_NOTA: TStringField;
    cdsResumoFinanceiroMAI_COMPRA_VAL_: TFloatField;
    cdsResumoFinanceiroATRASADOS_MEDIA: TFloatField;
    cdsResumoFinanceiroATRASADOS_MAIOR: TFloatField;
    cdsResumoFinanceiroATRASADOS_ATUAL: TFloatField;
    frxResumoFinanceiro: TfrxDBDataset;
    qryRelatorioAutorizacaoCompra: TUniQuery;
    dtsRelatorioAutorizacaoCompra: TDataSource;
    frxRelatorioAutorizacaoCompra: TfrxDBDataset;
    qrySocios: TUniQuery;
    frxSocios: TfrxDBDataset;
    frxExportaWord: TfrxRTFExport;
    rdgFormasEnvio: TRadioGroup;
    rdgEmissao: TRadioGroup;
    procedure rdgEmissaoExit(Sender: TObject);
    procedure rdgEmissaoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    function frxReportJUserFunction(const MethodName: String; var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chklstOpcoesClickCheck(Sender: TObject);
    procedure rdgModeloEnter(Sender: TObject);
    procedure rdgFormasEnvioClick(Sender: TObject);
  private
    blnBranco: Boolean;
    FPais    : TPais;
    blnMontouTermo : Boolean;
    FfltAlturaBandaOrig: Double;
    FfltTopQuadroObs: Double;
    FfltAlturaMemoObs: Double;

    function fFormataCGCInterna(strC_G_C_: String): String;
    function fFormataFoneInterna(strFone: String): String;

    function fRetSQL : String;
    procedure pMontaListaOpcoes;

    procedure pImpAba_Geral(blnImprime : Boolean);
    procedure pImpResumoFinanceiro(blnImprime : Boolean);
    procedure pImpAba_Contatos(blnImprime : Boolean);
    procedure pImpAba_ContatosAutorizacaoCompras(blnImprime : Boolean);
    procedure pImpAba_EntregaCobranca(blnImprime : Boolean);
    procedure pImpAba_QuadroSocietario(blnImprime : Boolean);
    procedure pImpAba_RefBancaria(blnImprime : Boolean);
    procedure pImpAba_RefComercial(blnImprime : Boolean);
    procedure pImpAba_InfCrediario(blnImprime : Boolean);

    function fRetImpAba(strNomAba : String) : Boolean;

    procedure pEnviaEmail(strCodCli, strTextoAdicional: String; arrArquivos : TStringArray);
    function fSQL_ContatosAutorizacaoComprasEmBranco(blnImprime, blnEmBranco: Boolean): string;
    procedure pDesabilitarSecoesSemAcesso;
    procedure pMontarTermoConsentimento;
    procedure pImprimirTermoConsentimento(strPasta: String; strPrefixo: String; strNomeRelatorio: String);
    procedure pMontarTermoConsentimentoBacen;

    function fWordToPDF(strWordFile : String): String;
    function fGeraPDFFichaCadastral(strPDFFile:String):String;
    function fGeraWordToPdf(strNomArquivo: String; strPrefixo: String):String;
    procedure pLoadReport;
    procedure pOcultaObservacao;
  public

    strCodCli: String;

    {Impressão das Abas}
    blnAba_Geral,
    blnResumoFinanceiro,
    blnAba_Contatos,
    blnAba_EntregaCobranca,
    blnAba_QuadroSocietario,
    blnAba_RefBancaria,
    blnAba_RefComercial,
    blnAba_InfCrediario : Boolean;

  end;

implementation

uses untModuloSPR, untFuncoesSimples,  untTEnvioEmail,
  untResFinanceiro, untValorPorExtenso, untCfgRel;

{$R *.dfm}

procedure TfrmEmiFichaCad.rdgEmissaoExit(Sender: TObject);
begin
  //inherited;
  rdgEmissaoClick(Sender);
end;

procedure TfrmEmiFichaCad.rdgModeloEnter(Sender: TObject);
begin
  inherited;
  If rdgModelo.ItemIndex = -1 Then
    rdgModelo.ItemIndex := 0;

  pSetFocus(TWinControl(rdgModelo.Controls[rdgModelo.ItemIndex]));
end;

procedure TfrmEmiFichaCad.rdgEmissaoClick(Sender: TObject);
begin
  inherited;
  chklstOpcoes.Enabled     := True;
  TRadioButton(rdgFormasEnvio.Controls[1]).Enabled := True;
  Case rdgEmissao.ItemIndex of
        2:Begin
            chklstOpcoes.Enabled     := False;
            rdgFormasEnvio.ItemIndex := 0;
            TRadioButton(rdgFormasEnvio.Controls[1]).Enabled := False;
          End;

  End;
end;

function TfrmEmiFichaCad.fGeraWordToPdf(strNomArquivo: String; strPrefixo: String) : String;
begin

  strNomArquivo := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'TermoCliente\' + strPrefixo + strCodCli + '.docx';

  If not FileExists(strNomArquivo) Then
  Begin
    strNomArquivo := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'TermoCliente\' + strPrefixo + strCodCli + '.doc';
    If not FileExists(strNomArquivo) Then
    Begin
      pMensagemOk('Arquivo "' + strNomArquivo + '" não encontrado!');
      Exit;
    End;
  End;

  Result := fWordToPDF(strNomArquivo);
End;

procedure TfrmEmiFichaCad.btnConfirmaClick(Sender: TObject);
var
  strSQL        : String;
  strExecutavel : String;
  strNomArquivo : String;
  intAux        : Integer;
  blnImprimeAba : Boolean;
  strTexto      : String;
  arrArquivos : TStringArray;
  stlArquivos : TStringList;
  blnFr3Personalizado : Boolean;
  memTitulo: TfrxComponent;
  comRelatorio: TfrxComponent;
begin

  inherited;

  blnBranco := (rdgModelo.ItemIndex = 0);

  if (rdgModelo.ItemIndex <> 0) and (rdgFormasEnvio.ItemIndex = 2) then
  begin
    fMensagem('ATENÇÃO!', 'Enviar Word por E-mail só pode ser usado com o Modelo Em Branco', ['&Ok']);
    Exit;
  end;

  If FileExists(ExtractFilePath(Application.ExeName)+'ficha_cadastral_cliente.fr3') Then
  begin
    try
      frxReportJ.LoadFromFile(ExtractFilePath(Application.ExeName)+'ficha_cadastral_cliente.fr3');
      blnFr3Personalizado := true;
    except
      pLoadReport;
      blnFr3Personalizado := false;
    end;
  end
  else
  begin
    pLoadReport;
    blnFr3Personalizado := false;
  end;


  comRelatorio := frxReportJ.FindObject('Memo38');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
    FfltTopQuadroObs := TfrxMemoView(comRelatorio).Top;

  comRelatorio := frxReportJ.FindObject('Memo161');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
    FfltAlturaMemoObs := TfrxMemoView(comRelatorio).Height;

  comRelatorio := frxReportJ.FindObject('rdbDadosGerais');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMasterData) Then
    FfltAlturaBandaOrig := TfrxMasterData(comRelatorio).Height;

  strSQL := '';
  strSQL := fRetSQL;

  memTitulo := frxReportJ.FindObject('Memo125');
  If Assigned(memTitulo) and (memTitulo is TfrxMemoView) Then
    TfrxMemoView(memTitulo).Text := fCfgSis('TITFCA', varString);

  With frmModuloSPR.qryRelatorio Do
  begin

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    If Not IsEmpty Then
    begin
      If  (rdgEmissao.ItemIndex = 0) Or (rdgEmissao.ItemIndex = 1) Then {Ficha Cadastral}
      Begin
        pDesabilitarSecoesSemAcesso;

        cdsOpcoes.First;
        while not cdsOpcoes.Eof do
        begin

          blnImprimeAba := fRetImpAba(cdsOpcoesNOME_ABA.AsString);

          {Geral}
          if (cdsOpcoesSIGLA.AsString = 'GERAL_') then
          begin
            pImpAba_Geral(blnImprimeAba);
          end;

          {Resumo Financeiro}
          if (cdsOpcoesSIGLA.AsString = 'RESFIN') then
          begin
            pImpResumoFinanceiro(blnImprimeAba);
          end;

          {Contatos}
          if (cdsOpcoesSIGLA.AsString = 'CONTAT') then
          begin
            pImpAba_Contatos(blnImprimeAba);
          end;

          {Autorização de Compra}
          if (cdsOpcoesSIGLA.AsString = 'AUTCMP') then
          begin
            pImpAba_ContatosAutorizacaoCompras(blnImprimeAba);
          end;


          {Endereço Entrega/Cobrança}
          if (cdsOpcoesSIGLA.AsString = 'DADCOB') then
          begin
            pImpAba_EntregaCobranca(blnImprimeAba);
          end;

          {Quadro Societário}
          if (cdsOpcoesSIGLA.AsString = 'QUASOC') then
          begin
            pImpAba_QuadroSocietario(blnImprimeAba);
          end;

          {Ref. Bancária}
          if (cdsOpcoesSIGLA.AsString = 'REFBAN') then
          begin
            pImpAba_RefBancaria(blnImprimeAba);
          end;

          {Ref. Comercial}
          if (cdsOpcoesSIGLA.AsString = 'REFCOM') then
          begin
            pImpAba_RefComercial(blnImprimeAba);
          end;

          {Inf. Crediário}
          if (cdsOpcoesSIGLA.AsString = 'INFCRE') then
          begin
            pImpAba_InfCrediario(blnImprimeAba);
          end;

          cdsOpcoes.Next;

        end;

        pOcultaObservacao;

        If blnBranco and Not blnFr3Personalizado Then
        Begin

          For intAux := 126 to 500 do
          Begin
            Try
              if frxReportJ.FindObject('Memo'+IntToStr(intAux)) <> nil then
                TfrxMemoView(frxReportJ.FindObject('Memo'+IntToStr(intAux))).Visible := False;
            Except
              //Alguns componentes foram renomeados. Serão tratados abaixo.
            End;
          End;

          if Assigned(TfrxMemoView(frxReportJ.FindObject('Memo65'))) then
            TfrxMemoView(frxReportJ.FindObject('Memo65')).Visible    := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('Memo62'))) then
            TfrxMemoView(frxReportJ.FindObject('Memo62')).Visible    := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('Memo63'))) then
            TfrxMemoView(frxReportJ.FindObject('Memo63')).Visible    := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('Memo55'))) then
            TfrxMemoView(frxReportJ.FindObject('Memo55')).Visible    := False;

          {Cartões}

          if Assigned(frxReportJ.FindObject('chkVisa')) and
             (frxReportJ.FindObject('chkVisa') is TfrxCheckBoxView) then
            TfrxCheckBoxView(frxReportJ.FindObject('chkVisa')).Checked := False;
          if Assigned(frxReportJ.FindObject('chkMasterCard')) and
             (frxReportJ.FindObject('chkMasterCard') is TfrxCheckBoxView) then
            TfrxCheckBoxView(frxReportJ.FindObject('chkMasterCard')).Checked := False;
          if Assigned(frxReportJ.FindObject('chkHiperCard')) and
             (frxReportJ.FindObject('chkHiperCard') is TfrxCheckBoxView) then
            TfrxCheckBoxView(frxReportJ.FindObject('chkHiperCard')).Checked := False;
          if Assigned(frxReportJ.FindObject('chkAmericanExpress')) and
             (frxReportJ.FindObject('chkAmericanExpress') is TfrxCheckBoxView) then
            TfrxCheckBoxView(frxReportJ.FindObject('chkAmericanExpress')).Checked := False;
          if Assigned(frxReportJ.FindObject('chkDiners')) and
             (frxReportJ.FindObject('chkDiners') is TfrxCheckBoxView) then
            TfrxCheckBoxView(frxReportJ.FindObject('chkDiners')).Checked := False;


          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvCliNOme'))) then
            TfrxMemoView(frxReportJ.FindObject('mvCliNOme')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mdDtNascimento'))) then
            TfrxMemoView(frxReportJ.FindObject('mdDtNascimento')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvEndereco'))) then
            TfrxMemoView(frxReportJ.FindObject('mvEndereco')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvBairro'))) then
            TfrxMemoView(frxReportJ.FindObject('mvBairro')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvCidade'))) then
            TfrxMemoView(frxReportJ.FindObject('mvCidade')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvEstado'))) then
            TfrxMemoView(frxReportJ.FindObject('mvEstado')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvEmail'))) then
            TfrxMemoView(frxReportJ.FindObject('mvEmail')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvDepartamento'))) then
            TfrxMemoView(frxReportJ.FindObject('mvDepartamento')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvTelefone'))) then
            TfrxMemoView(frxReportJ.FindObject('mvTelefone')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvCelular'))) then
            TfrxMemoView(frxReportJ.FindObject('mvCelular')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvFax'))) then
            TfrxMemoView(frxReportJ.FindObject('mvFax')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('mvObservacoes'))) then
            TfrxMemoView(frxReportJ.FindObject('mvObservacoes')).Visible := False;

          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbC_G_C_'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbC_G_C_')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCli_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCli_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCli_02'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCli_02')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbFaxCli_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbFaxCli_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbCelCli_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbCelCli_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCob_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCob_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCob_02'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCob_02')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelRef_03'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelRef_03')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelRef_02'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelRef_02')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelRef_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelRef_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCom_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCom_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCom_02'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCom_02')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelCom_03'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelCom_03')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rlbTelPro_01'))) then
            TfrxMemoView(frxReportJ.FindObject('rlbTelPro_01')).Visible := False;
          if Assigned(TfrxMemoView(frxReportJ.FindObject('rllObsCad'))) then
            TfrxMemoView(frxReportJ.FindObject('rllObsCad')).Visible := False;

        End;

        frxReportJ.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
        frxReportJ.Script.Variables['OBSCAD'] := fCfgSis('OBSCAD');

        frxReportJ.Script.Variables['CNPJ/CPF'] := IIF(FPais = opcParaguai, 'RUC', 'CNPJ/CPF');
        frxReportJ.Script.Variables['R.G.']     := IIF(FPais = opcParaguai, 'CI', 'R.G.');
        frxReportJ.Script.Variables['MSGROD']   := fCfgSis('MSGROD', varString);

        if length(frmModuloSPR.qryRelatorio.FieldByName('CLI_NOMPAI').AsString) > 45 then
        begin
          TfrxMemoView(frxReportJ.FindObject('memo218')).Font.Size := 5 ;
        end;
        if length(frmModuloSPR.qryRelatorio.FieldByName('CLI_NOMMAE').AsString) > 45 then
        begin
          TfrxMemoView(frxReportJ.FindObject('memo220')).Font.Size := 5 ;
        end;
        if length(frmModuloSPR.qryRelatorio.FieldByName('CLI_CONJUG').AsString) > 45 then
        begin
          TfrxMemoView(frxReportJ.FindObject('memo219')).Font.Size := 5 ;
        end;
      End;

      If ((rdgEmissao.ItemIndex = 1) Or (rdgEmissao.ItemIndex = 2)) Then {Termo de Consentimento}
        pMontarTermoConsentimento;

      If (rdgEmissao.ItemIndex = 3) Then {Termo de Consentimento Bacen}
        pMontarTermoConsentimentoBacen;

      Try
        case rdgFormasEnvio.ItemIndex of
          0:
          Begin
            If (rdgEmissao.ItemIndex = 0) Or (rdgEmissao.ItemIndex = 1) Then
              pPreviewReport(Self.Name, Self.Caption, frxReportJ); // Imprimir Ficha Cadastral

            If (rdgEmissao.ItemIndex = 1) Or (rdgEmissao.ItemIndex = 2) Then
              pImprimirTermoConsentimento('TermoCliente', 'TermoLGPD_', 'TermoTratamentoDadosCliente');

            If (rdgEmissao.ItemIndex = 3) Then
              pImprimirTermoConsentimento('TermoCliente', 'TermoBACEN_', 'TermoTratamentoDadosClienteBacen');
          End;
          1: // Enviar PDF por E-mail
            Begin
              If (rdgEmissao.ItemIndex = 0) Or (rdgEmissao.ItemIndex = 1) Then
              Begin
                strExecutavel := ExtractFilePath(Application.ExeName);

                If Not DirectoryExists(strExecutavel+'FichaCliente') Then
                  CreateDir(strExecutavel+'FichaCliente');

                If (rdgEmissao.ItemIndex = 1) Then
                begin
                  strNomArquivo := fGeraWordToPdf(strNomArquivo, 'TermoLGPD_');

                  If (not fEmptyStr(strNomArquivo)) Then
                  Begin
                    Setlength(arrArquivos, Length(arrArquivos)+1);
                    arrArquivos[High(arrArquivos)] := strNomArquivo;
                  End
                  Else
                  Begin
                    pMensagemOk('Não foi possível gerar arquivo PDF do Termo de Consentimento(LGPD)');
                    Exit;
                  End;
                end;

                strNomArquivo := 'CLI_' + strCodCli + '.pdf';

                frxReportJ.PrepareReport(True);
                frxExportaPDF.FileName    := strNomArquivo;
                frxExportaPDF.DefaultPath := strExecutavel+'FichaCliente';
                frxExportaPDF.ShowDialog  := False;
                frxReportJ.Export(frxExportaPDF);
                strNomArquivo := strExecutavel+'FichaCliente\'+strNomArquivo;

                If (Not fEmptyStr(strNomArquivo)) Then
                Begin
                  strTexto := '';
                  strTexto := strTexto + #13#10 + #13#10;
                  strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
                  strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

                  Setlength(arrArquivos, Length(arrArquivos)+1);
                  arrArquivos[High(arrArquivos)] := strNomArquivo;

                  pEnviaEmail(FieldByName('CLI_CODCLI').AsString, strTexto, arrArquivos);
                End
                Else
                  fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
              End;

              If (rdgEmissao.ItemIndex = 3) Then
              Begin
                strNomArquivo := fGeraWordToPdf(strNomArquivo, 'TermoBACEN_');

                If (not fEmptyStr(strNomArquivo)) Then
                Begin
                  Setlength(arrArquivos, Length(arrArquivos)+1);
                  arrArquivos[High(arrArquivos)] := strNomArquivo;

                  strTexto := '';
                  strTexto := strTexto + #13#10 + #13#10;
                  strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
                  strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

                  pEnviaEmail(FieldByName('CLI_CODCLI').AsString, strTexto, arrArquivos);
                End
                Else
                Begin
                  pMensagemOk('Não foi possível gerar arquivo PDF do Termo de Consentimento Bacen');
                  Exit;
                End;
              End;
            End;
          2: //Enviar Word por E-mail
            Begin
              strExecutavel := ExtractFilePath(Application.ExeName);

              If (rdgEmissao.ItemIndex = 0) Or (rdgEmissao.ItemIndex = 1) Then
              Begin
                If Not DirectoryExists(strExecutavel+'FichaCliente') Then
                  CreateDir(strExecutavel+'FichaCliente');

                strNomArquivo := 'CLI_' + strCodCli + '.doc';

                frxReportJ.PrepareReport(True);
                frxExportaWord.FileName   := strNomArquivo;
                frxExportaWord.DefaultPath := strExecutavel+'FichaCliente';
                frxExportaWord.ShowDialog  := False;
                frxReportJ.Export(frxExportaWord);

                strNomArquivo := strExecutavel+'FichaCliente\'+strNomArquivo;

                Setlength(arrArquivos, Length(arrArquivos)+1);
                arrArquivos[High(arrArquivos)] := strNomArquivo;
              End;

              If (rdgEmissao.ItemIndex = 1) Or (rdgEmissao.ItemIndex = 2) Then
              Begin
                strExecutavel := ExtractFilePath(Application.ExeName);
                strNomArquivo := strExecutavel+'TermoCliente\TermoLGPD_' + strCodCli + '.docx';

                If not FileExists(strNomArquivo) Then
                Begin
                  strNomArquivo := strExecutavel+'TermoCliente\TermoLGPD_' + strCodCli + '.doc';
                  If not FileExists(strNomArquivo) Then
                  Begin
                    pMensagemOk('Arquivo "' + strNomArquivo + '" não encontrado!');
                    Exit;
                  End;
                End;

                Setlength(arrArquivos, Length(arrArquivos)+1);
                arrArquivos[High(arrArquivos)] := strNomArquivo;
              End;

              If (rdgEmissao.ItemIndex = 3) Then
              Begin
                strExecutavel := ExtractFilePath(Application.ExeName);
                strNomArquivo := strExecutavel+'TermoCliente\TermoBACEN_' + strCodCli + '.docx';

                If not FileExists(strNomArquivo) Then
                Begin
                  strNomArquivo := strExecutavel+'TermoCliente\TermoBACEN_' + strCodCli + '.doc';
                  If not FileExists(strNomArquivo) Then
                  Begin
                    pMensagemOk('Arquivo "' + strNomArquivo + '" não encontrado!');
                    Exit;
                  End;
                End;

                Setlength(arrArquivos, Length(arrArquivos)+1);
                arrArquivos[High(arrArquivos)] := strNomArquivo;
              End;

              If (Not fEmptyStr(strNomArquivo)) Then
                pEnviaEmail(FieldByName('CLI_CODCLI').AsString, '', arrArquivos)
              Else
                fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo Word !', ['&Ok']);
            End;
          3:  //Gerar PDF
          Begin
            stlArquivos := TStringList.Create;
            try
              If (rdgEmissao.ItemIndex = 0) Or (rdgEmissao.ItemIndex = 1) Then
              Begin
                strNomArquivo := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'FichaCliente\CLI_' + strCodCli + '.pdf';

                strNomArquivo := fGeraPDFFichaCadastral(strNomArquivo);

                If (not fEmptyStr(strNomArquivo)) Then
                Begin
                  stlArquivos.Add(strNomArquivo);
                End
                Else
                Begin
                  pMensagemOk('Não foi possível gerar arquivo PDF da Ficha Cadastral');
                  Exit;
                End;
              End;

              If (rdgEmissao.ItemIndex = 1) Or (rdgEmissao.ItemIndex = 2) Then
              Begin
                strNomArquivo := fGeraWordToPdf(strNomArquivo, 'TermoLGPD_');

                If (not fEmptyStr(strNomArquivo)) Then
                Begin
                  stlArquivos.Add(strNomArquivo);
                End
                Else
                Begin
                  pMensagemOk('Não foi possível gerar arquivo PDF do Termo de Consentimento(LGPD)');
                  Exit;
                End;
              End;

              If (rdgEmissao.ItemIndex = 3) Then
              Begin
                strNomArquivo := fGeraWordToPdf(strNomArquivo, 'TermoBACEN_');

                If (not fEmptyStr(strNomArquivo)) Then
                Begin
                  stlArquivos.Add(strNomArquivo);
                End
                Else
                Begin
                  pMensagemOk('Não foi possível gerar arquivo PDF do Termo de Consentimento Bacen');
                  Exit;
                End;
              End;

              If (stlArquivos.Count > 0) Then
                pMensagemOK('Arquivo(s) PDF Gerado(s):' + #10+#13 + stlArquivos.Text);
            finally
              FreeAndNil(stlArquivos);
            end;
          End;
        end;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmCadClientes.btnFichaCliClick]');
        End;
      End;
    end
    else
      fMensagem('Atenção', 'Dados não encontrados para gerar o relatório',['&OK']);
  end;

end;

procedure TfrmEmiFichaCad.chklstOpcoesClickCheck(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  for i := 0 to chklstOpcoes.Count -1 do
  begin
    if cdsOpcoes.Locate('NOME_ABA', chklstOpcoes.Items.Strings[i], []) then
    begin
      cdsOpcoes.Edit;
      cdsOpcoesSELECIONADO.AsBoolean := chklstOpcoes.Checked[i];
      cdsOpcoes.Post;
    end;
  end;

end;

function TfrmEmiFichaCad.fFormataCGCInterna(strC_G_C_: String): String;
begin
  Result := fFormataCpfCgc(strC_G_C_, FPais);
end;

function TfrmEmiFichaCad.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

function TfrmEmiFichaCad.fGeraPDFFichaCadastral(strPDFFile: String): String;
begin
  Result := '';

  If (Not DirectoryExists(ExtractFilePath(strPDFFile))) Then
    ForceDirectories(ExtractFilePath(strPDFFile));

  frxReportJ.PrepareReport(True);
  frxExportaPDF.FileName    := ExtractFileName(strPDFFile);
  frxExportaPDF.DefaultPath := ExtractFilePath(strPDFFile);
  frxExportaPDF.ShowDialog  := False;
  frxReportJ.Export(frxExportaPDF);

  If FileExists(strPDFFile) Then
    Result := strPDFFile;



end;

function TfrmEmiFichaCad.fRetImpAba(strNomAba: String): Boolean;
begin

  Result := False;
  if cdsOpcoes.Locate('NOME_ABA', strNomAba, []) then
    Result := cdsOpcoesSELECIONADO.AsBoolean;

end;

function TfrmEmiFichaCad.fRetSQL: String;
var
  strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  if blnBranco then
  begin

    strSQL := strSQL + '   "" AS CLI_CODCLI, "" AS CLI_DTACAD, "" AS CLI_DTAALT, ';
    strSQL := strSQL + '   "" AS CLI_HOMEPA, "" AS CLI_NOMCLI, "" AS CLI_FANSOB, ';
    strSQL := strSQL + '   "" AS CLI_ENDERE, ';
    strSQL := strSQL + '   "" AS CLI_BAIRRO, "" AS CLI_C_E_P_, ';
    strSQL := strSQL + '   "" AS CLI_CAIPOS, "" AS CLI_NUMR_G, "" AS CLI_C_G_C_, ';
    strSQL := strSQL + '   "" AS CLI_I_E_S_, "" AS CLI_I_M_P_, "" AS CLI_NASCIM, ';
    strSQL := strSQL + '   "" AS CLI_FONE01, "" AS CLI_RAMAL1, "" AS CLI_FONE02, ';
    strSQL := strSQL + '   "" AS CLI_RAMAL2, "" AS CLI_F_A_X_, "" AS CLI_RAMAL3, ';
    strSQL := strSQL + '   "" AS CLI_CELULA, "" AS CLI_CONTAT, "" AS CLI_EMAIL_, ';
    strSQL := strSQL + '   "" AS CLI_STATUS, ';
    strSQL := strSQL + '   "" AS CLI_CONSUM, ';
    strSQL := strSQL + '   "" AS CLI_ORGPUB, ';
    strSQL := strSQL + '   "" AS CLI_ZONFRA, ';
    strSQL := strSQL + '   "" AS CLI_RETPCO, ';
    strSQL := strSQL + '   "" AS CLI_RETIRF, ';
    strSQL := strSQL + '   "" AS CLI_RETISS, ';
    strSQL := strSQL + '   "" AS CLI_SEGSOC, ';
    strSQL := strSQL + '   "" AS CLI_CALICM, ';
    strSQL := strSQL + '   "" AS CLI_CASAPR, ';
    strSQL := strSQL + '   "" AS CLI_ORPURD, ';
    strSQL := strSQL + '   "" AS CLI_CODCON, ';
    strSQL := strSQL + '   "" AS CLI_LIMCRE, "" AS CND_CNDPAG, "" AS CLI_OBS_01, "" AS CLI_OBS_02, ';
    strSQL := strSQL + '   "" AS CLI_OBS_03, "" AS CLI_OBS_04, "" AS CLI_DOUCOM, "" AS CLI_ULTCOM, ';
    strSQL := strSQL + '   "" AS CLI_VRUCOM, "" AS CLI_DOMCOM, "" AS CLI_DTMCOM, "" AS CLI_VRMCOM, ';
    strSQL := strSQL + '   "" AS CLI_ENDCOB, "" AS CLI_BAICOB, "" AS CLI_CIDCOB, "" AS CLI_CEPCOB, ';
    strSQL := strSQL + '   "" AS CLI_TELCOB, "" AS CLI_CONCOB, "" AS CLI_CNDPAG, ';

    strSQL := strSQL + '   "" AS CLI_ENDENT, ';
    strSQL := strSQL + '   "" AS CLI_BAIENT, ';
    strSQL := strSQL + '   "" AS CLI_CIDENT, ';
    strSQL := strSQL + '   "" AS CLI_CEPENT, ';
    strSQL := strSQL + '   "" AS CLI_TELENT, ';
    strSQL := strSQL + '   "" AS CLI_CONENT, ';

    strSQL := strSQL + '   "" AS CLI_VISA__, "" AS CLI_MASTER, "" AS CLI_HIPERC, "" AS CLI_AMERIC, "" AS CLI_DINERS, ';
    strSQL := strSQL + '   "" AS CLI_NOMPAI, "" AS CLI_NOMMAE, "" AS CLI_CONJUG, "" AS CLI_NASCON, ';
    strSQL := strSQL + '   "" AS CLI_ALQISS, "" AS CLI_CODRED, "" AS CLI_OBSERV, "" AS CLI_DTACON, ';
    strSQL := strSQL + '   "" AS CLI_QTDPRO, "" AS CLI_CHEDEV, "" AS CLI_OBSCON, "" AS FIC_NOMBC1, ';
    strSQL := strSQL + '   "" AS FIC_AGEBC1, "" AS FIC_TELBC1, "" AS FIC_CONBC1, "" AS FIC_NOMBC2, ';
    strSQL := strSQL + '   "" AS FIC_AGEBC2, "" AS FIC_TELBC2, "" AS FIC_CONBC2, "" AS FIC_NOMBC3, ';
    strSQL := strSQL + '   "" AS FIC_AGEBC3, "" AS FIC_TELBC3, "" AS FIC_CONBC3, ';

    strSQL := strSQL + '   "" AS FIC_NOMEM1, ';
    strSQL := strSQL + '   "" AS FIC_CGCEM1, ';
    strSQL := strSQL + '   "" AS FIC_TELEM1, ';
    strSQL := strSQL + '   "" AS FIC_CONEM1, ';
    strSQL := strSQL + '   "" AS FIC_DTACO1, ';
    strSQL := strSQL + '   "" AS FIC_DTAPC1, ';
    strSQL := strSQL + '   "" AS FIC_VALPC1, ';
    strSQL := strSQL + '   "" AS FIC_DTAMC1, ';
    strSQL := strSQL + '   "" AS FIC_VALMC1, ';
    strSQL := strSQL + '   "" AS FIC_DTAUC1, ';
    strSQL := strSQL + '   "" AS FIC_VALUC1, ';

    strSQL := strSQL + '   "" AS FIC_NOMEM2, ';
    strSQL := strSQL + '   "" AS FIC_CGCEM2, ';
    strSQL := strSQL + '   "" AS FIC_TELEM2, ';
    strSQL := strSQL + '   "" AS FIC_CONEM2, ';
    strSQL := strSQL + '   "" AS FIC_DTACO2, ';
    strSQL := strSQL + '   "" AS FIC_DTAPC2, ';
    strSQL := strSQL + '   "" AS FIC_VALPC2, ';
    strSQL := strSQL + '   "" AS FIC_DTAMC2, ';
    strSQL := strSQL + '   "" AS FIC_VALMC2, ';
    strSQL := strSQL + '   "" AS FIC_DTAUC2, ';
    strSQL := strSQL + '   "" AS FIC_VALUC2, ';

    strSQL := strSQL + '   "" AS FIC_NOMEM3, ';
    strSQL := strSQL + '   "" AS FIC_CGCEM3, ';
    strSQL := strSQL + '   "" AS FIC_TELEM3, ';
    strSQL := strSQL + '   "" AS FIC_CONEM3, ';
    strSQL := strSQL + '   "" AS FIC_DTACO3, ';
    strSQL := strSQL + '   "" AS FIC_DTAPC3, ';
    strSQL := strSQL + '   "" AS FIC_VALPC3, ';
    strSQL := strSQL + '   "" AS FIC_DTAMC3, ';
    strSQL := strSQL + '   "" AS FIC_VALMC3, ';
    strSQL := strSQL + '   "" AS FIC_DTAUC3, ';
    strSQL := strSQL + '   "" AS FIC_VALUC3, ';
    strSQL := strSQL + '   "" AS CLI_CGCCPF, ';
    strSQL := strSQL + '   "" AS CLI_ESTCIV, ';
    strSQL := strSQL + '   "" AS CLI_ESCOLA, ';
    strSQL := strSQL + '   "" AS CLI_SEXO__, ';

    strSQL := strSQL + '   "" AS CLI_NACION, "" AS CLI_NATURA, "" AS CLI_AVALIS, "" AS CLI_OUTROS,';
    strSQL := strSQL + '   "" AS CLI_RESIDE, "" AS CLI_MOTOUT,';
    strSQL := strSQL + '   "" AS CLI_PROFIS, "" AS CLI_C_PROF, "" AS CLI_TRABAL, "" AS CLI_ENDSER, ';
    strSQL := strSQL + '   "" AS CLI_TELSER, "" AS CLI_TEMSER, "" AS CLI_SALARI, "" AS CLI_OUTREN, ';
    strSQL := strSQL + '   "" AS CLI_VRALUG, "" AS CLI_ENDIM1, "" AS CLI_ENDIM2, "" AS CLI_TOTREN,';
    strSQL := strSQL + '   "" AS CLI_VALIM1, "" AS CLI_VALIM2, "" AS CLI_VEICUL, "" AS CLI_VALVEI, ';
    strSQL := strSQL + '   "" AS CLI_OBS_FC, ';
    strSQL := strSQL + '   "" AS CIDCLI, "" AS ESTCLI, ';
    strSQL := strSQL + '   "" AS CIDCOB, "" AS ESTCOB, ';
    strSQL := strSQL + '   "" AS CIDENT, "" AS ESTENT, ';
    strSQL := strSQL + '   "" AS NOMVEN, "" AS NOMREP, ';
    strSQL := strSQL + '   "" AS ATI_DESATI, "" AS FPG_DESCRI, "" AS POR_NOMPOR, ';
    strSQL := strSQL + '   "" AS CLI_EMCOB1, "" AS CLI_EMCOB2, "" AS CLI_DTCOCB, "" AS CLI_CAPSOC, ';
    strSQL := strSQL + '   "" AS CLI_CODREG, "" AS REG_DESREG, "" AS CLI_TABPRE, ';
    strSQL := strSQL + '   "" AS CLI_TIPCLI, "" AS TIP_DESTIP ';
    strSQL := strSQL + ' FROM CADCLI ';
    strSQL := strSQL + ' WHERE CADCLI.CLI_CODCLI = :CODCLI ';
  end
  else
  begin
    strSQL := strSQL + '   CADCLI.CLI_CODCLI, CLI_DTACAD, CLI_DTAALT, ';
    strSQL := strSQL + '   CLI_HOMEPA, CLI_NOMCLI, CLI_FANSOB, ';
    strSQL := strSQL + '   CONCAT(CLI_ENDERE, IF(IFNULL(CLI_ENDNUM, "") = "", "", CONCAT(", ", CLI_ENDNUM)), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(", ", CLI_ENDCOM))) AS CLI_ENDERE, ';
    strSQL := strSQL + '   CLI_BAIRRO, CLI_C_E_P_, ';
    strSQL := strSQL + '   CLI_CAIPOS, CLI_NUMR_G, CLI_C_G_C_, ';
    strSQL := strSQL + '   CLI_I_E_S_, CLI_I_M_P_, CLI_NASCIM, ';
    strSQL := strSQL + '   CLI_FONE01, CLI_RAMAL1, CLI_FONE02, ';
    strSQL := strSQL + '   CLI_RAMAL2, CLI_F_A_X_, CLI_RAMAL3, ';
    strSQL := strSQL + '   CLI_CELULA, CLI_CONTAT, CLI_EMAIL_, ';
    strSQL := strSQL + '   IF(CLI_STATUS = "A", "ATIVO", IF(CLI_STATUS = "I",';
    strSQL := strSQL + '             "INATIVO", "BLOQUEADO")) AS CLI_STATUS, ';
    strSQL := strSQL + '   IF(CLI_CONSUM = "S", "SIM", "NÃO") AS CLI_CONSUM, ';
    strSQL := strSQL + '   IF(CLI_ORGPUB = "S", "SIM", "NÃO") AS CLI_ORGPUB, ';
    strSQL := strSQL + '   IF(CLI_ZONFRA = "S", "SIM", "NÃO") AS CLI_ZONFRA, ';

    if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
    begin
      strSQL := strSQL + '   "NÃO" AS CLI_RETPCO, ';
      strSQL := strSQL + '   "NÃO" AS CLI_RETIRF, ';
    end
    else
    begin
      strSQL := strSQL + '   IF(CLI_RETPCO = "S", "SIM", "NÃO") AS CLI_RETPCO, ';
      strSQL := strSQL + '   IF(CLI_RETIRF = "S", "SIM", "NÃO") AS CLI_RETIRF, ';
    end;

    strSQL := strSQL + '   IF(CLI_RETISS = "S", "SIM", "NÃO") AS CLI_RETISS, ';
    strSQL := strSQL + '   IF(CLI_SEGSOC = "S", "SIM", "NÃO") AS CLI_SEGSOC, ';
    strSQL := strSQL + '   IF(CLI_CALICM = "S", "SIM", "NÃO") AS CLI_CALICM, ';
    strSQL := strSQL + '   IF(IC.CLI_CASAPR = "A", "ALUGADA", "PRÓPRIA") AS CLI_CASAPR, ';
    strSQL := strSQL + '   IF(CLI_ORPURD = "R", "RATEIO", "DESCONTO ESPECIAL") AS CLI_ORPURD, ';
    strSQL := strSQL + '   IF(CLI_CODCON = "1", "SERASA", IF(CLI_CODCON = "2", "EQUIFAX", ';
    strSQL := strSQL + '   IF(CLI_CODCON = "3", "SINDCOMERCIO", IF(CLI_CODCON = "4", "CHECKCHECK", ';
    strSQL := strSQL + '   IF(CLI_CODCON = "5", "MASTERLITE E AÇÕES", ""))))) AS CLI_CODCON, ';
    strSQL := strSQL + '   CLI_LIMCRE, CND_CNDPAG, CLI_OBS_01, CLI_OBS_02, ';
    strSQL := strSQL + '   CLI_OBS_03, CLI_OBS_04, CLI_DOUCOM, CLI_ULTCOM, ';
    strSQL := strSQL + '   CLI_VRUCOM, CLI_DOMCOM, CLI_DTMCOM, CLI_VRMCOM, ';
    strSQL := strSQL + '   CLI_ENDCOB, CLI_BAICOB, CLI_CIDCOB, CLI_CEPCOB, ';
    strSQL := strSQL + '   CLI_TELCOB, CLI_CONCOB, CLI_CNDPAG, ';

    strSQL := strSQL + '   ETC_ENDENT AS CLI_ENDENT, ';
    strSQL := strSQL + '   ETC_BAIENT AS CLI_BAIENT, ';
    strSQL := strSQL + '   ETC_CIDENT AS CLI_CIDENT, ';
    strSQL := strSQL + '   ETC_CEPENT AS CLI_CEPENT, ';
    strSQL := strSQL + '   ETC_TELENT AS CLI_TELENT, ';
    strSQL := strSQL + '   ETC_CONENT AS CLI_CONENT, ';

    strSQL := strSQL + '   IC.CLI_VISA__, IC.CLI_MASTER, IC.CLI_HIPERC, IC.CLI_AMERIC, IC.CLI_DINERS, ';
    strSQL := strSQL + '   IC.CLI_NOMPAI, IC.CLI_NOMMAE, IC.CLI_CONJUG, IC.CLI_NASCON, ';
    strSQL := strSQL + '   CLI_ALQISS, CLI_CODRED, CLI_OBSERV, CLI_DTACON, ';
    strSQL := strSQL + '   CLI_QTDPRO, CLI_CHEDEV, CLI_OBSCON, FIC_NOMBC1, ';
    strSQL := strSQL + '   FIC_AGEBC1, FIC_TELBC1, FIC_CONBC1, FIC_NOMBC2, ';
    strSQL := strSQL + '   FIC_AGEBC2, FIC_TELBC2, FIC_CONBC2, FIC_NOMBC3, ';
    strSQL := strSQL + '   FIC_AGEBC3, FIC_TELBC3, FIC_CONBC3, ';

    strSQL := strSQL + '   REFCO1.EMPRCO AS FIC_NOMEM1, ';
    strSQL := strSQL + '   REFCO1.CGCEMP AS FIC_CGCEM1, ';
    strSQL := strSQL + '   REFCO1.TELEMP AS FIC_TELEM1, ';
    strSQL := strSQL + '   REPLACE(REFCO1.CONEMP, "\r\n", "") AS FIC_CONEM1, ';
    strSQL := strSQL + '   IFNULL(REFCO1.DTACON, "") AS FIC_DTACO1, ';
    strSQL := strSQL + '   IFNULL(REFCO1.DTAPCO, "") AS FIC_DTAPC1, ';
    strSQL := strSQL + '   REFCO1.VALPCO AS FIC_VALPC1, ';
    strSQL := strSQL + '   IFNULL(REFCO1.DTAMCO, "") AS FIC_DTAMC1, ';
    strSQL := strSQL + '   REFCO1.VALMCO AS FIC_VALMC1, ';
    strSQL := strSQL + '   IFNULL(REFCO1.DTAUCO, "") AS FIC_DTAUC1, ';
    strSQL := strSQL + '   REFCO1.VALUCO AS FIC_VALUC1, ';

    strSQL := strSQL + '   REFCO2.EMPRCO AS FIC_NOMEM2, ';
    strSQL := strSQL + '   REFCO2.CGCEMP AS FIC_CGCEM2, ';
    strSQL := strSQL + '   REFCO2.TELEMP AS FIC_TELEM2, ';
    strSQL := strSQL + '   REPLACE(REFCO2.CONEMP, "\r\n", "") AS FIC_CONEM2, ';
    strSQL := strSQL + '   IFNULL(REFCO2.DTACON, "") AS FIC_DTACO2, ';
    strSQL := strSQL + '   IFNULL(REFCO2.DTAPCO, "") AS FIC_DTAPC2, ';
    strSQL := strSQL + '   REFCO2.VALPCO AS FIC_VALPC2, ';
    strSQL := strSQL + '   IFNULL(REFCO2.DTAMCO, "") AS FIC_DTAMC2, ';
    strSQL := strSQL + '   REFCO2.VALMCO AS FIC_VALMC2, ';
    strSQL := strSQL + '   IFNULL(REFCO2.DTAUCO, "") AS FIC_DTAUC2, ';
    strSQL := strSQL + '   REFCO2.VALUCO AS FIC_VALUC2, ';

    strSQL := strSQL + '   REFCO3.EMPRCO AS FIC_NOMEM3, ';
    strSQL := strSQL + '   REFCO3.CGCEMP AS FIC_CGCEM3, ';
    strSQL := strSQL + '   REFCO3.TELEMP AS FIC_TELEM3, ';
    strSQL := strSQL + '   REPLACE(REFCO3.CONEMP, "\r\n", "") AS FIC_CONEM3, ';
    strSQL := strSQL + '   IFNULL(REFCO3.DTACON, "") AS FIC_DTACO3, ';
    strSQL := strSQL + '   IFNULL(REFCO3.DTAPCO, "") AS FIC_DTAPC3, ';
    strSQL := strSQL + '   REFCO3.VALPCO AS FIC_VALPC3, ';
    strSQL := strSQL + '   IFNULL(REFCO3.DTAMCO, "") AS FIC_DTAMC3, ';
    strSQL := strSQL + '   REFCO3.VALMCO AS FIC_VALMC3, ';
    strSQL := strSQL + '   IFNULL(REFCO3.DTAUCO, "") AS FIC_DTAUC3, ';
    strSQL := strSQL + '   REFCO3.VALUCO AS FIC_VALUC3, ';

    strSQL := strSQL + '   CLI_CGCCPF, ';
    strSQL := strSQL + '   CASE IC.CLI_ESTCIV ';
    strSQL := strSQL + '     WHEN "C" THEN "CASADO" ';
    strSQL := strSQL + '     WHEN "S" THEN "SOLTEIRO" ';
    strSQL := strSQL + '     WHEN "M" THEN "MARITAL" ';
    strSQL := strSQL + '     WHEN "O" THEN "OUTROS" ';
    strSQL := strSQL + '   END AS CLI_ESTCIV, ';

    strSQL := strSQL + '   CASE IC.CLI_ESCOLA ';
    strSQL := strSQL + '     WHEN "ANA" THEN "ANALFABETO" ';
    strSQL := strSQL + '     WHEN "PGI" THEN "PRIMEIRO GRAU INCOMPLETO" ';
    strSQL := strSQL + '     WHEN "PGC" THEN "PRIMEIRO GRAU COMPLETO" ';
    strSQL := strSQL + '     WHEN "SGI" THEN "SEGUNDO GRAU INCOMPLETO" ';
    strSQL := strSQL + '     WHEN "SGC" THEN "SEGUNDO GRAU COMPLETO" ';
    strSQL := strSQL + '     WHEN "SI"  THEN "SUPERIOR INCOMPLETO" ';
    strSQL := strSQL + '     WHEN "SC"  THEN "SUPERIOR COMPLETO" ';
    strSQL := strSQL + '     WHEN "PG"  THEN "POS GRADUACAO" ';
    strSQL := strSQL + '   END AS CLI_ESCOLA, ';

    strSQL := strSQL + '   CASE IC.CLI_SEXO__ ';
    strSQL := strSQL + '     WHEN "M" THEN "MASCULINO" ';
    strSQL := strSQL + '     WHEN "F" THEN "FEMININO" ';
    strSQL := strSQL + '   END AS CLI_SEXO__, ';

    strSQL := strSQL + '   IC.CLI_NACION, IC.CLI_NATURA, IC.CLI_AVALIS, IC.CLI_OUTROS,';
    strSQL := strSQL + '   IC.CLI_RESIDE, IC.CLI_MOTOUT,';
    strSQL := strSQL + '   IC.CLI_PROFIS, IC.CLI_C_PROF, IC.CLI_TRABAL, IC.CLI_ENDSER, ';
    strSQL := strSQL + '   IC.CLI_TELSER, IC.CLI_TEMSER, IC.CLI_SALARI, IC.CLI_OUTREN, ';
    strSQL := strSQL + '   IC.CLI_VRALUG, IC.CLI_ENDIM1, IC.CLI_ENDIM2, (IC.CLI_SALARI + IC.CLI_OUTREN) AS CLI_TOTREN,';
    strSQL := strSQL + '   IC.CLI_VALIM1, IC.CLI_VALIM2, IC.CLI_VEICUL, IC.CLI_VALVEI, ';
    strSQL := strSQL + '   IC.CLI_OBS_FC, ';
    strSQL := strSQL + '   CIDCLI.CID_NOMCID AS CIDCLI, CIDCLI.CID_ESTADO AS ESTCLI, ';
    strSQL := strSQL + '   CIDCOB.CID_NOMCID AS CIDCOB, CIDCOB.CID_ESTADO AS ESTCOB, ';
    strSQL := strSQL + '   CIDENT.CID_NOMCID AS CIDENT, CIDENT.CID_ESTADO AS ESTENT, ';
    strSQL := strSQL + '   CADVEN.OPE_NOMOPE AS NOMVEN, CADREP.OPE_NOMOPE AS NOMREP, ';
    strSQL := strSQL + '   ATI_DESATI, FPG_DESCRI, POR_NOMPOR, ';
    strSQL := strSQL + '   CLI_EMCOB1, CLI_EMCOB2, CLI_DTCOCB, CLI_CAPSOC ';
    strSQL := strSQL + ' FROM CADCLI ';
    strSQL := strSQL + ' LEFT JOIN CLICND ON CADCLI.CLI_CODCLI = CLICND.CND_CODCLI AND CND_SUGEST = "S" AND ';

    If fCfgSis('USACND', varBoolean) Then
      strSQL := strSQL + '  CLICND.CND_CODCND IS NOT NULL '
    Else
      strSQL := strSQL + '  IFNULL(CLICND.CND_CNDPAG, "") <> "" ';

    strSQL := strSQL + ' LEFT JOIN CADFIC            ON CADCLI.CLI_CODCLI = FIC_CODCLI ';
    strSQL := strSQL + ' LEFT JOIN CLI_INFCRE IC     ON CADCLI.CLI_CODCLI = IC.CLI_CODCLI ';
    strSQL := strSQL + ' INNER JOIN CADCID AS CIDCLI ON CADCLI.CLI_CODCID = CIDCLI.CID_CODCID ';
    strSQL := strSQL + ' LEFT JOIN CADCID AS CIDCOB  ON CADCLI.CLI_CIDCOB = CIDCOB.CID_CODCID ';
    strSQL := strSQL + ' INNER JOIN CADATI           ON CADCLI.CLI_CODATI = CADATI.ATI_CODATI ';
    strSQL := strSQL + ' LEFT JOIN CADFPG            ON CADCLI.CLI_CODFPG = CADFPG.FPG_CODIGO ';
    strSQL := strSQL + ' LEFT JOIN CADPOR            ON CADCLI.CLI_CODPOR = CADPOR.POR_CODPOR ';
    strSQL := strSQL + ' INNER JOIN CADOPE AS CADVEN ON CADCLI.CLI_CODVEN = CADVEN.OPE_CODOPE ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE AS CADREP ON CADCLI.CLI_CODREP = CADREP.OPE_CODOPE ';

    strSQL := strSQL + ' LEFT JOIN ENTCLI ON ETC_CODCLI = CADCLI.CLI_CODCLI AND  ';
    strSQL := strSQL + '                     ETC_SEQVIS = (SELECT MIN(ETC_SEQVIS) FROM ENTCLI WHERE ETC_CODCLI = CADCLI.CLI_CODCLI AND ETC_ENDFAT <> '''+'S'+''' AND ETC_SITUAC <> '''+'I'+''') ';

    strSQL := strSQL + ' LEFT JOIN CADCID AS CIDENT  ON ENTCLI.ETC_CIDENT = CIDENT.CID_CODCID ';

    strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
    strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
    strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
    strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
    strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
    strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
    strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
    strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
    strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
    strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
    strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
    strSQL := strSQL + '            FROM CLIRCO                                           ';
    strSQL := strSQL + '            WHERE CLIRCO.CLI_CODCLI = :CODCLI                     ';
    strSQL := strSQL + '            LIMIT 0,1) AS REFCO1 ON TRUE                          ';

    strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
    strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
    strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
    strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
    strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
    strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
    strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
    strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
    strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
    strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
    strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
    strSQL := strSQL + '            FROM CLIRCO                                           ';
    strSQL := strSQL + '            WHERE CLIRCO.CLI_CODCLI = :CODCLI                     ';
    strSQL := strSQL + '            LIMIT 1,1) AS REFCO2 ON TRUE                          ';

    strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
    strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
    strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
    strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
    strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
    strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
    strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
    strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
    strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
    strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
    strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
    strSQL := strSQL + '            FROM CLIRCO                                           ';
    strSQL := strSQL + '            WHERE CLIRCO.CLI_CODCLI = :CODCLI                     ';
    strSQL := strSQL + '            LIMIT 2,1) AS REFCO3 ON TRUE                          ';

    strSQL := strSQL + ' WHERE CADCLI.CLI_CODCLI = :CODCLI ';
  end;

  Result := strSQL;

end;


function TfrmEmiFichaCad.frxReportJUserFunction(const MethodName: String;
  var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]))
  Else If (SameText(MethodName, 'fFormataCGCInterna')) Then
    Result := fFormataCGCInterna(Trim(Params[0]))
  Else If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]))
  Else If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

{************************************************}
{* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
{*********************************************IV*}
procedure TfrmEmiFichaCad.pEnviaEmail(strCodCli, strTextoAdicional: String; arrArquivos : TStringArray);
var
  strAssunto    : String;
  strTexto      : String;
  strDestinata  : String;
  strEmailDest  : String;
  arrDestinatarios : TStringArray;
  strTodosArquivos : String;
  intCont          : Integer;
begin
  strDestinata := edtContato.Text;
  strEmailDest := edtEmail.Text;

  strAssunto   := 'Cliente Cód nro.: ';

  If rdgEmissao.ItemIndex = 0 Then
    strTexto := 'Segue em anexo Ficha Cadastral.'
  Else If rdgEmissao.ItemIndex = 1 Then
    strTexto := 'Segue em anexo Ficha Cadastral e Termo de Consentimento (LGPD).'
  Else If rdgEmissao.ItemIndex = 2 Then
    strTexto := 'Segue em anexo o Termo de Consentimento (LGPD).';

  strAssunto := fRetNomeEmpresa + ' - ' + strAssunto + strCodCli;

  For intCont := 0 to Length(arrArquivos) - 1 do
  Begin
    If fEmptyStr(strTodosArquivos) Then
      strTodosArquivos := arrArquivos[intCont]
    Else
      strTodosArquivos := strTodosArquivos + ';' + arrArquivos[intCont];
  End;

  pCriarArrayAnexosEDestinatarios(strTodosArquivos, strEmailDest, arrDestinatarios, arrArquivos);

  If (TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos)) Then
    fMensagem('ATENÇÃO!', 'Documento(s) enviado(s) com sucesso !', ['&Ok']);
end;

procedure TfrmEmiFichaCad.pDesabilitarSecoesSemAcesso;
begin

  if Assigned(TfrxMemoView(frxReportJ.FindObject('child_ResumoFinanceiro'))) then
    TfrxMemoView(frxReportJ.FindObject('child_ResumoFinanceiro')).Visible := blnResumoFinanceiro;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_Contatos'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_Contatos')).Visible := blnAba_Contatos;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_AutorizacaoCompra'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_AutorizacaoCompra')).Visible := blnAba_Contatos;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_DadosCobrancaEntrega'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_DadosCobrancaEntrega')).Visible := blnAba_EntregaCobranca;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_QuadroSocietario'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_QuadroSocietario')).Visible := blnAba_QuadroSocietario;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_RefBancarias'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_RefBancarias')).Visible := blnAba_RefBancaria;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_RefComerciais'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_RefComerciais')).Visible := blnAba_RefComercial;

  if Assigned(TfrxMemoView(frxReportJ.FindObject('Child_InfCrediario'))) then
    TfrxMemoView(frxReportJ.FindObject('Child_InfCrediario')).Visible := blnAba_InfCrediario;

end;

procedure TfrmEmiFichaCad.pImpAba_Contatos(blnImprime : Boolean);
var
  strSQL : String;
  i      : Integer;
begin

  if Not Assigned(TfrxMemoView(frxReportJ.FindObject('Child_Contatos'))) then
    exit;

  if (blnImprime) then
  begin

    strSQL := '';
    if (blnBranco) then
    begin

      for i := 1 to 3 do
      begin

        strSQL := strSQL + 'SELECT                 ';
        strSQL := strSQL + '  *                    ';
        strSQL := strSQL + 'FROM                   ';
        strSQL := strSQL + '  (                    ';
        strSQL := strSQL + '   SELECT              ';
        strSQL := strSQL + '     "" AS CLI_NOMCTT, ';
        strSQL := strSQL + '     "" AS CLI_NASCTT, ';
        strSQL := strSQL + '     "" AS CLI_ENDCTT, ';
        strSQL := strSQL + '     "" AS CLI_BAICTT, ';
        strSQL := strSQL + '     "" AS CID_NOMCID, ';
        strSQL := strSQL + '     "" AS CID_ESTADO, ';
        strSQL := strSQL + '     "" AS CLI_EMACTT, ';
        strSQL := strSQL + '     "" AS CLI_DEPCTT, ';
        strSQL := strSQL + '     "" AS CLI_TELCTT, ';
        strSQL := strSQL + '     "" AS CLI_CELCTT, ';
        strSQL := strSQL + '     "" AS CLI_FAXCTT, ';
        strSQL := strSQL + '     "" AS CLI_OBSERV  ';
        strSQL := strSQL + '  ) AS TAB_TEMP        ';
        strSQL := strSQL + 'WHERE TRUE             ';

        if i <> 3 then
          strSQL := strSQL + 'UNION ALL ';

      end;

      qryRelatorioContatos.Close;
      qryRelatorioContatos.SQL.Clear;
      qryRelatorioContatos.SQL.Add(strSQL);
      qryRelatorioContatos.Open;

    end
    else
    begin

      qryRelatorioContatos.Close;
      qryRelatorioContatos.SQL.Clear;
      qryRelatorioContatos.SQL.Add('SELECT');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_NOMCTT,');
      qryRelatorioContatos.SQL.Add('  IFNULL(DATE_FORMAT(CLICTT.CLI_NASCTT,"%d/%m/%Y"), "") AS CLI_NASCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_ENDCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_BAICTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_EMACTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_DEPCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_TELCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_CELCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_FAXCTT,');
      qryRelatorioContatos.SQL.Add('  CLICTT.CLI_OBSERV,');
      qryRelatorioContatos.SQL.Add('  CADCID.CID_NOMCID,');
      qryRelatorioContatos.SQL.Add('  CADCID.CID_ESTADO');
      qryRelatorioContatos.SQL.Add('FROM');
      qryRelatorioContatos.SQL.Add('  CLICTT');
      qryRelatorioContatos.SQL.Add('  LEFT JOIN CADCID ON (CADCID.CID_CODCID = CLICTT.CLI_CIDCTT)');
      qryRelatorioContatos.SQL.Add('WHERE CLI_CODCLI = :CODCLI ORDER BY CLICTT.CLI_NOMCTT');
      qryRelatorioContatos.ParamByName('CODCLI').AsString := strCodCli;
      qryRelatorioContatos.Open;

    end;

    if not qryRelatorioContatos.IsEmpty then
      TfrxChild(frxReportJ.FindObject('Child_Contatos')).Visible := True
    else
      TfrxChild(frxReportJ.FindObject('Child_Contatos')).Visible := False;

  end
  else
  begin

    qryRelatorioContatos.Close;
    qryRelatorioContatos.SQL.Clear;
    qryRelatorioContatos.SQL.Add('SELECT');
    qryRelatorioContatos.SQL.Add('  CLICTT.*,');
    qryRelatorioContatos.SQL.Add('  CADCID.CID_NOMCID,');
    qryRelatorioContatos.SQL.Add('  CADCID.CID_ESTADO');
    qryRelatorioContatos.SQL.Add('FROM');
    qryRelatorioContatos.SQL.Add('  CLICTT');
    qryRelatorioContatos.SQL.Add('  LEFT JOIN CADCID ON (CADCID.CID_CODCID = CLICTT.CLI_CIDCTT)');
    qryRelatorioContatos.SQL.Add('WHERE FALSE');
    qryRelatorioContatos.Open;

    TfrxChild(frxReportJ.FindObject('Child_Contatos')).Visible := False;

  end;

end;

function TfrmEmiFichaCad.fSQL_ContatosAutorizacaoComprasEmBranco(blnImprime, blnEmBranco: Boolean): string;
var
  intQtde: Integer;
  i: Integer;
begin
  Result := '';
  intQtde := 2;

  for i := 1 to intQtde do
  begin
    Result := Result + 'SELECT                 ';
    Result := Result + '  *                    ';
    Result := Result + 'FROM                   ';
    Result := Result + '  (                    ';
    Result := Result + '   SELECT              ';
    Result := Result + '     "." AS CLI_NOMCTT, ';
    Result := Result + '     "" AS ' + IIF((blnImprime) and (not blnBranco), 'CLI_NUMR_G', 'CLI_RG_CTT') + ', ';
    Result := Result + '     "" AS ' + IIF((blnImprime) and (not blnBranco), 'CLI_NUMCPF', 'CLI_CPFCTT') + ', ';
    Result := Result + '     "" AS CLI_ASSCTT  ';
    Result := Result + '  ) AS TAB_TEMP        ';
    Result := Result + 'WHERE TRUE             ';

    if (intQtde > 1) and (i < intQtde) then
      Result := Result + 'UNION ALL ';
  end;
end;

function TfrmEmiFichaCad.fWordToPDF(strWordFile: String): String;
var objWord : TWord;
    strPDFFile : String;
begin
  Result := '';

  If Not FileExists(strWordFile) Then
    Exit;

  strPDFFile := ReplaceStr(strWordFile, ExtractFileExt(strWordFile), '.pdf');

  objWord := TWord.fCriarWord(Nil);

  Try
    If objWord.AbrirArquivo(strWordFile) Then
      objWord.SaveAsPDF(strPDFFile);
  Finally
    objWord.pFechar;
    FreeAndNil(objWord);

    DeleteFile(strWordFile);
  End;

  If FileExists(strPDFFile) Then
    Result := strPDFFile;
end;

procedure TfrmEmiFichaCad.pImpAba_ContatosAutorizacaoCompras(blnImprime : Boolean);
begin

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_AutorizacaoCompra'))) then
    exit;

  if (blnImprime) then
  begin
    if (blnBranco) then
    begin
      qryRelatorioAutorizacaoCompra.Close;
      qryRelatorioAutorizacaoCompra.SQL.Clear;
      qryRelatorioAutorizacaoCompra.SQL.Add(fSQL_ContatosAutorizacaoComprasEmBranco(blnimprime, blnBranco));
      qryRelatorioAutorizacaoCompra.Open;
    end
    else
    begin
      {Embora o cliente marque a opção "Autorização de Compra neste form"
      o sistema so carregará os dados de contato se a config abaixo estiver habilitada}
      If fCfgSis('AUTCTT', varBoolean) Then
      Begin
        qryRelatorioAutorizacaoCompra.Close;
        qryRelatorioAutorizacaoCompra.SQL.Clear;
        qryRelatorioAutorizacaoCompra.SQL.Add('SELECT');
        qryRelatorioAutorizacaoCompra.SQL.Add('  CLICTT.CLI_NOMCTT,');
        qryRelatorioAutorizacaoCompra.SQL.Add('  CLICTT.CLI_NUMR_G,');
        qryRelatorioAutorizacaoCompra.SQL.Add('  CLICTT.CLI_NUMCPF,');
        qryRelatorioAutorizacaoCompra.SQL.Add('  "" AS CLI_ASSCTT  ');
        qryRelatorioAutorizacaoCompra.SQL.Add('FROM');
        qryRelatorioAutorizacaoCompra.SQL.Add('  CLICTT');
        qryRelatorioAutorizacaoCompra.SQL.Add('  LEFT JOIN CADCID ON (CADCID.CID_CODCID = CLICTT.CLI_CIDCTT)');
        qryRelatorioAutorizacaoCompra.SQL.Add('WHERE CLI_CODCLI = :CODCLI AND CLI_AUTCTT = :AUTCTT ORDER BY CLICTT.CLI_NOMCTT');
        qryRelatorioAutorizacaoCompra.ParamByName('CODCLI').AsString := strCodCli;
        qryRelatorioAutorizacaoCompra.ParamByName('AUTCTT').AsString := 'S';
        qryRelatorioAutorizacaoCompra.Open;
      End;

      if (qryRelatorioAutorizacaoCompra.IsEmpty) then
      Begin
        qryRelatorioAutorizacaoCompra.Close;
        qryRelatorioAutorizacaoCompra.SQL.Clear;
        qryRelatorioAutorizacaoCompra.SQL.Add(fSQL_ContatosAutorizacaoComprasEmBranco(blnimprime, blnBranco));
        qryRelatorioAutorizacaoCompra.Open;
      End;

    end;

    if not qryRelatorioAutorizacaoCompra.IsEmpty then
      TfrxChild(frxReportJ.FindObject('Child_AutorizacaoCompra')).Visible := True
    else
      TfrxChild(frxReportJ.FindObject('Child_AutorizacaoCompra')).Visible := False;
  end
  Else
  Begin
    qryRelatorioAutorizacaoCompra.Close;
    qryRelatorioAutorizacaoCompra.SQL.Clear;
    qryRelatorioAutorizacaoCompra.SQL.Add(fSQL_ContatosAutorizacaoComprasEmBranco(blnimprime, blnBranco));
    qryRelatorioAutorizacaoCompra.Open;

    TfrxChild(frxReportJ.FindObject('Child_AutorizacaoCompra')).Visible := False;
  End;
end;


procedure TfrmEmiFichaCad.pImpAba_EntregaCobranca(blnImprime : Boolean);
begin

  {*******************************}
  {* DADOS DE COBRANÇA E ENTREGA *}
  {** 12/04/2010 **************IV*}

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_DadosCobrancaEntrega'))) then
    exit;

  TfrxChild(frxReportJ.FindObject('Child_DadosCobrancaEntrega')).Visible := blnImprime;

end;

procedure TfrmEmiFichaCad.pOcultaObservacao;
  Var
    comRelatorio: TfrxComponent;
begin
  comRelatorio := frxReportJ.FindObject('Memo161');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
  Begin
    TfrxMemoView(comRelatorio).Visible := True;
    TfrxMemoView(comRelatorio).Height := FfltAlturaMemoObs;
  End;
  comRelatorio := frxReportJ.FindObject('Memo38');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
    TfrxMemoView(comRelatorio).Visible := True;

  comRelatorio := frxReportJ.FindObject('rdbDadosGerais');
  If Assigned(comRelatorio) and (comRelatorio is TfrxMasterData) Then
    TfrxMasterData(comRelatorio).Height := FfltAlturaBandaOrig;

  If Not blnBranco Then
  Begin
    If fEmptyStr(frmModuloSPR.qryRelatorio.FieldByName('CLI_OBSERV').AsString) Then
    Begin
      comRelatorio := frxReportJ.FindObject('Memo161');
      If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
      Begin
        TfrxMemoView(comRelatorio).Visible := False;
        TfrxMemoView(comRelatorio).Height := 0;
      End;

      comRelatorio := frxReportJ.FindObject('Memo38');
      If Assigned(comRelatorio) and (comRelatorio is TfrxMemoView) Then
        TfrxMemoView(comRelatorio).Visible := False;

      comRelatorio := frxReportJ.FindObject('rdbDadosGerais');
      If Assigned(comRelatorio) and (comRelatorio is TfrxMasterData) and (FfltTopQuadroObs > 0) Then
        TfrxMasterData(comRelatorio).Height := FfltTopQuadroObs;
    End;
  End;
end;

procedure TfrmEmiFichaCad.pImpAba_Geral(blnImprime : Boolean);
begin
  {Quando for necessário algum tratamento para os dados gerais,
   adicione aqui!...}
  Exit;
end;

procedure TfrmEmiFichaCad.pImpAba_InfCrediario(blnImprime : Boolean);
begin

  {******************************}
  {* "INFORMAÇÕES DE CREDIÁRIO" *}
  {******************************}

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_InfCrediario'))) then
    exit;

  TfrxChild(frxReportJ.FindObject('Child_InfCrediario')).Visible := blnImprime;

  if (blnImprime) then
  begin

    {Cartões}
    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_VISA__').AsString = 'S') then
      TfrxCheckBoxView(frxReportJ.FindObject('chkVisa')).Checked := True
    else
      TfrxCheckBoxView(frxReportJ.FindObject('chkVisa')).Checked := False;

    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_MASTER').AsString = 'S') then
      TfrxCheckBoxView(frxReportJ.FindObject('chkMasterCard')).Checked := True
    else
      TfrxCheckBoxView(frxReportJ.FindObject('chkMasterCard')).Checked := False;

    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_HIPERC').AsString = 'S') then
      TfrxCheckBoxView(frxReportJ.FindObject('chkHiperCard')).Checked := True
    else
      TfrxCheckBoxView(frxReportJ.FindObject('chkHiperCard')).Checked := False;

    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_AMERIC').AsString = 'S') then
      TfrxCheckBoxView(frxReportJ.FindObject('chkAmericanExpress')).Checked := True
    else
      TfrxCheckBoxView(frxReportJ.FindObject('chkAmericanExpress')).Checked := False;

    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_DINERS').AsString = 'S') then
      TfrxCheckBoxView(frxReportJ.FindObject('chkDiners')).Checked := True
    else
      TfrxCheckBoxView(frxReportJ.FindObject('chkDiners')).Checked := False;

    {Nacionalidade}
    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_NACION').AsString <> '') then
      TfrxMemoView(frxReportJ.FindObject('Memo265')).Text := fRetNomePais(frmModuloSPR.qryRelatorio.FieldByName('CLI_NACION').AsString)
    else
      TfrxMemoView(frxReportJ.FindObject('Memo265')).Text := '';

    {Naturalidade}
    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_NATURA').AsString <> '') then
      TfrxMemoView(frxReportJ.FindObject('Memo266')).Text := fRetNomCidade(frmModuloSPR.qryRelatorio.FieldByName('CLI_NATURA').AsString)
    else
      TfrxMemoView(frxReportJ.FindObject('Memo266')).Text := '';

    {Avalista}
    if (frmModuloSPR.qryRelatorio.FieldByName('CLI_AVALIS').AsString <> '') then
      TfrxMemoView(frxReportJ.FindObject('Memo268')).Text := fRetNomCliente(frmModuloSPR.qryRelatorio.FieldByName('CLI_AVALIS').AsString)
    else
      TfrxMemoView(frxReportJ.FindObject('Memo268')).Text := '';

  end;

end;

procedure TfrmEmiFichaCad.pImpAba_QuadroSocietario(blnImprime : Boolean);
  Var
    strSQL: String;
    i: Integer;
begin
  {*********************}
  {* QUADRO SOCIETÁRIO *}
  {** 12/04/2010 ****IV*}

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_QuadroSocietario'))) then
    exit;

  If blnImprime Then
  Begin
    strSQL := '';

    If blnBranco Then
    Begin
      For i := 1 To 3 Do
      Begin
        strSQL := strSQL + 'SELECT "" SCO_NOMSCO, ';
        strSQL := strSQL + '       "" SCO_CPFCNP, ';
        strSQL := strSQL + '       "" SCO_DTANAS, ';
        strSQL := strSQL + '       "" SCO_PER_PS, ';
        strSQL := strSQL + '       "" SCO_ESTCIV  ';

        If i < 3 then
          strSQL := strSQL + ' UNION ALL ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + 'SELECT SCO_NOMSCO, ';
      strSQL := strSQL + '       SCO_CPFCNP, ';
      strSQL := strSQL + '       SCO_DTANAS, ';
      strSQL := strSQL + '       SCO_PER_PS, ';
      strSQL := strSQL + '       CASE SCO_ESTCIV ';
      strSQL := strSQL + '         WHEN "C" THEN "CASADO" ';
      strSQL := strSQL + '         WHEN "S" THEN "SOLTEIRO" ';
      strSQL := strSQL + '         WHEN "M" THEN "MARITAL" ';
      strSQL := strSQL + '         WHEN "O" THEN "OUTROS" ';
      strSQL := strSQL + '       END SCO_ESTCIV ';
      strSQL := strSQL + 'FROM CLISCO ';
      strSQL := strSQL + 'WHERE SCO_CODCLI = '+ strCodCli.QuotedString;
      strSQL := strSQL + 'ORDER BY SCO_NOMSCO ';
    End;

    qrySocios.Close;
    qrySocios.SQL.Text := strSQL;
    qrySocios.Open;

    TfrxChild(frxReportJ.FindObject('Child_QuadroSocietario')).Visible := Not qrySocios.IsEmpty;
  End
  Else
    TfrxChild(frxReportJ.FindObject('Child_QuadroSocietario')).Visible := False;
end;

procedure TfrmEmiFichaCad.pImpAba_RefBancaria(blnImprime : Boolean);
begin

  {*************************}
  {* REFERENCIAS BANCARIAS *}
  {** 12/04/2010 ********IV*}

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_RefBancarias'))) then
    exit;

  TfrxChild(frxReportJ.FindObject('Child_RefBancarias')).Visible := blnImprime;

end;

procedure TfrmEmiFichaCad.pImpAba_RefComercial(blnImprime : Boolean);
begin

  {**************************}
  {* REFERENCIAS COMERCIAIS *}
  {** 12/04/2010 *********IV*}

  if Not Assigned(TfrxChild(frxReportJ.FindObject('Child_RefComerciais'))) then
    exit;

  TfrxChild(frxReportJ.FindObject('Child_RefComerciais')).Visible := blnImprime;

end;

procedure TfrmEmiFichaCad.pImpResumoFinanceiro(blnImprime: Boolean);
begin

  if Not Assigned(TfrxChild(frxReportJ.FindObject('child_ResumoFinanceiro'))) then
    exit;

  TfrxChild(frxReportJ.FindObject('child_ResumoFinanceiro')).Visible := blnImprime;

  cdsResumoFinanceiro.EmptyDataSet;

  If (blnImprime) Then
  Begin

    Try

      If Not fEmptyStr(strCodCli) Then
      Begin

        pCriarFormularios(TfrmResFinanceiro, frmResFinanceiro);
        frmResFinanceiro.strCodCli := strCodCli;

        If Not blnBranco Then
          frmResFinanceiro.pSetaAjusteData(fMensagem('Ajuste de Datas - Impressão do "Resumo Financeiro"',
                                            'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                            ['&Sim','&Não'],2) = 1);

        frmResFinanceiro.FormShow(frmResFinanceiro);

        cdsResumoFinanceiro.Append;
        cdsResumoFinanceiroTOT_DUP_ABE_QTD.AsInteger := StrToIntDef(frmResFinanceiro.edtTotalQtd.Text, 0);
        cdsResumoFinanceiroTOT_DUP_ABE_VAL.AsFloat   := fStrToFloat(frmResFinanceiro.edtTotalVr.Text);

        cdsResumoFinanceiroTOT_DUP_LIQ_QTD.AsInteger := StrToIntDef(frmResFinanceiro.edtTotalLiqQtd.Text, 0);
        cdsResumoFinanceiroTOT_DUP_LIQ_VAL.AsFloat   := fStrToFloat(frmResFinanceiro.edtTotalLiqValor.Text);

        cdsResumoFinanceiroTOT_DUP_ATR_QTD.AsInteger := StrToIntDef(frmResFinanceiro.edtAtrasQtd.Text, 0);
        cdsResumoFinanceiroTOT_DUP_ATR_VAL.AsFloat   := fStrToFloat(frmResFinanceiro.edtAtrasVr.Text);

        cdsResumoFinanceiroTOT_DUP_LTR_QTD.AsInteger := StrToIntDef(frmResFinanceiro.edtAtrasLiqQtd.Text, 0);
        cdsResumoFinanceiroTOT_DUP_LTR_VAL.AsFloat   := fStrToFloat(frmResFinanceiro.edtAtrasLiqVr.Text);

        cdsResumoFinanceiroLIM_CRE_DISPONI.AsFloat   := fStrToFloat(frmResFinanceiro.edtDisponivel.Text);
        cdsResumoFinanceiroDIAS_SEM_VENDA_.AsInteger := StrToIntDef(frmResFinanceiro.edtInativo.Text, 0);

        cdsResumoFinanceiroULT_COMPRA_DATA.AsString  := frmResFinanceiro.edtDtaUltCom.Text;
        cdsResumoFinanceiroULT_COMPRA_NOTA.AsString  := frmResFinanceiro.edtNumNota.Text;
        cdsResumoFinanceiroULT_COMPRA_VAL_.AsFloat   := fStrToFloat(frmResFinanceiro.edtVrUltCom.Text);

        cdsResumoFinanceiroMAI_COMPRA_DATA.AsString  := frmResFinanceiro.edtDtaMaiorCompra.Text;
        cdsResumoFinanceiroMAI_COMPRA_NOTA.AsString  := frmResFinanceiro.edtNotaMaiorComp.Text;
        cdsResumoFinanceiroMAI_COMPRA_VAL_.AsFloat   := fStrToFloat(frmResFinanceiro.edtMaiorCompra.Text);

        cdsResumoFinanceiroATRASADOS_MEDIA.AsFloat   := fStrToFloat(frmResFinanceiro.edtMediaAtrasado.Text);
        cdsResumoFinanceiroATRASADOS_MAIOR.AsFloat   := fStrToFloat(frmResFinanceiro.edtMaiorAtrasado.Text);
        cdsResumoFinanceiroATRASADOS_ATUAL.AsFloat   := fStrToFloat(frmResFinanceiro.edtAtualAtrasado.Text);
        cdsResumoFinanceiro.Post;

        pFreeAndNil(frmResFinanceiro);

      End
      Else
        fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEmiFichaCad.pImpResumoFinanceiro]');
      End;
    End;

  End
  Else
  Begin

    cdsResumoFinanceiro.Append;
    cdsResumoFinanceiroTOT_DUP_ABE_QTD.AsString := '';
    cdsResumoFinanceiroTOT_DUP_ABE_VAL.AsString := '';
    cdsResumoFinanceiroTOT_DUP_LIQ_QTD.AsString := '';
    cdsResumoFinanceiroTOT_DUP_LIQ_VAL.AsString := '';
    cdsResumoFinanceiroTOT_DUP_ATR_QTD.AsString := '';
    cdsResumoFinanceiroTOT_DUP_ATR_VAL.AsString := '';
    cdsResumoFinanceiroTOT_DUP_LTR_QTD.AsString := '';
    cdsResumoFinanceiroTOT_DUP_LTR_VAL.AsString := '';
    cdsResumoFinanceiroLIM_CRE_DISPONI.AsString := '';
    cdsResumoFinanceiroDIAS_SEM_VENDA_.AsString := '';
    cdsResumoFinanceiroULT_COMPRA_DATA.AsString := '';
    cdsResumoFinanceiroULT_COMPRA_NOTA.AsString := '';
    cdsResumoFinanceiroULT_COMPRA_VAL_.AsString := '';
    cdsResumoFinanceiroMAI_COMPRA_DATA.AsString := '';
    cdsResumoFinanceiroMAI_COMPRA_NOTA.AsString := '';
    cdsResumoFinanceiroMAI_COMPRA_VAL_.AsString := '';
    cdsResumoFinanceiroATRASADOS_MEDIA.AsString := '';
    cdsResumoFinanceiroATRASADOS_MAIOR.AsString := '';
    cdsResumoFinanceiroATRASADOS_ATUAL.AsString := '';
    cdsResumoFinanceiro.Post;

  End;

end;

procedure TfrmEmiFichaCad.pMontaListaOpcoes;
var
  intIndice : Integer;
begin

  cdsOpcoes.EmptyDataSet;

  {Geral}
  {Será sempre impresso! Sem possibilidade de selecionar!
  if (blnAba_Geral) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Geral';
    cdsOpcoesSIGLA.AsString        := 'GERAL_';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;
  }

  {Resumo Financeiro}
  if (blnResumoFinanceiro) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Resumo Financeiro';
    cdsOpcoesSIGLA.AsString        := 'RESFIN';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Contatos}
  if (blnAba_Contatos) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Contatos';
    cdsOpcoesSIGLA.AsString        := 'CONTAT';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Endereço Entrega/Cobrança}
  if (blnAba_EntregaCobranca) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Dados de Cobrança/Entrega';
    cdsOpcoesSIGLA.AsString        := 'DADCOB';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Quadro Societário}
  if (blnAba_QuadroSocietario) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Quadro Societário';
    cdsOpcoesSIGLA.AsString        := 'QUASOC';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Ref. Bancária}
  if (blnAba_RefBancaria) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Ref. Bancária';
    cdsOpcoesSIGLA.AsString        := 'REFBAN';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Ref. Comercial}
  if (blnAba_RefComercial) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Ref. Comercial';
    cdsOpcoesSIGLA.AsString        := 'REFCOM';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Inf. Crediário}
  if (blnAba_InfCrediario) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Inf. Crediário';
    cdsOpcoesSIGLA.AsString        := 'INFCRE';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  {Aut. de Compra}
  if (blnAba_Contatos) then
  begin
    cdsOpcoes.Append;
    cdsOpcoesNOME_ABA.AsString     := 'Autorização de Compra';
    cdsOpcoesSIGLA.AsString        := 'AUTCMP';
    cdsOpcoesSELECIONADO.AsBoolean := True;
    cdsOpcoes.Post;
  end;

  chklstOpcoes.Clear;

  if not cdsOpcoes.IsEmpty then
  begin

    intIndice := 0;

    cdsOpcoes.First;
    while not cdsOpcoes.Eof do
    begin

      if (cdsOpcoesSELECIONADO.AsBoolean) then
      begin

        chklstOpcoes.Items.Add(cdsOpcoesNOME_ABA.AsString);
        chklstOpcoes.Checked[intIndice] := True;

        cdsOpcoes.Edit;
        cdsOpcoesINDICE_LISTA.AsInteger := intIndice;
        cdsOpcoes.Post;

        intIndice := (intIndice + 1);

      end;

      cdsOpcoes.Next;

    end;

  end;

end;

procedure TfrmEmiFichaCad.rdgFormasEnvioClick(Sender: TObject);
begin
  inherited;
  Case rdgFormasEnvio.ItemIndex of
       0,3: Begin
            lblEmail.Enabled     := False;
            edtEmail.Enabled     := False;
            edtEmail.Text        := '';
            edtEmail.Color       := $00FFE4D5;
            lblContato.Enabled   := False;
            edtContato.Enabled   := False;
            edtContato.Color     := $00FFE4D5;
          End;
      1,2: Begin
            lblEmail.Enabled     := True;
            edtEmail.Enabled     := True;
            edtEmail.Text        := fRetEmailCliente(strCodCli);
            edtEmail.Color       := clWhite;
            lblContato.Enabled   := True;
            edtContato.Enabled   := True;
            edtContato.Color     := clWhite;
          End;
  End;
end;

procedure TfrmEmiFichaCad.FormCreate(Sender: TObject);
begin
  Inherited;
  frxReportJ.AddFunction('function fFormataCondPag(strCond : String): String');
  frxReportJ.AddFunction('function fFormataCGCInterna(strC_G_C_: String): String');
  frxReportJ.AddFunction('function fFormataFoneInterna(strFone: String): String');
  frxReportJ.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
  FPais := fSetaPais;
  cdsOpcoes.CreateDataSet;
  cdsResumoFinanceiro.CreateDataSet;
  blnMontouTermo := False;
end;

procedure TfrmEmiFichaCad.FormShow(Sender: TObject);
begin
  inherited;
  {Monta lista de opções de abas disponíveis para impressão,
  conforme configurações e regras de acesso no cadastro de clientes!}
  pMontaListaOpcoes;

end;

procedure TfrmEmiFichaCad.pMontarTermoConsentimentoBacen;
  Var
    strCaminhoModelo : String;
    strCaminhoDestino : String;
    strExtensao : String;
    strCaminhoExecutavel : String;
    Word: TWord;
begin
  strCaminhoModelo := fCfgSis('PATETI');

  If (fEmptyStr(strCaminhoModelo)) Or (Not DirectoryExists(strCaminhoModelo)) Then
  Begin
    pMensagemOk('O caminho "CFG_PATETI" não foi encontrado ou não está configurado, favor verificar!');
    Exit;
  End;

  strCaminhoModelo := strCaminhoModelo + '\Termo de Consentimento Bacen';
  strExtensao := '.docx';

  If Not FileExists(strCaminhoModelo + strExtensao) Then
    strExtensao := '.doc';

  If Not FileExists(strCaminhoModelo + strExtensao) Then
  Begin
    pMensagemOk('Não foi encontrado o layout "Termo de Consentimento Bacen.'+strExtensao+'" dentro do caminho selecionado na "CFG_PATETI", favor verificar!');
    Exit;
  End;

  strCaminhoModelo := strCaminhoModelo + strExtensao;
  strCaminhoExecutavel := ExtractFilePath(Application.ExeName);

  If Not DirectoryExists(strCaminhoExecutavel+'TermoCliente') Then
    CreateDir(strCaminhoExecutavel+'TermoCliente');

  strCaminhoDestino := strCaminhoExecutavel+'TermoCliente\TermoBACEN_' + strCodCli + '.docx';

  Try
    If FileExists(strCaminhoDestino) Then
      DeleteFile(strCaminhoDestino);

    Word := TWord.fCriarWord(Nil);

    CopyFile(PChar(strCaminhoModelo), PChar(strCaminhoDestino), False);

    If Word = Nil Then
      Exit;

    Try
      If Not Word.AbrirArquivo(strCaminhoDestino) Then
      Begin
        pMensagemOk('Não foi possível abrir o arquivo "' + strCaminhoDestino + '"!');
        Exit;
      End;

      Word.pGoToPageHeader;
      Word.pGoToMainDocument;

      Word.pReplace('{{NOME_CLIENTE}}',   IIF(blnBranco, '',                  frmModuloSPR.qryRelatorio.FieldByName('CLI_NOMCLI').asString));
      Word.pReplace('{{CNPJ_CLIENTE}}',   IIF(blnBranco, fstrEspaco('',18,1), fFormataCpfCgc(frmModuloSPR.qryRelatorio.FieldByName('CLI_C_G_C_').asString, FPais)));
      Word.pReplace('{{NOME_EMPRESA}}',   IIF(blnBranco, fstrEspaco('',20,1), fCadEmp('NOMEMP')));
      Word.pReplace('{{CNPJ_EMPRESA}}',   IIF(blnBranco, fstrEspaco('',18,1), fFormataCpfCgc(fCadEmp('C_G_C_'), FPais)));
      Word.pReplace('{{CIDADE_DATA_IMPRESSAO}}', IIF(blnBranco, fstrEspaco('',70,1), fRetDataExtenso(VS_Date, True)));

      Sleep(2000);//deve aguardar para concluir o replace no documento

      Word.pSalvar;
      blnMontouTermo := True;

      Word.pFechar;
    Finally
      FreeAndNil(Word);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmEmiFichaCad.pMontarTermoConsentimentoBacen]');
  End;

end;

procedure TfrmEmiFichaCad.pMontarTermoConsentimento;
Var LstrExecutavel,
    LstrNomArquivoDest,
    LstrNomArquivoOri,
    LstrExtensao : String;
    Word: TWord;
begin
  LstrExecutavel    := ExtractFilePath(Application.ExeName);
  LstrNomArquivoOri := ExtractFilePath(Application.ExeName) + 'Termo de Consentimento para Tratamento de Dados Pessoais CLIENTES';
  LstrExtensao      := '.docx';

  If Not FileExists(LstrNomArquivoOri + LstrExtensao) Then
    LstrExtensao := '.doc';

  If Not FileExists(LstrNomArquivoOri + LstrExtensao) Then
  Begin
    pMensagemOk('Arquivo "' + LstrNomArquivoOri + LstrExtensao + '" não encontrado!');
    Exit;
  End;

  LstrNomArquivoOri := LstrNomArquivoOri + LstrExtensao;

  If Not DirectoryExists(LstrExecutavel+'TermoCliente') Then
    CreateDir(LstrExecutavel+'TermoCliente');

  LstrNomArquivoDest := LstrExecutavel+'TermoCliente\TermoLGPD_' + strCodCli + '.docx';

  Try
    If FileExists(LstrNomArquivoDest) Then
      DeleteFile(LstrNomArquivoDest);

    Word := TWord.fCriarWord(Nil);

    CopyFile(PChar(LstrNomArquivoOri), PChar(LstrNomArquivoDest), False);

    If Word = Nil Then
      Exit;

    Try
      If Not Word.AbrirArquivo(LstrNomArquivoDest) Then
      Begin
        pMensagemOk('Não foi possível abrir o arquivo "' + LstrNomArquivoDest + '"!');
        Exit;
      End;

      Word.pGoToPageHeader;
      Word.pGoToMainDocument;

      Word.pReplace('{{RAZAOEMP}}',   IIF(blnBranco,fstrEspaco('',20,1),fCadEmp('NOMEMP')));
      Word.pReplace('{{CNPJ}}',       IIF(blnBranco,fstrEspaco('',20,1),fFormataCpfCgc(fCadEmp('C_G_C_'), FPais)));
      Word.pReplace('{{ENDCOMPL}}',   IIF(blnBranco,fstrEspaco('',150,1),fCadEmp('ENDERECO')));
      Word.pReplace('{{DDDTEL}}',     IIF(blnBranco,fstrEspaco('',15,1),fFormataFone(fCadEmp('FONE01'))));
      Word.pReplace('{{EMAIL}}',      IIF(blnBranco,fstrEspaco('',50,1),fCadEmp('EMAIL_')));
      Word.pReplace('{{DATAEXT}}',    IIF(blnBranco,'',fRetDataExtenso(VS_Date, True)));
      Word.pReplace('{{NOMECLI}}',    IIF(blnBranco,'',frmModuloSPR.qryRelatorio.FieldByName('CLI_NOMCLI').asString));
      Word.pReplace('{{CPFCNPJCLI}}', IIF(blnBranco,fstrEspaco('',20,1),fFormataCpfCgc(frmModuloSPR.qryRelatorio.FieldByName('CLI_C_G_C_').asString, FPais)));
      Word.pReplace('{{FANTEMP}}',    IIF(blnBranco,'',fCadEmp('NOMFAN')));

      Sleep(2000);//deve aguardar para concluir o replace no documento

      Word.pSalvar;
      blnMontouTermo := True;

      Word.pFechar;
    Finally
      FreeAndNil(Word);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmEmiFichaCad.pMontarTermoConsentimento]');
  End;
end;

procedure TfrmEmiFichaCad.pImprimirTermoConsentimento(strPasta: String; strPrefixo: String; strNomeRelatorio: String);
Var LstrExecutavel,
    LstrNomArquivoDest,
    LstrNomImp   : String;
    LstrTipImp   : String;
    LblnImprime  : Boolean;
    Word: TWord;
Begin
  Try
    If not blnMontouTermo Then
      Exit;


    LstrExecutavel     := ExtractFilePath(Application.ExeName);
    LstrNomArquivoDest := LstrExecutavel + strPasta + '\' + strPrefixo + strCodCli + '.docx';

    If not FileExists(LstrNomArquivoDest) Then
    Begin
      LstrNomArquivoDest := LstrExecutavel + strPasta +'\'+ strPrefixo + strCodCli + '.doc';
      If not FileExists(LstrNomArquivoDest) Then
      Begin
        pMensagemOk('Arquivo "' + LstrNomArquivoDest + '" não encontrado!');
        Exit;
      End;
    End;

    Try
      Word := TWord.fCriarWord(Nil);

      If Word = Nil Then
        Exit;

      If Not Word.AbrirArquivo(LstrNomArquivoDest) Then
      Begin
        pMensagemOk('Não foi possível abrir o arquivo "' + LstrNomArquivoDest + '"!');
        Exit;
      End;

      pCarregaConfImpr(qryCfgRel, strNomeRelatorio);
      LstrNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      if fEmptyStr(LstrNomImp) then
      begin
        LblnImprime := fPreImpressao(qryCfgRel, LstrNomImp, LstrTipImp, False, 'I');
      end
      else
      begin
        LblnImprime := True;
      end;

      if LblnImprime then
        TCfgRel.pPrintReport(strNomeRelatorio, ExtractFileName(LstrNomArquivoDest), LstrNomImp, Word);

      blnMontouTermo := False;
      Word.pFechar;
      Application.ProcessMessages;
    Finally
      FreeAndNil(Word);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmEmiFichaCad.pImprimirTermoConsentimento]');
  End;
End;

procedure TfrmEmiFichaCad.pLoadReport;
  Var
    FLayImp: TUniQuery;
    mmsLoad: TStream;
begin
  FLayImp := fCriaQuery(Nil);
  Try
    Try
      FLayImp.Close;
      FLayImp.SQL.Clear;

      FLayImp.SQL.Add('SELECT LAY_RELFR3 FROM LAYIMP '+
                      ' WHERE LAY_TIPLAY = :TIPLAY '+
                      '   AND LAY_CODEMP = :CODEMP '+
                      '   AND LAY_CODLAY = :CODLAY '+
                      ' ORDER BY LAY_DTAALT DESC, LAY_HORALT DESC '+
                      ' LIMIT 1');

      FLayImp.ParamByName('CODLAY').AsString := 'FICCLI';
      FLayImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FLayImp.ParamByName('TIPLAY').AsString := 'L';

      FLayImp.Open;
      If Not FLayImp.IsEmpty Then
      Begin
        mmsLoad := FLayImp.CreateBlobStream(FLayImp.FieldByName('LAY_RELFR3'), bmRead);
        Try
          frxReportJ.LoadFromStream(mmsLoad);
        Finally
          FreeAndNil(mmsLoad);
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fLoadReport]');
    End;
  Finally
    FreeAndNil(FLayImp);
  End;
end;

end.
