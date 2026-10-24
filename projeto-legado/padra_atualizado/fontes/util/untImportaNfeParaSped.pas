unit untImportaNfeParaSped;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, StrUtils, Uni, untFuncFat, ComCtrls, DB, UniClientDataSet,
  BitBtnLockedIncrem, DirectoryEditFocus, untEntNfeXml, DateUtils, frxClass,
  frxDBSet, untFuncoesGenerica, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxMaskEdit, cxButtonEdit, untZClient, untTypesSistema,
  untFrameDirectoryEditFocus, untFuncFatTypes;

Type
  VerificacaoException = class(Exception);
  
Type
  TItemNota = class(TObject)
    public
      intNumIte: Integer;
      strCodIte: String;
      strDescri: String;
      fltQtdIte: Double;
      strUnidad: String;
      fltVlrCon: Double;
      fltDescon: Double;
      fltFrete: Double;
      fltDesAce : Double;
      blnMovEstoque: Boolean;
      strCstIcms: String;
      strCfop: String;
      strCodNat: String;
      fltBaseIcms: Double;
      fltAlqIcms: Double;
      fltValIcms: Double;
      fltBaseST: Double;
      fltAlqST: Double;
      fltValorST: Double;
      fltValorFcpSt: Double;
      fltBaseFcpSt: Double;
      strPerApuIpi: String;
      strCstIpi: String;
      strCodEnqIpi: String;
      fltBaseIPI: Double;
      fltAlqIPI: Double;
      fltValorIPI: Double;

      strCstPis: String;
      fltBasePis: Double;
      fltAlqPis: Double;
      fltValorPis: Double;

      strCstCofins: String;
      fltBaseCofins: Double;
      fltAlqCofins: Double;
      fltValorCofins: Double;

      constructor Create(nota: TNFeXml; intIndice: Integer);
  End;

Type
  TNotaFiscal = class(TObject)
    public
      strEntSai: String;
      blnEmiPropria: Boolean;
      strCodCli: String;
      strModelo: String;
      strSituacao: String;
      strSerie: String;
      strNumDoc: String;
      strChaveNfe: String;
      dtaDtaDoc: TDateTime;
      dtaDtaEnt: TDateTime;
      fltValorTotal: Double;
      strIndPagto: String;
      fltDesconto: Double;
      fltAbatNaoTrib: Double;
      fltTotalNota: Double;
      strTipoFrete: String;
      fltValorFrete: Double;
      fltValorSeguro: Double;
      fltDespAcessorias: Double;
      fltBaseIcms: Double;
      fltValorIcms: Double;
      fltBaseST: Double;
      fltValorST: Double;
      fltBaseIPI : Double;
      fltValorIPI: Double;
      fltValorPIS: Double;
      fltValorCofins: Double;
      fltValorPISST: Double;
      fltValorCOFINSST: Double;

      arrItemNota: Array Of TItemNota;

      constructor Create(nota: TNFeXml; strCnpjEmpresa: String);
      destructor Destroy; override;
      procedure pAdicionaItem(nota: TNFeXml);
      function DeSaida: Boolean;
  end;

Type
  TEmpresa = class(TObject)
  private
    function fRetCodEmpresa(strCnpj: String): String;
  public
    strCnpj: String;
    strCodEmp: String;
    arrNotas: Array Of TNotaFiscal;

    constructor Create(strCnpj: String);
    destructor Destroy; override;
    function fAdicionaNota(nota: TNFeXml; strCnpjEmpresa: String): TNotaFiscal;
  end;

Type
  TNotaInutilizada = record
    strData: String;
    strSerie: String;
    strNumIni: String;
    strNumFin: String;
  end;

type
  TfrmImportaNfeParaSped = class(TfrmPai)
    Label1: TLabel;
    lblDocumentos: TLabel;
    pgbDocumentos: TProgressBar;
    cdsParticipantes: TUniClientDataSet;
    cdsParticipantesCODVEL: TStringField;
    cdsParticipantesCNPJ: TStringField;
    btnImportar: TBitBtnLocked;
    lblEstimativa: TLabel;
    frxReportJ: TfrxReport;
    frxParticipantes: TfrxDBDataset;
    cdsClientesNaoCadastrados: TUniClientDataSet;
    cdsClientesNaoCadastradosDocumento: TStringField;
    cdsClientesNaoCadastradosCGC: TStringField;
    fraArquivo: TfraDirectoryEditFocus;
    chkImpNotasInutilizadas: TCheckBox;
    rdgFilIte: TRadioGroup;
    cdsCodVel: TUniClientDataSet;
    cdsCodVelCODVEL: TStringField;
    cdsAbfIcm: TUniClientDataSet;
    cdsAbfIcmCODEMP: TStringField;
    cdsAbfIcmCODITE: TStringField;
    cdsAbfIcmCODEST: TStringField;
    cdsCodVelCODABF: TStringField;
    cdsCodVelCODITE: TStringField;
    cdsCodVelCODEMP: TStringField;
    chkAbfIcm: TCheckBox;
    cdsCodVelFLAG: TStringField;
    cdsAbfIcmABF_IVA_ST_ENT_PEF: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_ENT_PEJ: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_ENT_PER: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_NCO: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_CCO: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_CNC: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_CTA: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_PRU: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_SNA: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_IND: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_SAI_TRS: TCurrencyField;
    cdsAbfIcmABF_IVA_ST_ENT_PES: TCurrencyField;
    cdsAbfIcmABF_CODABF: TStringField;
    cdsAbfIcmCODABF: TStringField;
    cdsAbfIcmABF_BASICM_ENT_PEF: TCurrencyField;
    cdsAbfIcmABF_BASICM_ENT_PEJ: TCurrencyField;
    cdsAbfIcmABF_BASICM_ENT_PER: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_NCO: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_CCO: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_CNC: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_CTA: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_PRU: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_SNA: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_IND: TCurrencyField;
    cdsAbfIcmABF_BASICM_SAI_TRS: TCurrencyField;
    cdsAbfIcmABF_BASICM_ENT_PES: TCurrencyField;
    cdsAbfIcmABF_ALQICM_ENT_PEF: TCurrencyField;
    cdsAbfIcmABF_ALQICM_ENT_PEJ: TCurrencyField;
    cdsAbfIcmABF_ALQICM_ENT_PER: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_NCO: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_CCO: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_CNC: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_CTA: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_PRU: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_SNA: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_IND: TCurrencyField;
    cdsAbfIcmABF_ALQICM_SAI_TRS: TCurrencyField;
    cdsAbfIcmABF_ALQICM_ENT_PES: TCurrencyField;
    cdsAbfIcmABF_BASRET_ENT_PEF: TCurrencyField;
    cdsAbfIcmABF_BASRET_ENT_PEJ: TCurrencyField;
    cdsAbfIcmABF_BASRET_ENT_PER: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_NCO: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_CCO: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_CNC: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_CTA: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_PRU: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_SNA: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_IND: TCurrencyField;
    cdsAbfIcmABF_BASRET_SAI_TRS: TCurrencyField;
    cdsAbfIcmABF_BASRET_ENT_PES: TCurrencyField;
    cdsAbfIcmABF_ALQRET_ENT_PEF: TCurrencyField;
    cdsAbfIcmABF_ALQRET_ENT_PEJ: TCurrencyField;
    cdsAbfIcmABF_ALQRET_ENT_PER: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_NCO: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_CCO: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_CNC: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_CTA: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_PRU: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_SNA: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_IND: TCurrencyField;
    cdsAbfIcmABF_ALQRET_SAI_TRS: TCurrencyField;
    cdsAbfIcmABF_ALQRET_ENT_PES: TCurrencyField;
    cdsAbfIcmABF_RICMPR_SAI_CNC: TStringField;
    cdsAbfIcmABF_RICMPR_ENT_PEF: TStringField;
    cdsAbfIcmABF_RICMPR_ENT_PEJ: TStringField;
    cdsAbfIcmABF_RICMPR_ENT_PER: TStringField;
    cdsAbfIcmABF_RICMPR_ENT_PES: TStringField;
    cdsAbfIcmABF_RICMPR_SAI_SNA: TStringField;
    cdsAbfIcmABF_CODSIT_ENT_PEF: TStringField;
    cdsAbfIcmABF_CODSIT_ENT_PEJ: TStringField;
    cdsAbfIcmABF_CODSIT_ENT_PER: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_NCO: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_CCO: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_CNC: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_CTA: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_PRU: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_SNA: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_IND: TStringField;
    cdsAbfIcmABF_CODSIT_SAI_TRS: TStringField;
    cdsAbfIcmABF_CODSIT_ENT_PES: TStringField;
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  protected
    procedure OnImportErro(strNumDoc, strSerie, strNomArq, strMensagem: String);

  private
    empresaAtual: TEmpresa;
    notaAtual: TNotaFiscal;

    strItemEspecial: String;
    arrNotasInutilizadas: Array Of TNotaInutilizada;
    stlChavesDel: TStringList;
    stlErroArqui: TStringList;
    stlErro: TStringList;
    tmrInicioProc: TDateTime;
    intRegAtual: Integer;

    strCnpjEmpresa: String;

    cdsDadosFornec: TZClient;
    
    procedure pProcessaArquivo(strArquivo: String);
    function fArquivoCanceladoInutilizado(strArquivo: String): Boolean;
    procedure pCarregarCliente(fatVenda: TFatVenda; strCodigo: String; blnCadFor: Boolean);
    procedure pCarregaDadosItem(qryItens: TUniQuery; strCodIte, strCamCodIte: String);
    function fretItemEspecial: String;
    procedure pAcertaDadosDoDocumento(fatVenda: TFatVenda;
      dtaDtaDoc: TDateTime; nota: TNotaFiscal; itemNota: TItemNota);
    procedure pGravarNotaEspecial(empresa: TEmpresa);
    function fRetornaCodigoConsumidor: String;

    procedure pCarregarArquivos(strPath: String; stlArquivos: TStringList);
    procedure pAcertaNotasCanceladasInutilizadas;
    procedure pCancelarNotaImportada(strChave: String);
    procedure pApagarNota(qryFis: TDataSet; strHistorico: String);
    procedure pImportarNotasInutilizadas(strData, strNotaIni, strNotaFin, strSerie: String);
    procedure pInutilizarNotas(strNotaIni, strNotaFin, strSerie: String);
    function fInsereCidade(strIBGE: String): String;
    //function fValidarSeDeveExibirMensagemDeImportacaoNaoRealizada: Boolean;
    procedure pCarregaCodVel;
    procedure pCarregaAbfIcm;
    function fCalcularBaseDeIpi(const objNotaFiscal : TNotaFiscal; const arrMatItens: TMatrizFechamento) : Double;
    procedure pLimparValorDosImpostosDaMatriz(var arrMatItens: TMatrizFechamento);
    { Private declarations }
  public
    FPais: TPais;
    FCgcCpf: TCgcCpf;
  end;

function fRegistro(strLinha: String): String;
function fGetValorLinhaSped(strLinha: String; intColuna: Integer): String;
function fCampoDataSped(const strLinha: String;
  const intColuna: Integer): TDateTime;
function fCampoValorSped(const strLinha: String;
  const intColuna: Integer): Double;


implementation

uses untFuncoesSimples, untFuncoes, MaskUtils, untConstantes,
  untTValidaNFeCapa, untMensagemExplicativa;

{$R *.dfm}

procedure TfrmImportaNfeParaSped.btnImportarClick(Sender: TObject);
  Var
    stlArquivos: TStringList;
    intContador: Integer;
begin
  inherited;
  If Not DirectoryExists(fraArquivo.edtDirectory.text) Then
  Begin
    fMensagem('', 'Este path não existe.', ['&Ok']);
    Exit;
  End;

  cdsParticipantes.EmptyDataSet;
  stlErroArqui.Clear;

  empresaAtual := TEmpresa.Create(fCadEmp('C_G_C_'));

  Try
    stlArquivos := TStringList.Create;
    pCarregarArquivos(fraArquivo.edtDirectory.text, stlArquivos);
    If rdgFilIte.itemIndex = 1 Then
    Begin
      pCarregaCodVel;
      If chkAbfIcm.checked Then
        pCarregaAbfIcm;
    End;

    pgbDocumentos.Max := stlArquivos.Count;
    pgbDocumentos.Position := 0;
    
    For intContador := 0 To stlArquivos.Count-1 Do
    Begin
      lblDocumentos.Caption := 'Arquivo: ' + IntToStr(intContador+1) + ' / ' + IntToStr(stlArquivos.Count);
      Application.ProcessMessages;
      If Not fArquivoCanceladoInutilizado(stlArquivos[intContador]) Then
      Begin
        pProcessaArquivo(stlArquivos[intContador]);
      End;
      pgbDocumentos.StepBy(1);
      Application.ProcessMessages;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Exit;
    End;
    
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnImportarClick]');
      Exit;
    End;
  End;

  If cdsClientesNaoCadastrados.RecordCount > 0 Then
  Begin
    fMensagem('Aviso', 'Existem Clientes / Fornecedores / Consumidores não cadastrados!', ['&Ok']);
    pPreviewReport(Self.Name, Self.Caption + ' (Clientes não cadastrados)', frxReportJ);
    Exit;
  End;

  btnImportar.Enabled := False;
  btnSair.Enabled := False;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  Try
    pGravarNotaEspecial(empresaAtual);
    pAcertaNotasCanceladasInutilizadas;

    Application.ProcessMessages;

    fMensagem('', 'Importação concluída!', ['&Ok']);

    If stlErroArqui.Count > 0 Then
    Begin
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      Try
        frmMensagemExplicativa.Caption := 'Arquivos não importados';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 500;
        frmMensagemExplicativa.mmoInstru.Font.Size := 10;
        frmMensagemExplicativa.mmoInstru.Font.Style := [];
        frmMensagemExplicativa.mmoInstru.Lines.Add('Lista de arquivos não importados e seus respectivos motivos:');
        frmMensagemExplicativa.mmoInstru.Lines.Add(' ');
        frmMensagemExplicativa.mmoInstru.Lines.Add(stlErroArqui.Text);
        frmMensagemExplicativa.ShowModal;
      Finally
        pFreeAndNil(frmMensagemExplicativa);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      lblDocumentos.Caption := 'Documentos';
      pMensagensErro(E.Message, '[btnImportarClick]');
    End;
  End;

  lblEstimativa.Caption := 'Estimativa de término';

  btnImportar.Enabled := True;
  btnSair.Enabled := True;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;

  FreeAndNil(stlArquivos);
end;

procedure TfrmImportaNfeParaSped.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(stlChavesDel);
  FreeAndNil(stlErroArqui)
end;

procedure TfrmImportaNfeParaSped.FormCreate(Sender: TObject);
begin
  inherited;
  notaAtual := Nil;
  empresaAtual := Nil;
  stlChavesDel := TStringList.Create;
  stlErro      := TStringList.Create;
  stlErroArqui := TStringList.Create;

  strItemEspecial := fretItemEspecial;

  cdsParticipantes.CreateDataSet;
  cdsClientesNaoCadastrados.CreateDataSet;
  strCnpjEmpresa := fCadEmp('C_G_C_');

  cdsCodVel.CreateDataSet;
  cdsCodVel.IndexFieldNames := 'CODVEL';

  cdsAbfIcm.CreateDataSet;
  cdsAbfIcm.IndexFieldNames := 'CODABF; CODEMP';

  cdsDadosFornec := TZClient.Create(Self, TNFeXml.fSQLDadosFornec);
  cdsDadosFornec.fLeDados('TfrmImportaNfeParaSped.FormCreate');
  cdsDadosFornec.IndexFieldNames := 'CODFOR';

end;

procedure TfrmImportaNfeParaSped.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(fraArquivo.edtDirectory);
  FPais := fSetaPais;
end;

function TfrmImportaNfeParaSped.fretItemEspecial: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ITE_CODITE FROM CADITE WHERE ITE_DESITE LIKE "%ITEM ESPECIAL%" ');
  qryAux.Open;
  Result := qryAux.FieldByName('ITE_CODITE').AsString;
  FreeAndNil(qryAux);
end;

procedure TfrmImportaNfeParaSped.pProcessaArquivo(strArquivo: String);
  Var
    nfe: TNFeXml;
    cdsInconn: TZClient;
    strAux: String;

    procedure pValidaClientesCadastrados;
      Var
        qryCli,
        qryCliCon: TUniQuery;
        strCGC,
        strCodCon: String;

        Function fRetCodCid(strIBGE: String): String;
        Begin
          Result := fCampoTabela('IFNULL(CID_CODCID, "")', 'CADCID', ['CID_COIBGE'], [strIBGE]);

          If fEmptyStr(Result) Then
            Result := fInsereCidade(strIBGE);
        End;

    begin
      strCGC := IIF(fEmptyStr(String(nfe.recDadosNota.E02_CNPJ)),
                      nfe.recDadosNota.C02A_CPF,
                      nfe.recDadosNota.E02_CNPJ);

      If fEmptyStr(strCGC) Then
        Exit;

      qryCli := fCriaQuery(Nil);
      Try
        qryCli.SQL.Add('SELECT ');
        qryCli.SQL.Add('  COUNT(1) AS QTDE ');
        qryCli.SQL.Add('FROM ');
        qryCli.SQL.Add('  CADCLI ');
        qryCli.SQL.Add('WHERE ');
        qryCli.SQL.Add('  CLI_C_G_C_ = :CODVEL ');

        qryCli.ParamByName('CODVEL').AsString := strCGC;
        qryCli.Open;

        If qryCli.FieldByName('QTDE').AsInteger > 0 Then
          Exit
        Else
        Begin
          qryCli.SQL.Clear;
          qryCli.SQL.Add('SELECT ');
          qryCli.SQL.Add('  COUNT(1) AS QTDE ');
          qryCli.SQL.Add('FROM ');
          qryCli.SQL.Add('  CADFOR ');
          qryCli.SQL.Add('WHERE ');
          qryCli.SQL.Add('  FOR_C_G_C_ = :CODVEL ');

          qryCli.ParamByName('CODVEL').AsString := strCGC;
          qryCli.Open;

          If qryCli.FieldByName('QTDE').AsInteger > 0 Then
            Exit
          Else
          Begin
            qryCli.SQL.Clear;
            qryCli.SQL.Add('SELECT ');
            qryCli.SQL.Add('  COUNT(1) AS QTDE ');
            qryCli.SQL.Add('FROM ');
            qryCli.SQL.Add('  CLICON ');
            qryCli.SQL.Add('WHERE ');
            qryCli.SQL.Add('  CON_C_P_F_ = :CODVEL ');

            qryCli.ParamByName('CODVEL').AsString := strCGC;
            qryCli.Open;

            If qryCli.FieldByName('QTDE').AsInteger = 0 Then
            Begin
              qryCliCon := fCriarQuery('SELECT * FROM CLICON WHERE FALSE');;
              strCodCon := fAtualizaProCod('CLICON', 'CON_CODCON');

              Try
                With qryCliCon Do
                Begin
                  Open;
                  Append;

                  FieldByName('CON_CODCON').AsString := strCodCon;
                  FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLICON', VS_strCodEmp);
                  FieldByName('CON_CODEMP').AsString := VS_strCodEmp;
                  FieldByName('CON_NOMCON').AsString := String(nfe.recDadosNota.E03_XNOME);
                  FieldByName('CON_ENDERE').AsString := String(nfe.recDadosNota.E03_XLGR) + ', ' + String(nfe.recDadosNota.E07_NRO);
                  FieldByName('CON_BAIRRO').AsString := String(nfe.recDadosNota.E09_XBAIRRO);
                  FieldByName('CON_C_E_P_').AsString := String(nfe.recDadosNota.E13_CEP);
                  FieldByName('CON_CODCID').AsString := fRetCodCid(String(nfe.recDadosNota.E10_CMUN));
                  FieldByName('CON_FONE01').AsString := String(nfe.recDadosNota.E16_FONE);
                  FieldByName('CON_C_P_F_').AsString := strCGC;

                  If Length(strCGC) > 11 Then
                    FieldByName('CON_CGCCPF').AsInteger := 1
                  Else
                    FieldByName('CON_CGCCPF').AsInteger := 2;

                  Post;
                End;

              Finally
                qryCliCon.Free;
              End;

            End;
          End;
        End;
      Finally
        qryCli.Free;
      End;
    end;

begin
  nfe := TNFeXml.Create(Self, True);
  strAux := stlErro.Text;
  Try
    nfe.blnEmpresaNoDestinatario := False;
    nfe.blnImportaNfeSpedCodVel := rdgFilIte.itemIndex = 1;
    If rdgFilIte.itemIndex = 1 Then
    Begin
      nfe.cdsCodVel := cdsCodVel;
      nfe.cdsAbfIcm := cdsAbfIcm;
    End;
    nfe.cdsDadosFornec := cdsDadosFornec;
    nfe.onLogErro := OnImportErro;
    nfe.blnIgnoraInativos := True;
    nfe.blnCriarTagDestinatarioEmBrancoCasoInexistente := True; //Ao gravar a nota o sistema buscará o Cliente Consumidor

    stlErro.Clear;
    If nfe.fCarregarDoArquivo(strArquivo, cdsInconn) Then
    Begin
      notaAtual := empresaAtual.fAdicionaNota(nfe, strCnpjEmpresa);
      notaAtual.pAdicionaItem(nfe);

      cdsParticipantes.Append;
      cdsParticipantes.FieldByName('CNPJ').AsString := String(nfe.recDadosNota.E02_CNPJ);
      cdsParticipantes.Post;

      pValidaClientesCadastrados;
    End
    Else
    Begin
      stlErroArqui.Add(ExtractFileName(strArquivo));
      stlErroArqui.Add(StringOfChar('-', Length(ExtractFileName(strArquivo))));
      stlErroArqui.Add(stlErro.Text);
      stlErroArqui.Add(' ');
    End;
  Finally
    stlErro.Text := strAux + stlErro.Text;
    nfe.Free;
  End;
end;

procedure TfrmImportaNfeParaSped.pGravarNotaEspecial(empresa: TEmpresa);
  Var
    dtaDtaDoc: TDateTime;
    fatVenda: TFatVenda;

    qryDadosItens: TUniQuery;
    forTin: TForTin;

    nota: TNotaFiscal;
    itemNota: TItemNota;
    intIndItem: Integer;

    dadosMadeira: TDadosMadeira;
    strOpcDoc: String;

    fltMedia: Double;
    fltEstimativa: Double;
begin
  FillChar(forTin, SizeOf(TForTin), #0);
  FillChar(dadosMadeira, SizeOf(TDadosMadeira), #0);

  pgbDocumentos.Position := 0;
  pgbDocumentos.Max := Length(empresa.arrNotas);

  If ((Length(empresa.arrNotas)) = 0) Then
    Exit;

  intRegAtual := 0;
  tmrInicioProc := fNow();
  itemNota := Nil;

  For nota in empresa.arrNotas Do
  Begin
    lblDocumentos.Caption := 'Gravando' + IIF(nota.strModelo = '65', ' cupom ', ' nota ') + nota.strNumDoc + '-' + nota.strSerie + '...';
    Application.ProcessMessages;
    If (nota.strSituacao <> '02') And (Length(nota.arrItemNota) > 0) Then
    Begin
      dtaDtaDoc := nota.dtaDtaEnt;

      If (nota.DeSaida) Then
      Begin
        If nota.blnEmiPropria Then
          strOpcDoc := 'VN'
        Else
          strOpcDoc := 'OF';
      End
      Else
      Begin
        strOpcDoc := 'OE';
      End;

      pCriarCdsVenda(Self);
      fatVenda := TFatVenda.CreateInstance(IIF(nota.blnEmiPropria, 'VN', 'OF'), False, True);
      qryDadosItens := fCriaQuery(Self);
      Try
        fatVenda.strMen001 := 'IMPORTAÇÃO SPED';
        fatVenda.blnComTansacao := False;
        fatVenda.strNomeForm := 'frmFatVendas';
        fatVenda.strNumDoc := nota.strNumDoc;
        fatVenda.strSerFsc  := nota.strSerie;
        fatVenda.strEspDoc := IIF(nota.strModelo = '65', 'IF', 'NF');
        fatVenda.blnNotEsp := IIF(fatVenda.strEspDoc = 'NF', True, fatVenda.blnNotEsp);
        fatVenda.blnCupEsp := IIF(fatVenda.strEspDoc = 'IF', True, fatVenda.blnCupEsp);
        fatVenda.strCodVen := strLoginUsuarioLogado;
        fatVenda.strCodDig := strLoginUsuarioLogado;
        fatVenda.strConPag := '01000';
        fatVenda.blnNovoSequencial := False;
        fatVenda.blnImportacaoSpedPisCofins := True;
        fatVenda.blnImportacaoNfeParaSped := True;
        pCarregarCliente(fatVenda, nota.strCodCli, Not nota.blnEmiPropria);
  
        For itemNota In nota.arrItemNota Do
        Begin
          pCarregaDadosItem(qryDadosItens, itemNota.strCodIte, IfThen(rdgFilIte.ItemIndex = 0, 'CODITE', 'CODVEL'));
          If (qryDadosItens.IsEmpty) Then
          Begin
            pCarregaDadosItem(qryDadosItens, strItemEspecial, IfThen(rdgFilIte.ItemIndex = 0, 'CODITE', 'CODVEL'));
            itemNota.strCodIte := strItemEspecial;
          End
          Else
          Begin
            itemNota.strCodIte := qryDadosItens.FieldByName('ITE_CODITE').AsString;
          End;

          If (qryDadosItens.IsEmpty) Then
          Begin
            Raise Exception.Create('Não foi encontrado o item ' + itemNota.strCodIte + ' ou Item Especial.');
          End;

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil, 'NOR',
                                               qryDadosItens.FieldByName('ITE_CODGRU').AsString,
                                               itemNota.strCodIte,
                                               qryDadosItens.FieldByName('ITE_DESITE').AsString,
                                               qryDadosItens.FieldByName('ITE_DESITE').AsString,
                                               '',
                                               qryDadosItens.FieldByName('ITE_CODUNI').AsString,
                                               qryDadosItens.FieldByName('ITE_CODUNI').AsString,
                                               qryDadosItens.FieldByName('ITE_CODMAR').AsString,
                                               qryDadosItens.FieldByName('ITE_CODFOR').AsString,
                                               '',
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               0,
                                               itemNota.fltQtdIte,
                                               itemNota.fltVlrCon,
                                               'S',
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon,
                                               'N',
                                               0,
                                               0,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               itemNota.fltVlrCon / itemNota.fltQtdIte,
                                               0,
                                               0,
                                               qryDadosItens.FieldByName('ITE_INCPIS').AsString,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               qryDadosItens.FieldByName('ITE_CODABF').AsString,
                                               0,
                                               0,
                                               'N',
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               False,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '1',
                                               0,
                                               0,
                                               '',
                                               0,
                                               '',
                                               0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               itemNota.fltDescon,
                                               0,
                                               'N',
                                               '',
                                               itemNota.fltVlrCon,
                                               itemNota.fltVlrCon,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               itemNota.fltFrete,
                                               forTin,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               False,
                                               '',
                                               '',
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               False,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               dadosMadeira,
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               False,
                                               False,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               'N',
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               qryDadosItens.FieldByName('ITE_EXCIPI').AsString);

          cdsVenda.Edit;
          cdsVenda.FieldByName('AUTOINCREM').AsString := IntToStr(itemNota.intNumIte);
          cdsVenda.Post;
        End;

        fatVenda.blnComTansacao := False;
        fatVenda.pPreencheMatrizFechamento;

        intIndItem := 0;
        For itemNota In nota.arrItemNota Do
        Begin
          fatVenda.arrMatItens[intIndItem].strCodFis := itemNota.strCstIcms;
          Inc(intIndItem);
        End;

        fatVenda.fltDesEsp := nota.fltDesconto;
        fatVenda.fltDesAce := nota.fltDespAcessorias + nota.fltValorSeguro;
        fatVenda.fltValFre := nota.fltValorFrete;

        fatVenda.pCalculaTotGer(False, True, Nil, False);

        fatVenda.fltBasIpi := fCalcularBaseDeIpi(nota, fatVenda.arrMatItens);
        fatVenda.fltTotIpi := nota.fltValorIPI;
        fatVenda.fltTotRet := nota.fltValorST;
        fatVenda.fltBasRet := nota.fltBaseST;
        fatVenda.fltDesAce := nota.fltDespAcessorias + nota.fltValorSeguro;
        fatVenda.fltTotGer := nota.fltTotalNota;

        If Not nota.blnEmiPropria Then
        Begin
          fatVenda.strCodFor := fatVenda.strCodCli;
          fatVenda.strCodCli := '';
        End;

        pLimparValorDosImpostosDaMatriz(fatVenda.arrMatItens);

        For itemNota In nota.arrItemNota Do
        Begin
          For intIndItem := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
          Begin
            If fatVenda.arrMatItens[intIndItem].intAutInc = itemNota.intNumIte Then
            Begin
              fatVenda.strClaFis := itemNota.strCfop;
              fatVenda.arrMatItens[intIndItem].strCodFis := itemNota.strCstIcms;
              fatVenda.arrMatItens[intIndItem].strClaFis := itemNota.strCfop;
              fatVenda.arrMatItens[intIndItem].fltBasIpi := itemNota.fltBaseIPI;
              fatVenda.arrMatItens[intIndItem].fltAlqIpi := itemNota.fltAlqIPI;
              fatVenda.arrMatItens[intIndItem].fltValipi := itemNota.fltValorIPI;
              fatVenda.arrMatItens[intIndItem].fltBasRet := itemNota.fltBaseST;
              fatVenda.arrMatItens[intIndItem].fltAlqRet := itemNota.fltAlqST;
              fatVenda.arrMatItens[intIndItem].fltValRet := itemNota.fltValorST;
              If (itemNota.fltValorST > 0) Then
              Begin
                fatVenda.arrMatItens[intIndItem].recDifalFCP.fltValFcp := itemNota.fltValorFcpSt;
                fatVenda.arrMatItens[intIndItem].recDifalFCP.fltBasFcp := itemNota.fltBaseFcpSt;
              End;

              fatVenda.arrMatItens[intIndItem].fltBasIcm := itemNota.fltBaseIcms;
              fatVenda.arrMatItens[intIndItem].fltAlqIcm := itemNota.fltAlqIcms;
              fatVenda.arrMatItens[intIndItem].fltValIcm := itemNota.fltValIcms;
              fatVenda.arrMatItens[intIndItem].fltValFre := itemNota.fltFrete;
              fatVenda.arrMatItens[intIndItem].fltDesEsp := itemNota.fltDescon;
              fatVenda.arrMatItens[intIndItem].fltDesAce := itemNota.fltDesAce;

              fatVenda.arrMatItens[intIndItem].fltBasPis := itemNota.fltBasePis;
              fatVenda.arrMatItens[intIndItem].fltAlqPis := itemNota.fltAlqPis;
              fatVenda.arrMatItens[intIndItem].fltValPis := itemNota.fltValorPis;
              fatVenda.arrMatItens[intIndItem].strCSTPis := itemNota.strCstPis;

              fatVenda.arrMatItens[intIndItem].fltBasCof := itemNota.fltBaseCofins;
              fatVenda.arrMatItens[intIndItem].fltAlqCof := itemNota.fltAlqCofins;
              fatVenda.arrMatItens[intIndItem].fltValCof := itemNota.fltValorCofins;
              fatVenda.arrMatItens[intIndItem].strCSTCof := itemNota.strCstCofins;

              Break;
            End;
          End;
        End;

        fatVenda.pCalculaPisCofinsLivro_SomenteCapa;

        Try
          If fatVenda.fGravaArquivos Then
          Begin
            pAcertaDadosDoDocumento(fatVenda, dtaDtaDoc, nota, itemNota);
          End
          Else
            Raise Exception.Create('Não foi possível gravar a nota.');
        Except
          On E: Exception Do
          Begin
            Raise Exception.Create('Houve um erro ao gerar a nota especial: ' + E.Message);
          End;
        End;
      Finally
        FreeAndNil(fatVenda);
        pFreeCdsVenda;
        FreeAndNil(qryDadosItens);
      End;

      pgbDocumentos.StepBy(1);
      Application.ProcessMessages;

      Inc(intRegAtual);

      fltMedia := (SecondsBetween(fNow(), tmrInicioProc) / intRegAtual);
      fltEstimativa := (fltMedia * (Length(empresaAtual.arrNotas) - intRegAtual)) / SecsPerDay;
      lblEstimativa.Caption := 'Estimativa de término: ' + FormatDateTime('hh:nn:ss', fltEstimativa);
    End;

  End;

end;

function TfrmImportaNfeParaSped.fCalcularBaseDeIpi(const objNotaFiscal : TNotaFiscal; const arrMatItens: TMatrizFechamento) : Double;
  Var
    itemNota : TItemNota;
    intIndItem : Integer;
begin
  Result := 0;
  For itemNota In objNotaFiscal.arrItemNota Do
  Begin
    For intIndItem := Low(arrMatItens) To High(arrMatItens) Do
    Begin
      If arrMatItens[intIndItem].intAutInc = itemNota.intNumIte Then
        Result := Result + itemNota.fltBaseIPI;
    End;
  End;
end;

procedure TfrmImportaNfeParaSped.pLimparValorDosImpostosDaMatriz(var arrMatItens: TMatrizFechamento);
  Var
    intIndItem : Integer;
begin
  For intIndItem := Low(arrMatItens) To High(arrMatItens) Do
  Begin
    arrMatItens[intIndItem].fltBasIpi := 0;
    arrMatItens[intIndItem].fltAlqIpi := 0;
    arrMatItens[intIndItem].fltValipi := 0;
    arrMatItens[intIndItem].fltBasRet := 0;
    arrMatItens[intIndItem].fltAlqRet := 0;
    arrMatItens[intIndItem].fltValRet := 0;
    arrMatItens[intIndItem].fltBasIcm := 0;
    arrMatItens[intIndItem].fltAlqIcm := 0;
    arrMatItens[intIndItem].fltValIcm := 0;
    arrMatItens[intIndItem].fltValFre := 0;
    arrMatItens[intIndItem].fltDesEsp := 0;
    arrMatItens[intIndItem].fltBasPis := 0;
    arrMatItens[intIndItem].fltAlqPis := 0;
    arrMatItens[intIndItem].fltValPis := 0;
    arrMatItens[intIndItem].fltBasCof := 0;
    arrMatItens[intIndItem].fltAlqCof := 0;
    arrMatItens[intIndItem].fltValCof := 0;
    FillChar(arrMatItens[intIndItem].recDifalFCP, SizeOf(arrMatItens[intIndItem].recDifalFCP), #0);
  End;
end;

procedure TfrmImportaNfeParaSped.pImportarNotasInutilizadas(strData, strNotaIni, strNotaFin, strSerie: String);
  Var
    blnFinal: Boolean;
    qryAux: TUniQuery;
    strDtaEnt: String;
begin
  blnFinal := True;

  strNotaIni := AnsiReplaceStr(strNotaIni, '<NNFINI>', '');
  strNotaFin := AnsiReplaceStr(strNotaFin, '<NNFFIN>', '');
  strSerie := AnsiReplaceStr(strSerie, '<SERIE>', '');
  strDtaEnt := Copy(strData, 9 , 2) + '/' + Copy(strData, 6 , 2) + '/' + Copy(strData, 1 , 4);

  qryAux := fCriaQuery(Self);
  Try
    If strNotaIni = strNotaFin Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO CADFIS (AUTOINCREM, FIS_DTAENT, FIS_NUMDOC, FIS_CODEMP, FIS_SERIE_, FIS_ESPDOC, FIS_HISTOR) VALUES (:AUTOINCREM, :DATA, :NUMDOC, :CODEMP, :SERIE_, :ESPDOC, :HISTOR)');
      qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFIS', empresaAtual.strCodEmp);
      qryAux.ParamByName('DATA').AsDateTime := StrToDate(strDtaEnt);
      qryAux.ParamByName('NUMDOC').AsString := strNotaIni;
      qryAux.ParamByName('CODEMP').AsString := empresaAtual.strCodEmp;
      qryAux.ParamByName('SERIE_').AsString := strSerie;
      qryAux.ParamByName('ESPDOC').AsString := 'NF';
      qryAux.ParamByName('HISTOR').AsString := 'INUTILIZADO';
      qryAux.ExecSQL;
    End
    Else
    Begin
      While blnFinal Do
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('INSERT INTO CADFIS (AUTOINCREM, FIS_DTAENT, FIS_NUMDOC, FIS_CODEMP, FIS_SERIE_, FIS_ESPDOC, FIS_HISTOR) VALUES (:AUTOINCREM, :DATA, :NUMDOC, :CODEMP, :SERIE_, :ESPDOC, :HISTOR)');
        qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFIS', empresaAtual.strCodEmp);
        qryAux.ParamByName('DATA').AsDateTime := StrToDate(strDtaEnt);
        qryAux.ParamByName('NUMDOC').AsString := strNotaIni;
        qryAux.ParamByName('CODEMP').AsString := empresaAtual.strCodEmp;
        qryAux.ParamByName('SERIE_').AsString := strSerie;
        qryAux.ParamByName('ESPDOC').AsString := 'NF';
        qryAux.ParamByName('HISTOR').AsString := 'INUTILIZADO';
        qryAux.ExecSQL;

        strNotaIni := IntToStr(StrToInt(strNotaIni) + 1);

        If strNotaIni = strNotaFin Then
        Begin
          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('INSERT INTO CADFIS (AUTOINCREM, FIS_DTAENT, FIS_NUMDOC, FIS_CODEMP, FIS_SERIE_, FIS_ESPDOC, FIS_HISTOR) VALUES (:AUTOINCREM, :DATA, :NUMDOC, :CODEMP, :SERIE_, :ESPDOC, :HISTOR)');
          qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFIS', empresaAtual.strCodEmp);
          qryAux.ParamByName('DATA').AsDateTime := StrToDate(strDtaEnt);
          qryAux.ParamByName('NUMDOC').AsString := strNotaIni;
          qryAux.ParamByName('CODEMP').AsString := empresaAtual.strCodEmp;
          qryAux.ParamByName('SERIE_').AsString := strSerie;
          qryAux.ParamByName('ESPDOC').AsString := 'NF';
          qryAux.ParamByName('HISTOR').AsString := 'INUTILIZADO';
          qryAux.ExecSQL;

          blnFinal := False;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmImportaNfeParaSped.pInutilizarNotas(strNotaIni, strNotaFin,
  strSerie: String);
  Var
    qryFis: TUniQuery;
begin
  qryFis := fCriaQuery(Self);
  Try
    qryFis.SQL.Add('SELECT * FROM CADFIS WHERE IFNULL(FIS_SERIE_,"") = :SERIE_ AND ');
    qryFis.SQL.Add('FIS_NUMDOC BETWEEN :DOCINI AND :DOCFIN ');
    qryFis.ParamByName('SERIE_').AsString := strSerie;
    qryFis.ParamByName('DOCINI').AsString := strNotaIni;
    qryFis.ParamByName('DOCFIN').AsString := strNotaFin;
    qryFis.Open;

    While (Not qryFis.Eof) Do
    Begin
      pApagarNota(qryFis, 'INUTILIZADO');
      qryFis.Next;
    End;
  Finally
    FreeAndNil(qryFis);
  End;
end;

procedure TfrmImportaNfeParaSped.pAcertaDadosDoDocumento(fatVenda: TFatVenda;
  dtaDtaDoc: TDateTime; nota: TNotaFiscal; itemNota: TItemNota);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE NOTGER SET ');
  qryAux.SQL.Add('  GER_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  GER_IMPRES = 1, ');
  qryAux.SQL.Add('  GER_ORIDOC = :ORIDOC ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF nota.blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE NOTDET SET ');
  qryAux.SQL.Add('  DET_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  DET_IMPRES = 1, ');
  qryAux.SQL.Add('  DET_ORIDOC = :ORIDOC ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(DET_TIP_FC="C", DET_CODCLI, DET_CODFOR) = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF nota.blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  FIS_DTADOC = :DTAENT, ');
  qryAux.SQL.Add('  FIS_ORIDOC = :ORIDOC, ');
  qryAux.SQL.Add('  FIS_ACESSO = :ACESSO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF nota.blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;
  qryAux.ParamByName('ACESSO').AsString := nota.strChaveNfe;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmImportaNfeParaSped.pAcertaNotasCanceladasInutilizadas;
  Var
    strChave: String;
    recInut: TNotaInutilizada;
begin
  lblDocumentos.Caption := 'Processando arquivos de notas deletadas...';
  Application.ProcessMessages;

  For strChave In stlChavesDel Do
  Begin
    pCancelarNotaImportada(strChave);
  End;

  lblDocumentos.Caption := 'Processando arquivos de notas inutilizadas...';
  Application.ProcessMessages;

  For recInut In arrNotasInutilizadas Do
  Begin
    If chkImpNotasInutilizadas.Checked Then
      pImportarNotasInutilizadas(recInut.strData, recInut.strNumIni, recInut.strNumFin, recInut.strSerie)
    Else
      pInutilizarNotas(recInut.strNumIni, recInut.strNumFin, recInut.strSerie);
  End;
end;

procedure TfrmImportaNfeParaSped.pApagarNota(qryFis: TDataSet; strHistorico: String);
  Var
    intContador: Integer;
    qryDel: TUniQuery;

    function f(strCampo: String; intIndice: Integer): TField;
    begin
      Result := qryFis.FieldByName(strCampo + IntToStr(intIndice));
    end;
begin
  qryDel := fCriaQuery(Self);

  If Not qryFis.IsEmpty Then
  Begin
    qryFis.Edit;
    qryFis.FieldByName('FIS_HISTOR').AsString := strHistorico;
    qryFis.FieldByName('FIS_BASPIS').AsFloat := 0;
    qryFis.FieldByName('FIS_TOTPIS').AsFloat := 0;
    qryFis.FieldByName('FIS_ALQPIS').AsFloat := 0;
    qryFis.FieldByName('FIS_BASCOF').AsFloat := 0;
    qryFis.FieldByName('FIS_TOTCOF').AsFloat := 0;
    qryFis.FieldByName('FIS_ALQCOF').AsFloat := 0;

    For intContador := 1 To 5 Do
    Begin
      f('FIS_VLCON', intContador).Value := Null;
      f('FIS_BASIC', intContador).Value := Null;
      f('FIS_ALQIC', intContador).Value := Null;
      f('FIS_VLRIC', intContador).Value := Null;
      f('FIS_OUTRA', intContador).Value := Null;
      f('FIS_ISENT', intContador).Value := Null;
      f('FIS_RETID', intContador).Value := Null;
      f('FIS_BASIP', intContador).Value := Null;
      f('FIS_VLRIP', intContador).Value := Null;
      f('FIS_BCRET', intContador).Value := Null;
      f('FIS_DACES', intContador).Value := Null;
    End;
    qryFis.Post;

    qryDel.SQL.Add('DELETE FROM NOTGER WHERE GER_NOTESP = "S" AND GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND ');
    qryDel.SQL.Add('GER_CODEMP = :CODEMP AND GER_CODCLI = :CODCLI AND IFNULL(GER_SERIE_,"") = :SERIE_ ');
    qryDel.ParamByName('NUMDOC').AsString := qryFis.FieldByName('FIS_NUMDOC').AsString;
    qryDel.ParamByName('ESPDOC').AsString := qryFis.FieldByName('FIS_ESPDOC').AsString;
    qryDel.ParamByName('CODEMP').AsString := qryFis.FieldByName('FIS_CODEMP').AsString;
    qryDel.ParamByName('CODCLI').AsString := qryFis.FieldByName('FIS_FORCLI').AsString;
    qryDel.ParamByName('SERIE_').AsString := qryFis.FieldByName('FIS_SERIE_').AsString;
    qryDel.ExecSQL;
  End;
  
  FreeAndNil(qryDel);
end;

procedure TfrmImportaNfeParaSped.pCancelarNotaImportada(strChave: String);
  Var
    qryFis: TUniQuery;
begin
  qryFis := fCriaQuery(Self);

  Try
    qryFis.SQL.Add('SELECT * FROM CADFIS WHERE FIS_ACESSO = :ACESSO');
    qryFis.ParamByName('ACESSO').AsString := strChave;
    qryFis.Open;

    pApagarNota(qryFis, 'CANCELADO');

  Finally
    FreeAndNil(qryFis);
  End;
end;

function TfrmImportaNfeParaSped.fArquivoCanceladoInutilizado(strArquivo: String): Boolean;
  Var
    stlArq: TStringList;
    strChave: String;
    intIniChave: Integer;
    strTexto: String;

    intPosIni: Integer;
    intPosFin: Integer;
    intTamMat: Integer;
begin
  Result := False;

  If AnsiEndsText('procNFe.xml', strArquivo) Then
    Exit;

  stlArq := TStringList.Create;
  stlArq.LoadFromFile(strArquivo);
  strTexto := AnsiUpperCase(stlArq.Text);

  If Pos(AnsiUpperCase('<descEvento>Cancelamento</descEvento>'), strTexto) > 0 Then
  Begin
    intIniChave := Pos(AnsiUpperCase('<chNFe>'), strTexto);
    strChave := Copy(strTexto, intIniChave+7, 44);
    stlChavesDel.Add(strChave);

    Result := True;
  End

  Else If Pos(AnsiUpperCase('<xServ>CANCELAR</xServ>'), strTexto) > 0 Then
  Begin
    intIniChave := Pos(AnsiUpperCase('<chNFe>'), strTexto);
    strChave := Copy(strTexto, intIniChave+7, 44);
    stlChavesDel.Add(strChave);

    Result := True;
  End

  Else If Pos(AnsiUpperCase('<xServ>INUTILIZAR</xServ>'), strTexto) > 0 Then
  Begin
    intTamMat := 0;
    SetLength(arrNotasInutilizadas, intTamMat+1);

    intPosIni := Pos(AnsiUpperCase('<serie>'), strTexto);
    intPosFin := Pos(AnsiUpperCase('</serie>'), strTexto);
    arrNotasInutilizadas[intTamMat].strSerie := Copy(strTexto, intPosIni, (intPosFin-intPosIni));

    intPosIni := Pos(AnsiUpperCase('<nNFIni>'), strTexto);
    intPosFin := Pos(AnsiUpperCase('</nNFIni>'), strTexto);
    arrNotasInutilizadas[intTamMat].strNumIni := Copy(strTexto, intPosIni, (intPosFin-intPosIni));

    intPosIni := Pos(AnsiUpperCase('<nNFFin>'), strTexto);
    intPosFin := Pos(AnsiUpperCase('</nNFFin>'), strTexto);
    arrNotasInutilizadas[intTamMat].strNumFin := Copy(strTexto, intPosIni, (intPosFin-intPosIni));

    intPosIni := Pos(AnsiUpperCase('<dhRecbto>'), strTexto);
    intPosFin := Pos(AnsiUpperCase('</dhRecbto>'), strTexto);
    arrNotasInutilizadas[intTamMat].strData := Copy(AnsiReplaceStr(AnsiReplaceStr(Copy(strTexto, intPosIni, (intPosFin-intPosIni)), '<DHRECBTO>', ''), '-', '/'), 0 , 10);

    Result := True;
  End;

  FreeAndNil(stlArq);
end;

function TfrmImportaNfeParaSped.fInsereCidade(strIBGE: String): String;
  Var
    qryCadCid,
    qryDadCid : TUniQuery;
    strCodCid : String;
begin
  Result := '';

  Try
    qryDadCid := fCriaQuery(Self);

    With qryDadCid Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT c.id_uf,              ');
      SQL.Add('       c.id_cidade,          ');
      SQL.Add('       c.cep,                ');
      SQL.Add('       c.nome AS cidade,     ');
      SQL.Add('       I.IBG_CODMUN AS IBGE  ');
      SQL.Add('FROM   IBG_CADIBG I INNER JOIN cidade c ON c.nome = I.IBG_NOMMUN  ');
      SQL.Add('WHERE  I.IBG_CODMUN = :IBGE ');
      ParamByName('IBGE').AsString := strIBGE;
      Open;
    End;

    If Not qryDadCid.IsEmpty Then
    Begin
      qryCadCid := fCriarQuery('SELECT * FROM CADCID WHERE FALSE');
      strCodCid := fAtualizaProCod('CADCID', 'CID_CODCID');

      With qryCadCid Do
      Begin
        Open;
        Append;

        FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCID', VS_strCodEmp);
        FieldByName('CID_CODCID').AsString   := strCodCid;
        FieldByName('CID_CODEMP').AsString   := VS_strCodEmp;
        FieldByName('CID_NOMCID').AsString   := UpperCase(fRemoveAcento(qryDadCid.FieldByName('cidade').AsString));
        FieldByName('CID_C_E_P_').AsString   := UpperCase(qryDadCid.FieldByName('cep').AsString);
        FieldByName('CID_CODCOR').AsString   := UpperCase(qryDadCid.FieldByName('id_cidade').AsString);
        FieldByName('CID_ESTADO').AsString   := UpperCase(qryDadCid.FieldByName('id_uf').AsString);
        FieldByName('CID_COIBGE').AsString   := UpperCase(qryDadCid.FieldByName('IBGE').AsString);
        FieldByName('CID_CODPAI').AsString   := '1058';
        FieldByName('CID_ORIGEM').AsString   := 'IMP.SPED';
        Post;
      End;

      FreeAndNil(qryCadCid);

      Result := strCodCid;
    End
    Else
      Result := '';

    FreeAndNil(qryDadCid);

  Except
    On E: Exception Do
      pMensagensErro(E.message, '');
  End;

end;

procedure TfrmImportaNfeParaSped.pCarregaAbfIcm;
var
  qryAbfIcm: TUniQuery;
begin
  If Assigned(cdsAbfIcm) Then
  Begin
    cdsAbfIcm.Open;
    qryAbfIcm := fCriaQuery;

    Try
      cdsCodVel.First;

      pgbDocumentos.Max := cdsCodVel.recordCount;
      pgbDocumentos.Position := 0;
      lblDocumentos.Caption := 'Carregando Abreviação Fiscal ... ';
      cdsCodVel.FIRST;
      While Not cdsCodVel.Eof Do
      Begin
        with qryAbfIcm, sql Do
        Begin
          Clear;
          Close;
          Add('SELECT ABF_CODABF, ABF_ESTADO, ');
          Add('       ABF_IVA_ST_ENT_PEF,');
          Add('       ABF_IVA_ST_ENT_PEJ,');
          Add('       ABF_IVA_ST_ENT_PER,');
          Add('       ABF_IVA_ST_SAI_NCO,');
          Add('       ABF_IVA_ST_SAI_CCO,');
          Add('       ABF_IVA_ST_SAI_CNC,');
          Add('       ABF_IVA_ST_SAI_CTA,');
          Add('       ABF_IVA_ST_SAI_PRU,');
          Add('       ABF_IVA_ST_SAI_SNA,');
          Add('       ABF_IVA_ST_SAI_IND,');
          Add('       ABF_IVA_ST_SAI_TRS,');
          Add('       ABF_IVA_ST_ENT_PES,');
          Add('       ABF_BASICM_ENT_PEF,');
          Add('       ABF_BASICM_ENT_PEJ,');
          Add('       ABF_BASICM_ENT_PER,');
          Add('       ABF_BASICM_SAI_NCO,');
          Add('       ABF_BASICM_SAI_CCO,');
          Add('       ABF_BASICM_SAI_CNC,');
          Add('       ABF_BASICM_SAI_CTA,');
          Add('       ABF_BASICM_SAI_PRU,');
          Add('       ABF_BASICM_SAI_SNA,');
          Add('       ABF_BASICM_SAI_IND,');
          Add('       ABF_BASICM_SAI_TRS,');
          Add('       ABF_BASICM_ENT_PES,');
          Add('       ABF_ALQICM_ENT_PEF,');
          Add('       ABF_ALQICM_ENT_PEJ,');
          Add('       ABF_ALQICM_ENT_PER,');
          Add('       ABF_ALQICM_SAI_NCO,');
          Add('       ABF_ALQICM_SAI_CCO,');
          Add('       ABF_ALQICM_SAI_CNC,');
          Add('       ABF_ALQICM_SAI_CTA,');
          Add('       ABF_ALQICM_SAI_PRU,');
          Add('       ABF_ALQICM_SAI_SNA,');
          Add('       ABF_ALQICM_SAI_IND,');
          Add('       ABF_ALQICM_SAI_TRS,');
          Add('       ABF_ALQICM_ENT_PES,');

          Add('       ABF_BASRET_ENT_PEF,');
          Add('       ABF_BASRET_ENT_PEJ,');
          Add('       ABF_BASRET_ENT_PER,');
          Add('       ABF_BASRET_SAI_NCO,');
          Add('       ABF_BASRET_SAI_CCO,');
          Add('       ABF_BASRET_SAI_CNC,');
          Add('       ABF_BASRET_SAI_CTA,');
          Add('       ABF_BASRET_SAI_PRU,');
          Add('       ABF_BASRET_SAI_SNA,');
          Add('       ABF_BASRET_SAI_IND,');
          Add('       ABF_BASRET_SAI_TRS,');
          Add('       ABF_BASRET_ENT_PES,');

          Add('       ABF_ALQRET_ENT_PEF,');
          Add('       ABF_ALQRET_ENT_PEJ,');
          Add('       ABF_ALQRET_ENT_PER,');
          Add('       ABF_ALQRET_SAI_NCO,');
          Add('       ABF_ALQRET_SAI_CCO,');
          Add('       ABF_ALQRET_SAI_CNC,');
          Add('       ABF_ALQRET_SAI_CTA,');
          Add('       ABF_ALQRET_SAI_PRU,');
          Add('       ABF_ALQRET_SAI_SNA,');
          Add('       ABF_ALQRET_SAI_IND,');
          Add('       ABF_ALQRET_SAI_TRS,');
          Add('       ABF_ALQRET_ENT_PES,');

          Add('       ABF_RICMPR_SAI_CNC,');
          Add('       ABF_RICMPR_ENT_PEF,');
          Add('       ABF_RICMPR_ENT_PEJ,');
          Add('       ABF_RICMPR_ENT_PER,');
          Add('       ABF_RICMPR_ENT_PES,');
          Add('       ABF_RICMPR_SAI_SNA,');

          Add('       ABF_CODSIT_ENT_PEF,');
          Add('       ABF_CODSIT_ENT_PEJ,');
          Add('       ABF_CODSIT_ENT_PER,');
          Add('       ABF_CODSIT_SAI_NCO,');
          Add('       ABF_CODSIT_SAI_CCO,');
          Add('       ABF_CODSIT_SAI_CNC,');
          Add('       ABF_CODSIT_SAI_CTA,');
          Add('       ABF_CODSIT_SAI_PRU,');
          Add('       ABF_CODSIT_SAI_SNA,');
          Add('       ABF_CODSIT_SAI_IND,');
          Add('       ABF_CODSIT_SAI_TRS,');
          Add('       ABF_CODSIT_ENT_PES ');


          Add('FROM ABFICM');
          Add('INNER JOIN CADITE ON ITE_CODITE = :CODITE');
          Add('WHERE ABF_CODABF = :CODABF');
          ParamByName('CODABF').AsString := cdsCodVelCODABF.AsString;
          ParamByName('CODITE').AsString := cdsCodVelCODITE.AsString;
          Open;
        End;
        If Not qryAbfIcm.isEmpty Then
        Begin
          qryAbfIcm.First;
          While Not qryAbfIcm.Eof Do
          Begin
            cdsAbfIcm.Append;
            cdsAbfIcmABF_CODABF.AsString := qryAbfIcm.FieldByName('ABF_CODABF').AsString;
            cdsAbfIcmCODEMP.AsString := cdsCodVelCODEMP.AsString;
            cdsAbfIcmCODITE.AsString := cdsCodVelCODITE.AsString;
            cdsAbfIcmCODEST.AsString := qryAbfIcm.FieldByName('ABF_ESTADO').AsString;
            cdsAbfIcmABF_IVA_ST_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_ENT_PEF').AsFloat;
            cdsAbfIcmABF_IVA_ST_ENT_PEJ.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_ENT_PEJ').AsFloat;
            cdsAbfIcmABF_IVA_ST_ENT_PER.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_ENT_PER').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_NCO.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_NCO').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_CCO.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_CCO').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_CNC.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_CNC').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_CTA.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_CTA').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_PRU.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_PRU').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_SNA.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_SNA').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_IND.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_IND').AsFloat;
            cdsAbfIcmABF_IVA_ST_SAI_TRS.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_SAI_TRS').AsFloat;
            cdsAbfIcmABF_IVA_ST_ENT_PES.AsFloat := qryAbfIcm.FieldByName('ABF_IVA_ST_ENT_PES').AsFloat;

            cdsAbfIcmABF_BASICM_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_ENT_PEF').AsFloat;
            cdsAbfIcmABF_BASICM_ENT_PEJ.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_ENT_PEJ').AsFloat;
            cdsAbfIcmABF_BASICM_ENT_PER.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_ENT_PER').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_NCO.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_NCO').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_CCO.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_CCO').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_CNC.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_CNC').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_CTA.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_CTA').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_PRU.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_PRU').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_SNA.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_SNA').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_IND.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_IND').AsFloat;
            cdsAbfIcmABF_BASICM_SAI_TRS.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_SAI_TRS').AsFloat;
            cdsAbfIcmABF_BASICM_ENT_PES.AsFloat := qryAbfIcm.FieldByName('ABF_BASICM_ENT_PES').AsFloat;


            cdsAbfIcmABF_ALQICM_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_ENT_PEF').AsFloat;
            cdsAbfIcmABF_ALQICM_ENT_PEJ.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_ENT_PEJ').AsFloat;
            cdsAbfIcmABF_ALQICM_ENT_PER.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_ENT_PER').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_NCO.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_NCO').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_CCO.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_CCO').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_CNC.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_CNC').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_CTA.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_CTA').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_PRU.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_PRU').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_SNA.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_SNA').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_IND.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_IND').AsFloat;
            cdsAbfIcmABF_ALQICM_SAI_TRS.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_SAI_TRS').AsFloat;
            cdsAbfIcmABF_ALQICM_ENT_PES.AsFloat := qryAbfIcm.FieldByName('ABF_ALQICM_ENT_PES').AsFloat;

            cdsAbfIcmABF_BASRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_ENT_PEF').AsFloat;
            cdsAbfIcmABF_BASRET_ENT_PEJ.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_ENT_PEJ').AsFloat;
            cdsAbfIcmABF_BASRET_ENT_PER.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_ENT_PER').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_NCO.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_NCO').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_CCO.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_CCO').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_CNC.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_CNC').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_CTA.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_CTA').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_PRU.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_PRU').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_SNA.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_SNA').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_IND.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_IND').AsFloat;
            cdsAbfIcmABF_BASRET_SAI_TRS.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_SAI_TRS').AsFloat;
            cdsAbfIcmABF_BASRET_ENT_PES.AsFloat := qryAbfIcm.FieldByName('ABF_BASRET_ENT_PES').AsFloat;

            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_ENT_PEF').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_ENT_PEJ').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_ENT_PER').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_NCO').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_CCO').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_CNC').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_CTA').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_PRU').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_SNA').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_IND').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_SAI_TRS').AsFloat;
            cdsAbfIcmABF_ALQRET_ENT_PEF.AsFloat := qryAbfIcm.FieldByName('ABF_ALQRET_ENT_PES').AsFloat;

            cdsAbfIcmABF_RICMPR_SAI_CNC.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_SAI_CNC').AsString;
            cdsAbfIcmABF_RICMPR_ENT_PEF.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_ENT_PEF').AsString;
            cdsAbfIcmABF_RICMPR_ENT_PEJ.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_ENT_PEJ').AsString;
            cdsAbfIcmABF_RICMPR_ENT_PER.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_ENT_PER').AsString;
            cdsAbfIcmABF_RICMPR_ENT_PES.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_ENT_PES').AsString;
            cdsAbfIcmABF_RICMPR_SAI_SNA.AsString := qryAbfIcm.FieldByName('ABF_RICMPR_SAI_SNA').AsString;

            cdsAbfIcmABF_CODSIT_ENT_PEF.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_ENT_PEF').AsString;
            cdsAbfIcmABF_CODSIT_ENT_PEJ.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_ENT_PEJ').AsString;
            cdsAbfIcmABF_CODSIT_ENT_PER.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_ENT_PER').AsString;
            cdsAbfIcmABF_CODSIT_SAI_NCO.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_NCO').AsString;
            cdsAbfIcmABF_CODSIT_SAI_CCO.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_CCO').AsString;
            cdsAbfIcmABF_CODSIT_SAI_CNC.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_CNC').AsString;
            cdsAbfIcmABF_CODSIT_SAI_CTA.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_CTA').AsString;
            cdsAbfIcmABF_CODSIT_SAI_PRU.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_PRU').AsString;
            cdsAbfIcmABF_CODSIT_SAI_SNA.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_SNA').AsString;
            cdsAbfIcmABF_CODSIT_SAI_IND.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_IND').AsString;
            cdsAbfIcmABF_CODSIT_SAI_TRS.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_SAI_TRS').AsString;
            cdsAbfIcmABF_CODSIT_ENT_PES.AsString := qryAbfIcm.FieldByName('ABF_CODSIT_ENT_PES').AsString;

            cdsAbfIcm.Post;
            qryAbfIcm.Next;
          End;
        End;
        cdsCodVel.Next;
        pgbDocumentos.StepBy(1);
        Application.ProcessMessages;
      End;
    Finally
      FreeAndNil(qryAbfIcm);
    End;
  End;
end;

procedure TfrmImportaNfeParaSped.pCarregaCodVel;
var
  qryCodVel: TUniQuery;
begin
  If assigned(cdsCodVel) Then
  Begin
    cdsCodVel.Open;
    qryCodVel := fCriaQuery;
    Try
      with qryCodVel, sql Do
      Begin
        Clear;
        Close;
        Add('SELECT DISTINCT ITE_CODVEL, ITE_CODABF, ITE_CODITE, ITE_CODEMP FROM CADITE');
        Add('WHERE ITE_ITEATI = "S" AND COALESCE(ITE_CODVEL, "") <> ""');
        Open;
      End;
      If Not qryCodVel.isEmpty Then
      Begin
        qryCodVel.First;
        While Not qryCodVel.Eof Do
        Begin
          If (Not cdsCodVel.FindKey([qryCodVel.FieldByName('ITE_CODVEL').AsString]) ) And
             (Not fEmptyStr(qryCodVel.FieldByName('ITE_CODVEL').AsString)) Then
          Begin
            cdsCodVel.Append;
            cdsCodVelCODVEL.AsString := qryCodVel.FieldByName('ITE_CODVEL').AsString;
            cdsCodVelCODABF.AsString := qryCodVel.FieldByName('ITE_CODABF').AsString;
            cdsCodVelCODITE.AsString := qryCodVel.FieldByName('ITE_CODITE').AsString;
            cdsCodVelCODEMP.AsString := qryCodVel.FieldByName('ITE_CODEMP').AsString;
            cdsCodVel.Post;
          End;
          qryCodVel.Next;
        End;
      End;
    Finally
      FreeAndNil(qryCodVel);
    End;
  End;
end;

procedure TfrmImportaNfeParaSped.pCarregarCliente(fatVenda: TFatVenda; strCodigo: String; blnCadFor: Boolean);
  Var
    qryCli: TUniQuery;
begin
  qryCli := fCriaQuery(Self);

  qryCli.SQL.Add('SELECT ');
  qryCli.SQL.Add('  CLI_CODCLI ');
  qryCli.SQL.Add('FROM ');
  qryCli.SQL.Add('  CADCLI ');
  qryCli.SQL.Add('WHERE ');

  If fEmptyStr(strCodigo) Then
  Begin
    qryCli.SQL.Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" LIMIT 1');
  End
  Else
  Begin
    qryCli.SQL.Add('  CLI_C_G_C_ = :CODVEL ');
    qryCli.ParamByName('CODVEL').AsString := strCodigo;
  End;

  qryCli.Open;

  If Not qryCli.IsEmpty Then
  Begin
    fatVenda.pCarregaDadosClienteBaixa(qryCli.FieldByName('CLI_CODCLI').AsString);
  End
  Else
  Begin
    qryCli.SQL.Clear;
    qryCli.SQL.Add('SELECT ');
    qryCli.SQL.Add('  FOR_CODFOR, FOR_NOMFOR, FOR_ENDNUM, FOR_ENDCOM, ');
    qryCli.SQL.Add('  FOR_ENDERE, FOR_BAIRRO, FOR_C_E_P_, ');
    qryCli.SQL.Add('  FOR_CODCID, FOR_FONE01, FOR_EMAIL_, FOR_EMAIL2, ');
    qryCli.SQL.Add('  FOR_CODATI, FOR_C_G_C_, ');
    qryCli.SQL.Add('  FOR_OBSERV ');
    qryCli.SQL.Add('FROM ');
    qryCli.SQL.Add('  CADFOR ');
    qryCli.SQL.Add('WHERE ');
    qryCli.SQL.Add('  FOR_C_G_C_ = :CODVEL ');

    qryCli.ParamByName('CODVEL').AsString := strCodigo;
    qryCli.Open;

    If Not qryCli.IsEmpty Then
    Begin
      fatVenda.strCodFor := qryCli.FieldByName('FOR_CODFOR').AsString;
      fatVenda.strCliOri := qryCli.FieldByName('FOR_NOMFOR').AsString;
      fatVenda.strCliNom := qryCli.FieldByName('FOR_NOMFOR').AsString;
      fatVenda.strCliEnd := qryCli.FieldByName('FOR_ENDERE').AsString + ', ' +
                            qryCli.FieldByName('FOR_ENDNUM').AsString;
      fatVenda.strCliNum := qryCli.FieldByName('FOR_ENDNUM').AsString;
      fatVenda.strCliCom := qryCli.FieldByName('FOR_ENDCOM').AsString;
      fatVenda.strCliBai := qryCli.FieldByName('FOR_BAIRRO').AsString;
      fatVenda.strCliCep := qryCli.FieldByName('FOR_C_E_P_').AsString;
      fatVenda.strCodCid := qryCli.FieldByName('FOR_CODCID').AsString;
      fatVenda.strCliCid := fRetNomCidade(qryCli.FieldByName('FOR_CODCID').AsString);
      fatVenda.strCliEst := fRetNomCidade(qryCli.FieldByName('FOR_CODCID').AsString, 1);
      fatVenda.strCliTel := qryCli.FieldByName('FOR_FONE01').AsString;
      fatVenda.strCli_Rg := '';
      fatVenda.strCliCgc := qryCli.FieldByName('FOR_C_G_C_').AsString;
      fatVenda.strObserv := qryCli.FieldByName('FOR_OBSERV').AsString;
      fatVenda.strCliAti := '';
      fatVenda.strCliEma := qryCli.FieldByName('FOR_EMAIL_').AsString;
      fatVenda.strCliEm2 := '';
    End
    Else
    Begin
      qryCli.SQL.Clear;
      qryCli.SQL.Add('SELECT ');
      qryCli.SQL.Add('  CON_CODCON, CON_NOMCON, "" AS CON_ENDNUM, CON_ENDERE, ');
      qryCli.SQL.Add('  CON_ENDERE, CON_BAIRRO, CON_C_E_P_, ');
      qryCli.SQL.Add('  CON_CODCID, CON_FONE01, "" AS CON_EMAIL_, "" AS CON_EMAIL2, ');
      qryCli.SQL.Add('  CON_C_P_F_ ');
      qryCli.SQL.Add('FROM ');
      qryCli.SQL.Add('  CLICON ');
      qryCli.SQL.Add('WHERE ');
      qryCli.SQL.Add('  CON_C_P_F_ = :CODVEL ');

      qryCli.ParamByName('CODVEL').AsString := strCodigo;
      qryCli.Open;

      If qryCli.IsEmpty Then
      Begin
        Raise VerificacaoException.Create('Cliente / Fornecedor / Consumidor' + strCodigo + ' não cadastrado. ' +
          'Favor cadastrar antes de continuar.');
      End
      Else
      Begin
        fatVenda.strCodCli := fRetornaCodigoConsumidor;
        fatVenda.strCliOri := qryCli.FieldByName('CON_NOMCON').AsString;
        fatVenda.strCliNom := qryCli.FieldByName('CON_NOMCON').AsString;
        fatVenda.strCliEnd := qryCli.FieldByName('CON_ENDERE').AsString;
        fatVenda.strCliNum := '';
        fatVenda.strCliCom := qryCli.FieldByName('CON_ENDERE').AsString;
        fatVenda.strCliBai := qryCli.FieldByName('CON_BAIRRO').AsString;
        fatVenda.strCliCep := qryCli.FieldByName('CON_C_E_P_').AsString;
        fatVenda.strCodCid := qryCli.FieldByName('CON_CODCID').AsString;
        fatVenda.strCliCid := fRetNomCidade(qryCli.FieldByName('CON_CODCID').AsString);
        fatVenda.strCliEst := fRetNomCidade(qryCli.FieldByName('CON_CODCID').AsString, 1);
        fatVenda.strCliTel := qryCli.FieldByName('CON_FONE01').AsString;
        fatVenda.strCli_Rg := '';
        fatVenda.strCliCgc := qryCli.FieldByName('CON_C_P_F_').AsString;
        fatVenda.strObserv := '';
        fatVenda.strCliAti := '';
        fatVenda.strCliEma := '';
        fatVenda.strCliEm2 := '';
      End;
    End;
  End;

  FreeAndNil(qryCli);
end;

procedure TfrmImportaNfeParaSped.pCarregaDadosItem(qryItens: TUniQuery;
  strCodIte, strCamCodIte: String);
  Var
    strTab: String;

begin
  strTab := IfThen(fCfgSIs('TIPABF') = '1', 'C', 'I');

  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  C.ITE_CODITE, ');
  qryItens.SQL.Add('  C.ITE_CODGRU, ');
  qryItens.SQL.Add('  C.ITE_DESITE, ');
  qryItens.SQL.Add('  C.ITE_CODUNI, ');
  qryItens.SQL.Add('  C.ITE_CODMAR, ');
  qryItens.SQL.Add('  C.ITE_CODFOR, ');
  qryItens.SQL.Add('  C.ITE_INCPIS, ');
  qryItens.SQL.Add('  C.ITE_CLAIPI, ');
  qryItens.SQL.Add('  C.ITE_EXCIPI, ');
  qryItens.SQL.Add(strTab+'.ITE_CODABF ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE C ');
  qryItens.SQL.Add('  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ');
  qryItens.SQL.Add('                     AND I.ITE_CODEMP = :CODEMP      ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  C.ITE_' + strCamCodIte + ' = :CODITE ');

  qryItens.ParamByName('CODITE').AsString := IfThen(strCamCodIte = 'CODITE', fStrZero(strCodIte, fTamCodIte), strCodIte);
  qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryItens.Open;

  If qryItens.IsEmpty Then
  Begin
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT ');
    qryItens.SQL.Add('  C.ITE_CODITE, ');
    qryItens.SQL.Add('  C.ITE_CODGRU, ');
    qryItens.SQL.Add('  C.ITE_DESITE, ');
    qryItens.SQL.Add('  C.ITE_CODUNI, ');
    qryItens.SQL.Add('  C.ITE_CODMAR, ');
    qryItens.SQL.Add('  C.ITE_CODFOR, ');
    qryItens.SQL.Add('  C.ITE_INCPIS, ');
    qryItens.SQL.Add('  C.ITE_CLAIPI, ');
    qryItens.SQL.Add('  C.ITE_EXCIPI, ');
    qryItens.SQL.Add(strTab+'.ITE_CODABF ');
    qryItens.SQL.Add('FROM ');
    qryItens.SQL.Add('  CADITE C ');
    qryItens.SQL.Add('  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ');
    qryItens.SQL.Add('                     AND I.ITE_CODEMP = :CODEMP      ');
    qryItens.SQL.Add('WHERE ');
    qryItens.SQL.Add('  C.ITE_' + IfThen(strCamCodIte = 'CODITE', 'CODVEL', 'CODITE') + ' = :CODVEL ');

    qryItens.ParamByName('CODVEL').AsString := IfThen(strCamCodIte = 'CODITE', fStrZero(strCodIte, fTamCodIte), strCodIte);
    qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryItens.Open;
  End;
end;

procedure TfrmImportaNfeParaSped.pCarregarArquivos(strPath: String;
  stlArquivos: TStringList);
  Var
    searchRec: TSearchRec;
begin
  If FindFirst(strPath + '\*.xml', faAnyFile, searchRec) = 0 Then
  Begin
    Repeat
      stlArquivos.Add(strPath + '\' + searchRec.Name);
    Until FindNext(searchRec) <> 0;
  End;
end;

function fRegistro(strLinha: String): String;
begin
  Result := fGetValorLinhaSped(strLinha, 1);
end;

function fGetValorLinhaSped(strLinha: String; intColuna: Integer): String;
begin
  Result := fGetValorLinha(strLinha, '|', intColuna, True);
end;

function fCampoDataSped(
  const strLinha: String; const intColuna: Integer): TDateTime;
  Var
    strData: String;
    strDia: String;
    strMes: String;
    strAno: String;
begin
  strData := fGetValorLinhaSped(strLinha, intColuna);
  strDia := LeftStr(strData, 2);
  strMes := Copy(strData, 3, 2);
  strAno := RightStr(strData, 4);

  Result := EncodeDate(StrToInt(strAno), StrToInt(strMes), StrToInt(strDia));
end;

function fCampoValorSped(const strLinha: String;
  const intColuna: Integer): Double;
Begin
  Result := fStrToFloat(fGetValorLinhaSped(strLinha, intColuna));
End;

{ TNotaFiscal }

constructor TNotaFiscal.Create(nota: TNFeXml; strCnpjEmpresa: String);
begin

  If String(nota.recDadosNota.C02_CNPJ) <> strCnpjEmpresa Then
    Raise ExceptionAutCom.Create('Atenção: as notas processadas não pertencem à empresa logada. Verifique.');

  SetLength(arrItemNota, 0);

  strSituacao := '01';

  strEntSai := IIF(nota.getItemNota[0].I08_CFOP > '5000', 'S', 'E');

  blnEmiPropria := True;
  strCodCli := String(nota.recDadosNota.E02_CNPJ);
  strModelo := IIF(String(nota.recDadosNota.B06_MOD) = '65', '65', '55');
  strSerie := String(nota.recDadosNota.B07_SERIE);
  strNumDoc := RightStr(String(nota.recDadosNota.B08_NNF), nota.fTamNumDocGerEle);
  strChaveNfe := nota.recDadosNota.PR07_CHNFE;
  dtaDtaDoc := nota.recDadosNota.B09_DEMI;
  dtaDtaEnt := nota.recDadosNota.B09_DEMI;
  fltValorTotal := nota.recDadosNota.W16_VNF;
  strIndPagto := String(nota.recDadosNota.B05_INDPAG);
  fltDesconto := nota.recDadosNota.W10_VDESC;
  fltAbatNaoTrib := 0;
  fltTotalNota := nota.recDadosNota.W16_VNF;
  strTipoFrete := nota.recDadosNota.X33_MODFRETE;
  fltValorFrete := nota.recDadosNota.W08_VFRETE;
  fltValorSeguro := nota.recDadosNota.W09_VSEG;
  fltDespAcessorias := nota.recDadosNota.W15_VOUTRO;
  fltBaseIcms := nota.recDadosNota.W03_VBC;
  fltValorIcms := nota.recDadosNota.W04_VICMS;
  fltBaseST := nota.recDadosNota.W05_VBCST;
  fltValorST := nota.recDadosNota.W06_VST;
  fltValorIPI := nota.recDadosNota.W12_VIPI;
  fltValorPIS := nota.recDadosNota.W13_VPIS;
  fltValorCofins := nota.recDadosNota.W14_VCOFINS;
  fltValorPISST := 0;
  fltValorCOFINSST := 0;
end;

function TNotaFiscal.DeSaida: Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    If arrItemNota[intContador].strCfop > '5000' Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

destructor TNotaFiscal.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    FreeAndNil(arrItemNota[intContador]);
  End;
  SetLength(arrItemNota,0);
  inherited;
end;

procedure TNotaFiscal.pAdicionaItem(nota: TNFeXml);
  Var
    intContador: Integer;
begin
  SetLength(arrItemNota, nota.getQuantidadeItens);

  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    arrItemNota[intContador] := TItemNota.Create(nota, intContador);
  End;
end;

{ TItemNota }

constructor TItemNota.Create(nota: TNFeXml; intIndice: Integer);
  Var
    item: TRecDetEle;
begin
  item := nota.getItemNota[intIndice];

  intNumIte := intIndice+1;
  strCodIte := String(item.I02_CPROD);
  strDescri := String(item.I04_XPROD);
  strUnidad := String(item.I09_UCOM);
  fltVlrCon := item.I11_VPROD;
  fltDescon := item.I17_VDESC;
  fltFrete := item.I15_VFRETE;
  fltDesAce := item.I17A_VOUTRO + item.I16_VSEG;
  blnMovEstoque := True;
  strCstIcms := String(item.N11_ORIG + item.N12_CST);
  strCfop := String(item.I08_CFOP);
  strCodNat := String(item.I08_CFOP);
  fltBaseIcms := item.N15_VBC;
  fltAlqIcms := item.N16_PICMS;
  fltValIcms := item.N17_VICMS;
  fltBaseST := item.N21_VBCST;
  fltAlqST := item.N22_PICMSST;
  fltValorST := item.N23_VICMSST;
  fltValorFcpSt := item.N23D_FCPST;
  fltBaseFcpSt := item.N23A_VBCFCPST;
  strPerApuIpi := '0';
  strCstIpi := '';
  strCodEnqIpi := String(item.I06_EXTIPI);

  If item.I10_QCOM > 0 Then
    fltQtdIte := item.I10_QCOM
  Else
    fltQtdIte := 1;

  If item.O14_VIPI > 0 Then
    fltBaseIPI := item.O10_VBC;

  fltAlqIPI := item.O13_PIPI;
  fltValorIPI := item.O14_VIPI;

  strCstPis := String(item.Q06_CST);
  fltBasePis := item.Q07_VBC;
  fltAlqPis := item.Q08_PPIS;
  fltValorPis := item.Q09_VPIS;

  strCstCofins := String(item.S06_CST);
  fltBaseCofins := item.S07_VBC;
  fltAlqCofins := item.S08_PCOFINS;
  fltValorCofins := item.S11_VCOFINS;
end;

{ TEmpresa }

constructor TEmpresa.Create(strCnpj: String);
begin
  Self.strCnpj := strCnpj;
  strCodEmp := fRetCodEmpresa(strCnpj);

  SetLength(arrNotas, 0);
end;

function TEmpresa.fRetCodEmpresa(strCnpj: String): String;
begin
  Result := fRetEmpresaPeloCGC(strCnpj);

  If (fEmptyStr(Result)) Then
    Raise Exception.Create('CNPJ ' + strCnpj + ' não encontrado no cadastro de empresas.');
end;

destructor TEmpresa.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrNotas) To High(arrNotas) Do
  Begin
    FreeAndNil(arrNotas[intContador]);
  End;
  SetLength(arrNotas, 0);

  inherited;
end;

function TEmpresa.fAdicionaNota(nota: TNFeXml; strCnpjEmpresa: String): TNotaFiscal;
  Var
    intTamMat: Integer;
begin
  Result := TNotaFiscal.Create(nota, strCnpjEmpresa);

  intTamMat := Length(arrNotas);
  SetLength(arrNotas, intTamMat+1);
  arrNotas[intTamMat] := Result;
end;

function TfrmImportaNfeParaSped.fRetornaCodigoConsumidor: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Add('SELECT CLI_CODCLI FROM CADCLI WHERE CLI_NOMCLI LIKE "%CONSUMIDOR%" LIMIT 1');
    qryAux.Open;
    Result := qryAux.FieldByName('CLI_CODCLI').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmImportaNfeParaSped.OnImportErro(strNumDoc, strSerie, strNomArq,
  strMensagem: String);
begin
  stlErro.Add(strMensagem);
end;

end.
