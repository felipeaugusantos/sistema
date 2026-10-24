unit untRetBcoAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, System.Generics.Collections,
  cxProgressBar, untGravando, untFuncoesSimples, Data.DB, Datasnap.DBClient,
  UniClientDataSet,System.StrUtils, frxDBSet, XMLDoc, XMLIntf, untTBancoItauAPI,
  untTBancoSicoobApi, untTBancoBradescoAPI;

type
  TfrmRetBcoAPI = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    pnlItens: TPanel;
    pnlTopo: TPanel;
    lblPeriodoConciliacao: TLabel;
    Label4: TLabel;
    edtDataInicial: TcxDateEdit;
    Label3: TLabel;
    edtDataFinal: TcxDateEdit;
    cdsNaoGra: TUniClientDataSet;
    cdsNaoGraNOSNUM: TStringField;
    cdsNaoGraDTAVEN: TDateField;
    cdsNaoGraDTAPAG: TDateField;
    cdsNaoGraVALDUP: TFloatField;
    cdsNaoGraVALPAG: TFloatField;
    cdsNaoGraCODCLI: TStringField;
    cdsNaoGraCODEMP: TStringField;
    cdsNaoGraESPDOC: TStringField;
    cdsNaoGraNUMDUP: TStringField;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxDBNaoGra: TfrxDBDataset;
    gbCarteira: TGroupBox;
    lblDadosDaConta: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FNomeDoBanco,
    FConfig,
    FCodigoDoBanco: String;

    FCarteira: Integer;

    FObjetoImportacao: TObject;

    FProgresso: TfrmGravando;

    FDuplicatasBaixadas,
    FDuplicatasNaoGravadas: TStringList;

    function RetornaDadosDaCarteira: String;

    function ImportaDadosBancoInter(cxgProgresso: TcxProgressBar = nil): Boolean;
    function ImportaDadosBancoDoBrasilApi(cxgProgresso: TcxProgressBar = nil): Boolean;
    function ImportaDadosBancoCredisisApi(cxgProgresso: TcxProgressBar): Boolean;
    function ImportaDadosBancoSicrediApi(cxgProgresso: TcxProgressBar): Boolean;
    function ImportaDadosBancoItauApi(cxgProgresso: TcxProgressBar = nil): Boolean;
    procedure GravaMovimentosDescontoItau(ADescontos: TList<TMovimentoDescontoItau>;
                                          var AChaveDuplicatas: TStringList;
                                          var AExiste: Boolean);
    procedure LiberaResultadoItau(var AResultado: TList<TRetornoPesquisaBancoItauApi>);
    function ImportaDadosBancoSicoobApi(cxgProgresso: TcxProgressBar = nil): Boolean;
    function ImportaDadosBancoSantanderApi(cxgProgresso: TcxProgressBar = nil): Boolean;
    function ImportaDadosBancoBradescoApi(cxgProgresso: TcxProgressBar = nil): Boolean;

    procedure GravaOcorrenciaFinanceiroNoCRM(ADuplicata: TDuplicataCtr);

    procedure ExibeMensagensImportacao(AImportouAlgumRegistro: Boolean);
    procedure pMostraDupNaoBaixa(lstArqNaoGravados: TStringList; blnImpDes: Boolean = True);
    function  RetornaOcorrenciaBoleto(strSituacao : String; var scodOco :string; var scodmot : String; var RecebPix : String): String;


    procedure AbreCdsNaoBaixa;
    procedure FechaCdsNaoBaixa;

    procedure MostraArquivoNaoBaixados;

    function ValidaPeriodoImportadoRetGer(APeriodo, ACarteira: String): Boolean;
    function GetConfiguracao: String;
    function ValidaPeriodoImportadoPorModalidadeDeCobranca:Boolean;
    procedure AguardeCincoSegundos;

    function DeveGravarRetGer(AGravouRetGer: Boolean;
                              ANomeArquivo,
                              ANomeArquivoBoleto: String): Boolean;
    procedure ExibeFormMensagemErro(AMensagem: String);
    { Private declarations }
  public
    property NomeDoBanco:      String  read FNomeDoBanco      write FNomeDoBanco;
    property Carteira:         Integer read FCarteira         write FCarteira;
    property Configuracao:     String  read FConfig           write FConfig;
    property CodigoDoBanco:    String  read FCodigoDoBanco    write FCodigoDoBanco;
    property ObjetoImportacao: TObject read FObjetoImportacao write FObjetoImportacao;

    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation
Uses DateUtils, untTBancoInter,untTBancoDoBrasilAPI, untFuncAutBan, untLogCtr, untAtualizaOcorrenciasCRM,
     untTypesCRM, untModuloRetBco, untTBancoCredisisApi, untTBancoSicrediApi,
     untTBancoSantanderAPI, untArqNaoGravados;

{$R *.dfm}

procedure TfrmRetBcoAPI.AbreCdsNaoBaixa;
Begin
  cdsNaoGra.CreateDataSet;
  cdsNaoGra.Open;
  cdsNaoGra.EmptyDataSet;
End;

procedure TfrmRetBcoAPI.FechaCdsNaoBaixa;
Begin
  cdsNaoGra.EmptyDataSet;
  cdsNaoGra.Close;
End;

procedure TfrmRetBcoAPI.MostraArquivoNaoBaixados;
  Var
    LNomImp,
    LTipImp: String;
    LReport: TfrxReport;
Begin
  pCarregaConfImpr(qryCfgRel, Self.Name);
  LNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  LTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  LReport := frxReportM;

  If LTipImp <> 'M' Then
  Begin
    LReport := frxReportJ;
    TfrxMemoView(LReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  End;

  LReport.Script.Variables['NOMEMP'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
  LReport.Script.Variables['NOMREL'] := 'DUPLICATAS NÃO ENCONTRADAS - ' + FNomeDoBanco;
  pPreviewReport(Self.Name, 'Duplicatas não encontradas - ' + FNomeDoBanco, LReport);
End;

procedure TfrmRetBcoAPI.pMostraDupNaoBaixa(lstArqNaoGravados: TStringList;
  blnImpDes: Boolean);
  Var
    intContador2: Integer;
Begin

  If lstArqNaoGravados.Count > 0 Then
  Begin
    Try
      pCriarFormularios(TfrmArqNaoGravados,frmArqNaoGravados);
      If blnImpDes Then
      Begin
        frmArqNaoGravados.memResumo.Lines.Add('As Duplicatas abaixo foram encontradas no sistema, porém, estão com a chave de busca duplicada ou incorreta. Necessário realizar a baixa/atualização manual. ');
        frmArqNaoGravados.memResumo.Lines.Add('');
      End;

      For intContador2 := 0 To lstArqNaoGravados.Count-1 Do
      Begin
        frmArqNaoGravados.memResumo.Lines.Add(lstArqNaoGravados[intContador2]);
      End;
      frmArqNaoGravados.ShowModal;

    Finally
      FreeAndNil(frmArqNaoGravados);
      lstArqNaoGravados.Clear;
    End;
  End;

End;

procedure TfrmRetBcoAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TfrmRetBcoAPI.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos THen
    Exit;

  Try
     Case StrToInt(CodigoDoBanco) Of
        1: TfrmGravando.fExecuta(ImportaDadosBancoDoBrasilApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
       33: TfrmGravando.fExecuta(ImportaDadosBancoSantanderApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
       77: TfrmGravando.fExecuta(ImportaDadosBancoInter, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
       97: TfrmGravando.fExecuta(ImportaDadosBancoCredisisApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
      237: TfrmGravando.fExecuta(ImportaDadosBancoBradescoApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
      341: TfrmGravando.fExecuta(ImportaDadosBancoItauApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
      748: TfrmGravando.fExecuta(ImportaDadosBancoSicrediApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
      756: TfrmGravando.fExecuta(ImportaDadosBancoSicoobApi, FProgresso, 'Importando boletos ' + NomeDoBanco + '...');
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRetBcoAPI.btnGravarClick]');
    End;
  End;
end;

function TfrmRetBcoAPI.DeveGravarRetGer(AGravouRetGer: Boolean; ANomeArquivo,
  ANomeArquivoBoleto: String): Boolean;
begin
  Result := False;

  If Not AGravouRetGer Then
    Exit(True);

  If Not ANomeArquivo.Equals(ANomeArquivoBoleto) Then
    Exit(True);
end;

procedure TfrmRetBcoAPI.ExibeMensagensImportacao(
  AImportouAlgumRegistro: Boolean);
begin
  If Not cdsNaoGra.IsEmpty Then
    MostraArquivoNaoBaixados;

  If Not AImportouAlgumRegistro Then
  Begin
    fMensagem('ALERTA','Não foi encontrada nenhuma duplicata referente ao período selecionado!',['&OK']);
    Exit;
  End;

  fMensagem('AVISO','Arquivo de retorno importado com sucesso!',['&OK']);

  If Assigned(FDuplicatasBaixadas) Then
  Begin
    If (FDuplicatasBaixadas.Count > 0) Then
      If (Trim(FDuplicatasBaixadas.CommaText) <> '') then
        fMensagem('ATENÇÃO!', 'Existe(m) duplicata(s) nessa importação que já está(ão) baixada(s), por isso não foi(ram) processada(s). Ela(s) está(ão) impressa(s) na página do relatório de retorno, C - Relatório de Boletos Pagos!', ['&OK']);
  End;
end;

procedure TfrmRetBcoAPI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FechaCdsNaoBaixa;

  FreeAndNil(FObjetoImportacao);

  If Assigned(FDuplicatasBaixadas) Then
    FreeAndNil(FDuplicatasBaixadas);

  If Assigned(FDuplicatasNaoGravadas) Then
    FreeAndNil(FDuplicatasNaoGravadas);
end;

procedure TfrmRetBcoAPI.FormCreate(Sender: TObject);
begin
  inherited;
  AbreCdsNaoBaixa;
end;

procedure TfrmRetBcoAPI.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicial.Date := IncDay(VS_Date, -5);
  edtDataFinal.Date := VS_Date;

  If FConfig.Contains('CONFIG756API') Then
  Begin
    edtDataInicial.Date := IncDay(VS_Date, -3);
    edtDataFinal.Date := IncDay(VS_Date, -1);
  End;

  FConfig := Concat(FConfig, FCarteira.ToString, '-', VS_strCodEmp);

  lblDadosDaConta.Caption := RetornaDadosDaCarteira;

  pSetFocus(edtDataInicial);
end;

function TfrmRetBcoAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtDataInicial Then
    Begin
      If fEmptyStr(edtDataInicial.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Data Inicial deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If StrToDate(edtDataInicial.Text) > VS_Date Then
      Begin
        fMensagem('ATENÇÃO','O campo Data Inicial deve ser menor ou igual a data atual!', ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtDataFinal Then
    Begin
      If fEmptyStr(edtDataInicial.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Data Final deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If StrToDate(edtDataFinal.Text) > VS_Date Then
      Begin
        fMensagem('ATENÇÃO','O campo Data Final deve ser menor ou igual a data atual!', ['&OK']);
        Result := False;
      End
      Else If Not fEmptyStr(edtDataInicial.Text) Then
      Begin
        If (StrToDate(edtDataInicial.Text) >  StrToDate(edtDataFinal.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo Data Final deve ser maior ou igual ao campo Data Inicial!', ['&OK']);
          Result := False;
        End
        Else If DaysBetween(StrToDate(edtDataInicial.Text), StrToDate(edtDataFinal.Text)) > 10 Then
        Begin
          fMensagem('ATENÇÃO','O o período entre as datas não pode ser superior a 10 dias!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRetBcoAPI.GetConfiguracao: String;
begin
  Result := LeftStr(FConfig,11);

 If MatchStr(FCodigoDoBanco, ['001', '097', '748', '341', '756', '033', '237']) Then
    Result := LeftStr(FConfig,14);
end;

procedure TfrmRetBcoAPI.GravaOcorrenciaFinanceiroNoCRM(
  ADuplicata: TDuplicataCtr);
begin
  If Not fCfgSis('UTICRM', varBoolean) Then
    Exit;

  If (fEmptyStr(fCfgSis('OCOFIN', varString))) Then
    Exit;

  TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(ADuplicata.strNumDup,
                                           ADuplicata.strEspDoc,
                                           ADuplicata.strCodEmp,
                                           ADuplicata.strCodCli,
                                           ADuplicata.strParcel,
                                           strLoginUsuarioLogado,
                                           fRetCgcCpf(ADuplicata.strCodCli),
                                           afcImportaRetornoBancario);
end;

function TfrmRetBcoAPI.ImportaDadosBancoDoBrasilApi(cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoDoBrasilApi>;

    LBoleto: TRetornoPesquisaBancoDoBrasilApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LMotivoPagamento: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  Result := ValidaPeriodoImportadoPorModalidadeDeCobranca;
  If Not Result Then
    Exit;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  While (LContadorTentativas <= 4) Do
  Begin

    Try
      LResultado := TBancoDoBrasilAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(FormatDateTime('DD.MM.YYYY', StrToDate(edtDataInicial.Text)),
                                                                                   FormatDateTime('DD.MM.YYYY', StrToDate(edtDataFinal.Text)),
                                                                                   FProgresso);

      cxgProgresso.Visible := True;
      cxgProgresso.Properties.Max := LResultado.Count;
      FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
      cxgProgresso.Position := 0;

      For LBoleto In LResultado Do
      Begin
        pStepStatusGravacao(cxgProgresso);

        If TBancoDoBrasilAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
        Begin
          untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

          If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.nossoNumero,
                                                        FCodigoDoBanco,
                                                        LDuplicata.strCodEmp,
                                                        FCarteira.ToString,
                                                        LQuantidadeDuplicatas,
                                                        LDuplicata.strAutoIn) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.nossoNumero);
          End
          Else If LQuantidadeDuplicatas > 1 Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.nossoNumero);
          End
          Else
          Begin
            LRecebidoPorPix := 'N';
            LMotivoPagamento := EmptyStr;
            If RightStr(LBoleto.FDetalhamento.CanalPagamento, 2) = '61' Then
            Begin
              LRecebidoPorPix := 'S';
              LMotivoPagamento := '01';
            End;

            untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                              FDuplicatasBaixadas,
                                              frmModuloRetBco.qryRetBco,
                                              FCarteira,
                                              LDuplicata.strParcel,
                                              LDuplicata.strNumDup,
                                              LDuplicata.strCodCli,
                                              LDuplicata.strCodEmp,
                                              LDuplicata.strEspDoc,
                                              IIF(Not FEmptyStr(LBoleto.ABoletoDataMovimento),LBoleto.ABoletoDataMovimento, LBoleto.ABoletoDataRegistro),
                                              LBoleto.ABoletoDataVencimento,
                                              LBoleto.ABoletoDataMovimento,
                                              LBoleto.NomeDoArquivo,
                                              LBoleto.valorDesconto,
                                              LBoleto.BoletoValorOriginal,
                                              LBoleto.ABoletoValorPago,
                                              LBoleto.valorJuros,
                                              '',
                                              FCodigoDoBanco,
                                              fStrZero(LBoleto.BoletoCodigoEstadoTituloCobranca, 2){'06'},
                                              LBoleto.nossoNumero,
                                              '',
                                              LMotivoPagamento,
                                              VS_Date,
                                              False,
                                              '',
                                              '',
                                              LBoleto.ABoletoDataCredito,
                                              LBoleto.FDetalhamento.Tarifa,
                                              LBoleto.ABoletoValorPago,
                                              '',
                                              LBoleto.BoletoCarteiraConvenio ,
                                              LBoleto.FDetalhamento.ValorIOF,
                                              '',
                                              False,
                                              '',
                                              'API',
                                              LRecebidoPorPix,
                                              LBoleto.FDetalhamento.EndToEndID);


            untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                  'IMPORTAÇÃO DO BOLETO REGISTRADO PELA API - ' + FCodigoDoBanco,
                                  Self.Name);

            GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

            LExiste := True;
          End;
        End
        Else
          pIncluiOcor(LBoleto.nossoNumero,
                      '',
                      '',
                      '',
                      '',
                      StrToDateDef(LBoleto.ABoletoDataVencimento, 0),
                      StrToDateDef(LBoleto.ABoletoDataMovimento, 0),
                      fStrToFloat(LBoleto.BoletoValorOriginal)/100,
                      fStrToFloat(LBoleto.BoletoValorPago)/100,
                      cdsNaoGra);

        If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
        begin
          LNomeArquivo := LBoleto.NomeDoArquivo;
          pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, fcONFIG, LBoleto.NomeDoArquivo, 0, False, LAutoIncremRetGer);
          LGravouRetGer := True;
        end;

        {*****************************}
        {* GRAVAÇÃO DA TABELA RETDET *}
        {**** DETALHES DA RETORNO ****}
        {**************************MO*}
        pGravaRetDet(LAutoIncremRetGer,
                     LDuplicata.strAutoIn,
                     LBoleto.nossoNumero,
                     fStrToFloat(LBoleto.BoletoValorPago)/100,
                     fStrtoFloat(LBoleto.ValorJuros)/100,
                     fStrtoFloat(LBoleto.valorDesconto)/100,
                     fStrtoFloat('0')/100,
                     StrToDateDef(lBoleto.ABoletoDataMovimento, 0),
                     FCodigoBanco,
                     fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     fStrZero(LBoleto.BoletoCodigoEstadoTituloCobranca, 2),
                     False);

      End; //End For
      LErroAPI := False;

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 4 Then
        Begin
          If (Pos(C_ERRO_AUTENTICACAO_BB, E.Message) > 0) Then
          Begin
            pGravarErro(True, '[TfrmRetBcoAPI.ImportaDadosBancoDoBrasilApi] - Falha na autenticação na API do Banco do Brasil',
                        E.Message + sLineBreak + fRetornaStack);
            fMensagem('ATENÇÃO', 'Não foi possível realizar a autenticação na API do Banco do Brasil.' + #13 +
                                 'Verifique se as chaves de autenticação da carteira estão corretas e liberadas para uso.' + #13 +
                                 'O detalhe do erro foi gravado no log de erros do sistema.', ['&Ok']);
          End
          Else
            ExibeFormMensagemErro(E.Message);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoBradescoApi(
  cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoBradescoApi>;

    LBoleto: TRetornoPesquisaBancoBradescoApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LCodigoOcorrencia,
    LMotivoPagamento: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;
    LDataOcorrencia,
    LAutoIncremsBaixados: String;

    LValorTotalJuros,
    LValorDesconto: Double;

    LNossoNumero: String;
begin
  LContadorTentativas := 1;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  Result := True;

  While (LContadorTentativas <= 2) Do
  Begin
    LErroAPI := True;

    Try
      LResultado := TBancoBradescoAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(edtDataInicial.Date,
                                                                                   edtDataFinal.Date,
                                                                                   FProgresso);

      If LResultado.Count = 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi encontrado nenhum registro nesse período.', ['&Ok']);

        Exit;
      End;

      cxgProgresso.Visible := True;
      cxgProgresso.Properties.Max := LResultado.Count;
      FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
      cxgProgresso.Position := 0;

      LErroAPI := False;

      LAutoIncremsBaixados := EmptyStr;

      For LBoleto In LResultado Do
      Begin
        pStepStatusGravacao(cxgProgresso);

        LNossoNumero := fStrZero(LBoleto.nossoNumero + LBoleto.digitoNossoNumero, 12);

        If TBancoBradescoAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
        Begin
          untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

          LAutoIncremsBaixados := LAutoIncremsBaixados + '"' + LDuplicata.strAutoIn + '",';

          If untFuncAutBan.VerificaNossoNumeroDuplicado(LNossoNumero,
                                                        FCodigoDoBanco,
                                                        LDuplicata.strCodEmp,
                                                        FCarteira.ToString,
                                                        LQuantidadeDuplicatas,
                                                        LDuplicata.strAutoIn) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LNossoNumero);
          End
          Else If LQuantidadeDuplicatas > 1 Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LNossoNumero);
          End
          Else
          Begin
            LRecebidoPorPix := LBoleto.indicadorPagoQrCode;
            LMotivoPagamento := IIF(Not LBoleto.baixaCodigo.Equals('51'), EmptyStr, '01');
            LCodigoOcorrencia := fStrZero(LBoleto.codStatus, 2);

            If Not LBoleto.dataPagamento.IsEmpty Then
            Begin
              If Not LBoleto.baixaCodigo.Equals('51') Then
                LBoleto.dataMovimento := DateToStr(IncDay(StrToDate(LBoleto.dataMovimento),
                                                   StrToInt(TBancoBradescoAPI(FObjetoImportacao).DadosCarteira.QtdDiasCredito)));

              LBoleto.dataMovimento := DateToStr(fAcertaDataParaDiaUtil(StrToDate(LBoleto.dataMovimento)));
            End;

            If LRecebidoPorPix.Equals('S') Then
            Begin
              LCodigoOcorrencia := '61';
              LMotivoPagamento := '01';

              LBoleto.dataMovimento := DateToStr(fAcertaDataParaDiaUtil(StrToDate(LBoleto.dataPagamento)));
            End;
            
            LValorTotalJuros := 0;
            LValorDesconto := 0;
            If LBoleto.sinalValorOscilacao = '+' Then
              LValorTotalJuros := RetornaValorImportacaoDouble(LBoleto.valorOscilacao, EmptyStr, EmptyStr, '237')
            Else
              LValorDesconto := RetornaValorImportacaoDouble(LBoleto.valorOscilacao, EmptyStr, EmptyStr, '237');

            LBoleto.nomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', edtDataInicial.Date),
                                            ' - ',
                                            FormatDateTime('dd/mm/yyyy', edtDataFinal.Date));

            untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                              FDuplicatasBaixadas,
                                              frmModuloRetBco.qryRetBco,
                                              FCarteira,
                                              LDuplicata.strParcel,
                                              LDuplicata.strNumDup,
                                              LDuplicata.strCodCli,
                                              LDuplicata.strCodEmp,
                                              LDuplicata.strEspDoc,
                                              LBoleto.dataPagamento,
                                              LBoleto.dataVencimento,
                                              LBoleto.dataPagamento,
                                              LBoleto.NomeDoArquivo,
                                              LValorDesconto.ToString,
                                              LBoleto.valorTitulo,
                                              LBoleto.vlrPagto,
                                              LValorTotalJuros.ToString,
                                              '',
                                              FCodigoDoBanco,
                                              LCodigoOcorrencia,
                                              LNossoNumero,
                                              '',
                                              LMotivoPagamento,
                                              VS_Date,
                                              False,
                                              '',
                                              '',
                                              LBoleto.dataMovimento,
                                              '',
                                              LBoleto.valorTitulo,
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              'API',
                                              LRecebidoPorPix);


            untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                  'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                  Self.Name);

            GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

            LExiste := True;
          End;
        End
        Else
          pIncluiOcor(LNossoNumero,
                      '',
                      LeftStr(LBoleto.ctrlPartic, 15).Trim,
                      Copy(LBoleto.ctrlPartic, 16 ,2),
                      Copy(LBoleto.ctrlPartic, 18 ,3),
                      StrToDateDef(LBoleto.dataVencimento, 0),
                      StrToDateDef(LBoleto.dataPagamento, 0),
                      fStrToFloat(LBoleto.valorTitulo),
                      fStrToFloat(LBoleto.vlrPagto),
                      cdsNaoGra);

        If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
        begin
          LNomeArquivo := LBoleto.nomeDoArquivo;
          pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, FConfig, LBoleto.nomeDoArquivo, 0, False, LAutoIncremRetGer);
          LGravouRetGer := True;
        end;

        pGravaRetDet(LAutoIncremRetGer,
                     LDuplicata.strAutoIn,
                     LNossoNumero,
                     fStrToFloat(LBoleto.valorPagamento),
                     LValorTotalJuros,
                     fStrtoFloat(LBoleto.valAbat),
                     fStrtoFloat('0'),
                     StrToDateDef(LBoleto.dataPagamento, 0),
                     FCodigoBanco,
                     fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     LCodigoOcorrencia,
                     False);

      End; //End For
      LErroAPI := False;

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 2 Then
        Begin
          If E.Message.Contains('BCOAPI -') Then
          Begin
            pGravarErro(True, E.Message, fRetornaStack);
            fMensagem('ATENÇÃO', E.Message.Replace('BCOAPI - ', EmptyStr), ['&Ok']);
          End
          Else
            pMensagensErro(E.Message, '[TfrmRetBcoAPI.ImportaDadosBancoBradescoApi]');

          FObjetoImportacao := TBancoBradescoAPI.Create(FConfig);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoCredisisApi(cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoCredisisApi>;

    LBoleto: TRetornoPesquisaBancoCredisisApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer: String;
    LContadorTentativas : Integer;
    LErroAPI: Boolean;
    FXmlRetorno : TXMLDocument;
    strCarteiraBoleto : String;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;
  FXmlRetorno := TXMLDocument.Create(Self);

  While (LContadorTentativas <= 4) Do
  Begin

    Try
      LResultado := TBancoCredisisAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(FormatDateTime('YYYY-MM-DD', StrToDate(edtDataInicial.Text)),
                                                                                   FormatDateTime('YYYY-MM-DD', StrToDate(edtDataFinal.Text)),
                                                                                   FProgresso,
                                                                                   FXmlRetorno);
      If (LResultado <> nil) Then
      Begin

        cxgProgresso.Visible := True;
        cxgProgresso.Properties.Max := LResultado.Count;
        FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
        cxgProgresso.Position := 0;

        For LBoleto In LResultado Do
        Begin
          pStepStatusGravacao(cxgProgresso);

          If TBancoCredisisAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
          Begin

            strCarteiraBoleto := TBancoCredisisAPI(FObjetoImportacao).fRetornaCarteiraBoleto(LBoleto);

            untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

            If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.nossoNumero,
                                                          FCodigoDoBanco,
                                                          LDuplicata.strCodEmp,
                                                          FCarteira.ToString,
                                                          LQuantidadeDuplicatas,
                                                          LDuplicata.strAutoIn) Then
            Begin
              FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                         LDuplicata.strEspDoc + '-' +
                                                         LDuplicata.strCodEmp +
                                                         ' Cliente: ' + LDuplicata.strCodCli +
                                                         ' Nosso Número: ' + LBoleto.nossoNumero);
            End
            Else If LQuantidadeDuplicatas > 1 Then
            Begin
              FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                         LDuplicata.strEspDoc + '-' +
                                                         LDuplicata.strCodEmp +
                                                         ' Cliente: ' + LDuplicata.strCodCli +
                                                         ' Nosso Número: ' + LBoleto.nossoNumero);
            End
            Else
            Begin
              untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                                FDuplicatasBaixadas,
                                                frmModuloRetBco.qryRetBco,
                                                FCarteira,
                                                LDuplicata.strParcel, LDuplicata.strNumDup, LDuplicata.strCodCli,
                                                LDuplicata.strCodEmp, LDuplicata.strEspDoc,
                                                LBoleto.ABoletoDataMovimento, LBoleto.ABoletoDataVencimento, LBoleto.ABoletoDataMovimento,
                                                LBoleto.NomeDoArquivo, LBoleto.valorDesconto,
                                                LBoleto.BoletoValorOriginal, LBoleto.ABoletoValorPago, LBoleto.valorJuros, '',
                                                FCodigoDoBanco, fStrZero(LBoleto.BoletoCodigoEstadoTituloCobranca, 2){'06'}, LBoleto.nossoNumero, '', '', VS_Date,
                                                False, '', '', LBoleto.ABoletoDataCredito, LBoleto.FDetalhamento.ValorTarifa, LBoleto.ABoletoValorPago, '',
                                                strCarteiraBoleto , LBoleto.FDetalhamento.ValorIOF, '',
                                                False, '','API');


              untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                    'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                    Self.Name);

              GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

              LExiste := True;
            End;
          End
          Else
            pIncluiOcor(LBoleto.nossoNumero,
                        '',
                        '',
                        '',
                        '',
                        StrToDateDef(LBoleto.ABoletoDataVencimento, 0),
                        StrToDateDef(LBoleto.ABoletoDataMovimento, 0),
                        IIF (FCodigoDoBanco = '097', fStrToFloat(LBoleto.BoletoValorOriginal), fStrToFloat(LBoleto.BoletoValorOriginal)/100 ),
                        IIF (FCodigoDoBanco = '097', fStrToFloat(LBoleto.BoletoValorPago), fStrToFloat(LBoleto.BoletoValorPago)/100 ),
                        cdsNaoGra);

          If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
          begin
            LNomeArquivo := LBoleto.NomeDoArquivo;
            pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, fcONFIG, LBoleto.NomeDoArquivo, 0, False, LAutoIncremRetGer);
            LGravouRetGer := True;
          end;

          {*****************************}
          {* GRAVAÇÃO DA TABELA RETDET *}
          {**** DETALHES DA RETORNO ****}
          {**************************MO*}
          pGravaRetDet(LAutoIncremRetGer,
                       LDuplicata.strAutoIn,
                       LBoleto.nossoNumero,
                       IIF (FCodigoDoBanco = '097', fStrToFloat(LBoleto.BoletoValorPago), fStrToFloat(LBoleto.BoletoValorPago)/100 ),
                       IIF (FCodigoDoBanco = '097', fStrtoFloat(LBoleto.ValorJuros), fStrtoFloat(LBoleto.ValorJuros)/100 ),
                       IIF (FCodigoDoBanco = '097', fStrtoFloat(LBoleto.valorDesconto), fStrtoFloat(LBoleto.valorDesconto)/100 ),
                       IIF (FCodigoDoBanco = '097', fStrtoFloat('0'), fStrtoFloat('0')/100 ),
                       StrToDateDef(lBoleto.ABoletoDataMovimento, 0),
                       FCodigoBanco,
                       fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                       VS_Date,
                       strLoginUsuarioLogado,
                       '',
                       fStrZero(LBoleto.BoletoCodigoEstadoTituloCobranca, 2),
                       False);

        End; //End For

      End;

      LErroAPI := False;

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 4 Then
        Begin
          ExibeFormMensagemErro(E.Message);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.RetornaOcorrenciaBoleto(strSituacao : String; var scodOco :string; var scodmot : String; var RecebPix : String): String;
Begin

  scodmot  := '';
  RecebPix := 'N';
  scodmot  := '00';

  If strSituacao.Equals('EM CARTEIRA') Then
    scodOco  := '02'
  Else If strSituacao.Equals('EM CARTEIRA PIX') Then
  Begin
    scodOco  := '02';
    scodmot  := '01';
  End
  Else If strSituacao.Equals('REJEITADO') Then
    scodOco  := '03'
  Else If strSituacao.Equals('VENCIDO') Then
    scodOco  := '04'
  Else If strSituacao.Equals('LIQUIDADO') Then
    scodOco  := '06'
  Else If strSituacao.Equals('LIQUIDADO CARTORIO') Then
    scodOco  := '15'
  Else If strSituacao.Equals('LIQUIDADO PIX') Then
  Begin
    RecebPix := 'S';
    scodOco  := '06';
    scodmot  := '01';
  End
  Else If strSituacao.Equals('LIQUIDADO CHEQUE') Then
  Begin
    scodOco  := '06';
    scodmot  := '02';
  End
  Else If strSituacao.Equals('LIQUIDADO REDE') Then
  Begin
    scodOco  := '06';
    scodmot  := '03';
  End
  Else If strSituacao.Equals('LIQUIDADO COMPE') Then
  Begin
    scodOco  := '06';
    scodmot  := '04';
  End
  Else If strSituacao.Equals('BAIXADO POR SOLICITACAO') Then
  Begin
    scodOco  := '10';
    scodmot  := '01';
  End
  Else If strSituacao.Equals('PROTESTADO') Then
  Begin
    scodOco  := '10';
    scodmot  := '14';
  End
  Else If strSituacao.Equals('EM CARTORIO') Then
    scodOco  := '23'
  Else If strSituacao.Equals('AGUARDANDO ENTRADA EM CARTORIO') Then
  Begin
    scodOco  := '23';
    scodmot  := '01';
  End
  Else If strSituacao.Equals('AGUARDANDO SUSTACAO DE CARTORIO') Then
  Begin
    scodOco  := '23';
    scodmot  := '02';
  End
  Else If strSituacao.Equals('NEGATIVADO') Then
    scodOco  := '80'
  Else
    scodOco := '99'; //outras

End;

function TfrmRetBcoAPI.ImportaDadosBancoSantanderApi(
  cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoSantanderApi>;

    LBoleto: TRetornoPesquisaBancoSantanderApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LCodigoOcorrencia,
    LMotivoPagamento: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;
    LDataOcorrencia,
    LAutoIncremsBaixados: String;

    LValorTotalJuros: Double;
begin
  LContadorTentativas := 1;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  Result := True;

  While (LContadorTentativas <= 2) Do
  Begin
    LErroAPI := True;

    Try
      LResultado := TBancoSantanderAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(edtDataInicial.Date,
                                                                                    edtDataFinal.Date,
                                                                                    FProgresso,
                                                                                    False);

      If LResultado.Count = 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Não foi encontrado nenhum registro nesse período.', ['&Ok']);

        Exit;
      End;

      cxgProgresso.Visible := True;
      cxgProgresso.Properties.Max := LResultado.Count;
      FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
      cxgProgresso.Position := 0;

      LErroAPI := False;

      LAutoIncremsBaixados := EmptyStr;

      For LBoleto In LResultado Do
      Begin
        pStepStatusGravacao(cxgProgresso);

        If TBancoSantanderAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
        Begin
          untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

          LAutoIncremsBaixados := LAutoIncremsBaixados + '"' + LDuplicata.strAutoIn + '",';

          If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.bankNumber,
                                                        FCodigoDoBanco,
                                                        LDuplicata.strCodEmp,
                                                        FCarteira.ToString,
                                                        LQuantidadeDuplicatas,
                                                        LDuplicata.strAutoIn) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.bankNumber);
          End
          Else If LQuantidadeDuplicatas > 1 Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.bankNumber);
          End
          Else
          Begin
            LRecebidoPorPix := 'N';
            LMotivoPagamento := EmptyStr;
            LCodigoOcorrencia := LBoleto.Ocorrencia;
            If LBoleto.paymentType.Equals('PIX') Then
            Begin
              LRecebidoPorPix := 'S';
              LMotivoPagamento := '01';
            End;

            LValorTotalJuros := RetornaValorImportacaoDouble(LBoleto.interestValue, EmptyStr, EmptyStr, '033') +
                                RetornaValorImportacaoDouble(LBoleto.fine, EmptyStr, EmptyStr, '033');

            LBoleto.nomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', edtDataInicial.Date),
                                            ' - ',
                                            FormatDateTime('dd/mm/yyyy', edtDataFinal.Date));

            untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                              FDuplicatasBaixadas,
                                              frmModuloRetBco.qryRetBco,
                                              FCarteira,
                                              LDuplicata.strParcel,
                                              LDuplicata.strNumDup,
                                              LDuplicata.strCodCli,
                                              LDuplicata.strCodEmp,
                                              LDuplicata.strEspDoc,
                                              LBoleto.paymentDate,
                                              LBoleto.dueDate,
                                              LBoleto.paymentDate,
                                              LBoleto.NomeDoArquivo,
                                              LBoleto.deductionValue,
                                              LBoleto.nominalValue,
                                              LBoleto.payedValue,
                                              LValorTotalJuros.ToString.Replace('.', EmptyStr).Replace(',', '.'),
                                              '',
                                              FCodigoDoBanco,
                                              LCodigoOcorrencia,
                                              LBoleto.bankNumber,
                                              '',
                                              LMotivoPagamento,
                                              VS_Date,
                                              False,
                                              '',
                                              '',
                                              LBoleto.creditDate,
                                              '',
                                              LBoleto.nominalValue,
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              'API',
                                              LRecebidoPorPix);


            untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                  'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                  Self.Name);

            GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

            LExiste := True;
          End;
        End
        Else
          pIncluiOcor(LBoleto.bankNumber,
                      '',
                      LeftStr(LBoleto.participantCode, 15).Trim,
                      Copy(LBoleto.participantCode, 16 ,2),
                      Copy(LBoleto.participantCode, 18 ,3),
                      StrToDateDef(LBoleto.dueDate, 0),
                      StrToDateDef(LBoleto.paymentDate, 0),
                      fStrToFloat(LBoleto.nominalValue) / 100,
                      fStrToFloat(LBoleto.payedValue) / 100,
                      cdsNaoGra);

        If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
        begin
          LNomeArquivo := LBoleto.nomeDoArquivo;
          pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, FConfig, LBoleto.nomeDoArquivo, 0, False, LAutoIncremRetGer);
          LGravouRetGer := True;
        end;

        pGravaRetDet(LAutoIncremRetGer,
                     LDuplicata.strAutoIn,
                     LBoleto.bankNumber,
                     fStrToFloat(LBoleto.payedValue),
                     LValorTotalJuros,
                     fStrtoFloat(LBoleto.deductionValue),
                     fStrtoFloat('0'),
                     StrToDateDef(LBoleto.paymentDate, 0),
                     FCodigoBanco,
                     fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     LCodigoOcorrencia,
                     False);

      End; //End For
      LErroAPI := False;

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 2 Then
        Begin
          ExibeFormMensagemErro(E.Message);

          FObjetoImportacao := TBancoSantanderAPI.Create(FConfig);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoSicoobApi(
  cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoSicoobApi>;

    LBoleto: TRetornoPesquisaBancoSicoobApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LMotivoPagamento: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;
    LDataOcorrencia,
    LCodigoOcorrencia: String;

    LParcela: Integer;
begin
  If edtDataFinal.Date > VS_Date Then
  Begin
    fMensagem('ATENÇÃO', 'O período não pode conter datas posteriores à data atual.', ['&Ok']);

    Exit(False);
  End;

  LContadorTentativas := 1;


  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  Result := True;

  While (LContadorTentativas <= 2) Do
  Begin
    LErroAPI := True;
    Try
      LResultado := TBancoSicoobAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(edtDataInicial.Date,
                                                                                 edtDataFinal.Date,
                                                                                 FProgresso);

      cxgProgresso.Visible := True;
      cxgProgresso.Properties.Max := LResultado.Count;
      FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
      cxgProgresso.Position := 0;

      LErroAPI := False;

      For LBoleto In LResultado Do
      Begin
        pStepStatusGravacao(cxgProgresso);

        If TBancoSicoobAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
        Begin
          untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

          If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.numeroTitulo,
                                                        FCodigoDoBanco,
                                                        LDuplicata.strCodEmp,
                                                        FCarteira.ToString,
                                                        LQuantidadeDuplicatas,
                                                        LDuplicata.strAutoIn) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.numeroTitulo);
          End
          Else If LQuantidadeDuplicatas > 1 Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.numeroTitulo);
          End
          Else
          Begin
            LCodigoOcorrencia := TBancoSicoobAPI(FObjetoImportacao).RetornaCodigoOcorenciaSicoob(LBoleto);

            LRecebidoPorPix := 'N';
            LMotivoPagamento := EmptyStr;
            If LCodigoOcorrencia.Equals('06') Then
            Begin
              If LBoleto.idTipoOpFinanceira.Equals('212') Then
              Begin
                LRecebidoPorPix := 'S';
                LMotivoPagamento := '01';
              End;
            End;

            untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                              FDuplicatasBaixadas,
                                              frmModuloRetBco.qryRetBco,
                                              FCarteira,
                                              LDuplicata.strParcel,
                                              LDuplicata.strNumDup,
                                              LDuplicata.strCodCli,
                                              LDuplicata.strCodEmp,
                                              LDuplicata.strEspDoc,
                                              LBoleto.dataMovimentoLiquidacao,
                                              LBoleto.dataVencimentoTitulo,
                                              LBoleto.dataPrevisaoCredito,
                                              LBoleto.NomeDoArquivo,
                                              LBoleto.valorDesconto,
                                              LBoleto.valorTitulo,
                                              LBoleto.valorLiquido,
                                              LBoleto.valorMora,
                                              '',
                                              FCodigoDoBanco,
                                              LCodigoOcorrencia,
                                              LBoleto.numeroTitulo,
                                              '',
                                              LMotivoPagamento,
                                              VS_Date,
                                              False,
                                              '',
                                              '',
                                              LBoleto.dataPrevisaoCredito,
                                              '',
                                              LBoleto.valorTitulo,
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              'API',
                                              LRecebidoPorPix);


            untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                  'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                  Self.Name);

            GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

            LExiste := True;
          End;
        End
        Else
        Begin
          LDuplicata.strNumDup := LeftStr(LBoleto.seuNumero, 9);
          LDuplicata.strParcel := Copy(LBoleto.seuNumero, 10, 1);
          LDuplicata.strEspdoc := Copy(LBoleto.seuNumero, 11, 2);
          LDuplicata.strCodEmp := EmptyStr;

          If LBoleto.seuNumero.Length > 15 Then
          Begin
            LDuplicata.strNumDup := LeftStr(LBoleto.seuNumero, 12);
            LDuplicata.strParcel := Copy(LBoleto.seuNumero, 13, 3).Trim;
            LDuplicata.strEspDoc := Copy(LBoleto.seuNumero, 16, 3);
            LDuplicata.strCodEmp := EmptyStr;
          End;

          pIncluiOcor(LBoleto.numeroTitulo,
                      EmptyStr,
                      LDuplicata.strNumDup + LDuplicata.strParcel,
                      LDuplicata.strEspdoc,
                      LDuplicata.strCodEmp,
                      StrToDateDef(LBoleto.dataVencimentoTitulo, 0),
                      StrToDateDef(LBoleto.dataMovimentoLiquidacao, 0),
                      fStrToFloat(LBoleto.valorTitulo),
                      fStrToFloat(LBoleto.valorLiquido),
                      cdsNaoGra);
        End;

        If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
        begin
          LNomeArquivo := LBoleto.nomeDoArquivo;
          pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, FConfig, LBoleto.nomeDoArquivo, 0, False, LAutoIncremRetGer);
          LGravouRetGer := True;
        end;

        {*****************************}
        {* GRAVAÇÃO DA TABELA RETDET *}
        {**** DETALHES DA RETORNO ****}
        {**************************MO*}
        pGravaRetDet(LAutoIncremRetGer,
                     LDuplicata.strAutoIn,
                     LBoleto.numeroTitulo,
                     fStrToFloat(LBoleto.valorLiquido),
                     fStrtoFloat(LBoleto.valorMora),
                     fStrtoFloat(LBoleto.valorDesconto),
                     fStrtoFloat('0'),
                     StrToDateDef(LBoleto.dataMovimentoLiquidacao, 0),
                     FCodigoBanco,
                     fGetBancoConfig(0, FConfig, 'CODCOOP', ''),
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     LCodigoOcorrencia,
                     False);

      End; //End For
      LErroAPI := False;

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 2 Then
        Begin
          If E.Message.Contains('INFOAPI -') Then
            fMensagem('ATENÇÃO', E.Message.Replace('INFOAPI - ', EmptyStr), ['&Ok'])
          Else
            ExibeFormMensagemErro(E.Message);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoSicrediApi(cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoSicrediApi>;

    LBoleto: TRetornoPesquisaBancoSicrediApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LMotivoPagamento,

    LCarteira,
    LEmpresaImportacao: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;

    strCodOco : String;
    LLabelStatus: String;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  Result := ValidaPeriodoImportadoPorModalidadeDeCobranca;
  If Not Result Then
    Exit;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  While (LContadorTentativas <= 4) Do
  Begin

    Try
      LResultado := TBancoSicrediAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(edtDataInicial.Date,
                                                                                  edtDataFinal.Date,
                                                                                  FProgresso);

      cxgProgresso.Visible := True;
      cxgProgresso.Properties.Max := LResultado.Count;
      FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
      cxgProgresso.Position := 0;

      For LBoleto In LResultado Do
      Begin
        LLabelStatus := Format(
          'Aguarde... Processando Requisições... %.0n de %.0n', [
            cxgProgresso.Position + 1,
            cxgProgresso.Properties.Max]);

        pStepStatusGravacao(cxgProgresso,LLabelStatus);

        If TBancoSicrediAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
        Begin
          untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API', TBancoSicrediAPI(FObjetoImportacao).DadosCarteira.ImportarEmpresas.Equals('N'));

          If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.nossoNumero,
                                                        FCodigoDoBanco,
                                                        LDuplicata.strCodEmp,
                                                        FCarteira.ToString,
                                                        LQuantidadeDuplicatas,
                                                        LDuplicata.strAutoIn) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.nossoNumero);
          End
          Else If LQuantidadeDuplicatas > 1 Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.nossoNumero);
          End
          Else If TBancoSicrediAPI(FObjetoImportacao).DeveBloquearSeFoiGeradoPorArquivo(LDuplicata) Then
          Begin
            FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                       LDuplicata.strEspDoc + '-' +
                                                       LDuplicata.strCodEmp +
                                                       ' Cliente: ' + LDuplicata.strCodCli +
                                                       ' Nosso Número: ' + LBoleto.nossoNumero);

            FDuplicatasNaoGravadas.Add('--Duplicata foi gerada por uma carteira que comunica com o banco através de arquivo remessa/retorno. '+
                                       'Deve ser baixada pela carteira em que o boleto foi gerado.');
          End
          Else
          Begin
            LRecebidoPorPix := 'N';
            LMotivoPagamento := EmptyStr;

            {If LBoleto.BoletoTipoLiquidacao.Equals('PIX') Or LBoleto.BoletoTipoLiquidacao.Equals('LIQUIDADO PIX') Then
            Begin
              LRecebidoPorPix := 'S';
              LMotivoPagamento := '01';
            End;}

            strCodOco        := '';
            LMotivoPagamento := '';
            LRecebidoPorPix  := 'N';

            RetornaOcorrenciaBoleto(LBoleto.BoletoTipoLiquidacao, strCodOco, LMotivoPagamento, LRecebidoPorPix);

            TBancoSicrediAPI(FObjetoImportacao).CarregaCarteiraEmpresaImportacao(LCarteira,
                                                                                 LEmpresaImportacao,
                                                                                 LBoleto);

            untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                              FDuplicatasBaixadas,
                                              frmModuloRetBco.qryRetBco,
                                              StrToInt(LCarteira),
                                              LDuplicata.strParcel,
                                              LDuplicata.strNumDup,
                                              LDuplicata.strCodCli,
                                              LDuplicata.strCodEmp,
                                              LDuplicata.strEspDoc,
                                              LBoleto.ABoletoDataMovimento,
                                              LBoleto.ABoletoDataVencimento,
                                              LBoleto.ABoletoDataMovimento,
                                              LBoleto.NomeDoArquivo,
                                              LBoleto.valorDesconto,
                                              LBoleto.BoletoValorOriginal,
                                              LBoleto.ABoletoValorPago,
                                              LBoleto.valorJuros,
                                              LBoleto.ValorMulta,
                                              FCodigoDoBanco,
                                              strCodOco,
                                              LBoleto.nossoNumero,
                                              '',
                                              LMotivoPagamento,
                                              VS_Date,
                                              False,
                                              '',
                                              '',
                                              LBoleto.ABoletoDataCredito,
                                              '',
                                              LBoleto.ABoletoValorPago,
                                              '',
                                              LBoleto.BoletoCarteiraConvenio ,
                                              '',
                                              '',
                                              False,
                                              '',
                                              'API',
                                              LRecebidoPorPix,
                                              '',
                                              LEmpresaImportacao);


            untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                  'IMPORTAÇÃO DO BOLETO REGISTRADO PELA API - ' + FCodigoDoBanco,
                                  Self.Name);

            GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

            LExiste := True;
          End;
        End
        Else
          pIncluiOcor(LBoleto.nossoNumero,
                      '',
                      LBoleto.BoletoSeuNumero,
                      '',
                      '',
                      StrToDateDef(LBoleto.ABoletoDataVencimento, 0),
                      StrToDateDef(LBoleto.ABoletoDataMovimento, 0),
                      RetornaValorImportacaoDouble(LBoleto.BoletoValorOriginal,'','','748'),
                      RetornaValorImportacaoDouble(LBoleto.BoletoValorPago,'','','748'),

                      cdsNaoGra);

       If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
        begin
          LNomeArquivo := LBoleto.NomeDoArquivo;
          pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, fcONFIG, LBoleto.NomeDoArquivo, 0, False, LAutoIncremRetGer);
          LGravouRetGer := True;
        end;

        {*****************************}
        {* GRAVAÇÃO DA TABELA RETDET *}
        {**** DETALHES DA RETORNO ****}
        {**************************MO*}
        pGravaRetDet(LAutoIncremRetGer,
                     LDuplicata.strAutoIn,
                     LBoleto.nossoNumero,
                     RetornaValorImportacaoDouble(LBoleto.BoletoValorPago,'','','748'),
                     RetornaValorImportacaoDouble(LBoleto.ValorJuros,'','','748'),
                     RetornaValorImportacaoDouble(LBoleto.valorDesconto,'','','748'),
                     fStrtoFloat('0'),
                     StrToDateDef(lBoleto.ABoletoDataMovimento, 0),
                     FCodigoBanco,
                     fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     //fStrZero(LBoleto.BoletoCodigoEstadoTituloCobranca, 2),
                     fStrZero(strCodOco, 2),
                     False);

      End; //End For
      LErroAPI := False;

      pMostraDupNaoBaixa(FDuplicatasNaoGravadas, True);

      ExibeMensagensImportacao(LExiste);

      FreeAndNil(LChaveDuplicatas);

      Self.Close;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        If LContadorTentativas >= 4 Then
        Begin
          ExibeFormMensagemErro(E.Message);
        End;

      End;
    End;

    If Not LErroAPI Then
      Break;

    Inc(LContadorTentativas);
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoInter(cxgProgresso: TcxProgressBar = nil): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoInter>;

    LBoleto: TRetornoPesquisaBancoInter;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer: String;
begin
  Try
    LNomeArquivo := edtDataInicial.Text + ' - ' + edtDataFinal.Text;

    Result := ValidaPeriodoImportadoRetGer(LNomeArquivo, FConfig);
    If Not Result Then
      Exit;

    Result := True;

    LExiste := False;
    FDuplicatasNaoGravadas := TStringList.Create;
    LChaveDuplicatas := TStringList.Create;
    LGravouRetGer := False;

    If (LeftStr(fGetBancoConfig(0, GetConfiguracao, 'VERSAO_API', ''),1) = '2') Then
      LResultado := TBancoInter(FObjetoImportacao).ConsultaBoletosPorPeriodoApiV2(FormatDateTime('yyyy-mm-dd', StrToDate(edtDataInicial.Text)),
                                                                                  FormatDateTime('yyyy-mm-dd', StrToDate(edtDataFinal.Text)),
                                                                                  FProgresso)
    Else
    If (LeftStr(fGetBancoConfig(0, GetConfiguracao, 'VERSAO_API', ''),1) = '1') Then
      LResultado := TBancoInter(FObjetoImportacao).ConsultaBoletosPorPeriodoApiV1(FormatDateTime('yyyy-mm-dd', StrToDate(edtDataInicial.Text)),
                                                                                  FormatDateTime('yyyy-mm-dd', StrToDate(edtDataFinal.Text)),
                                                                                  FProgresso)
    Else
    If (LeftStr(fGetBancoConfig(0, GetConfiguracao, 'VERSAO_API', ''),1) = '3') Then
      LResultado := TBancoInter(FObjetoImportacao).ConsultaBoletosPorPeriodoApiV3(FormatDateTime('yyyy-mm-dd', StrToDate(edtDataInicial.Text)),
                                                                                  FormatDateTime('yyyy-mm-dd', StrToDate(edtDataFinal.Text)),
                                                                                  FProgresso);

    cxgProgresso.Visible := True;
    cxgProgresso.Properties.Max := LResultado.Count;
    cxgProgresso.Position := 0;

    For LBoleto In LResultado Do
    Begin
      pStepStatusGravacao(cxgProgresso);

      If TBancoInter(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
      Begin
        untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste);

        If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.nossoNumero,
                                                      FCodigoDoBanco,
                                                      LDuplicata.strCodEmp,
                                                      FCarteira.ToString,
                                                      LQuantidadeDuplicatas,
                                                      LDuplicata.strAutoIn) Then
        Begin
          FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                     LDuplicata.strEspDoc + '-' +
                                                     LDuplicata.strCodEmp +
                                                     ' Cliente: ' + LDuplicata.strCodCli +
                                                     ' Nosso Número: ' + LBoleto.nossoNumero);
        End
        Else If LQuantidadeDuplicatas > 1 Then
        Begin
          FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                     LDuplicata.strEspDoc + '-' +
                                                     LDuplicata.strCodEmp +
                                                     ' Cliente: ' + LDuplicata.strCodCli +
                                                     ' Nosso Número: ' + LBoleto.nossoNumero);
        End
        Else
        Begin
          untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                            FDuplicatasBaixadas,
                                            frmModuloRetBco.qryRetBco,
                                            FCarteira,
                                            LDuplicata.strParcel, LDuplicata.strNumDup, LDuplicata.strCodCli,
                                            LDuplicata.strCodEmp, LDuplicata.strEspDoc,
                                            LBoleto.dataPagamento, LBoleto.dataVencimento, LBoleto.dataPagamento,
                                            LNomeArquivo, LBoleto.valorDesconto,
                                            LBoleto.valorDuplicata, LBoleto.valorPago, LBoleto.valorJuros, '',
                                            FCodigoDoBanco, '06', LBoleto.nossoNumero, '', '', VS_Date,
                                            False, '', '', '', '', LBoleto.valorPago, '',  '', '', '',
                                            False, '');

          untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                Self.Name);

          GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

          LExiste := True;
        End;
      End
      Else
        pIncluiOcor(LBoleto.nossoNumero,
                    '',
                    LBoleto.seuNumero,
                    '',
                    '',
                    StrToDateDef(LBoleto.dataVencimento, 0),
                    StrToDateDef(LBoleto.dataPagamento, 0),
                    fStrToFloat(LBoleto.valorDuplicata)/100,
                    fStrToFloat(LBoleto.valorPago)/100,
                    cdsNaoGra);

      if Not LGravouRetGer then
      begin
        pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, fcONFIG, LNomeArquivo, 0, False, LAutoIncremRetGer);
        LGravouRetGer := True;
      end;

      {*****************************}
      {* GRAVAÇÃO DA TABELA RETDET *}
      {**** DETALHES DA RETORNO ****}
      {**************************MO*}
      pGravaRetDet(LAutoIncremRetGer,
                   LDuplicata.strAutoIn,
                   LBoleto.nossoNumero,
                   fStrToFloat(LBoleto.valorPago)/100,
                   fStrtoFloat(LBoleto.valorMora)/100,
                   fStrtoFloat(LBoleto.valorDesconto)/100,
                   fStrtoFloat('0')/100,
                   StrToDateDef(lBoleto.dataPagamento, 0),
                   FCodigoBanco,
                   fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                   VS_Date,
                   strLoginUsuarioLogado,
                   '',
                   '06',
                   False);

    End; //End For

    ExibeMensagensImportacao(LExiste);

    FreeAndNil(LChaveDuplicatas);

    Self.Close;
  Except
    On E: Exception Do
    Begin
      ExibeFormMensagemErro(E.Message);
    End;
  End;
end;

function TfrmRetBcoAPI.ImportaDadosBancoItauApi(
  cxgProgresso: TcxProgressBar): Boolean;
  Var
    LResultado: TList<TRetornoPesquisaBancoItauApi>;

    LBoleto: TRetornoPesquisaBancoItauApi;

    LDuplicata: TDuplicataCtr;

    LQuantidadeDuplicatas: Integer;

    LChaveDuplicatas: TStringList;

    LExiste,
    LGravouRetGer: Boolean;

    LNomeArquivo,
    LAutoIncremRetGer,
    LRecebidoPorPix,
    LMotivoPagamento: String;

    LContadorTentativas : Integer;
    LErroAPI: Boolean;
    LDataOcorrencia: String;

    LTarifas: TDictionary<String, Integer>;
    LErroFrancesa: String;

    LDescontos: TList<TMovimentoDescontoItau>;
    LMovimentoDesconto: TMovimentoDescontoItau;
    LDescontada: Boolean;
    LValorLancado,
    LJurosMora,
    LTarifa,
    LValorPago: String;

begin
  LContadorTentativas := 1;
  LTarifas := Nil;
  LDescontos := Nil;
  LResultado := Nil;
  LErroFrancesa := EmptyStr;

  LExiste := False;
  FDuplicatasNaoGravadas := TStringList.Create;
  LChaveDuplicatas := TStringList.Create;
  LGravouRetGer := False;

  Result := True;

  Try
    While (LContadorTentativas <= 2) Do
    Begin
      LErroAPI := True;
      Try
        LiberaResultadoItau(LResultado);

        LResultado := TBancoItauAPI(FObjetoImportacao).ConsultaBoletosPorPeriodo(edtDataInicial.Date,
                                                                                 edtDataFinal.Date,
                                                                                 FProgresso);

        If (Not Assigned(LDescontos)) And
           (fCfgSis('ENCBAN', varBoolean) Or (Not fGetBancoConfig(0, FConfig, 'PORTDES', '').Trim.IsEmpty)) Then
        Begin
          If fCfgSis('ENCBAN', varBoolean) Then
            LTarifas := TDictionary<String, Integer>.Create;

          LDescontos := TList<TMovimentoDescontoItau>.Create;

          TBancoItauAPI(FObjetoImportacao).ConsultaMovimentacoesFrancesa(edtDataInicial.Date,
                                                                         edtDataFinal.Date,
                                                                         LTarifas,
                                                                         LDescontos,
                                                                         LErroFrancesa,
                                                                         FProgresso);
        End;

        If Assigned(LDescontos) Then
          GravaMovimentosDescontoItau(LDescontos, LChaveDuplicatas, LExiste);

        cxgProgresso.Visible := True;
        cxgProgresso.Properties.Max := LResultado.Count;
        FProgresso.lblGravando.Caption := 'Aguarde... Processando Requisições. ';
        cxgProgresso.Position := 0;

        LErroAPI := False;

        For LBoleto In LResultado Do
        Begin
          pStepStatusGravacao(cxgProgresso);

          If TBancoItauAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
          Begin
            untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not LExiste,'API');

            If untFuncAutBan.VerificaNossoNumeroDuplicado(LBoleto.nossoNumero,
                                                          FCodigoDoBanco,
                                                          LDuplicata.strCodEmp,
                                                          FCarteira.ToString,
                                                          LQuantidadeDuplicatas,
                                                          LDuplicata.strAutoIn) Then
            Begin
              FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                         LDuplicata.strEspDoc + '-' +
                                                         LDuplicata.strCodEmp +
                                                         ' Cliente: ' + LDuplicata.strCodCli +
                                                         ' Nosso Número: ' + LBoleto.nossoNumero);
            End
            Else If LQuantidadeDuplicatas > 1 Then
            Begin
              FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                         LDuplicata.strEspDoc + '-' +
                                                         LDuplicata.strCodEmp +
                                                         ' Cliente: ' + LDuplicata.strCodCli +
                                                         ' Nosso Número: ' + LBoleto.nossoNumero);
            End
            Else
            Begin
              LRecebidoPorPix := 'N';
              LMotivoPagamento := EmptyStr;
              If LBoleto.PagoPorPix Then
              Begin
                LRecebidoPorPix := 'S';
                LMotivoPagamento := '01';
              End;

              LDataOcorrencia := IIF(LBoleto.SituacaoBoletoCodigo.Equals('32'),
                                                LBoleto.DataBaixaAlteracao,
                                                     LBoleto.DataPagamento);

              If fEmptyStr(LDataOcorrencia) Then
                LDataOcorrencia := LBoleto.DataEmissao;

              LJurosMora := LBoleto.ValorJuros;

              LTarifa := EmptyStr;
              If LBoleto.SituacaoBoletoCodigo.Equals('06') Then
                LTarifa := TBancoItauAPI(FObjetoImportacao).RetornaTarifaFrancesa(LTarifas, LBoleto);

              LValorPago := LBoleto.ValorPago;

              If StrToIntDef(LTarifa, 0) > 0 Then
                LValorPago := IntToStr(Round(RetornaValorImportacaoDouble(LBoleto.ValorPago) * 100) - StrToInt(LTarifa));

              LValorLancado := LValorPago;
              LDescontada := False;

              If fCfgSis('ENCBAN', varBoolean) And
                 TBancoItauAPI(FObjetoImportacao).RetornaMovimentoDesconto(LDescontos,
                                                                           LBoleto.NossoNumero,
                                                                           'LZ',
                                                                           LMovimentoDesconto) Then
              Begin
                LDescontada := True;
                LValorLancado := LMovimentoDesconto.ValorLiquido.ToString;

                If LMovimentoDesconto.ValorLiquido > 0 Then
                Begin
                  LJurosMora := LValorLancado;
                  LValorLancado := EmptyStr;
                End;
              End;

              untFuncAutBan.GravaRegistroRetBco(LChaveDuplicatas,
                                                FDuplicatasBaixadas,
                                                frmModuloRetBco.qryRetBco,
                                                FCarteira,
                                                LDuplicata.strParcel,
                                                LDuplicata.strNumDup,
                                                LDuplicata.strCodCli,
                                                LDuplicata.strCodEmp,
                                                LDuplicata.strEspDoc,
                                                LDataOcorrencia,
                                                LBoleto.DataVencimento,
                                                LBoleto.DataPagamento,
                                                LBoleto.NomeDoArquivo,
                                                LBoleto.ValorDesconto,
                                                LBoleto.ValorTitulo,
                                                LValorPago,
                                                LJurosMora,
                                                '',
                                                FCodigoDoBanco,
                                                LBoleto.SituacaoBoletoCodigo,
                                                LBoleto.NossoNumero,
                                                '',
                                                LMotivoPagamento,
                                                VS_Date,
                                                False,
                                                '',
                                                '',
                                                LBoleto.DataCredito,
                                                LTarifa,
                                                LValorLancado,
                                                '',
                                                '',
                                                '',
                                                '',
                                                LDescontada,
                                                '',
                                                'API',
                                                LRecebidoPorPix,
                                                LBoleto.EndToEndID);


              untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                                    'IMPORTAÇÃO DO BOLETO PAGO PELA API - ' + FCodigoDoBanco,
                                    Self.Name);

              GravaOcorrenciaFinanceiroNoCRM(LDuplicata);

              LExiste := True;
            End;
          End
          Else
            pIncluiOcor(LBoleto.nossoNumero,
                        '',
                        '',
                        '',
                        '',
                        StrToDateDef(LBoleto.DataVencimento, 0),
                        StrToDateDef(LBoleto.DataPagamento, 0),
                        fStrToFloat(LBoleto.ValorTitulo)/100,
                        fStrToFloat(LBoleto.ValorPago)/100,
                        cdsNaoGra);

          If DeveGravarRetGer(LGravouRetGer, LNomeArquivo, LBoleto.nomeDoArquivo) then
          begin
            LNomeArquivo := LBoleto.NomeDoArquivo;
            pGravaRetGer(VS_strCodEmp, FCodigoDoBanco, fcONFIG, LBoleto.NomeDoArquivo, 0, False, LAutoIncremRetGer);
            LGravouRetGer := True;
          end;

          {*****************************}
          {* GRAVAÇÃO DA TABELA RETDET *}
          {**** DETALHES DA RETORNO ****}
          {**************************MO*}
          pGravaRetDet(LAutoIncremRetGer,
                       LDuplicata.strAutoIn,
                       LBoleto.nossoNumero,
                       fStrToFloat(LBoleto.ValorPago)/100,
                       fStrtoFloat(LBoleto.ValorJuros)/100,
                       fStrtoFloat(LBoleto.ValorDesconto)/100,
                       fStrtoFloat('0')/100,
                       StrToDateDef(LBoleto.DataPagamento, 0),
                       FCodigoBanco,
                       fGetBancoConfig(0, FConfig, 'CODAGEN', ''),
                       VS_Date,
                       strLoginUsuarioLogado,
                       '',
                       fStrZero(LBoleto.SituacaoBoletoCodigo, 2),
                       False);

        End; //End For
        LErroAPI := False;

        pMostraDupNaoBaixa(FDuplicatasNaoGravadas, True);

        ExibeMensagensImportacao(LExiste);

        FreeAndNil(LChaveDuplicatas);

        Self.Close;
      Except
        On E: Exception Do
        Begin
          TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

          If LContadorTentativas >= 2 Then
             ExibeFormMensagemErro(E.Message);

        End;
      End;

      If Not LErroAPI Then
        Break;

      Inc(LContadorTentativas);
    End;

    If (Not LErroAPI) And (Not LErroFrancesa.IsEmpty) Then
      fMensagem('ATENÇÃO', 'Os boletos foram importados, mas a francesinha do Itaú não foi consultada por completo. ' +
                           'Duplicatas deste retorno podem ficar sem a tarifa bancária e sem as entradas, ' +
                           'liquidações e estornos de duplicatas descontadas. Importe o período novamente.' + #13#13 + LErroFrancesa, ['&OK']);
  Finally
    LiberaResultadoItau(LResultado);

    If Assigned(LChaveDuplicatas) Then
      FreeAndNil(LChaveDuplicatas);

    If Assigned(LTarifas) Then
      FreeAndNil(LTarifas);

    If Assigned(LDescontos) Then
      FreeAndNil(LDescontos);
  End;
end;

procedure TfrmRetBcoAPI.GravaMovimentosDescontoItau(ADescontos: TList<TMovimentoDescontoItau>;
                                                    var AChaveDuplicatas: TStringList;
                                                    var AExiste: Boolean);
  Var
    LMovimento: TMovimentoDescontoItau;

    LBoleto: TRetornoPesquisaBancoItauAPI;

    LDuplicata: TDuplicataCtr;

    LOcorrencia,
    LNomeArquivo,
    LTarifa,
    LValorLancado,
    LIOF,
    LTaxa,
    LJurosOperacao: String;

    LDataMovimento: TDateTime;

    LQuantidadeDuplicatas: Integer;
begin
  LNomeArquivo := Concat(FormatDateTime('dd/mm/yyyy', edtDataInicial.Date), ' - ',
                         FormatDateTime('dd/mm/yyyy', edtDataFinal.Date));

  For LMovimento In ADescontos Do
  Begin
    LDataMovimento := StrToDateDef(LMovimento.DataMovimentacao, 0);
    If (LDataMovimento < DateOf(edtDataInicial.Date)) Or (LDataMovimento > DateOf(edtDataFinal.Date)) Then
      Continue;

    LTarifa := EmptyStr;
    LValorLancado := EmptyStr;
    LIOF := EmptyStr;
    LTaxa := EmptyStr;
    LJurosOperacao := EmptyStr;

    If LMovimento.Status.Equals('EZ') And fCfgSis('ENCBAN', varBoolean) Then
    Begin
      LOcorrencia := '02';
      LTarifa := LMovimento.TarifaBoleto.ToString;
      LValorLancado := LMovimento.ValorLiquido.ToString;
      LIOF := LMovimento.IOF.ToString;
      LTaxa := LMovimento.Contratacao.ToString;
      LJurosOperacao := LMovimento.Juros.ToString;
    End
    Else If LMovimento.Status.Equals('BY') Then
    Begin
      LOcorrencia := '48';

      If Abs(LMovimento.ValorLiquido) > LMovimento.ValorTitulo Then
        LTaxa := (Abs(LMovimento.ValorLiquido) - LMovimento.ValorTitulo).ToString;
    End
    Else
      Continue;

    LBoleto := TRetornoPesquisaBancoItauAPI.Create;
    Try
      LBoleto.NossoNumero := LMovimento.NossoNumero;

      If Not TBancoItauAPI(FObjetoImportacao).VerificaSeADuplicataExisteCadrec(LBoleto, LDuplicata) Then
      Begin
        pIncluiOcor(LMovimento.NossoNumero,
                    EmptyStr,
                    LMovimento.SeuNumero,
                    EmptyStr,
                    EmptyStr,
                    StrToDateDef(LMovimento.DataVencimento, 0),
                    0,
                    LMovimento.ValorTitulo / 100,
                    0,
                    cdsNaoGra);

        Continue;
      End;

      If untFuncAutBan.VerificaNossoNumeroDuplicado(LMovimento.NossoNumero,
                                                    FCodigoDoBanco,
                                                    LDuplicata.strCodEmp,
                                                    FCarteira.ToString,
                                                    LQuantidadeDuplicatas,
                                                    LDuplicata.strAutoIn) Or
         (LQuantidadeDuplicatas > 1) Then
      Begin
        FDuplicatasNaoGravadas.Add('Duplicata: ' + LDuplicata.strNumDup + '-' +
                                                   LDuplicata.strEspDoc + '-' +
                                                   LDuplicata.strCodEmp +
                                                   ' Cliente: ' + LDuplicata.strCodCli +
                                                   ' Nosso Número: ' + LMovimento.NossoNumero);
        Continue;
      End;

      untFuncAutBan.ApagaRegistrosAnterioresRetBco(FCodigoDoBanco, Not AExiste, 'API');

      untFuncAutBan.GravaRegistroRetBco(AChaveDuplicatas,
                                        FDuplicatasBaixadas,
                                        frmModuloRetBco.qryRetBco,
                                        FCarteira,
                                        LDuplicata.strParcel,
                                        LDuplicata.strNumDup,
                                        LDuplicata.strCodCli,
                                        LDuplicata.strCodEmp,
                                        LDuplicata.strEspDoc,
                                        LMovimento.DataMovimentacao,
                                        LMovimento.DataVencimento,
                                        '',
                                        LNomeArquivo,
                                        '',
                                        LMovimento.ValorTitulo.ToString,
                                        '',
                                        '',
                                        '',
                                        FCodigoDoBanco,
                                        LOcorrencia,
                                        LMovimento.NossoNumero,
                                        '',
                                        '',
                                        VS_Date,
                                        False,
                                        '',
                                        '',
                                        '',
                                        LTarifa,
                                        LValorLancado,
                                        '',
                                        '',
                                        LIOF,
                                        LTaxa,
                                        True,
                                        LJurosOperacao,
                                        'API');

      untLogCtr.GravaLogCtr(LDuplicata.strAutoIn,
                            'IMPORTAÇÃO DA DUPLICATA DESCONTADA PELA API (OCORRÊNCIA ' + LOcorrencia + ') - ' + FCodigoDoBanco,
                            Self.Name);

      AExiste := True;
    Finally
      FreeAndNil(LBoleto);
    End;
  End;
end;

procedure TfrmRetBcoAPI.LiberaResultadoItau(var AResultado: TList<TRetornoPesquisaBancoItauApi>);
  Var
    LItem: TRetornoPesquisaBancoItauApi;
begin
  If Not Assigned(AResultado) Then
    Exit;

  For LItem In AResultado Do
    LItem.Free;

  FreeAndNil(AResultado);
end;

function TfrmRetBcoAPI.RetornaDadosDaCarteira: String;
begin
  If CodigoDoBanco.Equals('756') Then
    Exit(Concat('Banco: ', NomeDoBanco, #13#10,
                'Carteira selec.: ', FCarteira.ToString, #13#10,
                'Cooperativa: ',     fGetBancoConfig(0, GetConfiguracao, 'CODCOPE', ''), '-',
                                     fGetBancoConfig(0, GetConfiguracao, 'DIGCOPE', ''), #13#10,
                'Conta Corrente: ',  fGetBancoConfig(0, GetConfiguracao, 'CODCCOR', '') +
                                     fGetBancoConfig(0, GetConfiguracao, 'DIGCCOR', '')));

  If CodigoDoBanco.Equals('033') Then
    Exit(Concat('Banco: ', NomeDoBanco, #13#10,
                'Carteira selec.: ', FCarteira.ToString, #13#10,
                'Agência: ',         fGetBancoConfig(0, GetConfiguracao, 'CODAGEN', ''), #13#10,
                'Convênio Cedente: ',fGetBancoConfig(0, GetConfiguracao, 'NUMCTAC', '')));

  Result := Concat(
                   'Banco: ', NomeDoBanco, #13#10,
                   'Carteira selec.: ', FCarteira.ToString, #13#10,
                   'Agência: ',         fGetBancoConfig(0, GetConfiguracao, 'CODAGEN', ''), '-',
                                        fGetBancoConfig(0, GetConfiguracao, 'DIGAGEN', ''), #13#10,
                   'Conta Corrente: ',  fGetBancoConfig(0, GetConfiguracao, 'NUMCTAC', '') +
                                        fGetBancoConfig(0, GetConfiguracao, 'DIGCTAC', ''));
end;

function TfrmRetBcoAPI.ValidaPeriodoImportadoPorModalidadeDeCobranca: Boolean;
  Var
    LNomeArquivo: String;
begin
  Result := True;

  LNomeArquivo := Concat(edtDataInicial.Text,' - ',edtDataFinal.Text);
  If Not ValidaPeriodoImportadoRetGer(LNomeArquivo, FConfig) Then
    Exit(False);

  LNomeArquivo := Concat('[1] ',edtDataInicial.Text,' - ',edtDataFinal.Text);
  If Not ValidaPeriodoImportadoRetGer(LNomeArquivo, FConfig) Then
    Exit(False);


  LNomeArquivo := Concat('[4] ',edtDataInicial.Text,' - ',edtDataFinal.Text);
  If Not ValidaPeriodoImportadoRetGer(LNomeArquivo, FConfig) Then
    Exit(False);

end;

function TfrmRetBcoAPI.ValidaPeriodoImportadoRetGer(APeriodo,
  ACarteira: String): Boolean;
begin
  Result := Not untFuncAutBan.fRetornoDuplicado(APeriodo, FConfig);

  If Not Result Then
  begin
    Result := fMensagem('CONFIRMAÇÃO', 'Já existe esse período importado para essa carteira' +
                                       '. Deseja importar novamente?', ['&Sim', '&Não']) = 1;

    If Result Then
      untFuncAutBan.ApagaRetGerRetDet(APeriodo, FConfig);
  end;
end;

procedure TfrmRetBcoAPI.ExibeFormMensagemErro(AMensagem: String);
  Var
    LArqNaoGravados: TfrmArqNaoGravados;
begin
  Try
    pCriarFormularios(TfrmArqNaoGravados,LArqNaoGravados);
    LArqNaoGravados.Caption := 'AVISO';
    LArqNaoGravados.memResumo.WantReturns := True;
    LArqNaoGravados.memResumo.Lines.Add(AMensagem);
    LArqNaoGravados.ShowModal;
  Finally
    FreeAndNil(LArqNaoGravados);
  End;
end;

end.
